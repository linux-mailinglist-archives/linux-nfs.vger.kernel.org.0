Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB53EC9F0
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2019 21:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfKAUxf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Nov 2019 16:53:35 -0400
Received: from mail-eopbgr800041.outbound.protection.outlook.com ([40.107.80.41]:22246
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfKAUxe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 1 Nov 2019 16:53:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+IB7/NFBl4v2joMg+KSUNvv3TChNeabbYFPp/KVT8Zc+kk7SWpignC9ZL6nkno8GwS/rDb1DsDfN+ZZlGfrcmCQntkuexeqqxBVWmxNtRix1kcnCK4y7XHqRgoZwNxZf6KoTVUNbTYVd+9lvBvhaRi4lg5eiJG0+YdM/6dDiyTO/KXA2K5f8EVPZvblR+0gRIQQuuIXrl7WO12ULcMtlp9IMt1cMcEu+n8iSkBMsJlNk8WMYo3pXyumAoXStLW85IlMd3LyIKCbqUttQlwQPUwvUcyW8DGpbmtQFer6ZB/c1/uyuYhdlrI9ej2LC0+GuM7iZN2fUM6o8mb8Y9+EOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz9DyTtu0JGheGZ2Z7mxwFrifhEDD6TACgvl9U6vBtQ=;
 b=TbpfoGW/fTzX11iGGqictGi1n2efncBMT6rBDuP3D9gK2tVYYSkZIHq9nGjxxHljdr0HVTpBFGfsEX9EsQIZZRwcOQdNAMzgTU96NW/+fiXg4J0b3hbBk3JbrLLW/WFuq2jNojf8R5hQL7TDLc7gHTRdHl/uyz3Sz0r8X/kh5udfjPmHVjsNKjTE03pV8Qn5zfLtVadFdsnZgLiy5f1RQZQGdc2O7l1ka2jJCrowTqlAbB/KKp/Ox0iEXYWso34ChQUPaq1RUpJRCuSputm9ItV9Qln61+2052UfHlL3fNgXIypIy2HGRFukJBUGyhVPJlJYbfuZYcV9YnxXoLSlmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lz9DyTtu0JGheGZ2Z7mxwFrifhEDD6TACgvl9U6vBtQ=;
 b=kPh67EDZj65kP1XxRu8Te3fIH+1Fe+E2HoagzLe030MjhAeVtYXeXPP4qubhX0En9/RyKx9uGwsb0DD1UKR8Q0d3FlkX62pBLArij5Oq6Y59sIfzpBLjxKK8mWw/Guw11ypwym/m0JQYwEPW4ZakKAXmvewhGO31GS4zKFTkEHo=
Received: from BYAPR06MB6054.namprd06.prod.outlook.com (20.178.51.220) by
 BYAPR06MB5349.namprd06.prod.outlook.com (20.178.52.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Fri, 1 Nov 2019 20:53:30 +0000
Received: from BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::918d:490e:90f0:61f8]) by BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::918d:490e:90f0:61f8%5]) with mapi id 15.20.2387.025; Fri, 1 Nov 2019
 20:53:30 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS Client Bugfixes for Linux 5.4-rc6
Thread-Topic: [GIT PULL] Please pull NFS Client Bugfixes for Linux 5.4-rc6
Thread-Index: AQHVkPZq1XQm9kO4Hka+IW6lkVoalg==
Date:   Fri, 1 Nov 2019 20:53:30 +0000
Message-ID: <2c39701ab77496cb78b4955aad532a2f18427465.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.42.68.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cf8578b-2637-46d6-d9ef-08d75f0d8d25
x-ms-traffictypediagnostic: BYAPR06MB5349:
x-microsoft-antispam-prvs: <BYAPR06MB5349708B60AC40F0A053B8F2F8620@BYAPR06MB5349.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:252;
x-forefront-prvs: 020877E0CB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(71190400001)(102836004)(54906003)(2351001)(86362001)(26005)(2501003)(476003)(6512007)(71200400001)(81156014)(8936002)(4001150100001)(81166006)(1730700003)(486006)(8676002)(5640700003)(6486002)(14454004)(6436002)(305945005)(6506007)(7736002)(66476007)(4326008)(58126008)(99286004)(66946007)(316002)(66446008)(64756008)(66556008)(25786009)(66066001)(6916009)(2616005)(5660300002)(36756003)(76116006)(186003)(14444005)(6116002)(118296001)(91956017)(3846002)(478600001)(256004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR06MB5349;H:BYAPR06MB6054.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9XeDLBcA6v5c9hk1V/VzuZ9UtzEIejJZ5hmyWsIr1L82ShTzz8MkOtiVpQVFqt48DOadVegnUNJt+oCrXkTRqhH/qG0amcLnWKZo9ADUnNpG9S8TMxpSHuuNKSiI6FREVNwoIKN1AmyB1qdgdhl3cj9pfJzx2kQPV44iwYNdTnef6nWigplkyDVBq4datxhiwpPZKPgVejZVSqvHPMmNwXJiqIBCB0P2chW/aWmZxHN85ZctjOxrguI4uN2HT2mvHJA2TYUtT0TIrPZMeIZ74R2+YLSzKcwFAQeFv0H2Db9z8tjtRGJQ3h3ohrPuWaBX1vZvEVniiAWRi1jJmj0uvv/5qvlD9En4S+bTo9mzkrKo61vjllKk5s+G0bN1ogqg5pLG3nbZsfjSwwppIYdtyLI4dUJNEREOopVXxuRttS0x33p07k+huT1L5mfbdSNJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F5D71A4A23DB24FA11CB08FE0D99CD3@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf8578b-2637-46d6-d9ef-08d75f0d8d25
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2019 20:53:30.1837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygNA+C+4HVWllXfSbnYtG5b26J8vdP74gD1C5JQfIQ+MR+IQo6nGrfOI0ZOQh1UkYJWT8ul/0JFgPoJl0y3faQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5349
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgOWU1ZWVmYmEz
ZDA5OGQ2NmRlZmExY2U1OWEzNGE0MWE5NmY0OTc3MToNCg0KICBNZXJnZSB0YWcgJ2Zvcl9saW51
cycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L21zdC92
aG9zdCAoMjAxOS0xMC0yOA0KMTI6NDc6MjIgKzAxMDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhl
IEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdDovL2dpdC5saW51eC1uZnMub3JnL3Byb2plY3Rz
L2FubmEvbGludXgtbmZzLmdpdCB0YWdzL25mcy1mb3ItNS40LTMNCg0KZm9yIHlvdSB0byBmZXRj
aCBjaGFuZ2VzIHVwIHRvIDc5Y2M1NTQyMmNlOTliZTU5NjRiZGUyMDhiYTg1NTcxNzQ3MjA4OTM6
DQoNCiAgTkZTOiBGaXggYW4gUkNVIGxvY2sgbGVhayBpbiBuZnM0X3JlZnJlc2hfZGVsZWdhdGlv
bl9zdGF0ZWlkKCkgKDIwMTktMTEtMDEgMTE6MDM6NTYgLTA0MDApDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRoaXMg
cGF0Y2ggc2V0IGNvbnRhaW5zIHR3byBkZWxlZ2F0aW9uIGZpeGVzICh3aXRoIHRoZSBSQ1UgbG9j
ayBsZWFrIGZpeCBtYXJrZWQNCmZvciBzdGFibGUpLCBhbmQgdGhyZWUgcGF0Y2hlcyB0byBmaXgg
ZGVzdHJveWluZyB0aGUgdGhlIHN1bnJwYyBiYWNrIGNoYW5uZWwuDQoNClRoYW5rcywNCkFubmEN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KDQpUcm9uZCBNeWtsZWJ1c3QgKDUpOg0KICAgICAgU1VOUlBDOiBUaGUgVENQ
IGJhY2sgY2hhbm5lbCBtdXN0bid0IGRpc2FwcGVhciB3aGlsZSByZXF1ZXN0cyBhcmUgb3V0c3Rh
bmRpbmcNCiAgICAgIFNVTlJQQzogVGhlIFJETUEgYmFjayBjaGFubmVsIG11c3RuJ3QgZGlzYXBw
ZWFyIHdoaWxlIHJlcXVlc3RzIGFyZSBvdXRzdGFuZGluZw0KICAgICAgU1VOUlBDOiBEZXN0cm95
IHRoZSBiYWNrIGNoYW5uZWwgd2hlbiB3ZSBkZXN0cm95IHRoZSBob3N0IHRyYW5zcG9ydA0KICAg
ICAgTkZTdjQ6IERvbid0IGFsbG93IGEgY2FjaGVkIG9wZW4gd2l0aCBhIHJldm9rZWQgZGVsZWdh
dGlvbg0KICAgICAgTkZTOiBGaXggYW4gUkNVIGxvY2sgbGVhayBpbiBuZnM0X3JlZnJlc2hfZGVs
ZWdhdGlvbl9zdGF0ZWlkKCkNCg0KIGZzL25mcy9kZWxlZ2F0aW9uLmMgICAgICAgICAgICAgICB8
IDEyICsrKysrKysrKysrLQ0KIGZzL25mcy9kZWxlZ2F0aW9uLmggICAgICAgICAgICAgICB8ICAx
ICsNCiBmcy9uZnMvbmZzNHByb2MuYyAgICAgICAgICAgICAgICAgfCAgNyArKy0tLS0tDQogaW5j
bHVkZS9saW51eC9zdW5ycGMvYmNfeHBydC5oICAgIHwgIDUgKysrKysNCiBuZXQvc3VucnBjL2Jh
Y2tjaGFubmVsX3Jxc3QuYyAgICAgfCAgNyArKysrLS0tDQogbmV0L3N1bnJwYy94cHJ0LmMgICAg
ICAgICAgICAgICAgIHwgIDUgKysrKysNCiBuZXQvc3VucnBjL3hwcnRyZG1hL2JhY2tjaGFubmVs
LmMgfCAgMiArKw0KIDcgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlv
bnMoLSkNCg==
