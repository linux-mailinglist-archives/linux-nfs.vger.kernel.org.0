Return-Path: <linux-nfs+bounces-10460-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAB2A4E43A
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4696316FF6B
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9CD293B44;
	Tue,  4 Mar 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iQ6muCsa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rpo3KIva"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195128152D;
	Tue,  4 Mar 2025 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102168; cv=fail; b=Z0e7KBZo0lktw1lKk4UIFdWKvYBX5cy6WZy1L1uzJm5j8r+3o2RIRAV/Sgtj9aX7yP4u1uA4o8fegB9vcdNZTGCt9RZKHONeAvDf6s++0hvKgwKDCrjn8cLeZNGEj/Y6k3UdLzz+EFGRrXGyIiBTSbTO3Sj16MaEn3c6Hhe0tWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102168; c=relaxed/simple;
	bh=Pi45Mr1XAjRjtvcUYupasw5+gR9WufEf9faWuHit9OA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sdMk2JQH68wp98CxNWpGyjWI8malXND05h5YkmaKsG3yHjIVJzURgvP9v++aJI/5VT1i6JahqinFEs9iOiH4D6NWcgFSlqftyEqNSnaMxaMFnxCV4xZ9ZUgW9BK3YaygepfWSpnmf/ypQnl5V42eMBEU8/8I/xqiYdKEQA0Pa7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iQ6muCsa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rpo3KIva; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524CauXK013683;
	Tue, 4 Mar 2025 15:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=dLMMswp41cW9Bzpwte9zDBIjK0OYSGDOp2JO7mexJWA=; b=
	iQ6muCsarL7uwFozzVWZMFMUbbnD1lC8Z9xhB7yRMWaZ2bYPV0Oh7nc5uWXQJujp
	/FlozXSuU2xgbe25RrPn0UVwOpAXwYpXrdC4U7FaHn334tg0S+Y45dZ2LCrsgwn5
	+3pzX71bSPWnxwtu60TlTX0FYZXCVSldEmMCyhdi9IMiALN/GlTyEW8vbbWEjh8c
	QH/HkRwdCJgP9lftF2t55nojPmTW+KOmx1xY6iEDoPXglNLTCNVsbKz65YcIFjGB
	4++o7NqjZvAkvgR5oUuV4Hbir3IPj77Et5wihitew8grAc2F/V8QW3Q2gmhEi0Z3
	U8tEU+dHWvpxBr84KTk7pw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wnckj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 15:29:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 524EqFXu011048;
	Tue, 4 Mar 2025 15:29:15 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpamrx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Mar 2025 15:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgSXaUjMRLmrvBlBPRhNglTCpEovtaNHg63DxVMZKyy12JXsQuBWDhhgSh6OESuQEJx4ZeuDtosk0gLD2IEM1WXXG244NnN9n+GPTK0H9FSY2eyubj13MwanXDLuTzJ/XCXhTiBLpZDt3Op6BQUELLc+c6d+o0sOnDQ51jpPB/12GRulDVHzi/+Suo4TgPQ9vRCVTs4JY7XaTpcNMpsx4a2tVCtjSDOvUOmNbz0YH8sCK8e9aEepXq22LkUyJkoFSK9RlecaAVQwghyoy6fZm/ObPCKrVGha1Ta6uRxUiWH/e1W48qqA6TKy6edAntKcCGstNINcFg1DJ2zLOgr61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLMMswp41cW9Bzpwte9zDBIjK0OYSGDOp2JO7mexJWA=;
 b=trKCFoS4hMz0TZCP5ktDNdMaxY9AdCKHcdL22ZnFErMreAgxokjQxkfltqALWbi11rDiqD8Eee6v1mwfxmVbjzBGH5OZ7clKBJmNvR8FA2jge1vUf2bUkRsKIomsjdWmRs/a5E5wrNb272NtZyRRiXLAk9Fqy/UVNmHsSQ4b8xCPEuYWvTP4yloH8ojbAvk43WwkRxQdmbp0TEMOZHvNTxReCaYNmXpMDP9KR3DTsWphrqD4SalRDw/b+TxOKA7EjhPANm8doO3sbKoN6b67LRFTXDB/yoZU6enIudBgfrmU0q/FzRiRR0QevsBEF4NTUjJlzQc6q8c7HEprvNtuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLMMswp41cW9Bzpwte9zDBIjK0OYSGDOp2JO7mexJWA=;
 b=rpo3KIvaK9KDgwcR8xNpwl6Y8iZkr0lNasVnfcP/wsP57An/7rkEzrsEmfizG69osc44Ad1ORbjC9nMhZrAeSyx7PUCSh+BEgIRuC90vxSCpHycva1dDL12LtVeg1uZ80pN3yrG4BdLfI4sVuF72Ek7ogZ0Z5FUZtBFxrmBtlaQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6226.namprd10.prod.outlook.com (2603:10b6:510:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 15:29:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 15:29:10 +0000
Message-ID: <4bb862cd-473f-4c38-91cb-d988314735ef@oracle.com>
Date: Tue, 4 Mar 2025 10:29:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] nfsd: clean up if statement in
 nfsd4_close_open_stateid()
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
 <20250303-nfsd-cleanup-v1-4-14068e8f59c5@kernel.org>
 <ebbd3d0faa939d498eb3bc67c7ba9c2ae72f3e60.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ebbd3d0faa939d498eb3bc67c7ba9c2ae72f3e60.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:610:b1::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e14e2d-9085-421c-e885-08dd5b314fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU1YOU5ackVnRWx4cXVrWEZoaFJ4S28wTnVpVGRLVWZ5dFBOUWNUSUF6T29Z?=
 =?utf-8?B?MUdLRnJEbWFOSGhqbmNQaFNQY01yQVBBQVhCdm1UUFU2azVJOEd3ZjR0eXVG?=
 =?utf-8?B?UnpKYWdzb0h2VmNpMTFud3FxL0VUeENzMGIxbFBFdk05S1JKeHIrUjdhalB4?=
 =?utf-8?B?WVliWmpwMlgxbGd1b3Fhd1VaVXkvY2R3anBxOHk1emZMRzB6VGt1RmdnQlpm?=
 =?utf-8?B?dUFVL3EvblcrOVk5OWVaUzVGK2lKR0g0VGh0ZzE3ODB3ejZNbmh0T3dSbDNG?=
 =?utf-8?B?QWg5TStpQVhtMSttMG9pTU1PYlhXbFZUZFN5ZGNLak8rV1NmUG9xZk1LU0hr?=
 =?utf-8?B?WWd3MVFDbnVhOHd1S2hycG5IaEo3YVlQTHEvdTRBQnBQVFBxUGMxd1FpOWNR?=
 =?utf-8?B?NDdMWHVnTFBsUGF2eC9HZWxMUkJzeURSQXNNZSs1UjczaFA5bFJYa0VuK2sw?=
 =?utf-8?B?V0dKbXJSWENzdDJDNmNhSHcrZUhubm5Wbmo0dmMwMHdiNllaTWFwRXhHVktv?=
 =?utf-8?B?dUs0NklRL3V2ZkZzUXRuRjJzTldMVmFNOC9jbjdxQ2Uyak9jR0NFb0xTT1pZ?=
 =?utf-8?B?Tkd2dzkvdk4vZjhWMlRiT3lmWDNONk9rSDlpZDJmd3dHVlZnSGN0SGxtSmgv?=
 =?utf-8?B?bHFIajJYWkliRzdRdkd4M1NrN2dXcFdrT05ia3JRUlc5L1Y0UEowd21oY3pW?=
 =?utf-8?B?bHlGcW9ndzFUZDVzZTJtazJmYjU3bTh0YUNZZVJLRXgyWWhjQVNzWGxvbFlF?=
 =?utf-8?B?YUNnaWtEOU1rMFFJY3ZiVzlaOTljTzZSMzhCRGRTQTNFTkhHL1MwWWRPd1Nk?=
 =?utf-8?B?UUNjdVhKM0VrS3BvQ0FtL3IwTTBzU1hsQURSSEovbytVVFJDNmtvcDNEdDNI?=
 =?utf-8?B?RkRXbUZBeVVFOHBGRlo4bE9MWFlrNFNJV3RyZ2RyMGdVWEY5VEN4NHF0YWdS?=
 =?utf-8?B?elR1WjJySHVyT3dwQkdldmorc29wVzZTUXQyaXN2ZlZUZUpTWFBQV3RqeGZn?=
 =?utf-8?B?UzdGWWZDdlFKRFNmL3dJSERFbDhacktMcTY1YWlWOFVYdmM0WWVkZ2QvY2VH?=
 =?utf-8?B?Qk9xS292ZVlEOUlOeU1VaXEyK1ArQ21HYlpMa1puN1I3NjRMVEFQMmhQVlBV?=
 =?utf-8?B?Y1Fwb3pOVldGcFZWNUovc3B3YTZlRnp3bGs0VWsvckhsMThuUjVVOVVHcEtl?=
 =?utf-8?B?bEQ5NWpOSmZnQTVtdURVbFhJR3U3K2NxWmJHSTNNZzErczRqS0lkQlpkditk?=
 =?utf-8?B?MVAwYXEvVHlMeEJ3WlY4dFVrTDFnUFZOaGhuR212N0lEQThGaUFEZnpORWxU?=
 =?utf-8?B?WXkwOGN6VUh5TlFIdTlaVnc2VnpMOGE2eVNGdldXWmNwTjlTelE1Q1FFdzJR?=
 =?utf-8?B?ejhWL1FiQlhtcEtYeGZYSUM4cCtGdEZHSU9weWRpaDc5SGlvWDV6TG5OOHpv?=
 =?utf-8?B?a1o0bENkdDFjT0xqdUFCeDJBUCttd3NudVh3MTE4bFNValBQTWVJcG9JNCtC?=
 =?utf-8?B?ZWVrZ0JkRHFnOWdEdlU4VTR6WmQ5ZXc5QkJhSVJmamQ5RWhXK0pUV0daUDRB?=
 =?utf-8?B?dzlzMmVJOHYzUzc5QTUyS1FzYU01c1FCSGF6UFRnWkRGQmdqMWQ2dFQ0QnV0?=
 =?utf-8?B?MDlSdVBadzdmdVhEYzV5dUVqMWg1SitEbmhqUlYyZk4rQ2UrN1hiaE91c2d6?=
 =?utf-8?B?V3l5TEpub0VVbkora3N0SExBcFBIQ0xRMldUM2o3a2ZmZHpsb3NVNnhYblZ1?=
 =?utf-8?B?OVRzbk4vK0RYTExWVHdYNExIUnlsN21GMEhtVWhveGxyNEFVajdmS2tiR3Fn?=
 =?utf-8?B?eGZLSkQ3YW94c3dWb29HRDdOM2dxS1NGR0xGMS9lMmYwOENiM3pEZCtjbDR3?=
 =?utf-8?Q?r9sFdD0YANPSE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWRkZGtCcTlRbjJ0eVBUeVQ4OU1sUlU3ZWo0Q1N0VzJpTG1weFZpcVhBVWt4?=
 =?utf-8?B?SUFOU1ZuMzNaS0dKdGRzT21UWUI2OUtUR3Q5b2VrM3NrdXJ6aDFLbHF4TG9r?=
 =?utf-8?B?Vk9CcENHTzNLTzdSQnRLUW92V2I0Z29rcmtzeEltUGowOTlIRkliU05MdHBT?=
 =?utf-8?B?SlBpNmdXc2pwc29EaFhBOVV4WnFuaHU2UVNLMFlzbEgzR3RzUUdzbmJHajd5?=
 =?utf-8?B?RnZveDR5bnIyOTA1eEVoNTVUdmk2UFpuUGZsQklsM2dQVnpyTVFiNzFMTzZm?=
 =?utf-8?B?QWdqV3NoVE9FeUlESm94S2NjbVVlYlNtU3FyY3hxSnphNlVOK0FQV0xzTGJw?=
 =?utf-8?B?YVZDTTN4cUhJNHVtQVZzaVdBdUVEN21XNXErazlEMm04Qkg2S1ZQL096SHpH?=
 =?utf-8?B?aW9TRVgxc01vRktXRU9UMXJnZWlSUVIxUVFVb0dvbGlHZXcxTmNrQTZWOFhF?=
 =?utf-8?B?R2RTWjdadndJWCtvZDdiWWtNMytERmRUMlB3OEM4Z05ldkdZcHhnT01sK1hi?=
 =?utf-8?B?VEdzTHJ2OElWNHpqWWc1cG5nZXJ0RzNPai9Zb3dPWCsrQWtrdXc5eEM5RmdG?=
 =?utf-8?B?dUVUL2YraEcvUnllK3JGdnRZNVNHMGNHVmtHdDJ5R205Y0ZzTEFCYmpWZWVN?=
 =?utf-8?B?N3diZ2pDMitrSU9YYTcxQ1VlK3pHdUh1QTRtTUxvbnFvQTR2OGtyZHo3TzR5?=
 =?utf-8?B?Tk54ZkpYK1FRV29OR0Z1aFNoUVYwRXFtcDdYdUpsVEpLSzdCVUpabjY0a0Va?=
 =?utf-8?B?Q1pnTkl6U1F4alBPOWZ6K0FkWmVMS0F0andWN1FYbGRYeUx0QTMxRnlweXFY?=
 =?utf-8?B?NWtYd3FvUVE3NTNxaVIvNjdTeElXSHQvSWF3YVVraENxT1kybDU1aU8yeWQz?=
 =?utf-8?B?bW8rVnBwbUNHSTFoa3ZJM3ZsL2dzSi9rSUxDS0dJZE9KS2dzOGlxR1kzU2o5?=
 =?utf-8?B?bmVXdHhSeUZQcTFXVG5pR0hwTytjYnY1L281bFNsa0xaK2pTM0QrRmFFTDly?=
 =?utf-8?B?L0V0ckhyYVgzNTZ2VElBUTdZOE1rNENSYW1vemFXNmU4Tng4R2FncmZSdnlw?=
 =?utf-8?B?aDl4YUJuNXE1NWZMOEorcVY5bkpwOHgrQ0V5a294bEk0dnBwYXVSeit2L1Nq?=
 =?utf-8?B?QmlJVmZ2T01EU0RLdWdPVW56WkVNRUFmMy9xUW1kOEZKK01PSU56WjRmTmRO?=
 =?utf-8?B?RlJQbGk4WGJyK2FBcGd2OW45VWN5REpGWmZQM3BhaHZxTFVpSWU5cmpOQTlJ?=
 =?utf-8?B?RE9DSkplQkZpeVcvTUlRUVJHSWZzbHovK3hrQUR5Zm9JMlRyR1p4bmJaV1do?=
 =?utf-8?B?OVhpV2RPQVdJOVVXV2MwQWFMdlFhVDFEeHdjdnVYRzRqWHE4dHYwYWpJTFJh?=
 =?utf-8?B?LzZyaGt0OWlDVzk1YkJsOXVHRUhvWE8rSVY0Z2pWckl0SFZ1dndQUmZlakFB?=
 =?utf-8?B?Zjh3Z0d6dHdnTzFxYiswdGF3TDhCc0RYTndZZ05ZSGxkTER2SmxHMEp0UGRD?=
 =?utf-8?B?Lys2TVhzdUcvMzdsakdPaS8zTnlseFl4akZWYTdWUHZDVjRxVjRvR200Z2du?=
 =?utf-8?B?SkV4eG8yOGh1aUFJR1lhVG1KMzlXcUZYcXA0Z3NMWGlBckdOR3hIMFVZSUFp?=
 =?utf-8?B?REFkMkpaT0NNdXZjRU5XdTgxYjVsVStYV0pPNUtWamtlQkh2ejIzOTA3ZFR4?=
 =?utf-8?B?YitacFdLR01zY251QUk4MGhCTWxaUkJsdXVjVzVyckFWWE80ZFpxOEhnUlRa?=
 =?utf-8?B?WTNzVk1TWm56UDNvMzc5TVZhZmJrdVIzTzJteU4vOG03UUoybkNaYzMreTRa?=
 =?utf-8?B?TWZwcTFzcjNrME5SOVhOQWR0ekVvSkdMNG5McFVQNHp4TlBycERxZ3Izcmtt?=
 =?utf-8?B?OXRMY3VjRTFHWHRsWjh1emtRUldxZEd1NmkvMHZ6Z3d1U2pVTVpvM0huZ29I?=
 =?utf-8?B?Z0pkdWZuYVFxUklXK0l4M2VGOUxYRkFUSVc0V2dOaGNDRXRLaTI4QUNyWC9u?=
 =?utf-8?B?U2VhaG9VZlF3ZDdGY0dtczd1dkhkQVhhQ2NCMXlpby9ORjZZcjBEU0wycDBX?=
 =?utf-8?B?RVVyeGQyYUJnWVUzNzBYandYc1RVYjlHejRxcmkrT3pTdE92eE9RNjdCd3Fr?=
 =?utf-8?B?WTVYWHo4WEZGZnpTOUFYRTNwV1NoK2hNREFXb2ZwckpwYTcyWlQ2T3pvMGs1?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1hGIIFnEXtT9UHvtPOz9DYQkk26w06lmiNbKiLgkFbqqjxptVmA95S9R62ZT0+EKws5PWeRV7Y0Oq9RU2ePIfQCgyfunDujiiHuOWTaOX7gqIN8nr6jHo+sUTOPSkkB7A7J/wDioyzW8EvCut9m/ju6g10CqjOD8o1wa3TvzbwYA2Y4kKPhEVnPHBVoOtV4MwDPuEfGGWP/6DI3jh12Iy5ZuCkKoV2gj6ioeat8D0OzRqUqvO1CQ6lsWXvjTyDVEZB9qplhv9A52ihRhQSUOL6onSXx9BwQLH8KrCxaZRwwanXt6ExeTHADRu3sDp5cSeLKvb/q5owaUJ9uz2ZEBGn4QmMNRRKc8jcJMBA/2hX00Cr34XSPcotAGqxAjQzECJ5heLuubmVFiAwDDwLdKpc57p7jqxSK1+3FbFNr6tAqQ3xTMkJLnyuZdCXJ7ljsDnsPnlLuCRu+SesOc8FVjp8rH8wlFGmJsVXZW3yyJye1FtY5uW+W17qxweOemNhl3gltswJ6ywofmdaa1MKbhMH6BQs/CFRB2/d849dAt9UBRQkHsNOJq+sdh8SBrDUsKnsw31EdeJAjvK5jjye0eT7MLGAf78abT1d2clMCaObQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e14e2d-9085-421c-e885-08dd5b314fd8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:29:10.9129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q62bGtjAclrirqRpAuf+Ox5SaXygGyYvf1Pf4z2RLCFyMbVn+gjYgi/rXOAyHMy3r6kRi4gLtNiDiTpx+zOKuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_06,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503040125
X-Proofpoint-ORIG-GUID: DCtf5-btEGmZ3mP1X22GOu9NERGMH1td
X-Proofpoint-GUID: DCtf5-btEGmZ3mP1X22GOu9NERGMH1td

On 3/4/25 10:24 AM, Jeff Layton wrote:
> On Mon, 2025-03-03 at 12:26 -0500, Jeff Layton wrote:
>> Just set unhashed to false in the one case where we return that
>> explicitly, and drop the else.
>>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>  fs/nfsd/nfs4state.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index a7bac93445e2fdbe743b77e66238d652094907cb..1f3e9d42fcd784ea8d101ad3549702a30dfe9058 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -7644,12 +7644,11 @@ static bool nfsd4_close_open_stateid(struct nfs4_ol_stateid *s)
>>  		list_for_each_entry(stp, &reaplist, st_locks)
>>  			nfs4_free_cpntf_statelist(clp->net, &stp->st_stid);
>>  		free_ol_stateid_reaplist(&reaplist);
>> -		return false;
>> -	} else {
>> -		spin_unlock(&clp->cl_lock);
>> -		free_ol_stateid_reaplist(&reaplist);
>> -		return unhashed;
>> +		unhashed = false;
>>  	}
>> +	spin_unlock(&clp->cl_lock);
>> +	free_ol_stateid_reaplist(&reaplist);
>> +	return unhashed;
>>  }
>>  
>>  /*
>>
> 
> My apologies, Chuck. This patch has a bug in it. Can you drop it from
> nfsd-testing? I may or may not send a replacement.

Done.


-- 
Chuck Lever

