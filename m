Return-Path: <linux-nfs+bounces-22001-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LNPDPerFmpHoQcAu9opvQ
	(envelope-from <linux-nfs+bounces-22001-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 10:31:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A75E1250
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BFF13001D6B
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F95A3BB114;
	Wed, 27 May 2026 08:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h7xkTGmt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012054.outbound.protection.outlook.com [40.93.195.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30283033DF;
	Wed, 27 May 2026 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779870709; cv=fail; b=ox28H8KO7kSeVOSvamsncxQwSUlTndASYYuBcoRbwgsUs/oCg43A6snPcBeB6SiMIjRibjQaz+z0sbcsYiVeSvbPGFqZJZuhmd5wvIhGPMND+7k4KYgBI7RNkmh7hyAadQyaY8OYgzjjIq9fWeTGV3KzXDSy5Hlb/1lB6qjwcbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779870709; c=relaxed/simple;
	bh=SeafqJVnY0vr4RBNQk4LatWCj1RNm2zeudCe6o37no8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VuhraqJf1+oCItrLovhh1O0u/L8eyGwE/Kh2DnXWOfRpePnZ++S9bKuV9nKNxmF5EJJE/t5jKM5tAb0wtHFcISYDCdMNEn6hq+5gTalgeiqHAEYrpRj5zM6Vm6OsbNFCcEA6UVsuO8ZJ4q2HPOxD97GLV4FLOOnp5pru4k9IoMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h7xkTGmt; arc=fail smtp.client-ip=40.93.195.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ous+WSWmAkV5xytH9+wT+BYjPJxQwBnhU04DiFkRPwBWO4ufoQpHTcNLNfBtPImom2vzzYutyMqWka+xGY9AWMxP9HaDTyOoPKWM9TZQOcaAIy+cbfOk/76glG9/JuFstcDX2/gH3tAB4ivQSOtBU02W8zOx1/Xh6xx+cHNYUuSx3+XP6/kX6LGSlOsvAi+pip6xxfzPTogMmkN3Zaf0OhorUs37ZYdLvVHD4iugzMcrz/SrxvsedkA2k27N6agGqklV2/Olp/ftqDkEqcSzjus9XqEVHEQdo2/XL+i1n1U5QWUKT1d1gt4x77501vwFLqBfOVua70mWsfwc6215tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn8nzoVHjhfTS2Vz8ce+bYlyNBT1UndVdj/XnPb8mXU=;
 b=C1htQl+EikJ5MhFMiIt5wJfOvmuCoKUMJ3VgWDo/CRoFodipMEFnPFkbO1W9qJle5d+PUhMNLqP74tkj1YmMb+JfX+kgPe8z3v6j+T8MDoAemSfbkUksLpqTP28V5A6hma0BEP2tCc/rdyF1qyTGG65kLniVqsr9WtrHIyWFt7XUoTuDY/kVyyIhBaoHFEDHIPvE2zws6UkLkS0/LI8d3Ue/rJOEBB+5o+k1x/ODX/XZenTV9lFYvZT0lQh8kDExULRuFSLfi/b7f1kkAzj/8g4bEV10G37EZyrnIgjxLjxpl8reMpK7Pd9PqR/Vh0V4h4o9e/fTZ0nyOrPEF/4WjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn8nzoVHjhfTS2Vz8ce+bYlyNBT1UndVdj/XnPb8mXU=;
 b=h7xkTGmtMf+OSH3a48y1jmoR2vr/I5rWLTyidRzNAsFnTmZY58MJs5fTDFeLdUR27NC5lNMTCCL9r9nsUg0tz3K7jqhEl/KY0/8WqiabQ7htAcb/JyScdjtCbRhddbtnYyWwwwkWCixmofHwLMAOhzMXJXX661A+CcZwe+WegnpqVm9Tqc5VOEW6oLr8FdhxMg4r4jqY7uRkIO2bzqrZytC1jtEj9d5r+4B5aYB4WBOE27HRxtRkV5+60otxrS01AVVV8x9QVXWxb/P9Z+5zIgOX7G89Skz/7jHuQD135vSaeTB/0bOtaBE7vqJHWGlkjscdOgbCxdVipYvMLg5JDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LVUPR12MB999138.namprd12.prod.outlook.com (2603:10b6:408:39e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 27 May
 2026 08:31:40 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 08:31:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Chuck Lever <chuck.lever@oracle.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-nfs@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: revisiting alloc_pages_bulks semantics?
Date: Wed, 27 May 2026 16:31:24 +0800
X-Mailer: MailMate (2.0r6292)
Message-ID: <2759BB06-005F-41EF-815F-C9F96E822DE1@nvidia.com>
In-Reply-To: <20260527080056.GA20040@lst.de>
References: <20260527071816.GA17632@lst.de>
 <A68C1B33-053C-4406-B78E-871ECD7293B3@nvidia.com>
 <20260527080056.GA20040@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LVUPR12MB999138:EE_
X-MS-Office365-Filtering-Correlation-Id: 7267c629-e5da-4831-0be4-08debbca5fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|6133799003|11063799006|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	S50Cx02N8JVzVun/tHf+67A+frQSh+9KGkrsXRhBxN7bQsViDstMlt6X0PU6V5gOXQknH+BKxZNbtzMYtiT2c5tLmv8ZBwrduBbgsJr4RDcEkb/h+lVuflQBqERJx3Z+FfksaxtgliSqISmsbSwPX6++TB7JOm5yer307IUstwZzLq2kY0pAB3jG7lg6vTsyCJe9uiX23RLZ67c8lvm14H321QboZMmg2ufXqml2K76HCWGMR6BmibzrXT1ZLDsieiX7ShC4eGTisDx+BXKONMucyCPZnYp+5Oz+Zrd2as5Y1dZfx4gwt/eo37Tfx/dlSUGoOsiVFhu41Ttpxd/QuL3a2roG3yi/fy2WY3m/jN1mvcAlUcmVFeroDYHHVDX4a8SKub9RKdJuXgpaTQaaYV73UztiSP0TIwb8256g0lGmdhDJr+yxea1iSHcR9Sf+Z3UhehNzyzCN5FFxUrHIz4qFi6wN0QLFZMRkcq2qXcABmQPhXS9kTwHJd1jYA4G7gvEAUWwPFJVFTf+yXuUi4XbxJ7or1VqgaEdli2cM56ui535HowoUP3+bbA2up3zMupnWSOSpx9+kUusfhcEBQE8ubUPcKhq89Ttur79FpzlKy46KW5WupTr4KniN/w/c/fTuQbDKMJGp9SdATpVBk+hsiZ9wRqCDVEBpy/f/4hbhKOhBM7g493lm2ximzZK9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(6133799003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzRGN1VvTVFUK3l4dVEzRmtkZlYva09mZTZtZHE5MTM2Q0F5ZG5jaEJGK2dk?=
 =?utf-8?B?bWVwaWEzNFhldkZOQjlEN20wUEVpazg4Z2ZQTk5JajBhL01TWjB5WFZqY2JN?=
 =?utf-8?B?bUJUaE9aNUFIWDcxKzFmT2twZXFOaTJVck93Wk5hSnQvd1RDdWZLUm9BbjBy?=
 =?utf-8?B?NnNZSDJ3L0cxSlZ3L1JxSUt0UVViOHhybHJ3dUk5d3NEMzMvVzhIT1EybjJB?=
 =?utf-8?B?ZlpqelBreXVvQS9PdWpXY2tKSG1KaXFWNkJ0Z3ZOQjhIK3BZbW95Ykl1c1JH?=
 =?utf-8?B?NzVtVjhrZ1dRaHExYmxuWm8rcEJtZGJXdGx5TFg1QjFicHB1MWVuYjh6TTVP?=
 =?utf-8?B?c3lXb29tR29Bb0IwTGxibU1WanN2VlYzaE05UW5oQzJNeU8vUjRCVXFuQWEr?=
 =?utf-8?B?MGEzSjBvU3UxS0pVc0M3ZllUOVc3c3JoYU9QWnFiMGdDRlFhM0lrTjh0R0dr?=
 =?utf-8?B?enJTRWY2ajRicUhURkVnNkJoS0dYRE9pMnJKMUpQN0xYY1M0cElNQmI5Skpi?=
 =?utf-8?B?T2cycGxMZEcwYjVmVCtMRXRxbjVIQ1FYL3VpR0t5NVZFSUxKVjZ4dkRhQ1Bk?=
 =?utf-8?B?MFplL2JSZDArZlRISFo1eXE0UkNvVUNnMHFQVW1BaTQwT3lRV0dHNHFkK0Vk?=
 =?utf-8?B?dlJVTENSSy93bXk3d3VXbW9GL0Z3NkdINVJNTWRkN3kzZDdjbVdHQ2o4THhi?=
 =?utf-8?B?REJtK1JmVzJ6SXVoWllaMWowL1hCMlVtMnlCTlduWTlSRTlXcFEybGJ5SjRo?=
 =?utf-8?B?U2t5aXRNUDV4MVdiODlJdnlnTys4QkpFYVVwa3YydUMvSzVHOXlFQzRWWW9i?=
 =?utf-8?B?RzJZcllCTmRFSGJha0YweExDbzI4b3JsSm4weUN6KzIyalgxb2htNHVLdTZS?=
 =?utf-8?B?L3NFcDhJaWh4TTd6RlhlTGw2anFNMzRSbHdxdnIweEZkWkx5L0prUHpwbndL?=
 =?utf-8?B?dXJWK1BvQWpTTG8zOCtWaHZpMkhabS8zVlRDbnJuZkdsUzgzTU5Hei9pQk1F?=
 =?utf-8?B?NlFsNG90UzRNUDlmNWhVc2RQTzF4MTViaUVLZHFzT3Q0bzIyK01jSk1ONkRO?=
 =?utf-8?B?L2cwNmN4cWRTV2FPQVVHL0Zla2UvZzlIa2RHY0VaU1dRUFlTYUlyQndKWGt6?=
 =?utf-8?B?c0F1dFhjS2VEdDlCZ1Y0NTJRN3BRejFoZGd5Sm5ER0h2bDJHMmlJY2tpREJ2?=
 =?utf-8?B?TEwvcmxpSVo0TC9Ha3pYM1RTQ2F1TWxYTGE2Q2xOY0M0ZWJKRTJyc3VrY2RW?=
 =?utf-8?B?WHRGcUlNamQ4T3Ura3hia3BNT3dSUU1xOWR6R2ZBL25hTENDSjF3cFVscFU1?=
 =?utf-8?B?Z1l5TzVCbk9zNUJ2d2VCSXVSM1kwbEoxMUMxL3RVOHZRMEdXRXc2bzVXS2Rh?=
 =?utf-8?B?c3d6c3FOSWFyemljSFRjbnBHc010SWJNazdKTWR1TnRKb0dMbDRncmFuRkwy?=
 =?utf-8?B?aytrWkVKblZ4Y1dJQVUwODVtblZzeXhGMUsxT2c3a0tuSElCTzJtTmJmbk9S?=
 =?utf-8?B?ZDU5YlRxd0d5Uk5HeUZiRzMxRlRsVjc5d2RvZnZlNzNnUDhUNExMb1pZdGRo?=
 =?utf-8?B?dG82SlVZdkdrb0wvZWNwT01XZC9xTFZTY3dRdjQwVFpEa0h5WHgvNno2L1FZ?=
 =?utf-8?B?WWVkaHltS2FiNTh6ekVzeWVFRlN3RG1iSmIyYitWUkdtaWd3K1VrenBlK1Fm?=
 =?utf-8?B?TGxpSndLTU45L2kvNE5KNzdONm9TMWk5V1h2YlJkdHJUd09TVS83M01pOGFh?=
 =?utf-8?B?WFFnYTUvQ21kNkptL0hEOVZRbGc4bkhwTE9sM1VGeG5BVE12b3lJcTJqSjdr?=
 =?utf-8?B?Q0JRYmR5d1FtTlgxYTNKQTI0L1FnWmpRS1ZieW9QLzVUeGpBQ1ZXMGZQTzFT?=
 =?utf-8?B?U1czNmdqNjFNdm5JRUR2R1RucVc1eWtMaStmWWYvSXJITSs4a3FUUWMxcVFG?=
 =?utf-8?B?eDkxSEZlQ3NzeFo2K3dtZkE5V1JUYTZHRGhoenFLTXJVdmFWYnJqZlhBUUlB?=
 =?utf-8?B?aFdSYUJodTIyb21nbXROWFhOLzV1cTR6bmJtcnJJVUhYdUlKRGJUZFpVUHB6?=
 =?utf-8?B?YUlBcGF1RG5pMnFLSDFBVzFQZi93YjV3dmc3UWRGMEc5MWRRbzkvWFdDUU9k?=
 =?utf-8?B?OWV1WkVScG4xa2w4bGJJbTk1MWJaUHdNWnRWWGZxRTFGK1FuTFdtN2s0Q1Zp?=
 =?utf-8?B?andiUU9WOFVaRmxjMTFEUzRubGFBT1ZwYTBLMWxVNHhkelpFRmtjTGQxVHRz?=
 =?utf-8?B?OGhETHVKZ3hHWlZGWFF3RDJ2YXdzeXp6KzlpZFE0RWpIY01wV0Q4SFI4S29k?=
 =?utf-8?B?SEx5TlJHSkd5NC9xS3dvK0l3Q3p0ZzJlajFROTVUd3BlYmhkdFZiSzhYQXVW?=
 =?utf-8?Q?7huuNU16VD63cvnKvTyywhEHCic8VA5/PbpAC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7267c629-e5da-4831-0be4-08debbca5fe5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:31:40.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rXHV6xeaBie5OA8x/qHqFVAgSEmRE3PXcDc933exijC7WzFYRgIAeSJYuGAmt94
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999138
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22001-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid]
X-Rspamd-Queue-Id: D07A75E1250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27 May 2026, at 16:00, Christoph Hellwig wrote:

> On Wed, May 27, 2026 at 03:53:53PM +0800, Zi Yan wrote:
>>> 1) early fail semantics
>>>
>>> alloc_pages_bulks can do partial allocations for some reasons, and
>>> users usually have a fallback by either looping and calling it again
>>> or falling back to single page allocations.  This sucks!  Why can't
>>> we get our usual try as hard as you can semantics, requiring
>>> GFP_NORETRY or similar to relax it?
>>
>> IIUC, current alloc_pages_bulks() tries to get free pages without doing
>> compaction or reclaim unless none can be allocated.
>
> Yes, which is really odd, as other page/folio allocators make that an
> opt-in through GFP flags.

Based on my understanding of the code, the GFP flags are respected at
the __alloc_pages_noprof() in alloc_pages_bulk(). The loop of
rmqueue_pcplist() is just a quick try of getting free pages.
And I suspect it might be quicker than calling __alloc_pages_noprof()
in a loop, since other preparation work in __alloc_pages_noprof()
is only done once.

>
>> Does your “usual try”
>> mean possible invocation of compaction and/or reclaim for every page
>> allocation?
>
> If you look at most callers in tree, and my recently merged or to be
> merged work isn't any different, they just bloody want the pages just
> as any other allocator.  Failing under grave memory pressure is fine
> of course, but just failing because getting the memory requires effort
> is not.
>
>> I guess it also relates to the order > 0 bulk allocation
>> below? My gut feeling is that if one “usual try” fails, the following
>> “usual try” might not work. So making alloc_pages_bulks() do heavy
>> allocation might not buy you much.
>
> Well, we need to centralize this.  Right now there is lots of divering
> cargo culting in the callers.
>
>> But can you elaborate on why looping alloc_pages_bulks() does not work
>> well? That is essentially triggering compaction/reclaim repeatedly
>> like your proposed “usual try” idea.
>
> I'm not even sure if it works well.  There are some callers that do that,
> some use individual fallbacks.  I don't really want to think about that
> when all I need is a few folios.
>
>>> The bulk allocator is limited to order 0 which limits it's usefulness
>>> these days.  It would be really helpful to do bulk allocations for
>>> the pagecache or bounce buffering.
>>
>> Sounds reasonable to me, but when under memory pressure, I wonder
>> how many > order 0 folios you can get in the end. And that might
>> cause a storm of compaction and/or reclaim if combined with Idea 1.
>
> Well, I really want them.  In some cases I might be fine falling down
> to smaller sizes, but I also really don't want the logic in every
> caller.

Based on your answers above, it sounds like a wrapper of
__alloc_pages_bulk() that doing allocation in a loop until all requested
pages are filled might be good enough for your case.

But let me know if I miss something.

>
>> For > order 0 bulk allocations, are you thinking about 1)
>> a try and bail-out early model or 2) a keep-trying model?
>
> Both are useful and as with other allocators should depend on the
> passed in GFP flags.

Like I said above, __alloc_pages_noprof() in alloc_pages_bulk()
respects the GFP flags.

>
>> For the latter, I wonder how large the allocation latency can be
>> and if that is tolerable or even makes sense, since for THP
>> allocations, we have seen >30s allocation latency when under
>> memory pressure. Is waiting minutes for bulk > order 0 allocation
>> making sense in your use cases?
>
> The allocations I have in mind would only require try hard allocations
> for typical file system blocks sizes (64k at most), while eveything
> larger is fair game for falling back.

Sure. In MM, PAGE_ALLOC_COSTLY_ORDER is 3, so pages bigger than that
would take more effort to get and the allocation latency can be longer.
So it might take a long time to allocate the last 64KB page in
a bulk allocation.

I do not have any data for such scenarios, but some trick I can think
of is to ask compaction and reclaim to aim for more free pages instead
of just the requested order (not higher order), so that after one round
of compaction and/or reclaim, more pages at the requested order can
be allocated afterwards.


Best Regards,
Yan, Zi

