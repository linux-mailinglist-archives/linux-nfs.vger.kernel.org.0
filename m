Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B67FD9A7E
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2019 21:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436685AbfJPTy1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Oct 2019 15:54:27 -0400
Received: from mail-eopbgr750088.outbound.protection.outlook.com ([40.107.75.88]:35478
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436659AbfJPTy1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 16 Oct 2019 15:54:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii+3+uEWLmJOAFY/5idbGRAblcovzTHZ1MBfuyaKaT0ck0CzuqARWKgdokxIwUf3VRAyWBaHdrMgdlZ78ctxR2jGLI/NAFKXPSI6U2e/Ox3zb6+xx4B1xzkzY8gK6hywL9VZIXGzDiL3yd43dFjbpkyDr/kXkWNTus/AYalkcNEtosakbcZPNjKqn4RrkiaxfF+zx6W69RfxrcQgqeN+i1J93nYmpzGvZC6bBzjfSdktfsfa+WcyRIne5pfhHHWfj2SHf1uKScyRREW1caTylVVouIWavTIVHqaBDLCYzcvj6DLLG5buH+CnsJBPOBkZK0UHfI0SbsjHkISAqWZYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18jMdTkoBVWmx1wmiFTI0wA/3y+ArD1Rg6GUiqK4R1o=;
 b=Ea89/1VPocdoRK+jxu3Z2GSi8PcOFI9cmT1wo4pMIIDABC+8PPDKKIf/PNiwFpuxooeQMEsU9ocKL6rAVIYHD2jDJ6lq7G1cgHXOyzkHvhrQwoTOedIRliczg7ZapGUljx+XTSJKXDa3RJi6aaql3CJk7Dvsibos0eezXqQ3o6158wqH3wehR0TuFA8RZ5SS1XCQPs451cm7Ad4d8kNiizjqAmIapbH3COU/PtBXCSzsaAV/9jLe4N9Yk/rtZS9uOPdFwQc1CHz3iXfYR0k1kXyLM0c7ieW7yniCrgUvAxstNAbFAYj75+J4TGk3gpRFvWeCJwxwEGjQqyubaVbigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector2-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18jMdTkoBVWmx1wmiFTI0wA/3y+ArD1Rg6GUiqK4R1o=;
 b=MHDzdWyFDQlL1Sfv1+LvpzbAxTuoEAI1Br5Uxk/oZ2GWfB+rfa5pl0bbVTuu3nCjZLJ1yzF88l8ozih9PEjaDXFyxF34CxbacyKWkY35v+rbbn09NzknJZNveGc0hz78wuoxMD6Fg54mI9MbEEGvlYsDxKvaXC++017tA+jOMtY=
Received: from BN8PR06MB5524.namprd06.prod.outlook.com (20.178.212.19) by
 BN8PR06MB5475.namprd06.prod.outlook.com (20.178.209.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 19:53:45 +0000
Received: from BN8PR06MB5524.namprd06.prod.outlook.com
 ([fe80::8179:6c93:78a1:872d]) by BN8PR06MB5524.namprd06.prod.outlook.com
 ([fe80::8179:6c93:78a1:872d%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 19:53:45 +0000
From:   "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Rick Macklem <rmacklem@uoguelph.ca>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4.2 server replies to Copy with length == 0
Thread-Topic: NFSv4.2 server replies to Copy with length == 0
Thread-Index: AQHVhDqX/nXy0ItheEilqjgnF3VvrKdda1EA
Date:   Wed, 16 Oct 2019 19:53:45 +0000
Message-ID: <31E6043B-090D-4E37-B66F-A45AC0CFC970@netapp.com>
References: <YQBPR0101MB1652856488503987CEB17738DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <YQBPR0101MB1652DEF8AD7A6169D44D47C6DD920@YQBPR0101MB1652.CANPRD01.PROD.OUTLOOK.COM>
 <20191016155838.GA17543@fieldses.org>
In-Reply-To: <20191016155838.GA17543@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1d.0.190908
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Olga.Kornievskaia@netapp.com; 
x-originating-ip: [2600:1700:6a10:2e90:acb1:357b:dba1:8e1a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8fb0a70-e383-450b-7309-08d752728dd0
x-ms-traffictypediagnostic: BN8PR06MB5475:
x-microsoft-antispam-prvs: <BN8PR06MB54753932C32A8AAF7235EB2D93920@BN8PR06MB5475.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(189003)(199004)(99286004)(186003)(11346002)(8936002)(2616005)(71190400001)(71200400001)(86362001)(476003)(6116002)(64756008)(66556008)(66946007)(66446008)(76176011)(6506007)(53546011)(81166006)(81156014)(2906002)(102836004)(8676002)(4326008)(446003)(66476007)(25786009)(486006)(14444005)(7736002)(6436002)(5024004)(229853002)(305945005)(6512007)(76116006)(33656002)(36756003)(6246003)(478600001)(316002)(91956017)(5660300002)(46003)(6486002)(14454004)(110136005)(58126008)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR06MB5475;H:BN8PR06MB5524.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1nKhOeLsyzTFJh3KVGM89j7kyOSyMaj+tnHDn4cnoGZAvXo+Kg/Us7cDn2pF7tOzEIDk/PBaN0hI4HI/6vqjQyci7l+mnz+0iDjzIhMqlaEJcKKJWOHXoQtg1cS84ONsp75/yaeR2Cnz3qmRVNVq+o+DmS09k6OG4VAjhXnJiK6UYOh6Ge+t1fekSFfk6YegprjHNphzNvbe6vXHy3Cf5yv7nyuKABK9NfCm/yjXTN8hXkzTs64+aGor4SkfyU/XkYgW1UbMR28zfGt295g+6SSEhcMASBCpKkJmkqxrZIoXsSMvnPOgqjfcmuOudVpkSWe1GsfPhVo9kvpzvNrsiJ6XAPkhfoIc0bnQ+/ddV4DNFJYR9xQHTqM3osESB+Pwvl8Di1mQ1iPcMlsrw3z8MAsXoVGF9113DExt6GOIus=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <23A8C22DCE3D9942BBAF8FA5D5940270@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fb0a70-e383-450b-7309-08d752728dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 19:53:45.3553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtP1kQhtaC1ulxqW6x7VCk5YUWlQZagj3QBmJP+NxfZCNY3h+owXCf3zvn7L2GfONrSjACeNvMuWEKa+joNjEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5475
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCu+7v09uIDEwLzE2LzE5LCAxMTo1OCBBTSwgIkouIEJydWNlIEZpZWxkcyIgPGJmaWVsZHNA
ZmllbGRzZXMub3JnPiB3cm90ZToNCg0KICAgIE5ldEFwcCBTZWN1cml0eSBXQVJOSU5HOiBUaGlz
IGlzIGFuIGV4dGVybmFsIGVtYWlsLiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2ht
ZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUuDQogICAgDQogICAgDQogICAgDQogICAgDQogICAgT24gV2VkLCBPY3QgMTYsIDIw
MTkgYXQgMDY6MjI6NDJBTSArMDAwMCwgUmljayBNYWNrbGVtIHdyb3RlOg0KICAgID4gSXQgc2Vl
bXMgdGhhdCB0aGUgQ29weSByZXBseSB3aXRoIHdyX2NvdW50ID09IDAgb2NjdXJzIHdoZW4gdGhl
IGNsaWVudA0KICAgID4gc2VuZHMgYSBDb3B5IHJlcXVlc3Qgd2l0aCBjYV9zcmNfb2Zmc2V0IGJl
eW9uZCBFT0YgaW4gdGhlIGlucHV0IGZpbGUuDQogICAgPiAoSXQgaGFwcGVuZWQgYmVjYXVzZSBJ
IHdhcyB0ZXN0aW5nIGFuIG9sZC9icm9rZW4gdmVyc2lvbiBvZiBteSBjbGllbnQsDQogICAgPiAg
YnV0IEkgY2FuIHJlcHJvZHVjZSBpdCwgaWYgeW91IG5lZWQgYSBidWdmaXggdG8gYmUgdGVzdGVk
LiBJIGRvbid0IGtub3cgaWYNCiAgICA+ICB0aGUgY2FzZSBvZiBjYV9zcmNfb2Zmc2V0K2NhX2Nv
dW50IGJleW9uZCBFT0YgYmVoYXZlcyB0aGUgc2FtZT8pDQogICAgPiAtLT4gVGhlIFJGQyBzZWVt
cyB0byByZXF1aXJlIGEgcmVwbHkgb2YgTkZTNEVSUl9JTlZBTCBmb3IgdGhpcyBjYXNlLg0KICAg
IA0KICAgIEkndmUgbmV2ZXIgdW5kZXJzdG9vZCB0aGF0IElOVkFMIHJlcXVpcmVtZW50LiAgQnV0
IEkga25vdyBpdCdzIGJlZW4NCiAgICBkaXNjdXNzZWQgYmVmb3JlLCBtYXliZSB0aGVyZSB3YXMg
c29tZSBqdXN0aWZpY2F0aW9uIGZvciBpdCB0aGF0IEkndmUNCiAgICBmb3Jnb3R0ZW4uDQogICAg
DQoNClNpZ2gsIHdlbGwsIEkgZG9u4oCZdCBrbm93IGlmIHdlIHNob3VsZCBjb25zaWRlciBhZGRp
bmcgdGhlIGNoZWNrIHRvIHRoZSBORlMgc2VydmVyIHRvIGJlIE5GUyBzcGVjIGNvbXBsaWFudC4g
VkZTIGxheWVyIGRpZG4ndCB3YW50IHRoZSBjaGVjayBhbmQgaW5zdGVhZCB0aGUgcHJlZmVyZW5j
ZSBoYXMgYmVlbiB0byBrZWVwIHJlYWQoKSBzZW1hbnRpY3Mgb2YgcmV0dXJuaW5nIGEgc2hvcnQg
cmVhZCAod2hlbiB0aGUgbGVuIHdhcyBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgZmlsZSBvciBpZiB0
aGUgc291cmNlKSB0byBzb21ldGhpbmcgYmV5b25kIHRoZSBlbmQgb2YgdGhlIGZpbGUuIE9uIHRo
ZSBjbGllbnQgaWYgVkZTIGRpZCByZWFkIG9mIGxlbj0wIHRoZW4gVkZTIGl0c2VsZiB3ZSByZXR1
cm4gMCwgdGh1cyB0aGlzIGRvZXNuJ3QgcHJvdGVjdCBhZ2FpbnN0IG90aGVyIGNsaWVudHMgc2Vu
ZGluZyBhbiBORlMgY29weSB3aXRoIGxlbj0wLiBBbmQgaW4gTkZTLCByZWNlaXZpbmcgY29weSB3
aXRoIGxlbj0wIG1lYW5zIGNvcHkgdG8gdGhlIGVuZCBvZiB0aGUgZmlsZS4gSXQncyBub3QgaW1w
bGVtZW50ZWQgZm9yIGFueSAiaW50cmEiIG9yICJpbnRlciIgY29kZS4gDQoNCiAgICAtLWIuDQog
ICAgDQogICAgPg0KICAgID4gcmljaw0KICAgID4NCiAgICA+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCiAgICA+IEZyb206IGxpbnV4LW5mcy1vd25lckB2Z2VyLmtl
cm5lbC5vcmcgPGxpbnV4LW5mcy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IG9uIGJlaGFsZiBvZiBS
aWNrIE1hY2tsZW0gPHJtYWNrbGVtQHVvZ3VlbHBoLmNhPg0KICAgID4gU2VudDogVHVlc2RheSwg
T2N0b2JlciAxNSwgMjAxOSAxMDo1MCBQTQ0KICAgID4gVG86IGxpbnV4LW5mc0B2Z2VyLmtlcm5l
bC5vcmcNCiAgICA+IFN1YmplY3Q6IE5GU3Y0LjIgc2VydmVyIHJlcGxpZXMgdG8gQ29weSB3aXRo
IGxlbmd0aCA9PSAwDQogICAgPg0KICAgID4gRHVyaW5nIGludGVyb3AgdGVzdGluZyAoRnJlZUJT
RCBjbGllbnQtPkxpbnV4IHNlcnZlcikgb2YgTkZTdjQuMiwgbXkNCiAgICA+IGNsaWVudCBnb3Qg
aW50byBhIGxvb3AuIEl0IHdhcyBiZWNhdXNlIHRoZSByZXBseSB0byBDb3B5IHdhcyBORlNfT0ss
DQogICAgPiBidXQgdGhlIGxlbmd0aCBpbiB0aGUgcmVwbHkgaXMgMC4NCiAgICA+IChJJ2xsIGZp
eCB0aGUgY2xpZW50IHRvIGZhaWwgZm9yIHRoaXMgY2FzZSBzbyBpdCBkb2Vzbid0IGxvb3AsIGJ1
dC4uLikNCiAgICA+DQogICAgPiBUaGUgc2VydmVyIGlzIEZlZG9yYSAzMCAoNS4yLjE4LTIwMCBr
ZXJuZWwgdmVyc2lvbikuDQogICAgPiBJdCB5b3UgdGhpbmsgdGhpcyBtaWdodCBiZSBmaXhlZCBp
biBhIG5ld2VyIGtlcm5lbCBvciB5b3UnZCBsaWtlIG1lIHRvIGRvDQogICAgPiBzb21ldGhpbmcg
d2l0aCBpdCB0byBnZXQgbW9yZSBpbmZvLCBqdXN0IGxldCBtZSBrbm93Lg0KICAgID4NCiAgICA+
IEkndmUgYXR0YWNoZWQgYSBzbmlwcGV0IG9mIHRoZSBwYWNrZXQgdHJhY2UuIChJZiB0aGUgbGlz
dCBzdHJpcHMgaXQgb2ZmLCBqdXN0IGVtYWlsDQogICAgPiBtZSBhbmQgSSdsbCBzZW5kIGl0IHRv
IHlvdS4pDQogICAgPg0KICAgID4gcmljaw0KICAgIA0KDQo=
