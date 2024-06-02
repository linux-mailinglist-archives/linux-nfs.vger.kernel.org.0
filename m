Return-Path: <linux-nfs+bounces-3520-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA568D76D5
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jun 2024 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF3141C216DA
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Jun 2024 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0667547F4A;
	Sun,  2 Jun 2024 15:40:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900517736;
	Sun,  2 Jun 2024 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342853; cv=fail; b=Ng36MY3NhLV5ZLKtqoCAh7NbsZckavEgEQ6ctSXXomhxHJP3Rz28RC2sckE1v1shVy0KJdyNlrODRSI4Iyg8LC7AhbTHzoS+q3K9vQZDM5JC+cZ42gA1yVTkUeNgr4NRQ3ZLvxQ5/6ECSaIcXMu+d/6Tt8QDe2prQ40qrarNj4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342853; c=relaxed/simple;
	bh=R9Ww7WdPOCSdFtddKKMHZ8mjuxIxBPJbVFQK8N40fiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SqpohgqIGhHeBfXZ1Eh59H9RCP6mfHsAAcbJiT3rHQp9+XOd2viIHMEN3ZiVOwvtvBcSFr1FP5ynbh+0S80IZBtFuqNH/yfBFrvYnA/j3ZbdsMsMlEgQ99+qdN2W4smeVubGHBoavv25VfgnbZHlYhL4aUYB2N4+k5nyyTPnt68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4526gCdq024867;
	Sun, 2 Jun 2024 15:40:49 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-id:content-transfer-encoding:content-type:date:fr?=
 =?UTF-8?Q?om:in-reply-to:message-id:mime-version:references:subject:to;_s?=
 =?UTF-8?Q?=3Dcorp-2023-11-20;_bh=3DR9Ww7WdPOCSdFtddKKMHZ8mjuxIxBPJbVFQK8N?=
 =?UTF-8?Q?40fiw=3D;_b=3DRUp2Ao88vGjFfXKAWj5OVQ5AA5EE6AMPDbTv7NWr7HdCIMeak?=
 =?UTF-8?Q?vylLMeAvLEZb2N7sN0f_9MqHb+8BgDW5X6TI+Jqk065ap6AMVJe/3Usgc0hxWg4?=
 =?UTF-8?Q?bfnfI6k0IQOO4XgP9o7kuFMim_UpOjbogCtX0KhHb683dHgnJ7DlRcMo0X7pMU2?=
 =?UTF-8?Q?UcEEh5m4Lj2/cANRrD+eK6woru+PNEu_mxe9++zxQPrq2MKw84jrRLXUtaNckiO?=
 =?UTF-8?Q?No9aVZ4MbHTqK4wvDJKR9iQDZQ5xsE1FCb4n9_y47HcQUpddIUFBd5DdkTTrkGo?=
 =?UTF-8?Q?FpEKyE/SMzQh3MkXawupesmbvDdsTO5zMQ4s2wTpzyY_Pw=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07senh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 15:40:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 452CV25j021715;
	Sun, 2 Jun 2024 15:40:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt6aenw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 15:40:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN2J7LQt739pcIFX62u3tC7kl82YLZt3wy8xv+I45lcipR9+ZbTBQcN5468wNWerK5C8xASZQXYZ9l2WWMHnaQtw2IFz0+hdP2XO9zWA3QgXNuXD3GFLRwtHbMvYE1F3N5YsNbI5g0+hse+KSaMrBGmtNiwRUoJynifi/VR2l9puFz2GPdB2wUnpVuHmdfm5xl2rub9cDgwvjRFIIaam/amq/WOVdNcgwmrB+fDNlMtbPDV1wVsb+opF9fMSBFtLxjOQBgEOWhtueotB7d3gXaS2Jt1ZAh3tOJngyTsiAmJPnr8tNTWvILqP4a54IZpd6mc2mu2YGjsDCGanuul/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9Ww7WdPOCSdFtddKKMHZ8mjuxIxBPJbVFQK8N40fiw=;
 b=jz4yVrIZXJDNpo3F0AkmQhvbOzu3ugr+m0l95tWrj3ojgK3sQYu5Erz8MWAnycHhWw1g5QCwLKXRo1HjD0RbtKLxikkPnSZjRPC/eu6Do3URbMYoFKzixxUnq1lhzIRRWpk+30YqscLwlwmHVaECq43l4H3ztdmClU9guGKcuOIkW4kvdThp7oILiXD2vLAidj5MPGO2m4uKyPcaWlwcZ12NMYR1HgzxuXTG3fhWH3BqI9gcowt17NOhZI/M32aR1BiUROm4aNLK25QMlhWIAiQUYgay5bQGOI5RzxNZOT4J+HG2THWMF+VzAfMJdIW/qMVcTIt231TaGM7CayqwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9Ww7WdPOCSdFtddKKMHZ8mjuxIxBPJbVFQK8N40fiw=;
 b=Md0TwspzqJmeMNANd4nawZtnXbzSK/tup3mQAuuvSYCQrG0Sia+ml+ogvXQsdW6tGPS8jP9EucZiRfsQeYSzi5EbuwL9g26+gOsP2ZNce6MdOssvS2tOfJroU6iaf+cWo7hti/v/3GwYv00IY1LRS843VV292/VHb/BXvGabjPk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5719.namprd10.prod.outlook.com (2603:10b6:a03:3ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Sun, 2 Jun
 2024 15:40:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Sun, 2 Jun 2024
 15:40:44 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Zhu Yanjun <zyjzyj2000@gmail.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kdevops@lists.linux.dev" <kdevops@lists.linux.dev>
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Topic: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Index: 
 AQHamkmDfBfBFsNf5kaeN/1BZO1Wh7GAavwAgABo5ICAAAR7gIAABDQAgAAI6gCAM+xcgA==
Date: Sun, 2 Jun 2024 15:40:44 +0000
Message-ID: <F2726F77-06F9-4DB4-B2A8-97F21B045A6F@oracle.com>
References: <20240429152537.212958-6-cel@kernel.org>
 <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
 <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com>
 <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
 <675A3584-6086-45D4-9B31-F7F572394144@oracle.com>
 <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
In-Reply-To: <6d483d75-5866-4c4e-8d86-c89a2b27f5e7@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5719:EE_
x-ms-office365-filtering-correlation-id: 5f0e074c-9670-4fda-e881-08dc831a5db0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dXdQV2R5RHhFTzAyRStCQ2hqK0ZOMDBvOWhXR2t6bERyVkZGbUJFdVpBVkdl?=
 =?utf-8?B?RnRXR296QnE0ZEtxNEswOHNyTlpFdUdKUlRVVzVYZlk1Z3FUZDhzWWE5OS9Y?=
 =?utf-8?B?NmUzKzh0MVFTL2lUdUY3N1czaHEwb0VWclVTV2tEUmRpRlBsa3ZyRXJsNTBH?=
 =?utf-8?B?K3NMenQwMG1uNFdIYm5vQjZCbnB3S3MzZUFpYWJTeWJtMHpNRGRPa0dmMVJN?=
 =?utf-8?B?cGxYK0VXRi8wUm5CRWdJcHg5VzhZV2EvRU9pK2RYLzhWS1NxK2YxSHVzbTYx?=
 =?utf-8?B?NGZEWDhvL2F2MkVjR1liU0hDVGtOMHpVSlUzaXpvV251WGFNRXBSNjJzazVu?=
 =?utf-8?B?dVl2THlRa2diZkRodndDVDR2UHhMRTFTOVQyODlITUNwYVNMTjM3cmhyZTVt?=
 =?utf-8?B?ZHE1T2liZVl6SENuV0xvMTRDZ0VCVTM4VUtwUG92cFY4dE9TN3NaSC84RnVN?=
 =?utf-8?B?SUxXU3k5SGVScVNTZWdQRlBXOEpPc3B4QzBVMEQ4ZUhIMmZtL1dta1ZsRGNV?=
 =?utf-8?B?OEZGMUQzUjdKancyWE4yK3NpWlNwM1g4MlBpNVZCMXBuSmJkM0Y1dnpnOHB6?=
 =?utf-8?B?MUduZGE1Rkh1eTUvUWdzT1pNVnhtNFBDSVZzQVk0dGdBNi84Y3EvMUJ0S1pi?=
 =?utf-8?B?UnhUM2tSVnNabi9LTm9OSjVpeWkyRk11alZVRDMybW5pVGlTcXZ3TjFBQWlu?=
 =?utf-8?B?TVJBZUZFNk1abWJHZDd4czlVMFcra1pkQlhHUlN4OU92WWRSaFFtb3RaN2Za?=
 =?utf-8?B?cU1DbGxNaVFubWtPSEV1OSs4SEN5NEpjSkp0ZXJKSHZ5VklNbmhWQllrNWI2?=
 =?utf-8?B?VDRhSWdHaE1USEc4bzQvYnpwQ3ZCWEs3Z0IwcE9WVXVBYjYvVjZ1T05rSzho?=
 =?utf-8?B?eUxaRkRlNTEveDFCSXFLWGROMUR0bGF6bHE0QU1lMWRheDF4elVJNDlwNFFq?=
 =?utf-8?B?YVNWdmVwV054d0pTdVZTWkN0cUtXT3YrVk5SMW5mbXlnR05vYWU5eXpCYnhs?=
 =?utf-8?B?c0VZYTFxZ0R3SHIrWk9sVlhrandqejZhNVBCV3h4TmMwc2wydWcwY2pIclZS?=
 =?utf-8?B?MUtaT096UzgyRExreDV3ODV2V1hGdG16bEZwZE9wTDIxZmFiMmR2cjRMakhz?=
 =?utf-8?B?VUtZemFYdmYvOUI1L20ralc3NEdPZmVNaVNOb0FiSVZRbk5WcGx6RHJxOGNp?=
 =?utf-8?B?dDZFTGZiNkNCNyt0ZnBwN0xxR21ZbFRKeHk1aTcwKzN6M2VKNnZFMW9ORmVX?=
 =?utf-8?B?U3E3ZmRoMForc25EVHdmZ2kxTk5Iek9nem9FYkhVekpjdXBkNXhnc1g4RUVJ?=
 =?utf-8?B?RWFZbmtZM3ZzWGJYUHE5eExmdzZYZHF6RHFtY3BXckZZUXlQbTVGaTBzZDJx?=
 =?utf-8?B?Y2ZIL2c3UnNsUkhxeTVuVGhhWXNTVENleFpNdFBUK3FNWnp2QU5QSUFkVFo1?=
 =?utf-8?B?SStCNDZnSGJjM2FOWjlHUmM4Wldxd0pSUUVEL1kvZGNSeDBMak0yczliSjFh?=
 =?utf-8?B?NnU4WjJmN2VKWDFtaU1yMHJ5bWVCYXNNbW94QVhHTjhuMTJzMjdDbk5hZGMv?=
 =?utf-8?B?VGtiS2pTOXo0K005bHc2Wm96YWx1ai9rb29pdEYyTnA2NmFEZ3NnMUdNN3ln?=
 =?utf-8?B?VklvSVY4NzlCQTB1eTdwc2kzSjhYODNXMGwvUy9MK1hmcmx2bWI2MzdwOG9j?=
 =?utf-8?B?Znpjb01aRm8xYmkwRDZ6QkNHY21kY3JiTU9CaENodXhNYlNRTDYvbUJnYmpq?=
 =?utf-8?B?bE5SWWdRbmVOR2IrUzRHMml4andiQ0pGVFh0aTZBN3JlRlJqSWdPczRqeHdk?=
 =?utf-8?B?UFZrNnY0RmVuZnJsWTBRdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TndYWXprcnVTU1NmL3RrZFl2REw4Vnh4S3NlRHA1dFppUGJIanBCRmdLZDZL?=
 =?utf-8?B?ZXVwUHJZZTc1SHhOektKZjl4VGRQaGJEWk5lZFRveDJsRVU4ODJ2TkdEc0hF?=
 =?utf-8?B?NTlNVkR3K3E2bzZKTVI0V2Foa0dmSVJ4cHR6L1cxSGk1bXBENXdtUXZXdVlS?=
 =?utf-8?B?K2drUWJKQWdTd1g2WkdhaVRoSXVkR1pwTVNwZDlpQXRKUEtaOTVKazlYTzJz?=
 =?utf-8?B?T25NTVNPY2R6Y1M3WTFlak9qem9hYU9TelRVWWpyS0tOejByY0h3TE1yd1Er?=
 =?utf-8?B?QWVTTk1FUDdsY0NEczNMNlVVMkpZUnBMRTFQTi8yRHlaOS9EMEc2WlE0VDVD?=
 =?utf-8?B?NElWUHhZYzVYSmNJdFRuMVdLenJjc1FNZ3hIdVR3NjYwQnpyRUx1RWR3UWxm?=
 =?utf-8?B?TVN4SFJEajlvVHIxWlcvVUV3c1BPb25VNjZWMEJYRmNoUENZVWJMbU1oNy9l?=
 =?utf-8?B?QTdxczljcDQwM09FT3Q2c2w0ek1COEZacjRsdndqREJyNUoxdEcyYWlzanVL?=
 =?utf-8?B?L0lzdW9wc3B0SGtjbG5sUzFhcXdWMzBabFBXV3VFVkxuem1vcjhhU0FkalBa?=
 =?utf-8?B?dndVc3FER0NUUS90b2lsZnpNWFc5VGk4M0FyM1F3cHd2RTBEbE40Q2xlQ2t3?=
 =?utf-8?B?VCtwTDAwZUpOczgzcHRnRDk3akMyT2VURTV5MzM3eVRjZ2tXUlR2WHk5ZEtR?=
 =?utf-8?B?ak9IR0VTR1Fpb1VrMWlVQVcrRUFlWlNvQVNXREhFbzVwcjB6S3IxbXh0K1VQ?=
 =?utf-8?B?OS90RUU5dStjbWN1aUdVZW13UUZCZlNWQWVuT213VUEvTWgxWk9BVGRPOE1r?=
 =?utf-8?B?VTBIZ3lFbHB4NFV6TXAzVGpmVllmU0F4SnJXNjBqR3V4Q0c4eUx1MjZ1a2JQ?=
 =?utf-8?B?YTRPOFEwR0hkK1lGK2x6dmNHZXc0MWo4ZlZRL3JzelRLUFNLR0xZbUNwclF6?=
 =?utf-8?B?TmVxZ1VCOHBSUWNyRVEyZnpUQU9rd0FLUUdtYUg1YnF1WDdNbENwTEhSa3FH?=
 =?utf-8?B?cXl2ODh3LzlZVSs3dEE1ME9BNm04Zmc5YWgvYnVlNHVpMnQyWlZZUXg1V2g5?=
 =?utf-8?B?OGx2VFltczI1QVJHRFZ2RTI3bkl3ZlV2WGhRWXBpbTZEQjFpK3RkNXRDTm5W?=
 =?utf-8?B?T1Z3RlBCbEtXT0wzS2FDd0hoNlRDQjBZVnkzVjVZUnc1cHM3Njg3RFpaYmpW?=
 =?utf-8?B?RzdXbW9BV2hueGpWZXNzaTFjK3dvNU5LWEFPanF1SzZLWmpuQWlBM2NQUFlU?=
 =?utf-8?B?ejJZSE1LNTl3OEpteXdNVlFOeDZIZWRRZGNsb3RXQXNXbUVEN1pHT1ZhY2dp?=
 =?utf-8?B?V2IvTG9NYTZNbWYwVGIvOWVNSnJvM3lJa05BWnZsK1d6MVZsbWwzMU9JL1Zr?=
 =?utf-8?B?NzFmbDV2TDFyNXpqOWFoTTJSK0N6cURGVkErWmhRUG0wd0h5dVRsTUpMZ3Fz?=
 =?utf-8?B?M0pObkQ4ZFkwcmVKUFdQRW1mRUJPVThnNC9aUjRaa2gzSDRFQ1IzTnVnelp1?=
 =?utf-8?B?Q1Q3SnhKRVpOaldHT0UxYjZoVC9zcThXVFhOdTVWc0RnSERpNDRVVjZvek1K?=
 =?utf-8?B?YTgzK0JDSyttbDA2VHgwMHhsbm1uTVZSNDJlazBsYUw4a3I0T3JUUnVHRnI1?=
 =?utf-8?B?Ti9sTEFkS0RSSFdTcVNkdUpScmNPTG1sY0VTYzZWNkNzUnFxc3hESmtqWjFn?=
 =?utf-8?B?TUpUTm02OHVDUzdjTkdpeG1zMG14Z1l1UW5EWStITXZNSGJrR0FUREVOVDU0?=
 =?utf-8?B?MU1oenFVanFBbmdmdHF4S0w2MkNvMWR6SnUxTG16b1dvRkJlVHZLREs4UGRw?=
 =?utf-8?B?Tlh5RzZTNzAyWDhBVjc0VDZCTk0zV2cvZmNGRWRuVzBlaDdCYUFSejVxcm9k?=
 =?utf-8?B?dlFCY2hwWmRMQlFTUldYTkRaaDdQdGYrOXF2NmRlbEtjME4rRDVmaXQrZXhS?=
 =?utf-8?B?TlJYRXlicEN0Zi9kRU9BRlVodCtIMzZ6clBoVlpDQ2J1WFY0bUZWTSt5SC80?=
 =?utf-8?B?UmpsVmFaM3BqWU9NUHFyUEc3ZjRZUVZSYjFwblpWQ21kNFZqNkJMaVphaUFV?=
 =?utf-8?B?TVh0azZIcnFUUkduRjF2MUk1clE0a0VqSFBsSlA4eXg5R1h6OFUzbnlBZ1Ux?=
 =?utf-8?B?SzBXaytLT044dEIwWURTL2pNOVJCYThsVDMvamlHSUF2R1dhazN1UWg1dVdJ?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D24BE2E79B7CD34F85CB065911648992@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	91HhcJXJAEMXCXvtGjuu9helNXL/u1iHrZdgmi7BNZL0y5HKZUVPbF6U6cgv+STPwlpyGMncv0KHp6olC8sm+n7zV/JkUFzsDzwoQ9Nb/uVkUN9CtJb6/oVfnBbrER7LGx9jvzU7ssz5gOKyE7+ojHLVXkNGDL402LXLlQM9ApmvnIgqLw4fpbE9jtWCLdwv/GZrcLI5Brh+n5me1YczNaLfcAXsyV2XqBueK/s7Jsm7pl84b/7PcnHprzIVvWGHbAxbQ9TG0Vrm+gO9+cjOSphXvH3iQr2+Dfk68pUh4HzL0QLO+VjBSn3gpB78g+thqG5DXN5YoUmaYZhISbZRD3SbLlRMCzRl2UqBfttzDxsUSvdr1+PpqS6gdBbu3inf0pcg2x4g23ckH32DNjoCLEQ1aFAX6Ldy5dpGJYkTB5Dlt7ps6d15CmEOfWZCJieAeAnOF3PRQ6mRI8fYYzV0JUEm53nJIjWO1IlR2kBsr1XjcKLl6Z0n0kvt1GajQXI/32tU1bAof8arEjLQsbOkD9Bf0srM/B/Gv0CNzJqOqjr7QqOYDO/zUtwtYvViyOhGEJxosEkw1YN7zf8O3YBaOAQ+jGtJGRt4bsbyL5B2/uQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0e074c-9670-4fda-e881-08dc831a5db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2024 15:40:44.3851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIuXggML+mbQDfUk7z1CZ11/SyXUmvAeZTAKu+fOSxpjAUV+c6BdIai52/62iBrgP53kvrT2ewDQ1okgiyumwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5719
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_10,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406020135
X-Proofpoint-GUID: 0C90YiwppOlzvFuEnPsMb4kQ1GYa8nIh
X-Proofpoint-ORIG-GUID: 0C90YiwppOlzvFuEnPsMb4kQ1GYa8nIh

DQo+IE9uIEFwciAzMCwgMjAyNCwgYXQgMTA6NDXigK9BTSwgWmh1IFlhbmp1biA8enlqenlqMjAw
MEBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gMzAuMDQuMjQgMTY6MTMsIENodWNrIExldmVy
IElJSSB3cm90ZToNCj4+IEl0IGlzIHBvc3NpYmxlIHRvIGFkZCByeGUgYXMgYSBzZWNvbmQgb3B0
aW9uIGluIGtkZXZvcHMsDQo+PiBidXQgc2l3IGhhcyB3b3JrZWQgZm9yIG91ciBwdXJwb3NlcyBz
byBmYXIsIGFuZCB0aGUgTkZTDQo+PiB0ZXN0IG1hdHJpeCBpcyBhbHJlYWR5IGVub3Jtb3VzLg0K
PiANCj4gVGhhbmtzLiBJZiByeGUgY2FuIGJlIGFzIGEgc2Vjb25kIG9wdGlvbiBpbiBrZGV2b3Bz
LCBJIHdpbGwgbWFrZSB0ZXN0cyB3aXRoIGtkZXZvcHMgdG8gY2hlY2sgcnhlIHdvcmsgd2VsbCBv
ciBub3QgaW4gdGhlIGZ1dHVyZSBrZXJuZWwgdmVyc2lvbi4NCg0KQXMgcGVyIG91ciByZWNlbnQg
ZGlzY3Vzc2lvbiwgSSBoYXZlIGFkZGVkIHJ4ZSBhcyBhIHNlY29uZA0Kc29mdHdhcmUgUkRNQSBv
cHRpb24gaW4ga2Rldm9wcy4gUHJvb2Ygb2YgY29uY2VwdDoNCg0KICBodHRwczovL2dpdGh1Yi5j
b20vY2h1Y2tsZXZlci9rZGV2b3BzL3RyZWUvYWRkLXJ4ZS1zdXBwb3J0DQoNCkJ1dCBiYXNpYyBy
cGluZyB0ZXN0aW5nIGlzIG5vdCB3b3JraW5nICh3aXRoIDYuMTAtcmMxIGtlcm5lbHMpDQppbiB0
aGlzIHNldC11cC4gSXQncyBtaXNzaW5nIHNvbWV0aGluZy4uLg0KDQotLQ0KQ2h1Y2sgTGV2ZXIN
Cg0KDQo=

