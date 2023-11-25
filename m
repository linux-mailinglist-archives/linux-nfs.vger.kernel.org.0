Return-Path: <linux-nfs+bounces-74-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09807F9062
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Nov 2023 00:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550402812B8
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Nov 2023 23:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43972D056;
	Sat, 25 Nov 2023 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="YcPMfZuI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2109.outbound.protection.outlook.com [40.107.93.109])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4483B127
	for <linux-nfs@vger.kernel.org>; Sat, 25 Nov 2023 15:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7c4hExpDjMb6r8128+6dyC9mGRSvLfyfxy1DdFPo2wVF96ZJqu7JicVv5v07UOin00pvLC06wdLUb4VArKX4EnhnUnTm2GmqaPAoeUGdnM5n0Os+Abw19U3BcbCUcVeDNIoM4fZ2sHy2y+fKa+YFInZEMdS1dlk2L1+gy9KoMVhe+XxIxqhQashhaHZTSNq7yJsSwKjTm0JF4ShHybrEpYcLW+Kj3sLmjLsXCn6Z0319YOgSqLKCU8gHdjc2i23/o3tnS4VJAyPLQAsVEjvt9aICslmMv+Ho9XVw4sdxuMJtSP2k3cKT5SlxEvzdJ6YTd39BzHtCHJ1bh57+x2rmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ1ko+cBiodD7L0ktWHd7Qyx1/naM6DAkr64uCDzh0I=;
 b=Du0zaCBdsyLvBqqzBNH1N0dEfiCQdiIrw/QP6lWPpJU352gj0UkCShEG3ELcXqIwCPCEpzVZ135E7esxVZRAVhwbE87amJmpwRwBDiMT1BvZNuTDkBox9YlQF/S42LZyH/ZJN2BxuEUuO3eTeVQ3gCPBvd/xVDY/f8M3/+svlRob45qc+Viz9HW5rdMreDcK+IXvFjiwrJrPIW7/t+TCrXqrmMkijGM5KWAb/8t9VYLayQLpilKhjV5aw3QDMTIL/oPVW/WsgPsYqBUo/b7GpoKcJAHgYcL7w8oL458Gr0Qu29U6WOE0RbeEe3tkat743zVJqqeqqDSWKg3yUA+wyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ1ko+cBiodD7L0ktWHd7Qyx1/naM6DAkr64uCDzh0I=;
 b=YcPMfZuIRVgCy0ZG18dikt+3U6Ge1ON+VkLxs2BnfF3cl7LwCWAOdRv1IlIyi5Y5e3qlfO1XTc/fi3BxRVvbqeqErFIv78v4MvpCL0/sOKUbRlBaYQULPoIrwdvrTDRwYz3P3T1/5M1nKYkhNchlXWddWAQPm/O3knp/SFvaK6E=
Received: from BL3PR13MB5073.namprd13.prod.outlook.com (2603:10b6:208:33c::7)
 by SJ0PR13MB5756.namprd13.prod.outlook.com (2603:10b6:a03:40f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sat, 25 Nov
 2023 23:54:48 +0000
Received: from BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::d405:57ad:ac67:fb8c]) by BL3PR13MB5073.namprd13.prod.outlook.com
 ([fe80::d405:57ad:ac67:fb8c%4]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 23:54:48 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "tao.lyu@epfl.ch"
	<tao.lyu@epfl.ch>
Subject: Re: Question about O_APPEND | O_DIRECT
Thread-Topic: Question about O_APPEND | O_DIRECT
Thread-Index: AQHaHjflhODFfyeMXUSkxSGiPt/2HLCLuRkA
Date: Sat, 25 Nov 2023 23:54:48 +0000
Message-ID: <2d948b43fa625952e50589e4bedf9551df7ee112.camel@hammerspace.com>
References: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
In-Reply-To: <c609e5f9df75438dbfe3810859935d58@epfl.ch>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR13MB5073:EE_|SJ0PR13MB5756:EE_
x-ms-office365-filtering-correlation-id: cbc0840e-2dc8-42de-b920-08dbee11e834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 009t1MgKd7/nIVn+841FwA0dKf0pue2ttgP9iyuGW+W++YQZ1lYBpDqxUq6Xqn86/Uu+x8F83G4MIV9v3B+ITdqwFIWFgiUxt6pwc9nVX5vTHwaIPj4C65epjgNH69+v6wviAFKcYGH66eSA5oNgLqyr1Zr94n65ZC2cMjTPB3trsDVo/PfqrVfCLAgPECtXeB04h1Cepsm8o4FLxLoBqBYIt5Q07ExB8i9efTsPiD/NcZWPaswNwLlq+01R5TzcymguXWbumnQ2YikTRFtbNBBpGTdyMkySP+3kmKVkZyXjf+T4NoCfDuVR/CtIBS4iyPfm5gmOOHOCfhTDKqishxeHWytTUBuHsr2JygFIbvC0LYodiZjt4UfN7fH5m9QubDhnUWnTFTeRs751oVXQ0ElsdEQOrSnbVuiGA6wvResKIPlfX7l3RwK8vLaH9BMRN50J3CqASxA+GzXRnaEq37RpEpRpcu8DKet2+JBX9h541S9OtFzcsp8m2Xd5z1BwI7BEobVj5maTfAMAkEeIB19KK+JG/+PYB+Hr1T1SR9N000cqJ2svGzNBk23Qmbag0AFgyzk3C0myCf+AFPAa7/wVEyH7bwU4pAKKNQelAstBiobGXucSmD1jvs41WQElRUj4BDr9R28FgPbP3DibT2kQBp16TC6StQ20GB3GObw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR13MB5073.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39830400003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(76116006)(66556008)(66476007)(66446008)(64756008)(316002)(66946007)(8936002)(8676002)(478600001)(6486002)(91956017)(110136005)(36756003)(86362001)(5660300002)(41300700001)(2906002)(4001150100001)(122000001)(38100700002)(71200400001)(2616005)(6506007)(6512007)(83380400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NThydGQ1OXIyNHNmSEdQRXc1c0t2SmRaaWlvQXZ2b2M5WVI5UHZoY1lwek9S?=
 =?utf-8?B?RHpDR3RqczNtY2U5ZUdBUTFNb2pudlM0Z3BCckhVWEdBZlpJbWVsb2pISEZx?=
 =?utf-8?B?QXBhNkI0dmFXbDdicGI1YU5YTlpxWWxMeENzL1BlV2FyVndXRXJIQ3lTaHFQ?=
 =?utf-8?B?WlQ2cVkxYmQyN2RYZjIzeEhCU3phVkNXWkNCWDRLSW52RWJyWEJ1YWtpSG1L?=
 =?utf-8?B?cXV3OGQ4S0ZVK2VVT1FPemVzSUVCQmNhT1VNdEFnQ1dnQk5RT0h5YWlXTkpw?=
 =?utf-8?B?N1MwTmFtek1HUExiREQxNE15SmU0aVhHdzQ4Q2hBWWtjMlh0T2I3YXdzN3VF?=
 =?utf-8?B?Ulh5d3RwVUtzSDl2MmJVVitxNitWbXFQUHl0bzYyQmt6aytWWUQ0eFpHMmVi?=
 =?utf-8?B?bUdKeVBwZHBLNWNZYU4xMHFER1JZelhPSmJLUkFqbzRxc0xIa3NsZzJyS24v?=
 =?utf-8?B?eGdJblZZemJCWmw1N1RTM0sxQkczWDBtSmhPWmdwbDNPMEJ2YU15TEpUSTFm?=
 =?utf-8?B?c1RUM3YrbllUTWxyd2RFQjR6M2VQWkJPRmNRMEoxM3gybXNMODZkNWQ0dlp2?=
 =?utf-8?B?aDNsWDZPWHFUeWt0Sjh6MGxaenhDNWNtTmhDb0xFN2VxZDEzbDdnUW1oci80?=
 =?utf-8?B?eDZIbVVuZ1lYZ1dvZTVjb2h0WWdpelVqRDZwK2p1YTRrbk4zalYvNlArcEFw?=
 =?utf-8?B?KzVZTC9hQVdCTGVPUVIvK005RjZqVSt3MWZBbGF5UnhYdEVZcHVKZkg5cktr?=
 =?utf-8?B?RnY3QlVsVHRvWWlmdStHdzAxVk0zK3QzQkJnT3hYZE9pbHFadkFsSElqb0hm?=
 =?utf-8?B?Y3UzaTV6Mi9RbFFzbmJFU3l6Ulp1Q2t3dS9DOWtFSnljekx5eXBqanZCOHlx?=
 =?utf-8?B?aTJlbWlUR3pNNGRoenVYMjRIazNIYzVncms5cVJTVHpjbnhDUFJsTWdKcUZh?=
 =?utf-8?B?RTREOVJkcThDVmlla09OWkpjeTkrVTREcGpPZVdza3JJbTBmTGZWRzRWRzRj?=
 =?utf-8?B?bkw0dll3QzNnWmNDZjhEZkpmMnNZVHBjZFRPOWVTRzZFczhwT2RqMkNoNzk4?=
 =?utf-8?B?WjFNWjVETDJQaDg5dFdJZFVMNE5TYXE1TjdVSDRVRThuNi9XdjFOME9jaDV5?=
 =?utf-8?B?NlprcDlnSnoxdUdVMjRzZG5VYW9TSzBVa3lvNHU1WmZNc3J1enp0bWx0YUFs?=
 =?utf-8?B?ald5ZWZhRzdDVTBzTnA4cHBPdUN6VVVEM3FFbmxJWXFTMlZ1OEtlaVpiYUpF?=
 =?utf-8?B?OXIvT29jSlk2Z1lDNXc1V1kxL0YvZlJYbFB2ZWJQTlBqU2hrMk5POWRDV2x1?=
 =?utf-8?B?ZnJJQXN4T2l1MDIwbCtnY3FUVlRjMHJrcUxIbFdwL1l6RHlic3p1SytCK2Vs?=
 =?utf-8?B?UnVtRjMyY1ZONTBEb0phem9NSDUxZlNTS0Vnd1dQQWllelQwbFlyUW9HbWdQ?=
 =?utf-8?B?di9pempsTEJrRmpRTTVJOEljU05pbFp5Q2g2QmY4SmgzdTNRQlBMSEVxL2Jn?=
 =?utf-8?B?RmVrOXRtdDZXS01KYmNBU081UGtVeHlUVTlBaHpHcG5SOEVPVzVNMkF1RHBh?=
 =?utf-8?B?Z05vWFo1SHdhcldlWDF5OFdiSUQwRUdWS2JKSU5hOHM2amxKaWdiUWhCeFBs?=
 =?utf-8?B?UWVuUnZ5bEFnWU9oM3JGSUgxcFRQNE9WMTJUWCtCTElZZXA3c2JaRTA4dGNR?=
 =?utf-8?B?WDVLMFo3UTdsNWo0VzBXalczTVFmcS9obmM0V1pmR0tlVUVjYjZLb2VUeVR2?=
 =?utf-8?B?SHFGMlF4S3E3bGd0bi9TNmJBQ2U1cGVLTGMzeEdmYjgxL0tzTEtPaFkyb0RD?=
 =?utf-8?B?U2tqaGZUOVUybkVIWmpGZVc5ZUpqekRBdEpwc29LVlJlaGdzMDVIKzI2dUlZ?=
 =?utf-8?B?a1NRa1RKbk1NQitxZi80QjlYbHdPTVVUaVo1cm10cTlmUDZYSkZqRkdkQnRp?=
 =?utf-8?B?eFZ4Q3RBZCs1OGltVTl3Q25oV3F4aVlBRHVjdW5UdUd4SWQvcWhrYXBDaXZz?=
 =?utf-8?B?MEtkZVBRVmlUT2s0R1VBTnBJK2cxREpaR0psdXV3eTBGNTVYd3Zta0JGeFVj?=
 =?utf-8?B?amEwVkUwZEZ4NCs2bUw4QVRRWktLVy9xU1orQXJlMFB6WVVvZThQZnp0YzRq?=
 =?utf-8?B?MWJzZXRDejhVeUNDM0FMVXhRb1J5Sy9IdWVURzZyY0srMUlhQzVsN0lSaHRn?=
 =?utf-8?B?L1N5SzRNMkhHNy91VFRoT09lUXlpcDBZVzEzeXdlNHpaMmNibzNoQ2lnWkV6?=
 =?utf-8?B?c3BVSGQzNDhWdGxRZUVlb052OXJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C129ADDE0C17DE4EAF871D5E8EE64F60@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR13MB5073.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc0840e-2dc8-42de-b920-08dbee11e834
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2023 23:54:48.0394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FrK6w9oJgqx7fcZ++dgvzCZJXHUCUpwgUFpqlddFChxpKcIlpbNn2wXP31vdvhjICW82AFVHrwzhTJOr7TrUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5756

T24gVGh1LCAyMDIzLTExLTIzIGF0IDE4OjE0ICswMDAwLCBUYW8gTHl1IHdyb3RlOg0KPiBIaSwN
Cj4gDQo+IFNvcnJ5IHRvIGJvdGhlciB5b3UgaGVyZS4NCj4gDQo+IEknbSB1c2luZyBORlMgYW5k
IHJlYWxpemUgaXQgZG9lc24ndCBzdXBwb3J0IG9wZW5pbmcgYSBmaWxlIHdpdGgNCj4gIk9fRElS
RUNUIHwgT19BUFBFTkQiLg0KPiANCj4gQWZ0ZXIgY2hlY2tpbmcgdGhlIHNvdXJjZSBjb2RlLCAN
Cj4gSSBmb3VuZCBpdCBoYXMgb25lIGZ1bmN0aW9uIHRoYXQgY2hlY2tzIGV4cGxpY2l0bHkgd2hl
dGhlciB0aGVyZSBpcyBhDQo+IGNvbWJpbmF0aW9uIGZsYWcgb2YgIk9fQVBQRU5EIHwgT19ESVJF
Q1QiLg0KPiBJZiBzbywgaXQgd2lsbCByZXR1cm4gaW52YWxpZCBhcmd1bWVudHMuDQo+IA0KPiBp
bnQgbmZzX2NoZWNrX2ZsYWdzKGludCBmbGFncykNCj4gew0KPiDCoMKgwqAgaWYgKChmbGFncyAm
IChPX0FQUEVORCB8IE9fRElSRUNUKSkgPT0gKE9fQVBQRU5EIHwgT19ESVJFQ1QpKQ0KPiDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsNCj4gDQo+IMKgwqDCoCByZXR1cm4gMDsNCj4gfQ0K
PiANCj4gQnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgTkZTIGRvZXNuJ3Qgc3VwcG9ydCB0aGlz
IGZsYWcgY29tYmluYXRpb24uDQo+IEknZCBhcHByZWNpYXRlIGl0IGlmIHNvbWVvbmUgY291bGQg
ZXhwbGFpbiB0aGlzIHRvIG1lLg0KDQoNCldoeSBkbyB5b3UgbmVlZCBPX0FQUEVORHxPX0RJUkVD
VD8NCg0KSW4gb3JkZXIgdG8gaW1wbGVtZW50IE9fQVBQRU5EfE9fRElSRUNULCB3ZSB3b3VsZCBu
ZWVkIHRvIGFkZCBhbiBBUFBFTkQNCm9wZXJhdGlvbiwgd2hpY2ggZG9lcyBub3QgZXhpc3QgaW4g
dGhlIE5GUyBwcm90b2NvbC4gVGhlIFdSSVRFDQpvcGVyYXRpb24gZG9lcyBub3Qgc3VmZmljZSwg
YmVjYXVzZSBpdCByZXF1aXJlcyB5b3UgdG8ga25vdyB0aGUgb2Zmc2V0DQphdCB3aGljaCB5b3Ug
d2lsbCBiZSB3cml0aW5nIHRoZSBkYXRhLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXgg
TkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbQ0KDQoNCg==

