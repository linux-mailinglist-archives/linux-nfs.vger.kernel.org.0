Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED73B5D90C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2019 02:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfGCAd3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Jul 2019 20:33:29 -0400
Received: from mail-eopbgr780085.outbound.protection.outlook.com ([40.107.78.85]:27713
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727127AbfGCAd2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 2 Jul 2019 20:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InuIGeQYX4OnOaooMnLaUU/WhOkkmHfo3tQCUiCKsiU=;
 b=jgrflCAW0Wj15A5wjbH7lOjkEOSc6imQCRO1SOylIjYjWjg5BYiGwxFZIBQDFpfrA3hmFjk2aQ+i8e2yD71Ie5ebY6hYfCfl+7MiZXpOs4AMbewiErVCgSduextKou+i8kFTwPpHF79z8nUczwoJt3rWPUW/qonQWzYhTma2Lic=
Received: from CY4PR06MB3479.namprd06.prod.outlook.com (10.175.117.23) by
 CY4PR06MB2887.namprd06.prod.outlook.com (10.175.117.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.16; Tue, 2 Jul 2019 20:35:25 +0000
Received: from CY4PR06MB3479.namprd06.prod.outlook.com
 ([fe80::4910:c5de:ec74:995]) by CY4PR06MB3479.namprd06.prod.outlook.com
 ([fe80::4910:c5de:ec74:995%2]) with mapi id 15.20.2032.018; Tue, 2 Jul 2019
 20:35:25 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "trondmy@hammerspace.com" <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: [GIT PULL] Please pull NFSoRDMA updates for Linux 5.3
Thread-Topic: [GIT PULL] Please pull NFSoRDMA updates for Linux 5.3
Thread-Index: AQHVMRWtUitNYWZf40a4s7CQZrEEUw==
Date:   Tue, 2 Jul 2019 20:35:25 +0000
Message-ID: <b2cabbe76eecc8db717cccd84067d78f8c3a7d0f.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [23.28.75.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c336e4f-fba2-49a9-27e2-08d6ff2cd051
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CY4PR06MB2887;
X-MS-TrafficTypeDiagnostic: CY4PR06MB2887:|CY4PR06MB2887:|CY4PR06MB2887:|CY4PR06MB2887:
x-microsoft-antispam-prvs: <CY4PR06MB28876FAC6DCDA5F9A581D806F8F80@CY4PR06MB2887.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(189003)(199004)(486006)(316002)(86362001)(476003)(2616005)(4326008)(6916009)(186003)(26005)(3846002)(6116002)(14454004)(2351001)(25786009)(118296001)(2501003)(14444005)(256004)(478600001)(58126008)(54906003)(72206003)(99286004)(6486002)(6436002)(5660300002)(1730700003)(8936002)(5640700003)(6512007)(66066001)(2906002)(71200400001)(68736007)(15650500001)(66476007)(64756008)(91956017)(76116006)(73956011)(71190400001)(66946007)(66446008)(66556008)(53936002)(305945005)(36756003)(7736002)(8676002)(102836004)(81156014)(81166006)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR06MB2887;H:CY4PR06MB3479.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4DX/sxawhNEgNWZTIGddz6RgYzUTw7+ACTsIjG9BKt3AjQ4N9TE0WRwvjmQfP/9+bRJ7ZGM2ZrQ3Mg/E0hjsfjp32+e+O3m0N0ePMe30ZQaN/K21WxKKQcmaFMyTA37wzmbKpCfWLMkwIfS9S2TqvKVyOlYotnsxMqqHnWFeyjY85J/PITYwCzQSvH2BsWyTP3EcqD/cgErbZCKhZvZCLVS9tsyJZsXmgAbBcBjopFhfnt8OIw6VCcLIc72gi7ktubw5WOsb5xuIvlrQfRQfSvV8BIQWOYmUeDO6zdN92u0Kv/FqNqNGVsPmyDAsVp6Vo7oEli5HRthoIaUzPVcbqP5BlCltshH7AyKNrRmZ7hCSPD+kmN3IUmMXevzE7VdjyX1Diwb7OEytpEnDoR8IC+xMR9IPypqo4LUJLeMOEo0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD2783FBF8DD8B4BB90922EFB979A863@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c336e4f-fba2-49a9-27e2-08d6ff2cd051
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 20:35:25.7316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjschuma@netapp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB2887
X-OriginatorOrg: netapp.com
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgVHJvbmQsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQNCjllMGJhYmYy
YzA2YzczY2RhMmMwY2QzN2ExNjUzZDgyM2FkYjQwZWM6DQoNCiAgTGludXggNS4yLXJjNSAoMjAx
OS0wNi0xNiAwODo0OTo0NSAtMTAwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9z
aXRvcnkgYXQ6DQoNCiAgZ2l0Oi8vZ2l0LmxpbnV4LW5mcy5vcmcvcHJvamVjdHMvYW5uYS9saW51
eC1uZnMuZ2l0IHRhZ3MvbmZzLXJkbWEtDQpmb3ItNS4zLTENCg0KZm9yIHlvdSB0byBmZXRjaCBj
aGFuZ2VzIHVwIHRvDQoxYThmMWVkM2ViMWFjMmZkZGMxZDJjNzUyOTRkYjA4YWNlODhjMWNiOg0K
DQogIE5GUzogUmVjb3JkIHRhc2ssIGNsaWVudCBJRCwgYW5kIFhJRCBpbiB4ZHJfc3RhdHVzIHRy
YWNlIHBvaW50cw0KKDIwMTktMDctMDIgMTY6Mjk6MjIgLTA0MDApDQoNClRoYW5rcywNCkFubmEN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KQ2h1Y2sgTGV2ZXIgKDE5KToNCiAgICAgIHhwcnRyZG1hOiBGaXggYSBCVUcg
d2hlbiB0cmFjaW5nIGlzIGVuYWJsZWQgd2l0aCBORlN2NC4xIG9uIFJETUENCiAgICAgIHhwcnRy
ZG1hOiBGaXggdXNlLWFmdGVyLWZyZWUgaW4gcnBjcmRtYV9wb3N0X3JlY3ZzDQogICAgICB4cHJ0
cmRtYTogUmVwbGFjZSB1c2Ugb2YgeGRyX3N0cmVhbV9wb3MgaW4gcnBjcmRtYV9tYXJzaGFsX3Jl
cQ0KICAgICAgeHBydHJkbWE6IEZpeCBvY2Nhc2lvbmFsIHRyYW5zcG9ydCBkZWFkbG9jaw0KICAg
ICAgeHBydHJkbWE6IFJlbW92ZSB0aGUgUlBDUkRNQV9SRVFfRl9QRU5ESU5HIGZsYWcNCiAgICAg
IHhwcnRyZG1hOiBSZW1vdmUgZnJfc3RhdGUNCiAgICAgIHhwcnRyZG1hOiBBZGQgbWVjaGFuaXNt
IHRvIHBsYWNlIE1ScyBiYWNrIG9uIHRoZSBmcmVlIGxpc3QNCiAgICAgIHhwcnRyZG1hOiBSZWR1
Y2UgY29udGV4dCBzd2l0Y2hpbmcgZHVlIHRvIExvY2FsIEludmFsaWRhdGlvbg0KICAgICAgeHBy
dHJkbWE6IFdha2UgUlBDcyBkaXJlY3RseSBpbiBycGNyZG1hX3djX3NlbmQgcGF0aA0KICAgICAg
eHBydHJkbWE6IFNpbXBsaWZ5IHJwY3JkbWFfcmVwX2NyZWF0ZQ0KICAgICAgeHBydHJkbWE6IFN0
cmVhbWxpbmUgcnBjcmRtYV9wb3N0X3JlY3ZzDQogICAgICB4cHJ0cmRtYTogUmVmYWN0b3IgY2h1
bmsgZW5jb2RpbmcNCiAgICAgIHhwcnRyZG1hOiBSZW1vdmUgcnBjcmRtYV9yZXE6OnJsX2J1ZmZl
cg0KICAgICAgeHBydHJkbWE6IE1vZGVybml6ZSBvcHMtPmNvbm5lY3QNCiAgICAgIE5GUzQ6IEFk
ZCBhIHRyYWNlIGV2ZW50IHRvIHJlY29yZCBpbnZhbGlkIENCIHNlcXVlbmNlIElEcw0KICAgICAg
TkZTOiBGaXggc2hvd19uZnNfZXJyb3JzIG1hY3JvcyBhZ2Fpbg0KICAgICAgTkZTOiBEaXNwbGF5
IHN5bWJvbGljIHN0YXR1cyBjb2RlIG5hbWVzIGluIHRyYWNlIGxvZw0KICAgICAgTkZTOiBVcGRh
dGUgc3ltYm9saWMgZmxhZ3MgZGlzcGxheWVkIGJ5IHRyYWNlIGV2ZW50cw0KICAgICAgTkZTOiBS
ZWNvcmQgdGFzaywgY2xpZW50IElELCBhbmQgWElEIGluIHhkcl9zdGF0dXMgdHJhY2UgcG9pbnRz
DQoNCiBmcy9uZnMvY2FsbGJhY2tfcHJvYy5jICAgICAgICAgIHwgIDI4ICsrKysrKysrLS0tDQog
ZnMvbmZzL25mczJ4ZHIuYyAgICAgICAgICAgICAgICB8ICAgMiArLQ0KIGZzL25mcy9uZnMzeGRy
LmMgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiBmcy9uZnMvbmZzNHRyYWNlLmggICAgICAgICAg
ICAgIHwgMjA3DQorKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KLS0tLQ0KIGZzL25mcy9uZnM0eGRyLmMgICAgICAg
ICAgICAgICAgfCAgIDIgKy0NCiBmcy9uZnMvbmZzdHJhY2UuaCAgICAgICAgICAgICAgIHwgMjMz
DQorKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLQ0KLS0tLS0tLS0tLS0tLQ0KIGluY2x1ZGUvbGludXgvc3VucnBjL3hw
cnQuaCAgICAgfCAgIDMgKysNCiBpbmNsdWRlL3RyYWNlL2V2ZW50cy9ycGNyZG1hLmggIHwgIDkw
ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQotDQogbmV0L3N1bnJwYy9zY2hlZC5j
ICAgICAgICAgICAgICB8ICAgMSArDQogbmV0L3N1bnJwYy94cHJ0LmMgICAgICAgICAgICAgICB8
ICAzMiArKysrKysrKysrKysNCiBuZXQvc3VucnBjL3hwcnRyZG1hL2Zyd3Jfb3BzLmMgIHwgMzI3
DQorKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCiBuZXQvc3VucnBjL3hwcnRyZG1hL3JwY19yZG1hLmMgIHwgMTQ4ICsrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBuZXQvc3Vu
cnBjL3hwcnRyZG1hL3RyYW5zcG9ydC5jIHwgIDgzICsrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLQ0KIG5ldC9zdW5ycGMveHBydHJkbWEvdmVyYnMuYyAgICAgfCAxMTUgKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0NCi0tLS0tLS0tLS0NCiBuZXQvc3VucnBjL3hwcnRyZG1hL3hw
cnRfcmRtYS5oIHwgIDQ0ICsrKysrLS0tLS0tLS0tLS0NCiBuZXQvc3VucnBjL3hwcnRzb2NrLmMg
ICAgICAgICAgIHwgIDIzICstLS0tLS0tLQ0KIDE2IGZpbGVzIGNoYW5nZWQsIDgzNyBpbnNlcnRp
b25zKCspLCA1MDMgZGVsZXRpb25zKC0pDQo=
