Return-Path: <linux-nfs+bounces-628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBF5814AA1
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 15:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44689B22F25
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Dec 2023 14:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3819F538A;
	Fri, 15 Dec 2023 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HAMszigc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wChEUYtY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7E1C29
	for <linux-nfs@vger.kernel.org>; Fri, 15 Dec 2023 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEZBIX017945;
	Fri, 15 Dec 2023 14:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=me9eFK1r4osRdFJJnEo/441rM0g4ixh/ZC4GRyQABcA=;
 b=HAMszigcqCcT5SKaNEpNmTsgssVDVSG5YdzOs8mM3oFVJ6hhHe7FedUjEwlhdYiEvaE/
 EbP8QXH/bMWUnQrWPlSCWBg9jEQliGmWgnPPNIZ4ygEm3h4l7iRUp1f1ZhsksrXZ9G6L
 C7U5ozYMCl5XBrWgIyt6y+JUDKSS1FYRG+H9j+PSEZYz8Q3Wj6PVAZpKHqXCOUVwooaM
 ZpPs4l8rNTVFx6NQDdEaaujoEqtIM7ekfRnD73AUdX19pXiFKav1L4SBB6sLuJ04HixC
 kjpa1591nHTPfsPEbOtZU1iWsxShyyDqDdi9d0Y4BgKJiL9VGcsA6wOSe8gVzz3gkvQy Og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsung38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 14:38:49 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEcb4g003164;
	Fri, 15 Dec 2023 14:38:47 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepbvxaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 14:38:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQq3msyJklCkrX6GihEFpxr0jDLOb9GJ/U0LbJRGqpeXztHLj9iG0DHFhLnDMlmUTJ+tWg8ZJsPIjmz5MNUIg8adUNRCuRCbTuWEc9/b4oqk3/WrTpZ0aINuzk189f1w+XiRv80srqQsLYLW55p6kCu2d403sl0a1s2Nb3GTRe92P6yrLgMZ+gxxEhek6/oYuTXaJdWFaxNF471efuH5+PnRHG47SymDpbomsaqkZYptkua6mZQel+eYOrwVVpftSoto+/E7Fg7wMF2w/tNPLVVrFgX3Yryx7chR2Jp1bQDGmZISJZE4tbg84Y6rgzkRKNuGPsOjH1wylcSZKwq0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me9eFK1r4osRdFJJnEo/441rM0g4ixh/ZC4GRyQABcA=;
 b=dE7gephyvOrU9n2pEfqt9gxpx0Qa7LD+qJHDFoX435PgaLJ4QeKRMZNCCe0zmTFZjbC2tWYMmJ3SJvNfZ0exBamk3oaPHNgHuvFTsMCfl++VzHAX3FI3RP+ulPt6UMK4qhSd+VQPME1OmZDa//mIMa1wilurs2u96jHNSfwfzRX+pcDIFmNMxmj4/vGNE652Bg3dJTZ3UYK/op5NyHPOra2Iu9NPLPVd4fbDsKKp9BqpbzIVK3+hP91Q1S/yVMnct9H1akcwhIMzmJU+PEN4sfN+hTbeCY/n1+qsJYQFRmf6NTIMus7ouAgKGfJKryrtUtn4uPFN7ZMtOgKHAq0bXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me9eFK1r4osRdFJJnEo/441rM0g4ixh/ZC4GRyQABcA=;
 b=wChEUYtYpCyx0Qc4blIJfOQhPR1TDyp3b0+WG7dsJe6ecy2W2HHPHeP2Xxqa6wHnAgDCCILBlIy5Pq9uDyoYFkCCevRrPywqc6HROaObfE+zTYgdcZ4GbKEnUwz3iFsfyppveUKSew+7oy2YVycunJkPe2F0R73sASvWvU/Y0/w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN6PR10MB7519.namprd10.prod.outlook.com (2603:10b6:208:471::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 14:38:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 14:38:44 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH 0/5 v2] sunrpc: stop refcounting svc_serv
Thread-Topic: [PATCH 0/5 v2] sunrpc: stop refcounting svc_serv
Thread-Index: AQHaLvIpI3Gh1yYMNEWNLEmjJILL4bCqLZEAgAA35gCAAAIGAIAAA2EA
Date: Fri, 15 Dec 2023 14:38:44 +0000
Message-ID: <C923978C-5171-4394-A3F7-101E07092EBD@oracle.com>
References: <20231215010030.7580-1-neilb@suse.de>
 <7659cf71534f9e81cb95f1571f1942a30b7f5a60.camel@kernel.org>
 <23A34EAB-A72E-459E-8D2D-7160CB25B549@oracle.com>
 <c8b275c3a9b168e8e4b4a4b4e921e913428294a7.camel@kernel.org>
In-Reply-To: <c8b275c3a9b168e8e4b4a4b4e921e913428294a7.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|MN6PR10MB7519:EE_
x-ms-office365-filtering-correlation-id: 460bc67d-04a6-455a-8e29-08dbfd7b8a3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 anR5J7IRMDBovvCLrnwBiM92oG7lH85sSToP9droipRKCWkIWhUHfmOf8yTEmlplOSq9fyERv8Ov2w4i+0J4RTlA/xrUfJ175TVxhV6zP5w1AMsGCVwr/on2lepYKx4UthNeicbD144OcIhvPyPaydF2Ew9BVDF5a1zlekU4kynrG3hddAoqysaewQU8BHT442tTUO8HKAnhVo2fSkehOndBd5QyR8ueHlBfp4XDB1iug4YG1EUMfRGmI8uDeG/XLxOZ1e78zV/x//zonGu11LMhVLM1G+j5vsykHGPwPQB1BQncXCMCj7jorIK/6k86PTz7XA09ThCEiaJ1TAuj3sGqLDg7dc6aeHqB0QOBsB8WvUVB1SZAN7IaUPTcdImOBK4Ho19oiVO93p6rtrAQHFuiZJ/sMbD1TIqTmoeWLe7hsrwamj1RmAgYp5yeZBeRHyg+7uMZe3VCynCq7GPZmm9LtYcZcZ+78WX5aQMjeddfDBP2gmVqi2BpQo/2HBjSeYtGHn1FFYfYB6J+A0W6pskA/cV8ke/ThH9IxVQ0E8ke8xjqLPiB5dyC12EmbfKWjCE8TEfLUXLWVfrD2qbOUx/YEyy7L5K7yOagq7RrjvKCczkYtag4VeJ8q4FMwT33
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(26005)(6512007)(6506007)(71200400001)(86362001)(33656002)(36756003)(38070700009)(38100700002)(5660300002)(8936002)(8676002)(4326008)(66476007)(83380400001)(53546011)(122000001)(64756008)(54906003)(66556008)(91956017)(66946007)(76116006)(110136005)(66446008)(41300700001)(2906002)(4001150100001)(966005)(316002)(6486002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZjlOVWM2NDVYOVRuZVFPdEhaR2dnanZ5ekpTWi9kbTR1K2NxL3ZpcFdSWU5i?=
 =?utf-8?B?anpMS1J2YTJzVU92NmtIUzJuSmhRMVJ5VzFDbC9NT3pQZDV2bzZQS0d3MUxx?=
 =?utf-8?B?ZUxGWUpWREZXRUhvSFBjdzNmWjV0U2V1Nmh5bXpaWTh6Q1MvN3kwTjNRRk1w?=
 =?utf-8?B?eDNxdHY0d3NsOXA5TkZrMkNPUGVucXBQMkloeFFXUXVWY2Z3K3hNalA2ajJF?=
 =?utf-8?B?aGpqdEh3MGdLZDkxU2dDdzNFaEtqeXBaNHZDaGZTczBHOHBDNjhydWJMR0Fi?=
 =?utf-8?B?VnhBTW9mSERSN3lBRGFKdnppSnVhVTM5VGFteEs0czNyVmZIOExRSlFlRVNR?=
 =?utf-8?B?L2xZTnRRdkhyd3BMWCsxeVJlQzBmYUxPWnorZ2hJTExnRElPL3FvTXVSSFZB?=
 =?utf-8?B?RldLNjRaNU4zT01UQXhzZkRzQ3Y5UG1hWWdIVEhuM0N2c1kyMXoyQndiM1I4?=
 =?utf-8?B?RytEUzJvWFBXU1NtZjVwMDBZeGFVR1U5YzBPem5EREJ1SHdHYmM5MWJQOXhn?=
 =?utf-8?B?cWpSaVpLbFZ4OStiSTR4NklSWm56c2RkSU9uU2ZVYW53SGY2WU9HTTZOZEVZ?=
 =?utf-8?B?QzdQNndnRENTdklrS1lDSENPSXBYaHVEc1BjWjFteS9rSXdHVm9VSnNuRStL?=
 =?utf-8?B?azVTeVRZNmduby9ZQ0J1bHloN2dvUkpLWnNLQmtuS1VjSWpVNFdYU2o5N1Ay?=
 =?utf-8?B?TENGNDMwSFArNUZrU3lydThHUUl2Z25vQy82TUlrbEFkd21YUEVOMDVwNUlR?=
 =?utf-8?B?RnoyTWRtU1ZDQ3JUZSs0WVpRNlBFSzNWZS82Q0ZVR1FhdytUREpTR1pTYVRa?=
 =?utf-8?B?cTlzQmRBYmxFWENaWGVzUzNGeXJmRms3bTVTbEkwQnp2N21tU1VSblpONEZi?=
 =?utf-8?B?dS9UQWptcWtRUmNEUnpnRHhkbVNnT3FyWE1SVmowaStUT2xubkk0MEpKenJj?=
 =?utf-8?B?cW5BZ2d0blcvVngydU1IMnRZSnJibzJKRDRsU1VIc1FnNnc3cG9LYVNMUkZ3?=
 =?utf-8?B?cHl1OTl0UzY3TUR4V2RmWmpVR2pFVFJCWFRsOHB4Y2FnK09ONUtMRmNBa2dq?=
 =?utf-8?B?b0dVY3djTy9TS0d6b1NCRnVqaEVtQ3U4ayt2QWxHK1dCSTI1UVBDWGdKbDh5?=
 =?utf-8?B?eUVFU3NHbDhQTXdxUVhhMjRjWTdRY3piM3JHQ3p4ZU5uenVvWVp6OE16WmFH?=
 =?utf-8?B?bklLbi9LMWc2UXhuWDdlSlRYL3dPaXZpWFpTRjJrM25RN3lQMnMwWExQQ1Ro?=
 =?utf-8?B?VVE3RkZhUklDZ1Z0OW5mSXpkVDNoUHdEME5Eamk3NUk1UmpHRWF1SlpHNWZ6?=
 =?utf-8?B?Q2pwTEo0M2RHdmEwT0F2bldPakRSQjFETEo5eXJicWphL0xUQjdkeWV6TnhT?=
 =?utf-8?B?QmRCaVE3NVhmdFd0WFlYMHUxVkZoaklQVjRiaTVlZGppbkRBQWVaaVlDUVZV?=
 =?utf-8?B?Wm80cUFidWFjeG0vdXA3emlIVisvT2d0R0R4dFYxOWh4SlFES1F3d2pvTUxR?=
 =?utf-8?B?NS85Si9lR0hhSU5UL2l3M202dWZUMTNWb0xIdVJmVjJXdlJMc1dWS1psaTdE?=
 =?utf-8?B?VHQ4ZjhjZlN1N0x3MkN0WFRxeWJsK2ovbTdzWEpLbkd2L2VHTWpzNjNUOUM5?=
 =?utf-8?B?TFIxelQ3OU1Iek9OV3o3V0FUbVpycTRJUHVDSHRpQ0E2ZnNjclAzZnlzNko3?=
 =?utf-8?B?UVJ6Nko0RDlkb0JrMUpWaFBpYmNMVFpSeXVDcTB3TzY0cUEvWW9RYUJNaFM3?=
 =?utf-8?B?UW5qQjdmWUdNMVFxN2FaY0tReU44aGxiVDBwVU5jem9ucjRJLzlXcUx2d1RB?=
 =?utf-8?B?NnN1MHliVnlyNDZ3YU9mcFVqNUpYZGFmdnpJeVlXakh6dVNUcGVQL2FjQldR?=
 =?utf-8?B?QnMxWVNiSTJ0TGwxVzkvNVNCdmVxZVA5emZhKzhzL0dmWkR2SXV4UDYwMFB0?=
 =?utf-8?B?TFlaemlJd1d4RFc1Sk1RSFZFUVozWXV4OEdaMUN3SFlpL1F3a0tNMkExL3Vz?=
 =?utf-8?B?NHNObWNYeUxRRlRzZW9JZThQb0ltdExmY3Z2TkRQVnZVVFlJcHA3dVV3NHJl?=
 =?utf-8?B?ZzcvWlBFczlpZU1HdTVJT2c3UGVHQTdZZFRBSHRudGxTdTB1dmNWTmpPL040?=
 =?utf-8?B?OC9Kdk5ya2ZZdWVYb0UrY1YzbDRLaTNMZVdDY21SWk85SEJoZEF0aHUyWVpt?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A32B1733D90E034281DD34833D141D94@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Z5GbrZi05NLh3OA56CdGDxpg2DE2Fi/44YNfT3czub532U2aliiDMjH5Neo1q85duR4i3AamXYs95V8sTkDViA/zG6UO53lVyMXpbwEU4oaJJDoPotS6tSd7uVU0hz80fJo3AsQrGZBWI2HVxK2tooJZgTL3Cu2tHqGI+XCh24JIkOceAl5z32o1w9Z+8uFxsTEm/+vCu+Egm0JLM1WHLDRsufpVeKbHEDVZqIX/ks7jnH9B21viEqvHBor64WcOw30zFQI2T2OmwzvRlSwa9ChkK6T/I+3kgXDULRwqra/0t/zwu0KmUcfd3qV8ND3nEb7qXd5huvDMgn/JK6j7KShX6+Cd0EQh0qB30iZeiF3lb8E9QlrvPGmhwaW2TnoexNauAlFvB/uW+XZKzKVDmsofMNIm827qYwA+Lqrcys8w5joFxBEAn2FwhDJedqG6r58kc53yfe9xNdPfTuOR5UZ0ftPpJNCfYOuzMt9rsGgHTRqRlZumYIIumjS9xiIEs44kMZJ+k8+Sq2mLvEQ+7bykRNoNIMfhOSF6zJ2smEPKnQ8hrpvUTT5t80quPlV4BboreS3xXdKwshV1Q45ZuRwJcVuTUm4/9jewokxcAuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460bc67d-04a6-455a-8e29-08dbfd7b8a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 14:38:44.4678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7sZCSYelnNaO5ZOo9jAWXab3VMahdVlApyy7TTliT1jgsZDcnXlsXq9QvbqhQv9krBkvXGgqcAOGSAIiY59I6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7519
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=836 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150100
X-Proofpoint-ORIG-GUID: Ca_n_rrEWMlwgiQIZhY19jnsIrEb4qp9
X-Proofpoint-GUID: Ca_n_rrEWMlwgiQIZhY19jnsIrEb4qp9

DQoNCj4gT24gRGVjIDE1LCAyMDIzLCBhdCA5OjI24oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDIzLTEyLTE1IGF0IDE0OjE5ICsw
MDAwLCBDaHVjayBMZXZlciBJSUkgd3JvdGU6DQo+Pj4gT24gRGVjIDE1LCAyMDIzLCBhdCA1OjU5
4oCvQU0sIEplZmYgTGF5dG9uIDxqbGF5dG9uQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+
IE9uIEZyaSwgMjAyMy0xMi0xNSBhdCAxMTo1NiArMTEwMCwgTmVpbEJyb3duIHdyb3RlOg0KPj4+
PiBJIHNlbnQgYW4gZWFybGllciB2ZXJzaW9uIG9mIHRoaXMgc2VyaWVzLCBnb3Qgc29tZSBmZWVk
IGJhY2ssIHJldmlzZWQNCj4+Pj4gaXQsIGJ1dCBuZXZlciBzZW50IGl0IGFnYWluLiAgU29ycnku
DQo+Pj4+IA0KPj4+PiBUaGUgbWFpbiBmZWVkYmFjayB3YXMgYXJvdW5kIHRoZSBpbnRlcmFjdGlv
biBiZXR3ZWVuIHN1bnJwYyBhbmQgbmZzZCBmb3INCj4+Pj4gaGFuZGxpbmcgcG9vbHN0YXRzLiAg
SSBoYXZlIGNoYW5nZWQgdGhhdCBzbyB0aGF0IG5mc2QgdGVsbHMgc3VucnBjIHdoZXJlDQo+Pj4+
IHRoZSBzdmNfc2VydiBwb2ludGVyIGxpdmVzLCBhbmQgd2hlcmUgdG8gZmluZCBhIG11dGV4IHRv
IHByb3RlY3QgaXQuDQo+Pj4+IHN1bnJwYyB0aGVuIHRha3MgdGhlIG11dGV4IGFuZCBhY2Nlc3Nl
cyB0aGUgcG9pbnRlciAtIGlmIG5vdCBOVUxMLiAgSQ0KPj4+PiB0aGluayB0aGlzIGlzIG5pY2Vy
IHRoYW4gdGhlIHZlcnNpb24gdGhhdCBwYXNzIGFyb3VuZCBmdW5jaXRvbiBwb2ludGVycy4NCj4+
Pj4gDQo+Pj4+IFRoaXMgc2VyaWVzIGlzIGFnYWluc3QgbmZzZC1uZXh0DQo+Pj4+IA0KPj4+PiBU
aGFua3MsDQo+Pj4+IE5laWxCcm93bg0KPj4+PiANCj4+Pj4gDQo+Pj4+IFtQQVRDSCAxLzVdIG5m
c2Q6IGNhbGwgbmZzZF9sYXN0X3RocmVhZCgpIGJlZm9yZSBmaW5hbCBuZnNkX3B1dCgpDQo+Pj4+
IFtQQVRDSCAyLzVdIHN2YzogZG9uJ3QgaG9sZCByZWZlcmVuY2UgZm9yIHBvb2xzdGF0cywgb25s
eSBtdXRleC4NCj4+Pj4gW1BBVENIIDMvNV0gbmZzZDogaG9sZCBuZnNkX211dGV4IGFjcm9zcyBl
bnRpcmUgbmV0bGluayBvcGVyYXRpb24NCj4+Pj4gW1BBVENIIDQvNV0gU1VOUlBDOiBkaXNjYXJk
IHN2X3JlZmNudCwgYW5kIHN2Y19nZXQvc3ZjX3B1dA0KPj4+PiBbUEFUQ0ggNS81XSBuZnNkOiBy
ZW5hbWUgbmZzZF9sYXN0X3RocmVhZCgpIHRvIG5mc2RfZGVzdHJveV9zZXJ2KCkNCj4+PiANCj4+
PiBJJ20gbm90IHN1cmUgcGF0Y2ggIzIgaXMgYmV0dGVyIHRoYW4gdGhlIHZlcnNpb24gd2l0aCBm
dW5jdGlvbiBwb2ludGVycywNCj4+PiBidXQgaXQgc2VlbXMgcmVhc29uYWJsZS4NCj4+PiANCj4+
PiBOb3RlIHRoYXQgcGF0Y2ggIzEgcHJvYmFibHkgbmVlZHMgdG8gZ28gdG8gdjYuNiBzdGFibGUs
IGFuZCBJIHRoaW5rIHdlDQo+Pj4gd2FudCAjMyBpbiB2Ni43IGJlZm9yZSBpdCBzaGlwcy4NCj4+
IA0KPj4gUmVtaW5kIG1lIHdoeSAjMyBzaG91bGQgZ28gaW50byB2Ni43LXJjID8gVGhlcmUncyBu
byBGaXhlcyB0YWcgb24NCj4+IHRoYXQgb25lLg0KPj4gDQo+PiANCj4gDQo+IEl0J3MgdGhlIHBy
b2JsZW0gSSBub3RlZCB0byBMb3JlbnpvIHRoZSBvdGhlciBkYXk6DQo+IA0KPiANCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZzLzVkOWJiYjU5OTU2OWNlMjlmMTZlNGUwZWVmNmIy
OTFlZGEwZjM3NWIuY2FtZWxAa2VybmVsLm9yZy9ULyN1DQo+IA0KPiBPbmNlIHlvdSd2ZSBkcm9w
cGVkIHRoZSBuZnNkX211dGV4LCB0aGVyZSBpcyBubyBndWFyYW50ZWUgdGhhdA0KPiBubi0+bmZz
ZF9zZXJ2IHdpbGwgc3RpbGwgYmUgYSB2YWxpZCBwb2ludGVyLiBIb2xkaW5nIHRoZSBtdXRleCBh
Y3Jvc3MNCj4gdGhlIG9wZXJhdGlvbiAobGlrZSBOZWlsJ3MgcGF0Y2ggZG9lcyksIHNob3VsZCBj
bG9zZSB0aGUgcmFjZS4NCg0KT0suIEknbGwgYWRkOg0KDQogIEZpeGVzOiBiZDlkNmEzZWZhOTcg
KCJORlNEOiBhZGQgcnBjX3N0YXR1cyBuZXRsaW5rIHN1cHBvcnQiKQ0KDQpJIHdpbGwgYXBwbHkg
MS8zIGFuZCAzLzMgdG8gdjYuNy1yYywgYW5kIHRoZSBvdGhlcnMgd2lsbCBnbyB0bw0KdjYuOCAo
bmZzZC1uZXh0KSBvbmNlIGl0IGlzIHJlYmFzZWQgb24gdjYuNy1yYzcuDQoNCi0tDQpDaHVjayBM
ZXZlcg0KDQoNCg==

