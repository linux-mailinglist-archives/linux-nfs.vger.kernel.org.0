Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1EA1D5B1C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2020 23:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgEOVAP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 May 2020 17:00:15 -0400
Received: from mail-eopbgr700123.outbound.protection.outlook.com ([40.107.70.123]:46494
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbgEOVAP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 15 May 2020 17:00:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7xZoPmCHAmP4rBmHKxJWwRDvSG1hK7YB1IYgm7Wds5UkVCI/lQVOtDw72Xdf5tvLeIXR4ZxakSp68Q1jjBNo/2aryccXbpKSNqfGN8GdF6XgzBAKSZvLKAez95mWKGCwVUOGHLtyXwkhEJK334w55NmNpb9rTsUzRRsJ5EXnDuR3A/YdRMimn191x1a+FWS6cYrYikL1tbz188UlgVpFsCLHk6tSXNbO23/2YrF392GiaLeux5QydhEDA+eUFgieOUgiJKbLjRZLC/wYEusjik8k9B/gMcR7V/BvU2PX8xF2i1Zp1S8F5S0Br77piVV6Va/lg4iPaQH89tGJVR1MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSBDTuXiaHo9aT/QtqBty5tOFAYvdXFMGTSGniVPr4Q=;
 b=kj1N5xcaV+y+qLiwM7bjv7mZGP76+ypAosclNWYxHVd6VeLpdCGZhpXVQtA4sTLTMBRy4DC8pepvqeHcl8MSNBgEkWnyZMNuwksw+I2Ct7V3g8pkIMQ/+KTGfr3ybGB/E+nXrBfFhT/dvNq9injEp4ho2y8KsCuCOYwPLzimdmvBPW2/PpVgz3Rj78F3Bra9UotZ0Gj1bds0LjpVsY2aZ9dgJh31QmxOsyiEuXFfY1nL+LNIzI8jKHoT35HtGJGaQ3LfI2XZWSOV4YcGBr4vOXMam/pk4O20ReLdHPQgyYFNR2FJdf+l0TA2i/lrU1/HWcJeghUEnepjRDFaBEqvsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSBDTuXiaHo9aT/QtqBty5tOFAYvdXFMGTSGniVPr4Q=;
 b=Uk6/UvGloMPvZKcElMUWpmnFmGX5oVFcTuOra9NLAfY3D7fTxo53+yRsJbhlLxkIS8Qixs9rI7l0V0+kXVvuGpqy2VVdlZB9Qtavykzd+qosQqgPtJ2rt0zWWrhHYpx7MsRRG16BhjPQRu+3uvm/t1aHu89H4mv98RAGFktuo2Y=
Received: from CH2PR13MB3398.namprd13.prod.outlook.com (2603:10b6:610:2a::33)
 by CH2PR13MB3336.namprd13.prod.outlook.com (2603:10b6:610:28::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Fri, 15 May
 2020 21:00:11 +0000
Received: from CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493]) by CH2PR13MB3398.namprd13.prod.outlook.com
 ([fe80::49f6:ce9b:9803:2493%6]) with mapi id 15.20.3021.010; Fri, 15 May 2020
 21:00:11 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHWKvvSr3FikOQ3nUyYLv26edod/g==
Date:   Fri, 15 May 2020 21:00:11 +0000
Message-ID: <550cfc745cc5ee9dcae06db50594088aad09fb45.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 624039fd-4151-4cf9-3412-08d7f912f514
x-ms-traffictypediagnostic: CH2PR13MB3336:
x-microsoft-antispam-prvs: <CH2PR13MB3336F66EC8A05596D68AE974B8BD0@CH2PR13MB3336.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0OjQy4RSc7Hb8Xx12VXjPDlvgoszhlzzTlTR8SohT1AUVdszjhno7daOhIcQO1npJFvLAY2vwq6TXimSUE13E8EN/tZha8XV4tlGAAHLkX4dVG2H/qAozud70B2kCGc/T/aoaC+Jn8iuxD7zLyn5oKUSvM1skuDSGPbXd2FsJDWlPz2rLp/kFfyILX4oKx+Y7M4s0Et61adpjhDUtZltjTLepU2YdNUavsNnKYO8WNWMekpDO2dapLFv25ulzZ9BfDFhUjbJMBQuwEI/NYsXvqEvFzupoJDFbwccmtU2YNEyH0RqFPHY6DDDHCRh0zrW9B6uzIXYdFIwUme9VIa9gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3398.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(39830400003)(396003)(136003)(86362001)(6486002)(4326008)(2906002)(6512007)(71200400001)(316002)(8936002)(6916009)(8676002)(5660300002)(478600001)(2616005)(6506007)(26005)(76116006)(54906003)(36756003)(186003)(66946007)(66556008)(66446008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zh0H3fAgzBW4dof1myumfjzWH843mhK/+4LJAoRVzpvUk3Vh5wo+QlHfEJ+duEVp1Ung2dNnQ0vRdAEfG3ZMJ++eCxnIbM9RV578pNHBpJn25QZAqa77a0gwzGp4swVP+4alRXxamPUZw9xjHdo4nbT6CKlDYEvgC3hfYju3uznX/+6pA1xea2+UbghQNqC6SVPLqRmct78qOUhJvOmy0aaecbpLvFXu1VqBVSAhSByYhnrNS8vr5XL0ZlU5BHTWU78XvloplURK25h0dTpDaeSuZ6ElDGQPIbbo5uHdDBgfcD7wQ+aaCuGtVEWquHQIQdu6FrZndVR3YHRYaj/827VcjM9pa11XNxlqsQZU++6KkndrRcY6Vqb9yVBaUSwXkV3HQS2tHWZsY65oHn2xKnqP3KlXXyKHs87Llnr92VBQ5DW6z18qRYXNWgoxGVGx/WS+7dzqanBpwbN684AYVVB4/iavbBZGZT4PKQqFl6w=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15D9406854603C45A518657C4A2B7DA4@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624039fd-4151-4cf9-3412-08d7f912f514
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 21:00:11.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3no9XuJVds2oejCqG50ERqFnNHTRe036/gmLi/a/IfWElTo0chbin7ksWWOK7uqXtKCfdeUon/F1OmspGz10Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3336
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgMmVmOTZhNWJi
MTJiZTYyZWY3NWI1ODI4YzBhYWI4MzhlYmIyOWNiODoNCg0KICBMaW51eCA1LjctcmM1ICgyMDIw
LTA1LTEwIDE1OjE2OjU4IC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xp
bnV4LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuNy01DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byA4ZWVkMjkyYmM4Y2JmNzM3ZTQ2ZmIxYzExOWQ0YzhmNmRjYjAwNjUwOg0KDQogIE5G
U3YzOiBmaXggcnBjIHJlY2VpdmUgYnVmZmVyIHNpemUgZm9yIE1PVU5UIGNhbGwgKDIwMjAtMDUt
MTQgMTg6NDI6NDQgLTA0MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk5GUyBjbGllbnQgYnVnZml4ZXMgZm9yIExp
bnV4IDUuNw0KDQpIaWdobGlnaHRzIGluY2x1ZGU6DQoNClN0YWJsZSBmaXhlczoNCi0gbmZzOiBm
aXggTlVMTCBkZWZlcmVuY2UgaW4gbmZzNF9nZXRfdmFsaWRfZGVsZWdhdGlvbg0KDQpCdWdmaXhl
czoNCi0gRml4IGNvcnJ1cHRpb24gb2YgdGhlIHJldHVybiB2YWx1ZSBpbiBjYWNoZWZpbGVzX3Jl
YWRfb3JfYWxsb2NfcGFnZXMoKQ0KLSBGaXggc2V2ZXJhbCBmc2NhY2hlIGNvb2tpZSBpc3N1ZXMN
Ci0gRml4IGEgZnNjYWNoZSBxdWV1aW5nIHJhY2UgdGhhdCBjYW4gdHJpZ2dlciBhIEJVR19PTg0K
LSBORlM6IEZpeCAyIHVzZS1hZnRlci1mcmVlIHJlZ3Jlc3Npb25zIGR1ZSB0byB0aGUgUlBDX1RB
U0tfQ1JFRF9OT1JFRiBmbGFnDQotIFNVTlJQQzogRml4IGEgdXNlLWFmdGVyLWZyZWUgcmVncmVz
c2lvbiBpbiBycGNfZnJlZV9jbGllbnRfd29yaygpDQotIFNVTlJQQzogRml4IGEgcmFjZSB3aGVu
IHRlYXJpbmcgZG93biB0aGUgcnBjIGNsaWVudCBkZWJ1Z2ZzIGRpcmVjdG9yeQ0KLSBTVU5SUEM6
IFNpZ25hbGxlZCBBU1lOQyB0YXNrcyBuZWVkIHRvIGV4aXQNCi0gTkZTdjM6IGZpeCBycGMgcmVj
ZWl2ZSBidWZmZXIgc2l6ZSBmb3IgTU9VTlQgY2FsbA0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDaHVjayBMZXZlciAo
MSk6DQogICAgICBTVU5SUEM6IFNpZ25hbGxlZCBBU1lOQyB0YXNrcyBuZWVkIHRvIGV4aXQNCg0K
RGF2ZSBXeXNvY2hhbnNraSAoMyk6DQogICAgICBORlM6IEZpeCBmc2NhY2hlIHN1cGVyX2Nvb2tp
ZSBpbmRleF9rZXkgZnJvbSBjaGFuZ2luZyBhZnRlciB1bW91bnQNCiAgICAgIE5GUzogRml4IGZz
Y2FjaGUgc3VwZXJfY29va2llIGFsbG9jYXRpb24NCiAgICAgIE5GU3Y0OiBGaXggZnNjYWNoZSBj
b29raWUgYXV4X2RhdGEgdG8gZW5zdXJlIGNoYW5nZV9hdHRyIGlzIGluY2x1ZGVkDQoNCkRhdmlk
IEhvd2VsbHMgKDEpOg0KICAgICAgY2FjaGVmaWxlczogRml4IGNvcnJ1cHRpb24gb2YgdGhlIHJl
dHVybiB2YWx1ZSBpbiBjYWNoZWZpbGVzX3JlYWRfb3JfYWxsb2NfcGFnZXMoKQ0KDQpKLiBCcnVj
ZSBGaWVsZHMgKDIpOg0KICAgICAgbmZzOiBmaXggTlVMTCBkZWZlcmVuY2UgaW4gbmZzNF9nZXRf
dmFsaWRfZGVsZWdhdGlvbg0KICAgICAgU1VOUlBDOiAnRGlyZWN0b3J5IHdpdGggcGFyZW50ICdy
cGNfY2xudCcgYWxyZWFkeSBwcmVzZW50IScNCg0KTGVpIFh1ZSAoMSk6DQogICAgICBjYWNoZWZp
bGVzOiBGaXggcmFjZSBiZXR3ZWVuIHJlYWRfd2FpdGVyIGFuZCByZWFkX2NvcGllciBpbnZvbHZp
bmcgb3AtPnRvX2RvDQoNCk5laWxCcm93biAoMSk6DQogICAgICBTVU5SUEM6IGZpeCB1c2UtYWZ0
ZXItZnJlZSBpbiBycGNfZnJlZV9jbGllbnRfd29yaygpDQoNCk9sZ2EgS29ybmlldnNrYWlhICgx
KToNCiAgICAgIE5GU3YzOiBmaXggcnBjIHJlY2VpdmUgYnVmZmVyIHNpemUgZm9yIE1PVU5UIGNh
bGwNCg0KVHJvbmQgTXlrbGVidXN0ICgzKToNCiAgICAgIE1lcmdlIHRhZyAnZnNjYWNoZS1maXhl
cy0yMDIwMDUwOC0yJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy8uLi4vZGhvd2VsbHMvbGludXgt
ZnMNCiAgICAgIE5GUzogRG9uJ3QgdXNlIFJQQ19UQVNLX0NSRURfTk9SRUYgd2l0aCBkZWxlZ3Jl
dHVybg0KICAgICAgTkZTL3BuZnM6IERvbid0IHVzZSBSUENfVEFTS19DUkVEX05PUkVGIHdpdGgg
cG5mcw0KDQogZnMvY2FjaGVmaWxlcy9yZHdyLmMgfCAxMiArKysrKystLS0tLS0NCiBmcy9uZnMv
ZnNjYWNoZS5jICAgICB8IDM5ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KIGZzL25mcy9tb3VudF9jbG50LmMgIHwgIDMgKystDQogZnMvbmZzL25mczRwcm9jLmMgICAg
fCAgMiArLQ0KIGZzL25mcy9uZnM0c3RhdGUuYyAgIHwgIDIgKy0NCiBmcy9uZnMvcGFnZWxpc3Qu
YyAgICB8ICA1ICsrKy0tDQogZnMvbmZzL3BuZnNfbmZzLmMgICAgfCAgMyArKy0NCiBmcy9uZnMv
c3VwZXIuYyAgICAgICB8ICAxIC0NCiBmcy9uZnMvd3JpdGUuYyAgICAgICB8ICA0ICsrLS0NCiBu
ZXQvc3VucnBjL2NsbnQuYyAgICB8ICA5ICsrKysrKystLQ0KIDEwIGZpbGVzIGNoYW5nZWQsIDQy
IGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQ0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxp
bnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBo
YW1tZXJzcGFjZS5jb20NCg0KDQo=
