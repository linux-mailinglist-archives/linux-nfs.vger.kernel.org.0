Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5689715B691
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Feb 2020 02:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgBMBUX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Feb 2020 20:20:23 -0500
Received: from mail-co1nam11on2118.outbound.protection.outlook.com ([40.107.220.118]:62399
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729285AbgBMBUX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Feb 2020 20:20:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvAhEuKrvRKtEgKIyWsZ31qMr2DR4sv38PuxaN9MqFslcLz6RkFs+EWYylxF6aSSafFfJNNfHBcnXUyfltsk56VaJV+M+Mj+JX5hz53YZ18oFpgbMvoqn2iijYjP8ZjzNGr/9IILd1HhRCsMo+bBDU7qiuZi5xREQTUNZ9GR7jSxHkFXB23fEr/MuiGt3GmDsMPsxciukpkDZSgElMCoH+CQsNgoqUwKCIpt14upVzRtW6JEtdcJHPx9z3S7OE893G/F3lJYgZPO5KRnz2oHHrUUQBX2gJ/OUcB5Q6j1jrJeok1m3QXczec3YWRKa45mK64KsYDU0vQxFzUqfwRBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v9/LMGk1FVhVqiWy9dqiPjqGU8J8BVEYs0MlWZs8dk=;
 b=YCRy9tWWi/dsYomOsDXMdYo10ScuoAnHi1/khwfo9wbEO74HPQMGN/6ze9IP8UZNslF0buqkmdfhvq5niQH0g1z51pLF3g8p0rOAa7SjaZE/9rq4ucZzrIRqufw20xFsn3v5qvHnf0w6kGOx79sNe9s+5uFtFaNaDb+ZSgu15UR2u/J7Idg0sUQv7QVBVn1hl1ixQiy2yRgW8eBrK0D1bXXElHRHlxr42dBKlD4vqEwGrIOCax7lnjnMm1AxEnWsPkkCpn/+ZpAyJrPcMZRIvj3B3QJF1ETsliOa47ocsBH+S6N7BWHOpxKc/FCbyqAF69Ub7ALrQNidPEc86YBGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v9/LMGk1FVhVqiWy9dqiPjqGU8J8BVEYs0MlWZs8dk=;
 b=MnJAI2RCkacLTCLcAF39kbwC9MM1hb+iT2dXQVwJVkcXXoqe91M/k/c+eSZNMM1F1ebyqUQALcyc+xffNaxiB6DeHdWh1+Ki9brbdSS+UGrUO7jE4MUYQ3mcIN5uDMRlKiXFR8EZLd7OTiGdUTVRUkXKAFgmwdodswJTz9YV2A8=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1916.namprd13.prod.outlook.com (10.174.184.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.19; Thu, 13 Feb 2020 01:20:19 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 01:20:18 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSv4.1 make cachethis=no for writes
Thread-Topic: [PATCH 1/1] NFSv4.1 make cachethis=no for writes
Thread-Index: AQHV4fRHVsJ+k0cOdk+k1i7+jS/KCKgYU5eA
Date:   Thu, 13 Feb 2020 01:20:18 +0000
Message-ID: <bc76215b9d72ebb6c9571f27c7ba79fbaa753c6a.camel@hammerspace.com>
References: <20200212223212.14638-1-olga.kornievskaia@gmail.com>
In-Reply-To: <20200212223212.14638-1-olga.kornievskaia@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7d0a9f5-469e-4364-3518-08d7b022e398
x-ms-traffictypediagnostic: DM5PR1301MB1916:
x-microsoft-antispam-prvs: <DM5PR1301MB1916DAA498015358B7E3553AB81A0@DM5PR1301MB1916.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(396003)(366004)(346002)(376002)(189003)(199004)(478600001)(71200400001)(2616005)(81166006)(8676002)(6506007)(26005)(8936002)(81156014)(5660300002)(86362001)(66446008)(64756008)(66556008)(66476007)(186003)(76116006)(91956017)(4326008)(66946007)(2906002)(6512007)(110136005)(36756003)(6486002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1916;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiaMO2+J7OMzaJlRK+h+7hsUvHsanO4bX/Wikqy7cXLplPJUKHPOkEIlEi5Zq2K5hZwwUNFnnPMZa/asiwYHTTmaB8Q1c1CCFaf4+6CXly7DoFY6DtTLmv4jn8s7Fh4KbgYRwg6VZitDe3rhDVSQpWyMecyk3LsoBqvPFncOezB83bNhs3NpuoqY2HXnlBNkpZzpLP7Xk3R34JNUQbeaJP2gZO0CWer5IBUWp2groziEqe6oORmmmqoLB0gPuzJaABFTV9r+a9991/7AQuJAExZrzfiYvbwaWVeSnMUyhKdmshIkFOskVMztVFGK6yQ5M/dH2Px2G5hQaYI7qKTYf8t43PVr8NuFA+hvC3AlnPv/DUFbDFDQBPnSwje5eDSOwHtwNGKkCQLP8xeOVwp8nrmOsmtJGoKUPKfymCNj9iDDjWFWU7ASd6vcJN43jXtk
x-ms-exchange-antispam-messagedata: uSDzPOhlg8EhKvA/2TNZLzY2cRl1DhjI5u7avdUmsj5NgjjdY/llZvL4wYw5LMPUpcgicwqix+6zENQIV7HV5fbwNbiPLw4F1zuEea9vvz+lrpq6PyDvHUVW6YH9mf9gDHtL+woN+VizogRLxhFzVA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBFB09A1127B6042A26A7629DC862590@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d0a9f5-469e-4364-3518-08d7b022e398
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 01:20:18.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/ENEg0sgkINbdp3tpqJa7Jt4C3u1PNaTx5HcHb3WlNsQDPiRTYzYJpkZbI8ZgnYrMDcbzvCEGOQ7FiGCXOh1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1916
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTEyIGF0IDE3OjMyIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gRnJvbTogT2xnYSBLb3JuaWV2c2thaWEgPGtvbGdhQG5ldGFwcC5jb20+DQo+IA0KPiBU
dXJuaW5nIGNhY2hpbmcgb2ZmIGZvciB3cml0ZXMgb24gdGhlIHNlcnZlciBzaG91bGQgaW1wcm92
ZQ0KPiBwZXJmb3JtYW5jZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZ2EgS29ybmlldnNrYWlh
IDxrb2xnYUBuZXRhcHAuY29tPg0KPiAtLS0NCj4gIGZzL25mcy9uZnM0cHJvYy5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZnMvbmZzL25mczRwcm9jLmMgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBpbmRl
eCA3ZjU4MDJiLi4yMmRjYTQ5IDEwMDY0NA0KPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYw0KPiAr
KysgYi9mcy9uZnMvbmZzNHByb2MuYw0KPiBAQCAtNTMzNiw3ICs1MzM2LDcgQEAgc3RhdGljIHZv
aWQgbmZzNF9wcm9jX3dyaXRlX3NldHVwKHN0cnVjdA0KPiBuZnNfcGdpb19oZWFkZXIgKmhkciwN
Cj4gIAloZHItPnRpbWVzdGFtcCAgID0gamlmZmllczsNCj4gIA0KPiAgCW1zZy0+cnBjX3Byb2Mg
PSAmbmZzNF9wcm9jZWR1cmVzW05GU1BST0M0X0NMTlRfV1JJVEVdOw0KPiAtCW5mczRfaW5pdF9z
ZXF1ZW5jZSgmaGRyLT5hcmdzLnNlcV9hcmdzLCAmaGRyLT5yZXMuc2VxX3JlcywgMSwNCj4gMCk7
DQo+ICsJbmZzNF9pbml0X3NlcXVlbmNlKCZoZHItPmFyZ3Muc2VxX2FyZ3MsICZoZHItPnJlcy5z
ZXFfcmVzLCAwLA0KPiAwKTsNCj4gIAluZnM0X3N0YXRlX3Byb3RlY3Rfd3JpdGUoc2VydmVyLT5u
ZnNfY2xpZW50LCBjbG50LCBtc2csIGhkcik7DQo+ICB9DQo+ICANCg0KUmV2aWV3ZWQtYnk6IFRy
b25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbT4NCg0KDQpBbm5h
LCB3ZSBjYW4gcHJvYmFibHkgYWxzbyBhZGQgYQ0KDQpGaXhlczogZmJhODNmMzQxMTlhICgiTkZT
OiBQYXNzICJwcml2aWxlZ2VkIiB2YWx1ZSB0byBuZnM0X2luaXRfc2VxdWVuY2UoKSIpDQoNCi0t
IA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
