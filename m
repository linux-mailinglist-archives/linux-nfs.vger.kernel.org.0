Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F54731ECF
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 19:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbjFORQ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 13:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbjFORQZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 13:16:25 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D25123;
        Thu, 15 Jun 2023 10:16:24 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f9e5c011cfso30957531cf.1;
        Thu, 15 Jun 2023 10:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686849383; x=1689441383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WUd2exhAx/+wi7FfcZIbEVnkCCAxeJpzDyEMaj0jvN0=;
        b=SCa9L9CuVUcFNRpcIDVH5q9PEZU8NBnvpEaY10cs+LGEHkqM693VAfkL6xrDayL9w8
         wcpIbMYl/GVC9Iij/rdoPmxivqTVx6xMxmIXOwxjN2ds1M5ClcoIUJkDuu3DPZLNJ3+b
         3/MuY0Ass7mVueRstLyx2NsDwxot00KPJMzgIc0+neWpIBYi/MhpR+7gU5Z51/qm5aMw
         ioUgLQ7pbS9W3h0+sbUBt+xzKOwYo3FSIOqEf5iu5RK/JQehA1ubLBfF9VSRF4kGlc9U
         Z42D808Re0XTdZ9IKgYSIoDsdCRrAH54hGDF3qgsXn1gNiWE935mbaGDe4TXppoMmQws
         YfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686849383; x=1689441383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUd2exhAx/+wi7FfcZIbEVnkCCAxeJpzDyEMaj0jvN0=;
        b=YRuj8B3KVUiwP+kOTqrhpBi4uRdizM3uxZjtzrjmqAwGrKu2koQj62N+sTUbhQazHL
         qGF4mh4OLpXMZCu3/H6ilTl9Ep0cwXIpYSKy0BIkObcKqB5ssvFxylD/6XoO3M0vu0pE
         Ftev69tLl/Iunx1i/mFAKOYLlt1RuDuXdTSqxVfLUgvWdc8AtNkq2SECCAvWPg82XmCH
         vB7gYVTsbOEcU+teoTgstq43mxahubAE9FBAcaqxDBbuYAm28TyuYu57KFbnny8vqY14
         VLuE3s9fLc81vYjCcMq5GrVBqUHjopNVe4tvlF4icDze0BAJu0yj57Uw4kwhRJEB9bKV
         BZmg==
X-Gm-Message-State: AC+VfDzzgDpgw/MoITMzBmexRUdkokJRNkSTPaqdK09LRx5E3XuwbJAV
        EoW257GW+Jab/VxWIchSzihps2veKvm4Rl1rOUU=
X-Google-Smtp-Source: ACHHUZ5PoiXFEQy0EpxDut3ktRnO1ih1bSuBv033xlA+DBMLA7k58MXSaHm28MKX5GUa9D+3tjV6soMBGgEbeevBOCw=
X-Received: by 2002:ac8:5a8b:0:b0:3f9:d1a3:8bd9 with SMTP id
 c11-20020ac85a8b000000b003f9d1a38bd9mr7212280qtc.9.1686849383060; Thu, 15 Jun
 2023 10:16:23 -0700 (PDT)
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
 <CAFX2JfmvMZ7DzD9znWeOHXywgPbUKDS1irMjUerEuborjRBpcg@mail.gmail.com> <CAFX2JfnhOz+HiOd4vBwBK+5d19Kb8wfBNQhxRZHQoP8S2qiwFw@mail.gmail.com>
In-Reply-To: <CAFX2JfnhOz+HiOd4vBwBK+5d19Kb8wfBNQhxRZHQoP8S2qiwFw@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 15 Jun 2023 13:16:07 -0400
Message-ID: <CAFX2Jf=5WV=dY9J4-7tp5NB85fDOkwiv8rxQqHziqG+ED1cUJw@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000448d9105fe2e3a42"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--000000000000448d9105fe2e3a42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 1:04=E2=80=AFPM Anna Schumaker <schumaker.anna@gmai=
l.com> wrote:
>
> On Thu, Jun 15, 2023 at 9:01=E2=80=AFAM Anna Schumaker <schumaker.anna@gm=
ail.com> wrote:
> >
> > On Thu, Jun 15, 2023 at 4:55=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 15/06/2023 10:52, Krzysztof Kozlowski wrote:
> > > > On 14/06/2023 22:55, Anna Schumaker wrote:
> > > >>>>> Still null ptr (built on 420b2d4 with your patch):
> > > >>>>
> > > >>>> We're through the merge window and at rc1 now, so I can spend mo=
re
> > > >>>> time scratching my head over your bug again. We've come up with =
a
> > > >>>> patch (attached) that adds a bunch of printks to show us what th=
e
> > > >>>> kernel thinks is going on. Do you mind trying it out and letting=
 us
> > > >>>> know what gets printed out? You'll need to make sure
> > > >>>> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.
> > > >>>
> > > >>> The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-20230=
609.
> > > >>
> > > >> Can you try the attached patch on top of my 3-patch series from th=
e
> > > >> other day, and let me know what gets printed out? It adds a bunch =
of
> > > >> printk()s at strategic points to print out what is going on with t=
he
> > > >> xdr scratch buffer since it's suddenly a bad memory address after
> > > >> working for a bit on your machine.
> > > >>
> > > >
> > > > Here you have entire log - attached (113 kB, I hope goes past maili=
ng
> > > > lists/spam filters).
> > >
> > > As expected this bounced from the mailing lists, but I hope you got i=
t.
> > > If not, let me know.
> >
> > I did still receive it. Thanks!
>
> Can you swap out yesterday's patch with this patch? I've adjusted what
> gets printed out, and added printk()s to xdr_copy_to_scratch().  I'm
> starting to think that the xdr scratch buffer is fine, and that it's
> the other pointer passed to memcpy() in that function that's the
> problem, and the output from this patch will confirm for me.

Oh, and can you add this one on top of the v2 patch as well?

Thanks,
Anna

>
> Thanks,
> Anna
>
> >
> > Anna
> > >
> > > Best regards,
> > > Krzysztof
> > >

--000000000000448d9105fe2e3a42
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-NFS-Olga-s-prink-patch.patch"
Content-Disposition: attachment; 
	filename="0001-NFS-Olga-s-prink-patch.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lixejz4q0>
X-Attachment-Id: f_lixejz4q0

RnJvbSA4MjUyMTM4Mzc2YTJiYTNlNTM4MDdmYWZhYjljMzgyYjZhY2Y1MDNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogVGh1LCAxNSBKdW4gMjAyMyAxMzoxMzo0NyAtMDQwMApTdWJqZWN0OiBbUEFU
Q0hdIE5GUzogT2xnYSdzIHByaW5rKCkgcGF0Y2gKCkFkZHMgYSBoYW5kZnVsIG9mIHByaW50aygp
IHN0YXRlbWVudHMgdG8gcHJpbnQgb3V0IHRoZSBzdGF0ZSBvZiB0aGUgeGRyCnN0cmVhbS4KLS0t
CiBmcy9uZnMvbmZzNDJ4ZHIuYyB8IDUgKysrKysKIG5ldC9zdW5ycGMvY2xudC5jIHwgMSArCiBu
ZXQvc3VucnBjL3hkci5jICB8IDIgKysKIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvZnMvbmZzL25mczQyeGRyLmMgYi9mcy9uZnMvbmZzNDJ4ZHIuYwppbmRl
eCA2YTRlYWRlMjQwMGIuLjIyNjI4MDU3ZDA4MCAxMDA2NDQKLS0tIGEvZnMvbmZzL25mczQyeGRy
LmMKKysrIGIvZnMvbmZzL25mczQyeGRyLmMKQEAgLTM1Miw2ICszNTIsNyBAQCBzdGF0aWMgdm9p
ZCBlbmNvZGVfcmVhZF9wbHVzKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsCiAJCQkgICAgIGNvbnN0
IHN0cnVjdCBuZnNfcGdpb19hcmdzICphcmdzLAogCQkJICAgICBzdHJ1Y3QgY29tcG91bmRfaGRy
ICpoZHIpCiB7CisJcHJpbnRrKCJBR0xPOiAlcyBzZXR0aW5nIHVwIGRlY29kZSBidWZmZXIgc2l6
ZT0lZFxuIiwgX19mdW5jX18sIGRlY29kZV9yZWFkX3BsdXNfbWF4c3opOwogCWVuY29kZV9vcF9o
ZHIoeGRyLCBPUF9SRUFEX1BMVVMsIGRlY29kZV9yZWFkX3BsdXNfbWF4c3osIGhkcik7CiAJZW5j
b2RlX25mczRfc3RhdGVpZCh4ZHIsICZhcmdzLT5zdGF0ZWlkKTsKIAllbmNvZGVfdWludDY0KHhk
ciwgYXJncy0+b2Zmc2V0KTsKQEAgLTEwNjUsNiArMTA2Niw3IEBAIHN0YXRpYyBpbnQgZGVjb2Rl
X3JlYWRfcGx1c19zZWdtZW50KHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsCiB7CiAJX19iZTMyICpw
OwogCisJcHJpbnRrKCJBR0xPOiAlcyBzdGFydCBzZWc9JXBcbiIsIF9fZnVuY19fLCBzZWcpOwog
CXAgPSB4ZHJfaW5saW5lX2RlY29kZSh4ZHIsIDQpOwogCWlmICghcCkKIAkJcmV0dXJuIC1FSU87
CkBAIC0xMDg4LDYgKzEwOTAsNyBAQCBzdGF0aWMgaW50IGRlY29kZV9yZWFkX3BsdXNfc2VnbWVu
dChzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLAogCQl4ZHJfZGVjb2RlX2h5cGVyKHAsICZzZWctPmhv
bGUubGVuZ3RoKTsKIAl9IGVsc2UKIAkJcmV0dXJuIC1FSU5WQUw7CisJcHJpbnRrKCJBR0xPOiAl
cyBlbmQgc2VnPSVwIHhkci0+bndvcmRzPSVkXG4iLCBfX2Z1bmNfXywgc2VnLCB4ZHItPm53b3Jk
cyk7CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTExMzAsNiArMTEzMyw3IEBAIHN0YXRpYyBpbnQgZGVj
b2RlX3JlYWRfcGx1cyhzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCBzdHJ1Y3QgbmZzX3BnaW9fcmVz
ICpyZXMpCiAJaW50IHN0YXR1cywgaTsKIAlfX2JlMzIgKnA7CiAKKwlwcmludGsoIkFHTE86ICVz
IFNUQVJUXG4iLCBfX2Z1bmNfXyk7CiAJc3RhdHVzID0gZGVjb2RlX29wX2hkcih4ZHIsIE9QX1JF
QURfUExVUyk7CiAJaWYgKHN0YXR1cykKIAkJcmV0dXJuIHN0YXR1czsKQEAgLTExNjEsNiArMTE2
NSw3IEBAIHN0YXRpYyBpbnQgZGVjb2RlX3JlYWRfcGx1cyhzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRy
LCBzdHJ1Y3QgbmZzX3BnaW9fcmVzICpyZXMpCiAKIG91dDoKIAlrZnJlZShzZWdzKTsKKwlwcmlu
dGsoIkFHTE86ICVzIEVORFxuIiwgX19mdW5jX18pOwogCXJldHVybiBzdGF0dXM7CiB9CiAKZGlm
ZiAtLWdpdCBhL25ldC9zdW5ycGMvY2xudC5jIGIvbmV0L3N1bnJwYy9jbG50LmMKaW5kZXggZDJl
ZTU2NjM0MzA4Li40NDI2YTI1ZDAxNTIgMTAwNjQ0Ci0tLSBhL25ldC9zdW5ycGMvY2xudC5jCisr
KyBiL25ldC9zdW5ycGMvY2xudC5jCkBAIC0xMzM3LDYgKzEzMzcsNyBAQCB2b2lkIHJwY19wcmVw
YXJlX3JlcGx5X3BhZ2VzKHN0cnVjdCBycGNfcnFzdCAqcmVxLCBzdHJ1Y3QgcGFnZSAqKnBhZ2Vz
LAogewogCWhkcnNpemUgKz0gUlBDX1JFUEhEUlNJWkUgKyByZXEtPnJxX2NyZWQtPmNyX2F1dGgt
PmF1X3JhbGlnbjsKIAorCXByaW50aygiQUdMTzogJXMgaGRyc2l6ZSAlZCAoPDwyICVkKSBIRFJT
SVpFICVkIGF1bGlnaCAlZFxuIiwgX19mdW5jX18sIGhkcnNpemUsIGhkcnNpemUgPDwgMiwgUlBD
X1JFUEhEUlNJWkUsIHJlcS0+cnFfY3JlZC0+Y3JfYXV0aC0+YXVfcmFsaWduKTsKIAl4ZHJfaW5s
aW5lX3BhZ2VzKCZyZXEtPnJxX3Jjdl9idWYsIGhkcnNpemUgPDwgMiwgcGFnZXMsIGJhc2UsIGxl
bik7CiAJdHJhY2VfcnBjX3hkcl9yZXBseV9wYWdlcyhyZXEtPnJxX3Rhc2ssICZyZXEtPnJxX3Jj
dl9idWYpOwogfQpkaWZmIC0tZ2l0IGEvbmV0L3N1bnJwYy94ZHIuYyBiL25ldC9zdW5ycGMveGRy
LmMKaW5kZXggMzdjOGY3ZTUxOWRkLi43ZjYzNWY2MDFkZDQgMTAwNjQ0Ci0tLSBhL25ldC9zdW5y
cGMveGRyLmMKKysrIGIvbmV0L3N1bnJwYy94ZHIuYwpAQCAtMTQyMiw2ICsxNDIyLDcgQEAgc3Rh
dGljIF9fYmUzMiAqIF9feGRyX2lubGluZV9kZWNvZGUoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwg
c2l6ZV90IG5ieXRlcykKIAlfX2JlMzIgKnAgPSB4ZHItPnA7CiAJX19iZTMyICpxID0gcCArIG53
b3JkczsKIAorCXByaW50aygiQUdMTzogJXMgbndvcmRzPSVkIHhkci0+bndvcmRzPSVkIHE9JXAg
eGRyLT5lbmQ9JXAgcD0lcCAoJWQgJWQpXG4iLCBfX2Z1bmNfXywgbndvcmRzLCB4ZHItPm53b3Jk
cywgcSwgeGRyLT5lbmQsIHAsIHEgPiB4ZHItPmVuZCwgcSA8IHApOwogCWlmICh1bmxpa2VseShu
d29yZHMgPiB4ZHItPm53b3JkcyB8fCBxID4geGRyLT5lbmQgfHwgcSA8IHApKQogCQlyZXR1cm4g
TlVMTDsKIAl4ZHItPnAgPSBxOwpAQCAtMTQzNSw2ICsxNDM2LDcgQEAgc3RhdGljIF9fYmUzMiAq
eGRyX2NvcHlfdG9fc2NyYXRjaChzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyLCBzaXplX3QgbmJ5dGVz
KQogCWNoYXIgKmNwZGVzdCA9IHhkci0+c2NyYXRjaC5pb3ZfYmFzZTsKIAlzaXplX3QgY3BsZW4g
PSAoY2hhciAqKXhkci0+ZW5kIC0gKGNoYXIgKil4ZHItPnA7CiAKKwlwcmludGsoIkFHTE86ICVz
IGhlcmVcbiIsIF9fZnVuY19fKTsKIAlpZiAobmJ5dGVzID4geGRyLT5zY3JhdGNoLmlvdl9sZW4p
CiAJCWdvdG8gb3V0X292ZXJmbG93OwogCXAgPSBfX3hkcl9pbmxpbmVfZGVjb2RlKHhkciwgY3Bs
ZW4pOwotLSAKMi40MS4wCgo=
--000000000000448d9105fe2e3a42--
