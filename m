Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D652807B0
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Oct 2020 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbgJATYp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Oct 2020 15:24:45 -0400
Received: from mail-bn8nam12on2123.outbound.protection.outlook.com ([40.107.237.123]:23698
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729990AbgJATYp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 1 Oct 2020 15:24:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J55RIr3qLjGNNhhH2ASO8EbWmtGN1ia7mSO1eO3d01IDQip8ufnLGe3aviMRCHf+lCKK4ZeQxZQZPBuqxyfb2evFoWQijEdmBOfL3prodbKv01jDxEWJ5mgAUjCX6WWDE/ExJm7NFQfmz5Uk05Jhllvm/ZD66+BVFAA7QXXOUbpmT6ftbV5zp2pwip/e13a4Htp/b+5Celun/gHtkXMVhZuSsd735Ghsi8e9iKYzt0xosj+WJeGYOKkWH3QazIKyJbD32bEqUGl7KU5hN9OAbmDdxqyHrB3tiXld0byjnFGOSapc6Pxx4X8/sRJmxcqpSK/zwlbE5C/UPLwVfqiO5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WAqWh+eWI7OMhfzqvnTGLjtq2bkNU0RG5n7D79B7+4=;
 b=aNm77VanwYEbT3sfWK3HrcMuk23hPKGB6fnKLh7CuNkWrlYxTuexbAYUmB/65Qp8cwglAPq4rAk26IrKEIbFyiJLkLsJW4RN6AN8cnj4s58kGOt7NjqOWSONXBqJEj1fx7nrZVcwI/k6wDMJ5e1xEg5iTqLWsUK1UNUbO+xJN5x9JERNEUfV7L9kboV8Mhi3YJIvXSrZA0H9ZFG42Zh+CmENS5b9fE5GhAJmJL5tq4hw5QlWqk3sxFnwpeVyuM0sc0+9iERmECYtjre0VqSI3AgC1FXARgzMcH7gRkLCaq//EbpyI01mMgmoaI2J3fUjghmLNPJUPaacJR1l4OYE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WAqWh+eWI7OMhfzqvnTGLjtq2bkNU0RG5n7D79B7+4=;
 b=Jm/A7rTMxvh4erMONfasg8RkL3uHmmhExpUiwMkJtbutAb0nw01p0Ku3drnJj94HkECqTNPfKdOSzrZtpXoZJXosCUqNXNAMIewVDEFaXYlzodJ4M09hE+FwCO/A6Peokz3tyy3EHG6v7/nFhkX34p+GejZQJtykarG8vvNgk9k=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3837.namprd13.prod.outlook.com (2603:10b6:208:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.22; Thu, 1 Oct
 2020 19:24:42 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 19:24:42 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: [Linux-cachefs] Adventures in NFS re-exporting
Thread-Topic: [Linux-cachefs] Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR1/IOmk+iGKBtwAAMJPuAAABg7oA
Date:   Thu, 1 Oct 2020 19:24:42 +0000
Message-ID: <1424d45ba1d140bfcff4ae834c70b0a79daa6807.camel@hammerspace.com>
References: <943482310.31162206.1599499860595.JavaMail.zimbra@dneg.com>
         <1155061727.42788071.1600777874179.JavaMail.zimbra@dneg.com>
         <97eff1ee2886c14bcd7972b17330f18ceacdef78.camel@kernel.org>
         <20201001184118.GE1496@fieldses.org>
In-Reply-To: <20201001184118.GE1496@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df3cf789-4eae-47ce-e960-08d8663fa5de
x-ms-traffictypediagnostic: MN2PR13MB3837:
x-microsoft-antispam-prvs: <MN2PR13MB38377B6133E3262CE9478D90B8300@MN2PR13MB3837.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zN7lfOtO+AQs5yLnCLD+3MMQfpYOJdqeMAEJdrUJ49ZCufnkm7nDEc8LGG5n5YER04KNipBvGU87rpndbmvgM5Zormkh6hU9EzIsLGazzpmJVmq7FT9ob2RGPBqi7Qw9EhbFKe0DSVcJ3svOb6aH24tQmReSwys1rMZhAwrpYNVz9m5YxdOpp30n1eHH+7j8aqvr+XcuxaRiwyvMgh2r5pza3rHLoz0mKXwDIvFAtZUoFRqeQQvS0JqZN9uqJONnykLs/cGR6AW72/vaq9Yiuy6HizjnN8Z3l1aCmKTXSnks8u7gkOJVNEvZdFkF9Yh0P87aF6zVHIffZVLhHC2ZGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(376002)(366004)(396003)(8676002)(8936002)(66556008)(66476007)(91956017)(66946007)(66446008)(64756008)(2906002)(76116006)(36756003)(316002)(54906003)(71200400001)(5660300002)(110136005)(186003)(6512007)(2616005)(26005)(83380400001)(4326008)(6506007)(6486002)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rOWo/aTR+4Ym2xZakyzWaAiFpcRETfaF65fqdDq3Atv/Po/yJOn3xhdL2a+lMJW8Dit+VtLZ3IwOc6koikC22Lif5rP46ebtWBX/royEpX+q7XwphXQwN1hNtKaRA2/Mrd0Pr8eAk8oKYImaGU60tA3y8Jjq4huBf4dURg7G5x/jQGRIV2Q574IJ8PsQ5j4tkhOOnC37RMa2TZb8Agvm4wKD4C093HjrNUv40wkFsN0sahtfOXzz+T5/dyVKg3DrIXOTQQ6NQw8FlHf0MMVwMhQztDcgaqSWERi0LQRnCqgVwR3+oygoFG2mgtwi+viiriur0GVd7dJRSyVcH3i9W3NnhErFdT2JuGJRTepw2GdYW8xG+Rb4RigbvdCIW11ZBFcE3CMGfJkBuAT+Hw2CW3bkT1rSHeaELUqhT1+WwZa3dY6wZ+8zdL9XsmpM7nJlmDZ0fHnk2jnytzpXSHWwQ1B1551f9NX1ih2Zv1vmCo+kynrBVuugD6ZrIr8yeyTKQw3yN4JfVsQ8Ql8G2/1a8JfDrlR82osJPxMB8QRRhr7VRTRRS14OjA+oEG6MRWUOFvefMggurGLJfPQsQYoxpwNDDCK5l0EjRebTk39nTSjqhbqiFaBlef1tO7c0k/T62q+f03AdBqdJa/bXga/b4A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <192A802A997A5747B3AAEDB0ED10B146@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3cf789-4eae-47ce-e960-08d8663fa5de
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 19:24:42.2795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axcQaxSDa6Qf39SkeptwVRvzGZCcOwd5ETEPAALDBruNCxxWQYp2SXuyqkgqdXq/crDmQkmbgsnNfH25dmr1mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3837
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEwLTAxIGF0IDE0OjQxIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFdlZCwgU2VwIDMwLCAyMDIwIGF0IDAzOjMwOjIyUE0gLTA0MDAsIEplZmYgTGF5dG9u
IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMC0wOS0yMiBhdCAxMzozMSArMDEwMCwgRGFpcmUgQnly
bmUgd3JvdGU6DQo+ID4gPiBUaGlzIHBhdGNoIGhlbHBzIHRvIGF2b2lkIHRoaXMgd2hlbiBhcHBs
aWVkIHRvIHRoZSByZS1leHBvcnQNCj4gPiA+IHNlcnZlciBidXQgdGhlcmUgbWF5IGJlIG90aGVy
IHBsYWNlcyB3aGVyZSB0aGlzIGhhcHBlbnMgdG9vLiBJDQo+ID4gPiBhY2NlcHQgdGhhdCB0aGlz
IHBhdGNoIGlzIHByb2JhYmx5IG5vdCB0aGUgcmlnaHQvZ2VuZXJhbCB3YXkgdG8NCj4gPiA+IGRv
IHRoaXMsIGJ1dCBpdCBoZWxwcyB0byBoaWdobGlnaHQgdGhlIGlzc3VlIHdoZW4gcmUtZXhwb3J0
aW5nDQo+ID4gPiBhbmQgaXQgd29ya3Mgd2VsbCBmb3Igb3VyIHVzZSBjYXNlOg0KPiA+ID4gDQo+
ID4gPiAtLS0gbGludXgtNS41LjAtMS5lbDcueDg2XzY0L2ZzL25mcy9pbm9kZS5jICAgICAyMDIw
LTAxLTI3DQo+ID4gPiAwMDoyMzowMy4wMDAwMDAwMDAgKzAwMDANCj4gPiA+ICsrKyBuZXcvZnMv
bmZzL2lub2RlLmMgIDIwMjAtMDItMTMgMTY6MzI6MDkuMDEzMDU1MDc0ICswMDAwDQo+ID4gPiBA
QCAtMTg2OSw3ICsxODY5LDcgQEANCj4gPiA+ICANCj4gPiA+ICAgICAgICAgLyogTW9yZSBjYWNo
ZSBjb25zaXN0ZW5jeSBjaGVja3MgKi8NCj4gPiA+ICAgICAgICAgaWYgKGZhdHRyLT52YWxpZCAm
IE5GU19BVFRSX0ZBVFRSX0NIQU5HRSkgew0KPiA+ID4gLSAgICAgICAgICAgICAgIGlmICghaW5v
ZGVfZXFfaXZlcnNpb25fcmF3KGlub2RlLCBmYXR0ci0NCj4gPiA+ID5jaGFuZ2VfYXR0cikpIHsN
Cj4gPiA+ICsgICAgICAgICAgICAgICBpZiAoaW5vZGVfcGVla19pdmVyc2lvbl9yYXcoaW5vZGUp
IDwgZmF0dHItDQo+ID4gPiA+Y2hhbmdlX2F0dHIpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIC8qIENvdWxkIGl0IGJlIGEgcmFjZSB3aXRoIHdyaXRlYmFjaz8gKi8NCj4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGlmICghKGhhdmVfd3JpdGVycyB8fCBoYXZlX2RlbGVnYXRp
b24pKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludmFsaWQgfD0g
TkZTX0lOT19JTlZBTElEX0RBVEENCj4gPiA+IA0KPiA+ID4gV2l0aCB0aGlzIHBhdGNoLCB0aGUg
cmUtZXhwb3J0IHNlcnZlcidzIE5GUyBjbGllbnQgYXR0cmlidXRlDQo+ID4gPiBjYWNoZSBpcyBt
YWludGFpbmVkIGFuZCB1c2VkIGJ5IGFsbCB0aGUgY2xpZW50cyB0aGF0IHRoZW4gbW91bnQNCj4g
PiA+IGl0LiBXaGVuIG1hbnkgaHVuZHJlZHMgb2YgY2xpZW50cyBhcmUgYWxsIGRvaW5nIHNpbWls
YXIgdGhpbmdzIGF0DQo+ID4gPiB0aGUgc2FtZSB0aW1lLCB0aGUgcmUtZXhwb3J0IHNlcnZlcidz
IE5GUyBjbGllbnQgY2FjaGUgaXMNCj4gPiA+IGludmFsdWFibGUgaW4gYWNjZWxlcmF0aW5nIHRo
ZSBsb29rdXBzIChnZXRhdHRycykuDQo+ID4gPiANCj4gPiA+IFBlcmhhcHMgYSBtb3JlIGNvcnJl
Y3QgYXBwcm9hY2ggd291bGQgYmUgdG8gZGV0ZWN0IHdoZW4gaXQgaXMNCj4gPiA+IGtuZnNkIHRo
YXQgaXMgYWNjZXNzaW5nIHRoZSBjbGllbnQgbW91bnQgYW5kIGNoYW5nZSB0aGUgY2FjaGUNCj4g
PiA+IGNvbnNpc3RlbmN5IGNoZWNrcyBhY2NvcmRpbmdseT8gDQo+ID4gDQo+ID4gWWVhaCwgSSBk
b24ndCB0aGluayB5b3UgY2FuIGRvIHRoaXMgZm9yIHRoZSByZWFzb25zIFRyb25kIG91dGxpbmVk
Lg0KPiANCj4gSSdtIG5vdCBjbGVhciB3aGV0aGVyIFRyb25kIHRob3VnaHQgdGhhdCBrbmZzZCdz
IGJlaGF2aW9yIGluIHRoZSBjYXNlDQo+IGl0DQo+IHJldHVybnMgTkZTNF9DSEFOR0VfVFlQRV9J
U19NT05PVE9OSUNfSU5DUiBtaWdodCBiZSBnb29kIGVub3VnaCB0bw0KPiBhbGxvdw0KPiB0aGlz
IG9yIHNvbWUgb3RoZXIgb3B0aW1pemF0aW9uLg0KPiANCg0KTkZTNF9DSEFOR0VfVFlQRV9JU19N
T05PVE9OSUNfSU5DUiBzaG91bGQgbm9ybWFsbHkgYmUgZ29vZCBlbm91Z2ggdG8NCmFsbG93IHRo
ZSBhYm92ZSBvcHRpbWlzYXRpb24sIHllcy4gSSdtIGxlc3Mgc3VyZSBhYm91dCB3aGV0aGVyIG9y
IG5vdA0Kd2UgYXJlIGNvcnJlY3QgaW4gcmV0dXJuaW5nIE5GUzRfQ0hBTkdFX1RZUEVfSVNfTU9O
T1RPTklDX0lOQ1Igd2hlbiBpbg0KZmFjdCB3ZSBhcmUgYWRkaW5nIHRoZSBjdGltZSBhbmQgZmls
ZXN5c3RlbS1zcGVjaWZpYyBjaGFuZ2UgYXR0cmlidXRlLA0KYnV0IHdlIGNvdWxkIGZpeCB0aGF0
IHRvby4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
