Return-Path: <linux-nfs+bounces-7830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5143E9C3360
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Nov 2024 16:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745641C20986
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Nov 2024 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C545C603;
	Sun, 10 Nov 2024 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OeDtQgS1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jXUGhA6B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FD682D91
	for <linux-nfs@vger.kernel.org>; Sun, 10 Nov 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731253759; cv=fail; b=bku1g86EvpdrnZzTTPs9i39WC5qB/2KopmQbQpMfA4ZTaAFx6YJ+d+3uYhck4P08VaqA+AWGZX5w2iuhXeUiKdAmiIEsuS8D2i2+IMySvI+UP/IBXFsXq8ldlEl+wSMJdWBFkhGZmCVy8Ch+gCUv1JlF83X8VcyPDCrhucO5+KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731253759; c=relaxed/simple;
	bh=eVo9Ufz8QP8j2wb7ECixWHBJO65OTSjAUH+BN9BAqkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ARVeAQ+xkcbn9WCjRNHSRxHOMLSq63x3hV+Iaz6/bQYHCWNiJQGPB6R+wdi4nhW1klR+5cBjEJ/AkQk4hOicVB5bT90Gc24fEcD4E2XUFfX7oMwbGRS7zuYk5cSytAI3sM1RM019A887pouu0gwtOI+a8UEaEQgJNuHxp2LcSl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OeDtQgS1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jXUGhA6B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAENuPY017609;
	Sun, 10 Nov 2024 15:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eVo9Ufz8QP8j2wb7ECixWHBJO65OTSjAUH+BN9BAqkI=; b=
	OeDtQgS1lPEciQZI2IPrAWwio0Y84AzMpppa68z3wSlsX/9pgYYt2ZoyvOtGepEQ
	re6qi6BVqoQLfeXwfktA3xv+J4OtV3BcufRdEYv4IdiwomXWgtdFraA977Bwd2S0
	1pH3m/kaFUve22E9OTduFpUM6drj2yW0GHb/vFEq6QhuQulP7lcdVA7n8Ie8EcDe
	UleS8/WPRfeD1vmXLppffCW96fpEK6EEr/I/tiYnozIcmR4YE/QeXZqZk6nFZyxT
	QL760EvxqjLMAjKbtgXH7axxSFM2FB73VJehfpeX4ZZVCw4uKHuOCGu+XURwnzZQ
	fWAqILa01knPnCj+cMHHkg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k598ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 15:49:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAD0r6k024241;
	Sun, 10 Nov 2024 15:49:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx660yap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 15:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6xbAOUK69LyoV7wl/fQ1TSgca/sGv36MIIkIPS9LxZOGdGVDkiU9zt5BBD2v6IxY2p39TVl8G9w3BlCD49bKv/6X3ZwSRt1UXGnmeJwIHs8ts4HD/R2xMOCYRt9fmQGtKgUt0N9XFWWpl9cJVWLsx49bdxSg4vtMjDUtqGl4bGECTC7hc+6Qu0pSvEkT/dZkwOn5FCDg4JatOBV4QBnAY2uYi3LM8OZbmyLHgGKWICj6gI8JWQ2pDqmYfKKSEe3Lu3lEwQxlgu2hXN5wFOIHhZwvoYaViypMqyrJTy+jolgHFBumfnLsLi2Obs25WOYMMcFqEawdw3csQ9EryFRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVo9Ufz8QP8j2wb7ECixWHBJO65OTSjAUH+BN9BAqkI=;
 b=JsqeN0W/CVehIZih3Y3mSptr3A1sP55/UJVcZCJo2X8JFP4xon9xYCzbrj/w9eVnlidIrTO/RBpjGudEACt40N779INkv0DgVK5vbYrANGjDlBxjsT+ciNzZhjOo9GeQp6JymGvhe+IxGZ7pT7xXccT6fxN1boRvAVbnnz4x8x9vnWTTTDMOtLYySNCxzMSj5HXWi/Y/QdNXz5SrreZS1Ceoo6pA9ALNGa4AZWLttsj6N0NzGsoPbDj7pekX4tubwpdF203JlGTK7q3sj9ND3ZMYlBQgAOTa3oOnO8ivdDEey/J3Op22eOo6+SrE10nPzjT6FTdq5/GMFcXG2jEAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVo9Ufz8QP8j2wb7ECixWHBJO65OTSjAUH+BN9BAqkI=;
 b=jXUGhA6BDbJmVtzZQ+Mei4nFMNXXpMb1fdiRTNbr2oJcxnr8dovGNF1zM9YdWr1k21FMpk7zZ+SY0WW+fbECAIFMZYIu4VT7LcXrWZbKTcU+8xhzVaePJsOBkt136Wmb9GOyGHSbAo4Z8xHvmf6nCM/YOWb3D4PJ75NKx0Zw4M0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB7663.namprd10.prod.outlook.com (2603:10b6:806:38e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Sun, 10 Nov
 2024 15:49:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Sun, 10 Nov 2024
 15:49:00 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker
	<anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton
	<jlayton@kernel.org>, Neil Brown <neilb@suse.de>
Subject: Re: [for-6.13 PATCH 00/19] nfs/nfsd: fixes and improvements for
 LOCALIO
Thread-Topic: [for-6.13 PATCH 00/19] nfs/nfsd: fixes and improvements for
 LOCALIO
Thread-Index: AQHbMjeNMhWQbOW2IEC4DMQI4eESnLKwq6AA
Date: Sun, 10 Nov 2024 15:49:00 +0000
Message-ID: <2B08F0CD-C9E7-4B8A-9F2B-E9A0CBDAD264@oracle.com>
References: <20241108234002.16392-1-snitzer@kernel.org>
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA1PR10MB7663:EE_
x-ms-office365-filtering-correlation-id: d1f7403a-de51-4b2e-e299-08dd019f31b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TG9mYS91bHhWMlFZdWpZVHV0M0FncHlHNFoxU2FOQVlRdnp0eG9zOTNiT1Aw?=
 =?utf-8?B?c3BRUHdweFFENjJreEZ6RjdSb0syUWEwajZiNFVjNmQxSjRudm1HZEViMmVj?=
 =?utf-8?B?cnZOejNZc25maGc2NkVsWXVDbGdCRmloWFA5cGppenRTY1RFb1ZDbTlmR2NU?=
 =?utf-8?B?eWtoQXZkK056cUU2aGxNa2tBVmFCZW9EbFV0YlR6SnJoeVlTMXFTUXZtYjVQ?=
 =?utf-8?B?ZnRnMGsxZDJMNC9KRHhuSys4WWJ4b0dSTllOVklKRnZFSHgrMHVPRDJzWStP?=
 =?utf-8?B?SDI3Z1VZTzJmUVVUSlYzUURmUldDMkRYRWRPanNSQjEzd3FzL2Jzd0VNV1VF?=
 =?utf-8?B?YTRDeVFtZFRGcG9odDR0aFNNUHY3WEoyUkRZRnRvWGFUa0w2WS9RN3g3NkhJ?=
 =?utf-8?B?dndhdmRWTEVlMEhqYjFHMm1yKzQ0WHd0ZGY3Q0puT0RvVHByVlRLWUNZRVdE?=
 =?utf-8?B?enhzVFFkTnJWU3dkK2lyWGdFUTNYdElLY3RwV2x5YkJWK0NhL1ZsK3F2V0Z6?=
 =?utf-8?B?cjdaTjdvUXdQenczcGxOVFVXR1EwcUNjQUZGa2xtVDBwa0tKL3M0em9hR3lk?=
 =?utf-8?B?dHVEZTZuZTBaT0VXTitLMjRnczBkbFp2WGs0aTNjbDJ0QUxsWjU3N0hQSlVk?=
 =?utf-8?B?WlEvOTJyMUR4YjkxTUYrS2N0M0wyeTFTbERFQzJLYkQ0UDRSVWc0VVZIZG5R?=
 =?utf-8?B?VVMzUmR1dDhuU3dwRzBDdHBrRDlXbFI4RXNkeWZhaGZNY3grcEtSbldlSFlC?=
 =?utf-8?B?bkNNeXV2Y01YdHZSdklWZTljem55c2I5bmR2OSs5UFo3Qk4xbU1lejh1cktk?=
 =?utf-8?B?SEdvajV1SWdqN2p0MDRsdlh5UjZocStmSDNqcml5dUlNYWtpWWY0NmQxQmZQ?=
 =?utf-8?B?UUVyWjlhcVN0UTRsN2FQZWVHY1ErU0xzV2paN0tzSmxQMGp2S0N1UVU2Vy9O?=
 =?utf-8?B?bktaa09ZTTcyVHk0K015ZnpqZ0VBRUFHbEdzM2QydThCQlV2bTgyUTlUKzFF?=
 =?utf-8?B?d3RUTVVEYUs0RjhNWkVsNzRsZzdYeXBYTURBM3c4MWlRTWNvYzBoYlVhSUh0?=
 =?utf-8?B?NEM3dWVwcHMrd2RTS09VQWV4b2g4bzh4TGFqT3hkeEZZbG1KVGlDdnFJRTlm?=
 =?utf-8?B?bHpPbVU0SjFWeFp0TjllaW9GQnZOM1p3MVFUQXAycGRYTkd5UHBNUitLYktZ?=
 =?utf-8?B?eEZvbk9HY09mWTJmcXdUOGVBdGV4bDUzeS9ULzJFSElReGdJZUNVSFBnT3Mr?=
 =?utf-8?B?cUN6RWRZUnE4Yk95SEZPMjBvQ1craXpHMTFSSTYzbmYvcUZHdks1aTdOTDYz?=
 =?utf-8?B?MW5UQkNlbTl3V2hYWjhmZVIxZGxpcndxYTluMWl6WVR3L3ZickRnNGZhaHE5?=
 =?utf-8?B?aUVzaGg3a2o3M2dOclRXU2ZTR2pTa2RHdWdrT2lucUoyMHVyWTFTR3F0c0lP?=
 =?utf-8?B?RFlhY0ZEMmRwMlBBNjM3NlhjcXUxM05hVk1ObFJTVFpHQ3Bna0lEdDBLSmVz?=
 =?utf-8?B?bHlKcDEvVXhsS1Vhd3lkZGhFYXljdGFGRnJnak9nRnR0V0hEN0dRUlNmQ3lt?=
 =?utf-8?B?bkxRY3FsUE5tS3dWcGFpdUJlV2VkR21SRUxmZDdndng3KzkwQ2pkMGNMYWU5?=
 =?utf-8?B?a1lSbkZCN0ZBcE45NGFLcFN2THVaUW8wcTdFY1BwMWxUb1hDNVYxUUEwMHZa?=
 =?utf-8?B?NjR3RWVhNU9zdHlrdmNwRmtnS040QXdwL1RLaDV2SFVoKzNpSUxIUEo1T3ov?=
 =?utf-8?B?eEtUR1R1cWpvdGtDRWNzV0w0akw3VGpOSUpPR3hWUFd1WlBKMU5KMmd1ZDVt?=
 =?utf-8?Q?pqwaEKRdbncTpEvic3bT88QS/MGCuA6PjVS1I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTdaZjZVU1grd0xkMDNmaTByZmhlc0lkVzJnN0Fadm4rYXRjK21zV0hTenZY?=
 =?utf-8?B?SXVDNVFtUDNBL25meWhqUW0vNmxtTTVvZnRxNkFJQzZiU3RRckZQWGM5WUFV?=
 =?utf-8?B?SlpGZ2JwdTF5cDJwclVIUU5yeEZyRTl2OUduZDA0cjN6cTI5TU85TlBQQzhm?=
 =?utf-8?B?MzJtWXdkNVpTUnpZcm5qdEc5Qytzdm00ektqYllEVGE0RmZKRm9GYmRHOVBr?=
 =?utf-8?B?WDB0YUFaL1hKdFdMNElsOW40SE5CaTE1VGVBa0tBN0J2ZEtIREFGOGhSZnBY?=
 =?utf-8?B?MzJlQUk4WXp2TVFUV29FSEpRTldXMUs2N0dEd0VoZndsUENSb3VJdW04L1RC?=
 =?utf-8?B?dVdsWG5VeUZreGVlbVE5L2JJbmh6ci9mcGtPN2pLWHdTd3NOeGdsZzgrdGhq?=
 =?utf-8?B?N0FlcGpmaXU1QVNEUE1MdjExWFp4UFRXVnJsSFpNM1MwOUxTU1hKcVFmcTBm?=
 =?utf-8?B?T1RhQUw3WmJBSmN4Zkk4OHNsSFZFcXUzUkVKWGUxYThaeW1sUDNBY2UyZ01M?=
 =?utf-8?B?d2UyNWx6NFk3NSs3K3R2aURmeSs0ZElsRnpXbDB0MUs0bWJEc3hibFRMTTQx?=
 =?utf-8?B?VWY1OXRCcHZUWS8vRDFvMG1NcFBQckVnRmcrRjdVbldrVEdSYzhJdkVTaUM4?=
 =?utf-8?B?VnJkUVFoOWNFZTlPbll0YXpOZGlvTXhFVDUyT2U4V0JnUThxeW9mdVJQcThJ?=
 =?utf-8?B?ZFRvVmhLTlJxV1ZWL1k4TDAxOW1TUWI3NG1oWW5DdVljUEpPQVVNMnBBaHFD?=
 =?utf-8?B?ZittaXJDdXRyYitTRXhaR3J5RFJxRUF3RmxUUDhGUjhiZDQ0TG15RmJyNTN4?=
 =?utf-8?B?ZEk0Y0hLV3FFdUxOWHBYREV5bERrU0owRUFkUTYxWkJZMkVBcUU2bm1NcEty?=
 =?utf-8?B?MW94T0I4NUNpNEpmRDFSUkdMQ01QZWUyYWZIVVR2eGtiZkx4WHdJM2RnVS9C?=
 =?utf-8?B?cFNoZDZHbDV1aWlGbldBb0Z4NktLYXRuUjR2YkZXcHVCb3ArMnNIU2RYWkJi?=
 =?utf-8?B?Ull2cDVHK0tUR0M2eS9UNDRPbFJwc2xxMkFXWnJVUEhXU0lIOWVWbGQ4ZG5p?=
 =?utf-8?B?Tnh2MU5SR3FvWmhjQzczM05nNENnMzR4dXdQQXU5Um5MdkV6RE9SQituMEZL?=
 =?utf-8?B?MW5MYmRCSEVmZWg3aVE4R2VSUlNBZThpNEdNdUdvbVRPN2dWaW1rNXc2SWdy?=
 =?utf-8?B?akN3K2o5VHRnclNCVjY0aXBKZ2dWWFhzcGpKaVRxcEMyRmV6YnNXWWpkbkF3?=
 =?utf-8?B?N0VUZWN6dUc0OXJaZ25UdXZxbkNEbUhxbCtsWmNsS205Uzd4enpSMW9LL21U?=
 =?utf-8?B?QzJZZFVzWHU2TkJrb1FteklmUDIvalNzQUlZMTNxMTVNK2ROOG1GMldEZEVt?=
 =?utf-8?B?ajB0aE9TNTFVdFF3eFZDVm9SZ3R6ZmIwWmh6Zi8wLzZGSi9XY0NJeGRrR1Bl?=
 =?utf-8?B?YTBPOFNWRDNMZGFEL2J0S0dURmNVYmYydGh1OTNpZDM4UXArVWo2SUE0dlFq?=
 =?utf-8?B?MERCRXFzWFc2V1JEcnN0b2xWWlVCVWFMWDl2d3RpamlzY3MySm4xK2plWUd5?=
 =?utf-8?B?QVJ6eVV3ZitUVVlHQ2hRQWN5RFcrNUVpY2hFTU5IczdxVmtjS2lsRjBDak9z?=
 =?utf-8?B?bDRpRXJOSU91Y1d5QndZR3VwRGptcVJybStoN2dBNUdaSDJpWThFczBGcWVa?=
 =?utf-8?B?TldNL2JPSUVPcUVFRVZhQUlmS292a2VVb0Q1M05uSXMvQk5rT2JwcEhya3ZL?=
 =?utf-8?B?c1NrbjZVRlUrNEVycjh3TU1oQ2M1Zzc0Wng3SWRoVnd1K1RqNlp2Q2hIT3NX?=
 =?utf-8?B?VklXZFdpc0dNVkVsaXVIT1VVa2NPZnRxWEVkeXpCUXNpRDNESmhXeUlKWTBz?=
 =?utf-8?B?Z2dhMEpGenFjdEI0MjdzUUFWNW41a21MWXF6WGxVUHk4akQ3MHZqSHkvb1RG?=
 =?utf-8?B?TFptand3Qzc4Q1BjeUhtY2kzVlR3K2NQcm1BYUpVOVJ1NU1laS92YWxGeUU4?=
 =?utf-8?B?bk5meUFVeVJ4c1VnYnFHWHFoYmtXRHFXMnVYZTJEY1FoRS9yRmI5aVpWKzYw?=
 =?utf-8?B?eWNZdXAyK1o1MHdpREVkTnNSRFlUbDJJYlk5QzMrUy9oczI3Uy9YcktIVTJ1?=
 =?utf-8?B?ZmRtUWNaRHAzeVgyQXJMckhsU2tPY1N0enRua2MxYXRXQ3VuNFFPTTdueFQ4?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC016E1E496B694BABF7AB9FB8E37AAB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+IT0a5GTppacNdJhPJrQUGyz3kvo4jtEzT1cJjF9T0S92qjrJ8JMihFU0G625lGSUxvOe0Yb16MlOti4Obu1dJq9o8Kf8svVbbh+UZXNdruhDJ3hhEHZfQ24wpUNoQgXvZxYbOWXbt/EKCSZ5yKJvg4YVV0Q7cm9eKT6CqFVNIWjuay2NbGvmO7piCYfpq237yxfo7Gp21wRyq88jHSi0TM3r2fx35YHdkrhNpjNDNmNuDMIPatBtlHf5na2CVshFOYBOqn+JbuqdtA7F8WAHuFJexpEtkFDoBVFkPqpmCx/ZmVcM5bIsJGPJaTSAIoApwd3Ksz/ap5VRSfMC/b7E6yODQc176Wr2d1VzELIb+idpXDVggXjRntcpbQmZJFepp7TgXzETL3HectgVPZ0RRCRGaO1H01S820rWYiqjuu3l1IdHBvgMv7UHuR7A5+MSbuAhBfmFB4XXc8cOhXboLmMjuSBzDPX9inoqxsU8/6QD1/c7Cq+l8+iSJqgL1GRIzaQaBbiFTGbCYxPHiJfxhvnSrhPrLNshrcJNMn423ZytX4KhwGZ3vyqXxS42f9DQyQi3caOMTN6Wykl/X/Jt5o8x010QZEroCR37KOl/n4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f7403a-de51-4b2e-e299-08dd019f31b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2024 15:49:00.1316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fLbQQdgwX6V41iDYsf7NyOuaXHS8FzLLrBipBzhJerkryf5OZi/OYBD5CuVZSnkvQwOYuQWG/kyrPfeX8Bi9wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7663
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-10_13,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411100141
X-Proofpoint-ORIG-GUID: BeVfc1R9U50eMgzu0xD_qjQkG0dbc_-o
X-Proofpoint-GUID: BeVfc1R9U50eMgzu0xD_qjQkG0dbc_-o

DQoNCj4gT24gTm92IDgsIDIwMjQsIGF0IDY6MznigK9QTSwgTWlrZSBTbml0emVyIDxzbml0emVy
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gSGksDQo+IA0KPiBJIHJlYWxseSB3YW50ZWQgdG8g
cG9zdCB0aGVzZSBwYXRjaGVzIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIHdlZWsgKG9yDQo+IHNv
b25lcikgYnV0IEkgaGFkIHF1aXRlIGEgZmV3IGlzc3VlcyB0byB3b3JrIHRocm91Z2guICBUaGUg
YmlnZ2VzdA0KPiBjaGFsbGVuZ2UgY2FtZSBmcm9tIHRyeWluZyB0byBkZXZlbG9wIHRoZSBmaW5h
bCBwYXRjaCBvbmx5IHRvIGhpdCB0aGUNCj4gd2FsbCBvZiBuZWVkaW5nIHRvIGZpbmQgYW5kIGZp
eCBtZW1vcnkgY29ycnVwdGlvbiB3aXRoIHRoZSBmaXJzdA0KPiBwYXRjaC4NCj4gDQo+IEhVR0Ug
c3BlY2lhbCB0aGFua3MgdG8gTmVpbEJyb3duIGZvciBoZWxwaW5nIG1lIGlkZW50aWZ5IHRoZSBz
b3VyY2Ugb2YNCj4gdGhlIE5GU3YzIExPQ0FMSU8gbWVtb3J5IGNvcnJ1cHRpb24gZml4ZWQgYnkg
dGhlIGZpcnN0IHBhdGNoLiAgQW5uYSwNCj4gd2UnZCBkbyB3ZWxsIGZvciB0aGF0IHBhdGNoIHRv
IGxhbmQgdXBzdHJlYW0gZm9yIDYuMTIgZmluYWwgKGJ1dCBUcm9uZA0KPiBpZiBpdCBzbGlwcyB0
byB0aGUgNi4xMyBtZXJnZSB3aW5kb3cgcHVsbCB0aGF0IHNob3VsZCBiZSBmaW5lLCBhcyB0aGUN
Cj4gRml4ZXM6IHRhZyBzaG91bGQgZ2V0IGl0IHRvIGxhbmQgaW4gNi4xMi1zdGFibGUpLg0KPiAN
Cj4gVGhlIDJuZCBwYXRjaCBpcyBhbHNvIGEgZnVuZGFtZW50YWwgZml4IGJ1dCBpdCBpcyBrZXJu
ZWwgY29uZmlnDQo+IGRlcGVuZGFudCBvbiB3aGV0aGVyIHlvdSdsbCBleHBlcmllbmNlIHRoZSBS
Q1Ugc3BsYXQgaXQgZml4ZXMuDQo+IA0KPiBQYXRjaGVzIDMgLSA2IGFyZSBjbGVhbnVwcyBJJ3Zl
IGJlZW4gY2Fycnlpbmcgc2luY2UganVzdCBhZnRlciB0aGUNCj4gNi4xMiBtZXJnZSB3aW5kb3cu
DQo+IA0KPiBQYXRjaCA3IGFkZHMgYSAnbG9jYWxpb19PX0RJUkVDVF9zZW1hbnRpY3MnIG5mcyBt
b2R1bGUgcGFyYW1ldGVyIHRoYXQNCj4gd2hlbiBzZXQgd2lsbCBhbGxvdyB0aGUgdXNlIG9mIE9f
RElSRUNUIGZyb20gdGhlIExPQ0FMSU8gY2xpZW50DQo+IHRocm91Z2ggdG8gdGhlIHVuZGVybHlp
bmcgZmlsZXN5c3RlbS4NCj4gDQo+IFBhdGNoZXMgOCBhbmQgYmV5b25kIGFyZSBkZWFsaW5nIHdp
dGggdGhlIGxlZnRvdmVyIGJha2UtYS10aG9uDQo+IGJ1c2luZXNzIG9mIHN3aXRjaGluZyBmcm9t
IGNhY2hpbmcgTE9DQUxJTydzIG9wZW4gbmZzZF9maWxlIGluIHRoZQ0KPiBzZXJ2ZXIgdG8gZG9p
bmcgc28gaW4gdGhlIGNsaWVudC4gIERlZmluaXRlbHkgdG9vayBzb21lIGVmZm9ydCBidXQgdGhl
DQo+IGVuZCByZXN1bHQgaXMgd29ya2luZyByZWFsbHkgd2VsbC4NCj4gDQo+IFRoaXMgaXMgcXVp
dGUgYSBiaXQgb2YgY2hhbmdlIGF0IHRoZSBlbmQgb2YgdGhlIDYuMTMgZGV2ZWxvcG1lbnQNCj4g
d2luZG93LCBidXQgSSBfdGhpbmtfIGl0IHdvcnRoeSBvZiBjb25zaWRlcnNhdGlvbiBmb3IgNi4x
MyAodGhlIGJ1bGsNCj4gb2YgdGhlIGNoYW5nZXMgYXJlIGNvbmZpbmVkIHRvIGZzL25mcy9sb2Nh
bGlvLmMgYW5kDQo+IGZzL25mc19jb21tb24vbmZzbG9jYWxpby5jIHdoaWNoIGFyZSBvbmx5IGJ1
aWx0IGlmIExPQ0FMSU8gS2NvbmZpZw0KPiBvcHRpb25zIGVuYWJsZWQgKGV2ZW4gZ2VuZXJhbCBO
RlMgY29kZSBwYXRocyBhcmUgYWxsIHdyYXBwZWQgd2l0aA0KPiBDT05GSUdfTkZTX0xPQ0FMSU8p
Lg0KPiANCj4gSSdtIGhhcHB5IHRvIHdvcmsgdGhyb3VnaCBhbnkgaXNzdWVzIGZvdW5kIGluIHJl
dmlldyB3aXRoIHVyZ2VuY3kgbmV4dA0KPiB3ZWVrIChvciB0aGlzIHdlZWtlbmQgaWYgb3RoZXJz
IGFyZSBpbnRlcmVzdGVkIHRvIGxvb2sgYW5kIGhhcHBlbiB0bw0KPiBmaW5kIHNvbWV0aGluZyku
DQo+IA0KPiBIYXBweSB0byB0YWtlIGl0IGFzIGl0IGNvbWVzLCBJJ20gaW4gbm8gd2F5IF9wdXNo
aW5nXyBmb3IgdGhlc2UNCj4gY2hhbmdlcyB0byBsYW5kIGZvciA2LjEzLiAgSSdtIGp1c3Qgbm93
IGNvbWZvcnRhYmxlIHBvc3RpbmcgdGhlbSBmb3INCj4gc2VyaW91cyBjb25zaWRlcmF0aW9uLg0K
DQpIZXkgTWlrZSAtDQoNCkknZCBsaWtlIHRvIHNlZSBwYXRjaGVzIDdmZiBnZXQgYW4gdW5odXJy
aWVkIHJldmlldyBhbmQgdGhlbg0Kc3BlbmQgYSBmZXcgd2Vla3MgaW4gZnMtbmV4dCBhbmQvb3Ig
bGludXgtbmV4dC4gSSBkb24ndCBoYXZlDQphbnkgb2JqZWN0aW9uIHRvIG1vdmluZyBmb3J3YXJk
IHF1aWNrbHkgd2l0aCAxIC0gNi4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

