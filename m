Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7738D15F8CF
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387682AbgBNVfw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:35:52 -0500
Received: from mail-mw2nam12on2060.outbound.protection.outlook.com ([40.107.244.60]:9761
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387640AbgBNVfw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 Feb 2020 16:35:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOtZSqmfh3cxUzbprf5gLxXzt+PlSBu/ZQN5IvGnnUjoQoJzOX896R32Xvrj64z8hc66z4vz4CMHusc3vjHEu4nuqk1s7P+pw0WU1enF7yoBBRm0mm+N7eAXa74FZIYZ9K7fn3xyC/E9tVYOZT7nkejnMSXAhoujOQdlDJoAhBSmb3I0/HzshRO78zYIzP/WXGSzEqMJ32awOJcGFKpmRIQ5ANydiymxZBSFGgroquOE7eNhOhTeIrO9XXB2BNDCk6AfzXtXKDIVFfvmb0nr2dmwvSgHc2Gn5VWeKaXz5P6esNUnCXgrggHciOOoKYmb56NoN5aoqEmQIWeM+WQEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvdmugYPqvZ/gt5MtSFdwgK8OG16OAsXlrqdDZHyGHo=;
 b=T0ex2OtB/FiPd3k/14HbGTvsj9J4YAtgay1kWqIpA+FLzQM7TrFqT38SgupBS2grV5AVjpbhxTPEI98BZnpUUSvdH+9ENbPPny2EiQooR3eemnATGKXkcfE4KkhE//mwVLd1U2HNXl31tz8xqUnSb77XwCP/UOz87akJEQxvAVi3WmcCfAvltYk1rzmBIF5D0YhjWnmsTi93JpUlidgKb5SRStnPELTLVdJZTz/SDWYPrXHTCBL04CMD7v6Cv7ZZA3ZCUkHdw+pOngKecz2CJf1IvbLwxtCcWZx93Ls0V6aDoS17JhCkz6BFGOJY+Owe6wyCFbpp/UIddg2/eMLDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvdmugYPqvZ/gt5MtSFdwgK8OG16OAsXlrqdDZHyGHo=;
 b=nYE7UEpvVOTZpnC2E1Pwj7dlJaPdvqBz5Eo4bsgEEYvSgNSUoQo0kprFzHLwoB1I3kxcpT9PUkVDIX7ScYs+zLEIfzaonlJ4kzglsmk9PbWMG2CXCDObfCHj8yd+suuRzHhz11wm3X5VgCWPlqTXh6jXDTFZdgIqA2HeZ+AvnQA=
Received: from DM6PR06MB6091.namprd06.prod.outlook.com (20.179.161.77) by
 DM6PR06MB3881.namprd06.prod.outlook.com (20.176.71.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Fri, 14 Feb 2020 21:35:50 +0000
Received: from DM6PR06MB6091.namprd06.prod.outlook.com
 ([fe80::f1f3:b30c:a1bc:ad26]) by DM6PR06MB6091.namprd06.prod.outlook.com
 ([fe80::f1f3:b30c:a1bc:ad26%6]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 21:35:50 +0000
From:   "Schumaker, Anna" <Anna.Schumaker@netapp.com>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Please pull NFS client bugfixes for 5.6-rc2
Thread-Topic: [GIT PULL] Please pull NFS client bugfixes for 5.6-rc2
Thread-Index: AQHV4365zRjAbqeDq0G+M1+kK6bZTQ==
Date:   Fri, 14 Feb 2020 21:35:50 +0000
Message-ID: <9a7d05a2d486fd39295c82c0673537359bc407f4.camel@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
x-originating-ip: [68.32.74.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b2ec616-a2f1-4a2e-2d38-08d7b195dc6a
x-ms-traffictypediagnostic: DM6PR06MB3881:
x-microsoft-antispam-prvs: <DM6PR06MB38810A4AC3C51714CCC33645F8150@DM6PR06MB3881.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(199004)(189003)(54906003)(81166006)(478600001)(81156014)(2906002)(8676002)(8936002)(36756003)(86362001)(71200400001)(6512007)(66556008)(66446008)(64756008)(91956017)(4326008)(6916009)(316002)(186003)(26005)(6486002)(2616005)(6506007)(66476007)(5660300002)(66946007)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB3881;H:DM6PR06MB6091.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UI0TfyBC3oqxL+uchO/VnzkxOIEI9eVdhtXO50VRJwEK+IoI1E8ZBwrIOM6jQwpdf0PJ6zQx1CXvxcDFGCnBebYG6UPasMce29GlxrTFOMkS+ePsvGB8oVu0e83m+sNydGEYK/7jO6VyZfJyXI0r1ZgOfbgUYVHoHCcVAqfmqtSdMn2hz7Onl1XgBcTSh9v2aTdN5N4nJkuF4n+fGKCQfLRIQzs+37H8NPt537U13p8hPqJ1BrTCI4A3rBNqvekSLTnnGB2L0FSfciAEtk+okDWYlyhYZpBgQvNOi31xETZNCPtmDWYEIoidLawlaIdjP5rELbX/UMHst7QhoxUEajTi2spa4A0U+NBG/laish9pisDozu3ddPLiDTt2Dfu+NZrj/krb6Id8LqFlVzRinpqemNWIRTjtwmKACbUDXzgmSNLEr5+dWJczdBBaQnCb
x-ms-exchange-antispam-messagedata: nlkGL947gFcfehF7MQUopWqADOplsELfP2C5pNjED2VD1v/4Y2zNDitufFWhMu4aJ5jH8TuFBdmmfh/EOxNw7RxpmmjPz+CG0GQif6m9YNVCpgbRVw19De2DQtcbsqf4Lw2Dd8WB41rdzryx0/cTlA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D42F7A2923C3B041BAFCF3CE6D1B7976@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2ec616-a2f1-4a2e-2d38-08d7b195dc6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 21:35:50.1904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScBFAb4Wg/E/WDRF5jn98ZvH7p+cKtyxPwYLv4H3PpMQ9M7aqjeU/k3E8CTIT1KbBZPOTkB/rv49EbKOxGcxeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB3881
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgTGludXMsDQoNClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgYmI2ZDNmYjM1
NGM1ZWU4ZDZiZGUyZDU3NmViNzIyMGVhMDk4NjJiOToNCg0KICBMaW51eCA1LjYtcmMxICgyMDIw
LTAyLTA5IDE2OjA4OjQ4IC0wODAwKQ0KDQphcmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3Np
dG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQubGludXgtbmZzLm9yZy9wcm9qZWN0cy9hbm5hL2xpbnV4
LW5mcy5naXQgdGFncy9uZnMtZm9yLTUuNi0yDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1
cCB0byA1ZDYzOTQ0ZjgyMDZhODA2MzZhZThjYjRiOTEwN2QzYjQ5ZjQzZDM3Og0KDQogIE5GU3Y0
OiBFbnN1cmUgdGhlIGRlbGVnYXRpb24gY3JlZCBpcyBwaW5uZWQgd2hlbiB3ZSBjYWxsIGRlbGVn
cmV0dXJuICgyMDIwLTAyLQ0KMTMgMTY6MjM6MDIgLTA1MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NClRoZSBvbmx5
IHN0YWJsZSBmaXggdGhpcyB0aW1lIGlzIHRoZSBETUEgc2NhdHRlci1nYXRoZXIgbGlzdCBidWcg
Zml4ZWQgYnkgQ2h1Y2suDQpUaGUgcmVzdCBmaXggdXAgcmFjZXMgYW5kIHJlZmNvdW50aW5nIGlz
c3VlcyB0aGF0IGhhdmUgYmVlbiBmb3VuZCBkdXJpbmcNCnRlc3RpbmcuDQoNClRoYW5rcywNCkFu
bmENCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KQ2h1Y2sgTGV2ZXIgKDEpOg0KICAgICAgeHBydHJkbWE6IEZpeCBETUEg
c2NhdHRlci1nYXRoZXIgbGlzdCBtYXBwaW5nIGltYmFsYW5jZQ0KDQpPbGdhIEtvcm5pZXZza2Fp
YSAoMSk6DQogICAgICBORlN2NC4xIG1ha2UgY2FjaGV0aGlzPW5vIGZvciB3cml0ZXMNCg0KVHJv
bmQgTXlrbGVidXN0ICg1KToNCiAgICAgIE5GUzogRml4IHVwIGRpcmVjdG9yeSB2ZXJpZmllciBy
YWNlcw0KICAgICAgTkZTdjQ6IEZpeCByYWNlcyBiZXR3ZWVuIG9wZW4gYW5kIGRlbnRyeSByZXZh
bGlkYXRpb24NCiAgICAgIE5GU3Y0OiBGaXggcmV2YWxpZGF0aW9uIG9mIGRlbnRyaWVzIHdpdGgg
ZGVsZWdhdGlvbnMNCiAgICAgIE5GU3Y0OiBFbnN1cmUgdGhlIGRlbGVnYXRpb24gaXMgcGlubmVk
IGluIG5mc19kb19yZXR1cm5fZGVsZWdhdGlvbigpDQogICAgICBORlN2NDogRW5zdXJlIHRoZSBk
ZWxlZ2F0aW9uIGNyZWQgaXMgcGlubmVkIHdoZW4gd2UgY2FsbCBkZWxlZ3JldHVybg0KDQogZnMv
bmZzL2RlbGVnYXRpb24uYyAgICAgICAgICAgIHwgIDUwICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCi0tLS0tLS0tLS0NCiBmcy9uZnMvZGVsZWdhdGlvbi5oICAgICAg
ICAgICAgfCAgIDEgKw0KIGZzL25mcy9kaXIuYyAgICAgICAgICAgICAgICAgICB8IDEyNg0KKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCisrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0NCiBmcy9uZnMvaW5vZGUuYyAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGZz
L25mcy9uZnM0ZmlsZS5jICAgICAgICAgICAgICB8ICAgMSAtDQogZnMvbmZzL25mczRwcm9jLmMg
ICAgICAgICAgICAgIHwgIDIwICsrKysrKysrKysrKysrKysrLS0tDQogaW5jbHVkZS9saW51eC9u
ZnNfZnMuaCAgICAgICAgIHwgIDI2ICsrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tDQogbmV0L3N1
bnJwYy94cHJ0cmRtYS9mcndyX29wcy5jIHwgIDEzICsrKysrKystLS0tLS0NCiA4IGZpbGVzIGNo
YW5nZWQsIDE4OCBpbnNlcnRpb25zKCspLCA1MCBkZWxldGlvbnMoLSkNCg==
