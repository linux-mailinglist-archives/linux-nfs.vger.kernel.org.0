Return-Path: <linux-nfs+bounces-10195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26020A3C6A2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 18:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AECD17A77B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Feb 2025 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042B01AF0D3;
	Wed, 19 Feb 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z6F9gdgE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IlPVtp7D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B8214219;
	Wed, 19 Feb 2025 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987354; cv=fail; b=jEHIYHir5+2K/oY2EmpdVMFY0uiHhlgHz8lRpr95cTpmCId+xRGo7j4jYcYYXnrmL7qCEme5VyuQSe2b/D+/w3QGWyk2KCKZlJplRo7cIdKTCvcQqMIvRByzz4JfH4tAAZw6JaSB/lGPRWdP4C7vlwKC3/W3PGdwMIWnApt1DCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987354; c=relaxed/simple;
	bh=tYsg5UsyiFmDRGfbYf1PryHqxAWpzrT8Z0PTu3NqioU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oAEuCrUzvvjI2lMhdj2gMC/BcjqX0/v/ca+BWcwUCr5UwQ9Goi7CAOM3+zR3MLaJY3pwSXLczQ6Bz9d2oEo3LP3WfymhXZIw+uBCYSm22YAF51qxawmd8ZNWuV4hjUOrn5W7h8P55s6nxWGpTUB9PZbIm1sH+Y9G2EOvZieUt2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z6F9gdgE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IlPVtp7D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JHMVog013951;
	Wed, 19 Feb 2025 17:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=8FuFVk4C+kJ/yA5PqCARi6ZRlXmtly8t4RlNL0zk0Vk=; b=
	Z6F9gdgE80cNDchBp4Z09NY6xa4o25Fbc/EzS5b93MHzrb6k7sxWqTDQUeUj7IuW
	jgbgEExRjkwSYPhLBnZbTA+h6V5OZL/AnSU2iG6NZrkph4ny6LC+VUn/V2MPjNdE
	W7XMNheP4NhTxUWuH9UXnwij13N6kjfArmZFBcWg8QI1oUya4GV9c1MdW1rhsK06
	fQhwJGg7cXARbiiLJFAGtE8wCSape69pYYevlhl2tLGdUmenLdiKbvjloAp1aiYV
	vFhKWtUJRRyQ+0KBu3NWfPHDAUln1FcNqA5p+y3k3rPHYi39FxBQ2NRAgBHNQ0MR
	ZFPcVpsrdC0drVSlaXIMwA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00m29ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 17:48:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JHU8A8026276;
	Wed, 19 Feb 2025 17:48:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0sp9u12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 17:48:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sw51q1I5iQI27eoYWsIsh1ON+khu21CMqaYOoJnf7jSSKDr+P3hTn1kwkIs2+DbGyXNagt/aGUQ6r/Zc40dBJVLuBb7HMpX6D2fpcjrkasiuaWU4V8vqflws5/1+b98QHEEuOvoWsbs9ARX3TUjnljCmVHBktFAGikG/ds27lePnSmmxLSziNMgN8E+EMUCyJEEUuX1F6FFOKikmwhpepqkRFpFGhLj0CBjXPtfnWj1qHJvyHAsuzXuPSUmRkRHlq5jSflfcSaiqwN63S2UDcNa1GduadRilNY04w+hffIewJGoJVHfROLD7I3w4b/tsOhXatG+ywpmCanneioe7Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FuFVk4C+kJ/yA5PqCARi6ZRlXmtly8t4RlNL0zk0Vk=;
 b=aPqKKj2KngjxhwvO6XIUZQG6ArsamTUkSckEVjOX5OxhPavabNNMLRrvfO6Sx94LoFd5FAE3xOrs4ljtqU5VG4yt0faTCbl9IJYoc42q/YI+CorFIPCzO2w8pojcM6sJXZVUV+QBIgK0z6Tt1beSAfo9J450suwekIfMDA5wLH5FZB8kg0KRT3jYN190GaQmuF5NdlYkHkaDHGEWRWKxjWePrrQXXCwH41uNtjOAv2uP+/NdSzB6UYopvjMHO9twmpAuLVXDbuT91zotYsCP1JsIFXdDAXdmE1FC/Y/a6qCink2HwoVr2bcGQTRNl2Jlada6GbTb04GRPDjWMEGGCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FuFVk4C+kJ/yA5PqCARi6ZRlXmtly8t4RlNL0zk0Vk=;
 b=IlPVtp7DdkTkTLJDnlC+NOrCTqIuhDPDLfRmuQEiYzbALCJN8Kpuf+lwvhKMhrhQGH8OAK2nCp/X9DoZfJu2Wtrvpc/n18XGZU5TpFM4bj57fIGIqjFQZENoFIEC3w4Su7vkW8ljC8/yGWzsDH8nvODXaKr0Y3SlTlOzFMYwhno=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4376.namprd10.prod.outlook.com (2603:10b6:610:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 17:48:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 17:48:47 +0000
Message-ID: <0e5cf4db-8a69-4416-8514-b76daed3455c@oracle.com>
Date: Wed, 19 Feb 2025 12:48:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH][next] fs: nfs: acl: Avoid
 -Wflex-array-member-not-at-end warning
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dai Ngo <Dai.Ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
        Neil Brown <neilb@suse.de>
References: <Z6GDiLZo5u4CqxBr@kspp>
 <b16ac12f-166a-4d25-bf33-b1ccf6e0dac7@oracle.com>
 <57b70bbc-c8d0-4181-98a9-5174517270a0@oracle.com>
 <CAFX2Jf=yktJ_Bz--c2VpoDmW13YyoY3MNSv5sJYSseWBGAV9Cw@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAFX2Jf=yktJ_Bz--c2VpoDmW13YyoY3MNSv5sJYSseWBGAV9Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0061.namprd04.prod.outlook.com
 (2603:10b6:610:74::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e8ef4d3-3c58-4633-b471-08dd510da90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHFSR3lWVjZtN3F4bXBGU0ZWbFRzWGxhM2lKazkrZE00aWcvYTNGSHJEZWNI?=
 =?utf-8?B?MmxiamFDZ0FRSDU4b296cTYwTXJtd3pDeGdDbWFnWi9WQ1NCbXZXSWRUVUYz?=
 =?utf-8?B?UzhEMlZBRGlEL3BKTVZHd2NiRkgvcVh0RUdXT3RacEdZVnVSMFJKNkg2eWtt?=
 =?utf-8?B?YjM2WjA4Y21hM1E4bDJwOW5VNTRZbEY0Y1pLejJ2ckg0SG52RDhrWU1hdEd1?=
 =?utf-8?B?QkRFZUpMcFRETEFnUWp6c1VSMHJ0Y3EyT2RUcFJNR1I4UjZPUEZSS2x1OHRY?=
 =?utf-8?B?RTFoTmJhOHBnVXhLRk1GTGMwYlFrTVg0Y0FZbjUxUHRrMUZ6RU56QUJjc1Bt?=
 =?utf-8?B?U2xBZUVXQm1FUE41RndOYkp0UFZiM3ZMQTJSTERTdit5emhjWXZNY0EvSThB?=
 =?utf-8?B?Z2JpY2Fsak5ZZWt3bXJtVVZFOXI0SHhRTXpRaEphYXdjTVU5YUEyM000VE5R?=
 =?utf-8?B?RmtsNE8zRmZMQWtKWHpDL3ZibTZxeU9xZ1Z6TFEwdUc2L2RKVnZFQ05LNTVp?=
 =?utf-8?B?eWplZjRQY01rcHdPUjMxTjQvRWlzRW03WVlyeS9OaHh6eTFmb21VWkRKaVFh?=
 =?utf-8?B?K0NCOUVEeGtudmZMU0VLRHVUeXMvMU9DcnlOc0VGWU5abU56MnVaNmpZZGlS?=
 =?utf-8?B?VGovYVpXV21GcDRTVFJTQnFFYnpZSjBFcENIaGx5ekdnZmdBS2FYMlV2YXdh?=
 =?utf-8?B?VE9JZEVXNHdKTk1JNVN0NEFTZVhqNFBXRUQwY3ZoQXZxdkxpNE9UWG1KbE5t?=
 =?utf-8?B?N1dBS1g2ZzU0WUFHT3pDUHpicHA3SmprdUJJeEcrK1ZGaFgxaXZZRFNHR1BF?=
 =?utf-8?B?bGg4NUVoODUvM2Z2bUtVUkRWUUVTMCswTEJ4UjFZS0V1OHQyQUtlU21mTld2?=
 =?utf-8?B?Vi9BTDd4eDI1VFMzTHhiT0tQL1dNNDNqVDBYdlNISndocTMyQ3BvSVhOYUdE?=
 =?utf-8?B?OSt4cUtDY1dtNHQ3d1llOWYvQm14SlM4YXdJUVVML1VOa1lZZFpWV2pxVGZu?=
 =?utf-8?B?K3NKTHBkMWloVzlkRmFmS3BTRjRsUlZxNE9TL00wRUtaSlhiTGx4aTZLM2lO?=
 =?utf-8?B?enV1UHE4dFEvYThMKzJFQjJudWQvU0tSSTBOb0tzeDE5b1lUWkRjMGJ1Qmcz?=
 =?utf-8?B?dURnb1FRMlRURjRWYTdEWm9udUhkZElGWERqZ2wwc3VqR0NYbFVOY0VBMXZ6?=
 =?utf-8?B?WmFwTExyN2N3Tkd2MlVaMmxSRWRVWCt3ZHZvQVpJangwU25tajNsSmcrUzlE?=
 =?utf-8?B?cHkydm5wZWs4K1p0V1ZVWW9qRjBGeTE3WTk3YzlZVTFKemgrV2g2SS9JZ0ZV?=
 =?utf-8?B?TVkwbW51NHpVcWVFWk9QQ2lyY2ZrV1BVd2p0RkR3bEw5K25CenlubjJyeDg0?=
 =?utf-8?B?OFdPSDdvdnJmeG5GUmxmdm5lck9VUEFYdDc5OUVpOGJ3UEt3NkZIcWVWN3NO?=
 =?utf-8?B?WnhXTG45eGtDdkVqR3pyQVZyRGszTmJpd1VWRk9kSXpEN3VPTzJwNU56UHUr?=
 =?utf-8?B?NExhcytaVVlLcGp0RXlBYytpRnYyZWdRd2xXYytuamdzOVJ1bWVIOWdYQ3VR?=
 =?utf-8?B?UktIQ3pEYkRVRTgySmZOOHBOWVRqM21kWU5KNTYwL3UrSHh3TGRoQlQ1V1M5?=
 =?utf-8?B?RXFxZmRWVyt3Z2JCbExZc1Zkdno1cXRBenB5L1pibnhsK2tTeXZyV1UyaGE1?=
 =?utf-8?B?WjFnSlVndmNLL2FEK0hHd05uRC9zYmc5ZHdVUTExY21pTE5FUHpEcHhUMWU4?=
 =?utf-8?B?STQ2S01KT3JENHhSbndHS0lhazg1VUtKTEtnd0l3K0ZxTEtBdWNLMERGeXRh?=
 =?utf-8?B?d2F1QmVOODJiSXdYVjZic1NoVXNiMjhBaGtGeDJ1T0dlUXRTMUd4SkFOQ2x3?=
 =?utf-8?Q?/C6IlyAGhmy97?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG96S1h3cElRcDV2OHVRNWFuclVaTG9MYm5QdlRJZ3RydGtEQUs4cUE0Q2Jr?=
 =?utf-8?B?UUFGVnEvVFMzVU9OZ0VvMmFpR0U3T0VhQU5YVHMyeUxSMjUvNGNvVnpmZ3pE?=
 =?utf-8?B?RlY4ekVSN0MvbXV5V05tYnRKNHlnMTZnMlFpK1FFTkpSSjJHdmxOcTdGZVln?=
 =?utf-8?B?aHZKMGdwdzdzd0ZrTkRqRnpBQkVRM0ZXK2tTMnlUTngyaWxtRWNmeGhwa2lF?=
 =?utf-8?B?cUpneTVVQ3hlK2JmOFlFZWx4bitPQ09rTVVtWU1FTEZ1bkd1enpEY3NrcG8x?=
 =?utf-8?B?cGUvd2EvTEl4ek5QdGFHcldPL05OWFlWSDlWVHZ5SHFweVFMb1l1Ry9Kb0xm?=
 =?utf-8?B?bnUySDZsZmNPc1kwa0tOQmk1bzEvZ1JRYWJjcFNOV0wrU2pVdlZqeDUweU1i?=
 =?utf-8?B?bTc3bGFzcllUS1AzQjJFbVNrV3ZGOTBXMmd5QnJyTmF6L25QUksvcitkSkg1?=
 =?utf-8?B?TzArV2JJYjVuWlNxeTFITUdaaVNxRkFmeTVQbXpuWE02TEdTRytydkxTK0pL?=
 =?utf-8?B?SXlWMnZCbGZxQUJOOHFJU2d2T2dQM1lyV0Y1VjQrUjVUbDRWVHFUaHRmczgx?=
 =?utf-8?B?cnI4NjYzVUZvTCt5VDJoRVBDaElzOWY1eG9aTFhRdzNidjB6Zlh0WDYrNkJW?=
 =?utf-8?B?NXBvZ1FwRkNjcGUyeVUveFNoQXgyWU82WEpkZnVCNmlKTHEvTE9FTzNQTG83?=
 =?utf-8?B?UWs5bVZGSG1MekphbVBrU1IvTWF2aGtmK2VUeVFhTE5BWlMrQ1BTMzlEU3Ev?=
 =?utf-8?B?VWxXUjhGdGV1VHlpOGZzYURIQ2xaZDYxYzd5bzZSd010WGtqOHNXNFd4WmZP?=
 =?utf-8?B?RXNvMkVmT29NbGdMWnBVZ3h4Y2NkME1LMFFEdG52YUlNSkdHdFlWV29qMXR4?=
 =?utf-8?B?WmdsQVdqb05OcnJWNDBHaFZxVXNhVTByQ24zWWU5YkJJWlp0TW12MEE3VkJ2?=
 =?utf-8?B?VXBKSHdXOUlCVEZhR0pobzQzZ1JyZEVIeSticW9PTGlFSVJEeXE4UitOWE9C?=
 =?utf-8?B?cEkxM290NWpZM294cEg4SG11bzhTQ3huc0FkUE9EeFk0OXFXcnNEakoxaSs3?=
 =?utf-8?B?UjB1Nkc5NTNKaVZXZXVGVnZRRWJrZHBpNlVTQzRqdndnWTVmNjJnTUt0ZGt5?=
 =?utf-8?B?ckxkMGR5U3pRRVAwMWs5THJoZ1A5TzExTHd3c2RXNENiOW9VK1VLUmVQSXRS?=
 =?utf-8?B?eEpiRVpaeFFYQ3FSaGlpOVVpMjAydXE2b2xLWEZGZmUxbjV5QnBtWFl5OHkr?=
 =?utf-8?B?WXp2WUxLVzFYdXhqWTk4TzJxTEgzRXBtQ09ndEFUU2YzQ05JY3pjd0FHdzlz?=
 =?utf-8?B?VTJxTnduL08xTjk4dDM2TTM0S0UzOVB5VW5IUXRsOTN6QWxIL2s2Y2Mrblo3?=
 =?utf-8?B?YmtSdmloTjlCRnBENjFvZmd0WGkzakFZNzdwcWJmc2VWSktZZm96aG5neWRF?=
 =?utf-8?B?K0tPSTNTR2Z6VHl4SVBMU1UxNVNUV3hHK3pZME9SNGVUd1c5TXp3ZGIvdXNh?=
 =?utf-8?B?NkpLZ2tDTXA1WW9mNDhRRlJuSm5lQzdBaGRPMUlmSk0xMFVlZjg5dnVlUW1s?=
 =?utf-8?B?a1Q2eEdOMTR5ZDk0a2JPR2krOU4rSWxPSmFnUiszYkIwUWNsWXFZQ3BKSTNM?=
 =?utf-8?B?bndZYU8zNlJoejdhNGpjdWd2ZWFyUDlOaGhPWTVSVnpoZmVVQ2VOTjJDMEs5?=
 =?utf-8?B?c0kzaVV6TGg3bDExQkVtUGdNa1RTMjNuY0tBaXJyQ0Q5RmUvRWxaQmthbnRL?=
 =?utf-8?B?MXdmQlBvTUFGd1plQU92Q05hYnRUaEs3NnpkQlBHVUs4OHVhVXd3Y0xkVnlt?=
 =?utf-8?B?dmVjQTkrbFdsdjk0Z0RRam9ONG5MalJVblFXdXY2c3Vqa25reHVHdWoxRGgv?=
 =?utf-8?B?YmEyOXh4eFZObnRIQU84Wm51NVBKbUU2VDUxRFZpMUhYSUJIMzBUVUloZmF0?=
 =?utf-8?B?M0t5Y0RwRVY1bytsc2ovbjhJbEVrVzlzWkI4ZWdhZDdUM0huSVB6bmIrNGpj?=
 =?utf-8?B?SkZCYWJhR0p4UVB6NWMvckY1bnc3NGhPaXhqYlU2OWtDYVozd2xyODh4V0RK?=
 =?utf-8?B?S0lmSFBXVXpPamtRVXBkd0lOeEh5aGNRRFBtR0ppWXNBUXZDYUVEZHJQMXlp?=
 =?utf-8?Q?G7hJ6c7uxkxSwy/arCwXxiAVF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BqOzYb/UoPkL5dL2JL9Q/BQPPGumyPAGg67QKu0GpHr1UzlqFJ7uyaxxUc4u0SWNW7skS+f/FhgK/pNJOZbpKG8IcBFaKKCsQgKTXdRlufP6FdlMaj3o45EmGFyF3JluW/dToNIo+od9PV/NTa7DS4qYTccA38A6a62JK3jvj0d29Jh5VX9crB8hi4b6y91ILg4961nplBfzj19AK3ul+/MgDi74x7ufc4ztbxbImzu+idfhk6xJrKZxaAnS8OhKUN0WW10ZEh0TbGKN9A9+b+cRE4VCE8sughRWeehyWAknbighBQIyf4glpvUSrtLj4wYeVU9oyqJZW4B17CXqYp7lP5skgpGjxhKtEaMXzVkt58ZpbLowWTJ0uUDUvYs8m13RxjU4VKdtgPNGZMLRw5XL2UUfrabVfcBi1OtKpht3gSHfGMbDzDSrXXfTdyuujQMdQ83gFPMQ3M7fDWeaczutYr7yXDsTc+mp7m3en7wyVGzEz7tY9Iq4cMF7AtlDSImUpa8Dz6VtJUPExwDWf/Nnnt7gluEppGMh6Qp01SrXeIQtt7qG1Sqnpufqo+WSef5IlXi22/ZyUyDSGRY54nLG6ZGbhYlRHra4gIg8y0o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e8ef4d3-3c58-4633-b471-08dd510da90c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:48:47.0738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BL7aBP0t5Kx534CO6z7PpO2yr/muUC0pygAzBcgH8GLGbgVUgD4hxJ9WzfD8aWwqHwhRbuRl3Ok+tIug1zKmlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502190138
X-Proofpoint-ORIG-GUID: dBzaC33CaNz8mWtnYE3uXj0m0mgPWu4I
X-Proofpoint-GUID: dBzaC33CaNz8mWtnYE3uXj0m0mgPWu4I

On 2/19/25 12:46 PM, Anna Schumaker wrote:
> Hi Chuck,
> 
> On Tue, Feb 18, 2025 at 1:10 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On 2/10/25 2:48 PM, Chuck Lever wrote:
>>> On 2/3/25 10:03 PM, Gustavo A. R. Silva wrote:
>>>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>>>> getting ready to enable it, globally.
>>>>
>>>> So, in order to avoid ending up with a flexible-array member in the
>>>> middle of other structs, we use the `struct_group_tagged()` helper
>>>> to create a new tagged `struct posix_acl_hdr`. This structure
>>>> groups together all the members of the flexible `struct posix_acl`
>>>> except the flexible array.
>>>>
>>>> As a result, the array is effectively separated from the rest of the
>>>> members without modifying the memory layout of the flexible structure.
>>>> We then change the type of the middle struct member currently causing
>>>> trouble from `struct posix_acl` to `struct posix_acl_hdr`.
>>>>
>>>> We also want to ensure that when new members need to be added to the
>>>> flexible structure, they are always included within the newly created
>>>> tagged struct. For this, we use `static_assert()`. This ensures that the
>>>> memory layout for both the flexible structure and the new tagged struct
>>>> is the same after any changes.
>>>>
>>>> This approach avoids having to implement `struct posix_acl_hdr` as a
>>>> completely separate structure, thus preventing having to maintain two
>>>> independent but basically identical structures, closing the door to
>>>> potential bugs in the future.
>>>>
>>>> We also use `container_of()` whenever we need to retrieve a pointer to
>>>> the flexible structure, through which we can access the flexible-array
>>>> member, if necessary.
>>>>
>>>> So, with these changes, fix the following warning:
>>>>
>>>> fs/nfs_common/nfsacl.c:45:26: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>>>
>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>> ---
>>>>  fs/nfs_common/nfsacl.c    |  8 +++++---
>>>>  include/linux/posix_acl.h | 11 ++++++++---
>>>>  2 files changed, 13 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
>>>> index ea382b75b26c..e2eaac14fd8e 100644
>>>> --- a/fs/nfs_common/nfsacl.c
>>>> +++ b/fs/nfs_common/nfsacl.c
>>>> @@ -42,7 +42,7 @@ struct nfsacl_encode_desc {
>>>>  };
>>>>
>>>>  struct nfsacl_simple_acl {
>>>> -    struct posix_acl acl;
>>>> +    struct posix_acl_hdr acl;
>>>>      struct posix_acl_entry ace[4];
>>>>  };
>>>>
>>>> @@ -112,7 +112,8 @@ int nfsacl_encode(struct xdr_buf *buf, unsigned int base, struct inode *inode,
>>>>          xdr_encode_word(buf, base, entries))
>>>>              return -EINVAL;
>>>>      if (encode_entries && acl && acl->a_count == 3) {
>>>> -            struct posix_acl *acl2 = &aclbuf.acl;
>>>> +            struct posix_acl *acl2 =
>>>> +                    container_of(&aclbuf.acl, struct posix_acl, hdr);
>>>>
>>>>              /* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
>>>>               * invoked in contexts where a memory allocation failure is
>>>> @@ -177,7 +178,8 @@ bool nfs_stream_encode_acl(struct xdr_stream *xdr, struct inode *inode,
>>>>              return false;
>>>>
>>>>      if (encode_entries && acl && acl->a_count == 3) {
>>>> -            struct posix_acl *acl2 = &aclbuf.acl;
>>>> +            struct posix_acl *acl2 =
>>>> +                    container_of(&aclbuf.acl, struct posix_acl, hdr);
>>>>
>>>>              /* Avoid the use of posix_acl_alloc().  nfsacl_encode() is
>>>>               * invoked in contexts where a memory allocation failure is
>>>> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
>>>> index e2d47eb1a7f3..62d497763e25 100644
>>>> --- a/include/linux/posix_acl.h
>>>> +++ b/include/linux/posix_acl.h
>>>> @@ -27,11 +27,16 @@ struct posix_acl_entry {
>>>>  };
>>>>
>>>>  struct posix_acl {
>>>> -    refcount_t              a_refcount;
>>>> -    unsigned int            a_count;
>>>> -    struct rcu_head         a_rcu;
>>>> +    /* New members MUST be added within the struct_group() macro below. */
>>>> +    struct_group_tagged(posix_acl_hdr, hdr,
>>>> +            refcount_t              a_refcount;
>>>> +            unsigned int            a_count;
>>>> +            struct rcu_head         a_rcu;
>>>> +    );
>>>>      struct posix_acl_entry  a_entries[] __counted_by(a_count);
>>>>  };
>>>> +static_assert(offsetof(struct posix_acl, a_entries) == sizeof(struct posix_acl_hdr),
>>>> +          "struct member likely outside of struct_group_tagged()");
>>>>
>>>>  #define FOREACH_ACL_ENTRY(pa, acl, pe) \
>>>>      for(pa=(acl)->a_entries, pe=pa+(acl)->a_count; pa<pe; pa++)
>>>
>>> Trond, Anna -
>>>
>>> Let me know if I need to take this one via the NFSD tree. If not,
>>>
>>> Acked-by: Chuck Lever <chuck.lever@oracle.com>
>>
>> Gentle ping: Still waiting for a response.
> 
> If you want it, it's yours! :)
> 
> I am planning a bugfixes pull request soon, so I don't mind taking it
> if you don't have anything else planned for 6.14 at the moment.

This change doesn't look like a "fix" to me, so I would include it in
nfsd-testing / nfsd-next, as long as you (or Trond) can send me an
Acked-by.


-- 
Chuck Lever

