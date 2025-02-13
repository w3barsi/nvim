local gemini_prompt = [[
You are the backend of an AI-powered code completion engine. Your task is to
provide code suggestions based on the user's input. The user's code will be
enclosed in markers:

- `<contextAfterCursor>`: Code context after the cursor
- `<cursorPosition>`: Current cursor location
- `<contextBeforeCursor>`: Code context before the cursor
]]

local gemini_few_shots = {}

gemini_few_shots[1] = {
    role = 'user',
    content = [[
# language: python
<contextBeforeCursor>
def fibonacci(n):
    <cursorPosition>
<contextAfterCursor>

fib(5)]],
}

local gemini_chat_input_template =
'{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}'

return {
    {
        'milanglacier/minuet-ai.nvim',
        event = { 'InsertEnter' },
        config = function()
            gemini_few_shots[2] = require('minuet.config').default_few_shots[2]

            require('minuet').setup {
                provider = 'gemini',
                request_timeout = 4,
                throttle = 2000,
                virtualtext = {
                    auto_trigger_ft = {},
                    keymap = {
                        accept = '<A-A>',
                        accept_line = '<A-a>',
                        accept_n_lines = '<A-z>',
                        prev = "<A-'>",
                        next = '<A-;>',
                        dismiss = '<A-e>',
                    },
                    show_on_completion_menu = true,
                },
                notify = 'error',
                provider_options = {
                    gemini = {
                        model = "gemini-2.0-flash",
                        stream = true,
                        system = {
                            prompt = gemini_prompt,
                        },
                        few_shots = gemini_few_shots,
                        chat_input = {
                            codestral = {
                                optional = {
                                    stop = { '\n\n' },
                                    max_tokens = 256,
                                },
                            },
                            template = gemini_chat_input_template,
                        },
                        optional = {
                            generationConfig = {
                                maxOutputTokens = 256,
                                topP = 0.9,
                            },
                            safetySettings = {
                                {
                                    category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
                                    threshold = 'BLOCK_NONE',
                                },
                                {
                                    category = 'HARM_CATEGORY_HATE_SPEECH',
                                    threshold = 'BLOCK_NONE',
                                },
                                {
                                    category = 'HARM_CATEGORY_HARASSMENT',
                                    threshold = 'BLOCK_NONE',
                                },
                                {
                                    category = 'HARM_CATEGORY_SEXUALLY_EXPLICIT',
                                    threshold = 'BLOCK_NONE',
                                },
                            },
                        },
                    },
                },
            }
        end,
    },
}
