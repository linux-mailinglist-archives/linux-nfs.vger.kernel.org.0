Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F8F1E6D47
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2020 23:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407568AbgE1VKH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 May 2020 17:10:07 -0400
Received: from mail-eopbgr700110.outbound.protection.outlook.com ([40.107.70.110]:59808
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407533AbgE1VKE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 28 May 2020 17:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOXdcv57FH5Bp1GEdIh60AvsH472ntnA1e05UAYdz806Wuo/2uDjyltVmAh5CNksw48AYD0B+0ZVbW+D4NlBy0JijfLr3HJ8VH79lUW+q7YbDRTP61WkMxDuM+LrI6ncAAOPEJxHdgIb/R8xg3EXesDTRtjuVRb/u+lO7U9ioSEXueQfAsT4lVvXhBV8C+Ghl9pdGUy7h7FUbLX7SF2EJm8CbC3u4NWb2PLwZ+a0GhvwABdJfpF1uoarzvQxnFKCqsnprSIMG2CTB57ZXm1ZOWnWW2yQvRJdI6bWI79cYLBUlAzvPVwk7F34jdkuSreDfuBb1u9i7J0D5r1EhST+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpH1n8anvqEJc8L1agfqQt84X+w0wKEM6mrTAVRhJuE=;
 b=nOdBiw+81CUlPOh0gohRAU8W8Tt4FrZ9i5CTJ/iyNj2R4Q86D6SSZVZiqFxEBQRUwntH9hYuRgyUAYaaZgmHEfths16LgvtjNbeG1+K4mCMCBl5QED4Xz6iMZpNRQecvv9C224S7hYHDBOTQWNpWJuhV2UcVXk9qrIcbBQoEWyqFi0OQwNPXfWzokNgMvPJiMG4gyv8QchNZmIE+T8AJ2cK2OGlrXqDOYmpSx4PqlBNuO3SDX3zwlN96c8gL3SxOHm8dHjJdS2O+Ebu/44PaFmzzc5HNWKw9z3Vac6aC7slY84Mwz0c8CsREk1HCFGW/0I3u5FXzEY0e1GUDOZ/NTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpH1n8anvqEJc8L1agfqQt84X+w0wKEM6mrTAVRhJuE=;
 b=dfKxeRXV4GgqlS7dRzsSfgaxp8DYwKJSChkc2Jy+mfXcPuHsVIgzQtDIwsCsdm4Ibo4B14GmwafG50Q3qT0E0FOTdD3uvvziDetYT8VsNfAnP3c1vJao49UiQXBSvbOkV8PlFrhZ6jgcSi9KRxOXRPcjIirq6Xu84JPgrLmQcL0=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3623.namprd13.prod.outlook.com (2603:10b6:610:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7; Thu, 28 May
 2020 21:10:00 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 21:10:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: How to handle revocation of locking state
Thread-Topic: How to handle revocation of locking state
Thread-Index: AQHWNTCSBj8lUsFTaUe5HR+XtfbiCqi9/k+A
Date:   Thu, 28 May 2020 21:10:00 +0000
Message-ID: <85234f9bde1c419e1a8d7e8a677e5d324325c56b.camel@hammerspace.com>
References: <CAN-5tyE-hr2Fd1dKt=DUrVh-FJXzgGx5zhWr17SSbM1LOZ-pGQ@mail.gmail.com>
In-Reply-To: <CAN-5tyE-hr2Fd1dKt=DUrVh-FJXzgGx5zhWr17SSbM1LOZ-pGQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42b82980-4d21-4210-67d0-08d8034b7bb3
x-ms-traffictypediagnostic: CH2PR13MB3623:
x-microsoft-antispam-prvs: <CH2PR13MB3623231CC580E0D287455002B88E0@CH2PR13MB3623.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3FHTK+6ysH2LRInblSvlcuLH1CWv82wKljelhPJb0Fl4Hg8Y1Ny5IaznUnYR8X0b6/kVPkfWrVHMJp+6hG/KQH1Hk2jzrR8DAY77ceGyO7gabq0EHAZCYnFiHgGLyV4gkUPngh0adUFTHfLCiK8dl9qt1zSyz0tgOOKin2FDi+XgV6XrX8AVMPL0eINuL0d99jd0Oluey1zqVnEV1O1wn4NNqKt/oRhS1Nf+lzeSxJeH39MFA+DAyFA5NIu7reQ84Aw//t25YUFfUTVY1YKX0MQobpxbeoqJLfOZkSS1XxdX5bNRI9OmYgkONmVPMSm/Li0WCTkzrm6eUC/LhNBxnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(376002)(346002)(39830400003)(396003)(186003)(2616005)(5660300002)(86362001)(478600001)(36756003)(26005)(110136005)(8676002)(6506007)(83380400001)(316002)(66946007)(6486002)(76116006)(8936002)(64756008)(6512007)(71200400001)(66476007)(2906002)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rJbtyCJvrqV6VEOynh6nvqIg2IH+kAJiTIpynTnrwsLBPPfgMqtf8/Pr4xF9kUuI2Zu9Fsi2qKO5TPCGfqiji8BGNd97uXsVqce+ow9+Y17jIG/MPm3tdDo2vaeMOpDwQ808A70db7CBE9zuRDXnbY2I825v8cMGSV9NyjwkOkoJS21wIc83sYlC1h8Y7SFwEsI+/g1U8c384l36m+PT8Wx22n/cO/snK9TeA+nX4HPd5wUOfqbP1LCv8Z7EQ6Qbwxr6co3CKYax/3/7B65G6J8k+kDWJQ8CYr0e2PjJHf+cEWvMAWcN34vUjhMNZJ/hw/v18uglDMfVolKY5qiSOSkIHqyAFPsCY2VJIRszHMx/8TzNy9+APVpQ3ZOqFtd9ZFQlRt5waOl8c6TQveD1Lqefy9LaGlvwoVPOI5xOIZRMXYu8l8SFNqurSccnW51Qg1mX/7a1H7PfE/DLdNvzBMELoNPErP4fkCO46NIqyBw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F78E6939C95AE140A46C5397EF4ECC5C@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b82980-4d21-4210-67d0-08d8034b7bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 21:10:00.4491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2R8yQBScE//FJ574TzZXuHqkv2QSQ5Xv/JYI3P84ed0FTBzF1W9Q4TgVHm7OA8suSb6lhhlHHeJhy8AWDuWLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3623
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgT2xnYSwNCg0KT24gVGh1LCAyMDIwLTA1LTI4IGF0IDE2OjQyIC0wNDAwLCBPbGdhIEtvcm5p
ZXZza2FpYSB3cm90ZToNCj4gSGkgZm9sa3MsDQo+IA0KPiBMb29raW5nIGZvciByZWNvbW1lbmRh
dGlvbiBvbiB3aGF0IHRoZSBjbGllbnQgaXMgc3VwcG9zZSB0byBiZSBkb2luZw0KPiBpbiB0aGUg
Zm9sbG93aW5nIHNpdHVhdGlvbi4gQ2xpZW50IG9wZW5zIGEgZmlsZSBhbmQgaGFzIGEgYnl0ZS1y
YW5nZQ0KPiBsb2NrIHdoaWNoIHJldHVybmVkIGEgbG9ja2luZyBzdGF0ZS4gQ2xpZW50IGlzIGFj
cXVpcmluZyBhbm90aGVyIGJ5dGUNCj4gcmFuZ2UgbG9jay4gSXQgdXNlcyB0aGUgcmV0dXJuZWQg
bG9ja2luZyBzdGF0ZWQgZm9yIHRoZSAybmQgbG9jay4NCj4gU2VydmVyIHJldHVybnMgQURNSU5f
UkVWT0tFRC4NCj4gDQo+IEN1cnJlbnRseSB0aGUgY2xpZW50IGdvZXMgaW50byBhbiBpbmZpbml0
ZSBsb29wIG9mIGp1c3QgcmVzZW5kaW5nIHRoZQ0KPiBzYW1lIExPQ0sgb3BlcmF0aW9uIHdpdGgN
Cj4gdGhlIHNhbWUgbG9ja2luZyBzdGF0ZWlkLg0KPiANCj4gSXMgdGhpcyBhIHJlY292ZXJhYmxl
IHNpdHVhdGlvbj8gVGhlIGZhY3QgdGhhdCB0aGUgbG9jayBzdGF0ZSB3YXMNCj4gcmV2b2tlZCwg
c2hvdWxkIGl0IGJlIGFuIGF1dG9tYXRpYyBFSU8gc2luY2UgcHJldmlvdXMgbG9jayBpcyBsb3N0
DQo+IChzbw0KPiB3aHkgYm90aGVyIGdvaW5nIGZvcndhcmQpPyBPciBzaG91bGQgdGhlIGNsaWVu
dCByZXRyeSB0aGUgbG9jayBidXQNCj4gc2VuZCBpdCB3aXRoIHRoZSBvcGVuIHN0YXRlaWQ/DQo+
IA0KPiBUaGFuayB5b3UuDQoNCkkgdGhpbmsgdGhlIHJpZ2h0IGJlaGF2aW91ciBzaG91bGQgYmUg
dG8ganVzdCBjYWxsDQpuZnNfaW5vZGVfZmluZF9zdGF0ZV9hbmRfcmVjb3ZlcigpLiBJbiBwcmlu
Y2lwbGUgdGhhdCB3aWxsIGVuZCB1cA0KZWl0aGVyIHJlY292ZXJpbmcgdGhlIGxvY2sgKGlmIHRo
ZSB1c2VyIHNldCB0aGUgbmZzLnJlY292ZXJfbG9zdF9sb2Nrcw0Ka2VybmVsIHBhcmFtZXRlciB0
byAndHJ1ZScpIG9yIG1hcmtpbmcgaXQgYXMgYSBsb3N0IGxvY2ssIHVzaW5nDQpORlNfTE9DS19M
T1NULg0KDQpDaGVlcnMNCiAgVHJvbmQNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMg
Y2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3Bh
Y2UuY29tDQoNCg0K
