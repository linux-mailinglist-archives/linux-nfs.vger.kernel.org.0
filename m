Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C89B7137
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 03:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbfISBtz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Sep 2019 21:49:55 -0400
Received: from mail-eopbgr760138.outbound.protection.outlook.com ([40.107.76.138]:7941
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387470AbfISBty (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Sep 2019 21:49:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOgTbzsc1ASCJa4qi4NMiMusJg0WK0f61N7O8C8+rGqBesKPpsGSsHkevBYpJgEcWmIBnVNG8EXNmbhXeUWrgepNl/Pibzwk04/PxS2CwnLTjhXQMPhJ7LValXue2EKR9XGWvLrbFLG3lzmEsK+R2oBWfv99p8PuQWqU7VZKQ2Iqm1X/2vZho4pMaFFQjWWei939CZjuphwNrpvtPqPA5388va4bHbD3IDJqbeIrUZH9Tqg8SdWvKcFo4fnQgUsPv2LE7dZYRaxg+QP+COujU8v3iNZQ+7GCSQqvAwpq/tgSPQrtwWCvEe6K1LXwSU8S2nw3juTnwDfd1YOPGadjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J+SV0VlCthRCKytgEUZP82S5qlF4EZwCOwSjA2nEVI=;
 b=lpwVAacJfHHUoQbJ2V5nGlnhAlZTPYdAGCF2lfVcaaarm5Gauj2XpWlNp6JrFA3LodxlDwJSjB6LUTQI2Luhl1xeC+KR+8h5FcPnr3SnfaGjoUj31QiMo5MDwLbdaUvo5nbk9HLyg3iOrPFf1zr+lm1h8W7BTlMFvsvw7JbGWgudYb5iV7S0mgSPX5DhCsU4JYGzQXMcsOusz1Gywfpp7bxWCWc7ri+mYD6isu4FkZn5i22s6xiAXwWfU/xl37scFlFjndC+JSsir3x/Y1VXk/PrfNfEGyNjRJM1dfPFzeKu5gKf3SkUR1yi89cHR5NlgUEKhDRr3gDn4YgMIAZwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J+SV0VlCthRCKytgEUZP82S5qlF4EZwCOwSjA2nEVI=;
 b=KgfGM8o3i77QCj4nLvz+L+vYoOUsFi4HfaD3fahrLzmPhFAI8b3+w5UvBM0COC3DVOnsSdMmzInevXZZxqvlW3ABGauzqOLUxu06kMf9HepAIFzONhBr3w6OuQO2oVBYLMb5dm91FT/s/c5dUDNPyhiHItnxyUZPq+qxlRgYoEM=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB0939.namprd13.prod.outlook.com (10.168.239.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.17; Thu, 19 Sep 2019 01:49:09 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 01:49:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "aglo@umich.edu" <aglo@umich.edu>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v2 0/9] Various NFSv4 state error handling fixes
Thread-Topic: [PATCH v2 0/9] Various NFSv4 state error handling fixes
Thread-Index: AQHVbM/S/fixzh0y6ESu1Qgv6VvgnKcx18EAgABneQA=
Date:   Thu, 19 Sep 2019 01:49:09 +0000
Message-ID: <4c620de7a944ff38644eceb4fed863f5092f1a15.camel@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
         <CAN-5tyF27z=+3tbU1De_wR0aosiczn67dNanBmBe4icj=uAYwQ@mail.gmail.com>
In-Reply-To: <CAN-5tyF27z=+3tbU1De_wR0aosiczn67dNanBmBe4icj=uAYwQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e50c4f9-f5fd-44f9-6708-08d73ca39075
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB0939;
x-ms-traffictypediagnostic: DM5PR13MB0939:
x-microsoft-antispam-prvs: <DM5PR13MB0939C58A78AC42A3C681EB36B8890@DM5PR13MB0939.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39830400003)(366004)(376002)(189003)(199004)(64756008)(66476007)(66946007)(66556008)(53546011)(66446008)(6512007)(229853002)(91956017)(76116006)(66066001)(86362001)(1730700003)(6436002)(6486002)(2351001)(5640700003)(76176011)(6246003)(2171002)(6916009)(305945005)(478600001)(36756003)(14454004)(81156014)(118296001)(99286004)(8936002)(4326008)(25786009)(26005)(7736002)(186003)(256004)(14444005)(476003)(71190400001)(102836004)(71200400001)(8676002)(2616005)(486006)(316002)(81166006)(3846002)(2501003)(6116002)(2906002)(6506007)(446003)(5660300002)(11346002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB0939;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ukut5zeQyGTcSv76/dAZs2r38bgo5328l8r8Ws9FU/YwComSFHwRy1Ki9rhUA9ZYi4Tt9Y0I0EjDC2HkdbO38XgQkP6G+UQTu+NQgaIaWQs6qDex+npj+Ez4eRp80KzUcu3FK28R00IshniLZ6b2agnDxAnD6XHQ4XjTkjlfvCoTok7e0j27r8/AWReksxpPxxramdJj7CAwoKsBRgeZCMzC9D0s3WIpev3tkg1iRDA/kiWOXt4fSH34jlEdx+nAWBN1/HAE7tCMFe4aG3hGBSLI0j1SosVXyl0rEwR+T62mBDvWbf2Zo9/JttQ6gmD6KQWTlmZgSshgl6Nwjg7489DX97QFKSQ1HgXswf1oz1j3HGdbe8xED653SEpmjlIA3FTaKhr+KF0Hw2lc6mVm9yd6kVUe/jWfi1j/qYKsjbk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFE08162BEF1F14FB8ADFA800606FF0D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e50c4f9-f5fd-44f9-6708-08d73ca39075
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 01:49:09.4554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYFil3Gl/hMIP+beBjiinXRgM9N4E0wehyPoFonobmVqNxXZfk4pui0aZqtieudGrFMdgge1WgHYNeyaqwKa0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0939
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYQ0KDQpPbiBXZWQsIDIwMTktMDktMTggYXQgMTU6MzggLTA0MDAsIE9sZ2EgS29ybmll
dnNrYWlhIHdyb3RlOg0KPiBIaSBUcm9uZCwNCj4gDQo+IFRoZXNlIHNldCBvZiBwYXRjaGVzIGRv
IG5vdCBhZGRyZXNzIHRoZSBsb2NraW5nIHByb2JsZW0uIEl0J3MNCj4gYWN0dWFsbHkNCj4gbm90
IHRoZSBsb2NraW5nIHBhdGNoICh3aGljaCBJIHRob3VnaHQgaXQgd2FzIGFzIEkgcmV2ZXJ0ZWQg
aXQgYW5kDQo+IHN0aWxsIGhhZCB0aGUgaXNzdWUpLiBXaXRob3V0IHRoZSB3aG9sZSBwYXRjaCBz
ZXJpZXMgdGhlIHVubG9jayB3b3Jrcw0KPiBmaW5lIHNvIHNvbWV0aGluZyBpbiB0aGVzZSBuZXcg
cGF0Y2hlcy4gU29tZXRoaW5nIGlzIHVwIHdpdGggdGhlIDINCj4gcGF0Y2hlczoNCj4gTkZTdjQ6
IEhhbmRsZSBORlM0RVJSX09MRF9TVEFURUlEIGluIENMT1NFL09QRU5fRE9XTkdSQURFDQo+IE5G
U3Y0OiBIYW5kbGUgTkZTNEVSUl9PTERfU1RBVEVJRCBpbiBMT0NLVQ0KPiANCj4gSWYgSSByZW1v
dmUgZWl0aGVyIG9uZSBzZXBhcmF0ZWx5LCB1bmxvY2sgZmFpbHMgYnV0IGlmIEkgcmVtb3ZlIGJv
dGgNCj4gdW5sb2NrIHdvcmtzLg0KDQoNCkNhbiB5b3UgZGVzY3JpYmUgaG93IHlvdSBhcmUgdGVz
dGluZyB0aGlzLCBhbmQgcGVyaGFwcyBwcm92aWRlDQp3aXJlc2hhcmsgdHJhY2VzIHRoYXQgc2hv
dyBob3cgd2UncmUgdHJpZ2dlcmluZyB0aGVzZSBwcm9ibGVtcz8NCg0KVGhhbmtzIQ0KICBUcm9u
ZA0KDQo+IE9uIE1vbiwgU2VwIDE2LCAyMDE5IGF0IDQ6NDYgUE0gVHJvbmQgTXlrbGVidXN0IDx0
cm9uZG15QGdtYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4gVmFyaW91cyBORlN2NCBmaXhlcyB0byBl
bnN1cmUgd2UgaGFuZGxlIHN0YXRlIGVycm9ycyBjb3JyZWN0bHkuIEluDQo+ID4gcGFydGljdWxh
ciwgd2UgbmVlZCB0byBlbnN1cmUgdGhhdCBmb3IgQ09NUE9VTkRzIGxpa2UgQ0xPU0UgYW5kDQo+
ID4gREVMRUdSRVRVUk4sIHRoYXQgbWF5IGhhdmUgYW4gZW1iZWRkZWQgTEFZT1VUUkVUVVJOLCB3
ZSBoYW5kbGUgdGhlDQo+ID4gbGF5b3V0IHN0YXRlIGVycm9ycyBzbyB0aGF0IGEgcmV0cnkgb2Yg
ZWl0aGVyIHRoZSBMQVlPVVRSRVRVUk4sIG9yDQo+ID4gdGhlIGxhdGVyIENMT1NFL0RFTEVHUkVU
VVJOIGRvZXMgbm90IGNvcnJ1cHQgdGhlIExBWU9VVFJFVFVSTg0KPiA+IHJlcGx5Lg0KPiA+IA0K
PiA+IEFsc28gZW5zdXJlIHRoYXQgaWYgd2UgZ2V0IGEgTkZTNEVSUl9PTERfU1RBVEVJRCwgdGhl
biB3ZSBkbyBvdXINCj4gPiBiZXN0IHRvIHN0aWxsIHRyeSB0byBkZXN0cm95IHRoZSBzdGF0ZSBv
biB0aGUgc2VydmVyLCBpbiBvcmRlciB0bw0KPiA+IGF2b2lkIGNhdXNpbmcgc3RhdGUgbGVha2Fn
ZS4NCj4gPiANCj4gPiB2MjogRml4IGJ1ZyByZXBvcnRzIGZyb20gT2xnYQ0KPiA+ICAtIFRyeSB0
byBhdm9pZCBzZW5kaW5nIG9sZCBzdGF0ZWlkcyBvbiBDTE9TRS9PUEVOX0RPV05HUkFERSB3aGVu
DQo+ID4gICAgZG9pbmcgZnVsbHkgc2VyaWFsaXNlZCBORlN2NC4wLg0KPiA+ICAtIEVuc3VyZSBM
T0NLVSBpbml0aWFsaXNlcyB0aGUgc3RhdGVpZCBjb3JyZWN0bHkuDQo+ID4gDQo+ID4gVHJvbmQg
TXlrbGVidXN0ICg5KToNCj4gPiAgIHBORlM6IEVuc3VyZSB3ZSBkbyBjbGVhciB0aGUgcmV0dXJu
LW9uLWNsb3NlIGxheW91dCBzdGF0ZWlkIG9uDQo+ID4gZmF0YWwNCj4gPiAgICAgZXJyb3JzDQo+
ID4gICBORlN2NDogQ2xlYW4gdXAgcE5GUyByZXR1cm4tb24tY2xvc2UgZXJyb3IgaGFuZGxpbmcN
Cj4gPiAgIE5GU3Y0OiBIYW5kbGUgTkZTNEVSUl9ERUxBWSBjb3JyZWN0bHkgaW4gcmV0dXJuLW9u
LWNsb3NlDQo+ID4gICBORlN2NDogSGFuZGxlIFJQQyBsZXZlbCBlcnJvcnMgaW4gTEFZT1VUUkVU
VVJODQo+ID4gICBORlN2NDogQWRkIGEgaGVscGVyIHRvIGluY3JlbWVudCBzdGF0ZWlkIHNlcWlk
cw0KPiA+ICAgcE5GUzogSGFuZGxlIE5GUzRFUlJfT0xEX1NUQVRFSUQgb24gbGF5b3V0cmV0dXJu
IGJ5IGJ1bXBpbmcgdGhlDQo+ID4gc3RhdGUNCj4gPiAgICAgc2VxaWQNCj4gPiAgIE5GU3Y0OiBG
aXggT1BFTl9ET1dOR1JBREUgZXJyb3IgaGFuZGxpbmcNCj4gPiAgIE5GU3Y0OiBIYW5kbGUgTkZT
NEVSUl9PTERfU1RBVEVJRCBpbiBDTE9TRS9PUEVOX0RPV05HUkFERQ0KPiA+ICAgTkZTdjQ6IEhh
bmRsZSBORlM0RVJSX09MRF9TVEFURUlEIGluIExPQ0tVDQo+ID4gDQo+ID4gIGZzL25mcy9uZnM0
X2ZzLmggICB8ICAxMSArKy0NCj4gPiAgZnMvbmZzL25mczRwcm9jLmMgIHwgMjA0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQo+ID4gLS0tLQ0KPiA+ICBmcy9uZnMv
bmZzNHN0YXRlLmMgfCAgMTYgLS0tLQ0KPiA+ICBmcy9uZnMvcG5mcy5jICAgICAgfCAgNzEgKysr
KysrKysrKysrKystLQ0KPiA+ICBmcy9uZnMvcG5mcy5oICAgICAgfCAgMTcgKysrLQ0KPiA+ICA1
IGZpbGVzIGNoYW5nZWQsIDIyOSBpbnNlcnRpb25zKCspLCA5MCBkZWxldGlvbnMoLSkNCj4gPiAN
Cj4gPiAtLQ0KPiA+IDIuMjEuMA0KPiA+IA0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5G
UyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJz
cGFjZS5jb20NCg0KDQo=
