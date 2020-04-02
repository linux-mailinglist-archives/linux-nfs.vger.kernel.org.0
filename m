Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02FCF19C768
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2020 18:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389554AbgDBQyg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 12:54:36 -0400
Received: from mail-bn8nam12on2126.outbound.protection.outlook.com ([40.107.237.126]:48244
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388689AbgDBQyf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 12:54:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUpYcwtpAFG7hmfRFhI+uRvWHXHq+nJuOYnG8begoRd5jEd6wCZRYUmyXCxgxZxWWcLRoQTkBWzHPoTZm489mqLQMxBd/zzBXtp3QFEPQMF9itNgsuIRTrhecSjs24SqJKW2OVdoUTaIvtnlS++DQMum9S6SnMjUpKAoUih+hqAUtAodBuWT+M7QcbOrZSObPGjmfZkmJjYc+25NzzWec7msdRJI70aLRdjRu1NyzN/WWuMOpqNPF3oc1Oq0MjoByo5RSmGV1XswNjKBBiYuxVNoDieq0SFKWT2wIT6vzSJwkIyW/JBGVN64LYdfGWYzwThNdJ4AzHI7shdYWqwEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYyvPBFlGCCrDU7nYY9pc3eGEPu8itpnZDVsyQknmig=;
 b=mpFUA7QXTI2Uu6MbHvsPo0zMU3I+OzB5qakMmhzRh7o2SXadxd0591nP3s0ZNWXZTUbeSJOeIwx8FUzcQPmSaD37HnV/B7Ksa+0LmPOex1eRV5K991uSkp6uMov7Qiq6sPaS0frwuyR5x9AXUzRRoQSpynRRojf0qPr50d0rPFv9HZp4bCk8DF8QRuvoRJAaDMybeB8fhW7+5h9+3KBeup+1HNyp2MFzE/Jd387+cfaqSAxI6BQHRJszU9ozSgVWvq0c/u1Ft0tgE3NeI3UH2gRoMJ5sAVGEPfR+StmdiHl9Dff6sZgltuI7HJBQRMAMopRA+uGqjYGb1cle6F2nRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYyvPBFlGCCrDU7nYY9pc3eGEPu8itpnZDVsyQknmig=;
 b=Xvj+jTBKCQ8uhBmm8hjGL1CW4wv4+fiGaa9OxoE3OBJkCILFug5Iy5tj4eGmy/l0VAaDKIhfDV7AR9A+Zqfr1Fh9tE8whWtpd1wJTkEZ0OS/ZgwDe1yuUV57aml/UBpVx9hx7jAzaVY3YXH4LQ4RYY9tI3AjqIyCc+uCyvi8fiM=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3589.namprd13.prod.outlook.com (2603:10b6:610:2a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.11; Thu, 2 Apr
 2020 16:54:32 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36%7]) with mapi id 15.20.2878.012; Thu, 2 Apr 2020
 16:54:31 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>
Subject: Re: [PATCH 05/10] NFS: Fix memory leaks in
 nfs_pageio_stop_mirroring()
Thread-Topic: [PATCH 05/10] NFS: Fix memory leaks in
 nfs_pageio_stop_mirroring()
Thread-Index: AQHWCFee17Md9vmxf0qCN4Yz5Tx8BahmAvGAgAALIAA=
Date:   Thu, 2 Apr 2020 16:54:31 +0000
Message-ID: <bb4d849713fb46a29ba06025c691687348ca2a11.camel@hammerspace.com>
References: <20200401185652.1904777-1-trondmy@kernel.org>
         <20200401185652.1904777-2-trondmy@kernel.org>
         <20200401185652.1904777-3-trondmy@kernel.org>
         <20200401185652.1904777-4-trondmy@kernel.org>
         <20200401185652.1904777-5-trondmy@kernel.org>
         <20200401185652.1904777-6-trondmy@kernel.org>
         <c1a7808b-2bf5-0716-f720-d77fc5f09160@gmail.com>
In-Reply-To: <c1a7808b-2bf5-0716-f720-d77fc5f09160@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ca4d8c9-5703-49db-7b48-08d7d7268401
x-ms-traffictypediagnostic: CH2PR13MB3589:
x-microsoft-antispam-prvs: <CH2PR13MB35898B6C146D142D7CC2156DB8C60@CH2PR13MB3589.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(136003)(366004)(39830400003)(376002)(346002)(66556008)(66946007)(6512007)(64756008)(6486002)(5660300002)(76116006)(86362001)(6506007)(66476007)(91956017)(71200400001)(53546011)(2616005)(316002)(186003)(36756003)(66446008)(8676002)(110136005)(81166006)(81156014)(2906002)(26005)(478600001)(8936002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UzUexVMA1QYtl9kQ2YqHvvu2sb/zEiMGYkIVbGXuAKorjvcVjJqTulVEVN/QnPwS+vgsK7cfFYq0bLHS2UWMUfqValjaFFuBvCJm25k0NwUPG91KHKCH9LqEjqrKIzZSFFb+5yVaTbcYPKnkt47C7cAptlClAFid1cO+6DcQtyCERZlZWu4UotxRDuXRO5FTlOwWngMmpwuZUuJmsce/hx6VfJR/1fmtLE22DDig6R5yMWU4N7LXWF4c2cRZXgjYRXx2IyTRqxexDMcmjgP7/QE4hJvDUsh9QflWp/SZZTSRcxeo3WNb0//31Zgl0XSyfXlrnveBXXCc4avTjL9FCU6CnedPTEJPupbzSwTsfC7IxZbFy+aR6qfNII+ySaMaK62hXjYQnZ6+4Kc63/E/URy5TFKVnAK7BZ9t5+xv6g3yIEY6t4a6oab8wyUJM65u
x-ms-exchange-antispam-messagedata: D9j6WF/QN0w5z7Km+go8crF6Xa7xukDqRBdjfpCGB+0Ll8ItZ1pbdsW2iC0AoQR05QqbNU8jt6qRTymXE5msuiby6S4U58AwSuFyg0EEChofp++3qVLijmg66SnPuIFvEvVUu5W7kTepjUV4M9F3kA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C2D81AA476C8C4CBA4460F7898882D3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca4d8c9-5703-49db-7b48-08d7d7268401
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 16:54:31.8813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DmDkrmTBx0eVX48gdAJZ5uWYwB8SONeQHxMtXPspKMZ2+Zz1gVqwtxrX2Igm/6WOk/m3cwGVTJ812pp1ixjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3589
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTAyIGF0IDEyOjE0IC0wNDAwLCBBbm5hIFNjaHVtYWtlciB3cm90ZToN
Cj4gSGkgVHJvbmQsDQo+IA0KPiBPbiA0LzEvMjAgMjo1NiBQTSwgdHJvbmRteUBrZXJuZWwub3Jn
IHdyb3RlOg0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1l
cnNwYWNlLmNvbT4NCj4gPiANCj4gPiBJZiB3ZSBqdXN0IHNldCB0aGUgbWlycm9yIGNvdW50IHRv
IDEgd2l0aG91dCBmaXJzdCBjbGVhcmluZyBvdXQNCj4gPiB0aGUgbWlycm9ycywgd2UgY2FuIGxl
YWsgcXVldWVkIHVwIHJlcXVlc3RzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyb25kIE15
a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZnMvbmZzL3BhZ2VsaXN0LmMgfCAxNyArKysrKysrKy0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9mcy9uZnMvcGFnZWxpc3QuYyBiL2ZzL25mcy9wYWdlbGlzdC5jDQo+ID4gaW5kZXggOTll
YjgzOWM1Nzc4Li4xZmQ0ODYyMjE3ZTAgMTAwNjQ0DQo+ID4gLS0tIGEvZnMvbmZzL3BhZ2VsaXN0
LmMNCj4gPiArKysgYi9mcy9uZnMvcGFnZWxpc3QuYw0KPiA+IEBAIC05MDAsMTUgKzkwMCw2IEBA
IHN0YXRpYyB2b2lkIG5mc19wYWdlaW9fc2V0dXBfbWlycm9yaW5nKHN0cnVjdA0KPiA+IG5mc19w
YWdlaW9fZGVzY3JpcHRvciAqcGdpbywNCj4gPiAgCXBnaW8tPnBnX21pcnJvcl9jb3VudCA9IG1p
cnJvcl9jb3VudDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAtLyoNCj4gPiAtICogbmZzX3BhZ2Vpb19z
dG9wX21pcnJvcmluZyAtIHN0b3AgdXNpbmcgbWlycm9yaW5nIChzZXQgbWlycm9yDQo+ID4gY291
bnQgdG8gMSkNCj4gPiAtICovDQo+ID4gLXZvaWQgbmZzX3BhZ2Vpb19zdG9wX21pcnJvcmluZyhz
dHJ1Y3QgbmZzX3BhZ2Vpb19kZXNjcmlwdG9yICpwZ2lvKQ0KPiA+IC17DQo+ID4gLQlwZ2lvLT5w
Z19taXJyb3JfY291bnQgPSAxOw0KPiA+IC0JcGdpby0+cGdfbWlycm9yX2lkeCA9IDA7DQo+ID4g
LX0NCj4gPiAtDQo+ID4gIHN0YXRpYyB2b2lkIG5mc19wYWdlaW9fY2xlYW51cF9taXJyb3Jpbmco
c3RydWN0DQo+ID4gbmZzX3BhZ2Vpb19kZXNjcmlwdG9yICpwZ2lvKQ0KPiA+ICB7DQo+ID4gIAlw
Z2lvLT5wZ19taXJyb3JfY291bnQgPSAxOw0KPiA+IEBAIC0xMzM0LDYgKzEzMjUsMTQgQEAgdm9p
ZCBuZnNfcGFnZWlvX2NvbmRfY29tcGxldGUoc3RydWN0DQo+ID4gbmZzX3BhZ2Vpb19kZXNjcmlw
dG9yICpkZXNjLCBwZ29mZl90IGluZGV4KQ0KPiA+ICAJfQ0KPiA+ICB9DQo+ID4gIA0KPiA+ICsv
Kg0KPiA+ICsgKiBuZnNfcGFnZWlvX3N0b3BfbWlycm9yaW5nIC0gc3RvcCB1c2luZyBtaXJyb3Jp
bmcgKHNldCBtaXJyb3INCj4gPiBjb3VudCB0byAxKQ0KPiA+ICsgKi8NCj4gPiArdm9pZCBuZnNf
cGFnZWlvX3N0b3BfbWlycm9yaW5nKHN0cnVjdCBuZnNfcGFnZWlvX2Rlc2NyaXB0b3IgKnBnaW8p
DQo+ID4gK3sNCj4gPiArCW5mc19wYWdlaW9fY29tcGxldGUocGdpbyk7DQo+ID4gK30NCj4gPiAr
DQo+IA0KPiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIHJlcGxhY2UgY2FsbHMgdG8gbmZzX3BhZ2Vp
b19zdG9wX21pcnJvcmluZygpDQo+IHdpdGggbmZzX3BhZ2Vpb19jb21wbGV0ZSgpIGluc3RlYWQ/
DQo+IA0KDQpOby4gTGV0J3Mga2VlcCB0aGUgd3JhcHBlciwgc2luY2UgaXQgbWFrZXMgdGhlIHdy
aXRlYmFjayBjb2RlIGVhc2llciB0bw0KcmVhZCAoaXQgZXhwcmVzc2VzIHRoZSBpbnRlbnQgbW9y
ZSBjbGVhcmx5KS4NCg0KPiBBbm5hDQo+IA0KPiA+ICBpbnQgX19pbml0IG5mc19pbml0X25mc3Bh
Z2VjYWNoZSh2b2lkKQ0KPiA+ICB7DQo+ID4gIAluZnNfcGFnZV9jYWNoZXAgPSBrbWVtX2NhY2hl
X2NyZWF0ZSgibmZzX3BhZ2UiLA0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGll
bnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5j
b20NCg0KDQo=
