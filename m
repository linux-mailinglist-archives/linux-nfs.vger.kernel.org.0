Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A5D49BC
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2019 23:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfJKVOX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Oct 2019 17:14:23 -0400
Received: from mail-eopbgr730079.outbound.protection.outlook.com ([40.107.73.79]:65089
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726843AbfJKVOX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Oct 2019 17:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOmW7heM5X3YqQm/8iY1rKzpgDi4InCITU/KRDYem8cMUrP1rjWCQwuFeE+h80RrHpFWLdKUCjP1IAtVTov6yyYdNirdfS0xstQ6s8YDnshF7tYmJ/iH7OYHkhhRrbgpnSURmnUg3Tt4m46nb0ngMVQZ/orrEQ2cBRdnB4b/k5SJY995nW+Y4VPOHa7IAKesryniI3QTfOwiR5Bgya5HgFUKA59qwyNc/Px0h+lzu9ub4wWCgHP2OxwSSsq2NnowL7qzeOG2QExd7Pv6jsfJK209UoMHkixsN/rMDSPEuIXMz/IhZGbUx5Lnor7KHhyw/jPYhpOWtJAD20RvZggVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGlzSgByONXJmbZGEP2oZ0mk1/EJvkCrrkJAhsxx2pc=;
 b=DXajNayeNlMC+dZJvwr/Al5oTyKupH3ycBgx/XYZVHBgxPK/llCczVw86rGywo2IYhbS07oDsQ4wNNxXBCxKz3DTFCqGVl3yIhGk0CDMq5sJRvh3v1/Ps2bd6qUYvhIaJm9JQ9hEsGZUaROsPsv3BbHsameJbSfvPyy7qxUB0jYqIlOUaUwSdwDTmI8bWFxv8BJPBOnNm1VGqkVPp3vXdl7w8CK9YmCodFOm0thpeJaCLBfMDLUAScFKe48xINTYwVZupfLTYiFlSdNP0T+F3u9ZUX4DMggc5rLbk2VQQK9iwPqaQQ6T19JU204JhwWZHqHEphsMrib7YT2xTPFrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGlzSgByONXJmbZGEP2oZ0mk1/EJvkCrrkJAhsxx2pc=;
 b=V+JNz4dLx1NpSTvcceyhMIf113/LPxZ7kamKpPiFyTiGxE97JO4kRPnrpEhp4BRiXTVQ7cOJkDatsdF4Fbe0msLH9gvACs66BEEkGs5sTHdSuc8FtY52evcFGSiRE8+us6IfaZ+qRsm8gm18IUpCrO6bBwh8QasLt7can7q4mZo=
Received: from BYAPR06MB6054.namprd06.prod.outlook.com (20.178.51.220) by
 BYAPR06MB5894.namprd06.prod.outlook.com (20.179.157.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 21:14:20 +0000
Received: from BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::50dc:9dc2:1445:556e]) by BYAPR06MB6054.namprd06.prod.outlook.com
 ([fe80::50dc:9dc2:1445:556e%4]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 21:14:20 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS Client bugfixes for 5.4-rc3
Thread-Topic: [GIT PULL] Please pull NFS Client bugfixes for 5.4-rc3
Thread-Index: AQHVgHjZ3ta4Edi/VESse/hIgBwzog==
Date:   Fri, 11 Oct 2019 21:14:20 +0000
Message-ID: <5e755211af46cd98099145223b8d4929542a8141.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.32.74.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26961586-8edd-4b05-29a5-08d74e8ffba3
x-ms-traffictypediagnostic: BYAPR06MB5894:
x-microsoft-antispam-prvs: <BYAPR06MB58949C56DA577991D4693D1DF8970@BYAPR06MB5894.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:403;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(66066001)(2351001)(256004)(36756003)(6506007)(26005)(186003)(1730700003)(8936002)(102836004)(25786009)(14444005)(8676002)(478600001)(2501003)(99286004)(14454004)(71190400001)(71200400001)(81156014)(118296001)(6916009)(81166006)(58126008)(54906003)(305945005)(5660300002)(316002)(66946007)(64756008)(66446008)(66476007)(66556008)(7736002)(76116006)(91956017)(86362001)(4326008)(6116002)(6436002)(2616005)(486006)(476003)(3846002)(4001150100001)(5640700003)(6486002)(6512007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR06MB5894;H:BYAPR06MB6054.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /SLnsTiQK0s+cmYPd+k/uoS4oCfjACSZW8qeYRD/Giwk0gviYyKdP/rUuc0n77Y6ZE7PPU1rpM+huGMQXL6tylYjYW5UT28SnWo1Z83VxQTryefNEWVy1HAmhjdF2dOb8JjVc1U9ANS7c808anMEQ95ojXb1CQafXYoVOMoin2a3gVcFD2xfsFs4iLDs9A4MtTshrZ1FjBfTGMtk2S+53qgpQz9+DbxePs5rvMeu7/B84gUQN+DQKaUaVoX2hkDMBzUzPHP6vqlCNxXN44Iyd1auia0ajTPr5tXcE9gbxgTOfA2rvsHpxFxRuhvqMoIyyZKldxQGBgbgtvBRziX9AfKET3rVX1dtby4dSgasZ1ORh9kON4CRZAUUdWyoLTTrUH9UAQz1DoQzYoRABlvutqNGK60fDGfwQbliNbb57og=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <28DDB7C0CDB79546999D730E09FD4711@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26961586-8edd-4b05-29a5-08d74e8ffba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 21:14:20.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WHCxKZc8Qwgr9ufKULcZSko8o9omcHpUGHXQe48Hf14MWWxCpz7Lr4Cj7IDLvvgq8zJP+bpomMVUOydjsL8ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5894
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgNTRlY2I4Zjcw
MjhjNWViM2Q3NDBiYjgyYjBmMWQ5MGYyZGY2M2M1YzoNCg0KICBMaW51eCA1LjQtcmMxICgyMDE5
LTA5LTMwIDEwOjM1OjQwIC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy9hbm5hL2xpbnV4
LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuNC0yDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byBhZjg0NTM3ZGJkMWIzOTUwNWQxZjNkODAyMzAyOWI0YTU5NjY2NTEzOg0KDQogIFNVTlJQ
QzogZml4IHJhY2UgdG8gc2tfZXJyIGFmdGVyIHhzX2Vycm9yX3JlcG9ydCAoMjAxOS0xMC0xMCAx
NjoxNDoyOCAtMDQwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KU3RhYmxlIGJ1Z2ZpeGVzOg0KLSBGaXggT19ESVJF
Q1QgYWNjb3VudGluZyBvZiBudW1iZXIgb2YgYnl0ZXMgcmVhZC93cml0dGVuICMgdjQuMSsNCg0K
T3RoZXIgZml4ZXM6DQotIEZpeCBuZnNpLT5ucmVxdWVzdHMgY291bnQgZXJyb3Igb24gbmZzX2lu
b2RlX3JlbW92ZV9yZXF1ZXN0KCkNCi0gUmVtb3ZlIHJlZHVuZGFudCBtaXJyb3IgdHJhY2tpbmcg
aW4gT19ESVJFQ1QNCi0gRml4IGxlYWsgb2YgY2xwLT5jbF9hY2NlcHRvciBzdHJpbmcNCi0gRml4
IHJhY2UgdG8gc2tfZXJyIGFmdGVyIHhzX2Vycm9yX3JlcG9ydA0KDQpJIGhvcGUgeW91IGhhdmUg
YSBnb29kIHdlZWtlbmQhDQpBbm5hDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpCZW5qYW1pbiBDb2RkaW5ndG9uICgxKToN
CiAgICAgIFNVTlJQQzogZml4IHJhY2UgdG8gc2tfZXJyIGFmdGVyIHhzX2Vycm9yX3JlcG9ydA0K
DQpDaHVjayBMZXZlciAoMSk6DQogICAgICBORlN2NDogRml4IGxlYWsgb2YgY2xwLT5jbF9hY2Nl
cHRvciBzdHJpbmcNCg0KVHJvbmQgTXlrbGVidXN0ICgyKToNCiAgICAgIE5GUzogRml4IE9fRElS
RUNUIGFjY291bnRpbmcgb2YgbnVtYmVyIG9mIGJ5dGVzIHJlYWQvd3JpdHRlbg0KICAgICAgTkZT
OiBSZW1vdmUgcmVkdW5kYW50IG1pcnJvciB0cmFja2luZyBpbiBPX0RJUkVDVA0KDQpaaGFuZ1hp
YW94dSAoMSk6DQogICAgICBuZnM6IEZpeCBuZnNpLT5ucmVxdWVzdHMgY291bnQgZXJyb3Igb24g
bmZzX2lub2RlX3JlbW92ZV9yZXF1ZXN0DQoNCiBmcy9uZnMvZGlyZWN0LmMgICAgICAgICAgICAg
ICAgIHwgMTA2ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBmcy9u
ZnMvbmZzNHByb2MuYyAgICAgICAgICAgICAgIHwgICAxICsNCiBmcy9uZnMvd3JpdGUuYyAgICAg
ICAgICAgICAgICAgIHwgICA1ICstDQogaW5jbHVkZS9saW51eC9zdW5ycGMveHBydHNvY2suaCB8
ICAgMSArDQogbmV0L3N1bnJwYy94cHJ0c29jay5jICAgICAgICAgICB8ICAxNyArKystLS0tDQog
NSBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCA4MSBkZWxldGlvbnMoLSkNCg==
