Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A909F34A
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 21:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfH0T04 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 15:26:56 -0400
Received: from mail-eopbgr690138.outbound.protection.outlook.com ([40.107.69.138]:4474
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730237AbfH0T0z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 15:26:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZB6FV+GRl+e/2Gg7CqTgQ15FnQRRSAv9RLAZC26BZNQQ0X0R2Kp/+YSrQLbXUWb/rOAjvy54KDQ/1ZQfxYZz9Uy5ZuwUHIrTIpz5k4oC7Q+rSKfsxI/llRRYUrFBVO7yiM903k24LOn/lD9nsNsdOLl6Fsg/r2anqkuPgIrOyq7wvMeHHQROgtfQMFwQ8vW1Yugnw9LSmUXlbIiXu2Xfa+2yF7Mey2ICwXOfmzko7gIE2ULUTNOX13RPNH0p3c/dXmMJ5BKYxHNur+7dYgd9GuZbnuc5Rfj6SnMjkzNT/2H+rhbAAir3DRkUoblbB6ttequJzOpQc1pMdZRRJLOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDUdbnJDOoJo4CM1/2r34H3XQ43an1qdlhZ1lG8P4Uk=;
 b=DRQ26lr0m4qE74ds3kiJtRnPnOs8uwMIlDMdyd/Q1vRoXzbljy8whKr798UFVa9Fee84p1uIjcUoA2/3ZuXuDFeCRCnZJDqnIJOI6pPcl1dIXS43Z5g/3JR6JDqKw62vbaUyjHyEBHPRK7eywI9ALGJoOiV+MGR1T2VCwOpqy66jq7zup6xVqEgkdEUFKWtd1D6u/Ja5LdGxjT0sVcD2RzDHniiK/iY58AYKUUovfCnpZj5Ax/MtSBLl0UUmKPJFBEDvQLBpdq4B5wtpnmao+GqAXXoyHLVXhmDKaa/OK6AGa/MSA6WxyS1Smfp0OubqIs9OTbK5ek7i42kkO8sTbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDUdbnJDOoJo4CM1/2r34H3XQ43an1qdlhZ1lG8P4Uk=;
 b=FedWWLBJ1O6Yp1SawqpN4CbCA9WnJ2jcNdMcgMRzBjWyhxHgwJ8PvwPzMhKMH24jolnslf9MNKCP8UVxWmOAQ00gzMwbb8J3BQWGSgK0cAMnGVsMqGOc1ih4VaJHWmFHyQrSzwgJnVubui8MOQUNIbP7nj+RDfyCqliwcuKz6BE=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1452.namprd13.prod.outlook.com (10.175.108.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.11; Tue, 27 Aug 2019 19:26:51 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::5d60:e645:84a2:be75%7]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 19:26:51 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHVXQ1gF2e8n4lPEEyD9HczfB0lxQ==
Date:   Tue, 27 Aug 2019 19:26:51 +0000
Message-ID: <e5010947fb92781e7e5eebc6750fa61d0c5e2399.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78d66e38-c1dc-4bf8-5ddf-08d72b248361
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1452;
x-ms-traffictypediagnostic: DM5PR13MB1452:
x-microsoft-antispam-prvs: <DM5PR13MB1452D09C0ECD9932C595C57DB8A00@DM5PR13MB1452.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(376002)(346002)(39840400004)(189003)(199004)(71190400001)(66476007)(2501003)(256004)(102836004)(53936002)(14444005)(76116006)(99286004)(5660300002)(7736002)(36756003)(26005)(66556008)(64756008)(66446008)(186003)(91956017)(6486002)(6512007)(3846002)(6506007)(71200400001)(2616005)(486006)(2906002)(5640700003)(66946007)(476003)(6116002)(66066001)(6916009)(305945005)(2351001)(8936002)(4326008)(81166006)(81156014)(1730700003)(8676002)(118296001)(316002)(14454004)(25786009)(6436002)(86362001)(54906003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1452;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sYAMkyieKaXNiS9m0MfH7Tb+JnMuYXhxUA74vB5tfW2ahjgIVsqWMRdpLO8PlAT1GiccHS7gbrz/Awxi6SjTzMkunwXnlkxLkPwx0F6T1f7/bScfN/GyLi5uYn1PUXI3snsM8ysVHW5x/Y+lA6281M1b2Ptf8C3NHWukIfrkzRvEUeFpqhm23K4WcChZEbrod8MW9bhjtZe3y7xAAUvKGdJHVt4HChzJmc+1521HudC+9K2VoXkKKtncjyFywpgT31Z71nQ/aBWKT394R5b+OBx9fiib/wXjKpnrX35vleqE33LViBu2T6AVQWirpehelkT7XSUhTzlgUZ0J5/vC98+TCpXAkcsW6BaGPK3M/Z/iuqaqNkG7yYxW2nxDMwsCS5TtnaD4owmIfV7F9bMSyAzgvezQNZHZF7Pig6kV0a4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6943D2E51CB41E46A410EB764B20A05E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d66e38-c1dc-4bf8-5ddf-08d72b248361
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 19:26:51.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5i7U6YpMJo8HaFsSRM8W0khn5BoOm9lWojrqP2z80TDyG7KVhzTCA3+y9+ALeNjGKlcSUwWa7iMlZ/dYXKF7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1452
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZDFhYmFlYjNi
ZTdiNWZhNmQ3YTFmYmJkMmUxNGUzMzEwMDA1YzRjMToNCg0KICBMaW51eCA1LjMtcmM1ICgyMDE5
LTA4LTE4IDE0OjMxOjA4IC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xp
bnV4LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuMy0zDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byA5OTMwMGE4NTI2MGMyYjdmZWJkNTcwODJhNjE3ZDEwNjI1MzIwNjdlOg0KDQogIE5G
UzogcmVtb3ZlIHNldCBidXQgbm90IHVzZWQgdmFyaWFibGUgJ21hcHBpbmcnICgyMDE5LTA4LTI3
IDEwOjI0OjU2IC0wNDAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpORlMgY2xpZW50IGJ1Z2ZpeGVzIGZvciBMaW51
eCA1LjMNCg0KSGlnaGxpZ2h0cyBpbmNsdWRlOg0KDQpTdGFibGUgZml4ZXM6DQotIEZpeCBhIHBh
Z2UgbG9jayBsZWFrIGluIG5mc19wYWdlaW9fcmVzZW5kKCkNCi0gRW5zdXJlIE9fRElSRUNUIHJl
cG9ydHMgYW4gZXJyb3IgaWYgdGhlIGJ5dGVzIHJlYWQvd3JpdHRlbiBpcyAwDQotIERvbid0IGhh
bmRsZSBlcnJvcnMgaWYgdGhlIGJpbmQvY29ubmVjdCBzdWNjZWVkZWQNCi0gUmV2ZXJ0ICJORlN2
NC9mbGV4ZmlsZXM6IEFib3J0IEkvTyBlYXJseSBpZiB0aGUgbGF5b3V0IHNlZ21lbnQgd2FzIGlu
dmFsaWRhdA0KZWQiDQoNCkJ1Z2ZpeGVzOg0KLSBEb24ndCByZWZyZXNoIGF0dHJpYnV0ZXMgd2l0
aCBtb3VudGVkLW9uLWZpbGUgaW5mb3JtYXRpb24NCi0gRml4IHJldHVybiB2YWx1ZXMgZm9yIG5m
czRfZmlsZV9vcGVuKCkgYW5kIG5mc19maW5pc2hfb3BlbigpDQotIEZpeCBwbmZzIGxheW91dHN0
YXRzIHJlcG9ydGluZyBvZiBJL08gZXJyb3JzDQotIERvbid0IHVzZSBzb2Z0IFJQQyBjYWxscyBm
b3IgcE5GUy9mbGV4ZmlsZXMgSS9PLCBhbmQgZG9uJ3QgYWJvcnQgZm9yDQogIHNvZnQgSS9PIGVy
cm9ycyB3aGVuIHRoZSB1c2VyIHNwZWNpZmllcyBhIGhhcmQgbW91bnQuDQotIFZhcmlvdXMgZml4
ZXMgdG8gdGhlIGVycm9yIGhhbmRsaW5nIGluIHN1bnJwYw0KLSBEb24ndCByZXBvcnQgd3JpdGVw
YWdlKCkvd3JpdGVwYWdlcygpIGVycm9ycyB0d2ljZS4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVHJvbmQgTXlrbGVi
dXN0ICgxNyk6DQogICAgICBORlM6IERvbid0IHJlZnJlc2ggYXR0cmlidXRlcyB3aXRoIG1vdW50
ZWQtb24tZmlsZSBpbmZvcm1hdGlvbg0KICAgICAgTkZTdjQ6IEZpeCByZXR1cm4gdmFsdWVzIGZv
ciBuZnM0X2ZpbGVfb3BlbigpDQogICAgICBORlN2NDogRml4IHJldHVybiB2YWx1ZSBpbiBuZnNf
ZmluaXNoX29wZW4oKQ0KICAgICAgTkZTdjQvcG5mczogRml4IGEgcGFnZSBsb2NrIGxlYWsgaW4g
bmZzX3BhZ2Vpb19yZXNlbmQoKQ0KICAgICAgTkZTOiBFbnN1cmUgT19ESVJFQ1QgcmVwb3J0cyBh
biBlcnJvciBpZiB0aGUgYnl0ZXMgcmVhZC93cml0dGVuIGlzIDANCiAgICAgIE5GUzogRml4IGlu
aXRpYWxpc2F0aW9uIG9mIEkvTyByZXN1bHQgc3RydWN0IGluIG5mc19wZ2lvX3JwY3NldHVwDQog
ICAgICBORlM6IE9uIGZhdGFsIHdyaXRlYmFjayBlcnJvcnMsIHdlIG5lZWQgdG8gY2FsbCBuZnNf
aW5vZGVfcmVtb3ZlX3JlcXVlc3QoKQ0KICAgICAgU1VOUlBDOiBEb24ndCBoYW5kbGUgZXJyb3Jz
IGlmIHRoZSBiaW5kL2Nvbm5lY3Qgc3VjY2VlZGVkDQogICAgICBwTkZTL2ZsZXhmaWxlczogVHVy
biBvZmYgc29mdCBSUEMgY2FsbHMNCiAgICAgIFNVTlJQQzogSGFuZGxlIEVBRERSSU5VU0UgYW5k
IEVOT0JVRlMgY29ycmVjdGx5DQogICAgICBSZXZlcnQgIk5GU3Y0L2ZsZXhmaWxlczogQWJvcnQg
SS9PIGVhcmx5IGlmIHRoZSBsYXlvdXQgc2VnbWVudCB3YXMgaW52YWxpZGF0ZWQiDQogICAgICBT
VU5SUEM6IEhhbmRsZSBjb25uZWN0aW9uIGJyZWFrYWdlcyBjb3JyZWN0bHkgaW4gY2FsbF9zdGF0
dXMoKQ0KICAgICAgcE5GUy9mbGV4ZmlsZXM6IERvbid0IHRpbWUgb3V0IHJlcXVlc3RzIG9uIGhh
cmQgbW91bnRzDQogICAgICBORlM6IEZpeCBzcHVyaW91cyBFSU8gcmVhZCBlcnJvcnMNCiAgICAg
IE5GUzogRml4IHdyaXRlcGFnZShzKSBlcnJvciBoYW5kbGluZyB0byBub3QgcmVwb3J0IGVycm9y
cyB0d2ljZQ0KICAgICAgTkZTdjI6IEZpeCBlb2YgaGFuZGxpbmcNCiAgICAgIE5GU3YyOiBGaXgg
d3JpdGUgcmVncmVzc2lvbg0KDQpZdWVIYWliaW5nICgxKToNCiAgICAgIE5GUzogcmVtb3ZlIHNl
dCBidXQgbm90IHVzZWQgdmFyaWFibGUgJ21hcHBpbmcnDQoNCiBmcy9uZnMvZGlyLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAyICstDQogZnMvbmZzL2RpcmVjdC5jICAgICAgICAgICAg
ICAgICAgICAgICAgfCAyNyArKysrKysrKysrKystLS0tLS0tDQogZnMvbmZzL2ZsZXhmaWxlbGF5
b3V0L2ZsZXhmaWxlbGF5b3V0LmMgfCAyOCArKysrKysrLS0tLS0tLS0tLS0tLQ0KIGZzL25mcy9p
bm9kZS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzMgKysrKysrKysrKysrKystLS0tLS0t
LS0tDQogZnMvbmZzL2ludGVybmFsLmggICAgICAgICAgICAgICAgICAgICAgfCAxMCArKysrKysr
Kw0KIGZzL25mcy9uZnM0ZmlsZS5jICAgICAgICAgICAgICAgICAgICAgIHwgMTIgKysrKy0tLS0t
DQogZnMvbmZzL3BhZ2VsaXN0LmMgICAgICAgICAgICAgICAgICAgICAgfCAxOSArKysrKysrKy0t
LS0tLQ0KIGZzL25mcy9wbmZzX25mcy5jICAgICAgICAgICAgICAgICAgICAgIHwgMTUgKysrKysr
Ky0tLS0NCiBmcy9uZnMvcHJvYy5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA3ICsrKy0t
DQogZnMvbmZzL3JlYWQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAzNSArKysrKysrKysr
KysrKysrKystLS0tLS0tDQogZnMvbmZzL3dyaXRlLmMgICAgICAgICAgICAgICAgICAgICAgICAg
fCAzOCArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCiBpbmNsdWRlL2xpbnV4L3N1bnJwYy9z
Y2hlZC5oICAgICAgICAgICB8ICAxIC0NCiBuZXQvc3VucnBjL2NsbnQuYyAgICAgICAgICAgICAg
ICAgICAgICB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCiBuZXQvc3Vu
cnBjL3hwcnQuYyAgICAgICAgICAgICAgICAgICAgICB8ICA3IC0tLS0tDQogMTQgZmlsZXMgY2hh
bmdlZCwgMTYzIGluc2VydGlvbnMoKyksIDExOCBkZWxldGlvbnMoLSkNCi0tIA0KVHJvbmQgTXlr
bGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
