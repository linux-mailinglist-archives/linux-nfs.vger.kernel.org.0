Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1312B6C046
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 19:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfGQRTK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 13:19:10 -0400
Received: from mail-eopbgr820090.outbound.protection.outlook.com ([40.107.82.90]:40032
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725873AbfGQRTJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Jul 2019 13:19:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXN3/TFxFUb1FJWAvt5OQQvLjn7aa6K5YJX4Ags0V7m/Yarn0Nb6f2AjNbcHm/uDl0iR1HBgbWP3opV0aic2tEd5JrvrhUm8r3oqUB6H75CxeSf0x9W9cv/eHX8cQdWqT9CBb2L05AjrsVWGSqHke0/Kf6xiDQkIJJx8zs2XgX5EGIp2CmVcMd9nm+P9n0vkUvrg6c3iDSW9qeCpO2+dvnyTfunWCYhIxKII1Ty2cK2zyUO0+Ko7//KFzpDsSn680hlGlZOnF61Tc02AaAqT7tc1iWpv4wS3UCX/3NkYZ31Vfu5b0AOhCcV/l9TO98zG8aIcNZRM9Y0Zd3hWNi7X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fniXBA15hAhNodBrAmy47VlwCjEqw2Gztj18ccFTveM=;
 b=bBgowSGYjIgwPoJPtslRp1QV/oplQxLQRR4osnrXWdGL0wLNAIIzoqdV8IAKrqxua9HSN4ZfBPohJkEiYz9y15cAkbo9rXR092jmQIoQclkAtwhAaB0X4QqTsLq8dKblAbritAh2T2rg7NHN2eQvHuoDJkKO1oZ75Xx109fAJC3Sdg6u7ADASVdeoAJigkUqODQBw5Fm+Dg4Wpz4yu1cMlr2dp44Ny3aCa3o5MYUtOjA2K/B7YbsgMfcdvn0I99qptQyq33IMt64ZbXL/qkexRK5MtuXYiIuk9WmuVjEmHoGEcawW3+n6sqk32zB0CTyvNr5EvByhdXZNV4ux5ODgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=hammerspace.com;dmarc=pass action=none
 header.from=hammerspace.com;dkim=pass header.d=hammerspace.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fniXBA15hAhNodBrAmy47VlwCjEqw2Gztj18ccFTveM=;
 b=CcibQfNsd6hMPSl9wY6SQBz+X3vcHPxHYucX3/Rd71yBfnJ9S75MpD343Ng0HAq03AO4XUfn+MTqzeaid0YOrmM6ri5Lr0/xb3e3tYDo3keJUw9uvoKCAH+b6L5D78CNgnEu2N+eVWNaCFG7z3zeW2Xw1YmOYJR+R50wG2cyjvE=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1180.namprd13.prod.outlook.com (10.168.237.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.8; Wed, 17 Jul 2019 17:19:06 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93%5]) with mapi id 15.20.2094.009; Wed, 17 Jul 2019
 17:19:06 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] SUNRPC: Fix up backchannel slot table accounting
Thread-Topic: [PATCH 1/2] SUNRPC: Fix up backchannel slot table accounting
Thread-Index: AQHVPBGky177GoZBdE6+Dd1fDjyBd6bO1lQAgAA4/wA=
Date:   Wed, 17 Jul 2019 17:19:06 +0000
Message-ID: <97e9839faef3d1bc901d4ced3d0cf2e0bf2a0bd1.camel@hammerspace.com>
References: <20190716200157.38583-1-trond.myklebust@hammerspace.com>
         <99A569FB-DD7F-4547-AB06-FEB5DABA8488@oracle.com>
In-Reply-To: <99A569FB-DD7F-4547-AB06-FEB5DABA8488@oracle.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 608aa1a6-1c11-467c-db58-08d70adadf60
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1180;
x-ms-traffictypediagnostic: DM5PR13MB1180:
x-microsoft-antispam-prvs: <DM5PR13MB1180EB86335F36F1594E2B80B8C90@DM5PR13MB1180.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(136003)(366004)(376002)(346002)(189003)(199004)(81166006)(81156014)(25786009)(6116002)(3846002)(14444005)(86362001)(53936002)(7736002)(305945005)(36756003)(186003)(478600001)(476003)(229853002)(8676002)(5660300002)(8936002)(6916009)(6512007)(11346002)(256004)(2906002)(4744005)(76116006)(66946007)(2616005)(316002)(486006)(68736007)(99286004)(6506007)(64756008)(66476007)(6436002)(76176011)(2351001)(66556008)(71200400001)(66446008)(446003)(102836004)(6486002)(5640700003)(2501003)(66066001)(14454004)(118296001)(6246003)(4326008)(26005)(53546011)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1180;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zvh4Xk0mCCX/4pkjbci+N4fjuFMJFjicOuhvgbG2n8UTVErS7r2IUgks81Le/lcNUwsAOV2JC+ORlTqb7uPRNRmr9rrdcpkgLX4o01gDTOABj6oCqSr97R5J0yILx6pYddFIxY4rJk1N/h0n4CD9dU7UXYXi1T2DF0PgEdWm985knTP4pn07hepqbV6JTcOoUvT4ZzzsCA/UtvII40sIVMLHirsi7TsKvkEoB/0d6CwLccqnfzSZy96BcL815SdgMbgb2pIWPjTqSqQk+XDfoLspqESBEqaAvAZCEWa6vYmp6n5xZ9j2OHNXTrn7O73rqsAnyUulvNDteuhy3OpqZAV8mxTErJiW8d+qKhN1rtVFLYOjIzoXMlp06nkCNFbzs6OXjgWbCYEp10tQcdRJB0LAp0Bp0TaVW9QSorIdk/I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AEC3D222CE72646B875AEFF22DC050F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608aa1a6-1c11-467c-db58-08d70adadf60
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 17:19:06.2759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1180
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTE3IGF0IDA5OjU1IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
SGkgVHJvbmQtDQo+IA0KPiA+IE9uIEp1bCAxNiwgMjAxOSwgYXQgNDowMSBQTSwgVHJvbmQgTXlr
bGVidXN0IDx0cm9uZG15QGdtYWlsLmNvbT4NCj4gPiB3cm90ZToNCj4gPiANCj4gPiBBZGQgYSBw
ZXItdHJhbnNwb3J0IG1heGltdW0gbGltaXQgaW4gdGhlIHNvY2tldCBjYXNlLCBhbmQgYWRkDQo+
ID4gaGVscGVycyB0byBhbGxvdyB0aGUgTkZTdjQgY29kZSB0byBkaXNjb3ZlciB0aGF0IGxpbWl0
Lg0KPiANCj4gRm9yIFJETUEsIHRoZSBudW1iZXIgb2YgY3JlZGl0cyBpcyBwZXJtaXR0ZWQgdG8g
Y2hhbmdlIGR1cmluZyB0aGUNCj4gbGlmZQ0KPiBvZiB0aGUgY29ubmVjdGlvbiwgc28gdGhpcyBp
cyBub3QgYSBmaXhlZCBsaW1pdCBmb3Igc3VjaCB0cmFuc3BvcnRzLg0KDQpUaGlzIGlzIGRlZmlu
aW5nIGEgbWF4aW11bSB2YWx1ZSwgd2hpY2ggaXMgdXNlZCBmb3IgYmFja2NoYW5uZWwgc2Vzc2lv
bg0Kc2xvdCBuZWdvdGlhdGlvbi4NCg0KPiANCj4gQW5kLCBBRkFJQ1QsIGl0J3Mgbm90IG5lY2Vz
c2FyeSB0byBrbm93IHRoZSB0cmFuc3BvcnQncyBsaW1pdC4gVGhlDQo+IGxlc3NlciBvZiB0aGUg
TkZTIGJhY2tjaGFubmVsIGFuZCBSUEMvUkRNQSByZXZlcnNlIGNyZWRpdCBsaW1pdCB3aWxsDQo+
IGJlIHVzZWQuDQoNClRoZSBzZXJ2ZXIgbmVlZHMgdG8ga25vdyBob3cgbWFueSByZXF1ZXN0cyBp
dCBjYW4gc2VuZCBpbiBwYXJhbGxlbCBvbg0KdGhlIGJhY2sgY2hhbm5lbC4gSWYgaXQgc2VuZHMg
dG9vIG1hbnksIHdoaWNoIGl0IGNhbiBhbmQgd2lsbCBkbyBvbg0KVENQLCB0aGVuIHdlIGN1cnJl
bnRseSBicmVhayB0aGUgY29ubmVjdGlvbiwgYW5kIHNvIGNhbGxiYWNrcyBlbmQgdXANCmJlaW5n
IGRyb3BwZWQgb3IgbWlzc2VkIGFsdG9nZXRoZXIuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
