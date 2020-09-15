Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4240926AE55
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Sep 2020 22:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgIOUBs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Sep 2020 16:01:48 -0400
Received: from mail-dm6nam12on2097.outbound.protection.outlook.com ([40.107.243.97]:63713
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727811AbgIOT7c (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Sep 2020 15:59:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUrpJ0K+pxA2P2pVQs/o6yngigsRBjehvQnSebAn7oI4d/ihq6mnMToLTyDObkk2iCX0njqca292r+A/JaVHGnzyreBp+Zzde8DJLUSbnom8i8vqqpUqP824Qsj9ObgMUVYOgMMTssrw9+98+VDnZ3AvH3UwdFaDFuLXUGxPA2m/+hPnwHUgNWbM5t+kJW0+DJQNvPJ3kDmTDKwde9+zHGJKlKuNupjTupYiv5+JAONX2QYgkKLnJ5E8AyldPONDujjSG4h0Os9rTsG5qNwAoe7iQe03fwvNm61X2P2UAtgapxO1hSvgASVaExc+w4XwCo7IsJ7GA2DKdBlVUPtPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyRVdMsF/LDWVPnnwF/qXjGfMYzWKQrZARuiySzoIp8=;
 b=eVb1a2NgbHg3J2VD0s26TEWB7SrBEhsrS+lX6kuxc1bmbJA7SrdsXQSQqm1BgaM7equDSwTNkUcyoZ//R/CsE9N7oWGjyP3tzgBrSawvuuJ0tQ3NEfyL5WaScISsHvCCQVYReCTVayk2/AUy9t9gCwKQIhnZLSeLMTqZwT0ecW2sAImrQSuaOObmnIrgjG2FITAvwWHtAcXT0uXoINGnjUpMMAMbN1M7Bof5dEOglY37/qNJT3xbR9v+qO01AyBBtZ4yDLXfWSE5RGVhHD+mYAmkm3khNyHDVFvzE3cXXp9iRg5C/efcGKrJcyilbL/8TNeVG9hqMQuXFE9UMiCORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyRVdMsF/LDWVPnnwF/qXjGfMYzWKQrZARuiySzoIp8=;
 b=dDe4OBrYYW1ZJooUXkE/GlVi2fxvU5DP2odZCKunYAAqguDoA8TqH3XI9TeqQtE/JQszpdjHAINSyDS7aJzLSEA24BQvEHHoBbQUykJFJU4mPecdXu56SWgvnbnCQI/erCMKpXxmZM5NcpnhJLYAQEvAXirxo0RQ7uZ4pzNtwmg=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3101.namprd13.prod.outlook.com (2603:10b6:208:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5; Tue, 15 Sep
 2020 19:59:27 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%7]) with mapi id 15.20.3370.016; Tue, 15 Sep 2020
 19:59:27 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "daire@dneg.com" <daire@dneg.com>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Adventures in NFS re-exporting
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR4tJDJwAAAWCe4A=
Date:   Tue, 15 Sep 2020 19:59:27 +0000
Message-ID: <4d1d7cd0076d98973a56e89c92e4ff0474aa0e14.camel@hammerspace.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
         <20200915172140.GA32632@fieldses.org>
In-Reply-To: <20200915172140.GA32632@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74991891-e3d9-4f3a-3c9e-08d859b1da0c
x-ms-traffictypediagnostic: MN2PR13MB3101:
x-microsoft-antispam-prvs: <MN2PR13MB3101B9208B2CF024ECFB6E99B8200@MN2PR13MB3101.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MNho3ZrYTjkTDmhLYqnNW8Oo8pknaxxxKAWuEohIcFNKeWGRDXY8HPGrOyhHrrIVynx3ErOnxuVcUnkVq4yrxBz83q4W8IwjIIF4oSLMeCJ+qLjhSZwcWQfhF2yHNt1d9k9ELHREdPtiGzBBsab+Acg7E50IYD9BBTUu6WGuA0PiVoQTCys0xqPlXe7JEmFmMdk+JztTG1Bn2FCOkBM1dFcbanVyrBSYC4yr96j3SYRZUb5S+phXpqriJs3aDzvz4GhDYFlLJp0Ej+btlqGAEu9NPeYv4qWb2G0biyiYqKF9j8HTw4R2EHf6d9GEumJ7QGS9KcW0rbwrO6YTUvlYgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(376002)(136003)(346002)(366004)(66476007)(66556008)(64756008)(66446008)(26005)(5660300002)(83380400001)(6486002)(186003)(316002)(8676002)(6512007)(8936002)(478600001)(6506007)(86362001)(2906002)(54906003)(4326008)(36756003)(110136005)(66946007)(71200400001)(91956017)(76116006)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: R6Y8iJ040w29ASrlwu8/bnqCwolPxe5G7jquEUIRIzcQtmLlJbLYDY8XRrX2TDS8VDOtQrwgIVeM7DpnYITlGzGvWEUAUAggHxi8QfldzbypU9673AJLYOUIVAcSnL5yhD/MxkAnbt+j+eIqhjhDtRWXcia4XFlAp0mJFMF10f7qqecjJ+T3RFOOEqPpB3qE0N7rwX2N2r+Id4JpIEdsHUEtdW5xmGgDPENyiQ9QMxg0+g85wUrM3nKjfQkJVkufBqh4+MuqgyWgbafcawl0x7BRjDhmB8fOoMfsLIJWft3akOeRiwhI4uQ/8kfvvCI1B5Nk1CTQCv5ARqKod8cfJ+E+0059hnvh9wFzqT+wvqiNXw2LE7BRPWRpOIqOXZ7ogDfXcAoEmyvOlgTpX+iUVRazJhsHp7kioP0bIov2DCu5NXeFuRlWL23hf23mBw11Be7lBXgTTbpNX/B9JO2M/eR7fNS8fB66pPLHUHwm6ioC3OpUaZKEpT8WzjaYH1TlCuh59XS+ravO4F6FAPUJ4sRQwxtYW+AZYM2l8xT+x9P8Pi5RzSLMW7XqArFtKi4NiTBLIkdP912qvOE8b9bh991ZpgVY47u9l6+4RYq/22vz+AHVRah5SNSXQcnrYgojWjNEusj5zrvuhgh8hQQQLA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <162A84E918D2E346BA691A563350C1CE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74991891-e3d9-4f3a-3c9e-08d859b1da0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 19:59:27.2326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsrfoJ6/ezCjLUgGzv4tKgR0gfc1ThrLNko7iYrEXd1IODHpUhGqkq1t4ehuZcb3yzHakMJC2NJ0jD34YSUzpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3101
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTE1IGF0IDEzOjIxIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIE1vbiwgU2VwIDA3LCAyMDIwIGF0IDA2OjMxOjAwUE0gKzAxMDAsIERhaXJlIEJ5cm5l
IHdyb3RlOg0KPiA+IDEpIFRoZSBrZXJuZWwgY2FuIGRyb3AgZW50cmllcyBvdXQgb2YgdGhlIE5G
UyBjbGllbnQgaW5vZGUgY2FjaGUNCj4gPiAodW5kZXIgbWVtb3J5IGNhY2hlIGNodXJuKSB3aGVu
IHRob3NlIGZpbGVoYW5kbGVzIGFyZSBzdGlsbCBiZWluZw0KPiA+IHVzZWQgYnkgdGhlIGtuZnNk
J3MgcmVtb3RlIGNsaWVudHMgcmVzdWx0aW5nIGluIHNwb3JhZGljIGFuZCByYW5kb20NCj4gPiBz
dGFsZSBmaWxlaGFuZGxlcy4gVGhpcyBzZWVtcyB0byBiZSBtb3N0bHkgZm9yIGRpcmVjdG9yaWVz
IGZyb20NCj4gPiB3aGF0IEkndmUgc2Vlbi4gRG9lcyB0aGUgTkZTIGNsaWVudCBub3Qga25vdyB0
aGF0IGtuZnNkIGlzIHN0aWxsDQo+ID4gdXNpbmcgdGhvc2UgZmlsZXMvZGlycz8gVGhlIHdvcmth
cm91bmQgaXMgdG8gbmV2ZXIgZHJvcCBpbm9kZSAmDQo+ID4gZGVudHJ5IGNhY2hlcyBvbiB0aGUg
cmUtZXhwb3J0IHNlcnZlcnMgKHZmc19jYWNoZV9wcmVzc3VyZT0xKS4gVGhpcw0KPiA+IGFsc28g
aGVscHMgdG8gZW5zdXJlIHRoYXQgd2UgYWN0dWFsbHkgbWFrZSB0aGUgbW9zdCBvZiBvdXINCj4g
PiBhY3RpbWVvPTM2MDAsbm9jdG8gbW91bnQgb3B0aW9ucyBmb3IgdGhlIGZ1bGwgc3BlY2lmaWVk
IHRpbWUuDQo+IA0KPiBJIHRob3VnaHQgcmVleHBvcnQgd29ya2VkIGJ5IGVtYmVkZGluZyB0aGUg
b3JpZ2luYWwgc2VydmVyJ3MNCj4gZmlsZWhhbmRsZXMNCj4gaW4gdGhlIGZpbGVoYW5kbGVzIGdp
dmVuIG91dCBieSB0aGUgcmVleHBvcnRpbmcgc2VydmVyLg0KPiANCj4gU28sIGV2ZW4gaWYgbm90
aGluZydzIGNhY2hlZCwgd2hlbiB0aGUgcmVleHBvcnRpbmcgc2VydmVyIGdldHMgYQ0KPiBmaWxl
aGFuZGxlLCBpdCBzaG91bGQgYmUgYWJsZSB0byBleHRyYWN0IHRoZSBvcmlnaW5hbCBmaWxlaGFu
ZGxlIGZyb20NCj4gaXQNCj4gYW5kIHVzZSB0aGF0Lg0KPiANCj4gSSB3b25kZXIgd2h5IHRoYXQn
cyBub3Qgd29ya2luZz8NCg0KTkZTdjM/IElmIHNvLCBJIHN1c3BlY3QgaXQgaXMgYmVjYXVzZSB3
ZSBuZXZlciB3cm90ZSBhIGxvb2t1cHAoKQ0KY2FsbGJhY2sgZm9yIGl0Lg0KDQo+IA0KPiA+IDQp
IFdpdGggYW4gTkZTdjQgcmUtZXhwb3J0LCBsb3RzIG9mIG9wZW4vY2xvc2UgcmVxdWVzdHMgKGh1
bmRyZWRzDQo+ID4gcGVyDQo+ID4gc2Vjb25kKSBxdWlja2x5IGVhdCB1cCB0aGUgQ1BVIG9uIHRo
ZSByZS1leHBvcnQgc2VydmVyIGFuZCBwZXJmIHRvcA0KPiA+IHNob3dzIHdlIGFyZSBtb3N0bHkg
aW4gbmF0aXZlX3F1ZXVlZF9zcGluX2xvY2tfc2xvd3BhdGguDQo+IA0KPiBBbnkgc3RhdGlzdGlj
cyBvbiB3aG8ncyBjYWxsaW5nIHRoYXQgZnVuY3Rpb24/DQo+IA0KPiA+IERvZXMgTkZTdjQNCj4g
PiBhbHNvIG5lZWQgYW4gb3BlbiBmaWxlIGNhY2hlIGxpa2UgdGhhdCBhZGRlZCB0byBORlN2Mz8g
T3VyDQo+ID4gd29ya2Fyb3VuZA0KPiA+IGlzIHRvIGVpdGhlciBmaXggdGhlIHRoaW5nIGRvaW5n
IGxvdHMgb2YgcmVwZWF0ZWQgb3Blbi9jbG9zZXMgb3INCj4gPiB1c2UNCj4gPiBORlN2MyBpbnN0
ZWFkLg0KPiANCj4gTkZTdjQgdXNlcyB0aGUgc2FtZSBmaWxlIGNhY2hlLiAgSXQgbWlnaHQgYmUg
dGhlIGZpbGUgY2FjaGUgdGhhdCdzIGF0DQo+IGZhdWx0LCBpbiBmYWN0Li4uLg0KPiANCj4gLS1i
Lg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
