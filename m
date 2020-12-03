Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408D12CE13F
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 22:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLCV6g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 16:58:36 -0500
Received: from mail-bn8nam12on2112.outbound.protection.outlook.com ([40.107.237.112]:28493
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbgLCV6f (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 16:58:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQRwLnPcWHj1Ms/JP/5zuIjUATG4e5UHvtt9WVbnaWjweRihlw4Yzgb0EA+D6poADFsSLjCtaVqaDHNfZWIn5sf7Tk12ZkkyYdLKsM55k3u9mZcrww6nMOCXXiHlBRyeUz/6owXzfPvCmmrqwkzlKa6jZriaQEpnroLiWhlFBVAA7nc+wWdF11htjejqQoD9b4v8SzBCtWjO2DsRwaILLS4Z/cQuI/eHKvQk++xKMXagvDXRPVxqr5pgpgK9Wjl+ar6lXzd0KaPm6qLxJElKvlSJiJr0608s2vpqN3202iJScWM/e9HyMs5a3aaigrVrA6cn8RIg4Vhz2bEHFLqieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpJ7lX6ek/3lXryoduCveEPW5YOu4jW6OzW86OXdH6Q=;
 b=IVECobrlHPFinjdi76LyouvfGcIlAHO5l6lsEnHVGWr6k5Goz2qGrA7kzicl1c3ZZVWECL4Wt4KdSK3FMVGgo6bH7pT/+gHgFh52pfPK7VOof40uXOwxJ0ajm/oiHxigCcnLi/kXc9VsvJrm1IayCXHr2i5tZVUJ1jMihLv61+PDHOjX3jNFaS5uoBPZK75t8l6nN/ZXRRJiW0ch5081Nm262hrsLhKt2Ir9GJ8EPi4flwUJWy2DD+Vq7ml1RUlj0+ix772Wjr3+wRHgXyDcir4ReL3BmJH6fMmv3hUbVGS4Iqj3SxRzkwiOt0hVaO/oyRSbjxAKOGKaewnFKWoRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpJ7lX6ek/3lXryoduCveEPW5YOu4jW6OzW86OXdH6Q=;
 b=XIu+pMQjyChIRccv8+HSQQcZQgsxISZMvAs2Uz6xFOLWUDGPfPmXeFRpcHDzcBx7vYjofXoys+VvmkNkzAMGX+QDLbIhyKzZ3OXbblx1CALz0/WEUKzPcAgEkyUNruUSdVMwmnXni86VhHaBu08dei+zGUQHv8iDuv60MWGo+xs=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3534.namprd13.prod.outlook.com (2603:10b6:208:163::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Thu, 3 Dec
 2020 21:57:41 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Thu, 3 Dec 2020
 21:57:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "ffilzlnx@mindspring.com" <ffilzlnx@mindspring.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR4tJDJwAAAWCe4BeKhpLVGiQL7pUtKchSdvFeTqNAIAEhEYAgBNavQCAAAtBAIABTyGAgAxAb4CAAG0ggIAAGvSAgAAMzwCAAAXZAIAAAzUAgAADTAA=
Date:   Thu, 3 Dec 2020 21:57:41 +0000
Message-ID: <b9e8da547065f6a94bed22771f214fef91449931.camel@hammerspace.com>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
         <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
         <20201109160256.GB11144@fieldses.org>
         <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
         <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
         <20201124211522.GC7173@fieldses.org>
         <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
         <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
         <20201203185109.GB27931@fieldses.org>
         <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
         <20201203211328.GC27931@fieldses.org>
         <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
         <019001d6c9bd$acbeb6b0$063c2410$@mindspring.com>
In-Reply-To: <019001d6c9bd$acbeb6b0$063c2410$@mindspring.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d169f744-9531-42d4-552c-08d897d67517
x-ms-traffictypediagnostic: MN2PR13MB3534:
x-microsoft-antispam-prvs: <MN2PR13MB353478A1BAAC664E94A066F0B8F20@MN2PR13MB3534.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oElvgPJzucbBWGWqQz11eTEe4ZwO4P5De360ijoPK6aKciQLlbSwKzJikFiHF6Vd0WIndhNFdg7TyLIR7we8zq5St/QQfkuRCIGANF8C8O0/XaKjYh3yeSeZSAJ9YaxGc0QUpp2KGmz7uEEnfFIuHaX4XrYgy8C6N68f1PMPhryAp8Zda9AIdGsX05py8ORIzO9OgZBDrKl2k4EXm3rLhCe0uY9EUBylQU/USrimSgQxgkDgUvFXDdY9OGzA+OxEEVKbGkwZzqs/HT3gYB3JJNqyCyerYiEnPsqnqO7hbhkrBV6/3JdKtYbxP4bRkqh08Q/522vYLmQz1ccBxILFIAaVgVFtcdyJ/h3HbJKbkGr6yz1FECVAtWKy8AkvrS2oxcJ+XfSocSYiod0WcaRzYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(376002)(366004)(136003)(396003)(346002)(5660300002)(54906003)(6512007)(91956017)(66946007)(36756003)(16799955002)(966005)(71200400001)(8936002)(478600001)(8676002)(316002)(110136005)(83380400001)(4326008)(66446008)(186003)(6486002)(2616005)(64756008)(26005)(66476007)(6506007)(76116006)(66556008)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Tkh2ZUh6VExBdGdJUlFhd2VKdk14NGhLNmpyUjFrYkt5czE4N2xSUzkzV2Mw?=
 =?utf-8?B?bHpQUzdwd3p1bVN1MklYeEJWYWtpWStOTkpVYy8zZWlxczFFdjd0aVRDanpZ?=
 =?utf-8?B?Wm93enJMZ0ZmRVRoeThFdm5TUzVBV2ZiQVBQZ0VVMFE3a0Z4amFXNmwvUDJq?=
 =?utf-8?B?NUFJenpMVFpsb251Rm1Gdm9iSkFoOU1WQzlEUDAvMmw3aVZ2M3cwTmY4OTRw?=
 =?utf-8?B?NVcrUTk5UlkzbTdDZlpBSGNDNk04cW5Bc0hIMk9YUXFwWmlJMTNNR2k3Uktn?=
 =?utf-8?B?WnllSEVkYlJTZGdMVTZoUzZ4cXBoQTMwYWsvL0ZpdlVYMXMvTWh0enc3clhD?=
 =?utf-8?B?VDd1WHRqbzJoNDhsRmpXMEZGRGNOSEl6bXl5WHJCNmVZaDZGU1VVTC9vd2xO?=
 =?utf-8?B?OU1EZnRqeFlPbzRHSDdHVlNZbGhBSzRFN3BDUFJQZ291S09EKzNvUHRGL1Qz?=
 =?utf-8?B?U29tTkRMUGdpNExIWE8xcW1TRUlPQ3dPK1pVa1dqbm0wSnpmMlZZS1c1Y21O?=
 =?utf-8?B?b3lKdVZPT2dmd2hrVWR1Sk94d0I2SGsvQXl4dlFDbFlzZ1dWblpGN3doMHo3?=
 =?utf-8?B?TlhOSStGb3ZoOENHL05GL2FZazJ1M0loNGZjcGluNzIzZE12YlhheGdQY2FB?=
 =?utf-8?B?aDYrYnhnS2JJRWI4YnNFNVhPczNIRUhyb3VZZTBsZjNmUW1sSVFNaFhUTHc5?=
 =?utf-8?B?Sk9ja2dQUzlLdkRnV2o4K3VWTUZOREpWKzh4enZjTVk0RzV2c3JMZWpLZ1BO?=
 =?utf-8?B?ZnBXWm5KaTJYNjBJc3Iyd1ZOaTNkNGE4NnRqeDNEcFhFTjJtdkhOYjNSd2NY?=
 =?utf-8?B?dW5MN1hQQ2xqK1B6aVpHb3JCajNvYkJYNGFHSHN6V2FMNHZldm1kRDVYb1NM?=
 =?utf-8?B?cFhmMkNXRWtqOVpuTWl0S1VJUmpyWjhDSUNQQ1NvYjdLYit1RkZDd3pGallP?=
 =?utf-8?B?b3VNV056M3huWUFpemx4TG9BUXRsQ2NKd2VYbDJtZnhRWnRTODFBeVFnMXF5?=
 =?utf-8?B?STBEQzhvMUVEMU5hQzNBamZ1Y01penR1Ylc0azY3R1RvT21TdUpucmNDMDcx?=
 =?utf-8?B?cVUxWHlnTVhiQlpFZUFNbjROenpWS1hQMldxUGFCcG02UWRxbzAzRWVYQ2xJ?=
 =?utf-8?B?aTdCMGFsTElwcGpRTjVMdzFpMGc4MXV5alBwaXpWOEVFZ0ljT1JJQWtVcm1I?=
 =?utf-8?B?MXBYdlVXUHVyb3N1VThTT1BZNmJmTWFySUtMRTZOSXg2eFhjL043Y3ltUm5p?=
 =?utf-8?B?VER3Ykg5c25NczNoYTYvcnRKTk90MTM4M25zYkR1Tk1QV1JKOC9rSnRxeWdL?=
 =?utf-8?Q?y1hR+Alsw8JKX9MoIBRfD8cvMY6eJdgbwd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <94B202ADCEB7014CAB6C8BA82E0AA46A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d169f744-9531-42d4-552c-08d897d67517
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 21:57:41.4959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lGV/pGLj2o/5Ab6wpD2kPU+de7mhbRdcjQdRKMV2byAU8QtnHFG2T/mRR99yqhOWKWTo3XNUD3O2lBYuRBjMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3534
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDEzOjQ1IC0wODAwLCBGcmFuayBGaWx6IHdyb3RlOg0KPiA+
IE9uIFRodSwgMjAyMC0xMi0wMyBhdCAxNjoxMyAtMDUwMCwgYmZpZWxkc0BmaWVsZHNlcy5vcmfC
oHdyb3RlOg0KPiA+ID4gT24gVGh1LCBEZWMgMDMsIDIwMjAgYXQgMDg6Mjc6MzlQTSArMDAwMCwg
VHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBPbiBUaHUsIDIwMjAtMTItMDMgYXQgMTM6
NTEgLTA1MDAsIGJmaWVsZHMgd3JvdGU6DQo+ID4gPiA+ID4gSSd2ZSBiZWVuIHNjcmF0Y2hpbmcg
bXkgaGVhZCBvdmVyIGhvdyB0byBoYW5kbGUgcmVib290IG9mIGENCj4gPiA+ID4gPiByZS0NCj4g
PiA+ID4gPiBleHBvcnRpbmcgc2VydmVyLsKgIEkgdGhpbmsgb25lIHdheSB0byBmaXggaXQgbWln
aHQgYmUganVzdCB0bw0KPiA+ID4gPiA+IGFsbG93IHRoZSByZS0gZXhwb3J0IHNlcnZlciB0byBw
YXNzIGFsb25nIHJlY2xhaW1zIHRvIHRoZQ0KPiA+ID4gPiA+IG9yaWdpbmFsDQo+ID4gPiA+ID4g
c2VydmVyIGFzIGl0IHJlY2VpdmVzIHRoZW0gZnJvbSBpdHMgb3duIGNsaWVudHMuwqAgSXQgbWln
aHQNCj4gPiA+ID4gPiByZXF1aXJlDQo+ID4gPiA+ID4gc29tZSBwcm90b2NvbCB0d2Vha3MsIEkn
bSBub3Qgc3VyZS7CoCBJJ2xsIHRyeSB0byBnZXQgbXkNCj4gPiA+ID4gPiB0aG91Z2h0cw0KPiA+
ID4gPiA+IGluIG9yZGVyIGFuZCBwcm9wb3NlIHNvbWV0aGluZy4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+IEl0J3MgbW9yZSBjb21wbGljYXRlZCB0aGFuIHRoYXQuIElmIHRoZSByZS1l
eHBvcnRpbmcgc2VydmVyDQo+ID4gPiA+IHJlYm9vdHMsDQo+ID4gPiA+IGJ1dCB0aGUgb3JpZ2lu
YWwgc2VydmVyIGRvZXMgbm90LCB0aGVuIHVubGVzcyB0aGF0IHJlLWV4cG9ydGluZw0KPiA+ID4g
PiBzZXJ2ZXIgcGVyc2lzdGVkIGl0cyBsZWFzZSBhbmQgYSBmdWxsIHNldCBvZiBzdGF0ZWlkcw0K
PiA+ID4gPiBzb21ld2hlcmUsIGl0DQo+ID4gPiA+IHdpbGwgbm90IGJlIGFibGUgdG8gYXRvbWlj
YWxseSByZWNsYWltIGRlbGVnYXRpb24gYW5kIGxvY2sNCj4gPiA+ID4gc3RhdGUgb24NCj4gPiA+
ID4gdGhlIHNlcnZlciBvbiBiZWhhbGYgb2YgaXRzIGNsaWVudHMuDQo+ID4gPiANCj4gPiA+IEJ5
IHNlbmRpbmcgcmVjbGFpbXMgdG8gdGhlIG9yaWdpbmFsIHNlcnZlciwgSSBtZWFuIGxpdGVyYWxs
eQ0KPiA+ID4gc2VuZGluZw0KPiA+ID4gbmV3IG9wZW4gYW5kIGxvY2sgcmVxdWVzdHMgd2l0aCB0
aGUgUkVDTEFJTSBiaXQgc2V0LCB3aGljaCB3b3VsZA0KPiA+ID4gZ2V0DQo+ID4gPiBicmFuZCBu
ZXcgc3RhdGVpZHMuDQo+ID4gPiANCj4gPiA+IFNvLCB0aGUgb3JpZ2luYWwgc2VydmVyIHdvdWxk
IGludmFsaWRhdGUgdGhlIGV4aXN0aW5nIGNsaWVudCdzDQo+ID4gPiBwcmV2aW91cyBjbGllbnRp
ZCBhbmQgc3RhdGVpZHMtLWp1c3QgYXMgaXQgbm9ybWFsbHkgd291bGQgb24NCj4gPiA+IHJlYm9v
dC0tYnV0IGl0IHdvdWxkIG9wdGlvbmFsbHkgcmVtZW1iZXIgdGhlIHVuZGVybHlpbmcgbG9ja3MN
Cj4gPiA+IGhlbGQgYnkNCj4gPiA+IHRoZSBjbGllbnQgYW5kIGFsbG93IGNvbXBhdGlibGUgbG9j
ayByZWNsYWltcy4NCj4gPiA+IA0KPiA+ID4gUm91Z2ggYXR0ZW1wdDoNCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBodHRwczovL3dpa2kubGludXgtbmZzLm9yZy93aWtpL2luZGV4LnBocC9SZWJvb3Rf
cmVjb3ZlcnlfZm9yX3JlLWV4cG9yDQo+ID4gPiB0X3NlcnZlcnMNCj4gPiA+IA0KPiA+ID4gVGhp
bmsgaXQgd291bGQgZmx5Pw0KPiA+IA0KPiA+IFNvIHRoaXMgd291bGQgYmUgYSB2YXJpYW50IG9m
IGNvdXJ0ZXN5IGxvY2tzIHRoYXQgY2FuIGJlIHJlY2xhaW1lZA0KPiA+IGJ5IHRoZSBjbGllbnQN
Cj4gPiB1c2luZyB0aGUgcmVib290IHJlY2xhaW0gdmFyaWFudCBvZiBPUEVOL0xPQ0sgb3V0c2lk
ZSB0aGUgZ3JhY2UNCj4gPiBwZXJpb2Q/IFRoZQ0KPiA+IHB1cnBvc2UgYmVpbmcgdG8gYWxsb3cg
cmVjbGFpbSB3aXRob3V0IGZvcmNpbmcgdGhlIGNsaWVudCB0bw0KPiA+IHBlcnNpc3QgdGhlIG9y
aWdpbmFsDQo+ID4gc3RhdGVpZD8NCj4gPiANCj4gPiBIbW0uLi4gVGhhdCdzIGRvYWJsZSwgYnV0
IGhvdyBhYm91dCB0aGUgZm9sbG93aW5nIGFsdGVybmF0aXZlOiBBZGQNCj4gPiBhIGZ1bmN0aW9u
DQo+ID4gdGhhdCBhbGxvd3MgdGhlIGNsaWVudCB0byByZXF1ZXN0IHRoZSBmdWxsIGxpc3Qgb2Yg
c3RhdGVpZHMgdGhhdA0KPiA+IHRoZSBzZXJ2ZXIgaG9sZHMgb24NCj4gPiBpdHMgYmVoYWxmPw0K
PiA+IA0KPiA+IEkndmUgYmVlbiB3YW50aW5nIHN1Y2ggYSBmdW5jdGlvbiBmb3IgcXVpdGUgYSB3
aGlsZSBhbnl3YXkgaW4gb3JkZXINCj4gPiB0byBhbGxvdyB0aGUNCj4gPiBjbGllbnQgdG8gZGV0
ZWN0IHN0YXRlIGxlYWtzIChlaXRoZXIgZHVlIHRvIHNvZnQgdGltZW91dHMsIG9yIGR1ZQ0KPiA+
IHRvIHJlb3JkZXJlZA0KPiA+IGNsb3NlL29wZW4gb3BlcmF0aW9ucykuDQo+IA0KPiBPaCwgdGhh
dCBzb3VuZHMgaW50ZXJlc3RpbmcuIFNvIGJhc2ljYWxseSB0aGUgcmUtZXhwb3J0IHNlcnZlciB3
b3VsZA0KPiByZS1wb3B1bGF0ZSBpdCdzIHN0YXRlIGZyb20gdGhlIG9yaWdpbmFsIHNlcnZlciBy
YXRoZXIgdGhhbiByZWx5aW5nDQo+IG9uIGl0J3MgY2xpZW50cyBkb2luZyByZWNsYWltcz8gSG1t
LCBidXQgaG93IGRvZXMgdGhlIHJlLWV4cG9ydA0KPiBzZXJ2ZXIgcmVidWlsZCBpdHMgc3RhdGVp
ZHM/IEkgZ3Vlc3MgaXQgY291bGQgbWFrZSB0aGUgY2xpZW50cw0KPiByZXBvcHVsYXRlIHRoZW0g
d2l0aCB0aGUgc2FtZSAiZ2l2ZSBtZSBhIGR1bXAgb2YgYWxsIG15IHN0YXRlIiwgdXNpbmcNCj4g
dGhlIHN0YXRlIGRldGFpbHMgdG8gbWF0Y2ggdXAgd2l0aCB0aGUgb2xkIHN0YXRlIGFuZCByZXBs
YWNpbmcNCj4gc3RhdGVpZHMuIE9yIGRpZCB5b3UgaGF2ZSBzb21ldGhpbmcgZGlmZmVyZW50IGlu
IG1pbmQ/DQo+IA0KDQpJIHdhcyB0aGlua2luZyB0aGF0IHRoZSByZS1leHBvcnQgc2VydmVyIGNv
dWxkIGp1c3QgdXNlIHRoYXQgbGlzdCBvZg0Kc3RhdGVpZHMgdG8gZmlndXJlIG91dCB3aGljaCBs
b2NrcyBjYW4gYmUgcmVjbGFpbWVkIGF0b21pY2FsbHksIGFuZA0Kd2hpY2ggb25lcyBoYXZlIGJl
ZW4gaXJyZWRlZW1hYmx5IGxvc3QuIFRoZSBhc3N1bXB0aW9uIGlzIHRoYXQgaWYgeW91DQpoYXZl
IGEgbG9jayBzdGF0ZWlkIG9yIGEgZGVsZWdhdGlvbiwgdGhlbiB0aGF0IG1lYW5zIHRoZSBjbGll
bnRzIGNhbg0KcmVjbGFpbSBhbGwgdGhlIGxvY2tzIHRoYXQgd2VyZSByZXByZXNlbnRlZCBieSB0
aGF0IHN0YXRlaWQuDQoNCkkgc3VwcG9zZSB0aGUgY2xpZW50IHdvdWxkIGFsc28gbmVlZCB0byBr
bm93IHRoZSBsb2Nrb3duZXIgZm9yIHRoZQ0Kc3RhdGVpZCwgYnV0IHByZXN1bWFibHkgdGhhdCBp
bmZvcm1hdGlvbiBjb3VsZCBhbHNvIGJlIHJldHVybmVkIGJ5IHRoZQ0Kc2VydmVyPw0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
