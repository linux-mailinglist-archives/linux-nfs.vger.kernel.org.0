Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC18240791
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Aug 2020 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHJO0Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Aug 2020 10:26:24 -0400
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:21984
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgHJO0X (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 Aug 2020 10:26:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6xpmH9kNTLeQ9rHp04lBANc5YD7GK6H86cwar49BUoBqzWniJfKezcVzrEG1QU9/uGv70ZVrcPg6ZUg4pgUMAWGWrZf6oi+25p6v2724xzVhumik1Q0EHamgsajAkQa9JWfHMq/3UAXzNJ6kVHVd0Bxsha7td0lvSqxLSaqSrjm9KkudyaLNqPdb+/XcIPUg3zLB4qFz0us+omZNdPnSx1uFvoMusE5JB9FMfq22Ax0r7mWCahPeK+XeCOdiX+kt9re36cS/ktZDKls07Z16OohdlodQ4SmZ1NnGJc5IYezPpjzBxla4HIfHUeODGoLruYGSWhSNZTdGQ38y5vizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrmhQb1UqaCTrKifdl49CPbDPp8cjTp+Av9WJcBcwE0=;
 b=YTGDavg4otFIlAk9FSsezbODuK23i6NBJpHY3MMvx/8cq5Y4RJ+vmUQnSr/Eji/Mq6jNLDL+Ryh+K/ejr/s4gHuB2Lu3yXacP9H70PpFOMleF/pD0kUfAZ80ftHBm25+TDBpW07USkm11f7JxLn+sYafbbgQZfppDqQz8tiMChWub9b8lmdWWiIRt7NMJV/lu0aszZ6K6FijeQlu2R7A3vMNBbZ7c0K2U3Yff0+v8UkMdOMcJotNyXX3Fda64dXUjXgM9aOWMT/VcqVTG6CAjldiKju5Bt+8DqKhCUSeqwVTHaIAM1DqAnaxgvJdTLrMiMJzmX4p/nd3u77b1UONrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrmhQb1UqaCTrKifdl49CPbDPp8cjTp+Av9WJcBcwE0=;
 b=O4MrZBx+XahNXMOnwdbnUsndN3V0gJpVaSKetk7hpWx2bNeZ466+eKEjNcKOglVDP+C1A/O/gxcNznqwDZqKecNd4+QvD0eOHakOQSDOPUC8QqiuAyzFtXAzOkRmxXRUJ5UUVCK7NOsjiYDtPLxeHq0iuqoLMEjIYvkgVhh1iUM=
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 (2603:10b6:301:2e::20) by MWHPR1001MB2077.namprd10.prod.outlook.com
 (2603:10b6:301:36::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Mon, 10 Aug
 2020 14:26:20 +0000
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::ad32:3fef:28b7:2573]) by MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::ad32:3fef:28b7:2573%2]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 14:26:20 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>
Subject: Re: idmapd Domain issue
Thread-Topic: idmapd Domain issue
Thread-Index: AQHWbW2oNVn2R9H9LEKSBtsqgjvvRakxZgYAgAADigA=
Date:   Mon, 10 Aug 2020 14:26:19 +0000
Message-ID: <3d4d41bde90709f0016d37f1f60c71ad61d10e75.camel@infinera.com>
References: <80a43e48b6f0c6c8806d1f8f6ca5ed575269445f.camel@infinera.com>
         <13df4b7e-c965-6ca8-eadd-a45e9f841914@RedHat.com>
In-Reply-To: <13df4b7e-c965-6ca8-eadd-a45e9f841914@RedHat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.37.90 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d0c8ab8-d755-4470-ab82-08d83d3959bc
x-ms-traffictypediagnostic: MWHPR1001MB2077:
x-microsoft-antispam-prvs: <MWHPR1001MB20779A87D9CBC1DBEA5B4192F4440@MWHPR1001MB2077.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xl9Kd7bdjsi6KSfW2okXzgrIo2U64E94p+Va1Lp2gqxlVK+dFmaAg10/jfH/y4SAFyjkCU1NonPfyBxYAHsYDsc8yKgQmtPeheP3qmNgq8b21xVYxlOc/FGPpcXdQgBzhTgcpTWoUxxF9FJKz+oN74WeGNT+48nzluChb5N7Q6vtqX0z1NzapbRQ7jSUr3/4CzAmqTH34VnRaKGPRH/yDmD8W2AAFCnbnkwre5kzp6aOQgUTYykXs+gOXxjT00FnVREKUuLu2C5fha59sq9UW3Jqxhuj7Wu2CoFKWtFEHykAn1Hk4Ad91+AylrokaZtwMNkDm9+dCBGMg0WCgYSIWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2190.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(110136005)(6486002)(6512007)(186003)(8936002)(7116003)(2616005)(86362001)(8676002)(26005)(6506007)(53546011)(71200400001)(316002)(91956017)(76116006)(3480700007)(5660300002)(2906002)(66556008)(36756003)(66946007)(478600001)(64756008)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IAPQu5cXo+mHSRDe4OVw3dXH6s548SkelzP49Y4LqfQ4OFLRVjkTxcUc07Gd5rf9/uVPFD96anBHAhi2IuhVKlASn/4db/TU6m9pbHqgbyG3nbjl6GV02bzpbLTwUu46AllA3P3S3HpKclfGPS3pulQ5xESlSgvumbk1yPcrwVzL6mv21qoVoZnCtUTK8X6pDvFoCXDa4VySjSl+8n6Qpn5hF7bih2B/kYgO0RxabGZvzvjI+gTZ723TYQC0hhvcBIeOuUn3hRqpY2kLeVTnkHxX3AsZzLxWD9ZpmRSlZ5U2oP1N6Z7LBoOldqEORHjb48BhfDGfw8jwzETOUy/BVB5WaiEzJTYN083qMrkPMWWn/4Ez84xWX7UBmOPXFHDolO+7yXgFIFLrBGEVLl5VfcQJtZMoeS80NAbozkZRAqewutkw3eU4ERBjigupa8r3taWhtAPoAQaqz53lAx1dIDFIDfAvkReI5l7M8rM+/3/xa4hKduAr/ISRsulZ/MD7sX0Oqp0yzQ2gHZDh7Bt/Ys3sn5haRzh+kuRbm3QlOle2CLDeQRSBnu/pFXrEtg2abnt8ZU5jhgSzGf/K5DtR/a8L/lyMc15ohGBBhAYbvc42t7eQKKdDwqrJM3hcDUxQzsrbPU7mfVsRZ6JGXfNdmQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <382FC28231D35442A19BBA78A63A9259@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2190.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0c8ab8-d755-4470-ab82-08d83d3959bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 14:26:19.8313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnmAFf9f/3ZMtlHIDnmEEA70EwgSn4EZzaxYzRZTpeeYe7XUp9kcSsoURVHPlTrUs4dkDNjEW6X9WlmDb6xEqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2077
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDIwLTA4LTEwIGF0IDEwOjEzIC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdh
bml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4g
DQo+IA0KPiBPbiA4LzgvMjAgNjoyMSBBTSwgSm9ha2ltIFRqZXJubHVuZCB3cm90ZToNCj4gPiBX
ZSBnb3QgYW4gb2xkLCBub24gZXhpc3RpbmcsIGRvbWFpbiBjb25maWd1cmVkIGZvciBpZG1hcGQs
IGxpa2Ugc286DQo+ID4gwqDCoERvbWFpbiA9IHgueQ0KPiA+IA0KPiA+IE5vdyBJIHdvdWxkIGxp
a2UgdG8gY2hhbmdlIHRoYXQgdG8gb3VyIG5ldyBkb21haW4gYnV0IEkgY2Fubm90DQo+ID4gY2hh
bmdlIGFsbCBjb21wdXRlcnMgdXNpbmcgdGhlIG9sZCBkb21haW4gYXQgdGhlIHNhbWUgdGltZS4N
Cj4gPiANCj4gPiBJZGVhbGx5IEkgd291bGQgbGlrZSB0byBqdXN0IGFkZCB0aGUgbmV3IGRvbWFp
biBhbmQgdGhlbiBjaGFuZ2UNCj4gPiBjbGllbnRzIGdyYWR1YWxseSBhcyB0aW1lIHBlcm1pdHMu
DQo+ID4gDQo+ID4gQ3VycmVudGx5IGlkbWFwZCBkb2VzIG5vdCBzZWVtcyB0byBzdXBwb3J0IHRo
aXMgPw0KPiBJIG5vdCBzdXJlIGlmIHRoYXQgaGVscHMuLi4gYnV0IHJwYy5pZG1hcGQgZG9lcyBx
dWVyeSBETlMNCj4gbG9va2luZyBmb3IgdGhlIF9uZnN2NGlkbWFwZG9tYWluIHRleHQgcmVjb3Jk
Li4uICBBZGQNCj4gwqDCoMKgwqDCoF9uZnN2NGlkbWFwZG9tYWluIElOIFRYVCAiZG9tYWlubmFt
ZSINCj4gwqByZWNvcmRlZCB0byB5b3VyIEROUw0KDQpZb3UgbWVhbjoNCiAxKSBBZGQgX25mc3Y0
aWRtYXBkb21haW4gSU4gVFhUICJ4LnkiIHRvIEROUw0KIDIpIFJtIGFsbCBEb21haW4gPSB4Lnkg
aWRtYXBkIGNvbmYNCiAzKSBDaGFuZ2UgbmZzdjRpZG1hcGRvbWFpbiBJTiBUWFQgIm5ldy5jb20i
IChkbyBJIG5lZWQgdG8gcmVzdGFydCBpZG1hcGQgaGVyZSB0b28/KQ0KPw0KDQo+IA0KPiA+IENv
dWxkIG11bHRpcGxlIGRvbWFpbnMgYmUgYWRkZWQgPw0KPiBQYXRjaGVzIGFyZSBhbHdheXMgd2Vs
Y29tZSEgOy0pIEJ1dCBJIGRvbid0IHNlZQ0KPiBob3cgdGhlIHdvdWxkIGV2ZXIgd29yayBhbmQg
aXRzIHByb2JhYmx5IGJyZWFrDQo+IGEgZmV3IHNwZWNzLg0KDQpUaGV5IGRpZG4ndCBjb25zaWRl
ciByZW5hbWUgbWlncmF0aW9uIHdoZW4gdGhvc2Ugc3BlY3Mgd2hlcmUgd3JpdHRlbiA6KQ0KDQog
Sm9ja2UNCg0KPiANCj4gc3RldmVkLg0KPiA+IA0KPiA+IMKgSm9ja2UNCj4gPiANCj4gDQoNCg==
