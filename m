Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F3179AC7
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2020 22:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgCDVUL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Mar 2020 16:20:11 -0500
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:14044
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726440AbgCDVUL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Mar 2020 16:20:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpumraMBTTHzTIo7G1Ulzh9HPd9K12+T539nqaTpXf8DfqEAadpaDv2173vBD15JWa20r/6UXui0bEsfCNTYIz+EhjCUqVbkDhprp93QHru4f85Fv/bCiGQhKMjTj1X3I2iIq+0PGyRkqCPkqZe9PPWi9pxLfN23YrY0iYvA7Uxklp0e+s1EHhkTo0L6l20pmJW1sP4HU5N8C2Tj4FQO3fyz928nKqcY0hK6I8Gp9uwYQqOO5yBDp3DNb/yVaxfeFT4xMzXTOr1tbGiy5YqNTJBLHVZ7XfZtM+krd3wUmdfGDtR/gi94zg9rVSt8iVG546C1rPrHhOUS63p8E7QM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3lfFZ4Gi1a4coxQx3lP8tJ+9kaPMo9H0SWDXzM6ey4=;
 b=fzIJAbvSCalrNMLOqwtGO6QjYuWT0lwstnUNwyL/wyoS4Ibb8puBntJi0QQzVavr9MRn26wmfMr+PWQLwohlzDf0rFja6fBao+jpKuuuP1RcVICa5b9mQMvFXCC244Gg4x8V90pymDPQRm0VLHHu/Qo7xPV5/v80WtklMetaAj2dzm2UOrWW6d8oYOc6WGjKstOR1AEy93jYrCuZaf55eo7tbzf3xBw7AuqMZzHfSZHAzxIIkKMjNSqQnHcpI0N1zD0aA46rcRhYxZrdVyUuf2SRlCpYbhirv976WE7oht2LMDnfUF5L7hSNOxYH4ZfG8m+sV+SHjaJzykAR/7Wp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3lfFZ4Gi1a4coxQx3lP8tJ+9kaPMo9H0SWDXzM6ey4=;
 b=iGon/RHfctQZuT8xQdURmg+qYUvGZfVqrEwXGk7Rc153QcO2VYZZ4YZHEwpabzSVBqJedS4XFSTVKf4BZswiEPm7DwtNktR1ew6PXx6bmTbMBpe6I86oGlDrSOAySJ96UtCbL3v4ri5vb26919nW3e9AsNekTjbr/sxH0R7xWro=
Received: from DM6PR06MB4892.namprd06.prod.outlook.com (2603:10b6:5:5a::20) by
 DM6PR06MB4684.namprd06.prod.outlook.com (2603:10b6:5:ff::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Wed, 4 Mar 2020 21:20:07 +0000
Received: from DM6PR06MB4892.namprd06.prod.outlook.com
 ([fe80::900f:c1ed:3bc8:6d16]) by DM6PR06MB4892.namprd06.prod.outlook.com
 ([fe80::900f:c1ed:3bc8:6d16%4]) with mapi id 15.20.2793.013; Wed, 4 Mar 2020
 21:20:07 +0000
From:   "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Bruce Fields <bfields@fieldses.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: Fix build error
Thread-Topic: [PATCH] nfsd: Fix build error
Thread-Index: AQHV8idg2SKgihnLXEOwwote24GDhKg4uTEAgAAjMICAABB1gP//sF4A
Date:   Wed, 4 Mar 2020 21:20:07 +0000
Message-ID: <64BBC05E-F3E6-49BA-9596-158A7789FE27@netapp.com>
References: <20200304131803.46560-1-yuehaibing@huawei.com>
 <BC0E3531-B282-4C04-9540-C39C6F4A1A5D@oracle.com>
 <20200304200609.GA26924@fieldses.org>
 <9592D8FB-C758-4B52-962B-B04A00627A43@oracle.com>
In-Reply-To: <9592D8FB-C758-4B52-962B-B04A00627A43@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.22.0.200209
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Olga.Kornievskaia@netapp.com; 
x-originating-ip: [2600:1700:6a10:2e90:c027:463f:30e8:8005]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 035f8aae-4dc9-465b-5685-08d7c081d019
x-ms-traffictypediagnostic: DM6PR06MB4684:
x-microsoft-antispam-prvs: <DM6PR06MB468403469C85222D024D8AA693E50@DM6PR06MB4684.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(186003)(53546011)(8676002)(76116006)(81166006)(2616005)(5660300002)(36756003)(33656002)(71200400001)(6486002)(66946007)(6512007)(81156014)(8936002)(66446008)(66556008)(64756008)(66476007)(110136005)(2906002)(478600001)(6506007)(91956017)(4326008)(54906003)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB4684;H:DM6PR06MB4892.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +PoK6NvJgk4h9LPfQn/eIo++1LGddYeblfJGg6GNFQ5T1zF8o+hRypMcbp+nxmkhpw/eDOZYZ66mAqMVg6kwI5N/e3ySK/siUBS6eSidtyeFXMDjWLTH1yVf5abzeHG7uer2hHdNMimKqKyLczkJyWxq3ppIbkZOaRQMaWkeGb9wemsfDE9txd5C9lR9+LbrQQo4ts5T8M+4jdEptoIHsIYdCoYRBJHZdcy943ptX02yDx13y6AUjc2owdXeXvXHZgq4T2qmrracJPnNVt3JD0ww/K0UBw1x64n/3791f9zD/30iDrhR6wRi7WPI18v4G5SJl/QuRegBdmd7N92PHmBnHIg/ZhVGHKftIv4n+xL6xyImlFPSIq03lcSJlKiSU37GLGeMi8vt9q9uApNH3hz5lqLRSJVgTjFozcdOj7DEUnulx5KfDMzmHeJ9pias
x-ms-exchange-antispam-messagedata: ha0EzpTvOOQWyX3C0BWhW7hlhSaH7HjAqPCWWro66Ly46mhb27sUDrz2vuZkAhGRxbZrx2Nj8/4wWS4Z5UiH5ctfCkg02TBD0myHEd9thisDkDLmL2oO9jzDaJLscX7vGkeySgm4IOZO6z62eIClb5T9NLJa2NPrNpJqO9zmmhSgu971fNV1QCIBiilK00deiuVTQUY53oC7GzCytPvv9w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EB9CD7A129BCD4D84EAAB6EE47233B1@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035f8aae-4dc9-465b-5685-08d7c081d019
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 21:20:07.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmhxbkqZBmy0g8Djg69ukWhpOLDeLrXSeDA8YYPVWBhxy5/ALM6Uvjcuq3DXHPgs8EbFPkfWX17lxEX6RiVrQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4684
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCu+7v09uIDMvNC8yMCwgNDowNSBQTSwgIkNodWNrIExldmVyIiA8Y2h1Y2subGV2ZXJAb3Jh
Y2xlLmNvbT4gd3JvdGU6DQoNCiAgICBOZXRBcHAgU2VjdXJpdHkgV0FSTklORzogVGhpcyBpcyBh
biBleHRlcm5hbCBlbWFpbC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KICAgIA0KICAgIA0KICAgIA0KICAgIA0KICAgID4gT24gTWFyIDQsIDIwMjAsIGF0IDM6
MDYgUE0sIEJydWNlIEZpZWxkcyA8YmZpZWxkc0BmaWVsZHNlcy5vcmc+IHdyb3RlOg0KICAgID4N
CiAgICA+IE9uIFdlZCwgTWFyIDA0LCAyMDIwIGF0IDAxOjAwOjEyUE0gLTA1MDAsIENodWNrIExl
dmVyIHdyb3RlOg0KICAgID4+IEhpLQ0KICAgID4+DQogICAgPj4+IE9uIE1hciA0LCAyMDIwLCBh
dCA4OjE4IEFNLCBZdWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+IHdyb3RlOg0KICAg
ID4+Pg0KICAgID4+PiBmcy9uZnNkL25mczRwcm9jLm86IEluIGZ1bmN0aW9uIGBuZnNkNF9kb19j
b3B5JzoNCiAgICA+Pj4gbmZzNHByb2MuYzooLnRleHQrMHgyM2I3KTogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgbmZzNDJfc3NjX2Nsb3NlJw0KICAgID4+PiBmcy9uZnNkL25mczRwcm9jLm86IElu
IGZ1bmN0aW9uIGBuZnNkNF9jb3B5JzoNCiAgICA+Pj4gbmZzNHByb2MuYzooLnRleHQrMHg1ZDJh
KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgbmZzX3NiX2RlYWN0aXZlJw0KICAgID4+PiBmcy9u
ZnNkL25mczRwcm9jLm86IEluIGZ1bmN0aW9uIGBuZnNkNF9kb19hc3luY19jb3B5JzoNCiAgICA+
Pj4gbmZzNHByb2MuYzooLnRleHQrMHg2MWQ1KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgbmZz
NDJfc3NjX29wZW4nDQogICAgPj4+IG5mczRwcm9jLmM6KC50ZXh0KzB4NjM4OSk6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYG5mc19zYl9kZWFjdGl2ZScNCiAgICA+Pj4NCiAgICA+Pj4gQWRkIGRl
cGVuZGVuY3kgdG8gTkZTRF9WNF8yX0lOVEVSX1NTQyB0byBmaXggdGhpcy4NCiAgICA+Pj4NCiAg
ICA+Pj4gRml4ZXM6IGNlMDg4N2FjOTZkMyAoIk5GU0QgYWRkIG5mczQgaW50ZXIgc3NjIHRvIG5m
c2Q0X2NvcHkiKQ0KICAgID4+PiBTaWduZWQtb2ZmLWJ5OiBZdWVIYWliaW5nIDx5dWVoYWliaW5n
QGh1YXdlaS5jb20+DQogICAgPj4+IC0tLQ0KICAgID4+PiBmcy9uZnNkL0tjb25maWcgfCAxICsN
CiAgICA+Pj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQogICAgPj4+DQogICAgPj4+
IGRpZmYgLS1naXQgYS9mcy9uZnNkL0tjb25maWcgYi9mcy9uZnNkL0tjb25maWcNCiAgICA+Pj4g
aW5kZXggZjM2OGYzMi4uZmM1ODdhNSAxMDA2NDQNCiAgICA+Pj4gLS0tIGEvZnMvbmZzZC9LY29u
ZmlnDQogICAgPj4+ICsrKyBiL2ZzL25mc2QvS2NvbmZpZw0KICAgID4+PiBAQCAtMTM2LDYgKzEz
Niw3IEBAIGNvbmZpZyBORlNEX0ZMRVhGSUxFTEFZT1VUDQogICAgPj4+DQogICAgPj4+IGNvbmZp
ZyBORlNEX1Y0XzJfSU5URVJfU1NDDQogICAgPj4+ICAgICBib29sICJORlN2NC4yIGludGVyIHNl
cnZlciB0byBzZXJ2ZXIgQ09QWSINCiAgICA+Pj4gKyAgIGRlcGVuZHMgb24gIShORlNEPXkgJiYg
TkZTX0ZTPW0pDQogICAgPj4NCiAgICA+PiBUaGUgbmV3IGRlcGVuZGVuY3kgaXMgbm90IGVzcGVj
aWFsbHkgY2xlYXIgdG8gbWU7IG1vcmUgZXhwbGFuYXRpb24NCiAgICA+PiBpbiB0aGUgcGF0Y2gg
ZGVzY3JpcHRpb24gYWJvdXQgdGhlIGNhdXNlIG9mIHRoZSBidWlsZCBmYWlsdXJlDQogICAgPj4g
d291bGQgZGVmaW5pdGVseSBiZSBoZWxwZnVsLg0KICAgID4+DQogICAgPj4gTkZTRF9WNCBjYW4n
dCBiZSBzZXQgdW5sZXNzIE5GU0QgaXMgYWxzbyBzZXQuDQogICAgPj4NCiAgICA+PiBORlNfVjRf
MiBjYW4ndCBiZSBzZXQgdW5sZXNzIE5GU19WNF8xIGlzIGFsc28gc2V0LCBhbmQgdGhhdCBjYW5u
b3QNCiAgICA+PiBiZSBzZXQgdW5sZXNzIE5GU19GUyBpcyBhbHNvIHNldC4NCiAgICA+Pg0KICAg
ID4+IFNvIHdoYXQncyByZWFsbHkgZ29pbmcgb24gaGVyZT8NCiAgICA+DQogICAgPiBJIGRvbid0
IHVuZGVyc3RhbmQgdGhhdCAiZGVwZW5kcyIgZWl0aGVyLg0KICAgID4NCiAgICA+IFRoZSBmdW5k
YW1lbnRhbCBwcm9ibGVtLCB0aG91Z2gsIGlzIHRoYXQgbmZzZCBpcyBjYWxsaW5nIG5mcyBjb2Rl
DQogICAgPiBkaXJlY3RseS4NCiAgICA+DQogICAgPiBXaGljaCBJIG5vdGljZWQgaW4gZWFybGll
ciByZXZpZXcgYW5kIHRoZW4gZm9yZ290IHRvIGZvbGxvdyB1cCBvbiwNCiAgICA+IHNvcnJ5Lg0K
ICAgID4NCiAgICA+IFNvIGVpdGhlciB3ZToNCiAgICA+DQogICAgPiAgICAgICAtIGxldCBuZnNk
IGRlcGVuZCBvbiBuZnMsIGZpeCB1cCBLY29uZmlnIHRvIHJlZmxlY3QgdGhlIGZhY3QsIG9yDQog
ICAgPiAgICAgICAtIHdyaXRlIHNvbWUgY29kZSBzbyBuZnNkIGNhbiBsb2FkIG5mcyBhbmQgZmlu
ZCB0aG9zZSBzeW1ib2xzIGF0DQogICAgPiAgICAgICAgIHJ1bnRpbWUgaWYgaXQgbmVlZHMgdG8g
ZG8gYSBjb3B5Lg0KICAgIA0KICAgIEFub3RoZXIgcHJhY3RpY2FsIG9wdGlvbiB3b3VsZCBiZSB0
byBjcmVhdGUgYSBjb3B5IG9mIHRoZXNlIGZ1bmN0aW9ucyBpbg0KICAgIHRoZSBzZXJ2ZXIncyBT
U0MgY29kZS4gQXQgbGVhc3QgbmZzX3NiX2RlYWN0aXZlKCkgaXMgbm90IGxhcmdlLg0KICAgIA0K
ICAgIE5vdCBjbGVhciBpZiBuZnM0Ml9zc2Nfb3Blbi9jbG9zZSBhcmUgZXZlbiB1c2VkIG9uIHRo
ZSBjbGllbnQuIE1heWJlIHRoZXkNCiAgICBjb3VsZCBiZSBtb3ZlZCB0byB0aGUgc2VydmVyPw0K
DQpOZnM0Ml9zc2Nfb3Blbi9jbG9zZSBhcmUgbm90IHVzZWQgb24gdGhlIGNsaWVudCBidXQgdGhl
aXIgaW5zaWRlcyB1c2UgY2xpZW50J3Mgc3RydWN0dXJlcyAobGlrZSBuZnNfZmgsIG5mczRfc3Rh
dGVpZCwgZXRjKSBhbmQgY2FsbHMgbmZzNF9wcm9jX2dldGF0dHIsIG5mc19maGdldCBhbmQgb3Ro
ZXJzIGFuZCBWRlMgZnVuY3Rpb25zLiBJdCdsbCBiZSBhIGxvdCB0byBjb3B5LiANCiAgICANCiAg
ICA+IFRoZSBsYXR0ZXIncyBjZXJ0YWlubHkgZG9hYmxlLCBidXQgaXQnZCBiZSBzaW1wbGVzdCB0
byBkbyB0aGUgZm9ybWVyLg0KICAgID4gQXJlIHRoZXJlIGFjdHVhbGx5IGEgbG90IG9mIHBlb3Bs
ZSB3aG8gd2FudCBuZnNkIGJ1dCBub3QgbmZzPyAgRG9lcyB0aGF0DQogICAgPiBjYXVzZSBhIHJl
YWwgcHJvYmxlbSBmb3IgYW55b25lPw0KICAgID4NCiAgICA+IC0tYi4NCiAgICANCiAgICAtLQ0K
ICAgIENodWNrIExldmVyDQogICAgDQogICAgDQogICAgDQogICAgDQoNCg==
