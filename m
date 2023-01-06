Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF4065FA3D
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jan 2023 04:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjAFD3r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Jan 2023 22:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbjAFD33 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Jan 2023 22:29:29 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004CA6ADA0
        for <linux-nfs@vger.kernel.org>; Thu,  5 Jan 2023 19:29:21 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id i20so1144741qtw.9
        for <linux-nfs@vger.kernel.org>; Thu, 05 Jan 2023 19:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jq2vhPGAO0v/wT2bPJea16b3mlomhbA+LjHzdkTGgSw=;
        b=3YldhEOgnrnN0uZKDDsWiqvgJobbmJqcJg5ZyTBiX1f9jyulH7CU16ewXHklsiA3kQ
         OMYB3dkEd25buknKqLDTngASAtGv0Kzyi9g85tGxF8dC58RZmxcyBmYyiz7XOSAlNv9L
         TfRyZHclWnwVnX8ILlyMidCEL5paVwI+B8LFQphSfRjp6qQydzefgfyoPu9gd0BqHLee
         V2bjfTqOOt2Otcq2/E/ikp7Oqd4bWLbOiULqGWxdm+N59522Kna3bjsjnmw0rVbdBpD0
         13WSEfniz7kro3Z5TDMQSAY6EZXVTxgTZUIjSWf7a483CgKFffixXdnPjC8948vCk9N8
         o84g==
X-Gm-Message-State: AFqh2krt7LVqDEnBR4iILdA+1TDIV5LYK6rItbi4YgfBMhWIKF0tYKM8
        j2Ehvp2ceTkLsc7bKdWRvw==
X-Google-Smtp-Source: AMrXdXsAfC0PI44jPpzxdGF8ECbYLnTr6/1nZxrltxQuLoJ/ylr+c2vtjLarXMXBqW02NSehdSAV0g==
X-Received: by 2002:ac8:6999:0:b0:3a7:ee15:d94c with SMTP id o25-20020ac86999000000b003a7ee15d94cmr75175563qtq.47.1672975760946;
        Thu, 05 Jan 2023 19:29:20 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a28c100b006fafaac72a6sm26890942qkp.84.2023.01.05.19.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 19:29:20 -0800 (PST)
Message-ID: <46f047159da42dadaca576e0a87a622539609730.camel@kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
From:   Trond Myklebust <trondmy@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Thu, 05 Jan 2023 22:29:19 -0500
In-Reply-To: <167295936597.13974.7568769884598065471@noble.neil.brown.name>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
        , <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
        , <167279409373.13974.16504090316814568327@noble.neil.brown.name>
        , <210f08ae5f0ba47c289293981f490fca848dd2ed.camel@kernel.org>
        , <167279837032.13974.12155714770736077636@noble.neil.brown.name>
         <167295936597.13974.7568769884598065471@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTA2IGF0IDA5OjU2ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6Cj4gT24g
V2VkLCAwNCBKYW4gMjAyMywgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gV2VkLCAwNCBKYW4gMjAy
MywgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gPiBPbiBXZWQsIDIwMjMtMDEtMDQgYXQgMTI6
MDEgKzExMDAsIE5laWxCcm93biB3cm90ZToKPiA+ID4gPiBPbiBXZWQsIDA0IEphbiAyMDIzLCBU
cm9uZCBNeWtsZWJ1c3Qgd3JvdGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+IAo+ID4gPiA+ID4gSWYg
dGhlIHNlcnZlciBzdGFydHMgdG8gcmVwbHkgTkZTNEVSUl9TVEFMRSB0byBHRVRBVFRSCj4gPiA+
ID4gPiByZXF1ZXN0cywKPiA+ID4gPiA+IHdoeSBkbwo+ID4gPiA+ID4gd2UgY2FyZSBhYm91dCBz
dGF0ZWlkIHZhbHVlcz8gSnVzdCBtYXJrIHRoZSBpbm9kZSBhcyBzdGFsZQo+ID4gPiA+ID4gYW5k
IGRyb3AKPiA+ID4gPiA+IGl0Cj4gPiA+ID4gPiBvbiB0aGUgZmxvb3IuCj4gPiA+ID4gCj4gPiA+
ID4gV2UgaGF2ZSBhIHZhbGlkIHN0YXRlIGZyb20gdGhlIHNlcnZlciAtIHdlIHJlYWxseSBzaG91
bGRuJ3QKPiA+ID4gPiBqdXN0Cj4gPiA+ID4gaWdub3JlCj4gPiA+ID4gaXQuCj4gPiA+ID4gCj4g
PiA+ID4gTWF5YmUgaXQgd291bGQgYmUgT0sgdG8gbWFyayB0aGUgaW5vZGUgc3RhbGUuwqAgSSBk
b24ndCBrbm93IGlmCj4gPiA+ID4gdmFyaW91cwo+ID4gPiA+IHJldHJ5IGxvb3BzIGFib3J0IHBy
b3Blcmx5IHdoZW4gdGhlIGlub2RlIGlzIHN0YWxlLgo+ID4gPiAKPiA+ID4gWWVzLCB0aGV5IGFy
ZSBhbGwgc3VwcG9zZWQgdG8gZG8gdGhhdC4gT3RoZXJ3aXNlIHdlIHdvdWxkIGVuZCB1cAo+ID4g
PiBsb29waW5nIGZvcmV2ZXIgaW4gY2xvc2UoKSwgZm9yIGluc3RhbmNlLCBzaW5jZSB0aGUgUFVU
RkgsCj4gPiA+IEdFVEFUVFIgYW5kCj4gPiA+IENMT1NFIGNhbiBhbGwgcmV0dXJuIE5GUzRFUlJf
U1RBTEUgYXMgd2VsbC4KPiA+IAo+ID4gVG8gbWFyayB0aGUgaW5vZGUgYXMgU1RBTEUgd2Ugc3Rp
bGwgbmVlZCB0byBmaW5kIHRoZSBpbm9kZSwgYW5kCj4gPiB0aGF0IGlzCj4gPiB0aGUga2V5IGJp
dCBtaXNzaW5nIGluIHRoZSBjdXJyZW50IGNvZGUuwqAgT25jZSB3ZSBmaW5kIHRoZSBpbm9kZSwK
PiA+IHdlCj4gPiBjb3VsZCBtYXJrIGl0IHN0YWxlLCBidXQgbWF5YmUgc29tZSBvdGhlciBlcnJv
ciByZXN1bHRlZCBpbiB0aGUKPiA+IG1pc3NpbmcKPiA+IEdFVEFUVFIuLi4KPiA+IAo+ID4gSXQg
bWlnaHQgbWFrZSBzZW5zZSB0byBwdXQgdGhlIG5ldyBjb2RlIGluIF9uZnM0X3Byb2Nfb3Blbigp
IGFmdGVyCj4gPiB0aGUKPiA+IGV4cGxpY2l0IG5mczRfcHJvY19nZXRhdHRyKCkgZmFpbHMuwqAg
V2Ugd291bGQgbmVlZCB0byBmaW5kIHRoZQo+ID4gaW5vZGUKPiA+IGdpdmVuIG9ubHkgdGhlIGZp
bGVoYW5kbGUuwqAgSXMgdGhlcmUgYW55IGVhc3kgd2F5IHRvIGRvIHRoYXQ/Cj4gPiAKPiA+IFRo
YW5rcywKPiA+IE5laWxCcm93bgo+ID4gCj4gCj4gSSBjb3VsZG4ndCBzZWUgYSBjb25zaXN0ZW50
IHBhdHRlcm4gdG8gZm9sbG93IGZvciB3aGVuIHRvIG1hcmsgYW4KPiBpbm9kZQo+IGFzIHN0YWxl
LsKgIERvIHRoaXMsIG9uIHRvcCBvZiB0aGUgcHJldmlvdXMgcGF0Y2gsIHNlZW0gcmVhc29uYWJs
ZT8KPiAKPiBUaGFua3MsCj4gTmVpbEJyb3duCj4gCj4gCj4gCj4gZGlmZiAtLWdpdCBhL2ZzL25m
cy9uZnM0cHJvYy5jIGIvZnMvbmZzL25mczRwcm9jLmMKPiBpbmRleCBiNDQxYjFkMTRhNTAuLjA0
NDk3Y2I0MjE1NCAxMDA2NDQKPiAtLS0gYS9mcy9uZnMvbmZzNHByb2MuYwo+ICsrKyBiL2ZzL25m
cy9uZnM0cHJvYy5jCj4gQEAgLTQ4OSw2ICs0ODksOCBAQCBzdGF0aWMgaW50IG5mczRfZG9faGFu
ZGxlX2V4Y2VwdGlvbihzdHJ1Y3QKPiBuZnNfc2VydmVyICpzZXJ2ZXIsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBjYXNlIC1FU1RBTEU6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGlub2RlICE9IE5VTEwgJiYgU19JU1JFRyhp
bm9kZS0+aV9tb2RlKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcG5mc19kZXN0cm95X2xheW91dChORlNfSShpbm9kZSkp
Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKGlu
b2RlKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoG5mc19zZXRfaW5vZGVfc3RhbGUoaW5vZGUpOwoKVGhpcyBpcyBub3JtYWxs
eSBkZWFsdCB3aXRoIGluIHRoZSBnZW5lcmljIGNvZGUgaW5zaWRlCm5mc19yZXZhbGlkYXRlX2lu
b2RlKCkuIFRoZXJlIHNob3VsZCBiZSBubyBuZWVkIHRvIGR1cGxpY2F0ZSBpdCBoZXJlLgoKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfREVMRUdfUkVWT0tF
RDoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNhc2UgLU5GUzRFUlJfQURNSU5f
UkVWT0tFRDoKPiBAQCAtMjcxMyw4ICsyNzE1LDEyIEBAIHN0YXRpYyBpbnQgX25mczRfcHJvY19v
cGVuKHN0cnVjdAo+IG5mczRfb3BlbmRhdGEgKmRhdGEsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHN0YXR1czsKPiDCoMKgwqDCoMKgwqDC
oMKgfQo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIShvX3Jlcy0+Zl9hdHRyLT52YWxpZCAmIE5GU19B
VFRSX0ZBVFRSKSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgaW5v
ZGUgKmlub2RlID0gbmZzNF9nZXRfaW5vZGVfYnlfc3RhdGVpZCgKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCZkYXRhLT5vX3Jlcy5zdGF0ZWlkLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGF0YS0+b3duZXIp
OwoKVGhlcmUgc2hvdWxkbid0IGJlIGEgbmVlZCB0byBnbyBsb29raW5nIGZvciBvcGVuIGRlc2Ny
aXB0b3JzIGhlcmUsCmJlY2F1c2UgdGhleSB3aWxsIGhpdCBFU1RBTEUgYXQgc29tZSBwb2ludCBs
YXRlciBhbnl3YXkuCgpJZiB3ZSdyZSBnb2luZyB0byBjaGFuZ2UgYW55dGhpbmcsIEknZCByYXRo
ZXIgc2VlIHVzIHJldHVybiAtRUFDQ0VTIGFuZAotRVNUQUxFIGZyb20gdGhlIGRlY29kZV9hY2Nl
c3MoKSBhbmQgZGVjb2RlX2dldGZhdHRyKCkgY2FsbHMgaW4KbmZzNF94ZHJfZGVjX29wZW4oKSAo
YW5kIG9ubHkgdGhvc2UgZXJyb3JzIGZyb20gdGhvc2UgdHdvIGNhbGxzISkgc28KdGhhdCB3ZSBj
YW4gc2tpcCB0aGUgdW5uZWNlc3NhcnkgZ2V0YXR0ciBjYWxsIGhlcmUuCgpJbiBmYWN0LCB0aGUg
b25seSBjYXNlIHRoYXQgdGhpcyBleHRyYSBnZXRhdHRyIHNob3VsZCBiZSB0cnlpbmcgdG8KYWRk
cmVzcyBpcyB0aGUgb25lIHdoZXJlIHRoZSBzZXJ2ZXIgcmV0dXJucyBORlM0RVJSX0RFTEFZIHRv
IGVpdGhlciB0aGUKZGVjb2RlX2FjY2VzcygpIG9yIHRoZSBkZWNvZGVfZ2V0ZmF0dHIoKSBjYWxs
cyBzcGVjaWZpY2FsbHksIGFuZCB3aGVyZQp3ZSB0aGVyZWZvcmUgZG9uJ3Qgd2FudCB0byByZXBs
YXkgdGhlIGVudGlyZSBvcGVuIGNhbGwuCgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgbmZzNF9zZXF1ZW5jZV9mcmVlX3Nsb3QoJm9fcmVzLT5zZXFfcmVzKTsKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgbmZzNF9wcm9jX2dldGF0dHIoc2VydmVyLCAmb19yZXMtPmZo
LCBvX3Jlcy0+Zl9hdHRyLAo+IE5VTEwpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBuZnM0X3Byb2NfZ2V0YXR0cihzZXJ2ZXIsICZvX3Jlcy0+ZmgsIG9fcmVzLT5mX2F0dHIsCj4g
aW5vZGUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpcHV0KGlub2RlKTsKPiDC
oMKgwqDCoMKgwqDCoMKgfQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiBAQCAt
NDMzNSw2ICs0MzQxLDcgQEAgaW50IG5mczRfcHJvY19nZXRhdHRyKHN0cnVjdCBuZnNfc2VydmVy
Cj4gKnNlcnZlciwgc3RydWN0IG5mc19maCAqZmhhbmRsZSwKPiDCoHsKPiDCoMKgwqDCoMKgwqDC
oMKgc3RydWN0IG5mczRfZXhjZXB0aW9uIGV4Y2VwdGlvbiA9IHsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC5pbnRlcnJ1cHRpYmxlID0gdHJ1ZSwKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgLmlub2RlID0gaW5vZGUsCj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqDC
oMKgwqDCoMKgwqDCoGludCBlcnI7Cj4gwqDCoMKgwqDCoMKgwqDCoGRvIHsKCi0tIApUcm9uZCBN
eWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQp0cm9uZC5t
eWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK

