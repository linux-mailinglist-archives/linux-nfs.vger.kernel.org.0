Return-Path: <linux-nfs+bounces-4812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC4492E98C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 15:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA35FB212C6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 13:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F6C84A40;
	Thu, 11 Jul 2024 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XdB+HHsj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tVYzHlJp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A594CE09
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704717; cv=fail; b=JjoT81+jX7htF2Q4841TT0Z0A6/vNUzMsD7qzcIBWYypvLz5bx/Cdaqfg/+tbh9/Yciri9pF6rLWFDylSJCjAU+0W7QAbZKYURV/K1ckxTnxfSSKxKk62aAHfuuItOsaHuMIbEPE3ZB2aULirsL1ElRavk4jJsRahQ2hgg1sFck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704717; c=relaxed/simple;
	bh=jdlmgkp0sC9Ices0OTXK8qzCOdICYAFiMiY8NOfmXtk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sSqSfnk01fqCcrOupsc9mEEu/nfV3VsaLlUO5N3sU1zoTutYb0BrJkcwcS+4J0mJpWIGSbI2s9JrQWRbdtjJd1zM8R2VO2bF7oslMHwMCuWS2YohQiPglU2AROjHrerPSknCvDpwGHv9fksAksyPAsAIqD6JfiAu2TchJTAXyA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XdB+HHsj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tVYzHlJp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tV6j014042;
	Thu, 11 Jul 2024 13:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=jdlmgkp0sC9Ices0OTXK8qzCOdICYAFiMiY8NOfmX
	tk=; b=XdB+HHsj9MfkXjjwYJeVz8yYvWQL9gkcnSRLLc8VdFxO5RXofxHAPBsJV
	KQ+mthoEHTlibYOVtzri/zwHrd47clLUmuNSy64zkjH99+SPsFqcj+qKYzDemoSD
	LEJPAUVd/dSJAfmW9vXg1QsyCGFGyfbwofU6Gva980s1A83vXY4k1opVxkOJU7yT
	uz9cZSNpWtB8/o0I83884BR+2+W/8XBYQ2nNPLebkV++h/oJGrgBH/Ynwc0VKMfe
	y3Zdtd4vk1DdEpz9hIKtDaoS5idq2AdMv0SCnz2dCTUXRiHrfkeGQIUCzFQ8v+gV
	uyrFINeFjGcCquSOtc5P13a8Eu+Yg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkchhtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:31:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BC0Y1M022663;
	Thu, 11 Jul 2024 13:31:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv2fmkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 13:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7vIFIaN86ADylxAP5RnzHxGeRNx8bmK8sRvbYcc4Ce1PnK1TwiWqQyQNCEvXoDJxXHxgsbNCxouSZFMD66le7dIpXLPfHFZQkD5oJEGCpmsLRrAQlbTgiC+V4uSnfn1Iyo8mLscADMiPSvDabu/sC3GXmM8LbDfw1JvutQQchTMTIC3uv45oaE/KWKMMLo5zwEZy4ziel1glrGGDgu7KKTSdzCxcKRLgrkoDnAEuhO5PYwfYslMfQOf9hz+j503DQqT4rxf7YDs8wRl/zBW42d0ykTB5k9HFYABQ4T4ExNH6aCLbFuh6WwCRhXVWymamdwjLayj0sk/mGHCa8JuGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdlmgkp0sC9Ices0OTXK8qzCOdICYAFiMiY8NOfmXtk=;
 b=gWfnP0DCWyj1etapoBvdRERLFyToRFXdaLM80chq61yN6s3GEjhitUnQqeKOONFDuNXQBwQ4vYU8df2FUZzdDSSdaIUk02M4oYUl6NK6EYIF6zaxEBlU7dDwB5V4SfNyZojJ51XnN9rF8l+6SuMV4klE48bTVy77Hq2rB46TtzUfMh0Je2g9W26EWwF6sETxd2ZhD3DBMqpJugaZTN0Eoq8/NA7ps4c5G7fBpcNpuB9i1fF7ZuZ1gWf8cUeQ1gt1gQAwbyRg7ZveU9g+Hcs0M8vFxqmHs6m0W/FeDXIgE5IBCr/A7Bf4cFWT91+lB47BqU2FcyDzGwh+hEyl6OCz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdlmgkp0sC9Ices0OTXK8qzCOdICYAFiMiY8NOfmXtk=;
 b=tVYzHlJpti988YmRkkpx/jNhOY7/kUjMwiJxV5hHzlwWDOHqm4/YzkZt3fvWQranVJ9/bKgwU+wwSxWkmg80jYVkybxlx6z3wx6ppioR0nEzrDu3OYKJ8Jl5QavpTOy4JC3zZSIWSvS8TOVG9n4lnk/D+5UkpbXzqqoI+jL7cbc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5581.namprd10.prod.outlook.com (2603:10b6:a03:3d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Thu, 11 Jul
 2024 13:31:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 13:31:43 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>, Dan Aloni <dan.aloni@vastdata.com>,
        Anna
 Schumaker <anna@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] rpcrdma: improve handling of
 RDMA_CM_EVENT_ADDR_CHANGE
Thread-Topic: [PATCH 2/2] rpcrdma: improve handling of
 RDMA_CM_EVENT_ADDR_CHANGE
Thread-Index: AQHa03j/C5AgCpK2bky6lwTwpS5AErHxTlyAgAA3+wA=
Date: Thu, 11 Jul 2024 13:31:43 +0000
Message-ID: <E0F82C7F-9936-4C9B-9CE9-F0AFF5B534BE@oracle.com>
References: <20240711095908.1604235-1-dan.aloni@vastdata.com>
 <20240711095908.1604235-2-dan.aloni@vastdata.com>
 <a4811705-b72f-4a1a-9ea8-11435b002259@grimberg.me>
In-Reply-To: <a4811705-b72f-4a1a-9ea8-11435b002259@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5581:EE_
x-ms-office365-filtering-correlation-id: 08bb7ff1-8b26-4189-d5fd-08dca1adcdba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cFlRR3VOTjVWQUhBSGMzREZROWMxQXRyTTVIZ05aQUQ4T2FIY2RudVlldUlM?=
 =?utf-8?B?Y3R1bHV5MzdsYUwrdGhxakx0c1ZnU2ExNXU2bmMvZ1FHY241emxVaFBEdFl1?=
 =?utf-8?B?dU1iRjkzWDVZbDFBRzhmNFhJY3AvRHU3VVRtY0dqZ3lLR2Z0VllsT1dadG5v?=
 =?utf-8?B?MG1GaVhENGNyM29sc2VZUVdpUjFrR3dPSTJrUE00LzdpWThiT1FmU1hWdzcz?=
 =?utf-8?B?TjBzUThFZzJBdXdqV1J1QnhwMDJUSTRKTFNZWlluODJVZGxLeG9uSFdlSTJM?=
 =?utf-8?B?bWFQVEdnbWRzQnRrU2g0MERmWi9RbE83Y0ZGVGVOWmp1WFJSMG5hNkRrY1U3?=
 =?utf-8?B?U0kvelFBU0VaUytpSHZ0OXhnNDNXcHdTakVSRU4zZWVjZFlmS0dFTGdEbWFu?=
 =?utf-8?B?SlJZKy9WeUJneEVSa2JRUUVSQlBXb3lvRmROZDdRdy9wQjdaNUZTaFNOYTNs?=
 =?utf-8?B?OEdHRGZ5anhLaXc3SlpiV2xkK2RIc2FQcElpQWhuQkNvb3Fuajh4aVlOajBU?=
 =?utf-8?B?bEIrKzJuTjZYUTNnUEJyd3dIbjBqV3JnT05vbW1JUDkrS0FubEdBR2Q4NHJa?=
 =?utf-8?B?VUlaWlB6dmVYdk9DUGJjWnNrRE8yRFJjdDNraS9tZTJyN3dJekJhZEd6Uzc3?=
 =?utf-8?B?ZEpnMDBrTkVNR3Rrc082WFo1VEhObERzSVVXWDRMbWxwVW1PUFZLM0o3cTdN?=
 =?utf-8?B?MG85Y01DblcyVDJpWUtoU3ZhM3lKY0cxaVFmSlhXTHJEM0dkbE5PMTNhVHdr?=
 =?utf-8?B?Y3JydWsxMTg5NUdQRFF2TnRVQVJKSlZJZ0ljdERVZmR1YzNaa2pqZUx3M1BX?=
 =?utf-8?B?Mk5pUitEMk1DUVBoTVZDRWVqaGlZS3huUmQwOFlDMHlVUVZYTi9zN2k3d2gr?=
 =?utf-8?B?U0JCc3pHQVBiSGEyZ2Nna2tvU1pzZ2pGaVN2VHNjV3Zvb3ZZMmZPdWRtcWNq?=
 =?utf-8?B?Y3dmQ0pwM3ZzWEwwYkZ3T0JuUGovYitsLy82RmVrdDJPMWttRkdTbjl5dTg3?=
 =?utf-8?B?aHU0ZzB1VzUyUndKUW5JQ2JSckIyRnBmdXg0Z1VUd0xaS1cva051b1p4Znpn?=
 =?utf-8?B?Z2U3U01HRkhqTTc3dnAraHNZQWlZbDA5Z1dtYm1SaGRxd2hYZmJyL3ZTZEM5?=
 =?utf-8?B?blIzMis1STZJR1ArSjlsY0RwRG1aU212Q0lsQmJtM0xxdnQ1ZDZRYVVsbXdO?=
 =?utf-8?B?YjhwdXhnK2k4dUNmSnpsbEtNek05WlhUaDlmemdWN3ZHS29QNEVXUVJtaEhH?=
 =?utf-8?B?UE5sYWh4WVZlcDlZditQclI3YXJ2L3lmejUvLzVCRzJhWjF2cUhBazdzZTRD?=
 =?utf-8?B?Mk1vS0VtQTVJK2F1TU9aWDhxNzRNM1BLTlFUb1o4Y09adHFYaGp4M0lRSk5D?=
 =?utf-8?B?eGE2alpjZjlKbVl1eU9WejJ3OEVSRTkxR1MyL0hnaldmMTlPWTRlQklOb2xC?=
 =?utf-8?B?L005QWR2ZUtleDRWQ0ZKRGlVdzNZcmhiVEpEcGtERXB3SWQ2aXZvSFRlS3lp?=
 =?utf-8?B?dEJURWpPa2x5WStOTm1aMWFSdHV3UjNpTzlkZEtnR2htVlBpWEtVbGp5Y0Vx?=
 =?utf-8?B?WHRCTnV1dkJBMFJPK1krNTh1dUpjcWsvdFc2bUlCNWVUSGE4c1h1OWN6ZHli?=
 =?utf-8?B?Z0xvUm5rcG5VT1JrR3NlYlczOVdBdEpVTkhhTzlJR0pqSmZEenZMakJ3SGpq?=
 =?utf-8?B?MmpYbUNSaW9nRlFSaUp3bktIaFdNTFlwQ1VoSmM5OFo5YWNzZ2toak1KNTUx?=
 =?utf-8?B?SjVxTWFMYjdpOHpJN01KNEJ3b292S25NYUY2aHlvNGcwQndpR1MwMkFiN2lR?=
 =?utf-8?B?d3Q5MGJTMmlXdjFyYjl4QT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SFpjNjdRZTR4bHdZWm9UbXpOZk03ZWRSLy9KOXlXOUhyNHl4elZRalB4TjNi?=
 =?utf-8?B?TTlER0tTQzhkbzZYU0ZmdUZTQUR3eUduckxkVGFmdVdZOFZrRWxFUmtpdjRx?=
 =?utf-8?B?TnR3V1pkUWlOelRYZVJIWi9ER0tGTUtZRTlrMG52NkMyUUVaV2dxUjd6VmlM?=
 =?utf-8?B?Um4zcElCZEk2M1p2d0tuZEhxdW9lNjRwTnJFVnlJYm9aQW52ditWYjhSQUdk?=
 =?utf-8?B?QmtocUxScEQ3TzRUMERBek5IWlhSN25xV2VKZjRzdXdDTWdpdGQzUlpPbkxa?=
 =?utf-8?B?K3JhcWFML2Zld0JIMVNsQnA4Q29USGNYR2xZNG5Uc29qbmFVWWtnZnBjdUlN?=
 =?utf-8?B?SVVYWEdFSE9HRzcwZnRwYkxRdzF0N2FaS2hDTjgrc2F3end0bTduWHdqeks5?=
 =?utf-8?B?VXQwbWJDYVlNSjRYb0pzR3UrY0VaQStKNVg0SWV3ZllRRnh3UDFvaXQxdU80?=
 =?utf-8?B?MEpuZlp5Y0ZVcXRra2JqSHNDbS94V1kwbXd1bnMrNWkwWDR1dnFnYUE1ZnYr?=
 =?utf-8?B?ZGFTbGM1aVROS1doVjczUitGaUpCWGt6bGNCK2gvZ01YY1VSZFdBc0w4ajVV?=
 =?utf-8?B?MnhPR1JKbmpjbFFYRkZhQmx3Z09vNmRtWXpXcytGaDVWLzJLSlA5NnJycEpE?=
 =?utf-8?B?VlA0YlZ3RWZxVExQK1g3azhlTHFXYjhnZVFtTG11S3YvY0NPaWVmZVhEZmd0?=
 =?utf-8?B?U0pqeDM2NW1RK2lPc2tKRzU1NWJzWTRGSmx1U2g5ZnpxdUZ2eUptczZPd2NT?=
 =?utf-8?B?ck5hcU40L3llS2xiSmFKazFnU25TUUNldlNjdCtWQTVDczcwZU9DN1FyU2l2?=
 =?utf-8?B?UlJKRWlDYUdaSldtbDcyV2VsMGl4SlpZNmdoTy9qTzJuaWlaTy9kcHhUWlZK?=
 =?utf-8?B?RlJCN0ZrdkdYQ0RSOWQvYi9xNll1TFdKdk00bG1ZeTNUbVBlWFh2WXk2M0d1?=
 =?utf-8?B?ejVGZnNWTjVBaGVrYU4rMnQrNU8xMERkcG55WllaNmVHYlVqZ09IMWFRNW1t?=
 =?utf-8?B?eGhSL2tZSnlxVm5Pa0doTTRnY05VZWJXZmJYcXRCdkNtR0ZNaitxdzlkcUFs?=
 =?utf-8?B?Z1BzUm9pckdIQ0sza3hYcEtIbURDUG51VnAybjB6U2hHa010d3lkQVJiV1ZL?=
 =?utf-8?B?dHl6bkdUWEloYjBWQytLUXJ4ZlE0UW04K1VVSHY0akdhc0VQOTBLVHBxZGxV?=
 =?utf-8?B?UVRGbFUyVGpGd3MvWjlRaXlZZWorYXVhWW15VmVGUUpsN3VZTEZIbWg4Qmtw?=
 =?utf-8?B?Y3FzUXoyTmNlUEdkRm0yZ0wyOGlKWG1YS1I2aVcrMEdJZEVKa3o5RmlnZU1Y?=
 =?utf-8?B?Q3JHK3dVNEJuR04xenJGQ1YzeHU5aFREQmN3Yi9PY3RGWE0zaXVvMDhsWUZB?=
 =?utf-8?B?OUZtUk9OSXE5ZCtGSUtrMzNXc25XRVI1UXB4WFBXL1VpYWJ6bk56bzNyclZG?=
 =?utf-8?B?Y3BjQVlxRU9IK2p4Y0tPRDNvN1hSZHFhak5rZy8wc1p3Vy9KQzVwckJLUklD?=
 =?utf-8?B?MXUwKy9qSjVTY08yK29naGhuZVBaN0VnZkRLbFJ3b29XQTBzdGxsTUtyWUc5?=
 =?utf-8?B?dFFZV25POS9IVU4xZ3ZDL2phZmtSK2x4eUFUNjZpWmhqRU5tandNV3h1SmtL?=
 =?utf-8?B?MklXZDFmd0lJd2RxRGhES1FIeGwxS1pZeXVMK0pqd250SnlyUU5YNGJKY2lH?=
 =?utf-8?B?czJiV25pRU5wZ1lBaXBQMWNud3QzakJjTEJJZkk4c3d2VGc4ZmdwcWdwem1C?=
 =?utf-8?B?WnhQVDJxakJ4d2RGMjMvQ0J2NGJYQllGRXE4UTR4MjV2bjUyK2NxYVorVUJZ?=
 =?utf-8?B?SS9VZ1lhU0dOQWhGUGVIdEFwTks1WHJRWXRzZGxva04yZmdoY3h6Y3VoTEFH?=
 =?utf-8?B?N3RaZWFPOWRXTDRPdXNsZWxjNlV2Vkl3QzlmM01TNEVpMG8yaWo0cDYyUlNy?=
 =?utf-8?B?MUgvY2JPREYra3lncG1MbitIVVZRZ2Jkb29NcFVRQmJZTkNKL3pZazlld3lp?=
 =?utf-8?B?cm9HQlE2RUhuaHI5cVVRVEtaVWl4NmFsNWlsL0NBOW5iNnJxSWxNZWFWMWhB?=
 =?utf-8?B?K1ZHbUJSV1RJSUV6aUVtbno0bnJSQzBEVjB1cjF1V2VPY0p4dHp0djJhdnJi?=
 =?utf-8?B?anR0VXJDclhBYlpXM0RMYWFUVC9NREFOSEd3QkpzKzR3MDNLTzI0NTR0N1dG?=
 =?utf-8?B?Q2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <546F4163C15B79408410EB2FECB80025@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vANR+vof5NN5PiOmJrM1ssX06RBxTvmUpaGoyRhlW2O9q0tVtj4n2VrKenoA3DzEzATapb5eUJH/fc9NheRZDwF/3Jw8vbJXsbo0PMr0hJVGhOkQsPpDt3cehF877kadPiLir0inv6FvfxvUqhHfapdMraHF4dtohEIkG7UDLCEc5+1bjuMc49kaFIpLyw0tpG96aCZiDkZKz/SKGfVrej8VXp00dsUY34pfeH7eD8c5ZPDX+pBbW0eYbz5N5UNOZWxqBoFH4Oh3AVTZjKVJJ97mFQr4ukkzAqnfslBso/WJ+r72EYzwy7ptwwUZa/puaB8VGkJ5sEZqOHDJSncONCmxor1q0lF1TjYODVADP5ub8HzpKkkxrWX10NhhLOj4xkXON9vBKbiWm0SH8yL4PzKIRYckCs/STCClIc9POHZZKWsv59O9FWtFN9WWERt79LlJ81bjjX7RR6ktSAQt+7SMIHh96UKUF1WP1ZAofZnS/MtEO71cvmYYMfizxlsi+0Qjcgkk28T/eFclt3ioEKUVfTyLnw3vEtI8zXo6Majj36l2SzbIfj1QnrFa1/A3jW6kkzP4tEUTSTHHdPqFEM1aK2RE3W9nM3P3dsPgw9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08bb7ff1-8b26-4189-d5fd-08dca1adcdba
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 13:31:43.2295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npyMP+nyQRMXQitHas0dfFSKmC03UbtKqxAy8z6t4DoNmP0zC1/lALTKYkuYR2VXN/lzxqI+jJMjST00hUlXKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_09,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=789 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110096
X-Proofpoint-ORIG-GUID: uaksedTzP6EKGd8Uc6iCfG-MMMXJuUSh
X-Proofpoint-GUID: uaksedTzP6EKGd8Uc6iCfG-MMMXJuUSh

DQo+IE9uIEp1bCAxMSwgMjAyNCwgYXQgNjoxMeKAr0FNLCBTYWdpIEdyaW1iZXJnIDxzYWdpQGdy
aW1iZXJnLm1lPiB3cm90ZToNCj4gDQo+IE9uIDExLzA3LzIwMjQgMTI6NTksIERhbiBBbG9uaSB3
cm90ZToNCj4+IEl0IHdvdWxkIGJlIGJlbmVmaWNpYWwgdG8gaW1wbGVtZW50IGhhbmRsaW5nIHNp
bWlsYXIgdG8NCj4+IFJETUFfQ01fRVZFTlRfREVWSUNFX1JFTU9WQUwgaW4gdGhlIGNhc2Ugd2hl
cmUgUkRNQV9DTV9FVkVOVF9BRERSX0NIQU5HRQ0KPj4gaXMgaXNzdWVkIGZvciBhbiB1bmNvbm5l
Y3RlZCBDTS4NCj4gDQo+IEkgdGhpbmsgQ2h1Y2sgaGFzIGEgcGVuZGluZyBzZXJpZXMgZm9yIGhh
bmRsaW5nIGRldmljZSByZW1vdmFscyB3aXRoIGEgZGVkaWNhdGVkDQo+IGliX2NsaWVudC4gU28g
b25lIHdvdWxkIGhhdmUgdG8gcmViYXNlIGFnYWluc3QgdGhlIG90aGVyLi4uDQo+IA0KPiBTZWU6
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2NlbC9saW51
eC5naXR0b3BpYy1kZXZpY2UtcmVtb3ZhbA0KPiANCj4gT3RoZXIgdGhhbiB0aGF0LCBsb29rcyBn
b29kLA0KPiBSZXZpZXdlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCg0K
RllJIEFubmEgaGFzIHRha2VuIG15ICJycGNyZG1hIGliX2NsaWVudCIgc2VyaWVzOg0KDQpodHRw
Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvP3A9YW5uYS9saW51eC1uZnMuZ2l0O2E9c2hvcnRsb2c7aD1y
ZWZzL2hlYWRzL2xpbnV4LW5leHQNCg0KUEFUQ0ggMS8yICJycGNyZG1hOiBmaXggaGFuZGxpbmcg
Zm9yIFJETUFfQ01fRVZFTlRfRElTQ09OTkVDVEVEDQpkdWUgdG8gYWRkcmVzcyBjaGFuZ2UiIGlz
IGEgZml4IHRoYXQgeW91IHByb2JhYmx5IHdhbnQgdG8gbWFrZQ0KYXZhaWxhYmxlIHRvIHRoZSBM
VFMga2VybmVscywgc28gaXQgd291bGQgaGF2ZSB0byBiZSBhcHBsaWVkDQpiZWZvcmUgbXkgcGF0
Y2hlcyBpbiBvcmRlciB0byBtYWtlIHRoYXQgcG9zc2libGUuIEkgZG9uJ3Qga25vdw0Kd2hhdCBB
bm5hJ3MgcG9saWN5IGlzIHJlZ2FyZGluZyByZWFycmFuZ2luZyB0aGUgcGF0Y2hlcyBpbiBoZXIN
CmxpbnV4LW5leHQgYnJhbmNoLg0KDQpRdWl0ZSBwb3NzaWJseSBzaGUnbGwganVzdCBoYXZlIHRv
IHJpcCBvdXQgbXkgcGF0Y2hlcyBzbyB3ZQ0KY2FuIGdpdmUgaGVyIGEgZnJlc2ggc2VyaWVzIHdp
dGggeW91ciB3b3JrIGFuZCBtaW5lIHByb3Blcmx5DQpvcmRlcmVkLg0KDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==

