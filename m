Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9772544B
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 17:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfEUPqH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 11:46:07 -0400
Received: from mail-eopbgr750105.outbound.protection.outlook.com ([40.107.75.105]:53487
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728091AbfEUPqH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 May 2019 11:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zD/Y4Ws1kOchjfrwMhmLj93mq22EJSIcGv2oU5W3Vhw=;
 b=H7xDVoIyZB7FlPN/5ivoix3YzzLvpqJc59sxmCdqvWhtRxaV1V7WA27yI8Zn3TdaUnZ8sRrjgv7by1/6NspMU0SkY1GXXAFTLIUsLdAacvWy23QOXYAGHgeUhlOapiJd4z41HrwTKv2URcKkKzwIC2Jmc5N5M1s4sA/5lq69M5Y=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1132.namprd13.prod.outlook.com (10.168.117.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Tue, 21 May 2019 15:46:04 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::502c:c076:fdd4:9633%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 15:46:04 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "adp@prgmr.com" <adp@prgmr.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: User process NFS write hang followed by automount hang requiring
 reboot
Thread-Topic: User process NFS write hang followed by automount hang requiring
 reboot
Thread-Index: AQHVD10Mj9cHITmmLUmLNk72TvyfOqZ1udsA
Date:   Tue, 21 May 2019 15:46:03 +0000
Message-ID: <c10084e889df77fc2b6a6c9a04b232faae3a80bc.camel@hammerspace.com>
References: <20190520223324.GL4158@turtle.email>
In-Reply-To: <20190520223324.GL4158@turtle.email>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a4c95b7-77e3-47de-fbe6-08d6de036e9f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR13MB1132;
x-ms-traffictypediagnostic: DM5PR13MB1132:
x-microsoft-antispam-prvs: <DM5PR13MB1132386A851A5975A3783B87B8070@DM5PR13MB1132.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39840400004)(396003)(136003)(189003)(199004)(446003)(99286004)(6436002)(118296001)(316002)(81156014)(8936002)(26005)(186003)(81166006)(102836004)(6512007)(8676002)(68736007)(256004)(14444005)(76176011)(2906002)(86362001)(6506007)(66066001)(2501003)(5660300002)(478600001)(14454004)(71190400001)(71200400001)(229853002)(6246003)(110136005)(11346002)(305945005)(25786009)(7736002)(53936002)(6486002)(2616005)(91956017)(6116002)(476003)(66946007)(76116006)(486006)(73956011)(66556008)(64756008)(66476007)(36756003)(3846002)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1132;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VLzZUBuxAB91+ZIEJaDFqlYTZY6n8d4x9cTL1gFeNMGlwQIh8wcX+3OVVwvF1j+enQtOShygEfndJDjepGSKLuHoG+g4sT9z6sdNW2hkDfiUqpiZNVo3pJCFSH4ZTQlV9gmFQhupPqz6wep6PGufY6DpEG4gNTNjHYQM+5fsarZPSxwhpG4t6YEDQwvyDg2br5zH0fA9fC/vDqXwtL1F7dcjRhOP2s/4ShkZ/nTzDnchLMLsRM4tqX0N7yDJDRCspRKJPvuhBRdUpWdXVpBQ9BIqkPZ3aNbgKMi/frY0acWddqXkkrklZ4HF32r4LANUOQPr/01IzM4gbH8nfFWTbcVI2pFmNinHcOv4L/QRV7l7bOj+J7QbKFwgHrPzYNYkp5as3ZKnNFzAG9L1tUolapqk7F1W7QRpt/GdbMVXMpw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F78A9BED59ED584CB0236D3A7C5641B6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4c95b7-77e3-47de-fbe6-08d6de036e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 15:46:04.0179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trondmy@hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1132
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTIwIGF0IDE2OjMzIC0wNjAwLCBBbGFuIFBvc3Qgd3JvdGU6DQo+IEkn
bSB3b3JraW5nIG9uIGEgY29tcHV0ZSBjbHVzdGVyIHdpdGggYXBwcm94aW1hdGVseSAzMDAgTkZT
DQo+IGNsaWVudCBtYWNoaW5lcyBydW5uaW5nIExpbnV4IDQuMTkuMjhbMV0uICBUaGVzZSBtYWNo
aW5lcyBhY2NlcHQNCj4gdXNlciBzdWJtaXR0ZWQgam9icyB3aGljaCBhY2Nlc3MgZXhwb3J0ZWQg
ZmlsZXN5c3RlbXMgZnJvbQ0KPiBhcHByb3hpbWF0ZWx5IGEgZG96ZW4gTkZTIHNlcnZlcnMgbW9z
dGx5IHJ1bm5pbmcgTGludXggNC40LjAgYnV0DQo+IGEgY291cGxlIHJ1bm5pbmcgNC4xOS4yOC4g
IEluIGFsbCBjYXNlcyB3ZSBtb3VudCB3aXRoIG5mc3ZlcnM9NC4NCj4gDQo+IEZyb20gdGltZSB0
byB0aW1lIG9uZSBvZiB0aGVzZSB1c2VyIHN1Ym1pdHRlZCBqb2JzIGhhbmdzIGluDQo+IHVuaW50
ZXJydXB0aWJsZSBzbGVlcCAoRCBzdGF0ZSkgd2hpbGUgcGVyZm9ybWluZyBhIHdyaXRlIHRvIG9u
ZSBvcg0KPiBtb3JlIG9mIHRoZXNlIE5GUyBzZXJ2ZXJzLCBhbmQgbmV2ZXIgY29tcGxldGUuICBP
bmNlIHRoaXMgaGFwcGVucw0KPiBjYWxscyB0byBzeW5jIHdpbGwgdGhlbXNlbHZlcyBoYW5nIGlu
IHVuaW50ZXJydXB0aWJsZSBzbGVlcC4NCj4gRXZlbnR1YWxseSB0aGUgc2FtZSB0aGluZyBoYXBw
ZW5zIHRvIGF1dG9tb3VudC9tb3VudC5uZnMgYW5kIGJ5DQo+IHRoYXQgcG9pbnQgdGhlIGhvc3Qg
aXMgY29tcGxldGVseSBpcnJlY292ZXJhYmxlLg0KPiANCj4gVGhlIHByb2JsZW0gaXMgbW9yZSBj
b21tb24gb24gb3VyIE5GUyBjbGllbnRzIHdoZW4gdGhleeKAmXJlDQo+IGNvbW11bmljYXRpbmcg
d2l0aCBhbiBORlMgc2VydmVyIHJ1bm5pbmcgNC4xOS4yOCwgYnV0IGlzIG5vdA0KPiB1bmlxdWUg
dG8gdGhhdCBORlMgc2VydmVyIGtlcm5lbCB2ZXJzaW9uLg0KPiANCj4gQSByZXByZXNlbnRhdGl2
ZSBzYW1wbGUgb2Ygc3RhY2sgdHJhY2VzIGZyb20gaHVuZyB1c2VyLXN1Ym1pdHRlZA0KPiBwcm9j
ZXNzZXMgKGpvYnMpLiAgVGhlIGZpcnN0IGhlcmUgaXMgcXVpdGUgYSBsb3QgbW9yZSBjb21tb24g
dGhhbg0KPiB0aGUgbGF0ZXIgdHdvOg0KPiANCj4gICAgICQgc3VkbyBjYXQgL3Byb2MvMTk3NTIw
L3N0YWNrDQo+ICAgICBbPDA+XSBpb19zY2hlZHVsZSsweDEyLzB4NDANCj4gICAgIFs8MD5dIG5m
c19sb2NrX2FuZF9qb2luX3JlcXVlc3RzKzB4MzA5LzB4NGMwIFtuZnNdDQo+ICAgICBbPDA+XSBu
ZnNfdXBkYXRlcGFnZSsweDJhMi8weDhiMCBbbmZzXQ0KPiAgICAgWzwwPl0gbmZzX3dyaXRlX2Vu
ZCsweDYzLzB4NGMwIFtuZnNdDQo+ICAgICBbPDA+XSBnZW5lcmljX3BlcmZvcm1fd3JpdGUrMHgx
MzgvMHgxYjANCj4gICAgIFs8MD5dIG5mc19maWxlX3dyaXRlKzB4ZGMvMHgyMDAgW25mc10NCj4g
ICAgIFs8MD5dIG5ld19zeW5jX3dyaXRlKzB4ZmIvMHgxNjANCj4gICAgIFs8MD5dIHZmc193cml0
ZSsweGE1LzB4MWEwDQo+ICAgICBbPDA+XSBrc3lzX3dyaXRlKzB4NGYvMHhiMA0KPiAgICAgWzww
Pl0gZG9fc3lzY2FsbF82NCsweDUzLzB4MTAwDQo+ICAgICBbPDA+XSBlbnRyeV9TWVNDQUxMXzY0
X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5DQo+ICAgICBbPDA+XSAweGZmZmZmZmZmZmZmZmZmZmYN
Cj4gDQoNCkhhdmUgeW91IHRyaWVkIHVwZ3JhZGluZyB0byA0LjE5LjQ0PyBUaGVyZSBpcyBhIGZp
eCB0aGF0IHdlbnQgaW4gbm90DQp0b28gbG9uZyBhZ28gdGhhdCBkZWFscyB3aXRoIGEgcmVxdWVz
dCBsZWFrIHRoYXQgY2FuIGNhdXNlIHN0YWNrIHRyYWNlcw0KbGlrZSB0aGUgYWJvdmUgdGhhdCB3
YWl0IGZvcmV2ZXIuDQoNCkJ5IHRoZSB3YXksIHRoZSBhYm92ZSBzdGFjayB0cmFjZSB3aXRoICJu
ZnNfbG9ja19hbmRfam9pbl9yZXF1ZXN0cyINCnVzdWFsbHkgbWVhbnMgdGhhdCB5b3UgYXJlIHVz
aW5nIGEgdmVyeSBzbWFsbCByc2l6ZSBvciB3c2l6ZSAobGVzcyB0aGFuDQo0aykuIElzIHRoYXQg
dGhlIGNhc2U/IElmIHNvLCB5b3UgbWlnaHQgd2FudCB0byBsb29rIGludG8ganVzdA0KaW5jcmVh
c2luZyB0aGUgSS9PIHNpemUuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xp
ZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2Uu
Y29tDQoNCg0K
