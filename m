Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD91A5BB5
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Apr 2020 02:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgDLA7G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Apr 2020 20:59:06 -0400
Received: from mail-dm6nam10on2137.outbound.protection.outlook.com ([40.107.93.137]:62516
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbgDLA7G (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 11 Apr 2020 20:59:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CH5rsXUMVBB8ofr/ZqIXVA5/Wfh00P5iTxAbBLQZIUPgOXD726N79nnRVo0ocSaXW2HK/y4Y4hDvKoZnZKQpJqFcQXG8DNYsCHcT2kS1dJphLwk6lem6ZtyCCG1Ea1XrEv82L2+4Tr+66RiMrZdV9MEwuZGCNiHR864cKDGLd6yrRHz1FZdpOgVfSGIZFvwAS3Y+HAacHo2EI/EdvSAm17KCAhKyX9BiVBc0hAMwSgLnmZVlF3b1PiOoatZ2EprLJ85ipdA0ZtP2Rp7LioH9jbE4u45lEKggiu5Ubg7TDPwMkVCrzTrt8c1cW7MOr+Yyxe37TaFcBWUxl3KVQiBQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8YmJ+voSMHr8jNGzhzA4s9e4PH7Meefd4tw9qN6+qc=;
 b=TcYhCP6iPrQd+nXS6l3dvwqOM1HGEjPq7F39ku1U/YWiwKEMJxXvGiHI/ApC8h+b6I7Aspo4w8iQ6xWtpO6FrcIp7H0eXzZN6IUM5nnIzPBX1k7vDrPJqov8vgrLtUlLRhTcXbOXBnBHAdBFLDdbP6mPhgMYxblBRlHAncDqvjdF0rH5KrfrqCI5cRcRJMhhreAQ1VQZRmilA0C++rLtvAGlkJCHbBbaytDS9H1Dax+VOAvyfWzGuIQZc/Z9CFwl6BF26fGzhyLXZ9WqNW1UDC5p1gIXFVKYQgDNkmQ2tvGoOw2R/xLp7v8Ls0rEad8fXW6fXT5tqS7USP5uS2ZW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8YmJ+voSMHr8jNGzhzA4s9e4PH7Meefd4tw9qN6+qc=;
 b=dnescYHEgc7BCvb0M/9gee4MK2veyupppx5RlCYZmf/Uzm/V1xnY3Psle6wqovbIleZHM3cUI15mUvO2/eUFPm/I8shdy/UBukux85TCnMAJ8Q3XUQXrP8AxgMg19On1u5kp+c0joZM2lBa86smYTHFrLXt9AS7rZ8kbIUyNNq8=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3318.namprd13.prod.outlook.com (2603:10b6:610:21::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.14; Sun, 12 Apr
 2020 00:59:01 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.2921.023; Sun, 12 Apr 2020
 00:59:00 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS bugfix for Linux 5.7
Thread-Topic: [GIT PULL] Please pull NFS bugfix for Linux 5.7
Thread-Index: AQHWEGWNajeB60ueMU2zAOFvCYS7VA==
Date:   Sun, 12 Apr 2020 00:59:00 +0000
Message-ID: <b1fd16bb3607f03e60f4e18c0d8d046451f8882d.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68407d59-89d7-4d73-2eaf-08d7de7cb03d
x-ms-traffictypediagnostic: CH2PR13MB3318:
x-microsoft-antispam-prvs: <CH2PR13MB3318F282C0AE30570D35D06DB8DC0@CH2PR13MB3318.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:506;
x-forefront-prvs: 0371762FE7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(39830400003)(366004)(376002)(346002)(5660300002)(8936002)(66476007)(4744005)(66946007)(91956017)(66446008)(6486002)(4326008)(81156014)(64756008)(76116006)(66556008)(6512007)(8676002)(71200400001)(186003)(26005)(54906003)(6916009)(478600001)(36756003)(2616005)(6506007)(316002)(86362001)(2906002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XSWdfmbml/74xMl89gvtMmWQQJVgApmsWJRmq9dTmdYJgtzcE8Dx9kcT0jwRFoXxoVkwZ/7DKdjlxqRekALgS2Y45rWPbizA4W/ota14fWbwCExGlszxus5FFxPQuVT3pmeQv4XXe1w0lhJUIeEs31sme5etFhp5Tfq4aYNTYZZpCBwv6GYw1sWLJ2zs3wNLDtgrMn2XZiEmsRMF2lveuxQYOUmB/fYgDMYptXexJEdT6FdN64hxbLLu5Hxy36agUPXvKcqzeqRYHs8NfGI29U5WHoUJnK27pWYhKlTaqb7G5YeRTcg4QHhB9CoQ3WntHph6U0QDBLf0UEA64AhhlmK2U7mQgQ1LHMir8Vh2mdhtg1o3OsX8DKG+uSLJ+cKUElkg1uFOYjgBCWfnHwF2BPXC6B3AjHYsf3uEKQjqvHJQDHt8/PyqC9C2C6+/AmAr
x-ms-exchange-antispam-messagedata: wb0L/MIcE8PQbLuDp3GflhP67cZ0Emx72N87uS9/CZuCbPp5k7GMWuifbsmEYDQLe0q+H7dgrRQpomOC4HYmXPIdTfr0Y7XSVxhDExE4sgTvwc11fCapursbzUQahraPffeZ15CySZ4p5XGStnX11w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5030DBB3DF95594A80DE27253B6A4D90@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68407d59-89d7-4d73-2eaf-08d7de7cb03d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2020 00:59:00.6547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xi2r4VXtTsGmEFTawRu91P+fYL7RQ6V3McpfbHC4vHbdtkFu2gMFE1DOJotqYStY1YQjkPwvrikHlmjpZ6I8Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3318
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgOTNjZTRhZjc3
NGJjM2Q4YTcyY2UyMjcxZDAzMjQxYzk2MzgzNjI5ZDoNCg0KICBORlM6IENsZWFuIHVwIHByb2Nl
c3Mgb2YgbWFya2luZyBpbm9kZSBzdGFsZS4gKDIwMjAtMDQtMDYgMTM6NTY6MzMgLTA0MDApDQoN
CmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdDovL2dpdC5s
aW51eC1uZnMub3JnL3Byb2plY3RzL3Ryb25kbXkvbGludXgtbmZzLmdpdCB0YWdzL25mcy1mb3It
NS43LTINCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDI3ZDIzMWMwYzYzYmI2MTk5
OTdhMjRiYWI4NWQ1NGQ5MGNhNzExMTA6DQoNCiAgcE5GUzogRml4IFJDVSBsb2NrIGxlYWthZ2Ug
KDIwMjAtMDQtMTEgMTE6NDI6MzUgLTA0MDApDQoNClRoYW5rcywNCiAgVHJvbmQNCg0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KTkZTIGNsaWVudCBidWdmaXggZm9yIExpbnV4IDUuNw0KDQpCdWdmaXg6DQotIEZpeCBhbiBS
Q1UgcmVhZCBsb2NrIGxlYWthZ2UgaW4gcG5mc19hbGxvY19kc19jb21taXRzX2xpc3QoKQ0KDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQpUcm9uZCBNeWtsZWJ1c3QgKDEpOg0KICAgICAgcE5GUzogRml4IFJDVSBsb2NrIGxl
YWthZ2UNCg0KIGZzL25mcy9wbmZzX25mcy5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFp
bmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
