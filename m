Return-Path: <linux-nfs+bounces-17789-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 165BED1893F
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 12:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA9CD301586A
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 11:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720AE346AF7;
	Tue, 13 Jan 2026 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Bh1CvfkO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020111.outbound.protection.outlook.com [52.101.201.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7011EB5FD
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305076; cv=fail; b=QJX7A/WQWqwq6cDwmj4JhtrGHox6bq7WDmBX92G8eOzL7vHdJt7e2vAntzNWD9xYh+kt8pHmMOmNtAunJ0j+sH+adlJ+niRGUrf62Sv62goruCfi2sUehDPGL2zNbzX7AtRsc07inZZFl1Qk62UaiRiHD9lQviZKTaV3IdK+gyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305076; c=relaxed/simple;
	bh=TQ/O7mDePZNLlZPGnllVKskaQouxcyo/kz16vkFYWNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bEGDioN+S6FrPdw9RSe/vgD/RM/qADkE7h5Rkccf/wi/E8G6TJJ4vovNJFPDyUu+TwSRbfR+JDSSM941UXIUHeD9QqpmuvuMxR3dUc7/EmHRWZOHaRqi+pAgPkcqnD0YkaZ8J/n1MwG8SrfV0DwQUc7sGhFYafAFNYH84E+t7RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Bh1CvfkO; arc=fail smtp.client-ip=52.101.201.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1s5Y87QHt5pAlV1dEDppGTixkAr06loc4xEREdYgCOMJZJuqN544BVjQZ0lc9tZO+4qjPjZ18tlOE6psrd3rX2llZxIuhYO7bs4eXeL8G1HB6FJ1hiRwIdFfyoGlg/V9IsENP8IxId0mXXtEUrSbPn/RX/r7Wp2YSRhCsQwnGC3A1KkIZik8mFP9gtKvTTleIJh/JJ7HITkYDTvV4C0G9GQbD7MfVHGCAvYNgFsWTYOQdCxmHEyDeFJ3g01uAliVcRGfrbaEc9veeOllgPGrX4KzeXa5bxSsgMaWOq7cYpsYgPovG1NViE1VQKfj1NYZFcy5m/zPyd8pSFKrFxj+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaF01XJ3MwjV5mzDsUgB+kDRRuds6astTfVLvPAHtt8=;
 b=AGXeIbyaBDPmP+P6iI0BLp41MzMXPK3D9KKiLJfy2axEaxkbtu2YM1LslmJqC+gwnR+9N9lgRZONvVshFlV0y/mBn0pwjtOMo3SbAzwhUrN2qt9r1WAEOI53SeYYwdvdDXcq/VmNhbSwFHeuQudtkri5pw3y1UMMgHNL8o7kD+o2AjUaOIv++cKjqnWkmfxPPWaN8L7Wixuew9XBjV4GQ1poeJj4MKUcag2HJzLZs7fY0GmR0uV7O3OtNXAZWDBj73hAh6/GMQRjyGHY+U5MkhU1b0kISHpGlWfzMk4WhYGF0ctDZ6lua53aNrN7NMTqVpDPrQFSqQgnGjjAh1CqyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaF01XJ3MwjV5mzDsUgB+kDRRuds6astTfVLvPAHtt8=;
 b=Bh1CvfkO5XfK0NIXHTnfk0JJbZUUnBtyn+qXJ+xy1zm0bejRhW4WfPUKTcdz96OnXsM0bd/fjkLn5kUcHxEHE5qwcDueoOUtzO8m4udqU4In0zajoij4XvfneQi/x1XEpalJ68XSN3WqqqgdeJkJKk494UOBCs14kgapJuDQfik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 SN7PR13MB6101.namprd13.prod.outlook.com (2603:10b6:806:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 11:51:10 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Tue, 13 Jan 2026
 11:51:10 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1 0/7] kNFSD Encrypted Filehandles
Date: Tue, 13 Jan 2026 06:51:06 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <7F8B576A-465B-4DCE-95F9-9F877513DF2A@hammerspace.com>
In-Reply-To: <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
References: <510E10A4-11BE-412D-93AF-C4CC969954E7@hammerspace.com>
 <cover.1766848778.git.bcodding@hammerspace.com>
 <aac7f668-5fc6-41cd-8545-a273ca7bfadf@app.fastmail.com>
 <2DB9B1FF-B740-48E4-9528-630D10E21613@hammerspace.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8P223CA0016.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::35) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|SN7PR13MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c3bbf35-1fd5-4d07-ae6b-08de529a0b63
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bdzlHWPHptYEX3UYJKbVKVftu0vEpObTRYsM12yHC9UAR90jlZg/RpTz3r0v?=
 =?us-ascii?Q?RdXop1wmio3xKpd3n+23iLPVvlS+O5eqLaeKMHaA/laRdXG5cWbKlftuDxc4?=
 =?us-ascii?Q?O4HB0t1nXPMag1WOpza1+xGFguyQHisSDJlHH680ANMD9RrswV+LEISdE7dJ?=
 =?us-ascii?Q?wnLGBYGVnd2efHQjkMK4o2fZzbbkFX+SwyNDZTKvzDAwczh/jn3+I4wyOcJt?=
 =?us-ascii?Q?NeyLHXDavaE+fnu9DfDQ+HEV5SFmOa7EKUxnOdVNP/7E5GzKLixi2vV7ZROH?=
 =?us-ascii?Q?/kjohoyeDNJGhGvS9NvP4Kv0sqgKUGVxCIOI9eBZLLkMvl7DhXaAu8kMh8GF?=
 =?us-ascii?Q?93SN+FFS/Eww2HzgCxLmUFmD/eM0mhjTCrjqmEdhZbPxBT8FpQPHB8fa/0Nz?=
 =?us-ascii?Q?Dx/LIvCQlupUmFJ3kiprz4GoiFg3REtRCso4WgmqqkNUzt8yMXClUPpLB5jw?=
 =?us-ascii?Q?BjO2kx6M3+fAJwDQpvyjc996qrunlfMIHjGNDKJi6d0xl86HrCRV212vuwyI?=
 =?us-ascii?Q?aO+RtjW51Ll7cjE6AB+4UnX3Yc9jJuorE6R0bmE7FS1jW/QUI6LIOdkUo08p?=
 =?us-ascii?Q?1tCW7wraDBdSg1FMCEM9nUNb2PMVAyqPUa1rTADXbPSpCKcLUKmAvQxdzKrS?=
 =?us-ascii?Q?OFfoWixf82+O36zx876UxRcpAwXzK7OnngTkRGgTb9/NIjkOZVZqA5HuHhqU?=
 =?us-ascii?Q?GThS7xmj7nr+MelDOdVx0oNLg8K9Su9UmdFcB4rYPmjpzFhfWwyYWsXJm5nX?=
 =?us-ascii?Q?F3KJ/hLowJyXuHaLLggtmxMcR4S85s9sN8DZGoti6LqGKuuQNh9KQX1qjxPA?=
 =?us-ascii?Q?Aa8+TmE6WxtBRHVZ3CmYZrfBn8T6EmOyNaW+dvs/H7nt7Lhs7969EL4oJqCn?=
 =?us-ascii?Q?hf/3TPuKU03+Pi4DxmN5rYybSMybkrHg6NZfqpdrBhajGfmeDcwvJ7JrT7TD?=
 =?us-ascii?Q?QAwBNEnKVgiUBcDYL1LiWulgYD3cYFtdh8l8MSRAWpOKX8RFPTOahQI4VhGL?=
 =?us-ascii?Q?KlESn1JVsAM6mL5MhSlvcpM6WOiPF5qup3fSFqezP+MX3A7tn3Mt0I+KnAGu?=
 =?us-ascii?Q?w745PPTTnCu7nClNiSalFmMjRN0wr/p2PQd1eiNLHgvDQn+TVb+er93mZa9g?=
 =?us-ascii?Q?or7M0pRGIVkwJmvcEijXQoCgXikmSFvAm1E9mL1B7CQmMUVnFB/dV4sjEaXP?=
 =?us-ascii?Q?uYKBGeeeO/iifGe9HdI5tbnYqXHZleH8NYxHUxByZKI+y9PwH7l70eu1+TQ+?=
 =?us-ascii?Q?f2+9lqBARg1nGDWAZxqOjL+d/qMUcswwPK3/FR4sMv4Mk7sPmBCSMtpGlnFr?=
 =?us-ascii?Q?YFMwAmSAwqMdgPiV5wZq0bkM9Ock1RfOWqdEpl4P6AEFKjLPKruH8IbqwLVt?=
 =?us-ascii?Q?UPabwFIe3sK18ZCytNWFnw4266xY8z1pbyOamN4GZSlk4WUMFmgU8AHjFwsl?=
 =?us-ascii?Q?PLCv/XrI96cZ7Yy/4mVF4lB698JgUXBJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CNEKFmKGMVoHmjG66A8LZA6eMgGxmahVKROUmhtoOPz5za2yjAZFY1T+CG9U?=
 =?us-ascii?Q?MO3p2ItV0gxRyIQklmwxxsDJ//5kXTYdte/BOJ+7TIAp5pWwsXRYmbXVdNQJ?=
 =?us-ascii?Q?Hg82LWezDws97ydK9eUVOe+MXlgVFq1V2EgAl86NPnltWiXX9vBlNRlzP1RG?=
 =?us-ascii?Q?J+MkOAvH2yJ+aYpcASu4/Q9Ylb6HNrzclJQk/d5JxrRA/Ucm7TI87Hn1CT5v?=
 =?us-ascii?Q?ekLwF0Dvk1PrJGwF+r1qqwIka08eLGTOkh1DWFyrnany8wIkFBEqx8h5cs+H?=
 =?us-ascii?Q?jSARMo61v8bKSVYT9uCzkwOx/gzDAjGMOEE7/OxBdQXvCR+yKEHudRAkxOvZ?=
 =?us-ascii?Q?gHFnkTqtyrmkc3H5cUxSTUcCz1s9UcdY2It6DjcLPcaF+fB5zxT7C5CTkoDC?=
 =?us-ascii?Q?H3cbC22py4rKpsGZ2+3x5l7Mvq5ch38dt9ZsM4z39UK7KFAoLghw+0SqFNOy?=
 =?us-ascii?Q?hgFyBUSnazDzvdCSL8p8fBsT49kMi/bX4C+tquDVqHca6XxxajwBXYilttBx?=
 =?us-ascii?Q?nqNlT1vt4fe2Sv4eHEZoh1B2F0E4OzXIhfBfgyVTXmCicoo7pbTz1XkQ5Twg?=
 =?us-ascii?Q?5FlQA75+9ozbUQm8HdciJpllU5/MRTEXSdvl+5O8Xc91VdTmJIFF3eGJkXNT?=
 =?us-ascii?Q?TZBusTSzOWWXKMN6fIuDTlpUrpkOBW9CNrmOZ34pweEufCwgc+NH2Hg1x15K?=
 =?us-ascii?Q?ij0iK4UHav0Mo9fTbzvtcQgTCX8UZDIrtIoE6XcnzR6EpEmb+1l7fFouQtwK?=
 =?us-ascii?Q?Thr2I0XFfLCiDNoBYgEfgRmwk3fvFweS4c1P2qwQWy0OUgVMBRWKrnpdlz0f?=
 =?us-ascii?Q?8PJYK82Ap+XetWAiPD2uDmha8LY1oD1mslwEKrcNHIbYW+6kVsZYRZHjzvu9?=
 =?us-ascii?Q?XIMgQC71gqny5mEdaDlt9lkF6JZixS1H7We5v1Dl6+tS837ZEW17qiAWJCEO?=
 =?us-ascii?Q?SswJzQeMpCg5Vd88NMRiBIt2q5MJFxIOSusExUnMpDyZ5gH7aoFvrrOW+G22?=
 =?us-ascii?Q?q2Vbfhz49L9YAD/WaKZbQ+5/5OJJxgGx5HrGdP8UuSPxPDCL3EThJrRqh1xo?=
 =?us-ascii?Q?K+KYwyAynlOwJGCKbFdeiKoSCtXXLTvHSPkf1EbpcAWN/OTahf7iIY8n/XhJ?=
 =?us-ascii?Q?tXTvC4+3RGiEPXBBb/JzMbo0guX1iWS9GhlO00fyNNKUFuxZM4SwfwpU6pKU?=
 =?us-ascii?Q?hwFSSbSo0b20migpSjvsoVpXzM1OFmnpCoVOOZRRW3YPOoWELD5VbmgxSafn?=
 =?us-ascii?Q?f5G+BMaXeQPq8Jw7oWvdDAtn7x13q/rjFQ3nFa/jX/3MfZkB15xXQ9wxx0Ye?=
 =?us-ascii?Q?n6MbB+aPdo17mGNRJI3bFI2Kj+gnfp+TB0YDtPkcCtp15Txh+AZtpqaX9cta?=
 =?us-ascii?Q?MPFmifeFEUTJW/ob4IxBLr+21bggCTmpgWp9rBfAWOq2qV2mBvsqW5cNVgFd?=
 =?us-ascii?Q?L2ed/HA8AX5KIiUOGcli6WY2HysRHmaddCek+Ux0MGlNJN2/760j+z3/Q+A4?=
 =?us-ascii?Q?GVyOIC0F2kqkEQWEwdFCpnFw6PI9rrrV0PqtYWOx5hKgKGd8mTlJ7qm9la0g?=
 =?us-ascii?Q?E2/BR/8jQ9WMsWMVGgv0N1eMi5bX5g03h+v8Wkxl18MUMnzsSG9AjtOa8ZWD?=
 =?us-ascii?Q?X0UJcbwpjk0cEzb2d08Pl0WKlU3Ib6+ZFrJ5IOjQ3bDC+5aGcE2RB0JLgYxv?=
 =?us-ascii?Q?Tg2XjP2u1STRd2EDBhQOELpspk5I5BmrJWRB4nWV9L/f02ynvhVQ5vY5mfWE?=
 =?us-ascii?Q?NkiMKvHKleGIsWoOWGFl6+zDEo+miX4=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3bbf35-1fd5-4d07-ae6b-08de529a0b63
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 11:51:10.4567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1fsQS3szEtkoh+etK+2SMFiZJr1rRqZa6mH++S9r0Vztm+VkfvtgoAV329WDjsw9VyVXuGNlkye15cRQi/EUeqXXNKxmklbKSoZzTmgXzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR13MB6101

Hi Chuck - I'm back working on this, hoping you'll advise:

On 29 Dec 2025, at 8:23, Benjamin Coddington wrote:

> On 28 Dec 2025, at 12:09, Chuck Lever wrote:
>
>> Hi Ben -
>>
>> Thanks for getting this started.
>
> Hi Chuck,
>
> Thanks for all the advice here - I'll do my best to fix things up in the
> next version, and I'll respond to a few things inline here:
>
...

>> I'd rather avoid hanging anything NFSD-related off of svc_rqst, which
>> is really an RPC layer object. I know we still have some NFSD-specific
>> fields in there, but those are really technical debt.
>
> Doh, ok - good to know.  How would you recommend I approach creating
> per-thread objects?

Though the svc_rqst is an RPC object, it's really the only place for
marshaling per-thread objects.  I coould use a static xarray for the buffers,
but freeing them still needs some connection to the RPC layer.  Would you
object to adding a function pointer to svc_rqst that can be called from
svc_exit_thread?

Ben

