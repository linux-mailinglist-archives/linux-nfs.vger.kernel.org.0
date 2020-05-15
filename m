Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2721D5622
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2020 18:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgEOQeA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 May 2020 12:34:00 -0400
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:39360
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbgEOQd7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 May 2020 12:33:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeehqatRFq1nExk52bSsMZy5ixf4PFKPiAi9102ujH41F+2T3hskvZ5yBtTUcekaH0veiT6Gohmxmv4wETQZ6dmeidwDUaMVhAXJEs7iuHS8nHY3jpv3Njqo44zG0C5X6eGcqotxCd8YfLpZN3FUmC5PUbeHzu0b5rKLuKATRpz7I+UfOl8vfpKisU4H1twHZA8y86V1oxWsOvVGOoh1A75MULdFjKAaPkgWzYJqJYVnA18ge6JYYA5yhEBZiCkZS80ypOMqRTh8rJX1KG+2DRqRizMUWD0UZKJiW8nKoLzwTUHGPRrYKy76HTpTKe2BAu3/0lS3E40B2DAvdjjd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EKnxHDURaPKCMZwe7qDKs4mWoL92zTnQkjGbhjqBno=;
 b=VBntkoJTBFoJVivx2iEG9av1wUSK1yfOs74UkdtIvelj3RhWvQl6f8IKkB7wLxDgX3WVbnP8OzXw/b/yBVCY4FukHonizOycGoi6jcEhx+SGcN5ZEx36Ul62PEHL52mdCLC13+0cBY0RvbzSarwT8fWEwhzEufYGXmTG9ku0s25hglCeVT5bB5KlgsrJA9irMb7x8dpwSsfQt2RuOImO2B2hPyHl62r8EGkyF5eWkuzgSp1xYWrrTMn8sbgs8/Ysuir4UhoXeo7SGx6khDF5ar3eSItMvqn2uXS8pfVrHKD4qY1/xkhBjdDRyO0HY/i4u2MCF0v68vjjDsrkOMlmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EKnxHDURaPKCMZwe7qDKs4mWoL92zTnQkjGbhjqBno=;
 b=ZXQPqHRjS351tcjgGfINV3xz3kmU/adqHDWD5BsVuUaf9mo2dglcJ4QmpVaBtg4uQtUMCzp4CpvUpXz3agPTf9gTLT9eR9HoYUDKfNU5HaRhQt3Erza92qIrzr0MM2KKVRYmGSsRXIXnxAuYsaJtvZbPZA11kHjLk+iN/9ebTww=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3416.namprd13.prod.outlook.com (2603:10b6:610:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.13; Fri, 15 May
 2020 16:33:55 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3021.010; Fri, 15 May 2020
 16:33:55 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: linux-next: Tree for May 15 (nfs/fsinfo.c)
Thread-Topic: linux-next: Tree for May 15 (nfs/fsinfo.c)
Thread-Index: AQHWKs10cNVAkOG0JEGfeV/Heq6q16ipV1UAgAAATYA=
Date:   Fri, 15 May 2020 16:33:55 +0000
Message-ID: <911066e2232f1437d2d924592d02279dd44722ee.camel@hammerspace.com>
References: <20200515224219.48a50b28@canb.auug.org.au>
         <129e8dee-76c3-ba9d-e692-d145653bbaaa@infradead.org>
         <ef6274c2de9fcc2e1820db1ac8f0b7602a9fe6b0.camel@hammerspace.com>
In-Reply-To: <ef6274c2de9fcc2e1820db1ac8f0b7602a9fe6b0.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canb.auug.org.au; dkim=none (message not signed)
 header.d=none;canb.auug.org.au; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0cd3b07-9302-42d3-ce7a-08d7f8edc2a0
x-ms-traffictypediagnostic: CH2PR13MB3416:
x-microsoft-antispam-prvs: <CH2PR13MB3416C694B298052947F4D35DB8BD0@CH2PR13MB3416.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ir5Zz+noXUKVg4mPGO+a8RdqLTO2BRT3GzLGTjiI4ApVuJay6/Vwy+Wlzo/ngnZXte4D1khI3ImYRPJyvJ4ok4Ryky3TN05JIJ34LwlzgEwSk9eA4/0Q95UpIawT2/aV2p2warpnSlm1yKZvN+qFqzjzIA2xSNn5rUf9ip+Q3wmeh0H2Tn74kybP7N88wh1gBMNfulau2bKL4l62LdGQ+veiPanxVMg+Ci2xWzdjy/Uc/7n6qmYnXLA8LLen87vlloqQhITpv5TWOhyFPqBv5B/R1+oQFINp2q4iQEvjZ/vFnwwnLNK03QwG1m+vLgkv14iMJPEJjEV/sQE/IowmmPImT+g7XXulEBO02mE3sIpFxpVuWhVsIE9AK850BbTmV+HApTsO4gynMjySHkHmfUxGl7lUSqMAX6WpV/tijIh0MruhnSKqdq90eeluxqvb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(136003)(366004)(376002)(39830400003)(4326008)(110136005)(8676002)(478600001)(6512007)(8936002)(6486002)(66946007)(2906002)(66476007)(26005)(2616005)(316002)(53546011)(186003)(36756003)(6506007)(64756008)(71200400001)(54906003)(66446008)(86362001)(66556008)(76116006)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ypzwv5FR/79+7yyKQM0V4Hz0UQCDILOsgC0tIE4CyMqa5RsrgeT9HkApIR5HaIM5ljTV/IW6leWHmrfMBkBR69akFspdxNQt2zvgh527FaXPh9x3Et/ElLvmKcKKy0vY3KRsuYSGt6DLQvATRudn6D3ko/8HGJPSGd3dDY7i1KVZ7SFFJKcmEXfZmocowUo8wvQofomyJ8+qbzZdCOMQ0Q03m9i3u/dq/ezvvJ9WNv4QS8G3DqB9ilLxTJ09K2otrxO47wTgvDk3JCXLPLc3dTKp7Et/kpIwFHzPOJqAuYc7c1frNnwbmHt2I7orWb1xPO39+t8C8BZkLMoeTDnOfqcQapcLQH6AdNYWKnNYe2KkwAjKgYjZ5N7i2DPE+fEmlIuHFzNiySG3w6sPk/1c9X29o2vZaxkHLR1sblsLm4wJZsPa5RIy4sLiqHVzaz8DC59sQiv6j2iVftoctyMmj0g6b0VGx2nsKgis3k5m+NY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <28FC0CAF7F22614FAD0FA4C33CC20243@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cd3b07-9302-42d3-ce7a-08d7f8edc2a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 16:33:55.1611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F05y5XVW5AD8uG5FrstOBSvJKrPIv6kkV7gLyQmuePcPoVk6nfIdIsRkT/t2Zj4wHvdJpGhYZxrScViJEFVGhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3416
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTE1IGF0IDE2OjMyICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6
DQo+IEhpIFJhbmR5LA0KPiANCj4gT24gRnJpLCAyMDIwLTA1LTE1IGF0IDA4OjI4IC0wNzAwLCBS
YW5keSBEdW5sYXAgd3JvdGU6DQo+ID4gT24gNS8xNS8yMCA1OjQyIEFNLCBTdGVwaGVuIFJvdGh3
ZWxsIHdyb3RlOg0KPiA+ID4gSGkgYWxsLA0KPiA+ID4gDQo+ID4gPiBDaGFuZ2VzIHNpbmNlIDIw
MjAwNTE0Og0KPiA+ID4gDQo+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gLS0tLS0tLS0tLS0NCj4gPiAN
Cj4gPiBvbiBpMzg2Og0KPiA+IA0KPiA+ICAgQ0MgICAgICBmcy9uZnMvZnNpbmZvLm8NCj4gPiAu
Li9mcy9uZnMvZnNpbmZvLmM6IEluIGZ1bmN0aW9uIOKAmG5mc19mc2luZm9fZ2V0X3N1cHBvcnRz
4oCZOg0KPiA+IC4uL2ZzL25mcy9mc2luZm8uYzoxNTM6MTI6IGVycm9yOiDigJhjb25zdCBzdHJ1
Y3QgbmZzX3NlcnZlcuKAmSBoYXMgbm8NCj4gPiBtZW1iZXIgbmFtZWQg4oCYYXR0cl9iaXRtYXNr
4oCZDQo+ID4gICBpZiAoc2VydmVyLT5hdHRyX2JpdG1hc2tbMF0gJiBGQVRUUjRfV09SRDBfU0la
RSkNCj4gPiAgICAgICAgICAgICBefg0KPiA+IC4uL2ZzL25mcy9mc2luZm8uYzoxNTU6MTI6IGVy
cm9yOiDigJhjb25zdCBzdHJ1Y3QgbmZzX3NlcnZlcuKAmSBoYXMgbm8NCj4gPiBtZW1iZXIgbmFt
ZWQg4oCYYXR0cl9iaXRtYXNr4oCZDQo+ID4gICBpZiAoc2VydmVyLT5hdHRyX2JpdG1hc2tbMV0g
JiBGQVRUUjRfV09SRDFfTlVNTElOS1MpDQo+ID4gICAgICAgICAgICAgXn4NCj4gPiAuLi9mcy9u
ZnMvZnNpbmZvLmM6MTU4OjEyOiBlcnJvcjog4oCYY29uc3Qgc3RydWN0IG5mc19zZXJ2ZXLigJkg
aGFzIG5vDQo+ID4gbWVtYmVyIG5hbWVkIOKAmGF0dHJfYml0bWFza+KAmQ0KPiA+ICAgaWYgKHNl
cnZlci0+YXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQwX0FSQ0hJVkUpDQo+ID4gICAgICAg
ICAgICAgXn4NCj4gPiAuLi9mcy9uZnMvZnNpbmZvLmM6MTYwOjEyOiBlcnJvcjog4oCYY29uc3Qg
c3RydWN0IG5mc19zZXJ2ZXLigJkgaGFzIG5vDQo+ID4gbWVtYmVyIG5hbWVkIOKAmGF0dHJfYml0
bWFza+KAmQ0KPiA+ICAgaWYgKHNlcnZlci0+YXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQw
X0hJRERFTikNCj4gPiAgICAgICAgICAgICBefg0KPiA+IC4uL2ZzL25mcy9mc2luZm8uYzoxNjI6
MTI6IGVycm9yOiDigJhjb25zdCBzdHJ1Y3QgbmZzX3NlcnZlcuKAmSBoYXMgbm8NCj4gPiBtZW1i
ZXIgbmFtZWQg4oCYYXR0cl9iaXRtYXNr4oCZDQo+ID4gICBpZiAoc2VydmVyLT5hdHRyX2JpdG1h
c2tbMV0gJiBGQVRUUjRfV09SRDFfU1lTVEVNKQ0KPiA+ICAgICAgICAgICAgIF5+DQo+ID4gLi4v
ZnMvbmZzL2ZzaW5mby5jOiBJbiBmdW5jdGlvbiDigJhuZnNfZnNpbmZvX2dldF9mZWF0dXJlc+KA
mToNCj4gPiAuLi9mcy9uZnMvZnNpbmZvLmM6MjA1OjEyOiBlcnJvcjog4oCYY29uc3Qgc3RydWN0
IG5mc19zZXJ2ZXLigJkgaGFzIG5vDQo+ID4gbWVtYmVyIG5hbWVkIOKAmGF0dHJfYml0bWFza+KA
mQ0KPiA+ICAgaWYgKHNlcnZlci0+YXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQwX0NBU0Vf
SU5TRU5TSVRJVkUpDQo+ID4gICAgICAgICAgICAgXn4NCj4gPiAuLi9mcy9uZnMvZnNpbmZvLmM6
MjA3OjEzOiBlcnJvcjog4oCYY29uc3Qgc3RydWN0IG5mc19zZXJ2ZXLigJkgaGFzIG5vDQo+ID4g
bWVtYmVyIG5hbWVkIOKAmGF0dHJfYml0bWFza+KAmQ0KPiA+ICAgaWYgKChzZXJ2ZXItPmF0dHJf
Yml0bWFza1swXSAmIEZBVFRSNF9XT1JEMF9BUkNISVZFKSB8fA0KPiA+ICAgICAgICAgICAgICBe
fg0KPiA+IC4uL2ZzL25mcy9mc2luZm8uYzoyMDg6MTM6IGVycm9yOiDigJhjb25zdCBzdHJ1Y3Qg
bmZzX3NlcnZlcuKAmSBoYXMgbm8NCj4gPiBtZW1iZXIgbmFtZWQg4oCYYXR0cl9iaXRtYXNr4oCZ
DQo+ID4gICAgICAgKHNlcnZlci0+YXR0cl9iaXRtYXNrWzBdICYgRkFUVFI0X1dPUkQwX0hJRERF
TikgfHwNCj4gPiAgICAgICAgICAgICAgXn4NCj4gPiAuLi9mcy9uZnMvZnNpbmZvLmM6MjA5OjEz
OiBlcnJvcjog4oCYY29uc3Qgc3RydWN0IG5mc19zZXJ2ZXLigJkgaGFzIG5vDQo+ID4gbWVtYmVy
IG5hbWVkIOKAmGF0dHJfYml0bWFza+KAmQ0KPiA+ICAgICAgIChzZXJ2ZXItPmF0dHJfYml0bWFz
a1sxXSAmIEZBVFRSNF9XT1JEMV9TWVNURU0pKQ0KPiA+ICAgICAgICAgICAgICBefg0KPiA+IA0K
PiA+IEZ1bGwgcmFuZGNvbmZpZyBmaWxlIGlzIGF0dGFjaGVkLg0KPiA+IA0KPiANCj4gV2hlcmUg
aXMgdGhpcyBmaWxlIGNvbWluZyBmcm9tPyBJJ20gbm90IGF3YXJlIG9mIGFueSBmcy9uZnMvZnNp
bmZvLmMNCj4gaW4NCj4gdGhlIGN1cnJlbnQgdHJlZSBvciBpbiBteSBsaW51eC1uZXh0IGZvciA1
LjcsIGFuZCBhIGN1cnNvcnkgZ2xhbmNlIGlzDQo+IHNob3dpbmcgaXQgdXAgaW4gQW5uYSdzIGxp
bnV4LW5leHQgZm9yIHRoZSA1LjggbWVyZ2Ugd2luZG93Lg0KDQouLi5pcyBub3Qgc2hvd2luZyBp
dCB1cCBpbiBBbm5hJ3MgbGludXgtbmV4dC4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGlu
dXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhh
bW1lcnNwYWNlLmNvbQ0KDQoNCg==
