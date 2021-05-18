Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66005387FB2
	for <lists+linux-nfs@lfdr.de>; Tue, 18 May 2021 20:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbhERShp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 May 2021 14:37:45 -0400
Received: from mail-dm6nam10on2101.outbound.protection.outlook.com ([40.107.93.101]:10625
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238176AbhERSho (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 18 May 2021 14:37:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4WMHvvf8/0+buFQLT62WnS8b04cDLJc+M5gg0BNizmYxalmgq+yBX0l+tc8k2NO1EWhtg8Ukk8AmnlmRvIbI/G5H4nNoDbgryW0eI9m05K1eWQPThodB7nc3dXR0nqf8L+Tc3KCkUVkcNSFsqE9QwlTuFVNRBn8geXK5U/pTKmt2VEXgorGGMSA5+6ge7kPJlXx+X0qHtpZxxucf33381tkG3Ezz+SOsaDuIr6DrFpm4aTEPbv5fKtPlcH5X34b72BQAH3keizkeIUV0vC1C90NBrT26GHu610zBBmNDhlFRvDcT26sDYvE/iiXlb93HHklpjMT3SYI+AjT4alqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRbrHAYY9vZXKgyxsE2NII7gxMUOdov+IZXbBY7dLZ4=;
 b=DrujMYOlx4fzJXCBVoEqklqlcSQI8FCfK4VZmVWsFQXABZ+KWCai2kNZ8+3RUFUgJuITCndia0DLckhZkWt3bVBqE92Pv/PdPDa+G/qFHQBpWQ6aUmBEoUxeSdelriWHYF8yH3F7UDktigF1HNSnM2XeZlMYA1OSN2ulH4/DrwVbLp2d0y+1+m1QuqgCWeZ4A7qQgwy6pX/TChR3uZ+r8vQ7qlaYnGRStRPsxmXUYIpRF9BbyFtLBai7qzrUKIkjWfSEZmSe9b0aOT1Xat9vhMkBxtL+w+2RHk3zD78+wU6h0P9hygDg8PipslpxxOPivNMevGcicHmY4aUMkRPxFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRbrHAYY9vZXKgyxsE2NII7gxMUOdov+IZXbBY7dLZ4=;
 b=Y+aMel5fKvE0SHDABICAIb9e+rlROCcVacUHdv2qzy9RjzJOloUJ+VSQDYi3Mc/n1bFFMujyySURYapIvofA26phd5Ap/IdB3uJY6AwSp3qlbiEBDYQBmSAFMDYnmvIsMPvbCk9XNEULM0HO+/vTCnfhtWelGSUDrl8z07b0va4=
Received: from DS7PR13MB4733.namprd13.prod.outlook.com (2603:10b6:5:3b1::24)
 by DM6PR13MB3691.namprd13.prod.outlook.com (2603:10b6:5:243::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11; Tue, 18 May
 2021 18:36:23 +0000
Received: from DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18]) by DS7PR13MB4733.namprd13.prod.outlook.com
 ([fe80::4c65:55ca:a5a2:f18%7]) with mapi id 15.20.4150.011; Tue, 18 May 2021
 18:36:23 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
CC:     "robbieko@synology.com" <robbieko@synology.com>,
        "bingjingc@synology.com" <bingjingc@synology.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "nickhuang@synology.com" <nickhuang@synology.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Thread-Topic: [PATCH] nfsd: Prevent truncation of an unlinked inode from
 blocking access to its directory
Thread-Index: AQHXSHWIwC4sG/njP0aIKkyiTSP2PqrjH9EAgAD/2YCABWzqAIAAB66AgAAEOQA=
Date:   Tue, 18 May 2021 18:36:23 +0000
Message-ID: <924d92d52116cff9c0203b84a02d45352bfad361.camel@hammerspace.com>
References: <20210514035829.5230-1-nickhuang@synology.com>
         <00195ec8bf1752306f549540eed74c3938c5e312.camel@hammerspace.com>
         <YJ9yD1S6Yl2m0gOO@infradead.org>
         <4387867bd64c5d3d8c67830a633b90e4a7e1ba38.camel@hammerspace.com>
         <20210518182115.GB26957@fieldses.org>
In-Reply-To: <20210518182115.GB26957@fieldses.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none
 header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 968d9745-4b77-4f35-8135-08d91a2bd6b5
x-ms-traffictypediagnostic: DM6PR13MB3691:
x-microsoft-antispam-prvs: <DM6PR13MB369131C245623F1C2C68935DB82C9@DM6PR13MB3691.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yolA/Pf0Jn7uBK3qT5ZPOwtjHxSZZBuXw6+brgwb8+eP33526KzH0fZpme+A7SjUcKO8nlXKgL+BtMYqNQg6g/N6dlGekLv5NUB2YVSuiLPL1O6Fr6J5KN6kn77PRRRS6hcXSn59g2DHFFX5gfk5s+fAb4qwnAFOqnMg5ySpoZrcvU8EOeeu9K6QuBpTYL3jatH2w3ZUhR7iUQQvSSdGu5QoyipQdno/+fcUQIQPPQDp09q/LsqAGLhMlu+XE74kHVx2szrttRwi4KevwOwuzvtXZS0a0TeA5sPwWUnO0frFKUU9DD2GyHHEF8vyuRZqAyWbWo5LVaEuYWrdSaVyVvVaCA5eFT1xHXEUNCkYI+PsL0AU/5UWyTmd8TyHoxwqgegVhs9s2hOr7mrU8n9Ri3d+BTkg02x0biBce5+dr1kacHTHcrnN06moaDVA4Lwb/nVrS5HC7QRhvRInyx9xaU7CwfxsirNLU8QYHStdKpvrNqrN3FZN3Yk/B1W/0XDdqAPbxYBj1psNR23fMc+liVWPkDZ+HPnN+QoYD7FlVKmg4mQWh5R1VQuj6waP50ct5ueYJVsWiE9ldKsM4OHTiyJ7lTnBeAgnX2dopiaqiIU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR13MB4733.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(136003)(39830400003)(346002)(4326008)(122000001)(8936002)(6916009)(6486002)(86362001)(5660300002)(38100700002)(83380400001)(36756003)(54906003)(186003)(71200400001)(6512007)(478600001)(316002)(26005)(66476007)(2906002)(76116006)(2616005)(66556008)(64756008)(66446008)(6506007)(91956017)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?d0laRW1ra29SeWJORmprbkkxd0kzakZGSUpuK1V6blJYc1FYQ2lpQnNiUEJm?=
 =?utf-8?B?VjZ1TWZGR3dPamFmQ1orMjR4YS91elRuU1F5UTA0V3Q0TVdHUVlCU2wrenZr?=
 =?utf-8?B?bitGbERUR1FMOXY1UkZjcE1oSWVITVhHK2lnNW1LOTZxNy9KMkpvemUrQkl3?=
 =?utf-8?B?UGV2S3FDcDdYbElXa2Vua3ZwWXdOR29DVUhLT0RrejhKMmJ6akt2ZlpLNlJr?=
 =?utf-8?B?VmtTNjdLb3FJNGN1eDhHYk5sQUx3K3ZGRklnL09hYnFGakRxYkFUY3pRR0FD?=
 =?utf-8?B?cTg2cmNReXkzMS84ZnVxVU1wRTM0Z2tOTG9aWGhZQnViK0FjS3NselN1ektq?=
 =?utf-8?B?UlNYM0ZXUXI4dHNVb1JMYWk2Q1N6dU5DcWcxWjNWSVQ2WVhDMmhId3RRbDJV?=
 =?utf-8?B?ZVBrNDBoYmt5VmErbTdBa1c5QVliQVFqNnRlK041Z29pQXZzKzVtNFpGQmxF?=
 =?utf-8?B?ZnBBVWJ2djMrT1R1cmNFM3FLeUFyVzcyUkdteVNhYWNBYjhnbXladjYrTHF2?=
 =?utf-8?B?L0hZN0tYbE52TkFpazJsOG1tSFcvbG1hcS9WUUREa280b3gzUkV6M1BNeW1k?=
 =?utf-8?B?SHhCNXYwTHlCbWxVZ0V6cDdNRXBjMXVGL1EzVDVMbnhrTzhMWkVTQytNSG9H?=
 =?utf-8?B?cmRIRGtHSEV6cHdzU0QvczVCY2cyR0FQVFJFR1FTM29Lc2ZzU0pQZ25mdXFx?=
 =?utf-8?B?U0JsdFpkenhWamtHT2VjaTNvUWhRVGZvT1ZIK3hrUi9wNHlwR29QTVNlbkhE?=
 =?utf-8?B?R3o0SHVEMjBYQkxsRXBpVy9xNTZmbnVhcENpZVk3bVlIRmw1U1UyS3VySlBR?=
 =?utf-8?B?UnJVSW9ScFBnTWtHQXIyMkpQWmZBcXhDUkYrRXVOKy9XUC9hV2FYR1J4VHor?=
 =?utf-8?B?SzFibjlGYVRhU24zWE1vM09OMndVUHM1ZCtKUE1XWHR5MTJHTDF3S25ETXh4?=
 =?utf-8?B?OUd0TUNJV1MyUFlqOFpXTFBhamVwTDBXMTFreEcrQlAxbU9Ib0ZWWUdHOU0r?=
 =?utf-8?B?d1haaGhBVmFHcC9LbWQvREJjK3RyS1RvT2lZWkRPMDBXVk16K2hPa0RGL0tN?=
 =?utf-8?B?Vlo5eVVGZ2NnWU4rTmtUK3gyKy9DKzFjTWs5cWJPZGV3T2lqYkxpb290bVlm?=
 =?utf-8?B?UzQvUk4rV1NTRWVVZW03Si9hQVZSeWRvRHVzcXFiR1NDNkhsQXhoclhaNHZz?=
 =?utf-8?B?RktLZnkzTXFCR2lsbGZQbUJsa29rWEpFdDY4YWgxTXVxcWpvKzVRUk9vZlc3?=
 =?utf-8?B?NnpUaEFEOWZPQ0tPQmFseFc2eGgyWkVkTnB6ZTlOUTJjdE1Da2xSS1RmajZ5?=
 =?utf-8?B?dGlYdEE0MUdMQ0RpQzB5YnZjU3MwNG0yaHVHNjVuMXNFMmxGWXBtL0h3NGs1?=
 =?utf-8?B?Wk1NbVl3MDBzb0NEdjdCUGVjRllVRElsL0gwL3d0TStqTVprbzlsWjR0d3NX?=
 =?utf-8?B?eFlaV3p0RWlrb2ZXZU1JWkM0VUtrTlRlc2F3Y01GTWxJRUEwR1luVGJ5SFZx?=
 =?utf-8?B?OVJMd29KS2ZDK21WVmp4YWZuKytwa3dPOGhWOE9kMHdEcjYrZFRTam5MVnVS?=
 =?utf-8?B?dHhmaERaRGVtaHQrSHFVN2kwNS9PS21DZ0R1VUhLWGJtUGp0b20ycVcyQ3Jw?=
 =?utf-8?B?VE4rS01OSEcwRm9aZUc5R1hTZkZpa0M1QjVyTlIxM3Yvc01KeFRFbkt4bHlR?=
 =?utf-8?B?YnR4NDl0RmNFcTZ1TFBwOTNmNGVqZ1B3U2wzUGYrTDFIMDhraDVJTGo4Z09z?=
 =?utf-8?Q?jBs93kb/LXAY/frMKYhIvhn7Mf3u6ysJ2fqo6PE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DA357612839B247AA29551F2E66934E@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR13MB4733.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968d9745-4b77-4f35-8135-08d91a2bd6b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 18:36:23.6078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cTEWCzKOBNFL4adQMwGNMVIGqoannDA1z8OV4L9kWPYMS0HrpilH4BE8Dv6ij0oak4esFSRqJWCK3Ce8Yy4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3691
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIxLTA1LTE4IGF0IDE0OjIxIC0wNDAwLCBiZmllbGRzQGZpZWxkc2VzLm9yZyB3
cm90ZToNCj4gT24gVHVlLCBNYXkgMTgsIDIwMjEgYXQgMDU6NTM6NDdQTSArMDAwMCwgVHJvbmQg
TXlrbGVidXN0IHdyb3RlOg0KPiA+IE9uIFNhdCwgMjAyMS0wNS0xNSBhdCAwODowMiArMDEwMCwg
Q2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4gPiBPbiBGcmksIE1heSAxNCwgMjAyMSBhdCAw
Mzo0Njo1N1BNICswMDAwLCBUcm9uZCBNeWtsZWJ1c3Qgd3JvdGU6DQo+ID4gPiA+IFdoeSBsZWF2
ZSB0aGUgY29tbWl0X21ldGFkYXRhKCkgY2FsbCB1bmRlciB0aGUgbG9jaz8gSWYgeW91J3JlDQo+
ID4gPiA+IGNvbmNlcm5lZCBhYm91dCBsYXRlbmN5LCB0aGVuIGl0IG1ha2VzIG1vcmUgc2Vuc2Ug
dG8gY2FsbA0KPiA+ID4gPiBmaF91bmxvY2soKQ0KPiA+ID4gPiBiZWZvcmUgZmx1c2hpbmcgdGhv
c2UgbWV0YWRhdGEgdXBkYXRlcyB0byBkaXNrLg0KPiA+ID4gDQo+ID4gPiBBbHNvIEknbSBub3Qg
c3VyZSB3aHkgdGhlIGV4dHJhIGlub2RlIHJlZmVyZW5jZSBpcyBuZWVkZWQuwqAgV2hhdA0KPiA+
ID4gc3BlYWtzDQo+ID4gPiBhZ2FpbnN0IGp1c3QgbW92aW5nIHRoZSBkcHV0IG91dCBvZiB0aGUg
bG9ja2VkIHNlY3Rpb24/DQo+ID4gDQo+ID4gSXNuJ3QgdGhlIGlub2RlIHJlZmVyZW5jZSB0YWtl
biBqdXN0IGluIG9yZGVyIHRvIGVuc3VyZSB0aGF0IHRoZQ0KPiA+IGNhbGwNCj4gPiB0byBpcHV0
X2ZpbmFsKCkgKGFuZCBpbiBwYXJ0aWN1bGFyIHRoZSBjYWxsIHRvDQo+ID4gdHJ1bmNhdGVfaW5v
ZGVfcGFnZXNfZmluYWwoKSkgaXMgcGVyZm9ybWVkIG91dHNpZGUgdGhlIGxvY2s/DQo+ID4gDQo+
ID4gVGhlIGRwdXQoKSBpcyBwcmVzdW1hYmx5IHVzdWFsbHkgbm90IHBhcnRpY3VsYXJseSBleHBl
bnNpdmUsIHNpbmNlDQo+ID4gdGhlDQo+ID4gZGVudHJ5IGlzIGp1c3QgYSBjb21wbGV0ZWx5IG9y
ZGluYXJ5IG5lZ2F0aXZlIGRlbnRyeSBhdCB0aGlzIHBvaW50Lg0KPiANCj4gUmlnaHQsIGJ1dCB3
aHkgYm90aGVyIHdpdGggdGhlIGV4dHJhIGlob2xkL2lwdXQgaW5zdGVhZCBvZiBqdXN0DQo+IHBv
c3Rwb25pbmcgdGhlIGRwdXQ/DQoNCkFzIEkgc2FpZCBhYm92ZSwgdGhlIGRlbnRyeSBpcyBuZWdh
dGl2ZSBhdCB0aGlzIHBvaW50LiBJdCBkb2Vzbid0IGNhcnJ5DQphIHJlZmVyZW5jZSB0byB0aGUg
aW5vZGUgYW55IG1vcmUsIHNvIHRoYXQgd291bGRuJ3QgZGVmZXIgdGhlIGlub2RlDQp0cnVuY2F0
aW9uLg0KDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbmFtZWkuYyBiL2ZzL25hbWVpLmMNCj4gaW5k
ZXggNzliMGZmOWIxNTFlLi5hZWVkOTNjOTg3NGMgMTAwNjQ0DQo+IC0tLSBhL2ZzL25hbWVpLmMN
Cj4gKysrIGIvZnMvbmFtZWkuYw0KPiBAQCAtNDA4NCw3ICs0MDg0LDYgQEAgbG9uZyBkb191bmxp
bmthdChpbnQgZGZkLCBzdHJ1Y3QgZmlsZW5hbWUNCj4gKm5hbWUpDQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgaW5vZGUgPSBkZW50cnktPmRfaW5vZGU7DQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGRfaXNfbmVnYXRpdmUoZGVudHJ5KSkNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBzbGFzaGVzOw0K
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWhvbGQoaW5vZGUpOw0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVycm9yID0gc2VjdXJpdHlfcGF0aF91bmxpbmsoJnBh
dGgsIGRlbnRyeSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGVycm9y
KQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3Rv
IGV4aXQyOw0KPiBAQCAtNDA5MiwxMSArNDA5MSwxMCBAQCBsb25nIGRvX3VubGlua2F0KGludCBk
ZmQsIHN0cnVjdCBmaWxlbmFtZQ0KPiAqbmFtZSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBlcnJvciA9IHZmc191bmxpbmsobW50X3VzZXJucywgcGF0aC5kZW50cnktPmRfaW5v
ZGUsDQo+IGRlbnRyeSwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJmRlbGVnYXRlZF9pbm9kZSk7DQo+IMKgZXhp
dDI6DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcHV0KGRlbnRyeSk7DQo+IMKg
wqDCoMKgwqDCoMKgwqB9DQo+IMKgwqDCoMKgwqDCoMKgwqBpbm9kZV91bmxvY2socGF0aC5kZW50
cnktPmRfaW5vZGUpOw0KPiAtwqDCoMKgwqDCoMKgwqBpZiAoaW5vZGUpDQo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpcHV0KGlub2RlKTvCoMKgwqDCoC8qIHRydW5jYXRlIHRoZSBp
bm9kZSBoZXJlICovDQo+ICvCoMKgwqDCoMKgwqDCoGlmICghSVNfRVJSKGRlbnRyeSkpDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkcHV0KGRlbnRyeSk7wqDCoMKgLyogdHJ1bmNh
dGUgdGhlIGlub2RlIGhlcmUgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoGlub2RlID0gTlVMTDsNCj4g
wqDCoMKgwqDCoMKgwqDCoGlmIChkZWxlZ2F0ZWRfaW5vZGUpIHsNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBlcnJvciA9IGJyZWFrX2RlbGVnX3dhaXQoJmRlbGVnYXRlZF9pbm9k
ZSk7DQo+IA0KPiA/DQo+IA0KPiAtLWIuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBO
RlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tDQoNCg0K
