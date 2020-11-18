Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9092B8794
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Nov 2020 23:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgKRWNV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Nov 2020 17:13:21 -0500
Received: from mail-eopbgr760125.outbound.protection.outlook.com ([40.107.76.125]:23020
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726288AbgKRWNU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 18 Nov 2020 17:13:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3HHTdtJiV9Rel/fZR4PX9kCQUe6NBTkB/bgXKlC93xSFdDZcV7yQTwJBYWXzSBsv+nGd3pfE9hfykMd+TayRXQYYqdVUDdUNs6tIbwFcmHCuzJY8VVfY/WJMnqU9zDsJEQ8ePfP+x4cMnO6pagPoJ9jVFIg9LdPWjpItyddMAy0lOfFai7yU5OX6BmIm5udUMoxb3SN9A/1GVx2LEmd3bw8mZMAy0AqSj+mi28h5YzAox6aRbLP+NQ48SdQbsB0+boHLa7zTM6jjHMsDIZWXXuhcIQyLEHChBp345hoyiINd2jOBkIacu/tDQAl7KintehdVXARbZitCyp1S/PCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pGD4IiybdhSx2EVa919tuf55y/vg0ufuHDR0Mq+W3A=;
 b=AOeulSlsABrrk7Nid+b5To5NQEFMRkul8tpoeBu2UFx1HShuFsV8YnLq7RbpUbeWM2n8TJ9qaoTwMNORKPHSFtr134g2KJSjrYffbsRkvvPsZ+U0tAFE10nryXF09hSjMr5m27s0lCelbj/iH2I0x7aJ9Ittbmdw1B07hpjmDeckwPjZvKe+c1F8dxOu4fU2PWLs3sYRAehhLk4AbGIKu9z8h8X3rNAdBMkcwwbgZeF7MmyTJKziMp+LhGfElga8olv88L+WWwDeFWGq1us7WmEOvBhQ8Pfr9NvtLai9n3mZw2Dd11O+9qbhPR/mHckUo+zNcXlPONh0tx1PJAw0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pGD4IiybdhSx2EVa919tuf55y/vg0ufuHDR0Mq+W3A=;
 b=MRX94EUZfNobkTDey0VAySXMJaQfENr3x1zywE0h2M/5qKxRv8IygAW8UWWgkdhjhygqTrShRuiREAhiRI00L+5hJFFpdRYCeTHbAilVfMhQeEO+em1RlnQA03gjkO2hswxioSe6vz9xjQp7YCk8yp+7PwygetGY+ThCJFVs78o=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3614.namprd13.prod.outlook.com (2603:10b6:208:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.19; Wed, 18 Nov
 2020 22:13:16 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3589.016; Wed, 18 Nov 2020
 22:13:16 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "anchalag@amazon.com" <anchalag@amazon.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFS: Retry the CLOSE if the embedded GETATTR is rejected
 with ERR_STALE
Thread-Topic: [PATCH] NFS: Retry the CLOSE if the embedded GETATTR is rejected
 with ERR_STALE
Thread-Index: AQHWvUE2gwXXu4fTCEGnbxZoTu1/nanNOCKAgAExLYCAAAw0gA==
Date:   Wed, 18 Nov 2020 22:13:16 +0000
Message-ID: <8f08df90240f8a040bec5e7cf8d280aab25f9ead.camel@hammerspace.com>
References: <20201118002431.GA6941@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
         <a0babbb7d58f02769a6ce40d029768e7221acf24.camel@hammerspace.com>
         <20201118212935.GA12762@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
In-Reply-To: <20201118212935.GA12762@dev-dsk-anchalag-2a-9c2d1d96.us-west-2.amazon.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 050e842e-fd21-4260-3bc1-08d88c0f2636
x-ms-traffictypediagnostic: MN2PR13MB3614:
x-microsoft-antispam-prvs: <MN2PR13MB36144AE31220E7D8D704FEA6B8E10@MN2PR13MB3614.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KJdqRN3S/0/cglnIqnspFU8MklCs91j6SG0SSem/mCMzZizpkBICKtYog0PBpWNlsSOnNZjrNdnJZApH6i550k4OnRiWzkXlH7XegUZxP+HvYSQ3uw/jKEYSbSYcPH7CFqtyGjKSKlprRqG5KE5my/p8nI7w1LgFJ7YZsjaUI3KfyJ0iosHwzO3lHZh1+7EQchfML94QTmk9s5BiGjN3LxyQLU7ONzkBkfEkJIIgQb1Jr+WTpsjPoQe3qMsgsmcW1Jmp9ICT4aQN5QosoguGN2j9V9/Wibpt/YYlBDYGNg9abLPB0rgHqfMtCXsEwwaD2oOs1PjpgFJXEjNfWYim6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(39840400004)(396003)(66556008)(6512007)(6916009)(2906002)(83380400001)(6506007)(86362001)(54906003)(5660300002)(64756008)(66446008)(6486002)(91956017)(66946007)(186003)(71200400001)(2616005)(36756003)(478600001)(26005)(66476007)(4326008)(76116006)(8676002)(316002)(8936002)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HtStt7I7zBnA56a7HmZkvWpAiKnoa6zZgT+p+jcaMYJTaviMqnWXi4yzGgyUKliP2i/Ai+506ZBrX2d/8++lrKJmFJwa6AFbmO8nQQ2hfimNnEOmBF507+uGPurVR2eYBtZdblTV58F3za4aTkf6ppYGwotF2kNqKJA248EfnJvPuXhtTXqMs+Rb7RHI4hnhxExK4yr4Vhk+d01hQNmG4ZzvEcp4w/Nwi49GxY0TNA3bHq00D+mlIlGKgWWeTFrjqetTrDPhWNFpYmtlge3IgHQyGw76xGC3tWNetGAh616V8eX6MYpvf2yEpE84h6170zbqqu1PGY0eUU8Pl87dod6HjceQ7wX11orVmx7UZ1hjlj0dkN+ZpzhZ5IL73DBl9XtjIxgRT2SkWYWf9aV5CVh7W9om4LccH1WrIt0dpK6faP+aBOGpaMQmuEWKNUF0CasweqOSem4OJ90vZxOepqc86QetmnfLwhsgV4jeKJMPm8gMsOXhVq0uCP1Im8TrxvLeRe4Lws/z9sABhSIDY+pcs/TJkeuH6shUbErVl2lv/yU7I7f5Dt0lZR6ovnwlOyg0k9Z0yyqozWpj4yq4+oitdU707gAIDcjm0SHi0e4hfYWRBGM8IQC6Tmf2ONCus5Txnj2zScoeMo7/Uv5B6g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D598237FDA6A3B488D9E1DDD04F288FC@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 050e842e-fd21-4260-3bc1-08d88c0f2636
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 22:13:16.4420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+YiUE80OuWK4s1yZTnfeAbgckCggh5jquQaUn2yyPnyR/VweUpvU94muiIFR+nF/8EU1J4lOqqAX/f4t9D6yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3614
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTE4IGF0IDIxOjI5ICswMDAwLCBBbmNoYWwgQWdhcndhbCB3cm90ZToN
Cj4gT24gV2VkLCBOb3YgMTgsIDIwMjAgYXQgMDM6MTc6MjBBTSArMDAwMCwgVHJvbmQgTXlrbGVi
dXN0IHdyb3RlOg0KPiA+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNp
ZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8NCj4gPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRoZQ0KPiA+IHNlbmRlciBhbmQga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+IE9uIFdlZCwgMjAy
MC0xMS0xOCBhdCAwMDoyNCArMDAwMCwgQW5jaGFsIEFnYXJ3YWwgd3JvdGU6DQo+ID4gPiBJZiBv
dXIgQ0xPU0UgUlBDIGNhbGwgaXMgcmVqZWN0ZWQgd2l0aCBhbiBFUlJfU1RBTEUgZXJyb3IsIHRo
ZW4NCj4gPiA+IHdlDQo+ID4gPiBzaG91bGQgcmVtb3ZlIHRoZSBHRVRBVFRSIGNhbGwgZnJvbSB0
aGUgY29tcG91bmQgUlBDIGFuZCByZXRyeS4NCj4gPiA+IFRoaXMgY291bGQgaGFwcGVuIGluIGEg
c2NlbmFyaW8gd2hlcmUgdHdvIGNsaWVudHMgdHJpZXMgdG8gYWNjZXNzDQo+ID4gPiB0aGUgc2Ft
ZSBmaWxlLiBPbmUgY2xpZW50IG9wZW5zIHRoZSBmaWxlIGFuZCB0aGUgb3RoZXIgY2xpZW50DQo+
ID4gPiByZW1vdmVzDQo+ID4gPiB0aGUgZmlsZSB3aGlsZSBpdCdzIG9wZW5lZCBieSBmaXJzdCBj
bGllbnQuIFdoZW4gdGhlIGZpcnN0IGNsaWVudA0KPiA+ID4gYXR0ZW1wdHMgdG8gY2xvc2UgdGhl
IGZpbGUgdGhlIHNlcnZlciByZXR1cm5zIEVTVEFMRSBhbmQgdGhlIGZpbGUNCj4gPiA+IGVuZHMN
Cj4gPiA+IHVwIGJlaW5nIGxlYWtlZCBvbiB0aGUgc2VydmVyLiBUaGlzIGRlcGVuZHMgb24gaG93
IG5mcyBzZXJ2ZXIgaXMNCj4gPiA+IGNvbmZpZ3VyZWQgYW5kIGlzIG5vdCByZXByb2R1Y2libGUg
aWYgcnVubmluZyBhZ2FpbnN0IG5mc2QuDQo+ID4gDQo+ID4gVGhhdCB3b3VsZCBiZSBhIHNlcmlv
dXNseSBicm9rZW4gc2VydmVyLiBJZiB5b3UgcmV0dXJuDQo+ID4gTkZTNEVSUl9TVEFMRSB0bw0K
PiA+IHRoZSBjbGllbnQsIHlvdSBjYW5ub3QgZXhwZWN0IGFueSBmdXJ0aGVyIGludGVyYWN0aW9u
IHdpdGggdGhhdA0KPiA+IGZpbGUNCj4gPiBmcm9tIHRoZSBjbGllbnQuIEl0IHdvbid0IHRyeSB0
byBzZW5kIENMT1NFIG9yIERFTEVHUkVUVVJOIG9yIGFueQ0KPiA+IG90aGVyDQo+ID4gc3RhdGVm
dWwgb3BlcmF0aW9uLg0KPiA+IA0KPiBJbiB0aGlzIHNjZW5hcmlvLCB0aGUgc2V0dXAgd2UgaGF2
ZSBhdCBFRlMgaXMgbW9yZSBvZiBhIGRpc3RyaWJ1dGVkDQo+IGZhc2hpb24uIE11bHRpcGxlDQo+
IGNsaWVudHMgYXJlIGNvbm5lY3RlZCB0byBtdWx0aXBsZSBzZXJ2ZXJzIHdpdGggYSBjb21tb24g
ZmlsZXN5c3RlbS4NCj4gU28gdGhlIGFib3ZlDQo+IHNjZW5hcmlvIGxlYWRzIHRvIGxlYWtlZCBv
cGVuIGZpbGUgaGFuZGxlcyBvbiB0aGUgY2xpZW50IHRoYXQgdHJpZXMNCj4gdG8gY2xvc2UgZGVs
ZXRlZA0KPiBmaWxlLiBTbyBJIHdhcyBvZiB0aGUgdmlldywgaW4gdGhhdCBjYXNlIGNsaWVudCBj
b3VsZCByZXRyeSBjbG9zZQ0KPiB3aXRob3V0IGdldGF0dHINCj4gaW4gdGhlIGNsb3NlIHNlcXVl
bmNlIHdpdGhvdXQgYW55dGhpbmcgdG8gZG8gb24gc2VydmVyIHNpZGUuDQoNCg0KSWYgeW91IHNl
bmQgdGhlIGNsaWVudCBhbiBORlM0RVJSX1NUQUxFLCB5b3UgYXJlIHRlbGxpbmcgaXQgdGhhdCBp
dHMNCmFjY2VzcyB0byB0aGUgZmlsZSBoYXMgYmVlbiByZXZva2VkLiBUaGF0IGlzIG5vdCBhIHRl
bXBvcmFyeSBlcnJvciwgaXQNCmlzIGEgZmF0YWwgb25lLiBUaGUgY2xpZW50IGlzIG5vdCByZXNw
b25zaWJsZSBmb3IgY2xlYW5pbmcgdXAgYW55DQpzdGF0ZS4NCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=
