Return-Path: <linux-nfs+bounces-8861-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C09FF4CE
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3B616164E
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 19:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8240E1E2307;
	Wed,  1 Jan 2025 19:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M6Lo52cz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YvtmSN1h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC526A33F
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jan 2025 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735759544; cv=fail; b=sp+846cNRQQW+eF+F8zweJh1kWH9i/AO3jeHLsWk2XxBAAtlb8Hfm2X59jNqIX+IbNTojVk3klZyphhQyglOKR7ZrXJx/JsvKAtHW1W7qftZkRn2AcZTkl4xShdprbjBUnoHnbr8gBPLi4oLoVVvlc7h6CjozvunAhth5LJ1Cts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735759544; c=relaxed/simple;
	bh=LKtP+qb2m7KEdeyvE7oYZoKGEvVXoD0Y2OB7p7ddETA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QxmxAywhCJ3BzLyKMR6pjGz1Vn2iVHR6NwWZ7B8PM3hN8NS009ox9Ob1X764fLd9b0UZzqOkE52+yWkV/R874x7IArF6WdiA3czrpGfIFGyohzMUbSddjKipWeNt43HoWVWoloaGOLqTWF4bN3tBiSeE68QXpluVjTo3XwUDLzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M6Lo52cz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YvtmSN1h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501ISsE3025246;
	Wed, 1 Jan 2025 19:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RdQW564q1cY9rrDyFPQ37g/VNntPEb3/KDKTdELXzOw=; b=
	M6Lo52czFnJMbqr4JnSdwt/f789+bnj98BNkttHPMvpCRPn5MdfIkbKyeC7vExta
	+DmInfJc6EUOAzrAGzv98eFGxn2mu01LzhKriY0WOjV2IO6v130DCK9x7XxMtQbb
	hFIfuTa6rokvHt5O9aTfI21x0kgImeGW08XskA6XE+LBHzHlMWfj4GBGrUXNUvom
	doEj4BbmL2ZDpfqrtDgFQt+Xa1pVsKeYv7dlbVhsQQ0JnhtpitErpRpxKrQatdJD
	8WElqxzrkE7fiuZSn/r18FeFSxKRxG4KO8y9IpMFK0QUIXsCoWm/hCT6JdD2nlo3
	eQ8hCquCPsGawNA+XPZCIA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t7rbvhm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 19:24:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 501EjiuH027775;
	Wed, 1 Jan 2025 19:24:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43vry10d7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 Jan 2025 19:24:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPJyIKLSX6JtEQGFWf2DoBDU+FjYO3EkoC6OLyeHg9ehyoP1N+1aZSxApA47DM7GtYButgeaxHLxcfu1jQYFrvRwpyAGALbqzSSLjfaJhDTQdTz6m82+JsM4WHagW95jARYcKXlO5H3chhcEE6j6SY5lCJQK4c2YG3rN0uffj8udDFCmAoQrfyIZPBbYoZC+wkQmxSIUShuPNLRlvw+3EOmqRyvp6UEBo/lWzLDLDPX0fxoFApFe3ks8iqECixikp/1zzGvuU/v0C+ADljqPqJVmQViDQ/qxoosu5kUtbEhG/eN6+FUfswt76OYKbcDQuHHAuhScTbnD9y7eVK1ZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdQW564q1cY9rrDyFPQ37g/VNntPEb3/KDKTdELXzOw=;
 b=Dpt8VZKJLRvcCbusANmGGGsD757qGsFSP0a1LFqDRSG9E177bWJJ4dANiksYV2Qf06ZQK8cfOHpjEahSV9Z5E0d628USDYA+M557NFtE6Dq2ionmQdxr4SDt3cX4fIQ0+hrfbkK7n3HVN2An6eFOKJMJqGY1Il6pUqcSHrey/FfwHUXbVAYbqb1ew9EpcMJWYVUjPqDdsoWJ5SzP+yYfrbaWoeQfCOBLABs/Xu5ouH2VbJQXQHGV8fhAHxkAHft1jFzwLsehw+/ycJTbbDrVnautaVQnS13kdZrXKLfJWYsB/auT+xXhe4MwGqDR03lgvg9362pB3UHgbU2m9+xxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdQW564q1cY9rrDyFPQ37g/VNntPEb3/KDKTdELXzOw=;
 b=YvtmSN1huVaGX5jddMNJ4FK/gidmkgGm8fx2k0PiQAisiGgsxeiQg4ZshDaq9p0Sk9qe71WHrOckecgb+aWur9oFBlGhRfaAy35g2oHc2jiEYEhiZ0cb1nCY0GnS1csMLBRjQ19GllERVSc2UdEB1ofqM7ERofYVmQnn91TCpzU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Wed, 1 Jan
 2025 19:24:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.012; Wed, 1 Jan 2025
 19:24:52 +0000
Message-ID: <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
Date: Wed, 1 Jan 2025 14:24:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
To: Salvatore Bonaccorso <carnil@debian.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Harald Dunkel <harald.dunkel@aixigo.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        herzog@phys.ethz.ch, Martin Svec <martin.svec@zoner.cz>,
        Michael Gernoth <debian@zerfleddert.de>,
        Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z2vNQ6HXfG_LqBQc@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: bec433a2-e140-4b3d-650f-08dd2a99f72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YlR0SWpOempSSmR0YXJXaVVHbndIVmV6U2J5bW9nVHV1bDVpeWFCaU5uNUhu?=
 =?utf-8?B?MithcnFTNElmck54dzVBY05hRlk0UURwb1hPUHNtUkRacXhCNTlZcGJyMWd3?=
 =?utf-8?B?UDEyTS9RRGhORjNWWU9oaUt5Q1Z4QXB5aFU4ZVZjbWFxcXN2WEEwcVZFOHNM?=
 =?utf-8?B?T3ZSSjFHVS9GdXFjNjUvOTVyZGlQcWQrS1BidkV1VWJvY2VsUUxXRXZ4TDZs?=
 =?utf-8?B?c2llQjNDdGVTcWh4NVk5QlcrUGJzMXRGVkdKc0UzV05kNjNEVDAydDFhWFdH?=
 =?utf-8?B?UjlObnJ6MFRvNlFiUzk2cElQdUVXbkY3L0ptSm5RWFd5T0RBL1lnTTh1dzZX?=
 =?utf-8?B?Q25YeklTek1QUTZEY080NEZ2MXAzVHRuaUd0T0tKMzEzSm9FTXR1TmRpd1JU?=
 =?utf-8?B?ZDlRMWh0RmdYYjlVaVhReWkvdGxNSTYwMUhqdlFIRnN2K3BmNEJwekV4SzRv?=
 =?utf-8?B?bDZYNm9rYit0VWlUZkl5MEpad2tTaUhSelBWT0IwZFRDbDdoN3dnSkZXM2tt?=
 =?utf-8?B?UUIzMVVYVTVVYU4rTDAxMW5XRWxTOW1Bendlb3d1R3VmalAxUmR5QlI1SXZK?=
 =?utf-8?B?YWREdmJ0YXBhek1KRCtlc0NrUUJQbWRISDRmaHQvdXhLVUw5WS9CbElBQWds?=
 =?utf-8?B?ZUVYMnRqNjg1aVVHZE0vaWhld3p0Nmx3WkJmTWdEd1k4YzRtS1hPYlIzNGdZ?=
 =?utf-8?B?S2lTQTBENHlvQ2FyY3loNjRSTkFKbS9vN1dPRWVySCt3b3NXT1E5ZTRmSzFj?=
 =?utf-8?B?bjZjWktVUlV3dTJ3SVEvb2pXY3pTRnhUSzlGaWNubXZZbzhZMVY1RkQ5ZVFr?=
 =?utf-8?B?OFNIYmkxazJwbnI4ZDdJSzBUSFlXM2I2RjM5R1h1eDdLVlAxU1RSRnJUZlhm?=
 =?utf-8?B?ZnVmbiszd1FBZ1dKNHZyeWhhalFLRG15OGY4NEJDalFWV0VtZUVZa1ZsaGhr?=
 =?utf-8?B?WXNtSTZoQUwrVDVpdS84QVBIM29TWDBHTjJ3MnpuN3ZkOGVMTVExSDkzcG5S?=
 =?utf-8?B?aC9kdFUzdXhnV1pxSVdIelczdm5jOXY2Tm5HOEN1Nks1YzA0V1p4QVJPV1pz?=
 =?utf-8?B?NUhTeklVK0trYTF0cXBycmxjbDZIcDRudVRuWjMvTzhpUDVycTZXZ2oybkFz?=
 =?utf-8?B?NThMK3BHamEyeVZoMk1KdDFwalVSczJvcGp4TEMwWCtldFl0WUZSNDV5Z3RW?=
 =?utf-8?B?L21DWmdkUkQxNFUzVGxwRUZjT3VsT1VVRzRyMW1NTTA2VE5wZ0IyVTdYYWZP?=
 =?utf-8?B?TDlRbGJxTnFnTzI2N2JjZE8wMVNBSHRTWEdhNkFqdjUxbkc1ZTlBS04xa2dL?=
 =?utf-8?B?bmV2cU54dzNKVGlJR3FaUEZtQ0N3QjNwUG11YlVNbXJ3ZGQxQnZwaXNhZGZE?=
 =?utf-8?B?VndRWGhrZ1R5azgxYlduZEJUWndwZzc3WXY1dHNOS1R4RTd4cmZIOWpCOXRS?=
 =?utf-8?B?ZGtvTURpRmVVWTkyNzl0QzFtTktvNUx5enY3MW5RMUlwTnhOS0JhYWNnU2Fr?=
 =?utf-8?B?NlZwaDVEZytYZHJnSFZUSW1SamhiRlBZcjdMSHpHUmx6ZHdKeTZHa1RLYnd3?=
 =?utf-8?B?UmtUQ2s2UzFPd3RsSWRCTUMxWHVrVDI3MHlEOXV1LzhqRmIrNEt6aG4wOElE?=
 =?utf-8?B?UTROSW1xRko5UE5GY3JCYTFHRDZBZjlCM1pveUE4YkEzSkFsNFpMRTN2a2ZZ?=
 =?utf-8?B?VmxqYzYvMFIwTTU3M2hFRFJDc3hpOEVsbnROUGdRb0hkME83T1JsU0dLcnIw?=
 =?utf-8?B?TU5XMzFrdGFUZ3crRys1dFBNOTVFQmMxMUwyR0dJT0dXODl1SWUycnZxVlYv?=
 =?utf-8?B?VWk3K1M2WFhacVBBQWlJQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEIzclV2eGtra2dBb0ZVdlQ5bDR4RGdLTEVxYnJvRFB0ME9DMTBmck1DdkEr?=
 =?utf-8?B?aDJrc1hiQWhiazZZUnJRWENuOXFQRUh1MGtnclN4c3lncW4ybVNVSitIdHBP?=
 =?utf-8?B?ZDVaUjZLWjMxVzl5bnBZOFA5VHRLcWxkdVRwcDdPOEkvczl3dE8yZE9UTlpC?=
 =?utf-8?B?cTIwL2xYV2NhM3lBTTlHa3ZWaVJuY3hCNzNRWGx2bFVSaXpjbStZS1Y1UFJM?=
 =?utf-8?B?WVZ4NStGNVJOaG5JWWpjZFAxdUEyUjk3emdqQ25hSFdLYVJ5QndXZE8vUUFG?=
 =?utf-8?B?bHQ5NEZGZThVMUtnMDc0aWlBb0VrbHZHYzZlWVl6TUd0bERoNEdlU0JrOUQr?=
 =?utf-8?B?MlZHUjN0cGFBMlJPVURWQ3pDUVRTcHNQempzeTlFZ1N1dzRua25XbGYyLzJI?=
 =?utf-8?B?emdkUnNUTXc5MHBpRGNlNFdvZlZaNm9xazhpWENNbFNhRTB5bTZCRG5uY2JV?=
 =?utf-8?B?MXJCQWtISmduRnVaSksxcjBZd25KVkZpT0dOSnExN251YWRwbkNWNi9KQlZW?=
 =?utf-8?B?bW9aU2lXVWVFaUNzWDdES0NUa2p1Y2FGUW84L3IvbmFncEFLMlU4UFNyY2tp?=
 =?utf-8?B?WEphUjlONmljTUxEdE9tKzU2OXNIMUJTMzdWbFA1UmF4aStZdlNNQVFFNytl?=
 =?utf-8?B?UHRFTkZoU045MGc5OXlHcXEyc0hocExrZ3M2S1RjV21hSnE3aXJPbnFXMVBz?=
 =?utf-8?B?Z2pNdnd3UW92OE9IZDBHbHp2ZGFsK2hhTmdRTzg2WFNmL1crWXU0NGdXYVlk?=
 =?utf-8?B?Ny9IclZCaFNhMVdCK28xUEw5WUd4WXlDeC92cStQRi8zSmQ4ZkpJSDVCazZq?=
 =?utf-8?B?bWNlUVdIRzE1OWU4WWZmY1FLbE5XSEdmV2pNVUlWMjY2L01WUkpuNnF1WU5M?=
 =?utf-8?B?Nk1nQkJDVE9jd0ltSTMyUTdQRW44ZXB2ci8xWEUvamZJNmp3OFkwMDJreHdr?=
 =?utf-8?B?bHlrNHVoMVFPb2Q0ajNQekVGcmFPOHpTN0FHT3Y0d1lELzVmQmJTSVRLVlZa?=
 =?utf-8?B?eVhxTDMyM2xkcDFyTStzRnVtNFh4WVZPQUw3TDlpaEVBZTFBRXhjSEhRUmhM?=
 =?utf-8?B?bm90S2dTN3NKQWZIcDJwTFB4NHNmeXBZQU42Q3hUbWU3Y3p5TEd6RmMwZm56?=
 =?utf-8?B?RDZmRW5MQ1laY0RpWHU0V25ReS9nMC9sS01vOUF0eG5nWWFzTWFkdVlVcnYr?=
 =?utf-8?B?blZBQU5WNDl3OEFkL2lNWEZYSXJlaDhUQlZUa3NTcHpRSDIvbEVjYmgzb0hS?=
 =?utf-8?B?YTlpT0N4N1FwaHVka2IyWmVsbHBHZURkNkFFbGpuSWFQV3dCY1piZWRaa2hQ?=
 =?utf-8?B?M3FDQnBkT0VmNGVrdThNcVJYUURLQVB4eFNuall2WTdjMUtSai82bHBnMnZ5?=
 =?utf-8?B?bEhZRHU0UVNSVnRneUVtYmsvdU54Q251NGlBY3JtN3FBbE5VYmM4em9ob2Jt?=
 =?utf-8?B?V2JXd29EV2w0dHZaMnhCRk1CUXQ5aE9lckphbGkwRm42am1MMk9Sd1pKdDdG?=
 =?utf-8?B?cnIyWXJlOTBPNWFJN055SC9XT0dlWFZwZExsbjBWRy9mcFJCR2FzWU5nYnl2?=
 =?utf-8?B?SXV1eW5ETG4rdlpraFRTbGtWTGc1U2FQbFBpOUNtaWZBTDJXbitGNkpabXVp?=
 =?utf-8?B?U2V3SzEvZk9kaWk4YzI0dzhmZ3dIV1ZBMU1NZGhPK25CYitHNjZLLzBkZ3U1?=
 =?utf-8?B?NSs2U1Q3eXhVMUxFWkpzdGRuWG4wZXMrdUs4dG16MVIwdHZya3dMYUZqTjNX?=
 =?utf-8?B?citLY0tPaS9xOXRXUm5SSDZ3cENVa01yNldVWW8vSCtJRnFlMVFXc2FnamJE?=
 =?utf-8?B?Q0JLSlZQWXprYXVtejZnK0ZsMzV1TTVvNG9LOVZYb01rVFk5a2FNQ1dnZThm?=
 =?utf-8?B?blRPZ0ptNlhjajk0NGZ3cGMxZU81cUM0a3VSYTFlOVNSelFRWjNJQkRxSFFJ?=
 =?utf-8?B?T0pnY0dwbjRSZGYwclp0d0RoY3lqblNiYnBWZ1ZHSWs5TTFGM2RQbWdHL29m?=
 =?utf-8?B?NldyNHJSNU1qQ25BMWhmOW93L0d1N2k0YVlIL1NvWDJlYjJvQVVscFhDUHlo?=
 =?utf-8?B?YWlOYmVBS3A1RTNRV3dETktCR0lIZko1RDVPNlBqdE5laXZzSTBLVHV2STI3?=
 =?utf-8?Q?YzjUoO9FoR2uCJXm8b8hlORmY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O26CrGrLl718icq9zSC+4lDqDtpwFjBc8CU9MeuHkRtFU6+EC81j9KsKm1kixCFNkee8fY3GyI7o6p1SPwSZlBWejXlre0lXSv0lnbXDxOEg6JdWkwS8DiDbf43JijFYIHVPStd7XIgpV8BdkML2/DA7y7zzzRvoCuA8jQzgUjEkiNhaIUWba0B6lKgpqXcjv4AJpYRihkPox3fJhJI5nwdJs0Ke42vjSrQWUjPmFsTpaQ4Cp3TauBSjXmnAFbiJlycYzUapTjwHadUSMaesjVFaSl4z3D/3xDnqzMUZKJmvS8IR20tDbnLG7NiLqDh9p/FPtASHoe5lf6qekMni3IbEj43Ax2oWVe4OXnOZsxiNuDVhbwU5kN3tSof1zfhLZCD4iNumvwu/jWsMBmXkHKcTW/7claaO2F91ZdLm7N2Jbh8zgNpoeJRbxBixptlRqTIKy/jdShaqaXWg3N+cxK1Ea5qE1Aya5ehmyIiwPc6r6OLckDw8lBAA7mYkwXy7K3o1YCdSu+AZVAhiJIIkhVhazuYqbp0P7fAEco/V0tIDIwEA0d/7nVtKFy9d55byQKNZWSQhnQyK4id+4FFhf87JnX8XdstEynhxl+Ny9VY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bec433a2-e140-4b3d-650f-08dd2a99f72e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 19:24:52.3598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrUuROoiwXyeor0w0twUV6ZOxRG3mLTRGNT3CAZ43HlDQqAvrVtqK3/Lj/jZZwF1fvSNE5t9vXUBTTdJIy4+FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-01_08,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501010170
X-Proofpoint-ORIG-GUID: cuQ79_hTsCnfdxgrvbWvx9lWDuf8WxcI
X-Proofpoint-GUID: cuQ79_hTsCnfdxgrvbWvx9lWDuf8WxcI

On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
> Hi Chuck, hi all,
> 
> [it was not ideal to pick one of the message for this followup, let me
> know if you want a complete new thread, adding as well Benjamin and
> Trond as they are involved in one mentioned patch]
> 
> On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
>>
>>
>>> On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
>>>
>>> Hi folks,
>>>
>>> what would be the reason for nfsd getting stuck somehow and becoming
>>> an unkillable process? See
>>>
>>> - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
>>> - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
>>>
>>> Doesn't this mean that something inside the kernel gets stuck as
>>> well? Seems odd to me.
>>
>> I'm not familiar with the Debian or Ubuntu kernel packages. Can
>> the kernel release numbers be translated to LTS kernel releases
>> please? Need both "last known working" and "first broken" releases.
>>
>> This:
>>
>> [ 6596.911785] RPC: Could not send backchannel reply error: -110
>> [ 6596.972490] RPC: Could not send backchannel reply error: -110
>> [ 6837.281307] RPC: Could not send backchannel reply error: -110
>>
>> is a known set of client backchannel bugs. Knowing the LTS kernel
>> releases (see above) will help us figure out what needs to be
>> backported to the LTS kernels kernels in question.
>>
>> This:
>>
>> [11183.290619] wait_for_completion+0x88/0x150
>> [11183.290623] __flush_workqueue+0x140/0x3e0
>> [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
>> [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
>>
>> is probably related to the backchannel errors on the client, but
>> client bugs shouldn't cause the server to hang like this. We
>> might be able to say more if you can provide the kernel release
>> translations (see above).
> 
> In Debian we hstill have the bug #1071562 open and one person notified
> mye offlist that it appears that the issue get more frequent since
> they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
> with a 6.1.y based kernel).
> 
> Some people around those issues, seem to claim that the change
> mentioned in
> https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
> would fix the issue, which is as well backchannel related.
> 
> This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
> again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
> nfs_client's rpc timeouts for backchannel") this is not something
> which goes back to 6.1.y, could it be possible that hte backchannel
> refactoring and this final fix indeeds fixes the issue?
> 
> As people report it is not easily reproducible, so this makes it
> harder to identify fixes correctly.
> 
> I gave a (short) stance on trying to backport commits up to
> 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
> seems to indicate it is probably still not the right thing for
> backporting to the older stable series.
> 
> As at least pre-requisites:
> 
> 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
> 4119bd0306652776cb0b7caa3aea5b2a93aecb89
> 163cdfca341b76c958567ae0966bd3575c5c6192
> f4afc8fead386c81fda2593ad6162271d26667f8
> 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
> 57331a59ac0d680f606403eb24edd3c35aecba31
> 
> and still there would be conflicting codepaths (and does not seem
> right).
> 
> Chuck, Benjamin, Trond, is there anything we can provive on reporters
> side that we can try to tackle this issue better?

As I've indicated before, NFSD should not block no matter what the
client may or may not be doing. I'd like to focus on the server first.

What is the result of:

$ cd <Bookworm's v6.1.90 kernel source >
$ unset KBUILD_OUTPUT
$ make -j `nproc`
$ scripts/faddr2line \
	fs/nfsd/nfs4state.o \
	nfsd4_destroy_session+0x16d

Since this issue appeared after v6.1.1, is it possible to bisect
between v6.1.1 and v6.1.90 ?


-- 
Chuck Lever

