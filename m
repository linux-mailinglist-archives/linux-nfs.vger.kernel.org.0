Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C639B0FC4
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 15:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfILNZ6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 09:25:58 -0400
Received: from mail-eopbgr800093.outbound.protection.outlook.com ([40.107.80.93]:36768
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731879AbfILNZ6 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 09:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhPJRIVMMu3MuMs444ncOS4guMGWagPLky8HIQuMa2irjLRmuIjBmuXjg2DBPqhOr9JIN2YZdtzfG1vruMuJIUkXO5NP5n1h1LdX5qh6jBA9ou4JHk/W8XH2jGlp1Iz/6vw9bAObfMyyZSc/Sl2xIR6Efuk4KgE5ItyuRIim9Y0dm5aI6tzHBjcO7q2Hf5aZ2lvKzY8mC3qSKcsNo5IYhqPZEVk2iim0GbxwC+zR+UlsIFx8nEVB7L48PDTDACrf9jB/Dhyd1C9G6y9DQkprlMTflKLymwtMOD6TMbWyEI3Kzc8u0AOeHyzCBK5VL8fsQqkJrlNs0XYdl8WIxn5f7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDsJpJf8h+/NrNuQArehXk82KZVqr1IWaohKzKq0GqY=;
 b=cJ0UpPuP0vHvrfSU1wOZRkY9/sWF+LSx7BJ92n/tsO6SJ3EZegjxd3GACtTfqVF0j9ap3KkNbit2tXuRXVBy2cMhO1V0xZBEWrP34AYlVVUoGbZUwsDYezgXrwD59k6Z0o8eOeVNL0Tp3sxNz2RxKoK0xTmTZraDf9LP7DCqvCjn2q1xoHAMgG/IZ1pJUyPxYiXLlOs+/j+TFjwIBiUrsvY81Xoa8vi5ApQllM16q37K9WPBLrP+HOXFG6kT2LKv9suUCVFWZi85Ze31YyY6cjojwvt9Ps1/tVa0zqkE+RFFEwbve76WkVbE0swbK93x9CdUCUopKobPAOUUNwL7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDsJpJf8h+/NrNuQArehXk82KZVqr1IWaohKzKq0GqY=;
 b=WoQPVJxsWMFEIpUh1MPXoSiBUhub7SfUT7xwvg/laJYcf4zZNySYWBOTrb2giR4e0pir0pKJOj+jKR0XvYNp8Owie2Zu7JJDDxYe74REM2ZW6m6hHkigAFfgVQyWgaL/dAy8jzTxr87JrgAZmevClAZ9FNZeTf0KhtB1lwwHvmo=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1337.namprd13.prod.outlook.com (10.168.117.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.10; Thu, 12 Sep 2019 13:25:53 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 13:25:53 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "bcodding@redhat.com" <bcodding@redhat.com>
CC:     "tibbs@math.uh.edu" <tibbs@math.uh.edu>,
        "linux@stwm.de" <linux@stwm.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "km@cm4all.com" <km@cm4all.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: Regression in 5.1.20: Reading long directory fails
Thread-Topic: Regression in 5.1.20: Reading long directory fails
Thread-Index: AQHVUfDuoAq39fX+s0K+L+pluMBkM6cHnsTegAlOTYCAAAwCNIAJQZHggAAlEwCAABHoXoAAKhIAgABG1wuAA/3qgIAAZExXgAAA1wCAB5GfgIAAA/sAgAAM/YCAAADmAIAAAysAgAACpICAAAEVAIABN6+AgAAGjQCAAARdgIAAAW+AgAADUYA=
Date:   Thu, 12 Sep 2019 13:25:53 +0000
Message-ID: <db42c87ba2c5b0852ad42ba51792ee67ab036a37.camel@hammerspace.com>
References: <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
         <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
         <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
         <F1EC95D2-47A3-4390-8178-CAA8C045525B@oracle.com>
         <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
         <FAA4DD3D-C58A-4628-8FD5-A7E2E203B75A@redhat.com>
         <B8CDE765-7DCE-4257-91E1-CC85CB7F87F7@oracle.com>
         <EC2B51FB-8C22-4513-B59F-0F0741F694EB@redhat.com>
         <c8bc4f95e7a097b01e5fff9ce5324e32ee9d8821.camel@hammerspace.com>
         <57185A91-0AC8-4805-B6CE-67D629F814C2@redhat.com>
         <20190912131359.GB31879@fieldses.org>
In-Reply-To: <20190912131359.GB31879@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [50.36.167.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a308be1-7c78-43e2-8aa6-08d73784bcd2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR13MB1337;
x-ms-traffictypediagnostic: DM5PR13MB1337:
x-microsoft-antispam-prvs: <DM5PR13MB1337B25BCABEC6A811A2BC06B8B00@DM5PR13MB1337.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(136003)(39830400003)(366004)(199004)(189003)(102836004)(14444005)(6506007)(486006)(2906002)(446003)(5660300002)(4744005)(36756003)(2501003)(2616005)(11346002)(86362001)(478600001)(316002)(14454004)(3846002)(66066001)(110136005)(71190400001)(26005)(186003)(476003)(71200400001)(6116002)(7736002)(6246003)(81166006)(4326008)(305945005)(76176011)(6512007)(81156014)(53936002)(99286004)(256004)(229853002)(66946007)(6436002)(66476007)(54906003)(6486002)(64756008)(66556008)(118296001)(8936002)(66446008)(8676002)(25786009)(76116006)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1337;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M5Atlu+zFtev3aWQXoGvQip26lPfOMqfaI6FyByWmTJ0lGVbStwnp4yd+V/tcedHkc5xXKTvjkTOx+M9Q/KH26hJw4nwdZA9NlyCaZ93moF594d60ik8WWTcDgekUbt0V2uJapSAN3kNywrjG3iysjj58+p/nQ+z3nitpuwbwqDXl/3n4EFh4Hc6F9C0zUlo0Fs3pnHVnIRWUMSSeOIZPxAwSTwBDXQGGxNSG2imClMpkACX2U6HnoAzcEuC3HsIvrrdLjjFXqA7Mdy2mTYQBm6X6lx5ETpHnD34QW4tn3ey9GLxvrVhTz5x9VpA3W2OvraRJaoRfhgBS+3bFnKkfAbHOI07QrmogzilTi+AsjpgoH8idmPw5F4k6htvAOt8u7/i4BJR4r1tQiUBHp+UrFJVa+UkZ7K8WrHrCFrUBew=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD517F3422D8104CB56853EEB7D0EBF7@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a308be1-7c78-43e2-8aa6-08d73784bcd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:25:53.8300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va27BrFjY9VdpZyHzzMx5SEA94MBgqG2FHPuhlF2AbpahNT5VBDpXnkfma5RMfTM+W61NYRUYqDZQtLQiyHlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1337
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTEyIGF0IDA5OjEzIC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IChVbmxlc3MgSSdtIG1pc3Npbmcgc29tZXRoaW5nLiAgSSBoYXZlbid0IGxvb2tlZCBhdCB0
aGlzIGNvZGUgaW4gYQ0KPiB3aGlsZS4gIFRob3VnaCBpdCB3YXMgcHJvYmxlbSBtZSB0aGF0IHdy
b3RlIGl0IG9yaWdpbmFsbHktLWFwb2xvZ2llcw0KPiBmb3INCj4gdGhhdC4uLi4pDQo+IA0KDQpU
aGUgZnVuY3Rpb24gaXRzZWxmIGlzIGZpbmUuIEl0IHdhcyBqdXN0IHRoZSBuYW1lIEknbSBvYmpl
Y3RpbmcgdG8sDQpzaW5jZSB3ZSdyZSBhY3R1YWxseSBtb3ZpbmcgdGhlIGxhc3QgJ24nIGJ5dGVz
IGluIHRoZSBtZXNzYWdlIGluIG9yZGVyDQp0byBiZSBhYmxlIHRvIHJlYWQgdGhlbS4NCg0KLS0g
DQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3Bh
Y2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
