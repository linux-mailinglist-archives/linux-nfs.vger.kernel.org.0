Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565DC731E9F
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 19:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjFOREz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 13:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFOREs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 13:04:48 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15B0194;
        Thu, 15 Jun 2023 10:04:46 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9e9e9d06fso5225081cf.0;
        Thu, 15 Jun 2023 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686848686; x=1689440686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YuL4/fFGHW1h2jnYUu/vaiCa88peR1HnERpktr610W4=;
        b=Nj2pgtMAguiPPAYB9aIwbqk86tN2T/fEzv77mV1kMEoQ+LJRCgTaauGJD28rg1PD+5
         KVzsNj/wWpLLewhxP1jueIU2g5IHY/MFTMhj83ibOyHuSqUoVw6f2SvtL0hHAaXMlnJf
         XWPlD9ZcKhBVhug69UQOnjjcWOeNMQNm/HLJNC/Jfz3QvQ1e+rQjw46wOQYMCUOlfVoe
         6PN2IY/gQaKe1E80eW3PH6gvEZS7KgfXDA3ndHP6iicfrOtBJT7vgmWdFuYz1Y6EEHL0
         yCty+8C4HdFYP+hit345V80sOE584ePi8R3zZaPRj2bMFFBQ25VkDliUtShK7hI7hTSV
         yjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686848686; x=1689440686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuL4/fFGHW1h2jnYUu/vaiCa88peR1HnERpktr610W4=;
        b=IVp48HHHvskGITiRD5OalXGBZ8qaLuAFgT+ku0wq01IWRBgweCn8rS0sWnQejC+vun
         t8spSV8TFE9/rYIZaEHoiyFc8QnIoZOgifQ0LCvZLUtLie1CrK4cPSpAzba5hjLHKJX+
         QiB4rbjE3c4knS/2aN+ZQQGOWb3C8mlIVfTplKIaU2rsZLKBCjtmCGJ/Q2+5HDhbY1BW
         xJfMMWXOFRB7asHmY+WIlRMjoYopJfA1AHri3bY7DunY1OTnoHa2JgWuZVidxryev836
         Y8FOCfnk8j/UNvM92jNM7WkHwX6z7WsUN04+x0ExeHUK2ac2QatPZaA0eJgQIEhgXbc2
         o0Ag==
X-Gm-Message-State: AC+VfDxLOqqWx86dswGWeq0EUJmoIegljTpx/EEkXvg7hWHdsuNGRntz
        R1frUoKRWT5EHDRZgzh0EO0kIE4trzleClRq7C8=
X-Google-Smtp-Source: ACHHUZ5jXtu6CpND+Z61lZn26Pd/9N3XgPUxLWU5UhZAKdouwHUM5KHZ9rI+TY03USloK6ujTPzXwKDwFahB9Z4jSz4=
X-Received: by 2002:a05:6214:1c0a:b0:62d:ddeb:3770 with SMTP id
 u10-20020a0562141c0a00b0062dddeb3770mr5554057qvc.0.1686848685900; Thu, 15 Jun
 2023 10:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com> <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org>
 <51430925-8046-7066-84ed-2ff0db835347@linaro.org> <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
 <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org> <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
 <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org> <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
 <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org> <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org> <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
 <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org> <CAFX2Jfn_DSs38WQYsRs2ifLi5w+T3BhZfSU2W80T6dK48_Bb5g@mail.gmail.com>
 <e8d31e48-df6a-fde4-4c6b-c4ccf1664ded@linaro.org> <c8d454b0-d355-f599-f720-b7e64374fb56@linaro.org>
 <CAFX2JfmvMZ7DzD9znWeOHXywgPbUKDS1irMjUerEuborjRBpcg@mail.gmail.com>
In-Reply-To: <CAFX2JfmvMZ7DzD9znWeOHXywgPbUKDS1irMjUerEuborjRBpcg@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 15 Jun 2023 13:04:29 -0400
Message-ID: <CAFX2JfnhOz+HiOd4vBwBK+5d19Kb8wfBNQhxRZHQoP8S2qiwFw@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000b6d55305fe2e10cf"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--000000000000b6d55305fe2e10cf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 9:01=E2=80=AFAM Anna Schumaker <schumaker.anna@gmai=
l.com> wrote:
>
> On Thu, Jun 15, 2023 at 4:55=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 15/06/2023 10:52, Krzysztof Kozlowski wrote:
> > > On 14/06/2023 22:55, Anna Schumaker wrote:
> > >>>>> Still null ptr (built on 420b2d4 with your patch):
> > >>>>
> > >>>> We're through the merge window and at rc1 now, so I can spend more
> > >>>> time scratching my head over your bug again. We've come up with a
> > >>>> patch (attached) that adds a bunch of printks to show us what the
> > >>>> kernel thinks is going on. Do you mind trying it out and letting u=
s
> > >>>> know what gets printed out? You'll need to make sure
> > >>>> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.
> > >>>
> > >>> The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-2023060=
9.
> > >>
> > >> Can you try the attached patch on top of my 3-patch series from the
> > >> other day, and let me know what gets printed out? It adds a bunch of
> > >> printk()s at strategic points to print out what is going on with the
> > >> xdr scratch buffer since it's suddenly a bad memory address after
> > >> working for a bit on your machine.
> > >>
> > >
> > > Here you have entire log - attached (113 kB, I hope goes past mailing
> > > lists/spam filters).
> >
> > As expected this bounced from the mailing lists, but I hope you got it.
> > If not, let me know.
>
> I did still receive it. Thanks!

Can you swap out yesterday's patch with this patch? I've adjusted what
gets printed out, and added printk()s to xdr_copy_to_scratch().  I'm
starting to think that the xdr scratch buffer is fine, and that it's
the other pointer passed to memcpy() in that function that's the
problem, and the output from this patch will confirm for me.

Thanks,
Anna

>
> Anna
> >
> > Best regards,
> > Krzysztof
> >

--000000000000b6d55305fe2e10cf
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-NFS-Add-debugging-printk-s-to-trace-the-xdr-scrat.patch"
Content-Disposition: attachment; 
	filename="v2-0001-NFS-Add-debugging-printk-s-to-trace-the-xdr-scrat.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lixe2d0k0>
X-Attachment-Id: f_lixe2d0k0

RnJvbSBkNDFmNDMwNDAwN2QyOTU0Zjg1MTNmM2MzZDg0NTAyOGZlZmU3OWVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogV2VkLCAxNCBKdW4gMjAyMyAxNjo0OTozNyAtMDQwMApTdWJqZWN0OiBbUkZD
IHYyXSBORlM6IEFkZCBkZWJ1Z2dpbmcgcHJpbnRrKClzIHRvIHRyYWNlIHRoZSB4ZHItPnNjcmF0
Y2gKIGJ1ZmZlcgoKSSdtIHRyeWluZyB0byBmaWd1cmUgb3V0IGF0IHdoYXQgcG9pbnQgdGhlIHhk
ci0+c2NyYXRjaCBidWZmZXIgaXMKYWxsb2NhdGVkLCBmcmVlZCwgc2V0LCBhbmQgcmVzZXQgdG8g
ZmlndXJlIG91dCB3aHkgUkVBRF9QTFVTIHN1ZGRlbmx5CnRoaW5rcyBpdCdzIGEgTlVMTCBwb2lu
dGVyIHdpdGggbGVuZ3RoIDE2LgoKU2lnbmVkLW9mZi1ieTogQW5uYSBTY2h1bWFrZXIgPEFubmEu
U2NodW1ha2VyQE5ldGFwcC5jb20+Ci0tLQogZnMvbmZzL25mczQyeGRyLmMgICAgICAgICAgfCAy
ICsrCiBmcy9uZnMvcmVhZC5jICAgICAgICAgICAgICB8IDggKysrKysrKy0KIGluY2x1ZGUvbGlu
dXgvc3VucnBjL3hkci5oIHwgMSArCiBuZXQvc3VucnBjL3hkci5jICAgICAgICAgICB8IDQgKysr
KwogNCBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZnMvbmZzL25mczQyeGRyLmMgYi9mcy9uZnMvbmZzNDJ4ZHIuYwppbmRleCAyMGFh
NWU3NDY0OTcuLjZhNGVhZGUyNDAwYiAxMDA2NDQKLS0tIGEvZnMvbmZzL25mczQyeGRyLmMKKysr
IGIvZnMvbmZzL25mczQyeGRyLmMKQEAgLTEzNTEsNiArMTM1MSw4IEBAIHN0YXRpYyBpbnQgbmZz
NF94ZHJfZGVjX3JlYWRfcGx1cyhzdHJ1Y3QgcnBjX3Jxc3QgKnJxc3RwLAogCXN0cnVjdCBjb21w
b3VuZF9oZHIgaGRyOwogCWludCBzdGF0dXM7CiAKKwlwcmludGsoS0VSTl9JTkZPICIlcyhoZHI9
JXB4LCBzY3JhdGNoPSVweClcbiIsIF9fZnVuY19fLAorCQljb250YWluZXJfb2YocmVzLCBzdHJ1
Y3QgbmZzX3BnaW9faGVhZGVyLCByZXMpLCByZXMtPnNjcmF0Y2gpOwogCXhkcl9zZXRfc2NyYXRj
aF9idWZmZXIoeGRyLCByZXMtPnNjcmF0Y2gsIFJFQURfUExVU19TQ1JBVENIX1NJWkUpOwogCiAJ
c3RhdHVzID0gZGVjb2RlX2NvbXBvdW5kX2hkcih4ZHIsICZoZHIpOwpkaWZmIC0tZ2l0IGEvZnMv
bmZzL3JlYWQuYyBiL2ZzL25mcy9yZWFkLmMKaW5kZXggN2RjMjFhNDhlM2U3Li43YjkzMzE2YTUy
ZGUgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9yZWFkLmMKKysrIGIvZnMvbmZzL3JlYWQuYwpAQCAtNDcs
OCArNDcsMTEgQEAgc3RhdGljIHN0cnVjdCBuZnNfcGdpb19oZWFkZXIgKm5mc19yZWFkaGRyX2Fs
bG9jKHZvaWQpCiAKIHN0YXRpYyB2b2lkIG5mc19yZWFkaGRyX2ZyZWUoc3RydWN0IG5mc19wZ2lv
X2hlYWRlciAqcmhkcikKIHsKLQlpZiAocmhkci0+cmVzLnNjcmF0Y2ggIT0gTlVMTCkKKwlpZiAo
cmhkci0+cmVzLnNjcmF0Y2ggIT0gTlVMTCkgeworCQlwcmludGsoS0VSTl9JTkZPICIlcyhoZHI9
JXB4LCBzY3JhdGNoPSVweClcbiIsCisJCQlfX2Z1bmNfXywgcmhkciwgcmhkci0+cmVzLnNjcmF0
Y2gpOwogCQlrZnJlZShyaGRyLT5yZXMuc2NyYXRjaCk7CisJfQogCWttZW1fY2FjaGVfZnJlZShu
ZnNfcmRhdGFfY2FjaGVwLCByaGRyKTsKIH0KIApAQCAtMTE0LDYgKzExNyw5IEBAIGJvb2wgbmZz
X3JlYWRfYWxsb2Nfc2NyYXRjaChzdHJ1Y3QgbmZzX3BnaW9faGVhZGVyICpoZHIsIHNpemVfdCBz
aXplKQogewogCVdBUk5fT04oaGRyLT5yZXMuc2NyYXRjaCAhPSBOVUxMKTsKIAloZHItPnJlcy5z
Y3JhdGNoID0ga21hbGxvYyhzaXplLCBHRlBfS0VSTkVMKTsKKwlwcmludGsoS0VSTl9JTkZPICJc
biIpOworCXByaW50ayhLRVJOX0lORk8gIiVzKGhkcj0lcHgsIHNpemU9JXpkKSA9ICVweFxuIiwK
KwkJX19mdW5jX18sIGhkciwgc2l6ZSwgaGRyLT5yZXMuc2NyYXRjaCk7CiAJcmV0dXJuIGhkci0+
cmVzLnNjcmF0Y2ggIT0gTlVMTDsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKG5mc19yZWFkX2FsbG9j
X3NjcmF0Y2gpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdW5ycGMveGRyLmggYi9pbmNs
dWRlL2xpbnV4L3N1bnJwYy94ZHIuaAppbmRleCBkOTE3NjE4YTMwNTguLjFjOWE1NGU5ZWZhYyAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9zdW5ycGMveGRyLmgKKysrIGIvaW5jbHVkZS9saW51
eC9zdW5ycGMveGRyLmgKQEAgLTI4Niw2ICsyODYsNyBAQCBleHRlcm4gdW5zaWduZWQgaW50IHhk
cl9zdHJlYW1femVybyhzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCB1bnNpZ25lZCBpbnQgb2Zmc2V0
LAogc3RhdGljIGlubGluZSB2b2lkCiB4ZHJfc2V0X3NjcmF0Y2hfYnVmZmVyKHN0cnVjdCB4ZHJf
c3RyZWFtICp4ZHIsIHZvaWQgKmJ1Ziwgc2l6ZV90IGJ1ZmxlbikKIHsKKwlXQVJOX09OKGJ1ZiAh
PSBOVUxMICYmIHhkci0+c2NyYXRjaC5pb3ZfYmFzZSAhPSBOVUxMKTsKIAl4ZHItPnNjcmF0Y2gu
aW92X2Jhc2UgPSBidWY7CiAJeGRyLT5zY3JhdGNoLmlvdl9sZW4gPSBidWZsZW47CiB9CmRpZmYg
LS1naXQgYS9uZXQvc3VucnBjL3hkci5jIGIvbmV0L3N1bnJwYy94ZHIuYwppbmRleCAzOTFiMzM2
ZDk3ZGUuLjM3YzhmN2U1MTlkZCAxMDA2NDQKLS0tIGEvbmV0L3N1bnJwYy94ZHIuYworKysgYi9u
ZXQvc3VucnBjL3hkci5jCkBAIC0xNDQwLDYgKzE0NDAsOCBAQCBzdGF0aWMgX19iZTMyICp4ZHJf
Y29weV90b19zY3JhdGNoKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsIHNpemVfdCBuYnl0ZXMpCiAJ
cCA9IF9feGRyX2lubGluZV9kZWNvZGUoeGRyLCBjcGxlbik7CiAJaWYgKHAgPT0gTlVMTCkKIAkJ
cmV0dXJuIE5VTEw7CisJcHJpbnRrKEtFUk5fSU5GTyAiICAgICVzKCVkKTogbWVtY3B5KCVweCwg
JXB4LCAlemQpXG4iLAorCQlfX2Z1bmNfXywgX19MSU5FX18sIGNwZGVzdCwgcCwgY3BsZW4pOwog
CW1lbWNweShjcGRlc3QsIHAsIGNwbGVuKTsKIAlpZiAoIXhkcl9zZXRfbmV4dF9idWZmZXIoeGRy
KSkKIAkJZ290byBvdXRfb3ZlcmZsb3c7CkBAIC0xNDQ4LDYgKzE0NTAsOCBAQCBzdGF0aWMgX19i
ZTMyICp4ZHJfY29weV90b19zY3JhdGNoKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsIHNpemVfdCBu
Ynl0ZXMpCiAJcCA9IF9feGRyX2lubGluZV9kZWNvZGUoeGRyLCBuYnl0ZXMpOwogCWlmIChwID09
IE5VTEwpCiAJCXJldHVybiBOVUxMOworCXByaW50ayhLRVJOX0lORk8gIiAgICAlcyglZCk6IG1l
bWNweSglcHgsICVweCwgJXpkKVxuIiwKKwkJX19mdW5jX18sIF9fTElORV9fLCBjcGRlc3QsIHAs
IG5ieXRlcyk7CiAJbWVtY3B5KGNwZGVzdCwgcCwgbmJ5dGVzKTsKIAlyZXR1cm4geGRyLT5zY3Jh
dGNoLmlvdl9iYXNlOwogb3V0X292ZXJmbG93OgotLSAKMi40MS4wCgo=
--000000000000b6d55305fe2e10cf--
