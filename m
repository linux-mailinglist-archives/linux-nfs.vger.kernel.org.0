Return-Path: <linux-nfs+bounces-7916-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6619C65B9
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 01:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D194B1F24E0B
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 00:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CE91388;
	Wed, 13 Nov 2024 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DDwScfPV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NHf06/dI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5038A10F1
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456463; cv=fail; b=hK4N0GTIUkgKuybeVFHPY615QSrmGdx2TTJDraasUqg828dCwtfxArec09k2kFiR3QSPuYwI5r9iDYNQ4oj9RwXLE115AGL2BKWWfBToUsdFEWMA7o4mRxBeg8IRAaSeSAKYqFb+8SYH1LA/IJuaMzt4HcSaLNZNPyU2PNTm6hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456463; c=relaxed/simple;
	bh=N+wIB+6AszW04nB0H3AWhgYi/5AGemBb20zLfOWPVyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HNwhdRyVJKD5PqBX6Yt6RWZ4YYXYix45OnVuvEfC19AqmCBzxVVHuqiQXoqI0GBN4E/gRNKhkbHKKGWQUF3p/ToWK17Xy6QWbXRMpLuy80JDbzIoRFdY+oNI6jag5FZVPi+/VlP4bVkV4IiXe/M8Vfm3xl7lZZ2OF+wcQaaYzoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DDwScfPV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NHf06/dI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN1THJ030920;
	Wed, 13 Nov 2024 00:07:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=N+wIB+6AszW04nB0H3AWhgYi/5AGemBb20zLfOWPVyA=; b=
	DDwScfPVsWdaq2gbyyLA4pvrQ2BW4KwEwjrgeeFZhKgRIzDmjsg4luH07U8070Rm
	GISJH5o9M9VgkDXNp5KQ2HhQPM5irwqcXDfCPAJVez/McfjUakZz/aRrxbfj/yMs
	EML3/7KyWTGGtZopNpBh5H6zjffkpa8q2JZ+Xhvg11proG4KJwLuE6Pcu24EEtEy
	5a/tp7/c+tL1LYEXeDUY/MDqXW63Qs5G9Cs4ICGum1Zei3YEWWNAv6lcE1Qu8fxH
	1wgUgaRunZaBYFFqgYlc7jDI18RxMfeDWeLXWVyi7V157bnSMGBWi6jbK4OZy8I/
	IhtH1X5I9Y5dOXlRAkYwRg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0henn4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 00:07:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN3ZAu000355;
	Wed, 13 Nov 2024 00:07:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp7y701-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 00:07:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wO114+3lBUETtB43s9hd5yVhTIEpIv8nzFHwm65h9nUpg59S3szB6u8a/AbpTvXv/abBLtxi6mK4fQSb5m7ITx98sPmN7IXvglHlRIS/37zrTIDKrH9XibJ+TBUWXEZZbBZOPxF8Sk6khuuObXs2HkCmXgXmoTAQCBiu6BlqTR+RhBI+E59t/96DZM0f8qapatdYvGo+NkigLwJWAJ+vi9Goc8NhZ2/OwKtDxojei747Af2jFCP5ZoyFm9ZMORmxAsf4kYf4gcusYgHl9p5jUCVt8Ca566c1POOkEmyorUCs/zqerdnJ8T/G83+tdpZ50LdXg6WLt1fFd8tENW/vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+wIB+6AszW04nB0H3AWhgYi/5AGemBb20zLfOWPVyA=;
 b=waID9XO7XgWEwfpA8s1VyWOMougKR9rp9TNEnb08raJhr9dijVIdZcMD7nTw5MFfx8Z5ZG0hPx3XVkSJ/+/UK9IRBfVM55dfpFDOKea68igprXFOyw5ILFRFi0i6vRHb5XWvdrWkDEjiYbAQV35q3e136PgR7kxLTBE5gCbjUEoLolChC37KSo00LfSVFu+TRebpBXc7OIZhGKIljQYSAvdJuLnwvgvpPJg0rcpN9NGTjKQjRkG8INvyHV1RnzrAGOiU9/WCiZ7wJw7DLOl1+b06Yty3NxUxii01Y2tEWXkijcpRzrGdbBiPj5yZStArnohcXWngeO0kkqH2iPC3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+wIB+6AszW04nB0H3AWhgYi/5AGemBb20zLfOWPVyA=;
 b=NHf06/dI9a7gkJln3CnkNaOCygEeU4kWdSo938iQOpzpBb3foAmrUb4fINaYPh6GXFX+TwVsd7uwOigla/pKV+GWKIryIUS7q6pflOKFksYAGkXbV4gUFafyOX9MMbYuTsfhAvM0l/0n6Co4arR5/ziRtauPpd+q6rj0YWQq9SI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW4PR10MB5704.namprd10.prod.outlook.com (2603:10b6:303:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 00:07:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 00:07:29 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Neil Brown <neilb@suse.de>
CC: Mike Snitzer <snitzer@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond
 Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
Thread-Topic: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
Thread-Index:
 AQHbMjeVpJdkpikre0CCB4tP6hMv+7KxVRwAgADktYCAAFQgAIAAH4WAgAAPfYCAAA7zAIAACSEAgADm94CAAJCCAIAADxEA
Date: Wed, 13 Nov 2024 00:07:29 +0000
Message-ID: <24F9F9A5-7EB3-430D-BDB2-A9314C581817@oracle.com>
References: <ZzNn2czIB0f66g0Y@tissot.1015granger.net>
 <173145320232.1734440.886416117667950658@noble.neil.brown.name>
In-Reply-To: <173145320232.1734440.886416117667950658@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MW4PR10MB5704:EE_
x-ms-office365-filtering-correlation-id: eac66367-f9af-4afa-57dc-08dd037729b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnFqRkZ3dXdhQWNLb29WUy93eUJuaGhuSEluRkdFN1lWdEFYSkMrWUxXZTc2?=
 =?utf-8?B?T1BPdWx5ZVRob2NpZGZLd0taQTFMR1U1TS84TWVxcVpHVUhmNE5kVUZSNGVR?=
 =?utf-8?B?V1ZBZGQ1amtRS29meGxueVFVbzNnd3hhNGYzSUN3NVFMNjVJMXBEWDZ3VHVK?=
 =?utf-8?B?SEZydG1zTSs4YjNkMEM4UHhpdThPMk1LRVcvWCtNRTlUbHVzZndXb2FscThs?=
 =?utf-8?B?QTd0YXQ4aTdrUGhpbHp2dWlwTEY2VTVFRmtqM2VJMS9Ed2FEcEI1Y0wrWTJt?=
 =?utf-8?B?K1ZuUS9IMDR4Z0NkNlJ2VGtjRlY3NE8xNGtiNWluS3pFaVRzbGdmUFBhMkZq?=
 =?utf-8?B?eDNUV1l4Ty9UbWlpclU4YWVkcnQrQnVKUW9Mc1BKSjhrdE5udTJLWFlXNjJk?=
 =?utf-8?B?L0NjaW1zc3kweWNFSDRqWUJYcjZCMCtYd2lQVlRHek1Va1grdVlEbG9uK24z?=
 =?utf-8?B?TjNudTh4alp3ejZXR210alVDUHZaS2hRMzd3U055NXZ3WGNrS0FyYVdITjJy?=
 =?utf-8?B?UkFWSXdZSzhBZHh0bnVncFV5T1pIb0VVTCtzUkxSbTFOQWdhUnRIcXdWSHVQ?=
 =?utf-8?B?bW0zSXV3QWovU1oxN3lpN2pOVFYrdzZzZXFWRC9YMEFtNWl2WWE1TVB1T0hV?=
 =?utf-8?B?ZW9wUlZFYjNtU1E2Q0puRkR2bkNHK3NSQWN6NTdkcXZuemdDTWRkWnRuM2Ry?=
 =?utf-8?B?L3ZtZ2h3cEhickJPM1hrZ0dvWXpJUHQ5aU92QXM5MHNseWkvUUtzV0phRXVs?=
 =?utf-8?B?Q2RkOXc5VGozbWRZUkRjMmU4NUVFUW1HQU9ldVRPekV4VHJvWDdBNndTZ0Rn?=
 =?utf-8?B?d0FMb3BxQURoZjJhMHk5bjBaL05EbmRzRDU2L2Z0eXJqUDhvWkJvWmY1VUpF?=
 =?utf-8?B?bzhPRzd1cTlCcmtyaTAyQ3IwREJmT1ZWZ2tBYW1uZVNpU3doYVJ5dERUTUNs?=
 =?utf-8?B?aDllcXRMT2ZBbk95K3NPc2JHZWFPa3NyN2NUdTVjRUhoMVdTUWgvSzNnSUZW?=
 =?utf-8?B?MHJMNndJNkRKdkFFRDU3VlBBalg5VGJBMWJjTjdQcHFnRks4dm1GL1BHLzNv?=
 =?utf-8?B?NnNsZlhoeHYyQlBJdno0L3RpYzFFZkpqb25zeW5LWWNMWU5EWHlTUFYzNDc3?=
 =?utf-8?B?cVVheHNvNHNwVG9vSDBYT0UxejVONTBRMnB4ODltNVd2RkdPT2pLYUZTZ0ZH?=
 =?utf-8?B?bHJGVTF4M2I5ZEJhbzRIYmtycGh2eHNUMWtSWSsyQlhxK0Y1TXhvUTV4S2RR?=
 =?utf-8?B?TVFzMjVIUUk4TDVyZmVLYTVxMEt4RVlWbkNNWWhQZWw4TXZ1MG1qVk5zSTI5?=
 =?utf-8?B?VzFCRmZZNjVjVkh3KzJkby91dHNQU2pkaHhjY3ZNUHc0UUFQb2ZYWTlydjFD?=
 =?utf-8?B?QWlWRmFzb0F4dUZKYkZJc2x1UVRmMVpaQkZzL0dCMUNiT0ZuVWliam9UQ0pu?=
 =?utf-8?B?YXY1TDZRcEZmVWJSMXIvMEVsOXVuOFBHMWhlVitFSXdzTVdraFFzOHpTaFZj?=
 =?utf-8?B?RXJPbWVYbmdqS0lURWx0bG5PcXNzQ25aT0tvYmhkSVo2Y2I4bitIREZ3dUYy?=
 =?utf-8?B?bGFSZG9renJ1dGN3RHhoUVZyUTh4OFg5bXA5bkFyenQ0UjhPNEJJajVMajdm?=
 =?utf-8?B?ODhUNWYxMzFBUGpxWjFXbDVUUURkUlg1Znl4c2ZpdUFVWmtUV2U3UGhKR1dv?=
 =?utf-8?B?T09GVFREYndLQzBaSDg4d1VQS3NzMG04RXFUdC9QbW9JblVLM0s4dzEvOEs4?=
 =?utf-8?B?c2dnZUx2YlNRWFF2bEpYVDZtLzcwaGVCdDNwK1lLaXU3eXJVcmIzb3Q5RHBQ?=
 =?utf-8?Q?TW3YyL9YwWe6FPjqh6zxQsbNfg/avg5asaPag=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWpRVnJINlVSUVU0V0pnWnZsZFYwT1YxR3g4NnY4blZTT0hIcHYrNFMrMDlH?=
 =?utf-8?B?NGNZT0ppYlpBMEdCeFl6M245dzlubjBkZ3pXRHVTK0NvN1YwWjNzOW5aeEpI?=
 =?utf-8?B?cG9tZndSejN5aGY3enhMczA2UTVDTHZlL083RTBvUmJUUmh4TXYwMWtaVUFT?=
 =?utf-8?B?MjFGc3BZWXNlODJQdjVuVEhuZytCL1AxWTZkTWpFUlIvYjA4Z2NKSTFZdHhv?=
 =?utf-8?B?RGRQbTY0bmxoeXRaRUQvZ2d1ZllPcEcrVERCUys1cExTTU5rNTdmMzZ0Qldz?=
 =?utf-8?B?cVMzTFBwMVRZbzFVRm1SemV3eEZUWHBvY3Z0QjA0cUlZa3RTN0Z6SGNldmZv?=
 =?utf-8?B?dkI0Qytid1hnRldqbGlka1FZNHFURWFEWm9HQTgxaE00TjYwRktXelI3c0NO?=
 =?utf-8?B?MThVWWp1eXZOUzhpbjkwQTNuRFQ4VytCZGg1aHQzQXcwdVJMRnRkcXl2MEZq?=
 =?utf-8?B?Y2o0RWpaL0EzQzA2RWYvOWlXM2lqdE9RU3JCb3lYQWkrVjV0TU1nQWRBS3k5?=
 =?utf-8?B?bnl5WU5WNEloUTdYZlRMK1dRKyswYkZxSnZHSjdlYzBMMVgveFd6Yy8rSkV0?=
 =?utf-8?B?UjZtR1p6SGJwb0U4RTVraHFkaHlYai9ZZzVYZStrVVJoZUkwa1EzMWV3QXJl?=
 =?utf-8?B?R1IrSmlCRnJJK3Y5VGkxdG1MaEtpT09SSVMwL1liUDR3UU03Z1l3YngwL0hZ?=
 =?utf-8?B?aUxCZUprYnZITnhBRHUwN2JkNFYyWHA5akdpVlhtNGRHRnhXL3psN0ZBaW53?=
 =?utf-8?B?RyswbXZHcStBek1IOGVHbGZkeU1oaUg1NHFGUnlVeWkvT3BMNDBmRFNnZHJT?=
 =?utf-8?B?V1hjRVRSby93V0lvNkxxclhjdGFnTGQzcXg5cVV4MEoweElCVDNHeHdhVlJl?=
 =?utf-8?B?TUgweGl3b01SdVYyK2VveUhmNUZ1TENwRXFSRy8zMzlQVUFHckFhNDJoUmpK?=
 =?utf-8?B?azcyZjhXckpOcEV0SHd5ZFpNQThxQ3UzY2p3UkdEUy8xS1g5cXVaSU9YOGFr?=
 =?utf-8?B?TUVOWXFGM3JjNzJMSllxbTlUaFB2eWpNR3ZsTi9iRXViMndFd2lwWHZ2V0ly?=
 =?utf-8?B?YjdONllEdXQvRXNnZTBxejZRZkFXb2M2NnBhVVhUWnBLTmxDQTk3VXZ5enMz?=
 =?utf-8?B?VGlUa2Fmby8wbTNGUi9DU1p0TXVGc2twTkZKMFF3ZWY5UkJxakpHblVocnFp?=
 =?utf-8?B?Y2sxd0VDbHpyZWN0Z2N2eVdsTCtJQVBWVEVBQ3BBelVTMlV2eEIzMXdxc2pK?=
 =?utf-8?B?NHJ2MlQ5TUg3UGVtTlE0WGV2clA3Rk4yYW9pS2dJMm9MaUlUYUJpQmNtK3lw?=
 =?utf-8?B?STEyeE5Ub2Z3ZTJYdFlIdnJWWEgwZ0NBYUltZGVIOE1BOElhbCtiRGNJdWRN?=
 =?utf-8?B?Q3ltL3R1ZERrQ3ovUGpZUnF4emtFODdzT2FsYUlNeFd0TDgvVityM0hvWkdm?=
 =?utf-8?B?dWJreHJBRGRtTmVvbER0N0xvM3phYkRMNW96Y1pOZXBNeHRkU3RJblB3UnlH?=
 =?utf-8?B?Z2hnZUJGWWwyRnc3UFZwOGtZVVBPcmNEQlF6TlFpbVgxTkxyVWRJa1FoQzcx?=
 =?utf-8?B?enl0Z0hXNTJiQ25YYmNhSjdSb2FSSXpYZDN6RC9laG1DMmVYUXdrOFMwWlp1?=
 =?utf-8?B?N2JUc2p2eER2RUVYZnFnWEt3bTB2a0daTktZanl1b2lNWUpLbGZ4dFJHZm82?=
 =?utf-8?B?YmtLMGY3K3N0UzM2dkNJUmRyaG5yM0xYek8rQmgxU1NRSlVMcnNQQzB1RDdu?=
 =?utf-8?B?NVVWNUd2VU9oZmR5VFJiR2VLbXhiU2Q4UW40U1JyUHZRQU9rVzRLU1h2Qk1U?=
 =?utf-8?B?ZVRGaXdCV0Z5UGFnYVU2M1k1MGRlMTdIaUY0Y3J5YS93SGMrWFV2TmtSWXgv?=
 =?utf-8?B?M1NCV1RKd1pRbmlxZFh5aUJYQVBNZ2l0MXJvakw2UUVmUTdweHNMNDNhK2pM?=
 =?utf-8?B?dC9SbDFGbmhuWldKVDZTSUZwRlBKSkx5THA0Q1UzMEhaclZ0Yy9DMHFoRTF4?=
 =?utf-8?B?ekwzK3RoYzFsWDIycWNGUkkyS2kzQ3ZnODBOaHEwb2hubDNMcSszMWhUY3lI?=
 =?utf-8?B?WXhCc1RhTzYwMU1SSUNwQzZYbWVWb3Z6TFJmdzZJUDdHaFhMNTRLSjladGhC?=
 =?utf-8?B?QmZwd0U4dkVBYk1TbWFWbVA3MGg4QVBJdC9IaFNKZ2czRW5PVXhBSTJRMEpi?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB9AB1233A0F9341834DCBFD5B9BC5A2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rzxAnlStBw5UIGYPBzqe0x7UVn92XK/tvI9DSBbuEHnTWYH+lYodN2wp+Gl6XvvxYNIcHlwIrkwQcEmGfARtVYY/RH6blVRbUSt/3XSj8Iq9cYrsOt3lPALpI2aKVaAoJWd/7+MdYPKFPLvXs3Iq/dLzMdxoHhKZ3V1hTBFliZjTaZHTM640Qy2uLPMbLBD0jtXKml5B0B7znZQT9b4wGQ7pqJEsGi5TWOLur0ANp/fEbv94jzsR8RRWXlp8NJktqvox4OPBlbGM9AZPAwJFYkKaMyEgwzPoNO0AObgRGi4Si5bSFNyNIogHckW2etylYIfgo/cj/CWE+sE+B4JpABJjhAeHL7/MQauXciNkV5ByHv7my27zhrCzhC1jphuOAYfvcfEptnMS2Ghtwv9CDeXDxRze/w21k+nH8Z3WgVknxJsykJBdOQnCaiNBq2cCj/W75IIOT5QzSxJuEbG7Y5tKNCHjhXCc4HbMYWpBD4CNYigvrJJHNI/+msTGUrKjoGO8QfzWPrOtUFkCVGgC3Hp1O12uvkZvogYKot+cbIHUsHBpFwmaxQTH0WPzdjhw3tTV8r39Wg38AbE1NcS/pSeqYeVVo18L5aN+IqyYCXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac66367-f9af-4afa-57dc-08dd037729b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 00:07:29.1694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZp0UJM3QcFbL+96DR3m3cs8jl1wX0GgIz5HHYAi3jRO7uTiZqTswqrB2nWdmUsg8Fas4GqoDkawrgWpPJFl/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411120194
X-Proofpoint-ORIG-GUID: gxLEJPD36zdqP0EoUZ3y5F4ZkkW7qcbX
X-Proofpoint-GUID: gxLEJPD36zdqP0EoUZ3y5F4ZkkW7qcbX

DQoNCj4gT24gTm92IDEyLCAyMDI0LCBhdCA2OjEz4oCvUE0sIE5laWxCcm93biA8bmVpbGJAc3Vz
ZS5kZT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDEzIE5vdiAyMDI0LCBDaHVjayBMZXZlciB3cm90
ZToNCj4+IE9uIFR1ZSwgTm92IDEyLCAyMDI0IGF0IDExOjQ5OjMwQU0gKzExMDAsIE5laWxCcm93
biB3cm90ZToNCj4+Pj4gDQo+Pj4+IElmIHlvdSBoYXZlIGEgc3BlY2lmaWMgaWRlYSBmb3IgdGhl
IG1lY2hhbmlzbSB3ZSBuZWVkIHRvIGNyZWF0ZSB0bw0KPj4+PiBkZXRlY3QgdGhlIHYzIGNsaWVu
dCByZWNvbm5lY3RzIHRvIHRoZSBzZXJ2ZXIgcGxlYXNlIGxldCBtZSBrbm93Lg0KPj4+PiBSZXVz
aW5nIG9yIGF1Z21lbnRpbmcgYW4gZXhpc3RpbmcgdGhpbmcgaXMgZmluZSBieSBtZS4NCj4+PiAN
Cj4+PiBuZnMzX2xvY2FsX3Byb2JlKHN0cnVjdCBuZnNfc2VydmVyICpzZXJ2ZXIpDQo+Pj4gew0K
Pj4+ICBzdHJ1Y3QgbmZzX2NsaWVudCAqY2xwID0gc2VydmVyLT5uZnNfY2xpZW50Ow0KPj4+ICBu
ZnNfdXVpZF90ICpuZnNfdXVpZCA9ICZjbHAtPmNsX3V1aWQ7DQo+Pj4gDQo+Pj4gIGlmIChuZnNf
dXVpZC0+Y29ubmVjdF9jb29raWUgIT0gY2xwLT5jbF9ycGNjbGllbnQtPmNsX3hwcnQtPmNvbm5l
Y3RfY29va2llKQ0KPj4+ICAgICAgIG5mc19sb2NhbF9wcm9iZV9hc3luYygpDQo+Pj4gfQ0KPj4+
IA0KPj4+IHN0YXRpYyB2b2lkIG5mc19sb2NhbF9wcm9iZV9hc3luY193b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCj4+PiB7DQo+Pj4gIHN0cnVjdCBuZnNfY2xpZW50ICpjbHAgPSBjb250
YWluZXJfb2Yod29yaywgc3RydWN0IG5mc19jbGllbnQsDQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBjbF9sb2NhbF9wcm9iZV93b3JrKTsNCj4+PiAgY2xwLT5jbF91dWlkLmNvbm5l
Y3RfY29va2llID0NCj4+PiAgICAgY2xwLT5jbF9ycGNjbGllbnQtPmNsX3hwcnQtPmNvbm5lY3Rf
Y29va2llOw0KPj4+ICBuZnNfbG9jYWxfcHJvYmUoY2xwKTsNCj4+PiB9DQo+Pj4gDQo+Pj4gT3Ig
bWF5YmUgYXNzaWduIGNvbm5lY3RfY29va2llICh3aGljaCB3ZSBoYXZlIHRvIGFkZCB0byB1dWlk
KSBpbnNpZGUNCj4+PiBuZnNfbG9jYWxfcHJvYmUoKS4NCj4+IA0KPj4gVGhlIHByb2JsZW0gd2l0
aCBwZXItY29ubmVjdGlvbiBjaGVja3MgaXMgdGhhdCBhIGNoYW5nZSBpbiBleHBvcnQNCj4+IHNl
Y3VyaXR5IHBvbGljeSBjb3VsZCBkaXNhYmxlIExPQ0FMSU8gcmF0aGVyIHBlcnNpc3RlbnRseS4g
VGhlIG9ubHkNCj4+IHdheSB0byByZWNvdmVyLCBpZiBjaGVja2luZyBpcyBkb25lIG9ubHkgd2hl
biBhIGNvbm5lY3Rpb24gaXMNCj4+IGVzdGFibGlzaGVkLCBpcyB0byByZW1vdW50IG9yIGZvcmNl
IGEgZGlzY29ubmVjdC4NCj4+IA0KPiBXaGF0IGV4cG9ydCBzZWN1cml0eSBwb2xpY3kgc3BlY2lm
aWNhbGx5Pw0KPiBEbyB5b3UgbWVhbiBjaGFuZ2luZyBmcm9tIHNlYz1zeXMgdG8gdG8gc2VjPWty
YjVpIGZvciBleGFtcGxlPw0KDQpBbm90aGVyIGV4YW1wbGUgbWlnaHQgYmUgYWx0ZXJpbmcgdGhl
IElQIGFkZHJlc3MgbGlzdCBvbg0KdGhlIGV4cG9ydC4gU3VwcG9zZSB0aGUgY2xpZW50IGlzIGFj
Y2lkZW50YWxseSBibG9ja2VkDQpieSB0aGlzIHBvbGljeSwgdGhlIGFkbWluaXN0cmF0b3IgcmVh
bGl6ZXMgaXQsIGFuZCBjaGFuZ2VzDQppdCBhZ2FpbiB0byByZXN0b3JlIGFjY2Vzcy4NCg0KVGhl
IGNsaWVudCBkb2VzIG5vdCBkaXNjb25uZWN0IGluIHRoaXMgY2FzZSwgQUZBSUsuDQoNCg0KPiBU
aGlzDQo+IHdvdWxkIChob3BlZnVsbHkpIGRpc2FibGUgbG9jYWxpby4gIFRoZW4gY2hhbmdpbmcg
dGhlIGV4cG9ydCBiYWNrIHRvDQo+IHNlYz1zeXMgd291bGQgbWVhbiB0aGF0IGxvY2FsaW8gd291
bGQgYmUgcG9zc2libGUgYWdhaW4uICBJIHdvbmRlciBob3cNCj4gdGhlIGNsaWVudCBjb3BlcyB3
aXRoIHRoaXMuICBEb2VzIGl0IHdvcmsgb24gYSBsaXZlIG1vdW50IHdpdGhvdXQNCj4gcmVtb3Vu
dD8gIElmIHNvIGl0IHdvdWxkIGNlcnRhaW5seSBtYWtlIHNlbnNlIGZvciB0aGUgY3VycmVudCBz
ZWN1cml0eQ0KPiBzZXR0aW5nIHRvIGJlIGNhY2hlZCBpbiBuZnNfdWlkZCBhbmQgZm9yIGEgcHJv
YmUgdG8gYmUgYXR0ZW1wdGVkDQo+IHdoZW5ldmVyIHRoYXQgY2hhbmdlZCB0byBzZWM9c3lzLg0K
PiANCj4gVGhhbmtzLA0KPiBOZWlsQnJvd24NCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

