Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C059D1FF
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbfHZOxR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 10:53:17 -0400
Received: from smtppost.atos.net ([193.56.114.177]:26107 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfHZOxN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Aug 2019 10:53:13 -0400
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost2.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 6c80_408f_8cb49928_57f4_4ef3_991a_e01fbadc8b5c;
        Mon, 26 Aug 2019 16:53:09 +0200
Received: from mail2-int.my-it-solutions.net ([10.92.32.13])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x7QEr9JP024489
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 16:53:09 +0200
Received: from DEERLM99ETQMSX.ww931.my-it-solutions.net ([10.86.142.102])
        by mail2-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x7QEr91g004039
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-nfs@vger.kernel.org>; Mon, 26 Aug 2019 16:53:09 +0200
Received: from DEERLM99ETTMSX.ww931.my-it-solutions.net (10.86.142.105) by
 DEERLM99ETQMSX.ww931.my-it-solutions.net (10.86.142.102) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Mon, 26 Aug 2019 16:53:08 +0200
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.105) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Mon, 26 Aug 2019 16:53:07 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4Tj+gtuNerGfjU59lLKjgRbEpOg0JH83Hes2iMdu/sMeuMgo/k4fsam55f3FMPuRz8D6pPEX7+zlVktdjEi/KUuqaDkAyZCrf6WV+VgYXta4T4fvqD6LeyQLkk93wdba4acf0c0ghje47oe3j7LiaFWa+HizJmWTpamzrPdk+eZFFOtlQZfyddFyZR7ust4ErjcXsGDE1aSPU1zv710ZnRpQPjkHicwEyagfY/+h/9hFbiFp3/QJjhyQsQjKnAjDloSyPUDhzdklhkOy588tnw1QGlAkeoa0PTD9dAH0OyfPqyYK06oWD9769d3pNzdykIAWFCngDAs+kf7y1i12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFLGi+wN/kNeInGAAAew/qXdmXNMhI6O73QF/0HO3K4=;
 b=OCgBJ9wNknJtIftt5w5ckxPuvOpHwGseEVCN0J/JGTAH7wvalbuXteTkQjjHMXDEAAur9A+zrtfPjmWjAubtC0k6k/385c51z1bMdv3p3g01+fA9KaBQOo3uVT8VHvO+bouxPxrVUJzIRkXFAmdnsWsYF+pKY0iD3NIT89QyvT0Rt5Fjj/JtlazYgwhApLTF2egLXvyLRyZQEgZVCNHpSxE3hfvdwlZpJ/LnCu/jPnEmeiJ2dHNWv1+nV46NUlrtmZhq+NzdF0DSR/qynNbZWgByqJGoLVpgL0hBNsBsghLFmJSTPTgJga1JH7VOMyuwm/npPLSHFUmlXwq+eVbI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com (10.173.88.135) by
 AM5PR0202MB2484.eurprd02.prod.outlook.com (10.173.90.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 26 Aug 2019 14:53:05 +0000
Received: from AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::411:ed7c:ed00:7bea]) by AM5PR0202MB2564.eurprd02.prod.outlook.com
 ([fe80::411:ed7c:ed00:7bea%12]) with mapi id 15.20.2199.021; Mon, 26 Aug 2019
 14:53:05 +0000
From:   "de Vandiere, Louis" <louis.devandiere@atos.net>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: RE: Maximum Number of ACL on NFSv4
Thread-Topic: Maximum Number of ACL on NFSv4
Thread-Index: AdVZ/zHAXlVbOFcuRg6ALmyIfYKMtQAAvtpwAISMAoAAAgBdYA==
Date:   Mon, 26 Aug 2019 14:53:05 +0000
Message-ID: <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
References: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu>
In-Reply-To: <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=louis.devandiere@atos.net; 
x-originating-ip: [157.130.128.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15766357-7c12-454f-9578-08d72a351a45
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM5PR0202MB2484;
x-ms-traffictypediagnostic: AM5PR0202MB2484:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM5PR0202MB24842DE836293579F686C57BE7A10@AM5PR0202MB2484.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(13464003)(189003)(199004)(42274003)(2501003)(66446008)(33656002)(66556008)(64756008)(66476007)(45080400002)(66066001)(6436002)(305945005)(256004)(14444005)(86362001)(55016002)(71190400001)(71200400001)(478600001)(74316002)(66946007)(76116006)(5640700003)(6306002)(2351001)(316002)(25786009)(52536014)(9686003)(7736002)(66574012)(5660300002)(966005)(229853002)(476003)(53546011)(6506007)(76176011)(11346002)(6116002)(446003)(7696005)(3846002)(81156014)(2906002)(81166006)(8676002)(8936002)(486006)(102836004)(6916009)(53936002)(26005)(99286004)(14454004)(6246003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0202MB2484;H:AM5PR0202MB2564.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZJxBoEEnv8iBM/WwXJiE3vE7j8f/SL+fsopQEGnKL+Y/9mSmA50BXi7TuEHYpdHF2GU3sFefknGLsgnfUkE+oVf3EkTVKZcdBd3AEuRJE+ncRQfzKiANU9ZJzuMZVoV2NacH7kK+6CdPD9wya6vfezqeZgfNurg7vHoFRSQnRP4f/fn+1FU5VaN2P/ZZiGGwf22HQeV0inSC22Bh1fctufau6komdBuWfVLU++hkrzWK4xHL9uEypyDXPB8MLRPC1rGRZB3ucQ7laCjWqdenK//1mrn3i2NJZ+KKdbB2Wqhe7cdI4ybpfVIxh+3adPhnYnrV+DEIA5mZBmovsRf6hLpgZlxzO2jZHN0f6vxp2w0e46wJr9WVhF/rvatNpoWgUEHKfDAuJU+7+HVIp0aXTyymYA3XSLLQ9G0P7l7kzOo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 15766357-7c12-454f-9578-08d72a351a45
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 14:53:05.6776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjnt8jLCAECSyRO0dzvQhLSoBgGmW/k60tc6Pz4DiIu/qlED69RgiN9avJ9dgAI0dMkeMdqMhYNzI4TumHcdmDpXBAmz937ocW2c/eoJm2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0202MB2484
X-OriginatorOrg: atos.net
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

WWVzLCBJIGFzc3VtZSBpdCdzIG5vdCB2ZXJ5IGZyZXF1ZW50IHRvIGhhdmUgaHVuZHJlZHMgb2Yg
TkZTdjQgQUNMcy4gRm9yIGNvbXBsaWFuY2UgYW5kIG9yZ2FuaXphdGlvbmFsIGlzc3VlLCB3ZSBj
YW5ub3QgdXNlIGdyb3VwcyBlZmZpY2llbnRseSB0byBtYW5hZ2UgYWNjZXNzIHRvIHRoZSBzaGFy
ZXMsIHNvIGl0J3MgdXNlci1iYXNlZCBhbmQgY2FzZSBieSBjYXNlLg0KIA0KTXkgcmVhbCBnb2Fs
IGlzIHRvIGJlIGFibGUgdG8gcmVwbGljYXRlIHNvbWUgZmlsZXMgdG8gYSBuZXcgTkZTdjQgc2Vy
dmVyIHdoaWxlIHByZXNlcnZpbmcgdGhlIEFDTHMuIEJ5IHVzaW5nICJjcCAtUiAtLXByZXNlcnZl
PWFsbCBhY2wtZm9sZGVyLyIsIEknbSBhYmxlIHRvIHByZXNlcnZlIHRoZSBBQ0xzIHdoZW4gdGhl
aXIgbnVtYmVyIGRvZXMgbm90IGV4Y2VlZCAyMDAsIGFib3ZlIGl0LCBJIHNlZSB0aGUgIkZpbGUg
dG9vIGxhcmdlIiBlcnJvciB3aGlsZSByc3luYyBkb2VzIG5vdCB3b3JrIGF0IGFsbCAoZXZlbiBp
biB2ZXJzaW9uIDMuMS4zKS4gVGhhdCdzIHdoeSBJJ20gZGlnZ2luZyBpbnRvIHRoaXMgYW5kIGNo
ZWNraW5nIHdoYXQgcG9zc2libHkgY291bGQgZ28gd3JvbmcuDQoNClRoYW5rIHlvdS4NCkJlc3Qs
DQpMb3VpcyBkZSBWYW5kacOocmUNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogR29ldHosIFBhdHJpY2sgRyA8cGdvZXR6QG1hdGgudXRleGFzLmVkdT4gDQpTZW50OiBNb25k
YXksIEF1Z3VzdCAyNiwgMjAxOSA4OjQ0IEFNDQpUbzogZGUgVmFuZGllcmUsIExvdWlzIDxsb3Vp
cy5kZXZhbmRpZXJlQGF0b3MubmV0PjsgbGludXgtbmZzQHZnZXIua2VybmVsLm9yZw0KU3ViamVj
dDogUmU6IE1heGltdW0gTnVtYmVyIG9mIEFDTCBvbiBORlN2NA0KDQpJJ20gZHlpbmcgdG8ga25v
dyB3aGF0IHRoZSB1c2UgY2FzZSBpcyBmb3IgdGhpcywgYW5kIHdoeSB5b3UgY2FuJ3QganVzdCBk
byB0aGlzIHdpdGggZ3JvdXAgcGVybWlzc2lvbnMgKHVubGVzcyB5b3UncmUgdGFsa2luZyBhYm91
dCBodW5kcmVkcyBvZiBncm91cCBBQ0xzKS4NCg0KT24gOC8yMy8xOSA1OjMxIFBNLCBkZSBWYW5k
aWVyZSwgTG91aXMgd3JvdGU6DQo+IEhpLA0KPiANCj4gSSdtIGN1cnJlbnRseSB0cnlpbmcgdG8g
YXBwbHkgaHVuZHJlZHMgb2YgQUNMcyBvbiBmaWxlIGhvc3RlZCBvbiBhIE5GU3Y0IHNlcnZlciAo
bmZzLXV0aWxzLTEuMy4wLTAuNjEuZWw3Lng4Nl82NCBhbmQgbmZzNC1hY2wtdG9vbHMuMC4zLjMt
MTkuZWw3Lng4Nl82NCkuIEl0IGFwcGVhcnMgdGhhdCB0aGUgbGltaXQgSSBjYW4gYXBwbHkgaXMg
MjA3LiBBZnRlciB0aGUgbGltaXQgaXMgcmVhY2hlZCwgdGhlIGNvbW1hbmQgIm5mczRfc2V0ZmFj
bCAtYSIgcmV0dXJuZWQgdGhlIGVycm9yICJGYWlsZWQgc2V0eGF0dHIgb3BlcmF0aW9uOiBGaWxl
IHRvbyBsYXJnZSIuIFRoZSBzYW1lIHByb2JsZW0gaGFwcGVucyBpZiBJIHVzZSBhbiBBQ0wgd2l0
aCBtb3JlIHRoYW4gMjAwIGxpbmUgaW4gaXQuIEkgZGlkIGEgbGl0dGxlIGRlYnVnZ2luZyBzZXNz
aW9uIGJ1dCBJIHdhcyBub3QgYWJsZSB0byBjb21lIHVwIHdpdGggYW4gZXhwbGFuYXRpb24gb24g
d2h5IEknbSBmYWNpbmcgc3VjaCBhbiBpc3N1ZS4NCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5kLCBJ
IGNhbiBhcHBseSBodW5kcmVkcyBvZiBBQ0xzIG9uIFhGUyB3aXRob3V0IGlzc3VlLiBEbyB5b3Ug
a25vdyBpZiBpdCBjb3VsZCBiZSBhIGJ1ZyB3aXRoIHRoZSBuZnM0LWFjbC10b29scyBwYWNrYWdl
Pw0KPiBUaGFuayB5b3UgZm9yIHlvdXIgc3VwcG9ydC4NCj4gQmVzdCwNCj4gTG91aXMgZGUgVmFu
ZGnDqHJlDQo+Pj4gVGhpcyBtZXNzYWdlIGlzIGZyb20gYW4gZXh0ZXJuYWwgc2VuZGVyLiBMZWFy
biBtb3JlIGFib3V0IHdoeSB0aGlzIDw8DQo+Pj4gbWF0dGVycyBhdCBodHRwczovL2V1cjAxLnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaW5rcy51
dGV4YXMuZWR1JTJGcnR5Y2xmJmFtcDtkYXRhPTAyJTdDMDElN0Nsb3Vpcy5kZXZhbmRpZXJlJTQw
YXRvcy5uZXQlN0NlNmQ2YjQ3MDVjZGU0NmJmNDU1YTA4ZDcyYTJiOTNkZiU3QzMzNDQwZmM2Yjdj
NzQxMmNiYjczMGU3MGIwMTk4ZDVhJTdDMCU3QzAlN0M2MzcwMjQyMzg5NzU2NDg2NDUmYW1wO3Nk
YXRhPUVnVGczJTJCUHlJcm5xRzZheGNIT3liS1oxQWxkc0dYajhDSUM1ejBGMFJhYyUzRCZhbXA7
cmVzZXJ2ZWQ9MC4gICAgICAgICAgICAgICAgICAgICAgICA8PA0KPiANCg==
