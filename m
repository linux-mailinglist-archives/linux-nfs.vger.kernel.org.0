Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6663B9C8
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2019 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfFJQn7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jun 2019 12:43:59 -0400
Received: from mail-eopbgr730129.outbound.protection.outlook.com ([40.107.73.129]:10056
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726781AbfFJQn7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 Jun 2019 12:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO3873XzD3w/gO4hGlUK3g3bLK88GCViIKyr/QZUnVQ=;
 b=fRcVA3c6umdqfM2jyuYb72V2erFH0QoVV1YBpACqyk+Wo+lh3sqn6oyw4n6oiZyvDxoXja8Z/2fjISbA3C2G+YFBKA2CtWu5YQydUrF1hv/1Tw5aYO8WjDPdlgWbkf9RGI6OUnZ3UEfztSSAOB7e3exYfcmTDAzs662SgYjHP5s=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1659.namprd13.prod.outlook.com (10.171.155.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.7; Mon, 10 Jun 2019 16:43:53 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1987.010; Mon, 10 Jun 2019
 16:43:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: client skips revalidation if holding a delegation
Thread-Topic: client skips revalidation if holding a delegation
Thread-Index: AQHVGtLKBUNk28aCck+RoJHGu9wZpaaLdE6AgAAUoACAAAwCgIAARNaAgAkeSgCAACmogA==
Date:   Mon, 10 Jun 2019 16:43:53 +0000
Message-ID: <2cc7cbfda42601d2e52ee63bed2dbb4140401adc.camel@hammerspace.com>
References: <6C2EF3B8-568A-41F0-B134-52996457DD7D@redhat.com>
         <c133a2ed862bf5714210aa5a44190ddaecfa188f.camel@hammerspace.com>
         <CFD3CE5E-5081-4A4D-B67E-41D9E7A3D5C5@redhat.com>
         <a595b6962b2e083fef8ad2d3534e1d0964995560.camel@hammerspace.com>
         <7289561F-686E-4425-B0CE-F3E5800C033D@redhat.com>
         <243407AC-A416-4FF2-A09B-B1362C6206D9@redhat.com>
In-Reply-To: <243407AC-A416-4FF2-A09B-B1362C6206D9@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 422f964c-02fc-4a5f-963c-08d6edc2d292
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1659;
x-ms-traffictypediagnostic: DM5PR13MB1659:
x-microsoft-antispam-prvs: <DM5PR13MB1659C05E8BB9522062AA1790B8130@DM5PR13MB1659.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(346002)(396003)(366004)(39830400003)(189003)(199004)(316002)(2616005)(486006)(6486002)(476003)(102836004)(6506007)(5660300002)(86362001)(53546011)(11346002)(4744005)(6246003)(118296001)(229853002)(2906002)(71190400001)(71200400001)(68736007)(5640700003)(14444005)(14454004)(256004)(6512007)(54906003)(76176011)(6436002)(446003)(66446008)(8936002)(53936002)(186003)(66066001)(26005)(8676002)(478600001)(6916009)(2351001)(7736002)(25786009)(305945005)(2501003)(99286004)(36756003)(4326008)(76116006)(81156014)(66476007)(66556008)(64756008)(73956011)(66946007)(6116002)(3846002)(81166006)(1730700003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1659;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mNgc/5AtPJ9M32/yL1DuzO9gtTuS7sBKKYdH6hrNKAIvueveUZxdDkT34tIhHGzhVZQr55jZG8SUucIPXTLoE+YdLxbliS89OXYWoYMxgniiPQd6Mz6u4B6f4FaZw9IwzxB/fSiWlYjdneovB2gWMa5l5lBQUmt66Fhom4JJItfNS3MfeBgjAXFC5nRHZ0WfpM++lB7LYCy2Z6oWTmKWSQT/LwXAP4VRvi9ve9BwwNxvGvSblAcqW62HPLxQTNTl/VUIG/tllgIFqDHDoY+8lY/ysLipgizdwc6LFufLVuDKP8cdQT026R3zgCwU00P4LVcOPcciZQceiu/Z4ZIL7EbwLAw+G7V6hJsE1e2pCsFfjxcn99/5fnpHhxGaQVJ04ocyeisIECzc8/BOQPIE3qZGIxbOIxFjNuqytlhEfX8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2298EE08B17D74CB5CD90E1A0F96F38@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422f964c-02fc-4a5f-963c-08d6edc2d292
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 16:43:53.0303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1659
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTEwIGF0IDEwOjE0IC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBPbiA0IEp1biAyMDE5LCBhdCAxNTowMCwgQmVuamFtaW4gQ29kZGluZ3RvbiB3cm90
ZToNCj4gDQo+ID4gQXQgbGVhc3Qgbm93IEkgY2FuIHNwZW5kIHNvbWUgdGltZSBvbiBpdCBhbmQg
bm90IGZlZWwgYWltbGVzcywNCj4gPiB0aGFua3MgZm9yDQo+ID4gdGhlIGNsb3NlciBsb29rLg0K
PiANCj4gSSBhbSBub3QgZmluZGluZyBhIHJlbGlhYmxlIHdheSB0byBmaXggdGhpcyBhbmQgcmV0
YWluIHRoZQ0KPiBvcHRpbWl6YXRpb24uICBJDQo+IHdpbGwgc2VuZCBhIHBhdGNoIHRvIHJlbW92
ZSBpdC4NCg0KDQpIb3cgYWJvdXQganVzdCBtb3ZpbmcgdGhlIG9wdGltaXNhdGlvbiBpbnRvIHRo
ZSBpZg0KKG5mc19jaGVja192ZXJpZmllcigpKSB7IH0gY2FzZT8gVGhlcmUgc2hvdWxkIGJlIG5v
IG5lZWQgdG8gZG8gdGhlDQpuZnNfbG9va3VwX3ZlcmlmeV9pbm9kZSgpIGRhbmNlIGlmIHdlIGhv
bGQgYSBkZWxlZ2F0aW9uLiBzaG91bGQgdGhlcmU/DQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
