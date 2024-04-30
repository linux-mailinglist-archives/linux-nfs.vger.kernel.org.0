Return-Path: <linux-nfs+bounces-3099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD28B7933
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4530D1C20EED
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEE17A922;
	Tue, 30 Apr 2024 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CT4DkLS8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LnPzm7kG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201512AAED;
	Tue, 30 Apr 2024 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486448; cv=fail; b=exH6b+O/67L+PlkTPi0c4SLc8IgdPkNqgJ8oKn+lLogrMn2VuELdGvdj6fuMsMLguT/NqB4QKVAJktVFlEJIng0L50L85pCfaHbsL1WMr5jEqQtDuDUTZOwVXCe5iuojdmPUrWkcSwQ0mN6eAbaRbzeqQVcfgd71pNToxDmymRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486448; c=relaxed/simple;
	bh=qQGXfDZ2joQzyIxrhCRRJUKGFcCb/1kRxT4dJV5cwyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNQIK6/9bdTmKEhhCexo+qehCwVA4OEd7XTsY1T2BborezDWjd3GNBeOKTZK26t0NV9lMnPbtzmBN3oDTuz9LpwRsw+4MjlTtFGaPvHw/j1aLcadqmEuDZYqstBPwINwnRyJ01KcBb8OzKi0B59eO6DLP47bWGi9DlY5+GS4QLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CT4DkLS8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LnPzm7kG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UCjYvF004985;
	Tue, 30 Apr 2024 14:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qQGXfDZ2joQzyIxrhCRRJUKGFcCb/1kRxT4dJV5cwyI=;
 b=CT4DkLS8kWvSvydp3feIeYWYubvYQ8TjIzHjKJ0uvHZJduO4fnAiIClyZAPgnikpqYnq
 MEwRVfJh3Ic9SQNZDdV71P24G/6lMKH3halFM+ALsyM9IucnX6bwT12QZjLaE+UfPydn
 UL5KTEqgHLj6DryycZlcmCRGaNtkH3Uo41DWILg5hVLOLERErELU7Y2sCfBY12LHbeOK
 yhLiIFrzBaCKmqKUm8dh3vxNJnq3peRBTDE3AK7MbPPhSEfSVK53B/BkNfJtCDH4VXEM
 DHtC006/i+WTUpC0VO1rVM3u6yq+KuHycAseKhrtZ157ULOtADXe/8UN2DEByw+CQkiJ VQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrs8cn563-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:13:58 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43UE0Ga0016807;
	Tue, 30 Apr 2024 14:13:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtdyprt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DktDs0xly9Pd/XQWX6e+Bmm7rqJPf13CaSXhJFA3TewMm3/5evnUhIUKU52Ol9jNsnUuZOh4TDL+AYg62WleU4QTkXGvyiZ9oOPmMKFGaeyXOHH5ox7dRGGdyg9mCUrg7LcqgUfirfrvrmxd4ljVq3XfyJSjPVT9izfmwlD8r7bS1rqKvhHxBsxMRtUsi7ej5K/uB3eIyAaPTWu/lTBGXGLOLiksNb3ZiijiByMHEZ6swcgm+vrO9mNfJiYKNS2L4/x0g5whhR936G68Wu78kLvyveNLHVih9Kc1jCS8QjPaDomBQGWFe+8wy+Fovm22kPuGp2D5v4l+Qobv20pxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQGXfDZ2joQzyIxrhCRRJUKGFcCb/1kRxT4dJV5cwyI=;
 b=igrMJfUiK1Evy3CeEESpDlIYzzOVZMdTFkW7vNAFjMgh3r5/OeyowCnphg0+exrCh890mv85Hq9FsTiVuJjBYnyZ1s79/yhKNwbIM70GakRbAf7EV1AwQDMd4Oc/M/ZwzrmyztPVN2YvDRt6rWgaNGnOOgB680Sm6hGsIU+WzoGb07cmQAMrm6dOKc7ZQVeZLOYpV/yG2GmvdKE8XWbhtFWxzA0DzhwjamuW0uKAAUKkkJcj9vIC3gVAL4pKXgjrdwFbahCpVfvh9RXr9ELcT5z34dQsB1k1RhaPMrbDJ4Dqy5gMHSIkreyTQeX3FG2NcyVs2QC4Z930FDsN+yJjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQGXfDZ2joQzyIxrhCRRJUKGFcCb/1kRxT4dJV5cwyI=;
 b=LnPzm7kG3SkkOTbk+oATkqsViHgBdL8O+EzSIWZtenDumGDwcUciekXNGqLjhMXZJhZVI+gxXXbLaOnSKwOo581mz7hKctuFD01O6u7Z407DbEZbqHMh6z27KPS0IReG4+VBd6+0Y9YCzw4F3ZXvewXunpL872XkjeRdj+AQS40=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB6963.namprd10.prod.outlook.com (2603:10b6:a03:4cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Tue, 30 Apr
 2024 14:13:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 14:13:36 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
CC: Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Topic: [RFC PATCH 0/4] NFS: Fix another 'check_flush_dependency' splat
Thread-Index: AQHamkmDfBfBFsNf5kaeN/1BZO1Wh7GAavwAgABo5ICAAAR7gIAABDQA
Date: Tue, 30 Apr 2024 14:13:36 +0000
Message-ID: <675A3584-6086-45D4-9B31-F7F572394144@oracle.com>
References: <20240429152537.212958-6-cel@kernel.org>
 <efc4f895-3a45-4b44-a47d-532896526458@linux.dev>
 <90F6A893-5315-4E53-B54E-1CF8D7D4AC4D@oracle.com>
 <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
In-Reply-To: <f49907ea-cedc-44b7-9ffc-30c265731f3e@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.500.171.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB6963:EE_
x-ms-office365-filtering-correlation-id: 3645b313-2de4-47f5-8cfb-08dc691fba18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?TW8xcERpVlA5RzVpODhidzFIRjhXRXRmOVBuWDdmd3BhTDFpY2Mxd052UGcy?=
 =?utf-8?B?aEE1K0NwQ0NVV0svVnN2eWlZWmJ6WlRFUW1DWVlQTkxaUncvY2Vlc3N5SEVJ?=
 =?utf-8?B?MjdlaEk2em4xL0ZGUFlJVjd2Q3N3OVhnYlBiRzVvTnFPUFl1RzZIUzdoNHVZ?=
 =?utf-8?B?Um5hK2xrZmcxVitwSDRNZkVsQzg4Q29CQWc2emswK0RoY292Rm44a2ZZNkg5?=
 =?utf-8?B?UHIyQlhYN0RocC9uU2x2UnRzUk9ZejFwUzdIR1BhRnZTa01weXR5cE9TTCs5?=
 =?utf-8?B?VFo3QmtmNElOdEErUG9BNkdBOVdMdWVacnBkZzBuMk5Mc2phYy83LzRFWjRY?=
 =?utf-8?B?YXMrUUNLbUkvN1g1MTRQOUJDcWcwc0NTelA1ZzRPZVN5TUdUR1pJelZuR205?=
 =?utf-8?B?cnF0b3JmVFlvNkx1dFJTRjFiTzB2VEZJTm5tNEtQVFVCT0l2dDdKSEUvY0VO?=
 =?utf-8?B?RU9Oa3pMS3lXSi9PSThOUWZZR01RUFRFdm5sRXdXRGJ5R2J0Z1QvN3dlVW52?=
 =?utf-8?B?OHB6NEVNc0RrU3pjVWhxWHZJTDcva0dRQUYyWDVod2pxWmd6RWFPaDhGcTNv?=
 =?utf-8?B?elJoWElnemlWN0YzRnVlWnFvc0pvT2Z3T0RLYkhmVzZVUjlVWmNSZXpncXBa?=
 =?utf-8?B?QXUreFI1ZDZ4K1hUYlNmUGFUYzVoY2FwSEExTGI5bnJFcVI2OU8zYXk0NE9w?=
 =?utf-8?B?UUhhNkM2aWQvemZaOHdiVkFGeVVDMkZrdGJieGJxMVYyQkJkZzdDYklLQnJ5?=
 =?utf-8?B?VVlQSUJtT0xiRnFLNlBoY3lYL0FMdmV1dlJNTkRCQzczOStMdW1oekxkRHZ4?=
 =?utf-8?B?c2dRU3dQZXR4SHltejBjNkR1VUc3R3lxaG9pbi9BcklNQ0NYdWNEUHFoblB2?=
 =?utf-8?B?NVdDajliMzZaRVp3c3ZYbFd6T2V4aWFrbnJ2L21Ba044blhFWTlzYWJmeXNm?=
 =?utf-8?B?T0Iyb2M1TFRTWGxjR3RGR0s3REFSdUZXNU1acnFMZGFyRjUrL3VzdHlaOFY3?=
 =?utf-8?B?MWFHSVdFNWZMYWtoNUF5ZXlXcGJXWENEUEs4QXRHeXlLSDFLT2M3dGJkSmxk?=
 =?utf-8?B?L3FCTER1OW5DS003dXVXVWREZDNuVUZNTDQ5Q3NtbStKQk51eFpHbGk1bG9k?=
 =?utf-8?B?L0xsdkpzRjdRT1RuRUpjV1pSYmhXeHJjU1UvVW0vNmtKZm9DTmNWWkp2SHVP?=
 =?utf-8?B?UUZaTUhZc25qcllYaU5vWEc5Zm5zenE4cFN4UnhETGEzQXlYdW5NeFpOa25M?=
 =?utf-8?B?emd2anhrRGZmTWd5ckY4WGVQeUFpTkJqNUs4bFM5K2tWcFRSK1plRE9RMjdi?=
 =?utf-8?B?VXRrODNOZ2RiV3dBd3NoMnl2YWdXd1B3dGxqeFFnNytCK3p0V2dKK1J1QUsy?=
 =?utf-8?B?ZW1HTEZKek9DZlQ4ZDEzSG5mVGpLKzNvSHVRdDhWWGVrVzVIeDF3YWE3dWNk?=
 =?utf-8?B?eDIxVUJlYlczLytXa041T0hYb1FEa1RjdGpDd0VDSXV0NG9EQjJkbHNtblYx?=
 =?utf-8?B?ZHZ3LzBXTWVuWk5hR2VPVFFGMzRqbWxTSkJ1cSszTmV2Znl2aFk1NnVQanZN?=
 =?utf-8?B?OFlKekdpWFh2RlVtUVRjMHltZU5JRHVxMXh6R1ZvSW5LTVVtYWhCY0cvaW1C?=
 =?utf-8?B?eEFORnlhUGFFSFpoOGMybW1hWlhGZWM2cG5VbkVIRm4vSFAxdEs2Tkx2T2U4?=
 =?utf-8?B?ZTNPSVgxd2hZMmZ0cHVTRW5OaGRmMU0zOUE3R3NXd3V0K3I5ZnVkdkRUTlEx?=
 =?utf-8?B?OWJiNXdLNzk3M0ZWRGZYdU1vTXR3Y1pxS2h5Mm8xRUZONlB0bGNPcU5wcTBp?=
 =?utf-8?B?KzhrVTNIeGpaSTVwaUZSZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bjBlWVl0NE9Nb3ZlUWpNUWdtdUF3S1gxc3RicUlxUm80ZW85Um9WYVlMeE9h?=
 =?utf-8?B?VTgzTlQ0ZVFLcFoxY0hKRVF0d3U1ZG5KTW96cnJib2E2WGNkU1VndTgwRE94?=
 =?utf-8?B?bXNHYXF5NWlJbjR6SG11OURwaUNjT3k3UzdyYmtmbVBuOCtZQkNwTGk0cklC?=
 =?utf-8?B?NzBQU0V5WVVRZkdZTTROZVQxQjBBU1lLTXgvZStUWG85aVJ4RzJmbU5NS2hS?=
 =?utf-8?B?V3c2VFBnMER0N3NxcnpEKzNVY2F5ZXN3VFpMSnJiNHVKK1JOOUZCYlc4aHhs?=
 =?utf-8?B?UEdQdTZJSTlvUDNrcTdUemRNcDA4Y2txSmZUeVVkc1d5MlNqWFNLNkwrTWQ0?=
 =?utf-8?B?ZXdDSmVsQzNtTWNpQjB0MkJudGNoaVlEakFmTWdxSFBrOUJIdFhKeDFvaDdm?=
 =?utf-8?B?TFVLYis4L3VQT0lsMGliS0dOUzJ0eEFTWE1OdmNkUU9MS2dQNWZaSlNqc3Rz?=
 =?utf-8?B?Vm9hbXQ0TVRVMnRqekNtcDB4cU9xZmYvcXUySDN5S0UrdU5RRi9ZdU5XTnhk?=
 =?utf-8?B?WWEyWWVmR0NNVDVuVjlzaVdxVE5ZQ21ZSW5Lek1nOGlOalFQNCtaZE5xVkIy?=
 =?utf-8?B?WjVGcC85WU9keWxWYjJkdVI5QlpqNWplbmFYQmlLN01sM1RGZjM2SDNiV2Rk?=
 =?utf-8?B?SnZSdi95c204ZEgzMHJSUGlhZjZrdlN3MnpaNTNkNEo4RjhhZmRKc1YwVHVm?=
 =?utf-8?B?S1RqRC8vZlVqQ3c2ZWtTTXlrdHZDYStJeUhnaVlvdEYzaE5qR3MwbHVMNCtv?=
 =?utf-8?B?Zml5Q3JYZFluLzJrU09mcTYzdG82b3lBTWRBblh5M3B4aFIyU1FDMUNrREdZ?=
 =?utf-8?B?d1RyMnNXdHU4U3pHK2p6MFBjSXVZSUVjVWxYcHRabEdXV3BzR3NFbjdxWko5?=
 =?utf-8?B?OFZpZ3I2TGUvcjlBcnJqakdYWVZmWkI1dnJLazBkWEcwd0ppamVNVXZHM29G?=
 =?utf-8?B?MFVzOWo5STQ3MHFOcEpYRWtYcW5UL2x5YjNiZGZvN2F4L2lVaW5zY3Z2Y3pF?=
 =?utf-8?B?WmNOYkxhRDFxa0FZZ3YwWnN3VEZWaUlUMUNIbUk2My9VRjh4c2NBWVI4WCtO?=
 =?utf-8?B?Rmp2N3RKTDZ5K3VDVmRqTll1MTFUenpNWWNMejVpR1pJK3BPaC9ZTC9xQlRY?=
 =?utf-8?B?dGFpYkZ2cDZzMHVkMDJOMXBkekMwUEtXL09DSHBaa0E3dkZLWHI0TjRXMGJh?=
 =?utf-8?B?YXAwUkFJWXFMQ1dWemlNQ2FKVlJJNWJGenovSE9tSkxQMjFtOHZLbTJjb1NN?=
 =?utf-8?B?WVVuZ2EvYTBHMXhkL2FKNFVVQlIzZnpCWFVQMVBnZ2QzeHBaUlVqUmR4enBL?=
 =?utf-8?B?aEpUNXBNMVZLSmxmZ3Z3Q0pOQWtzamRYYzczd2liV2IxeTc0MmVnWDhtbVdT?=
 =?utf-8?B?b3FwT3I4OVBaWUFqYm9MSnFZRkFacTA4MHJXQWJLTlFySFJxVXlkWnUrR2hP?=
 =?utf-8?B?VC9vZVltMXRDa0k0dDB5cVdDZk5URnBRK21ma2FlVWxBNisxeHpYNTYyUWhP?=
 =?utf-8?B?bERvT1dhQVZiS1hqTDZXVjF5TEdlRGtIUlpSd1NSN3BYT0k5ZWtJSitYM291?=
 =?utf-8?B?c2Ywd253UmxJeW4rQ2RBN3dmL1doSDlNdHF2Y3VoSmM2cXZRWXphdVh5VHpv?=
 =?utf-8?B?bFJkNDlTTEVDeVlkYXRXVHREQ0Q0WTdzYkJyTDREcVgzdTM3ZE9rTDk1L2NN?=
 =?utf-8?B?Q2ZSOTY4SjlaZGNSMlJKL01TV1RJQThOZTRPWGJpalZWd1VtaUlkbHBpcjl5?=
 =?utf-8?B?emUzUngxKzlxaml0elF0Zm9abjR1UVpXWVd3R1VqY3NOUVZNb091UWpwL0tL?=
 =?utf-8?B?TDU2T0Q4L2RBYXVRcC9TVGdPbEkwZWtSQlNyZnZscjhpcWk2RmJkS2lWeXpN?=
 =?utf-8?B?YjVlL2RZMEdsMmZBMnhsQWgrY2RIMHhOR1cvYm5LRUFIQmpHclp6cEJoRG00?=
 =?utf-8?B?N1VkdnBZeU16OGhobnZFSXhPWGRXazFvc0FXS1hhUk5NUDZJTGRrcEpYSjg3?=
 =?utf-8?B?d2tMN1VPdzRiSlZ3Z2dJcHJyeVkrSG5yNGFJWGRnbllKcUN3RFdSRWprV2t5?=
 =?utf-8?B?TDdGZ0dWTHBVeGkzZmhXVDU5cmp6R1ZzZFMvVjduVFo5SFNkcS9kczNuSlpS?=
 =?utf-8?B?d1YreGZtaU9HRDFJbzZ6R2IxMGlJdEdlZEplNGNDeERlVkhuS0ZySklGeFht?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3B1857D2F148E409B68CDF5DD5AB12C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Yt4mvo8eL3Hpky7LlzGdFZsqB/ZmaDEKH0XRULhFDLd7L+LWUAGrZIqmYxuka71kLEwz6GGm7w0zRY1NrJuqHy13Xe8B8/g3G17Dbq5UhXdmGgywabaQ0CgZor20HpZelH7oQL/ejMf0b/4JUJvlq3SvBtRCRikFZ6Zf0caIXGviNcstWqYwx/yOhH3dA5lC5cvcqBg1R/53W0RcDwiRgQNx1+PiFWV46bS3+T92tnI6zJU/AtZl+SUD94mWCyR6GcRc0waVKM75KFRVLOKsWLKtKSuu3FiOrpL61iyl8ZXoNKRIg/cgqnpV9tr6lNFf+5FnAiCz/j6sJwG0481Z1LD1BHlR0ownm37kkS9o1fuFRYg/HdMVH0Z5aYxYXcVsZJtHnDSwvo/XwrBTguGxL+ig8/ocLfGjellc4Uo7IaSBePZkGH3dKZIZ9Li7YxYqst6SsE3o6Asfv3b+A1DZoBfrr0+lQlHKMipYLHFg2NJhwiLDBBmTqigHdmpOxH/nBxxtoN8CpkLy4ATOEboSSKuhodrULX/itep9TWcLLwIUCOcJQm4LigQeYfPbVF+fEUs41701a3shx8pSKAOX21AwzUZahdS6cZRCKbJmAwE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3645b313-2de4-47f5-8cfb-08dc691fba18
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 14:13:36.6570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bs9Sg13uKtBCBcdklPAKAuDv2uLGgxfvinneVGBgp5HQiipTKS9TpIuPdQhXNhNcQboKQMa/EUotinCyUzBUsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6963
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404300101
X-Proofpoint-GUID: pOSJ71TftV_xm7rgboLqYgTmRE4svEZc
X-Proofpoint-ORIG-GUID: pOSJ71TftV_xm7rgboLqYgTmRE4svEZc

DQoNCj4gT24gQXByIDMwLCAyMDI0LCBhdCA5OjU44oCvQU0sIFpodSBZYW5qdW4gPHlhbmp1bi56
aHVAbGludXguZGV2PiB3cm90ZToNCj4gDQo+IA0KPiBPbiAzMC4wNC4yNCAxNTo0MiwgQ2h1Y2sg
TGV2ZXIgSUlJIHdyb3RlOg0KPj4gDQo+Pj4gT24gQXByIDMwLCAyMDI0LCBhdCAzOjI24oCvQU0s
IFpodSBZYW5qdW4gPHp5anp5ajIwMDBAZ21haWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBPbiAy
OS4wNC4yNCAxNzoyNSwgY2VsQGtlcm5lbC5vcmcgd3JvdGU6DQo+Pj4+IEZyb206IENodWNrIExl
dmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPg0KPj4+PiBBdm9pZCBnZXR0aW5nIHdvcmsgcXVl
dWUgc3BsYXRzIGluIHRoZSBzeXN0ZW0gam91cm5hbCBieSBtb3ZpbmcNCj4+Pj4gY2xpZW50LXNp
ZGUgUlBDL1JETUEgdHJhbnNwb3J0IHRlYXItZG93biBpbnRvIGEgYmFja2dyb3VuZCBwcm9jZXNz
Lg0KPj4+PiBJJ3ZlIGRvbmUgc29tZSB0ZXN0aW5nIG9mIHRoaXMgc2VyaWVzLCBub3cgbG9va2lu
ZyBmb3IgcmV2aWV3DQo+Pj4+IGNvbW1lbnRzLg0KPj4+IEhvdyB0byBtYWtlIHRlc3RzIHdpdGgg
bmZzICYmIHJkbWE/IENhbiB5b3UgcHJvdmlkZSBzb21lIHN0ZXBzIG9yIHRvb2xzPw0KPj4gV2Ug
YXJlIGJ1aWxkaW5nIE5GUyB0ZXN0cyBpbnRvIGtkZXZvcHM6DQo+PiANCj4+ICAgIGh0dHBzOi8v
Z2l0aHViLmNvbS9saW51eC1rZGV2b3BzL2tkZXZvcHMuZ2l0DQo+PiANCj4+IGFuZCB0aGVyZSBp
cyBhIGNvbmZpZyBvcHRpb24gdG8gdXNlIHNvZnQgaVdBUlAgaW5zdGVhZCBvZiBUQ1AuDQo+IA0K
PiBUaGFua3MgYSBsb3QuIEl0IGlzIGludGVyZXN0aW5nLiBIYXZlIHlvdSBtYWRlIHRlc3RzIHdp
dGggUlhFIGluc3RlYWQgb2YgaVdBUlA/DQo+IA0KPiBJZiB5ZXMsIGRvZXMgbmZzIHdvcmsgd2Vs
bCB3aXRoIFJYRT8gSSBhbSBqdXN0IGN1cmlvdXMgd2l0aCBuZnMgJiYgUlhFLg0KPiANCj4gTm9y
bWFsbHkgbmZzIHdvcmtzIHdpdGggVENQLiBOb3cgbmZzIHdpbGwgdXNlIFJETUEgaW5zdGVhZCBv
ZiBUQ1AuDQo+IA0KPiBUaGUgcG9wdWxhciBSRE1BIGltcGxlbWVudGF0aW9uIGlzIFJvQ0V2MiB3
aGljaCBpcyBiYXNlZCBvbiBVRFAgcHJvdG9jb2wuDQo+IA0KPiBTbyBJIGFtIGN1cmlvdXMgaWYg
TkZTIGNhbiB3b3JrIHdlbGwgd2l0aCBSWEUgKFJvQ0V2MiBlbXVsYXRpb24gZHJpdmVyKSBvciBu
b3QuDQo+IA0KPiBJZiB0aGUgdXNlciB3YW50cyB0byB1c2UgbmZzIGluIGhpcyBwcm9kdWN0aW9u
IGhvc3RzLCBpdCBpcyBwb3NzaWJsZSB0aGF0IG5mcyB3aWxsIHdvcmsgd2l0aCBSb0NFdjIgKFVE
UCkuDQoNClllcywgTkZTL1JETUEgd29ya3Mgd2l0aCByeGUgYW5kIGV2ZW4gd2l0aCByeGUgbWl4
ZWQgd2l0aA0KaGFyZHdhcmUgUm9DRS4gU29tZW9uZSBlbHNlIHdpbGwgaGF2ZSB0byBzdGVwIGlu
IGFuZCBzYXkNCndoZXRoZXIgaXQgd29ya3MgIndlbGwiIHNpbmNlIEkgZG9uJ3QgdXNlIHJ4ZSwg
b25seSBDWC01DQphbmQgbmV3ZXIgb24gMTAwR2JFLg0KDQpHZW5lcmFsbHkgd2UgdXNlIHNpdyBi
ZWNhdXNlIG91ciB0ZXN0aW5nIGVudmlyb25tZW50IHZhcmllcw0KYmV0d2VlbiBhbGwgc3lzdGVt
cyBvbiBhIHNpbmdsZSBsb2NhbCBuZXR3b3JrIG9yIGh5cGVydmlzb3IsDQphbGwgdGhlIHdheSB1
cCB0byBORlMvUkRNQSBvbiBWUE4gYW5kIFdBTi4gVGhlIHJ4ZSBkcml2ZXINCmRvZXNuJ3Qgc3Vw
cG9ydCBvcGVyYXRpb24gb3ZlciB0dW5uZWxzLCBjdXJyZW50bHkuDQoNCkl0IGlzIHBvc3NpYmxl
IHRvIGFkZCByeGUgYXMgYSBzZWNvbmQgb3B0aW9uIGluIGtkZXZvcHMsDQpidXQgc2l3IGhhcyB3
b3JrZWQgZm9yIG91ciBwdXJwb3NlcyBzbyBmYXIsIGFuZCB0aGUgTkZTDQp0ZXN0IG1hdHJpeCBp
cyBhbHJlYWR5IGVub3Jtb3VzLg0KDQoNCj4gQmVzdCBSZWdhcmRzLA0KPiANCj4gWmh1IFlhbmp1
bg0KPiANCj4+IGtkZXZvcHMgaW5jbHVkZXMgd29ya2Zsb3dzIGZvciBmc3Rlc3RzLCBNb3JhJ3Mg
bmZzdGVzdCwgdGhlDQo+PiBnaXQgcmVncmVzc2lvbiBzdWl0ZSwgYW5kIGx0cCwgYWxsIG9mIHdo
aWNoIHdlIHVzZSByZWd1bGFybHkNCj4+IHRvIHRlc3QgdGhlIExpbnV4IE5GUyBjbGllbnQgYW5k
IHNlcnZlciBpbXBsZW1lbnRhdGlvbnMuDQo+PiANCj4+IA0KPj4+IEkgYW0gaW50ZXJlc3RlZCBp
biBuZnMgJiYgcmRtYS4NCj4+PiANCj4+PiBUaGFua3MsDQo+Pj4gWmh1IFlhbmp1bg0KPj4+IA0K
Pj4+PiBDaHVjayBMZXZlciAoNCk6DQo+Pj4+ICAgeHBydHJkbWE6IFJlbW92ZSB0ZW1wIGFsbG9j
YXRpb24gb2YgcnBjcmRtYV9yZXAgb2JqZWN0cw0KPj4+PiAgIHhwcnRyZG1hOiBDbGVhbiB1cCBz
eW5vcHNpcyBvZiBmcndyX21yX3VubWFwKCkNCj4+Pj4gICB4cHJ0cmRtYTogRGVsYXkgcmVsZWFz
aW5nIGNvbm5lY3Rpb24gaGFyZHdhcmUgcmVzb3VyY2VzDQo+Pj4+ICAgeHBydHJkbWE6IE1vdmUg
TVJzIHRvIHN0cnVjdCBycGNyZG1hX2VwDQo+Pj4+ICBuZXQvc3VucnBjL3hwcnRyZG1hL2Zyd3Jf
b3BzLmMgIHwgIDEzICsrLQ0KPj4+PiAgbmV0L3N1bnJwYy94cHJ0cmRtYS9ycGNfcmRtYS5jICB8
ICAgMyArLQ0KPj4+PiAgbmV0L3N1bnJwYy94cHJ0cmRtYS90cmFuc3BvcnQuYyB8ICAyMCArKyst
DQo+Pj4+ICBuZXQvc3VucnBjL3hwcnRyZG1hL3ZlcmJzLmMgICAgIHwgMTczICsrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tDQo+Pj4+ICBuZXQvc3VucnBjL3hwcnRyZG1hL3hwcnRfcmRt
YS5oIHwgIDIxICsrLS0NCj4+Pj4gIDUgZmlsZXMgY2hhbmdlZCwgMTI1IGluc2VydGlvbnMoKyks
IDEwNSBkZWxldGlvbnMoLSkNCj4+Pj4gYmFzZS1jb21taXQ6IGU2NzU3MmNkMjIwNDg5NDE3OWQ4
OWJkN2I5ODQwNzJmMTkzMTNiMDMNCj4+IC0tDQo+PiBDaHVjayBMZXZlcg0KPj4gDQo+PiANCj4g
LS0gDQo+IEJlc3QgUmVnYXJkcywNCj4gWWFuanVuLlpodQ0KDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==

