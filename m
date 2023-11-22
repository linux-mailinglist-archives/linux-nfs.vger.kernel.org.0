Return-Path: <linux-nfs+bounces-30-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D58A7F48F8
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 15:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13089B2105E
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Nov 2023 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C494E621;
	Wed, 22 Nov 2023 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OSNheHIp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yfHoed+i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64689A
	for <linux-nfs@vger.kernel.org>; Wed, 22 Nov 2023 06:31:44 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AME3mBb021321;
	Wed, 22 Nov 2023 14:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Fml6j/AU4ULUjbpbTYgopM4KX/V6ZQT3F2HR1ZDn1mc=;
 b=OSNheHIpsBAd0qacTlDEKGkGNMYvukqf4zWvPAN10/jLit/geqp5cEgEfNAQoVQ6qyyc
 JoyJmGW1z2msNYpXbJs4h24AteomEIqrTRbprsBR3WPta6esG8NwEoPNSwf1dQkgp3Np
 zNcNNis+anc+2DSG7PFHr5Q83h4FGOcduiiJia5kAH5ltm2+aB3TlSsUc9cqeS9iUYXn
 AiC95h8KY3Dcn51Fvj55nOO+7wkDn+3QUP4bCQy74bEikH+sv22vTMFLX/0HXKSDrgNV
 UKG1pQgiPcAnmfo0Bs2GoctCWf+OlA9jGmwVAxUjdem8f1Kz3dYcpVVLmMyJEqRoZrpk tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uemvufhdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 14:31:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDUcES002584;
	Wed, 22 Nov 2023 14:31:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq8u593-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 14:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ9eZMw+0THyfJodS6hkrShmnSzpr7FNJxKzSdGnzjxRLZCH61f1pRYvL/uxA5qGDbMFlhqBP8b9iKc5bdgsidm6W7XhyS/2NFYuNpcgllOU1tZFhe1pAwsr+O+gSR3EAh9e741XQ+BTJ+nZxunf4dcvVZtAYTTrySaYof2HmMCJX770x5KiZsC2Zo94b4/Z2jI5v14I8rJVz2qpCA64gqaxxhgKsKnqQNZ1DCkZ3TqaNiWW67/YnoYeLHAs1WaNxx+qxy+D6Q/RJxkvD2GG4YU3ow8XdIz3tnq3k/SALYINsffN7LaHsPsMl02o2djCzZ53HRdDQm1/w3BNNPS8fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fml6j/AU4ULUjbpbTYgopM4KX/V6ZQT3F2HR1ZDn1mc=;
 b=MA9MGjdBRPkwhBJf4rN2h/ek6/isInWGjHXEZm2oivt+JKJIKDX68WlmFMCIM3SfZnKME6igh//30ewHiqlPMC9Aqeb8zFs3giyce2CBy4Mo+yRpvtHa59RKGLqT3LbWnTh309xBCs6pY1U2oMZ1RNzFpu4nJFn/cFJz25d50E2Qq6AnFGfLca6Uh7TKdtCTcHyG9ZDEN6NIKnjMYv2bebNiXuehZ6iSkSYFI988HKPOLzNl9hvVn2tfnCHozM7wOHrbSWX3G4gMk7U9IHxvz98Arq443VgGkZiGZTUDiwFEaHvxEI/6o7WExHM3mjhvMaiWQKRB4lzimE9hhjDj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fml6j/AU4ULUjbpbTYgopM4KX/V6ZQT3F2HR1ZDn1mc=;
 b=yfHoed+iD+IzI9/LQk3bx6KmOVkL9cIWHwWvWdFc2kcnT3D2LWYNDYasx9yzBtMVJdWSRcxFLxcckwbcqkiWxs+CKn28HCk01rnnIASNfgplxtrBzcClMNCsvnhqnDw8tpRcc/dvNJxE7ONV17r8tzMyrOoZQov3ASPiSIxKfKc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 14:31:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 14:31:31 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Olga Kornievskaia <aglo@umich.edu>
CC: Olga Kornievskaia <kolga@netapp.com>, Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: changes to struct rpc_gss_sec
Thread-Topic: changes to struct rpc_gss_sec
Thread-Index: AQHaHJwg2fXD+j4QtUyDX01K/ANhlrCF2ygAgACMv4A=
Date: Wed, 22 Nov 2023 14:31:31 +0000
Message-ID: <6F0CCBAF-29E1-4720-A7DC-9F43751B56E7@oracle.com>
References: <97AE695C-8F9F-4E9C-9460-427C284FBD32@oracle.com>
 <CAN-5tyHxvTevgM38q94W4e+rBzYu7tWqDHVMNcFQ5GT3uNArCw@mail.gmail.com>
In-Reply-To: 
 <CAN-5tyHxvTevgM38q94W4e+rBzYu7tWqDHVMNcFQ5GT3uNArCw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4574:EE_
x-ms-office365-filtering-correlation-id: 89be3dee-80f1-4e97-09bf-08dbeb67b8df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7OIgTmETolXtwtT+4f3KlgNHY/Odxdux0k/4RSj44IIKdtKjAoAN/PYe/JQMc+MSOUDdyYSWLcp9AEX+QaJZ5srN4ouVxgNr5fvIqMFaJOhpxCcOt56qsavzF9+zWLLX2JThAMHN3LGtq1bpFEpqXjZIsjyvdV3BPOfEIZ0UttLFWmpkT0Jf8unwRRoJB1lXWty2O8KYCOOGnkekta2ZzwQT20HsAWnk8ssG5isKwdowvsKrhUI1J9F2fq1vUvXnsGZ9gg35ynDrj456JF7Z/hnFVza2yy4EgYW3pBEKbRPePIVD9JIhIJDpOF4/SBTR324msNHD2a8Pu2JDkFwsRXix5dogH/kUifaeEs3ZOlwSMbQumD991EIOCBaIvKmdtklGHnDEhoSxo+pQ2EI6aHhbLd+1YWuOQTbIc1OWyuERU7eO5pmS+z1lHb0eJ5l8xaiGzOiSn+o+AeunAChjcwD6Eyh0TPXa5/J27Re1RhQ+kFkMdZhyMzcQnY5rlJ7m8Csga0NEiiydgefBaI+JgQJ24q/aoNK/K1SdDJY16ImOoeujYpJuEDQBX0IE/lyu3xBog7Vk+d8Avns/owCwaTfAkIoT0LR+mINg5UPA7C/xTL+PODWJX9t1xTzD/li/GocuU/lfyEmmlSlRZrI2lw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(2906002)(5660300002)(64756008)(8676002)(4326008)(66556008)(8936002)(316002)(6916009)(76116006)(66446008)(66476007)(66946007)(86362001)(33656002)(54906003)(6486002)(478600001)(122000001)(38100700002)(71200400001)(91956017)(53546011)(6512007)(6506007)(36756003)(38070700009)(2616005)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RlFYcFBFSzE5WTJPVGtnbUlqNnYwa2NVajJaT3huVExnU3lCU1hHSFpwMGZi?=
 =?utf-8?B?RHdZdlRUUUhrRTZ4bDdOcVJXMGtLZTJ3bzRpREE0d1lqWENwMnlLU1pEVmRZ?=
 =?utf-8?B?UzZiKzFSOStLcmUrTGlmYXYyU2IrWFhyYS9jVDRPUVhQOTUrRDBHaXFOcktl?=
 =?utf-8?B?UXZPeUoyMmNhekFZUmZoTEN6SFpCMlo2WTh2U2hCYlVOR04zNDY0Q3htOW55?=
 =?utf-8?B?SFM0YTNKd2xrYU1rSVhzU25Dc2VSTUc2K2ljbHE1amR3ai9ydCt5WHQ5ajJp?=
 =?utf-8?B?Ujl3UUZ2Rzk1eTVINlVxMXBwalZkOFAzTjMzU3Vnc0JWdmRVbHVsY2IrdkVi?=
 =?utf-8?B?Y3JIUTBBV2tQRVdKSEltaGJqT2Q5cEJwVCtEUXd4QUYvUVJoajROYlRoODc4?=
 =?utf-8?B?M2lDaExMWEp4d1RPdWpaY0JOSDB6WEV2ajlKbmFjMXgrcm5pdlMrWWVmZ2kw?=
 =?utf-8?B?aHBCNk8xbzFQSVhFSFVSaHluVFV3aWI1Y2lzNFJVWWlOeEZEdXFKMWxuYSs0?=
 =?utf-8?B?NUUrUDByd2svT3U0d0N3bFl2QXM4cW1XbWtxSDBNbmEyOUt2R1ZDTTNRMTZ0?=
 =?utf-8?B?NkMwSWh1ZE9aZWZPT0FvR2hMODJnNFFlRUdLVWM3aVVEa3VVcVE4ZFJTc1lX?=
 =?utf-8?B?ZjFoQVRuY3gzZ01aNStQaFk1TUNFb3pPV1FqMlF5RUJUZ3Z2Y1pYL3pSL0Fy?=
 =?utf-8?B?TzB0ZDhQZDVGejZ1WlFPWkVmTmsyajY4QlE5NUhmcFJkR1Y5dWhjc2xTY3R3?=
 =?utf-8?B?MEJ1NlN0a1dBK245UjFaeXUrZXgwMHlkZGh0WGxMUnVYZC9WMk1qQ2REaFJY?=
 =?utf-8?B?cjRTaGg2WFVnU1FNMEVxODVxZWsxZWFwbC8xMHk4dWFXR05UdGV0Snl4Nzdh?=
 =?utf-8?B?V3VheWdyNGx5U05rejA1WEVwZzU4dkthSUR1T0lyMEFFMERWbFZDbmNYQ1dZ?=
 =?utf-8?B?bU9SWHY1QXBydWM3YjRSMWtUQWdUb1JCYmhFVVdILzRyenFEcnYrd05JOEVZ?=
 =?utf-8?B?dnhoNFRtVGJIU2VlcjBqbXVVVDRmT0VSdFRYdEdPdTljRHBsbURMQ25NQlhz?=
 =?utf-8?B?dEpOUEFkSDIzMlhlVjhJRWk5ZEdTQ3dVNCtRTXNKdWhPaXFIYXpUUVJYc1Jv?=
 =?utf-8?B?TkExMzZxNW9IbDgxUjNzOTVySnJ2K2w5RFZMb1FiYnd3bm1hYkFRVW1rTU5k?=
 =?utf-8?B?QWtIT0Y5UnF0MXlNZy9Pa1U5K1JhODc1MjhaZThzL0UydS9QWkw2ZWVRaGsv?=
 =?utf-8?B?aitpei9QT2lEcUJyMnhwQ1R2KzN5VUZqTy9VZlRMUEE3VDVDdWNwSVZsRHB3?=
 =?utf-8?B?SFRDN3c0WDJJTUU4RG9UTnRtU0lYSk50U1RpTGNvZUZZTHBFTGsxR0VJd0pU?=
 =?utf-8?B?Q0c2QVdScWJpU2NKeTdwT1RSNm1yY201ZjhFWWxVSUxkMDVEMXl0R1FjbU9l?=
 =?utf-8?B?UU9Sbm9oVWRVM0xXUGkrUjUvYzd5ZTM2Slc4RVFqTFB1bCtrOTlYc2NPTXdy?=
 =?utf-8?B?bjZVT0Qwc3Y1NE1FVlhnOUVnTzJidVZyZkdXcGpkeWdKN0hJd2ExQ1g1dkVt?=
 =?utf-8?B?NDljTys2NWZlSHRSeHdtMmRZNXlMUzd6cEFRWmhpcWV3NmM2bGQvWUlBcFNG?=
 =?utf-8?B?THZjMHlGS0wxRnowdy85VnF3Q1V0cTI0U3l2c09XSUh2OGFJcTY5dkNQWEsv?=
 =?utf-8?B?ZFhGcVd6RjVtbEdGd1dmNDdtQm9UQWl0T1dWQU1uczF1Y0lHU0g5NHlpVlov?=
 =?utf-8?B?SXVIZjZwTDBHUlpqTko3bWlidHNPM0FKd3Zxd0tpNmRWTkRCbTNiWVc5anZm?=
 =?utf-8?B?Z1NueGpiMTdjbCtTWFNscXNaTHFJcUVrR3FidzdOTnBQTXI2NXAzajhBU0RP?=
 =?utf-8?B?eUFFQTE0QkNsblRSVzJqejdBcTZVZnlBL0dRZGxmUDk3VkxUdVA0SFhuMDBw?=
 =?utf-8?B?UjIwS3hDU2RGWk5QL2ZCYVpRTGpqVUpvODM3MTBCeXdYN3k5ZVoxdEM0RXRD?=
 =?utf-8?B?STZ3NFJwS1hhUmZWUWVFNWZCWk9tV3JabWNWNmJJSUNKaTBobHVaaXpuS2xD?=
 =?utf-8?B?SXowdzBHbTZKMFdiTDhnc1VnWHZzV3hJK2haUHVzaDFhSWtOczlRcUduNnZT?=
 =?utf-8?B?VE5STmVid25uamdkaWZJcytKWUloNlIyYmhVeGVjQU43WVVTU0RVd0FoZ3BL?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D04E9A8F388E044B5D22260C775EBE6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	D6fyeP7DvCdLidT2HxKP4Y46MKFpKJ62uM4c7tf4bDDt8yEteBmeUAFK/qnMmD/HcnuFRL2ROkt4Gs7ZAjyk5nz8bNPDURg3wsdq2CjLDfUX1853FHXrym3Z+WssMJrCZhaSpCUKR8An4CHJhsa9dHbX8bnAb7uGtW8+f+k2Z25qPrm5a7FnPCtAhRtpXz8To5rulz7agcoXkiNL1P0HMDG5UosBSu9o9ZnQW74E6TzY/k1FFA0TVCEH8WZvQ63nNB/I8hiXCYkDN/V4lXw6/BLKGWJbe6iOfYUvVSLtzHrWKborzj0clSWFvjWOgNrE3wbyYRqA2hWrePu9QgEwDmF7IBPtsNSiOCvenA9k1w610dYxzXXBBNBKP3QDE65asJdARJk9S2BwiA6RSx9olYYXgknS+c/xI4C7dZPZ2HRXe7+Rg4Z+xxnBaEQG6YdhzDk4J2rdDwh6AUKPWPG5AliVaN0rlZeDYMZG4283hVYIhtRoI6fCBDhz94nTUrHh0PB8LSBMJXdKEQRZWYL4dI/JIehnmNqGEnJz0Ii7wROWg5fLR8H6LKd3lQr0NZf4/G9LGEFYzNsqSy9Vn2qt9clQ3VrN0F456K/3wlbEDSeCO4x9W/KSl1LNT+ZWwDQwpCbk8rm1B0vA+8dj3hDCThdIT8YeRt8g8vyG5oAWI7UT7CkuCWg3a7fGAUv9hCxPbVAHOekNnNd/OUqJMDJ+URgF2xhYPSk/YbLQJJyAYe5vCOEmtkzCCIxHwCO3SbjTAC6Gi5BTlqf5VKP6kqjd0LF+YrWK2C3A5ckrHSV5HuveKU6+MC6SPd2p3K49Z2mf/cD9aROciL7SBJBTQy2IAcN16VJXsweaRQ2Bot7JVZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89be3dee-80f1-4e97-09bf-08dbeb67b8df
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 14:31:31.8767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KnyzycYd1tja+vtWO4pzPHaEFDo+0O+ZOOc9BkDUL2A4UVqgDr1TOCl0IXa/fVHTb9kViPBI1HVN4yTijFPd0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_10,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220103
X-Proofpoint-GUID: 0BrDBnqZrad-QOni2-dnlr8NHJwZc2qT
X-Proofpoint-ORIG-GUID: 0BrDBnqZrad-QOni2-dnlr8NHJwZc2qT

UG9zc2libHkgYmVjYXVzZSBhdXRoZ3NzX2NyZWF0ZV9kZWZhdWx0KCkgd2FzIHRoZSBBUEkNCmF2
YWlsYWJsZSB0byBnc3NkIGJhY2sgaW4gdGhlIGRheS4gcnBjX2dzc19zZWNjcmVhdGUoM3QpDQpp
cyBuZXdlci4gVGhhdCB3b3VsZCBiZSBteSBndWVzcy4NCg0KDQo+IE9uIE5vdiAyMiwgMjAyMywg
YXQgMTowN+KAr0FNLCBPbGdhIEtvcm5pZXZza2FpYSA8YWdsb0B1bWljaC5lZHU+IHdyb3RlOg0K
PiANCj4gSGkgQ2h1Y2ssDQo+IA0KPiBBIHF1aWNrIHJlcGx5IGFzIEknbSBvbiB2YWNhdGlvbiBi
dXQgSSBjYW4gdGFrZSBhIGxvb2sgd2hlbiBJIGdldA0KPiBiYWNrLiBJJ20ganVzdCB0aGlua2lu
ZyB0aGVyZSBtdXN0IGJlIGEgcmVhc29uIHdoeSBnc3NkIGlzIHVzaW5nIHRoZQ0KPiBhdXRoZ3Nz
IGFwaSBhbmQgbm90IGNhbGxpbmcgdGhlIHJwY19nc3Mgb25lLg0KPiANCj4gT24gVHVlLCBOb3Yg
MjEsIDIwMjMgYXQgNjo1OeKAr0FNIENodWNrIExldmVyIElJSSA8Y2h1Y2subGV2ZXJAb3JhY2xl
LmNvbT4gd3JvdGU6DQo+PiANCj4+IEhleSBPbGdhLQ0KPj4gDQo+PiBJIHNlZSB0aGF0IGY1YjZl
NmZkYjFlNiAoImdzcy1hcGk6IGV4cG9zZSBnc3MgbWFqb3IvbWlub3IgZXJyb3IgaW4NCj4+IGF1
dGhnc3NfcmVmcmVzaCgpIikgYWRkZWQgYSBjb3VwbGUgb2YgZmllbGRzIGluIHN0cnVjdHVyZSBy
cGNfZ3NzX3NlYy4NCj4+IExhdGVyLCB0aGVyZSBhcmUgc29tZSBuZnMtdXRpbHMgY2hhbmdlcyB0
aGF0IHN0YXJ0IHVzaW5nIHRob3NlIGZpZWxkcy4NCj4+IA0KPj4gVGhhdCBicmVha3MgYnVpbGRp
bmcgdGhlIGxhdGVzdCB1cHN0cmVhbSBuZnMtdXRpbHMgb24gRmVkb3JhIDM4LCB3aG9zZQ0KPj4g
Y3VycmVudCBsaWJ0aXJwYyBkb2Vzbid0IGhhdmUgdGhvc2UgbmV3IGZpZWxkcy4NCj4+IA0KPj4g
SU1PIHN0cnVjdCBycGNfZ3NzX3NlYyBpcyBwYXJ0IG9mIHRoZSBsaWJ0aXJwYyBBUEkvQUJJLCB0
aHVzIHdlIHJlYWxseQ0KPj4gc2hvdWxkbid0IGNoYW5nZSBpdC4NCj4+IA0KPj4gSW5zdGVhZCwg
aWYgZ3NzZCBuZWVkcyBHU1Mgc3RhdHVzIGNvZGVzLCBjYW4ndCBpdCBjYWxsDQo+PiBycGNfZ3Nz
X3NlY2NyZWF0ZSgzKSwgd2hpY2ggZXhwbGljaXRseSB0YWtlcyBhIHN0cnVjdA0KPj4gcnBjX2dz
c19vcHRpb25zX3JldF90ICogYXJndW1lbnQ/DQo+PiANCj4+IGllLCBqdXN0IHJlcGxhY2UgdGhl
IGF1dGhnc3NfY3JlYXRlX2RlZmF1bHQoKSBjYWxsIHdpdGggYSBjYWxsIHRvDQo+PiBycGNfZ3Nz
X3NlY2NyZWF0ZSgzKSAuLi4uDQo+PiANCj4+IA0KPj4gLS0NCj4+IENodWNrIExldmVyDQo+PiAN
Cj4+IA0KPj4gDQoNCi0tDQpDaHVjayBMZXZlcg0KDQoNCg==

