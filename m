Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263D8738413
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jun 2023 14:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjFUMt5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Jun 2023 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUMt4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Jun 2023 08:49:56 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F51717;
        Wed, 21 Jun 2023 05:49:55 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-440db8e60c8so49698137.0;
        Wed, 21 Jun 2023 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687351794; x=1689943794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PdIfEQE5qKLVmM+dbuAdzdn3w59OCD/u/aDJaWNRVY=;
        b=oXT+JxL/7NBOvVrMWn+Xlf9j+mWJgDxO6CMZzQHe0vouHmGpEYx/slqSGR7MIKi+1X
         7a5EJ94R0GKUnIrYbbxoVDdqRuaovmA6NEE4JMl2odCYKXIHssunN9af6Du4p4Q72GUf
         gC+bdGSSp0EkjN5MG7Ulp0uxiUEWz96j9nH07ZAASJ90+v6FLY85vKYiO+nQDr1LYaDD
         wQAm5hu4dJmCoB9ZeNCKF0s3RWcDRwuOrLRvGF2x5wZHoVvj3uH7DesXRTSCQGIMV8fx
         FLYGQVBZhDQZs5695s0ax3jHufydoqL1BFiz13gd9b3DGt5e06JyTcnROQ3tYYu9aYGe
         PifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687351794; x=1689943794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PdIfEQE5qKLVmM+dbuAdzdn3w59OCD/u/aDJaWNRVY=;
        b=kf1cq8cmLeuihw0pXPph9Nz5ViR7FXJm2oFGB+NkL+caixF5yTN6RqWPU6TRST6x0P
         A6bekUIUGRXcvOP0I7uY3nzGuA3uha4THREcjDWrpbB8Y1dipU3sliMZeqL3uSlNsjjT
         XQl1GyLesMjOZBryegxh29WoAAVW9jPMviDHNd1l77uq2wH45VD9wxU3rUPjGTXPwHHa
         UJ55YyGgf9MSsPXkdsoeTePZqNvG6i60kFWkc5dScHQ65NXHP6wbuGaAHB4OjS+3hare
         oGSy4C4z0grdnimfGJbWnsJHGq6Bt9DBbsNSJo5nC2BuntwRO/I9Ex/4pyCByOVxYHxU
         QoqQ==
X-Gm-Message-State: AC+VfDwHdGopPsoAdGwXmcC3V0/oNSqL24KLL1iRrPVXHxzaeFJsunY5
        MxAVyQe1tsbS900HTzTrgkqxO/cYkFuouLE8HTo=
X-Google-Smtp-Source: ACHHUZ40j3yDUpJMaBERCx7VHArb1cFDlbuTRAimB469povwCJ+py9bIr6qHbKLdzihsUJblvAeHzhy2GixZ3W0FG3A=
X-Received: by 2002:a05:6102:41b:b0:440:9f9a:4bbb with SMTP id
 d27-20020a056102041b00b004409f9a4bbbmr5517461vsq.20.1687351794168; Wed, 21
 Jun 2023 05:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <f591b13c-4600-e2a4-8efa-aac6ad828dd1@linaro.org>
 <32530c36-91d0-d351-0689-aed6a0975a4b@linaro.org> <2f285607-cbf9-6abc-f436-edb6e9a3938b@linaro.org>
 <CAFX2Jfmz7QqZBEdzbPUhPs0yctnXVaVF68tX1c57YX=6ki=0TA@mail.gmail.com>
 <4fe39d77-eb7c-a578-aefa-45b76e2247c2@linaro.org> <CAFX2JfmdRMsHPTySiw4vm7BwJfRZj3s0V3_v7NJ+XwMxBBSo9A@mail.gmail.com>
 <a3683dd3-3f30-bb4c-539d-d1519de6e5bf@linaro.org> <CAFX2JfnS9GVc4NaxKhr9E4y10NNv6SPgcv1yoeHTfEw5NvZgMg@mail.gmail.com>
 <86d8e252-975f-5d48-4567-0911d5ef9a44@linaro.org> <CAFX2Jfn_DSs38WQYsRs2ifLi5w+T3BhZfSU2W80T6dK48_Bb5g@mail.gmail.com>
 <e8d31e48-df6a-fde4-4c6b-c4ccf1664ded@linaro.org> <c8d454b0-d355-f599-f720-b7e64374fb56@linaro.org>
 <CAFX2JfmvMZ7DzD9znWeOHXywgPbUKDS1irMjUerEuborjRBpcg@mail.gmail.com>
 <CAFX2JfnhOz+HiOd4vBwBK+5d19Kb8wfBNQhxRZHQoP8S2qiwFw@mail.gmail.com>
 <CAFX2Jf=5WV=dY9J4-7tp5NB85fDOkwiv8rxQqHziqG+ED1cUJw@mail.gmail.com>
 <CAFX2Jf=TxojviigtdQ=F_8FcHFFC4RNdfkoS=157jnXQCQSq5g@mail.gmail.com> <85851031-cf43-07d2-8ec7-b40c8c00be91@linaro.org>
In-Reply-To: <85851031-cf43-07d2-8ec7-b40c8c00be91@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Wed, 21 Jun 2023 08:49:38 -0400
Message-ID: <CAFX2JfnH_rOFxn+uT4e1Eutea5En4_z26a-u_qCwOsnr5EowRw@mail.gmail.com>
Subject: Re: Regression: NULL pointer dereference after NFS_V4_2_READ_PLUS
 (commit 7fd461c47)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Jun 17, 2023 at 6:09=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/06/2023 21:38, Anna Schumaker wrote:
> > On Thu, Jun 15, 2023 at 1:16=E2=80=AFPM Anna Schumaker <schumaker.anna@=
gmail.com> wrote:
> >>
> >> On Thu, Jun 15, 2023 at 1:04=E2=80=AFPM Anna Schumaker <schumaker.anna=
@gmail.com> wrote:
> >>>
> >>> On Thu, Jun 15, 2023 at 9:01=E2=80=AFAM Anna Schumaker <schumaker.ann=
a@gmail.com> wrote:
> >>>>
> >>>> On Thu, Jun 15, 2023 at 4:55=E2=80=AFAM Krzysztof Kozlowski
> >>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>
> >>>>> On 15/06/2023 10:52, Krzysztof Kozlowski wrote:
> >>>>>> On 14/06/2023 22:55, Anna Schumaker wrote:
> >>>>>>>>>> Still null ptr (built on 420b2d4 with your patch):
> >>>>>>>>>
> >>>>>>>>> We're through the merge window and at rc1 now, so I can spend m=
ore
> >>>>>>>>> time scratching my head over your bug again. We've come up with=
 a
> >>>>>>>>> patch (attached) that adds a bunch of printks to show us what t=
he
> >>>>>>>>> kernel thinks is going on. Do you mind trying it out and lettin=
g us
> >>>>>>>>> know what gets printed out? You'll need to make sure
> >>>>>>>>> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.
> >>>>>>>>
> >>>>>>>> The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-2023=
0609.
> >>>>>>>
> >>>>>>> Can you try the attached patch on top of my 3-patch series from t=
he
> >>>>>>> other day, and let me know what gets printed out? It adds a bunch=
 of
> >>>>>>> printk()s at strategic points to print out what is going on with =
the
> >>>>>>> xdr scratch buffer since it's suddenly a bad memory address after
> >>>>>>> working for a bit on your machine.
> >>>>>>>
> >>>>>>
> >>>>>> Here you have entire log - attached (113 kB, I hope goes past mail=
ing
> >>>>>> lists/spam filters).
> >>>>>
> >>>>> As expected this bounced from the mailing lists, but I hope you got=
 it.
> >>>>> If not, let me know.
> >>>>
> >>>> I did still receive it. Thanks!
> >>>
> >>> Can you swap out yesterday's patch with this patch? I've adjusted wha=
t
> >>> gets printed out, and added printk()s to xdr_copy_to_scratch().  I'm
> >>> starting to think that the xdr scratch buffer is fine, and that it's
> >>> the other pointer passed to memcpy() in that function that's the
> >>> problem, and the output from this patch will confirm for me.
> >>
> >> Oh, and can you add this one on top of the v2 patch as well?
> >
> > Sorry about the noise today. Can you use this patch instead of the two
> > I attached earlier? I cleaned up the output and cut down on extra
> > output..
> >
>
> Here you have - attached.

This is good, thanks! I was finally able to figure out how to hit the
bug using a 32bit x86 VM, so hopefully the next thing you hear from me
is a patch fixing the bug!

Anna

>
>
> Best regards,
> Krzysztof
