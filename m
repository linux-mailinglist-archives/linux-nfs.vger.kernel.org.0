Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18011A3A68
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2020 21:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDITRQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Apr 2020 15:17:16 -0400
Received: from mail-dm6nam10on2123.outbound.protection.outlook.com ([40.107.93.123]:59425
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726684AbgDITRQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 9 Apr 2020 15:17:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCa/4hbE9dU2vTcjdrBdg/7T0HTJb8vZ5XooUqtzyZHBtJKdW3cdlZSe9KLq97+E35sbpuRppwdsrmzLdeEXfjSZWSrbzzQFMll3KmtGDkCcbTO3gttqZGJBTaU9pkCNEj7C5z7r17QVwyHA9MUIQaQQryGgqobRXarVN5/R7lKSzwxqMbuZute6O62ASXV+TRM8IdXadPBv2Lo2g6q/CwC7COONehYmCOqzDzijsRGN+TtbOk2SpF53Ue23m1AZB2X4tvdPwt+DS3ZwpuAV4wI6kp7Qq/c2xXK8yIB9RjwEgoivXVEPqZ8Czu6pKVQt05Nn6OszmgJM2rhmRk/GIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWmCwl2LX63ucMhiO3ZAER29FbVkcvdXXWdO0GtRcAE=;
 b=GU3IcnQTl38yQZRfBqlG8ZESF4/4qoxbLmgVogSPB1QI219te1nmR36pl7C+dq/WofNcUMqoUWpjYBE2SNkpmNgUZJxirZL88vYV5nm+Y9UySwyWbfI8hufri75wIRT/soqLqy38up/u/mtsrXXXWm25K5U/e/GEf0kwHOz8kyvSc/olpkJ+GXv7VWCz9EOYKccGDG1WcV44goA9inctOVsdDnKT4N3dFuold/26trnmfhjU4VqSHr8aN9TXACojXMOKZxUGYOpbjPwavyAoWFT5aBnPKiIgVrh6JOw79auV4HRMn+OeMQiHa+s4+iCEehGb2k3cHLmLk9iw732Zgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWmCwl2LX63ucMhiO3ZAER29FbVkcvdXXWdO0GtRcAE=;
 b=fX9PvD2KfRdHdG2QQ+xQuHlDa8UD6ZSSRxzzpdGqLDOz94K4rXOqIL5sqOfLTwk/kaW7shwjmlyUzibGGY/mk/Mo/awqZARzzeX50u6hONu2f5b0ixDAdvmmFl7vPZT5IbNXCMUvg6cP0Gmr1KnZvia3EJ1LhtrYiVVarD/cVFA=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3718.namprd13.prod.outlook.com (2603:10b6:610:9e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.13; Thu, 9 Apr
 2020 19:16:37 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2921.009; Thu, 9 Apr 2020
 19:16:37 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: VFS rename hang
Thread-Topic: VFS rename hang
Thread-Index: AQHWDpJuMMm7Q8qVrEKw5hVGHY5A76hxKZ8A
Date:   Thu, 9 Apr 2020 19:16:37 +0000
Message-ID: <8be4b4e465f01f66f96c2308c833cbf95546e2cb.camel@hammerspace.com>
References: <CAN-5tyE4w3LPx8oy=e=S+shq8w74iRGD-0Aktd0DtzGk8KkkJA@mail.gmail.com>
In-Reply-To: <CAN-5tyE4w3LPx8oy=e=S+shq8w74iRGD-0Aktd0DtzGk8KkkJA@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fa3d1f5-51ed-4700-424e-08d7dcba8680
x-ms-traffictypediagnostic: CH2PR13MB3718:
x-microsoft-antispam-prvs: <CH2PR13MB3718158117A309B75343C79AB8C10@CH2PR13MB3718.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(346002)(136003)(376002)(396003)(39830400003)(366004)(110136005)(3480700007)(316002)(71200400001)(2616005)(66556008)(8936002)(66446008)(478600001)(66476007)(186003)(6506007)(76116006)(91956017)(7116003)(5660300002)(66946007)(86362001)(81156014)(8676002)(2906002)(6486002)(36756003)(64756008)(26005)(81166007)(6512007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9+rW7Kbrqpnam9t3dkTZzxk0bGF7/UneIsxi8P+Fc1J8AdVK5XHcCwm5wQNmtl3DHRcTke3AG8aja2QRxZriLVql9KUi3E71OX2sWlWqEyAaxVRViXFzzP+QbdMtACMuPmUJo0se/9TtecOm/5ENYE7jgBwnMTTnXDtsWgQNqXptmKy+w/Qhk0sgxLrdgFRBRue6XeZsSLKV7nDC35eCI8yD1NmA8/gn1ydREyg/Jw7i+bsvbfaRrAbhYGSblTpM1fb7gk6q2CKBQX/acbMb+MQH3th1S/7ouCvTxT23Wie4nVwyiqE78esKcNugOXZ2NET7EyLKanRjHFp3kTNCEOcSFA5zrGm3KnkVftnmsG/cvdqXFv1lYnQlvEnIqB2/xjz/TbRdfXUpi/lsyAPB4SL4A9AjtBj6wXAl/8uLkuLkj8tMUQF8LKLr4CYaa0iw
x-ms-exchange-antispam-messagedata: rNv6dSAOwYWb3byEf87Csab6gVJBuY2JJGf1Iq3gbKOcgFr7ynyZtBVMznGVjJU+KpyUa6eHRLIMRvf7O6xUmrLoF2L7w5gBVK1aPgz5LpU0TUb+NBz2bd+hguFAhqu3WYy0zaL00jNGBkfXFTD00g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B44B05661C15940AF5E73F47438C171@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa3d1f5-51ed-4700-424e-08d7dcba8680
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 19:16:37.3545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1/CQm9tS9jp8Rn8QE0Wi4QPnDuefaWY+A7vgXM93WzsO5p++xItvC578NdBHEGV25aEsdCpx7xIgbTI0r4Fsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3718
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gVGh1LCAyMDIwLTA0LTA5IGF0IDEzOjE0IC0wNDAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gSGkgZm9sa3MsDQo+IA0KPiBUaGlzIGlzIGEgcmVuYW1lIG9uIGFu
IE5GUyBtb3VudCBidXQgdGhlIHN0YWNrIHRyYWNlIGlzIG5vdCBpbiBORlMsDQo+IGJ1dCBJJ20g
Y3VyaW91cyBpZiBhbnkgYm9keSByYW4gaW50byB0aGlzLiBUaGFua3MuDQo+IA0KPiBBcHIgIDcg
MTM6MzQ6NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5lbDogICAgICBOb3QgdGFpbnRlZCA1LjUuNyAj
MQ0KPiBBcHIgIDcgMTM6MzQ6NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5lbDogImVjaG8gMCA+DQo+
IC9wcm9jL3N5cy9rZXJuZWwvaHVuZ190YXNrX3RpbWVvdXRfc2VjcyIgZGlzYWJsZXMgdGhpcyBt
ZXNzYWdlLg0KPiBBcHIgIDcgMTM6MzQ6NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5lbDogZHQgICAg
ICAgICAgICAgIEQgICAgMCAyNDc4OA0KPiAyNDMyMyAweDAwMDAwMDgwDQo+IEFwciAgNyAxMzoz
NDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBDYWxsIFRyYWNlOg0KPiBBcHIgIDcgMTM6MzQ6
NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5lbDogPyBfX3NjaGVkdWxlKzB4MmNhLzB4NmUwDQo+IEFw
ciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBzY2hlZHVsZSsweDRhLzB4YjAN
Cj4gQXByICA3IDEzOjM0OjUzIHNjc3ByMTg2NTE0MjAwMiBrZXJuZWw6DQo+IHNjaGVkdWxlX3By
ZWVtcHRfZGlzYWJsZWQrMHhhLzB4MTANCj4gQXByICA3IDEzOjM0OjUzIHNjc3ByMTg2NTE0MjAw
MiBrZXJuZWw6DQo+IF9fbXV0ZXhfbG9jay5pc3JhLjExKzB4MjMzLzB4NGUwDQo+IEFwciAgNyAx
MzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiA/DQo+IHN0cm5jcHlfZnJvbV91c2VyKzB4
NDcvMHgxNjANCj4gQXByICA3IDEzOjM0OjUzIHNjc3ByMTg2NTE0MjAwMiBrZXJuZWw6IGxvY2tf
cmVuYW1lKzB4MjgvMHhkMA0KPiBBcHIgIDcgMTM6MzQ6NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5l
bDogZG9fcmVuYW1lYXQyKzB4MWU3LzB4NGYwDQo+IEFwciAgNyAxMzozNDo1MyBzY3NwcjE4NjUx
NDIwMDIga2VybmVsOiBfX3g2NF9zeXNfcmVuYW1lKzB4MWMvMHgyMA0KPiBBcHIgIDcgMTM6MzQ6
NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5lbDogZG9fc3lzY2FsbF82NCsweDViLzB4MjAwDQo+IEFw
ciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOg0KPiBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5DQo+IEFwciAgNyAxMzozNDo1MyBzY3NwcjE4NjUxNDIw
MDIga2VybmVsOiBSSVA6IDAwMzM6MHg3Zjc0N2ExMGFjNzcNCj4gQXByICA3IDEzOjM0OjUzIHNj
c3ByMTg2NTE0MjAwMiBrZXJuZWw6IENvZGU6IEJhZCBSSVAgdmFsdWUuDQo+IEFwciAgNyAxMzoz
NDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBSU1A6IDAwMmI6MDAwMDdmNzQ3OWY5Mjk0OA0K
PiBFRkxBR1M6IDAwMDAwMjA2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDUyDQo+IEFwciAgNyAx
MzozNDo1MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJY
Og0KPiAwMDAwMDAwMDAyMzYwNGMwIFJDWDogMDAwMDdmNzQ3YTEwYWM3Nw0KPiBBcHIgIDcgMTM6
MzQ6NTMgc2NzcHIxODY1MTQyMDAyIGtlcm5lbDogUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSToN
Cj4gMDAwMDdmNzQ3OWY5NGE4MCBSREk6IDAwMDA3Zjc0NzlmOTZiODANCj4gQXByICA3IDEzOjM0
OjUzIHNjc3ByMTg2NTE0MjAwMiBrZXJuZWw6IFJCUDogMDAwMDAwMDAwMDAwMDAwNSBSMDg6DQo+
IDAwMDA3Zjc0NzlmOWQ3MDAgUjA5OiAwMDAwN2Y3NDc5ZjlkNzAwDQo+IEFwciAgNyAxMzozNDo1
MyBzY3NwcjE4NjUxNDIwMDIga2VybmVsOiBSMTA6IDY0NWY3MjY1NjQ2NDYxNmMgUjExOg0KPiAw
MDAwMDAwMDAwMDAwMjA2IFIxMjogMDAwMDAwMDAwMDAwMDAwMQ0KPiBBcHIgIDcgMTM6MzQ6NTMg
c2NzcHIxODY1MTQyMDAyIGtlcm5lbDogUjEzOiAwMDAwN2Y3NDc5Zjk4YzgwIFIxNDoNCj4gMDAw
MDdmNzQ3OWY5YWQ4MCBSMTU6IDAwMDA3Zjc0NzlmOTRhODANCg0KSXQgbG9va3MgbGlrZSB0aGUg
cmVuYW1lIGxvY2tpbmcgKGkuZS4gdGFraW5nIHRoZSBpbm9kZSBtdXRleCBvbiB0aGUNCnNvdXJj
ZSBhbmQgdGFyZ2V0IGRpcmVjdG9yeSkgaXMgaHVuZy4gVGhhdCBsaWtlbHkgaW5kaWNhdGVzIHRo
YXQNCnNvbWV0aGluZyBlbHNlIGlzIGxlYWtpbmcgb3IgaG9sZGluZyBvbnRvIG9uZSBvciBtb3Jl
IG9mIHRoZSBkaXJlY3RvcnkNCm11dGV4ZXMuIElzIHNvbWUgb3RoZXIgdGhyZWFkL3Byb2Nlc3Mg
cGVyaGFwcyBhbHNvIGh1bmcgb24gdGhlIHNhbWUNCmRpcmVjdG9yeT8NCg0KQ2hlZXJzDQogIFRy
b25kDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
