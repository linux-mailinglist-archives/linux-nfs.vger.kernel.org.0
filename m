Return-Path: <linux-nfs+bounces-1824-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 364ED84D20A
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 20:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645F11C2296E
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Feb 2024 19:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B791A8527E;
	Wed,  7 Feb 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="AHTi6WRh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2110.outbound.protection.outlook.com [40.107.94.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F86E1EA72
	for <linux-nfs@vger.kernel.org>; Wed,  7 Feb 2024 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707333127; cv=fail; b=gIHb7i/aSw5bu3ebXaUUPrXI/Z4mNgw9AdvXkGT2GeQuJu8UcJ+mELJC/yzvJ/krk0OCAJx5QRKcIv42yoeECShTtVtqkRkj1E25X04NrVwKLUhJCtAofpO8MfeS0fM/BTy+BnpqPp/OTx1oQlYP0apietTTsAhBOo4ALOeO7u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707333127; c=relaxed/simple;
	bh=99pP4eZjh2aF2Y6uKMkwd7iIqPQjt06BYy/RtmPNRpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WPF5Lgy8VyqD7mxyLKy+uSbTCgTw2PIEX8M5NKWPEjnWWdQrjOm9UWq2OXERS3Qvjc/+f+FNj6AGev1Tl/BtjoePTy7c8hSaPtby91fV+1ek3BKUJHUN6XGc0GHXOPamQ81VWcXLWuB7PigZ+jN/xXHC0jlCWPRiOcEgx4e7yvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=AHTi6WRh; arc=fail smtp.client-ip=40.107.94.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuIunJEH/5jVGL0/vE8ReoDv+6Jj1jKWPgUOjATn0NQJP+EpgAeTJltcmjTOaNwtA5CvyakCZ8CWxMgzPiIkeZRCb2LOv2lLdsnBy0yakKRohUr2Bp3oE3pYUvKYEF9mV+hpuOSrss6jf3KTbhtPDKTLsh4fauumvjIo5m+Stl91GVmCONGTqs2yJcrcKkvIQXpY3BdZ9HZVd1s5mHO56UDnjq3lDLnm/W846k4Z5vdXGdGTAZ0eN7F3K1OZpcZ5AEwam9yiynZs0nMGah9p/ffdcWQq5PipI8d3ixeqgvjqherqNJ/51GSiqrjxZTPdaGXajQmY263gUUtq+VpUZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99pP4eZjh2aF2Y6uKMkwd7iIqPQjt06BYy/RtmPNRpQ=;
 b=FLJYcSI17q3LB1w8d6W3X5V4ajyLmUy3ba84IgjZPown/CK+WWhhhD6jxzKYumQ6RRCnFcCtrqCnxXRHBP3uwTaywNbLeyWj7n4o3wAW+qXbqDJAvOXuq4XNgQO68F5YMaqXtLax8GuJw0Paej464k94OlsgJ4TAifhBajNRAJBmrQe7HXkXJ5Dfn2TuYuFGac06uxPVDDYxjDrPv68VnY3z4cLtAtV3//tEW0PMuEkS1dmR1NIVUr8mYQrnWFO9roLXDIucMNWJHFN0TZArzw7BcVM33q85loVDOce0pZTetv+Z6SBUfoG8cAO58u2UqAXAv31n1QVQ30BSkCJKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99pP4eZjh2aF2Y6uKMkwd7iIqPQjt06BYy/RtmPNRpQ=;
 b=AHTi6WRhEfrehn0OIESiL5ZzlG51hkRiR0UMJinb0M+RW/OmShjeu9hRNHYqulpBSitzPAMDcU7FFIhBlACbdLUHfts2lBsRFf7Y0eOPXFmtNUXDOuSmVoiLqk0jxGBfSMcsgAo+a3Q2/Ifoe0662h2Wps1AfLJeUsPM/ACgBjE=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH3PR13MB6554.namprd13.prod.outlook.com (2603:10b6:610:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 19:12:02 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5003:a508:6b4:4e8a%5]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 19:12:01 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
	"olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs layout
Thread-Topic: [PATCH 1/1] NFSv4.1/pnfs: error gracefully on partial pnfs
 layout
Thread-Index: AQHaWfOPdWZCWS05wUeJC6M2pFsKwLD/PyUA
Date: Wed, 7 Feb 2024 19:12:01 +0000
Message-ID: <be83ac24a9d17fc78590d4b182afd3f4e6c1e8a7.camel@hammerspace.com>
References: <20240207182912.30981-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20240207182912.30981-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH3PR13MB6554:EE_
x-ms-office365-filtering-correlation-id: 08b99900-da8e-47f4-08b6-08dc2810aa15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ps25CDrC417JFgZ/t6JA4SnOvRNijFCE/KFeAgw0mSTApnMZFMZzRsmnLoC2XyDFs/1YvDYl6bBw4Iyppew+7X/WjBCPuietVNxCjMENZTwSdRLofDLRBK47Z1BUAQaABk8e6au6bgbYiTb7sUtVlnIE0bhjokcG5RP5QvARfcPmBb7Jz9bYWAe/StjypydtCm6VglfszD2SfYB4xt9b5kx/6SiE8lK2lgDyHcIjfvm5WDVdVculmVxOfWvCF0xNL85d+NRwdAsKoHVRC35BrRdxZ8D+REH8lqEvgVtLPOICJ7JPYG1ygaVTR2RR4nknEUZ9HlWOjJjDmLnir5n3FVWjW3vIybIwhh+9cERhHJdE8Vx7jalikwFIypVEKNa5s2VJAGZ0jmuh+BLXdpaOyMFDAot74p0iECiZjFjiJVmclaAAJ6C9xzvqb9l8nHfIbjO7J+c5rXtjTAWkJWQ5uat2hxrdAxfTuigLMUvAunv88aVfCgwyHLl35GEkaq68H+zOOFVDtJdEhmgcEaYMyy0YsbRNmks9E5F+VlVfCpOOLopYsU8qBmzz+1dakv4kZ7rgecsHCiE7ofeWympENcFU6vRJUcbts69Ttx4v4wSkTiat+4U8+Eixyuld+GBc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39840400004)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(38070700009)(64756008)(66446008)(110136005)(66476007)(36756003)(66946007)(76116006)(66556008)(316002)(5660300002)(8676002)(2906002)(4326008)(8936002)(122000001)(38100700002)(6486002)(6506007)(71200400001)(6512007)(478600001)(2616005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDNkVkZraWY2TnNKKzJzQUJudGg2TXVRbENLbUdoMEZpUkhta0E2cW5rdXZT?=
 =?utf-8?B?NzJZUjU2RnUvc01oK1JMM0czUWkvUmNRVHRFeE5IYnc3VnhJZGlMaFFxTGdU?=
 =?utf-8?B?MGNyd3hZbDc4UGxIMm1VOVlCYkEyck0xMFpKR0p1UHVXWXRBT0hyUG1maHlQ?=
 =?utf-8?B?dmpHNWQyT0t3T3lDQmdUNDJaWTg3ZVRBdlZjZEhsMnVKQUxIZWRwbVZoYWhO?=
 =?utf-8?B?Q1NGc2U2UTQzRWdFeC9LdktuMW5YbFIxUjZxSkMwTjRHbDZ0ZmgvV2I1aGlL?=
 =?utf-8?B?enlRWFZieXdYZjl5K3ROSVA5QkxZR3ZHZW02Y1Zyc0VWSGh6QTRmQVEyNnNR?=
 =?utf-8?B?NUE1cFgrM09qbjFTdEliYzFwUDdsdEhmT2xTdUNWbGkwU0lQLzIwQ2Z1OGcr?=
 =?utf-8?B?NzV5SXVmZ0RBNXlzekx0ejZsMFFYYkxNdFhXVlRwTGpJRnA2N0NsUzZBdmhP?=
 =?utf-8?B?WFM4Q3E3TVBlbmZDUVZOZlNXS3hZV0RRRTZqbGtMelVacFFiZmVBZW1odDhL?=
 =?utf-8?B?VW1YL0VpaUoxd3BqdWxmekN6SGZCQk1zL3dEaExteUdsZmdyODlsVllXMkY5?=
 =?utf-8?B?SGxqdW55dExFK3I1S1VkY1R3NEozTmd4emFhejUrK21wdXpuR3VhT0RDbEZ6?=
 =?utf-8?B?bGRMdTAvWHE5UmJpakNvNjM4eHJoSFRTWGQ0b0dHU0QybEI1QWM1Qm1yKzNj?=
 =?utf-8?B?TGFkZEZOL1UrQ0xlWkRQRStDRWtUU0o4ckVkSjE0VXN1dzFXKzB1THNOdTNE?=
 =?utf-8?B?d245QjhzMTFWd0VmSVNKeTJucEQySzRrekxsSUM2V3ZwTHhJWDExU3lGYm9M?=
 =?utf-8?B?cmlZSENIMEs4ODdiNDRJZ1ZCOUsvWHRjKzdIc2JkeWlMRTd2MW1YaDY2d3E4?=
 =?utf-8?B?RkRPTXNBQU5wcUlZWmwvUGJ6d0t1R3htK2U4OXVmRGpFdUlYT0RUaUVwYWJU?=
 =?utf-8?B?djJzUGFOS2pLZEt3MmtqMGRFUVZvRlFPZFpYNUxMcDZqaWlSVzNGVjQ0dHhw?=
 =?utf-8?B?WkNsR2RKQjJuWXFQall5aHFnRFlqQ2FIL3Q2UnV1VnBva2NMMnEwYStuRnZk?=
 =?utf-8?B?UlhxdlZWT2lXOUNFSVI5ZFUyYjB2Zno1ZG5pOVNDVmZyV0RNRVRQZm1nck91?=
 =?utf-8?B?Z2QyTVJ6ZEJkSTdWRTNXVHJndnRLcWlDdHh6bUhIN3BXb2VQZFczc3owcmJa?=
 =?utf-8?B?aUEzSVJBNzRiN1ZCREttT0tTZUs3L1R3NEdUbUtPNnRrN0dlU0Z2VWFOdXIv?=
 =?utf-8?B?c3BnS1RhVlhtS3N1K1VKN2ZMZ1pPdlJxUENIaWt1LzVuandxMG9wWW41R01W?=
 =?utf-8?B?OW0wQmxQT1Z0ejNxTDZPZjdjY1oyT2V4bU0zbHZDVGJKQzJ5V3ZnNGFOV3Bq?=
 =?utf-8?B?dWVWVXV0a2dTSUZCcTcwSG5OQkxvYThveEphNkdySUVJQnovV2RVZHcwQ2k0?=
 =?utf-8?B?ZEgwbFhnbzNBcVc5dWVxbDVySkdsam5CL1dqcVNMMFdZQXcwY01ZTWFGQTRv?=
 =?utf-8?B?UWNYYThMejFyZXBuQ0tuUndnT1FRckplMm5XZjBVb0piOHFnQUxXYTdSd0cz?=
 =?utf-8?B?dUZSNmtVbHVmRHhtakt1dlY4b3VDU3BFZmdNT2J4dXZUc2xxV29RcXJGUHpU?=
 =?utf-8?B?VXo1TEpHVXNQL0hNRXU0eW1Jblk0S2l5UDJqUUN4R1FaM3JQeWhCNzBsQ3hO?=
 =?utf-8?B?OE0ySUVCZzZ5UWpKT3NJRFVaMDZockpNS0t0R2ZYZG1MTDBzTndqazZiSVBo?=
 =?utf-8?B?bS9sNGFiVS9QYlRIZEtreE9uVXBIR0dTTHkxZDk3a255OFR4TmtWME43K0cv?=
 =?utf-8?B?b281Y1lBS0M4MkswM3B1QjdjU2twNVlIbFkybTU5QTUxS25hSVJUZlpIdy8r?=
 =?utf-8?B?eTlLMkJHdG4zOU5Uc2NEeVhFQkxQTWo1Z0VlbnhJM2ZZRzA3Uk9OWGxtM1Fq?=
 =?utf-8?B?dVlEd2NhempJR1ViQmIrcHNWOTNJcUZFUzVuMm1YTURmVysxejNyZ0hOSHdN?=
 =?utf-8?B?OU9yV2NGNDdaQkVGQWZSYTNoTzJOdThuUVlPRTdCL2l5NzlFSGZHMWNhRkRi?=
 =?utf-8?B?RFcyWDR4NS8yeHNQeElhY1FwVk1EZlNuaExGOUFYZnp0SExDZWIyTGJwd2Nx?=
 =?utf-8?B?TjkyWmpTY1E1T1FIUE1sWWNZYU1OdDFydVhTbmYxL3lNcS8zVlhFZnZIM0FL?=
 =?utf-8?B?TWx1TDkzNjRGa2JENDhnTnVuTmRKanpoQm9XT0VjRE9ROVgxcmQ1dTd4N2l4?=
 =?utf-8?B?YkxBblBpL1RXckdneURpRll4QUdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AC11C861F2857428C08F061E42E6A3F@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b99900-da8e-47f4-08b6-08dc2810aa15
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 19:12:01.7749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X50/ulUtzgV9SaUzh5OsP1h2Us9VEZ/WXTVukKFROdtQkubwY+giyeFxRHxmykh8VUIYI78FeqVsB/6nmqah6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR13MB6554

T24gV2VkLCAyMDI0LTAyLTA3IGF0IDEzOjI5IC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+IA0KPiBD
dXJyZW50bHksIGlmIHRoZSBzZXJ2ZXIgcmV0dXJucyBhIHBhcnRpYWwgbGF5b3V0LCB0aGUgY2xp
ZW50IGdldHMNCj4gc3R1Y2sgYXNraW5nIGZvciBhIGxheW91dCBpbmRlZmluaXRlbHkuIFVudGls
IHdlIGFkZCBzdXBwb3J0IGZvcg0KPiBwYXJ0aWFsIGxheW91dHMsIHRyZWF0IHBhcnRpYWwgbGF5
b3V0IGFzIGxheW91dCB1bmF2YWlsYWJsZSBlcnJvci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9s
Z2EgS29ybmlldnNrYWlhIDxrb2xnYUBuZXRhcHAuY29tPg0KPiAtLS0NCj4gwqBmcy9uZnMvbmZz
NHByb2MuYyB8IDYgKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMN
Cj4gaW5kZXggZGFlNGMxYjZjYzFjLi4xMDhiYzdmM2U4YzIgMTAwNjQ0DQo+IC0tLSBhL2ZzL25m
cy9uZnM0cHJvYy5jDQo+ICsrKyBiL2ZzL25mcy9uZnM0cHJvYy5jDQo+IEBAIC05NzkwLDYgKzk3
OTAsMTIgQEAgbmZzNF9wcm9jX2xheW91dGdldChzdHJ1Y3QgbmZzNF9sYXlvdXRnZXQNCj4gKmxn
cCwNCj4gwqAJaWYgKHN0YXR1cyAhPSAwKQ0KPiDCoAkJZ290byBvdXQ7DQo+IMKgDQo+ICsJLyog
U2luY2UgY2xpZW50IGRvZXMgbm90IHN1cHBvcnQgcGFydGlhbCBwbmZzIGxheW91dCwgdGhlbg0K
PiB0cmVhdA0KPiArCSAqIGdldHRpbmcgYSBwYXJ0aWFsIGxheW91dCBhcyBMQVlPVVRVTkFWQUlM
QUJMRSBlcnJvcg0KPiArCSAqLw0KPiArCWlmIChsZ3AtPmFyZ3MucmFuZ2UubGVuZ3RoICE9IGxn
cC0+cmVzLnJhbmdlLmxlbmd0aCkNCj4gKwkJdGFzay0+dGtfc3RhdHVzID0gLU5GUzRFUlJfTEFZ
T1VUVU5BVkFJTEFCTEU7DQoNCg0KSSB0aGluayB0aGlzIGNhc2UgaXMgYmV0dGVyIGhhbmRsZWQg
YnkgYWxsb3dpbmcgdGhlIGNhbGxlciB0byBzZXQgbGdwLQ0KPmFyZ3MubWlubGVuZ3RoIHRvIGFu
IGFwcHJvcHJpYXRlIG1pbmltdW0gdmFsdWUuDQoNCj4gKw0KPiDCoAlpZiAodGFzay0+dGtfc3Rh
dHVzIDwgMCkgew0KPiDCoAkJZXhjZXB0aW9uLT5yZXRyeSA9IDE7DQo+IMKgCQlzdGF0dXMgPSBu
ZnM0X2xheW91dGdldF9oYW5kbGVfZXhjZXB0aW9uKHRhc2ssIGxncCwNCj4gZXhjZXB0aW9uKTsN
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

