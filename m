Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176589A0F8
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Aug 2019 22:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbfHVUSa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Aug 2019 16:18:30 -0400
Received: from mail-eopbgr800075.outbound.protection.outlook.com ([40.107.80.75]:26160
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727310AbfHVUSa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 22 Aug 2019 16:18:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSjEGPjdYyDEGC9etBDda3nNZtomvucHIVSO4QS4MFHdpuD2eep/ZoZZxDVmiYhTYO/WhhJYqr0o/NPX1k3PiwVtRZpv2vgZQkMWB84gRuib3S5wP99C11dMRXTkQNLuPX2s6YAq8/0L/f/soT1YKjMuFzu2fGVkRHG+hyKBu/6YQHjXJUMFz9A6Uk368ZUbtqXKadFOVjL5TPsK8cfKB490k0rIH3ODqOiy85DKnDS5A8Suiz5Gcg4abkFuYaG+lEscn4ozjFTMKae9llnx6f/yctci/NYlcjzBxFE7eJIveV/zTVpAqBPLoWDlXtEkNfzKSojH5RoOvUIWUi4P4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h4UNhgVaQZJidbdlcZfmWlbKr/6Rur3XHfXcyoBYcg=;
 b=VsVQP9BbZaNY/7AcG6YlYyuHC/ADXV0oyRHwHcayadhJl11idzOaUFOMgt+ke/76h2vW+t0tnFR3pO3QcSco4xRw8gBBZEuwuCi/e+nM+7aMAmtccLtIEMQKaCeNRLGOji1y/lO9CRntU/p/KBJAkNTlAmSDKSJnpKTuL37FmA/3unv8KsnzR+DQZU49slwiFyfcpbt2NniYsdfVtJjPacGiXXSrHunOp0HDF+HeKTUAA3+QaCfXSaJKn1WR+YYecG8yI+eWYgJOCxnjRdC1SptgDoIAdDGPdKvmImVQcM0EvPlexiytAZaeIxgvrapLmVykrI/yresTaUlMz/SLJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0h4UNhgVaQZJidbdlcZfmWlbKr/6Rur3XHfXcyoBYcg=;
 b=ttYK2kLZJthGIbK5pRGlRgO2Pw8EqKuWHpGPGSiZPKODvF8lqwcL8SZpKqL41zj1CJsqKUGpJ7/D2Y4ugmUi7RDHu8Fxmk9P8+GbuldcztoPqj6ii6swcJgkMZU7vvJvsImYDrQBVYPxGrFBGmfAvQEQRIswaSuJxtSsJaDO2Qo=
Received: from CY4PR06MB3479.namprd06.prod.outlook.com (10.175.117.23) by
 CY4PR06MB2648.namprd06.prod.outlook.com (10.173.39.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 20:18:26 +0000
Received: from CY4PR06MB3479.namprd06.prod.outlook.com
 ([fe80::b0fc:fa55:aefa:2df2]) by CY4PR06MB3479.namprd06.prod.outlook.com
 ([fe80::b0fc:fa55:aefa:2df2%7]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 20:18:26 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 00/21] NFS/RDMA client-side for-5.4
Thread-Topic: [PATCH v2 00/21] NFS/RDMA client-side for-5.4
Thread-Index: AQHVVt55iitIcm1Cv0Cfk2tYgEa26qcHn8IA
Date:   Thu, 22 Aug 2019 20:18:25 +0000
Message-ID: <13c0cc293fa62406161aa3cc3f1afcb2d1a6557a.camel@netapp.com>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.4 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7d20fe3-956a-4754-95f4-08d7273de39a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR06MB2648;
x-ms-traffictypediagnostic: CY4PR06MB2648:
x-microsoft-antispam-prvs: <CY4PR06MB2648DBA17A4FF5BF1BFF8BF6F8A50@CY4PR06MB2648.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:133;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(199004)(189003)(6246003)(66446008)(118296001)(64756008)(66476007)(66556008)(86362001)(66946007)(305945005)(66066001)(6116002)(2351001)(446003)(3846002)(76116006)(6506007)(14454004)(476003)(7736002)(6436002)(256004)(14444005)(11346002)(316002)(5640700003)(2906002)(2501003)(5660300002)(25786009)(99286004)(81156014)(8676002)(81166006)(54906003)(6512007)(71200400001)(2616005)(58126008)(71190400001)(186003)(36756003)(53936002)(102836004)(76176011)(486006)(4326008)(6916009)(229853002)(6486002)(8936002)(91956017)(478600001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR06MB2648;H:CY4PR06MB3479.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y8o0IOKPp1bjGQ9jafRjt+dMh90mtSsRyglHI3MKCWRfgMLk85nt7bolPChwIAsJLKM3yaW3iQSsq6l2uOgcjydVabifdC2wvNMVKhT0qcV9SxMCPo4vK9eJzQdi1otOL5mxZAdR4v75+97WGR5qEIiCxIVmmHMc5oJ5Zxlvt7Ip4qsAUTkjYajNL8GV79keRTFeWP0WSOeQ/vi9JsbFrUjIpo5b1cf3Z+u8bdtaV/VO5rhRU45HrWR5fgUaYNl3ixWcRH6zKSp4E/sgFHA9I0eF12fg9DryWR1UjuWJnmNmVo1p7VpkdyDlk/+sx0Y2/O/+P3Rc39bdbFRsbrWlo9/9nv7KZSgV/DklgBy1exyRYyhlf+Vkm2NSHE4MfO+BDfrXyTUTH/8XzFJI7bsi1X83ybtgbdHb8/+odWoBlv4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6B4238D396FCA4ABB1B2F792A70B69A@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d20fe3-956a-4754-95f4-08d7273de39a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 20:18:25.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByqQu5HJQIi8hIHXQDH5BcA/PJnJ9IAeAhL8x9RBGHXJyBRNO4KD+ZcDKK3aRCu6BXNQvw4sR8iT0aL8zg4x0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB2648
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

VGhhbmtzLCBDaHVjayEgSSd2ZSBwdXNoZWQgdGhlc2Ugb3V0IHRvIG15IGxpbnV4LW5leHQgYnJh
bmNoLg0KDQpBbm5hDQoNCk9uIE1vbiwgMjAxOS0wOC0xOSBhdCAxODozNSAtMDQwMCwgQ2h1Y2sg
TGV2ZXIgd3JvdGU6DQo+IEhpIEFubmEtDQo+IA0KPiBUaGVzZSBmZWVsIGxpa2UgdGhleSBhcmUg
cmVhZHkgZm9yIHlvdSB0byBtZXJnZS4NCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IC0gUmVi
YXNlZCBvbiB2NS4zLXJjNQ0KPiAtIEltcHJvdmVkICJCb29zdCBtYXhpbXVtIHRyYW5zcG9ydCBo
ZWFkZXIgc2l6ZSINCj4gLSBNaW5vciBjbGFyaWZpY2F0aW9ucw0KPiANCj4gLS0tDQo+IA0KPiBD
aHVjayBMZXZlciAoMjEpOg0KPiAgICAgICBTVU5SUEM6IFJlbW92ZSBycGNfd2FrZV91cF9xdWV1
ZWRfdGFza19vbl93cSgpDQo+ICAgICAgIFNVTlJQQzogSW5saW5lIHhkcl9jb21taXRfZW5jb2Rl
DQo+ICAgICAgIHhwcnRyZG1hOiBSZWZyZXNoIHRoZSBkb2N1bWVudGluZyBjb21tZW50IGluIGZy
d3Jfb3BzLmMNCj4gICAgICAgeHBydHJkbWE6IFVwZGF0ZSBvYnNvbGV0ZSBjb21tZW50DQo+ICAg
ICAgIHhwcnRyZG1hOiBGaXggY2FsY3VsYXRpb24gb2YgcmlfbWF4X3NlZ3MgYWdhaW4NCj4gICAg
ICAgeHBydHJkbWE6IEJvb3N0IG1heGltdW0gdHJhbnNwb3J0IGhlYWRlciBzaXplDQo+ICAgICAg
IHhwcnRyZG1hOiBCb29zdCBjbGllbnQncyBtYXggc2xvdCB0YWJsZSBzaXplIHRvIG1hdGNoIExp
bnV4DQo+IHNlcnZlcg0KPiAgICAgICB4cHJ0cmRtYTogUmVuYW1lIENRRSBmaWVsZCBpbiBSZWNl
aXZlIHRyYWNlIHBvaW50cw0KPiAgICAgICB4cHJ0cmRtYTogUmVuYW1lIHJwY3JkbWFfYnVmZmVy
OjpyYl9hbGwNCj4gICAgICAgeHBydHJkbWE6IFRvZ2dsZSBYUFJUX0NPTkdFU1RFRCBpbiB4cHJ0
cmRtYSdzIHNsb3QgbWV0aG9kcw0KPiAgICAgICB4cHJ0cmRtYTogU2ltcGxpZnkgcnBjcmRtYV9t
cl9wb3ANCj4gICAgICAgeHBydHJkbWE6IENvbWJpbmUgcnBjcmRtYV9tcl9wdXQgYW5kIHJwY3Jk
bWFfbXJfdW5tYXBfYW5kX3B1dA0KPiAgICAgICB4cHJ0cmRtYTogTW92ZSBycGNyZG1hX21yX2dl
dCBvdXQgb2YgZnJ3cl9tYXANCj4gICAgICAgeHBydHJkbWE6IEVuc3VyZSBjcmVhdGluZyBhbiBN
UiBkb2VzIG5vdCB0cmlnZ2VyIEZTIHdyaXRlYmFjaw0KPiAgICAgICB4cHJ0cmRtYTogQ2FjaGUg
ZnJlZSBNUnMgaW4gZWFjaCBycGNyZG1hX3JlcQ0KPiAgICAgICB4cHJ0cmRtYTogUmVtb3ZlIHJw
Y3JkbWFfYnVmZmVyOjpyYl9tcmxvY2sNCj4gICAgICAgeHBydHJkbWE6IFVzZSBhbiBsbGlzdCB0
byBtYW5hZ2UgZnJlZSBycGNyZG1hX3JlcHMNCj4gICAgICAgeHBydHJkbWE6IENsZWFuIHVwIHhw
cnRfcmRtYV9zZXRfY29ubmVjdF90aW1lb3V0KCkNCj4gICAgICAgeHBydHJkbWE6IEZpeCBiY19t
YXhfc2xvdHMgcmV0dXJuIHZhbHVlDQo+ICAgICAgIHhwcnRyZG1hOiBJbmxpbmUgWERSIGNodW5r
IGVuY29kZXIgZnVuY3Rpb25zDQo+ICAgICAgIHhwcnRyZG1hOiBPcHRpbWl6ZSBycGNyZG1hX3Bv
c3RfcmVjdnMoKQ0KPiANCj4gDQo+ICBpbmNsdWRlL2xpbnV4L3N1bnJwYy9zY2hlZC5oICAgICAg
fCAgICAzIA0KPiAgaW5jbHVkZS9saW51eC9zdW5ycGMveHBydHJkbWEuaCAgIHwgICAgNCAtDQo+
ICBpbmNsdWRlL3RyYWNlL2V2ZW50cy9ycGNyZG1hLmggICAgfCAgIDg4ICsrKysrKysrKysrKy0t
DQo+ICBuZXQvc3VucnBjL3NjaGVkLmMgICAgICAgICAgICAgICAgfCAgIDI3ICstLS0NCj4gIG5l
dC9zdW5ycGMveGRyLmMgICAgICAgICAgICAgICAgICB8ICAgIDIgDQo+ICBuZXQvc3VucnBjL3hw
cnRyZG1hL2JhY2tjaGFubmVsLmMgfCAgICA0IC0NCj4gIG5ldC9zdW5ycGMveHBydHJkbWEvZnJ3
cl9vcHMuYyAgICB8ICAxMzEgKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICBuZXQvc3VucnBjL3hw
cnRyZG1hL3JwY19yZG1hLmMgICAgfCAgIDYzICsrKysrKystLS0NCj4gIG5ldC9zdW5ycGMveHBy
dHJkbWEvdHJhbnNwb3J0LmMgICB8ICAgMTIgKy0NCj4gIG5ldC9zdW5ycGMveHBydHJkbWEvdmVy
YnMuYyAgICAgICB8ICAyMzUgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+IC0tLS0tLS0t
LS0NCj4gIG5ldC9zdW5ycGMveHBydHJkbWEveHBydF9yZG1hLmggICB8ICAgNTggKysrKy0tLS0t
DQo+ICAxMSBmaWxlcyBjaGFuZ2VkLCAzMDUgaW5zZXJ0aW9ucygrKSwgMzIyIGRlbGV0aW9ucygt
KQ0KPiANCj4gLS0NCj4gQ2h1Y2sgTGV2ZXINCg==
