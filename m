Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6DB486C52
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2019 23:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404238AbfHHV0z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Aug 2019 17:26:55 -0400
Received: from mail-eopbgr680108.outbound.protection.outlook.com ([40.107.68.108]:12963
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404237AbfHHV0y (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 8 Aug 2019 17:26:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNdSDvXgFc1ENVTEqqPzw+qq3hmqc7k6a9UI8S/nhajPOiwGdvCaoJba+8z7wbGRs3UD9eQZU5yMGSdLJlSYqHJyVKeloXBt6Yhy7nCBCp7QW3194A1P+BJ59BREdzKuw2+BKQuu6Fr5+VXqMcfBB+4ARVRSoEBVoa+UpVwVgW32aMIBN3O98nG1OqtU+qMGSxfxbpb52kaAxb2Iliy804etnnT4g92p8GLGsNEmuMKQreRMtKm1QDbM0Adz18GHr6My5AjoJ07kHH/qhuY3+i9xb69yZY4djaOCYOR8aO2ZTKT/w3s4xlYliV9wa2PHubpVVlBKRMTZo4jQUbl44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YXzqnmq1TgxBgTdHDGS9gtIZ5BuLJRbeCs967TQs6w=;
 b=IquZ++xFqztFftDATAcdG0pd5LPreoGLPmOo7HjjxPKW9v9UVUJ8z2uJ3pWZNpJ0hzM4Cb5haQnlYLJ0HYSzN/u0aP2DiVCmOLp9oV9+bOE+1ZqisQjnhf2dTIgRBYyYABZIft8v0HPqPtf2FyD9IpJDaCkJ5HjEj0bFZGdW9vlsEbIFLpMS85cNjoKo/h/qJRlLwqubTJWDlF4UMmJJ0ve9jOSRPlgm69iuPwU8kbbRt0cP5ieMDvpXj4vvn2TCTpE+Ww2aCVv1VJTTG/SixThkrIjwQ9Jo++JbbKJBF2nOK46yxeVuMkrJNK9xNfxCsLH/peKxNHDvYFdpYibifg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YXzqnmq1TgxBgTdHDGS9gtIZ5BuLJRbeCs967TQs6w=;
 b=FuC2gdgn/lhC3VQBlwpQrxlVqDC9BaXKSC9RqEyVfWYWg+hDQwWHOpN3mUVHbOQSZT8b/UF21IZKISJ6wt19hNvzaV6qh3+bNNqMS2sO5StW3kzXAOq9JCd9MBLtYGkFSSNTyfBmePd/P+esb2jlviJArjpLjx+KJaBS4NMSLBU=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1738.namprd13.prod.outlook.com (10.171.158.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.11; Thu, 8 Aug 2019 21:26:49 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::28ef:bf07:4680:dc93%5]) with mapi id 15.20.2157.015; Thu, 8 Aug 2019
 21:26:49 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes
Thread-Index: AQHVTi/9k4jpO49iQUK+ZoJ/U5JMtg==
Date:   Thu, 8 Aug 2019 21:26:49 +0000
Message-ID: <c898416a146ef77bd5a61a0cf3e219fccbfcf508.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23b9a87d-067c-4653-3bf9-08d71c471f92
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1738;
x-ms-traffictypediagnostic: DM5PR13MB1738:
x-microsoft-antispam-prvs: <DM5PR13MB173841B459C71478212BD457B8D70@DM5PR13MB1738.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39830400003)(136003)(396003)(366004)(189003)(199004)(6916009)(118296001)(71190400001)(2501003)(186003)(86362001)(71200400001)(2616005)(5660300002)(14444005)(36756003)(4326008)(26005)(486006)(256004)(8936002)(6506007)(102836004)(478600001)(54906003)(25786009)(476003)(5640700003)(53936002)(305945005)(7736002)(91956017)(66446008)(66556008)(66946007)(66476007)(64756008)(6436002)(2351001)(76116006)(3846002)(8676002)(2906002)(1730700003)(81166006)(316002)(81156014)(6512007)(99286004)(14454004)(6116002)(6486002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1738;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y50BOQXGdjYQwlp9bXNm8NUyOS19OXL3Wgt05+Vi0btdpz0mreACRhR3Nm8URy/OG++XFAa2AWZ4iHpfHZdU+/DMJi6BaieqSB1sK8MaivzXCIlWmxHpVv6VkZ/CUUZAjAmcwRZYuHmhgacgyy/o45JkJr92AU2VLfS7BVv3gOkjcK+3MGsYk/8wNwbA7799WeWhrxtapzXQrV/IVJ38dcRHUTLVenoFGjKqAfgtPiX9dB1arITk0MmU0uq0U2bqrtvJQ1lCxf+1Ei0hK1N/Z62F6dUQ4oSSJHheUt5MZTrbFzlfIDWJTQqpyEQJ8l5xDD40EnGMxgYO7hv5egwqSgBszHb1Y6HD29wUWTdM0dB4+mzeAy++aicmMC3q0jcywZNPpZ6g0gXFRUyVQdQS/0d6Qh/6l9ZuxgSDnPtITJU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6DB6CBD4247A440AE8315E4E18045DB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23b9a87d-067c-4653-3bf9-08d71c471f92
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 21:26:49.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/vkexy3umqVdQDqTlQx1oISiwdEcYAMOgio+siGtezaMx1MHrYhBJVQKqKEOGPV9wSml6zL3+fZyf7a0Lw4Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1738
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZTIxYTcxMmE5
Njg1NDg4ZjVjZTgwNDk1YjM3YjlmZGJlOTZjMjMwZDoNCg0KICBMaW51eCA1LjMtcmMzICgyMDE5
LTA4LTA0IDE4OjQwOjEyIC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xp
bnV4LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuMy0yDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byA2N2U3YjUyZDQ0ZTNkNTM5ZGZiZmNkODY2YzNkM2Q2OWRhMjNhOTA5Og0KDQogIE5G
U3Y0OiBFbnN1cmUgc3RhdGUgcmVjb3ZlcnkgaGFuZGxlcyBFVElNRURPVVQgY29ycmVjdGx5ICgy
MDE5LTA4LTA3IDEyOjU1OjExIC0wNDAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpORlMgY2xpZW50IGJ1Z2ZpeGVz
IGZvciBMaW51eCA1LjMNCg0KSGlnaGxpZ2h0cyBpbmNsdWRlOg0KDQpTdGFibGUgZml4ZXM6DQot
IE5GU3Y0OiBFbnN1cmUgd2UgY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBvZiB1cGRhdGVfb3Blbl9z
dGF0ZWlkKCkgc28gd2UNCiAgY29ycmVjdGx5IHRyYWNrIGFjdGl2ZSBvcGVuIHN0YXRlLg0KLSBO
RlN2NDogRml4IGZvciBkZWxlZ2F0aW9uIHN0YXRlIHJlY292ZXJ5IHRvIGVuc3VyZSB3ZSByZWNv
dmVyIGFsbCBvcGVuDQogIG1vZGVzIHRoYXQgYXJlIGFjdGl2ZS4NCi0gTkZTdjQ6IEZpeCBhbiBP
b3BzIGluIG5mczRfZG9fc2V0YXR0cg0KDQpCdWdmaXhlczoNCi0gTkZTOiBGaXggcmVncmVzc2lv
biB3aGVyZWJ5IGZzY2FjaGUgZXJyb3JzIGFyZSBhcHBlYXJpbmcgb24gJ25vZnNjJyBtb3VudHMN
Ci0gTkZTdjQ6IEZpeCBhIHBvdGVudGlhbCBzbGVlcCB3aGlsZSBhdG9taWMgaW4gbmZzNF9kb19y
ZWNsYWltKCkNCi0gTkZTdjQ6IEZpeCBhIGNyZWRlbnRpYWwgcmVmY291bnQgbGVhayBpbiBuZnM0
MV9jaGVja19kZWxlZ2F0aW9uX3N0YXRlaWQNCi0gcE5GUzogUmVwb3J0IGVycm9ycyBmcm9tIHRo
ZSBjYWxsIHRvIG5mczRfc2VsZWN0X3J3X3N0YXRlaWQoKQ0KLSBORlN2NDogVmFyaW91cyBvdGhl
ciBkZWxlZ2F0aW9uIGFuZCBvcGVuIHN0YXRlaWQgcmVjb3ZlcnkgZml4ZXMNCi0gTkZTdjQ6IEZp
eCBzdGF0ZSByZWNvdmVyeSBiZWhhdmlvdXIgd2hlbiBzZXJ2ZXIgY29ubmVjdGlvbiB0aW1lcyBv
dXQNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KVHJvbmQgTXlrbGVidXN0ICgxMik6DQogICAgICBORlN2NDogRml4IGEg
Y3JlZGVudGlhbCByZWZjb3VudCBsZWFrIGluIG5mczQxX2NoZWNrX2RlbGVnYXRpb25fc3RhdGVp
ZA0KICAgICAgTkZTdjQ6IEZpeCBkZWxlZ2F0aW9uIHN0YXRlIHJlY292ZXJ5DQogICAgICBORlN2
NDogUHJpbnQgYW4gZXJyb3IgaW4gdGhlIHN5c2xvZyB3aGVuIHN0YXRlIGlzIG1hcmtlZCBhcyBp
cnJlY292ZXJhYmxlDQogICAgICBORlN2NDogV2hlbiByZWNvdmVyaW5nIHN0YXRlIGZhaWxzIHdp
dGggRUFHQUlOLCByZXRyeSB0aGUgc2FtZSByZWNvdmVyeQ0KICAgICAgTkZTdjQ6IFJlcG9ydCB0
aGUgZXJyb3IgZnJvbSBuZnM0X3NlbGVjdF9yd19zdGF0ZWlkKCkNCiAgICAgIE5GU3Y0LjE6IEZp
eCBvcGVuIHN0YXRlaWQgcmVjb3ZlcnkNCiAgICAgIE5GU3Y0LjE6IE9ubHkgcmVhcCBleHBpcmVk
IGRlbGVnYXRpb25zDQogICAgICBORlN2NDogQ2hlY2sgdGhlIHJldHVybiB2YWx1ZSBvZiB1cGRh
dGVfb3Blbl9zdGF0ZWlkKCkNCiAgICAgIE5GU3Y0OiBGaXggYSBwb3RlbnRpYWwgc2xlZXAgd2hp
bGUgYXRvbWljIGluIG5mczRfZG9fcmVjbGFpbSgpDQogICAgICBORlN2NDogRml4IGFuIE9vcHMg
aW4gbmZzNF9kb19zZXRhdHRyDQogICAgICBORlM6IEZpeCByZWdyZXNzaW9uIHdoZXJlYnkgZnNj
YWNoZSBlcnJvcnMgYXJlIGFwcGVhcmluZyBvbiAnbm9mc2MnIG1vdW50cw0KICAgICAgTkZTdjQ6
IEVuc3VyZSBzdGF0ZSByZWNvdmVyeSBoYW5kbGVzIEVUSU1FRE9VVCBjb3JyZWN0bHkNCg0KIGZz
L25mcy9kZWxlZ2F0aW9uLmMgfCAgMjUgKysrKysrKystLS0tDQogZnMvbmZzL2RlbGVnYXRpb24u
aCB8ICAgMiArLQ0KIGZzL25mcy9mc2NhY2hlLmMgICAgfCAgIDcgKysrLQ0KIGZzL25mcy9mc2Nh
Y2hlLmggICAgfCAgIDIgKy0NCiBmcy9uZnMvbmZzNF9mcy5oICAgIHwgICAzICstDQogZnMvbmZz
L25mczRjbGllbnQuYyB8ICAgNSArKy0NCiBmcy9uZnMvbmZzNHByb2MuYyAgIHwgMTA5ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBmcy9uZnMv
bmZzNHN0YXRlLmMgIHwgIDQ5ICsrKysrKysrKysrKysrKysrKy0tLS0tDQogZnMvbmZzL3BuZnMu
YyAgICAgICB8ICAgNyArLS0tDQogZnMvbmZzL3N1cGVyLmMgICAgICB8ICAgMSArDQogMTAgZmls
ZXMgY2hhbmdlZCwgMTM1IGluc2VydGlvbnMoKyksIDc1IGRlbGV0aW9ucygtKQ0KDQotLSANClRy
b25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0K
dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
