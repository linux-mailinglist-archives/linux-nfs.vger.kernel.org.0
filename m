Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F71BA0670
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2019 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1Phw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Aug 2019 11:37:52 -0400
Received: from mail-eopbgr730138.outbound.protection.outlook.com ([40.107.73.138]:2954
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbfH1Pht (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 28 Aug 2019 11:37:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7G8l+RHkSI/XF5IomQXbaZcCXHrDWSlQwWjlZY5/HfjTEBlu/U+lohXQ/JayQsSk/GtxCy8GooItyguoyLhC6+M+AKRvL1hGrw/w3qrHl6mtd+Bd21FDhR0iMSzQvlMAplyXOUsDhFUcPhgtY8ca+XI9Cx4N5j2Fu5bnsBkNR9BB/vNG8anp/PlGJNGwt8P/5ixxOAwbesfLrL2oUG+C43BxihsTl+mRUr6yNc6Ipwv/dn+9GgXQx83QTtMFuaqedhCPo1P85+4viSziL+0AZpWbbWJtJni+DFQlrKQcJEp3GSP0+P4D4cK36vH/hwsigyjTTxfGGNj3++QyLlPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI4tr4J+Wck63sFnT62ijuLmDuHurZHXMtpTniCs2Ps=;
 b=Ewyp6ACSeerZU8QSvuB5JLu8h8sBgVbUUv9YD+Bt36o/Kah8F4UwOc3XhskRUV0Y39iEfvIjN1bdluWH/pswWuUq7RtsfGdJEN8tUn+oj2gXw5SiFQE0ElGNMl9b83JSuAvq0rrmIFcJUY8fjCv2hpsuUXM8Qb8m7R87gC2dL7yLhBkGVPhS8J+318tAbGHZDAxBSlv5mLY1htIIIbf8EU+pOKUbi8rfrO3mo1mknHjgT87cU+YW3X1N/XPrfayIhhsXI1F3EYuluLr8Uc/dkjJo1lp6PTtRAyUM+wT+x883Da0eeEd2lxQPZzZKdG5yleQQtBM2daebHq4CdfPeMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI4tr4J+Wck63sFnT62ijuLmDuHurZHXMtpTniCs2Ps=;
 b=CM4N/JmjyAFCH1YrvjvAPxdhAbbZiLVD4/mt8s8dW+TpG5qBqasMl5NOx8psCUXj4UmxhDBR8rq5LRE6RS7j9frtYnZ7HLMJU88i34IW5NEKIKsNelglbR+9mqLn363sn95NpRYUbIPCPQSeWfQu1gnlXadQkyBCCydJhJU2J2M=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1627.namprd13.prod.outlook.com (10.175.110.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.15; Wed, 28 Aug 2019 15:37:45 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Wed, 28 Aug 2019
 15:37:45 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jlayton@redhat.com" <jlayton@redhat.com>,
        "rmacklem@uoguelph.ca" <rmacklem@uoguelph.ca>,
        "bfields@redhat.com" <bfields@redhat.com>
CC:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Topic: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
Thread-Index: AQHVXC7WXUD5cV8FEUS4EYbsSk6I0qcN59MAgAAC84CAARwhgIAADvgAgAABfYCAAAA/AIAABJIAgAF6DICAAADKAIAAAamAgAAA7gCAAACjgIAAA6uAgAAGz4CAAAjrAIAABxCA
Date:   Wed, 28 Aug 2019 15:37:45 +0000
Message-ID: <82a88db7eb00fe606c82ac2af78d4fcd22a2b8d3.camel@hammerspace.com>
References: <ec7a06f8e74867e65c26580e8504e2879f4cd595.camel@hammerspace.com>
         <20190827145819.GB9804@fieldses.org> <20190827145912.GC9804@fieldses.org>
         <1ee75165d548b336f5724b6d655aa2545b9270c3.camel@hammerspace.com>
         <20190828134839.GA26492@fieldses.org>
         <ed2a86da204cbf644ef2dada4bda2b899da48764.camel@redhat.com>
         <45582F32-69C7-4DC8-A608-E45038A44D42@oracle.com>
         <20190828140044.GA14249@parsley.fieldses.org>
         <990B7B57-53B8-4ECB-A08B-1AFD2FCE13A6@oracle.com>
         <31658faabfbe3b4c2925bd899e264adf501fbc75.camel@redhat.com>
        ,<20190828144031.GB14249@parsley.fieldses.org>
         <YT1PR01MB29075543EF1DD94AE0101631DDA30@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <YT1PR01MB29075543EF1DD94AE0101631DDA30@YT1PR01MB2907.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74867c16-1305-4f5c-3f63-08d72bcdac4b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1627;
x-ms-traffictypediagnostic: DM5PR13MB1627:
x-microsoft-antispam-prvs: <DM5PR13MB162777F3AB8DCCBABA2E6094B8A30@DM5PR13MB1627.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(36756003)(54906003)(118296001)(316002)(110136005)(2501003)(66476007)(66556008)(64756008)(66446008)(66946007)(99286004)(186003)(26005)(76116006)(91956017)(102836004)(6506007)(76176011)(2906002)(11346002)(446003)(2616005)(486006)(476003)(6486002)(305945005)(7736002)(8936002)(6436002)(8676002)(81156014)(81166006)(4326008)(6512007)(25786009)(229853002)(53936002)(5660300002)(66066001)(71200400001)(71190400001)(6116002)(2201001)(478600001)(256004)(6246003)(14454004)(86362001)(3846002)(17423001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1627;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WZAFpQkxzHZsXhQyb3q4EcyHi/1dCNoEsMzXmbE/vhb7x7sJdLd4Ch3Iyz3DHbClDQDOpZ1WWF3x833Yko/lwPVqEdzheLT36QZD+DS4IhTR0aE1HjAL0vz9DBKkMdqcb98XTQbCqmSJBWg4wAlKGbQPtbSa6oa1MQJADmEzLw26KDhcQKIUgHpuAXuwT31Ue61djmoumABI5n0+mNORo9ROQCz45ogx1F0zUXvDBxiEJzFBLy7VDXeEHVfJym0VHs5sffbKQ+1Jr0kkh72BEqSEJq0KT2ze3B7Qr49vTsC2ZCNSYeKUc5o/7frxP03ZAK1aEielcY/mYurHjj/iXf00cBqXzKZ01uonlUWmhyUWwYInu9IfIRopxRU5pJwkPtsLkUi8VxWkEBlBKqNs8SdjQ7DUbF/8ZBXtCNaTOVk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <85BA3330B2A2B144916F139A603BE258@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74867c16-1305-4f5c-3f63-08d72bcdac4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 15:37:45.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ByM4mxuF+k0kRCZc8CFQp7mgtoj/lCKp8hgAO0dm3WdK+DhFP1WoUoCDY85ZLD2OWVNIDYQk+7GVBbbhhTHZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1627
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTI4IGF0IDE1OjEyICswMDAwLCBSaWNrIE1hY2tsZW0gd3JvdGU6DQo+
IEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4gPiBPbiBXZWQsIEF1ZyAyOCwgMjAxOSBhdCAxMDox
NjowOUFNIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4gPiA+IEZvciB0aGUgbW9zdCBwYXJ0
LCB0aGVzZSBzb3J0cyBvZiBlcnJvcnMgdGVuZCB0byBiZSByYXJlLiBJZiBpdA0KPiA+ID4gdHVy
bnMNCj4gPiA+IG91dCB0byBiZSBhIHByb2JsZW0gd2UgY291bGQgY29uc2lkZXIgbW92aW5nIHRo
ZSB2ZXJpZmllciBpbnRvDQo+ID4gPiBzdmNfZXhwb3J0IG9yIHNvbWV0aGluZz8NCj4gPiANCj4g
PiBBcyBUcm9uZCBzYXlzLCB0aGlzIGlzbid0IHJlYWxseSBhIHNlcnZlciBpbXBsZW1lbnRhdGlv
biBpc3N1ZSwNCj4gPiBpdCdzIGENCj4gPiBwcm90b2NvbCBpc3N1ZS4gIElmIGEgY2xpZW50IGRl
dGVjdHMgd2hlbiB0byByZXNlbmQgd3JpdGVzIGJ5DQo+ID4gc3RvcmluZyBhDQo+ID4gc2luZ2xl
IHZlcmlmaWVyIHBlciBzZXJ2ZXIsIHRoZW4gcmV0dXJuaW5nIGRpZmZlcmVudCB2ZXJpZmllcnMg
ZnJvbQ0KPiA+IHdyaXRlcyB0byBkaWZmZXJlbnQgZXhwb3J0cyB3aWxsIGhhdmUgaXQgcmVzZW5k
aW5nIGV2ZXJ5IHRpbWUgaXQNCj4gPiB3cml0ZXMNCj4gPiB0byBvbmUgZXhwb3J0IHRoZW4gYW5v
dGhlci4NCj4gDQo+IFdlbGwsIGhlcmUncyB3aGF0IFJGQy0xODEzIHNheXMgYWJvdXQgdGhlIHdy
aXRlIHZlcmlmaWVyOg0KPiAgICAgICAgICBUaGlzIGNvb2tpZSBtdXN0IGJlIGNvbnNpc3RlbnQg
ZHVyaW5nIGEgc2luZ2xlIGluc3RhbmNlDQo+ICAgICAgICAgIG9mIHRoZSBORlMgdmVyc2lvbiAz
IHByb3RvY29sIHNlcnZpY2UgYW5kIG11c3QgYmUNCj4gICAgICAgICAgdW5pcXVlIGJldHdlZW4g
aW5zdGFuY2VzIG9mIHRoZSBORlMgdmVyc2lvbiAzIHByb3RvY29sDQo+ICAgICAgICAgIHNlcnZl
ciwgd2hlcmUgdW5jb21taXR0ZWQgZGF0YSBtYXkgYmUgbG9zdC4NCj4gWW91IGNvdWxkIGRlYmF0
ZSB3aGF0ICJzZXJ2aWNlIiBtZWFucyBpbiB0aGUgYWJvdmUsIGJ1dCBJJ2Qgc2F5IGl0DQo+IGlz
bid0ICJwZXIgZmlsZSIuDQo+IA0KPiBIb3dldmVyLCBzaW5jZSB0aGVyZSBpcyBubyB3YXkgZm9y
IGFuIE5GU3YzIGNsaWVudCB0byBrbm93IHdoYXQgYQ0KPiAic2VydmVyIiBpcywNCj4gdGhlIEZy
ZWVCU0QgY2xpZW50IChhbmQgbWF5YmUgdGhlIG90aGVyICpCU0QsIGFsdGhvdWdoIEkgaGF2ZW4n
dCBiZWVuDQo+IGludm9sdmVkDQo+IGluIHRoZW0gZm9yIGEgbG9uZyB0aW1lKSBzdG9yZXMgdGhl
IHdyaXRlIHZlcmlmaWVyICJwZXIgbW91bnQiLg0KPiAtLT4gU28sIGZvciB0aGUgRnJlZUJTRCBj
bGllbnQsIGl0IGlzIGF0IHRoZSBncmFudWxhcml0eSBvZiB3aGF0IHRoZQ0KPiBORlN2MyBjbGll
bnQgc2VlcyBhcw0KPiAgICAgIGEgc2luZ2xlIGZpbGUgc3lzdGVtLiAoVHlwaWNhbGx5IGEgc2lu
Z2xlIGZpbGUgc3lzdGVtIG9uIHRoZQ0KPiBzZXJ2ZXIgdW5sZXNzIHRoZSBrbmZzZA0KPiAgICAg
IHBsYXlzIHRoZSBnYW1lIG9mIGNvYWxlc2NpbmcgbXVsdGlwbGUgZmlsZSBzeXN0ZW1zIGJ5DQo+
IHVuaXF1aWZ5aW5nIHRoZSBJLW5vZGUjLCBldGMuKQ0KPiANCj4gSXQgaXMgY29uY2VpdmFibGUg
dGhhdCBzb21lIG90aGVyIE5GU3YzIGNsaWVudCBtaWdodCBhc3N1bWUNCj4gInNhbWUgc2VydmVy
IElQIGFkZHJlc3MgLS0+IHNhbWUgc2VydmVyIiBhbmQgc3RvcmUgaXQgInBlciBzZXJ2ZXINCj4g
SVAiLCBidXQgSSBoYXZlDQo+IG5vIGlkZWEgaWYgYW55IHN1Y2ggY2xpZW50IGV4aXN0cy4NCj4g
DQoNClRoZSBwYXRjaHNldHMgd2UndmUgYmVlbiBkaXNjdXNzaW5nIHNob3VsZCBhbGwgYmUgY29t
cGF0aWJsZSB3aXRoDQpGcmVlQlNELCBhcyB0aGV5IGltcGxlbWVudCBhIHBlci1zZXJ2ZXIgYm9v
dCB2ZXJpZmllciAoYXMgaW4gZGlmZmVyZW50DQpjb250YWluZXJzIHJlcHJlc2VudGluZyBkaWZm
ZXJlbnQga25mc2Qgc2VydmVycyBvbiBkaWZmZXJlbnQgbmV0d29ya3MNCmFyZSBhbGxvd2VkIHRv
IGhhdmUgZGlmZmVyZW50IGJvb3QgdmVyaWZpZXJzLCBidXQgZWFjaCBzZXJ2ZXIgYXBwbGllcw0K
dGhlaXIgYm9vdCB2ZXJpZmllciBnbG9iYWxseSB0byBhbGwgZXhwb3J0ZWQgZmlsZXN5c3RlbXMp
Lg0KDQpXZSBjb3VsZCBtYWtlIHRoZXNlIGJvb3QgdmVyaWZpZXJzIGJlIHBlciBmaWxlc3lzdGVt
IHRvIHJlZHVjZSB0aGUNCmZyZXF1ZW5jeSBvZiB0aGVzZSAnc2VydmVyIHJlYm9vdHMnIGJ1dCB0
aGUgZXhwZWN0YXRpb24gaXMgdGhhdA0KZmlsZXN5c3RlbSBlcnJvcnMgb24gQ09NTUlUIGFyZSBy
YXJlLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVy
LCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
