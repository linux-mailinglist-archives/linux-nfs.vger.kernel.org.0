Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B3714CFF4
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgA2R4C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 12:56:02 -0500
Received: from mail-mw2nam12on2127.outbound.protection.outlook.com ([40.107.244.127]:21243
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbgA2R4C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Jan 2020 12:56:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5wm3tBU5IHzhr3t9nrCHfiYq5Ifs05Ndmd4DzKrr/qJnykF0EpvHDUqjGiH6Qtgiak/o6thYT17xMM2sReTgyCZzQa5ICAy6wRufkvPPqKbpTc9qub2yH7qNAA5vylBbfHlMEihKZ8eHfEmj8m/+0nn2KhWgtyZvMFnGayzg/S4/j4UYLLiMTUvButPIAMzcwCPivsdqSOU7yvGSgO9J9zHxnPdxbr6piHT6KTYc1NExM0STxmNqPP6bNeXy0AVc9GyWU0s3YFmykFcYA/qmoTufi06KxX52H0uGOTxAvxK8hHnJ9eEDdpaR1WOzfPvA1LuUlBNIFccdeOYFB9eCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzl8ZcvRmnWHBR0QYggAjdTxi0X4oRbq7y98Gc5JVqk=;
 b=YbqEjA/wIJymxtmL/Tz4832dqd2Edoev840Gyy3/8MrjF0u7k5bIJcWqqIoo0O9aPHtKLBDW2Wn9zYlbhxhx70n558J26DyMWd+d5r/vWzJAo8CNI5kxX9P7bINrc+nMLpYrx2q8scudY5f36596tPnd5SNBjhgtuRpuBYF+84N1yoJ1bhtq639tWtNXeINhAA+HAxXV4cfNxmYjssR1f1NPhdHnFpjzwgxzigvB2DAcn4C1WuCTwKpK0lgzZI/6BQP0CPTRF3N7G/1Ta5SONIZeJrs+M9dsFmCnyRyXTQIjz4SmQedjs/PKCA6xWluzPlUD3l4TEodwzd7NkjUCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzl8ZcvRmnWHBR0QYggAjdTxi0X4oRbq7y98Gc5JVqk=;
 b=LdkHkaRyNNwmtopSVxHKn8v7dgn58AjqyrJc2u0e1PephHT9MBhDcGunSLaekP/amnsKB+Fr7IpSoYmXNU+VxdsAVOlphjPOHp3GpJGHG+haITpc1Bez/5DtYRbyoZF1NK6VtGvOJeHfIpB/zA9+071+IT/PvsyX6EH2GcnTn88=
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com (10.174.186.34) by
 DM5PR1301MB1978.namprd13.prod.outlook.com (10.174.184.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.10; Wed, 29 Jan 2020 17:55:57 +0000
Received: from DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344]) by DM5PR1301MB2108.namprd13.prod.outlook.com
 ([fe80::9449:ded8:d7b:a344%3]) with mapi id 15.20.2686.019; Wed, 29 Jan 2020
 17:55:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "aglo@umich.edu" <aglo@umich.edu>
Subject: Re: question about nconnect implementation
Thread-Topic: question about nconnect implementation
Thread-Index: AQHV1sdJiuGC/HdPKESiM+O4uyf5N6gB7ScA
Date:   Wed, 29 Jan 2020 17:55:57 +0000
Message-ID: <5a923d18a740e0bc161a0a3bf689cd14416f8c21.camel@hammerspace.com>
References: <CAN-5tyGoKOQzPHjTikO4ScPGe7eyob5pLOH7JM3MfgFG1W7eDQ@mail.gmail.com>
In-Reply-To: <CAN-5tyGoKOQzPHjTikO4ScPGe7eyob5pLOH7JM3MfgFG1W7eDQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a20f266-fd9a-4eab-6469-08d7a4e47e5b
x-ms-traffictypediagnostic: DM5PR1301MB1978:
x-microsoft-antispam-prvs: <DM5PR1301MB1978F669D7EBB3B403595433B8050@DM5PR1301MB1978.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(5660300002)(6506007)(110136005)(316002)(86362001)(8936002)(36756003)(6486002)(76116006)(66476007)(66556008)(64756008)(66446008)(2906002)(66946007)(6512007)(8676002)(81166006)(81156014)(478600001)(26005)(3480700007)(186003)(2616005)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1301MB1978;H:DM5PR1301MB2108.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J6uA/x8kT2GuZLFDUrgSRZH5fmoqag6/gB3fs0hy2JJ6BueyirhUhpW5ZZO5Fcu/Gf6O4uFcquwKH0LSGiBzLj0NMlrnrPY7ogKynKP9vSZ2+R97kUo0PP5l3+jdjVSMXIL5eogVcg3PlID0T1sFTzirVdoNG2tjDtoGdSHTD+u5GYtes4MNJO6RAY7jdzaDq6APJx2vkjAZOTk5y9Ep+Oprxn+Vfhos71uC7N39RDVDDGHNBAx7HGZ7F/GAJv51aAmS1j/8iXchSoSt6OFScZuny+MYThejHrCEzS4Ss8InABdzgdvTtlo40AnmNVWAvYDSzfwAW4OWBpJUYSlyAot1fGm9VLShPm6o3RAkwEJLbpefm1WjbaM3bWFmliwApFeK08L5QeK7YhPrrc0nbbOQ2+IcYX5u33ukpKBFvahSO8nwQJwZ9hmhvdmVQcDb
x-ms-exchange-antispam-messagedata: N7vDLz5gSCuIjOuvDIC4/mINRyWKS5O6m+KTTL4UsPqBXgcwYH9hiBdoKltZ57Hkoz+0AKY+B+gR2u7gpodzDRhkAjBb4M6eU6qEDhMMGXm1v/QNNEeJbpUuk6TFMbrHeXhxcKbXXBb0dDAtwXvrYw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F6C05FDB2B4A5438E91766BDED3B7E2@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a20f266-fd9a-4eab-6469-08d7a4e47e5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 17:55:57.4882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFz9RU5f3z99fQvz5XihOCu8e4L/BTx7N5kiotZEByHLIQjKGj8WLmrNUbibR15edNxITsavdDimSkMR816w6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB1978
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTI5IGF0IDEyOjEyIC0wNTAwLCBPbGdhIEtvcm5pZXZza2FpYSB3cm90
ZToNCj4gSGkgVHJvbmQsDQo+IA0KPiBDb3JyZWN0IG1lIGlmIEknbSB3cm9uZyBidXQgSSBiZWxp
ZXZlIGN1cnJlbnRseSB0aGUgY2xpZW50IHdpbGwgbmV2ZXINCj4gYmluZCBuZXcgKG5jb25uZWN0
KSBjb25uZWN0aW9ucyB0byBhbiBleGlzdGluZyBzZXNzaW9uIHVudGlsIGl0IGdldHMNCj4gYW4g
ZXJyb3IgQ09OTl9OT1RfQk9VTkRfVE9fU0VTU0lPTiwgaXMgdGhhdCBjb3JyZWN0Pw0KPiBuZnM0
X3Byb2NfYmluZF9jb25uX3RvX3Nlc3Npb24oKSB0aGF0IGl0ZXJhdGVzIG92ZXIgdGhlIHRyYW5z
cG9ydHMgaXMNCj4gb25seSBjYWxsZWQgbmZzNHN0YXRlJ3MgbmZzNF9iaW5kX2Nvbm5fdG9fc2Vz
c2lvbiB3aGVuIGNsX3N0YXQncyBmbGFnDQo+IG9mIEJJTkRfQ09OTl9UT19TRVNTSU9OIGlzIHNl
dCBhbmQgaXQncyBzZXQgb24gZXJyb3IgaGFuZGxpbmcgb2YNCj4gQ09OTl9OT1RfQk9VTkQuDQo+
IA0KPiBJcyB0aGUgcmVhc29uIGNsaWVudCBub3QgZXhwbGljaXRseSBzZW5kaW5nIEJJTkRfQ09O
Tl9UT19TRVNTSU9ODQo+IGJlZm9yZSBzZW5kaW5nIG90aGVyIG9wZXJhdGlvbnMgaXMgYmVjYXVz
ZSBjbGllbnQgKGltcGxlbWVudHMpDQo+IHNwZWNpZmllcyAibm8gc3RhdGUgcHJvdGVjdGlvbiIg
Zm9yIHRoZSBjbGllbnQ/IEFuZCBhY2NvcmRpbmcgdG8gdGhlDQo+IHNwZWMgaWYgbm8gc3RhdGUg
cHJvdGVjdGlvbiBpcyB1c2VkIHRoZW4ganVzdCBzZW5kaW5nIGEgU0VRVUVOQ0Ugb24gYQ0KPiBu
ZXcgY29ubmVjdGlvbiBpcyBzdWZmaWNpZW50IHRvIGNyZWF0ZSBhbiBhc3NvY2lhdGlvbiBiZXR3
ZWVuIHRoYXQNCj4gY29ubmVjdGlvbiBhbmQgdGhlIHNlc3Npb24/DQo+IA0KPiBUaGFuayB5b3Uu
DQoNCkl0IGlzIHRoYXQsIGFuZCBpdCBpcyBhbHNvIGJlY2F1c2UgZGVzcGl0ZSBhbGwgdGhlIHZl
cmJpYWdlIGluIHRoZQ0KUkZDcywgbW9zdCBwZW9wbGUgYXJlIHVzaW5nIE5GU3Y0Lnggd2l0aCBB
VVRIX1NZUywgZm9yIHdoaWNoIHdlIHVzZQ0KU1A0X05PTkUgcHJvdGVjdGlvbi4gVGhhdCBkb2Vz
IG5vdCByZXF1aXJlIHVzZSBvZiBCSU5EX0NPTk5fVE9fU0VTU0lPTg0Kd2l0aCBuZXcgY29ubmVj
dGlvbnMuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWlu
ZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
