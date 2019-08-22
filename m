Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D943C9A285
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2019 00:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfHVWCQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Aug 2019 18:02:16 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:26298 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729667AbfHVWCQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Aug 2019 18:02:16 -0400
IronPort-SDR: hvaFJw9taW97l+xRKwJonTIhQeemHVR2EM8IikRMNDYPuHpIaD+Gq88ae6ROJOGQlx2ypZMV5a
 o3ZTJfwjGpb10d6bMZXAXgNJd9VBpPAf29WdWjUuyzc//m+srDJogR/oshjyYpWArc+lDHhgu0
 zhO02VgsDGSfu7a3GYaHSjJARRmGofgjEZhNy3XOKFr4M7qCNWKdRzxUgPBX8wEKxMP2y7+nWm
 mZz+9SACxpZ2IG4IunbX5v+zqlkFYUx/MpE17gOS7osgrQm/v9eoi+inYc48fP7vtR17VDl3nQ
 8l0=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 150097043
IronPort-PHdr: =?us-ascii?q?9a23=3ABHCawhN4TDuOccKMWNEl6mtXPHoupqn0MwgJ65?=
 =?us-ascii?q?Eul7NJdOG58o//OFDEu6g/l0fHCIPc7f8My/HbtaztQyQh2d6AqzhDFf4ETB?=
 =?us-ascii?q?oZkYMTlg0kDtSCDBjjI/nncz4SGc1eVBl443yrOFMTFcrjNBXf?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EnAABxEF9dhzMiL2hlGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBZ4FFUIFlBAsqCoQWg0cDhTKFPIJcmjgDGDwBCAEBAQEBAQE?=
 =?us-ascii?q?BAQcBLQIBAQKEPQIXgmw4EwIJAQEFAQEBAQEGBAICEAEBAQgNCQgphTQMg0U?=
 =?us-ascii?q?5MgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCODkBAQE?=
 =?us-ascii?q?DEhERDAEBNwEPAgEIGAICJgICAjAVEAIEDgUigwCBawMdAZ90PQJiAguBBCm?=
 =?us-ascii?q?IYAEBcoEygnsBAQWCR4JcGEIIgUwJgQwojAEGgUE+gTiCaz6ELhaDC4JYjxi?=
 =?us-ascii?q?cSAkCgh2MHIgbBhuCMYtJilCjIIJSAgQCBAUCDgEBBYFngXpyE4MngkIag1i?=
 =?us-ascii?q?KU0ABMYEpik4BgSABAQ?=
X-IPAS-Result: =?us-ascii?q?A2EnAABxEF9dhzMiL2hlGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?4FFUIFlBAsqCoQWg0cDhTKFPIJcmjgDGDwBCAEBAQEBAQEBAQcBLQIBAQKEP?=
 =?us-ascii?q?QIXgmw4EwIJAQEFAQEBAQEGBAICEAEBAQgNCQgphTQMg0U5MgEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCODkBAQEDEhERDAEBNwEPA?=
 =?us-ascii?q?gEIGAICJgICAjAVEAIEDgUigwCBawMdAZ90PQJiAguBBCmIYAEBcoEygnsBA?=
 =?us-ascii?q?QWCR4JcGEIIgUwJgQwojAEGgUE+gTiCaz6ELhaDC4JYjxicSAkCgh2MHIgbB?=
 =?us-ascii?q?huCMYtJilCjIIJSAgQCBAUCDgEBBYFngXpyE4MngkIag1iKU0ABMYEpik4Bg?=
 =?us-ascii?q?SABAQ?=
X-IronPort-AV: E=Sophos;i="5.64,418,1559538000"; 
   d="scan'208";a="150097043"
X-Utexas-Seen-Outbound: true
Received: from mail-by2nam01lp2051.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.51])
  by esa12.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:02:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2LyfouIe/TsFQeTfsAL3fSpDm/rlhyoBjsMT7HIWYa8aGcl0/8Wl0UqoCCY2BFfexILjA0y5DFJf6wefmjYXrJb7tJzVyCMtoVz/OHRCJFdOIsWAf7uoLWHEEls4vopfuO1RQui2dR2iM6/VAXCgkQngJYmZceoV/YtGiI6vNRHfFxxV6dqXZtzt9mXhROzXCfKkHFS5YEwvTtFTeZvjRcwZxtdyC1filOQKUZwHq5Qya3PCOLZUPHESG6j9yL9H+OIEv7+SCD2Dk7Qo8PY4eIoxugsila3VH0IMmkBLcSPbYuU15MVUvKSHkQB1/Ppu9cm2hARn8FBI25IcU97ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TlbB+XF00zudr9vEsj6ktVmse9IM9pSoaBXIRIcUuQ=;
 b=VpBA19OomMOdQlR8yTxCIufXQJv9/mjWsQBqCk+NsJYrxclaV2+pdQZD8NOrgc+6cizkaJtLRWWVO0PKzknmOzPRkI2AFi9wT8tplrf/Ge2crkkggz8RTGiMGyMJfw1t8Bi+CE5LRhthNHzVzfQjRgp2QJNZx3UBKI99gBoEvwlqifSwA44MNxJr7vkz6nMfj4az/GZ640ObcdR5GzO6pxuAf0hNeAnr4oZ84HdS0D9LzO1T1InFr7b8ZxLqG5wwpEHD/Lf9tLeUckyoFfoO3xBa940MiZhwnxWkbdHuf5I0dhxy73B6nj2afY7xweHTO/E3whP8/yzabZZzqqggsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector2-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TlbB+XF00zudr9vEsj6ktVmse9IM9pSoaBXIRIcUuQ=;
 b=V6cYrLk61J87NJDEJuiHSKnJshy+BmBYtJsB24fC9zFaDOGmO3OErqyaVZJGTTMLRdYf6qOEFhheegkaariXfauDZ+fnEDHPP+Ry4yoMeCMlDpCl9pffl+GWt7+TsQqbNHbLxmxyVNEzVpuClPRR7xMwxnhsTPT88tIvitb3KeA=
Received: from DM5PR0601MB3606.namprd06.prod.outlook.com (10.167.108.144) by
 DM5PR0601MB3654.namprd06.prod.outlook.com (10.167.108.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Thu, 22 Aug 2019 22:02:14 +0000
Received: from DM5PR0601MB3606.namprd06.prod.outlook.com
 ([fe80::6dec:6d3b:c9d9:7a41]) by DM5PR0601MB3606.namprd06.prod.outlook.com
 ([fe80::6dec:6d3b:c9d9:7a41%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 22:02:14 +0000
From:   "Goetz, Patrick G" <pgoetz@math.utexas.edu>
To:     Daniel Kobras <kobras@puzzle-itc.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Does NFSv4 translate POSIX ACL's?
Thread-Topic: Does NFSv4 translate POSIX ACL's?
Thread-Index: AQHVV4YD8bGOXAW/2kOmYaroxDGJAqcEaAiAgANTaoA=
Date:   Thu, 22 Aug 2019 22:02:14 +0000
Message-ID: <3db56f4d-9e7c-bb67-4de4-e723e20a9cb7@math.utexas.edu>
References: <87bee5fc-5461-01b2-ad9d-9c60e86396c1@math.utexas.edu>
 <224D3569-14EA-4533-A5DC-CD4903EF4772@puzzle-itc.de>
In-Reply-To: <224D3569-14EA-4533-A5DC-CD4903EF4772@puzzle-itc.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CH2PR12CA0002.namprd12.prod.outlook.com
 (2603:10b6:610:57::12) To DM5PR0601MB3606.namprd06.prod.outlook.com
 (2603:10b6:4:7c::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgoetz@math.utexas.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.83.133.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 623aecb9-1d3d-41e4-c7f6-08d7274c63a6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR0601MB3654;
x-ms-traffictypediagnostic: DM5PR0601MB3654:
x-microsoft-antispam-prvs: <DM5PR0601MB36545E821005CFC6B594337F83A50@DM5PR0601MB3654.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(189003)(6512007)(14454004)(786003)(316002)(229853002)(186003)(6486002)(6436002)(446003)(86362001)(81166006)(66066001)(4326008)(31696002)(81156014)(8676002)(11346002)(14444005)(2616005)(256004)(76176011)(476003)(6246003)(2906002)(88552002)(486006)(8936002)(53936002)(52116002)(4744005)(66446008)(64756008)(66556008)(305945005)(66476007)(99286004)(7736002)(102836004)(478600001)(25786009)(75432002)(6916009)(6506007)(6116002)(31686004)(3846002)(386003)(71190400001)(71200400001)(26005)(53546011)(66946007)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0601MB3654;H:DM5PR0601MB3606.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: math.utexas.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YNyGxT/p4x9zhyCWZPYTnJDZEbAzPouZxgTE49nm0fxS7j/OJoEJya5h8fLNEICVh+JBHJHqaYeLO2RZKVClNcQeSHYG5izbHV/9seY0g8+FMYFHchaut7gaiXprxbkxC96wOTzvReEk1aitbhRwbvtV8DoNvAx5UvRy+tpxpvF3bHvV/KsWQH6n2LGhrHOfi0L0nyWV6bcjdpT3gXfb5oVfxK13gBBKWEyBM/JDz1MjzwQ7ei0DXacmRIsXzZIRMbJFnmWFZG4o531f/lFICISNX+qnFoujS4WhsJNgl96El5p5HXBfhZMDVxaPjwgZfjQTA0MDqfPjHlGdfkTr3sOMp0PzGxKmXlR6L4WI3jy+m2vIDVnurwtzUZKhoMRn6j+RWIa81srRSzj4Gf9EnMB5JM2XmfmqMnMdpw1bVww=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3645774F9D1AF41A7F9F782A0B87DD7@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 623aecb9-1d3d-41e4-c7f6-08d7274c63a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 22:02:14.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63vllROsTU7dJxy1QMlraLKf54RzAOodk6tjziEQqKaM93UeD+fa65uz/QRoQYXyN6xyOEOjVBbCDclBUqC8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3654
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgRGFuaWVsIC0NCg0KVGhhbmtzIHNvIG11Y2ggZm9yIHlvdXIgaGVscCEgIFRoYXQgd2FzIGlu
ZGVlZCB0aGUgcHJvYmxlbS4gIEkgZGlkbid0IA0KcmVhbGl6ZSB0aGF0IGRlZmF1bHQgQUNMJ3Mg
ZG9uJ3QgY291bnQgYXMgYWN0aW9uYWJsZSBBQ0wncyAob3RoZXIgdGhhbiANCnRvIGRpY3RhdGUg
YXV0aG9yaXphdGlvbiBmb3IgbmV3IHN1Yi1kaXJlY3RvcmllcyBhbmQgZmlsZXMpLg0KDQoNCk9u
IDgvMjAvMTkgMjoxNCBQTSwgRGFuaWVsIEtvYnJhcyB3cm90ZToNCj4gSGkhDQo+IA0KPj4gQW0g
MjAuMDguMjAxOSB1bSAyMDozNSBzY2hyaWViIEdvZXR6LCBQYXRyaWNrIEcgPHBnb2V0ekBtYXRo
LnV0ZXhhcy5lZHU+Og0KPj4NCj4+IEkgaGF2ZSBhbiBORlN2NCBleHBvcnRlZCBmb2xkZXIgKGJh
c2UgZmlsZXN5c3RlbTogWEZTKSB3aGljaCBtdXN0IGFmZm9yZA0KPj4gcmVhZCBhY2Nlc3MgdG8g
YSBwcm9ncmFtIG9uIGZvbGRlcnMgd2hpY2ggYXJlIG90aGVyd2lzZSBoaWRkZW4gZnJvbSB0aGUN
Cj4+IHB1YmxpYy4gIE9uIHRoZSBORlMgc2VydmVyOg0KPj4NCj4+ICAgIHJvb3RAa3Jha2VuOi9F
TS9FTXRpZnMjIGdldGZhY2wgcGdvZXR6DQo+PiAgICAjIGZpbGU6IHBnb2V0eg0KPj4gICAgIyBv
d25lcjogcGdvZXR6DQo+PiAgICAjIGdyb3VwOiBjbnMtY25zaXRsYWJ1c2Vycw0KPj4gICAgdXNl
cjo6cnd4DQo+PiAgICBncm91cDo6ci14DQo+PiAgICBvdGhlcjo6LS0tDQo+PiAgICBkZWZhdWx0
OnVzZXI6OnJ3eA0KPj4gICAgZGVmYXVsdDp1c2VyOmNyeW9zcGFyY191c2VyOnIteA0KPj4gICAg
ZGVmYXVsdDpncm91cDo6ci14DQo+PiAgICBkZWZhdWx0Om1hc2s6OnIteA0KPj4gICAgZGVmYXVs
dDpvdGhlcjo6LS0tDQo+IA0KPiBUaGVyZeKAmXMgb25seSBhIGRlZmF1bHQgQUNMICh3aGljaCBp
cyBpbmhlcml0ZWQgdG8gbmV3IG9iamVjdHMpLCBidXQgbm8gcHJvcGVyIEFDTCBvbiB0aGUgZGly
ZWN0b3J5IGl0c2VsZi4gSGF2ZSB5b3UgdHJpZWQNCj4gDQo+ICAgIHNldGZhY2wgLW0gdTpjcnlv
c3BhcmNfdXNlcjpyeA0KPiANCj4gYWxyZWFkeT8NCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+
IERhbmllbA0KPiANCg==
