Return-Path: <linux-nfs+bounces-15371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35223BEDA3B
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 21:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187B75E3A0E
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 19:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5723C28689F;
	Sat, 18 Oct 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MU322Cd5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qy0Hoe7a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263DE286D63
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815385; cv=fail; b=NCZDwItcH/SC4U4KCTHP15RQftulli9j/VUjxbXe6v9EFaWxA19xo7em4dxsc7Tgmv0X0eS43VCkmlLdRl0N0G34ZKr+imr4aIeWIAExmH/nI8iPgaJzBbGV5o+n6+ohfCfvBjJ0bHTGG3qJQ9zeqZWt1mFR2hF7F3+fNmzjcNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815385; c=relaxed/simple;
	bh=2x/9cxrA9QnTCSah1mcU0sr7Cn9CvIheiaXjqXZcMo8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jpBLJAvrRlGsgGdx+g8CL0umbF8HuIwRmozunabMnI5ZrWrTI+ILH/YJAk162lBJOQe7qqOJfyhE01zFqVBA/k8A3Sxb+zzbj/+/kERgXO+oTzkMeJt84q3pitcvdR+czK0JsSatrnVXZ71HfL43FZwrUPIaFXWUD5eEzERs7HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MU322Cd5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qy0Hoe7a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59ICgqkA016900;
	Sat, 18 Oct 2025 19:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/D+ZWHc03vbBmRvwVYHtGbkWEKHei1KZtY+4ewcKW/k=; b=
	MU322Cd5DGbLsTFLsimKn9PMeHasSZOD9aeUet69K1TwL5RYmXCfX2midSfBurv3
	0AEW5Rh9Zxcu5nLCgkvb/EccLsVuOtcnMPHpLrF/0Wm+yRpzRYsIpOdSIkQZ/g4S
	7oHtln4Btd+RxcKit6at4pem3WUE/MNhxwl64/EG4IPXOEl6RdNL/9t2pLLObMH6
	W6ao95yft9a1fmBl7Et8wvL9GR06ZnvcHQ3efYKc/IPete249XjuEd/FMUR0nL/G
	QLPlNrme0Wr78AbRdFZrdZIXmMjQfIx5BiW5XlazGsh1J3n3toD3q1LOajtGFb8U
	PUqfB8sT0dicqHWImD+JIQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3esgfj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:22:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59IIj47Y007196;
	Sat, 18 Oct 2025 19:22:55 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1b9qgtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Oct 2025 19:22:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaNxuI+rAIImPYl36dE40VW97/ap9+pVdw8ISMJ5TIybOmUTU7UcrNImSZQskcfwhPjC0HpLIfSBV27OAOUxGvgnCqtf2O94HmC+76ThK4fJhayoBBMZqMWiv58qnp1Me8ibejWaUPq6E2adMmOwY//yezoII18uW3OjS5HW4KaeTrTdBy+bRCy/sJ9OtrgfYWNzXjuA2HYcEgzbM7oX4Eg1r+9Z8vR8bvWoQrmSO1B1zoeRvq6QuoAACXqCt+aenMV3UxUJtVnt6f9HLS7ZayhkREKT29z5yS9HSSsf8/ZZcQecmnYrvzvCO3P9KYyT+np3uWVD8aBNxOIDQWUVAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/D+ZWHc03vbBmRvwVYHtGbkWEKHei1KZtY+4ewcKW/k=;
 b=hla4TjNVMbGPR0tP1McMVpnJXReFzjzaSWOBPxwK7aT5wrZ7wtSEJk2dh1xWm6F7GeT++MLeAEyIgSTiIokteEOFJQfgFatqTu5N+UhjQbXF7IZnivFSX0xDDGW7iIuKhH4ecVxMKW/Esjl09wqqhUBRQJZBTJH+vP0oD/GDuK1dsbucZOU/a70HK7pVVIJtTfn8BUIJJCkLmdH8kM5vcqx3pbGfyfuT5nWlqUc4H4kM7/oWDUwOldPtINmPWT9/wFACEGMabE1mSSyt5ptm7+0l8M3qAwC1nEVhDrMVQA/OeVCF6L6aoQI1FrOQVh2/EzIv2eO+VUeruzBCLI6jWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/D+ZWHc03vbBmRvwVYHtGbkWEKHei1KZtY+4ewcKW/k=;
 b=qy0Hoe7aW83P1H7zHiAyxQnpR+z+XHgoXhhzoe+z0p4SH9C7BllIBPf50mWZC5BGF0YjHTqH3wDRfLu4Hq2H+c0RcWJ0+LTroV3rCpQGlRPohnovyGEl7M/KznBJsdS4PzNbPq7TEx1chNtV/O82TscFQb95ro23Z0Kb1lz87J4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ5PPFD1D499C15.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Sat, 18 Oct
 2025 19:22:52 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9228.012; Sat, 18 Oct 2025
 19:22:52 +0000
Message-ID: <27844685-0132-4f65-b8cf-3ea058d783ae@oracle.com>
Date: Sat, 18 Oct 2025 15:22:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sunrpc/cache: improve RCU safety in cache_list walking.
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
References: <176074628319.1793333.3387532760794075868@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <176074628319.1793333.3387532760794075868@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0004.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ5PPFD1D499C15:EE_
X-MS-Office365-Filtering-Correlation-Id: 123b0ebd-c8e3-4bd7-b7e3-08de0e7bba41
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?ais4RWRpbzFyMzcwMWFOVWxmMGl2alcrQmsvNUtkM0dOM2greHVkZE1VUkR2?=
 =?utf-8?B?b2t2L2tDL2dXVGZVbVVzeE1KeWx5cmxKR3RnNG14RTRsNTJKYWdWN3RTSjFS?=
 =?utf-8?B?Y3d1UTlJUi9mSkhydzFnQitOelVNR0x3YzhseXRqYVV4SllwUURSMmZ5S0NI?=
 =?utf-8?B?VmszUnB5T09VT0V2MjFSZkVYMm5iRnVlci9EVmhmVVlCOHFtRWJ6WFNqVWRV?=
 =?utf-8?B?ZGRucFlOejhaVWFVM1lXTGJRK1MvSmRybEZEZVZJTWl5T0tXRkhaSkRPQStB?=
 =?utf-8?B?ekk3MFE1bC9jTDI4Slk2UEFXSlZnYWpWWE4rdGxXQmd1bHRBVkpRRVRlM1gz?=
 =?utf-8?B?MGNpa1JTVmhua2hkMWdUY05ha09ickxmY21RelREZk1ldDdtVWtqRURLUkk5?=
 =?utf-8?B?ZU04MjM2YWk4VGdMV2tHSkZVakFCSDBDQ2FTSjg1VW5yNnNNblJSbjluQmpo?=
 =?utf-8?B?TTBxYWRYUmo1cmZvRW5HZEQ2bk02YnZFNFNic2t0NG16dWtyVGJLZlRINkRN?=
 =?utf-8?B?Rml5SnZ2MDFkejhuYUs4M2x4MXJrTnVxeVNMWHB4eUxZUG1Rc0ZqY0c3K0tB?=
 =?utf-8?B?M3FtQU1FRXZvTlVSbENuWnVlWXZ6VEhJVGhxRVRKZVVTU0JBU25kRnowUTdE?=
 =?utf-8?B?K0U5TU01SWptcU15ekVEdWVFMlM5WmM4VlBncXdoOTFpd2daNVNrRDVFenZK?=
 =?utf-8?B?RURJWFA0N1E0cFAzd3lpQk5Wb0RFMFpzZEFqcnRMaHR3OHJGcmJmYnFSRE9S?=
 =?utf-8?B?VWNCNGRORkE4ODduYTVOeHBvMW5TS3dxTVJJcExSUFJIYVVubG9LZUR4VDh5?=
 =?utf-8?B?SHIya0hsZWxhS1hQU3ZmR1RES21sSDZJcWhPTk82TXY1ZWQ1TUNhbDBvSGNR?=
 =?utf-8?B?L3BmSnRUd1A1ZExmZjkzdzRHdGhkSDR0MWFBS1B0eitZek5Xcy9DZUVZR2k3?=
 =?utf-8?B?OWVoaHExa3JibS9JQmRUUWlvanYzanNyUjMzS3phb25yYm00SjRId2pVNzE0?=
 =?utf-8?B?S2VRbDZ1WlVhTyt6cy9LMjJ2aG5EcjJNZmtxRERjQVp5T1RyMmVZWElDb3B1?=
 =?utf-8?B?UmY3cmxmNmdBU2U5VzJiYzh3dDZxQlhMVGc3dk1Dd3lFdnIzbWU0ZnJCZmh2?=
 =?utf-8?B?NkRCSnFEM2dlQUpyM1ptTFl6di90ZnZvQTlVaWxFOG1jWXBmdHlnMG9La3Y1?=
 =?utf-8?B?S0lkdERyL0YrN1dUSjd4em5RTDRjelFZU1BtQkJ1czdwN2M3eXltZGJNa3lZ?=
 =?utf-8?B?UVBrQnVpdFovbjR4MTc0eHJJK1gwNFNhazN2cXBablRYTVFtRk5OTVZkd2lD?=
 =?utf-8?B?Qy9sbDN1MGZVV1lyUnkrakRVTnpmN1RBMW1SeFFHT1ZSQmFwaThCc2RzYXJt?=
 =?utf-8?B?MTFSeDlseUgxTCt1QkZoemJSam8zRXIvMjFJbHRoRVprYk1GenE5aGxrTUxU?=
 =?utf-8?B?bU9jMEo5KzNVaVRTQ0hUMmxnMnRkYUFaUDRpOFcvT0NXOU1xRE1wRXZUaFc0?=
 =?utf-8?B?R21DamRkZnUzNVNZN2U1eG9idXNObWpJUVdUaisxOWpwT2w4aXJqeXp2Q1Nh?=
 =?utf-8?B?Zmk0ZTFHSVl4QzBMTnl5RVd3VkRkQjczbEVCSWlDblhOV2lOSDBnUnBPcSth?=
 =?utf-8?B?dTRwamtvd1d4WXU0aUxTVGVxdnZ6c2VzZmJkUlhDcmNvR2pleWorSE9acWQz?=
 =?utf-8?B?WUtCRndOV1FEU1Y3UWUzamNtMFRrSUMxNnB5M2hOVm1SVzBOSUJjYUQ0d1BM?=
 =?utf-8?B?NXpra3Z2ZUttcURpNUM2ejNRRUM3aFR4RVJkZlRxcy9iNzFuVDFNV1ZwVkZK?=
 =?utf-8?B?Y21OcDFNalFqWFJ6eXNvcTJuMEJESG52d21IRjZYZlpXZkdzR2x6YldsMXF4?=
 =?utf-8?B?QWhQWEc2d1NGNXVUQUx1WlZoOUF1SDJ6K1ZwUmhIZTRMSk50Vm9yaU80Z2NY?=
 =?utf-8?Q?4TJZVwNqtqZLp7WoPKWd+UTht0HJtWuU?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?T3E3d1RkOTU0QjNtUy9oR3RLWmJZeW5YWDF6dXdlWU5HN0hKRWQrN1VhdDBX?=
 =?utf-8?B?YThMVklucDJoS2d5eEFxSVR3UU91TmxKZEh1WnZpNnJiY25uVWpMVHMrT3NP?=
 =?utf-8?B?d0ZwdkYrTldxZ202d0VMZXBKRXBJWTl1NDk3SERnQmNVbEVRZDBjSkxVeHdP?=
 =?utf-8?B?aEFqcmYyUjFOSUZQdHY2M1c1Wm9pNWtKOUkydjI2ZjltVTdwMnJGZTdScStS?=
 =?utf-8?B?bFo0VzdMTThZUlBpT1ZPejlyTmZ4OFZvYzJHdCt1SXFnSDJCa1gvR25SV21T?=
 =?utf-8?B?K0lKY21ETlBoTDNKUFlQZ2lnRk9TeUNIcHpDNlRpUzREem1tNzdjVFgrdHVh?=
 =?utf-8?B?bnJVa0ptbEsyeWNVaU9nc1dvZVdNMG5sWldGRG1OUGliOXdHM3lxSGFpbXNU?=
 =?utf-8?B?S1d4V2J4cTVWVnYxUDdEVW00YXVJMysvR0VpSnR3TG1reU9SdHlROGIxL3ZF?=
 =?utf-8?B?RUFVSXJDUFZQM2ZhNEd6N1RsdEdFQXhUbjAxc1hhbkR5ZVROcktCV0hzV2NT?=
 =?utf-8?B?SUxiN2J4TXgvWXBrSURSUXR6aEVpRDBONTZCY1BlRWt1aFoxOEpiMko1a2sz?=
 =?utf-8?B?TGFlZ0I2eG41RmF3Q3JRS2wraG4vTXJVSlg1a1pBTy80dldIL1UrRnJvRm5Q?=
 =?utf-8?B?USs5dVdKejI3ZllNdDM1bE5FVEExdWw0ME45dDRSbk1wS016YnZPSW4xTy9s?=
 =?utf-8?B?eFhJazlGV2wxckxqTEYwUjQ2aVN3RzVJQUYwcXJ4d0VHdk1pNjBES3NlSWxl?=
 =?utf-8?B?bk0rb0w1clhLbGxMaTJKRExab1lTUGdwRVljYStuSTZDQzNGSkdyL2l2cWZq?=
 =?utf-8?B?Z0p2NEpVUkViSmNCS2ZSWTRCeTc1S2laUTJlcEx5aEh0SGdLN3lVd3hDbzl4?=
 =?utf-8?B?VFp1WkduZjdpeU5zclhydUNQUmtNTElham5qMlZNNmVXZ2tlV0FpSjJPbDNu?=
 =?utf-8?B?TVN3cW1YTWVDUGp1TjhtSDM5TUhEOTBTTU9vaDRtejh4UHh1STVUcEhWNVVp?=
 =?utf-8?B?RDlwbGRaUGs4OVFLTkh6eWhhdkt5RTV1SzNhdGR4UEhHVDgvYkZlV0tsRmo5?=
 =?utf-8?B?Y1pkL21DTTY5QTY3b1E2MG0vc2tDZFNVM2tzUHdvMmFCby9BaTFtU1pwa1RB?=
 =?utf-8?B?VEl6R0R5N3pnaU92RFluTWVQNVZvS3dJTlZEZW5POERINmcyRys5Q3F0OUpF?=
 =?utf-8?B?RWtlalJVVUxsSWFMbHRJZC9DaFpieXF5c3MxZ3JIV3o2VjRkQWFBb09oVUdy?=
 =?utf-8?B?dS9wNk8vWWsyclQ2M2hoK3Z4UlNVbmFTN0twS3BmdjZaaGY2TnZFTVdTSkQz?=
 =?utf-8?B?T3YvUk9nV3dZdk5lODlrRWlsbXpJOVB6SUZmVG9HZXBya2pTbnBnQ2dxTWEx?=
 =?utf-8?B?bXB5bWFxT1oweHpkMVJxK3dNWkdpUWxFQlU2NW5wZGloV0lnU0ZxNXhTcXd6?=
 =?utf-8?B?c2cvUHZOV3hjRS9ESm4yamdWQk5IUWUyNjFjV1Nka0RMWTVZSkp1UEh3Y2R4?=
 =?utf-8?B?VkMvbFdtc0Z5elJsTmlDeGxNM3doTjIrTFljSW1XVitiWUN0ZFNjM2dFTy9x?=
 =?utf-8?B?bGRJRlgwdHd1d1BMNG5KS1luOEtiZEVITVd5cmlQSGFVcWhsRUZXVCtqQUVS?=
 =?utf-8?B?eUhrVEdVNk1VRVcydU9OSjRrNzduQXdKZzVzeHdoUlhha1RtRmdaWDVuQ2tJ?=
 =?utf-8?B?UlI5ZWtXeDRrY3NBR2dSTks0bUxDT2pUZTVLdDlLREgvdHIveFB0alArZmx5?=
 =?utf-8?B?bkF1RWgwMU9SV0hHV1NVVGFoYkNLUVg1TitsZEFFckN6dFV2K1gzQnJYL1hJ?=
 =?utf-8?B?TUpaZmprTjBVY3c4T1dzNnFyRWgzS1JLV01oL2VzQWh4RG5GSnhDcUJaTDkw?=
 =?utf-8?B?ZzhXQVlkY3VKWlkxelB3SEdEZE04Z2RVK3ZyWW4xWGFRZkVmWm9oNVlLN3Yr?=
 =?utf-8?B?ZUx0aFJiWm9pdURWczZ5ZWxwNWtheHFyVkxmcllKcW51aTQ3UzRINS9EYjc0?=
 =?utf-8?B?ZXpVd0ZPTjhaTll6ZktCekdFRmRYMXJkZ0YycXhrUDd2QUJUVC8xOS9rUHVO?=
 =?utf-8?B?TkhxYTBZTEpIbG4wajFlZHU4Q0ZDLzc4Zlh2NGZ3QU9ZMUVNS1ZERHdyWUpn?=
 =?utf-8?Q?E4WucLKVEft228dYbHuqg6A/2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ATGXSGDA2XCPt85l4+vmMQ6+rwEhThoHXjSIdauZuqW/t+ldgMG+bs48fcHdfsEpxiGxeN2+B3MgV3qlVIoJU4sQqgzp6DeNp/Vv+eJ0sPP9sPLRZkF/K33vz7ZIeocfyFrp2kLzK82VQ9NjfzuDCiBf8IrKBLBx+2AhbdUGmYzKdpWPBnszzVqCfPSnJ9bGeNPlSW0i2nbWo9rwTCfNC8Iztk9UwoqM/wVWuUf9NXWGbATi/RTPISuU0KRBgmUid2xlzvRLaQg3vqZI6ojwRJDRq+CqcErNEBtEEsALj7E1vPrN8pntzWZ/SAsKUcgnRr8kffVHvVR27ZfjQwkQaZzuTYELNq/teKqmtGx8mvRB4qRWFbGPZft494M/uXI2+ZJGMSiRtacwNDgfihLI8n4we7FSgWllUbPlrJ1zpHUEx5JgjbaCFdUaoDyryWaQPDPL8FZsAOEfIWlTI8SOXEPZ4xAuECzaIuy9CEiqiLPMlLPLZNZgthYjvEle1ndJ5fmsaJQtqhtUAUri8rkeeXTFR5NqelN7N2TtmWR/CKdWKKhEnTEhj5dHM3nrNbhNbh3FjxJXJzk/QbFjHep+gohmzBM95ow4jV3wgjw+ly4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123b0ebd-c8e3-4bd7-b7e3-08de0e7bba41
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 19:22:52.6403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BqKBMHWCgSyMzVHkYiTmm8aKQ9d1RB8mxboI5NNaHrqu0yx8awrNpvc0cOsHOEyYOu09g6SDOv85guS4UsfkJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD1D499C15
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510180140
X-Authority-Analysis: v=2.4 cv=N8Mk1m9B c=1 sm=1 tr=0 ts=68f3e90f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W1lE1KdKfeaGUqO04OsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sTzFygFB8zcphhrBG9yvdcheHktmbe7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfX6XOnv53XO2vI
 s8+KP8ZRqxdkriCk6ogYMOYDzPD2RoRjrfTzIh1xlPpyT2+B5NFXQAa75F9O15KBAD2uAVtD5R+
 citMcRCZmJQXAr1IKIwVOW+8alROs4X81RWZRT11M5cOar7GmXgvQ0hbrTeWQpe/y8soedixMZ5
 G1GegIePmHD8JGTLsqBf9PzciExijx9o4t2QQ6obSTJmrVhjH/iYzoZQ35vGDabWO4mmXteyVei
 0evoA+Ge1UEtegUZKKC4b0qr3W8k34SBbvhbe1Ztk/THUpsmiYyBD8zNGrTtkRgE5xkbrXR6SpI
 to2Bi7Ka0hrd6+q/cvGYlnNUaPTNi78zoaCEwsDJ4xzsEvAeWClrEK3SI56oPNvOJHWfaUWzNnZ
 GzzSVtIj8Bj/yqzQTtmEdtxmeBEtDw==
X-Proofpoint-GUID: sTzFygFB8zcphhrBG9yvdcheHktmbe7B

On 10/17/25 8:11 PM, NeilBrown wrote:
> 
> From: NeilBrown <neil@brown.name>
> 
> 1/ consistently use hlist_add_head_rcu() when adding to
>   the cachelist to reflect that fact that is can be concurrently
>   walked using RCU.  In fact hlist_add_head() has all the needed
>   barriers so this is no safety issue, primarily a clarity issue.
> 
> 2/ call cache_get() *before* adding the list with hlist_add_head_rcu().
>   It is generally safest to inc the refcount before publishing a
>   reference.  In this case it doesn't have any behavioural effect
>   as code which does an RCU walk does not depend on precision of
>   the refcount, and it will always be at least one.  But it look
>   more correct to use this order.
> 
> 3/ avoid possible races between NULL tests and hlist_entry_safe()
>    calls.  It is possible that a test will find that .next or .head
>    is not NULL, but hlist_entry_safe() will find that it is NULL.
>    This can lead to incorrect behaviour with the list-walk terminating
>    early.
>    It is safest to always call hlist_entry_safe() and test the result.
> 
>    Also simplify the *ppos calculation be simply assigning the hash
>    shifted 32, rather than masking out low bits and incrementing high
>    bits.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
> 
> I was looking at this code a while back while hunting for a bug that
> turned out to be somewhere else.
> I notice point 1 and 2 above and thought that while of little
> significance, I may as well fix them.  While examining the code more
> closely as part of preparing the patch I noticed point 3 which is a
> little more significant - clearly a bug but not particularly serious (I
> think).
> 
> NeilBrown

I wonder if this patch should be split for better bisectability.
Are the changes to the *ppos calculations dependent on the RCU changes?

One more nit below.


>  net/sunrpc/cache.c | 61 ++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 32 deletions(-)
> 
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index 131090f31e6a..1dc84522de45 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -133,11 +133,11 @@ static struct cache_head *sunrpc_cache_add_entry(struct cache_detail *detail,
>  		return tmp;
>  	}
>  
> +	cache_get(new);
>  	hlist_add_head_rcu(&new->cache_list, head);
>  	detail->entries++;
>  	if (detail->nextcheck > new->expiry_time)
>  		detail->nextcheck = new->expiry_time + 1;
> -	cache_get(new);
>  	spin_unlock(&detail->hash_lock);
>  
>  	if (freeme)
> @@ -232,9 +232,9 @@ struct cache_head *sunrpc_cache_update(struct cache_detail *detail,
>  
>  	spin_lock(&detail->hash_lock);
>  	cache_entry_update(detail, tmp, new);
> -	hlist_add_head(&tmp->cache_list, &detail->hash_table[hash]);
> -	detail->entries++;
>  	cache_get(tmp);
> +	hlist_add_head_rcu(&tmp->cache_list, &detail->hash_table[hash]);
> +	detail->entries++;
>  	cache_fresh_locked(tmp, new->expiry_time, detail);
>  	cache_fresh_locked(old, 0, detail);
>  	spin_unlock(&detail->hash_lock);
> @@ -1361,18 +1361,14 @@ static void *__cache_seq_start(struct seq_file *m, loff_t *pos)
>  	hlist_for_each_entry_rcu(ch, &cd->hash_table[hash], cache_list)
>  		if (!entry--)
>  			return ch;
> -	n &= ~((1LL<<32) - 1);
> -	do {
> -		hash++;
> -		n += 1LL<<32;
> -	} while(hash < cd->hash_size &&
> -		hlist_empty(&cd->hash_table[hash]));
> -	if (hash >= cd->hash_size)
> -		return NULL;
> -	*pos = n+1;
> -	return hlist_entry_safe(rcu_dereference_raw(
> +	ch = NULL;
> +	while (!ch && ++hash < cd->hash_size)
> +		ch = hlist_entry_safe(rcu_dereference(
>  				hlist_first_rcu(&cd->hash_table[hash])),
>  				struct cache_head, cache_list);
> +
> +	*pos = ((long long)hash << 32) + 1;
> +	return ch;
>  }
>  
>  static void *cache_seq_next(struct seq_file *m, void *p, loff_t *pos)
> @@ -1381,29 +1377,30 @@ static void *cache_seq_next(struct seq_file *m, void *p, loff_t *pos)
>  	int hash = (*pos >> 32);
>  	struct cache_detail *cd = m->private;
>  
> -	if (p == SEQ_START_TOKEN)
> +	if (p == SEQ_START_TOKEN) {
>  		hash = 0;
> -	else if (ch->cache_list.next == NULL) {
> -		hash++;
> -		*pos += 1LL<<32;
> -	} else {
> -		++*pos;
> -		return hlist_entry_safe(rcu_dereference_raw(
> -					hlist_next_rcu(&ch->cache_list)),
> -					struct cache_head, cache_list);
> +		ch = NULL;
>  	}
> -	*pos &= ~((1LL<<32) - 1);
> -	while (hash < cd->hash_size &&
> -	       hlist_empty(&cd->hash_table[hash])) {
> +	while (hash < cd->hash_size) {
> +		if (ch)
> +			ch = hlist_entry_safe(
> +				rcu_dereference(
> +					hlist_next_rcu(&ch->cache_list)),
> +				struct cache_head, cache_list);
> +		else
> +
> +			ch = hlist_entry_safe(
> +				rcu_dereference(
> +					hlist_first_rcu(&cd->hash_table[hash])),
> +				struct cache_head, cache_list);

Extraneous blank line added above.


> +		if (ch) {
> +			++*pos;
> +			return ch;
> +		}
>  		hash++;
> -		*pos += 1LL<<32;
> +		*pos = (long long)hash << 32;
>  	}
> -	if (hash >= cd->hash_size)
> -		return NULL;
> -	++*pos;
> -	return hlist_entry_safe(rcu_dereference_raw(
> -				hlist_first_rcu(&cd->hash_table[hash])),
> -				struct cache_head, cache_list);
> +	return NULL;
>  }
>  
>  void *cache_seq_start_rcu(struct seq_file *m, loff_t *pos)


-- 
Chuck Lever

