Return-Path: <linux-nfs+bounces-9882-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6143DA292B8
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 16:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A670216CC81
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE5D1953A2;
	Wed,  5 Feb 2025 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mE/GyO4t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AIyWMWlz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BEC193404;
	Wed,  5 Feb 2025 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767392; cv=fail; b=cvmx+h03e3AR+m6HLVO1i8WVSnFIHhI9qQ/dCtw3z2svDT8793aJfZWKAX3XIEBgCHgeN0eRg67uyTzzvca2yWPiLL+Bank70GbTqUCbrE77hCv/Nx77AAUCmlwmFAjfmDZctEwFc9llwhMl+g4UOr/OVf2Af1xmD6CpRszvL3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767392; c=relaxed/simple;
	bh=Tz+brzsTf0w1yTNj9oD1Rb3aIkwsuDSygaS04MGFYmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nVxB/so6Pf+LdzRBIsF3+ODJ7qUJs33pcRmuGp7JeBxyPqMPy7fgXEX7xvDrbb7+nxgSuLGsDFtiF1REkM1ik1gNd9KFzWbkCKoPPqIttYkyJtmLzzW0AfVPwPwxBmzpsmd4GRbRK3t4jSWifsq5nKRIIcFGC+I2GLIJoevdklw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mE/GyO4t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AIyWMWlz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515DRRFn012754;
	Wed, 5 Feb 2025 14:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9AMKrPb15BAVE60CzYBabFC+aMpFnpNTSPNKJJv8msQ=; b=
	mE/GyO4tcDZsh5FBF9ZSb1GiHrgHhugWmOlgnBk0IaO1qau9BhUFmTQTJaLCQtli
	kHQ7+xwZWyXGNNuhg9+W0ezGuDiYJvSUyHc1NUCEkmOIUrRxjdPHMCiG2OUSco5a
	L8EB49fgbIdOGqLWquNd8Os7bwQwgsZKX6jLXEh/qKbTZMh8XSVo9VE+Rkysdivw
	zOixy0LXTVIxj98CAQ72mMYvNLPIZAYoZz5JRykZgArgCgUY9nslkp8REiVZS9dv
	OpJ79OrgWZpXp0s4M+g1oW56xQdWd0QOkDwX3prN3q96v7jgB0+02Nrir5g2Shqq
	+Enf+tSBv9vGT8g2QkE+Ig==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4tgns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 14:56:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 515EnXZo027158;
	Wed, 5 Feb 2025 14:56:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fnp539-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2025 14:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBrwGttD5OjB6iU/j3+aFDwPQHesn98B7L1mlQzdtgrz7f2TeaecFYowMtAWwvSwESoIt/Yl+bvVM97JMsdbkJBPulK7azMj3QhQtFfX1GwxNLpGVthV9Dt71c65F4U2U1ZetJ0Kf5f3zZGnD/TfL+4fKmmDbynSyirtT1UEdjBZ75u/rpNnMwW+1PYzHxIrfjWkLbF43mdtzaQ9Uhv/qcda9nXtYTP64Q6T4AQhuPaYtAhrsVAk0ikabyTTLBRPBsanWh20D07TM7VXgjUwyJnyEbDeTduBDscpexAZbRyQJifuqGAqXSwj+e0z2yZPHgGQVdSY8sp6PrqXgtz/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AMKrPb15BAVE60CzYBabFC+aMpFnpNTSPNKJJv8msQ=;
 b=aJBw7pYzv81ECGBb5ctKIY9Ltr3knj38s7xoKSWrK58JkX2khjTDJFVDnGMnhaswoyBMjE4gXECGzDIYCVXJEv6jMSw0wdAcj3t3hrl1BlOX+pOzrV0eNIo1hyOevKSuk5OWx8ds1fSCiaII44D6ltlsOKcq8TVW1r4qxd/rK/DtHxFNaK3XZnA6xlE3bBg3nKPRkB5mBbY8MwJgneqyKHChu8xNngqvA6Tdz6kIlz95T8RhvwwlujXp8PtlDkglq9IEos6VYFtowTIXLoFdHOlDLquRRGrDRd2EO+YvNn380GPvbMq0Mx6q+saDY6hdhgB8N2z/xTIRetj+S+fMTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AMKrPb15BAVE60CzYBabFC+aMpFnpNTSPNKJJv8msQ=;
 b=AIyWMWlzbHxIMYAzSpJ1Gp6w6hSxYdW0mOV/oEJGjBPLhw7w06ixImLlIvapWRnYkibtFar8SdU53IvV9sSI1LZTFK/v5I67h4N6rxpVQv6MPwnBIP00BqsjiL9h2pWzsXzJFesi3UvecQPAqbPjNn5vPuiMv4YAcK5rbpyELd4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4978.namprd10.prod.outlook.com (2603:10b6:208:30e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 14:56:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 14:56:16 +0000
Message-ID: <f5bcf44a-822d-40bd-8e1c-19bafe9ea5d0@oracle.com>
Date: Wed, 5 Feb 2025 09:56:14 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc: make rpc_restart_call() and
 rpc_restart_call_prepare() void return
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250205-sunrpc-6-15-v1-1-57c723b72214@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250205-sunrpc-6-15-v1-1-57c723b72214@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:610:50::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BLAPR10MB4978:EE_
X-MS-Office365-Filtering-Correlation-Id: 628dd7e1-3be6-4a31-b1e2-08dd45f53db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTM1c2lEWk9lWXh6Q1EvLzY0Sitla2xzVk4wV28wZW9ZZDRxaXp3Tm1zQUJ1?=
 =?utf-8?B?WXhRZGdjTE1oUXhUTWU5Zm9HaGwrVTlQQ1lSTk9vamZXNkJMdDcxQkorU3JL?=
 =?utf-8?B?MUxwTDMxa250QmRlcU5JU2Z2TXBDeUdUaVdQRTFJQytoNzgvV0N3aWJRZnk4?=
 =?utf-8?B?Q29SQ2pta3pBREFxYkhYV3VlS1lvTXRzYk5iWUJXMy85K29WbWRLVHREeExM?=
 =?utf-8?B?dnVBTXFsaVRNWGNrMndsanBJM0JIcUZ4YnJCenJpdUM3SCs4dzFVWGdBMG1U?=
 =?utf-8?B?ZHNOOHRpOWZqL2xJR0dvSk5OQy9ZT284NEtQM3ZWYktWaE50cVQ3aWlQZ3Bh?=
 =?utf-8?B?NnEvSmRaYSs0Wjc0SWM0TU9TVXpubHdHZTZhSGJLdzFRaytkSGhWTjlWMjl4?=
 =?utf-8?B?MktDVDEvbXZUeTc1cXo4MDF1UEc0YjhubG1sUlgyZFdmUitESFJzcVU3QWVl?=
 =?utf-8?B?OWZwdThvRTRzZTJScDZ5amMxaFo4REJjZllYY2pTeTR0NUVKZytUbHBXQ1cr?=
 =?utf-8?B?MmFoS0NhZlZnNGhlbjA3aFdidEV4VzBhMHlVTHFxWWxUbjVDY244NmR0ak5a?=
 =?utf-8?B?aVEzbTk5YnFMY21xZXhvL0d3RVcrblppQWRGaWpPUXE5cjRCM0FYOTN5dHlD?=
 =?utf-8?B?KzFsTHZaYXZ3ZVZnRS9heTFxWk5iY0Z5eG5CWmY0SE9qR1ZaUlo4Ky8zbXhF?=
 =?utf-8?B?cVBSb3I5ZGpYSy9Cc2tGUTBSNmZGazA4c3JDblRnZGp3LzVVNGxGRHhpUklP?=
 =?utf-8?B?cngwUmdsOFJ0N3M5Z01IbFJNRkUyckZwU0hsc3NQVEs3VFcwN3d3eUI4U21p?=
 =?utf-8?B?dzMvR0g3MGt4RlNsOU5zVDR6NmVkS0EwZm1vTEg0cXlYQzg1UExFWGk2NElk?=
 =?utf-8?B?elBKUTF1aFJwYTBXVWZlS0RQbFNIaWdWWWJoa3pDZDdRb2lXZU1KanBhV1dr?=
 =?utf-8?B?V1ZtTW5MWmNaQmFzcDVReHJsVUxCY1VQREt4QnRnSXpwZEtDUXBIM3BDUEph?=
 =?utf-8?B?UjdhTHhwM0ZVNWRoaXZRamxVamV2bG9DT0tBY3RMZTNGK1hyVzBienhJWjRX?=
 =?utf-8?B?eEk0eGRzZ2o2Zm1kTm1laWlGL29wTHV4TXRDdTVZNUE0SktTQ2lseWtGSDly?=
 =?utf-8?B?NkNlbVBjdEZzMENjVS9XMThueWtSa0lBaDN5ajVxTUxMQlJiMEZjR3lsaFRW?=
 =?utf-8?B?UjAvM2owdzFOZjcxOTA0dDVRZzNaS0JwYnBuV1VLY0wvbWw3aS9PSkVydEZL?=
 =?utf-8?B?NGsvYlJsWk0rYmJ1d2xtYzhKQTlScWFBU2M4RUVYeDBjZytNcXVtTzc1TG0x?=
 =?utf-8?B?aEdlbHNnbndkbTJOSExpUlh6RWhVVkFrUWQ4WkxoZHRzcEViZDdCYUg0RUFS?=
 =?utf-8?B?a3JVTUgxVHg5Ulk3aXA5azBDcldtTmlLNUpObkttUWhnNzJYRWxzdzJJL1Mr?=
 =?utf-8?B?b01ibWNXTU5GTnBjR244dzZKYVRCS052TTQ1T0YwRFhGTm1qQVJWNzBFRFVm?=
 =?utf-8?B?aEtJM1lpWW9SeGRIdGQzdkxjUFlWTHRpbFdoZFk4b2ZrZkM1SE5OZStUS1RM?=
 =?utf-8?B?U05tT2FkWDlTQ1NJSWp3QUdhSFVoVnlaZVdJZ1BEZXlIS05SY0oydkJKVU5Z?=
 =?utf-8?B?Z0wxY255SnBiUUxlNVB3d093WWdpc2kyWkJyazlhcHk0WFBBWHFJRTg3a3lt?=
 =?utf-8?B?OFM0RlBwTkF3cS9iNG1xNHBmT2w0RzVpWFYzUVRncWlQVDNCaEw2RjZLbC9T?=
 =?utf-8?B?a3BnWm5LYVhWT050UW5aRW95U3RJT29sTUpaZXFyZVErT1pSSkwrd3h2ZTRs?=
 =?utf-8?B?eHdvbGZLZmVhc1FPN1VrMnBydEYvRDhnVWdRaEtNU0xubXljN0padG1xV2lR?=
 =?utf-8?Q?oQFhxM0uYefaT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3Z6Y3lScTVVdjZUeWlhZXlYRThERUh4WnJaWXcrNGdmcHg1VGxmWVNqSTFF?=
 =?utf-8?B?Y29mUjZiRmxJT3QrZVRtV0NGK00vYmRkcktwdUJtOXFwQ092YVVPSERSRTdz?=
 =?utf-8?B?QnM3cXBBTVk5dVdiMlJIUU11QTRXWWtVd1J5aG1NVW5lajdGeHY3L1V6V2pJ?=
 =?utf-8?B?L3NOTEhLenB1UTBUMFlGbkRMRDVBT216WXFvMU9LdzNVU0l3eU9yUy9LMHFS?=
 =?utf-8?B?NlA4QXNvU1VEaE5GRVgxT2hNSkk1bWc1R0h4ZDhmSUE5UG9LMlord0QrVVVk?=
 =?utf-8?B?aVg1Uk1VcEdGMUlCbkRVUC9Tci9GSWNsUzAwUldOenFURWJOcnRNWDFISW1y?=
 =?utf-8?B?NFR1bFhwQ1pvTUR1YitaWjlBSkNoU0QvRzVuYXJKQ2RlNlZuMnhmYXIxcHli?=
 =?utf-8?B?dTB4S2pucFgwWXF2U201bU9LWmhCMmk0QmZBUWNQYkFyaWZnNjVYRzBFRnZn?=
 =?utf-8?B?V1RNbmJlU0FGSGtrTzg1NzBhNUlPaWVOeVh6Z3hEb0daTzZZb1FSalFCNTJ5?=
 =?utf-8?B?a0d0eFF1aTFvUi9waWdxaHgzbEJsaGczOXdCRXJicGIySkhyOHNaMGNpMFRP?=
 =?utf-8?B?NndzTnFqK0xWTjgyT3FpMVJxdXc0NExTdWE5ZTIzRC93a3dseHdaTTY2YWdw?=
 =?utf-8?B?YUtJKy9TUWVkaGVpL2x1RG1oZkp3NWJSUEZ5d01td2Y3SHljYVRRL1d5OVlG?=
 =?utf-8?B?cFBYQUx0Vk84NWM2VXV0WWZucTBnTldjdUxpUEZ1aCtLeFBkNDNoeGVic1Nt?=
 =?utf-8?B?N3RuU2RONXVIZmo0T09QZU1MamFBVUFQa3pXSjBZS2tCRmd1MkFvejBNeCtw?=
 =?utf-8?B?bmovQjdOT3liUXBSRk9jcC9ZQURTVGFFQmM3UVlsWnFvRGwvejZZV0dXRDlH?=
 =?utf-8?B?L0RPN2JBaWhrbjFsVC9adytwU0U4Q3hrUzRMbmtCbExXcCt1c1RuUVgzb2Rx?=
 =?utf-8?B?REFxUllNM0FqQzNLcFJNc2ZqT1JPMzJmTkNLV1Vzc1UwL1c4Wm9qL3Ard0FZ?=
 =?utf-8?B?N1pncFRsR2JtZy96QmhkcGlWRjBzeUVmdHNBTVJhWENGSDVjOFhOVVVsNEgy?=
 =?utf-8?B?K0MzaVR0OG5ZN3ZvcmVhQ2VFVTgrOVZEb0Eya01aeFZZOHdQb3ZqcjFKZTlC?=
 =?utf-8?B?K25PcUJQeFRrdkRsYUpCUEZ5SklRbVRBQ2tXZkZrajNvNkpLYlRDN3cyVSto?=
 =?utf-8?B?MHZsRGVzWDFydVdmN05tbk1vK3FKSXREY3F3bWNrcEE0YjFJVWFoVy92ZnVY?=
 =?utf-8?B?M3Vsb2pmOU9SNGFsRTU0R3FHanI5ZjBoMnB4eEpiVWVXV0lVa00yU2Vxbyt1?=
 =?utf-8?B?WUhIQVdJWG43WDd5cDF1aXh0MzVBRER1WmUwUmlCYnpsOG5pbFFuM1VIcGJw?=
 =?utf-8?B?b01meEl3bS9zNHVPa0hqaGtmaWtPTndjVzhXT0VPSXVtZzAxdCsrYlI4eFJU?=
 =?utf-8?B?bXA1S3NBa1RqWmg3czlPeHRCd2JyWmtVNUx4a0k3R3F3dWU2cjJnUXZ2dmta?=
 =?utf-8?B?Y0h4SDBlUWY5SGphdENZaDFIN1VLZTk2VDFRYTNKRUI0dUprQmdMc3B5Mk1V?=
 =?utf-8?B?ejFGZmhSL3JDV0ZrQ0NnU0R6a0ZlNkl3RzV0TXR2cldScUdveEFHaVk5bTRJ?=
 =?utf-8?B?MmdvR2lZQjEzTGgwUlVaOFBjK3RLTE81SXphQnIrNTI2RmUzanhLd3h2OGdT?=
 =?utf-8?B?NzhwamdEeXEveFBZd2dsUXZScFphZWxrUkcyMXpmT0RzNjJYOEllWFc2dkFZ?=
 =?utf-8?B?Qm84cE56RDR3ckc5UmVtTDV4dno4VXRlR2NoOVc4cEtXR3djRXp5U21NM2dE?=
 =?utf-8?B?OTM2VUxZVGlCdmd0bzIvdkd4ZFNuQjlNWEhvMEh0U0tjcUR0ajlpTG0weEVK?=
 =?utf-8?B?SEFadzdUOUo4OXNtWStMUWFrQzhOL1JrR2NGVWFiMUtvMUhDOGtoeVU4U1J2?=
 =?utf-8?B?NkwvYzdZZ0hYZHhSRkZFRVJaV3BIbTVWSEswZk9aZ3NBZnFtS09YZ3dWY2hC?=
 =?utf-8?B?VEFaM0NTdi92UzRNS0FqTFR5SG9mWE5qZStGUDFoWHdiNHRwNjlBL3h3d3NF?=
 =?utf-8?B?ekI1djZMeVVodnk0WUkrOURHVUxGcWIvVlFvWEZhakdTNkNFVDR1aWRReTJp?=
 =?utf-8?B?bWNESFhkcThuRzkzWjJkcXNUYVZZTG4wL0xXMVRXSkdIRnRqWGlrYTR2SVVm?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z0iQDQg2bvQHFgv5WZaSCxlq9iJTPJ4q7tE9zoLu1McY1cSYegwILDXU7G9ox/RhsEqD8ZwoE9pOGdNSvopypvwcK3gpakHq7SjNzVuG3AgAlx5Zs1irj1Dk9hoCXRkK4vbJIYAXZ1fXMH0OyYzL6Zz8PThe8CIzeL9V8iQztcDcLD5BV2CYRv0QIs0AaDsJ2uRzZV9DwP/dsHbaYcCnUEKI9Yx82w4eyPHB7XNCbm1Sp11hkRatCAVa7MhcMIXjPHySY950IeDnaFCHwVQ5t/nrNU/MFiVGdz8srwCIBl9ieUnWC8O/ZX6HbRZEKOi3d8RDNbpHvhfVjJ4YSWQ0ArrehIrHd4KppM5H0/wVTXm56fwqypB1VUFRe5N2XmBwhthK0IrFtRUTX21WJhsQdQgOWdiz3mNRf0Q2CimjpfXq+ptNR20m4aeKwxwsrqNdehsPkZk6cgFkO4c76RRhEj4jbbYI39W1cJka9UuHZ7P+7kmkk5vyHQh7nrAyyTE6DRRk/r6z7UvKvE60kT388p/B57+HwgqUMqc6zdYU6IKVkI4s3/hf90V2kkAeT0syqvYSKiRgkwWdSBzp6oEgu9k8nt5yXhPdrhFnSgiS0fs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628dd7e1-3be6-4a31-b1e2-08dd45f53db9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 14:56:16.2476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2oLNHdNXb9C6acq1NDU9jgnF5hx/ymUefbFi/0mdaNzlkXkXTOxVlFzcSuUZHk724a6cnJClhadaNg8u6HzaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_06,2025-02-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050116
X-Proofpoint-GUID: gYPjH2tvzFQt_hdwVUWnzbN11mPAa2Lg
X-Proofpoint-ORIG-GUID: gYPjH2tvzFQt_hdwVUWnzbN11mPAa2Lg

On 2/5/25 8:58 AM, Jeff Layton wrote:
> These functions always return 1. Make them void return and fix up the
> places that check the return code.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/nfs4proc.c           | 12 +++++-------
>  fs/nfsd/nfs4callback.c      |  8 +++-----
>  include/linux/sunrpc/clnt.h |  4 ++--
>  net/sunrpc/clnt.c           |  7 +++----
>  4 files changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 405f17e6e0b45b26cebae06c5bbe932895af9a56..cda20bfeca56db1ef8c51e524d08908b93bfeba6 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -968,15 +968,13 @@ static int nfs41_sequence_process(struct rpc_task *task,
>  retry_new_seq:
>  	++slot->seq_nr;
>  retry_nowait:
> -	if (rpc_restart_call_prepare(task)) {
> -		nfs41_sequence_free_slot(res);
> -		task->tk_status = 0;
> -		ret = 0;
> -	}
> +	rpc_restart_call_prepare(task);
> +	nfs41_sequence_free_slot(res);
> +	task->tk_status = 0;
> +	ret = 0;
>  	goto out;
>  out_retry:
> -	if (!rpc_restart_call(task))
> -		goto out;
> +	rpc_restart_call(task);
>  	rpc_delay(task, NFS4_POLL_RETRY_MAX);
>  	return 0;
>  }
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index c083e539e898ba6593bc0d6185ccb8692aae6a95..b6d30111f7c85b0814ebd0821c4967574ca97e56 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1350,9 +1350,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  		goto need_restart;
>  	case -NFS4ERR_DELAY:
>  		cb->cb_seq_status = 1;
> -		if (!rpc_restart_call(task))
> -			goto out;
> -
> +		rpc_restart_call(task);
>  		rpc_delay(task, 2 * HZ);
>  		return false;
>  	case -NFS4ERR_BADSLOT:
> @@ -1374,8 +1372,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
>  out:
>  	return ret;
>  retry_nowait:
> -	if (rpc_restart_call_prepare(task))
> -		ret = false;
> +	rpc_restart_call_prepare(task);
> +	ret = false;
>  	goto out;
>  need_restart:
>  	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
> diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
> index 5321585c778fcc1fef0e0420cb481786c02a7aac..e56f15c97fa24c735090c21c51ef312bfd877cfd 100644
> --- a/include/linux/sunrpc/clnt.h
> +++ b/include/linux/sunrpc/clnt.h
> @@ -213,8 +213,8 @@ int		rpc_call_sync(struct rpc_clnt *clnt,
>  			      const struct rpc_message *msg, int flags);
>  struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *cred,
>  			       int flags);
> -int		rpc_restart_call_prepare(struct rpc_task *);
> -int		rpc_restart_call(struct rpc_task *);
> +void		rpc_restart_call_prepare(struct rpc_task *task);
> +void		rpc_restart_call(struct rpc_task *task);
>  void		rpc_setbufsize(struct rpc_clnt *, unsigned int, unsigned int);
>  struct net *	rpc_net_ns(struct rpc_clnt *);
>  size_t		rpc_max_payload(struct rpc_clnt *);
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index 0090162ee8c350568c91f1bcd951675ac3ae141c..3d2989120599ccee32e8827b1790d4be7d7a565a 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -1670,20 +1670,19 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
>  }
>  EXPORT_SYMBOL_GPL(rpc_force_rebind);
>  
> -static int
> +static void
>  __rpc_restart_call(struct rpc_task *task, void (*action)(struct rpc_task *))
>  {
>  	task->tk_status = 0;
>  	task->tk_rpc_status = 0;
>  	task->tk_action = action;
> -	return 1;
>  }
>  
>  /*
>   * Restart an (async) RPC call. Usually called from within the
>   * exit handler.
>   */
> -int
> +void
>  rpc_restart_call(struct rpc_task *task)
>  {
>  	return __rpc_restart_call(task, call_start);
> @@ -1694,7 +1693,7 @@ EXPORT_SYMBOL_GPL(rpc_restart_call);
>   * Restart an (async) RPC call from the call_prepare state.
>   * Usually called from within the exit handler.
>   */
> -int
> +void
>  rpc_restart_call_prepare(struct rpc_task *task)
>  {
>  	if (task->tk_ops->rpc_call_prepare != NULL)
> 
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250205-sunrpc-6-15-f19946041dfa
> 
> Best regards,

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

