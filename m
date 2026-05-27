Return-Path: <linux-nfs+bounces-21999-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAQ5IiqjFmqBnwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21999-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 09:54:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0614B5E0AAF
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 09:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03DC8301C6E9
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 07:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF993CD8BD;
	Wed, 27 May 2026 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZEn0bb39"
X-Original-To: linux-nfs@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6333C8700;
	Wed, 27 May 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779868448; cv=fail; b=VznOl68o0acg++Os9UKezybeEsPQH1uHRAIIowT6WC/Yk+7S0o/sxWM1OuyczDZNaJwL/MERLdkcFRbslxDGv+RpIJWcTy3LWZysoHJcWKNk2N6gdtJ+PjLRC04PEHkeTPW/7BPh11aGScYwWbrQTbzzDguXKUnOZ5oZBS2L+wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779868448; c=relaxed/simple;
	bh=fzJGkPhZP9FocuZLPhGEXutqEguKVljdd6TBkaYQ/CE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ucFSzDX9vpdqJsUr4Z4TdIBSFRfRqgtsJw6HlQFa52EM/e8jSkBXhMCboxGhiz0tXnHo+DdDIwvCwpNOi1uxItfdN1Qb2NDeqzTTbFq59mwWZuTCMGklZhFViJIhQ0oKhFHtggemokM9NVMOok+pZvhPE3xKIdA9LEmh9PAuMSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZEn0bb39; arc=fail smtp.client-ip=40.93.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lf7lKOMt/cnOE5xyH3F7ZBLMYU4kE+RezrDL+tT6r1MkiII7dP+gMslpvIT4Ive3YZTmd3yuxXBlBjPIIQgeybOwkDeN2MrVDsqYpk8jlMev67ZWkWGNgwYVDK5zQdPrCB90pWu80ioptRxvZQfrITzkAhOWTX5jYe2hVIcqz4WVDGfzr8scEKuQKEHIWLwEFlHm8SOjP2kdQrLag0FdIjjc09raqYHUlo+US6jyURhp63eLSJmE+ESrqGf7lzF6qhZ8hYkcHXUPfiIezwfW9oBu5QEsuAO6PuJywMNtW6u1pSNi+nwuIUriqcYFMFLeNpSQ9ltC7GfQduXotgkiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2vPYd1FwT9hBn+eYVP9WTgN6us8+EOM0NFb6LCTcvQ=;
 b=ae/KeBtfw1FYu0XO8teS8ieStvQsVggtB2Y2G6VfrJnnv9gWplnJ5SJ5VFvj+qLaKM4knI0R8w6PzWnTC7oA82Dsy9e8PXm0DlQ1+p/+bgmYmYnp3VJJ5pzD7DZWzFb6POj9aTUnJtdZB+N82W2V1oeEZDv+srqETS6mqS5WWlg7jxUAcSrl70eJK6e/aLQkAKOKJTld1fIfNRo8r7YvN2pCAXeKhBpg726gxqc5NTSGwbnlhS0vaRJ6v4BeuoePEarbbjIkp9dIBCFLisD23u9dQNyL7bGIOq2HFMVTzinELQP2Vy7HnoiWax/c7VBOV+MYNpFliE//KBuacXAUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2vPYd1FwT9hBn+eYVP9WTgN6us8+EOM0NFb6LCTcvQ=;
 b=ZEn0bb394YBLMJXdJw57FLhmXfvl2Y94eM5RhSE4raXWfIub9U06AeWkDuVdl7NXpTkIRyC52qxju1bxTwfawBycGcS7j230Vpj/DCEoKZRNC3H7AyQxJty6G6wQ3EuO1hTbx02Fch/UHFdAbuiBrk8ju6941g1uxX6xjT76oRZbGANVVT0Gdm3znCcqEH35n2/WPTDPnwr5B8ycoNfaFsRXPV+EWSUZVSySeo6dGhKPGKlOlpePJviip77rJqQdxTDfOv7hM/GLran+gnOlrcMPXlWdHCahoHB4o7rxfOou76w4SGKHk+kgHrnMw4d9rie7/PYRAeq6n1Zch1j29g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA1PR12MB6459.namprd12.prod.outlook.com (2603:10b6:208:3a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 07:54:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 07:54:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Chuck Lever <chuck.lever@oracle.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-nfs@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: revisiting alloc_pages_bulks semantics?
Date: Wed, 27 May 2026 15:53:53 +0800
X-Mailer: MailMate (2.0r6292)
Message-ID: <A68C1B33-053C-4406-B78E-871ECD7293B3@nvidia.com>
In-Reply-To: <20260527071816.GA17632@lst.de>
References: <20260527071816.GA17632@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0108.apcprd02.prod.outlook.com
 (2603:1096:4:92::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA1PR12MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f56031-b591-4c70-7a36-08debbc51e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	HqDYao+yR38lSlUKPbxpyrlQLrJ9C6WXiIjatSV939nuoVIr2EzSFYMzrIsyzGCreTQO12J9A0ku+ALaTLB9y0XmMm4KdLjohm/DbRda+JOzFzYWUi5GL/GmaRWE6ORu5+ultoRSLb1sHbm570lEXEDbrgujOCVlCJCivbUqbc3216VDaZAPBFe9vDNwCDMbDNtZsI9ed7eXHeOrj+IRTKm64sl3od/qE3kfLqccNXPfinzJ5tB1ilO7L8S+q3S4WfY1ML0UjsfmDZ9oXSFLsAT4/EVXHN4/aDTo3QqkglCUCHECfuFSfE67QjRxSVRCyKWDrtyqstNFx7GY4QtFiM9rZEZxZI6BQS1411UoSJ30iG8yUsTUmiQLJ7JtkeYDCHAdCDP3WPmC+Nt9qBTWauo+uLNuula4PDH+zaOIMcR/L4WddNnpkWvP9m+yKHsEiS+fjAnS/EAxQdDqxlXIzCywZarz5cRYwYjXHxUvPTrR/3cPmCy1sAYHqMKGrxON3QFfV0oa+UCnRs6At7un7kd2tkSjqqcqtpLXcnAONNV5DUo5nRSg0gLnarIteq6xHsKR71Rigfld2Zwcx+Qbl4QBIEaz3Zy+CJejBTR8OrDfz6/D9VYD0DRT7Wo8sK1hvL7OgO3lCr9H/+zkAapxLAgCb5GPfNadSHdQBSXz9BdwEbOmvkd+/QnJrZwSwk53
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkEvOUhvM0pwanE0OCtKT0V4NGc4cDBqVVVLUFZMSkhUWkU0WmlnWXg2ejRp?=
 =?utf-8?B?NWlRaDNCeTVlQjE0TmZ5UXZRM0dkS0JUTGhzWlhyUUxZdGtNTTJaeEJJUnFL?=
 =?utf-8?B?ZnMyQUh4SVArRFRZNjl1RkJLUXBIVFQ2VjJJRnNyK2ViUzJjNE1CMnVYZFBr?=
 =?utf-8?B?YVh4Z1JoV3IxSmJVemlqUGpGZksvcVBPaFBtRFEybHBqaFNBZnpMbFZEM1Zj?=
 =?utf-8?B?MVRFQmFxMkdZNUxJM2xNenA3clBZcGNDUE94cHIranZHelJEVUhzVGFMSTVU?=
 =?utf-8?B?Z0dOUGhGaGVSZXltaVJPbW1IaXFscUM0SitaR2I2MHF4V2xvYWNSTnFsZ2pu?=
 =?utf-8?B?dndoWEhNN2NhQW1oTk9PUUZhdU5QUVZxSERKUEZ5SFFRNFN4Q1JIcVpQNS84?=
 =?utf-8?B?dGp1dzBEaS9HVGgwdExNWkdSaW1TV1U1eDdlRWlnd2ZIZ0pkRjNsVCtqNUFO?=
 =?utf-8?B?Q05qM3pmKzVMRzhTWkpEUE1sRmIrbitFTkZFZzNxbmIyc1JtVmFBRjA2SnNH?=
 =?utf-8?B?Yzd6L3NuNEFzaVliV3RheEpJcE5QRkMwcXQ1dmlwV2kzcHhHNTFsMnJNVlkv?=
 =?utf-8?B?K0VRc3JDa29SSkE2cWJiK094ZE4wOXN5eGtVdytieWs2TlFrS0R5UFhvby81?=
 =?utf-8?B?OHlSMEttMmlCV05NcEJ0cXVvd1Q0ZmJ5cVFxam1BNjBJek9aZ2FSZSt4TDEy?=
 =?utf-8?B?MWEwQzBuMEJHTHJVK0d3Z2ZsQVlBWEdhMit6d05ISngrYWhjM3NVR1JxTVdE?=
 =?utf-8?B?aVBvM0Zzb2gyQmVxNnJpZEdhNUdKZm90aE1ZTWhEaC81L293alNLb3l4Rm5K?=
 =?utf-8?B?N0hJWXJjUGFsbHRKSmlTL2ZsMmRHWHlEeDJlT01jNXRGdisvZ1p2OHp1ZXdj?=
 =?utf-8?B?K21yQ0lsZWdoK2d4WGpmNEJ3UkhSVzFYZUtRV2hLNHI1N29iUnFTR2JxS1pq?=
 =?utf-8?B?RHFtcncvUFM2RUo1am0rdHFsdEtKUFVDWit1ejUzakhCbFFWNmlWdmxHQmJ5?=
 =?utf-8?B?REliTHZwRk5Oa2JWY01JMkZETUo2Uy9jcDR0WDM1c2pIYm9yaXdwNmYyNVRE?=
 =?utf-8?B?QlU5TGR4NUd6YXhGTXc5a0tRemttcE56ZjFvcVYzNmhjVFRxN3o0ZS9WaFZq?=
 =?utf-8?B?bk1qSjQzMWNvc0J0WTBnbGNNOWoyNDNjK0lLRGd6Z09Qay9aRHlUY0pXc1Vt?=
 =?utf-8?B?VVFReis2Y2dNbzkzOGpocjZvWEdrRnUxaURNWjV3TTRCZG5NUmtPb3czNlRH?=
 =?utf-8?B?LzN4VzNlY25NbU5DZXNTTkZab2RacW9UTmNrRHBsMjZmNUN4VThmditRaXE4?=
 =?utf-8?B?akhHU1dubDc3RklSODFSTTJsSFVPSUordjJsc0JOL2NoNEFoZERtZG85NkRu?=
 =?utf-8?B?S0NaS0oxdFI2eTlwUnpISzVtTVNJNUcwQVc1US93L0ZkTFYrVlZwbUM5eXBr?=
 =?utf-8?B?OEt5QklXeG9mYlhuRzdkMm91UDVUTkxRbXVqSzhTNFZsL3EwQkZacU9YWWs3?=
 =?utf-8?B?Y05YK2lWMGVlTFZmZU94c1VveFIvMjJkM2FubXdzbXF5UTZhNHZ3RHhXaFFj?=
 =?utf-8?B?QkhRUTRHK3RPMm1vdld3RFlWc01UWnhHdjFWK0M1Yk1EazdYcFFGNjJiZHpx?=
 =?utf-8?B?UldIMzVvd1VkUG1uMWRxalR2ajhmaEFkV2xndDhmamtEdlFRVWRibHNrTzc5?=
 =?utf-8?B?MlBGb2JIdU93R3pnL3NLaWFPN0dDRDkyZW4xaDFqZ25wUE9id3dFYXpnNm1L?=
 =?utf-8?B?ZUdkVEZlU0s3NFJhT2gwaUUybDNqelhMNTRKWGpmVkhPMnlPQ3NyVFdENzFC?=
 =?utf-8?B?cHVNdFpXWkxEZnZVc2RlSEs4UW5mQUlQMWM4cTBZOTBya3ZXdjc4dnpQSWUz?=
 =?utf-8?B?Q1k3bTluUVl4ejU4ZVRsa1lIQWxKV2dPWmhlS2pDazc2VjViK0l3akdzbnFU?=
 =?utf-8?B?T25Zd3pWZThlaW9rcWFHQlpZUUl5Z3hMN0s0aTcvZ253R2s5eXE4eXRnOTRv?=
 =?utf-8?B?bTBOd1c3cEdpOTQvajduZUhQeHFLcEw3ZWtVZFJ2RmhOaFhMamVaMEFVT0o3?=
 =?utf-8?B?TGtDN1l3bjZiZi9mb0E5UTNUL0Y2MENQQVFRRjNwb0N2WUJCNVRBb3Z4bFlJ?=
 =?utf-8?B?R1o3YXNtUHNCU3RDbW5acHB3MlVWNlhNQ0dURWZvKzhWWXJvaWNpM3BMa2kz?=
 =?utf-8?B?YlZaMUwzVk1rd01RQlZUeWhFQVZEUnlydDFqK1ZVdzJ0YkFZaXVVRVVXZEZX?=
 =?utf-8?B?WTlldUNVc1hjMUlHOWdFdkNRcEFpZUdYR2EvdkZtSnV4RDFYRGlCUDg2N2VK?=
 =?utf-8?B?V21HcmFsMDJGU3NVOXovQ0hDREFWbFFZdUs2Wk16SXNyRjl6dms2U3hBRWdG?=
 =?utf-8?Q?8iDBj3vJSuDAAKQCn+2CRgUZuw1ju4x8oLBqT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f56031-b591-4c70-7a36-08debbc51e75
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:54:02.8126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ws3/tDWlAutTMBP5zJ7kiLP/O2w3R0CefCzplwuiL35k42LVkL4wQdwtr6s5gmt8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6459
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21999-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Queue-Id: 0614B5E0AAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27 May 2026, at 15:18, Christoph Hellwig wrote:

> Hi all,
>
> I've been looking into using alloc_pages_bulks in a few places lately,
> and have run into issues with the API.  Here is my suggestions for how
> to make this more useful, although only some of them are something
> I'd feel comfortable to do myself:

I have some questions below to get more details on your needs.

>
> 1) early fail semantics
>
> alloc_pages_bulks can do partial allocations for some reasons, and
> users usually have a fallback by either looping and calling it again
> or falling back to single page allocations.  This sucks!  Why can't
> we get our usual try as hard as you can semantics, requiring
> GFP_NORETRY or similar to relax it?

IIUC, current alloc_pages_bulks() tries to get free pages without doing
compaction or reclaim unless none can be allocated. Does your “usual try”
mean possible invocation of compaction and/or reclaim for every page
allocation? I guess it also relates to the order > 0 bulk allocation
below? My gut feeling is that if one “usual try” fails, the following
“usual try” might not work. So making alloc_pages_bulks() do heavy
allocation might not buy you much.

But can you elaborate on why looping alloc_pages_bulks() does not work
well? That is essentially triggering compaction/reclaim repeatedly
like your proposed “usual try” idea.

>
> 2) pre-zeroed page array
>
> There is one single user (svc_fill_pages in sunrpc) that relies on it.
> For everyone else it creates extra burden and is very error prone
> (speaking from experience).

No comment for this one.

>
> 3) page instead of folio
>
> We're allocating folios, so we should have a folio API.

Sounds reasonable to me.

>
> 4) > order 0 support
>
> The bulk allocator is limited to order 0 which limits it's usefulness
> these days.  It would be really helpful to do bulk allocations for
> the pagecache or bounce buffering.

Sounds reasonable to me, but when under memory pressure, I wonder
how many > order 0 folios you can get in the end. And that might
cause a storm of compaction and/or reclaim if combined with Idea 1.
For > order 0 bulk allocations, are you thinking about 1)
a try and bail-out early model or 2) a keep-trying model?
For the latter, I wonder how large the allocation latency can be
and if that is tolerable or even makes sense, since for THP
allocations, we have seen >30s allocation latency when under
memory pressure. Is waiting minutes for bulk > order 0 allocation
making sense in your use cases?

Thanks.


Best Regards,
Yan, Zi

