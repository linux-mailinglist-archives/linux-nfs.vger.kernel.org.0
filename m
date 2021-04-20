Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53938365E95
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 19:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbhDTR2p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 13:28:45 -0400
Received: from mail-co1nam11on2110.outbound.protection.outlook.com ([40.107.220.110]:2144
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233245AbhDTR2o (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Apr 2021 13:28:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3nuPV5Ukp96QwbU8ecHV+kexzm68DvwBlKK615lXoQnU2pePtix1PSNsHYj86GsuM+2GNX9letb9G1fDBTPb19qAHkWmffLydOD1/4w66cw06z71abi5ejHSB+6XkFdlTOLxIvep3GKjGGB3S0Dnnw/R1A7DzYekWpoHi5bey1JIIbnxoWwrGzf8ehrPkv+4i7t9YL23wuI+5ZULR4abxAGfyAthr6d0tibqup2RL8n5XBKcp56zDdctNHvrYVXgopK67bK1q4RCffqHgSwJ229PQIOUWSLGCJBv7hevbFneFSp/mg9QPQ0Xulp2UPq6iL2UzLPBh+4JHlR+xv0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71y/8iTroGv/Fuq6kb6O14AtHGcFwqj2qc8xoDGrx6A=;
 b=nA6GMGUCQ13iGoqsuYBAN+F03d2Fe3T71rM30kXWTuJ6OHlzr1te5/uJkLqG+IYRxhv7xtdz3PdOLiLJa1bmEs90hg7Vyin53sdeBlnRPNpOW/QrZPuz2G6wyd/FZ41lWyn1uLYwMvNo+EYmBMLY2B50X0c7Vqv3pgvnLRyjxNxJqdhNM6N2iQkx2fxeAAI53fZN7Py+ggOu/xfIGeKW1std39sO38el5GC4JqDszW/HN8qKebrI6LJs4OX3o6oqkb5y/yqhOWLz1Qkg1hYwol214j/CPsBVlKR3urGG2z0rVtuX7rk/Y7qzF37HhyX7fFcPmRvx7cj6NpawHrsu7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71y/8iTroGv/Fuq6kb6O14AtHGcFwqj2qc8xoDGrx6A=;
 b=NkV4p/h0dA7JmPBkaAV1Nu43lPilem5JiylY/Oa9NmxkLphCuMNXYDhXrC1etkYloKuqdI8vO55Ju+I+gLxA+zvz5erfudm2coQDfJRsYg1BziEmji11o0Amtx43PvcndnGhlny+CkqfVYYOC5LuYecfyjy9EGCoTKuRWjaJpTU=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR13MB1084.namprd13.prod.outlook.com (2603:10b6:3:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8; Tue, 20 Apr
 2021 17:28:08 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 17:28:08 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "ajmitchell@redhat.com" <ajmitchell@redhat.com>,
        "SteveD@RedHat.com" <SteveD@RedHat.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Topic: [PATCH 0/3] Enable the setting of a kernel module parameter from
 nfs.conf
Thread-Index: AQHXMVl4VT45tjmxiUS0kqeKowHWU6q0qJsAgAEODwCAABHMAIADH5EAgAAEzACAABTdAIABgaqAgALnPICAABBfgIAABi2AgAAubACAAALMgA==
Date:   Tue, 20 Apr 2021 17:28:08 +0000
Message-ID: <be1a2b6beab29b3e40277f5fefd6c49b37c32361.camel@hammerspace.com>
References: <AA442C15-5ED3-4DF5-B23A-9C63429B64BE@oracle.com>
         <5adff402-5636-3153-2d9f-d912d83038fc@RedHat.com>
         <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
         <77a6e5a4-7f14-c920-0277-2284983e6814@RedHat.com>
         <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
         <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
         <DAFAF7B1-5C56-4DA7-B7F9-4F544CCDA031@oracle.com>
         <f0525973-a32c-32d4-4ccc-827acaa3c125@RedHat.com>
         <20A43DDA-C08E-4E39-A83C-24E326768ADE@oracle.com>
         <2d7d391802a3984b68aa8b3e7f360b0b6cb733dc.camel@hammerspace.com>
         <20210420171806.GC4017@fieldses.org>
In-Reply-To: <20210420171806.GC4017@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2962b41b-1059-4b76-60e5-08d90421aa70
x-ms-traffictypediagnostic: DM5PR13MB1084:
x-microsoft-antispam-prvs: <DM5PR13MB1084503EA2C03C5C7A9A99F6B8489@DM5PR13MB1084.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4BTaNhBz1PeztpSYngy2u7oY3Hw0pz6J2z2psstZNBq2jfdI4S2cPXcnoxygOxBkohbE5EkicQ3zYhLVrosNcY4De1tTaookKklIZL8i3VPYqHp21sH6ovx76R6el1PZ8zUgF3bV7zJY8p8CWycfdtpjq6/cbINKPIIFBLQVIukYfc/HUJdF2I68oxY4zwm+0/kaWgziIQHix5GNTJ8bujuBT/Wjndn2FJULgVKzzS0uiaFJv1JmDOuoxeOcqq2czwPIIFe1ApUBfm3IRQq53EGcxtHd69P0KCOA8DTJeReED17P6fYpkeNI+Gr3gzkigO8n2bS2pD0OaEwgQPh+PgFvyQEnYet4P1NjSpjFlWd01gPnzvLhqqDG1wi/1rGqaj43LNqhG9lU4tSgsDFUREF2SgJnGWCUdBNtTT1a7+LeFfpi7lQlOepi/qNf7U/hxBQBh1YAXIq7gZ16f1fHcBRZe7vOOpiAtRs9B4PoBRlY6XLY6WCPPlHGB1O4oqaPzPKbK6aHEtQAgFptPIypvvpJZkutwV/0f973ecGVOXAdCBdnh9spbM8tWefVrhVHc1qsnp9w8/8As/IhmcrE6b36qArxLtbEt3V2oo4wFg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(346002)(366004)(39830400003)(6506007)(316002)(2616005)(86362001)(71200400001)(5660300002)(66476007)(66446008)(2906002)(8676002)(54906003)(6916009)(38100700002)(64756008)(122000001)(36756003)(66556008)(8936002)(66946007)(6486002)(6512007)(76116006)(26005)(91956017)(4326008)(478600001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VWlZbXJ2SE9lZEU0SVpqNFhxOU4ya2xkSkovWms0Q3JuSFNpL3Z2Nkl4MnpP?=
 =?utf-8?B?Z3A0Yms4RFJkamVDbzVUSFNyUDV3K2tEQ2NSWmtQK0JKTGNlUU9sWDBhRXl0?=
 =?utf-8?B?ZXE5WmZOY000OWY3RUhNZmU4QXQvVmZFWmYyd2IyL09aUzJZM1FyUWROcWtH?=
 =?utf-8?B?dFJ1OHNtS0N6QUUrcUdGa2hhRElzT1BZK0FsV1pHeDEwVlprdXE1elZ2TS96?=
 =?utf-8?B?eTJsUy9CbGZFRlMvTXB2QXhSemVEYi84RXlQd3Rxb2NRb0NXQnRwbzF4dWw4?=
 =?utf-8?B?QXI2Y1ZxU1VaNjdyU0I4Wkt5MWx5UTdhaEZkMmJONTNRc2tOQktRWUp4SGdj?=
 =?utf-8?B?dzdaZXVUTGV5Q2hMalJ1OUtReGF4VzdBam56MlVKa0orWUdzRG1YMlBTYmxs?=
 =?utf-8?B?MXFyUzM3UkJrM25lRytlOEg2SCtnVGxTWTRMeWxwVEF5T1NEYWtjYVYva3g2?=
 =?utf-8?B?dzgyVzJiTDJoNjRHU1l5OXZRbFdBb0FydDhZUWYzVTFDTXpvdlUzSkNnb0Z3?=
 =?utf-8?B?S3ljUFQ4OXpLNEQ4dlVCS29YaDdGZnhBV25WOVpaR3FZLzNNanc4UCtibk5p?=
 =?utf-8?B?NE96ZEtJM1lsU09hdFlDUVJMemEwWFdFNFBqa2hGMElyeEl3anNmSDN4OS9r?=
 =?utf-8?B?WUZMLzh0Q21LamxOVDBzVXVhMnhrQnhhV2lhc0QwNDNaekVsV2ZFQ1FXV1Bu?=
 =?utf-8?B?eW1SZXNFblNOSnZYL251NHF0ak1KdFJDVnNMdDgybHRkb0hjUjBOaHFwTGtD?=
 =?utf-8?B?UGF2SUM1L1VPSi9qVjNscjVHZWJaMHJTOEFFWSthYVhSZnFJUDBqVTFjU2VH?=
 =?utf-8?B?RTdrd1hCRVBYbFNWVHlObEFnZzFzM2VtNitwNUJJVGxJRjdnd3JKcEk4Zk0z?=
 =?utf-8?B?eEdsV2FUTkhJNlFSb09qSFpJNlB0RjhUT2wxSWR2ZHJmR2Q2alI2VWtaTCt3?=
 =?utf-8?B?ck9qNzRvcHNoTXdIblZGSkFucXVUajEzQ1pJaGZyS0FRN21jcGlieEd1SkNq?=
 =?utf-8?B?M2VwanRGSS9wbTQ2WmR5a2ZNaDdtd0dJektONUMvUFFybFRLelV1dXBqTXFK?=
 =?utf-8?B?T21mMzczdmt6Mi93QWRQcjVCa043RFYyRGJPcXd1ZDBMQkxlbi82KzFJbzlE?=
 =?utf-8?B?elJ5Rmw3NUFvL2crWFI4dDIxZkJZN0E5K09ORW1rdUUzMS9kdzhrYzhHQUxa?=
 =?utf-8?B?OVFLK2kvSTJmWXZaQnVhYU04OHEyN2oyUjE4ay84ZWFpdlFVMDdmM2RUVmFL?=
 =?utf-8?B?TjBtZ3VjVUY5Y2FXZWhlekJ4K1g4UmRUWHllRW1NV2grTXI5WHhPWVc3NmY4?=
 =?utf-8?B?eExjMldTWVVoOWVjTm1xcGhDMjVkZUFmNFUvQ3BWamswNUFrQ1AwSlRiSEo4?=
 =?utf-8?B?S21odjB2Z0dObFIzNTZ6aFN1Sy9DM2wyMGczUHJpSEl3clpraXB1WUZjZHNn?=
 =?utf-8?B?YWVjTzBEMzh2Y210RWRZdHJoSXV4cHdiZzg0aWo1QmNDSWVFTWZoQ1lEalRL?=
 =?utf-8?B?ejljeXpseUlmWCtBUUFDMWJ1NGhOanhybWx2V1lzcG9kNzRGcFExdCszRW1n?=
 =?utf-8?B?RzhaS3hsSGZxZEcxdk1oQkNzZGR1RWVIQVJzOUFZYkxMdExla1UvSm9peGlR?=
 =?utf-8?B?Y0FUZVcxc1pkakhoeVE4MlBiZ1hvaWw5Y3NSc0luZkdtUGIxTVNuRjZyaGM0?=
 =?utf-8?B?aU5pOEs0ektEMllsYmFNVmdpeUlDcEFNdzgyNkJKcDU5eTlxWFRQRldHMHNX?=
 =?utf-8?Q?yiAy/axiPr6hAnQF2w55AKQCEUZOa2xm2cYVjuJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <872871E4C4817B4197A2BA71FEAC571A@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2962b41b-1059-4b76-60e5-08d90421aa70
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 17:28:08.8991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16bivPu06FBOf4327kkTffvJY4WN7S2nMluL9M4xQZdLbQW15uiAKO3vITfmzKL7RjT8G71ZYjQ6bDIxZBvo6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB1084
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA0LTIwIGF0IDEzOjE4IC0wNDAwLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6
DQo+IE9uIFR1ZSwgQXByIDIwLCAyMDIxIGF0IDAyOjMxOjU4UE0gKzAwMDAsIFRyb25kIE15a2xl
YnVzdCB3cm90ZToNCj4gPiBJIHRoaW5rIHRoZSBpbXBvcnRhbnQgdGhpbmcgaXMsIGFzIENodWNr
IHNhaWQsIHRoYXQgdGhlIHNldHRpbmcgb2YNCj4gPiB0aGUNCj4gPiB1bmlxdWlmaWVyIGhhcyB0
byBiZSBhdXRvbWF0ZWQuIFRoZXJlIGFyZSB0b28gbWFueSBpbnN0YW5jZXMgb3V0DQo+ID4gdGhl
cmUNCj4gPiBvZiBwZW9wbGUgd2hvIGdldCBjb25mdXNlZCBiZWNhdXNlIHRoZXkgYXJlIHVzaW5n
IGEgZGVmYXVsdA0KPiA+IGhvc3RuYW1lLA0KPiA+IHN1Y2ggYXMgJ2xvY2FsaG9zdC5sb2NhbGRv
bWFpbicgYW5kIGFyZSBzZXR0aW5nIG5vIHVuaXF1aWZpZXIuDQo+ID4gDQo+ID4gU28gdGhlIHBv
aW50IGlzIHRoYXQgaXQgbmVlZHMgdG8gYmUgcGVyc2lzdGVkIGJ5IGFuIGF1dG9tYXRlZA0KPiA+
IHNjcmlwdCBpZg0KPiA+IHVuc2V0Lg0KPiA+IA0KPiA+IFdoaWxlIHRoYXQgc2NyaXB0IGNvdWxk
IHVzZSBuZnNjb25mIHRvIGdldC9zZXQgdGhlIHBlcnNpc3RlZA0KPiA+IHVuaXF1aWZpZXIsIHRo
ZSB3b3JyeSBpcyB0aGF0IHN1Y2ggYW4gYXV0b21hdGVkIGNoYW5nZSBtaWdodCBiZQ0KPiA+IG1h
ZGUNCj4gPiB3aGlsZSB0aGUgdXNlciBpcyBwZXJmb3JtaW5nIHNvbWUgb3RoZXIgZWRpdCBvZiBu
ZnMuY29uZi4gV2hhdA0KPiA+IGhhcHBlbnMNCj4gPiB0aGVuPw0KPiANCj4gVGhlIG9uZSB0aGlu
ZyBJJ20gYSBsaXR0bGUgdW5lYXN5IGFib3V0IGlzIGlnbm9yaW5nIC9ldGMvbWFjaGluZS1pZC4N
Cj4gU2VlbXMgbGlrZSBkaXN0cm9zICpzaG91bGQqIGJlIGNyZWF0aW5nIGl0IGZvciB1cy7CoCBB
bmQgaXQgd291bGQgYmUNCj4gY29udmVuaWVudCB0byBoYXZlIG9uZSBzb3VyY2Ugb2YgbWFjaGlu
ZSBpZGVudGl0eSByYXRoZXIgdGhhbg0KPiBzZXBhcmF0ZQ0KPiBvbmVzIGZvciBkaWZmZXJlbnQg
c3Vic3lzdGVtcy4NCj4gDQo+IE1heWJlIHdlIGNvdWxkIHVzZSB0aGF0IGlmIGl0IGV4aXN0cywg
YW5kIGZhbGwgYmFjayBvbiBnZW5lcmF0aW5nIG91cg0KPiBvd24gb25seSBpZiBpdCBkb2Vzbid0
Pw0KPiANCj4gKFdlbGwsIHdoZXJlICJ1c2UgaXQiIGFjdHVhbGx5IG1lYW5zIHRha2UgYSBoYXNo
IG9mIGl0LCBhcyBleHBsYWluZWQNCj4gaW4NCj4gbWFjaGluZS1pZCg1KS4pDQo+IA0KDQpNYXli
ZSwgYnV0IHRoYXQgdGllcyB0aGUgbmZzLXV0aWxzIHBhY2thZ2UgaXJyZXZvY2FibHkgdG8gc3lz
dGVtZC4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5l
ciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
