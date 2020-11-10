Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2742AE118
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 21:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKJUzN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 15:55:13 -0500
Received: from mail-bn7nam10on2118.outbound.protection.outlook.com ([40.107.92.118]:32385
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgKJUzN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 15:55:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUF3rc6bCsQ25R4WJb+HdcRwwg1rzLsxd43h6Ju2V8+tPhTFTLSJ3UnLJ/NKwqfvEV7dIBGjt28astkGxn7YfIFSffxTTneMNdx/6KRQfHO3HOtKKhE+lUSkqr3Qw2x6mAUgOXA/v876sBwM25jeBs9pJHM0oR/2ZSk5X8Mj0wgPq3tOO9f4K7IVh2W2DgMWSgp+BjsQSkvOvhBvAkP/P31ZKbrmdd9lZW6SlpzdCiCTy8TmhVS2Rf0Cr4NeG97Y48SHAb0WK69f18XVxEuuhYmbWwlttVrt5l/I8Ksxc9oHmFN0K6fpujsYBtXN+u/qjrIEFkSTbB6NO5112HMV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH9RgkINf3Bqax0Upi+ij1olV7wSTT7BvqnUgTJSU3s=;
 b=YYd7lWVeSpTmKx55GyA4b0kGJskKiqGrzLIMHpuWB8PAW9l8Do1MEPmLZzleM6POr9fr4EMT4VTp4pC+xIxOtInebBRq5e7Li1Vp3IGaIH0PUEDMRxX0W/4uYd43ve6XLPuFl61hoYYtmOzPfjBh1QvHflTYT6llYJdJ924yMuGWZAF8tT0HjtjeS98t/cExoLV3A3r1jUxhuST565AgVh++cybk549Pw/8nWTrpLodI0vghqSQU+qAmJKnyc+RUzGEkU30DiTld2AEB+GnxenDOQZP3aunMfhyCYIwQhVVEWo6Kbhb+fzN5U/M3siVUkUqG4wj9JUZnUUKmCGnVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH9RgkINf3Bqax0Upi+ij1olV7wSTT7BvqnUgTJSU3s=;
 b=U/KuVtHDSsgOxBvjPj+B1182E6RdWFgA/Z7OsGZ2VIT2Ac7GpUpTeOEAeOZjIJNZIQ9yjfQ3EOgK76Bj3SF8R7dJpVrVcuREld3OEVu6Fuvwklb65KS9PZuM160TVIRsEl31mLOIEaru1Bf7KDywsEK+20/QoVhQ/tbC4QMlQTM=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3680.namprd13.prod.outlook.com (2603:10b6:208:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.15; Tue, 10 Nov
 2020 20:55:10 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Tue, 10 Nov 2020
 20:55:09 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "dwysocha@redhat.com" <dwysocha@redhat.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
Thread-Topic: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a
 cookie in an empty page cache
Thread-Index: AQHWtRA6iwOeaceJLkybCI7SueOQ/6nBdvkAgABmcgA=
Date:   Tue, 10 Nov 2020 20:55:09 +0000
Message-ID: <6193acbe2fe1cbfe760bf91ae08a77a859870fc1.camel@hammerspace.com>
References: <20201107140325.281678-1-trondmy@kernel.org>
         <20201107140325.281678-2-trondmy@kernel.org>
         <20201107140325.281678-3-trondmy@kernel.org>
         <20201107140325.281678-4-trondmy@kernel.org>
         <20201107140325.281678-5-trondmy@kernel.org>
         <20201107140325.281678-6-trondmy@kernel.org>
         <20201107140325.281678-7-trondmy@kernel.org>
         <20201107140325.281678-8-trondmy@kernel.org>
         <20201107140325.281678-9-trondmy@kernel.org>
         <20201107140325.281678-10-trondmy@kernel.org>
         <20201107140325.281678-11-trondmy@kernel.org>
         <20201107140325.281678-12-trondmy@kernel.org>
         <20201107140325.281678-13-trondmy@kernel.org>
         <20201107140325.281678-14-trondmy@kernel.org>
         <20201107140325.281678-15-trondmy@kernel.org>
         <20201107140325.281678-16-trondmy@kernel.org>
         <20201107140325.281678-17-trondmy@kernel.org>
         <20201107140325.281678-18-trondmy@kernel.org>
         <20201107140325.281678-19-trondmy@kernel.org>
         <20201107140325.281678-20-trondmy@kernel.org>
         <20201107140325.281678-21-trondmy@kernel.org>
         <20201107140325.281678-22-trondmy@kernel.org>
         <CALF+zOm+2Vng8Fx6124jK9G9bZHGLd1UEMrjot79naUwyLqn7Q@mail.gmail.com>
In-Reply-To: <CALF+zOm+2Vng8Fx6124jK9G9bZHGLd1UEMrjot79naUwyLqn7Q@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdbf76e5-46ba-4497-2856-08d885bae968
x-ms-traffictypediagnostic: MN2PR13MB3680:
x-microsoft-antispam-prvs: <MN2PR13MB36808490334D9BD5B7073B5FB8E90@MN2PR13MB3680.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CPuMDbAoxogiye/9QzZ2seg00EfKViUZbdI2nA7o2tIRanQSTnGy+r218zktq9SWc82wSzUZWQyO13zL3w6NdBtTH+iiiEEJsdeVfTU8FW52x7uqJVlIHHnCTpC+24wlfy+zqUHmtG1HDD1hQ+MzzAAHt7+P9kDZGARfkV1t0pH/IVaDr6pbAID4Y1pNy8/QZNeM9WpuQlLOoA7hBhfHzRcr0OoYus/Aeax7fpwPfA85Z7J4G5OLRpzgwXX+JxMPoWbWS7ApL2iQh0khBYvLJYSmbv9hOYFveQ3h46jJxmqswZCMN9vbwDks7AKrR1nUNVKYbd6q/qHP4MEZuJ5TIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(396003)(39830400003)(366004)(6506007)(71200400001)(4001150100001)(64756008)(8676002)(5660300002)(186003)(86362001)(4326008)(2906002)(36756003)(6486002)(316002)(6512007)(8936002)(26005)(66446008)(66476007)(66556008)(66946007)(83380400001)(6916009)(76116006)(478600001)(91956017)(53546011)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FH5IjXklXdXHxFVigr6w9CEwj2Jd4goF3sJYJfcTpbxW3jXZc51UB5ldTPZGUkbmSjMAjrTNjLhs8tAFlOOQBDGAKCo6nXBwvYN4Vk08CS2oUyxjMHwr80YvvpudBIOWJPgUMxkGK33MmLaHukk0OlVnj4YFA2CUXBCHAdFYhkov49DFLda78MTq6pkaW134XaEedBjaDiZ4KJcDCdzBKYpwN8L7mXYT6Wml1ngVOyfuqpRCmKRpiszCoGgXR4t9eCB0blTU0Nw+Aykt8DgCrki1tJ4zlaGkWF3b8IJ9qb05khxnz7SWCAm7b50XMHWAyNIIgkNxXJJhWN1ds1FjsoqMUU5PJxh5dubxGGMIPLhXFQ3dGei7O7QipdmtXr7dJlxuad/c7y0RrQMERitY4ljcPkvfOhlt5w17VzoBTmM5bSkeZUXdtm/K1TWMO+EKmqyWWHwGVnMrYK+itVzQ6fYf8HhYeLY2t3XRnEBhf0b4lnLUspvOAtaHDkJhkKPx0RRchdhKAqNFUVCbgDzTcFgcaGLzJRXWDn+bZmSdCKjEbIX4zLcxs4dEav2owsZAL3GrC29Zo+qmbiYKrptzyUOk+4OopCR4DFEOgXvIkS0wRlShfS+fTmigr8NRZNvwhKDpKY7lSG1oJpK2RgX0/w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <82CEF6B86505FC4FA86DCAAC4725A3B3@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbf76e5-46ba-4497-2856-08d885bae968
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 20:55:09.7780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mM9nf0RHa3Phyb2H3TE/XS3KPCI4Z0a/ZlEGzn3NWtCBKrBSru5F2DIppMZFgE9n+Xm+D/tPmXeyN3N1aUg5KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3680
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTEwIGF0IDA5OjQ4IC0wNTAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToNCj4gT24gU2F0LCBOb3YgNywgMjAyMCBhdCA5OjE0IEFNIDx0cm9uZG15QGtlcm5lbC5vcmc+
IHdyb3RlOg0KPiA+IA0KPiA+IEZyb206IFRyb25kIE15a2xlYnVzdCA8dHJvbmQubXlrbGVidXN0
QGhhbW1lcnNwYWNlLmNvbT4NCj4gPiANCj4gPiBJZiB0aGUgZGlyZWN0b3J5IGlzIGNoYW5naW5n
LCBjYXVzaW5nIHRoZSBwYWdlIGNhY2hlIHRvIGdldA0KPiA+IGludmFsaWRhdGVkDQo+ID4gd2hp
bGUgd2UgYXJlIGxpc3RpbmcgdGhlIGNvbnRlbnRzLCB0aGVuIHRoZSBORlMgY2xpZW50IGlzIGN1
cnJlbnRseQ0KPiA+IGZvcmNlZA0KPiA+IHRvIHJlYWQgaW4gdGhlIGVudGlyZSBkaXJlY3Rvcnkg
Y29udGVudHMgZnJvbSBzY3JhdGNoLCBiZWNhdXNlIGl0DQo+ID4gbmVlZHMNCj4gPiB0byBwZXJm
b3JtIGEgbGluZWFyIHNlYXJjaCBmb3IgdGhlIHJlYWRkaXIgY29va2llLiBXaGlsZSB0aGlzIGlz
DQo+ID4gbm90DQo+ID4gYW4gaXNzdWUgZm9yIHNtYWxsIGRpcmVjdG9yaWVzLCBpdCBkb2VzIG5v
dCBzY2FsZSB0byBkaXJlY3Rvcmllcw0KPiA+IHdpdGgNCj4gPiBtaWxsaW9ucyBvZiBlbnRyaWVz
Lg0KPiA+IEluIG9yZGVyIHRvIGJlIGFibGUgdG8gZGVhbCB3aXRoIGxhcmdlIGRpcmVjdG9yaWVz
IHRoYXQgYXJlDQo+ID4gY2hhbmdpbmcsDQo+ID4gYWRkIGEgaGV1cmlzdGljIHRvIGVuc3VyZSB0
aGF0IGlmIHRoZSBwYWdlIGNhY2hlIGlzIGVtcHR5LCBhbmQgd2UNCj4gPiBhcmUNCj4gPiBzZWFy
Y2hpbmcgZm9yIGEgY29va2llIHRoYXQgaXMgbm90IHRoZSB6ZXJvIGNvb2tpZSwgd2UganVzdCBk
ZWZhdWx0DQo+ID4gdG8NCj4gPiBwZXJmb3JtaW5nIHVuY2FjaGVkIHJlYWRkaXIuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogVHJvbmQgTXlrbGVidXN0IDx0cm9uZC5teWtsZWJ1c3RAaGFtbWVy
c3BhY2UuY29tPg0KPiA+IC0tLQ0KPiA+IMKgZnMvbmZzL2Rpci5jIHwgMTcgKysrKysrKysrKysr
KysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2ZzL25mcy9kaXIuYyBiL2ZzL25mcy9kaXIuYw0KPiA+IGluZGV4IDIzODg3
MmQxMTZmNy4uZDdhOWVmZDMxZWNkIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mcy9kaXIuYw0KPiA+
ICsrKyBiL2ZzL25mcy9kaXIuYw0KPiA+IEBAIC05MTcsMTEgKzkxNywyOCBAQCBzdGF0aWMgaW50
IGZpbmRfYW5kX2xvY2tfY2FjaGVfcGFnZShzdHJ1Y3QNCj4gPiBuZnNfcmVhZGRpcl9kZXNjcmlw
dG9yICpkZXNjKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXM7DQo+ID4gwqB9DQo+ID4g
DQo+ID4gK3N0YXRpYyBib29sIG5mc19yZWFkZGlyX2RvbnRfc2VhcmNoX2NhY2hlKHN0cnVjdA0K
PiA+IG5mc19yZWFkZGlyX2Rlc2NyaXB0b3IgKmRlc2MpDQo+ID4gK3sNCj4gPiArwqDCoMKgwqDC
oMKgIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nID0gZGVzYy0+ZmlsZS0+Zl9tYXBwaW5n
Ow0KPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGlub2RlICpkaXIgPSBmaWxlX2lub2RlKGRlc2Mt
PmZpbGUpOw0KPiA+ICvCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IGR0c2l6ZSA9IE5GU19TRVJW
RVIoZGlyKS0+ZHRzaXplOw0KPiA+ICvCoMKgwqDCoMKgwqAgbG9mZl90IHNpemUgPSBpX3NpemVf
cmVhZChkaXIpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgIC8qDQo+ID4gK8KgwqDCoMKgwqDC
oMKgICogRGVmYXVsdCB0byB1bmNhY2hlZCByZWFkZGlyIGlmIHRoZSBwYWdlIGNhY2hlIGlzIGVt
cHR5LA0KPiA+IGFuZA0KPiA+ICvCoMKgwqDCoMKgwqDCoCAqIHdlJ3JlIGxvb2tpbmcgZm9yIGEg
bm9uLXplcm8gY29va2llIGluIGEgbGFyZ2UNCj4gPiBkaXJlY3RvcnkuDQo+ID4gK8KgwqDCoMKg
wqDCoMKgICovDQo+ID4gK8KgwqDCoMKgwqDCoCByZXR1cm4gZGVzYy0+ZGlyX2Nvb2tpZSAhPSAw
ICYmIG1hcHBpbmctPm5ycGFnZXMgPT0gMCAmJg0KPiA+IHNpemUgPiBkdHNpemU7DQo+ID4gK30N
Cj4gPiArDQo+ID4gwqAvKiBTZWFyY2ggZm9yIGRlc2MtPmRpcl9jb29raWUgZnJvbSB0aGUgYmVn
aW5uaW5nIG9mIHRoZSBwYWdlDQo+ID4gY2FjaGUgKi8NCj4gPiDCoHN0YXRpYyBpbnQgcmVhZGRp
cl9zZWFyY2hfcGFnZWNhY2hlKHN0cnVjdCBuZnNfcmVhZGRpcl9kZXNjcmlwdG9yDQo+ID4gKmRl
c2MpDQo+ID4gwqB7DQo+ID4gwqDCoMKgwqDCoMKgwqAgaW50IHJlczsNCj4gPiANCj4gPiArwqDC
oMKgwqDCoMKgIGlmIChuZnNfcmVhZGRpcl9kb250X3NlYXJjaF9jYWNoZShkZXNjKSkNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVCQURDT09LSUU7DQo+ID4gKw0K
PiA+IMKgwqDCoMKgwqDCoMKgIGRvIHsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKGRlc2MtPnBhZ2VfaW5kZXggPT0gMCkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGVzYy0+Y3VycmVudF9pbmRleCA9IDA7DQo+ID4g
LS0NCj4gPiAyLjI4LjANCj4gPiANCj4gSSBkaWQgYSBsb3Qgb2YgdGVzdGluZyB5ZXN0ZXJkYXkg
YW5kIGxhc3QgbmlnaHQgYW5kIHRoaXMgbW9zdGx5DQo+IGJlaGF2ZXMgYXMgZGVzaWduZWQuDQo+
IA0KPiBIb3dldmVyLCBiZWZvcmUgeW91IHNlbnQgdGhpcyBJIHdhcyBzdGFydGluZyB0byB0ZXN0
IHRoZSBmb2xsb3dpbmcNCj4gcGF0Y2ggd2hpY2ggYWRkcyBhIE5GU19ESVJfQ09OVEVYVF9VTkNB
Q0hFRA0KPiBmbGFnIGluc2lkZSBuZnNfb3Blbl9kaXJfY29udGV4dC7CoCBJIHdhcyBub3Qgc3Vy
ZSBhYm91dCB0aGUgbG9naWMNCj4gd2hlbg0KPiB0byB0dXJuIGl0IG9uLCBzbyBmb3Igbm93IEkn
ZCBpZ25vcmUgdGhhdA0KPiAoZXNwZWNpYWxseSBucnBhZ2VzID4gTkZTX1JFQURESVJfVU5DQUNI
RURfVEhSRVNIT0xEKS7CoCBIb3dldmVyLCBJJ20NCj4gY3VyaW91cyB3aHk6DQo+IDEuIHlvdSBk
aWRuJ3QgdGFrZSB0aGUgYXBwcm9hY2ggb2YgYWRkaW5nIGEgcGVyLXByb2Nlc3MgY29udGV4dCBm
bGFnDQo+IHNvIG9uY2UgYSBwcm9jZXNzIGhpdHMgdGhpcyBjb25kaXRpb24sIHRoZQ0KPiBwcm9j
ZXNzIHdvdWxkIGp1c3Qgc2hpZnQgdG8gdW5jYWNoZWQgYW5kIGJlIHVuYWZmZWN0ZWQgYnkgYW55
IG90aGVyDQo+IHByb2Nlc3MuwqAgSSB3b25kZXIgYWJvdXQgbXVsdGlwbGUgZGlyZWN0b3J5DQo+
IGxpc3RpbmcgcHJvY2Vzc2VzIGRlZmVhdGluZyB0aGlzIGxvZ2ljIGlmIGl0J3Mgbm90IHBlci1w
cm9jZXNzIHNvIHdlDQo+IG1heSBnZXQgYW4gdW5ib3VuZGVkIHRpbWUgc3RpbGwNCj4gMi4geW91
IHB1dCB0aGUgbG9naWMgaW5zaWRlIHJlYWRkaXJfc2VhcmNoX3BhZ2VjYWNoZSByYXRoZXIgdGhh
bg0KPiBpbnNpZGUgdGhlIGNhbGxpbmcgZG8geyAuLiB9IHdoaWxlIGxvb3ANCg0KVGhlIHJlYXNv
biBmb3IgdXNpbmcgdW5jYWNoZWQgcmVhZGRpciBoZXJlIGlzIGJlY2F1c2Ugd2UncmUgaGF2aW5n
DQp0cm91YmxlIHNoYXJpbmcgdGhlIGNhY2hlLiBIb3dldmVyIGlmIHRoZXJlIGlzIGEgcG9zc2li
aWxpdHkgdG8gZG8gc28sDQpiZWNhdXNlIHdlIGhhdmUgbXVsdGlwbGUgcHJvY2Vzc2VzIHJhY2lu
ZyB0byByZWFkIHRoZSBzYW1lIGRpcmVjdG9yeSwNCnRoZW4gd2h5IHNob3VsZCB3ZSBub3QgdHJ5
Pw0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoNCg==
