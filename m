Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CF31BCEBE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2020 23:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgD1VcJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 17:32:09 -0400
Received: from mail-dm6nam11on2104.outbound.protection.outlook.com ([40.107.223.104]:46752
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbgD1VcI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 28 Apr 2020 17:32:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cv5PRpXpWIxqMec7mc6l2hjrywdijHzR6s/PvzAfSbE7LqKVm5rzK7qeZUB4vWVoGRAv0f/oq+awxd0euwPKs7dJfdkS2rw1mQ2lfPkobPpZIxTB7eo9xNjXyjxZVG3pMDjc+nbYTTFmnUp6MNNJzeJ9RIlLRdBJ38unj2GuLs97WWZmFdLoc9a0ie6f+cr4hV5SGCgmVmyskGLzbSYGzyP3ileOx9a1W3banWUPzCNHK2FyZ+GGGVfupgKuFECaREOqWAoUl0Qkv3nUI8cWJsTtcD0U9uHaBYHCBpXs06wnKiANhB0yQl/4chd/Mj3ssxRQ62xs8KjnLyHskhYbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkSZkr827MKeZY9o/vM+E13xbUiB9Nqf+b8u9y7YiPM=;
 b=GfAJSbLTxKRcLO02022jV4YTlDPgnEyliCoPID9XdpM4KipRghqjKcvxJMMrwo+BjEFGJ3gI/ra8fCGlGBnvwiHv3coPVk8kRgXXW9enoG3dX1QZc8D1MK1MGczZIPh5B0AgqpTyFwWZlaVPt5hFImTvMA6i4HOR9Ic9Cvp7V33/Eqntga7lSd8FcP+JplbTqFL2g5TcRUTydNvshjxh9PA5xwBSYULa49ZZuEgolg6ldTTy6qjWIYVEdKCCPuMySqJlF7zf9VuKOfNoRsiVKzfSlg1qdjzf2G+XbwfDCynSeJ2sgOHWfNKbSYYVdGQ3Q1u/H0ikZoqPGqlgT/8SgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkSZkr827MKeZY9o/vM+E13xbUiB9Nqf+b8u9y7YiPM=;
 b=BBsXAsBBup2NcJg4h5OZVpZdiHl4u1SZvlZYKgs03w7dnBQThRthh32eW0+ANxzJaG9+jc4Yi+1A7sNj4nNZp+V1dxr7PtxwxNfWB9lMnJSTX7VXy246WrYuI+Kl3Iv5Gr+rz34sPXWqNDK7Jtvi0pMUr/GbNGC2/66QITkMBhQ=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3526.namprd13.prod.outlook.com (2603:10b6:610:2a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14; Tue, 28 Apr
 2020 21:32:00 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2958.014; Tue, 28 Apr 2020
 21:32:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
Thread-Topic: handling ERR_SERVERFAULT on RESTOREFH
Thread-Index: AQHWHYjzjBZLlmadoEGcRGdAsbmgTaiO38OAgAAfvACAAA5TAA==
Date:   Tue, 28 Apr 2020 21:32:00 +0000
Message-ID: <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
         <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
         <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
In-Reply-To: <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umich.edu; dkim=none (message not signed)
 header.d=none;umich.edu; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e37ebddc-225b-4e19-8c06-08d7ebbb9636
x-ms-traffictypediagnostic: CH2PR13MB3526:
x-microsoft-antispam-prvs: <CH2PR13MB3526DA781CBA02585394B938B8AC0@CH2PR13MB3526.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0387D64A71
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VWg0ZYugaXLw7wVAcdRkaX1qOXYzjkgMkPe4MT/RPQh96phxbou4YbFTTi2HjKrKZDxAi4Jhul7NH/I9sfUJFvXgZ3v0yzJER8b3YztiIO7iYutNmBeGBZem8KEv2XsZXi/0qA8ZLfTlDrH4oP5uOolYWZ6AnjH3TXkYQLZLnrpHo71a1ghLRp+A2hnn9xrpvdtk+qISKK7PyocoVpE/rATjTARXMFIEijRVD9kXZEhH7g8HpRksimUGwJdANDEr1jEd3Xi89LcCwYSmraVjY2sfRvN73PjaJZwJadgQlTejZ2IGPe0/ebjQonqUEvyXWcF2WXmMVI9O5Vbm5hoFVTugiRu192DMO1sSnQrb8RFsLnQCKl7CfClUacO2AOYmdfSgXaja1JSnaaqliz1BPkJ9Fi+1XbcbyqpzrhSJhVwvwbkYbjbL/fXyZTjNMlRt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(366004)(376002)(39830400003)(186003)(6486002)(4326008)(8936002)(8676002)(478600001)(6916009)(66556008)(6512007)(66476007)(66946007)(76116006)(64756008)(91956017)(66446008)(86362001)(53546011)(36756003)(5660300002)(26005)(71200400001)(2906002)(6506007)(316002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oEmv4pjXbGmjhDCnc96eVpRcgoTZn2kj8XRqW0dsY8XDGWc80M7qfUs+fF6t9YSyuKfhefsbUDGa3aWGbeWYqw53wDk+PAncmZtkN/qWFrn12My4Gd/xCpZMlBOY5MZZEat8/iFlJM1vyr+PiAZXe73mk6V1hjDL1pmVR6YubjhF2VL0uzPQtXlzA2pJ73KsMvOXLfeesvSrocLbcdKWZiDfPFR5LPPVHVfjO8VRTaTxXmeqoLAmGgTsaZZ4feGbKFtLu32y92Xw4Jhcj5/zf9HHc7l5X8j3yVBrOJSftjH5WmnpKoXGUYPBf8EeoDU6AGq9tn9lHIe2MdxaUkyP9ja7XXeKnkToSAv47qYt9R4hY5NTN7RcEIma4V7P/PN3hqQFs8VTheMOv7Fqk9Ik3YStnpECea9hja8Pc3AQGKm++k1Wig8jEkxqy2P/VTvem+BlMJGtnGitGXje60tQOJWd52sNZOkSwRz5E/VStEdXXPEfYQiGhMPV8kt2NcN0DxPJKt9c52WcpZAZuo6jUtw0oQ+U1f9MiDzTd2gldd5ZTE/n/U/DR7nruiVxYGJnYo/Dg7eVy0/yNE91MiOozNWXkU4gS2F8OT+vhHjJh4MBagpM4a18o3u6PE4EvT6MqxMRtLJ9hL6PhpZXDhj+dXNl9ayzzeUbvWGcc6/yO7FZKz2nuXenY+TErFigXCr9Bui2XyTRFwWu0SwfBzsNPAM5x20VVL7Wf5KhFSEOEsf59vG095icexmsjhVA562G3mCCHSG7zMjPXmzWnZK6TyYQB+2aEXetuv4vDNPJ0r0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1E3ADFC2497334DBDF80E0A5BB7E574@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37ebddc-225b-4e19-8c06-08d7ebbb9636
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 21:32:00.6664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NgCfynZhgtBFSm1od3KtNRGY2+N98eddRBLeNPvJ50+10byKwewdi9l7uOdH5D1QCVR4bkCh0T3yJJdjN1sB0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3526
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTI4IGF0IDE2OjQwIC0wNDAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gT24gVHVlLCBBcHIgMjgsIDIwMjAgYXQgMjo0NyBQTSBUcm9uZCBNeWtsZWJ1c3QgPA0K
PiB0cm9uZG15QGhhbW1lcnNwYWNlLmNvbT4gd3JvdGU6DQo+ID4gSGkgT2xnYSwNCj4gPiANCj4g
PiBPbiBUdWUsIDIwMjAtMDQtMjggYXQgMTQ6MTQgLTA0MDAsIE9sZ2EgS29ybmlldnNrYWlhIHdy
b3RlOg0KPiA+ID4gSGkgZm9saywNCj4gPiA+IA0KPiA+ID4gTG9va2luZyBmb3IgZ3VpZGFuY2Ug
b24gd2hhdCBmb2xrcyB0aGluay4gQSBjbGllbnQgaXMgc2VuZGluZyBhDQo+ID4gPiBMSU5LDQo+
ID4gPiBvcGVyYXRpb24gdG8gdGhlIHNlcnZlci4gVGhpcyBjb21wb3VuZCBhZnRlciB0aGUgTElO
SyBoYXMNCj4gPiA+IFJFU1RPUkVGSA0KPiA+ID4gYW5kIEdFVEFUVFIuIFNlcnZlciByZXR1cm5z
IFNFUlZFUl9GQVVMVCB0byBvbiBSRVNUT1JFRkguIEJ1dA0KPiA+ID4gTElOSyBpcw0KPiA+ID4g
ZG9uZSBzdWNjZXNzZnVsbHkuIENsaWVudCBzdGlsbCBmYWlscyB0aGUgc3lzdGVtIGNhbGwgd2l0
aCBFSU8uDQo+ID4gPiBXZQ0KPiA+ID4gaGF2ZSBhIGhhcmRsaW5lIGFuZCAibG4iIHNheWluZyBo
YXJkbGluayBmYWlsZWQuDQo+ID4gPiANCj4gPiA+IFNob3VsZCB0aGUgY2xpZW50IG5vdCBmYWls
IHRoZSBzeXN0ZW0gY2FsbCBpbiB0aGlzIGNhc2U/IFRoZSBmYWN0DQo+ID4gPiB0aGF0DQo+ID4g
PiB3ZSBjb3VsZG4ndCBnZXQgdXAtdG8tZGF0ZSBhdHRyaWJ1dGVzIGRvbid0IHNlZW0gbGlrZSB0
aGUgcmVhc29uDQo+ID4gPiB0bw0KPiA+ID4gZmFpbCB0aGUgc3lzdGVtIGNhbGw/DQo+ID4gPiAN
Cj4gPiA+IFRoYW5rIHlvdS4NCj4gPiANCj4gPiBJIGRvbid0IHJlYWxseSBzZWUgdGhpcyBhcyB3
b3J0aCBmaXhpbmcgb24gdGhlIGNsaWVudC4gSXQgaXMgdmVyeQ0KPiA+IGNsZWFybHkgYSBzZXJ2
ZXIgYnVnLg0KPiANCj4gV2h5IGlzIHRoYXQgYSBzZXJ2ZXIgYnVnPyBBIHNlcnZlciBjYW4gbGVn
aXRpbWF0ZWx5IGhhdmUgYW4gaXNzdWUNCj4gdHJ5aW5nIHRvIGV4ZWN1dGUgYW4gb3BlcmF0aW9u
IChSRVNUT1JFRkgpIGFuZCBsZWdpdGltYXRlbHkgcmV0dXJuaW5nDQo+IGFuIGVycm9yLg0KDQpJ
ZiBpdCBpcyBoYXBwZW5pbmcgY29uc2lzdGVudGx5IG9uIHRoZSBzZXJ2ZXIsIHRoZW4gaXQgaXMg
YSBidWcsIGFuZCBpdA0KZ2V0cyByZXBvcnRlZCBieSB0aGUgY2xpZW50IGluIHRoZSBzYW1lIHdh
eSB3ZSBhbHdheXMgcmVwb3J0DQpORlM0RVJSX1NFUlZFUkZBVUxULCBieSBjb252ZXJ0aW5nIHRv
IGFuIEVSRU1PVEVJTy4NCg0KPiBORlMgY2xpZW50IGFsc28gaWdub3JlcyBlcnJvcnMgb2YgdGhl
IHJldHVybmluZyBHRVRBVFRSIGFmdGVyIHRoZQ0KPiBSRVNUT1JFRkguIFNvIEknbSBub3Qgc3Vy
ZSB3aHkgd2UgYXJlIHRoZW4gbm90IGlnbm9yaW5nIGVycm9ycyAob3INCj4gc29tZSBlcnJvcnMp
IG9mIHRoZSBSRVNUT1JFRkguDQoNCldlIGRvIG5lZWQgdG8gY2hlY2sgdGhlIHZhbHVlIG9mIFJF
U1RPUkVGSCBpbiBvcmRlciB0byBmaWd1cmUgb3V0IGlmIHdlDQpjYW4gY29udGludWUgcmVhZGlu
ZyB0aGUgWERSIGJ1ZmZlciB0byBkZWNvZGUgdGhlIGZpbGUgYXR0cmlidXRlcy4gV2UNCndhbnQg
dG8gcmVhZCB0aG9zZSBmaWxlIGF0dHJpYnV0ZXMgYmVjYXVzZSB3ZSBkbyBleHBlY3QgdGhlIGNo
YW5nZQ0KYXR0cmlidXRlLCB0aGUgY3RpbWUgYW5kIHRoZSBubGlua3MgdmFsdWVzIHRvIGFsbCBj
aGFuZ2UgYXMgYSByZXN1bHQgb2YNCnRoZSBvcGVyYXRpb24uDQoNCkNoZWVycw0KICBUcm9uZA0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
