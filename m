Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BADC5334F0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfFCQaJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 12:30:09 -0400
Received: from mail-eopbgr720126.outbound.protection.outlook.com ([40.107.72.126]:12640
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728239AbfFCQaJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jun 2019 12:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FkBtsv/DJErPpchCMNVzEHdntpcdHR7/Wk5rrzWRe0=;
 b=AFhfoq5u2vVeFoLAmbb5qcs0/whFa4I5rx0o4LXcwtQl0xM1oc3O9yRu5tbm8Na3a5lDYi5eruiX7lvbxJVetvOagFmMdPiaY/FBv2DgSnGCyZHxEMcr4M/zzOOln3R27YivNZyCVfOUaI94qDH/OQAaQvbb2lYjKGSt/w4fZFk=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1370.namprd13.prod.outlook.com (10.168.119.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 3 Jun 2019 16:30:05 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.1965.007; Mon, 3 Jun 2019
 16:30:05 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] Add support for the "[exports] rootdir" nfs.conf
 option to rpc.mountd
Thread-Topic: [PATCH v3 08/11] Add support for the "[exports] rootdir"
 nfs.conf option to rpc.mountd
Thread-Index: AQHVFZSk1606pId51U+ecolwFdoj86aFaU8AgASaEwCAACSjgA==
Date:   Mon, 3 Jun 2019 16:30:04 +0000
Message-ID: <dc346f64a0e0d3934de0eb18e3c63bef63003c48.camel@hammerspace.com>
References: <20190528203122.11401-1-trond.myklebust@hammerspace.com>
         <20190528203122.11401-2-trond.myklebust@hammerspace.com>
         <20190528203122.11401-3-trond.myklebust@hammerspace.com>
         <20190528203122.11401-4-trond.myklebust@hammerspace.com>
         <20190528203122.11401-5-trond.myklebust@hammerspace.com>
         <20190528203122.11401-6-trond.myklebust@hammerspace.com>
         <20190528203122.11401-7-trond.myklebust@hammerspace.com>
         <20190528203122.11401-8-trond.myklebust@hammerspace.com>
         <20190528203122.11401-9-trond.myklebust@hammerspace.com>
         <20190531160224.GD1251@fieldses.org>
         <3b9913c5-6ec7-aea8-fa03-bcabdac2f59c@RedHat.com>
In-Reply-To: <3b9913c5-6ec7-aea8-fa03-bcabdac2f59c@RedHat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.175.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abc6536f-8ebd-43c9-d741-08d6e840bc27
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1370;
x-ms-traffictypediagnostic: DM5PR13MB1370:
x-microsoft-antispam-prvs: <DM5PR13MB137048F89DBA894534CB2C1FB8140@DM5PR13MB1370.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(396003)(39830400003)(189003)(199004)(25786009)(256004)(7736002)(36756003)(8676002)(5660300002)(305945005)(81166006)(81156014)(478600001)(14454004)(476003)(2616005)(446003)(486006)(11346002)(8936002)(110136005)(316002)(4326008)(186003)(6246003)(66946007)(66066001)(6506007)(53546011)(102836004)(76176011)(26005)(73956011)(66556008)(76116006)(99286004)(2906002)(64756008)(66476007)(66446008)(2501003)(6116002)(3846002)(229853002)(71200400001)(71190400001)(53936002)(6436002)(6486002)(6512007)(86362001)(68736007)(118296001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1370;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tcpf9L8Q0CJfo15LTVbavNS/Cu6MCO3f9Gd5dL4b2M35wWNc4NHew73NTeJkgGe/9puONUBxLIp+8WK+9WxmQB0AoE0ahAm2CPM4MGbbd5IsW8K2IUrBFzL06iYVXQpVTv4+1qcz6vNo0bDAraLFRnXAxNR2QIkCvlZXS25+IA+FG3IcxdcaZ/CPKh+AR/Se0azY6lQZudhLq/D0hBDr/REREaz10KIvYYzBcN1JzR7SO+8oI0V+R0MASZ/dkSxuB0g18Br+g1ztKJv3nHcZRDB4Bo95yAu7dD3V3/uW3AttpcjE4XAk1KJKEG2iSgdyCTlJs8Sti7tS+5/zbjqSRgTAMXdD9XzzcRXbGBJ7cxUG72ExT8skmeWWOrZ9Ot6efBXwotz3q63nqxDNcT+KMJ3R10BfqzDvqWqCcwghp9Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4348E92EFAC8124889B0F185F29B1656@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abc6536f-8ebd-43c9-d741-08d6e840bc27
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 16:30:05.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1370
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA2LTAzIGF0IDEwOjE4IC0wNDAwLCBTdGV2ZSBEaWNrc29uIHdyb3RlOg0K
PiANCj4gT24gNS8zMS8xOSAxMjowMiBQTSwgSi4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+IE9u
IFR1ZSwgTWF5IDI4LCAyMDE5IGF0IDA0OjMxOjE5UE0gLTA0MDAsIFRyb25kIE15a2xlYnVzdCB3
cm90ZToNCj4gPiA+IEBAIC0zNzMsMjEgKzM5MCwyMiBAQCBzdGF0aWMgY2hhciAqbmV4dF9tbnQo
dm9pZCAqKnYsIGNoYXIgKnApDQo+ID4gPiAgCUZJTEUgKmY7DQo+ID4gPiAgCXN0cnVjdCBtbnRl
bnQgKm1lOw0KPiA+ID4gIAlzaXplX3QgbCA9IHN0cmxlbihwKTsNCj4gPiA+ICsJY2hhciAqbW50
X2RpciA9IE5VTEw7DQo+ID4gPiArDQo+ID4gPiAgCWlmICgqdiA9PSBOVUxMKSB7DQo+ID4gPiAg
CQlmID0gc2V0bW50ZW50KCIvZXRjL210YWIiLCAiciIpOw0KPiA+ID4gIAkJKnYgPSBmOw0KPiA+
ID4gIAl9IGVsc2UNCj4gPiA+ICAJCWYgPSAqdjsNCj4gPiA+IC0Jd2hpbGUgKChtZSA9IGdldG1u
dGVudChmKSkgIT0gTlVMTCAmJiBsID4gMSAmJg0KPiA+ID4gLQkgICAgICAgKHN0cm5jbXAobWUt
Pm1udF9kaXIsIHAsIGwpICE9IDAgfHwNCj4gPiA+IC0JCW1lLT5tbnRfZGlyW2xdICE9ICcvJykp
DQo+ID4gPiAtCQk7DQo+ID4gPiAtCWlmIChtZSA9PSBOVUxMKSB7DQo+ID4gPiAtCQllbmRtbnRl
bnQoZik7DQo+ID4gPiAtCQkqdiA9IE5VTEw7DQo+ID4gPiAtCQlyZXR1cm4gTlVMTDsNCj4gPiA+
ICsJd2hpbGUgKChtZSA9IGdldG1udGVudChmKSkgIT0gTlVMTCAmJiBsID4gMSkgew0KPiA+ID4g
KwkJbW50X2RpciA9IG5mc2RfcGF0aF9zdHJpcF9yb290KG1lLT5tbnRfZGlyKTsNCj4gPiA+ICsN
Cj4gPiA+ICsJCWlmIChzdHJuY21wKG1udF9kaXIsIHAsIGwpID09IDAgJiYgbW50X2RpcltsXSAh
PSAnLycpDQo+ID4gPiArCQkJcmV0dXJuIG1udF9kaXI7DQo+ID4gDQo+ID4gVGhhdCBzaG91bGQg
YmUgIm1udF9kaXJbbF0gPT0gJy8nIiwgcmlnaHQ/DQo+IENvbW1lbnQgc2F5cw0KPiAvKiBJdGVy
YXRlIHRocm91Z2ggL2V0Yy9tdGFiLCBmaW5kaW5nIG1vdW50cG9pbnRzDQo+ICAqIGF0IG9yIGJl
bG93IGEgZ2l2ZW4gcGF0aA0KPiAgKi8NCj4gDQo+IFNvIEkgZG9uJ3QgdGhpbmsgdGhlIGFjdHVh
bCAnLycgc2hvdWxkIHJldHVybmVkLCBUcm9uZD8NCg0KWWVwLiBZb3UncmUgYm90aCByaWdodC4g
SSd2ZSBnb3QgYW4gaW5jcmVtZW50YWwgcGF0Y2ggdG8gZml4IHRoaXMuDQoNCi0tIA0KVHJvbmQg
TXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9u
ZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
