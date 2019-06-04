Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF6E34763
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2019 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfFDM46 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jun 2019 08:56:58 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:7040
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfFDM46 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Jun 2019 08:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R59XlH5+KJFUo018OeLXOmRFeCtxAVB4I4dSTzxY2Gw=;
 b=TxN37nZdOfzP4aiYtFkYWO5TTszXgDFWno2OR4JNdxf2VWVgCx8tCP/a5WqMOFkRnJIakv0LztzqFTA5xt0UgAkwcBagJYL9xGgG8vZ/5wA1M1XYl4Qa+C/AJArMFpybFo3Nmx1sxbUExClfSEQLClRMIIq4oAyC34Ug7Ufo1zM=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1529.namprd13.prod.outlook.com (10.175.110.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Tue, 4 Jun 2019 12:56:54 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1965.007; Tue, 4 Jun 2019
 12:56:54 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bcodding@redhat.com" <bcodding@redhat.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: client skips revalidation if holding a delegation
Thread-Topic: client skips revalidation if holding a delegation
Thread-Index: AQHVGtLKBUNk28aCck+RoJHGu9wZpaaLdE6A
Date:   Tue, 4 Jun 2019 12:56:54 +0000
Message-ID: <c133a2ed862bf5714210aa5a44190ddaecfa188f.camel@hammerspace.com>
References: <6C2EF3B8-568A-41F0-B134-52996457DD7D@redhat.com>
In-Reply-To: <6C2EF3B8-568A-41F0-B134-52996457DD7D@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.175.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89ed2e34-fbc0-483f-75b6-08d6e8ec1ecc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1529;
x-ms-traffictypediagnostic: DM5PR13MB1529:
x-microsoft-antispam-prvs: <DM5PR13MB1529DAC798115968F7AD5697B8150@DM5PR13MB1529.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0058ABBBC7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39830400003)(376002)(396003)(136003)(478694002)(189003)(199004)(229853002)(3846002)(6246003)(99286004)(6512007)(68736007)(6116002)(6436002)(6486002)(53936002)(316002)(110136005)(8676002)(446003)(486006)(2616005)(81156014)(476003)(81166006)(11346002)(36756003)(118296001)(8936002)(6506007)(66446008)(102836004)(73956011)(305945005)(64756008)(66556008)(66476007)(76176011)(66946007)(66066001)(7736002)(26005)(76116006)(186003)(2501003)(2906002)(5660300002)(86362001)(4326008)(256004)(478600001)(71190400001)(71200400001)(14444005)(25786009)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1529;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dX70u1T8MM/RrT1ePPThW+tve3MgVcDbwRZlaf6IdkfRUyFOkTEhr9YpKuUYPtTiWJqSTTX6mbBYe40R8y2iVpGs06Fvw6ZdApEEfvt1/R1LF5YHBVMfl1FjwK6XLGi6RHPhpWiDD1rNdEIejZNmlMZv8A2bIIVEH4+C4uBMHEymf4YK7BDNJbONyc+wt6IF85lLROLKSpqv+OHGZSVeAnQUSVKqDFMrlhLBajzKNRdeFAAa6kDOgtF804uHdbOyGbdS7nkvxe4MLC2WlB7iV5FXroGOG8/Xg4u3lGuRRA7NxyMLJILhtB0eMe8lknJbkoHBmSBfXpK/BXUyQA/zJo4Pc0aiUwCeJ9DXx/3sIWamdWnqyA5W1YJH2vap7BraD5FsIX0bcMo3m3xWn8WYq8rufc1AhNNcm5jgA27AYaU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0E5AE6B17601246AD376811D88C40A9@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ed2e34-fbc0-483f-75b6-08d6e8ec1ecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2019 12:56:54.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1529
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA2LTA0IGF0IDA4OjQxIC0wNDAwLCBCZW5qYW1pbiBDb2RkaW5ndG9uIHdy
b3RlOg0KPiBIZXkgbGludXgtbmZzLCBhbmQgZXNwZWNpYWxseSBtYWludGFpbmVycywNCj4gDQo+
IEknbSBzdGlsbCBpbnRlcmVzdGVkIGluIHdvcmtpbmcgb24gYSBwcm9ibGVtIHJhaXNlZCBhIGNv
dXBsZSB3ZWVrcw0KPiBhZ28sIGJ1dA0KPiBjb25mdXNpb24gbXVkZGxlZCB0aGF0IGRpc2N1c3Np
b24gYW5kIGl0IGRpZWQ6DQo+IA0KPiBJZiB0aGUgY2xpZW50IGhvbGRzIGEgcmVhZCBkZWxlZ2F0
aW9uLCBpdCB3aWxsIHNraXAgcmV2YWxpZGF0aW9uIG9mIGENCj4gZGVudHJ5DQo+IGluIGxvb2t1
cC4gIElmIHRoZSBmaWxlIHdhcyBtb3ZlZCBvbiB0aGUgc2VydmVyLCB0aGUgY2xpZW50IGNhbiBl
bmQNCj4gdXAgd2l0aA0KPiB0d28gcG9zaXRpdmUgZGVudHJpZXMgaW4gY2FjaGUgZm9yIHRoZSBz
YW1lIGlub2RlLCBhbmQgdGhlIGRlbnRyeQ0KPiB0aGF0DQo+IGRvZXNuJ3QgZXhpc3Qgb24gdGhl
IHNlcnZlciB3aWxsIG5ldmVyIHRpbWUgb3V0IG9mIHRoZSBjYWNoZS4NCj4gDQo+IFRoZSBjbGll
bnQgY2FuIGRldGVjdCB0aGlzIGhhcHBlbmluZyBiZWNhdXNlIHRoZSBkaXJlY3Rvcnkgb2YgdGhl
DQo+IGRlbnRyeQ0KPiB0aGF0IHNob3VsZCBiZSByZXZhbGlkYXRlZCB1cGRhdGVzIGl0J3MgY2hh
bmdlIGF0dHJpYnV0ZS4gIFNraXBwaW5nDQo+IHJldmFsaWRhdGlvbiBpcyBhbiBvcHRpbWl6YXRp
b24gaW4gdGhlIGNhc2Ugd2UgaG9sZCBhIGRlbGVnYXRpb24sIGJ1dA0KPiB0aGlzDQo+IG9wdGlt
aXphdGlvbiBzaG91bGQgb25seSBiZSB1c2VkIHdoZW4gdGhlIGRlbGVnYXRpb24gd2FzIG9idGFp
bmVkIHZpYQ0KPiBhDQo+IGxvb2t1cCBvZiB0aGUgZGVudHJ5IHdlIGFyZSBjdXJyZW50bHkgcmV2
YWxpZGF0aW5nLg0KPg0KPiBLZWVwaW5nIHRoZSBvcHRpbWl6YXRpb24gbWlnaHQgYmUgZG9uZSBi
eSB0eWluZyB0aGUgZGVsZWdhdGlvbiB0byB0aGUNCj4gZGVudHJ5LiAgTGFja2luZyBzb21lIChl
YXN5Pykgd2F5IHRvIGRvIHRoYXQgY3VycmVudGx5LCBpdCBzZWVtcw0KPiBzaW1wbGVyIHRvDQo+
IHJlbW92ZSB0aGUgb3B0aW1pemF0aW9uIGFsdG9nZXRoZXIsIGFuZCBJIHdpbGwgc2VuZCBhIHBh
dGNoIHRvIHJlbW92ZQ0KPiBpdC4NCg0KQSBkZWxlZ2F0aW9uIG5vcm1hbGx5IGFwcGxpZXMgdG8g
dGhlIGVudGlyZSBpbm9kZS4gSXQgY292ZXJzIF9hbGxfDQpkZW50cmllcyB0aGF0IHBvaW50IHRv
IHRoYXQgaW5vZGUgdG9vIGJlY2F1c2UgY3JlYXRlLCByZW5hbWUgYW5kIHVubGluaw0KYXJlIGFs
d2F5cyBhdG9taWNhbGx5IGFjY29tcGFuaWVkIGJ5IGFuIGlub2RlIGNoYW5nZSBhdHRyaWJ1dGUu
DQoNCklPVzogVGhlIHByb3Bvc2VkIHJlc3RyaWN0aW9uIGlzIGJvdGggdW5uZWNlc3NhcnkgYW5k
IGluY29ycmVjdC4NCg0KPiBBbnkgdGhvdWdodHMgb24gdGhpcz8gIEFueSByZXNwb25zZSwgZXZl
biBhc3NlcnRpbmcgdGhhdCB0aGlzIGlzIG5vdA0KPiBzb21ldGhpbmcNCj4gd2Ugd2lsbCBmaXgg
YXJlIHdlbGNvbWUuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K
