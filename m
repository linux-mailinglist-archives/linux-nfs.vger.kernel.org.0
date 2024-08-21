Return-Path: <linux-nfs+bounces-5550-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839DE95A54E
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 21:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E871C21904
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 19:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8164315C159;
	Wed, 21 Aug 2024 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iH2eIzX3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JZNMazTj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6AEA31
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268810; cv=fail; b=EqIddXEW7hFuy8hpZV1tqra8kA2XIzKNyqZOe9wE3OnYmD+Y3skrlf/SjKTXFWnyjSuKBz97fxxv8EKthasmW5t/PQMxBcjDC/n2ePgNd01BdGvquRZc+niN+O+/M8K/h95IgaUMpIhUZPGIgxtQ8ypV+yQVA0c7C7qd9IwLpno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268810; c=relaxed/simple;
	bh=J37msOf1vSPITgoqquUVAfbBzeQZkuxTm+521XD+CVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dMwIkhSuqRmeHUd3g7MCmxfsECEWg6puaNjXs1STvG0DGQVqqFA4QBT2Rxo70PvpeQrVHaNld53zlgcWBBi2GIdfoJkiMl3QXEDeuwbCoeeIlrnK6X/UF1X1Djcifyh5Oog5pnpTCLMblupsMRLhCKL0pCd2be0xqytDpyjN6pI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iH2eIzX3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JZNMazTj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LDIW06028538;
	Wed, 21 Aug 2024 19:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=J37msOf1vSPITgoqquUVAfbBzeQZkuxTm+521XD+C
	VY=; b=iH2eIzX3EPB/sDIhzXC1Whb6J76i0vOG915496E71nY9c/1lVT2AQ4lQT
	RmZ0MnQlLlTWgKop0vH2AOjI6XpvStwdZ+FJ86VUBg1GDTUya/cjt9dBIt71YEcm
	KDniKssEf9/8uuX/yyuQ3/7sq0qSbfZRyVoeaM6EfSQDGjCupz4rohHAVrmeXmFf
	rkUgR0IwX05DfhE4PJloT525STSxTTeQXATSyfU3eeM6q0stLt+fzncUZTb+9NxM
	Vm4owwk1Bh+9Suc40t8UC+S4w4onlXBP2lEy2QGOXmWPESO8/qJ9LbhpPH+QUI6O
	cavCANZM+EZq5zk4T/vsBGleuXzgA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt0d1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 19:33:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LJO6n8037730;
	Wed, 21 Aug 2024 19:33:16 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415pbxga8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 19:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFrNoV9kTruZ1TJBxoDUE8LKBgfD4+iPfqWdc0iPkkJ0km3UXpXvCEv70kMI1dV5LMH6c4FgThBuZCtm2UdnteCRjaTEWDsf9vSpkdXV7jHPJI5AIHfKeamEdejldY34jLtbINJ3MfvyQ9oYc2yQ9rXwCoHvKNOTbkzZ2B2ogtjoohComMRZm5RTUnTZetSyYwfcEcI2SWo1CWstz3Dk3DsOSQMS5w4kSlsbhCUo1NoKBZHx1HupsBOp/ty0uZwJwK6NTNO4RPKWuF1jx3XehvmP7FK7ui5YlvdOGJ8GEai4+bvusGTCtDlhLHSiJp7imTsgIqnR6/IBCf17KCF9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J37msOf1vSPITgoqquUVAfbBzeQZkuxTm+521XD+CVY=;
 b=a/uNcfhI+q8SOApgwF+3HoYDBZV4gMwKSL1sg2NMf1VjMytD6ghN5PD5j86ElqvLW1AQsGIDKP+Ty4kHAddtcfLBbUtnnBFBEIYTe6y4TRhO9FlOKYsA16ZyJO0KJtPD8t6GGaw3VKf9ha9mXnt22reupU8LkFNvWqOLx3QYKgkbYuebeJ9c7YrZAEoFNCh3mG/1pyMin7sIOb5gIXFrDWJ2mPAf99mWCpCPzwO+U/ahHucfnvbXRHNyN5n9I/B5QY0iIDAKVRbQ/nAwRrQUwLKiwDvoRZDSEPOA3zFYzSdmeWycHuyx/EO0yAVocnwJHwJv8+mHgEKY6zO33xyNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J37msOf1vSPITgoqquUVAfbBzeQZkuxTm+521XD+CVY=;
 b=JZNMazTjHB/928SEee+g13eA3DziFEBTZOKD3YeG8o/QjBSgsfNudynrur/VPepgBH4ptvHjG3XhgwdcjEr+9V1Lsj06/Q739aNc37VmsrnlweK0JmHjfE0PtWIG0pUcvLxqy0pg6iVCSUspFDzb01Bc5VdqmufmchaXqiZnAMc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5055.namprd10.prod.outlook.com (2603:10b6:5:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.12; Wed, 21 Aug
 2024 19:33:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 19:33:13 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Anna Schumaker <anna@kernel.org>
CC: Chuck Lever <cel@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/3] Fixes for NFS/RDMA device removal
Thread-Topic: [PATCH 0/3] Fixes for NFS/RDMA device removal
Thread-Index: AQHa7M8IUqZOQ2LstkCNpe3CCvZsKbIyJ8oAgAAAeIA=
Date: Wed, 21 Aug 2024 19:33:13 +0000
Message-ID: <92BEC3CC-7A5A-42E2-9BDF-ACCB1BF62750@oracle.com>
References: <20240812154759.29870-1-cel@kernel.org>
 <CAFX2JfmyYciHb0O4Bya+RkwZiZ6FjAKxN_fAPV7bB7cui9dFLg@mail.gmail.com>
In-Reply-To:
 <CAFX2JfmyYciHb0O4Bya+RkwZiZ6FjAKxN_fAPV7bB7cui9dFLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|DS7PR10MB5055:EE_
x-ms-office365-filtering-correlation-id: 49b414d7-679a-4731-ef00-08dcc218194d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cXZKZ1FPRUlPYzd4cmFJdGdxQnhuMWJ5bU8rWCs2Q2tlSFFoTHc0QnQyY0c4?=
 =?utf-8?B?NndEQiszcUVMQjlOS2hSV0oxZllQUkU2L0ovUm9kKzFsbVd6elRLTWQ4MVpq?=
 =?utf-8?B?WllYRzhpN0lSUGVPYmthVlA1bEJobHBDYkRVTEdPQ1M2VE9ha3lWMG8vUzNp?=
 =?utf-8?B?dGZ4YzI4eGg4KytTYmZvTE95dDc0bTdHOVpONEVncWM4NmMycmtBRHY5UVdP?=
 =?utf-8?B?dy8yalN0UjJjRjFUSjltbkd1T2FKM0VyUnB6QnB3OFB4Rll2cWsxNWV3d1Rl?=
 =?utf-8?B?OW5RSE8zQWx2VDJzL1RUSVpQTmlRYytTWTQ0NDdHZnQzQ0ZHQkRyTVkzeUFo?=
 =?utf-8?B?SkRyTTVTem9MYlVMS3IxZTZFTWtrY3pXbEJsWDArLzR1dTM4bHRXRUk1cDd3?=
 =?utf-8?B?YWthbXFRelplV3hYbDRES3J1S1NSSllZV1hZdXJwSHl2MHNwSzJRZmx1aXkw?=
 =?utf-8?B?ZzRTNVZEMXlTOEZubVc1K2FkYStnYUpBZE9IN3dHalA2WFJXWFp1U3Q5aGR2?=
 =?utf-8?B?b0N6ZGM5dU1HQ1NjNk1VQlpSRjRvcVpaZ2VLVFUwOVc2eDhrQ01LM1FrMVgv?=
 =?utf-8?B?cStraVcvQi9PaW9KTmJ1ekVYQkRRd2plL05HOEdxNitYbUhUYUFtbWJoSndW?=
 =?utf-8?B?aVdIUGc2M0pUTStURXBZMUd1Y0x5M0Q2MlBNTDZENEhQUVRGN2FuUjdEbXRX?=
 =?utf-8?B?WE5WWWRyVmQ5TnJMVkJheGFvL21IYW4weVI2WnRlYm1PdDM4UWoyY2xqNTZS?=
 =?utf-8?B?aXYvWFpQWC8yRmJ4VkxEQTF3YmpJd0RmMWN4K1lsK1RFWkhQQ09EN0EvVmJX?=
 =?utf-8?B?K3NlNWJNTWM1ZE1JMThieVc4cUFrMFpEcmZuS2pSZFVQUVJETytGMjZEb012?=
 =?utf-8?B?ZWNKZ3lRSTdabXE4cTlzVkUrWkZQR3lNRmNDSE9vSHVqRFFyMmlLNC9EVlhE?=
 =?utf-8?B?MGkvRkZtYnJjcE1pQXB3Q1pKR3UvK01DQUtoZUhtZU9CU1BtVitDZHVZWkFt?=
 =?utf-8?B?Vmx1TURVS01tWmJoQWJTU2pRczZOc2xPMEhkM2wrUnNUbnJjZWpYTUpnNUtW?=
 =?utf-8?B?YnZZTnBxMGZLSUkxeG14ZHJrOVJiWUtPeHBnQ0NzNnZLNEJjRlZkZVlvUXNI?=
 =?utf-8?B?VUhBT3BON0dTeWErVWxoWG9sQ3JjV0FPTnlhakJRckNFZnFsSmF3dGE0ZVpu?=
 =?utf-8?B?MTVkTUZzQjc5NUxCc1dra0ZPNStFYTJnYVF1QnFNMC9sdjNwcVpXbWNpaCtY?=
 =?utf-8?B?dG01S05sOHlYa0lCemZaTzN1TXZGRzlFeU9JWXJYb0xPbEgyeWszTlU3WTNp?=
 =?utf-8?B?T05ZVytlWDdISDZLRFRWaWVodEtPU3RveUVjNDIvcXNSTjZ4T1BKeFhDWXZY?=
 =?utf-8?B?d29aRXpKMUVMcnhBTk8wV3V6cVZVd0pnZkE4VkRNTGNqZ2kwcFZhZ0pXZVNE?=
 =?utf-8?B?V0dwUUloVk1kWnV3RkF5QjVQL0NuV3NoOHl6L1ZjdHpMMzRaV2d0WlBKcEJN?=
 =?utf-8?B?aXdPN1ZJSU9hY3B0ano5OC91cC9acTNCVFhqLzJ6SHR5NHJWcVFLcDl0eTMw?=
 =?utf-8?B?S0tQb2pNc2ZzKzFMbVF6dHgzS1MybmhTT3BYSzRCalZ5Mkd1T24wRHZqdHNz?=
 =?utf-8?B?eFBXc1VFcWN0YWhmekFPMk04Z2dKMzIwTitHVmppNDYrZC9TeFBmUVd2aUtx?=
 =?utf-8?B?TEZBd21wWnhHUnV4VGRGMGI3bUIwRXVsRFpLMkRFRG1sNWNMVUJYRTZkMmEy?=
 =?utf-8?B?MW5IdEtzZ3YyNW1TeEw4Z3NlWVhVN3RSa0k2bjJUSjVYdEVFcDVyRkxhNzFa?=
 =?utf-8?B?TWZ4aU5hcWlodzdTaDd6U1orZVE3bUlGN0ZlNWYvajNGb3ZSemF6TzFNRVZX?=
 =?utf-8?Q?+soeywyfVyTWW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlNWZ0xBNTB2cmZzUmNiQTNHcHdYNlJTWXB5Q3RFVUVsWlVaYktYRENIeHJy?=
 =?utf-8?B?YlNVZGtiNmVxeUo2anhoaVlwY1NjWXd5cVhRZG9QUTFMWUlrOE9qWWo5em5U?=
 =?utf-8?B?SGFTWlMvalhrWFV3Wk83dEoxNU1zZTJvY2JHTjRlWThyZUN1Y0RzNFphS0Fm?=
 =?utf-8?B?QVMyUWRCTEpBTkpHYXNmbGFtYUhpM1Z6dXE1WHFLVldoeEx6ZmVhaVFtUmlR?=
 =?utf-8?B?MUhTTTZNTlRoQWJCWGFTS3Z2UE9DcVR1anZROGFIYUdSa3Iya2YzckJmcmxY?=
 =?utf-8?B?azUyclV4VDJDanRUM01tSHllYlNWNVpQV2NIZ0ZGL0tzRWkrampFRGdGUDBv?=
 =?utf-8?B?ck1sL2MxYXR5bHdBQnB4SUhsdkZ6Mk1tbVJ2VlZ2c3dwV3ArNlNCTHkydkZk?=
 =?utf-8?B?cExwZ3JzVUYvSlB3eC95eXM3am9uNHl0YithcW5XZVRvcXdQMWd0Wk81QXdM?=
 =?utf-8?B?VGduSnp0WE1wanJJVUtTUjZpTGh4WlVNTG5pRlI4U1B1NUZOYU5Hcm82WkhK?=
 =?utf-8?B?UzVKRFY5MFV1MVgyQVRkNGo1SlVuSzJBeTFKOWdUNTFsdDdkMHhjWmdId0kx?=
 =?utf-8?B?S2NsektNc2pmZDBxUm91SzNDUVlldWRPcjlLMENRbVlWTEtTUUNtdFM1OHpG?=
 =?utf-8?B?VzJNb2xnNGpXYkZ0NWdXeGpaakxaU0ZvcGhNUGQrWmZLK3RkNmZ4S3BPc3Y5?=
 =?utf-8?B?cU05eUZDeEFJSTVsVFM1OHk4dW9LazdZZXhXU2FXcGlBZGFvM2ZkclZCUnlO?=
 =?utf-8?B?TEhZYURXcjFGcUo5cmVtU3pRRDlqTFc2RUgzWmRTaHk0WGpDZHViaHkydlYx?=
 =?utf-8?B?UmJ3Z3ZoS256aW5abHc3VmthYnBrMEtwY1c1SVROK0EzbnFkR2RrZ1R2UlNh?=
 =?utf-8?B?NklWZGVrYUJDTU9RbmY3Wnp3R09OTVJUc1ZMNDJNTE1TcHVsdWN4QjhMekhW?=
 =?utf-8?B?NFpVUkNkcU0zbEU2bU9FZmMwRHJ3NGlPeGt4Y1ZYTWI0NkJSdkVjanFHbC9L?=
 =?utf-8?B?T0VQOVA0OE96NVVxNk1WQmduaENkSFdrMjhCZzVCb3JEUWVBRkE3WUdERkRo?=
 =?utf-8?B?QWhEWUhWTTN3azJjUjVzZmluaTZkTldQTGFXenMwNjZLc3RWdEhXTHZicFNn?=
 =?utf-8?B?TGVNSzR4L2g3bWhYcWIzTllTY0RWOERDdWQ4ZCt6dkFOS2VoNWQ2MXI1a01i?=
 =?utf-8?B?c3FYeEhlckRlNk5hRFBISjdTdmIvWnpYNTArajIvRDhJd2xIZ1pLTkQ3YUFV?=
 =?utf-8?B?dE1QaFVVUUY2SGIvaVBwUmFMbldBdlVLTktyTkJGUTJXc1FrL3lsekFvLzI3?=
 =?utf-8?B?NTBDS25sMDJrL0crQ3U1YmVDbG1uQ20xNE9GSEVWRWJnRFZSbHZMRjFvTitq?=
 =?utf-8?B?T25aN2NNVzR4cytXVXRQOWZvSGVTOWpXMGFaMUU1NWxJYlB1VHhtbHV2U2Fs?=
 =?utf-8?B?N0htUitKZTJhcTdKRkZ2Z1JYb2hXRkk4b290S1RMYll4NU1XN3hNTFB1a1J0?=
 =?utf-8?B?OXl4NWxVTEpLSVR6VXJ6cmZka29TYnNPK0p3K05PbnlkUEZOdDBEc3NWQXcw?=
 =?utf-8?B?dXRXWFNnNmlyUlB6dEFHd1h6WG9LenRjb1dnb01wVE03R3RYV0xqMFk4Y016?=
 =?utf-8?B?T052YVF1UU1ReGlsR2Npdm0yaUVoWCtKdmRJaE44TnVvSmtEVDJiU0FFZExl?=
 =?utf-8?B?aGhwamltWkR3TERjVHlTVW9Cb25NUzR6UmQ5NWkrNXRYNXM0cW5xbm5QZEl0?=
 =?utf-8?B?a1Z1SDZlVFhBSUtUVWJEbEw0dm1XelM1M2w3d3had09Ra29rUDFrUTIrcE9V?=
 =?utf-8?B?MWlmVXZCcXhEeHVNRVBlN2swNGtNZXdXeWh4a1lGU2ZRNlF3dHZQdE82a2dM?=
 =?utf-8?B?QU5LOGM2UDBhYUo0SEZyTWx1QjlGa1hUM0p6aEdQREtCVVhqM213d0pWVUJs?=
 =?utf-8?B?UDBxNFV1QjlxdkpCZHNhcUNKMndhM0VoN0pudHNXUGJTcTBaeGlLUVFsT21r?=
 =?utf-8?B?cXMzMTJORERCQW5Pb3J5cEJHVHcvbktvRjVhTUZGWTYxZ1Rkc1dFRys5ekpI?=
 =?utf-8?B?L1NMVllmK2g5YVkzZlV4R2kvRlY2WTU2dEYvOEp3U2crSmlhL29xaXp3QTNx?=
 =?utf-8?B?TEVEbkcwelZqNGI2VHJVcmFibzgreGtNbUpXK2xmNXlHYiswWFJMVVQ4RkxK?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <208EB5907EC35A4E829A0D094B74ECB1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sGLhH9V4pd+qKqnyTb7YSLZPFvDcnCpURdyM8VC+/3CM01JXtpe5Jwv3rYWq/zAXztcbe6R2LsdzRSIUNo3kpE7FNIEyOWwtHXBoiplGyxKyAprpS9PTQHQ+ycxuqFoGZ/h0VqkICypBq3zrMvI7z6LUSSL7e4rKj73Oxu3ym3q5uMVpoQuLcyohvhWmPTBkkzHzWo46hdpeLFY+rkn3RzkXMxg0vyL7aXCdaOelWVz7qLbce+K31hCsMhIpHGBRfb6lkQiKxySX1gbLAvE2+MSGS7FzSNpJeItACF8XP/YWB4L/aWGIbH4WURQOGr5H5w8VNkRjOKTsIUKY+G1etL5DsFDdeZlJNk1RPVMskPdigw+2xBVcYoAM1H3g5MFxvM0ljlvKET2QaSUVBEbjzZOoLJBZ7l6/eO7E2ABqnV5S/yzNHT56AKlw2LtVTAsdGjRu2ZCbkvj03bTNPq9M+iY47wj7UJJG/PjbpZ6STPcMKxhTtVV3jupJGEajBya+o+qJetuJGD6y83JAYmdHZ9uCF6HRkpEOcXOl5nQ9oryFi1YsHcc2uek5kEbYNKcmEg5nMJfbxzQ9BGaAFS0wn+SX6uZ/RebxatVa+J4UCKU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b414d7-679a-4731-ef00-08dcc218194d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 19:33:13.8753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lt2GkkE5ghF3TAxeW4gW5pkjSWmtvhXl2BHKgtrXIfc53oa+AKnn2g9KVCb/b++XakoyayZDPDo3G2JpwnLTIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_13,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210143
X-Proofpoint-ORIG-GUID: 2OstU8UJM14KT4iPH4mAWWm-8UpBZ2is
X-Proofpoint-GUID: 2OstU8UJM14KT4iPH4mAWWm-8UpBZ2is

DQoNCj4gT24gQXVnIDIxLCAyMDI0LCBhdCAzOjMx4oCvUE0sIEFubmEgU2NodW1ha2VyIDxhbm5h
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gSGkgQ2h1Y2ssDQo+IA0KPiBPbiBNb24sIEF1ZyAx
MiwgMjAyNCBhdCAxMTo0OOKAr0FNIDxjZWxAa2VybmVsLm9yZz4gd3JvdGU6DQo+PiANCj4+IEZy
b206IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4gDQo+PiBGaXggYSBo
YW5kZnVsIG9mIG5pdHMgZm9yIHRoZSBORlMvUkRNQSBkZXZpY2UgcmVtb3ZhbCBjb2RlIHRoYXQN
Cj4+IHdlbnQgaW50byB2Ni4xMS1yYy4NCj4gDQo+IEFyZSB5b3UgaW50ZW5kaW5nIHRoZXNlIGZv
ciA2LjExLXJjIG9yIDYuMTI/DQoNCklJUkMgdGhlIHBhdGNoZXMgdGhleSBmaXggd2VudCBpbnRv
IDYuMTEtcmMxLCBzbyBJJ2QgbGlrZSB0bw0Kc2VlIHRoZXNlIGdvIGludG8gYSA2LjExLXJjIHJl
bGVhc2UuDQoNCg0KPiBBbm5hDQo+IA0KPj4gDQo+PiBDaHVjayBMZXZlciAoMyk6DQo+PiAgcnBj
cmRtYTogRGV2aWNlIGtyZWYgaXMgb3Zlci1pbmNyZW1lbnRlZCBvbiBlcnJvciBmcm9tIHhhX2Fs
bG9jDQo+PiAgcnBjcmRtYTogVXNlIFhBX0ZMQUdTX0FMTE9DIGluc3RlYWQgb2YgWEFfRkxBR1Nf
QUxMT0MxDQo+PiAgcnBjcmRtYTogVHJhY2UgY29ubmVjdGlvbiByZWdpc3RyYXRpb24gYW5kIHVu
cmVnaXN0cmF0aW9uDQo+PiANCj4+IGluY2x1ZGUvdHJhY2UvZXZlbnRzL3JwY3JkbWEuaCAgfCAz
NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+IG5ldC9zdW5ycGMveHBydHJk
bWEvaWJfY2xpZW50LmMgfCAgNiArKysrLS0NCj4+IDIgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+IA0KPj4gLS0NCj4+IDIuNDUuMQ0KPj4gDQoNCi0t
DQpDaHVjayBMZXZlcg0KDQoNCg==

