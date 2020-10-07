Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257B42866D2
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Oct 2020 20:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgJGSTi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 14:19:38 -0400
Received: from mail-co1nam11on2119.outbound.protection.outlook.com ([40.107.220.119]:14080
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgJGSTh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 14:19:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8kvN9qHWbLAs8eo0zh3FEU6y2m7udvzBUbEx2E0Fj1cR8iIIjaAzyt5Mmix70NYFaaEhwYhcXAurDq+TwBWcb30uRtZgf0EBf42CXZenK5Pg7cAUXTUNLOg1yA8WvWZcMqpEHbDUlAEkZPHLfToyBwHtJ37stZDP7q/cOIZwyjy/EO164Lzs1e+0pBd8wRkXJBmunqQ9ht8FEAzAW8G1drwZM3vnbqHzSqwxISj/E0esnaQ49j63q77+XSsQjaH7UxAgR0OBkUuNK2GzKbMtyH9OV3t56EH+lr7UeT6r/v4ikwjpvWocwieu59CeY/mmAjGNv3bxuY6Hz0JFtrwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUCdwmOyUvegaffXm+lEIB6IF0Q2DbmhFw0RULehdVY=;
 b=DstvM46ZA5jFQH6XI+Dcb+/N9NmRfaLvGKdjwRP6wH4Lyloe/SuqyGlsMqOGV4d80fw9iUKupgB4dHywZZKlKhWMFpWKXXSOAZkfEzLNydQ16gWFkCX1DLgJga8abV1aH8D5sgvQRU7YLkDZy96XifHzZUPo5Qi2jHuU1MuCG0ay3r1LLrnRlQdN0k7/LMwMWwTkT3gYYkA4fi7S21WV4T6wL1XvLBNOJoq6gxplUHeB9Xbxh32DzVK1R+zQhTbxQCBUZK2fhx11braiXuWgsNeudft1LJwaYWaVLPCVPqxnKk8K9kePVQ4FkFT49jRMrHEXv1Kyr48PcJQPipXh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUCdwmOyUvegaffXm+lEIB6IF0Q2DbmhFw0RULehdVY=;
 b=YQv3RKm/Xrly36B0drtNFqLxY39RMpD+BzZ83W70FCBVQwNOpsEMHm2m5yvDTB7TJvlNwiw7V3cUCqRsM43UIjcZBH8AJfur7owct+/rrkfJ5rEzqZM4S3nf4MD3gCO2f6eiYx7ilkLDJGxLf4S7sIuPy+C94+dxwWD9OqPwXeo=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB4174.namprd13.prod.outlook.com (2603:10b6:208:3e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11; Wed, 7 Oct
 2020 18:19:33 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%7]) with mapi id 15.20.3455.021; Wed, 7 Oct 2020
 18:19:33 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: unsharing tcp connections from different NFS mounts
Thread-Topic: unsharing tcp connections from different NFS mounts
Thread-Index: AQHWm/NG4ET1NagHX0mhv4Iw/L0dZKmK9/iAgAAkV4CAACp7AIAAuvkAgAAYugCAAA3yAIAABV0AgAAC94CAAB7QAIAACtUAgAAWRQCAAAQ5gA==
Date:   Wed, 7 Oct 2020 18:19:33 +0000
Message-ID: <3e6860bc5f72e3e0d1c4be9e577e83221aecd1a8.camel@hammerspace.com>
References: <20201006151335.GB28306@fieldses.org>
         <95542179-0C20-4A1F-A835-77E73AD70DB8@redhat.com>
         <CAN-5tyGDC0VQqjqUNzs_Ka+-G_1eCScVxuXvWsp7xe7QYj69Ww@mail.gmail.com>
         <20201007001814.GA5138@fieldses.org>
         <57E3293C-5C49-4A80-957B-E490E6A9B32E@redhat.com>
         <5B5CF80C-494A-42D3-8D3F-51C0277D9E1B@redhat.com>
         <8ED5511E-25DE-4C06-9E26-A1947383C86A@oracle.com>
         <20201007140502.GC23452@fieldses.org>
         <85F496CD-9AAC-451C-A224-FCD138BDC591@oracle.com>
         <20201007160556.GE23452@fieldses.org>
         <6d9aee613e9fb25509c9317910189ee37a2e4b43.camel@hammerspace.com>
         <7755CA77-7ABB-438A-A6E1-C3A73A54B7B3@redhat.com>
In-Reply-To: <7755CA77-7ABB-438A-A6E1-C3A73A54B7B3@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1401f6c0-721c-4c27-0105-08d86aed8a3f
x-ms-traffictypediagnostic: MN2PR13MB4174:
x-microsoft-antispam-prvs: <MN2PR13MB417481D99D4CB6E32B7EE8F3B80A0@MN2PR13MB4174.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WgSz5X/6RvT0thInwCvYfKNPAVhBNm/C4C3FNo5+hWNz6v58E6hHVb3ETCbScr9ygEekJF6J5qV4gYMfImACzmgxtDdLXuGMMRS+t0OlLHcuvd4nI132zdQee1zxuV1aIuqW48eqs4YP/0kLRbovffIut6Ebp/PluzwIkg1vXuTWBHvYORrzJeK2X8My1YwRzqTutGM2QSmdf5Ohv/AlUXvtYX/shhrhXcL3ONp66ls+I0sSLYH/4tVZNOi1jzFl2TcNAD1S+uMOO+ev3fPAGbVTdcyjBZhVnhRaYPsaxujGGDALgKv4pBBoHYrNleKmSHY/q+yYwPIdkre7NDrLuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(39830400003)(136003)(54906003)(83380400001)(8676002)(6916009)(2616005)(36756003)(53546011)(478600001)(6512007)(6486002)(26005)(2906002)(71200400001)(8936002)(316002)(5660300002)(4326008)(66946007)(86362001)(66556008)(76116006)(64756008)(66476007)(91956017)(6506007)(66446008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 22zhLDF5wBnvhraxX8Fp43OIFG5d2p4msIrBhbgZ1CxCn828kbfBkMclvHFr6lshobrNiC0HB3AkzFg028V4iLU/YFwIHdmiPclh+BhBQ1Acz9kNAGWEBZ/Zpdomd0KRTcQigaAglRQKJWrJf5c/a4xog5h1C3AaVmoqhxiYkC8X/0J6iCZEEzAnwkwzW8PTOL4gxQGvr4oKjYTvbeRq80rU/eighoZZqWOPhN6LEpXbY1uPaamEI152NOhV7m4GHzaVFrdieD4KeiSulK/ctbWxyIcNvzUAHjMllGLOkh8HsXvwVUnn4Kor4lmUj1P8cKPzi/iTY3/jzHN0WT0cY16Az0IgsztdKXv0qX5eekra5u3eE/dzEjk2oAv0p/W1JQtUOe6/SjOZyv5pIZK1jwzZKx+obL7ng1zqct2AXvcb2QoDOI18GHkQewZIsnsx/cpBbraW60bH8ngLBjzv+O4ifxtgag+rUcdev3gT/RJevfJYw3XcMAn6h5XXWs3919rHR3cDTgpa+L78th4pOooXGb7RqllNgMrwILcyAZV8e8ayP3UtmAw0Vzm78JLaxrDtiGXgSPM82VUqrqX0xzor99vXd+x2ue37O2yAsJXo1+W3RY//RctQSgcQdoxKiIy9T81r9Kiz0D9WFERfpw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E18F00A7978A847828DBAFE9B0D110C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1401f6c0-721c-4c27-0105-08d86aed8a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 18:19:33.1137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6nIk7Ovhzfj/w+zhGjU6pOqQgJCTikQJeHRzidanGt0NrWcOxW0dHd+hkODQ9aqSxNRIYAgGpeXrhx4kU7/zHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4174
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTEwLTA3IGF0IDE0OjA0IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA3IE9jdCAyMDIwLCBhdCAxMjo0NCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0K
PiA+IEkgZGlkIHNlZSBJZ29yJ3MgY2xhaW0gdGhhdCB0aGVyZSBpcyBhIFFvUyBpc3N1ZSAod2hp
Y2ggYWZhaWNzDQo+ID4gd291bGQNCj4gPiBhbHNvIGFmZmVjdCBORlN2MyksIGJ1dCB3aHkgZG8g
SSBjYXJlIGFib3V0IFFvUyBhcyBhIHBlci1tb3VudHBvaW50DQo+ID4gZmVhdHVyZT8NCj4gDQo+
IEJlY2F1c2UgaXQncyBoYXJkIHRvIGRvIFFvUyB3aXRob3V0IGJlaW5nIGFibGUgdG8gY2xhc3Np
ZnkgdGhlDQo+IHRyYWZmaWMgb24NCj4gdGhlIG5ldHdvcmsgc29tZWhvdy4gIFRoZSBzZXBhcmF0
ZSBjb25uZWN0aW9uIG1ha2VzIGl0IGEgbG90DQo+IGVhc2llci4gIEkgc2VlDQo+IGhvdyB0aGF0
J3MgLSBub3Qgb3VyIHByb2JsZW0gLSwgdGhvdWdoLg0KPiANCj4gVGhlIHJlZ3VsYXIgYWRtaW4g
bWlnaHQgZmluZCBpdCBzdXJwcmlzaW5nIHRvIHRlbGwgdGhlaXIgc3lzdGVtIHRvDQo+IGNvbm5l
Y3QgdG8gYSBzcGVjaWZpYyBJUCBhZGRyZXNzIGF0IG1vdW50IHRpbWUsIGFuZCBpdCBpbnN0ZWFk
IHNlbmRzDQo+IHRoZQ0KPiBtb3VudCdzIHRyYWZmaWMgZWxzZXdoZXJlLg0KPg0KPiBBcmUgeW91
IGhhcHB5IHdpdGggdGhlIHN0YXRlIG9mIG5jb25uZWN0LCBvciBpcyB0aGVyZSByb29tIGZvcg0K
PiBzb21ldGhpbmcNCj4gbW9yZSBkeW5hbWljPw0KPiANCg0KSSB0aGluayB0aGVyZSBpcyByb29t
IGZvciBpbXByb3ZlbWVudC4gV2UgZGlkIHNheSB0aGF0IHdlIHdhbnRlZCB0bw0KZXZlbnR1YWxs
eSBoYW5kIGNvbnRyb2wgb3ZlciB0byBhIHVzZXJzcGFjZSBwb2xpY3kgZGFlbW9uIHdoaWNoIHNo
b3VsZA0KYmUgYWJsZSB0byBtYW5hZ2UgdGhlIG51bWJlciBvZiBjb25uZWN0aW9ucyBiYXNlZCBv
biBkZW1hbmQgYW5kDQpuZXR3b3JraW5nIGNvbmRpdGlvbnMuDQpIb3dldmVyIGFzIEkgYWxyZWFk
eSBwb2ludGVkIG91dCwgTkZTdjQuMSBhbHNvIGhhcyBjb25nZXN0aW9uIGNvbnRyb2wNCmF0IHRo
ZSBzZXNzaW9uIGxldmVsIHdoaWNoIG1heSBiZSBwbGF5aW5nIGEgcm9sZSBoZXJlLg0KDQotLSAN
ClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFj
ZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
