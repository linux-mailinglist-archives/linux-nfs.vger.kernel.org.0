Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F1725760
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfEUSR2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 14:17:28 -0400
Received: from mail-eopbgr700120.outbound.protection.outlook.com ([40.107.70.120]:22209
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728256AbfEUSR2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 May 2019 14:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5ptBMNnMLa0gNg0BMa8HsQw3tFo8W4RnUIdrSHXQgk=;
 b=Xxa9dtN6EA1fZlZsLudKGPrFWn5EuybcRnrX2Ya+cSNEl8rdxWJUWwQ81zaFWnbdI7hM4yhFD9z1kqzM2J7Omg9FdP4LkJSXeIJRVeLSx+izjlHnQTYMoBl6AEq+ZXmPIHD+9PQGigIRcLDt7Do9VLK/VTpek3+pjKdj9sLS1+c=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB0891.namprd13.prod.outlook.com (10.169.159.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.8; Tue, 21 May 2019 18:17:22 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 18:17:22 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chucklever@gmail.com" <chucklever@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Subject: Re: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Topic: [RFC PATCH v2 0/7] Add a root_dir option to nfs.conf
Thread-Index: AQHVD9OY0U3UwvcYW0a/WB0ITGDVLKZ12MoAgAAKagA=
Date:   Tue, 21 May 2019 18:17:22 +0000
Message-ID: <25ce1d3aa852ecd09ff300233aea60b71e6e69df.camel@hammerspace.com>
References: <20190521124701.61849-1-trond.myklebust@hammerspace.com>
         <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
In-Reply-To: <708D03B6-AEE1-42D6-ABDF-FB1AA5FC9A94@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7e5af12-42fa-43b7-c2c6-08d6de1891d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR13MB0891;
x-ms-traffictypediagnostic: DM5PR13MB0891:
x-microsoft-antispam-prvs: <DM5PR13MB08915ABBBBEF8E4F6D96F211B8070@DM5PR13MB0891.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39830400003)(366004)(376002)(346002)(136003)(199004)(189003)(2351001)(66066001)(1730700003)(1361003)(6486002)(81166006)(8676002)(81156014)(229853002)(8936002)(14444005)(256004)(14454004)(71190400001)(71200400001)(2501003)(5640700003)(118296001)(36756003)(76176011)(478600001)(6436002)(54906003)(316002)(6916009)(64756008)(2906002)(73956011)(11346002)(2616005)(102836004)(66446008)(76116006)(66476007)(91956017)(66946007)(66556008)(476003)(53936002)(486006)(305945005)(53546011)(6506007)(1411001)(6246003)(7736002)(4326008)(68736007)(5660300002)(446003)(6116002)(26005)(25786009)(86362001)(186003)(3846002)(6512007)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB0891;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ggji4xv/46E8DtiX/jpRYCobIHZDy8lcXOJCoEEQMhsz73io3VBj7HZLAkXDW2UStRt5MCThgwI3ZzUN5Py1Am9QBHH3+2Cgr7A3NUv9TKwgHgcdudY4qaUAV3tmav1QqThkM7+j1NzTALDSUVdNgG/dKff/V8YIvwYi0A1N7CXwixAHLW7C+v0+7QTbvpMLCJpj8NNPN7QeOjKp5LfTlP5IGbsyIpTtmMg+kMR9N2ZBzrYc44mL7ASm4WwFh4NqPmjI0i6yEIqWZfq5oGMcK5uOH1kU0rb3QT2N7942awI+j9PgmMf+kEYjVlCf6V9sUNAHjlAwTtZt/blm1CW8ZVY06fFP1444y4mlnugY0P2Jd3I0Q06mVOj1oG6eWQe1F+wQkSC7o8cbGswNDackcWDxGzrsSrW+SMf5WQ/9Zqo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68FE2D2301AE9D44A2B67EB2C57FBEEF@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e5af12-42fa-43b7-c2c6-08d6de1891d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 18:17:22.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0891
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTA1LTIxIGF0IDEzOjQwIC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SGkgVHJvbmQgLQ0KPiANCj4gPiBPbiBNYXkgMjEsIDIwMTksIGF0IDg6NDYgQU0sIFRyb25kIE15
a2xlYnVzdCA8dHJvbmRteUBnbWFpbC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gVGhlIGZv
bGxvd2luZyBwYXRjaHNldCBhZGRzIHN1cHBvcnQgZm9yIHRoZSAncm9vdF9kaXInDQo+ID4gY29u
ZmlndXJhdGlvbg0KPiA+IG9wdGlvbiBmb3IgbmZzZCBpbiBuZnMuY29uZi4gSWYgYSB1c2VyIHNl
dHMgdGhpcyBvcHRpb24gdG8gYSB2YWxpZA0KPiA+IGRpcmVjdG9yeSBwYXRoLCB0aGVuIG5mc2Qg
d2lsbCBhY3QgYXMgaWYgaXQgaXMgY29uZmluZWQgdG8gYSBjaHJvb3QNCj4gPiBqYWlsIGJhc2Vk
IG9uIHRoYXQgZGlyZWN0b3J5LiBBbGwgcGF0aHMgaW4gL2V0Yy9leHBvcmZzIGFuZCBmcm9tDQo+
ID4gZXhwb3J0ZnMgYXJlIHRoZW4gcmVzb2x2ZWQgcmVsYXRpdmUgdG8gdGhhdCBkaXJlY3Rvcnku
DQo+IA0KPiBXaGF0IGFib3V0IGZpbGVzIHVuZGVyIC9wcm9jIHRoYXQgbW91bnRkIG1pZ2h0IGFj
Y2Vzcz8gSSBhc3N1bWUgdGhlc2UNCj4gcGF0aG5hbWVzIGFyZSBub3QgYWZmZWN0ZWQuDQo+IA0K
VGhhdCdzIHdoeSB3ZSBoYXZlIDIgdGhyZWFkcy4gT25lIHRocmVhZCBpcyByb290IGphaWxlZCB1
c2luZyBjaHJvb3QsDQphbmQgaXMgdXNlZCB0byB0YWxrIHRvIGtuZnNkLiBUaGUgb3RoZXIgdGhy
ZWFkIGlzIG5vdCByb290IGphaWxlZCAob3INCmF0IGxlYXN0IG5vdCBieSByb290X2RpcikgYW5k
IHNvIGhhcyBmdWxsIGFjY2VzcyB0byAvZXRjLCAvcHJvYywgL3ZhciwNCi4uLg0KDQo+IEFyZW4n
dCB0aGVyZSBhbHNvIG9uZSBvciB0d28gb3RoZXIgZmlsZXMgdGhhdCBtYWludGFpbiBleHBvcnQg
c3RhdGUNCj4gbGlrZSAvdmFyL2xpYi9uZnMvcm10YWI/IEFyZSB0aG9zZSBhZmZlY3RlZD8NCg0K
U2VlIGFib3ZlLiBUaGV5IGFyZSBub3QgYWZmZWN0ZWQuDQoNCj4gSU1ITyBpdCBjb3VsZCBiZSBs
ZXNzIGNvbmZ1c2luZyB0byBhZG1pbmlzdHJhdG9ycyB0byBtYWtlIHJvb3RfZGlyIGFuDQo+IFtl
eHBvcnRmc10gb3B0aW9uIGluc3RlYWQgb2YgYSBbbW91bnRkXSBvcHRpb24sIGlmIHRoaXMgaXMg
bm90IGEgdHJ1ZQ0KPiBjaHJvb3Qgb2YgbW91bnRkLg0KDQpJdCBpcyBuZWl0aGVyLiBJIG1hZGUg
aW4gYSBbbmZzZF0gb3B0aW9uLCBzaW5jZSBpdCBnb3Zlcm5zIHRoZSB3YXkgdGhhdA0KYm90aCBl
eHBvcnRmcyBhbmQgbW91bnRkIHRhbGsgdG8gbmZzZC4NCg0KQ2hlZXJzDQogIFRyb25kDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
