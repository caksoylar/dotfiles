#include QMK_KEYBOARD_H

enum layers {
    _BASE,
    _GAME,
    _EXTR,
    _TMUX,
    _FUNC
};

// layer-tap and mod-tap definitions
#define LT_SPC LT(_EXTR, KC_SPC)
#define LT_DEL LT(_FUNC, KC_DEL)
#define TM_GRV LT(_TMUX, KC_GRV)
#define LC_MIN LCTL_T(KC_MINS)
#define RA_EQL RALT_T(KC_EQL)
#define LS_LBR LSFT_T(KC_LBRC)
#define RS_ENT RSFT_T(KC_ENT)

// shortcut definitions
#define CT_DEL LCTL(KC_DEL)
#define CT_INS LCTL(KC_INS)
#define ST_INS LSFT(KC_INS)
#define CT_F4 LCTL(KC_F4)
#define ALT_F4 LALT(KC_F4)
#define CG_LT LCTL(LGUI(KC_LEFT))
#define CG_RT LCTL(LGUI(KC_RGHT))

// prefix for tmux layer
#define TMUX_P LCTL(KC_SPC)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [_BASE] = LAYOUT(
    //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
       TM_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                               KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                               KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSLS,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       KC_ESC,  KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                               KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
    //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
       LS_LBR,  KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_MPLY,          XXXXXXX, KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RBRC,
    //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                      KC_LGUI, LC_MIN,  RA_EQL,                    LT_SPC,  RS_ENT,  LT_DEL
                                  // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
    ),

    [_GAME] = LAYOUT(
    //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
       KC_GRV,  KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                               KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    KC_BSPC,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       KC_TAB,  KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                               KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_BSLS,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       KC_ESC,  KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                               KC_H,    KC_J,    KC_K,    KC_L,    KC_SCLN, KC_QUOT,
    //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
       KC_LSFT, KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,    KC_MPLY,          XXXXXXX, KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, KC_RBRC,
    //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                      KC_LCTL, KC_LSFT, KC_SPC,                    LT_SPC,  KC_ENT,  MO(_FUNC)
                                  // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
    ),

    [_EXTR] = LAYOUT(
    //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
       KC_F12,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                              KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  KC_F11,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       _______, ALT_F4,  CT_F4,   _______, _______, KC_LBRC,                            KC_RBRC, _______, _______, KC_MINS, KC_EQL,  _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       _______, CG_LT,   _______, CG_RT,   _______, _______,                            KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, KC_INS,  KC_PGUP,
    //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
       _______, _______, CT_DEL,  CT_INS,  ST_INS,  KC_LCBR, _______,          _______, KC_RCBR, KC_APP,  KC_HOME, KC_END,  KC_DEL,  KC_PGDN,
    //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                      _______, _______, _______,                   _______, _______, _______
                                  // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
    ),

    [_TMUX] = LAYOUT(
    //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
       _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       _______, _______, _______, _______, _______, _______,                            _______, _______, _______, _______, _______, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
       _______, _______, _______, _______, _______, _______, _______,          _______, _______, _______, _______, _______, _______, _______,
    //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                      _______, _______, _______,                   _______, _______, _______
                                  // └────────┴────────┴────────┘                 └────────┴────────┴────────┘
    ),

    [_FUNC] = LAYOUT(
    //┌────────┬────────┬────────┬────────┬────────┬────────┐                          ┌────────┬────────┬────────┬────────┬────────┬────────┐
       _______, DF(_BASE),DF(_GAME),_______,_______,_______,                            _______, _______, _______, _______, _______, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       RGB_TOG, _______, _______, _______, RESET,   _______,                            _______, _______, _______, _______, KC_PSCR, _______,
    //├────────┼────────┼────────┼────────┼────────┼────────┤                          ├────────┼────────┼────────┼────────┼────────┼────────┤
       RGB_MOD, _______, _______, _______, _______, _______,                            _______, _______, RGB_HUI, RGB_SAI, RGB_VAI, KC_CAPS,
    //├────────┼────────┼────────┼────────┼────────┼────────┼────────┐        ┌────────┼────────┼────────┼────────┼────────┼────────┼────────┤
       RGB_RMOD,KC_MPRV, KC_MNXT, KC_CALC, _______, _______, _______,          _______, _______, _______, RGB_HUD, RGB_SAD, RGB_VAD, _______,
    //└────────┴────────┴────────┴───┬────┴───┬────┴───┬────┴───┬────┘        └───┬────┴───┬────┴───┬────┴───┬────┴────────┴────────┴────────┘
                                      _______, _______, _______,                   _______, _______, _______
    //                               └────────┴────────┴────────┘                 └────────┴────────┴────────┘
    )
};

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    if (IS_LAYER_ON(_TMUX)) {
        if (record->event.pressed && keycode != TM_GRV) {
            uint8_t temp_mod = get_mods();
            clear_mods();
            tap_code16(TMUX_P);
            set_mods(temp_mod);
            wait_ms(10);
        }
    }
    return true;
}

#ifdef RGBLIGHT_ENABLE
void keyboard_post_init_user(void) {
    rgblight_sethsv_noeeprom(150, 255, 255);
}

layer_state_t layer_state_set_user(layer_state_t state) {
    uint8_t sat = rgblight_get_sat();
    uint8_t val = rgblight_get_val();
    switch (get_highest_layer(state)) {
        case _EXTR:
            rgblight_sethsv_noeeprom(188, sat, val);
            break;
        case _TMUX:
            rgblight_sethsv_noeeprom(67, sat, val);
            break;
        case _FUNC:
            rgblight_sethsv_noeeprom(242, sat, val);
            break;
        default:
            switch (get_highest_layer(default_layer_state)) {
                case _GAME:
                    rgblight_sethsv_noeeprom(110, sat, val);
                    break;
                default:
                    rgblight_sethsv_noeeprom(150, sat, val);
                    break;
            }
            break;
    }
    return state;
}
#endif  // RGBLIGHT_ENABLE

#ifdef ENCODER_ENABLE
void encoder_update_user(uint8_t index, bool clockwise) {
    if (index == 0) {
        switch (get_highest_layer(layer_state)) {
            case _EXTR:
                clockwise ? tap_code(KC_AUDIO_VOL_UP) : tap_code(KC_AUDIO_VOL_DOWN);
                break;
            case _TMUX:
                tap_code16(TMUX_P);
                wait_ms(10);
                clockwise ? tap_code(KC_N) : tap_code(KC_P);
                break;
            case _FUNC:
                clockwise ? tap_code(KC_MS_WH_RIGHT) : tap_code(KC_MS_WH_LEFT);
                break;
            default:
                clockwise ? tap_code(KC_MS_WH_DOWN) : tap_code(KC_MS_WH_UP);
                break;
        }
    }
}
#endif  // ENCODER_ENABLE
