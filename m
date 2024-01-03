Return-Path: <linux-nfs+bounces-898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED41823570
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 20:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D664D1F25FB3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jan 2024 19:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C61CA9B;
	Wed,  3 Jan 2024 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bvjFaBRz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tWE31slb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37171CA94
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jan 2024 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 403HZhtc026556;
	Wed, 3 Jan 2024 19:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=bzyHlIX73Uw5XHdfR6FlNeg6H7Q7l/7PvZ3NOhVUmUc=;
 b=bvjFaBRz46slLlxEv9jgSDY6HHUZc550HFlofoA3vmDPTAY2+rcQ7fRt50upE4vwkpy6
 aPAMl4Y4Z/fnhZXZyli6Iwz9BwnZX03h14KLbgPbsKRKNZjsl/bkOdCFga3b6JZTt7Kr
 zpTtleQNARM3000dpNCeCbNQ3MzOWnTTI2AyLedsGrvxUPPt6U+vmYZ1sO5zbNhl4/9M
 nzHtQ87KgUUXBeFfT7gTaOb4QJDBP4pcy78o228LjugyNpZ9wd2rcod6mGNRGSPUV+zO
 tNNfgDkZTCs+EZs3qSJoN0MqTyvG1iXiNbEHDD05QaoUonxxAd9iIfK4CLp7LPCjLUJA Yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaa4cdruy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 19:16:48 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 403Ixo3O024165;
	Wed, 3 Jan 2024 19:16:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vddbr19gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jan 2024 19:16:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KheYabOyK8vCU5mqIwIJ3kgZwMZdPzAWQvnHy+quRimK3IfX6DXuKCrhYQITQ3N9AqpYyT+VMji3svx93PP/Ytip6UTy7Mw3xeZYyGJ0/sru/e90qmow5sDPL+bweohLznlmNfnfyC1c0bDuavDb/iIgA7tFf4BbbSq9xffoeBOAyYdo0bV+rnFuzjDS3Nr1EzjW/5ihw5ojYf9q/kBKk/P2GZHnfsK1GBP9IIvnrsXBFQwgg7SRZpHBLEq5QD3d39biiZcTEoL1rK4c2fCUFqRiycW/6xGhp49s9SDjqhcHRBrM2W0kgdVyZhk8//QN3v0BGBtKgzPS3mWO41W4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzyHlIX73Uw5XHdfR6FlNeg6H7Q7l/7PvZ3NOhVUmUc=;
 b=gLVUmWVfJEv8lctR/3rHr5l5lxiEFLGflFl5R1fkYF3kCw8JhBCvIKzpRTCJ7qU9QVRCfyoKjYfkAGzJWq7ghe9ahn+1Fcb7oCHEsa8Vwjod4bAmGg1RIh437DXROtkTk7noWirVcBLVB9gOR4pOhJwMZA1/eKaMZL5d5ZdtVFYY8ePezNfknWSy+gwrK+bsu3dOpd/RsTwjQTW84Z63JV+IxQCsbehET+9kH3p+T8qXu3yOYttwfjcZVFA5CJvMMcFDbsD5WUzilZcmYiiycqPudUBiV4DQe/3vB5/LlYxGDYtZU5DX14eD8ipYBVXvZO7bm2tu0Y1mHtOjPADk9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzyHlIX73Uw5XHdfR6FlNeg6H7Q7l/7PvZ3NOhVUmUc=;
 b=tWE31slb5YwjqyfRcJLT/JD2iEYgT+vomj3g5gsMwnlbhW39+BdVQDvDwllAINC16qwUkxmsidu5KDpkkWl5ujbBgQ7zbWXpM6w5l4n68aA0jabTeURHDQBHflCL7RwuQEVokjEptyZhZSKxUrtn3eN5G7HXV1iWxrBU+aBBLmg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4923.namprd10.prod.outlook.com (2603:10b6:610:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 19:12:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 19:12:42 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: hangs during fstests testing with TLS
Thread-Topic: hangs during fstests testing with TLS
Thread-Index: AQHaPm8s2o2kQKEy6EOaZCqQ1j2yibDIbaUAgAAHFYA=
Date: Wed, 3 Jan 2024 19:12:42 +0000
Message-ID: <D1091C94-9F23-47E9-A9CF-31CCEFE5EF8A@oracle.com>
References: <117352d5dc94d8f31bc6770e4bbb93a357982a93.camel@kernel.org>
 <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
In-Reply-To: <ABBA5E37-2E13-4603-A79C-F9B9B8488AE3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB4923:EE_
x-ms-office365-filtering-correlation-id: f3371027-0e15-474b-2a61-08dc0c8ff5dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 mH/t0Oj66U8m4kSnq4f4fMftj+d8l/Kc12071hH4mCGyL7lPd/g9ZLdQ8AIxzCsplieuovAd2zs3ol5VtlNW/e13u/WNMWEl+66xKgYwIwpftr3VqYsdCLX2b03GnGYoNd+/nsT8bqIlDwfqZsbmvSoo5VnY69bNEHxZXKFEi68481nFrIFkAEB4UEVw4anx0mi1L79lpw47srgNu1+NjalgWaP6HrWhcw9Gk/h4aRCnD6i14zLUSbYINzbcvyVyp9IKaIvUcE1BVgfmuLRUf2Bw3EL+995PtrYNhtZuKmvi7E6H/ut2x8WMCuMmIwMYRGmAf22S/uIii9RyIqRbBNDNAB1O3dYJ4hG2BdVxgVqnuXopRZo06bPo/EqTIsuAxZnQFLB+TuwjcwOUwjUWOcbhbyo05LP4pITGx70OkIQ3h8BzEdIeXdkKZQbX1dOgKAm0yJ0zYt4YEmu6mVUWZeD3QYq7XMvV43tGGhS+8lmoXmSdGF6/GGk7j5IlLLTKg1UifLeDRv2XzVue7T7uaVMey+RCVt27lKLQ6BNRuo+JnbvfxRw4lOc5Fo8qv90KjVMBQfHlBiGMeIY7lMXMA1yWXhNCifDWB1lUgZr8mWA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(76116006)(66446008)(66556008)(64756008)(66946007)(91956017)(66476007)(6486002)(54906003)(316002)(8676002)(6916009)(8936002)(4326008)(26005)(2616005)(83380400001)(71200400001)(966005)(6512007)(478600001)(53546011)(5660300002)(2906002)(41300700001)(33656002)(6506007)(38070700009)(36756003)(38100700002)(122000001)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eEZqekhtNDd3WFFKNm1rMG0zL3VjTGEyTU5Ld0VXK2dQVXNDQ09yM3NXYnh0?=
 =?utf-8?B?YUlDc1RVMFlCUm1Dc0ZLSWtnSTBtUDU4U1NpTWpCMSttQllWR2ZVMitVZWln?=
 =?utf-8?B?VkwvcWx3QTc3L1lWWjlaaWxVN0t6ZnltOFVwR1psR0tvcnBnTDJyZnRDYk9p?=
 =?utf-8?B?eFJUMHJqTVBZRlp0Q3liVzRYNDU5MXJCNmZsM0Q0NU1FTmpLYXVwbDNQam0r?=
 =?utf-8?B?TjRFNHBRU2MxZVdIRnluUTNZSDd5cFVna2doYWk0NENNOWY4c2o1K3REOHJr?=
 =?utf-8?B?UmNLZUxIdmdtMWFBVkVIaUlDZktyMGZoMVdrMi9Md0RtZVdkcG1GZ1BrVzFy?=
 =?utf-8?B?alRBYWVNaG5xV0t5MlUwZ1FjOXE0Ymhtb1JyR00zN001ZDRqSndjbWJORFht?=
 =?utf-8?B?eHdpTXJhOHhBaDNTb0RrR2FUVktocmpIOExhWFFzcVBIYmZnWU85Rk43TEVL?=
 =?utf-8?B?QXpueTFNSmtXc3pGOXpteitXOE1PM2RxVXJnZDJsdG54aEtwS0ZXaHVLanlZ?=
 =?utf-8?B?VmlWSkI1MHovZkNXam5jaG9mOVlxdzlzd2dJVFd1a2VTdy9jWjhiZzlWdzgr?=
 =?utf-8?B?aVNHMmJIZVNoNkNtdmdyTC9zWE0yNUw3R0dFa2kxS2VKT0QrK0NlUGpkdi94?=
 =?utf-8?B?UVV5TzBNQ0RTYlpOZ3JjNkJyL3h6TlBkVVJlVG80eVhvQmwzK3JIYjE5YmVF?=
 =?utf-8?B?bkdscW15MnVLclVKNW1VQzZsNm1yNnNjR3hPYVZxd0dicGZXRXNaYkcvQWhx?=
 =?utf-8?B?ZlhNdFJrK3JMbHNGYWk5MmI3ZTdlMXFsdWk5eHdjeHVaNkM3QmtkQXgyLy9h?=
 =?utf-8?B?Q1dPbC9od1FHd3YrQUlyekhUbDVpTDZkY1VkQWpzUDB6YnBQNzIyZjZpR0h4?=
 =?utf-8?B?OHgxU2YzdUl2Vk5uYlk0STdub2dsV3ErYmlQRVI2dUtteWt2NXJVQ2pGVTRK?=
 =?utf-8?B?ZzNZVjg4eGorY25OTmp6dlNiaDJ3MTJvd0g4YzV4aWxENkZTNFNMY2ZHb3p1?=
 =?utf-8?B?QTJUWk45NEpvTGViRWZ6UkIvN3gwVTQ3VlAzTnZzcGxuRklVUHgwcmZGZTlK?=
 =?utf-8?B?ZGhHQmR4QzYvckJ3MkM3ck4wL1J3ZjBGbFV5QVpONkZlUmE3c1hDc0VUcGZk?=
 =?utf-8?B?MFpUbWloeVdQZC83VytNeDAzcENER0EydGJJRUovM0lkamRDL1FsODZjUHlY?=
 =?utf-8?B?VUh1SnpsdFc0Vk8xUVVVc1RXWWJUVkVDK3RqaE9sRnNqYzBYb0k1UCtMdGxt?=
 =?utf-8?B?VDNwQlY4NndiUi9GYjl1bXlZd2FtVkZmcjVuVmNTQmMxelRSaHM2SHhpQ2ww?=
 =?utf-8?B?UWNnKzdQZllXUEg2d3ZHUjBib0poNkdsUW1IR01Zb2h0S2xnOTQweHEyR1R3?=
 =?utf-8?B?ZTR4bFBrWnp4TS9zREhhbFlROTMyMGtocG5KTXZhWG9WTkJkUEFhR3EwM0dN?=
 =?utf-8?B?QTZFUThSTE5ucHY4VFRNQnZzQ1pxL0VjZTlDRXhRZ2pXRUdvVHluV3ZlRWdS?=
 =?utf-8?B?RlZvMTFGL21oVU1BNy9kUVVlM3BvR2JRa3pOc2p1MEdxM2FXYlh1dzg4WHJL?=
 =?utf-8?B?VjBnM2NlbUljZjM2WEhHU0xZSkw2RmpHQzgxOWYxdjVoRm1lVHdybzc3enQ1?=
 =?utf-8?B?azRJZjVMb2pJUkZDZ2tkc0p0QlBXUU1FOC9jWW0vQnV0eDFObXVVc2ovU2Va?=
 =?utf-8?B?NExwSmliR0dVaG5pMi8wcytKT0JaRTczd0lWQWtiTWtxcEtlUWMxSW1LdUt0?=
 =?utf-8?B?RUdWNlV6aXZvSHY3dE9vL0VTbUdlT1F3NmUxLzNmWTRPb1NrdkhWVTVpWU5R?=
 =?utf-8?B?L1JOc09DeTA1ekNNK0JXVHpLd1RiaDZQa1RpZ1N0a2dEZUtXbkFlYTB2YmZL?=
 =?utf-8?B?UE5kQi9EVFQ1OGFaQnRQSXRKb3p5MmtwMURrSXJINEJSUXkwUEJGdld3eW5m?=
 =?utf-8?B?a09KYWFIZmt3MWxnNFdPK3grSlU5b2hxRHFzeGVXUHk1bERyeUlYMmIvRWNE?=
 =?utf-8?B?dGdoVFdvWkxHTndzd2FlVVF0c1JudDlkeFF4ZGpHK1BnaE9GWHV0VDFYczVn?=
 =?utf-8?B?Nm9kaTRUSTVpZG9PVnU4bmVOWjgvaU9mMUFhYk9IRVJmSGh2dkhNSDh4T1ZG?=
 =?utf-8?B?MnVEMU9YcGR2aWRLS2RoWFRWZ2hmVEhRaFNLRnBIUytaZ2s3ZDI4a0t4N2NQ?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <466B435CB4108D4B932A2BEBF638CD28@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8jk0BThxZcMSLjhG1UobwWPiTSnzea4GszQzACdJ33qLqeF4TxMP1DV+7O5XvVgEuVwss4+rL01cLvNx6tfkYT9+sLV+UXjd3S/P/eN5cZzB0blN3VzijUuJMDX+ubMmBWSdayq6nfa72awAsFQiBizxMrLi8bDt7NphnrPonDkAIYYIyvzYoPowjMcNqviqsF+3usykYmcWv2icdkxcFnFKqVNO79YLZu1wJ8U9VL0UklPI2cV1VLAfZ9DXJMuQEn3PrXgA0XpQoroovwsBT4dOtZPJH3sQj1A8yE4CRlOgftL72seIV88+dxIqZ7oJKB3whAqbEc+j8yPFNyFfSfDvdEfbvtaKbs/sFfytrftHu8p/aplk5BGfWuiqt9mgXpx4NpZdNwrZLUSW2bRJ7buC9+KhXBxUafog5XfCCGETO7OKVe/LYkb1LzprkjFgtn3vCmyfy86gacrWmzhV1+474Zh7gkQUlpOec0GB5Nmp0dcl9YZciVf3QrOG99IEqfK2mMAVUIWEnw2ISHVczRAu+a3gVywM3ZViDL8Pip6m4AV5m/hPXEO/W9eVbUCYoTUxExmCeAtK6hPdRzgYiU7KmbdWsFbhhuirI03QGWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3371027-0e15-474b-2a61-08dc0c8ff5dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 19:12:42.4218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tx9tn/DcibQRfDFv3FOY4UPZs64v/44M0xvf+AoIPt7jX5WsihGw3W3KtTeJ6AHgSYaWTYhgxTzkJLE6nJkLiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030156
X-Proofpoint-GUID: ENl8LyH0mbY9lWz7_aNFUVMYD3pBt4wG
X-Proofpoint-ORIG-GUID: ENl8LyH0mbY9lWz7_aNFUVMYD3pBt4wG

DQoNCj4gT24gSmFuIDMsIDIwMjQsIGF0IDE6NDfigK9QTSwgQmVuamFtaW4gQ29kZGluZ3RvbiA8
YmNvZGRpbmdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgaXQgc3Rh
cnRlZCBvdXQgYXMgdGhlIHByb2JsZW0gSSd2ZSBiZWVuIHNlbmRpbmcgcGF0Y2hlcyB0bw0KPiBm
aXggb24gNi43LCBsYXRlc3QgaGVyZToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
bmZzL2UyODAzOGZiYTEyNDNmMDBiMGRkNjZiN2M1Mjk2YTFlMTgxNjQ1ZWEuMTcwMjQ5NjkxMC5n
aXQuYmNvZGRpbmdAcmVkaGF0LmNvbS8NCj4gDQo+IC4uIGhvd2V2ZXIgd2hlbmV2ZXIgSSBlbmNv
dW50ZXIgdGhlIGlzc3VlLCB0aGUgY2xpZW50IHJlY29ubmVjdHMgdGhlDQo+IHRyYW5zcG9ydCBh
Z2FpbiAtIHNvIEkgdGhpbmsgdGhlcmUgbWlnaHQgYmUgYW4gYWRkaXRpb25hbCBwcm9ibGVtIGhl
cmUuDQoNCkknbSBsb29raW5nIGF0IHRoZSBzYW1lIHByb2JsZW0gYXMgeW91LCBCZW4uIEl0IGRv
ZXNuJ3Qgc2VlbSB0byBiZQ0Kc2ltaWxhciB0byB3aGF0IEplZmYgcmVwb3J0cy4NCg0KQnV0IEkn
bSB3b25kZXJpbmcgaWYgZ2VycnktcmlnZ2luZyB0aGUgdGltZW91dHMgaXMgdGhlIHJpZ2h0IGFu
c3dlcg0KZm9yIGJhY2tjaGFubmVsIHJlcGxpZXMuIFRoZSBwcm9ibGVtLCBmdW5kYW1lbnRhbGx5
LCBpcyB0aGF0IHdoZW4gYQ0KZm9yZWNoYW5uZWwgUlBDIHRhc2sgaG9sZHMgdGhlIHRyYW5zcG9y
dCBsb2NrLCB0aGUgYmFja2NoYW5uZWwncyByZXBseQ0KdHJhbnNtaXQgcGF0aCB0aGlua3MgdGhh
dCBtZWFucyB0aGUgdHJhbnNwb3J0IGNvbm5lY3Rpb24gaXMgZG93biBhbmQNCnRyaWdnZXJzIGEg
dHJhbnNwb3J0IGRpc2Nvbm5lY3QuDQoNClRoZSB1c2Ugb2YgRVRJTUVET1VUIGluIGNhbGxfYmNf
dHJhbnNtaXRfc3RhdHVzKCkgaXMuLi4gbm90IGVzcGVjaWFsbHkNCmNsZWFyLg0KDQpORlNEJ3Mg
YmFja2NoYW5uZWwgY2xpZW50IGhhcyBpdHMgb3duIHNldCBvZiBxdWlya3MgdGhhdCBtYWtlIHRo
aXMNCnNpdHVhdGlvbiB3b3JzZS4gRm9yIGV4YW1wbGUsIGEgcmVwbHkgdHJhbnNtaXQgZmFpbHVy
ZSBvbiB0aGUgY2xpZW50DQp3aWxsIHNjcmV3IHVwIHRoZSBvbmUgYmFja2NoYW5uZWwgc2Vzc2lv
biBzbG90LCBiZWNhdXNlIHRoZSBjbGllbnQgd2lsbA0KaGF2ZSBhZHZhbmNlZCB0aGUgc2xvdCBz
ZXF1ZW5jZSBudW1iZXIsIGJ1dCB0aGUgc2VydmVyIHdpbGwgbmV2ZXIgc2VlDQp0aGUgcmVwbHkg
dG8gdGVsbCBpdCB0byBkbyB0aGUgc2FtZS4NCg0KDQpKZWZmIHNheXM6DQo+IEkgZGlkIHR1cm4g
dXAgYWxsIG9mIHRoZSBzdW5ycGMgYW5kIE5GUyBjbGllbnQgdHJhY2Vwb2ludHMsIGJ1dCBzYXcg
bm8NCj4gb3V0cHV0IHdoYXRzb2V2ZXIuIEkgYWxzbyB0cmllZCB0dXJuaW5nIHVwIGFsbCBvZiB0
aGUgZHByaW50aydzIGJ1dCB0aGF0DQo+IGFsc28gc2hvd2VkIG5vdGhpbmcuDQoNClRyeSBib29z
dGluZyB0bHNoZCBkZWJ1Z2dpbmcgZm9yIHRoZSB3aG9sZSB0ZXN0Lg0KDQpBbHNvLCB0aGUgc2Vy
dmVyIG1pZ2h0IGJlIGRvaW5nIHNvbWV0aGluZyB3ZWlyZCwgc28gdHVybiB1cCBkZWJ1Z2dpbmcN
CnRoZXJlIHRvby4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

