Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3A027B329
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Sep 2020 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI1R1U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Sep 2020 13:27:20 -0400
Received: from mail-bn8nam11on2119.outbound.protection.outlook.com ([40.107.236.119]:54241
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbgI1R1U (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 28 Sep 2020 13:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSOm2vZLzQMck3FGzXITrSE/DybxYZYf3GSatYfSwnswvq3q9u/pjXpvTd8KqU8PkRSy8r5QFE9H/P3+H0lHqxTBNwoZALQZ3/S05J4hKXbRdlnE3ml71uOmVuoONjS5VVgmJz5e4BiGvg/QSvoAG4f4N0MqMk37rZjWNNxJu5o0BGQK0nKQ/+DcU/cGNACChjN1SoFafOayqDKh4qhdnv8Sm5LNGEyUeiWMqhvVjkQ0PJ7hZ4slR0WKnc91tP1itrqsFZMVVuqsJVAzZFa/d8XL7Hy1Hq+2pwIwzlIQEPcax8Mex/yEAC4AiKZSe+2ExR1oAWk89WVPzHaWv+Nr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obKvPQYQV8QBhYqKJosYIDVefS+y2r3SOzFNSH5f2rg=;
 b=LfcpF1dreKgoFaC4dXN9EGOZIrDSZuC0tLJjkBotTzRrmRSTzwJJDfvfbgnFP1O3m/L3Jx7pvIp/0JtUb77JYxhRWewlmdri7IoWO7CzLJfFT9moFm6wrUDmsjWs1NOW1s7lfTUFMySu5gMGVMmKBIi2uDJkNaN1BZPbuvU3wR4Wy0jIcxJQMbHUa16KEHSvw2EvDOVyQ7oNGmwEMCkWd76rMshEXwv44aN0T8uhibpz0ZfgfSj07ao1h3wgGjNKXhBdYkTQYIECObJVndzW3x1jA+KsJnU7u6Tx4loNH81P5XxBDrjM/OSQLwmgMFItKX4qOKDkHIquUaPiTdDJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obKvPQYQV8QBhYqKJosYIDVefS+y2r3SOzFNSH5f2rg=;
 b=Upap9GP3d41yX6RMxbKfQePR963Sbo55HU9f3O+Z6AV+2v/BXruN1J6VkSJwE6J1C+C/jRmauozRpWJezwU9gB1llpfn2w9yE2CWqz+3T/uzhR3EnxjMvrqo1t05N65co4Bkd9gkEF/aHVbxxqsxQrsVn/iU5KFmxx3xr4EAcds=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3696.namprd13.prod.outlook.com (2603:10b6:208:1e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.18; Mon, 28 Sep
 2020 17:27:15 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%6]) with mapi id 15.20.3433.030; Mon, 28 Sep 2020
 17:27:15 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHWlbyb7Abp3rPZ80efHk7uJAcVYw==
Date:   Mon, 28 Sep 2020 17:27:14 +0000
Message-ID: <93a6b36e466a389330945f8c515ad7fd86e8b714.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76459e92-d25e-4eb5-6cef-08d863d3be15
x-ms-traffictypediagnostic: MN2PR13MB3696:
x-microsoft-antispam-prvs: <MN2PR13MB3696E67DB78161A5A87264FBB8350@MN2PR13MB3696.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9eOdc02iu42a2Q6Vl4HFOZOk1MJMlsd+Ec9ZHseLErmm3R7ziycdu5loLi+kIfHs4DiY4MKu7GYrQ4yi/vBniPl3wUQXs9x5A0CbUhQp77dkfPTYO7jqo9MkBNtfYw3WjKbCoJn+tjssXQmQfaCyyiBrzbC+0+8BRs14zNMHsMiTKoMFtaTZtrqx03pgvsAiL1C4/XbODhFyt3YKRlgJv/zFz+JicgblhPDuF/+wTrxsDUwtMiegror1SpSKpCZxAm1B3HDkjwHfBEF8O7qLSK4mx8iCZzQw/YTM0ILzduUI7ce1KUsnsyqL43K1ENnTDe9QCgFd+qyrOwrBJaJB0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(346002)(376002)(136003)(366004)(478600001)(26005)(54906003)(36756003)(2616005)(6506007)(186003)(316002)(8936002)(2906002)(6916009)(6512007)(8676002)(86362001)(66476007)(64756008)(66556008)(66446008)(83380400001)(5660300002)(71200400001)(6486002)(76116006)(91956017)(4326008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: rBxeWNAeOyn85CFINKQjCyZqCW536WTskLOTLUDEavzvzky2WuWVue5e+cySMiAkRNXZ7PBADPpADo+xNifsfOxBQV4WgGE4qP8uIaGIw1Gfnr5cjEnrJPcyJ7/hBy0N1YTPNhua98nj30rKIgshjI9KFMgRyd9M7MicEBVQeFKhVvI7sRG/D8zAm2GDEINk4/bMKP/NrHMNWjI3DgST0r3eutWAoE85c56ZV51vo+2NPZX5Pr5xGHyZfqHFQeqcZVRb4o0lrOSIbSL+HbynKCaC6fRRyhogF88mnQAEp3c1q2vi7g/tx7nrMzFbjIsnZkjNwHY49OLXRaDc4x2xdTYwvEbkUbsEo55qEbBaBx/ltthmggFaRgIwQptcwUsTwh2a9Ep324gh2EDrJulyaevh1lJCmkpS10mE3hUOOuqKI4ZqKEZJYXT9rZ8NnjdxEmHZrccNNR9Upvm7nI7J3gJuPxSGL/azvLn32YrB2uzBflNla1JSDVOpn3B1f0FhXC5lLL303Dj9UJRhi2vXfME7EVIboMdTmkfbgsMzWWa61OnEXReo+iMvu8werzGgqBb6pbG9VcKUvAasBPh7LDH2e/QBhYbr7O0dfdsxnSX8/o6qCZoZHEk/EWcWcYLnMebIUCpz+TdLVddj/WS9pQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C970E3A53B69824683840492C9890F7F@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76459e92-d25e-4eb5-6cef-08d863d3be15
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 17:27:14.9128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDqHGUWznzM/9ip1llAQD21YmehYMf8ALNNK1wnVchueVZaOjYDbW3nDrU3hl3XAyJZyNWoeuo1khuUlGpO9Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3696
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgODU2ZGViODY2
ZDE2ZTI5YmQ2NTk1MmUwMjg5MDY2ZjYwNzhhZjc3MzoNCg0KICBMaW51eCA1LjktcmM1ICgyMDIw
LTA5LTEzIDE2OjA2OjAwIC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xp
bnV4LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuOS0zDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byBiOWRmNDZkMDhhOGQwOThlYTIxMjRjYjllM2I4NDQ1OGE0NzRiNGQ0Og0KDQogIHBO
RlMvZmxleGZpbGVzOiBCZSBjb25zaXN0ZW50IGFib3V0IG1pcnJvciBpbmRleCB0eXBlcyAoMjAy
MC0wOS0xOCAwOToyNTozMyAtMDQwMCkNCg0KQ2hlZXJzLA0KICBUcm9uZA0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KTkZT
IGNsaWVudCBidWdmaXhlcyBmb3IgTGludXggNS45DQoNCkhpZ2hsaWdodHMgaW5jbHVkZToNCg0K
QnVnZml4ZXM6DQotIE5GU3Y0LjI6IGNvcHlfZmlsZV9yYW5nZSBuZWVkcyB0byBpbnZhbGlkYXRl
IGNhY2hlcyBvbiBzdWNjZXNzDQotIE5GU3Y0LjI6IEZpeCBzZWN1cml0eSBsYWJlbCBsZW5ndGgg
bm90IGJlaW5nIHJlc2V0DQotIHBORlMvZmxleGZpbGVzOiBFbnN1cmUgd2UgaW5pdGlhbGlzZSB0
aGUgbWlycm9yIGJzaXplcyBjb3JyZWN0bHkgb24gcmVhZA0KLSBwTkZTL2ZsZXhmaWxlczogRml4
IHNpZ25lZC91bnNpZ25lZCB0eXBlIGlzc3VlcyB3aXRoIG1pcnJvciBpbmRpY2VzDQoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCkplZmZyZXkgTWl0Y2hlbGwgKDEpOg0KICAgICAgbmZzOiBGaXggc2VjdXJpdHkgbGFiZWwg
bGVuZ3RoIG5vdCBiZWluZyByZXNldA0KDQpPbGdhIEtvcm5pZXZza2FpYSAoMSk6DQogICAgICBO
RlN2NC4yOiBmaXggY2xpZW50J3MgYXR0cmlidXRlIGNhY2hlIG1hbmFnZW1lbnQgZm9yIGNvcHlf
ZmlsZV9yYW5nZQ0KDQpUcm9uZCBNeWtsZWJ1c3QgKDIpOg0KICAgICAgcE5GUy9mbGV4ZmlsZXM6
IEVuc3VyZSB3ZSBpbml0aWFsaXNlIHRoZSBtaXJyb3IgYnNpemVzIGNvcnJlY3RseSBvbiByZWFk
DQogICAgICBwTkZTL2ZsZXhmaWxlczogQmUgY29uc2lzdGVudCBhYm91dCBtaXJyb3IgaW5kZXgg
dHlwZXMNCg0KIGZzL25mcy9kaXIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgKysr
DQogZnMvbmZzL2ZsZXhmaWxlbGF5b3V0L2ZsZXhmaWxlbGF5b3V0LmMgfCA0MyArKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQogZnMvbmZzL25mczQycHJvYy5jICAgICAgICAgICAg
ICAgICAgICAgfCAxMCArKysrKysrLQ0KIGluY2x1ZGUvbGludXgvbmZzX3hkci5oICAgICAgICAg
ICAgICAgIHwgIDQgKystLQ0KIDQgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMjQg
ZGVsZXRpb25zKC0pDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==
