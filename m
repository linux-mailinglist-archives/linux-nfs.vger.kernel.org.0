Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34774199B46
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2020 18:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgCaQUs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Mar 2020 12:20:48 -0400
Received: from mail-dm6nam12on2115.outbound.protection.outlook.com ([40.107.243.115]:47594
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730011AbgCaQUs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Mar 2020 12:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5u5BQN1+9tQ0IICanc7WfEzZYjuBhIiAIyMUi0wLBtCEbM5NsaXdYh5ZWIUeg0WLHmaLagamcznE1L2QTI8uJnKs/jLhXPMAnPMu5Ac8DBR+PrrxPdkFgUNz1GqINjSiprtVgKyK95vqQI/bNVATW9CUgaXWxZjueB+EmHKSpQ9dUeIdz3MbQDDhn4RTtJNnoPBT4Tekh7DYmir2816pkYrneSUEdl79b6k/I0Pu6l/cuMjCeeCffb0pPL5fbY+bLIehdOPMqaO++CYXxjkLi9buJZAqPUPL3WB+ekRDAkXj48VFFI3BcLMUWt2gHy94LZWSUzYYynguJvDj/x1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/AO7MiRrIGZ3Kc4AHcErgphlQoWxmySKXD/cICOAM8=;
 b=LF3BGCgsUvTWWh4Xo/UFsHdDTsL2GaIPf0g/1yo19lq4YW+uhk+Etf+vbgtAtHdgiSh982xdygFFg6F2iUI6qEIX4BUlvSaArEQrRTl8sBPIf6soXzgmyXYmhHdxEoBuOIfcim3aqTbWmyFB7pemZB/F4uobViWDDTJtPe/mYB9pnZbkQUndMXgtGlZrdqHHnGuBVOq1RYSs/T+g7AFIadPt7siyD4VH/tEYC+HzuJg7hRX50+YCZ1xA4ptq8zuCo5kn3JSLe85KfFIGu+/NlyNCldaBNoCF90AF7klLhJGZdP795rn11yfqJhkYhTBXY7sqK5c8YkZCOWsg11Gj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/AO7MiRrIGZ3Kc4AHcErgphlQoWxmySKXD/cICOAM8=;
 b=NPx4jLatxLC3/SjT8Ks2lygbar1ysf/9QofnUKEBKGEn3XEy0Gx+0NSdRYeDUTeEJsVtuH/UnX4lMY0ytB/PNvju6jG+mK6ylFYMZ7SV/2xMs3GxdECtugazoEYS89lV2tpG8XhGrXLM0bT+v+TbbED0NuwW76DoDecpS1Lt87o=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3574.namprd13.prod.outlook.com (2603:10b6:610:23::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.13; Tue, 31 Mar
 2020 16:20:41 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::9570:c1b8:9eb3:1c36%7]) with mapi id 15.20.2878.012; Tue, 31 Mar 2020
 16:20:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "walteste@inf.ethz.ch" <walteste@inf.ethz.ch>
Subject: Re: [PATCH] Add regex plugin for nfsidmap
Thread-Topic: [PATCH] Add regex plugin for nfsidmap
Thread-Index: AQHWBz3V7u4++9DRMEK8lKZQQ2gXCahi4icA
Date:   Tue, 31 Mar 2020 16:20:41 +0000
Message-ID: <9ddd1ed60d57ea13a704b9f609c4dc3536043e66.camel@hammerspace.com>
References: <20200331090237.D56A4B7279@osaka.inf.ethz.ch>
In-Reply-To: <20200331090237.D56A4B7279@osaka.inf.ethz.ch>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29e11b34-0421-41c3-d70e-08d7d58f7513
x-ms-traffictypediagnostic: CH2PR13MB3574:
x-microsoft-antispam-prvs: <CH2PR13MB357420E7B294F65013A8AE73B8C80@CH2PR13MB3574.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(136003)(346002)(396003)(39830400003)(366004)(6486002)(66946007)(36756003)(66446008)(66476007)(5660300002)(91956017)(76116006)(66556008)(81156014)(81166006)(8676002)(64756008)(186003)(71200400001)(26005)(86362001)(8936002)(2906002)(478600001)(6506007)(2616005)(110136005)(6512007)(316002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qnw3TPjY6a20NBGm2V3An5OI/y8VJ1FlogcEOgmlLl8mz3ODkXuy1M+O+6U03FKN5lFNETWqmZacEmBWk+9xNQ+182JwXQ/MxoVTztPdMGV9g9z+e/HhvL1UIrAwyFOd+679+jhYScfs8Vn7AvCxfNB6Wc7E/rk2SqqJToxkDMnrrkDbJys978BNkq5gJ9+9RqH1E0j1L99yVWXEjHiWYGHhV0gX5KXQgvkA0RTqqmEX4eLo0c6pZcytlxktFseuWhoabcaLRpe7jMX6NilKyPtba28EIGlnfd+rk3vAgqEPIoHRiOSjQQs8mgTG/R08BV8JqeM2mFpA5Hz2bIIJiDSX3LbyFtUxGFnZdU5ynehedCukHZWzUIkQAXJLRAcTdxcC/xemSSEXl6+CWm6O8QNMJzFH/cyer3Sh/rHJFuC6KDr07uoOkhdeo3nvc4CH
x-ms-exchange-antispam-messagedata: +1XEqtIR+txeqyDlA2JkA6ioTXuyHZnd5Pj22I/cLNZEEuKOch7RsnjJQfELdEbpPNHiaBTW9omk6FtT+ZYA8WbIu95n1/F//eEa8EI3oZx0V/MsgsQH1YWCyysUg90pslZ54D+mF9f0asXc1uVWTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C85CF114DE497946AFD7E33FE163E174@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e11b34-0421-41c3-d70e-08d7d58f7513
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 16:20:41.5569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZmdslJViFb1JKmFKb4wmgQfNTl8dYVN+pOPE2i/C5h3pDuaHSqkPaCL+x3HfUp/ZusJ1TEUqURTYSilKj6h0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3574
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTMxIGF0IDExOjAyICswMjAwLCBTdGVmYW4gV2FsdGVyIHdyb3RlOg0K
PiBUaGUgcGF0Y2ggYmVsb3cgYWRkcyBhIG5ldyBuZnNpZG1hcCBwbHVnaW4gdGhhdCB1c2VzIHJl
Z2V4IHRvIGV4dHJhY3QNCj4gaWRzIGZyb20gTkZTdjQgbmFtZXMuIE5hbWVzIGFyZSBjcmVhdGVk
IGZyb20gaWRzIGJ5IHByZS0gYW5kDQo+IGFwcGVuZGluZw0KPiBzdGF0aWMgc3RyaW5ncy4gSXQg
d29ya3Mgd2l0aCBib3RoIGlkbWFwZCBvbiBzZXJ2ZXJzIGFuZCBuZnNpZG1hcCBvbg0KPiBjbGll
bnRzLg0KPiANCj4gVGhpcyBwbHVnaW4gaXMgZXNwZWNpYWxseSB1c2VmdWwgaW4gZW52aXJvbm1l
bnRzIHdpdGggQWN0aXZlDQo+IERpcmVjdG9yeQ0KPiB3aGVyZSBkaXN0cmlidXRlZCBORlMgc2Vy
dmVycyB1c2UgYSBtaXggb2Ygc2hvcnQgKHVuYW1lKSBhbmQgbG9uZw0KPiAoZG9tYWluXHVuYW1l
KSBuYW1lcy4gQ29tYmluaW5nIGl0IHdpdGggdGhlIG5zc3dpdGNoIHBsdWdpbiBjb3ZlcnMNCj4g
Ym90aA0KPiB2YXJpYW50cy4NCj4gDQo+IEN1cnJlbnRseSB0aGlzIHBsdWdpbiBoYXMgaXRzIG93
biBnaXQgcHJvamVjdCBvbiBnaXRodWIgYnV0IEkgdGhpbmsNCj4gaXQgY291bGQgYmUgaGVscGZ1
bCBpZiBpdCB3b3VsZCBiZSBpbmNvcnBvcmF0ZWQgaW4gdGhlIG1haW4gbmZzLXV0aWxzDQo+IHBs
dWdpbiBzZXQuDQoNCkhtbS4uLiBXaHkgd291bGRuJ3QgeW91IHJhdGhlciB3YW50IHRvIHVzZSBz
b21ldGhpbmcgbGlrZSB0aGUNCnNzc19ycGNpZG1hcGQgcGx1Z2luIGluIHRoZSBBRCBlbnZpcm9u
bWVudD8gTWFudWFsIGVkaXRpbmcgb2YgdGhlDQp1c2VybmFtZSBzb3VuZHMgZXJyb3IgcHJvbmUs
IHBhcnRpY3VsYXJseSBpZiB5b3VyIGRvbWFpbiBpcyBwYXJ0IG9mIGFuDQpBRCBmb3Jlc3QuDQoN
CkknbSBub3Qgc2F5aW5nIHRoYXQgdGhpcyBwbHVnaW4gY291bGRuJ3QgYmUgdXNlZnVsIGluIG90
aGVyDQpjaXJjdW1zdGFuY2VzIChwbGVhc2UgZWxhYm9yYXRlKSwganVzdCB0aGF0IHRoZSBBRCB1
c2UgY2FzZSBzb3VuZHMgYQ0KbGl0dGxlIGlmZnkuLi4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QN
CkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVz
dEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
