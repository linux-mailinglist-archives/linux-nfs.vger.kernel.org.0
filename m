Return-Path: <linux-nfs+bounces-152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0E57FC911
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 23:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E2D2828AE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Nov 2023 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5349481AD;
	Tue, 28 Nov 2023 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JizpyVp9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jEZsSDkA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3444B1A3;
	Tue, 28 Nov 2023 14:07:18 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASI14xO020426;
	Tue, 28 Nov 2023 22:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NT9BBGmNS4ksvGUtTpX4Bp6FosHN8JVkeJnqoPpRVmU=;
 b=JizpyVp9T94txRCvqJLsZDKZKp52OFTg93ZcH6dK7beEezkDmkRaAaFu/+HBEJykIvMh
 5j3e4hmULmbDCclR2GhjiQi7IX5hsoc6P/QrsjbZuDviutJHRdfpQJcz79mgHhGB8tr+
 og8qYTu2RuUsNGsd+AyW+tefkojpZb7IzH30KjSKPuUuig0w4nmxMtKFIfLV00zcBFi9
 FYkk2K9chkdEwtAAlanWM4BwEIDZ0Q/OL77iuhp+HLviHNqBFUk/RAOyCDKOGiq6BS5w
 VldxgtiaEl+dztPdowyEyoitztDrLQdQhX60TNIMNRLrgMJnzmWy4NObQDJbBh6ZtnuO +A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3un1rxk296-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 22:07:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASLlaKG012742;
	Tue, 28 Nov 2023 22:07:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cdccrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Nov 2023 22:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIphdMraTH8IRhJlDWL2IoUr28DcYf5yaIfRCL7h8uxfKuqy3awdAek1kxNF9AH1Z0X17e/jhsQB843/LiQ94bggcpw6xN09znkaGRknVMtfyYDOGxS8GEypvDta4iuzp5zkI8FSqI3QnAYgoqjPNz+hDOg5jPycN/hhi/F9EwOqI6R6DB5zxeuChOFilB9A0wnY0xRlf+Em6eetMR4Gk9N1ch98Ly00uOiYuZKWFOA1pRC99d3ZgPpNAPw2zw0nylAKBpj4ih0dIv9nbm5KRQ9NkXwq319+sN2bxj9+2zh//d2EIguxwLvxwN4sU1Th2dLcQd7MidZLc88YB/FKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT9BBGmNS4ksvGUtTpX4Bp6FosHN8JVkeJnqoPpRVmU=;
 b=ZHwILAKppbJz35dk4/zSF7jqrwbwDx4sxUTumALscMH2hhZCZRBNq9o7Cnjp76k/p3OsYe2YUK5mnKVvknebQoqy34p0MqeLS3axMVCsgsiSvAdVO+nm6045DB5u6A/mwnnSkfWr7asTRgOe8aQtlkg1w6EaYmbWqqBBpmkA9/+20zfjoWLXQrDe/NpU97knI3foCaK7IML+AHcQSgI6ctEjGk65EjUWvCGDGyKS6wJP3KZatvxZolKdXPB1lA6ugm0cWL2HGrggzzFhx+KCn5Vsctlku4Wl4bwp4rPvKLycn1Vse1CGTJKSJb94fT+Qpjq8yP5+ggQuMor+RGs9GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT9BBGmNS4ksvGUtTpX4Bp6FosHN8JVkeJnqoPpRVmU=;
 b=jEZsSDkAfhKAzU7ZKcTf8UYo2GmV4mdPNagT7w1rpP0DKEbf+mQCwb32bxuPwxzcRqeJiIcp0iIF7tpFFDX4MeYQUlXzIKLdssRan/AMkspBSohVjJCRB2Q25AKUHnVTNZ/zFWZ8gJtPWGDxXgF11g7uGCBeey2D8GC5PbIJpiA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7163.namprd10.prod.outlook.com (2603:10b6:610:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 22:07:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 22:07:11 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Chuck Lever <cel@kernel.org>
CC: linux-stable <stable@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] nfsd fixes for 6.5.y
Thread-Topic: [PATCH 0/8] nfsd fixes for 6.5.y
Thread-Index: AQHaIkYyL/0SS5hNA0elwk6nU8iyCbCQSeCA
Date: Tue, 28 Nov 2023 22:07:11 +0000
Message-ID: <3C2A1F40-C0F3-412E-87ED-66AC1A2CA0F4@oracle.com>
References: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
In-Reply-To: 
 <170120874713.1515.13712791731008720729.stgit@klimt.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB7163:EE_
x-ms-office365-filtering-correlation-id: 4b15c189-f78f-49a1-118e-08dbf05e5ef9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 vAmCBqTlyC1NRlMBJjK4sofJasa39C0j1e3Lw+JZwK8ug7dkfy/079XpTK85bB4p5KMR6lDIojVbkSjTGQuMXAfTtGqOr1kYtTU17sS1RwZPIKadA9RgMZl2x7ifO2Q8Dr2nq3aMQIsUcmYAbOnXpon6zFV+q97h1C7Jp9wg7CvyCJAHDuSjJfxNquZvp3HKSrm+KYxS8MGKoracRRsctRiTcgTE7I+LrX/6Q6z3zTQQpich23jFX4C+zKaO6srNlcn6psjtw5BT3qbkO61GSDPs+e7wGQNwRmhq/SL2k7pExepVXHu5lV7xQYoJW3dh8Oh/OOfHcYqxzrKSeQbDv+nItzoYi0zV9jntbQjnAKWb61bUEOfEWWlGjD0SnHeBHL7kp6tMwvf6vPUYaya1FUP86uqfAxS+NCNwyrJggA3Lnr5D5sql2lvUK6Dab4sJqW6x5S+BCl9WkBg0+bcHCFbVaphupfJsE0u1g7n/j3V8UXpbpal9jubdLY9IO7XHi+ti4R/d0saH8pE7TDTsi3RyBs/nz6qiz5C/HmqLVcbC/QpjjQWG9gTI2Bjrd3WGNHozcQvWGjSSrH1HztFF6WFimjUz/Yr3TKy31LUbPYsiPzJc8NHqvkyVu5w4aisaUvYbZgVeDhk6mRPPauSPQg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(36756003)(86362001)(38070700009)(122000001)(33656002)(83380400001)(5660300002)(26005)(2906002)(2616005)(6512007)(53546011)(6506007)(8676002)(4326008)(71200400001)(8936002)(6486002)(478600001)(54906003)(66946007)(76116006)(64756008)(66556008)(91956017)(66476007)(66446008)(316002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eXJiWjRiUFRERTRFdUkyTmphRldYUGtnQ3gzNjVPSklxSlR0UnRIODVpbXF5?=
 =?utf-8?B?UGhxUU5DRGh0NjdqMTRobFhEUXBpdFdVY2V2Z1h0ZkNuV1Fyb0kwZktzWDN6?=
 =?utf-8?B?T1hJbnM4UXdINkhVRmRQa1p6Z25QVm51Tm4vSmhBUlo5R2ROKzBsZjBCcmIz?=
 =?utf-8?B?ZXFUdjIza1pzNmN4a29hdkVVL1FYcHZtMjF5U2UxQWh2R3FpY1RXOGt6VEJI?=
 =?utf-8?B?bUp5b2NxZHJUR0V6NmErMzZ5VmhLTUlVVlJCR0tDbnVrZWZZdjRHTGJQNmYr?=
 =?utf-8?B?M0VrdzFDVTlJc09tVk5OdXFzUjMrN0JVOENESFZjNzNBVlkyOU1Mckk3WXRJ?=
 =?utf-8?B?clRLYlRjMzRCK2xGRzZxbDRYK2ZSbEJaNWJDUGQxeVNYQWRWUHJjKzZzTm1j?=
 =?utf-8?B?K0U1enFCYlRaalUyTFJyRVpoQjhrcG5TQW1qc2paVlJ5eHpTQVJRWllmOEQz?=
 =?utf-8?B?ZEY3dlVUUExCcVNEZTFlU053cmtwWlNsbHdla1BMZElJSG15QW5NV1BkTmUr?=
 =?utf-8?B?SmRWVW9sU0ZyUFRvM3FQMnRlb3BteDdNZWljdFc5NHNZRVhwSmRJZDkrY1NL?=
 =?utf-8?B?SWdoVTlUVUFXWGdXT2hhbTd1eFEyODJKdFZieUZLTnpSTjkxTU4wMzNlZWFY?=
 =?utf-8?B?SW5NaEt4cmVJb09ZMHRjR2kvSGc0TTRVQVAxZzhWYjQraTF1TzNpQ1pTenBt?=
 =?utf-8?B?cU9pZ1BZWk5kTkZmTTkxUG9qL1kvZy9CWlI2SEdJcUlBTHo1ZlRCbXNSOTVn?=
 =?utf-8?B?RFAxYk5lcUx0YWRKVDJiSXlJZHhPM1k1ek1saktUdC84R0o3VlZWTkdNZU9n?=
 =?utf-8?B?U21lL0xFbTNoQVlCNUFRQzMyVHB1ZmtXNVZTdmMzNDNPOUNPTDQ1Sm5RQ1dM?=
 =?utf-8?B?cUthMGdWY0tDbGYxZVY0NndiNE83SjdOSHZxR0d2NUNRVzlBbVNWVkRJb1pC?=
 =?utf-8?B?enFZamdmWjBNRDZjakJPblFLTnc3QTBGRkdmWGZTSlRqakl1WGpyZCtITW5J?=
 =?utf-8?B?MmZRMk9TOFpEWVF2eEJER1A3bGx1ZE9BK0krR2IwSExsZXQ5MmFpNWFKcTFy?=
 =?utf-8?B?T0dzSC9BSytqZzhPSkw1SVQrckl6amo2SWJQK1pNZlNiSksrU2MzTkJBZ1Jy?=
 =?utf-8?B?aTdjVXpXWWdlNStuZlZ6T2I0LzMydERJVUw5dW9wM3JHdThQL21QMlBVRHda?=
 =?utf-8?B?OVBqVzNTSWJJNmtXbXZ1dEdpYUg1OE9wa3dWMWc2ZzBtUEhHVkwrM09BZ0RW?=
 =?utf-8?B?aUd2eHFYdlo1bGNkSHhsVlQ4UWkyZVNOOUkrL2dwaDBOTy9EcnE5TGFBbTlR?=
 =?utf-8?B?azRhdWdrRGdjK1F5YlVWclo2NG81ZWtsd2NSVHdxQXUxTTc0WWUvcTNHL2s3?=
 =?utf-8?B?L3o2TmUyaHVSUjNlSjlod3NmdkRXM1dYbzBtdTRuQ0NKOTJrSmJCRVpDL2pm?=
 =?utf-8?B?L2ZQazJEMUpSMDFaMWhqbUdKVW1sUk5tMFl0SVQxRXV0bERwVzRyMEFZUlgx?=
 =?utf-8?B?YXpSS0VOTDVGWW43VGRmTC96dmlUZG5XdkpCdTNVRnIvemloUy84WTJPT3F4?=
 =?utf-8?B?NFNMS1BXTkViclR3Y3hKNUduS2NaSHUwUTR3VEdaOW1zRFFWZ3J0d0pYd3Bp?=
 =?utf-8?B?T2w2eXJ2aGorVkFWVlB2YUFEcHp4NDR4d1JjNktGVlYxd0VicFJKR3VGTEpi?=
 =?utf-8?B?ZmJENGZHaHJyZVBzVmNucUtBQjEvRW1WQzFORi92Rm85bVRhaDlwSm9zN0Iz?=
 =?utf-8?B?K0RUMkdEVkpTVHR0VjNoYXRCOHBGVE9wTFB2dk84M3N5bys2K3RrKzQvRGdC?=
 =?utf-8?B?b2FkSWlWejlJcjBWN0Jkc0J3b1NzeFBTSlpBVTdqcEZ6NzBhNUQzWklBWTFI?=
 =?utf-8?B?bnJFZ2ZFdWVsWjByd1ExdzI2NlJVaktFK0NZRzJ2L25CK0NhUUxsdnZyT0tj?=
 =?utf-8?B?Nk5vWmRIMDBKKzBmTGRQWlExU0pHYzJ1Zk5UTFhKVTZNTzc2S1RmL25KcDBw?=
 =?utf-8?B?dGo0SkxxRjJaMldPWlFmMG5QSFB4Z21YSzJOeGZyaStlak5Bd0xkR3Y2TGZp?=
 =?utf-8?B?Qk9aamo4TEorZDIrN2Vyb016QVNmRHJyV3hwbkhFcEVJS1VlNlFqSTBJSkpi?=
 =?utf-8?B?TjNhaHBWYUlZckdRQnp4WlVEdTdxMjhZUFJTOW13RERPcDZLSHhuSmRSNVRo?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <194E68389C4D8947B551E2FB6B5B6FF5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tYZ6MMr3hvYgPchHUAH5LBFLy3/zj6q7i/7MDgV+KgOboKIC6LCi5J8N/b7l9mN/Qvds08nXUu/cnfbCgzlo/A3TM3Gn1+RydVXYezgCfVQ8+HPf5k0BMpijzuEabnqBdyxJAJop7tAuJgyGV+GT6FK8TjqllSYrgael12cEIo2z7xtCgza+e3Hwh+K4kbOmGBCMhUCKXFjCD4Fzt74214AnRNvuLIuG2+LllIc18joMCZIacoFydkGZqeb0jo2l3Fj+CpLBJHlcXhGIO1Xhw7KAXiCkN/EzNzqaXT9vO0ysy+f43BdyKX53MqK0ArQNYBK52GzrSCA4PevEMYQrtXpQp8asjt7DJxDC4P1OmP1uyQuJN9FQ3m7uUnigRMQq5zGu9URKfbyWHzeiIPOHrkm/Qhkhxv2wzPgfXtRTXBR7fj+kn2bO0ZyZ4d44+z/pOaR9QT1kOMd9tS3tuIKqdI1Yv8Vc3sQljoXo8V2c/fBqDw35Pqk0+t62+v8KiH6ZemMq6dIQbJVMqYzlTSamh/gwvkugzdwy8N90RNIT+kBVm2m3yegx2mDbd4vFAOUmLVmwOYLTTGoGcDjfHf41bIqxTiu4FH6GTvTf+4I1ovBFBS1zXQGJ7KLsOYPRi109SMQQXVTqg9fwxlb90SKM8dr0iQSzab2dKrDx2K3hC0iKpMguy+/41CgC0IV6tfhddcPOKFFctm7lgyITc/sl8sEyZZNUsHMMlIQqk9D/DIMQTH93OcfCjZA5k/hQ6cVE4hc2gQkWSpqH3u+9tH1q1TuStvAy3hW7nPbzGo6l248=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b15c189-f78f-49a1-118e-08dbf05e5ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 22:07:11.3912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfOMkuda86BAnDuo/pkza+6IhHyseH7dqcq2+DcAsIbG0D54K6/yRGWd7DkBdsu8vrKUim1xKXMgkN6ko5MhJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7163
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=699
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311280175
X-Proofpoint-GUID: rhsquy1I3fI0eZgj35ZLiCQq-Yt0pjPi
X-Proofpoint-ORIG-GUID: rhsquy1I3fI0eZgj35ZLiCQq-Yt0pjPi

DQoNCj4gT24gTm92IDI4LCAyMDIzLCBhdCA0OjU54oCvUE0sIENodWNrIExldmVyIDxjZWxAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBCYWNrcG9ydCBvZiB1cHN0cmVhbSBmaXhlcyB0byBORlNE
J3MgZHVwbGljYXRlIHJlcGx5IGNhY2hlLiBUaGVzZSANCj4gaGF2ZSBiZWVuIGhhbmQtYXBwbGll
ZCBhbmQgdGVzdGVkIHdpdGggdGhlIHNhbWUgcmVwcm9kdWNlciBhcyB3YXMgDQo+IHVzZWQgdG8g
Y3JlYXRlIHRoZSB1cHN0cmVhbSBmaXhlcy4NCg0KQWZ0ZXIgYXBwbHlpbmcgcGF0Y2hlcyAxIHRo
cm91Z2ggNiBjbGVhbmx5LCB0aGVzZSBhcHBsaWVkIHdpdGggZnV6eg0KYW5kIG9mZnNldCBidXQg
bm8gcmVqZWN0aW9uIC0tIHRoZSBzYW1lIGFzIHRoZSA2LjYueSBwYXRjaCBzZXQuDQpUaGUgY29u
dGV4dCBjaGFuZ2VzIHdlcmUgZHVlIHRvIExvcmVuem8ncyBuZXcgbmZzZCBuZXRsaW5rIHByb3Rv
Y29sLg0KDQoNCj4gLS0tDQo+IA0KPiBDaHVjayBMZXZlciAoOCk6DQo+ICAgICAgTkZTRDogUmVm
YWN0b3IgbmZzZF9yZXBseV9jYWNoZV9mcmVlX2xvY2tlZCgpDQo+ICAgICAgTkZTRDogUmVuYW1l
IG5mc2RfcmVwbHlfY2FjaGVfYWxsb2MoKQ0KPiAgICAgIE5GU0Q6IFJlcGxhY2UgbmZzZF9wcnVu
ZV9idWNrZXQoKQ0KPiAgICAgIE5GU0Q6IFJlZmFjdG9yIHRoZSBkdXBsaWNhdGUgcmVwbHkgY2Fj
aGUgc2hyaW5rZXINCj4gICAgICBORlNEOiBSZW1vdmUgc3ZjX3Jxc3Q6OnJxX2NhY2hlcmVwDQo+
ICAgICAgTkZTRDogUmVuYW1lIHN0cnVjdCBzdmNfY2FjaGVyZXANCj4gICAgICBORlNEOiBGaXgg
InN0YXJ0IG9mIE5GUyByZXBseSIgcG9pbnRlciBwYXNzZWQgdG8gbmZzZF9jYWNoZV91cGRhdGUo
KQ0KPiAgICAgIE5GU0Q6IEZpeCBjaGVja3N1bSBtaXNtYXRjaGVzIGluIHRoZSBkdXBsaWNhdGUg
cmVwbHkgY2FjaGUNCj4gDQo+IA0KPiBmcy9uZnNkL2NhY2hlLmggICAgICAgICAgICB8ICAgOCAr
LQ0KPiBmcy9uZnNkL25mc2NhY2hlLmMgICAgICAgICB8IDI2NiArKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tDQo+IGZzL25mc2QvbmZzc3ZjLmMgICAgICAgICAgIHwgIDIwICsr
LQ0KPiBmcy9uZnNkL3RyYWNlLmggICAgICAgICAgICB8ICAyNiArKystDQo+IGluY2x1ZGUvbGlu
dXgvc3VucnBjL3N2Yy5oIHwgICAxIC0NCj4gNSBmaWxlcyBjaGFuZ2VkLCAyMTggaW5zZXJ0aW9u
cygrKSwgMTAzIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gQ2h1Y2sgTGV2ZXINCj4gDQo+IA0K
DQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

