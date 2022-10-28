Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9380261190A
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 19:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiJ1ROW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 13:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiJ1ROV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 13:14:21 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD5AE4A
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 10:14:20 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id e15so5124030iof.2
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 10:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5XNgSsEq8vOrb3y+8G8g3hexuQ/j5bt/MCK+TBnCiJ0=;
        b=sX4doDM00qB88tN1dawLzeC6cVSuHqamcJsS3wWPJAvZIg3I28l9eL6ZLGGQx6s1bX
         ClGpYbOwn08uvHJFtBnjauQhH5LQmIgmX7yRsW4A9KP5ZpRKs9wGbtAzsHPlFd4MVIbe
         6hfiGlKtvku+omA02cTLRqdI+ugek+S5Ob4QQn+GSZ/7OV9kdBZGKxXyTWUcWcFRmkGq
         CcSXeu6470isl4W4Z0lMave4SdNjDDBpB8ogSBB7JSTupd33ZbE3ZL7UJqjHXRtMWf7G
         sR44bgLwcOtsn1tOnlLEntn9rKmWodMbqkfz+9JCEPW+oLpcr89L1UksC4SfCOb9XN/F
         /+/w==
X-Gm-Message-State: ACrzQf2WjWoKALbp2GllTFcTCj+Hbz413hZPlwi1OzmXRC+P9uZqO/WA
        qsxh+Z2bjM4D4dkuRhoiqbTtsjKgOg==
X-Google-Smtp-Source: AMsMyM4xWugIfjL2bKxgAAqoAP5WqrmCAtnlcRXrbJVGopZIWr2X28blkMjO7bmmITEno4znIlHAHQ==
X-Received: by 2002:a05:6638:629:b0:374:e740:883d with SMTP id h9-20020a056638062900b00374e740883dmr267479jar.278.1666977259441;
        Fri, 28 Oct 2022 10:14:19 -0700 (PDT)
Received: from [192.168.75.138] (50-36-85-28.alma.mi.frontiernet.net. [50.36.85.28])
        by smtp.gmail.com with ESMTPSA id y8-20020a056602164800b006a49722dc6dsm1913200iow.11.2022.10.28.10.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 10:14:19 -0700 (PDT)
Message-ID: <8675d583b7d3d2832f7c52da01e4b171e8f5ba46.camel@kernel.org>
Subject: Re: [PATCH v9 1/5] NFS: Rename readpage_async_filler to
 nfs_pageio_add_page
From:   Trond Myklebust <trondmy@kernel.org>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Date:   Fri, 28 Oct 2022 13:14:17 -0400
In-Reply-To: <CALF+zOkC4F-g5sW1-v5eyyFph_JuSuSrLMbQ-3Uk71_QN2d75Q@mail.gmail.com>
References: <20221017105212.77588-1-dwysocha@redhat.com>
         <20221017105212.77588-2-dwysocha@redhat.com>
         <010f7996fde7dc4aa7a21e4b2b835d5ae7084771.camel@kernel.org>
         <CALF+zOkC4F-g5sW1-v5eyyFph_JuSuSrLMbQ-3Uk71_QN2d75Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

T24gRnJpLCAyMDIyLTEwLTI4IGF0IDA2OjMyIC0wNDAwLCBEYXZpZCBXeXNvY2hhbnNraSB3cm90
ZToKPiBPbiBUaHUsIE9jdCAyNywgMjAyMiBhdCAyOjA3IFBNIFRyb25kIE15a2xlYnVzdCA8dHJv
bmRteUBrZXJuZWwub3JnPgo+IHdyb3RlOgo+ID4gCj4gPiBPbiBNb24sIDIwMjItMTAtMTcgYXQg
MDY6NTIgLTA0MDAsIERhdmUgV3lzb2NoYW5za2kgd3JvdGU6Cj4gPiA+IFJlbmFtZSByZWFkcGFn
ZV9hc3luY19maWxsZXIgdG8gbmZzX3BhZ2Vpb19hZGRfcGFnZSB0bwo+ID4gPiBiZXR0ZXIgcmVm
bGVjdCB3aGF0IHRoaXMgZnVuY3Rpb24gZG9lcyAoYWRkIGEgcGFnZSB0bwo+ID4gPiB0aGUgbmZz
X3BhZ2Vpb19kZXNjcmlwdG9yKSwgYW5kIHNpbXBsaWZ5IGFyZ3VtZW50cyB0bwo+ID4gPiB0aGlz
IGZ1bmN0aW9uIGJ5IHJlbW92aW5nIHN0cnVjdCBuZnNfcmVhZGRlc2MuCj4gPiA+IAo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBEYXZlIFd5c29jaGFuc2tpIDxkd3lzb2NoYUByZWRoYXQuY29tPgo+ID4g
PiBSZXZpZXdlZC1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4KPiA+ID4gLS0t
Cj4gPiA+IMKgZnMvbmZzL3JlYWQuYyB8IDYwICsrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLQo+ID4gPiAtLS0tCj4gPiA+IC0tCj4gPiA+IMKgMSBmaWxlIGNoYW5n
ZWQsIDMwIGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+ID4gZGlmZiAt
LWdpdCBhL2ZzL25mcy9yZWFkLmMgYi9mcy9uZnMvcmVhZC5jCj4gPiA+IGluZGV4IDhhZTJjOGQx
MjE5ZC4uNTI1ZTgyZWE5YTllIDEwMDY0NAo+ID4gPiAtLS0gYS9mcy9uZnMvcmVhZC5jCj4gPiA+
ICsrKyBiL2ZzL25mcy9yZWFkLmMKPiA+ID4gQEAgLTEyNywxMSArMTI3LDYgQEAgc3RhdGljIHZv
aWQgbmZzX3JlYWRwYWdlX3JlbGVhc2Uoc3RydWN0Cj4gPiA+IG5mc19wYWdlCj4gPiA+ICpyZXEs
IGludCBlcnJvcikKPiA+ID4gwqDCoMKgwqDCoMKgwqAgbmZzX3JlbGVhc2VfcmVxdWVzdChyZXEp
Owo+ID4gPiDCoH0KPiA+ID4gCj4gPiA+IC1zdHJ1Y3QgbmZzX3JlYWRkZXNjIHsKPiA+ID4gLcKg
wqDCoMKgwqDCoCBzdHJ1Y3QgbmZzX3BhZ2Vpb19kZXNjcmlwdG9yIHBnaW87Cj4gPiA+IC3CoMKg
wqDCoMKgwqAgc3RydWN0IG5mc19vcGVuX2NvbnRleHQgKmN0eDsKPiA+ID4gLX07Cj4gPiA+IC0K
PiA+ID4gwqBzdGF0aWMgdm9pZCBuZnNfcGFnZV9ncm91cF9zZXRfdXB0b2RhdGUoc3RydWN0IG5m
c19wYWdlICpyZXEpCj4gPiA+IMKgewo+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAobmZzX3BhZ2Vf
Z3JvdXBfc3luY19vbl9iaXQocmVxLCBQR19VUFRPREFURSkpCj4gPiA+IEBAIC0xNTMsNyArMTQ4
LDggQEAgc3RhdGljIHZvaWQgbmZzX3JlYWRfY29tcGxldGlvbihzdHJ1Y3QKPiA+ID4gbmZzX3Bn
aW9faGVhZGVyICpoZHIpCj4gPiA+IAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKHRlc3RfYml0KE5GU19JT0hEUl9FT0YsICZoZHItPmZsYWdzKSkgewo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIG5vdGU6IHJlZ2lv
bnMgb2YgdGhlIHBhZ2Ugbm90IGNvdmVyZWQKPiA+ID4gYnkgYQo+ID4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHJlcXVlc3QgYXJlIHplcm9lZCBp
bgo+ID4gPiByZWFkcGFnZV9hc3luY19maWxsZXIgKi8KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiByZXF1ZXN0IGFyZSB6ZXJvZWQgaW4KPiA+
ID4gbmZzX3BhZ2Vpb19hZGRfcGFnZQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChieXRlcyA+IGhkci0+Z29vZF9ieXRlcykgewo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAvKiBub3RoaW5nIGluIHRoaXMgcmVxdWVzdCB3YXMKPiA+ID4gZ29vZCwKPiA+ID4gc28g
emVybwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICogdGhlIGZ1bGwgZXh0ZW50IG9mIHRoZSByZXF1ZXN0Cj4gPiA+
ICovCj4gPiA+IEBAIC0yODEsOCArMjc3LDEwIEBAIHN0YXRpYyB2b2lkIG5mc19yZWFkcGFnZV9y
ZXN1bHQoc3RydWN0Cj4gPiA+IHJwY190YXNrCj4gPiA+ICp0YXNrLAo+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbmZzX3JlYWRwYWdlX3JldHJ5KHRhc2ssIGhkcik7Cj4gPiA+
IMKgfQo+ID4gPiAKPiA+ID4gLXN0YXRpYyBpbnQKPiA+ID4gLXJlYWRwYWdlX2FzeW5jX2ZpbGxl
cihzdHJ1Y3QgbmZzX3JlYWRkZXNjICpkZXNjLCBzdHJ1Y3QgcGFnZQo+ID4gPiAqcGFnZSkKPiA+
ID4gK2ludAo+ID4gPiArbmZzX3BhZ2Vpb19hZGRfcGFnZShzdHJ1Y3QgbmZzX3BhZ2Vpb19kZXNj
cmlwdG9yICpwZ2lvLAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCBuZnNfb3Blbl9jb250ZXh0ICpjdHgsCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHBhZ2UgKnBhZ2UpCj4gPiAKPiA+IElmIHdlJ3JlIGdv
aW5nIHRvIHJlbmFtZSB0aGlzIGZ1bmN0aW9uLCB0aGVuIGxldCdzIG5vdCBnaXZlIGl0IGEKPiA+
IG5hbWUKPiA+IHRoYXQgc3VnZ2VzdHMgaXQgYmVsb25ncyBpbiBwYWdlbGlzdC5jLiBJdCdzIG5v
dCBhIGdlbmVyaWMgaGVscGVyCj4gPiBmdW5jdGlvbiwgYnV0IGlzIHN0aWxsIHZlcnkgbXVjaCBz
cGVjaWZpYyB0byB0aGUgcGFnZWNhY2hlIHJlYWQKPiA+IGZ1bmN0aW9uYWxpdHkuCj4gPiAKPiAK
PiBIb3cgYWJvdXQgbmZzX3JlYWRfYWRkX3BhZ2UoKT8KPiAKPiAKClRoYXQncyBiZXR0ZXIuIAoK
LS0gClRyb25kIE15a2xlYnVzdApMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNw
YWNlCnRyb25kLm15a2xlYnVzdEBoYW1tZXJzcGFjZS5jb20KCgo=

