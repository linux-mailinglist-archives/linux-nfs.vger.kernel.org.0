Return-Path: <linux-nfs+bounces-1828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C283184D31A
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 21:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E756F1C241B3
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 20:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5E21D697;
	Wed,  7 Feb 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="Wt982vbU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2090.outbound.protection.outlook.com [40.107.95.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5941EB49
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338555; cv=fail; b=lNZj4RQwmtNf0Rxdp4DUwJHizXUYrtKGc+zkyloWTp39yxzQcdlvaNnKWVgyTxWxHD/5YUTpJs3LGfBNuDIXdQkG5OmjJ3sEFfwZHIVXiSR7+xzPVIESnjnF7yzXDHeWo0cOhWLW+znOjV82pqmOjYJ1SC1vRRFI+yr4QKACuxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338555; c=relaxed/simple;
	bh=zQVqJqBAwvGt+PxCKw9bpGvzxsuXtYlEXq4+LE4W9AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ii8E3pEm3M4GkuBEzS2ECoc3nWwLaMUR7sKi+wjmq2rxCFZtcu7NTQ4Pp50kwaXjZUsKq8OvfkZRvycad5RBsGyQKrir/K2LGH1ddVrCGGDUKkyNAF0cAdLMQGC9zsMPHl/suGwZ5nJ9otDLTydJS8f0JzHSPeXB9mmnpJolF0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=Wt982vbU; arc=fail smtp.client-ip=40.107.95.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMFHsUcdfE4hKDyHz++K0eO8qR4g0XpToe9cPqfStTlYle2g1IvLS4WbJDCjs8uCTplcU5dFevuSYdcfF0J4vy+/sO9fmVCTMDGW+LXa9ltpolf1PTdN8iJ4WHGdg0pM2O/mbIVNMA2imDPhpg3Opk3H34b/JhqayYviIRRcASBXhftCTot+/SXL85lVol1MuMQF2CifZzIrSOY2OjwLDngU97/E0Z63JVQYxeoCQvM+fLBPvabeEQK6XW9dB081qQYavnjxrq/cI2wO8bKObrmqvAZ+ulwQaAYGU/qYzil0ZX8T5AJZJV29AuGsEqsfkD/n828voogdeqHLYaVx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQVqJqBAwvGt+PxCKw9bpGvzxsuXtYlEXq4+LE4W9AA=;
 b=JS9SgNGdI5p4ClQj2nKYicHmKCOPb+jokfwFQNNsJ9ZxGCAsdeY7NGyyGXCAE6c3LZHdWY+eX8M4Yn2uFwuEwC7jhzil9+diLWSKe+Bgkhw96k0f/XDDJPDP5hI4jc8NX8Tpu/iVSrQuRTMR9W9FJinMirQm02lBkvt8Ujzmszj++v754zoRkb319ApwjecG33jew1W+fVfsm4l/wxJWzUSnHF8mAEkzH7aUg5ZYGS5clx09gpjdrR6N6HGCosdAInisKrS3+pqg6wZaoBE7sabFMLlO6tN1bldbAZVUPEKDyuqCfjdSnXCQaw5Vi8ATwpKLbSHr259wLuLpKGhvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQVqJqBAwvGt+PxCKw9bpGvzxsuXtYlEXq4+LE4W9AA=;
 b=Wt982vbULwM5TKbXt57DVTXRE1eulGwNe8shldrtJNRx4ieTbHXDmT1FTTbXnWL2oAMYhVC2/hG8dV5BTnzOY8FWzGsV/7naGJp4SU47h4Uo+6tWy5Twc2+dKrJls8puPDdNSDdDkRFHS9W42Rg8oIxgJDhdBtd7QRMoBOu/Qn0=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by PH0PR13MB5380.namprd13.prod.outlook.com (2603:10b6:510:fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Wed, 7 Feb
 2024 20:42:25 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 20:42:25 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs layout
Thread-Topic: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs
 layout
Thread-Index: AQHaWfOPdWZCWS05wUeJC6M2pFsKwLD/PyUAgAAK7ICAAAIoAIAADC4A
Date: Wed, 7 Feb 2024 20:42:25 +0000
Message-ID: <10ca1cfa1243a7b039502a5cc8253a56c2572408.camel@hammerspace.com>
References: <20240207182912.30981-1-olga.kornievskaia@gmail.com>
	 <be83ac24a9d17fc78590d4b182afd3f4e6c1e8a7.camel@hammerspace.com>
	 <CAN-5tyFTx4bUvuF627E_2x9Kw2h9tccqU-7KfCtJHyFazTTLYg@mail.gmail.com>
	 <CAN-5tyF2bqMy9y1rbeYbU5uakzg0AeiF7rEzH8M7S=kWyogY_w@mail.gmail.com>
In-Reply-To:
 <CAN-5tyF2bqMy9y1rbeYbU5uakzg0AeiF7rEzH8M7S=kWyogY_w@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|PH0PR13MB5380:EE_
x-ms-office365-filtering-correlation-id: 7aab0de9-9331-4cdc-869a-08dc281d4b00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JeKm239rDXgVG/LxW7NKM8aXSV6BDC9zVtK8WeXz/ouFoV/qxzjKdb6UCxxR9rY9RGteG0JA18EX73bfLVoIOwA+UcwQSA3jbUbcZO9uYtbcKW0DgahU7iFHNk1jyLXfi4yIpwUrupcWhb2rhtxLLijkHJ6xR7UszPgvDGMmpjsyXvCNBgiI3W/EBSIShH4PnH4YiSIFibHqeSx40m3BlsTMAWcFKuO/NbM/t24+OBZoDIGRgdVzvKUIzClKhdW4yqDlWGV3zTCODjkVv6KhBqMGhqm2EgT7x5TEW38ee4ce5LAmr0N6aBZtkr/VGzakFBH5WlfD+/5giA8hzBLUZg3hPTfvLJebhD/LAERADhdrXd/21lr9DLI4EVsrt4NsJ7utYfgJPCzClga8VAzi01J4P7dSTQoMTpduUuaGhGJx5aitN9vvx1YXT8Agz3lKNXmh0LHLtDez65slXcqwZFb/jgYef1fZzcii3Askwh1I/cFHHGyNcqG5oO1ePEcng9OVaB00aDj5iSUNkyZdy1Hgt0ZzcShNcdgCD2B8+2dyPXiMa0n5ycEFR/kPO7wM+hzph21o47TQ38VaQC18Kuw0RUGnmGyfVzW8twiaLJLRhlLI97mUiEPvytJSXYen
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(136003)(376002)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(86362001)(6916009)(66446008)(76116006)(66556008)(66476007)(66946007)(316002)(54906003)(64756008)(478600001)(6486002)(4326008)(8936002)(8676002)(2906002)(38100700002)(122000001)(6512007)(2616005)(53546011)(71200400001)(6506007)(83380400001)(38070700009)(36756003)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sks2Qi9xUFpnd1FhRFVuZVp6ZFRxbm1GcHNSMzlsU0RwMDQ0NDU3N3dlMm5U?=
 =?utf-8?B?TlkvNUU2MmNSdk5oYVMyRGR6ZzlWZWlFSTNGRjhKL2RYa2ZiRUg0MC9UVnh0?=
 =?utf-8?B?dlU1SlJndnYrR015NDBnTExTQ1lPNXhwdmxEanN1UUZQbHpld2poUXFrRGJ3?=
 =?utf-8?B?Qm9oajNNY2pESGRNb3pFUG9ERG43UjVNMkhNb1pjeUhvQytPR2NVOFgwei9p?=
 =?utf-8?B?MFJjMHNBdFJBbmZVTEFnMGtiL0E3MDVnUERoYkNwbGJhSWpINkZZVzdaWDZV?=
 =?utf-8?B?MDRWeXlUQ1FoQWduMnZndWd3NjQ2dVZNMG0yNGgvbVdwU3JpaWltc1NXLzcr?=
 =?utf-8?B?alZkTnZtNXlYNk1NekVkZm5nM3VlWVQyVkNLWjNWcllxbmRKWDBvOXJIeTg3?=
 =?utf-8?B?SEtQOHBQRmtKNWNEaG1aaDAzYTlWeVRybDh2ZEQ1ZmZGK3ZyYXVDQzFraDg3?=
 =?utf-8?B?RWJSZmtDRFh2N2hiK2l4SmRQdlNZRGZINFFYeU55Y0thUUNmbTk2K1l4U3di?=
 =?utf-8?B?U3BDdENFYW9EcnA3N0QvZWlybm9nckZIMWRTdFBRVG54WEdOa2Z2Y0Y2dVQw?=
 =?utf-8?B?OFZFMkNZUmY4c3dISUhWUG94YjRIRXRUYXVTK1BVQk1Jb2lLMGsxOU4zTTk5?=
 =?utf-8?B?Zm02UXVGMDlDZXlJT3oxNC9sSk1mbmh2U0tUcHBLU2xPRkhOTTBBZExYa0M3?=
 =?utf-8?B?Yld6TkpoV0FTbmc0bUVhSE5DMzd5SzE2eGFnOTgvYUtMejhLL3lxblZzZUZh?=
 =?utf-8?B?S091Zm85RVJWc1VWQ2FFeFFxdE9VREc1TnFyNURjS21ka0FVQ2RTc291eEl5?=
 =?utf-8?B?SlljZHJPaFVVTmNFd2E2dXRqK3lobHBNOGQvc01KV2k5UlUxNVg4OS90U0hG?=
 =?utf-8?B?TDYrSWY4cXJQUG1ib0RvVndHZ2ZXUlVETXNuR3I2NlArVEtndEJZNU5zRWNk?=
 =?utf-8?B?cXRFaTVwK2dtb01kamM4MnRIUHZrTS8xUHR3cUs0elJPUWJzOUdQc0x2N3VP?=
 =?utf-8?B?S2tzVUZpZFVNc0poeHVNcWswWGVFT05uMExRdmcxdWlBRkNzeThxS25YWWYx?=
 =?utf-8?B?eklrS1liakVXMHF2My80QkZoMHZMSGhLWXVrVWdUeFZ1ZEVLSWE1Tkk4NVZk?=
 =?utf-8?B?Y3pWTkdZSm1xS20xd2pHcVVlZ1lnMXVyZ1I4TWJwcnpvdlVaN0Y0a1lVYmVH?=
 =?utf-8?B?NFJMeEszcmFVN1hQbHFlSEZ2MmxYMG5qemlWNzd4a1pjSU1BL25BOXJqVFNP?=
 =?utf-8?B?bjhLQWI0TnNoSlpZZEhiTTdJS2F5a2grbDRwcGQ2S0FwdStxa3hDcWFuenJ3?=
 =?utf-8?B?MlRXWUVKcEtjZzZETTRpZGUrQmVRMjJQQldEcmx4Y1RZMzVFTWxzQmVZdStG?=
 =?utf-8?B?SFIvakZJcnBYTHBWUTFLMFU4Mk1xdnRoTDBvKzVnd09YY1JwbitFNXdUclpE?=
 =?utf-8?B?UWpOam40QlYwck5DUzNWb21VWEw0b0RUVzV1a05hTW5TdjJVUWxzS25WcklQ?=
 =?utf-8?B?cVRTTXhzOWMrUWJGSE5Pb2lpSzhzcVdxaFN5ZmJmRjB4MEZoR2dvWmxhdzlh?=
 =?utf-8?B?VEVKZmFQTGM3a0g2V0VVWW1CMmNLcVNVdG9wTko0djNHeTVLazVFVUZQRC92?=
 =?utf-8?B?TTBBVmlZM1BKblBlN2FqUktQT3FWbURUZHM3SUFyYmtRdTgreW5FSUc2YWVI?=
 =?utf-8?B?aGpPRitsUnNaNWkzSXJRUmhGK1c5QnV4czZOMVJ1Z2lHYUljOGVYaW5FMUFE?=
 =?utf-8?B?WHV5TjV3NlJJWUU1US8vTHBtMnlTY2pIUTNBaTVGMkVBZmw5Rk5pdEY3VlY5?=
 =?utf-8?B?NCt2K2s3OTVRUFE2bWtTaEQxbXptZ3MwWnd5YWUyR0c0emFyOTg2bFJzN0tK?=
 =?utf-8?B?NDBJZEZ0MzZnQ1Zhcnc4aHRsQmVTUXpMTjV5NTd6YVAxanQ5b25PaEx3TjhS?=
 =?utf-8?B?Zit5UWV6bHBFU0dqNDN2U0thYTd6OEN6dmJOTnA0a1FUSUUwU2IxUUs4Sm5z?=
 =?utf-8?B?R0VmOW9DdkRhZDkrZVpJNFZmNzdER2puQTIwSTFQT0E1ZnRvNFhwMkU0UU1V?=
 =?utf-8?B?Rm1hVy9LSVN3aEZqbUlJZzJrbG1xYnVVVHhDSGdlVGw2NHlod3JrNVFNcEdF?=
 =?utf-8?B?VXZvS3FDdFQzdTRmVmVKRG9vYXBVM2RXRlNSSmFZMmQvbWhZU01QOE4yZXhR?=
 =?utf-8?B?Qk5ET0tUOThOZE1lMEx5NU9DZ0RTQVB3VHdIOGRQYTVZNVE2MnAxUGQ4bUYx?=
 =?utf-8?B?L3grYStwNzhsb0swKy93UVpMMzJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED5CE3F768FCA24496C0E3C0A52DD730@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aab0de9-9331-4cdc-869a-08dc281d4b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 20:42:25.7034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: At4Wz5+kWMWx2RfLZmwA8hQQr9KI4Bc4BG9rsgUpVEPM+z4+5+6N0jQWWEpsBqjy8rR1Yjd2RUF4HcK6tPOzXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5380

T24gV2VkLCAyMDI0LTAyLTA3IGF0IDE0OjU4IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gV2VkLCBGZWIgNywgMjAyNCBhdCAyOjUx4oCvUE0gT2xnYSBLb3JuaWV2c2thaWEN
Cj4gPG9sZ2Eua29ybmlldnNrYWlhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gV2Vk
LCBGZWIgNywgMjAyNCBhdCAyOjEy4oCvUE0gVHJvbmQgTXlrbGVidXN0DQo+ID4gPHRyb25kbXlA
aGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gV2VkLCAyMDI0LTAyLTA3
IGF0IDEzOjI5IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90ZToNCj4gPiA+ID4gRnJvbTog
T2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+ID4gPiA+IA0KPiA+ID4gPiBD
dXJyZW50bHksIGlmIHRoZSBzZXJ2ZXIgcmV0dXJucyBhIHBhcnRpYWwgbGF5b3V0LCB0aGUgY2xp
ZW50DQo+ID4gPiA+IGdldHMNCj4gPiA+ID4gc3R1Y2sgYXNraW5nIGZvciBhIGxheW91dCBpbmRl
ZmluaXRlbHkuIFVudGlsIHdlIGFkZCBzdXBwb3J0DQo+ID4gPiA+IGZvcg0KPiA+ID4gPiBwYXJ0
aWFsIGxheW91dHMsIHRyZWF0IHBhcnRpYWwgbGF5b3V0IGFzIGxheW91dCB1bmF2YWlsYWJsZQ0K
PiA+ID4gPiBlcnJvci4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29y
bmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gwqBmcy9u
ZnMvbmZzNHByb2MuYyB8IDYgKysrKysrDQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJv
Yy5jIGIvZnMvbmZzL25mczRwcm9jLmMNCj4gPiA+ID4gaW5kZXggZGFlNGMxYjZjYzFjLi4xMDhi
YzdmM2U4YzIgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiA+
ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+ID4gPiA+IEBAIC05NzkwLDYgKzk3OTAsMTIgQEAg
bmZzNF9wcm9jX2xheW91dGdldChzdHJ1Y3QNCj4gPiA+ID4gbmZzNF9sYXlvdXRnZXQNCj4gPiA+
ID4gKmxncCwNCj4gPiA+ID4gwqDCoMKgwqDCoCBpZiAoc3RhdHVzICE9IDApDQo+ID4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Ow0KPiA+ID4gPiANCj4gPiA+ID4gK8Kg
wqDCoMKgIC8qIFNpbmNlIGNsaWVudCBkb2VzIG5vdCBzdXBwb3J0IHBhcnRpYWwgcG5mcyBsYXlv
dXQsDQo+ID4gPiA+IHRoZW4NCj4gPiA+ID4gdHJlYXQNCj4gPiA+ID4gK8KgwqDCoMKgwqAgKiBn
ZXR0aW5nIGEgcGFydGlhbCBsYXlvdXQgYXMgTEFZT1VUVU5BVkFJTEFCTEUgZXJyb3INCj4gPiA+
ID4gK8KgwqDCoMKgwqAgKi8NCj4gPiA+ID4gK8KgwqDCoMKgIGlmIChsZ3AtPmFyZ3MucmFuZ2Uu
bGVuZ3RoICE9IGxncC0+cmVzLnJhbmdlLmxlbmd0aCkNCj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0YXNrLT50a19zdGF0dXMgPSAtTkZTNEVSUl9MQVlPVVRVTkFWQUlMQUJMRTsN
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoaXMgY2FzZSBpcyBiZXR0ZXIgaGFuZGxl
ZCBieSBhbGxvd2luZyB0aGUgY2FsbGVyIHRvIHNldA0KPiA+ID4gbGdwLQ0KPiA+ID4gPiBhcmdz
Lm1pbmxlbmd0aCB0byBhbiBhcHByb3ByaWF0ZSBtaW5pbXVtIHZhbHVlLg0KPiA+IA0KPiA+IEkg
ZG8gbm90IHVuZGVyc3RhbmQgd2hhdCB0aGlzIHN1Z2dlc3Rpb24gbWVhbnMuIFdoYXQgSSBjYW4g
dGhpbmsgb2YNCj4gPiBpcw0KPiA+IHRoYXQgdGhlIGNhbGxlciB3b3VsZCBzZXQgYW4gYXBwcm9w
cmlhdGUgbWluaW11bSB2YWx1ZSBhbmQgdGhlIGNvZGUNCj4gPiBoZXJlIHdvdWxkIGNoZWNrIHRo
YXQgdGhlIHJlc3VsdCBpcyBhdCBsZWFzdCBhcyBsYXJnZT8NCj4gDQo+IEEgZm9sbG93IHVwIHF1
ZXN0aW9uIG9uIGEgIm1pbmltdW0gdmFsdWUiLiBJdCBzZWVtcyB0aGF0IHNpbmNlIHRoZQ0KPiBj
bGllbnQgd291bGQgdGhlbiBuZWVkIHRvIHNldCBpdCB0byB0aGUgc2FtZSB2YWx1ZSBhcyB0aGUg
Imxlbmd0aCINCj4gKGllDQo+IHdob2xlIGZpbGUgbGF5b3V0IHZhbHVlKSwgeWVzPyBTbyBpdCBz
aGlmdHMgdGhlIHJlc3BvbnNpYmlsaXR5IHRvIHRoZQ0KPiBzZXJ2ZXIsIGRpc2FsbG93aW5nIGl0
IGZyb20gcmV0dXJuaW5nIGEgcGFydGlhbCBsYXlvdXQuDQoNCk15IGV4cGVjdGF0aW9uIGlzIHRo
YXQgd2UgdXNlICdtaW5pbXVtIGxlbmd0aCcgdG8gbWVhbiB0aGUgbGVuZ3RoIHRoYXQNCmlzIHRo
ZSBzbWFsbGVzdCB2YWx1ZSB0aGF0IGlzIGFjY2VwdGFibGUgdG8gdGhlIGNsaWVudCAoaS5lLiB0
aGUNCiJsb2dhX21pbmxlbmd0aCIgYXMgZGVzY3JpYmVkIGluIFJGQzU2NjEgU2VjdGlvbiAxOC40
MykuIElmIHRoZSBjbGllbnQNCmNhbm5vdCBoYW5kbGUgYSBsYXlvdXQgdGhhdCBpcyBzbWFsbGVy
IHRoYW4gYSB3aG9sZSBmaWxlIGxheW91dCwgdGhlbg0KdGhhdCdzIHRoZSB2YWx1ZSB3ZSBzaG91
bGQgc2V0IGZvciBsb2dhX21pbmxlbmd0aC4gVGhlIHNlcnZlciB0aGVuIGdldHMNCnRvIGRlY2lk
ZSBpZiBpdCBjYW4gaG9ub3VyIHRoZSByZXF1ZXN0LCBvciBzaG91bGQgcmV0dXJuDQpORlM0RVJS
X0xBWU9VVFRSWUxBVEVSLg0KDQpUaGUgb3RoZXIgdmFsdWUgaXMgdGhlIGRlc2lyZWQgbGVuZ3Ro
IChpLmUuIHRoZSAibG9nYV9sZW5ndGgiIGFzDQpkZXNjcmliZWQgaW4gUkZDNTY2MSwgU2VjdGlv
biAxOC40MykuIEN1cnJlbnRseSwgaW4gdGhlIGZsZXhmaWxlcw0KY2xpZW50LCB3ZSBzZXQgdGhh
dCB0byB0aGUgbGVuZ3RoIG9mIHRoZSBJL08gcmVxdWVzdCB0aGF0IHdlJ3JlIHRyeWluZw0KdG8g
b2JleS4gSWYgdGhlIHNlcnZlciBjYW4gbWVldCBvciBleGNlZWQgdGhhdCB2YWx1ZSwgaXQgd2ls
bCBzdGlsbCBkbw0Kc28sIGJ1dCBpdCBkb2Vzbid0IG5lZWQgdG8gcmV0dXJuIGFuIGVycm9yIGlm
IGl0IGNhbm5vdCBtZWV0IHRoYXQgdmFsdWUNCnByb3ZpZGVkIHRoYXQgaXQgY2FuIHN0aWxsIHJl
dHVybiBhIGxheW91dCB3aXRoIGEgbGVuZ3RoIHRoYXQgbWVldHMgdGhlDQoibG9nYV9taW5sZW5n
dGgiIHJlcXVpcmVtZW50Lg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==

