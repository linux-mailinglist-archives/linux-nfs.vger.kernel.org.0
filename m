Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0638621F811
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jul 2020 19:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgGNRVX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jul 2020 13:21:23 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:56341 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgGNRVX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jul 2020 13:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594747282; x=1626283282;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mQdU6qAxMHJ74owgd48Th1eZik1UsKy4eCyJGCMQgD0=;
  b=vPlKfUV+gpHHRCZ2manLlk4iGC29yrHq4NdaoZQbWBtyctFEWjzHZrxd
   P2sE0TRDlR6eACLgFrA5W3y7p2917l27I4yM0egO/bufLVx1z2ghuy5pT
   B/pZrL7eM/AamCGrRS1Wbi9plCXnZUafn0koVj8loN4R8qNvostb67eEv
   0=;
IronPort-SDR: lBzCnr8mcxUMwy58oODrDNYX0jbaD9/n6kmzSp+Hhl6IZ2PiyaPzf+0hS36NRgrV8xJucxnnaF
 lkEgoTJvTQFA==
X-IronPort-AV: E=Sophos;i="5.75,352,1589241600"; 
   d="scan'208";a="41804987"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 14 Jul 2020 17:20:51 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 328D1A2346;
        Tue, 14 Jul 2020 17:20:50 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 14 Jul 2020 17:20:49 +0000
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 14 Jul 2020 17:20:49 +0000
Received: from EX13D13UWB002.ant.amazon.com ([10.43.161.21]) by
 EX13D13UWB002.ant.amazon.com ([10.43.161.21]) with mapi id 15.00.1497.006;
 Tue, 14 Jul 2020 17:20:49 +0000
From:   "van der Linden, Frank" <fllinden@amazon.com>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>
Subject: Re: [PATCH v3 00/13] client side user xattr (RFC8276) support
Thread-Topic: [PATCH v3 00/13] client side user xattr (RFC8276) support
Thread-Index: AQHWSa8aNVY7gFwM+kWFPBzDlYf1+6kG/YWA
Date:   Tue, 14 Jul 2020 17:20:49 +0000
Message-ID: <CBBBBCD2-FD57-4C02-AB16-861BA86F5CF6@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.85]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC169A06CD8F3944818432DC594668F4@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

SGkgVHJvbmQsIEFubmENCg0KQW55IGNvbW1lbnRzIG9uIHRoaXMgc2VyaWVzPyBEbyB5b3UgdGhp
bmsgaXQgY2FuIGJlIGluY2x1ZGVkIGZvciA1Ljk/DQoNClRoZSBzZXJ2ZXIgc2lkZSBwYXRjaGVz
IGFyZSBsb29raW5nIHByZXR0eSBnb29kIGZvciA1LjkuDQoNCkxldCBtZSBrbm93IGlmIHRoZXJl
J3MgYW55dGhpbmcgeW91IHdhbnQgbWUgdG8gZG8vdGVzdC4NCg0KVGhhbmtzLA0KDQotIEZyYW5r
DQoNCu+7v09uIDYvMjMvMjAsIDM6MzkgUE0sICJGcmFuayB2YW4gZGVyIExpbmRlbiIgPGZsbGlu
ZGVuQGFtYXpvbi5jb20+IHdyb3RlOg0KDQp2MzoNCiAgICogUmViYXNlIHRvIHY1LjgtcmMyDQoN
CnYyOg0KICAgKiBNb3ZlIG5mczQgc3BlY2lmaWMgZGVmaW5pdGlvbnMgdG8gbmZzX2ZzNC5oDQog
ICAqIFNxdWFzaCBzb21lIHBhdGNoZXMgdG9nZXRoZXIgdG8gYXZvaWQgdW51c2VkIGZ1bmN0aW9u
IHdhcm5pbmdzDQogICAgIHdoZW4gYmlzZWN0aW5nLg0KICAgKiBNYWRlIGRldGVybWluaW5nIHNl
cnZlciBzdXBwb3J0IGEgdHdvLXN0ZXAgcHJvY2Vzcy4gRmlyc3QsDQogICAgIHRoZSBleHRlbmRl
ZCBhdHRyaWJ1dGUgRkFUVFIgaXMgdmVyaWZpZWQgdG8gYmUgc3VwcG9ydGVkLCB0aGVuDQogICAg
IHRoZSB2YWx1ZSBvZiB0aGUgYXR0cmlidXRlZCBpcyBxdWVyaWVkIGluIGZzaW5mbyB0byBkZXRl
cm1pbmUNCiAgICAgc3VwcG9ydC4NCiAgICogRml4ZWQgdXAgTWFrZWZpbGUgdG8gcmVtb3ZlIGFu
IHVubmVlZGVkIGV4dHJhIGxpbmUuDQoNCnYxOg0KICAgKiBDbGllbnQgc2lkZSBjYWNoaW5nIGlz
IG5vdyBpbmNsdWRlZCBpbiB0aGlzIHBhdGNoIHNldC4NCiAgICogQXMgcGVyIHRoZSBkaXNjdXNz
aW9uLCB1c2VyIGV4dGVuZGVkIGF0dHJpYnV0ZXMgYXJlIGVuYWJsZWQgaWYNCiAgICAgdGhlIGNs
aWVudCBhbmQgc2VydmVyIHN1cHBvcnQgdGhlbSAoZS5nLiB0aGV5IHN1cHBvcnQgNC4yIGFuZA0K
ICAgICBhZHZlcnRpc2UgdGhlIHVzZXIgZXh0ZW5kZWQgYXR0cmlidXRlIEZBVFRSKS4gVGhlcmUg
YXJlIG5vIGxvbmdlcg0KICAgICBvcHRpb25zIHRvIHN3aXRjaCB0aGVtIG9mZiBvbiBlaXRoZXIg
dGhlIGNsaWVudCBvciB0aGUgc2VydmVyLg0KICAgKiBUaGUgY29kZSBpcyBubyBsb25nZXIgY29u
ZGl0aW9uZWQgb24gYSBjb25maWcgb3B0aW9uLg0KICAgKiBUaGUgbnVtYmVyIG9mIHBhdGNoZXMg
aGFzIGJlZW4gcmVkdWNlZCBzb21ld2hhdCBieSBtZXJnaW5nDQogICAgIHNtYWxsZXIsIHJlbGF0
ZWQgb25lcy4NCg0KDQpPcmlnaW5hbCBjb21iaW5lZCBjbGllbnQvc2VydmVyIFJGQzoNCmh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTExNDM1NjUvDQoNCkluIGdlbmVyYWwsIHRo
ZXNlIHBhdGNoZXMgd2VyZSwgYm90aCBzZXJ2ZXIgYW5kIGNsaWVudCwgdGVzdGVkIGFzDQpmb2xs
b3dzOg0KICAgICAgICAqIHN0cmVzcy1uZy14YXR0ciB3aXRoIDEwMDAgd29ya2Vycw0KICAgICAg
ICAqIFRlc3QgYWxsIGNvcm5lciBjYXNlcyAoWEFUVFJfU0laRV8qKQ0KICAgICAgICAqIFRlc3Qg
YWxsIGZhaWx1cmUgY2FzZXMgKG5vIHhhdHRyLCBzZXR4YXR0ciB3aXRoIGRpZmZlcmVudCBvcg0K
ICAgICAgICAgIGludmFsaWQgZmxhZ3MsIGV0YykuDQogICAgICAgICogVmVyaWZ5IHRoZSBjb250
ZW50IG9mIHhhdHRycyBhY3Jvc3Mgc2V2ZXJhbCBvcGVyYXRpb25zLg0KICAgICAgICAqIFVzZSBL
QVNBTiBhbmQgS01FTUxFQUsgZm9yIGEgbG9uZ2VyIG1peCBvZiB0ZXN0cnVucyB0byB2ZXJpZnkN
CiAgICAgICAgICB0aGF0IHRoZXJlIHdlcmUgbm8gbGVha3MgKGFmdGVyIHVubW91bnRpbmcgdGhl
IGZpbGVzeXN0ZW0pLg0KICAgICAgICAqIEludGVyb3AgcnVuIGFnYWluc3QgRnJlZUJTRCBzZXJ2
ZXIvY2xpZW50IGltcGxlbWVudGF0aW9uLg0KICAgICAgICAqIFJhbiB4ZnN0ZXN0cy1kZXYsIHdp
dGggbm8gdW5leHBlY3RlZC9uZXcgZmFpbHVyZXMgYXMgY29tcGFyZWQNCiAgICAgICAgICB0byBh
biB1bnBhdGNoZWQga2VybmVsLiBUbyBmdWxseSB1c2UgeGZzdGVzdHMtZGV2LCBpdCBuZWVkZWQN
CiAgICAgICAgICBzb21lIG1vZGlmaWNhdGlvbnMsIGFzIGl0IGV4cGVjdHMgdG8gZWl0aGVyIHVz
ZSBhbGwgeGF0dHINCiAgICAgICAgICBuYW1lc3BhY2VzLCBvciBub25lLiBXaGVyZWFzIE5GUyBv
bmx5IHN1cHBvcnMgdGhlICJ1c2VyLiINCiAgICAgICAgICBuYW1lc3BhY2UgKCsgb3B0aW9uYWwg
QUNMcykuIEkgd2lsbCBzZW5kIHRoZSBjaGFuZ2VzIGluDQogICAgICAgICAgc2VwZXJhdGVseS4N
CgkqIFRlc3QgdGhlIG1lbW9yeSBzaHJpbmtlciBmb3IgdGhlIGNsaWVudCBzaWRlIGNhY2hlIGJ5
IHJ1bm5pbmcNCgkgIHRoZSBjbGllbnQgaW5zaWRlIGEgMUcgS1ZNIFZNLCBmaWxsaW5nIHVwIHRo
ZSBjYWNoZSBieSBydW5uaW5nDQoJICBhbiBhZ3Jlc3NpdmUgbXVsdGktdGhyZWFkZWQgeGF0dHIg
d29ya2xvYWQsIGFuZCB0cmFjaW5nIHRoZQ0KCSAgc2hyaW5rZXIgd2hlbiBpdCBraWNrZWQgaW4u
IE5vIG1lbW9yeSBhbGxvY2F0aW9uIHByb2JsZW1zIHdlcmUNCgkgIHNlZW4uDQoNCkZyYW5rIHZh
biBkZXIgTGluZGVuICgxMyk6DQogIG5mcyxuZnNkOiAgTkZTdjQuMiBleHRlbmRlZCBhdHRyaWJ1
dGUgcHJvdG9jb2wgZGVmaW5pdGlvbnMNCiAgbmZzOiBhZGQgY2xpZW50IHNpZGUgb25seSBkZWZp
bml0aW9ucyBmb3IgdXNlciB4YXR0cnMNCiAgTkZTdjQuMjogZGVmaW5lIGxpbWl0cyBhbmQgc2l6
ZXMgZm9yIHVzZXIgeGF0dHIgaGFuZGxpbmcNCiAgTkZTdjQuMjogcXVlcnkgdGhlIHNlcnZlciBm
b3IgZXh0ZW5kZWQgYXR0cmlidXRlIHN1cHBvcnQNCiAgTkZTdjQuMjogYWRkIGNsaWVudCBzaWRl
IFhEUiBoYW5kbGluZyBmb3IgZXh0ZW5kZWQgYXR0cmlidXRlcw0KICBuZnM6IGRlZmluZSBuZnNf
YWNjZXNzX2dldF9jYWNoZWQgZnVuY3Rpb24NCiAgTkZTdjQuMjogcXVlcnkgdGhlIGV4dGVuZGVk
IGF0dHJpYnV0ZSBhY2Nlc3MgYml0cw0KICBuZnM6IG1vZGlmeSB1cGRhdGVfY2hhbmdlYXR0ciB0
byBkZWFsIHdpdGggcmVndWxhciBmaWxlcw0KICBuZnM6IGRlZmluZSBhbmQgdXNlIHRoZSBORlNf
SU5PX0lOVkFMSURfWEFUVFIgZmxhZw0KICBuZnM6IG1ha2UgdGhlIGJ1Zl90b19wYWdlc19ub3Ns
YWIgZnVuY3Rpb24gYXZhaWxhYmxlIHRvIHRoZSBuZnMgY29kZQ0KICBORlN2NC4yOiBhZGQgdGhl
IGV4dGVuZGVkIGF0dHJpYnV0ZSBwcm9jIGZ1bmN0aW9ucy4NCiAgTkZTdjQuMjogaG9vayBpbiB0
aGUgdXNlciBleHRlbmRlZCBhdHRyaWJ1dGUgaGFuZGxlcnMNCiAgTkZTdjQuMjogYWRkIGNsaWVu
dCBzaWRlIHhhdHRyIGNhY2hpbmcuDQoNCiBmcy9uZnMvTWFrZWZpbGUgICAgICAgICAgICAgfCAg
ICAyICstDQogZnMvbmZzL2NsaWVudC5jICAgICAgICAgICAgIHwgICAyMiArLQ0KIGZzL25mcy9k
aXIuYyAgICAgICAgICAgICAgICB8ICAgMjQgKy0NCiBmcy9uZnMvaW5vZGUuYyAgICAgICAgICAg
ICAgfCAgIDE2ICstDQogZnMvbmZzL25mczQyLmggICAgICAgICAgICAgIHwgICAyNCArDQogZnMv
bmZzL25mczQycHJvYy5jICAgICAgICAgIHwgIDI0OCArKysrKysrKw0KIGZzL25mcy9uZnM0Mnhh
dHRyLmMgICAgICAgICB8IDEwODMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
CiBmcy9uZnMvbmZzNDJ4ZHIuYyAgICAgICAgICAgfCAgNDM4ICsrKysrKysrKysrKysrDQogZnMv
bmZzL25mczRfZnMuaCAgICAgICAgICAgIHwgICAzNSArKw0KIGZzL25mcy9uZnM0Y2xpZW50LmMg
ICAgICAgICB8ICAgMzEgKw0KIGZzL25mcy9uZnM0cHJvYy5jICAgICAgICAgICB8ICAyMzcgKysr
KysrKy0NCiBmcy9uZnMvbmZzNHN1cGVyLmMgICAgICAgICAgfCAgIDEwICsNCiBmcy9uZnMvbmZz
NHhkci5jICAgICAgICAgICAgfCAgIDMxICsNCiBmcy9uZnMvbmZzdHJhY2UuaCAgICAgICAgICAg
fCAgICAzICstDQogaW5jbHVkZS9saW51eC9uZnM0LmggICAgICAgIHwgICAyNSArDQogaW5jbHVk
ZS9saW51eC9uZnNfZnMuaCAgICAgIHwgICAxMiArDQogaW5jbHVkZS9saW51eC9uZnNfZnNfc2Iu
aCAgIHwgICAgNiArDQogaW5jbHVkZS9saW51eC9uZnNfeGRyLmggICAgIHwgICA2MCArLQ0KIGlu
Y2x1ZGUvdWFwaS9saW51eC9uZnM0LmggICB8ICAgIDMgKw0KIGluY2x1ZGUvdWFwaS9saW51eC9u
ZnNfZnMuaCB8ICAgIDEgKw0KIDIwIGZpbGVzIGNoYW5nZWQsIDIyNjkgaW5zZXJ0aW9ucygrKSwg
NDIgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGZzL25mcy9uZnM0MnhhdHRyLmMN
Cg0KLS0gDQoyLjE3LjINCg0KDQo=
