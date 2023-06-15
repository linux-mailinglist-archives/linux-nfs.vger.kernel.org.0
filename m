Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1E73206B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjFOTjH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 15:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjFOTjH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 15:39:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DC32954;
        Thu, 15 Jun 2023 12:39:05 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f9b5ec058aso32222801cf.0;
        Thu, 15 Jun 2023 12:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686857944; x=1689449944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WfBh2k1U3eI20yWs4X+VVtdCsw4D6kT59ardJpauNR0=;
        b=PW8OyOfIZg0dtf7Nz7BMRrFQvNMQTaj34I05sPjexhYeILpAd2HUA/l1Dsu11qYrVn
         xYzBdQRH89/YKi4PHcUbuVTYp+SeLojgAV16Dhwz5JX+7zrJdp02C3qlA/QdhtagS4ux
         pKSZGVTJAmMuiCjMU8usKe5Q785j2sJnd40QunidYEAWFQouXvzUmvE0TuunVHGHkZqq
         ctp2ZTDkgIe9kJqwhbaD1aAMkGeo3/oYX3uHE65/JlIML7VLOOTyRQqkFd22+6f1kcJX
         JH9+XhaOQuZ8BRbPXX7Y/l8oG0IX/PkVFgYErMDe0cP1q7SqKpf6DMaOUWAtZSRfUbba
         S7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857944; x=1689449944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfBh2k1U3eI20yWs4X+VVtdCsw4D6kT59ardJpauNR0=;
        b=e9EeS9F1Kx2i27f1AiLLycoMrUo1CKyeEDhHTZZlXRwD+Utv/83CrQ3RBRxccAmh9O
         MpFI+IW8h4pb8s6plkjHd6REQMPyX3VehF7HvKSBnG7vfa/JCHLMIx41j5V1nR2husBY
         s0V3oyLGFloqHD/Qk0OHIbkBZMy5HapaMgrnSiORcv0uPha3Zwri6IgXINMu/69wQCay
         dt/V5ZWBirMClhPTf7ZGEFLe2PLrJu3wCCYzjCC8SQ1PAYyNeMN153v+bUjaVw7DyHJm
         SUhWphjq/9VmJzXUwAvOayrCzahY0Dhvzc8cNGt4+YqSK9spBiPCHJ2uMRsTdoa+GWcH
         Oc1w==
X-Gm-Message-State: AC+VfDxoYzS7LYyA59HdY/6gnCXk273yfHBQVMddTm6REk/JYqGoGU/b
        J+gnQCLziamdnGfCsHligRbENCHIQa1o9m8oqKQ=
X-Google-Smtp-Source: ACHHUZ4qcrFaf+VzzNnwzgS2In+sejHPpk/WOClZZIo88td5xQvdSSo/hbGRwfKRQMnElOAb1Yl7XUgy1Mq/eOOIu+M=
X-Received: by 2002:ac8:5f86:0:b0:3f3:91bd:a459 with SMTP id
 j6-20020ac85f86000000b003f391bda459mr110572qta.34.1686857944591; Thu, 15 Jun
 2023 12:39:04 -0700 (PDT)
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
 <CAFX2JfnhOz+HiOd4vBwBK+5d19Kb8wfBNQhxRZHQoP8S2qiwFw@mail.gmail.com> <CAFX2Jf=5WV=dY9J4-7tp5NB85fDOkwiv8rxQqHziqG+ED1cUJw@mail.gmail.com>
In-Reply-To: <CAFX2Jf=5WV=dY9J4-7tp5NB85fDOkwiv8rxQqHziqG+ED1cUJw@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 15 Jun 2023 15:38:48 -0400
Message-ID: <CAFX2Jf=TxojviigtdQ=F_8FcHFFC4RNdfkoS=157jnXQCQSq5g@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="00000000000093278305fe3038d4"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--00000000000093278305fe3038d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 1:16=E2=80=AFPM Anna Schumaker <schumaker.anna@gmai=
l.com> wrote:
>
> On Thu, Jun 15, 2023 at 1:04=E2=80=AFPM Anna Schumaker <schumaker.anna@gm=
ail.com> wrote:
> >
> > On Thu, Jun 15, 2023 at 9:01=E2=80=AFAM Anna Schumaker <schumaker.anna@=
gmail.com> wrote:
> > >
> > > On Thu, Jun 15, 2023 at 4:55=E2=80=AFAM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >
> > > > On 15/06/2023 10:52, Krzysztof Kozlowski wrote:
> > > > > On 14/06/2023 22:55, Anna Schumaker wrote:
> > > > >>>>> Still null ptr (built on 420b2d4 with your patch):
> > > > >>>>
> > > > >>>> We're through the merge window and at rc1 now, so I can spend =
more
> > > > >>>> time scratching my head over your bug again. We've come up wit=
h a
> > > > >>>> patch (attached) that adds a bunch of printks to show us what =
the
> > > > >>>> kernel thinks is going on. Do you mind trying it out and letti=
ng us
> > > > >>>> know what gets printed out? You'll need to make sure
> > > > >>>> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel=
.
> > > > >>>
> > > > >>> The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-202=
30609.
> > > > >>
> > > > >> Can you try the attached patch on top of my 3-patch series from =
the
> > > > >> other day, and let me know what gets printed out? It adds a bunc=
h of
> > > > >> printk()s at strategic points to print out what is going on with=
 the
> > > > >> xdr scratch buffer since it's suddenly a bad memory address afte=
r
> > > > >> working for a bit on your machine.
> > > > >>
> > > > >
> > > > > Here you have entire log - attached (113 kB, I hope goes past mai=
ling
> > > > > lists/spam filters).
> > > >
> > > > As expected this bounced from the mailing lists, but I hope you got=
 it.
> > > > If not, let me know.
> > >
> > > I did still receive it. Thanks!
> >
> > Can you swap out yesterday's patch with this patch? I've adjusted what
> > gets printed out, and added printk()s to xdr_copy_to_scratch().  I'm
> > starting to think that the xdr scratch buffer is fine, and that it's
> > the other pointer passed to memcpy() in that function that's the
> > problem, and the output from this patch will confirm for me.
>
> Oh, and can you add this one on top of the v2 patch as well?

Sorry about the noise today. Can you use this patch instead of the two
I attached earlier? I cleaned up the output and cut down on extra
output..

>
> Thanks,
> Anna
>
> >
> > Thanks,
> > Anna
> >
> > >
> > > Anna
> > > >
> > > > Best regards,
> > > > Krzysztof
> > > >

--00000000000093278305fe3038d4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-NFS-Add-debugging-printk-s-to-trace-the-READ_PLUS-xd.patch"
Content-Disposition: attachment; 
	filename="0001-NFS-Add-debugging-printk-s-to-trace-the-READ_PLUS-xd.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lixjmbht0>
X-Attachment-Id: f_lixjmbht0

RnJvbSAyMmY5NjEwN2U3ZmU1ODc0ZDRmNzkxNTI5NDU3NmU5MzQyMmQ5ZmJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogV2VkLCAxNCBKdW4gMjAyMyAxNjo0OTozNyAtMDQwMApTdWJqZWN0OiBbUEFU
Q0hdIE5GUzogQWRkIGRlYnVnZ2luZyBwcmludGsoKXMgdG8gdHJhY2UgdGhlIFJFQURfUExVUyB4
ZHIKIGRlY29kaW5nCgpJbiBhZGRpdGlvbiB0byB0cmFjaW5nIHRoZSBsaWZldGltZSBvZiB0aGUg
eGRyLT5zY3JhdGNoIGJ1ZmZlciwgaXQgYWRkcwppbmZvcm1hdGlvbiBhYm91dCB0aGUgeGRyIHN0
cmVhbSBzdWNoIGFzIHJlbWFpbmluZyBieXRlcywgY3VycmVudCBkZWNvZGUKb2Zmc2V0LCBhbmQg
c29tZSBvdGhlciAoaG9wZWZ1bGx5KSBoZWxwZnVsIHN0dWZmLgoKU2lnbmVkLW9mZi1ieTogQW5u
YSBTY2h1bWFrZXIgPEFubmEuU2NodW1ha2VyQE5ldGFwcC5jb20+Ci0tLQogZnMvbmZzL25mczQy
eGRyLmMgICAgICAgICAgfCAxOCArKysrKysrKysrKysrKysrLS0KIGZzL25mcy9yZWFkLmMgICAg
ICAgICAgICAgIHwgIDggKysrKysrKy0KIGluY2x1ZGUvbGludXgvc3VucnBjL3hkci5oIHwgIDEg
KwogbmV0L3N1bnJwYy94ZHIuYyAgICAgICAgICAgfCAxNyArKysrKysrKysrKysrLS0tLQogNCBm
aWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2ZzL25mcy9uZnM0Mnhkci5jIGIvZnMvbmZzL25mczQyeGRyLmMKaW5kZXggMjBhYTVlNzQ2
NDk3Li44Nzg2YTI3ZmU3MzEgMTAwNjQ0Ci0tLSBhL2ZzL25mcy9uZnM0Mnhkci5jCisrKyBiL2Zz
L25mcy9uZnM0Mnhkci5jCkBAIC03ODksNiArNzg5LDExIEBAIHN0YXRpYyB2b2lkIG5mczRfeGRy
X2VuY19yZWFkX3BsdXMoc3RydWN0IHJwY19ycXN0ICpyZXEsCiAKIAlycGNfcHJlcGFyZV9yZXBs
eV9wYWdlcyhyZXEsIGFyZ3MtPnBhZ2VzLCBhcmdzLT5wZ2Jhc2UsIGFyZ3MtPmNvdW50LAogCQkJ
CWhkci5yZXBsZW4gLSBSRUFEX1BMVVNfU0VHTUVOVF9TSVpFX0RJRkYpOworCXByaW50ayhLRVJO
X0lORk8gIiAgJXMoaGRyPSVweCwgZGVjb2RlX3JlYWRfcGx1c19tYXhzej0lZClcbiIKKwkJIiAg
ICB4ZHItPmJ1ZiA9IHtoZWFkLT5pb3ZfbGVuPSV6ZCwgcGFnZV9iYXNlPSV1LCBwYWdlX2xlbj0l
dX1cbiIsCisJCV9fZnVuY19fLCBjb250YWluZXJfb2YoYXJncywgc3RydWN0IG5mc19wZ2lvX2hl
YWRlciwgYXJncyksCisJCWRlY29kZV9yZWFkX3BsdXNfbWF4c3osIHhkci0+YnVmLT5oZWFkLT5p
b3ZfbGVuLAorCQl4ZHItPmJ1Zi0+cGFnZV9iYXNlLCB4ZHItPmJ1Zi0+cGFnZV9sZW4pOwogCWVu
Y29kZV9ub3BzKCZoZHIpOwogfQogCkBAIC0xMDYxLDEwICsxMDY2LDEyIEBAIHN0YXRpYyBpbmxp
bmUgdWludDY0X3QgcmVhZF9wbHVzX3NlZ21lbnRfbGVuZ3RoKHN0cnVjdCByZWFkX3BsdXNfc2Vn
bWVudCAqc2VnKQogfQogCiBzdGF0aWMgaW50IGRlY29kZV9yZWFkX3BsdXNfc2VnbWVudChzdHJ1
Y3QgeGRyX3N0cmVhbSAqeGRyLAotCQkJCSAgICBzdHJ1Y3QgcmVhZF9wbHVzX3NlZ21lbnQgKnNl
ZykKKwkJCQkgICAgc3RydWN0IHJlYWRfcGx1c19zZWdtZW50ICpzZWcsCisJCQkJICAgIHVuc2ln
bmVkIGludCBuKQogewogCV9fYmUzMiAqcDsKIAorCXByaW50ayhLRVJOX0lORk8gIiAgICAlcyhu
PSV1KVxuIiwgX19mdW5jX18sIG4pOwogCXAgPSB4ZHJfaW5saW5lX2RlY29kZSh4ZHIsIDQpOwog
CWlmICghcCkKIAkJcmV0dXJuIC1FSU87CkBAIC0xMDc5LDYgKzEwODYsOCBAQCBzdGF0aWMgaW50
IGRlY29kZV9yZWFkX3BsdXNfc2VnbWVudChzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLAogCQlzdHJ1
Y3QgeGRyX2J1ZiBidWY7CiAJCXVpbnQzMl90IGxlbiA9IGJlMzJfdG9fY3B1cChwKTsKIAorCQlw
cmludGsoS0VSTl9JTkZPICIgICAgICAlcyhuPSV1KTogREFUQSB7b2Zmc2V0PSVsbGQsIGxlbmd0
aD0ldX1cbiIsCisJCQlfX2Z1bmNfXywgbiwgc2VnLT5vZmZzZXQsIGxlbik7CiAJCXNlZy0+ZGF0
YS5sZW5ndGggPSBsZW47CiAJCXNlZy0+ZGF0YS5mcm9tID0geGRyX3N0cmVhbV9wb3MoeGRyKTsK
IApAQCAtMTA4Niw4ICsxMDk1LDExIEBAIHN0YXRpYyBpbnQgZGVjb2RlX3JlYWRfcGx1c19zZWdt
ZW50KHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsCiAJCQlyZXR1cm4gLUVJTzsKIAl9IGVsc2UgaWYg
KHNlZy0+dHlwZSA9PSBORlM0X0NPTlRFTlRfSE9MRSkgewogCQl4ZHJfZGVjb2RlX2h5cGVyKHAs
ICZzZWctPmhvbGUubGVuZ3RoKTsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiICAgICAgJXMobj0ldSk6
IEhPTEUge29mZnNldD0lbGxkLCBsZW5ndGg9JWxsdX1cbiIsCisJCQlfX2Z1bmNfXywgbiwgc2Vn
LT5vZmZzZXQsIHNlZy0+aG9sZS5sZW5ndGgpOwogCX0gZWxzZQogCQlyZXR1cm4gLUVJTlZBTDsK
KwlwcmludGsoS0VSTl9JTkZPICIgICAgICAlcyhuPSV1KTogeGRyLT5ud29yZHMgPSAlZCIsIF9f
ZnVuY19fLCBuLCB4ZHItPm53b3Jkcyk7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTExNDksNyArMTE2
MSw3IEBAIHN0YXRpYyBpbnQgZGVjb2RlX3JlYWRfcGx1cyhzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRy
LCBzdHJ1Y3QgbmZzX3BnaW9fcmVzICpyZXMpCiAJCXJldHVybiAtRU5PTUVNOwogCiAJZm9yIChp
ID0gMDsgaSA8IHNlZ21lbnRzOyBpKyspIHsKLQkJc3RhdHVzID0gZGVjb2RlX3JlYWRfcGx1c19z
ZWdtZW50KHhkciwgJnNlZ3NbaV0pOworCQlzdGF0dXMgPSBkZWNvZGVfcmVhZF9wbHVzX3NlZ21l
bnQoeGRyLCAmc2Vnc1tpXSwgaSk7CiAJCWlmIChzdGF0dXMgPCAwKQogCQkJZ290byBvdXQ7CiAJ
fQpAQCAtMTM1MSw2ICsxMzYzLDggQEAgc3RhdGljIGludCBuZnM0X3hkcl9kZWNfcmVhZF9wbHVz
KHN0cnVjdCBycGNfcnFzdCAqcnFzdHAsCiAJc3RydWN0IGNvbXBvdW5kX2hkciBoZHI7CiAJaW50
IHN0YXR1czsKIAorCXByaW50ayhLRVJOX0lORk8gIiAgJXMoaGRyPSVweCwgc2NyYXRjaD0lcHgp
XG4iLCBfX2Z1bmNfXywKKwkJY29udGFpbmVyX29mKHJlcywgc3RydWN0IG5mc19wZ2lvX2hlYWRl
ciwgcmVzKSwgcmVzLT5zY3JhdGNoKTsKIAl4ZHJfc2V0X3NjcmF0Y2hfYnVmZmVyKHhkciwgcmVz
LT5zY3JhdGNoLCBSRUFEX1BMVVNfU0NSQVRDSF9TSVpFKTsKIAogCXN0YXR1cyA9IGRlY29kZV9j
b21wb3VuZF9oZHIoeGRyLCAmaGRyKTsKZGlmZiAtLWdpdCBhL2ZzL25mcy9yZWFkLmMgYi9mcy9u
ZnMvcmVhZC5jCmluZGV4IDdkYzIxYTQ4ZTNlNy4uMGQ4Yzg2YmU0MjQyIDEwMDY0NAotLS0gYS9m
cy9uZnMvcmVhZC5jCisrKyBiL2ZzL25mcy9yZWFkLmMKQEAgLTQ3LDggKzQ3LDExIEBAIHN0YXRp
YyBzdHJ1Y3QgbmZzX3BnaW9faGVhZGVyICpuZnNfcmVhZGhkcl9hbGxvYyh2b2lkKQogCiBzdGF0
aWMgdm9pZCBuZnNfcmVhZGhkcl9mcmVlKHN0cnVjdCBuZnNfcGdpb19oZWFkZXIgKnJoZHIpCiB7
Ci0JaWYgKHJoZHItPnJlcy5zY3JhdGNoICE9IE5VTEwpCisJaWYgKHJoZHItPnJlcy5zY3JhdGNo
ICE9IE5VTEwpIHsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiICAlcyhoZHI9JXB4LCBzY3JhdGNoPSVw
eClcbiIsCisJCQlfX2Z1bmNfXywgcmhkciwgcmhkci0+cmVzLnNjcmF0Y2gpOwogCQlrZnJlZShy
aGRyLT5yZXMuc2NyYXRjaCk7CisJfQogCWttZW1fY2FjaGVfZnJlZShuZnNfcmRhdGFfY2FjaGVw
LCByaGRyKTsKIH0KIApAQCAtMTE0LDYgKzExNyw5IEBAIGJvb2wgbmZzX3JlYWRfYWxsb2Nfc2Ny
YXRjaChzdHJ1Y3QgbmZzX3BnaW9faGVhZGVyICpoZHIsIHNpemVfdCBzaXplKQogewogCVdBUk5f
T04oaGRyLT5yZXMuc2NyYXRjaCAhPSBOVUxMKTsKIAloZHItPnJlcy5zY3JhdGNoID0ga21hbGxv
YyhzaXplLCBHRlBfS0VSTkVMKTsKKwlwcmludGsoS0VSTl9JTkZPICJcbiIpOworCXByaW50ayhL
RVJOX0lORk8gIiVzKGhkcj0lcHgsIHNpemU9JXpkKSA9ICVweFxuIiwKKwkJX19mdW5jX18sIGhk
ciwgc2l6ZSwgaGRyLT5yZXMuc2NyYXRjaCk7CiAJcmV0dXJuIGhkci0+cmVzLnNjcmF0Y2ggIT0g
TlVMTDsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKG5mc19yZWFkX2FsbG9jX3NjcmF0Y2gpOwpkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdW5ycGMveGRyLmggYi9pbmNsdWRlL2xpbnV4L3N1bnJw
Yy94ZHIuaAppbmRleCBkOTE3NjE4YTMwNTguLjFjOWE1NGU5ZWZhYyAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9saW51eC9zdW5ycGMveGRyLmgKKysrIGIvaW5jbHVkZS9saW51eC9zdW5ycGMveGRyLmgK
QEAgLTI4Niw2ICsyODYsNyBAQCBleHRlcm4gdW5zaWduZWQgaW50IHhkcl9zdHJlYW1femVybyhz
dHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAogc3RhdGljIGlubGlu
ZSB2b2lkCiB4ZHJfc2V0X3NjcmF0Y2hfYnVmZmVyKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsIHZv
aWQgKmJ1Ziwgc2l6ZV90IGJ1ZmxlbikKIHsKKwlXQVJOX09OKGJ1ZiAhPSBOVUxMICYmIHhkci0+
c2NyYXRjaC5pb3ZfYmFzZSAhPSBOVUxMKTsKIAl4ZHItPnNjcmF0Y2guaW92X2Jhc2UgPSBidWY7
CiAJeGRyLT5zY3JhdGNoLmlvdl9sZW4gPSBidWZsZW47CiB9CmRpZmYgLS1naXQgYS9uZXQvc3Vu
cnBjL3hkci5jIGIvbmV0L3N1bnJwYy94ZHIuYwppbmRleCAzOTFiMzM2ZDk3ZGUuLmZmODQwNmU2
NjhiMiAxMDA2NDQKLS0tIGEvbmV0L3N1bnJwYy94ZHIuYworKysgYi9uZXQvc3VucnBjL3hkci5j
CkBAIC0xNDE2LDEyICsxNDE2LDE3IEBAIHZvaWQgeGRyX2luaXRfZGVjb2RlX3BhZ2VzKHN0cnVj
dCB4ZHJfc3RyZWFtICp4ZHIsIHN0cnVjdCB4ZHJfYnVmICpidWYsCiB9CiBFWFBPUlRfU1lNQk9M
X0dQTCh4ZHJfaW5pdF9kZWNvZGVfcGFnZXMpOwogCi1zdGF0aWMgX19iZTMyICogX194ZHJfaW5s
aW5lX2RlY29kZShzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCBzaXplX3QgbmJ5dGVzKQorc3RhdGlj
IF9fYmUzMiAqIF9feGRyX2lubGluZV9kZWNvZGUoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc2l6
ZV90IG5ieXRlcywKKwkJCQkgICAgYm9vbCBkZWJ1Z19wcmludCkKIHsKIAl1bnNpZ25lZCBpbnQg
bndvcmRzID0gWERSX1FVQURMRU4obmJ5dGVzKTsKIAlfX2JlMzIgKnAgPSB4ZHItPnA7CiAJX19i
ZTMyICpxID0gcCArIG53b3JkczsKIAorCWlmICh1bmxpa2VseShkZWJ1Z19wcmludCkpCisJCXBy
aW50ayhLRVJOX0lORk8gIiAgICAgICAgJXMobmJ5dGVzPSV6ZCwgbndvcmRzPSVkLCB4ZHIsIHE9
JXB4KVxuIgorCQkJIiAgICAgICAgICB4ZHIgPSB7bndvcmRzPSV1LCBwPSVweCwgZW5kPSVweH1c
biIsCisJIAkJX19mdW5jX18sIG5ieXRlcywgbndvcmRzLCBxLCB4ZHItPm53b3JkcywgeGRyLT5w
LCB4ZHItPmVuZCk7CiAJaWYgKHVubGlrZWx5KG53b3JkcyA+IHhkci0+bndvcmRzIHx8IHEgPiB4
ZHItPmVuZCB8fCBxIDwgcCkpCiAJCXJldHVybiBOVUxMOwogCXhkci0+cCA9IHE7CkBAIC0xNDM3
LDE3ICsxNDQyLDIxIEBAIHN0YXRpYyBfX2JlMzIgKnhkcl9jb3B5X3RvX3NjcmF0Y2goc3RydWN0
IHhkcl9zdHJlYW0gKnhkciwgc2l6ZV90IG5ieXRlcykKIAogCWlmIChuYnl0ZXMgPiB4ZHItPnNj
cmF0Y2guaW92X2xlbikKIAkJZ290byBvdXRfb3ZlcmZsb3c7Ci0JcCA9IF9feGRyX2lubGluZV9k
ZWNvZGUoeGRyLCBjcGxlbik7CisJcCA9IF9feGRyX2lubGluZV9kZWNvZGUoeGRyLCBjcGxlbiwg
dHJ1ZSk7CiAJaWYgKHAgPT0gTlVMTCkKIAkJcmV0dXJuIE5VTEw7CisJcHJpbnRrKEtFUk5fSU5G
TyAiICAgICAgJXMoJWQpOiBtZW1jcHkoJXB4LCAlcHgsICV6ZClcbiIsCisJCV9fZnVuY19fLCBf
X0xJTkVfXywgY3BkZXN0LCBwLCBjcGxlbik7CiAJbWVtY3B5KGNwZGVzdCwgcCwgY3BsZW4pOwog
CWlmICgheGRyX3NldF9uZXh0X2J1ZmZlcih4ZHIpKQogCQlnb3RvIG91dF9vdmVyZmxvdzsKIAlj
cGRlc3QgKz0gY3BsZW47CiAJbmJ5dGVzIC09IGNwbGVuOwotCXAgPSBfX3hkcl9pbmxpbmVfZGVj
b2RlKHhkciwgbmJ5dGVzKTsKKwlwID0gX194ZHJfaW5saW5lX2RlY29kZSh4ZHIsIG5ieXRlcywg
dHJ1ZSk7CiAJaWYgKHAgPT0gTlVMTCkKIAkJcmV0dXJuIE5VTEw7CisJcHJpbnRrKEtFUk5fSU5G
TyAiICAgICAgJXMoJWQpOiBtZW1jcHkoJXB4LCAlcHgsICV6ZClcbiIsCisJCV9fZnVuY19fLCBf
X0xJTkVfXywgY3BkZXN0LCBwLCBuYnl0ZXMpOwogCW1lbWNweShjcGRlc3QsIHAsIG5ieXRlcyk7
CiAJcmV0dXJuIHhkci0+c2NyYXRjaC5pb3ZfYmFzZTsKIG91dF9vdmVyZmxvdzoKQEAgLTE0NzMs
NyArMTQ4Miw3IEBAIF9fYmUzMiAqIHhkcl9pbmxpbmVfZGVjb2RlKHN0cnVjdCB4ZHJfc3RyZWFt
ICp4ZHIsIHNpemVfdCBuYnl0ZXMpCiAJCXJldHVybiB4ZHItPnA7CiAJaWYgKHhkci0+cCA9PSB4
ZHItPmVuZCAmJiAheGRyX3NldF9uZXh0X2J1ZmZlcih4ZHIpKQogCQlnb3RvIG91dF9vdmVyZmxv
dzsKLQlwID0gX194ZHJfaW5saW5lX2RlY29kZSh4ZHIsIG5ieXRlcyk7CisJcCA9IF9feGRyX2lu
bGluZV9kZWNvZGUoeGRyLCBuYnl0ZXMsIGZhbHNlKTsKIAlpZiAocCAhPSBOVUxMKQogCQlyZXR1
cm4gcDsKIAlyZXR1cm4geGRyX2NvcHlfdG9fc2NyYXRjaCh4ZHIsIG5ieXRlcyk7Ci0tIAoyLjQx
LjAKCg==
--00000000000093278305fe3038d4--
