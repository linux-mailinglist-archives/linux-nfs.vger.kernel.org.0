Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00862CE0D0
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 22:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgLCVfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 16:35:22 -0500
Received: from mail-dm6nam11on2139.outbound.protection.outlook.com ([40.107.223.139]:37856
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725885AbgLCVfV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 3 Dec 2020 16:35:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kt71TduI48ClpnUvoF8bKjjH1pxjd3sxkwkc6GT9as5ENLiSLekyn1/yLoVj5+wxM4gSWSkPJ8/wBUQV+Gx86rFFHdCbxZ9QSDVd6OF2UlykaGcOydnaR1nqnzW25yU7uuxxY/QEo/z+Yaq32uP3xXb8afAwkIkj6nDWjUurx4WWwsYYmcRWArO6+TMoDz/9JH9hZnY3eSOzfSC4JoUOh1A1+QkeiqNgaweQBXHBosVN0zwnF+0e2Ta2/AcGOLZNqjhwC+R2Dm0211sY5bAwYcUjbFzhT7ydujjEMdDkAdVcOZq6koPWjsMcOKgtWQq0SYrntA1uj1OoJGsfTh0HDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y34VOKInmNUcT54XDotBxmLoyhvRitFIS+gt/ns5AxY=;
 b=Gp87YgHFiUMWv06nOaAm3yqHmhaxAWizD8zBEYuileAluHq9IWCjuuwrJjDn5f7qUXVPXOu65YpEbvKioJjT9zrqmBJKLktcFifF0Z2xLJjREq41pswxbe7cl2o7oDRcZbxufYdy2BHsas4C9Wv2VB0EwFSf3adcYvYT/WInN65ZnEbGtJxfXKvIU86+dro5CQ4yVPsD2Bf4ol8hWZ4GE7bRB7Xdi+6zsVnt6+uOLAz7nZwrttD4bdbJ+AbwFNbmQCCcRPDYB35lSg/rNn9cZTIPTKgbJoSV6BwB/fqMe7mfGsiulpVUfV09ShHYkD/X1pOfdBIH1QwW4i34OFBtZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y34VOKInmNUcT54XDotBxmLoyhvRitFIS+gt/ns5AxY=;
 b=Src+G+nHmCLyRbIo6ofAEHZFfgxS3m3nwxZX13l3VPmvQ08krs6v1HUxkJ7V+WbkS25jfEJPaIuEu02unYFKV8+wDKd1+1ta6eHy61wOI0ZkgkXC0ruzkjYmJhZ9VZjCHG+n72qo03dl/xI8X+/0rhO81ODj5NT9ymMNZEDVAOI=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB2736.namprd13.prod.outlook.com (2603:10b6:208:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6; Thu, 3 Dec
 2020 21:34:26 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3632.016; Thu, 3 Dec 2020
 21:34:26 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "daire@dneg.com" <daire@dneg.com>
Subject: Re: Adventures in NFS re-exporting
Thread-Topic: Adventures in NFS re-exporting
Thread-Index: fNDm/l4o9cYx5Rz5g0S1EO4zMAtIR4tJDJwAAAWCe4BeKhpLVGiQL7pUtKchSdvFeTqNAIAEhEYAgBNavQCAAAtBAIABTyGAgAxAb4CAAG0ggIAAGvSAgAAMzwCAAAXZAA==
Date:   Thu, 3 Dec 2020 21:34:26 +0000
Message-ID: <9df8556bf825bd0d565f057b115e35c1b507cf46.camel@hammerspace.com>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
         <635679406.70384074.1603272832846.JavaMail.zimbra@dneg.com>
         <20201109160256.GB11144@fieldses.org>
         <1744768451.86186596.1605186084252.JavaMail.zimbra@dneg.com>
         <1055884313.92996091.1606250106656.JavaMail.zimbra@dneg.com>
         <20201124211522.GC7173@fieldses.org>
         <932244432.93596532.1606324491501.JavaMail.zimbra@dneg.com>
         <1403656117.98163597.1606998035261.JavaMail.zimbra@dneg.com>
         <20201203185109.GB27931@fieldses.org>
         <4903965f2beb742e0eca089b5db8aa3a4cabb7f0.camel@hammerspace.com>
         <20201203211328.GC27931@fieldses.org>
In-Reply-To: <20201203211328.GC27931@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a664a139-3135-4375-ba9f-08d897d3357d
x-ms-traffictypediagnostic: MN2PR13MB2736:
x-microsoft-antispam-prvs: <MN2PR13MB2736423A43FB4BD19129289EB8F20@MN2PR13MB2736.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7EY4S3SoX2PvPBDwMEl3C7rqDjZ656ZNLb60YKbGX1ciksflc9zE50YDHARMnUaRZH0XPHqz+UeLZnpsaXx0B/d1et0pqiAiMmTl9l7VYGHWcJvCeAgYL4A5CKCwS+Un2H5uuXxNnT/HbSdGhbFiJA5BV50sBNQwtsKc71YsI2pJJkPNnEmyTaxZVSz1x8mbF9TZ4uOL/oNDPsU1Qs+9CWKfkiX8PtPIIUWv+4qvpuU2WyWv/6XL1vAgnhHNp1rVQYLRAgBnju4mozjvaau09iskJeIhte/QQINDzESsJBJBGN9S71bKtqNTaeKp9HLCcJj0umqXBGtbpDUrsJgW33P1IBS02F5XPe2kfTRg71U3E9Ds0Q+6F0b7VMxgIcxtCqKfQqvfnQo8C2K9+RmXzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39840400004)(136003)(346002)(376002)(396003)(86362001)(8936002)(6506007)(26005)(71200400001)(2906002)(4326008)(36756003)(66476007)(64756008)(66446008)(478600001)(2616005)(66556008)(91956017)(66946007)(76116006)(966005)(186003)(6486002)(6512007)(6916009)(8676002)(16799955002)(5660300002)(83380400001)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dUEwTVF2b1FXTVlETHlodFloRDVFTWszYkRLUkRmMHJTWnE2UEZlaFl4TENQ?=
 =?utf-8?B?aHhCWFRUNTZBSDNZWlliKy9QVFR0Q0ZiN0FjVzMzaXBrV2lwVE51UG5iNmI4?=
 =?utf-8?B?UkI4a1dOU1ZTTGh2WG9wWHp5N1NIMjdLYUZJWjB2TTZYTk9wbkM3NkMxN05m?=
 =?utf-8?B?STdSby9wK0dKOEpFZVhUcmVwdmVodGtwS2xMTFhsYzl4Z2s4akc0ZHNHUlkz?=
 =?utf-8?B?aVdydWxESW9ET2wwODBwanpGaHZIOG8wR3V4UGNFcTJoVGpRUzBPdGtBbko1?=
 =?utf-8?B?SGNjQXRpWVNQNlA2elk5cTlVOGw3YzZzSjZsV2Y3c2lVZWVKYklMSnRUaURh?=
 =?utf-8?B?UGRWNXF6OHROSm5TcHdrRUZkYmxZei8vSUFlN1VOaWlOb3g0S2p0bHBvK3ky?=
 =?utf-8?B?WWFYRTU1LzZHcCsvQXM0OTFWMk5wTy9uU283KzZHZklPL1ZBL1ZnVHhiOFFF?=
 =?utf-8?B?U0t6N0xzc1JYTTJZeW5KSk9xWVlpTzNDYjMyQ1lXcnJwVHBoQjFjUll5blBG?=
 =?utf-8?B?cThubUtRNFJZQnlQOHdIVHFMcVgrRlNlVWhBRXBTV3BRNi9LRExabXpJOHFj?=
 =?utf-8?B?d3dXZ0pIUkJ4dTRITVM0NEhuM25hYTBaYkxTdmxyVzRUWEFkTFBGU2FxempR?=
 =?utf-8?B?YkVlK1djRTM1eFR1bWlUUXcrVlRkei9lU3VpcVliTXlDNGxuSjU5TjdlbkJ3?=
 =?utf-8?B?WC9jYm1lVldVRmI0Ym5xUHdzazJKcFlCRFpOaEdUWVdwd3dUcjgydGRFN0Z3?=
 =?utf-8?B?Z3N3N05qVndBQ0FXSWJDcVhyc0RoYzYzOVQxTVVLbWFoT3Irb3pteGdLRGY3?=
 =?utf-8?B?UGNYSkhFVU5DTkdOODNUUnZuM2FlbThBVko2R2lYRXBPK2ZVOHh3QlQvVHJv?=
 =?utf-8?B?WjJmTmJEeWg5MHlBYmhSTFFVcUhzblNmSUZ3cGRad1MzTS8wbzBLL2JBK0Fn?=
 =?utf-8?B?RUZxaDN4YTZnTEw4YWxtMm1rVEU5R1dIUkN0V011Si9TUkFUS3Eyc1l6eERC?=
 =?utf-8?B?ejFVQXFYZ0Y4NDFXY3Jiam4yUCtacUtwTXBIdWNvbTltMUtSZy9OWGZHM2xu?=
 =?utf-8?B?SFdPSDdlTlhZZjBTakRkOGVFc2tyOXliVXkxckhCTWdaQ1JzTGw5a1p1V2dU?=
 =?utf-8?B?RDZ6d1Yyb2djUWVNZzc0cU01MHlUQWVkNDA0aTRtZ2x1TzJud2FWVmE3OEQy?=
 =?utf-8?B?U0FFZ3lRTDhYaU5QRUlZNlk4dUlSeldlbmh3WjZ6VnAybTRHcVdZN0FnQXM5?=
 =?utf-8?B?Q1YxMkVEVEE3SG5pd0d6RVU4ZzQvK254NnZTemFwYnVzMGN6cCtLSzIybVVH?=
 =?utf-8?Q?dot7ua90metHTYV21PegrUNvXztXLS/z4I?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <07CEFFFB5926D24B901968826DF1CB66@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a664a139-3135-4375-ba9f-08d897d3357d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 21:34:26.2419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nbeo8XUy//kidJdISdUeoZYvL+AtXHK/1xaMnZmZ+xN25PMtyth5Mhst1l7b3pAXtkZPnnQbieeN938euJkMlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2736
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDE2OjEzIC0wNTAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVGh1LCBEZWMgMDMsIDIwMjAgYXQgMDg6Mjc6MzlQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyMC0xMi0wMyBhdCAxMzo1MSAtMDUwMCwg
YmZpZWxkcyB3cm90ZToNCj4gPiA+IEkndmUgYmVlbiBzY3JhdGNoaW5nIG15IGhlYWQgb3ZlciBo
b3cgdG8gaGFuZGxlIHJlYm9vdCBvZiBhIHJlLQ0KPiA+ID4gZXhwb3J0aW5nDQo+ID4gPiBzZXJ2
ZXIuwqAgSSB0aGluayBvbmUgd2F5IHRvIGZpeCBpdCBtaWdodCBiZSBqdXN0IHRvIGFsbG93IHRo
ZSByZS0NCj4gPiA+IGV4cG9ydA0KPiA+ID4gc2VydmVyIHRvIHBhc3MgYWxvbmcgcmVjbGFpbXMg
dG8gdGhlIG9yaWdpbmFsIHNlcnZlciBhcyBpdA0KPiA+ID4gcmVjZWl2ZXMNCj4gPiA+IHRoZW0N
Cj4gPiA+IGZyb20gaXRzIG93biBjbGllbnRzLsKgIEl0IG1pZ2h0IHJlcXVpcmUgc29tZSBwcm90
b2NvbCB0d2Vha3MsIEknbQ0KPiA+ID4gbm90DQo+ID4gPiBzdXJlLsKgIEknbGwgdHJ5IHRvIGdl
dCBteSB0aG91Z2h0cyBpbiBvcmRlciBhbmQgcHJvcG9zZQ0KPiA+ID4gc29tZXRoaW5nLg0KPiA+
ID4gDQo+ID4gDQo+ID4gSXQncyBtb3JlIGNvbXBsaWNhdGVkIHRoYW4gdGhhdC4gSWYgdGhlIHJl
LWV4cG9ydGluZyBzZXJ2ZXINCj4gPiByZWJvb3RzLA0KPiA+IGJ1dCB0aGUgb3JpZ2luYWwgc2Vy
dmVyIGRvZXMgbm90LCB0aGVuIHVubGVzcyB0aGF0IHJlLWV4cG9ydGluZw0KPiA+IHNlcnZlcg0K
PiA+IHBlcnNpc3RlZCBpdHMgbGVhc2UgYW5kIGEgZnVsbCBzZXQgb2Ygc3RhdGVpZHMgc29tZXdo
ZXJlLCBpdCB3aWxsDQo+ID4gbm90DQo+ID4gYmUgYWJsZSB0byBhdG9taWNhbGx5IHJlY2xhaW0g
ZGVsZWdhdGlvbiBhbmQgbG9jayBzdGF0ZSBvbiB0aGUNCj4gPiBzZXJ2ZXINCj4gPiBvbiBiZWhh
bGYgb2YgaXRzIGNsaWVudHMuDQo+IA0KPiBCeSBzZW5kaW5nIHJlY2xhaW1zIHRvIHRoZSBvcmln
aW5hbCBzZXJ2ZXIsIEkgbWVhbiBsaXRlcmFsbHkgc2VuZGluZw0KPiBuZXcNCj4gb3BlbiBhbmQg
bG9jayByZXF1ZXN0cyB3aXRoIHRoZSBSRUNMQUlNIGJpdCBzZXQsIHdoaWNoIHdvdWxkIGdldA0K
PiBicmFuZA0KPiBuZXcgc3RhdGVpZHMuDQo+IA0KPiBTbywgdGhlIG9yaWdpbmFsIHNlcnZlciB3
b3VsZCBpbnZhbGlkYXRlIHRoZSBleGlzdGluZyBjbGllbnQncw0KPiBwcmV2aW91cw0KPiBjbGll
bnRpZCBhbmQgc3RhdGVpZHMtLWp1c3QgYXMgaXQgbm9ybWFsbHkgd291bGQgb24gcmVib290LS1i
dXQgaXQNCj4gd291bGQNCj4gb3B0aW9uYWxseSByZW1lbWJlciB0aGUgdW5kZXJseWluZyBsb2Nr
cyBoZWxkIGJ5IHRoZSBjbGllbnQgYW5kIGFsbG93DQo+IGNvbXBhdGlibGUgbG9jayByZWNsYWlt
cy4NCj4gDQo+IFJvdWdoIGF0dGVtcHQ6DQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgaHR0cHM6Ly93
aWtpLmxpbnV4LW5mcy5vcmcvd2lraS9pbmRleC5waHAvUmVib290X3JlY292ZXJ5X2Zvcl9yZS1l
eHBvcnRfc2VydmVycw0KPiANCj4gVGhpbmsgaXQgd291bGQgZmx5Pw0KDQpTbyB0aGlzIHdvdWxk
IGJlIGEgdmFyaWFudCBvZiBjb3VydGVzeSBsb2NrcyB0aGF0IGNhbiBiZSByZWNsYWltZWQgYnkN
CnRoZSBjbGllbnQgdXNpbmcgdGhlIHJlYm9vdCByZWNsYWltIHZhcmlhbnQgb2YgT1BFTi9MT0NL
IG91dHNpZGUgdGhlDQpncmFjZSBwZXJpb2Q/IFRoZSBwdXJwb3NlIGJlaW5nIHRvIGFsbG93IHJl
Y2xhaW0gd2l0aG91dCBmb3JjaW5nIHRoZQ0KY2xpZW50IHRvIHBlcnNpc3QgdGhlIG9yaWdpbmFs
IHN0YXRlaWQ/DQoNCkhtbS4uLiBUaGF0J3MgZG9hYmxlLCBidXQgaG93IGFib3V0IHRoZSBmb2xs
b3dpbmcgYWx0ZXJuYXRpdmU6IEFkZCBhDQpmdW5jdGlvbiB0aGF0IGFsbG93cyB0aGUgY2xpZW50
IHRvIHJlcXVlc3QgdGhlIGZ1bGwgbGlzdCBvZiBzdGF0ZWlkcw0KdGhhdCB0aGUgc2VydmVyIGhv
bGRzIG9uIGl0cyBiZWhhbGY/DQoNCkkndmUgYmVlbiB3YW50aW5nIHN1Y2ggYSBmdW5jdGlvbiBm
b3IgcXVpdGUgYSB3aGlsZSBhbnl3YXkgaW4gb3JkZXIgdG8NCmFsbG93IHRoZSBjbGllbnQgdG8g
ZGV0ZWN0IHN0YXRlIGxlYWtzIChlaXRoZXIgZHVlIHRvIHNvZnQgdGltZW91dHMsIG9yDQpkdWUg
dG8gcmVvcmRlcmVkIGNsb3NlL29wZW4gb3BlcmF0aW9ucykuDQoNCi0tIA0KVHJvbmQgTXlrbGVi
dXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
