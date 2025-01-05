Return-Path: <linux-nfs+bounces-8917-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECCFA01A23
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 16:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85201162932
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jan 2025 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663EC49652;
	Sun,  5 Jan 2025 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g3O1h9Vs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tBfU52Fq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B41E48A
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jan 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736091727; cv=fail; b=RJobhESdGF6yu0iG9K9Gs4zZ5r+9h9mnJgLtPTldbhTNoYbDp2DGWTosL/GxTNaDYwGLhKuykT++3m6WdpeZ+Lt2S1hnZGKxdUG/bPs/IpLaAuUoMt+l3ynB/5Fn63mjp/x5nUYBQqhla4AZhp7sQS2olYGf5YMs3Oyd44vbOgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736091727; c=relaxed/simple;
	bh=L0PFYsBYr8nNPbsnVpsrRHzC8opNpVNM+1A+RkJ9JXo=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r9He74xSIE7BhYUXI1hEh/8hH66f2jLo4wc9P1XHrxV/l6WyBek+EMHjRwDbGTlYH4mIORnnBYtfduHDTI+v9oCkQBBbIwgzj0mhtKSEHuXCLZajeix+t2MX6tHZ0eWAHt4j2x8q3NVkNMWqBIx2aQp4+nTq4/MgKqcLotPFKT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g3O1h9Vs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tBfU52Fq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 505DuCJ6000998;
	Sun, 5 Jan 2025 15:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=w/+Vr4OLzoX+OKeAC82qj0Dn/GNqNWaGqd828N3J6HM=; b=
	g3O1h9Vs2F08FmHDDofVVHZJYS6MQLaW5nn20jAjZA0dvsckbvk3nFUcNFkotr1K
	pM9sWnMITGW84orl3PaYtnm298qR26wCxXZocmbnbSP8AVUuRTUz6Lb67wagZ1IQ
	RbtW5ruV3PavcCyOL9EUjEPSLo6GFsRItfU/pFMAeRiQh4tI2hicG5cijYN8jAmY
	D2G52B/5sfdFTx/9AKCX5f03/ac4xyY40VfQvm7ZejZWXbDJeZpa33bYPy0kl56K
	4dRlHkYepHlLDxrOdv0ZBGLR9k62L2HD+ynxEcFR4dmXp+n94KHRmUyEMLoxgiTm
	egYOegxyDzkjOaxHzc9RDA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb1gj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 Jan 2025 15:41:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 505C2qn2019961;
	Sun, 5 Jan 2025 15:41:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xuecsgvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 05 Jan 2025 15:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mz+FhZVShQxLJPbyoTaVv2ugWDqcRZus4fX6w50wrXnPpm451UQlJQJ0FDgKi7IqjcwKk1TP44DScopuqz8MFR+T4+2Vnp3cGMt0FLQOIx5owi5k/AkDigPxJBavMzIdkJC7WksWG56PO0YUOdiCA2eChk7va2t20rAVoW5YPZzyvg426LyIH4ckbNbLK4YLATDIKN1snjNfIQtPZ8BZ2n9fXcupyF+h/fXk0F5pW5WvDABobsMRqOQyoq5muEzAl0WQJaXejhmUvq00uerPkqFhHk9XOyynfED4OnL1GhakM4x7ora1c+77K4hZ6FcFWo8yMOqdpMXK0fE6FnnbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/+Vr4OLzoX+OKeAC82qj0Dn/GNqNWaGqd828N3J6HM=;
 b=wuBjWHNR1lepFvzbVke0hK3bZEQs91eDuFm6eKheOW/v/ZfHWONhEuDuCJiDBgyLdjljSDus2uy075ja8R6EF2ODIW8fOfhR1pkDmP77ysIavLNPfi0yizSSlJHj9BKMVcWU3G1qfCLYougjECoaGMPhMzvhOMws6kNn19n7LHmb2KKl/XrEcaDWaW5nQbT9GqmuOr/BPr4uj2mXpQQBhIXOhOi+nLESWtmRJGsloTibPe4+tdUiHJV8SonG//5+7Wfw3qfvpZk9YCPwJ22M8q8QIqXZQGH/2P/ZkkX8VfNjXxBLkupTMa5PmR37M7xXxzQP4eBmYEn7BDqnbbp+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/+Vr4OLzoX+OKeAC82qj0Dn/GNqNWaGqd828N3J6HM=;
 b=tBfU52Fq73DvQlpWL6NaX/003rpwIRTF/dHXFlfZMRof3a08dHrgVMd9UpOml73GwlGsQgd4aBKcFhGICPI6wfTRitctkOcPTUXHCiQyL0JPoiIPwfvDUan5Qa64X+yFnEwvh+9uzgZNiiFASA3+0BOLmigPzJyxxvpAg+krveQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4699.namprd10.prod.outlook.com (2603:10b6:806:118::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Sun, 5 Jan
 2025 15:41:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%3]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 15:41:51 +0000
Message-ID: <f1dbebbd-f15e-412f-94ad-151674303bbc@oracle.com>
Date: Sun, 5 Jan 2025 10:41:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Sagi Grimberg <sagi@grimberg.me>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
 <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
 <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
 <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
 <9b9430e9-845b-4e21-b021-cfc387cbd01e@grimberg.me>
 <53440FD0-58F1-4B92-BCC3-20CB91BB529C@oracle.com>
 <500c22cd-b88c-48e6-8cb4-732f66f8e913@grimberg.me>
 <9DB557C4-60D9-4148-9017-AEE32792BA0A@oracle.com>
 <a8d6d640-ab58-498d-9b28-427014ca9b5b@grimberg.me>
 <CANH4o6NyKgTt+ooWCzQDwB+CvRB674ikmMD9kEegBvzdeCtCfg@mail.gmail.com>
 <ad99755e-3ba0-4239-8f39-9d4405e02bc5@grimberg.me>
Content-Language: en-US
Cc: Martin Wege <martin.l.wege@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ad99755e-3ba0-4239-8f39-9d4405e02bc5@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4699:EE_
X-MS-Office365-Filtering-Correlation-Id: df8e0032-f19e-4284-8650-08dd2d9f791e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEloVkZzdXVuRUtER0E0STJxZFc0RTdwU2RqbnBFR2EyRkxjaEtBaVUxMHk5?=
 =?utf-8?B?eXo5NXZ2ZmxFYzFZOW8vQmJYSEI5L0lrSHBOM3BUeFFhN1Bud2xrUWNlb3BP?=
 =?utf-8?B?Q0ttdnBNZjVNT3lLeHAvYm5KeDArd2xlcDVCU2gwcEZMMTlDKzhTeHBCZzV0?=
 =?utf-8?B?cUhqcDh2SW9yT2g4UnJLYW5PMWwvQ0ViZXpCb0xYYlpRM05LbXdNYTl4aTNh?=
 =?utf-8?B?TjNQczdrakpyU09UTks5Q3VkdTM4QlNxWkNDbDN3L3UyRlRlL1hTUk1YYzNr?=
 =?utf-8?B?bk94OGVSUUI1Mit2MG12RWpBOGxXNmdnaHN1Q0VtTHF2b2N2OUl5SDVIam5s?=
 =?utf-8?B?eXV3NFJTU1YxdUhuVHpDRjdRYzhGSFYxSk5BRkZ3Rmd3V3dhZDBpZHB0MldU?=
 =?utf-8?B?TXc3cEhDdE5tcU5FUmoxNkZGa2xaUnFVWFVpWXlEZ0pvZWNmR0g3bm9XcHhQ?=
 =?utf-8?B?ckZrT20xdVdGR2JVUW9WR1JpTmEvTzFBcVdCZVQ2ZmVyMVBGUG1MUVFGQ0VX?=
 =?utf-8?B?S1RNaFlEaDU2MHNheW5GbzJhZW0xUEJXcW9ta0FraFllQkE4cmpHQllCZCtV?=
 =?utf-8?B?YlFBYkxzUk01TTVoRlN1TEg3dUhZWUt2a3lvVlFsS25RWFRxZE1JQWtFTlJj?=
 =?utf-8?B?Z3UrYlN0UW0vYUhBbkxlTDNFVlI3UExHbmtRc2hNeDJJeUNJNHlIeXdMV0FJ?=
 =?utf-8?B?RzNkaEI0YkJkNmd6QzFaUGE5VS9aUlVCbkhKWVlUWERNR0Y0eFRvbE81RjZJ?=
 =?utf-8?B?TDdRNHNYRmJrL0gxR25PVWovWDNFZ0Y3cmJYaVNzdFpobk8xTkNaZHJxWllh?=
 =?utf-8?B?Tm5rcVFMdExJNUpFSjB0ek82U1NWcEJtQU1Va0NLZElqbm1FL3MwdWlIZTRX?=
 =?utf-8?B?S1RpdUFGd2I2WXpmRDRLdlh0MFBXUTNUNElsbERPVTc4ckZIcE1Xc2tSVDlT?=
 =?utf-8?B?RTNlVTJWdWdmZ0FaeTVXSmlSU1ljWlAzQVoxaVFUbnFCanNoZlZUQ3d2cWZO?=
 =?utf-8?B?RTUxSTRYcG5SSnhPUEtsNXFFZDdkb2FxajQrb05vTjJWVVhCamlXV2t0cmww?=
 =?utf-8?B?OTVZbExtcGsxWXpxV1hacFpNc1B0d01UT2xFNUs0YjZlR2diY1g5YWJXNWZU?=
 =?utf-8?B?ZmZHYjJRQTZsVUJoMTg5SjV5STRXZXFYRXd5ODZyaTJjSUxGWWg3RnZlVW5h?=
 =?utf-8?B?TDBxM0RWaDY0eVBpazlwRXpPVTBLRFRHUWFpbHpVbWh0Tms5djZmdzNHSXNC?=
 =?utf-8?B?cDFzcUEyQW14azQ0OTNkS1k5dGw0cThwUHR5Q0xPMW0wakd0L0ZkU2Y0ZUN2?=
 =?utf-8?B?ckhEQ0lDYWd0SU1NSnk4UEZqL051TUR0ZXJVdnRNOTV6NjBxOVhvZW5zUDB5?=
 =?utf-8?B?d1R4eEJLd3h5cW81TzR6bVFxUnRlaUZWdlVEcm1RSEFHZUZiYnI4dzJTWGxa?=
 =?utf-8?B?K3N5OVNNVXZUbGdRU1EreUM1ZFZhWnRGeHFSVzBlelNGYmRUN3ZvT2hySHpv?=
 =?utf-8?B?V3RhdEIrZ1BQYm1MZkJrTTg4bUMzcS9zc0dKbm02QWQvbkVMdUxZam9vdXRP?=
 =?utf-8?B?dWJ6MjZKVGlYc3FpeklZVU8vZ1ZhaXVadTk4eXhuVUF5R0tXbFVIWTFNVDdU?=
 =?utf-8?B?bjNBbHBiTVlUOXh4NGhBS3pmcEtZZkJmenFXeGNuM1lHTzcvaXR5OXd0eTl4?=
 =?utf-8?B?Y1VOT0IxU1pxengzMXBXaTRkVUxhb0t2Y1FTME92Mk84dnBUMzYzN2ptTUx3?=
 =?utf-8?B?WHdhTjNxbVRRa2Z6dGlZQ0I5U0c3am9nSGJKL1JVR3RycVdUeGhleldOYzRF?=
 =?utf-8?B?NHFnalZIUmxZNFQzdll3b1l2UFRkTURqTE9BNnhkYzd1dWkyK2c5NEplMW1x?=
 =?utf-8?Q?+EPe+svgnCa4k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVRhdWVOMkxrdmRuT2dlelNEY1l1K1FLVzUvbWpHSGk2OHhiLzhsdC9jaWV2?=
 =?utf-8?B?ZnFUaHNDKzF4UnZGdSs5elpDem9Tbm1vSUhNMFR5L1E0THdtcmhxZDl6cVNE?=
 =?utf-8?B?OWhuYXBiZ2QzWUVxczNHM29vclF6NlMzTmxSV3c3VVU5ZUg2OFhkemo1RVB2?=
 =?utf-8?B?dW9iL3NQcUFUZGtxcWJIeEd1SjZVdU9lRU1id3RDYlJBV0EzQUJwVzYvTmV1?=
 =?utf-8?B?enpMcXlIaGVqTEpvS3B1NFdiNzdtQ0I2WG5OdTErSjFNd2xtOEs1blVQTDZJ?=
 =?utf-8?B?ZFYzazM3c2h1NzJUdmMyMHJCZENCNERLMC80dS9DQTNETlBCTzQyVnVBdW1s?=
 =?utf-8?B?YzdISnJHMHJoY0pzTjBFT0hGNGJ5T0FReERwMm1ONDBVNVNMVUpyZ0NIMCtR?=
 =?utf-8?B?cUhJSUdUdThjM1FsTDhNdTJUQU85NjVOd2lRTGVLM1Znem1CeWh2WTdNanl3?=
 =?utf-8?B?eENZcW5tY0U2cUYrVHlEaGl6YkI4ZHJ4YVBCSUZ6V0VSY2grNEFHMEw3VGxt?=
 =?utf-8?B?OVM4ZzEvWFByMUhra2dHaVQ5VTAyM0RaYjhnbGJuVDBlbVk2RVNnWlh0eWdI?=
 =?utf-8?B?ZDhhZU1GUkVmNUU2a3k0bU5QS3B1cGgrWE8rK3RJcXhwOU1hQlk4NGhleDls?=
 =?utf-8?B?amF5OXNXenphT3hqdGJpUkNPSTNEVHFTaUxtcTVCZWZSZm42ZzNuQ2doSGlm?=
 =?utf-8?B?OGNKNExBN2REaU1lMnJUR2NNalpHWGN5bzR1Sk91a0RudGhoSEhJVmM5L3RN?=
 =?utf-8?B?N0IrM3dmTUYwRWY2VktGcHk2d2NXdm4xRldLNFJvR2xGRHI3YkZXMHpOTFBB?=
 =?utf-8?B?SjFCK2pBYTZMNVZLamhUbHhsMUllNHZPUXd4ektaOSs0MWFNbmdiOC96UWJT?=
 =?utf-8?B?K0tlRDJtRm5wNjNYMVhLRldrbTAzdkR1K0JZWEVkRkczRG54OUdnaXJhKzFM?=
 =?utf-8?B?a1E1Sjd6SzFXa2NseFNMS3dvOXI1MnJxVmdPRVFkL2htVHhvdXB6OUVuQjFa?=
 =?utf-8?B?VmxxZ0NlZ3FWeVE5bGQwTHJuTzhYN0VJTU5qeldSdm0zVDU4Nm15aW5pbFR5?=
 =?utf-8?B?dlluVFdrZC8ySjhJSUxxZjR1cGo2eDJFTVE2V1BVL2VEeTBaOGxXaThMUi9J?=
 =?utf-8?B?aU1FMVRSeXhxQUF3L3FWZTl3R0tjZXk0dXpnVkFjL3RacHVKWVNnOTVIY3hy?=
 =?utf-8?B?MnZLZjhCOGNVb0V0c0JnNDdzRVdxSDluenFSbEdPQlk0ak91dERJRk4xSmtn?=
 =?utf-8?B?TmNQZnQxNjhJOXdIMGVKOEZDeVQvcnZ2NytjckI0ZHZ2UDFSM1VlTmo3T2w2?=
 =?utf-8?B?RkhmMzdsUVZtdnFmQ25tUjZLaTNDMVdiUksxbXlramZjQVVwSk1HaThsSEFq?=
 =?utf-8?B?aFBmWi9NWW5BNUN3NkhXWHJ5MFhmU2dISmVRZ1p3bmZYd1FUYlFFVVFLVmRC?=
 =?utf-8?B?UERCQ0RFMldzQU52eDZ2WmZ2ZGJhUzVsYldRVzhSTjB5aHR0c0FVdXRvZi9C?=
 =?utf-8?B?QXk1MER0R2RhaE5sRWhUVnlkVDBIN0R4d2tGWG40cnFaMG9OV2JibVNXMTky?=
 =?utf-8?B?ZXRRUE5lRkRPRzk5cFRyazFTTDRZN2RuWmZIZVF2ZjYrak02eHUwcmR3aG51?=
 =?utf-8?B?UFJuVktTajdIUjY4N202VjNZL2I5S3hRWVRpeWVtelhRb2pRaXA1emVOeGJB?=
 =?utf-8?B?ZkdDVzF2RnlxNVZoVVpEc0dzSUN4bEh2eWpudXFMb1BzcVUyODN0MnRKNWJ2?=
 =?utf-8?B?N2FPVk9nbzNaa0NhV3Y3YnQxeFZlLzBhUk16Z1RuSVRoT0F6WUYrSitTMnhR?=
 =?utf-8?B?b1Iwbkwra2NwRjVucGVOK3FkRTgzOXJFaWVIdCtCK0dmYk5WaHRHQ21XV1Bl?=
 =?utf-8?B?N3o5UTJhdXFCSFFyNWV0ekhtK3M1K3ZXYkQ4KytXQjdqZWtVUjlwcjFYNDJE?=
 =?utf-8?B?THRvQTBQQUtpeU5xK3hjb3VXejRLTTUwdXV2dnJYMXFuRGJnd2tmUE84UHBO?=
 =?utf-8?B?MEJSSkNsbUFaQ21uWThwYUt4dEltZkZZMEZpSVptR2RncElhWTZ5dmV5enN0?=
 =?utf-8?B?bjFLQjlTVG9qUEhRamlZb0dESTd6K3d5aEFXTWs0dzBETFJmMk9zYTR6OEp2?=
 =?utf-8?B?QU5yOUtxV29INGV3eVJ6ZTJadktXOWlZMzI3M3lLR2RueHlXN01SNTVUSlRJ?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JFkgHgyvXCciMaqUsao1/MPO1Rto4oX+B7Z8qCU9uKoROfgqahjiTTiUbWKy/0Y2BgyxIpkiEj8iHtrBiLaYhMJPIdxuxK9PBTI+93wnvDLRPnNmGdYeIg7E1CFFySOEBDPfYcNFYKi75tt72lJlkqa7lhHkgUyluO6dmVxkYKNYxtJXlMSnD8VUpII3JzKV6yadhOOzFGzDB5xCmAEbxVys7gbjR2QMgGNSnKa2Y9TyQGCmimdPLire7j6sWtO1RbDf26tfYBah0byca09OiNY1EHDPfL11G+BK21RnroSk5/Sm0Jj7dBv2ZXineid5q4u9m5aZM8Szt7t6uPIKecldl4IsxhitqPHlOx7y5PAcCVclu2P4YYN4JIZWfNQV49W+P4x0U94Ak01oPHtQENecxVMPwX4UFGy+ZSRh5+Io5joFBphB0IlXW/xgXnRuk+/JWO3Z4dcXL+64c06suwedfZZetvIn3Q/LPu8eyeGVMO33qbeu0l655f36Ztzk4tilt47PH1fC+HQnTukmHMk0WLmGACHtycaUbRqPYdxkaEFZLfo0zyCT27hh4P5P7/LU4wdFiQ/O+FRM/m1Kqd2DLUkHn4ymtq9VLL8uvT0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8e0032-f19e-4284-8650-08dd2d9f791e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2025 15:41:51.4149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrSxezs58Em0DtwLzFU8SWCcyQM1ehwZQwGI/4y8vRVd4slBDJDNpk17513hhleYXfugqBT9r4hXCvJvYgCQ8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501050145
X-Proofpoint-GUID: E-1fJ6KsWruqUtqPOiiFkpmi2VH2yl6M
X-Proofpoint-ORIG-GUID: E-1fJ6KsWruqUtqPOiiFkpmi2VH2yl6M

On 1/4/25 5:26 PM, Sagi Grimberg wrote:
> 
>>>>> On Jul 10, 2024, at 3:11 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
>>>>>
>>>>>
>>>>>> Yes, as an NFSD co-maintainer, I would like to see the
>>>>>> READ stateid issue addressed. We just got distracted
>>>>>> by other things in the meantime.
>>>>> OK, so reading the correspondence from the last time, it seems that
>>>>> the breakage was the usage of anon stateid on a read. The spec says 
>>>>> that
>>>>> the client should use a stateid associated with a open/deleg to avoid
>>>>> self-recall, but allowed to use the anon stateid.
>>>>>
>>>>> I think that Dai's patch is a good starting point but needs to add 
>>>>> handling of
>>>>> the anon stateid case. The server should check if the client holds 
>>>>> a delegation,
>>>>> if so simply allow, if another client holds a deleg, it should recall?
>>>> For an anon stateid, NFSD might just always recall if
>>>> there is a delegation on that file. The use of anon is
>>>> kind of a legacy behavior, IIUC, so no need to go to a
>>>> lot of trouble to make it optimal.
>>>>
>>>> (This is my starting position; I'm open to be convinced
>>>> NFSD should take more pain for this use case).
>>> Hey Chuck, didn't forget about this.
>>>
>>> I'll look into this when I find some time (which I lack these days).
>>>
>> Welcome to 2025 - is this issue fixed?
> 
> No, I didn't get to come back to this... sorry :(
> 
> I'll try to find some time for this, but if someone else is interested 
> in seeing
> this added, it may not be sufficient to wait for me to get it done.

I'm trying to clear some time to look at what infrastructure changes
will be needed to get this done. But people keep filing CVEs....


-- 
Chuck Lever

