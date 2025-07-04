Return-Path: <linux-nfs+bounces-12901-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA584AF968D
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 17:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F05E1885DAC
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519F12C3251;
	Fri,  4 Jul 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lh/UYAor";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UbbK+OMR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861672BF01B
	for <linux-nfs@vger.kernel.org>; Fri,  4 Jul 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642021; cv=fail; b=OELh9ZVYVf0AP4K1bQxrSaa0kcrEOpESjYGzhqmqsWmFkXn8MNaZOOsXTWPIWvbA7vI+9RT+fjP2J6xKwrHkxZhArmFmK7EpbImm2xFr9dmzAzEBLcF7d+0y44J6MhmNJRQJL0y8sYe706/ECABTdhjaGr6mRiD1OaNkxMzFAM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642021; c=relaxed/simple;
	bh=OVWA5pHAwU6KYT1ZuCtl7WsrFdyynL37IrwXvY45nIE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J1vQwax9Dys5pKDXU4LEBEY+v6fOnT6jSrYzq6NIg8F16OdIeCvLmtH5JUj4FsYH2MebLaZM4UCAxbTnxHVR/sG/JkaOYU/IC3gURUVgItjiJkLP4IFE7IFxAOtOD9KIZVuwPYrOGLkkPrAEQJsvAw/jOjYm53x3FR5Q+YrgHQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lh/UYAor; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UbbK+OMR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5649Ysuq030722;
	Fri, 4 Jul 2025 15:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hYXlraRPDmzYDmHv/rOOAIn3j2lUVgUPiIWBovuMMG0=; b=
	lh/UYAorDbMI3S9zl4Ca3hVAFufatiZrsA4EM72/kxhySxRiTZHwDnGAViWTFHE2
	hOThAA2/QOBezaGSqLq2BJHfLcQT0NH2qQtv6rfRyWg0NlgKwzVhbZafYFYqNJsE
	mXQRPPaQ0ZkiuvJVGHgKT7fCvQJTmrEPIkhV8xzFfFe8mOj/FLFdsXoEoNZxOZFn
	7ISZch/BrlemNhshtWdIgyWgr7asbcAlA8QC5qwxM8dzCAo/HbXG/wthDt23YlCt
	nT18mqo3PV6udb+7jjbTvfFToL8sCQEhp5hwEX9KrtV46o9uZ2zTqUiWS6+IyIs7
	GfaaEoB+8hPn3+QlIFjYxQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j6tfjvdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 15:13:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 564DCWrf015090;
	Fri, 4 Jul 2025 15:13:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6udp3rs-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 15:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdVoGgpOKwo7UDqLeV66Avj6+YE1J8BcmUekUNcWdpdm+eb+WPpB/cLRLh40NkipNFYMRLmbgkGcze41C6ilp6xwtnVkbnxtsLAQDy0ZCEjBkCCRqTKcHmL88dH9cPRYjSRyk2Ymxk4+ld6/ucXCiwPmzq3guYh6u75YEfeuj26cVukTPGFcFrpLLBCu3TVaeGamuai9gGR/G3kV1Qrqx+BkgU/3dWt4I74prmDDh4LlxWdrlhIRVXBc7wzbyHdIUEYNZ8cn9WokTvV2J6IVY4XGh3p25hq70pIt5awfSg3bGLiN/hs/W6FVJ0uOBXpj/QJ9GVvirQs+2FXXHQKiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYXlraRPDmzYDmHv/rOOAIn3j2lUVgUPiIWBovuMMG0=;
 b=Iy8b3MHUH85IaUP2sos5zPRLWfC8Zvlp7HsNT4ecSIF3N/AQQHItFPLxcefpk/pYnbWfNwtCOH3//33bq5lnHazRDSgsMVM7nBUNUQpQG2SgukeneOtOM+LetMbDx9LTb5ovgAt9rh4jcoYbM65fEtP+kRtxzGCdLOGcmIPam07bnK34bUFfFP0qeHbihxXF5hGXLYwsYu4xO+mPqMjsZ5JwuqF9ElITj7WA8xq9CVYr8E9lEthOlJM2oS0TCHTcpGBtgflIxZwEVe+tzlrjBdxdYka1kXcesWbcqk4+q3ohAwV3ynIb7tkMeu4vr2DlvXjnBBnP8dHPqOCjaky0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYXlraRPDmzYDmHv/rOOAIn3j2lUVgUPiIWBovuMMG0=;
 b=UbbK+OMRKmoh1sNOjO2VvlHOm0/dPAUQpAVIdTxV6jdL6Lax8fv/Z1Q3XRSu9RhEb4dh5wf0RZ4ci48h2nXzWp84e+kmEibhnG8ukKN8gW25DsAaY5T55Xq7s3ccDuGEnNPSGTgy2BFPAlTqwEwxSidbbA+0bKqNK4HxzXOHElA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5541.namprd10.prod.outlook.com (2603:10b6:806:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.18; Fri, 4 Jul
 2025 15:13:15 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 15:13:15 +0000
Message-ID: <cfe836c0-2189-4452-89e8-8ffbe8f8e1ec@oracle.com>
Date: Fri, 4 Jul 2025 11:13:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nfsd: discard client_tracking_active and instead
 disable laundromat_work
To: NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Li Lingfeng <lilingfeng3@huawei.com>, Jeff Layton <jlayton@kernel.org>
References: <20250704072332.3278129-1-neil@brown.name>
 <20250704072332.3278129-3-neil@brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250704072332.3278129-3-neil@brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:610:cd::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5541:EE_
X-MS-Office365-Filtering-Correlation-Id: 997ae27e-d78c-46cc-b741-08ddbb0d4c73
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?c011SkdpMnRGTFRPYUtSRGYwNjVrRUxnbmo2RFdYa3lKN1J1ZHR1R0FraW9z?=
 =?utf-8?B?WXdGODdKQ0ErdU1pYkVlK2psWWxzT1RyZ2FOc2ZudFd5RThuQTZtcmlPbWgz?=
 =?utf-8?B?VlAyMy9FOGN0MGVSU3VRZ1RKREZRYTFhOHliUXRUNnE3NGdNSWppQ1U3dFlw?=
 =?utf-8?B?ZHFXeHJTKzAzbVVrTWdhN0t3VU81YVNhcWRQMElNckdRU0ZYeGlZbFEvcHVj?=
 =?utf-8?B?UnBpQjBRaDFsSU9ZTHYzQVBDK2NTQ0V5amFnemlwdkU2TmlVOGdmYnhPNWRy?=
 =?utf-8?B?NC95dmFpUzl2UzdGSGRLdlRPYmhjQUE2QjFPZXlNVXV6MFVkaDJuc0xPeVhC?=
 =?utf-8?B?Z21ieFlLN09ESTFidWVXVEVVWGxiMVE2U3Vva015OEpMUWJ6bWFVUkRYUVc3?=
 =?utf-8?B?U2hoY0RSVVdTNDVuN2x6dDE3a011QkpqNlRWanE5MFlhaUo4SGZOM24vamRC?=
 =?utf-8?B?Vmc2SCtVckhQZXdiWk9EMExUQ0c1clBseXBKUzdZeE9qWlJNUk83WThPMEdN?=
 =?utf-8?B?YUR3bVRoQTlTRGlQSFQxbEtvWnN4OEtwa0JnWi9HTE84NWswWm5qRzN3MGVa?=
 =?utf-8?B?L050T2czRlArakM0NmZSb2tMaVZ0eWpRNVNGR2NmTVRGN1BjZFpIcmcrdXow?=
 =?utf-8?B?SGs0ZkZ6WEd4WnozY0Q2dVpKWnpTRVF2R3hNS0VwYXF5ZHdjak45MnppcW0r?=
 =?utf-8?B?WStOOE1vSkFCOGtWRzA2anlMeGNEeS9NRktzQ1RVVmxDZG1CSU9VTkNJRTBq?=
 =?utf-8?B?eU5iY2w0Q1JaUytkRmt0VXZFd0JVOEttclhEMFVpNFlzMUFlZjdLeStkdVNT?=
 =?utf-8?B?YTIrb25oTURKWDBBNUV1Z1QwcmZqejhTU2sxNktsaGNMT3E1Nmt2S3ViQjNo?=
 =?utf-8?B?Y0tzbWVFVjFwd0pzWHhoSG5qY3hwVUVGdWNjR3JXbEtaMENad0c0Qit2K1Nv?=
 =?utf-8?B?QUJmSHRyYTZiK3BQak5TaXdHZEJkNWdCMkxkTHR0ODZIcXJPVlh1NG1pNndP?=
 =?utf-8?B?ZDB1NDNjdWtseHQrZk5NUUJ5cEsxVXNWczV2am9tNXYyTWsybGVTMUp3SU9j?=
 =?utf-8?B?UUh3Ri9leWRIY0hTblNJaGRuK1RqbHFCVzhLT1lqQ3Q1VktISVJkcm1hTEpB?=
 =?utf-8?B?ejdaNkxqMGZ4c3o1c0VlRitlNlpBSWprN2F6d1ErYTNWOGdIVklOeGlJTnRI?=
 =?utf-8?B?czZ2MGtDQmwyZ0xHU2JUa3ZuNm9xNldHb2hURDAzZ3V1N3Z2eVVrZFZFUGwx?=
 =?utf-8?B?bk1mKzVhY0gvakdoOGpvd0FxMDdKbEtsTHRYOHIwdDMzN285bUtDUEszeWNQ?=
 =?utf-8?B?MnpKZzd6S0dsUG9NTDdpbTVSTisxT0JQVmxBUzN1WWRoUVdoUlRTNXAwK0Mr?=
 =?utf-8?B?TWFRUWVsUmpPbDlFQ0FhbXd6dlF3SmMvOHlMM3VMOUJENGNLam9yYWJnUkNp?=
 =?utf-8?B?UEkwZ1VoUnY1d0NBSzRRNXNYSW9YTWw3NFZMYnM1U2plNExuOGFEdWhwNUt3?=
 =?utf-8?B?cmVFZkpyTXlBakJnZnV4NXA4YTRQY1FmdXd5QkR2Sm5ZOW9wL2N4QTcxR3ZJ?=
 =?utf-8?B?bW9zRnc4TnE4SlcrR2RZcDdHb0FpcjB4M25CVDBQQy9JbktXSytGTDUydjFo?=
 =?utf-8?B?ZDltQjA2MlpMYXVmdGM2UHVNZzZWTWtPeFVFZCtVM3Y4Y3pBc2JUc1J6OXlh?=
 =?utf-8?B?YmdyVFJJeHp2M3Q4YXVpNjB6dlZoQTdiV2ZrRFluWGZJTDNuTndrZnREYlJG?=
 =?utf-8?B?K3I0S3VYUHpRd3hIakJjUnNmMExIeWhYVzFQWFM0cUJlbUZMMEE4ZFBUZHlx?=
 =?utf-8?B?V3VNVlZnMkY0NThoWGlDdzNyU3pqUUhEc2VwQzBZeUJEblMvNXdZcGNuUndl?=
 =?utf-8?B?WGo1YVBIbG10MTRTSXE2aUV3L21xSTNoamhuUzZvU1VmTGlQOXU0aW1peUtE?=
 =?utf-8?Q?K9QsO/n7V24=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?STVCWTdwS1lweVpqbWRaWk1HQWc2a0Z1c1VaUjQxamJncmFtWkVGbFl2d3lx?=
 =?utf-8?B?My96Q2hyZVc4VDVCV1dZVEhaR3RaeFRLNHIrSW10YmRqS2t6TTdqM1VIQzFx?=
 =?utf-8?B?NGN4cEdjdUVrV05GVzM2bUV0cjRIZk15cUc1bllTK2pRZUtBdjFYMC9QMHlj?=
 =?utf-8?B?WFhvRHo2S2s2aFV5TjlvWEkycjJYWEJ0SGhINzZseVRqeXBGbmdNVUx3Sllr?=
 =?utf-8?B?Z2xFR0h0dHBibU84MUhpQXRWWU9QaFdYVGtTTmVPY1RHbkR5WHhNNmN2bmt1?=
 =?utf-8?B?NUFUMitxTHRzZ2JkWTdBb0RKTzVKUjdmQUN0akVFUUtzTjNZVjJlZkcvTE9H?=
 =?utf-8?B?YkJxYm84UGhDR2dMUlVjSzlqOW5NTld2MVJnMFZOakRFZ2YvY2RnWVRuaWpx?=
 =?utf-8?B?cXh1OFBxZGRHTXRHWkxwYjRVbTVyUUlBeUlYalRXWG84dWJYQXpSck95L0ty?=
 =?utf-8?B?Y1hUYUVndnpVRDJJR2RJSThsU0wyaVFhYkFmNEltTUZSUXpGTG9ydUdzMXJH?=
 =?utf-8?B?RmR1K0pGT3AzOVRIOFh4Y1pFUEYwSmM3cHlibUZrZHUrbEE1K0x3amM4dnl1?=
 =?utf-8?B?WWRSdG5ZSExQNm9zd3ZQMG9Wd0UyUnZ0cFJxby9FYUJtOHN1endNclZKTitF?=
 =?utf-8?B?Q0RtaDA4TXk3VnJPcFZCNW1KaUhnOFhoVW5DMFZ1V3dmUk5DbWVQL2tyMS9i?=
 =?utf-8?B?OGxSVTRBSE83M1JXUEVSM2RoK1JkbG1GZlU4MWJWdFB4dlpDOFlyZmE4WFND?=
 =?utf-8?B?RWFoRzdabzNTQ1hMdFl5TW50cytDTnRLbGIwVlVZc08rdVMwY1N2K2RVem1T?=
 =?utf-8?B?TXhBR3pxd01ILzBMRWVMbmt0S01FQ1FoVGk1ZXFVZG9PVVB3bGs5ekF2dC9h?=
 =?utf-8?B?L1czUHdXRTlTVTR3N3ZuQUh1SDhvZ2ZucUVUWGJLUUoyRmozcVBmV1dGQ0lu?=
 =?utf-8?B?THVUUHBVdllRZllxc1A0OW1qQktnNHBhbXppZHdBSzB1Qm82SGZFaFlIeW9Y?=
 =?utf-8?B?Z3kyYnc5bi8zR2ZUOWVQQjBOTVd3S2hna1Flcnpoa045NFVOSmI0OTRFQzJu?=
 =?utf-8?B?NWNFT1gva1UvdHVpbEVRVFo0cTRFbGdlNHgrWUtpTk9wRGJNeVp5d3Jhc0JW?=
 =?utf-8?B?RWRKVzM4ank0b0tOM3JqQkR2ekNnTE5LN2FYRFZXenU2endDVFdmOEdQdWVy?=
 =?utf-8?B?L25xSUxTSnMzYnV1Mmw3akxLYkE4QTR0ME1aSFFXa3kyUVlodm5sNTJobk5y?=
 =?utf-8?B?NkY4THdOYm14OWpuMXV0M2xIdHpGU21obXBYVXhNQ2R4eWtLUGFPdkdiSUdB?=
 =?utf-8?B?UEJhRFlNNjJQWlFWOHE3NVpsellhSGVra3RkYzV5dTFhRnA0cFJXM09EKysw?=
 =?utf-8?B?bVFZOUpqTUJDakFpblhJc0tsOENZV09kN0dNaHFtdmlpY2hrckx0R0RxTUF1?=
 =?utf-8?B?a25BOGljbTJTRnBoT1NrNFlZTVZ2aEUzTXcwK1F5Q3hmellzUlFNZXVrMVVr?=
 =?utf-8?B?eHR6RlIvaS91ZGxQY1dGZlowSzZCT1BmblBGajcrUWlwYUc4UHlNSUxXdW00?=
 =?utf-8?B?VGt3Q0hDQ2hibVVaSDY5MSt2SkJPMkczUWN0b3JkNEFKTzdxdnlIZ09RbWdE?=
 =?utf-8?B?K2pDZW1Sc0RNcmExS1dWaHJlWkNCVXBZdU15Qk9kRlNRWWFHSEM5ZkF6TDZW?=
 =?utf-8?B?WjNhRjN4UzYzaks3K1NIczcyYUNJTjZnbVlBR2hUN1FGeTRrczZZQlFnL1Nr?=
 =?utf-8?B?REtMNEQwRnNZemxlUXV1ZVpCR0NKM3dyNXFpZnQrN2ZVZUkvTm1YQWthK0JI?=
 =?utf-8?B?QVpHZnFGbXFYZXdUUC85ZWlxaCt1Qml5NjBwTmZ1Z1h3S2xpbTNDTXpjWThR?=
 =?utf-8?B?L2F6ZkYxMlh6MHF4NGQ0TTlIbkVpekxUdzgxZ3hSS2dpTUEyR0c0WXFmYUJj?=
 =?utf-8?B?aVlsaC9SUHFyR2xFb1lKSjNZSlgrTFNVT2hKNENrRlRNYUlXZWRxSFBUL0Ez?=
 =?utf-8?B?U3RWTjZRV3Z4Tm0rbGEyTnBZb2xLQ1NnQmRZOE1NQ0lZSy82T1lqMlo5bFk0?=
 =?utf-8?B?TWtpTS9waG16SW1nNGlmQlR3WkdqYmJielB2V2l6UUNIUS82SnhlazFCUEw0?=
 =?utf-8?Q?zkLs1x8wuH9Wo3Q6lChVtEoQ9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B9VWULjriOp2K2F65LMGTa+shbKy/BudrFf0V9YDimgYx+pycWex6d883AzikwpxNhxjRN5Nx+O8TPGigeuE64wnslzYKMtXr+MLnhdT6+GOIGh24/MnBDCSbS8PkUBmKE1FUzNRiw5P0h4E7WPfco1GO0gprNfjoqIRKNl3PKm0q2JlXvLr4y41ytjjg1fFHusQ/8CGm9IQBVKwKShtGMnTzvKi0ErTGn8d97BdbCZ4y3FTBNVR7Y9AVyOgURW1SRTFNxFZNA9w1qZBeNv/6lzjzvJIw+9KM6ujq1i4ROodxrKNsCMbyMR4muAtQl4jm6z+3WetPJuDKKp+06f2Wc9gAphnFI1ld749iDDEAaRsi4+36lyHwqk7yxj4pp7r/qAfwCUqQvmInmmL9yLXy6Uk3S8yqAhXmmMvE0wRzTiOBBZfP/avrHoDMZ1lcOgMhlHAmM0AfhjFihzpN05Gp/hWL/O6HsrhpZijrZFaDDZtomeWDtt28oeXwDiIkXmbYNLLbRJAkAvyQU/FfNie5a93F/UlBnhgFghjrJ3Tgdr2jYYvBioSHwxuB2g1ez/I6khPx4R7oHJlr33KNftZDdwzHRTONxqHHbxCjcTvgcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997ae27e-d78c-46cc-b741-08ddbb0d4c73
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 15:13:14.9750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aa1PQ7Aze2VtSqfdvfuYf3F9kJMphRfzMloWUS0cb5JHe39fkwoERzokZ3D55fsz1P7A8PdF3gb0wava49DYMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5541
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507040115
X-Authority-Analysis: v=2.4 cv=CMMqXQrD c=1 sm=1 tr=0 ts=6867ef8f b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ln_gdIdk0iQ8KoPi8CUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cwmKSege2oN_Kdm2fVJikOlf7g9OBR3D
X-Proofpoint-ORIG-GUID: cwmKSege2oN_Kdm2fVJikOlf7g9OBR3D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDExNSBTYWx0ZWRfXyfD7NOURzNqM Vr32eWXmo1dB9vdkVI3oUxVR0Xvn4ZCOJbL6qvH+K8epiUA4NZ7o/dk6wHY4TzsqGZvKBrCBROM AFgVlVwvqgE3mJe6ZvBU/6lP7dLxYcbWmIUwWEhDcxA26OAReip9Vw8PQCtWq+rO4nIXkbRQg6R
 JAZoxrim+H972NVnCRRqUk56l/xVKqmq/DQSsJN9x4kwHrLk1sZeRad+TEDiqWVCVrA6lUA+p/a s68Ti45XkUSII9gh4XF9gDUGqFdGXdBZX/j+cNcyc3oZy8JnkMpgfakS6XS6S8W8Kqucc1mRL7o RG//zbqLVa1qr7dV30WF2Rl2bYui8q+EtGZjLHNBL4Q72xpW6URMpGO67v0ltKlGQQauqveZwPJ
 8uUWogJg+bu4seMkO5Rpy0o/acIEK7mF6SpwvD3BvqIqZRCD4kau0DLjUUM1y6Zyuk9hjmeM

On 7/4/25 3:20 AM, NeilBrown wrote:
> We currently set client_tracking_active precisely when it is safe for
> laundromat_work to be scheduled.  It is possible to enable/disable
> laundromat_work, so we can do that instead of having a separate flag.
> 
> Doing this avoids overloading ->state_lock with a use that is only
> tangentially related to the other uses.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/netns.h     |  1 -
>  fs/nfsd/nfs4state.c | 24 ++++++++++--------------
>  2 files changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index fe8338735e7c..d83c68872c4c 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -67,7 +67,6 @@ struct nfsd_net {
>  	struct lock_manager nfsd4_manager;
>  	bool grace_ended;
>  	bool grace_end_forced;
> -	bool client_tracking_active;
>  	time64_t boot_time;
>  
>  	struct dentry *nfsd_client_dir;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 124fe4f669aa..db292ac473c6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6512,12 +6512,12 @@ nfsd4_force_end_grace(struct nfsd_net *nn)
>  {
>  	if (!nn->client_tracking_ops)
>  		return false;
> -	spin_lock(&nn->client_lock);
> -	if (nn->client_tracking_active) {
> -		nn->grace_end_forced = true;
> -		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> -	}
> -	spin_unlock(&nn->client_lock);
> +	/* laundromat_work must be initialised now, though it might be disabled */
> +	nn->grace_end_forced = true;
> +	/* This is a no-op after nfs4_state_shutdown_net() has called
> +	 * disable_delayed_work_sync()
> +	 */
> +	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
>  	return true;
>  }
>  
> @@ -8840,7 +8840,6 @@ static int nfs4_state_create_net(struct net *net)
>  	nn->boot_time = ktime_get_real_seconds();
>  	nn->grace_ended = false;
>  	nn->grace_end_forced = false;
> -	nn->client_tracking_active = false;
>  	nn->nfsd4_manager.block_opens = true;
>  	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
>  	INIT_LIST_HEAD(&nn->client_lru);
> @@ -8855,6 +8854,8 @@ static int nfs4_state_create_net(struct net *net)
>  	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>  
>  	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> +	/* Make sure his cannot run until client tracking is initialised */

Nit: maybe it's "Make sure /t/his cannot run " ?

I agree that backporting enable_delayed_work() is not practical.


> +	disable_delayed_work(&nn->laundromat_work);
>  	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>  	get_net(net);
>  
> @@ -8922,9 +8923,7 @@ nfs4_state_start_net(struct net *net)
>  	locks_start_grace(net, &nn->nfsd4_manager);
>  	nfsd4_client_tracking_init(net);
>  	/* safe for laundromat to run now */
> -	spin_lock(&nn->client_lock);
> -	nn->client_tracking_active = true;
> -	spin_unlock(&nn->client_lock);
> +	enable_delayed_work(&nn->laundromat_work);
>  	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
>  		goto skip_grace;
>  	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
> @@ -8973,10 +8972,7 @@ nfs4_state_shutdown_net(struct net *net)
>  
>  	shrinker_free(nn->nfsd_client_shrinker);
>  	cancel_work_sync(&nn->nfsd_shrinker_work);
> -	spin_lock(&nn->client_lock);
> -	nn->client_tracking_active = false;
> -	spin_unlock(&nn->client_lock);
> -	cancel_delayed_work_sync(&nn->laundromat_work);
> +	disable_delayed_work_sync(&nn->laundromat_work);
>  	locks_end_grace(&nn->nfsd4_manager);
>  
>  	INIT_LIST_HEAD(&reaplist);


-- 
Chuck Lever

