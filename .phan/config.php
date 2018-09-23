<?php

return [
    'directory_list' => [
		'src',
		'vendor',
    ],
    'exclude_analysis_directory_list' => [
		'vendor',
    ],
    'allow_missing_properties' => true,
    'null_casts_as_any_type' => true,
    'backward_compatibility_checks' => false, // 後方互換性はチェックしない
    'quick_mode' => true, // 対象の関数の中の関数を再帰的に検査しない
	'minimum_severity' => Phan\Issue::SEVERITY_NORMAL,
    'parent_constructor_required' => [
    ],
    'suppress_issue_types' => [
        'PhanNonClassMethodCall',
    ],
];
