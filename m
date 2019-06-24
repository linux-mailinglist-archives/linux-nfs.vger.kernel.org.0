Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E3851F45
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2019 01:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfFXXvJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jun 2019 19:51:09 -0400
Received: from mail-eopbgr720117.outbound.protection.outlook.com ([40.107.72.117]:61312
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727699AbfFXXvJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 24 Jun 2019 19:51:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=pQvEwFB6P3Xq4uBWRWAIV+kMjXeDPo96Z0xWYtEnhCbucREdC+2ToiQvN3DNCMjo8TTVH35ZY4r0wQYmI6D15Ur+4XM2DCtgJR7txAG61B1m2iL9VaivP25aispnlC4OLXzuCyQvs4pEvOZp1YckwYxlbIu026qgNeBnSJhk6aw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AER0NeljWzEHMWFFXQMi1VSsadyic9YuOPB4AqWdMRg=;
 b=r9YkErPraRbdKQ/NZ0qRvnjSsvtXZwyBY6jNYvmPaRFSMg1fMy5nmpD5XHqSQj0HSq9iHDeVJfDUsZERKDs3geKQbv5chWQuuRsJT6h+DrliMp7kETBtib9Fso3lJR/3ht+IzfAFW5fltZEX/zRDi5wRmQlQs/+8jvifkxR5bU8=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AER0NeljWzEHMWFFXQMi1VSsadyic9YuOPB4AqWdMRg=;
 b=KieTnIsDU84GRhQrWiFkx6UP3u6+nYqN/C+muZx7TbfEYbIUvFSGQ+Bnha9F9X2xZFf32u31IKH/n+3EfN3Rqtnz6Du0piFcCYDaZafZqua5Llc6xqE4/GSfDejXEFQdqchvvgWtvTdd2lpj3SfNjUM9fOjV3T/23YPXjnLsbXM=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1595.namprd13.prod.outlook.com (10.175.110.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.5; Mon, 24 Jun 2019 23:51:02 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::8c58:2c23:dcba:94ee%7]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 23:51:02 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: Fix up calculation of client message length
Thread-Topic: [PATCH] SUNRPC: Fix up calculation of client message length
Thread-Index: AQHVKuMPBGOfrI50kUiEjOHQWpFEPqareZMA
Date:   Mon, 24 Jun 2019 23:51:02 +0000
Message-ID: <540d70a9d7eb98b7ee09834f940527b80f9ff966.camel@hammerspace.com>
References: <20190624231544.1021-1-trond.myklebust@hammerspace.com>
In-Reply-To: <20190624231544.1021-1-trond.myklebust@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a057c05c-47cb-442a-1525-08d6f8fed0e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1595;
x-ms-traffictypediagnostic: DM5PR13MB1595:
x-microsoft-antispam-prvs: <DM5PR13MB159527DDE7F8DDFE1AD2CD15B8E00@DM5PR13MB1595.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39830400003)(136003)(366004)(189003)(199004)(476003)(25786009)(6916009)(86362001)(4326008)(14444005)(6512007)(2616005)(8936002)(81166006)(118296001)(8676002)(81156014)(11346002)(446003)(68736007)(486006)(53936002)(71190400001)(71200400001)(6246003)(256004)(6486002)(3846002)(14454004)(6436002)(6116002)(5640700003)(478600001)(26005)(186003)(2501003)(6506007)(102836004)(316002)(64756008)(4744005)(2351001)(36756003)(66066001)(5660300002)(15650500001)(7736002)(2906002)(76176011)(305945005)(99286004)(76116006)(229853002)(66556008)(66446008)(73956011)(66946007)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1595;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: axUA023SgeMkYY9pj+uLo8RtKYjym+PqZ7deSanHMdNdsug7k78RRiwPXhwZc/d/Dor6iDZtVrm6DXArY4Xb8CN4514MSY9gXkYfPQFErq3fLeeoiLWBIgR/9w1DQWV/en8QUOOFrVKuEz3ez8X+nadfmdApa0HydIIaqKny8Ja3iVYqJHW/d935a1DXWzzQaX+T3yskJXvwMS4TLgXMxCEkp2b0+JYbWun6USc5QIxo9zzVnYKd8JxIHreMzuRqcyss9Vzwf6bzUkV1SS4H16stZYhJnl5fETBNkfkhasO9vsJSM8/KPV8tNRUs+jA/PwUNxgoTG1N4XP8yUab5GHTuh39efjPZxqAPROOnztnkfAERoCB4dyng3cMZQlFCur3Rr4ZkWentA4JaR/6C7pkPBa2yzT3LNQ1Mk3bXsVI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B503AD21A7D3741BCAD18A5B37E0C74@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a057c05c-47cb-442a-1525-08d6f8fed0e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 23:51:02.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1595
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgQW5uYSwNCg0KT24gTW9uLCAyMDE5LTA2LTI0IGF0IDE5OjE1IC0wNDAwLCBUcm9uZCBNeWts
ZWJ1c3Qgd3JvdGU6DQo+IEluIHRoZSBjYXNlIHdoZXJlIGEgcmVjb3JkIG1hcmtlciB3YXMgdXNl
ZCwgeHNfc2VuZHBhZ2VzKCkgbmVlZHMNCj4gdG8gcmV0dXJuIHRoZSBsZW5ndGggb2YgdGhlIHBh
eWxvYWQgKyByZWNvcmQgbWFya2VyIHNvIHRoYXQgd2UNCj4gb3BlcmF0ZSBjb3JyZWN0bHkgaW4g
dGhlIGNhc2Ugb2YgYSBwYXJ0aWFsIHRyYW5zbWlzc2lvbi4NCj4gV2hlbiB0aGUgY2FsbGVycyBj
aGVjayByZXR1cm4gdmFsdWUsIHRoZXkgdGhlcmVmb3JlIG5lZWQgdG8NCj4gdGFrZSBpbnRvIGFj
Y291bnQgdGhlIHJlY29yZCBtYXJrZXIgbGVuZ3RoLg0KPiANCj4gRml4ZXM6IDA2YjVmYzNhZDk0
ZSAoIk1lcmdlIHRhZyAnbmZzLXJkbWEtZm9yLTUuMS0xJy4uLiIpDQo+IENjOiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnICMgNS4xKw0KPiBTaWduZWQtb2ZmLWJ5OiBUcm9uZCBNeWtsZWJ1c3QgPHRy
b25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20+DQo+IA0KDQpUaGlzIHBhdGNoIGZpeGVzIGFu
IGlzc3VlIHdoaWNoIGlzIGNhdXNpbmcgdGhlIE5GUyBzZXJ2ZXIgdG8gY2xvc2UgdGhlDQpUQ1Ag
Y29ubmVjdGlvbiBldmVyeSBmZXcgbW9tZW50cyBkdWUgdG8gaW5jb3JyZWN0bHkgZm9ybWF0dGVk
IFJQQw0KbWVzc2FnZXMuIEl0IGlzIGFsc28gY2FwYWJsZSBvZiBjb3JydXB0aW5nIGRhdGEsIHNv
IHBsZWFzZSBhcHBseSBhcw0Kc29vbiBhcyBwb3NzaWJsZS4NCg0KQ2hlZXJzDQogIFRyb25kDQot
LSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJz
cGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
