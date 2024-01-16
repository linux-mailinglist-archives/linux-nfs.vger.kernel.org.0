Return-Path: <linux-nfs+bounces-1131-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2CC82F0A1
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 15:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97B78B229B3
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jan 2024 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419F1B941;
	Tue, 16 Jan 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hitachivantara.com header.i=@hitachivantara.com header.b="QfJCDdO/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB613AF3
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jan 2024 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachivantara.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hitachivantara.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z91Qt//Cv8lF/22BxBENlN+w7+Od7aCSYDw4yuFV2bBQvBX1FFggYgAYq09HntXIqRHHqMn2HPQgBEVcTLeCqMAd0hq03bVaHdtA49E+mtG2LYH9VDcZRY6SPsqzyekLlNjrVqpW4MyB9T7JmwFpEvEqPC5CpPCcwBdzRoIkelQm9/ZxZxsU4Dz9uffN9feKp5+onlL2joWUaVCwM+YlV893M8BWzYqScaLrrTsjD9lnG8xXMB+jh5ztANonc75QUN0P+Ct5eyDE7tThW2ttdCu68CF4dEGphUtzRZGmA9jMlsiGRIL1bvSZ958OUMxflpht5qTZBwh34Jb83iRTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5O6TfiLo0lTpwa+kdPYF5n6SgoAqyi4BxCiYCQP+JA=;
 b=Kluc3RkjPKbnTo42GGPF2Bh9dD9VzsWhyFlV1gVrz6JjCOlTt/fCLQL/aVwkvsDtBHGFfnrfZLnhaj6PwaVuv3L8zcHojyU6r4n8Ua3e2MhpsAbTb6IWiAwBpvOOMF62REWOMNCnN/Z+ynZqhO9LpM8CCZQz+6h9XB8jA5C1yCYWD4JdVBd9qgcT+yVdygnjZFeeDnxDlisAuAF2/uGJuzDZBdTQqSWoluNNALyeWwlyGpBBIXDSFgbSeTwIF8FN1XsL9BFE3goaf+E8Tzouf6RnwFNGXzKvymNIJhWSU51bo0ZcJGABcpvBHlhpeGzEekoVLmXPQu362ZuvEOlJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachivantara.com; dmarc=pass action=none
 header.from=hitachivantara.com; dkim=pass header.d=hitachivantara.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachivantara.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5O6TfiLo0lTpwa+kdPYF5n6SgoAqyi4BxCiYCQP+JA=;
 b=QfJCDdO/nDkaxNXySEXNEyuPAuQCk/kRpiHyerZJViqPV8Xm9ivb7FxLwbqLhMASNB5fScAH/9eLIRx8hlZhSkBpmX1wMF305mMLecrBZvlnUtuBcANNkQjqPKnfwK5qYyT1GHCN10G3QbJI28mZbedKkQ8tIUoNgyjODQFu1fWMAK9vqB5qeL5rwrAzJrmT92LIWMxXIeak3SwbUnuhZiNrElXZxsLl2AeZjN2cHdf6CZTgnK9vL171LZjAAtdNlkTF8Z0Dg4YskW0ZgrXV3YeFjBulkPI1kv+5hTVG1SyL0/i+9kR17ZrPqOje1PgAEioSPidZqL/EDxWortM+fQ==
Received: from DM8PR08MB7288.namprd08.prod.outlook.com (2603:10b6:8:23::13) by
 CH0PR08MB6892.namprd08.prod.outlook.com (2603:10b6:610:dc::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.17; Tue, 16 Jan 2024 14:39:22 +0000
Received: from DM8PR08MB7288.namprd08.prod.outlook.com
 ([fe80::2b41:a5f5:7df0:1a60]) by DM8PR08MB7288.namprd08.prod.outlook.com
 ([fe80::2b41:a5f5:7df0:1a60%7]) with mapi id 15.20.7202.017; Tue, 16 Jan 2024
 14:39:22 +0000
From: Connor Smith <connor.smith@hitachivantara.com>
To: Chuck Lever III <chuck.lever@oracle.com>
CC: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: RE: Possible discrepancy in CREATE_SESSION slot number accounting
Thread-Topic: Possible discrepancy in CREATE_SESSION slot number accounting
Thread-Index: AdpIgOxAPAgULydbT7evjuyQgxyM6gABhbOAAABuq2A=
Date: Tue, 16 Jan 2024 14:39:22 +0000
Message-ID:
 <DM8PR08MB72883534799EB11902F01936E8732@DM8PR08MB7288.namprd08.prod.outlook.com>
References:
 <DM8PR08MB72883F3D2AF2A0638CD41356E8732@DM8PR08MB7288.namprd08.prod.outlook.com>
 <B23AEE8C-2C4C-4DD0-904C-7BCD927CC4E0@oracle.com>
In-Reply-To: <B23AEE8C-2C4C-4DD0-904C-7BCD927CC4E0@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachivantara.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR08MB7288:EE_|CH0PR08MB6892:EE_
x-ms-office365-filtering-correlation-id: d68b4807-72a9-42ec-703e-08dc16a0ee12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 y2g8FtI/tyaGJwHig6EpTKoUORLWOUEfRrDCdkswW8yiilx4FGIfbzXqekzMTQxeymVjghCbgi8jCUZoxf1ToAiApodAcJ7oNXPhJoBDnJ3+tlfEXpCN9vSKeuBSukMiNheFPnM4f1kTD0NEfbMDDY2n14S5Sb1oHxwoPsIZq9+gC4Ez/iHB3FIddUqbok4r7l6aRQ2j303+bcPV/lFam7ISPWDYWrLJsvwPDHKrdtBfNmG9h01XAYGTOxgRfFZhaph+BGhJi0p5S1ylPES3do96Cu6X8urWdzip/DHKYNq5MwCTc1D39u8ggIApTsqqd2wub9PHh6zS7WeunFqCC2vevu8//CbM9/RtbLbtJlwgDTtQFM/S+rHnMharR4ucZgJXXypNtgVgvcM8eCv6nm35ckQOfFfjI/TgFQroveorFBaAoTZ0smuEfJwB0zE5WcXL+20IHWmwEKI757dpjkHR6voGFOE/uaRFtBT5Gh08m8DuRMv5Hr1oByPf+5PmhSWRth+i9VoIt0gxBgrG6Pat+hsRtWWw+UTQ51NCaA20p3sQH3kDsl3sOalVhbr0vGaKp+7i4mdilXBtYjp9BQdDnCEf+F6F+Fjvaih0r6A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR08MB7288.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(7696005)(26005)(71200400001)(6506007)(9686003)(122000001)(5660300002)(44832011)(52536014)(4326008)(2906002)(8676002)(966005)(478600001)(76116006)(316002)(6916009)(66446008)(66556008)(66946007)(64756008)(66476007)(8936002)(41300700001)(82960400001)(86362001)(38100700002)(33656002)(558084003)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVJEQURaKytXVklzYUtseElaaWZqS1B2V0FlZEluVnVyTy94bkpSaVl6ek9w?=
 =?utf-8?B?YmRxeElKdFROMjF5TTZrTjNLWHJoZWF1RWJLdkhra29sT09UeVc5NUQyK2ox?=
 =?utf-8?B?NkRuRmlCM3ErdEIxNjNyZmZjbjJWRlZOd2VONnM4RFJ6eUdzUnR6MjhwWERN?=
 =?utf-8?B?Z1IrTHMzbmVyYlNKTVZiMzJEeGw0RlZ5d250NHl4T3RsTVQyc05QcVBEYktr?=
 =?utf-8?B?NDNuOWVhWFdPYmdtbmdsd2pOaTR6eGRQS2tWUGprUFBMaGkxeUlqc2hrbGpn?=
 =?utf-8?B?cmtlQkt3TFQzTStwZllVcHhBU0J4bW1uOHJLaU9yeEFyNk9Cb3NZaFljaDVp?=
 =?utf-8?B?aG9BUXUzaUtWSUxmNE53RW1qOGtwVHdmNk5KVjNFdC8zcG1BZ1NzbEVZSUlB?=
 =?utf-8?B?TnNkMXZHbjRIS2FjcnhhaHhrNHhyVmVSbVUyT0E1YmlQRTRmbHdvVUNrZjhI?=
 =?utf-8?B?UDBJOTlKWW5objRCWUlTUUVCOG5sZXFlUlROMWplTkZ2S3J3SWVJa1ByM0g3?=
 =?utf-8?B?VHNzUjRWMnN6L0VrVEdUdldKN3BYZmxkdFd2ZG9sSTB2amNjRWJWQmtSRTNH?=
 =?utf-8?B?Mkg4bG1YdXVjeTIydDkzOUVFZlZhSHBBQlBvWmdvYVZ0MHVNczNrK202amZq?=
 =?utf-8?B?dFQrSi93bC81S2JudCtJSWY5TlpKQ2E5bHdWU0Zwai9BalFuM2l1dTdpMVVh?=
 =?utf-8?B?bkVoRVEzTDhqcklzWVZKanhSUkIxODhYbFNxdEFVdUhTdkF6L1luK1VNSmZ4?=
 =?utf-8?B?b3dkdDRTckdPZURwb05jWEU1K2dsa3ZOK0dRTkdwMlNNYmpVZnY2cHptUUpj?=
 =?utf-8?B?YXdZR3NzR3pVb0xtUFl3b0RrSFhjS1E2Y2dSSjZpK0VReWcwUFZGRGNDM0V0?=
 =?utf-8?B?cGJqRXErc21wSEovWWxwd3VJWTFEb2IyZEh5bEJYTzAwd21oYTc0ODhCdFNy?=
 =?utf-8?B?WVVuRS9rNUo5ODkxbnJkVER1UE9abGl5N1FLZCtRdCt2bzJ2NTZDc1NxSFdH?=
 =?utf-8?B?WGlNbTlHQWJVd3F3SGtSLzRvY0plYzRldDdMVGpoc1YyWE80Mk9qUzJZRWJx?=
 =?utf-8?B?ZkoyVkRuM0hSZXc2MGNIV3k1QWlhbmpWMTdpRk9sb09jQlo5VFVnUDRCU0lY?=
 =?utf-8?B?VkdKMDV3UkkyMVlNQ3NWT04xNy9JeFlHNnNQZm5NTTdZcVd5azVuekR2cDdP?=
 =?utf-8?B?dXlrSk5jbmIrdCtTbXBNcWlscFduVTdPNzBUeG85REhOcEJvNDhURStXZ0k0?=
 =?utf-8?B?T2xRNUdCcldLZkl3dHVnOWJ4bVRnc1VENUk4eFQwbmZCbXpCRlYyU3VCY3Ji?=
 =?utf-8?B?MDJVcEpOSU9nV2lVV2hucCtjRVp5dStuSy9ueGJ0ZEZqLytsVkdZczVIL1lP?=
 =?utf-8?B?djZtUDNaT3RhYW1sV1BXWHRwTkdqSHplbmk2SXFnZkRsdFhUK3B1U0c3RjlH?=
 =?utf-8?B?YzZEL2hxZHNGU3ZXakVqQnRNMXNHSDQ4WFpoOHJBL0JZWHJLSDA5WEVyUFFz?=
 =?utf-8?B?VWtrOWJTd29RRHRhV09BZU56bDBoNVBTelJldjlDdjR2UHdUOWVxejJGcmcv?=
 =?utf-8?B?dVNxVGFEVGkwbThzL01CUVF2b0pqK1o5NkJ0VjdWSVErdzZ4WGtkazk4Sm1y?=
 =?utf-8?B?QlNnTHFkbXdqQUl6cE54bWNNWEhMN00yRW1sRmxtWmxROGZSUjBRdzRwbnd3?=
 =?utf-8?B?Q2hMR0tYNUpsUW55QWFnREEvalljQVFFS0NMeDZQWnFqSlNnUlJMV2FMRjlT?=
 =?utf-8?B?OTlHWCtIcENoWXFPN01VTmNrenZEa01qSGF3OGkyVzdBM0s3SVZUUHFORXpG?=
 =?utf-8?B?TURhMjMzK0xjOUtkcTk4ZnVDOEVJMmNaV2hXNWJyN3VscEsxcmsrQU84bkc2?=
 =?utf-8?B?Z2Voa0pJK3JtQnNOOFFuMGVOWGZuZ3FwbTNrN2ExS1dGTUpGVHRtK3BGc1Q1?=
 =?utf-8?B?dWNKUGNNTkhwZzlVdmgybWxCM3JoZFNuck80SXk3dXI5ZDZVR2NMeExDWWlV?=
 =?utf-8?B?TXlWZU05UlVBMUdyeTUvTmlsVWZ6YVFZV1ZlM0Y1OWh0b3VnMTRPZEpRZnBW?=
 =?utf-8?B?cm4yTjFXcDBCZ0FqU01FMG0xQVF6M2pveWc3dUtSZXNPNUQ4R2hpNURQaTdv?=
 =?utf-8?B?MTh6V1JhVkpsdzZnU010bUQwYm4xLzEwbzNFNC8wdW5yN2o3bzRZZzB3TUFo?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachivantara.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR08MB7288.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68b4807-72a9-42ec-703e-08dc16a0ee12
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 14:39:22.4278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18791e17-6159-4f52-a8d4-de814ca8284a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3kcHR9AYNuAFTie6Dr4jg5QzKA1YHF/43kvRdw0/oPT6uMVZpzXQpVo7rrfAcfcggN01UCDsKp52r/qlyDG8TBrnc8m5fk0CXrFYQIJj5yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR08MB6892

PiBPbiBmaXJzdCBibHVzaCwgeW91ciBpbnRlcnByZXRhdGlvbiBvZiBTMTguMzYuNCBsb29rcyBj
b3JyZWN0DQo+IHRvIG1lLiBXZSBuZWVkIHRvIHN0dWR5IHRoaXMgZnVydGhlciBhbmQgYWxzbyBs
b29rIGludG8gaG93DQo+IHB5bmZzIHRyZWF0cyBDUkVBVEVfU0VTU0lPTiByZXRyYW5zbWl0cy4g
UGxlYXNlIGZpbGUgYSBidWcNCj4gcmVwb3J0IGhlcmU6DQoNClRoYW5rcyBDaHVjayAtIEkndmUg
cmFpc2VkIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE4Mzgy
DQoNClRoYW5rcywNCkNvbm5vcg0K

