Return-Path: <linux-nfs+bounces-7181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204799EE17
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 15:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64B91F258B6
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 13:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254801514F8;
	Tue, 15 Oct 2024 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mpaExPEC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SKrwNjdg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76928691
	for <linux-nfs@vger.kernel.org>; Tue, 15 Oct 2024 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999837; cv=fail; b=TMqK6kTP291b6F8Yg7FPmKbYteT7DpA7MDuCQT1bFsR6yq9AJ6mck3KT0hycXI17mOHuW9xW0lQMumnHhX3kT5FP8Efl5/UXXFYOkesdsDw41BeDUmLaxdlUMj1fClOWQX1a/VQLYp0E+x4WUhxIUEaq6Htcym+w40D5q1JRd0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999837; c=relaxed/simple;
	bh=10M0gsWQ3xcKmn2b4DIjI+N2BRiTwE9/QNbJ4Xr6Rdg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NNfaibE01BnXN/YnAMfZOVa51CdbKoba67hNf+hicFjeVV+55yLlnUHM6Of+8dy7xUmtSjd2J7eYw1kvncKiSCy5ilk7BF8RO5uvO24FBjqaR/n+oszAS/4DZ9iPxniU2mex6ZfT+t6Jcpv2/Nd1pjbrhE089xI91XkWOpdc1wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mpaExPEC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SKrwNjdg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FDMaBF029832;
	Tue, 15 Oct 2024 13:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=10M0gsWQ3xcKmn2b4DIjI+N2BRiTwE9/QNbJ4Xr6Rdg=; b=
	mpaExPEC5RbHKP3EpXW9sYMPhLI9iwIJBrvT27AzVxq78kQ93pdjVcsR6fkWU/ZN
	P5ZWI8iKhlaCLOAdr1R/vLufGHJ03jLvf3pGJzOM54SvB8MznhGe/V2VzN7QqDAe
	W1pE7zL4OW605NU2sMZfW7mHdAKIhAi1JjQMeRYIpr5Nsn67dM+7KoHOADEOsnrx
	mZ7CeaEFneSJj5uVPAOOaMaCtisIlaJelYvGVWUG4Ymejyuvu3wZ8k1nMwhdIQhw
	cXXHY4fnkFEoL7hEGNSu36nQRPHBHlAqGzJO5gxFRw90tbv22DvPPTctRnU4Mtsl
	tr0EYnK054+J1vcwLZU2NA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2h5sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 13:43:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FDSkGN010918;
	Tue, 15 Oct 2024 13:43:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjdrb0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 13:43:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRW8xnpU2OMiTS0VYK2MZudAKYfn1rEfLt761IuA+mdjWB1a1REI4jgk39Vg2iq3kPNQcicjbU7Fi52nWvUaF7XZU1WC8uPgb6QZd/ih5cxAsoYCAhqR9Kv+39xKkodY5Vy2bWS4j3mzFoRq89AePzvNu7iS1hf2rFGDFxQb7jdsi4+UyqKYTAwvdGtwdNyzpCqzSRiPPcSw/GH8jxC2v4RpJxYoTDcMgsbD/x/DbCpmFxuSgHq1scsjQErBNO0So+e+LpHD/rJsm6z6L0kavaSs7VNxAdQO5e0BxY7e2MxNffBKUB6N4pNGfqaKOF9VK0GR01g8JsY4w5i3jhmVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10M0gsWQ3xcKmn2b4DIjI+N2BRiTwE9/QNbJ4Xr6Rdg=;
 b=rrgXyBZtWYNtSBr0DwLe/99esYSdGWi5MLfOntKdnTIzw+w62QKq30ul3uDq/phw1RwpI1HcGNtWYl9iGSuknV4j6nd5L3KKy545XrlEel3bZNFLqYtc4iUT3lZCn2jbCAUClYdMammJzh8yiMhGtP+92o9OmhD7wrV7JScpCbWkUvq1OpR1YO3UuIk+2CTPlm+CkiXiOTDI7c+aY9ulcLQZVkGRw5WKPha/1xZL1FwfDHyS6yD3/7LDUmQJyA0VcAopaTCviYOfaug9KTUt64QbHHHQhn17vvCASPSp46fgknKVmmlK2m2G5STUsL2CYIxFw41o+irH8oEvo9Kbzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10M0gsWQ3xcKmn2b4DIjI+N2BRiTwE9/QNbJ4Xr6Rdg=;
 b=SKrwNjdg9TiMogKgtJ2PJSc8cCO7R/OxtRsScxKlYrZgQdYYgHb0Sh8nezX9gEB46QIn9y+PoAizt+eqkcf5dJOykdPhNL1/wKe125Ghuh8sQz4VtqYL8eocEQ6RPYzNwOFSsvMJ5gvermo7W138vz8pOtaNchNR/LNvUgNDXpk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7978.namprd10.prod.outlook.com (2603:10b6:8:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:43:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 13:43:48 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH pynfs v2 5/7] nfs4.1: default to minorversion 2
Thread-Topic: [PATCH pynfs v2 5/7] nfs4.1: default to minorversion 2
Thread-Index: AQHbHnrDg8LzcFUYDEubfUZFT/rBorKH04QA
Date: Tue, 15 Oct 2024 13:43:48 +0000
Message-ID: <6123766E-BCAB-41DB-A86B-E75B05DC88C0@oracle.com>
References: <20241014-cb_getattr-v2-0-3782e0d7c598@kernel.org>
 <20241014-cb_getattr-v2-5-3782e0d7c598@kernel.org>
In-Reply-To: <20241014-cb_getattr-v2-5-3782e0d7c598@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS0PR10MB7978:EE_
x-ms-office365-filtering-correlation-id: 17c411bd-4659-426b-2a32-08dced1f65d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cW50eGNnenh5MlNCVjdaSUM0UC80SUx5U1F5MTA0V0hBK1lqSExqZWovU0pL?=
 =?utf-8?B?bkE0aDJIS3cxZW9xazZYN3p2RXoyZ2xsbm5MSHpEeWszZUliZlN5SDY2dTBQ?=
 =?utf-8?B?MHJSeFVxSEZMSlRkMEtkWkNlVFlCQldxakVSS2p2SGo0QWNiZUVwVXY1d2Rm?=
 =?utf-8?B?aWpvL2tWYkF1c2QxbXdzMTBJRUxkcWtVQWlTOGFwa3FRMGtsL0ZVT2JyTXM3?=
 =?utf-8?B?dFRTTmI0aWxJMUREODVhMUlRMVdPTDBJc3RlSDFicmRxblNQUGZQK0xyTnVH?=
 =?utf-8?B?VFZBWUpNQ2tpRjZNdHh0NDM0RnBPeVltTnVsNDNmTVo3NFRTYStXcTcvNUp4?=
 =?utf-8?B?cTA3dllWdmx1T0lSQnZRTUhiQlFldEJla0JRYXRTZW9tLzQvTVJ2R0Ywaysv?=
 =?utf-8?B?aENNZ2ZFek1DTy9vTC8yTTBBenBySXVZdEJVdEgwZlpsdUVoWHVYR0xaRjZZ?=
 =?utf-8?B?b21yZXRpSGhDQkdXMDBRQnBpTC9xbkFMM2RBRkJRWDdROXFGdEZhUnZGUUk0?=
 =?utf-8?B?akF3Y0xueVk4aEgvY1gwVWozR2tQQnphbTRrUnVJU1l0Z1dWYjRTZlhxVHpT?=
 =?utf-8?B?bU5LcHRpeFBiVkRTSS9QRVJSOFRTN251SkJZZE5xaXlBM1BDZnVGSnRicDVZ?=
 =?utf-8?B?SG1nM25WU3FsMVFxMUZvMHhqaCt5M0s4bUtMbUc1UVpWVkpPOWgwQjBtNGZl?=
 =?utf-8?B?QWdTTHRwZy85TEs3TDZYd0w3NS85cFo1OTZjbkRyMUorSkNUS21seTJIL3hZ?=
 =?utf-8?B?eDM2UklCeGZxaFgvNGtsOGhRd21BTjdyck9XOG1JeDVzcGcvUzNWRFNFVXJo?=
 =?utf-8?B?YU0veFUycHI5K0pxMmRwdW5FVFF0ZFdWRmVWZHRiazhLWTZOTlhOQlA5L1hr?=
 =?utf-8?B?Z0lQZVh1Mk5OVVZiam9qWElpeWVMd0xidW5ocWYwamVZaDFHbjhNVU1udDZN?=
 =?utf-8?B?UGMwM0tKT1dhY3NLYkVrdXNNR3FacjR4V1BicXErZWlFQmlxbko0Qlo1dFc4?=
 =?utf-8?B?ZmNNWHZ3Vmw3Z081U21GTitDTVJoL0xWTFF3SWRETHlTUm1lZDFTNW8yblBs?=
 =?utf-8?B?bS9ncjloYkdPZXpEUWZ4aVNtdnVtWFVNeE9SYlRZZlozd3ZzWXVkL3ZnOFlu?=
 =?utf-8?B?c2lPZXZBVEdzZjF0Y3FzaWhHaWdyN2h1OTNuaC9jcXlkZXB5TzNydkZHN1k4?=
 =?utf-8?B?MVJvQmxHZ3V1WnZZVklleTkzYiswV2UzbkJrUWdnbmpvYlVITDNyRW5Pd1cr?=
 =?utf-8?B?dER0NXZDVW92Ly8rVWdWUk00aWc4UVJzeU0zMGxvRjRnWjVZNGI0d0lOdlM2?=
 =?utf-8?B?SEU0dVY2Z1JDNzE4SCs2VlpEVlMwRmhtTUZsQ2N3ZndWbVVIMWhLTVF1QU56?=
 =?utf-8?B?MWN6VnJDSzdaNXplemd2NmtoWTBWcitoUEE2TzllQ3hoRkhodlY4SE15Y2Uv?=
 =?utf-8?B?QzlhUWZTbUJoZE1XV2hiZFJjOGliZ2RDdGQvd3NMYlBEWjZqakxFOEYzWHlz?=
 =?utf-8?B?ZUg3djZCVTNzMVRWSDdhT3BCTFNjbW5JZTJoR1NEVm9kZVY3YjdiZEZ0cjhM?=
 =?utf-8?B?cVVSWGUrQ0NMNEY1QWM3WkpXRHdDWTZ5WUFUU1grYnl2V092eUxFNWxLV05U?=
 =?utf-8?B?cGNkb3ViRW5oS2JvditNcXp5T1hxOHpyYUxHd2JqZ2dqZHdWS2xUK1R6cWdK?=
 =?utf-8?B?SXNvdjhEZTFOSnNlTS9XZGpPeWJMOWlBdG40dGVIa1VoZUdtR0dEN1BCa3VT?=
 =?utf-8?B?aW05cVY3NERTNjMyWWROZjhRcWVJbnlYNGJGbGF3M1BCSEZsb0hyV1lKRm5T?=
 =?utf-8?B?V2JvMy9xYTk3QmtRR1duQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFhocjhPRGliejRtT1p6ZGQxb3JybXFQVklYUFRIdTFlN0tqQUNZMFJ4cUxa?=
 =?utf-8?B?Q1ZwdjYzcHFCNHM4OS9BR2VZWUlMVVp5RHdHaFhjeTZOUGVkdWxVWmZDSDRk?=
 =?utf-8?B?M2RPTHg1amZxeHZaczVGdm1LcHRIcjh0Y0VJR05aN2NYSjN1aXFieUgycXlu?=
 =?utf-8?B?NHVhUGJOQmdrYnUxZUxXNW9KWEZwN0Npemt3bUhZK0FDMXdKWnNkRnN1amVn?=
 =?utf-8?B?cGtIdnR2Q0JONWo0ajFSZFdVeWtLTUdkSkRvL3RZRGF2V2RGRk8vK2dONEZi?=
 =?utf-8?B?cW1hZVR6MENwQWhRbTJrdlRMRDdmUWp5M0NEc2JNUzg5enMrRlEvYWJpL2pz?=
 =?utf-8?B?Nk12cXVXUXArRzZmVjc0OXhIZGJhTzZ1Q2p6UlJuNWl0dmxaQnRkOUpXVEwr?=
 =?utf-8?B?Sk1TUXVnRk8razc1UGEwKzFKYXNMUThzckt2STV5Nm1aSUVEak9sTnp5TTNl?=
 =?utf-8?B?dDRaTEhUbjM0SXViOUFrY3dGY21lcFI2cVc2T3Q0c1RYQXpUTTdaL0xjOEdQ?=
 =?utf-8?B?dTJzZ0JXS3NkanhncUZUd0Q0M3VTamJ0QitFU2p2VUp5cEdQV09XMGdIeVl2?=
 =?utf-8?B?U0lKTFlhY1pYR0VHTUpUZ0k3SEhHOWVyRUE3OE9Yc1NOM29rdFZGYzNqbnlY?=
 =?utf-8?B?M1FteThYZkhMRktVd3ZyMWh4cFFFblZFTDFtR0VsYjMyOENCVCt6dUYvTUd3?=
 =?utf-8?B?cC9Vdml2STNGNGZMRlpzemNwb1BJZmwzUmdBZVhYcTZ6U3UzT1FkQU5QZUR5?=
 =?utf-8?B?SHd4cWo3YTY4a2I5bU9ubHVKalN0UUdYLzRaK0ZETVRNYi9JM2hldi9SSmRJ?=
 =?utf-8?B?M0s2QlZyWWMxcU15SDlTOVowSDlBNHdOSGRlQzRBSXFBWEY0ZEZtUWF4Wmcy?=
 =?utf-8?B?bWIxZjRXZHhzaXNtd1BuUEcvanMrWWh6b1JlaUxHWWFFVmRScTAyVlVhRStU?=
 =?utf-8?B?dEtCWTRBbXNHMTRhNCt4WVp2dkNJK2VYV1daOHdHbjN1ZHE5UGZXV25tZ1p5?=
 =?utf-8?B?Y2FQeWVVL2tvL0VFNzVQdHpSaS9MajdqL1A2V2RSRnAyV2orYmVCLzBma2E2?=
 =?utf-8?B?WVVVWVMvaHY1NE50ckU2WCtIc045bkhpZURJTUo4eGlkUnhtV3VGcUhVWllG?=
 =?utf-8?B?eXIvUmlLR3dDK3M4TDJsekJhNFVTV2tZc2YxZ3hWTkZYYmo2NG41c2ZLZFBj?=
 =?utf-8?B?b09VOGo0V2dWcldWN1M2UThlYkRWU2NEblRnWnBreW9IaldTcFd4bTdRUlB3?=
 =?utf-8?B?b1pDT0RqSERHUnNCNW0xaEs5eGVpZ3ZpakhiY2I2VVRvRU9MVHhreHQ1cExp?=
 =?utf-8?B?SmVuc2htYWhKbEpZY2xsOERkaTd2YWdub09mOS9XSFlBTEw2M1ZQRFJDSUhl?=
 =?utf-8?B?eW45bENwbVNpTWprMWZpYWhOZUZQYllXQVIxL1B0ai9RZWxDMHFERXNuTzlV?=
 =?utf-8?B?UURpTWNtSG1aQTZpbzFJa2ticU5BNkNKelZlVjNWTzNTMzNjeXE3QUdWcU1h?=
 =?utf-8?B?NlJnR09uY3NpL2Y2aEprR0tBeFQ4TTZGRm9yR2xpcFRadzVOZ2JYNlZadU1W?=
 =?utf-8?B?WVNXUGpOMDZtL0k2aUVuTXU0UGk5UkpqRUZJOWZiWUhQeSswVkxMNE9xNUl0?=
 =?utf-8?B?eGk2S2pjTGtjTjBqQ21QMHl2eUs4MVVZbnZ3QXRxdk54L0pLRmUrZFpXR2Ju?=
 =?utf-8?B?cFgwaVZGYmFlbnlQS25qMGp3bXdIc09UUStyZks4ZmRTWjl6RTdtdFE5Nmhl?=
 =?utf-8?B?cDZzQ1E2bU1XbnpPcXN3Q0RHV0M4am05VXo0MlludVIvL294elB0SlQreFNm?=
 =?utf-8?B?RFd4UExGTWVmejR1RFFWWDR3RkhhTnlvNkpOdlhnWEtaWWhHMEVaUHhkalpT?=
 =?utf-8?B?cGI5WEIvRFVYNTRXaDZHaytqZ0JrOGhrZThJMDJoQmtkdG5xRzQxV2VPeUd1?=
 =?utf-8?B?SXdTZ1ZjcllCampQOE5NMkNjT29aZmtPNnBHcm15dXRqdGJjQmlwZXhibUN6?=
 =?utf-8?B?SjZIOVQyZi83R3o0ckVVaUoyMkYrMTJqOHY0a1F6OENwYVA5Tk5iSDNTTjFw?=
 =?utf-8?B?OFJnRkNOdTZmUHJkNVU0a0NzV2FudlFxWW01ZGZSRGJtejVYUHRQRTRzaTJE?=
 =?utf-8?B?NG85WlZzcGJad2ZnRzBpK0R3Z0QrOUtuZkZDaEM1dkt4RlEvaWNYd00zcVJr?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <962AE5B069C80743B5CA0B150053B26A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dHn34a/mQ+wZYJWYNZ4mWEBM9wj1oVgxTzngUGcUmF7Xa1RYLjkw5I8ohza7bXXTNgGVB13LAQLyc/6QTJYo052HtWkk0ffwWZaVVjrlCD+8nMrQEp1GWbi09z2zAnaOOHm50lWODw7p+LHqFbYKix7GXUzTwGsKokqK+/pBkmly18w6kBa4NUA+aFbFFipuGXdZml7jz6tWUxCBQb5msvl+V1tBHELO2a4SNkgAWPe24J2Md0liLsGU9MqzbFlDv3AazfXwyEDVbIYL0HvJPRVSEDea6C9gEzfrE0X22GJ3Yb9GLr8bfIva4aHwHpGFyiXOyrmqTQZcwhFya42fAj3zc9X9ONqAAJMfXBsAg1s6m8OP/tru2kL4B2rv8kmpIvYsiVW8yOPIlYqhr8rGawBbzYBFdtJ6uMu7i5n1MfpfNMzLuv0UvRjmr+ipv5sVAbDn6JVTee/HIsfLXX+VU2WC4QrOhVc8c8XmaXEWYVOoHzo+eNQ5fRlXrhvxbvVMib4LGk+fhOSYYztrVHzagQcU7TPCxsZnmETiv54HsapWeOOTpPzD2TEFINzV3iCSk3d/qWht88Pj6pJbMzqYkCKjdtR+xKlW5g2P32eRohU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c411bd-4659-426b-2a32-08dced1f65d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 13:43:48.7434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qd+5/InXb1t7eUl+DVXfiGtBIsMrydcwPsaV8K8oxaP1J4gH4LgNUZDEcsAUvTMn2bEvLWll32+MMQDHs9foIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_08,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150093
X-Proofpoint-GUID: v3xQzBhxJ39IHdEtJTly3PnRlspsdisM
X-Proofpoint-ORIG-GUID: v3xQzBhxJ39IHdEtJTly3PnRlspsdisM

DQoNCj4gT24gT2N0IDE0LCAyMDI0LCBhdCA0OjUw4oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gTWlub3J2ZXJzaW9uIDIgY29uc2lzdHMgb2YgYWxs
IG9wdGlvbmFsIGZlYXR1cmVzLCBzbyB3ZSBjYW4gc2FmZWx5IGp1c3QNCj4gZGVmYXVsdCB0byB0
aGF0IGluIHB5bmZzJ3MgNC4xIE5GUzRDbGllbnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZWZm
IExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gbmZzNC4xL25mczRjbGllbnQu
cHkgfCAyICstDQo+IG5mczQuMS90ZXN0c2VydmVyLnB5IHwgMiArLQ0KPiAyIGZpbGVzIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9u
ZnM0LjEvbmZzNGNsaWVudC5weSBiL25mczQuMS9uZnM0Y2xpZW50LnB5DQo+IGluZGV4IDk0MWNm
NDAwMGE1ZjBkYTI1NGNkODI2YTFkNDFlMzdmNjUyZTc3MTQuLmY0ZmFiY2MxMWJlMTMyOGY0N2Q2
ZDczOGY3ODU4NmIzZTg1NDEyOTYgMTAwNjQ0DQo+IC0tLSBhL25mczQuMS9uZnM0Y2xpZW50LnB5
DQo+ICsrKyBiL25mczQuMS9uZnM0Y2xpZW50LnB5DQo+IEBAIC0yNyw3ICsyNyw3IEBAIG9wNCA9
IG5mc19vcHMuTkZTNG9wcygpDQo+IFNIT1dfVFJBRkZJQyA9IDANCj4gDQo+IGNsYXNzIE5GUzRD
bGllbnQocnBjLkNsaWVudCwgcnBjLlNlcnZlcik6DQo+IC0gICAgZGVmIF9faW5pdF9fKHNlbGYs
IGhvc3Q9Yidsb2NhbGhvc3QnLCBwb3J0PTIwNDksIG1pbm9ydmVyc2lvbj0xLCBjdHJsX3Byb2M9
MTYsIHN1bW1hcnk9Tm9uZSwgc2VjdXJlPUZhbHNlKToNCj4gKyAgICBkZWYgX19pbml0X18oc2Vs
ZiwgaG9zdD1iJ2xvY2FsaG9zdCcsIHBvcnQ9MjA0OSwgbWlub3J2ZXJzaW9uPTIsIGN0cmxfcHJv
Yz0xNiwgc3VtbWFyeT1Ob25lLCBzZWN1cmU9RmFsc2UpOg0KPiAgICAgICAgIHJwYy5DbGllbnQu
X19pbml0X18oc2VsZiwgMTAwMDAzLCA0KQ0KPiAgICAgICAgIHNlbGYucHJvZyA9IDB4NDAwMDAw
MDANCj4gICAgICAgICBzZWxmLnZlcnNpb25zID0gWzFdICMgTGlzdCBvZiBzdXBwb3J0ZWQgdmVy
c2lvbnMgb2YgcHJvZw0KPiBkaWZmIC0tZ2l0IGEvbmZzNC4xL3Rlc3RzZXJ2ZXIucHkgYi9uZnM0
LjEvdGVzdHNlcnZlci5weQ0KPiBpbmRleCAwODVmMDA3MjM4OGFkOGE0YjQ3NzA3MzY0MWFlMTYy
Njg1MzJiYzZhLi4wOTcwYzY0ZWZlMzRkY2VjMWU1NDU3YjcwMjVmYWYwY2IxMzk2NzBjIDEwMDc1
NQ0KPiAtLS0gYS9uZnM0LjEvdGVzdHNlcnZlci5weQ0KPiArKysgYi9uZnM0LjEvdGVzdHNlcnZl
ci5weQ0KPiBAQCAtNzQsNyArNzQsNyBAQCBkZWYgc2Nhbl9vcHRpb25zKHApOg0KPiAgICAgICAg
ICAgICAgICAgIGhlbHA9IlN0b3JlIHRlc3QgcmVzdWx0cyBpbiB4bWwgZm9ybWF0IFslZGVmYXVs
dF0iKQ0KPiAgICAgcC5hZGRfb3B0aW9uKCItLWRlYnVnX2ZhaWwiLCBhY3Rpb249InN0b3JlX3Ry
dWUiLCBkZWZhdWx0PUZhbHNlLA0KPiAgICAgICAgICAgICAgICAgIGhlbHA9IkZvcmNlIHNvbWUg
Y2hlY2tzIHRvIGZhaWwiKQ0KPiAtICAgIHAuYWRkX29wdGlvbigiLS1taW5vcnZlcnNpb24iLCB0
eXBlPSJpbnQiLCBkZWZhdWx0PTEsDQo+ICsgICAgcC5hZGRfb3B0aW9uKCItLW1pbm9ydmVyc2lv
biIsIHR5cGU9ImludCIsIGRlZmF1bHQ9MiwNCj4gICAgICAgICAgICAgICAgICBtZXRhdmFyPSJN
SU5PUlZFUlNJT04iLCBoZWxwPSJDaG9vc2UgTkZTdjQgbWlub3IgdmVyc2lvbiIpDQo+IA0KPiAg
ICAgZyA9IE9wdGlvbkdyb3VwKHAsICJTZWN1cml0eSBmbGF2b3Igb3B0aW9ucyIsDQo+IA0KPiAt
LSANCj4gMi40Ny4wDQo+IA0KPiANCg0KSSdtIG5vdCBjb252aW5jZWQgd2Ugd2FudCB0byBjb21i
aW5lIHRoZSBORlN2NC4xIGFuZCBORlN2NC4yDQp0ZXN0cy4NCg0KSG93IGFyZSB3ZSBwbGFubmlu
ZyB0byBkZWFsIHdpdGggTkZTdjQgZXh0ZW5zaW9ucz8NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0K
DQo=

