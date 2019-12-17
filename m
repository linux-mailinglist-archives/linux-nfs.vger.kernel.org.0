Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2612386F
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Dec 2019 22:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfLQVJ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Dec 2019 16:09:26 -0500
Received: from mail-mw2nam10on2093.outbound.protection.outlook.com ([40.107.94.93]:28209
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726634AbfLQVJZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 17 Dec 2019 16:09:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKWpmxPhpDYwX+7t0oQXCLFrSQGGEN+v1F7JiQrIhJ7fp5sa0pPsPsgNnx34hy1ipJuWJQmUpoYIemihlLdEUSzWxddQyCxmkSb6U2IevinnasYVa5qBLOb/hgiIk3yNoCJfjOfS2OMIjctgD/v5JORpXLpXk6BCQ85mzGU0Drrer3cqpr7dX8io6izHRe7mRgxfkHQsoHgX8xzXOzS+k5cUunDTHmaqmrf1KCXSgsFimGh+X+sTIZORCyRCZJN7SWK9jxzCfAbwsKFDkok6Qu+j8BYuxP1ku/NBk7zTYs87Xd9VjYZEQk5qn2PScBAvDXqYJ4AbwV1JqH/gmcGHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUUGKazw3ryI9HatbUHLhjevobfzJima0ybONQ8sWfM=;
 b=KSsxImZK7azYWmLGS8yhrifJgt9ksz9KS6tqnPogbS7Wbpaa7m0imI+8kcvhwShQS/s9+1QI9l6vdxcjA/5ZTF12EmYeWaTiATN8XKsPj3QFAV9SL1bzixywsoXIh1b7M4VfIWlqTPQJWIaxr7jYVxXfwV0IJiOBZCo+Lt2Yn1oXG2p2S0Q5S21VOifPhr5qZ9BZC0jte9HEzm+SgBNXWqHHzfQ/9VCamDCK1V7qSXi3MBal7mcrbfFoJWUJQGKwCq2F0YkaHqxDKpsq8Abiod6/BvxZX4TM23P8iBUZyNCQjwoKTDhixXkK/b2Rey3Sewd0wMRE+nJblxWu/9AqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUUGKazw3ryI9HatbUHLhjevobfzJima0ybONQ8sWfM=;
 b=aVzgmrR4SwaRZyBHZYwX4d5Oc100oJSeo/yITNU8iOGNl1OaHMLX4+7EykPBHyYoIGRmSAQrOgXF08mYcT86k9r5GtgqkHF+apxxWY3z7zN9rpFMbCN4qGwIj6zuCsr0dyk8NUUlSQTu1GtkJvqJCgvL/5ev0P/GrOnPMeQaQkY=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB2089.namprd13.prod.outlook.com (10.174.185.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.12; Tue, 17 Dec 2019 21:09:22 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::2d23:b456:d67:f230%6]) with mapi id 15.20.2559.012; Tue, 17 Dec 2019
 21:09:22 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@redhat.com" <bfields@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Return the correct number of bytes written to the
 file
Thread-Topic: [PATCH] nfsd: Return the correct number of bytes written to the
 file
Thread-Index: AQHVtQCYoZZ0pUm0fkGoKdsByYbV3qe+tsCAgAAWtACAAAOxgIAAAVkA
Date:   Tue, 17 Dec 2019 21:09:22 +0000
Message-ID: <79e2e673e544588767db43b20c40d3529722befb.camel@hammerspace.com>
References: <20191217173333.105547-1-trond.myklebust@hammerspace.com>
         <20191217193003.GA13504@pick.fieldses.org>
         <558a7031d413ffe2b16ef38c374a2bbc8bccec79.camel@hammerspace.com>
         <20191217210431.GE13504@pick.fieldses.org>
In-Reply-To: <20191217210431.GE13504@pick.fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1795cc21-9eee-4483-3bac-08d78335638c
x-ms-traffictypediagnostic: DM5PR1301MB2089:
x-microsoft-antispam-prvs: <DM5PR1301MB2089C7DCF259B532F46070D2B8500@DM5PR1301MB2089.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39840400004)(136003)(346002)(376002)(366004)(396003)(51444003)(189003)(199004)(26005)(6506007)(2906002)(6512007)(4001150100001)(6486002)(5660300002)(36756003)(81166006)(4326008)(8676002)(316002)(81156014)(6916009)(4744005)(8936002)(71200400001)(86362001)(76116006)(64756008)(66556008)(91956017)(66476007)(66946007)(66446008)(508600001)(2616005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB2089;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DOG4O3cvgegcLoRjigoUHw0BdCsdGC011prSV3DwHTvjFybXMn0ntefKZrTx3SZ52vPQxAm/ntVwzLxyEzWJC8UC5/T64C4vHTh0KMj8lXUqGIgCzVQQm0uQOKxhg9TnjRwvZeG1cxhefYGpPRA4dt5wOMCyegTWFcrKM3ecrW/wvIWHR8pFxJe0uxuBpbAYJe6j37JDXo1EjvQRo9J38laOVRhGbj2V+cV0kJUTS9+3LwJj702+2ErW0Dp9FAcNQ6jSsJT9be6LuHFq+AANr57Uqts4n9f3knR6vYFcfgwGdHWMyKEdpUuYxfUtNqTXBP4GfpfwCskRcKTs7O4IVAGdsHh0bW+52+X0Nu38ITgX8QD873qAS1Taqw2LEwkiAx67mU+vY/X2zvKVYi7Xbzf1rrvhaJhTW9Heolx+57GrIYUIkweBqtgtbadBXhH9+SRNcXf+tvLlcPeHdYq5tSaUBEKe1JDXs9F1X8PVOAsXseshf7pFUbADzJlFLJv6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F5AFC4DCCD8814DBE3DF035E001CCB0@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1795cc21-9eee-4483-3bac-08d78335638c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 21:09:22.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ECvgGa9JcTItfx1SAZXj6gvddPv3JB2GKaYGPE+HejHGQolSwuyYbdIs6H0nholMDZWDXcHJtZRAQV3sfat90Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2089
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDE2OjA0IC0wNTAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgRGVjIDE3LCAyMDE5IGF0IDA4OjUxOjIwUE0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMTktMTItMTcgYXQgMTQ6MzAgLTA1MDAsIEouIEJy
dWNlIEZpZWxkcyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgRGVjIDE3LCAyMDE5IGF0IDEyOjMzOjMz
UE0gLTA1MDAsIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+ID4gV2UgbXVzdCBhbGxvdyBm
b3IgdGhlIGZhY3QgdGhhdCBpb3ZfaXRlcl93cml0ZSgpIGNvdWxkIGhhdmUNCj4gPiA+ID4gcmV0
dXJuZWQNCj4gPiA+ID4gYSBzaG9ydCB3cml0ZSAoZS5nLiBpZiB0aGVyZSB3YXMgYW4gRU5PU1BD
IGlzc3VlKS4NCj4gPiA+IA0KPiA+ID4gVGhhbmtzISAgSnVzdCBhIG5pdDoNCj4gPiA+IA0KPiA+
ID4gPiBGaXhlczogNzNkYTg1MmUzODMxICgibmZzZDogdXNlIHZmc19pdGVyX3JlYWQvd3JpdGUi
KQ0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoYXQgc2hvdWxkIGJlIGQ4OTBiZTE1OWE3MSAibmZz
ZDogQWRkIEkvTyB0cmFjZSBwb2ludHMNCj4gPiA+IGluDQo+ID4gPiB0aGUNCj4gPiA+IE5GU3Y0
IHdyaXRlIHBhdGgiLg0KPiA+IA0KPiA+IEZhaXIgZW5vdWdoLiBEbyB5b3Ugd2FudCB0byBmaXgg
dGhhdCB1cD8NCj4gDQo+IEkndmUgdGFrZW4gY2FyZSBvZiBpdC4tLWIuDQoNClRoYW5rIHlvdSEN
Cg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFt
bWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
