Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A509199E3D
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2020 20:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgCaSll (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Mar 2020 14:41:41 -0400
Received: from mailg110.ethz.ch ([129.132.162.66]:5869 "EHLO mailg110.ethz.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgCaSlk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Mar 2020 14:41:40 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 14:41:39 EDT
Received: from mailm213.d.ethz.ch (2001:67c:10ec:5603::27) by mailg110.ethz.ch
 (2001:67c:10ec:5605::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 31 Mar
 2020 20:26:30 +0200
Received: from mailm110.d.ethz.ch (2001:67c:10ec:5602::22) by
 mailm213.d.ethz.ch (2001:67c:10ec:5603::27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 31 Mar 2020 20:26:35 +0200
Received: from mailm110.d.ethz.ch ([fe80::c430:c62a:4d17:d8a6]) by
 mailm110.d.ethz.ch ([fe80::c430:c62a:4d17:d8a6%4]) with mapi id
 15.01.1913.010; Tue, 31 Mar 2020 20:26:35 +0200
From:   "Walter  Stefan" <stefan.walter@inf.ethz.ch>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Walter Stefan" <stefan.walter@inf.ethz.ch>
Subject: Re: [PATCH] Add regex plugin for nfsidmap
Thread-Topic: [PATCH] Add regex plugin for nfsidmap
Thread-Index: AQHWBz3V9BfzZpQHyEa6DkLVZeSAqKhi4icAgAABpgA=
Date:   Tue, 31 Mar 2020 18:26:35 +0000
Message-ID: <1872C22B-0591-4A43-A98E-8EA167AC991F@inf.ethz.ch>
References: <20200331090237.D56A4B7279@osaka.inf.ethz.ch>
 <9ddd1ed60d57ea13a704b9f609c4dc3536043e66.camel@hammerspace.com>
In-Reply-To: <9ddd1ed60d57ea13a704b9f609c4dc3536043e66.camel@hammerspace.com>
Accept-Language: en-US, de-CH
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.14)
x-originating-ip: [151.248.166.174]
x-tm-snts-smtp: 2CDE292942AE071F3D30816382B311690D76F055344A1E3E2294EAE70FD73E102000:8
Content-Type: text/plain; charset="utf-8"
Content-ID: <38AED5BFA94E3A4889BA0E1824E7E72E@intern.ethz.ch>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQoNCj4gT24gMzEgTWFyIDIwMjAsIGF0IDE4OjIwLCBUcm9uZCBNeWtsZWJ1c3QgPHRyb25kbXlA
aGFtbWVyc3BhY2UuY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwgMjAyMC0wMy0zMSBhdCAxMTow
MiArMDIwMCwgU3RlZmFuIFdhbHRlciB3cm90ZToNCj4+IFRoZSBwYXRjaCBiZWxvdyBhZGRzIGEg
bmV3IG5mc2lkbWFwIHBsdWdpbiB0aGF0IHVzZXMgcmVnZXggdG8gZXh0cmFjdA0KPj4gaWRzIGZy
b20gTkZTdjQgbmFtZXMuIE5hbWVzIGFyZSBjcmVhdGVkIGZyb20gaWRzIGJ5IHByZS0gYW5kDQo+
PiBhcHBlbmRpbmcNCj4+IHN0YXRpYyBzdHJpbmdzLiBJdCB3b3JrcyB3aXRoIGJvdGggaWRtYXBk
IG9uIHNlcnZlcnMgYW5kIG5mc2lkbWFwIG9uDQo+PiBjbGllbnRzLg0KPj4gDQo+PiBUaGlzIHBs
dWdpbiBpcyBlc3BlY2lhbGx5IHVzZWZ1bCBpbiBlbnZpcm9ubWVudHMgd2l0aCBBY3RpdmUNCj4+
IERpcmVjdG9yeQ0KPj4gd2hlcmUgZGlzdHJpYnV0ZWQgTkZTIHNlcnZlcnMgdXNlIGEgbWl4IG9m
IHNob3J0ICh1bmFtZSkgYW5kIGxvbmcNCj4+IChkb21haW5cdW5hbWUpIG5hbWVzLiBDb21iaW5p
bmcgaXQgd2l0aCB0aGUgbnNzd2l0Y2ggcGx1Z2luIGNvdmVycw0KPj4gYm90aA0KPj4gdmFyaWFu
dHMuDQo+PiANCj4+IEN1cnJlbnRseSB0aGlzIHBsdWdpbiBoYXMgaXRzIG93biBnaXQgcHJvamVj
dCBvbiBnaXRodWIgYnV0IEkgdGhpbmsNCj4+IGl0IGNvdWxkIGJlIGhlbHBmdWwgaWYgaXQgd291
bGQgYmUgaW5jb3Jwb3JhdGVkIGluIHRoZSBtYWluIG5mcy11dGlscw0KPj4gcGx1Z2luIHNldC4N
Cj4gDQo+IEhtbS4uLiBXaHkgd291bGRuJ3QgeW91IHJhdGhlciB3YW50IHRvIHVzZSBzb21ldGhp
bmcgbGlrZSB0aGUNCj4gc3NzX3JwY2lkbWFwZCBwbHVnaW4gaW4gdGhlIEFEIGVudmlyb25tZW50
PyBNYW51YWwgZWRpdGluZyBvZiB0aGUNCj4gdXNlcm5hbWUgc291bmRzIGVycm9yIHByb25lLCBw
YXJ0aWN1bGFybHkgaWYgeW91ciBkb21haW4gaXMgcGFydCBvZiBhbg0KPiBBRCBmb3Jlc3QuDQo+
IA0KPiBJJ20gbm90IHNheWluZyB0aGF0IHRoaXMgcGx1Z2luIGNvdWxkbid0IGJlIHVzZWZ1bCBp
biBvdGhlcg0KPiBjaXJjdW1zdGFuY2VzIChwbGVhc2UgZWxhYm9yYXRlKSwganVzdCB0aGF0IHRo
ZSBBRCB1c2UgY2FzZSBzb3VuZHMgYQ0KPiBsaXR0bGUgaWZmeeKApg0KDQpUaGUgcmVhc29uIHdo
eSBJIHdyb3RlIHRoZSBwbHVnaW4gaW5pdGlhbGx5IHdhcyBiZWNhdXNlIHdlIGhhZCBhDQpuZXcg
U3BlY3RydW1TY2FsZSBmaWxlIHNlcnZlciB3aXRoIE5GUzQrS3JiNS4gVGhpcyBzeXN0ZW0gdXNl
cw0KdXNlciBuYW1lcyBvZiB0aGUgZm9ybSBET01BSU5cdW5hbWUuIEFjY29yZGluZyB0byBJQk0g
dGhhdCBpcw0KYnkgZGVzaWduIHNvIHRoYXQgaXQgY2FuIHN1cHBvcnQgbXVsdGlwbGUgZG9tYWlu
cyBhcyBpbiBhbiBBRCBmb3Jlc3QuDQoNCk5vdywgb3VyIGxpbnV4IGNsaWVudHMgYW5kIHNlcnZl
cnMgdG9vIG9ubHkga25vdyB1c2VycyBieSB0aGVpcg0KdW5hbWUuIFdlIGNvdWxkIG5vdCBnZXQg
Y2xpZW50cyB0byB3b3JrIGluIHRoaXMgbWl4ZWQgc2V0dXAgd2l0aA0KbmVpdGhlciBuc3N3aXRj
aC5zbyBub3Igc3NzLnNvLiBJIGp1c3QgdHJpZWQgYWdhaW4gYW5kIGV2ZW4gZmlkZGxpbmcNCndp
dGggTm8tU3RyaXAgYW5kIFJlZm9ybWF0LUdyb3VwLCBhbGwgSSBnZXQgaXMgbm9ib2R5Om5vYm9k
eQ0KKG9uIGFuIHVwLXRvLWRhdGUgUkhFTDcpLg0KDQpBbm90aGVyIGdvYWwgd2FzIHRvIGhhdmUg
cmF3IGNvbnRyb2wgb3ZlciB0aGUgcGFyc2luZyBhbmQNCmdlbmVyYXRpb24gb2YgdGhlIG5hbWVz
LCBldmVuIGlmIG9ubHkgZm9yIGRlYnVnZ2luZyBwdXJwb3Nlcy4NCklmIHlvdSB0aGluayBhYm91
dCB3aHkgdGhlIFJlZm9ybWF0LUdyb3VwIG9wdGlvbiB3YXMgYWRkZWQNCmFjY29yZGluZyB0byB0
aGUgbWFuIHBhZ2UsIHRoaXMgaXMgZXhhY3RseSBzb21ldGhpbmcgYSANCnN5c2FkbWluIGNvdWxk
IGZpeCBxdWlja2x5IHdpdGggdGhpcyBwbHVnaW4gd2hpbGUgd2FpdGluZw0KdW50aWwgdGhlIGRl
dnMgZmlndXJlIG91dCBob3cgdG8gcGVybWFuZW50bHkgZml4IGl0Lg0KDQpUcnVlLCBpbiBhbiBB
RCAgZm9yZXN0IHRoZSBuYW1lLT5pZCBtYXBwaW5nIHdvdWxkIHdvcmssIGJ1dCB0aGUNCmlkLT5u
YW1lIG1hcHBpbmcgZmFpbHMgYmVjYXVzZSB0aGVyZSBpcyBubyB1bmFtZS0+cmVhbG0NCm1hcHBp
bmcgYXZhaWxhYmxlLiBUaGUgc3NzIHBsdWdpbiBjYW4gZG8gdGhpcyBjb3JyZWN0bHkgSSBndWVz
cywNCmJ1dCB0aGVuIGFnYWluIG5zc3dpdGNoLnNvIGNhbm5vdCBlaXRoZXIgaWYgSSByZWFkIHRo
ZSBzb3VyY2UgcmlnaHQuDQoNCg==
