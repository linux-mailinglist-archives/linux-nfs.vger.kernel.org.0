Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C76773BE2F
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jun 2023 20:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjFWSAE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Jun 2023 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbjFWSAC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Jun 2023 14:00:02 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E692136;
        Fri, 23 Jun 2023 11:00:00 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-40079c67a1fso9171251cf.0;
        Fri, 23 Jun 2023 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687543200; x=1690135200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NR3XgMRotW/m3BP5L8wvyTpmLFOPidYrOBArMrDIUuE=;
        b=ZInovtcfIjAC5AmsoOrRnq9sIdFaPfJYJ3ViHjt0BrAxyCS+ZH48IzFA8hfba3xgd1
         EOOA+Dd/urJqCr9SQ+qpunLjF9ifVo4G1GWShxcP6x6FXcVljLbXoa3cZyMu18ZUqIQ3
         XzwITGgxpISNG3U/zxyQcy+NNtCN7Ns2ijiBEQkvSCxrQLyJQFj/lFpWRI+AlOv/YMKT
         3PoVx8CCb5mvUwcsUaYsBLAWi2M6rQnrla5T2T4oMgA+DMveH7zQ48xDlGjVhNC3mxVZ
         larXH7Xa0J05esPOMblLQPZtuCu7yDMds52eZRL5L8bbhnR6hreagcNB/vkC3x6B5fUO
         YEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687543200; x=1690135200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NR3XgMRotW/m3BP5L8wvyTpmLFOPidYrOBArMrDIUuE=;
        b=Ff1OlFvC/7wxMlxFf3U6NL+Jin3m/cPEmYxfqSQ6RWDOL0iMd7+Qq3ifvD8QcDwPKZ
         UpMaSYkp87NmfTK2l156b4oZnrLfPyBw7Cn0bYGDTuqZRH7hs1hXxa/gt7uo4/ggHjuU
         mwIT0dLQZqCM+ARSVL4VroUumrDz+NhEGvDubjT9tog0UqiLycwWsBcN1k6UAG8OiaSj
         t5N3SN12LCfh3xt04HXYvJ32A0izrl66CB7QHOi5QDKemB/Sb0VrRB3hsg1oDAjYidh4
         hktYul3TkJPmVoYpE8IgMxGh+9wzJXnqYHb7fBMJ4zI1E7+vac9AjQFOeWfi9K5TUPwp
         oWBg==
X-Gm-Message-State: AC+VfDxVkK01Mw2x5I+z0RXCQBVtziDLDTOqsZP1lAUM7UwPUN9R6SNm
        DMZcnf5sqrMBzGwW/4mumAMhwrPLxwmez3r92Z1UDac8
X-Google-Smtp-Source: ACHHUZ6pAhUSyAV5+Fc5LuKxFFGuZzhNTgoDstA8CLrpHcHcwUXTydnf4yaD3frUVaD9IcPBhuzlvk9VQtuscAkobAk=
X-Received: by 2002:ac8:7f43:0:b0:3fd:eb04:344f with SMTP id
 g3-20020ac87f43000000b003fdeb04344fmr23929782qtk.54.1687543199819; Fri, 23
 Jun 2023 10:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
 <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org> <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org> <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
 <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org> <CAFX2Jfn_DSs38WQYsRs2ifLi5w+T3BhZfSU2W80T6dK48_Bb5g@mail.gmail.com>
 <e8d31e48-df6a-fde4-4c6b-c4ccf1664ded@linaro.org> <c8d454b0-d355-f599-f720-b7e64374fb56@linaro.org>
 <CAFX2JfmvMZ7DzD9znWeOHXywgPbUKDS1irMjUerEuborjRBpcg@mail.gmail.com>
 <CAFX2JfnhOz+HiOd4vBwBK+5d19Kb8wfBNQhxRZHQoP8S2qiwFw@mail.gmail.com>
 <CAFX2Jf=5WV=dY9J4-7tp5NB85fDOkwiv8rxQqHziqG+ED1cUJw@mail.gmail.com>
 <CAFX2Jf=TxojviigtdQ=F_8FcHFFC4RNdfkoS=157jnXQCQSq5g@mail.gmail.com>
 <85851031-cf43-07d2-8ec7-b40c8c00be91@linaro.org> <CAFX2JfnH_rOFxn+uT4e1Eutea5En4_z26a-u_qCwOsnr5EowRw@mail.gmail.com>
 <dfcc114f-56f1-e4ab-7b36-f9a4ce3e8c8c@linaro.org>
In-Reply-To: <dfcc114f-56f1-e4ab-7b36-f9a4ce3e8c8c@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 23 Jun 2023 13:59:43 -0400
Message-ID: <CAFX2Jf=uaOC2oDceShnNNJdSeW-MNwh7N=Jh=S9zYjP_Ci-DuQ@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: multipart/mixed; boundary="000000000000f823fb05fecfc466"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--000000000000f823fb05fecfc466
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, Jun 21, 2023 at 9:27=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/06/2023 14:49, Anna Schumaker wrote:
> > On Sat, Jun 17, 2023 at 6:09=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 15/06/2023 21:38, Anna Schumaker wrote:
> >>> On Thu, Jun 15, 2023 at 1:16=E2=80=AFPM Anna Schumaker <schumaker.ann=
a@gmail.com> wrote:
> >>>>
> >>>> On Thu, Jun 15, 2023 at 1:04=E2=80=AFPM Anna Schumaker <schumaker.an=
na@gmail.com> wrote:
> >>>>>
> >>>>> On Thu, Jun 15, 2023 at 9:01=E2=80=AFAM Anna Schumaker <schumaker.a=
nna@gmail.com> wrote:
> >>>>>>
> >>>>>> On Thu, Jun 15, 2023 at 4:55=E2=80=AFAM Krzysztof Kozlowski
> >>>>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>>>
> >>>>>>> On 15/06/2023 10:52, Krzysztof Kozlowski wrote:
> >>>>>>>> On 14/06/2023 22:55, Anna Schumaker wrote:
> >>>>>>>>>>>> Still null ptr (built on 420b2d4 with your patch):
> >>>>>>>>>>>
> >>>>>>>>>>> We're through the merge window and at rc1 now, so I can spend=
 more
> >>>>>>>>>>> time scratching my head over your bug again. We've come up wi=
th a
> >>>>>>>>>>> patch (attached) that adds a bunch of printks to show us what=
 the
> >>>>>>>>>>> kernel thinks is going on. Do you mind trying it out and lett=
ing us
> >>>>>>>>>>> know what gets printed out? You'll need to make sure
> >>>>>>>>>>> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kerne=
l.
> >>>>>>>>>>
> >>>>>>>>>> The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-20=
230609.
> >>>>>>>>>
> >>>>>>>>> Can you try the attached patch on top of my 3-patch series from=
 the
> >>>>>>>>> other day, and let me know what gets printed out? It adds a bun=
ch of
> >>>>>>>>> printk()s at strategic points to print out what is going on wit=
h the
> >>>>>>>>> xdr scratch buffer since it's suddenly a bad memory address aft=
er
> >>>>>>>>> working for a bit on your machine.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> Here you have entire log - attached (113 kB, I hope goes past ma=
iling
> >>>>>>>> lists/spam filters).
> >>>>>>>
> >>>>>>> As expected this bounced from the mailing lists, but I hope you g=
ot it.
> >>>>>>> If not, let me know.
> >>>>>>
> >>>>>> I did still receive it. Thanks!
> >>>>>
> >>>>> Can you swap out yesterday's patch with this patch? I've adjusted w=
hat
> >>>>> gets printed out, and added printk()s to xdr_copy_to_scratch().  I'=
m
> >>>>> starting to think that the xdr scratch buffer is fine, and that it'=
s
> >>>>> the other pointer passed to memcpy() in that function that's the
> >>>>> problem, and the output from this patch will confirm for me.
> >>>>
> >>>> Oh, and can you add this one on top of the v2 patch as well?
> >>>
> >>> Sorry about the noise today. Can you use this patch instead of the tw=
o
> >>> I attached earlier? I cleaned up the output and cut down on extra
> >>> output..
> >>>
> >>
> >> Here you have - attached.
> >
> > This is good, thanks! I was finally able to figure out how to hit the
> > bug using a 32bit x86 VM, so hopefully the next thing you hear from me
> > is a patch fixing the bug!

I'm really hopeful that the attached patch finally fixes the issue.
Can you try it and let me know?

Thanks,
Anna

>
> QEMU also has 32-bit ARM and x86...
>
> Best regards,
> Krzysztof
>

--000000000000f823fb05fecfc466
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-SUNRPC-kmap-the-xdr-pages-during-decode.patch"
Content-Disposition: attachment; 
	filename="0001-SUNRPC-kmap-the-xdr-pages-during-decode.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lj8vm1s50>
X-Attachment-Id: f_lj8vm1s50

RnJvbSA4OGJlNjIxZmM2ODdkODU4OTE2MzZlZDQ2OTVhYjk5M2UxZjJjYjNiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbm5hIFNjaHVtYWtlciA8QW5uYS5TY2h1bWFrZXJATmV0YXBw
LmNvbT4KRGF0ZTogRnJpLCAyMyBKdW4gMjAyMyAxMTo0MzoxNCAtMDQwMApTdWJqZWN0OiBbUEFU
Q0hdIFNVTlJQQzoga21hcCgpIHRoZSB4ZHIgcGFnZXMgZHVyaW5nIGRlY29kZQoKSWYgdGhlIHBh
Z2VzIGFyZSBpbiBISUdITUVNIHRoZW4gd2UgbmVlZCB0byBtYWtlIHN1cmUgdGhleSdyZSBtYXBw
ZWQKYmVmb3JlIHRyeWluZyB0byByZWFkIGRhdGEgb2ZmIG9mIHRoZW0sIG90aGVyd2lzZSB3ZSBj
b3VsZCBlbmQgdXAgd2l0aCBhCk5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4KClJlcG9ydGVkLWJ5
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+ClNp
Z25lZC1vZmYtYnk6IEFubmEgU2NodW1ha2VyIDxBbm5hLlNjaHVtYWtlckBOZXRhcHAuY29tPgot
LS0KIGluY2x1ZGUvbGludXgvc3VucnBjL3hkci5oIHwgIDIgKysKIG5ldC9zdW5ycGMvY2xudC5j
ICAgICAgICAgIHwgIDEgKwogbmV0L3N1bnJwYy94ZHIuYyAgICAgICAgICAgfCAyMCArKysrKysr
KysrKysrKy0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oIGIvaW5jbHVk
ZS9saW51eC9zdW5ycGMveGRyLmgKaW5kZXggZDkxNzYxOGEzMDU4Li5mNTYyYWFiNDY4ZjUgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc3VucnBjL3hkci5oCisrKyBiL2luY2x1ZGUvbGludXgv
c3VucnBjL3hkci5oCkBAIC0yMjgsNiArMjI4LDcgQEAgc3RydWN0IHhkcl9zdHJlYW0gewogCXN0
cnVjdCBrdmVjICppb3Y7CS8qIHBvaW50ZXIgdG8gdGhlIGN1cnJlbnQga3ZlYyAqLwogCXN0cnVj
dCBrdmVjIHNjcmF0Y2g7CS8qIFNjcmF0Y2ggYnVmZmVyICovCiAJc3RydWN0IHBhZ2UgKipwYWdl
X3B0cjsJLyogcG9pbnRlciB0byB0aGUgY3VycmVudCBwYWdlICovCisJdm9pZCAqcGFnZV9rYWRk
cjsJLyoga21hcHBlZCBhZGRyZXNzIG9mIHRoZSBjdXJyZW50IHBhZ2UgKi8KIAl1bnNpZ25lZCBp
bnQgbndvcmRzOwkvKiBSZW1haW5pbmcgZGVjb2RlIGJ1ZmZlciBsZW5ndGggKi8KIAogCXN0cnVj
dCBycGNfcnFzdCAqcnFzdDsJLyogRm9yIGRlYnVnZ2luZyAqLwpAQCAtMjU0LDYgKzI1NSw3IEBA
IGV4dGVybiB2b2lkIHhkcl90cnVuY2F0ZV9kZWNvZGUoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwg
c2l6ZV90IGxlbik7CiBleHRlcm4gaW50IHhkcl9yZXN0cmljdF9idWZsZW4oc3RydWN0IHhkcl9z
dHJlYW0gKnhkciwgaW50IG5ld2J1Zmxlbik7CiBleHRlcm4gdm9pZCB4ZHJfd3JpdGVfcGFnZXMo
c3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3RydWN0IHBhZ2UgKipwYWdlcywKIAkJdW5zaWduZWQg
aW50IGJhc2UsIHVuc2lnbmVkIGludCBsZW4pOworZXh0ZXJuIHZvaWQgeGRyX3N0cmVhbV91bm1h
cF9jdXJyZW50X3BhZ2Uoc3RydWN0IHhkcl9zdHJlYW0gKnhkcik7CiBleHRlcm4gdW5zaWduZWQg
aW50IHhkcl9zdHJlYW1fcG9zKGNvbnN0IHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIpOwogZXh0ZXJu
IHVuc2lnbmVkIGludCB4ZHJfcGFnZV9wb3MoY29uc3Qgc3RydWN0IHhkcl9zdHJlYW0gKnhkcik7
CiBleHRlcm4gdm9pZCB4ZHJfaW5pdF9kZWNvZGUoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwgc3Ry
dWN0IHhkcl9idWYgKmJ1ZiwKZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMvY2xudC5jIGIvbmV0L3N1
bnJwYy9jbG50LmMKaW5kZXggZDJlZTU2NjM0MzA4Li4zYjdlNjc2ZDg5MzUgMTAwNjQ0Ci0tLSBh
L25ldC9zdW5ycGMvY2xudC5jCisrKyBiL25ldC9zdW5ycGMvY2xudC5jCkBAIC0yNTkwLDYgKzI1
OTAsNyBAQCBjYWxsX2RlY29kZShzdHJ1Y3QgcnBjX3Rhc2sgKnRhc2spCiAJY2FzZSAwOgogCQl0
YXNrLT50a19hY3Rpb24gPSBycGNfZXhpdF90YXNrOwogCQl0YXNrLT50a19zdGF0dXMgPSBycGNh
dXRoX3Vud3JhcF9yZXNwKHRhc2ssICZ4ZHIpOworCQl4ZHJfc3RyZWFtX3VubWFwX2N1cnJlbnRf
cGFnZSgmeGRyKTsKIAkJcmV0dXJuOwogCWNhc2UgLUVBR0FJTjoKIAkJdGFzay0+dGtfc3RhdHVz
ID0gMDsKZGlmZiAtLWdpdCBhL25ldC9zdW5ycGMveGRyLmMgYi9uZXQvc3VucnBjL3hkci5jCmlu
ZGV4IDM5MWIzMzZkOTdkZS4uYjA3M2Y1MWU2MDE4IDEwMDY0NAotLS0gYS9uZXQvc3VucnBjL3hk
ci5jCisrKyBiL25ldC9zdW5ycGMveGRyLmMKQEAgLTEzMDgsNiArMTMwOCwxNCBAQCBzdGF0aWMg
dW5zaWduZWQgaW50IHhkcl9zZXRfdGFpbF9iYXNlKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIsCiAJ
cmV0dXJuIHhkcl9zZXRfaW92KHhkciwgYnVmLT50YWlsLCBiYXNlLCBsZW4pOwogfQogCit2b2lk
IHhkcl9zdHJlYW1fdW5tYXBfY3VycmVudF9wYWdlKHN0cnVjdCB4ZHJfc3RyZWFtICp4ZHIpCit7
CisJaWYgKHhkci0+cGFnZV9rYWRkcikgeworCQlrdW5tYXBfbG9jYWwoeGRyLT5wYWdlX2thZGRy
KTsKKwkJeGRyLT5wYWdlX2thZGRyID0gTlVMTDsKKwl9Cit9CisKIHN0YXRpYyB1bnNpZ25lZCBp
bnQgeGRyX3NldF9wYWdlX2Jhc2Uoc3RydWN0IHhkcl9zdHJlYW0gKnhkciwKIAkJCQkgICAgICB1
bnNpZ25lZCBpbnQgYmFzZSwgdW5zaWduZWQgaW50IGxlbikKIHsKQEAgLTEzMTUsNyArMTMyMyw2
IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgeGRyX3NldF9wYWdlX2Jhc2Uoc3RydWN0IHhkcl9zdHJl
YW0gKnhkciwKIAl1bnNpZ25lZCBpbnQgbWF4bGVuOwogCXVuc2lnbmVkIGludCBwZ29mZjsKIAl1
bnNpZ25lZCBpbnQgcGdlbmQ7Ci0Jdm9pZCAqa2FkZHI7CiAKIAltYXhsZW4gPSB4ZHItPmJ1Zi0+
cGFnZV9sZW47CiAJaWYgKGJhc2UgPj0gbWF4bGVuKQpAQCAtMTMzMCwxNSArMTMzNywxNSBAQCBz
dGF0aWMgdW5zaWduZWQgaW50IHhkcl9zZXRfcGFnZV9iYXNlKHN0cnVjdCB4ZHJfc3RyZWFtICp4
ZHIsCiAKIAlwZ25yID0gYmFzZSA+PiBQQUdFX1NISUZUOwogCXhkci0+cGFnZV9wdHIgPSAmeGRy
LT5idWYtPnBhZ2VzW3BnbnJdOwotCWthZGRyID0gcGFnZV9hZGRyZXNzKCp4ZHItPnBhZ2VfcHRy
KTsKKwl4ZHItPnBhZ2Vfa2FkZHIgPSBrbWFwX2xvY2FsX3BhZ2UoKnhkci0+cGFnZV9wdHIpOwog
CiAJcGdvZmYgPSBiYXNlICYgflBBR0VfTUFTSzsKLQl4ZHItPnAgPSAoX19iZTMyKikoa2FkZHIg
KyBwZ29mZik7CisJeGRyLT5wID0gKF9fYmUzMiopKHhkci0+cGFnZV9rYWRkciArIHBnb2ZmKTsK
IAogCXBnZW5kID0gcGdvZmYgKyBsZW47CiAJaWYgKHBnZW5kID4gUEFHRV9TSVpFKQogCQlwZ2Vu
ZCA9IFBBR0VfU0laRTsKLQl4ZHItPmVuZCA9IChfX2JlMzIqKShrYWRkciArIHBnZW5kKTsKKwl4
ZHItPmVuZCA9IChfX2JlMzIqKSh4ZHItPnBhZ2Vfa2FkZHIgKyBwZ2VuZCk7CiAJeGRyLT5pb3Yg
PSBOVUxMOwogCXJldHVybiBsZW47CiB9CkBAIC0xMzY2LDkgKzEzNzMsMTAgQEAgc3RhdGljIHZv
aWQgeGRyX3NldF9uZXh0X3BhZ2Uoc3RydWN0IHhkcl9zdHJlYW0gKnhkcikKIAogc3RhdGljIGJv
b2wgeGRyX3NldF9uZXh0X2J1ZmZlcihzdHJ1Y3QgeGRyX3N0cmVhbSAqeGRyKQogewotCWlmICh4
ZHItPnBhZ2VfcHRyICE9IE5VTEwpCisJaWYgKHhkci0+cGFnZV9wdHIgIT0gTlVMTCkgeworCQl4
ZHJfc3RyZWFtX3VubWFwX2N1cnJlbnRfcGFnZSh4ZHIpOwogCQl4ZHJfc2V0X25leHRfcGFnZSh4
ZHIpOwotCWVsc2UgaWYgKHhkci0+aW92ID09IHhkci0+YnVmLT5oZWFkKQorCX0gZWxzZSBpZiAo
eGRyLT5pb3YgPT0geGRyLT5idWYtPmhlYWQpCiAJCXhkcl9zZXRfcGFnZSh4ZHIsIDAsIHhkcl9z
dHJlYW1fcmVtYWluaW5nKHhkcikpOwogCXJldHVybiB4ZHItPnAgIT0geGRyLT5lbmQ7CiB9Ci0t
IAoyLjQxLjAKCg==
--000000000000f823fb05fecfc466--
