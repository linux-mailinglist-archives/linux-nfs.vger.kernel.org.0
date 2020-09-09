Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A42634FF
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Sep 2020 19:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgIIRwF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Sep 2020 13:52:05 -0400
Received: from mail-eopbgr690120.outbound.protection.outlook.com ([40.107.69.120]:9399
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725772AbgIIRwF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 9 Sep 2020 13:52:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aIbhQw+aJBECxPys9+bvXzRDtKt8ZtEPiQ7XBi24v1fntxzj5CIGqPMTZerdHDyqq1PlBrt5VRxJQ+4Rzz8W1SzStXTynFOP00YR2Bj4QSMR2sNftxBNG78VoZx5WIbqQ/RTjZXbk4t0ZHKQr2ozrIs/AchnlDYcg9QhpB/Me0j2rDC2YCByQ7ds9SUDmzYUxNpH+PlssL2Uhs8KMELxVu3mwYOotoaI1UKGDioVGSCo2RqHVzTnHup3jUZ5SaQEBv9rGqDduG6H+fc3WpJtlIwF1ijuIe4+4Kdu5ZnG3R2wupaszx1jjvWTfJfbQXAONeqSNnIZt+f7FIG3QkUvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHxTnq+f3e6lfLuEuMIjSlVGe6OZ0hzlE5T1gXp9N+w=;
 b=Pzr65+O4NmFXYwC+l9byw5pC01IbFYPszh6PcJzp2/5s0/A4Et/h6s6Tq4O8J07rEdASnXwmoZA0EuVTUXfGVI2yC4AA1c8hw2ZbKn6uCUPNO1UPpZSkU1W4TsnoicJ+SG+Rtdcz6DG5ETPFLW5/7vRP1G0VizGKbdvLDwY27PlnRXNzgV2eRJt8+j1CmcytFMeuE/zvz2BbJ7WYQhwr8BBuJJn9Ruo5xcqLkusp3xY5SOIEPQVyeuKknuaxjkzG/+IZVT0b+qJ1q2s8wSudqzTYPv0yu0i7UDkCQLa8QxyooEVGoXNNXek+wkZLkcwqFi5uS5fBnsob6zm3DM9ErA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHxTnq+f3e6lfLuEuMIjSlVGe6OZ0hzlE5T1gXp9N+w=;
 b=AKVmv11iRTdo4BKQkX05bZsf+t+84C9mHNVPwEbdBrzR8dArXJ4oE9S8t1wFm9wA5KldazhUAX7bj7hjyzgDjcxlpsaIMGP1j4ibNgLtKm+yCnM4dF4O8OTT5RECOczeffEakwhHzXtUaet2LjLNTo4WOQ4xOjUkCXMarBPxXYo=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3245.namprd13.prod.outlook.com (2603:10b6:208:152::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7; Wed, 9 Sep
 2020 17:52:01 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e8a1:6acc:70f0:ef39%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 17:52:01 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for Linux 5.9
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for Linux 5.9
Thread-Index: AQHWhtHrbz1WMbApNESpNEz9e59ozg==
Date:   Wed, 9 Sep 2020 17:52:01 +0000
Message-ID: <f96776cef2b96ae904dd7f0c58a96c964cb9a950.camel@hammerspace.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 877aff4d-b35e-4c53-febc-08d854e90e0d
x-ms-traffictypediagnostic: MN2PR13MB3245:
x-microsoft-antispam-prvs: <MN2PR13MB32451049B730E86091B7558EB8260@MN2PR13MB3245.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:397;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgvHGhiafD0GKzOLDARtWjymaxaVFxmxEeEXOam44/bwDJfBih0RPeLauGU5x2+CB5oLK5/UdFjbEM1BNKxm6liaw5UAoc5C7IYCYoC89h9TMLzRpKdBGPifndRbf5QypMGEuhQp5uoc35VHy5sxEXKAnKscImcOC7RZzCxEzPV8VI5mUl26oQOM5LHw8z2TATgU/xix8yYLDzC4ExjM+iFBLMD7u5PiEZYWO9Qzoz0TMSwKwF8cHAvQGF6VX9cVfZNoNvxUVLb0P36ZTJJ/NmTw/Tm1SfoSOqGlbfnc1sFd8KTeor2EEd6HgGoxNQEY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(366004)(376002)(346002)(136003)(316002)(86362001)(6916009)(26005)(36756003)(186003)(6486002)(6506007)(478600001)(2616005)(6512007)(4326008)(83380400001)(71200400001)(8676002)(91956017)(8936002)(2906002)(64756008)(66476007)(66946007)(5660300002)(54906003)(76116006)(66446008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: R7bvAnx3HtqkMx4Ecsn7+LT+SjmTxFu8EyCIKjYT8twhvFtYYZIHxYPAj9uUOoiQCtwKh6vK/O188MTumJ+P24A3vAJw+ToE5vxMz7DgWNee1X0f2Ph1Lxb/6DJz0CZj7f5GpOblC0f0NNcJwkOlZx3p6uYOdEv8bC1N7OvVk+805irmYXrBPSZiy9pD/RqMUy4GVXbu4xG5hwTJpZ2kWjLzr9Sx9n5xN1vfM0KsiXhS0wWvHlQ0xHqMlZOQ93WjqZ7pgrk5c/nqEJEshmLPefz33GMqxFZo5GEKB9rZJBHHAW/SKj7p7fUVWNgEMYiCrO0kQtSqGIt6E6H0j1e8OO/YMwHDwfk9R0HxhhGumx4NAidnVC7bGnBaeV6wIncii+lhXghq3Y/1vilI40LbiIYjZ8cCGR5VaghXvThAiCeLBemMswyS/qatQRyTaPxWNVnTuGBv7mFRt5ms1L5pCeVVRLeA4AzmD0A71XwlY8lwvUclSa5BttBHbbo4x/SNfH7XLyJ+G2iy147uu4JrJtRMd2CRah2wda6/WimFztgLL223gltEg1K8wj+y5DeK8ZEhpzglIWiX7r91pB+kx0tQhdtfyswR60qfNDSCb4KwkkXLT/6hyPkVgGEMJNa7H8NOnIq2xA0A6JR//A1bTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA1748092C4D824DAA8D0567E77E693A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877aff4d-b35e-4c53-febc-08d854e90e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 17:52:01.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyMvD5msUNxL+82zui55P45i7cN3y6qOEhTUW+SR24diK+0lJ03zgjIYby/UB/z1KqR0NRjAeNI03b8i8XqmGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3245
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgZDAxMmE3MTkw
ZmMxZmQ3MmVkNDg5MTFlNzdjYTk3YmE0NTIxYmNjZDoNCg0KICBMaW51eCA1LjktcmMyICgyMDIw
LTA4LTIzIDE0OjA4OjQzIC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy90cm9uZG15L2xp
bnV4LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuOS0yDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byA4YzZiNmM3OTNlZDMyYjhmOTc3MGViY2RmMWJhOTlhZjQyM2MzMDNiOg0KDQogIFNV
TlJQQzogc3RvcCBwcmludGsgcmVhZGluZyBwYXN0IGVuZCBvZiBzdHJpbmcgKDIwMjAtMDktMDUg
MTA6Mzk6NDEgLTA0MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCk5GUyBjbGllbnQgYnVnZml4ZXMgZm9yIExpbnV4
IDUuOQ0KDQpIaWdobGlnaHRzIGluY2x1ZGU6DQoNCkJ1Z2ZpeGVzOg0KLSBGaXggYW4gTkZTL1JE
TUEgcmVzb3VyY2UgbGVhaw0KLSBGaXggdGhlIGVycm9yIGhhbmRsaW5nIGR1cmluZyBkZWxlZ2F0
aW9uIHJlY2FsbA0KLSBORlN2NC4wIG5lZWRzIHRvIHJldHVybiB0aGUgZGVsZWdhdGlvbiBvbiBh
IHplcm8tc3RhdGVpZCBTRVRBVFRSDQotIFN0b3AgcHJpbnRrIHJlYWRpbmcgcGFzdCBlbmQgb2Yg
c3RyaW5nDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCkNodWNrIExldmVyICgyKToNCiAgICAgIHhwcnRyZG1hOiBSZWxl
YXNlIGluLWZsaWdodCBNUnMgb24gZGlzY29ubmVjdA0KICAgICAgTkZTOiBaZXJvLXN0YXRlaWQg
U0VUQVRUUiBzaG91bGQgZmlyc3QgcmV0dXJuIGRlbGVnYXRpb24NCg0KSi4gQnJ1Y2UgRmllbGRz
ICgxKToNCiAgICAgIFNVTlJQQzogc3RvcCBwcmludGsgcmVhZGluZyBwYXN0IGVuZCBvZiBzdHJp
bmcNCg0KT2xnYSBLb3JuaWV2c2thaWEgKDEpOg0KICAgICAgTkZTdjQuMSBoYW5kbGUgRVJSX0RF
TEFZIGVycm9yIHJlY2xhaW1pbmcgbG9ja2luZyBzdGF0ZSBvbiBkZWxlZ2F0aW9uIHJlY2FsbA0K
DQpUcm9uZCBNeWtsZWJ1c3QgKDEpOg0KICAgICAgTWVyZ2UgdGFnICduZnMtcmRtYS1mb3ItNS45
LTEnIG9mIGdpdDovL2dpdC5saW51eC1uZnMub3JnL3Byb2plY3RzL2FubmEvbGludXgtbmZzDQoN
CiBmcy9uZnMvbmZzNHByb2MuYyAgICAgICAgICAgfCAxMSArKysrKysrKystLQ0KIG5ldC9zdW5y
cGMvcnBjYl9jbG50LmMgICAgICB8ICA0ICsrLS0NCiBuZXQvc3VucnBjL3hwcnRyZG1hL3ZlcmJz
LmMgfCAgMiArKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
