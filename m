Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1BB82D3
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2019 22:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388758AbfISUko (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Sep 2019 16:40:44 -0400
Received: from mail-eopbgr700132.outbound.protection.outlook.com ([40.107.70.132]:35328
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388726AbfISUko (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Sep 2019 16:40:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaeyuIiN/lYwF3Zn0G09nSKo6a6nZQIldUfEf72qEIhfFlsPQ724xn3C/5LYAm2BU7FhUhjwZfmO6Ow3F4GBcXfiNw2rEo5lGHh46Q32tYsTPfmShjFfnqfeZEuvyvM2E+dvnq6vRgWL0DOs3b4NoKsTS5Pzfqx/RV6iE+BLQLi3/Ptgvo/GE2s2zICPjNfB42pHXC/2EaVIFYC7uaMfRdr4ibNp3bqhlt4ZWvKfNQ2ed40vkiv3/EViyK5Y+JAUCcVHZVkByLqNOdmCSJPd3c9iZzdXk5lxIDo41EQlK1cLM+iOsWGGB09vndb6c56+5G0BZCbca+GlF/08z1qFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LINCoqMC4HicxiketZOoJctV4oI1Bi+KecR/K3ON49Y=;
 b=nZb35GJinh8h4O+BPjbbLGOVLYXcWWo10wZ2mz/HS0MXBsW4Sbc/EyFVlj9UPdUg44YyzWpnaQBuBbAe1OYJ6zkBbocGwuhV5sz2LXUkysJk8pk2IV2PxNX3hUgDOk42NxDlVxc9mUfCxgbuYG/a9r55K3Jq+5c9J3VQMJ7o3Q6e6NHTWeHR304iOE8XmWyc8C4b8KAUcLJavs7RPMtHbGwsGYZAw+DTEuRTX/YW0nmTKrj0qvJz63k3i00PrBw2gQCa0/tyegVKsjpvtI6OV+aOOO9ZK0iGljME4CyRu1tWpn2tnMbmr8TNYxLYqBa3tmpcc1LUEuf+iPCnVB4D+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LINCoqMC4HicxiketZOoJctV4oI1Bi+KecR/K3ON49Y=;
 b=Gxf+1vq/bG1y0YvI2Q9EcQlBVfkQ37FlX5F8HwrTiaK0k41N/KqslxsvlFhmZCBg7RGhhZND8ITHH/iuFptFA4b5exfmJ9yHx1Ji41FclTL0XPER/Vfi/VKGZLNITPTCjFxxU4exoqS0Z5Qq5twdGxDb3X1iLUgj9zedya5BAQ4=
Received: from DM5PR13MB1851.namprd13.prod.outlook.com (10.171.159.143) by
 DM5PR13MB1643.namprd13.prod.outlook.com (10.171.155.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.13; Thu, 19 Sep 2019 20:40:41 +0000
Received: from DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6]) by DM5PR13MB1851.namprd13.prod.outlook.com
 ([fe80::70fd:85c2:8ea9:a0b6%9]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 20:40:41 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "alkisg@gmail.com" <alkisg@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: rsize,wsize=1M causes severe lags in 10/100 Mbps
Thread-Topic: rsize,wsize=1M causes severe lags in 10/100 Mbps
Thread-Index: AQHVbwMN/jYKfSJ+jEOCnZqjx88626czK6CAgAA1K4CAAAiCAIAAAYOAgAACcYCAAAQggIAABZeA
Date:   Thu, 19 Sep 2019 20:40:41 +0000
Message-ID: <d7ea48b4cd665eced45783bf94d6b1ff1f211960.camel@hammerspace.com>
References: <80353d78-e3d9-0ee2-64a4-cd2f22272fbe@gmail.com>
         <CAABAsM7XHjTC4311-XY04RSy_XJs+E+j+-3prYAarX_=k0259g@mail.gmail.com>
         <ee758eaf-c02d-f669-bc31-f30e6b17d92a@gmail.com>
         <3d00928cd3244697442a75b36b75cf47ef872657.camel@hammerspace.com>
         <7afc5770-abfa-99bb-dae9-7d11680875fd@gmail.com>
         <e51876b8c2540521c8141ba11b11556d22bde20b.camel@hammerspace.com>
         <915fa536-c992-3b77-505e-829c4d049b02@gmail.com>
         <1d5f6643330afd2c04350006ad2a60e83aebb59d.camel@hammerspace.com>
         <5601db40-ee2f-262d-7d01-5c589c9a07eb@gmail.com>
In-Reply-To: <5601db40-ee2f-262d-7d01-5c589c9a07eb@gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=trondmy@hammerspace.com; 
x-originating-ip: [68.40.189.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8695b0f2-db40-4a38-ee46-08d73d41a302
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR13MB1643;
x-ms-traffictypediagnostic: DM5PR13MB1643:
x-microsoft-antispam-prvs: <DM5PR13MB1643B0680CD3CB2CB032FBDDB8890@DM5PR13MB1643.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(366004)(136003)(396003)(376002)(189003)(199004)(66946007)(6246003)(6512007)(66066001)(316002)(2906002)(6116002)(64756008)(66556008)(66476007)(66446008)(81156014)(8936002)(81166006)(8676002)(118296001)(3846002)(76116006)(36756003)(91956017)(5660300002)(2616005)(6436002)(6486002)(11346002)(71200400001)(446003)(71190400001)(7736002)(14454004)(86362001)(229853002)(256004)(476003)(305945005)(486006)(26005)(186003)(76176011)(99286004)(2501003)(6506007)(110136005)(102836004)(478600001)(53546011)(25786009)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR13MB1643;H:DM5PR13MB1851.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hammerspace.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yCHFMcpNtBfhyLBN5A0qvAPpvoDi9+AJKvFQxdrZoe8SDpWu1NUnZtkur/oWImK5JD6wsfVt3zmrN9E0e0ueeELUVscEJv8V+B3YJf/u/uaD6imgIhO+5zue3R9FFeWykcEq7ngwowV1ybI92RnIiMFuSRW4QOMaKFVx7ZgQEB+Dbm6orOAkGOXamPHC/mODdAJ8tgJO0D+/NvI/iZXmQyCnDWfffrziGs1RmdTeGKyb9v8wlL1wfX4h6tEt21CGNhLoffdJSMr/ZZnnONlh8xOHwZrdyyjd+2a4/VhZJ54kinolpyH3ap2ZXwJGsRCXyFqpBRxR9zUMPyIxqeWsthpCN9AvFBqlShsYjIQxhwgQG6zlI4PfgrzGjEyi4GQd4IMy7A2pLWhbOmEK3WFS7Yc9uGYvdm6mHfrTCUaktRk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B931AC592DBA94E89E8EA1A49CF0036@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8695b0f2-db40-4a38-ee46-08d73d41a302
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 20:40:41.2591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TaF2M62zq49HleHefV3UX+Y7FQ7NpMHyFo0xhvNQ8RjR1GDx19Cl1m3IQn1MgApvFL/NnvHknoA+DklAi86K4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1643
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDIzOjIwICswMzAwLCBBbGtpcyBHZW9yZ29wb3Vsb3Mgd3Jv
dGU6DQo+IE9uIDkvMTkvMTkgMTE6MDUgUE0sIFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiBU
aGVyZSBhcmUgcGxlbnR5IG9mIG9wZXJhdGlvbnMgdGhhdCBjYW4gdGFrZSBsb25nZXIgdGhhbiA3
MDAgbXMgdG8NCj4gPiBjb21wbGV0ZS4gU3luY2hyb25vdXMgd3JpdGVzIHRvIGRpc2sgYXJlIG9u
ZSwgYnV0IENPTU1JVCAoaS5lLiB0aGUNCj4gPiBORlMNCj4gPiBlcXVpdmFsZW50IG9mIGZzeW5j
KCkpIGNhbiBvZnRlbiB0YWtlIG11Y2ggbG9uZ2VyIGV2ZW4gdGhvdWdoIGl0DQo+ID4gaGFzIG5v
DQo+ID4gcGF5bG9hZC4NCj4gPiANCj4gPiBTbyB0aGUgcHJvYmxlbSBpcyBub3QgdGhlIHNpemUg
b2YgdGhlIFdSSVRFIHBheWxvYWQuIFRoZSByZWFsDQo+ID4gcHJvYmxlbQ0KPiA+IGlzIHRoZSB0
aW1lb3V0Lg0KPiA+IA0KPiA+IFRoZSBib3R0b20gbGluZSBpcyB0aGF0IGlmIHlvdSB3YW50IHRv
IGtlZXAgdGltZW89NyBhcyBhIG1vdW50DQo+ID4gb3B0aW9uDQo+ID4gZm9yIFRDUCwgdGhlbiB5
b3UgYXJlIG9uIHlvdXIgb3duLg0KPiA+IA0KPiANCj4gVGhlIHByb2JsZW0gaXNuJ3QgdGltZW8g
YXQgYWxsLg0KPiBJZiBJIHVuZGVyc3RhbmQgaXQgY29ycmVjdGx5LCB3aGVuIEkgdHJ5IHRvIGxh
dW5jaCBmaXJlZm94IG92ZXINCj4gbmZzcm9vdCwgDQo+IE5GUyB3aWxsIHdhaXQgdW50aWwgaXQg
ZmlsbHMgMU0gYmVmb3JlICJyZXBseWluZyIgdG8gdGhlIGFwcGxpY2F0aW9uLg0KPiBUaHVzIHRo
ZSBhcHBsaWNhdGlvbnMgd2lsbCBsYXVuY2ggYSBsb3Qgc2xvd2VyLCBhcyB0aGV5IGdldCAiZGlz
ayANCj4gZmVlZGJhY2siIGluIGxhcmdlciBjaHVua3MgYW5kIG5vdCAic25hcHB5Ii4NCj4gDQo+
IEluIG51bWJlcnM6DQo+IHRpbWVvPTYwMCxyc2l6ZT0xTSA9PiBmaXJlZm94IG9wZW5zIGluIDMw
IHNlY3MNCj4gdGltZW89NjAwLHJzaXplPTMyayA9PiBmaXJlZm94IG9wZW5zIGluIDIwIHNlY3MN
Cj4gDQoNClRoYXQncyBhIGRpZmZlcmVudCBwcm9ibGVtLCBhbmQgaXMgbW9zdCBsaWtlbHkgZHVl
IHRvIHJlYWRhaGVhZCBjYXVzaW5nDQp5b3VyIGNsaWVudCB0byByZWFkIG1vcmUgZGF0YSB0aGFu
IGl0IG5lZWRzIHRvLiBJdCBpcyBhbHNvIHRydWUgdGhhdA0KdGhlIG1heGltdW0gcmVhZGFoZWFk
IHNpemUgaXMgcHJvcG9ydGlvbmFsIHRvIHRoZSByc2l6ZSBhbmQgdGhhdCBtYXliZQ0KaXQgc2hv
dWxkbid0IGJlLg0KSG93ZXZlciB0aGUgVk0gbGF5ZXIgaXMgc3VwcG9zZWQgdG8gZW5zdXJlIHRo
YXQgdGhlIGtlcm5lbCBkb2Vzbid0IHRyeQ0KdG8gcmVhZCBhaGVhZCBtb3JlIHRoYW4gbmVjZXNz
YXJ5LiBJdCBpcyBib3VuZGVkIGJ5IHRoZSBtYXhpbXVtIHdlIHNldA0KaW4gdGhlIE5GUyBsYXll
ciwgYnV0IGl0IGlzbid0IHN1cHBvc2VkIHRvIGhpdCB0aGF0IG1heGltdW0gdW5sZXNzIHRoZQ0K
cmVhZGFoZWFkIGhldXJpc3RpY3Mgc2hvdyB0aGF0IHRoZSBhcHBsaWNhdGlvbiBtYXkgbmVlZCBp
dC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwg
SGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
