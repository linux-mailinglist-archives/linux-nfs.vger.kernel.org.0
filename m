Return-Path: <linux-nfs+bounces-2113-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06286B9AA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 22:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626101C24804
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97758624E;
	Wed, 28 Feb 2024 21:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CmNu9VT4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QF0SjFaW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49070037
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709154568; cv=fail; b=bNs/Qqxzxjwy9+ZkXKwK+2kdT1BGeLZpYYGsFRimTP0vsyILMDoYB7LATscnPQZaVKlmjmxiSMXn1geRiMuDqnIeDI8zyrppoiJUw+P/ZgpOLg5fFY2Hzy9P6whwAB00TFAa3DUeHg3MJoGnNo2c5zM6ixqwbMqNaBo1NFzIzpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709154568; c=relaxed/simple;
	bh=Zugz2NLgje6hvqDEQ7qqHGuKqCXdOn6G+617jxn6qZ0=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D3O5g8k3PYR1DQ9e8HWlxRvB9519HiLfCnF4tq8XLfDLA77iYzP/S7gt3dzze+ncJNB1XyFwO+yE/67VjZDsu19u69RWFfhZysWADY+a49rDMUBESdCvWe1t39SrsslJOZvJ3SWzLFxKSjUWNP+6bl0zvR7H6hl2hHPmG+in6EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CmNu9VT4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QF0SjFaW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SK3CfE012890;
	Wed, 28 Feb 2024 21:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 cc : subject : to : references : from : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=Zugz2NLgje6hvqDEQ7qqHGuKqCXdOn6G+617jxn6qZ0=;
 b=CmNu9VT4sOU2dcsSVC7AYn0Vdt317H+xel0KLmh/8qMVlgaCjV3Ho/zu0zWBrieM6bq7
 /UfWndgvh8VQm2vhq5TEwTKPzjQwjCS+QT07OR6+nfEaSsfBRUhhAJd3GCk0YnBdCmH6
 h4wBMyw0RMbMHq2UZgWTFaES2TvGCpHknVmCzFKvG+r9PXIvgqQeNgzX6L+t1Iyrm/so
 HKxS92g56e+xccNSiMsFYbBol6qsvzF+0/pkXwTJ1kPWHICDUpdQ184RkPjw/hEqZzSf
 BBXAxbsEYDgeOzBEN3y06hnEMzO4Pmodgv3ih7vMhuFKRCl/pQBcc/VxH6d/n3+Hur+o 0w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784kny5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 21:09:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41SK1Kod009796;
	Wed, 28 Feb 2024 21:09:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9fg0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 21:09:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gb22WVVozK1+WSeSVwFJyagvlvJY3HOCMmtBwlS2U2Q6vT8mFKIAgEwjqTR6/ZncPRZ5sVDUe148Awlycgjkk/5UtCkDXybzbnHdZPoiPZM4x+T8QYJ2/hYXIBYRq91/LeZx+pvdM0AIxU6/j8VyYHAMCavi9ApgfYKt8w3QvSkamnDbZriKdUc0peAhQW6ckiO16twSKi+XFG0/DVRn7+zSSAgm7tf5ppiw2nEFI+pZOYXy1ks1GU0+5TbBVlin51UamN/3PgjSQiuygh4KO9IeKUzsY1m8+vKGyITwUGAcgl4WMNE/GmK8a6aj1QqqoVx4uTUL7VSB1rKoB19Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zugz2NLgje6hvqDEQ7qqHGuKqCXdOn6G+617jxn6qZ0=;
 b=GaayojP3bB/X6IKprWZ7lcRNF8R970ChpUeBol6bRFK8mq2FPr7U9rQ8s9Ji3OKq4BqPqxBTsqRdJbe93tS9wJsWuROY6rymuKnhfiksfCFJUWGC9eX67ZnqgNuBFh8s+TQLLm0ePbhLvsuliQ5frtaGfuvNRBhcHz1xzgkyUEONmlgiudlodJKQEUaypBby39zDtfj/0jTmrQ3ym8vjN25/8K3t03S+w4tw9wWUqlZgLJeLZNqpAhjozeLM3Ciwv4XtyAh8OkD9iPCdD/c2RvfHc/j/gMHd903wZiQEvXu/29tfaDzbDvodM3SNAm5eoVBhxRDjJlN3ZIxrDhgjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zugz2NLgje6hvqDEQ7qqHGuKqCXdOn6G+617jxn6qZ0=;
 b=QF0SjFaW09Q/IJp+BCwegLCZILTuRTwQCtLAJDMSMXXUfTPXvXYkhYw13GSZPSF2W4cntK2tAPlG3fQ/rbdqXGxGTCkcL39QcFZFpdJy9Uz0lfqjnTNrEP1fVvDJWNEk3uBFk3VzSqcVYIxzhyfgvBMhcP6dPkAkQbcB4xU6bfs=
Received: from BN0PR10MB5143.namprd10.prod.outlook.com (2603:10b6:408:12c::7)
 by CH3PR10MB7612.namprd10.prod.outlook.com (2603:10b6:610:17b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 21:09:12 +0000
Received: from BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::1b5:28b6:5a3f:2053]) by BN0PR10MB5143.namprd10.prod.outlook.com
 ([fe80::1b5:28b6:5a3f:2053%6]) with mapi id 15.20.7316.039; Wed, 28 Feb 2024
 21:09:12 +0000
Message-ID: <fd6db153-669f-4635-bacf-a23b0f7d2c7c@oracle.com>
Date: Wed, 28 Feb 2024 21:09:07 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH nfs-utils] start-statd: use flock -x instead of -e for
 busybox compatibility
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, NeilBrown <neilb@suse.de>,
        Steve Dickson <steved@redhat.com>
References: <20240228185644.2743036-1-a.fatoum@pengutronix.de>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <20240228185644.2743036-1-a.fatoum@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1J0YY5DSyqfr18e8PEbWYU72"
X-ClientProxiedBy: LO4P123CA0113.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::10) To BN0PR10MB5143.namprd10.prod.outlook.com
 (2603:10b6:408:12c::7)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5143:EE_|CH3PR10MB7612:EE_
X-MS-Office365-Filtering-Correlation-Id: 15773dd4-7617-4aaa-5e5d-08dc38a1830a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KctRYEym6Ds/nYcT7iAvKgfI9snQt0hfupB2e7QSETjDhc7iKbXx0U2ThmvwmRljvpDNZcj7/xr5FN8G5vvdcbEB0HsmVsdeMyrF0ib/o0h1y0TKzG8+lWcaWDnizPwV4bfHf6hh2wfMkkNaWLY6OUC1tLOTbArIC9YZcyVq+zisVV1bgR/mGYkYcwEUaXXmLAjVhcf7JCpBTYFWPU2X0JkKDhCXOE+FOodsj/XWM69rFwWTiK+r+fBq+37yOv/maAtxQzQYH/JJlEHTS9+dXlfGN1kSRKCQCMZBxr25zwic8janyd5gn/DBReJk2do5SvVOv2FxsRvhzZbpPE7/cU0WWGFQbO+Z5v9q28jRZxcenU9OEPvVvoU51bM337ZB3EJEuNl7T8TdQ8VwsMZkOCoFhMdeGoNhF6W8FrdWTwpZ7dj+fwNxHqhRsOiX9zQZ2LJODfzBSDJIuv60i8TnMM7Bs78JH6RF3KMcRjNgaIezwR5QFinzzWNjhsrK7dwV7ye5lP0aDHiHm8XaK0loxL0+EaB1YwJssaCZkbirjuJLpbEXebAmndLZUs5V6Yh4Vy9DpPXEMgVZvtFyPD7/OAMpM+XP25gXPkfhky+H+43p2xQJeF67LGpalEh/L9re96JpiHAInC9N/6qNpyRa9Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5143.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eExoY1dVb2VZSmVJMDNjL3M3cWpjT0x3Wlp0cVA0RHVmWSt5RnVpQnpRajQ4?=
 =?utf-8?B?c2VYWmtCT0FHL1hkYVh1ZG5tYk1lQkdvQTdIRnFMR0VBak8vMWdhTHNwT0tC?=
 =?utf-8?B?MWprNWQzOGNKMW1tWkhTVDU2NkduK3lUTWlRaXVWdXZkS1BVNGlFMG5VcS9R?=
 =?utf-8?B?Y3psVWNBV2wzWHlBNEZVb21CbitHWHlFOGQ5UVgxcDN3RjV3ekZQWmsrZjVy?=
 =?utf-8?B?dGJXQkxPUWVXQy9XaHkvRTZPQlN3WnRhNFNNVStWTHJqMVFBTWVzbWNsOGsw?=
 =?utf-8?B?N3VFVkhwYWpyZHl1Nmx3Tjk0Unc2U290NUErdHp6SzBBWDdlS2RRRm5rWGhX?=
 =?utf-8?B?THFjUFdLU2tPSUIvalB3VHk2SzJMNUp6NHo1WC9Td2VudW5OTWtpTkV0WDVL?=
 =?utf-8?B?d1Y4OVVLbEUveTNYZU9nRDJ6UlZVL0lsZkdoVDJOWnE1WUZJZnJiUmc0Mlha?=
 =?utf-8?B?Ym9CeE94eTBUWjBhM3JGME1uaXhuWU9ha1lUQkJIcjg3L3BwdVVjT0pSRWp3?=
 =?utf-8?B?cTI3ZFplZUkrWTlrWko2YXR4WUZ6L3FWcGl1dVpHYkRSUFNoamhJbXZrck95?=
 =?utf-8?B?dytxajRtUGNHMzlZOGZaV2xKTkZUTTVhclFnd0tKdmxmUnBiUXRaVkQ5ZUZY?=
 =?utf-8?B?YWlFM0taOEdRVGZKUW8rYmNXUkYyR1FYcmNZMkw1aFBHU21vWHJIdUdiUGIr?=
 =?utf-8?B?YXdTNmJkQ1Fra1Nob2FZMTBBbGV5NHF5RTFvY0VXcjJJT1o4c2RHWFI5TVo1?=
 =?utf-8?B?WldEelZtSzN6c3U3a0lJZGFudlJnNzBuN0tKcnZCSkM1L3Y5TUY0TytIR0dT?=
 =?utf-8?B?UWxCS0FyZjk3ZURQSkFJR2F4NDdFWVVwWEVrRWo1VmRuclIvLy83c3VwZnha?=
 =?utf-8?B?bWh6ejl3T1ZlUWozV2VPL281OEcrQXBCT0JMeDFNc3kvTlFUK2FYdFZKb25F?=
 =?utf-8?B?MUJEN0Q5MXFBTHd4d0xCeWtXbHZDcm91M1FsZG5Vd2t0VDE2R3dLQWltVG56?=
 =?utf-8?B?SllhOHA2U2lUd0g3T1RGbUZldTJqYWsxVXZCVHh3Q2xOWlhLb1lGcGRiRDk3?=
 =?utf-8?B?VUF5RXhPRVR2c1U2eFR2enlobnB1WTBwWWYzaEFOVEZFdWc0bGM2bnJ4U2ZJ?=
 =?utf-8?B?WlFBNlp0Rml3S0hBMmVrZWZ5R0tOM3R4LzdwbnFoQXYyNHhmdDJmVENVanpI?=
 =?utf-8?B?bWo1Q0RvakxZVGVxYThqNVl2bE9tRnpXMG83UVJQOE5QY0FuanROYnAzcVhV?=
 =?utf-8?B?WG5NWERsb2pDek80NUNURy82MFJyQjU0ZVRCa1ZpRGVKT0hDTHpJT1EwTG5u?=
 =?utf-8?B?RXN2UHpmYTJzSjBUWllmdnBSRnl3WVpsK2Ixb0k3ck9HVGxWYVVVenpBM1ZV?=
 =?utf-8?B?VW5EVVI0elozVklvMmJpOW1jVE9EdUVxZm9ONGpTY2ZZdm9BaDZkU0tTR1kw?=
 =?utf-8?B?TGF4U3I0VUtuUjdNMi9oVFZrcmlqM0ZxV2JyK1liL21WVGNDblVyUC9BNmlV?=
 =?utf-8?B?dEtCbVRGMTRXLzRySVVQdmlvMWFtamEwaWZoUUxhQzlza2tvdE9lcjhmbmVR?=
 =?utf-8?B?amhTOWdJZ3BlM0pxeFExZm5VUFJnY25Bdm5ZSHRXVUg5RlFuTmswaTVGWkY5?=
 =?utf-8?B?bjhxU3ZPdS9wMXZzT2cvQStTOTZuWnRXRENXYm00Y2lvTU9kS1lkbTltL0to?=
 =?utf-8?B?eENzQ00vd3FlUDVTWktITTJjVWpWckp1VWpycTBKRndLTHpMU3Roc1NGNUZV?=
 =?utf-8?B?UFZkdWpKMWE4MjJiNDZPb09qT0sxWHRyQkx5T0FsVWtrL3A2MUZCNnEwN2Vx?=
 =?utf-8?B?bmVvcjFYVG90Y2lSeUhSVmVpYlRVTHpUbnF3MVl0a3lOb3B1YmpOTVA2RlN5?=
 =?utf-8?B?SW55K1hBZzMrZHZ0OGFick4xeS9sVUVNYVVKTWZvRXV3SWtzeHQ3WkxKdXVj?=
 =?utf-8?B?SldWaXBQU2QvRE1MMXNhSENwRzhNTU1NZ3FBSDBBVVM2azNvaEs0Q2IxMEM2?=
 =?utf-8?B?TGNlZytUTDFubDRxQlhTNTRJTytFK1U2MHdjZDNUeE5SRlluNng0MU1hRVZX?=
 =?utf-8?B?c0w2Vm9CcDlWRjhuajNOVDdkYStqRW9nL2M3TU5tdS9VUnI4VjVWWCs0eDh2?=
 =?utf-8?B?RTJmWU9jM2xmOXArT3Q1SXBlT0RNbkJIWEtNMHExeUtQZVR3TWdTNzNnYnJ6?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WtWr8vbiiK9EGbrn0KTU3nPrw1bzO0hO7NEbLIFH53i7fYJlml3JGf5omWnlfiUZdJ+HX1z8tbtBiO80lt6lwJFumBAokppvCXbU7wLYeRFFUg+qMR8gSi/nO3bxr+hFUdLnFVEnb15fKixan19uVhALLPYQSFDk237zOLP1G5EChghjW4DapnAmmiIPcfLr0nHhrGNHIGkJSPlvRzol20GaC2JZOeu6KAtp7MNbR+vSjjJSJ0k9GYgP2Uum0BdVsGXG9O/raR+TEGoPaxLGLv3ys9YyMpWSAIZaYtBomyQIIt1M31Sz1+G0izhVBMyOxphYW1alAKPL5tCFG9fjaAjVE+aHvKa2da65XMfpxOpT2lrG9EGPW3OGZ3Wg7o0AcORODmlaMub4ZWs2Km3aMHBfTFX8pnaMab62OinTcHcYmWVp6BxE4SV4m7MtcLeQblonijmABtvFZS8SOvS3bX+DUhraaaBNF9blWpexf4JA8aS7wxSLHB+wiUECvYkVnRAHuLsX6QxehLKVDDo/ot5gKDC4MsyeomgqefQ9ynqjZXePaWefpcRCrM+EabP6eFoz7MhNKtd/A0ybBobv51RxCsWb0/TJ8KfFaUw0PsY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15773dd4-7617-4aaa-5e5d-08dc38a1830a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5143.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 21:09:12.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTLLfhSabKqAA4dsNZUMeu7B9FCBHHi9+WTDHjALEUK/FM22RprB0L0XaTAAnvP6Y95OzLge8sQ3dP8j+exqFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280167
X-Proofpoint-GUID: ymZCd-R2skOj5liD5LzlL_3792EH2IPT
X-Proofpoint-ORIG-GUID: ymZCd-R2skOj5liD5LzlL_3792EH2IPT

--------------1J0YY5DSyqfr18e8PEbWYU72
Content-Type: multipart/mixed; boundary="------------1lcHiA7fhxoFXRnZzBKa7CxC";
 protected-headers="v1"
From: Calum Mackay <calum.mackay@oracle.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>, NeilBrown <neilb@suse.de>,
 Steve Dickson <steved@redhat.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-nfs@vger.kernel.org,
 kernel@pengutronix.de
Message-ID: <fd6db153-669f-4635-bacf-a23b0f7d2c7c@oracle.com>
Subject: Re: [PATCH nfs-utils] start-statd: use flock -x instead of -e for
 busybox compatibility
References: <20240228185644.2743036-1-a.fatoum@pengutronix.de>
In-Reply-To: <20240228185644.2743036-1-a.fatoum@pengutronix.de>

--------------1lcHiA7fhxoFXRnZzBKa7CxC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjgvMDIvMjAyNCA2OjU2IHBtLCBBaG1hZCBGYXRvdW0gd3JvdGU6DQo+IGJ1c3lib3gg
ZmxvY2soMSkgb25seSBzdXBwb3J0cyAteCBhbmQgbm90IC1lLiB1dGlsLWxpbnV4IGZsb2Nr
KDEpDQo+IHRyZWF0cyBib3RoIC1lIGFuZCAteCB0aGUgc2FtZSwgZG9jdW1lbnRzIHRoZW0g
Ym90aCBpbiBpdHMgbWFuIHBhZ2UsDQo+IGJ1dCBsaXN0cyBvbmx5IC14IGluIGl0cyBoZWxw
IG91dHB1dC4NCj4gDQo+IFJlZmVycmluZyB0byB1dGlsLWxpbnV4IGdpdCwgaXQgc2VlbXMg
Ym90aCBvcHRpb25zIHdlcmUgYWRkZWQgYmV0d2Vlbg0KPiB1dGlsLWxpbnV4LTIuMTMtcHJl
MSBhbmQgdXRpbC1saW51eC0yLjEzLXByZTIgYmFjayBpbiAyMDA2LCBzbyB0aGVyZQ0KPiBz
aG91bGQgYmUgbm8gaGFybSBpbiBzd2l0Y2hpbmcgb3ZlciB0byBmbG9jayAteCB0byBhdm9p
ZCBjb25mdXNpbmcNCj4gZXJyb3Igb3V0cHV0IHdoZW4gYXR0ZW1wdGluZyB0byBtb3VudCBh
IE5GUyBvbiBhIGJ1c3lib3ggc3lzdGVtOg0KPiANCj4gICAgJCBtb3VudCAtdCBuZnMgMTky
LjE2OC4yLjEzOi9ob21lL2FmYS9uZnNyb290L2lteDhtbi1ldmsgL21udA0KPiAgICBmbG9j
azogaW52YWxpZCBvcHRpb24gLS0gJ2UnDQo+ICAgIEJ1c3lCb3ggdjEuMzYuMCAoKSBtdWx0
aS1jYWxsIGJpbmFyeS4NCj4gDQo+ICAgIFVzYWdlOiBmbG9jayBbLXN4dW5dIEZEIHwgeyBG
SUxFIFstY10gUFJPRyBBUkdTIH0NCj4gDQo+ICAgIFtVbl1sb2NrIGZpbGUgZGVzY3JpcHRv
ciwgb3IgbG9jayBGSUxFLCBydW4gUFJPRw0KPiANCj4gICAgICAgICAgICAtcyAgICAgIFNo
YXJlZCBsb2NrDQo+ICAgICAgICAgICAgLXggICAgICBFeGNsdXNpdmUgbG9jayAoZGVmYXVs
dCkNCj4gICAgICAgICAgICAtdSAgICAgIFVubG9jayBGRA0KPiAgICAgICAgICAgIC1uICAg
ICAgRmFpbCByYXRoZXIgdGhhbiB3YWl0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBaG1hZCBG
YXRvdW0gPGEuZmF0b3VtQHBlbmd1dHJvbml4LmRlPg0KDQpoaSBBaG1hZCwNCg0KU2luY2Ug
dGhlIGRlZmF1bHQgaXMgYW4gZXhjbHVzaXZlIGxvY2ssIGluIGJvdGggQnVzeUJveCBhbmQg
dXRpbC1saW51eCwgDQptaWdodCBpdCBiZSBzaW1wbGVyIGp1c3QgdG8gcnVuIGZsb2NrIHdp
dGhvdXQgdGhhdCBvcHRpb24/DQoNCmJlc3Qgd2lzaGVzLA0KY2FsdW0uDQoNCj4gLS0tDQo+
ICAgdXRpbHMvc3RhdGQvc3RhcnQtc3RhdGQgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdXRp
bHMvc3RhdGQvc3RhcnQtc3RhdGQgYi91dGlscy9zdGF0ZC9zdGFydC1zdGF0ZA0KPiBpbmRl
eCBiMTFhN2Q5MWE3ZjYuLjY3YTJmNGFkOGUwZSAxMDA3NTUNCj4gLS0tIGEvdXRpbHMvc3Rh
dGQvc3RhcnQtc3RhdGQNCj4gKysrIGIvdXRpbHMvc3RhdGQvc3RhcnQtc3RhdGQNCj4gQEAg
LTgsNyArOCw3IEBAIFBBVEg9Ii9zYmluOi91c3Ivc2JpbjovYmluOi91c3IvYmluIg0KPiAg
IA0KPiAgICMgVXNlIGZsb2NrIHRvIHNlcmlhbGl6ZSB0aGUgcnVubmluZyBvZiB0aGlzIHNj
cmlwdA0KPiAgIGV4ZWMgOT4gL3J1bi9ycGMuc3RhdGQubG9jaw0KPiAtZmxvY2sgLWUgOQ0K
PiArZmxvY2sgLXggOQ0KPiAgIA0KPiAgIGlmIFsgLXMgL3J1bi9ycGMuc3RhdGQucGlkIF0g
JiYNCj4gICAgICAgICAgWyAiMSQoY2F0IC9ydW4vcnBjLnN0YXRkLnBpZCkiIC1ndCAxIF0g
JiYNCg0KDQo=

--------------1lcHiA7fhxoFXRnZzBKa7CxC--

--------------1J0YY5DSyqfr18e8PEbWYU72
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE1GBbrQYgx8o9Vdw+hSPvAG3BU+IFAmXfoPQFAwAAAAAACgkQhSPvAG3BU+IN
IQ//SA8Kd6TWetJCflDJQtn5PAKxTzeANCAIP4at83aiCrHS/M27SR02au0wH1VYn5dC0YXwo76H
8AIewIzmlo3514B9Y9z1Vg55HsTiJppQtI+FnaryGcLZe81XEEmtSszQVxOsMBy6YCVo3ZxeI2cZ
8zqBfcSOFwUyVgQA7XxUntCOgycI0xTwidoXoiiAyxpXd4FWLyTAls24x4P68g+8wsD/uemusR7m
O+uNv1++dxOJNWlKUGeUxPu3Tq3PouhUS98qJfY3AHVTCe+/lTzHY1wkND+qRRIpaOLjuhp6uoH3
Gg4//Ts/VRGS3Ob0o6SPkUzXIgf66q8LNmdpgX+j0RHuyjHR+RaAVa+oR4B8e7b6KcNhfyXFzXAi
ibKiZiP8Z8TnloAj9KQ/siYD7WEqr9j+lnrmGrn7EI3NworiE5Fe9bTlQTTeYpKwCQSN+G5jcBY2
9rzyet5yXykS3ZKrL+dP/pNqkj09Lrf67YjDWJ7QKIQE6jOboum9L2XXbFOq5ZChFbgM0iqAJrsl
vySd/glo6pb3f23NNx4zgJkIzhyNck3S1mYCfkpNrhXWQHfXD4oxswrsQpai038jMvRd89sKyo9i
DQiNp1tVTydkPXc8bflyZhjqbbEdgkIfHKm8A9RLk2YF5F291h6daxhaFkd6jo6QRbJNTjvcV+x6
898=
=oJSw
-----END PGP SIGNATURE-----

--------------1J0YY5DSyqfr18e8PEbWYU72--

