Return-Path: <linux-nfs+bounces-470-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31B380ABDC
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 19:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A15EB20B6C
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2A6481C4;
	Fri,  8 Dec 2023 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="LMxXff52"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0242C98
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 10:16:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aVmzBk0IoqwEoqAtuCdFU8cOYlGijhAatgBV80IJ/mXfRQ6ufqQi0e/Jj+RTFmmluQPsvHv6u7bRLi8uUQmYaahsIVGn02vZPEJsdS6EaZiuoPlkurK+LTqGNe+kxJ5dRrp23UIR9LE0T50k7UygutfLcZbmJ3o89v+7/DNu+RuZibyYxcU49HAwUrfpcLjKGJh+ZjYQ8Y5sJA8p/5zI6BlNt9uPm4kx5gloE6rpNDWGjx3aAu/FVdsqTzRwdIBjskJ06dJVrkK0r4T2zxLyIqcx1XwrsfseYGt95fW/9jASEbrQL6NIS7AK+O11Hj/u8nSo2RdjoxpiVNvlXsgKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJYow/fjof8vVK/lU0fMWOVh3nyJCkOWRos9hV29HXQ=;
 b=e5a9EjNqQJqJQgfFwX5cGe+EPaebPnkA+1SmyWktX51oVSZmYOCan+sx8F+Lkwf/YfzctNaIaKa8tLT9WGNRwGXWN03bcFrOeKgGbMM18lw+Y0TnFX1PoAuJM3oPLM0g6SSLMbRR8dl6buoLsMmHjBtSb+QQ2zhwn83rJp9zPcZI3ljX6f/QnvXuuh69242jeqkRizV/hJU5w69B2JpDvZfOkqXIZjNgxuNEQLmMrhUkfRvcy7hUyWvDMCCj1g8Z529KtP6YTq0VN/Ot18uM7hMgn1i7bsKXx8tor53WHtvHNaxoOqOaVSFEGu5t7OHKkLrJlO8dNhImr9TlX+ovtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJYow/fjof8vVK/lU0fMWOVh3nyJCkOWRos9hV29HXQ=;
 b=LMxXff52Sux/TaxxC0aLJxK5uHFLRBpeWolAUwaVbPDl5lwJEjl1dmO+NcqEwo10/qDpeqUiYoUpdfMzC6DmxzVPpkpJV7niDM7uIQ6K0EwHxFmTPX1KRQnGhjB95A3uLFia1OCKJuEHxGWG+oFlv0SbwShicH8gAcJVNQP44HI=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by CH2PR13MB3800.namprd13.prod.outlook.com (2603:10b6:610:9c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 18:16:43 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::390:1b7:55fc:a776]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::390:1b7:55fc:a776%2]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 18:16:43 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "anna@kernel.org" <anna@kernel.org>, "bcodding@redhat.com"
	<bcodding@redhat.com>
CC: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fixup v4.1 backchannel request timeouts
Thread-Topic: [PATCH] SUNRPC: Fixup v4.1 backchannel request timeouts
Thread-Index: AQHaKfRYht+bm+bgJkWCO2LEqHaVKLCfsXmA
Date: Fri, 8 Dec 2023 18:16:43 +0000
Message-ID: <fbd98744da0c47e7830db6a753a27db541f07379.camel@hammerspace.com>
References:
 <d69074e4dc692ea7a9ccc866d8f87177539411e2.1702053194.git.bcodding@redhat.com>
In-Reply-To:
 <d69074e4dc692ea7a9ccc866d8f87177539411e2.1702053194.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|CH2PR13MB3800:EE_
x-ms-office365-filtering-correlation-id: 96b2842e-4eff-4941-6ab1-08dbf819d4eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 02rjsBUZ2PPhm+q0mgf3sdqfJUCjGOx1PP5SIdjJqmZQeewRA2+PV5s8nRhBCXKADRhU+XeSg0CNTWmfxrkbcN5rFmpWxsE1vh5rEUtb1ChdpchSbfR+BHx7zGvvKaM8KCX8BkPyAehBrRiQ8iuDpEaJO+5JnDZgon3T/zhAF4xqNJ9xcSPymrRViAMHkIEdZLFhXjYoLwXEUPKa4AQdIuIiib3Q4r65mumXG6OFy+4ONcKQTCr/8oj7i0eptj/IzAtnPT6SnKBo74gRsfI7Tu2iyOkYVaRKKl6puxOw28523+/HhLKctfhNU3pVCqJRWl8oohYp/yDMRan/rZdGGeMlghpLyW/EQ0iocEQd5x2EoTuYIfmMbdJAZIFPZ6PyFiWjnCUyneB87KZc9nkO4iC22uYuZAVT5xHzeys8dZtX2jTZ/oDohLu6MEhf52Ff518SGaJSbGFUBp5XlxL1yykJ7/GbhQnb3E/iCAByVAOs/KhPSUC0lx/fpxRNZby/hgykmUkR+NrZo4yqGWqDqEVDOfcGhGqgYxgxNElmX+VlX01nsn8tn1z2zrDrUR9XOQyP1SYAWfHg/nBTCmdLAZOaIMuzQjtVgphU8kdiXmHUeeS3pHvAtpY48VwZ/wIu7SatPdb1JVSziRt88fwTvrU8dmLUV3G0ajZ2sEPdI2I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39840400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2616005)(6506007)(26005)(71200400001)(6512007)(83380400001)(122000001)(64756008)(41300700001)(5660300002)(8936002)(8676002)(4326008)(110136005)(478600001)(6486002)(66476007)(316002)(66946007)(2906002)(91956017)(76116006)(66446008)(66556008)(86362001)(38100700002)(38070700009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUxueUdvWnZEUXZ2dDR1RTJZRHBPbi9ZcW5jS3RKRzVhd21BaDFPbW9LV1Ux?=
 =?utf-8?B?Ym1JM1U0MUI0ZWRjNlFJeDE1aGZ2NGg5NW03NDUyMittL1lJSjkrYU95UmVV?=
 =?utf-8?B?TWRzMzlNcWNWc1J5Vm50VWNJU0ZvNHY2M0NxRElQLzhPVVNHYmlhaGhSQSs1?=
 =?utf-8?B?cUJad0owUXF0Q0dpSWUwNElZSXNHUGNGZzlzUEZNelFGbTJVdnZPRHJGbml2?=
 =?utf-8?B?QjFGS2ZiRHRVczBaMG8yL1BKT20yTjhJVFlKWGhxdENWN3VrTVFhanF4V3dY?=
 =?utf-8?B?bllDOVBhOUhHaEE0WTNNOEVEVUZNbTI2SVRicjRSOTg4eDRyUWlBd3dGb0E4?=
 =?utf-8?B?Y1IxNTVicENhMjVkRjJjNko5cTNQVGlOaFpUbEpsdWllWUIybDkraGw5WEdX?=
 =?utf-8?B?SmhZUTFlbFlVVXRKTTJ5U21jRkVhYmpvVWZOM2U5elc1Yi83K2xNU0hGSE93?=
 =?utf-8?B?eDh3QzVHRjZ3OEdHMVhKSXY1T1NHWGNsMW5NZ05HbzNtN0JRVWVHYnRnRzdm?=
 =?utf-8?B?SkhqRTQyS01va3FvVUFLTXVXNDVGOVlQdmtXK0Y5VzhodGhZTkhHR083NHlO?=
 =?utf-8?B?NXlBak55Y2hQR1M5dzRrMzEyb0tndGJWQWdrZXhTUXpFVkQxK3BKWHNYbXg1?=
 =?utf-8?B?MmFTUnp3dHRINEtHYmdsN3d0Z1IvaWZVcXIxTkpxbUhueEpuR0FMNkVwNUp1?=
 =?utf-8?B?SW1ybEhUN3UzQWVCL1dyTUQ4OGlHK0Nyb1lsaXl5OFZhOC9zb2hrdkdjejN6?=
 =?utf-8?B?ME5ITEhCR0h3K1VoK0xWajR3SjZKbjVuZW5nV3dQMksvc0lhR21HUmxxQzJr?=
 =?utf-8?B?cEpCc0N5Ykw2aktBRTFDZ09lUkpUeXYvaHQ0UEdPZ2FyS0FvY0ZEeUdxMGtr?=
 =?utf-8?B?Z09keEpoaXRzcFg2ZDAzbHVyTmwrY0ZtZE1EZC9WRUZ5eDJaMlM4blZ5UElH?=
 =?utf-8?B?ZjVVa1pBU0lIVlVzVS9pMFplQmVGQi9SQ0YwSmxiRVBDcEdRQVZ1YVBhbCtt?=
 =?utf-8?B?RjdoUnpPeWF0LzhKdVRRWTZTc1E0bXcrc3c1QzlSemppbGloVmxBTjNYVENj?=
 =?utf-8?B?a3JyR2M5ZC8rTmtiWGdueDQrejRGTUJXdkpKVm9VdW9NVStETnFiNkF0SnMw?=
 =?utf-8?B?aGw2V0lERGtSdXhSN2tPV1FES1lQWEF4ZnV0ZWg0V293endWZzcrV1RvREJI?=
 =?utf-8?B?NlluSTR6WDZOdjd6bzNTTWR6VkFKOGg1SXc5ampmQ09oR2FMbUppRThwNzIz?=
 =?utf-8?B?YWp5b1BYZmdHM3VhRlpNU3dtL2RmaW5xR2Z4RXphNzd1REZwcU1uV2N4UGlW?=
 =?utf-8?B?ZXNyR0hFUEV3b3lpZTR0SkpVWUxWQUJMY1BPMGtFRXdEOUZuQ0tsR3ZEbVpM?=
 =?utf-8?B?TFBRakd3a2hyRGtvamF4ZnhXNTN2TFpGVHFnZllPOXhXY2RNcllDT1JGV2tr?=
 =?utf-8?B?TDY0dzJ2MEVvcGVOR0NKalhVUlB3Z0lQOHRYMmpXT2paKzVCU1FQVUg4RUxk?=
 =?utf-8?B?STQwek5scTByaTQ3bDY4eTFtWHhZUDZnNjlBVjdpaE1qdHNFT2c4emM4dWVB?=
 =?utf-8?B?UGFHVjZyV05yVVJ6VmZuamk5Z1VWOXdlbkRSbzJ6RmVRZC9xQ0h0dm5LWFl3?=
 =?utf-8?B?K29DRTIxT0lDdFpSSlM4RU9zcGdDbzhMbzAyaTdUeVJTd21BWlFOK0FPN05F?=
 =?utf-8?B?M1NUZGZDM1F5RXhsdHdobk40cEtOZUpzRHlWUlEwMGxPMytlTnhqTXpUUlRL?=
 =?utf-8?B?cGFybzJKSlg4d2NOVnF5TUFHdnEzcUtBMUdIb1lBMDZ2UlVKM1VlY0lpeWcy?=
 =?utf-8?B?dDFnc2UrclNISVJVUmVKNU1IZUFuamFRcW1VN0ZuUEFLRkRKaXZ3anVDWWhp?=
 =?utf-8?B?TFRjS2xOaDZIMlNFUWxmeXZxS2VvZEhrbWNsOCszbmNJam9rVWphZEFTMGYx?=
 =?utf-8?B?aGtLSzkrdU5lK0FDVTBud2lWWnllZUFsWGY5QitkVkYzK0NScU5VTjVhY1N3?=
 =?utf-8?B?anVTU2pWeGMyZUxxVWU3MHVNMkJaV3UrNXF0SjRUUkszbnR0MlN1bUxvQ2lq?=
 =?utf-8?B?K29ORkI2NVJxM2hla1dGNDVjZ0FET1R4d1NyYlZRNml3QzJ4S0RzQmVjQjZu?=
 =?utf-8?B?U3RJZ3NBWmgrZkxHY3d0cTJoTlI1U25EaFhMM3ZLaGRZTkhzQUxFQ2hNRzZI?=
 =?utf-8?B?eUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C73C81F8532FB4498213EFDE4F7EAF13@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b2842e-4eff-4941-6ab1-08dbf819d4eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 18:16:43.2713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: klXvqA9W73M2msuiHGYWlCGp9FiO11yi+5JzSdyQ9UxiVpqG0vn7pNCVrs1cWtpF5eXKWNUCL2knp1YcN9CKrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3800

T24gRnJpLCAyMDIzLTEyLTA4IGF0IDExOjMzIC0wNTAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBBZnRlciBjb21taXQgNTk0NjRiMjYyZmY1ICgiU1VOUlBDOiBTT0ZUQ09OTiB0YXNr
cyBzaG91bGQgdGltZSBvdXQNCj4gd2hlbiBvbg0KPiB0aGUgc2VuZGluZyBsaXN0IiksIGFueSA0
LjEgYmFja2NoYW5uZWwgdGFza3MgcGxhY2VkIG9uIHRoZSBzZW5kaW5nDQo+IHF1ZXVlDQo+IHdv
dWxkIGltbWVkaWF0ZWx5IHJldHVybiB3aXRoIC1FVElNRURPVVQgc2luY2UgdGhlaXIgcmVxIHRp
bWVycyBhcmUNCj4gemVyby4NCj4gV2UgY2FuIGZpeCB0aGlzIGJ5IGtlZXBpbmcgYSBjb3B5IG9m
IHRoZSBycGNfY2xudCdzIHRpbWVvdXQgcGFyYW1zIG9uDQo+IHRoZQ0KPiB0cmFuc3BvcnQgYW5k
IHVzaW5nIHRoZW0gdG8gcHJvcGVybHkgc2V0dXAgdGhlIHRpbWVvdXRzIG9uIHRoZSB2NC4xDQo+
IGJhY2tjaGFubmVsIHRhc2tzJyByZXEuDQo+IA0KPiBGaXhlczogNTk0NjRiMjYyZmY1ICgiU1VO
UlBDOiBTT0ZUQ09OTiB0YXNrcyBzaG91bGQgdGltZSBvdXQgd2hlbiBvbg0KPiB0aGUgc2VuZGlu
ZyBsaXN0IikNCj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGluZ3RvbiA8YmNvZGRpbmdA
cmVkaGF0LmNvbT4NCj4gLS0tDQo+IMKgaW5jbHVkZS9saW51eC9zdW5ycGMveHBydC5oIHzCoCAx
ICsNCj4gwqBuZXQvc3VucnBjL2NsbnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAzICsrKw0K
PiDCoG5ldC9zdW5ycGMveHBydC5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNSArKysrKysrKysr
KysrLS0NCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdW5ycGMveHBydC5oDQo+IGIv
aW5jbHVkZS9saW51eC9zdW5ycGMveHBydC5oDQo+IGluZGV4IGY4NWQzYTBkYWNhMi4uNzU2NTkw
MjA1M2YzIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3N1bnJwYy94cHJ0LmgNCj4gKysr
IGIvaW5jbHVkZS9saW51eC9zdW5ycGMveHBydC5oDQo+IEBAIC0yODUsNiArMjg1LDcgQEAgc3Ry
dWN0IHJwY194cHJ0IHsNCj4gwqAJCQkJCQkgKiBpdGVtcyAqLw0KPiDCoAlzdHJ1Y3QgbGlzdF9o
ZWFkCWJjX3BhX2xpc3Q7CS8qIExpc3Qgb2YNCj4gcHJlYWxsb2NhdGVkDQo+IMKgCQkJCQkJICog
YmFja2NoYW5uZWwNCj4gcnBjX3Jxc3QncyAqLw0KPiArCXN0cnVjdCBycGNfdGltZW91dAliY190
aW1lb3V0OwkvKiBiYWNrY2hhbm5lbA0KPiB0aW1lb3V0IHBhcmFtcyAqLw0KPiDCoCNlbmRpZiAv
KiBDT05GSUdfU1VOUlBDX0JBQ0tDSEFOTkVMICovDQo+IMKgDQo+IMKgCXN0cnVjdCByYl9yb290
CQlyZWN2X3F1ZXVlOwkvKiBSZWNlaXZlIHF1ZXVlICovDQo+IGRpZmYgLS1naXQgYS9uZXQvc3Vu
cnBjL2NsbnQuYyBiL25ldC9zdW5ycGMvY2xudC5jDQo+IGluZGV4IGQ2ODA1YzEyNjhhNy4uNTg5
MTc1N2M4OGIxIDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL2NsbnQuYw0KPiArKysgYi9uZXQv
c3VucnBjL2NsbnQuYw0KPiBAQCAtMjc5LDYgKzI3OSw5IEBAIHN0YXRpYyBzdHJ1Y3QgcnBjX3hw
cnQNCj4gKnJwY19jbG50X3NldF90cmFuc3BvcnQoc3RydWN0IHJwY19jbG50ICpjbG50LA0KPiDC
oAkJY2xudC0+Y2xfYXV0b2JpbmQgPSAxOw0KPiDCoA0KPiDCoAljbG50LT5jbF90aW1lb3V0ID0g
dGltZW91dDsNCj4gKyNpZiBkZWZpbmVkKENPTkZJR19TVU5SUENfQkFDS0NIQU5ORUwpDQo+ICsJ
bWVtY3B5KCZ4cHJ0LT5iY190aW1lb3V0LCB0aW1lb3V0LCBzaXplb2Yoc3RydWN0DQo+IHJwY190
aW1lb3V0KSk7DQo+ICsjZW5kaWYNCj4gwqAJcmN1X2Fzc2lnbl9wb2ludGVyKGNsbnQtPmNsX3hw
cnQsIHhwcnQpOw0KPiDCoAlzcGluX3VubG9jaygmY2xudC0+Y2xfbG9jayk7DQo+IMKgDQo+IGRp
ZmYgLS1naXQgYS9uZXQvc3VucnBjL3hwcnQuYyBiL25ldC9zdW5ycGMveHBydC5jDQo+IGluZGV4
IDkyMzAxZTMyY2RhNC4uZDljYmUwODE0ZmQ4IDEwMDY0NA0KPiAtLS0gYS9uZXQvc3VucnBjL3hw
cnQuYw0KPiArKysgYi9uZXQvc3VucnBjL3hwcnQuYw0KPiBAQCAtNjU1LDkgKzY1NSwxNCBAQCBz
dGF0aWMgdW5zaWduZWQgbG9uZw0KPiB4cHJ0X2Fic19rdGltZV90b19qaWZmaWVzKGt0aW1lX3Qg
YWJzdGltZSkNCj4gwqANCj4gwqBzdGF0aWMgdW5zaWduZWQgbG9uZyB4cHJ0X2NhbGNfbWFqb3J0
aW1lbyhzdHJ1Y3QgcnBjX3Jxc3QgKnJlcSkNCj4gwqB7DQo+IC0JY29uc3Qgc3RydWN0IHJwY190
aW1lb3V0ICp0byA9IHJlcS0+cnFfdGFzay0+dGtfY2xpZW50LQ0KPiA+Y2xfdGltZW91dDsNCj4g
Kwljb25zdCBzdHJ1Y3QgcnBjX3RpbWVvdXQgKnRvOw0KPiDCoAl1bnNpZ25lZCBsb25nIG1ham9y
dGltZW8gPSByZXEtPnJxX3RpbWVvdXQ7DQo+IMKgDQo+ICsJaWYgKHJlcS0+cnFfdGFzay0+dGtf
Y2xpZW50KQ0KPiArCQl0byA9IHJlcS0+cnFfdGFzay0+dGtfY2xpZW50LT5jbF90aW1lb3V0Ow0K
PiArCWVsc2UNCj4gKwkJdG8gPSAmcmVxLT5ycV94cHJ0LT5iY190aW1lb3V0Ow0KPiANCg0KSWYg
eW91J3JlIGdvaW5nIHRvIGNvbnZlcnQgdGhpcyBmdW5jdGlvbiBmb3IgZ2VuZXJpYyB1c2UsIHRo
ZW4gcGxlYXNlDQpwYXNzIHRoZSB0aW1lb3V0ICd0bycgYXMgYSBmdW5jdGlvbiBwYXJhbWV0ZXIg
cmF0aGVyIHRoYW4gbWFraW5nDQphc3N1bXB0aW9ucyBoZXJlLg0KDQo+ICsNCj4gwqAJaWYgKHRv
LT50b19leHBvbmVudGlhbCkNCj4gwqAJCW1ham9ydGltZW8gPDw9IHRvLT50b19yZXRyaWVzOw0K
PiDCoAllbHNlDQo+IEBAIC02ODYsNyArNjkxLDExIEBAIHN0YXRpYyB2b2lkIHhwcnRfaW5pdF9t
YWpvcnRpbWVvKHN0cnVjdCBycGNfdGFzaw0KPiAqdGFzaywgc3RydWN0IHJwY19ycXN0ICpyZXEp
DQo+IMKgCQl0aW1lX2luaXQgPSBqaWZmaWVzOw0KPiDCoAllbHNlDQo+IMKgCQl0aW1lX2luaXQg
PSB4cHJ0X2Fic19rdGltZV90b19qaWZmaWVzKHRhc2stDQo+ID50a19zdGFydCk7DQo+IC0JcmVx
LT5ycV90aW1lb3V0ID0gdGFzay0+dGtfY2xpZW50LT5jbF90aW1lb3V0LT50b19pbml0dmFsOw0K
PiArDQo+ICsJaWYgKHRhc2stPnRrX2NsaWVudCkNCj4gKwkJcmVxLT5ycV90aW1lb3V0ID0gdGFz
ay0+dGtfY2xpZW50LT5jbF90aW1lb3V0LQ0KPiA+dG9faW5pdHZhbDsNCj4gKwllbHNlDQo+ICsJ
CXJlcS0+cnFfdGltZW91dCA9IHJlcS0+cnFfeHBydC0NCj4gPmJjX3RpbWVvdXQudG9faW5pdHZh
bDsNCg0KRGl0dG8uDQoNCj4gwqAJcmVxLT5ycV9tYWpvcnRpbWVvID0gdGltZV9pbml0ICsgeHBy
dF9jYWxjX21ham9ydGltZW8ocmVxKTsNCj4gwqAJcmVxLT5ycV9taW5vcnRpbWVvID0gdGltZV9p
bml0ICsgcmVxLT5ycV90aW1lb3V0Ow0KPiDCoH0NCj4gQEAgLTE5OTgsNiArMjAwNyw4IEBAIHhw
cnRfaW5pdF9iY19yZXF1ZXN0KHN0cnVjdCBycGNfcnFzdCAqcmVxLA0KPiBzdHJ1Y3QgcnBjX3Rh
c2sgKnRhc2spDQo+IMKgCSAqLw0KPiDCoAl4YnVmcC0+bGVuID0geGJ1ZnAtPmhlYWRbMF0uaW92
X2xlbiArIHhidWZwLT5wYWdlX2xlbiArDQo+IMKgCQl4YnVmcC0+dGFpbFswXS5pb3ZfbGVuOw0K
PiArDQo+ICsJeHBydF9pbml0X21ham9ydGltZW8odGFzaywgcmVxKTsNCj4gwqB9DQo+IMKgI2Vu
ZGlmDQo+IMKgDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50
YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K

