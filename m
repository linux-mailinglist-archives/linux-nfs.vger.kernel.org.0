Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA344730978
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Jun 2023 22:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjFNUzg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jun 2023 16:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjFNUzf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Jun 2023 16:55:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD2211F;
        Wed, 14 Jun 2023 13:55:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f9aa383527so23404801cf.1;
        Wed, 14 Jun 2023 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686776134; x=1689368134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GuT2u5i+zu8JABUORePbTo/5nH4btXdVlFm59OPxaUI=;
        b=IvbkYbAYvxtG7fFnqHvV03fOuUWiz0pN/YccpN4kgEbYzQJRPXy5MFNDhjz8NQR5ME
         ciCn1m70FVNa8scFELdfef1tip+69F2LtcLm6GwZM6CpSvENCHNDInbmwtCsegcJ0KQU
         DbQMGtgcl4aB2Zzttt06UDMGnqeRrkA3EebxOADTfsab2Ue/9gx4aYsu/dKGMGC0TFFs
         lPXJdUtrEd61fQ/AcF+nmmNljLrPP7/i6UG3lbYweu/kVDEBcPojQ/xZjomQYxk8lAPs
         r+hzX5x/PY/G7njLgBoh+B1fAplEmQRBgv2du1iPKKeRm9H3xyQO58CSHF6KoLn9MRTX
         5z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686776134; x=1689368134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GuT2u5i+zu8JABUORePbTo/5nH4btXdVlFm59OPxaUI=;
        b=U7S1wui2IkwKD9WdGifXiUrnmrBgf4CmF9ynhakt7OjiyR92VAtiJS+2oee64DpBo/
         0kF/8TD2eZsyNLcSeIdpuCc40enIkjeIQga95ZQkUz5HHt9yVTH1C/bMn6RU7eb+N14y
         2WS7/S+KqzYbvmMYOBYZ7hzHbg+fBQHTKpkCHZJMLaKz+XbO1Jh8CR6yo3Eqo3unCx+Y
         n9gFi1vJD/JkTrNGVxiFsq6EHi8yjJpfjBrqqWsquhUz4OLKlC83Kk6Ymof6aVq8AEC+
         q3VGNpRhQ0RnfTGfJAtCSrBJMau8DatVqps5m926IAZhIEk3otK5fmfDFJVj9x5rJIMb
         4iGg==
X-Gm-Message-State: AC+VfDyL7dI1rxk6xD3dK1bY0iHVIYBLEGOwGRCb2j+49ouRe6McQH9t
        wfvf4HhLlm6YQYHMQjE+D+yzhghEDPh72TFV2w0=
X-Google-Smtp-Source: ACHHUZ6DkH26XCIhr+wTdRpdpaHyJ5f/gxn6jjA5CNDtnOfSVK4gHdCkHUSyea/lG9umV3hV7rZ7i2rdqyWnmHbXJDs=
X-Received: by 2002:a05:622a:138b:b0:3f9:adc9:4785 with SMTP id
 o11-20020a05622a138b00b003f9adc94785mr3164763qtk.51.1686776133578; Wed, 14
 Jun 2023 13:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <82526863-d07a-0a5d-2990-1555b1387f26@linaro.org> <2C5E9725-F152-4D2E-882E-CF92A35481BF@hammerspace.com>
 <7ba38377-7992-7f0f-d905-cceb42510f39@linaro.org> <51430925-8046-7066-84ed-2ff0db835347@linaro.org>
 <CAFX2Jf=5X3zyZEWQmD6Rg9jQAD7ccDbae5LQCwrAyPCVVoFumg@mail.gmail.com>
 <2add1769-1458-b185-bc78-6d573f61b6fc@linaro.org> <CAFX2JfnKy7juGQaDTzqosN9SF-zd+XrhSL9uh_Xg0GpJGDux-A@mail.gmail.com>
 <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org> <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
 <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org> <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org> <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
 <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org>
In-Reply-To: <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 14 Jun 2023 16:55:17 -0400
Message-ID: <CAFX2Jfn_DSs38WQYsRs2ifLi5w+T3BhZfSU2W80T6dK48_Bb5g@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000426b2f05fe1d2cfc"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--000000000000426b2f05fe1d2cfc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Sat, Jun 10, 2023 at 6:15=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/03/2023 18:09, Anna Schumaker wrote:
> > Hi Krzysztof,
> >
> > On Tue, Feb 14, 2023 at 6:02=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 12/02/2023 15:05, Anna Schumaker wrote:
> >>>>> From ac2d6c501dbcdb306480edaee625b5496f1fb4f5 Mon Sep 17 00:00:00 2=
001
> >>>>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >>>>> Date: Fri, 10 Feb 2023 15:50:22 -0500
> >>>>> Subject: [PATCH] NFSv4.2: Rework scratch handling for READ_PLUS
> >>>>>
> >>>>
> >>>> Patch is corrupted - maybe mail program reformatted it when sending:
> >>>>
> >>>> Applying: NFSv4.2: Rework scratch handling for READ_PLUS
> >>>> error: corrupt patch at line 12
> >>>> Patch failed at 0001 NFSv4.2: Rework scratch handling for READ_PLUS
> >>>
> >>> That's weird. I wasn't expecting gmail to reformat the patch but I
> >>> guess it did. I've added it as an attachment so that shouldn't happen
> >>> again.
> >>
> >> Still null ptr (built on 420b2d4 with your patch):
> >
> > We're through the merge window and at rc1 now, so I can spend more
> > time scratching my head over your bug again. We've come up with a
> > patch (attached) that adds a bunch of printks to show us what the
> > kernel thinks is going on. Do you mind trying it out and letting us
> > know what gets printed out? You'll need to make sure
> > CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.
>
> The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-20230609.

Can you try the attached patch on top of my 3-patch series from the
other day, and let me know what gets printed out? It adds a bunch of
printk()s at strategic points to print out what is going on with the
xdr scratch buffer since it's suddenly a bad memory address after
working for a bit on your machine.

Thanks,
Anna

>
> Best regards,
> Krzysztof
>

--000000000000426b2f05fe1d2cfc
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-NFS-Add-debugging-printk-s-to-trace-the-xdr-scratch-.patch"
Content-Disposition: attachment; 
	filename="0001-NFS-Add-debugging-printk-s-to-trace-the-xdr-scratch-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_liw6vo5i0>
X-Attachment-Id: f_liw6vo5i0

RnJvbSA5ODUyNDgxNjVlNTNhNjdlN2NiNmExOGVjMjgxM2FiYThiMjZkYTMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogV2VkLCAxNCBKdW4gMjAyMyAxNjo0OTozNyAtMDQwMApTdWJqZWN0OiBbUkZD
XSBORlM6IEFkZCBkZWJ1Z2dpbmcgcHJpbnRrKClzIHRvIHRyYWNlIHRoZSB4ZHItPnNjcmF0Y2gg
YnVmZmVyCgpJJ20gdHJ5aW5nIHRvIGZpZ3VyZSBvdXQgYXQgd2hhdCBwb2ludCB0aGUgeGRyLT5z
Y3JhdGNoIGJ1ZmZlciBpcwphbGxvY2F0ZWQsIGZyZWVkLCBzZXQsIGFuZCByZXNldCB0byBmaWd1
cmUgb3V0IHdoeSBSRUFEX1BMVVMgc3VkZGVubHkKdGhpbmtzIGl0J3MgYSBOVUxMIHBvaW50ZXIg
d2l0aCBsZW5ndGggMTYuCgpTaWduZWQtb2ZmLWJ5OiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1
bWFrZXJATmV0YXBwLmNvbT4KLS0tCiBmcy9uZnMvbmZzNDJ4ZHIuYyB8IDcgKysrKysrKwogZnMv
bmZzL3JlYWQuYyAgICAgfCA4ICsrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9uZnMvbmZzNDJ4ZHIuYyBiL2Zz
L25mcy9uZnM0Mnhkci5jCmluZGV4IDIwYWE1ZTc0NjQ5Ny4uNmY2M2M4MTZiMGE1IDEwMDY0NAot
LS0gYS9mcy9uZnMvbmZzNDJ4ZHIuYworKysgYi9mcy9uZnMvbmZzNDJ4ZHIuYwpAQCAtMTM1MSwy
MSArMTM1MSwyOCBAQCBzdGF0aWMgaW50IG5mczRfeGRyX2RlY19yZWFkX3BsdXMoc3RydWN0IHJw
Y19ycXN0ICpycXN0cCwKIAlzdHJ1Y3QgY29tcG91bmRfaGRyIGhkcjsKIAlpbnQgc3RhdHVzOwog
CisJcHJpbnRrKEtFUk5fSU5GTyAiJXMoaGRyPSVweCwgc2NyYXRjaD0lcHgpXG4iLCBfX2Z1bmNf
XywKKwkJY29udGFpbmVyX29mKHJlcywgc3RydWN0IG5mc19wZ2lvX2hlYWRlciwgcmVzKSwgcmVz
LT5zY3JhdGNoKTsKIAl4ZHJfc2V0X3NjcmF0Y2hfYnVmZmVyKHhkciwgcmVzLT5zY3JhdGNoLCBS
RUFEX1BMVVNfU0NSQVRDSF9TSVpFKTsKIAorCXByaW50ayhLRVJOX0lORk8gIiAgICBidWYgPSB7
JXB4LCAlemR9XG4iLCB4ZHItPnNjcmF0Y2guaW92X2Jhc2UsIHhkci0+c2NyYXRjaC5pb3ZfbGVu
KTsKIAlzdGF0dXMgPSBkZWNvZGVfY29tcG91bmRfaGRyKHhkciwgJmhkcik7CiAJaWYgKHN0YXR1
cykKIAkJZ290byBvdXQ7CisJcHJpbnRrKEtFUk5fSU5GTyAiICAgIGJ1ZiA9IHslcHgsICV6ZH1c
biIsIHhkci0+c2NyYXRjaC5pb3ZfYmFzZSwgeGRyLT5zY3JhdGNoLmlvdl9sZW4pOwogCXN0YXR1
cyA9IGRlY29kZV9zZXF1ZW5jZSh4ZHIsICZyZXMtPnNlcV9yZXMsIHJxc3RwKTsKIAlpZiAoc3Rh
dHVzKQogCQlnb3RvIG91dDsKKwlwcmludGsoS0VSTl9JTkZPICIgICAgYnVmID0geyVweCwgJXpk
fVxuIiwgeGRyLT5zY3JhdGNoLmlvdl9iYXNlLCB4ZHItPnNjcmF0Y2guaW92X2xlbik7CiAJc3Rh
dHVzID0gZGVjb2RlX3B1dGZoKHhkcik7CiAJaWYgKHN0YXR1cykKIAkJZ290byBvdXQ7CisJcHJp
bnRrKEtFUk5fSU5GTyAiICAgIGJ1ZiA9IHslcHgsICV6ZH1cbiIsIHhkci0+c2NyYXRjaC5pb3Zf
YmFzZSwgeGRyLT5zY3JhdGNoLmlvdl9sZW4pOwogCXN0YXR1cyA9IGRlY29kZV9yZWFkX3BsdXMo
eGRyLCByZXMpOwogCWlmICghc3RhdHVzKQogCQlzdGF0dXMgPSByZXMtPmNvdW50Owogb3V0Ogor
CXByaW50ayhLRVJOX0lORk8gIiAgICBidWYgPSB7JXB4LCAlemR9XG4iLCB4ZHItPnNjcmF0Y2gu
aW92X2Jhc2UsIHhkci0+c2NyYXRjaC5pb3ZfbGVuKTsKIAlyZXR1cm4gc3RhdHVzOwogfQogCmRp
ZmYgLS1naXQgYS9mcy9uZnMvcmVhZC5jIGIvZnMvbmZzL3JlYWQuYwppbmRleCA3ZGMyMWE0OGUz
ZTcuLjdiOTMzMTZhNTJkZSAxMDA2NDQKLS0tIGEvZnMvbmZzL3JlYWQuYworKysgYi9mcy9uZnMv
cmVhZC5jCkBAIC00Nyw4ICs0NywxMSBAQCBzdGF0aWMgc3RydWN0IG5mc19wZ2lvX2hlYWRlciAq
bmZzX3JlYWRoZHJfYWxsb2Modm9pZCkKIAogc3RhdGljIHZvaWQgbmZzX3JlYWRoZHJfZnJlZShz
dHJ1Y3QgbmZzX3BnaW9faGVhZGVyICpyaGRyKQogewotCWlmIChyaGRyLT5yZXMuc2NyYXRjaCAh
PSBOVUxMKQorCWlmIChyaGRyLT5yZXMuc2NyYXRjaCAhPSBOVUxMKSB7CisJCXByaW50ayhLRVJO
X0lORk8gIiVzKGhkcj0lcHgsIHNjcmF0Y2g9JXB4KVxuIiwKKwkJCV9fZnVuY19fLCByaGRyLCBy
aGRyLT5yZXMuc2NyYXRjaCk7CiAJCWtmcmVlKHJoZHItPnJlcy5zY3JhdGNoKTsKKwl9CiAJa21l
bV9jYWNoZV9mcmVlKG5mc19yZGF0YV9jYWNoZXAsIHJoZHIpOwogfQogCkBAIC0xMTQsNiArMTE3
LDkgQEAgYm9vbCBuZnNfcmVhZF9hbGxvY19zY3JhdGNoKHN0cnVjdCBuZnNfcGdpb19oZWFkZXIg
Kmhkciwgc2l6ZV90IHNpemUpCiB7CiAJV0FSTl9PTihoZHItPnJlcy5zY3JhdGNoICE9IE5VTEwp
OwogCWhkci0+cmVzLnNjcmF0Y2ggPSBrbWFsbG9jKHNpemUsIEdGUF9LRVJORUwpOworCXByaW50
ayhLRVJOX0lORk8gIlxuIik7CisJcHJpbnRrKEtFUk5fSU5GTyAiJXMoaGRyPSVweCwgc2l6ZT0l
emQpID0gJXB4XG4iLAorCQlfX2Z1bmNfXywgaGRyLCBzaXplLCBoZHItPnJlcy5zY3JhdGNoKTsK
IAlyZXR1cm4gaGRyLT5yZXMuc2NyYXRjaCAhPSBOVUxMOwogfQogRVhQT1JUX1NZTUJPTF9HUEwo
bmZzX3JlYWRfYWxsb2Nfc2NyYXRjaCk7Ci0tIAoyLjQxLjAKCg==
--000000000000426b2f05fe1d2cfc--
