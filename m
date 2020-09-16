Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB5426CD4D
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Sep 2020 22:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgIPU5B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Sep 2020 16:57:01 -0400
Received: from mail-co1nam11on2123.outbound.protection.outlook.com ([40.107.220.123]:8768
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbgIPQwi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Sep 2020 12:52:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abNJILevqXylK1DSUxAXmp7FQlQVS2O6+ffCsl2yXZo84+ixGSEVfIQJMH2zWfb59uzKV8kYtoIScV8dmgV7865sqO73V9D+Qty+NBD9voi0lIJCOB1Enf+/bBkn4rbaOgJFAPfccpVOhMfzBTEbP5v8ahL3bqE4bz1v/7dOI4NO8ABSisalhacGhaH1Pojq5dcMbOIthnTVC/qWgGddL1iosFQ3a/9uffobvf1PTnVqs0tQvutVTlcG/3MUZmMpa9RkySQap/+8QknxWSrNMfk7uDjUD8hPKXFCdlf9SIdZFK4RWNv4J1NQYaRkzA3skUCmWYsHv31QLkxcfspnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDqZfdmEDwPlvOQn1hLWvTb9sUIWVKpGWa7vBmqO8lw=;
 b=DdiYdU28/zea1XPfYSjg+liA3P0frIPutkRhubWTu1iipyBJy/iNaBM0hWq0I5x56okmOjMgLybRvruf5oNc109K7ZDK+NBKJyfun+2cznvKDyn1VBjdMoTCyWVwerzp6goeWb3QV5PVDbwOgv8BLA6wFsE90DklB+UIABQCa4q6TUQ5WHs1InP8bxEGhI50esPj/A3FUPoeTXJGkoh3DM6cGTclpQ4W1HlHd52kV3z57L2HWjDHN3undOhvVeMyP/pLb/hYgqLSHBAjXxQM3rKII0lw96VyOQnUwHvFCFbh4eiVTD4bDbcFq3NfOJ/Xui+NZi/kNzT/u1D1QqwfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDqZfdmEDwPlvOQn1hLWvTb9sUIWVKpGWa7vBmqO8lw=;
 b=PPUUTYOOo+ErWxVg4RGGkzWdOkEAxMK1886qgoq8ROZ+czGhrNrchoyy9t7NrrPzYZGiKr43ktg9+0iZDKw6S+MogMDoFDuFKaCz5D56uOF1Du8YZIpI2gjkQP2RH0uvSL6PSNIHCaW8OmLPQ9GZF2uPxJyjKU2nc2TAf8NnAzg=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3152.namprd13.prod.outlook.com (2603:10b6:208:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.9; Wed, 16 Sep
 2020 15:14:52 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3412.004; Wed, 16 Sep 2020
 15:14:52 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "fllinden@amazon.com" <fllinden@amazon.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: Re: [PATCH] nfs: round down reported block numbers in statfs
Thread-Topic: [PATCH] nfs: round down reported block numbers in statfs
Thread-Index: AQHWh63rpBtl6EcLe0Gc5o9tw8GbKqlraOIA
Date:   Wed, 16 Sep 2020 15:14:52 +0000
Message-ID: <38d81562153d8168a54d93f452407a24f5cf5240.camel@hammerspace.com>
References: <20200910200644.8165-1-fllinden@amazon.com>
In-Reply-To: <20200910200644.8165-1-fllinden@amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 430d3809-0158-43fb-3453-08d85a5342ee
x-ms-traffictypediagnostic: MN2PR13MB3152:
x-microsoft-antispam-prvs: <MN2PR13MB3152BFEE0BDEDEE01DAA76F8B8210@MN2PR13MB3152.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8bo4NTry1gPPEZbyyxl77CHz/5qhv11OuNX1FoJy9jA/28lAcFA1WqdY0mg9bPIhBYGokeQuZj4NENmoyvyogHcMlW4Ym0WlxnhLpSXxSVdlD/pySnhHo+iiEJeTl3jbfqjeBv+ZrzgFT+hY/UJhFW0e/JZ+dHYr/ZFQwoGMqeS4JXdF9MHoydQHqWRiBhDCbj3sHAV8DPw4++gr+G/Phe3Ej5F6apykOQbjAGrX50L5LlxMXCzfiNAg3r2BFmXNomAHF7iaMGEd837BJ+Puf9gsgWGXiQyoI0vbu2qHrY2lDOJXVgJVOUeCjZs4Mt9S7AQmbGNDmoc9cHzmnSr6VV/VFL0jEHTImnA4tX+fiJZ0ukXihSu46o7iR0dIskGy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39830400003)(376002)(396003)(83380400001)(110136005)(5660300002)(6506007)(26005)(86362001)(478600001)(6486002)(71200400001)(316002)(8936002)(66476007)(2906002)(6512007)(8676002)(186003)(2616005)(64756008)(36756003)(76116006)(91956017)(66556008)(66946007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6L0SJp/nvDmgx1bUniLIIuXLRedsCxgm8+m6zQSBO13Qs6RgrMVR6dBr5+CNobQJqqWoRQky4MzuA62f4lNuWbj4jJTplOR+l+gTK3Gp2+PkLAqpePpHBsI87Z19JVBgmnPdTAWIc5jZSXS335iaY/zwGT0EXdZrfgfakQ3rmMC2rnnzhDz17TkWT85hUaxberdnJk07ag7yVjkKiRPgHfqb1yQfTUQyieoSLtI842w7CgQnozGaJL5V5/h8nlwRpo/1z2tnCaATSLyz0xcvyoKz8D99AeEtiCViUwwIh5p+BR/KzQF3CI3SgZsWaARx0nZitz45sIH53D4r2Frr0URBp57Vp0TldnsP6juAIBS6Oj91tF9VdcjMtl4PoNiNcUTqJoX89h8T5yhuKoUzvp1x8ik6Uo1yTYmEjV2k3Hz1zx6YDn9P9/P4GPAFgCavduNapIxUX+tdCrvLK1C7FYWIrnhNfoxTmxMykGhDWi3X+kJxiSwaHNZfHAf0YdYCBsV1hYztm5mBrQWRXSOaJ5+w6Rn4FiTiQEZSarFrByPFlUQa9Hi0tIGsY2otWbI7NOQhWmvUJgF1EufKmYwHgp2fPl8ad7FrIMxFKssln7p/9qUuuKJ4aEZVB7rRtB6w88ZKExBRdf2Vo2YJd8q5NQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB4113E918262748B45B2B010BA637B5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 430d3809-0158-43fb-3453-08d85a5342ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 15:14:52.3462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zr+dzrMb/C4k6MccTvzgGPe3pOdWbjfOnSG8arhYETIvs46HhTTpbaoKXIaCk5lcrWYMFW2QaT3V5W/ZcoRBGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3152
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDIwOjA2ICswMDAwLCBGcmFuayB2YW4gZGVyIExpbmRlbiB3
cm90ZToNCj4gbmZzX3N0YXRmcyByb3VuZHMgdXAgdGhlIG51bWJlcnMgb2YgYmxvY2tzIGFzIGNv
bXB1dGVkDQo+IGZyb20gdGhlIG51bWJlcnMgdGhlIHNlcnZlciByZXR1cm4gdmFsdWVzLg0KPiAN
Cj4gVGhpcyB3b3JrcyBvdXQgd2VsbCBpZiB0aGUgY2xpZW50IGJsb2NrIHNpemUsIHdoaWNoIGlz
DQo+IHRoZSBzYW1lIGFzIHdyc2l6ZSwgaXMgc21hbGxlciB0aGFuIG9yIGVxdWFsIHRvIHRoZSBh
Y3R1YWwNCj4gZmlsZXN5c3RlbSBibG9jayBzaXplIG9uIHRoZSBzZXJ2ZXIuDQo+IA0KPiBCdXQs
IGZvciBORlM0LCB0aGUgc2l6ZSBpcyB1c3VhbGx5IGxhcmdlciAoMU0pLCBtZWFuaW5nDQo+IHRo
YXQgc3RhdGZzIHJlcG9ydHMgbW9yZSBmcmVlIHNwYWNlIHRoYW4gYWN0dWFsbHkgaXMNCj4gYXZh
aWxhYmxlLiBUaGlzIGNvbmZ1c2VzLCBmb3IgZXhhbXBsZSwgZnN0ZXN0IGdlbmVyaWMvMTAzLg0K
PiANCj4gR2l2ZW4gYSBjaG9pY2UgYmV0d2VlbiByZXBvcnRpbmcgdG9vIG11Y2ggb3IgdG9vIGxp
dHRsZQ0KPiBzcGFjZSwgdGhlIGxhdHRlciBpcyB0aGUgc2FmZXIgb3B0aW9uLCBzbyBkb24ndCBy
b3VuZA0KPiB1cCB0aGUgbnVtYmVyIG9mIGJsb2Nrcy4gVGhpcyBhbHNvIHNpbXBsaWZpZXMgdGhl
IGNvZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayB2YW4gZGVyIExpbmRlbiA8ZmxsaW5k
ZW5AYW1hem9uLmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvc3VwZXIuYyB8IDI1ICsrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDIxIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL25mcy9zdXBlci5jIGIvZnMvbmZzL3N1
cGVyLmMNCj4gaW5kZXggN2E3MDI4N2YyMWEyLi40NWQzNjhhNWNjOTUgMTAwNjQ0DQo+IC0tLSBh
L2ZzL25mcy9zdXBlci5jDQo+ICsrKyBiL2ZzL25mcy9zdXBlci5jDQo+IEBAIC0yMTcsOCArMjE3
LDYgQEAgRVhQT1JUX1NZTUJPTF9HUEwobmZzX2NsaWVudF9mb3JfZWFjaF9zZXJ2ZXIpOw0KPiAg
aW50IG5mc19zdGF0ZnMoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3Qga3N0YXRmcyAqYnVm
KQ0KPiAgew0KPiAgCXN0cnVjdCBuZnNfc2VydmVyICpzZXJ2ZXIgPSBORlNfU0IoZGVudHJ5LT5k
X3NiKTsNCj4gLQl1bnNpZ25lZCBjaGFyIGJsb2NrYml0czsNCj4gLQl1bnNpZ25lZCBsb25nIGJs
b2NrcmVzOw0KPiAgCXN0cnVjdCBuZnNfZmggKmZoID0gTkZTX0ZIKGRfaW5vZGUoZGVudHJ5KSk7
DQo+ICAJc3RydWN0IG5mc19mc3N0YXQgcmVzOw0KPiAgCWludCBlcnJvciA9IC1FTk9NRU07DQo+
IEBAIC0yNDEsMjYgKzIzOSwxMSBAQCBpbnQgbmZzX3N0YXRmcyhzdHJ1Y3QgZGVudHJ5ICpkZW50
cnksIHN0cnVjdA0KPiBrc3RhdGZzICpidWYpDQo+ICANCj4gIAlidWYtPmZfdHlwZSA9IE5GU19T
VVBFUl9NQUdJQzsNCj4gIA0KPiAtCS8qDQo+IC0JICogQ3VycmVudCB2ZXJzaW9ucyBvZiBnbGli
YyBkbyBub3QgY29ycmVjdGx5IGhhbmRsZSB0aGUNCj4gLQkgKiBjYXNlIHdoZXJlIGZfZnJzaXpl
ICE9IGZfYnNpemUuICBFdmVudHVhbGx5IHdlIHdhbnQgdG8NCj4gLQkgKiByZXBvcnQgdGhlIHZh
bHVlIG9mIHd0bXVsdCBpbiB0aGlzIGZpZWxkLg0KPiAtCSAqLw0KPiAtCWJ1Zi0+Zl9mcnNpemUg
PSBkZW50cnktPmRfc2ItPnNfYmxvY2tzaXplOw0KDQpOQUNLLiBUaGlzIGNvbW1lbnQgYW5kIGV4
cGxpY2l0IHNldHRpbmcgaXMgdGhlcmUgdG8gZG9jdW1lbnQgd2h5IHdlJ3JlDQpub3QgcHJvcGFn
YXRpbmcgdGhlIHRydWUgdmFsdWUgb2YgdGhlIGZpbGVzeXN0ZW0gYmxvY2sgc2l6ZS4gUGxlYXNl
IGRvDQpub3QgcmVtb3ZlIGl0Lg0KDQo+IC0NCj4gLQkvKg0KPiAtCSAqIE9uIG1vc3QgKm5peCBz
eXN0ZW1zLCBmX2Jsb2NrcywgZl9iZnJlZSwgYW5kIGZfYmF2YWlsDQo+IC0JICogYXJlIHJlcG9y
dGVkIGluIHVuaXRzIG9mIGZfZnJzaXplLiAgTGludXggaGFzbid0IGhhZA0KPiAtCSAqIGFuIGZf
ZnJzaXplIGZpZWxkIGluIGl0cyBzdGF0ZnMgc3RydWN0IHVudGlsIHJlY2VudGx5LA0KPiAtCSAq
IHRodXMgaGlzdG9yaWNhbGx5IExpbnV4J3Mgc3lzX3N0YXRmcyByZXBvcnRzIHRoZXNlDQo+IC0J
ICogZmllbGRzIGluIHVuaXRzIG9mIGZfYnNpemUuDQo+IC0JICovDQo+ICAJYnVmLT5mX2JzaXpl
ID0gZGVudHJ5LT5kX3NiLT5zX2Jsb2Nrc2l6ZTsNCj4gLQlibG9ja2JpdHMgPSBkZW50cnktPmRf
c2ItPnNfYmxvY2tzaXplX2JpdHM7DQo+IC0JYmxvY2tyZXMgPSAoMSA8PCBibG9ja2JpdHMpIC0g
MTsNCj4gLQlidWYtPmZfYmxvY2tzID0gKHJlcy50Ynl0ZXMgKyBibG9ja3JlcykgPj4gYmxvY2ti
aXRzOw0KPiAtCWJ1Zi0+Zl9iZnJlZSA9IChyZXMuZmJ5dGVzICsgYmxvY2tyZXMpID4+IGJsb2Nr
Yml0czsNCj4gLQlidWYtPmZfYmF2YWlsID0gKHJlcy5hYnl0ZXMgKyBibG9ja3JlcykgPj4gYmxv
Y2tiaXRzOw0KPiArDQo+ICsJYnVmLT5mX2Jsb2NrcyA9IHJlcy50Ynl0ZXMgLyBidWYtPmZfYnNp
emU7DQo+ICsJYnVmLT5mX2JmcmVlID0gcmVzLmZieXRlcyAvIGJ1Zi0+Zl9ic2l6ZTsNCj4gKwli
dWYtPmZfYmF2YWlsID0gcmVzLmFieXRlcyAvIGJ1Zi0+Zl9ic2l6ZTsNCj4gIA0KPiAgCWJ1Zi0+
Zl9maWxlcyA9IHJlcy50ZmlsZXM7DQo+ICAJYnVmLT5mX2ZmcmVlID0gcmVzLmFmaWxlczsNCg0K
QXMgZmFyIGFzIEkgY2FuIHRlbGwsIGFsbCB3ZSdyZSBkb2luZyBoZXJlIGlzIGNoYW5naW5nIHJv
dW5kaW5nIHVwIHRvDQpyb3VuZGluZyBkb3duLCBzaW5jZSBkZW50cnktPmRfc2ItPnNfYmxvY2tz
aXplIHNob3VsZCBhbHdheXMgZXF1YWwgdG8NCigxIDw8IGRlbnRyeS0+ZF9zYi0+c19ibG9ja3Np
emVfYml0cykuDQoNCk90aGVyd2lzZSwgc3dpdGNoaW5nIGZyb20gYSBzaGlmdCB0byBkaXZpc2lv
biBzZWVtcyBsaWtlIGl0IGlzIGp1c3QNCm1ha2luZyB0aGUgY2FsY3VsYXRpb24gbGVzcyBlZmZp
Y2llbnQuIFdoeT8NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFp
bnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0K
DQo=
