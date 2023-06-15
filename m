Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24328731973
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jun 2023 15:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbjFONB1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jun 2023 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbjFONB0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Jun 2023 09:01:26 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFD02704;
        Thu, 15 Jun 2023 06:01:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f86a7f3a65so29435351cf.0;
        Thu, 15 Jun 2023 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686834082; x=1689426082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzzubgBVt/J0nhYq2hKWgLyD/ISUfZBJNfYWWUP1FQE=;
        b=NVkPW3sSJz8Ti0OLHUwsQMACcGifVQZarMa9af3J9v7HIiAdbCMuVVow5wmCtXlltO
         MW9V93ISS7DGuX0zeRDHvXLB+RrMDvnq1nIBIGKEA3CR8vDqwE4m9UFzGOMb25HnmLWF
         xHXjGUqFgfzH6OKyyNbsMduwcpodYZJse5Bon6Ypg6UB2rZLWlOkB6j+MLevlZFD/67K
         PmK0k6Lh1NCThLxwsg93FCoju/8JN3DPGWLjzfnvSCag9q1tMxzgDI2V98RTME/KI+rG
         K6WEUD1A9z4YdgkIqntvhwx7E9LCOp/tDgTROuBi/jZegsbsXBO0GO7clHuIrLsrNEHd
         NLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834082; x=1689426082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzzubgBVt/J0nhYq2hKWgLyD/ISUfZBJNfYWWUP1FQE=;
        b=k7iEuG9q0KqBBkRwkaB0a0EOQhlTuxN26/q4pS+CpTrFbuI0JLTybSLJvGOBdOaMDr
         uWhH+19UTigT/gOmYGvOYNB0fG5W1+llILLPjym4sFNwbkeTb+rWDn6f3ncE+wl+17BY
         eW05qzFZhcL2pqdO8HE2GtpURPGRWktDMCPGAh6PuSPByH+FCYO3y/Uu4g6ik3fFk+xB
         PCnzKcLixGIMSsypZcfCEoYtPLT+IrDeztXpQSC72hPjrhhaYJmlogdJ9sbaSwsJ0sYN
         5vZWvDi/hFchdd2DMUd/y7aBNcNBWQqCrg1ewkLMtMki2Duy4PEZVWIHPN+j/go6Bbqc
         4RSw==
X-Gm-Message-State: AC+VfDzXOAI9iYWq4w83+WJyEhVeeTDDKI+Av4nUz7z/RDQ7xa51sAGg
        9jcURn7go7PZyyq26dYXcBSZGt8/2D6ood5J/aY=
X-Google-Smtp-Source: ACHHUZ6ylbf4BRxvTAx0QGSZ0SFgescSs+d4NQ+GPGVU5MPdz5hjOXzBWLTzX6pUzQ995la95FLpjPN00bR8sR+CfdM=
X-Received: by 2002:a05:622a:54b:b0:3ed:86f6:6ecf with SMTP id
 m11-20020a05622a054b00b003ed86f66ecfmr6189795qtx.46.1686834081704; Thu, 15
 Jun 2023 06:01:21 -0700 (PDT)
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
In-Reply-To: <c8d454b0-d355-f599-f720-b7e64374fb56@linaro.org>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 15 Jun 2023 09:01:05 -0400
Message-ID: <CAFX2JfmvMZ7DzD9znWeOHXywgPbUKDS1irMjUerEuborjRBpcg@mail.gmail.com>
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

On Thu, Jun 15, 2023 at 4:55=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/06/2023 10:52, Krzysztof Kozlowski wrote:
> > On 14/06/2023 22:55, Anna Schumaker wrote:
> >>>>> Still null ptr (built on 420b2d4 with your patch):
> >>>>
> >>>> We're through the merge window and at rc1 now, so I can spend more
> >>>> time scratching my head over your bug again. We've come up with a
> >>>> patch (attached) that adds a bunch of printks to show us what the
> >>>> kernel thinks is going on. Do you mind trying it out and letting us
> >>>> know what gets printed out? You'll need to make sure
> >>>> CONFIG_NFS_V4_2_READ_PLUS is enabled when compiling the kernel.
> >>>
> >>> The patch does not apply. I tried: v6.4-rc1, v6.4-rc5, next-20230609.
> >>
> >> Can you try the attached patch on top of my 3-patch series from the
> >> other day, and let me know what gets printed out? It adds a bunch of
> >> printk()s at strategic points to print out what is going on with the
> >> xdr scratch buffer since it's suddenly a bad memory address after
> >> working for a bit on your machine.
> >>
> >
> > Here you have entire log - attached (113 kB, I hope goes past mailing
> > lists/spam filters).
>
> As expected this bounced from the mailing lists, but I hope you got it.
> If not, let me know.

I did still receive it. Thanks!

Anna
>
> Best regards,
> Krzysztof
>
