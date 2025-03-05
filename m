Return-Path: <linux-nfs+bounces-10487-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92761A50A2F
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 19:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD42B3AC063
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Mar 2025 18:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706631624F2;
	Wed,  5 Mar 2025 18:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U4LPQ+zM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BRpE4mcw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9DC13AA38
	for <linux-nfs@vger.kernel.org>; Wed,  5 Mar 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200351; cv=fail; b=MNV6ahd+RVQCbxCrucM13h78busfVQHmJdkDKxfDumvXnKOBVMTq4IKUV2P47dYd+nZ96se18I3X9sRxtWtRuzzHI5feaoze25e4bT/lWGjPEGhkFrL7T5DcXfIy9Xy2nmJAL+2MF3JEb7mGpmqypipfw+gJ6BU/SIYNzmd+gSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200351; c=relaxed/simple;
	bh=78CZo7qFEV0gX9WObS8QwekApUxNXemQlHTcBYiiJYc=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZhV5VXq3h82gmKrLyXhyCyUceMZNdlGaYXDKW4B94fUMDCsGnnLJhvA17cuEG2wEuQYE6TJ+X9HMD7ZAiU8GIfbZxgX67P9mWpwx+v+V8GizOamYXvtB4Co1/vbZNRZwwbH98j099Ghz7gP8qsNQ8D9/qydfsz7sfkyR1f9iPr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U4LPQ+zM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BRpE4mcw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMfds014093;
	Wed, 5 Mar 2025 18:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FVtmVW5qJJ2uZBduqEodjqA6pqfMrH1WTNvb7yZWip0=; b=
	U4LPQ+zMMq6+P29BCUk/J6tYHwhXbKYTnIRcuoq2J8slSuGSXi+hysfoZyBJSY+M
	k5V4oLtaNlU1QrTHBnEXtvVi3EnWNRafb7Gsh8Nn8j42TfLD0cMy0fz45lzcP4VO
	gavvoe0I26MycO3e0j2G1iE9j1obqAu9yC+fOEsXeylsA68Ff+59cqf3kw7sqoVF
	9xhQfq5vRbjYVEQhu/PbZUg5QaFAlcd6RJPfLNhjZxzwtcwgdXTu6RvGbc6uOcFR
	ZKZxGcj6ILOtsgTYatQGpEjWQPUFPGMJWeiCyo2Wb/x5P7JLEn8OiAk8AENpFKYT
	GsNHC6ghbFmKOc9NPUcAQQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u820bkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 18:45:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525I102p013611;
	Wed, 5 Mar 2025 18:45:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpcbdum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 18:45:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoIEjawET9hJ+YhJdEjRbJQj2qvgXuX1mAFGrBBsETMi2XZA+Gjp98CprK4v+mh+Rv6zpp9caOUVq0Qzvzecp1qbnjGGJEIO9rro11lC2eW7JMiaSMjSQakEfGyIRyBA7Shd1nhsPAiBHYBQIUIavqSI+sGJpXiKy1LyBTirJlXu2cO0BhVxcwq1SQdAm/e0M3EVIc4zWp7QyhcVmV9TDm8iBadATRPjgTdIOOihpmqwfrOGSnNsCX596XWYGZQLfRPCswge7VjRJpdmLqDWbiJDbMKvm2yxAip1HV7H6ES7aCWp+t4GhPd67ByFAPy3dObBJ4O6bI0fUgQOZa2sTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVtmVW5qJJ2uZBduqEodjqA6pqfMrH1WTNvb7yZWip0=;
 b=XIeNzLPt6LInr9AixRsd95K2UaDrMRApMsoX2/vOMLfMT86EP4UBtXJt1T0/hRWhuevoIxJzWwQHZ9Yboh/20CTPlQpl6BP66GCSlvzSeTEX5KjVyadhQMKmRYfvqWhn+oZLx90KOEQ3zgdkpHT7PIKwHk59uM5AFX8AzcfKeMbGqXOdpOIqwIMiGDSoLSYEClBSLHbM9e4K1j3hQplM/mLdvx43c8IixH90J19FanqprTe7/Sj81p7HqCdeiAPEUYDYiBiKX2seWhMy3vLJv++HfAwTIN2DZU9AmetT4hqyWg2o0WMJfNEatQtFAbts2wINTJdr3SYE/rOL3X0XVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVtmVW5qJJ2uZBduqEodjqA6pqfMrH1WTNvb7yZWip0=;
 b=BRpE4mcw8JsVCcqFU5AMWRyRh0ZBJp1tR4qk28o5mH3AiXGkcBtE1/ztwQJXqF38E5eaZeXnJUn0sGHKYxs3dutnYIqvAHqX4PreTtW+boScKj3I/BTYW09Ddbb6o8edlRN/k+cNHGTheQ4gy8P6b0w/lDttj5QCxPKmQfesdbg=
Received: from DS7PR10MB5151.namprd10.prod.outlook.com (2603:10b6:5:3a4::18)
 by DS0PR10MB6845.namprd10.prod.outlook.com (2603:10b6:8:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 18:45:37 +0000
Received: from DS7PR10MB5151.namprd10.prod.outlook.com
 ([fe80::f493:6425:26c5:36ab]) by DS7PR10MB5151.namprd10.prod.outlook.com
 ([fe80::f493:6425:26c5:36ab%3]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 18:45:36 +0000
Message-ID: <27b7e9f4-b600-4b50-a401-5389ceeabf91@oracle.com>
Date: Wed, 5 Mar 2025 18:45:33 +0000
User-Agent: Thunderbird Daily
Cc: Calum Mackay <calum.mackay@oracle.com>,
        Frank Filz <ffilzlnx@mindspring.com>, linux-nfs@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH pynfs RFC] pynfs: add v4.1+ st_delegation and st_xattr
 tests to "all" group
To: Jeff Layton <jlayton@kernel.org>
References: <20250220-fixes-v1-1-92c4b1745be8@kernel.org>
 <1224b697-5863-41f3-aef0-59580d85117b@oracle.com>
Content-Language: en-GB
From: Calum Mackay <calum.mackay@oracle.com>
Autocrypt: addr=calum.mackay@oracle.com; keydata=
 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
 smRifw1wGg==
Organization: Oracle
In-Reply-To: <1224b697-5863-41f3-aef0-59580d85117b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To DS7PR10MB5151.namprd10.prod.outlook.com
 (2603:10b6:5:3a4::18)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5151:EE_|DS0PR10MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: d41c023e-e57d-4a3e-4316-08dd5c15eafd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDN4MjBveC8vV1ZHQUNjaDVrMnE5MkNhaXhPSGZiQjFnR0lwQnZDeEFJelBi?=
 =?utf-8?B?Vjd3cG43YmZ2QW5FayszQk41SytONFZ5Q1hYNHVEODVpbk03RHhYWlE5V0RN?=
 =?utf-8?B?aVhMMG8wUjhqZmE1ZGF0K0E0d0hhRFhaendNQTFyVTlqM2lmYWNFZkUrVTBI?=
 =?utf-8?B?a0hLdGxVTXhncFptdlhPclRYSERaeWZ5a2VJQUE1eFV0cTV4NXZlMVUzRkVo?=
 =?utf-8?B?VGNYTTE4UmlFazQ1dFQwdWVXWGdSQzVxa2lVM3d1VGtHWUR2K3JHMkwzR0RL?=
 =?utf-8?B?TDZMN0FKUjB4YkJhSnFWRmZDNDYwemZ6K3dSTzFLSUFrajZPbjk1aGhCL0JJ?=
 =?utf-8?B?NllhbUxwOXhReGNTU052bEl1N1BJY2ttS01JWmRHUXVnSE5sUjc5TGhMM1RP?=
 =?utf-8?B?T25JeDgvc3htVUZjZVdYNlRsTlNJMnpIcTNrSHpUeXJPWlZmbWYzc21zVlNN?=
 =?utf-8?B?SnhmOVVsdGV5V01KalJsQXBzWTlEUmxBQ24zRkUwbTAxRUtkaW04OFNkMldF?=
 =?utf-8?B?eGdDUkFPRzNZNjd0U2IzdFd4NlhrcDEvVExJL3ZUU2FwOFY3NXNKb2ZOanJm?=
 =?utf-8?B?c2hsM1MwWjdsS0xnazkwMDV0Ni9FMDFnQkNlTFRqNXMrcjhJa3FZZzg0R1Jl?=
 =?utf-8?B?R1lCNXpFd090S3JQeXFTb2J2TG1sazJsaGdJK0szVHRFR1E1bFJrc1JVUzY2?=
 =?utf-8?B?Z09VMVM2cFFUWFhSR2Z2S1BxcWZ3eE1Edmh2NUduR1Y1TWpnY2RPQXV1MmFN?=
 =?utf-8?B?L0pEcXJzV1I0REk1WEFKY1NWY2hxV0pwa2Y4d2hmUDBPTDBXZUhwUVp3dXhU?=
 =?utf-8?B?WGM0eVh6Y0pSaTR4ampzbDRTdzFIdGZ0UU1EQm1Hb3oybTNQUU5RS0JQZWtX?=
 =?utf-8?B?U0hQZlRjaEVwVzR5S0lVWGdOWW5NMVVEVmZ4UVJTR24vU29PNDhUNUhRTlZn?=
 =?utf-8?B?cmwwVmUrSG1YcERFVGpzRTdSd2g0OWNWK2xGNCtObnpDbUllNWpqVS8zNDJt?=
 =?utf-8?B?bTREZGpWMmoydnJYT1YzSU0ySzRvVnQyazNEbGoxR1ovYnFrVW1LZTBFWGJw?=
 =?utf-8?B?VWJRY1hCaW42djd0RUdINEgraTJER1luaFE1Q2VMaEpVempFMG5lbDhwR21W?=
 =?utf-8?B?SEwyZVkxbHB2UDQ3L05xMUorNDJjTjMwSE50QmFpY2FFV2FxTk5DdE5BUVNS?=
 =?utf-8?B?MWo1ZCtvQk9IWFVZZ2k5Y3pGbjl1elNFVWplY1drK1orU1l2RjZpeGVQMnd6?=
 =?utf-8?B?OWM5dm4xemQrSVhMWWlEZ0JkZ1JabzRiZ2l5WHZaVWZwTkdTM053TDZ1M2hS?=
 =?utf-8?B?QzkvdlhuajY0L0puN0UrclRKWWRSQkpzNXNJSzFJWDJ4WGhRY01zbnhIQmNo?=
 =?utf-8?B?eDM0akRYMHJVNWlwcjlkNmpuYjhySzdLSUkwZkozQ1NNNWZyRGxRQ2hlalBn?=
 =?utf-8?B?RWZNTlZ6aFpoZnVwVU94Vnp2amFwaHkvejA4dDBQVGw0eDVieSswZm5hSW9U?=
 =?utf-8?B?c1J2K3E0TW5CSjR3K24rT1JqaUZoS2lFNzZsQkN3WDJSRkNwREFGNDcvdkdj?=
 =?utf-8?B?QjBDb2JVMVYwQ1dKRDZSdFhNblNsYzNnMFNPa0x1elhpU1RKVlJxcm1yOFI2?=
 =?utf-8?B?eHJlYmxsbDIyamNZRCtnUXVMWmZkYjZDa1MyMGF3SGVKbmRKOFNCS0NXd29p?=
 =?utf-8?B?RXBGcExUbjFJbGVBbjdlVWhDMS9maDVMSi9MWjdaL2FMd1hjaVRieDUwVmtQ?=
 =?utf-8?B?bUZTZEpZbFNJNmJKdXFWaUlKazAvMWhkc1hkODRMd01mYUlZUUs2RzUyb0NO?=
 =?utf-8?B?RjlDcnU4MkFWTmdURlVBL01WbmE2Mm45aWdsM3kra3YwOFltUk1nMUFKT1Ji?=
 =?utf-8?Q?trIgNrVLNjTdf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5151.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FOSkFxYXQ5M0k2dGhma21uL2RWSERnZnYzaWYzalU4dHJ5U1B0NHlxaFpm?=
 =?utf-8?B?LzN0NlNFWjVoM2V1dE1lYlpjWXJZTDU4TGFCUkNQRFRvcWxXU2VJTkdnKys4?=
 =?utf-8?B?cnloMkJjaDFqMmVxaW5Pcm9peTZpRXdXTkdFQVVFdk1rZnRMd251WVQrb1NQ?=
 =?utf-8?B?TFNTU3QvTHlHNnZJTFYydjMxSU9PZ3ZwOEhjYmlHbWQ3cjVqVFBNcmN3N1hY?=
 =?utf-8?B?cUczQnJFUDJOa1NQbXZ5aGdWdjhVTitZdHI3d3NEbzBmU3hNTGZFem9FM3pM?=
 =?utf-8?B?REo4N096SXZ2M21oeThaUkk2MWhCVnRNTFNlZE9QdVpsK2phOHlsL25EdnY4?=
 =?utf-8?B?QjBQVXlieCsxNnhwY3NVcG9lUy9rTVRIdjIvRXZobUgrYlh3WnZFb0U5TnFC?=
 =?utf-8?B?UTlXeWRqcXpRNjI1b1JnUmxrTHdrR2RaZ2dmdEVSVUM5UXZKdUo5dWdsSGlm?=
 =?utf-8?B?c1ZWUkczSktrZEJpanE2S2ttdjVnTmQ2WGhJcHd0RlhYVUplTkMxSkNGNERl?=
 =?utf-8?B?R0xNdkhzWGdJQmlzZmdrMVRtQk9md1Z0blo1MDhIUDZSbVAzL2R3S1JTRGVM?=
 =?utf-8?B?eU5WZEdBVEx3dll5bkExZHNwcFZKdlN6TmgxK2Y3cHhyQVRYRUkxWElRMzgr?=
 =?utf-8?B?aWZjRGFxK25yVGNPMExqcGVvOUJxQ0R3RlJsR0l5SzdWNEhER3dsTkk0R3ZF?=
 =?utf-8?B?NFZrMjRuUlVwZ09xL3FqczJPc2srMmV5WVgwdDRSRDd3VFNrNjRNTWl2RW5I?=
 =?utf-8?B?SGt1aXVOWGp4OFFCdFM3cGU4eTUvNjR1bVhCMVRaS2RGQjlyZkt6VmVPQ09Q?=
 =?utf-8?B?KysvTCtWQUFXNFJlTnFlb2FVTDNvMWI0a21COXROVmx1RjBpMVB5YlNTWTdu?=
 =?utf-8?B?b2dWQWZzQXBwam8vVnVpVmtQTzJieTU0M2ROSUhpblJEbnlPem1zbUxmLytY?=
 =?utf-8?B?MFhNc00zS0taM0lKMW5WT0NEMlozb3pHeUxreUYyNWlkQ1N2M2lydk81dyt2?=
 =?utf-8?B?ZmtsM2sxSnFQbTlKdmVQM3JuYTBOQVMxZWRvY1IrZzN0WnN5bjlvVENZZVhh?=
 =?utf-8?B?OUdIbXB0blgyaXR5SEdvV3V5R2o4akhCdzIyUUlHbG9pTkxQa3pNdjFrTC96?=
 =?utf-8?B?ZTdxSlVTRHBjNm9pZzhXVXE2cER2VHNtMFdTSEM4Z09HbGNpMnl0c0FXUjJX?=
 =?utf-8?B?N2x5YmRiY1lMcms0dVk3Q0NwL0UydG5YT0hTaDRMdFVENXFxMHQ5aDE4RVlz?=
 =?utf-8?B?OVg4b3pneFNTZWM0UnhLTFJvZDVNL0VLRTNmTjZucVpoRkdDNnJORGdhUTQw?=
 =?utf-8?B?R1ZGMEZHU3ZEcUhCY3lJZm5WcHpMT2hlaGJNeWtESWdwY1g5YUo4S0JlYWh3?=
 =?utf-8?B?alJWKzM1cTBKYUtBVERWTWxzd1FXSWpCM1NvMS9nRnF0UHg4dUhjQWhEcnkz?=
 =?utf-8?B?SFZYUCtWYUZsalNwbXduaDhIRHR5T245TjgwTzRKVDNseWh5QUEwUkMydjFZ?=
 =?utf-8?B?WWlvUWw1QnNWc1BaVGZkQlZaTjFxNml6c2JqQmJtTUxLcEZaTUtIZ3JpRzVC?=
 =?utf-8?B?bjJXd3pwYklYb08rbEM1aVRkV21zSHcyZUpBdkIxK0lrQjB0bkwxcncwL2tu?=
 =?utf-8?B?S281eHRNWXpNVjlnYU9iWnd5UVR2T09wREs0bXgzam1yNGRmSmZPcUEvT0xt?=
 =?utf-8?B?eS8xbDZPUlhxdkpCVWVHY09pSXlyVUFZS1ExN09ZUFNKTXZTbHFna2hkdXlv?=
 =?utf-8?B?TnZ2bDgvbkxtOFFMRXkrUjdEVjA3ZG5GaEJ0UEVJSkxLTEFieDBsaUpFcjVK?=
 =?utf-8?B?RG15YzlSbWU2VXpVUk1RVFZKUGIzaWhEZUU2VVlHbjNEem9GNUFyRmlwWW1U?=
 =?utf-8?B?MWRRNmk0cG9hR3RkczRkUXJlS1dGUkZ0ck5lR01LalBQZjlVUmg5Qk1sTEVs?=
 =?utf-8?B?ZjdBUnVnT3RxNWNuMUxhWVdBSE1hU1JqWG94cGpxY200YUwyWUhLalJZN2c4?=
 =?utf-8?B?ME84OVRSV2g3cDVoVXc4RHV1QnpBVmhqTy9qNWdHdTVnR1h3UzlMU09ISUxn?=
 =?utf-8?B?T3BTQS84K3B1QlJSMDYrYk1QMGh1blk0WWRyM3I3aUVSN3VxWCtvZEdIa1Br?=
 =?utf-8?B?a3ZwNTFqS1ZQdXNQeGdzNkZqT2c5S0tUdXBPc0VjR0JQTEI2REtsNUZ6RXQ4?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m5t2nIbiFzun/2PLhIg7qJs5e4pT1MJUOXDmFSwb3OqTFTHI+/dMCHK2U/z/mGo9veQkJSHEmGaf2I6v++hY6FqATmR4cBQnHhwQFq+0Tmaz88tWt7ODLJyBDbzPzAMdpEKnvqaQq7+PiL/NvUojRDpCOFpk0cswPPGkGh3twJ0qhYi7Q1ncRqjzT5YQq2eSmR3lZHA9A0JW23TPOMY2G42rO4rp1UPkj3ImtmNEem2EGkM/kgxzgoWcasQq+7PClG2NjQkK0vzCetmAC1mNTHUcHVecJZLZ/ZJ8wB3/N5oNfn3/qwneCI/MJ7bkNm5A4mRCv+lPAf3KqTlObLc+m8eAQhzLZ8ll/hs90nvC/c/vNSK/WzGvR2aBHwoFdvrZZmjwXvJgeeu4E0ebz3cEqxum1MobFIRJJS/zch/nLvDW1f0CtjbDw3YOpOkXMwI3U3NP3nScpU/wfngOuRZsRstv9PFPNeqJJWqtrs0YdTs4lQnvR/AHC96FI3Md8ptmKwgLjPfnHTI961tyOIgbWsBiSfT9R4sBjladvayc9kJLaWKduiBEFs6xCU8rPJsGzzwQEIi6476/A207f41hMPyVBDACKYTOL+I0IE/bgUw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41c023e-e57d-4a3e-4316-08dd5c15eafd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5151.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 18:45:36.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diLOR5b+kjajvDtHFKQIe4OC5JG5gJlk2rrvS4eC+K8llqqmjWAR7+0hjHGPXetD0OIUkkOYzklbUfBQnnKx2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6845
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503050144
X-Proofpoint-GUID: -YC8Qlxwnrbx-SGLgmBObRNbTZev_WTL
X-Proofpoint-ORIG-GUID: -YC8Qlxwnrbx-SGLgmBObRNbTZev_WTL

On 04/03/2025 8:37 pm, Calum Mackay wrote:
> On 20/02/2025 4:54 pm, Jeff Layton wrote:
>> These tests all pass against a fully up-to-date Linux knfsd, and I think
>> should pass against ganesha as well. Add the "all" flag to these tests.
>>
>> Cc: Frank Filz <ffilzlnx@mindspring.com>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> Should we add the "all" tag to these tests?

hi Jeff,

Chuck reports that some of these tests break on older NFS server 
kernels, so perhaps aren't suited to "all", after all.

Might it be better to only add to "all" to those tests which do work on 
both current and older kernels, for some value of "older"?

I could revert this for now, unless you can split them accordingly 
shortly, but for the moment I'll leave it in.


Anyone having difficulty with the latest pynfs and older kernels can, 
for the moment, use the "pynfs-0.1" tag.

thanks!

cheers,
c.


>> It might also be good to
>> think about tagging out a release before this change, so that we can
>> tell people to use a specific version if they're hitting problems.
> 
> Thanks very much, Jeff.
> 
> Applied, and tagged "pynfs-0.2", as there's no other pending changes.
> 
> 
> The previous commit was given the tag "pynfs-0.1"; before that we've not 
> had tags in the current repo.
> 
> cheers,
> c.
> 
> 
> 
>> ---
>>   nfs4.1/server41tests/st_delegation.py | 24 ++++++++++++------------
>>   nfs4.1/server41tests/st_xattr.py      | 22 +++++++++++-----------
>>   2 files changed, 23 insertions(+), 23 deletions(-)
>>
>> diff --git a/nfs4.1/server41tests/st_delegation.py b/nfs4.1/ 
>> server41tests/st_delegation.py
>> index 
>> fc374e693cb4b9a9adaaf5ff15a64a02573113b0..fa9b4515dba25c6dd0bf11b409b6eacf5e783cbd 100644
>> --- a/nfs4.1/server41tests/st_delegation.py
>> +++ b/nfs4.1/server41tests/st_delegation.py
>> @@ -67,7 +67,7 @@ def _testDeleg(t, env, openaccess, want, 
>> breakaccess, sec = None, sec2 = None):
>>   def testReadDeleg(t, env):
>>       """Test read delegation handout and return
>> -    FLAGS: open deleg
>> +    FLAGS: open deleg all
>>       CODE: DELEG1
>>       """
>>       _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ,
>> @@ -76,7 +76,7 @@ def testReadDeleg(t, env):
>>   def testWriteDeleg(t, env):
>>       """Test write delegation handout and return
>> -    FLAGS: writedelegations deleg
>> +    FLAGS: writedelegations deleg all
>>       CODE: DELEG2
>>       """
>>       _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ| 
>> OPEN4_SHARE_ACCESS_WRITE,
>> @@ -85,7 +85,7 @@ def testWriteDeleg(t, env):
>>   def testAnyDeleg(t, env):
>>       """Test any delegation handout and return
>> -    FLAGS: open deleg
>> +    FLAGS: open deleg all
>>       CODE: DELEG3
>>       """
>>       _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ,
>> @@ -94,7 +94,7 @@ def testAnyDeleg(t, env):
>>   def testNoDeleg(t, env):
>>       """Test no delegation handout
>> -    FLAGS: open deleg
>> +    FLAGS: open deleg all
>>       CODE: DELEG4
>>       """
>>       sess1 = env.c1.new_client_session(b"%s_1" % env.testname(t))
>> @@ -115,7 +115,7 @@ def testNoDeleg(t, env):
>>   def testCBSecParms(t, env):
>>       """Test auth_sys callbacks
>> -    FLAGS: create_session open deleg
>> +    FLAGS: create_session open deleg all
>>       CODE: DELEG5
>>       """
>>       uid = 17
>> @@ -131,7 +131,7 @@ def testCBSecParms(t, env):
>>   def testCBSecParmsNull(t, env):
>>       """Test auth_null callbacks
>> -    FLAGS: create_session open deleg
>> +    FLAGS: create_session open deleg all
>>       CODE: DELEG6
>>       """
>>       recall = _testDeleg(t, env, OPEN4_SHARE_ACCESS_READ,
>> @@ -144,7 +144,7 @@ def testCBSecParmsNull(t, env):
>>   def testCBSecParmsChange(t, env):
>>       """Test changing of auth_sys callbacks with backchannel_ctl
>> -    FLAGS: create_session open deleg backchannel_ctl
>> +    FLAGS: create_session open deleg backchannel_ctl all
>>       CODE: DELEG7
>>       """
>>       uid1 = 17
>> @@ -165,7 +165,7 @@ def testDelegRevocation(t, env):
>>       """Allow a delegation to be revoked, check that TEST_STATEID and
>>          FREE_STATEID have the required effect.
>> -    FLAGS: deleg
>> +    FLAGS: deleg all
>>       CODE: DELEG8
>>       """
>> @@ -220,7 +220,7 @@ def testDelegRevocation(t, env):
>>   def testWriteOpenvsReadDeleg(t, env):
>>       """Ensure that a write open prevents granting a read delegation
>> -    FLAGS: deleg
>> +    FLAGS: deleg all
>>       CODE: DELEG9
>>       """
>> @@ -249,7 +249,7 @@ def testServerSelfConflict3(t, env):
>>       That should succeed.  Then do a write open from a different client,
>>       and verify that it breaks the delegation.
>> -    FLAGS: deleg
>> +    FLAGS: deleg all
>>       CODE: DELEG23
>>       """
>> @@ -357,7 +357,7 @@ def testCbGetattrNoChange(t, env):
>>       client regurgitate back the same attrs (indicating no changes). 
>> Then test
>>       that the attrs that the second client gets back match the first.
>> -    FLAGS: deleg
>> +    FLAGS: deleg all
>>       CODE: DELEG24
>>       """
>>       attrs1, attrs2 = _testCbGetattr(t, env)
>> @@ -376,7 +376,7 @@ def testCbGetattrWithChange(t, env):
>>       attrs before sending them back to the server. Test that the 
>> second client
>>       sees different attrs than the original one.
>> -    FLAGS: deleg
>> +    FLAGS: deleg all
>>       CODE: DELEG25
>>       """
>>       attrs1, attrs2 = _testCbGetattr(t, env, change=1, size=5)
>> diff --git a/nfs4.1/server41tests/st_xattr.py b/nfs4.1/server41tests/ 
>> st_xattr.py
>> index 
>> b3eb8a87465b9fd76121e846f9927bfc0867ffc8..f67df9517bdbac0ebd88c0c9f94244a96d5d2d3e 100644
>> --- a/nfs4.1/server41tests/st_xattr.py
>> +++ b/nfs4.1/server41tests/st_xattr.py
>> @@ -15,7 +15,7 @@ current_stateid = stateid4(1, b'\0' * 12)
>>   def testGetXattrAttribute(t, env):
>>       """Server with xattr support MUST support.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT1
>>       VERS: 2-
>>       """
>> @@ -37,7 +37,7 @@ def testGetXattrAttribute(t, env):
>>   def testGetMissingAttr(t, env):
>>       """Server MUST return NFS4ERR_NOXATTR if value is missing.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT2
>>       VERS: 2-
>>       """
>> @@ -53,7 +53,7 @@ def testGetMissingAttr(t, env):
>>   def testCreateNewAttr(t, env):
>>       """Server MUST return NFS4_ON on create.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT3
>>       VERS: 2-
>>       """
>> @@ -76,7 +76,7 @@ def testCreateNewAttr(t, env):
>>   def testCreateNewIfMissingAttr(t, env):
>>       """Server MUST update existing attribute with SETXATTR4_EITHER.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT4
>>       VERS: 2-
>>       """
>> @@ -99,7 +99,7 @@ def testCreateNewIfMissingAttr(t, env):
>>   def testUpdateOfMissingAttr(t, env):
>>       """Server MUST return NFS4ERR_NOXATTR on update of missing 
>> attribute.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT5
>>       VERS: 2-
>>       """
>> @@ -117,7 +117,7 @@ def testUpdateOfMissingAttr(t, env):
>>   def testExclusiveCreateAttr(t, env):
>>       """Server MUST return NFS4ERR_EXIST on create of existing 
>> attribute.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT6
>>       VERS: 2-
>>       """
>> @@ -138,7 +138,7 @@ def testExclusiveCreateAttr(t, env):
>>   def testUpdateExistingAttr(t, env):
>>       """Server MUST return NFS4_ON on update of existing attribute.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT7
>>       VERS: 2-
>>       """
>> @@ -165,7 +165,7 @@ def testUpdateExistingAttr(t, env):
>>   def testRemoveNonExistingAttr(t, env):
>>       """Server MUST return NFS4ERR_NOXATTR on remove of non existing 
>> attribute.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT8
>>       VERS: 2-
>>       """
>> @@ -183,7 +183,7 @@ def testRemoveNonExistingAttr(t, env):
>>   def testRemoveExistingAttr(t, env):
>>       """Server MUST return NFS4_ON on remove of existing attribute.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT9
>>       VERS: 2-
>>       """
>> @@ -204,7 +204,7 @@ def testRemoveExistingAttr(t, env):
>>   def testListNoAttrs(t, env):
>>       """Server MUST return NFS4_ON an empty list if no attributes 
>> defined.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT10
>>       VERS: 2-
>>       """
>> @@ -227,7 +227,7 @@ def testListNoAttrs(t, env):
>>   def testListAttrs(t, env):
>>       """Server MUST return NFS4_ON and list of defined attributes.
>> -    FLAGS: xattr
>> +    FLAGS: xattr all
>>       CODE: XATT11
>>       VERS: 2-
>>       """
>>
>> ---
>> base-commit: 81a4693305abb42ffd16e77a4808a1a607693476
>> change-id: 20250220-fixes-4bb1039117da
>>
>> Best regards,
> 
> 


