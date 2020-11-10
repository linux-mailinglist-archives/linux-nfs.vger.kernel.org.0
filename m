Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B472AE445
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 00:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgKJXmi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 18:42:38 -0500
Received: from mail-eopbgr700110.outbound.protection.outlook.com ([40.107.70.110]:50657
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732544AbgKJXmf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 18:42:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C96cZ9m3wQ1z08ER5OulmwGPSjUrJcmx5Q1ZqGusV3gk0Yg3YOggDyYTwVOGk0DbI3PrPtPbS8J6UhcNZcNh44iozkDmBvh1+kzRch3JSfWA9sLOGpigUnxPGliAZnaqLLIaNmDsPGllXNufJwMJcf+Hl9qbwm34oshtzwI8gdsxst42+vCqMjKoNRWRYEBaOMbcQD0hVuKsVB6yv5+qQWjTRcsw6FKU8I6Y1G+6NdP3S+4XvSGzockIFbLKV2phebhxn7RsllrRB2XYPNtMsOfvj7AkMexGngSs15GUlbZugmsHxxeI99C2TCit5jpBXUvJ6wE5qSrFFB1ok5QYMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlwL5IdIGUbBH3O3Bx+F9+FahG/lL1uYpGBCyX1L/20=;
 b=Vocx9AibaZkJIqhFP0LzB5n75BiAYUM75dtHhtixXpytu8GBsxSojVlW07zToupEs7f8GtPtJsGHfDVuRdk1y/zjbEDKd0TPPkl1YOA71nGEOxT+NVNtPQ6/Bp8qyQNE/v+NziCG26DEYqqoV2YAFK7Zyrr84c2mqct0P2oeiek2KfJnnLjKseOiNQ40l9Dtc6XVzFNR4QunK53Jt2TmPCXQfWV5JchGnvdUgYG4EtUWJKfTKBvHhZUEoTlmnZPm7BcXDj5bzOS8O65pOlRVbJsgbneuUKqwvdqoKjXt4sK0ErIBNVosrcRARlwjypdv1T34JVpoiVLDjG1KaHDrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlwL5IdIGUbBH3O3Bx+F9+FahG/lL1uYpGBCyX1L/20=;
 b=QSRWSjHOseMQVP7nye6t8rrpZndrdEuH4WEQyROJP+Nf3vO4wSVPRK8kkTPLJdD172yGm6Pq41KSOoTajuUJmQcq6dldPtyXlO+NZ2z9kOKLcBhmHI8gRjjGdojxJ2KBm6nbO835H4QUr4D/dDNVtfLXzPxvoGfTA2XHBMPLZzM=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3757.namprd13.prod.outlook.com (2603:10b6:208:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.14; Tue, 10 Nov
 2020 23:42:32 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Tue, 10 Nov 2020
 23:42:32 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles data
 channels
Thread-Topic: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles
 data channels
Thread-Index: AQHWt7lTY9xR7iW33kG2X9IO1/hKs6nCBtsA
Date:   Tue, 10 Nov 2020 23:42:31 +0000
Message-ID: <3a3696f03eef74ac4723fdc0d1297076a34aa8ae.camel@hammerspace.com>
References: <20201110231906.863446-1-trondmy@kernel.org>
In-Reply-To: <20201110231906.863446-1-trondmy@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56fe44a2-8eb1-4ff7-a89a-08d885d24af9
x-ms-traffictypediagnostic: MN2PR13MB3757:
x-microsoft-antispam-prvs: <MN2PR13MB3757501F73FD38E17678E0D1B8E90@MN2PR13MB3757.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wiikpspv4ym6BpHCA0PfqX8y4PGis7lyTQBOdeE/8dfEGtyEw08818v5CabBhCp2JRalFXjVPbPvPnRRCla+MCtlPZK2GbGdP9Np52B7VcrZrcnGQZ/W8NIsRFtHvRMQLE32N/U750/Vs1OUf1NAxmksSYnsH+ZlESg7AcHOF5iQojBualRMBIhqTqijyFH1QAmm5/Yp3UhLLzlNr+/0HLU5/WrOnftPyLalAubfaQTk5EtNEfbfOm7KfVW0wZR8gX/+PK4Q4DyAhr2XJbfuOnop//BjXdHCry/DeFkglIX+sDrTymF0+jKuhNUEb5VZVnbgkn9eGbhnHyxB8psXfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39830400003)(6512007)(66446008)(6916009)(478600001)(2906002)(66946007)(66476007)(66556008)(64756008)(76116006)(91956017)(4001150100001)(8936002)(316002)(5660300002)(2616005)(186003)(8676002)(86362001)(36756003)(6486002)(26005)(4744005)(71200400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zw63SyYxZFNwLLaZvq7zsUHyCRRLdhKNVvKN9ohl3fvyt1FI31gSBSNyVCxB4xTPrvQ7zjzeJqmYIctu5jg5GI50DjSsbL3GKO1E01W2GgDs51hiV4/RBvzHHpY9EB/7IQ1XDmA45eaX9gNWlPNFzLvMgOdLL5mGC/wGRO00RoJAwyIWXlGsKBtQTuk75R+80C/cK+eR80cTmfeRoUOPJGNTzOR08AezDLFzPFvyIWn6FsPF5sGvOAyypmJ5rit/Ui//4sueQlpKtttoQh4RiA2QjRYTqie0dDm8nyw4+ghNZhnwFM2OFPEP1P1ODQ6d3dIlTsYM1uA52YjExkr8T50HCDahb57vuDf5PnacKH2M3aaov+6YXiDvymAIswrK380VCYzm33I7cZgBE308S3rRNAnm+CkttBpwLUS15gg3Wq82Ax/OdsBpGyg7YjTwnlc2+1h7DRrdn0SMKfnhoV5uOrt4BI4JGFOhGCsUWP9aqoq78WX1nRN5bgHi1wIJ1HDo6R9MpEcFu6l+UObC+/wlhKxVYRJpElLyzD1s0rclNfAVrmvVpRUlM3MmvbWaZK2pRz/DX/lMeESuKFlOuJGviXQD0eSLJbo5GI0mKI4x6IoAvkJ+JavHWr6TLqtvF0Yzu6QK1NGRIUoxxbsiEg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD5547911E65D0489040D1BD54BD52C1@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56fe44a2-8eb1-4ff7-a89a-08d885d24af9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 23:42:31.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53lKxE+QQOwcUW98yIvFot1fs3dtEDt3pwpno4/qqd80L/R0FhziZsbftBZHeuhkKInoh3WPtJfv9S0YnGWa8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3757
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTEwIGF0IDE4OjE4IC0wNTAwLCB0cm9uZG15QGtlcm5lbC5vcmcgd3Jv
dGU6DQo+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNl
LmNvbT4NCj4gDQo+IEFkZCBzdXBwb3J0IGZvciBjb25uZWN0aW5nIHRvIHRoZSBwTkZTIGZpbGVz
L2ZsZXhmaWxlcyBkYXRhIHNlcnZlcnMNCj4gdGhyb3VnaCBSRE1BLCBhc3N1bWluZyB0aGF0IHRo
ZSBHRVRERVZJQ0VJTkZPIGNhbGwgYWR2ZXJ0aXNlcyB0aGF0DQo+IHN1cHBvcnQuDQo+IA0KPiB2
MjogRml4IGxheW91dHN0YXRzIGVuY29kaW5nIGZvciBwTkZTL2ZsZXhmaWxlcy4NCj4gdjM6IE1v
dmUgbW9zdCBvZiB0aGUgbmV0aWQgaGFuZGxpbmcgaW50byB0aGUgU1VOUlBDIGFuZCBSRE1BIG1v
ZHVsZXMuDQo+IMKgwqDCoCBGaXggdXAgdGhlIG1vdW50IGNvZGUgdG8gYmVuZWZpdCBtb3JlIGZy
b20gYXV0b21hdGVkIGxvYWRpbmcgb2YNCj4gwqDCoMKgIFNVTlJQQyB0cmFuc3BvcnQgbW9kdWxl
cy4NCj4gDQoNCk5vdGUgdGhhdCBvbmUgY2xlYW51cCB0aGF0IEkgZGlkIG5vdCBwZXJmb3JtLCBi
dXQgd2hpY2ggcmVhbGx5IGNvdWxkIGJlDQp1c2VmdWwgc2hvdWxkIHdlIHdhbnQgdG8gYWRkIG1v
cmUgdHJhbnNwb3J0IG1lY2hhbmlzbXMsIGlzIHRvIG1vdmUgdGhlDQpjb2RlIHRvIHBhcnNlIHN0
cmluZ2lmaWVkIGFkZHJlc3NlcyAoaW4gcGFydGljdWxhciBJRVRGIHN0eWxlDQoidW5pdmVyc2Fs
IGFkZHJlc3NlcyIpIGludG8gdGhlIHRyYW5zcG9ydCBtb2R1bGVzIHNvIHRoYXQgdGhlIGFjdHVh
bA0KcGFyc2luZyBvZiBtb3VudCBhbmQgcE5GUyB0cmFuc3BvcnQgaW5mbyBjYW4gYmUgYXV0b21h
dGljYWxseSBleHRlbmRlZA0Kd2hlbiBuZXcgdHJhbnNwb3J0IG1vZHVsZXMgYXJlIGFkZGVkLg0K
DQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1t
ZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
