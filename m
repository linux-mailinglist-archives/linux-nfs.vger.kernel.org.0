Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79936276082
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Sep 2020 20:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWSxe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Sep 2020 14:53:34 -0400
Received: from mail-bn8nam12on2093.outbound.protection.outlook.com ([40.107.237.93]:40992
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbgIWSxe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 23 Sep 2020 14:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTOpWKECXoK64v6Ysa0kQoGR5In7MdS0cio+My+mcKJy/v9NuxX73KfwpJDn74xXvTQfPG1+6bMgiiGttRwU9s7dT9K1kAXXDjueLFP/Yjit8DnPgRZGVeiWz/BPNqjL0WJ8U2bqqauEGssmAORbWgO1i1b1b6j1WHZY6MdInlcfGgA+yy1lIw0BFp7dAl497WLbUJENxq0jk8cVbiHvSqwH1e/r0Bgkf/PcTs2sJ2Q43Qjve3Knmn1HHEkYUbF/MoZbjbv723vBqx2VfI3evehIa4Hif37UFHr7243KMPGRgYSxHgoaCsvMh2sNSHxrvRloq/QKmWmUtTbuGHD5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vCaf77X/p9xOspJXSgS1TJuVFTB5YsCWmKRGF+sJhI=;
 b=jyZoLFdn4zTa6wHESiro4Bi8Uh2KTg+xMTLXAPbXSVxVwsoU3Scebh1Sroka4HOA3uO6iOkQiBF4Ald7nzOVqdrZ/5ENhFbCY9KOGbjV+w70eZ3FbDt1YnrB4HVi9KvscDnmFXBNuTqS3RgbDNwAi+sB9sqQ8IvXmQ73+y1MI/RlXNPmzHdwR3vnkVSuthAwTQMcjDcANDDqIt5tbJ4BZQG/bv4p15dpKHA5gzHrbBPUiTHciMBvp4NxwsTsg0ltBVIaYVg50wn4YBpUj0nZETC8P9coETIweKQqK0rVu+MkcS8t/1/fMGf+h1oBC/XPY3n4sgw488jA34zsg9VYbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vCaf77X/p9xOspJXSgS1TJuVFTB5YsCWmKRGF+sJhI=;
 b=gk2+T9k5+yNhL3OKPS4ks3gujfCDZQLo8KH3FcZ5fRcvSKqNi9YPjIxH2gsLIcqZB3FfP1Q0Q5axdBRqpWH4bX92abwIgKV+Fd3taSX/1DaDNozhwBMEcxLmFESV4uvRs90nS80s7Kmk4W2lELK0D1S6na7JXpxRiYidbnrkVPo=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3927.namprd13.prod.outlook.com (2603:10b6:208:260::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4; Wed, 23 Sep
 2020 18:53:30 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3433.013; Wed, 23 Sep 2020
 18:53:30 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2 v3] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Topic: [PATCH 1/2 v3] NFSv4: Fix a livelock when CLOSE pre-emptively
 bumps state sequence
Thread-Index: AQHWkdAtEMKsMIWKs0WWIwkhmSwpm6l2kgaA
Date:   Wed, 23 Sep 2020 18:53:30 +0000
Message-ID: <69ca1c64b0e7eb205e8f53af8febf6d688f65d80.camel@hammerspace.com>
References: <cover.1600882430.git.bcodding@redhat.com>
         <787d0d4946efb286f4dc51051b048277c0dc697e.1600882430.git.bcodding@redhat.com>
In-Reply-To: <787d0d4946efb286f4dc51051b048277c0dc697e.1600882430.git.bcodding@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8696e289-00bf-47d8-d204-08d85ff1f6dd
x-ms-traffictypediagnostic: MN2PR13MB3927:
x-microsoft-antispam-prvs: <MN2PR13MB39277205FE795E5FF7131BF1B8380@MN2PR13MB3927.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vjxr8Px87MyJWoVuWZYVlX5V5WvpTBfJQHlCKRO5YKird8KM6f/OqSuUW9LZ7088GNXvr+z5uB7fqtmdKzYC9ZJmt+6KuSb4nHRfOwFUdx3IqiEtCqsG6fEt5HzK1Rx/qERRbJcY0JYNZ50v2nQUGl+6k+1axWY9+Juh3b8YqHzMm26nvOf+kvFr4FHU26JYbN+sz+KF6oe5dNXBn0/npvAQLJV5jhIiZtzDmQ6QND5eO7ygXichUhzms4/kEP31kFExusenJTzPxUhYIpVcz9iny+4+/X8rRCOoIT1Wo/Jt04XDBFszloCwZWPwt7fEUZ6sSxjj5jptkjCbgy/i5pJKWtBF9UqARDQY9KyprwQsFj1LgYrGH2yAnKm4mV1a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39840400004)(376002)(396003)(136003)(86362001)(5660300002)(186003)(8676002)(2906002)(66556008)(91956017)(6512007)(8936002)(26005)(66446008)(6506007)(66946007)(66476007)(83380400001)(4326008)(64756008)(76116006)(71200400001)(478600001)(36756003)(6486002)(110136005)(316002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ke9RCLO1tR/HFfdSwTh9vdIA5IQzrAwn8KC/5vmAh/SjjzpYrGrqOaPxZ6y1DU3sIbYkslkjIAd+Tt+M7eU6ydvcrkNkVaXf3twPC1CQRFMCF2gryGpPFUiC83oldpWej5XR6y7d15NNcpFZFjn9mz/oxtVbk4KOIteFvbBvYnf3BD1K1mB7zKde/9BR3KQTeqDJI6TNYlEzFMNfaouXSLhHBtTcQjtq3QaaWBTe4s6gYGPk6FV3Gp2jXeiVf3vtJBlihteI1SPEMkdGoz9xsepIhuKE/z3i763cHYmuQPZjORqvjZazwnQhMbKWXt3ZuAh6uv+CGTaU/lpFFDYzs7VSkxB1SlFr6KqECbyDl73goHo/eYb91n70QPTYnBdbeF+YVpxGc94PsLD8PaKzVElVL9iMs/tnRCKTw7jN4SF4uXVS59aNcs1lQRt8fK0Gf8V7LuyHFeAcevf4myp7nlpiKkXvwXYjSeNUxs+6qqXaQ/S6WQQsVRLAZf/2Zhc5dc84O11bnml6jmcMXF02eswZf1yf6bDzgUHbb84r1c1KB5lRhkJPb3bg3ODFJUIMEErNFwpF8BOPRqFZ9mrAoUvy5OMmtH4/6s44RSFOZ7Y31b4rlh4Ft6O3MiKBq5qCknM5k1qucI5WSEdBTFqzwA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A05FC31260DB66418A56302B285EF452@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8696e289-00bf-47d8-d204-08d85ff1f6dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 18:53:30.5150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqkaSyy+a48PUkx0sa5ogdTWfEoG0XIgxb2xhcjFjKkrrKEc69LcrLQuED25EVLuTFs0B6Z2i3yjenWUZo9zBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3927
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTIzIGF0IDEzOjM3IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBTaW5jZSBjb21taXQgMGUwY2IzNWI0MTdmICgiTkZTdjQ6IEhhbmRsZSBORlM0RVJS
X09MRF9TVEFURUlEIGluDQo+IENMT1NFL09QRU5fRE9XTkdSQURFIikgdGhlIGZvbGxvd2luZyBs
aXZlbG9jayBtYXkgb2NjdXIgaWYgYSBDTE9TRQ0KPiByYWNlcw0KPiB3aXRoIHRoZSB1cGRhdGUg
b2YgdGhlIG5mc19zdGF0ZToNCj4gDQo+IFByb2Nlc3MgMSAgICAgICAgICAgUHJvY2VzcyAyICAg
ICAgICAgICBTZXJ2ZXINCj4gPT09PT09PT09ICAgICAgICAgICA9PT09PT09PT0gICAgICAgICAg
ID09PT09PT09DQo+ICBPUEVOIGZpbGUNCj4gICAgICAgICAgICAgICAgICAgICBPUEVOIGZpbGUN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJlcGx5IE9QRU4gKDEp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSZXBseSBPUEVOICgy
KQ0KPiAgVXBkYXRlIHN0YXRlICgxKQ0KPiAgQ0xPU0UgZmlsZSAoMSkNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJlcGx5IE9MRF9TVEFURUlEICgxKQ0KPiAgQ0xP
U0UgZmlsZSAoMikNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJl
cGx5IENMT1NFICgtMSkNCj4gICAgICAgICAgICAgICAgICAgICBVcGRhdGUgc3RhdGUgKDIpDQo+
ICAgICAgICAgICAgICAgICAgICAgd2FpdCBmb3Igc3RhdGUgY2hhbmdlDQo+ICBPUEVOIGZpbGUN
Cj4gICAgICAgICAgICAgICAgICAgICB3YWtlDQo+ICBDTE9TRSBmaWxlDQo+ICBPUEVOIGZpbGUN
Cj4gICAgICAgICAgICAgICAgICAgICB3YWtlDQo+ICBDTE9TRSBmaWxlDQo+ICAuLi4NCj4gICAg
ICAgICAgICAgICAgICAgICAuLi4NCj4gDQo+IEFzIGxvbmcgYXMgdGhlIGZpcnN0IHByb2Nlc3Mg
Y29udGludWVzIHVwZGF0aW5nIHN0YXRlLCB0aGUgc2Vjb25kDQo+IHByb2Nlc3MNCj4gd2lsbCBm
YWlsIHRvIGV4aXQgdGhlIGxvb3AgaW4gbmZzX3NldF9vcGVuX3N0YXRlaWRfbG9ja2VkKCkuICBU
aGlzDQo+IGxpdmVsb2NrDQo+IGhhcyBiZWVuIG9ic2VydmVkIGluIGdlbmVyaWMvMTY4Lg0KPiAN
Cj4gRml4IHRoaXMgYnkgZGV0ZWN0aW5nIHRoZSBjYXNlIGluIG5mc19uZWVkX3VwZGF0ZV9vcGVu
X3N0YXRlaWQoKSBhbmQNCj4gdGhlbiBleGl0IHRoZSBsb29wIGlmOg0KPiAgLSB0aGUgc3RhdGUg
aXMgTkZTX09QRU5fU1RBVEUsIGFuZA0KPiAgLSB0aGUgc3RhdGVpZCBzZXF1ZW5jZSBpcyA+IDEs
IGFuZA0KPiAgLSB0aGUgc3RhdGVpZCBkb2Vzbid0IG1hdGNoIHRoZSBjdXJyZW50IG9wZW4gc3Rh
dGVpZA0KPiANCj4gRml4ZXM6IDBlMGNiMzViNDE3ZiAoIk5GU3Y0OiBIYW5kbGUgTkZTNEVSUl9P
TERfU1RBVEVJRCBpbg0KPiBDTE9TRS9PUEVOX0RPV05HUkFERSIpDQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnICMgdjUuNCsNCj4gU2lnbmVkLW9mZi1ieTogQmVuamFtaW4gQ29kZGluZ3Rv
biA8YmNvZGRpbmdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBmcy9uZnMvbmZzNHByb2MuYyB8IDE2
ICsrKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9u
ZnMvbmZzNHByb2MuYw0KPiBpbmRleCA2ZTk1Yzg1ZmUzOTUuLjhjMmJiOTExMjdlZSAxMDA2NDQN
Cj4gLS0tIGEvZnMvbmZzL25mczRwcm9jLmMNCj4gKysrIGIvZnMvbmZzL25mczRwcm9jLmMNCj4g
QEAgLTE1ODgsMTkgKzE1ODgsMjEgQEAgc3RhdGljIHZvaWQNCj4gbmZzX3Rlc3RfYW5kX2NsZWFy
X2FsbF9vcGVuX3N0YXRlaWQoc3RydWN0IG5mczRfc3RhdGUgKnN0YXRlKQ0KPiAgc3RhdGljIGJv
b2wgbmZzX25lZWRfdXBkYXRlX29wZW5fc3RhdGVpZChzdHJ1Y3QgbmZzNF9zdGF0ZSAqc3RhdGUs
DQo+ICAJCWNvbnN0IG5mczRfc3RhdGVpZCAqc3RhdGVpZCkNCj4gIHsNCj4gLQlpZiAodGVzdF9i
aXQoTkZTX09QRU5fU1RBVEUsICZzdGF0ZS0+ZmxhZ3MpID09IDAgfHwNCj4gLQkgICAgIW5mczRf
c3RhdGVpZF9tYXRjaF9vdGhlcihzdGF0ZWlkLCAmc3RhdGUtPm9wZW5fc3RhdGVpZCkpIHsNCj4g
KwlpZiAodGVzdF9iaXQoTkZTX09QRU5fU1RBVEUsICZzdGF0ZS0+ZmxhZ3MpKSB7DQo+ICsJCS8q
IFRoZSBjb21tb24gY2FzZSAtIHdlJ3JlIHVwZGF0aW5nIHRvIGEgbmV3IHNlcXVlbmNlDQo+IG51
bWJlciAqLw0KPiArCQlpZiAobmZzNF9zdGF0ZWlkX21hdGNoX290aGVyKHN0YXRlaWQsICZzdGF0
ZS0NCj4gPm9wZW5fc3RhdGVpZCkgJiYNCj4gKwkJCW5mczRfc3RhdGVpZF9pc19uZXdlcihzdGF0
ZWlkLCAmc3RhdGUtDQo+ID5vcGVuX3N0YXRlaWQpKSB7DQo+ICsJCQluZnNfc3RhdGVfbG9nX291
dF9vZl9vcmRlcl9vcGVuX3N0YXRlaWQoc3RhdGUsDQo+IHN0YXRlaWQpOw0KPiArCQkJcmV0dXJu
IHRydWU7DQo+ICsJCX0NCj4gKwl9IGVsc2Ugew0KPiArCQkvKiBUaGlzIGlzIHRoZSBmaXJzdCBP
UEVOICovDQo+ICAJCWlmIChzdGF0ZWlkLT5zZXFpZCA9PSBjcHVfdG9fYmUzMigxKSkNCj4gIAkJ
CW5mc19zdGF0ZV9sb2dfdXBkYXRlX29wZW5fc3RhdGVpZChzdGF0ZSk7DQo+ICAJCWVsc2UNCj4g
IAkJCXNldF9iaXQoTkZTX1NUQVRFX0NIQU5HRV9XQUlULCAmc3RhdGUtPmZsYWdzKTsNCg0KSXNu
J3QgdGhpcyBnb2luZyB0byBjYXVzZSBhIHJlb3BlbiBvZiB0aGUgZmlsZSBvbiB0aGUgY2xpZW50
IGlmIGl0IGVuZHMNCnVwIHByb2Nlc3NpbmcgdGhlIHJlcGx5IHRvIHRoZSBzZWNvbmQgT1BFTiBh
ZnRlciBpdCBwcm9jZXNzZXMgdGhlDQpzdWNjZXNzZnVsIENMT1NFPw0KDQpJc24ndCB0aGUgcmVh
bCBwcm9ibGVtIGhlcmUgcmF0aGVyIHRoYXQgdGhlIHJlcGx5IHRvIENMT1NFIG5lZWRzIHRvIGJl
DQpwcm9jZXNzZWQgaW4gb3JkZXIgdG9vPw0KDQo+ICAJCXJldHVybiB0cnVlOw0KPiAgCX0NCj4g
LQ0KPiAtCWlmIChuZnM0X3N0YXRlaWRfaXNfbmV3ZXIoc3RhdGVpZCwgJnN0YXRlLT5vcGVuX3N0
YXRlaWQpKSB7DQo+IC0JCW5mc19zdGF0ZV9sb2dfb3V0X29mX29yZGVyX29wZW5fc3RhdGVpZChz
dGF0ZSwNCj4gc3RhdGVpZCk7DQo+IC0JCXJldHVybiB0cnVlOw0KPiAtCX0NCj4gIAlyZXR1cm4g
ZmFsc2U7DQo+ICB9DQo+ICANCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50
IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29t
DQoNCg0K
