Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84537286819
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 21:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJGTLx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 15:11:53 -0400
Received: from mail-dm6nam12on2090.outbound.protection.outlook.com ([40.107.243.90]:38145
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbgJGTLx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 15:11:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGWNQidpQJQ6++6Y06k710z2/LfYh9McjGaQy9cmmtq57WwMWFFcJsrNst0+VOqUB28Ux+E3+C0VoWlyj/FlnSOM00rnA21ivygDACqsXMgTwjtruclOudztKlCM7phjQFHNxB3JlMKSuPa2/t00uVugtemA2yjwaNJlUaGJwczzd1MnNfTxoCrkW5oaPwuNWR5cpvHxneUBqa4kjafmCPVSP+kcVmufp8Kx6P44awGHShv1Zj0zJHnV0vVeE0o4inB84QuJUDdRR/ts2WWLaNXRn67AQLpZqKCe61d8rTLiDf6P2026ofQPg8DiZ6jmAvCAU+IM2twQCO64tMbaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOenwJ74E5e0Xx7FKAewGxjwMf+1mT9pSy7dFkLNKRE=;
 b=IkJ+Fgbxk5kcMnVZ/WSczJ8nQf+hfs6mEbMxGG5SIgaDgplVnLyzzczVJJv7LMyMZRBv243TbPYhBhBQDgBU9V+aTEYVPV7xt76C6Ss2VJtNS+MsTPLPFE62d+8/K5n+J54klhsltdd+SgVZ2f1lcVAbcPet63qPkwgM4owPEvd8YTBRqy/WnOF3SgZDC5pKj3g09Nlk/jg40ty/jH9AgcNRdW4AasZ2dY/zs2O2/byvgJAkbqBkkSimu+COdnLhcuJg+kxCq1bH2TBK9igHn0KT1FjX52l1XekIKVCpSg234txR0oqx4RxIf+hQaqNUBXWa8XuCvAWT0OgJT7KdrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOenwJ74E5e0Xx7FKAewGxjwMf+1mT9pSy7dFkLNKRE=;
 b=MjeVvj5LeJCuICOTJ/AJjqtYVtCzZ9cujSVqOEPhbE2lq8lTEbgNzxfV+jEZVefC4dLX+rGFwxrznQjW5urN40JpKAjjELZVdbwgP0HPeIeUhdf5kq/mZnOCUDbZRzKE/6Wrt813Q0jpF3HkyBB3+0BhMJ+0CqKezBsd+sUmbZM=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3743.namprd13.prod.outlook.com (2603:10b6:208:1f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13; Wed, 7 Oct
 2020 19:11:49 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%7]) with mapi id 15.20.3455.021; Wed, 7 Oct 2020
 19:11:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "bcodding@redhat.com" <bcodding@redhat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Thread-Topic: unsharing tcp connections from different NFS mounts
Thread-Index: AQHWm/NG4ET1NagHX0mhv4Iw/L0dZKmK9/iAgAAkV4CAACp7AIAAuvkAgAAYugCAAA3yAIAABV0AgAAC94CAAB7QAIAACtUAgAAIvoCAAAO/AIAACgMAgAASmIA=
Date:   Wed, 7 Oct 2020 19:11:49 +0000
Message-ID: <a761cb67ba5704ee95a95b863af5a283d554bd20.camel@hammerspace.com>
References: <20201007001814.GA5138@fieldses.org>
         <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
         <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
         <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
         <20201007140502.GC23452@fieldses.org>
         <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
         <20201007160556.GE23452@fieldses.org>
         <6d9aee613e9fb25509c9317910189ee37a2e4b43.camel@hammerspace.com>
         <20201007171559.GF23452@fieldses.org>
         <5998d49f790736aa49e7a2ac89b555bc99f3b543.camel@hammerspace.com>
         <20201007180514.GG23452@fieldses.org>
In-Reply-To: <20201007180514.GG23452@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d743a2d-ab81-4f46-356e-08d86af4d7e0
x-ms-traffictypediagnostic: MN2PR13MB3743:
x-microsoft-antispam-prvs: <MN2PR13MB374312E5CC600D2E99E15316B80A0@MN2PR13MB3743.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W3xVwbz137YaugXBofiyAvb5nyRqpJ3Hc9HY0quY5+XVYLuMC5PoJW+M4XLO/i77gjA1APmU7XNbe5WdoUJj2fX0HkpFoNoXw6HjT/EIYZp4jZ2pIqEDqOpWK4liSM5BJW9PeNj4TfSh/CitPo8CSTb/ZQQ+ypOHW2sKype2l5cu5Tc/V01MyUNQosCJz5+RB3gMCG2SGGNBeYhUWFnzlw9TzivT3ZJXDxhNqdyVwYWKr0Y52RVztGD0AJIAY98pUfjQBjccwW+SD4qlBHzg0RIOWLnc2942QA0wxHArZoDF4N+ag3WXi94OSxAqTozzgf7V9lERPDIwX+FUr5dSGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(39830400003)(366004)(396003)(316002)(2616005)(2906002)(26005)(6506007)(186003)(6916009)(71200400001)(6512007)(36756003)(83380400001)(54906003)(66476007)(4326008)(91956017)(76116006)(5660300002)(6486002)(66946007)(8936002)(478600001)(66446008)(8676002)(64756008)(66556008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Yl3Vfmuc73G9jCpLfvB0xCLpUEcQVXBKMBTBx9M/zLgZo0SuzK/VrJ4Xa0VC8KvR70nHC4Ur8tD0g+bpnD0+xI3xElbSE/2AbNOWSVUiUKySP7ddefso0F+k5dAQMOwNjE2/OlfZB0ATUbLAcfFRqLd6/fUmdr+6UyA53mxI7XXQVBKIkbNcDC5Li7oKNq8UCtaDVrMZtVlorD3IczQSlwslCr62prCSYZoThWE7PT6kepeI3PBJi4B8nYSmA7oBOd39lI/2tkpnxKgkvvazMwPhhqfqAJGqjctq4iUARJhfOVDA4RqRTsWH5gQOOfv9oBGc6hEZNAqUhtqczNCBWpHvLV1kDfYgjCR3fKJuK63Mi5ZZv+e9LF5e6avqYMgD1dD3Qj60c/L4SBnyBHydvnzWFEJnEHp/SpVyl/owwtxyzi+ozyTGh2C0sj3Qzo1pNSkLc90XY1QhCyOLmsNnab/OhMSv6aoTLvf1oDFqRU04uNFESweD0HeIICT9PH0Lr8LN/AmwoXoZzKF32elmMhrecxJTUYpYNat2Z5BqX2T/kFQjl/L8ykEksUd5Qtd7PwUNFtIcRy2ki6MUGVUJjaqPH+bcuHK4bHrTYhhZJjSetSNwLLvh9OvO/Sfzwgjg6w1g8TBsBByj7XA3DeoxJw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <51B8E18AA69B734699541955C561DFD5@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d743a2d-ab81-4f46-356e-08d86af4d7e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 19:11:49.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+9dYvNgRdQUJkS8DwLfX91bkSZr0AtrfBV/w2hDNkp7s2E6Bt/j1tZnD83rCJYdYLES/v/lQD0JXG3BtLMF7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3743
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTA3IGF0IDE0OjA1IC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gV2VkLCBPY3QgMDcsIDIwMjAgYXQgMDU6Mjk6MjZQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMC0xMC0wNyBhdCAxMzoxNSAtMDQwMCwg
QnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gWWVhaCwgaG9uZXN0bHkgSSBkb24ndCB1bmRlcnN0
YW5kIHRoZSBkZXRhaWxzIG9mIHRoYXQgY2FzZQ0KPiA+ID4gZWl0aGVyLg0KPiA+ID4gDQo+ID4g
PiAoVGhlcmUgaXMgb25lIHJlbGF0ZWQgdGhpbmcgSSdtIGN1cmlvdXMgYWJvdXQsIHdoaWNoIGlz
IGhvdyBjbG9zZQ0KPiA+ID4gd2UNCj4gPiA+IGFyZQ0KPiA+ID4gdG8ga2VlcGluZyBjbGllbnRz
IGluIGRpZmZlcmVudCBjb250YWluZXJzIGNvbXBsZXRlbHkgc2VwYXJhdGUNCj4gPiA+ICh3aGlj
aA0KPiA+ID4gd2UnZCBuZWVkLCBmb3IgZXhhbXBsZSwgaWYgd2Ugd2VyZSB0byBldmVyIHBlcm1p
dCB1bnByaXZpbGVnZWQNCj4gPiA+IG5mcw0KPiA+ID4gbW91bnRzKS4gIEl0IGxvb2tzIHRvIG1l
IGxpa2UgYXMgbG9uZyBhcyB0d28gbmV0d29yayBuYW1lc3BhY2VzDQo+ID4gPiB1c2UNCj4gPiA+
IGRpZmZlcmVudCBjbGllbnQgaWRlbnRpZmllcnMsIHRoZSBjbGllbnQgc2hvdWxkIGtlZXAgZGlm
ZmVyZW50DQo+ID4gPiBzdGF0ZQ0KPiA+ID4gZm9yDQo+ID4gPiB0aGVtIGFscmVhZHk/ICBPciBp
cyB0aGVyZSBtb3JlIHRvIGRvIHRoZXJlPykNCj4gPiANCj4gPiBUaGUgY29udGFpbmVyaXNlZCB1
c2UgY2FzZSBzaG91bGQgYWxyZWFkeSB3b3JrLiBUaGUgY29udGFpbmVycyBoYXZlDQo+ID4gdGhl
aXIgb3duIHByaXZhdGUgdW5pcXVpZmllcnMsIHdoaWNoIGNhbiBiZSBjaGFuZ2VkDQo+ID4gdmlh
IC9zeXMvZnMvbmZzL25ldC9uZnNfY2xpZW50L2lkZW50aWZpZXIuDQo+IA0KPiBJIHdhcyBqdXN0
IGxvb2tpbmcgYXQgdGhhdCBjb21taXQgKGJmMTFmYmQyMGIzICJORlM6IEFkZCBzeXNmcw0KPiBz
dXBwb3J0DQo+IGZvciBwZXItY29udGFpbmVyIGlkZW50aWZpZXIiKSwgYW5kIEknbSBjb25mdXNl
ZCBieSBpdDogaXQgYWRkcyBjb2RlDQo+IHRvDQo+IG5mcy9zeXNmcyB0byBnZXQgYW5kIHNldCAi
aWRlbnRpZmllciIsIGJ1dCBub3RoaW5nIGFueXdoZXJlIHRoYXQNCj4gYWN0dWFsbHkgdXNlcyB0
aGUgdmFsdWUuICBJIGNhbid0IGZpZ3VyZSBvdXQgd2hhdCBJJ20gbWlzc2luZy4NCj4gDQoNCk5v
LCB5b3UncmUgcmlnaHQuIFNvbWV0aGluZyBzbGlwcGVkIHVuZGVyIHRoZSByYWRhciB0aGVyZS4g
VGhlDQppbnRlbnRpb24gd2FzIHRoYXQgd2hlbiBpdCBpcyBzZXQsIHRoZSBjb250YWluZXItc3Bl
Y2lmaWMgJ2lkZW50aWZpZXInDQpzaG91bGQgcmVwbGFjZSB0aGUgcmVndWxhciBzeXN0ZW0td2lk
ZSB1bmlxdWlmaWVyLiBJIHRob3VnaHQgSSBoYWQNCm1lcmdlZCBwYXRjaGVzIGZvciB0aGF0LCBi
dXQgYXBwYXJlbnRseSBzb21ldGhpbmcgZ290IHNjcmV3ZWQgdXAuIExldA0KbWUgZml4IHRoYXQg
dXAgZm9yIDUuMTAuLi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQg
bWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20N
Cg0KDQo=
