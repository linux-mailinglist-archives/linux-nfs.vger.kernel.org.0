Return-Path: <linux-nfs+bounces-8658-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AABEF9F6F33
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 22:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71486188F141
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2024 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0BB1FBEAC;
	Wed, 18 Dec 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SRBYHvRe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SNA4eEGa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875A14D283
	for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2024 21:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555939; cv=fail; b=FG5voVIgsNGu301h/L7ZzW+pfcf3Yxi5u5tkeJ8lDdTnfCegM47NZe5KdS+G8kkcT4l/VERQSC8V7Lezm032QjKwxdqAVGcxf6CFM1xlBjYBguxZjhI9lDDN1P1ynynylff3A50BUCv1W8jxNv3W0gVKFyC5Frqq0G67e1Q7f9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555939; c=relaxed/simple;
	bh=buHusqYd6xOZ2VuYaXumn9Po/WHMJWeOhlDVrDcgibI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P20ezYr9WB3sGqvon5Xk4ELZT4FdF4PdgXlc4lyptR48O8Po5O0k6oetbEstf1zuARuH3RCI99o/bSssMPimghXniFoooAMM78iLzS6yb9pqsvpDmLHYBaPh8EAqPKoabFmpnNEXJ/3WlfRFICpc5VxxeAyt9CXMZraRqqZTWf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SRBYHvRe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SNA4eEGa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKIZtS018131;
	Wed, 18 Dec 2024 21:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qANF2k6fqNPZNY26Hk4syrqLin6jSQ9qXLg3PayeooI=; b=
	SRBYHvRe+iOIYWND9jB30FSNPPy6m6KJ3WX04AXhpzCwoIjKVh+l1P/qfxvSFwl0
	dKAPd468pZVVWfzDsz9blb7gAwuOjiIlQxe8IegxO4VfiraMIdapSNlpk7g8zevR
	SgIabnZB+QBgzQEvXcwa8RYroduT/rnvLo15YrI+OnIrJz/RgP/gMG1XpRajO6SE
	Wayom0kctiNpNP0sLRoU8bbg0HLv4nnR3nNXdIEtTxxRR5BN5Tj2BzV/+Fzbd4vq
	V5KqJiCv/0sy3PVnJYSd56dSTcIyM18E84PYS0hxLJf+2snR403Ek/+eMXXQvJDe
	znMldE9JM5sNgOyytR/tWQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec9kf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 21:05:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIKJK4e011752;
	Wed, 18 Dec 2024 21:05:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fa7e86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 21:05:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sE5KnIjdUbRx/g2KfNTsR4QTLmMbaM9JLeQZMFfw1ZKzXee++RQ0qaJubupVeMBARSdI6TqMKN/Vntyzm6JXr31EyNPhET47UtH4rYxFN1WGXgcHqXebRW8Oigm3gIG2xa8knNlaCEgAH7VG36UVRPMOMN+gOihyv+xejAeBZ3anvs2ner7E0E9MhOH7e8RAaBDj17mbxBwPtX9/yyaUxy3dVdA8d0D/o7kxceIpOFsDFYByFgufCkyId6LOCKMljQnNFjrC13g2hnR9IoJFTtOB16hVV4KD6okuz+1l4BRbQHzXghHWEtgU9g3db4FoB5mdEHmNkECes5T6FmG+kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qANF2k6fqNPZNY26Hk4syrqLin6jSQ9qXLg3PayeooI=;
 b=oNxu4G+QP0ownNFFQW3EWfswY4Q67yHVyL4dnNcufMiADy9twOm8nENWj89qD6qgN6Uj+JJ+LTV9kVyAjmITSwfBTkzxUB+zHW+c0y7LbXS/W3PliJg+Xx54OWNYHRHD+AhcnqAXDRe1rBRrN4K1utMJotZjxttAsDKpxAo0sh1rFReKu/YLGq6xTgA3N3LgU0HaGOcmsFA70OS3HIQVaPHvo2yCtbRaSvAAOCHr/kdcttIoZT/Gi8ZS6ILAat6XXCOE3cl9T7axEW2A3qPaik60wB9OIl3Ncnd0oUILzF5iE2KbKix9KsBrwjlFhpdcbajWA8OHyoZ1QQspS8jHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qANF2k6fqNPZNY26Hk4syrqLin6jSQ9qXLg3PayeooI=;
 b=SNA4eEGaslUfBDxi8BFlQ3PBbu/yBK3om/tYrW5oVjsDarbo9I3bfwgIxho8NzCtagWmUI/vGIowZ+2rD8pnsq5FEjJbAaEemslK7pzERQOxIQ84+w75tJHroyCieAFzatx77CJfNBc/SEHqcsPen/vpbBEf1dxCI2M3AeuR548=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB5746.namprd10.prod.outlook.com (2603:10b6:510:126::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 21:05:25 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8272.005; Wed, 18 Dec 2024
 21:05:24 +0000
Message-ID: <23bc5e70-9d7a-4185-9645-0ba89cd43de0@oracle.com>
Date: Wed, 18 Dec 2024 16:05:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [for-6.13 PATCH v3 00/14] nfs/nfsd: improvements for LOCALIO
To: Anna Schumaker <anna.schumaker@oracle.com>,
        Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org
References: <20241116014106.25456-1-snitzer@kernel.org>
 <754757a44ac96f894c82338ec3212cf7202d540a.camel@kernel.org>
 <Z0E-e7p5FtWWVKeV@kernel.org> <Z2MG3X_PpbJRNzCw@kernel.org>
 <f0d7f601-a6ac-40d6-9665-e9a40e2dc00c@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f0d7f601-a6ac-40d6-9665-e9a40e2dc00c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:610:53::26) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e7ceb3-0f00-4ff1-c6d7-08dd1fa7b115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHlRdDlVejJNWFF2TU1seW1FOG1aSlgyYjNvb01BWkc4ZVJMVWF5UTVsN3hz?=
 =?utf-8?B?SmxNM2FCdGRVTWRwTTVXSnY1aXU4V3BIVkhqMXlIZnVYdlNyYmdpd0YzZyt4?=
 =?utf-8?B?aDBId01MVVYvbFpsTGNGbk5QN0dtSC9aRVR1Wnh6Tzk5QjgwbkNFOXBaS05Z?=
 =?utf-8?B?VUlOQU13VUFtS08yVE16WGZlYU82ckdlMzUvREtEV25CY1hCM0xpUXE2U0NX?=
 =?utf-8?B?SGcvdkxCRnFrcmIyeXlHd21IZHBQMllUR0VGS2xxc2tlcUxwZEl4NFNjWnU5?=
 =?utf-8?B?TDE0N1Y0UVJVV1NLSDhXcFBhcnpNU1c2SWJzNmRVWjdqYnR1MTEyWHVRS0dm?=
 =?utf-8?B?dE1jNlBmZElxeDIxUWMwOGNlMURoVVN1Vld0MHczcjI0RG5KcVhRNzY4UWNR?=
 =?utf-8?B?UzdtdTJGQTNGQmlxZWhuV2hGWjNKeTAvUjhtdm1GckZucllIRjRoYlRCVEJq?=
 =?utf-8?B?dlh0NHVGaEZ6V0QvLzJSL2s1V3RmR2NYTUowUHF5dTBCNjg0SWFLQmp1UWNT?=
 =?utf-8?B?NUV1YXh2Kzg0R3dxNldIbmczeDFiZmNQTFpocUJPU0dKaGxUQTVHZ282RThi?=
 =?utf-8?B?NjgwaHFEYXlSWFNuSndvQ0l0bXFSR2p0WmtWTVF1ME5vWUFqQlA2dW9EYkFx?=
 =?utf-8?B?a08yNEtSQWFpYlhmeWs4VGhKbmpPS0FKczN0c3prUHFjcGE0dGJrUTVxN3h2?=
 =?utf-8?B?RldlRkVNeVRwdDE4STcrd2h4ZU5Xc0dVZy90c3pZSVlONXQ3MmdQOUVRalZo?=
 =?utf-8?B?QkJHbGdwUW5ldXlzaERwdXNuSm9EekVEZUtTb2hIUjZnMTYvTU9qL0FqZlc0?=
 =?utf-8?B?QjYxbE01Z0dCK0FwNXJENVZMU2lEWVhONVZzUWhUakN0bG5BdWtHaDdmclB4?=
 =?utf-8?B?NS9paVAvOXYxOFpzM29XdzQ5c1QzSU5IVnVpSHdpbmduNXplZTkyanhVK1Vw?=
 =?utf-8?B?bU1rSnlxTVRraEFJR0tJRkZlT1FtUkF6aHRTZHhvc3pVMFFOS2hwWGZMajFT?=
 =?utf-8?B?bEYwVUExNVRRYm9ib3VRckxiMnlpSjBMRlkrd3M3WFVCN0tTMGhIcmpNQlNW?=
 =?utf-8?B?ZW80RlQ0RWdwTzJyQitiNHJTbUNpMXUxVGgrQ2pMYjk0V3VtY0orU015QlFr?=
 =?utf-8?B?WVhVWGZ5bG5DcUQ5c0s1OU1ZMGMyZkVBN0o5RXc4cWRQMisyNC8wTFZrR2ZS?=
 =?utf-8?B?QzA3SlcwNWxoSGdKMm1sTXJVRzg0SmE4ak8xTWFQejR2WDk5dDVmL255bkF1?=
 =?utf-8?B?WmZhWGVhSlY1YWc3Q0p5aHJrd1FnNHJ4ditkbVFyRFJ5OTJLc3NBOG1BZ2NC?=
 =?utf-8?B?c2h6amtoYnU2N0JDNmZKQW45dlgwbkhFQkhrbEkvdUc2ODVqTXdTcm1xZFBp?=
 =?utf-8?B?WmpBd3NFTi9tdC9UaEI1OWgwUEc3UWo5ZHl1SkV2M2tyVytBZllndjlRYjNE?=
 =?utf-8?B?UE1FTllLQXJCMk01Zi9LOHJHbG1EcVRaOUVrYzFEVjRteUd6elJyZjZEb0g2?=
 =?utf-8?B?ZUFkU1RzWm84cHFBbW5hS05FdElUeVpTYVRkajd6SE4ybkpqRERoN1l0L2lG?=
 =?utf-8?B?QzFtQlJxUjFHclVmMXlZZHhSakJsQUlRS2RLTkVUN3NoMTZQRENtYW9ZTWVz?=
 =?utf-8?B?OVZLc1BXb0Jtb1VDbDVqOTNhQlhJVFdWU1lXSkN0YnBwNVdYZ2owdkdVaDN6?=
 =?utf-8?B?U0NsSGJDUXU4QTRtRC9TTXMwRTh4N1lOSmNaUk1UV2ZEcUtPLzQzNWpzN2ZU?=
 =?utf-8?B?SDViZWkzYTdnRC85a2tNMzNwVDFaVEE2RnJPZDJ4TC8rdEF2RFVmVEh0RUkv?=
 =?utf-8?B?VVBaWks1TiswcG40a2FXaVF6YXBmL05SZnNSOER6NFUxeFlMWXErR0ZTcUJj?=
 =?utf-8?Q?WFhLOWZQJMNyO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTZ5RkgwTlYvV2h5NVZQSitJK0VTdVlrMXhTZFloYzhQbktXYWJyc3JJRXVO?=
 =?utf-8?B?ekdCeGI4L0VsWlJ3TE5UbE9adUJnTGR2ai9sNElLRithUFNqbUdHRk9Zcm9M?=
 =?utf-8?B?T3U5cGVienpBQkdKT2FNZHRDS053aS83ZnJrQllKNTFkYU5rTW1XVGdvVnRN?=
 =?utf-8?B?ZXhUQUFNYnZ0TlBLT2JwaCtienFJaEF5dEVpRTVScGgvejFxdnlOYkRNNEhN?=
 =?utf-8?B?UW5DdWxXeVNkRUpHblpjdkJ5QkRMc21kRm8xc3dPWm5mZnA5WWQxVGxuUlQ4?=
 =?utf-8?B?U2NROHd2aEhES3Y5M0Y1MTlhNHBMK3pyRHIvcjA3MWZESFk5cEpnRjhOc2FT?=
 =?utf-8?B?NXZUK0ZzUEtnMkJuYXZkZDVZZVBmUHdwekR3K2QwVGFzZFVpS21wbnkvSzBO?=
 =?utf-8?B?czFhM21YS2dGR3I1RGIrRDU4ZFpQSEh1UzcvN0dqVGxzSGsxMnZTNXlPVklK?=
 =?utf-8?B?dzRjL0RYa0ZXYXZWZjd4U3ZEa2drVkpJeUZ0eWlEajVaL2hWV3ZFU28zZTcx?=
 =?utf-8?B?ZS9OZmtGTVozdnllaWxYZ1VCbGhzTFJ5bHhISldoTU5jUnZkRWNCMURBRnQ1?=
 =?utf-8?B?bWJrWmVNUWo5bHhENHErUExUS2xMNGIxSVhOWHNmclZkbkptV3JsdloyTHJh?=
 =?utf-8?B?aW1RNWU0NStzTkFKTVRtM3JianZOMFZpMlBSOXVUekxjVEdtK0RsTDJPV0Fz?=
 =?utf-8?B?TklZRkNPbEkxYWpoQWhSS2RBUldOSDZWZ3ByZ2YzczNHeUlCMkpxUkFnbURD?=
 =?utf-8?B?aGRKREJKc250NlBUUmF4R3h5RmRJS2M0bVdpaDU4bEJacmowcEJtZlhWTE5m?=
 =?utf-8?B?SmVLNncyK2UvaWdTUm5HRGxadTVwckRlT3BpSHVPS1N6dmpIZ3U2TmsyRVpI?=
 =?utf-8?B?RlVVNzBYcnAvMkl4ZVJMSFpNd1M4NjJaOEk3b3NLL2dTaGNDdnlOelJINFZr?=
 =?utf-8?B?NFRhSExqVjVPdGF6UnhGaUxlWTZaU0hHRzdrZ0d5NGF2SFhNR3BocDY2NFd5?=
 =?utf-8?B?bm45TkpNWnhxM2tvaWp3SWlBdlptNjU3SzcrTHR6dDY2L0lobVhEUlZmTHFU?=
 =?utf-8?B?ZXk0ci90VE9NdjJVOVRkRGEwNEFmZExIaHQrQysxMkNtTFhHbWRyaWZwUkdG?=
 =?utf-8?B?ek4wdEp3eXJKL1JUSUpCQTV2bmZ3cytKSWZ3NDdKWWdYdzM2MXJzYWJ0cE0z?=
 =?utf-8?B?akd2YVVrTmRCZ3Y4ckkzeTVmTnp0UFBJTk9QQ3ZkYTN0VC9NUU5GeEVZSkd6?=
 =?utf-8?B?TU5TTUhBM0hhL2J5OEJIWXJKQXUrdDVZVm1HcXVJSmp1VHpwQzFVYVhoRWRl?=
 =?utf-8?B?VlVKY2hNQUVJL0NWRTl0Q2IyVUNYa3I1dWpnREZRUkZxMjVZNitQQWUwOWp1?=
 =?utf-8?B?ZXEzT3Y3bURSaUpvRFVZMG1vRlFLYm1aRWVkT1RnUVRuYjlCWWRhcFptZzRl?=
 =?utf-8?B?VHJKWlN1anBQQlFBeXA0MHpwQTRLL3NvMXJwVHZ4MHI5UXNyK095Z05pZ2Rw?=
 =?utf-8?B?d1VHSENmMDNuNzB0RWVxVURBQzJnQlZ2MVRWKzVwby9jR2orRnRYWHViM2M5?=
 =?utf-8?B?NFhRUGJHcTEzV3FBTkNEaUQwTmtpSEV0cDRlTHE2Sk9KRnpuODNPclB0TDVj?=
 =?utf-8?B?QlppSDNSQXpBOXJVcTkvVUtuc0dLS3h0K1pMVGEvbXVYKzNsQVc0b1Nwcmhw?=
 =?utf-8?B?KzBrUFEzbHhGanBSWE9INUJxdzFUMUZMS016ME1WUG9NVnlub3FnZ1kwbVd4?=
 =?utf-8?B?bkRmTWR0cDZ3cDcwbkl5dDVIa0R6RWpWUDZPVGlla2ZQNURxc24rV25pVlZT?=
 =?utf-8?B?UWxtTmtSQUJmOElrZ2RxWFh4b2pBZFVJVDNSbHpZSE4vMGJXOGh1dTk2T0NN?=
 =?utf-8?B?M25XVHRNSFV5TXJFNmdFMUM5SGJlSm1mT3dFbWZieWhUaUNMUmVIQ3E5Vmhm?=
 =?utf-8?B?MFJsb0xVcUh1b2E4NEx5SkFBdkhJRzRkMGhBK0Fxa2xsTGNPV3NJNC9Ycmo5?=
 =?utf-8?B?bFRFNG1CSnF3NTBtYUVRUldsZFM3emRzbE9SekRSV0xwNTNrNXEyRU9nMEty?=
 =?utf-8?B?RS8xSUJoUnYvU2pzb09lZ2tFVUhJYWZGbDZ3aXZGZmVFbURScjBGeGdYZDho?=
 =?utf-8?B?SEl5V05sNXNLeUUra0hJSk9IU2lxeFlIR014NWFHSVhRRTA4NzlBVXZjTkZJ?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AI+PRFrrUccoX68O9KKVGUaFaWPgu0JG5rnYfA7mllxdeATFfLLz2rv84TtAzkEI4zcg/dA3/hRzQ+LNnneB+Aq79jGkthdrG65h8ir9czT6M7xIuNdIFS4FafX+viGAIhahQHj6lKItWVCl1DiC8fITUDviA74W7MrtWdbiTUFzZCqd2Q8vG5UfK4HVz7OsSWrTL0Wyf8zHeN1zBGDaqwyE6GLfyOHY+wRhOO4ZxQaOKAR5S6/7Mu+yJQVHUGtVnsJa1xQevXPmjentMTResF7JOtuuQaX7JhIsOoRVajJdHsm2j476BHU1VgBAc4Nio1ZhW+Pu8mSSRiTbMKowQklcqk6PmOmOxFk0Ph+VcuRR+V1GD6cQ2yKMOafZ2FJ9Cgt+B1PjC/EVZz4mj+OYiyGzMCj7qj2H0B6n3yHsyeWxkgYl61N7FeNxMMU9inHkZs59+sbckt9uFCF6VcaOizb2PYZzE4HnBBfGBKYoPN3Fhz+dw8mVpIN376NUb+EyuyA+1gxHqJz/bc0+Y85vl/V8NYNMVg46WHYyAbsZmQsnKvmOlDuXMS0OpRNlZzJBETdySpbDVZFP9MiT0qJO+0t4PC4sjoLX1Q/bBEa0nuk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e7ceb3-0f00-4ff1-c6d7-08dd1fa7b115
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 21:05:24.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvGFUIG1JCuZFHKooz5j8rM5Mp2cSgMB/sURcz29q4XPCMbj6qYAjU7L9in6lDnb7fpOJ89fAUOCYbP4p0U5NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5746
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_07,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412180164
X-Proofpoint-GUID: V4zS99DdGU9IHNEitzkosHyod_PV6Rv6
X-Proofpoint-ORIG-GUID: V4zS99DdGU9IHNEitzkosHyod_PV6Rv6

On 12/18/24 3:55 PM, Anna Schumaker wrote:
> 
> 
> On 12/18/24 12:31 PM, Mike Snitzer wrote:
>> On Fri, Nov 22, 2024 at 09:31:23PM -0500, Mike Snitzer wrote:
>>> On Fri, Nov 22, 2024 at 12:26:39PM -0500, Jeff Layton wrote:
>>>> On Fri, 2024-11-15 at 20:40 -0500, Mike Snitzer wrote:
>>>>> Hi,
>>>>>
>>>>> All available here:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next
>>>>>
>>>>> Changes since v2:
>>>>> - switched from rcu_assign_pointer to RCU_INIT_POINTER when setting to
>>>>>    NULL.
>>>>> - removed some unnecessary #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>>>>> - revised the NFS v3 probe patch to use a new nfsv3.ko modparam
>>>>>    'nfs3_localio_probe_throttle' to control if NFSv3 will probe for
>>>>>    LOCALIO. Avoids use of NFS_CS_LOCAL_IO and will probe every
>>>>>    'nfs3_localio_probe_throttle' IO requests (defaults to 0, disabled).
>>>>> - added "Module Parameters" section to localio.rst
>>>>>
>>>>> All review appreciated, thanks.
>>>>> Mike
>>>>>
>>>>> Mike Snitzer (14):
>>>>>    nfs/localio: add direct IO enablement with sync and async IO support
>>>>>    nfsd: add nfsd_file_{get,put} to 'nfs_to' nfsd_localio_operations
>>>>>    nfs_common: rename functions that invalidate LOCALIO nfs_clients
>>>>>    nfs_common: move localio_lock to new lock member of nfs_uuid_t
>>>>>    nfs: cache all open LOCALIO nfsd_file(s) in client
>>>>>    nfsd: update percpu_ref to manage references on nfsd_net
>>>>>    nfsd: rename nfsd_serv_ prefixed methods and variables with nfsd_net_
>>>>>    nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
>>>>>    nfs_common: rename nfslocalio nfs_uuid_lock to nfs_uuids_lock
>>>>>    nfs_common: track all open nfsd_files per LOCALIO nfs_client
>>>>>    nfs_common: add nfs_localio trace events
>>>>>    nfs/localio: remove redundant code and simplify LOCALIO enablement
>>>>>    nfs: probe for LOCALIO when v4 client reconnects to server
>>>>>    nfs: probe for LOCALIO when v3 client reconnects to server
>>>>>
>>>>>   Documentation/filesystems/nfs/localio.rst |  98 +++++----
>>>>>   fs/nfs/client.c                           |   6 +-
>>>>>   fs/nfs/direct.c                           |   1 +
>>>>>   fs/nfs/flexfilelayout/flexfilelayout.c    |  25 +--
>>>>>   fs/nfs/flexfilelayout/flexfilelayout.h    |   1 +
>>>>>   fs/nfs/inode.c                            |   3 +
>>>>>   fs/nfs/internal.h                         |   9 +-
>>>>>   fs/nfs/localio.c                          | 232 +++++++++++++++-----
>>>>>   fs/nfs/nfs3proc.c                         |  46 +++-
>>>>>   fs/nfs/nfs4state.c                        |   1 +
>>>>>   fs/nfs/nfstrace.h                         |  32 ---
>>>>>   fs/nfs/pagelist.c                         |   5 +-
>>>>>   fs/nfs/write.c                            |   3 +-
>>>>>   fs/nfs_common/Makefile                    |   3 +-
>>>>>   fs/nfs_common/localio_trace.c             |  10 +
>>>>>   fs/nfs_common/localio_trace.h             |  56 +++++
>>>>>   fs/nfs_common/nfslocalio.c                | 250 +++++++++++++++++-----
>>>>>   fs/nfsd/filecache.c                       |  20 +-
>>>>>   fs/nfsd/localio.c                         |   9 +-
>>>>>   fs/nfsd/netns.h                           |  12 +-
>>>>>   fs/nfsd/nfsctl.c                          |   6 +-
>>>>>   fs/nfsd/nfssvc.c                          |  40 ++--
>>>>>   include/linux/nfs_fs.h                    |  22 +-
>>>>>   include/linux/nfs_fs_sb.h                 |   3 +-
>>>>>   include/linux/nfs_xdr.h                   |   1 +
>>>>>   include/linux/nfslocalio.h                |  48 +++--
>>>>>   26 files changed, 674 insertions(+), 268 deletions(-)
>>>>>   create mode 100644 fs/nfs_common/localio_trace.c
>>>>>   create mode 100644 fs/nfs_common/localio_trace.h
>>>>>
>>>>
>>>> I went through the set and it looks mostly sane to me. The one concern
>>>> I have is that you have the client set up to start caching nfsd files
>>>> before there is a mechanism to call it and ask them to return them. You
>>>> might see some weird behavior there on a bisect, but it looks like it
>>>> all gets resolved in the end.
>>>
>>> Yeah, couldn't see a better way to atomically pivot to the new disable
>>> functionality without it needing to be a large muddled patch.
>>>
>>> Shouldn't be bad even if someone did bisect, its only the server being
>>> restarted during LOCALIO that could see issues (unlikely thing for
>>> someone to be testing for specifically with a bisect).
>>>
>>>> How do you intend for this to go in? Since most of this is client side,
>>>> will this be going in via Trond/Anna's tree?
>>>
>>> Yes, likely easiest to have it go through Trond/Anna's tree.  Trond
>>> did have it in his testing tree, maybe your Reviewed-by helps it all
>>> land.
>>>
>>>> You can add:
>>>>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>
>>> Thanks,
>>> Mike
>>>
>>
>> Hi all,
>>
>> These LOCALIO changes didn't land for 6.13 merge, please advise on if
>> we might get these changes staged for 6.14 now-ish.
> 
> Works for me.
> 
>>
>> Trond and/or Anna, do you feel comfortable picking this series up
>> (nfsd cachnges too) or would you like to see any changes before that
>> is possible?
> 
> I'll go through the patches once more, but they should be fine. I will need Acked-by's for the NFSD bits from Chuck or Jeff.

Looks like Jeff gave his Reviewed-by for the series already.

I had asked for some minor changes, haven't seen them go by, but, for
the NFSD-related hunks:

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

