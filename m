Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC8365ED6
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 19:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhDTRyL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 13:54:11 -0400
Received: from mail-bn7nam10on2125.outbound.protection.outlook.com ([40.107.92.125]:64801
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233450AbhDTRyI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Apr 2021 13:54:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrn0Wm3N6yXqjpiG4EvVnaTBG6yyVd5hggHDCPcuAD9gI7XxGaJ3N30aYHlPcB0PUmCuZgB77APh5M1XDaDG8rQkP8l3hjLOVJTl2BGCPLAoLWdLpuk1nt9waTgGa2g8PghHM9LmJUH6Uy06hCvySOvmZHSgokyucuAXcO8pLbqpOUkO2duwjE1LPAi+2s8lyeX6FjPeeWU9KmndqjGIXBYS1JVgDje3BWZZK9xjGJ8OXaIsszOvdBqpry5V9jD58snb+F53KrE8Yr+I32gt8oJuDpm4TcKlQqLBMw0BoPuoRRt0RefNdQjQKu72cB/MtSXP9M7Wye7Qw4bPn33fiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2ZNUnFruK1C6YXI/DakuKzuRVJ8VCTZ8GCP7mybCS0=;
 b=GjN+PS2vN4KCqeS/n4yxuOUUEvd7tD12xJvFVrVu71sH5JdzD/lemVpAxknBHyGd8+LkhmfSgC7xCwnT3VI9XAOoINx5e2tWVRhJNlSGEnxY22npt6hqeciO/S8R4Ci3QVU/BnDIPyc2fGHseYQH1N9t14rbtnj+kCiKOI3q+b857zyFx1TwbaHJRMDJ3yoh4wwHHnmKzKleWBSVZu9O1Z/WFUtH86pcMR5D2aWi9HM/i6o38WzVMKtJbD7J4GUHoAhcuc15lPzMS6IUJn2AdTcCJxhk0RcRDtKBD1n59VgI8hJyn5DG9kYFlAZvvUqmBAq9tJoNOcYFhv2K1evmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2ZNUnFruK1C6YXI/DakuKzuRVJ8VCTZ8GCP7mybCS0=;
 b=dDFt4nk93OwsL6eCeD9ajAJwoq4JfiSdZaRbW8EQjRFrY2bgX+hTnyu10W0iXYvgcZDJ71dcMl5KdNzbudDWg6AwD0OFD4WtOuJU3k5YH4/JsClNeF7tCrYuGsTXFY8SJzrPIyiM7U5lTbpmysXY2jO0wqGxjg+WkxhdaC6dbEY=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM5PR1301MB2073.namprd13.prod.outlook.com (2603:10b6:4:34::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6; Tue, 20 Apr
 2021 17:53:35 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::f414:a9a:6686:f7e0%4]) with mapi id 15.20.4065.020; Tue, 20 Apr 2021
 17:53:34 +0000
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
Thread-Index: AQHXMVl4VT45tjmxiUS0kqeKowHWU6q0qJsAgAEODwCAABHMAIADH5EAgAAEzACAABTdAIABgaqAgALnPICAABBfgIAABi2AgAAubACAAALMgIAAA30AgAADnoA=
Date:   Tue, 20 Apr 2021 17:53:34 +0000
Message-ID: <85b4ca155d1697a714be88a67c505d287e22be46.camel@hammerspace.com>
References: <366FA143-AB3E-4320-8329-7EA247ADB22B@oracle.com>
         <77a6e5a4-7f14-c920-0277-2284983e6814@RedHat.com>
         <2F7FBCA0-7C8D-41F0-AC39-0C3233772E31@oracle.com>
         <c13f792a-71e8-494f-3156-3ff2ac7a0281@RedHat.com>
         <DAFAF7B1-5C56-4DA7-B7F9-4F544CCDA031@oracle.com>
         <f0525973-a32c-32d4-4ccc-827acaa3c125@RedHat.com>
         <20A43DDA-C08E-4E39-A83C-24E326768ADE@oracle.com>
         <2d7d391802a3984b68aa8b3e7f360b0b6cb733dc.camel@hammerspace.com>
         <20210420171806.GC4017@fieldses.org>
         <be1a2b6beab29b3e40277f5fefd6c49b37c32361.camel@hammerspace.com>
         <20210420174036.GD4017@fieldses.org>
In-Reply-To: <20210420174036.GD4017@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a17ca0d6-86ee-42e2-7e21-08d904253807
x-ms-traffictypediagnostic: DM5PR1301MB2073:
x-microsoft-antispam-prvs: <DM5PR1301MB2073A0FF92BF438973D3050EB8489@DM5PR1301MB2073.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BA0738VAa0lTvKEAQ02rxjUfLlCkoEIEbZvwWxjS9J0c194kL5pFf8JRA6Ha4vjHxpZseyQsMuVrz4c9JiP5XS6E/QFv4RRVbJRdCO+10Waz2Bw5aF03OlOM96CXtKyWmBq06IraGntRoNgHwqOb3YUpJIUuBrUbNKg4KyCiNMAKxdsgrYrE7pXXbx4fEuI+dlfRoT8d2/z3Dbjw2CVCfOvAJDl/zH7YRLBmMrnPfC3JSkGo0LE0+C8/4ZAMRwg8doxYSgdtpjb/XeAJ8Fnip36dAlaK1oDv5047+ozxXhNppnRU954oRjQOlxrf2H/5DSaIKXyPznB9MgCxri17umAnnGnysCDgSFwDNCwNCd7/w265eit/XVhMrXjzXqfxP24rQF0psIgg5M6tVW9RMdJkIHWjxR69wIN81SI48h8DkkQnFY+vTHG9Lis5c/2EUN7OUhycTDAUpTtqoz2Yyghd+45PVwy6ad4bcRa/KroZpejkb1gfhXNCGAM9G8tCqTdwyn6DMLjt64v2Oj4Xr3PbtIJpstItIv6a67EbOmyCif296QpeI5aionefYOzjnKxYorJjMakzQBs8M4c7h86mP3paBiEm20y/p1HGqvA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39830400003)(376002)(346002)(136003)(83380400001)(8936002)(86362001)(6916009)(38100700002)(26005)(76116006)(66446008)(66476007)(186003)(66556008)(54906003)(2616005)(36756003)(4326008)(122000001)(2906002)(91956017)(6506007)(64756008)(8676002)(66946007)(316002)(6486002)(478600001)(6512007)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QVA0M213WHlCSjBZQ3VyL0lyd1QwN0NXR3ppNHdUQmFHeUVtU0hqMjI1WGFj?=
 =?utf-8?B?YmtMaGoza2RIMTFpZGNLNHZpQ0dDblNLUk1JaDRQekdIa2FCSUZSNUFvUDY1?=
 =?utf-8?B?YTV3cHNTOEg5N0Y2a3JjOEN3bGIrWFZGQ1Z5a1gvdGtoNytsT2pka1l2c1FZ?=
 =?utf-8?B?ZHV3R2JkSUxyRUxjNGE2QVBqNkZxdlE3ZU9DVktDa2lTc3p1TkJwVSs1L2RY?=
 =?utf-8?B?bUhLb3ZKYytpVkdtNzByc2JLaDE1REdhVWVqWGpObWtMdUNoTmdkZmlmdDdy?=
 =?utf-8?B?SVF3RGFUZVVveUpxU3JJKzJ3b2lYYWpaRkZZWmRydFZweGQzMk5mYmhkVmZN?=
 =?utf-8?B?NkM3VUtiZngxN0N4d0l1aVVCZEd6SHBDREk2Q0ZiVGRmUVpvU3NWdjFwaTkz?=
 =?utf-8?B?cU9DaS85dEJ1R3oxZUJ0NUpEWmNMdk5pcTNCTXRVdEJJL1VzN2RsRUxrc2FT?=
 =?utf-8?B?OURBYThpUUVTb3ZBU3BtWkJXaEJRRjNuR2t2MHhYcGYzbDBEOTBBRzU3RWcy?=
 =?utf-8?B?NlhPYmRoYmI3MFBnVWpQN0kzOHlMNGRxcU1YSDNhYS9EWndyRjQ2dFN2VEJL?=
 =?utf-8?B?THZHSFh2aHJJZ0JTbnEyQjZYbW9ZRHZCWDJmL1RmbXBvUU9hT2pENzVLVDFO?=
 =?utf-8?B?TTA4ZHIzYzVlT21PT0sxalNzNmg5YjJTVFRVWTlLUCtsUGJXTFh5UzRSaWFv?=
 =?utf-8?B?UHhuTXNCWEREVzUrWUdpVDE3S2lQeDU3L3ltKzBaa2RsaWJFbnl3ajBCc3R2?=
 =?utf-8?B?cnZMZXl1Q2ExT0EvMmdiQmgzVEkzUWwwclppTlFaSXlDSWREditRaE82Qnov?=
 =?utf-8?B?S2tFOHp4V3pvSTd3a3p1MzRpQ0J6Q015N3d4S0tyeFA1aUJxdDlaVWt2QlVU?=
 =?utf-8?B?cFdSOHRDUEFXZGhGVnRJZ3p5dDRmT1h2L3FHNDhrVVFrejhyamFteVBXMkQ3?=
 =?utf-8?B?bnlFdmNDdXd5RUcrWndTcjArT3JRelFtbHRnWG5qYVZldytqeUQ1NnVKTmtC?=
 =?utf-8?B?L1RVaEkvalQ4VlVlREwwcmV5SFBKdTE1ZXF4WGgwQkNrckxTWUJqVG5iMmtE?=
 =?utf-8?B?Q0xwZExmQlI3S0dIM1VuRXF5V0dnSGtBQlJHd1dhdGdXUkNsSzNtSk1tRHQx?=
 =?utf-8?B?Q1IxVWg4S1dOL1hieWpvN3NoVmpNOUMzdyt3RUJpV2NqY1pncDJrSURqWFZG?=
 =?utf-8?B?ZHY3cWtjZjN0MXJSUWxOT1BIOWsxUm9YSWEwZnp4UmRieVAxdTNVRDFNU1Rx?=
 =?utf-8?B?S3BTeFJaaVVWUzJPWXBKb3VNNGNXa1JWQkFuaUZLczd5dWdieXZRc1BvbW9L?=
 =?utf-8?B?UHFySmJtUkk1Ynk0b2R3eEN0LzVIRXB0SFhGVFdCT2FER0Z5VGlQRko2TkNT?=
 =?utf-8?B?Q1g3M3VFN1BiRllnTHFBMllBVG05MTI0Yk8reWsrY0t1TUY5bUE1K2JEK2lr?=
 =?utf-8?B?bW44Ry91WmxGM1VvSXBOUkZZYjlyb0JWUTJ6ZXdZUkNiWjRqeld1elM1VG9x?=
 =?utf-8?B?VDJMdEcvRjM5RUw3QjhscHgzQW1TNG8xL05ybEVKREpLekFHcGlVUjEyUkpu?=
 =?utf-8?B?RzVrYlZUeG9DRjBieStVeUcvemJLY3pWTHhIU1lxcjQrMFRFWXB1YVloRlQ3?=
 =?utf-8?B?bEh5NGwwOStZSTlWODhpZXJPd2t0c0lPbEx5dXoybEdKVFRKVlF4QnNIWElP?=
 =?utf-8?B?Tlk2ZWEyVXBDalhLWXNReU5rbUJ5b3lKRWlNdTV2V3MzY0hMVmxIVnI5U1BZ?=
 =?utf-8?Q?qms+hhUBh7NJyLWITBX33D/ZK2JPDyTpYCyddS2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C758E3165355F4C8A9B3C51536E0EB6@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17ca0d6-86ee-42e2-7e21-08d904253807
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 17:53:34.8657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 27vlYBI4YlLw9l1LjiUkQkZhq6KdtBAMW46aIyv7VlSr03sCrzg2u6uNZo3lEElCsZu0aPBtSy993jZcv15yag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1301MB2073
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA0LTIwIGF0IDEzOjQwIC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVHVlLCBBcHIgMjAsIDIwMjEgYXQgMDU6Mjg6MDhQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyMS0wNC0yMCBhdCAxMzoxOCAtMDQwMCwg
Si4gQnJ1Y2UgRmllbGRzIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBBcHIgMjAsIDIwMjEgYXQgMDI6
MzE6NThQTSArMDAwMCwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOg0KPiA+ID4gPiBJIHRoaW5rIHRo
ZSBpbXBvcnRhbnQgdGhpbmcgaXMsIGFzIENodWNrIHNhaWQsIHRoYXQgdGhlIHNldHRpbmcNCj4g
PiA+ID4gb2YNCj4gPiA+ID4gdGhlDQo+ID4gPiA+IHVuaXF1aWZpZXIgaGFzIHRvIGJlIGF1dG9t
YXRlZC4gVGhlcmUgYXJlIHRvbyBtYW55IGluc3RhbmNlcw0KPiA+ID4gPiBvdXQNCj4gPiA+ID4g
dGhlcmUNCj4gPiA+ID4gb2YgcGVvcGxlIHdobyBnZXQgY29uZnVzZWQgYmVjYXVzZSB0aGV5IGFy
ZSB1c2luZyBhIGRlZmF1bHQNCj4gPiA+ID4gaG9zdG5hbWUsDQo+ID4gPiA+IHN1Y2ggYXMgJ2xv
Y2FsaG9zdC5sb2NhbGRvbWFpbicgYW5kIGFyZSBzZXR0aW5nIG5vIHVuaXF1aWZpZXIuDQo+ID4g
PiA+IA0KPiA+ID4gPiBTbyB0aGUgcG9pbnQgaXMgdGhhdCBpdCBuZWVkcyB0byBiZSBwZXJzaXN0
ZWQgYnkgYW4gYXV0b21hdGVkDQo+ID4gPiA+IHNjcmlwdCBpZg0KPiA+ID4gPiB1bnNldC4NCj4g
PiA+ID4gDQo+ID4gPiA+IFdoaWxlIHRoYXQgc2NyaXB0IGNvdWxkIHVzZSBuZnNjb25mIHRvIGdl
dC9zZXQgdGhlIHBlcnNpc3RlZA0KPiA+ID4gPiB1bmlxdWlmaWVyLCB0aGUgd29ycnkgaXMgdGhh
dCBzdWNoIGFuIGF1dG9tYXRlZCBjaGFuZ2UgbWlnaHQgYmUNCj4gPiA+ID4gbWFkZQ0KPiA+ID4g
PiB3aGlsZSB0aGUgdXNlciBpcyBwZXJmb3JtaW5nIHNvbWUgb3RoZXIgZWRpdCBvZiBuZnMuY29u
Zi4gV2hhdA0KPiA+ID4gPiBoYXBwZW5zDQo+ID4gPiA+IHRoZW4/DQo+ID4gPiANCj4gPiA+IFRo
ZSBvbmUgdGhpbmcgSSdtIGEgbGl0dGxlIHVuZWFzeSBhYm91dCBpcyBpZ25vcmluZyAvZXRjL21h
Y2hpbmUtDQo+ID4gPiBpZC4NCj4gPiA+IFNlZW1zIGxpa2UgZGlzdHJvcyAqc2hvdWxkKiBiZSBj
cmVhdGluZyBpdCBmb3IgdXMuwqAgQW5kIGl0IHdvdWxkDQo+ID4gPiBiZQ0KPiA+ID4gY29udmVu
aWVudCB0byBoYXZlIG9uZSBzb3VyY2Ugb2YgbWFjaGluZSBpZGVudGl0eSByYXRoZXIgdGhhbg0K
PiA+ID4gc2VwYXJhdGUNCj4gPiA+IG9uZXMgZm9yIGRpZmZlcmVudCBzdWJzeXN0ZW1zLg0KPiA+
ID4gDQo+ID4gPiBNYXliZSB3ZSBjb3VsZCB1c2UgdGhhdCBpZiBpdCBleGlzdHMsIGFuZCBmYWxs
IGJhY2sgb24gZ2VuZXJhdGluZw0KPiA+ID4gb3VyDQo+ID4gPiBvd24gb25seSBpZiBpdCBkb2Vz
bid0Pw0KPiA+ID4gDQo+ID4gPiAoV2VsbCwgd2hlcmUgInVzZSBpdCIgYWN0dWFsbHkgbWVhbnMg
dGFrZSBhIGhhc2ggb2YgaXQsIGFzDQo+ID4gPiBleHBsYWluZWQNCj4gPiA+IGluDQo+ID4gPiBt
YWNoaW5lLWlkKDUpLikNCj4gPiA+IA0KPiA+IA0KPiA+IE1heWJlLCBidXQgdGhhdCB0aWVzIHRo
ZSBuZnMtdXRpbHMgcGFja2FnZSBpcnJldm9jYWJseSB0byBzeXN0ZW1kLg0KPiANCj4gV2VsbCwg
bGlrZSBJIHNheSwgd2UgY291bGQgaGF2ZSBhIGZhbGxiYWNrLsKgIE9yIGV2ZW4gcHJvdmlkZQ0K
PiBhbHRlcm5hdGl2ZQ0KPiBzY3JpcHRzIGluIG5mcy11dGlscyBhbmQgbGV0IHRoZSBkaXN0cm8g
ZGVjaWRlIHdoaWNoIHRvIGluc3RhbGwNCj4gZGVwZW5kaW5nIG9uIHdoZXRoZXIgdGhleSB1c2Ug
c3lzdGVtZC4NCj4gDQo+IEJ1dCwgd2hhdGV2ZXIsIHRob3NlIHR3byBhbHRlcm5hdGl2ZXMgKG1h
Y2hpbmUtaWQgb3IgdnMuIG5mcw0KPiBnZW5lcmF0aW5nDQo+IGl0cyBvd24gdXVpZCkgYXJlIGJh
c2ljYWxseSB0aGUgc2FtZSBvbiBzb21lIGxldmVsLg0KDQpOb3QgcXVpdGUuIFRoZXkgY2F1c2Ug
dGhlIGJlaGF2aW91ciB0byBkaWZmZXIgZGVwZW5kaW5nIG9uIHdoZXRoZXIgb3INCm5vdCBzeXN0
ZW1kIGlzIGluc3RhbGxlZC4gU28gaWYgeW91IGltYWdpbmUgYSBzeXN0ZW0gdGhhdCBnZXRzIHVw
ZGF0ZWQNCmZyb20gInRyYWRpdGlvbmFsIGluaXQiIHRvIHN5c3RlbWQsIHRoZW4gdGhhdCBjb3Vs
ZCBjYXVzZSB0aGUgTkZTDQppZGVudGl0eSBvZiB0aGUgbWFjaGluZSB0byBjaGFuZ2UuDQoNCkl0
IHdvdWxkIGJlIGJldHRlciB0byBiZSBhYmxlIHRvIHNwZWNpZnkgdGhlIGlkZW50aXR5IGluIGEg
Zm9ybSB0aGF0IGlzDQppbmRlcGVuZGVudCBvZiB0aGUgcGxhdGZvcm0uDQoNClNvIGlmIHRoZSBt
YWNoaW5lLWlkIGV4aXN0cywgdGhlbiBtYXliZSB3ZSBjb3VsZCBpbmRlZWQgZ2VuZXJhdGUgdGhl
DQppZGVudGl0eSB1c2luZyB0aGUgdXVpZCBpbiB0aGF0IGZpbGUgKGFsdGhvdWdoIHRoZSBxdWVz
dGlvbiByZW1haW5zIGFzDQp0byB3aHkgeW91J2Qgd2FudCB0aGF0PykuIEhvd2V2ZXIgdGhlIGdl
bmVyYXRlZCB2YWx1ZSBzaG91bGQgdGhlbiBiZQ0KcGVyc2lzdGVkIHNlcGFyYXRlbHkgc28gdGhh
dCBpdCBjYW4gYmUgcGxhdGZvcm0gaW5kZXBlbmRlbnQuDQoNCj4gDQo+IEkgYWdyZWUgd2l0aCB0
aGUgYmFzaWMgaWRlYSB0aGF0IHRoaXMgc2hvdWxkIGJlIGF1dG9tYXRlZCByYXRoZXIgdGhhbg0K
PiBsaXZpbmcgaW4gYSBjb25maWd1cmF0aW9uIGZpbGUgdGhhdCBodW1hbnMgbWlnaHQgaGF2ZSB0
byBkZWFsIHdpdGguDQo+IA0KPiAtLWIuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
