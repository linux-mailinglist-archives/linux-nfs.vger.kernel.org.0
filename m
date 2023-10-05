Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC77BA9EF
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 21:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjJETVK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 15:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjJETVJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 15:21:09 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADA8E7
        for <linux-nfs@vger.kernel.org>; Thu,  5 Oct 2023 12:21:07 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7b07719089aso880190241.0
        for <linux-nfs@vger.kernel.org>; Thu, 05 Oct 2023 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696533667; x=1697138467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3YAwa7B2OJPRUP59nwxn3A11jwk1jGLcSNDbqpCUEs=;
        b=I1tuKsyYs8KLTCBbO4XyPQD4vMYyicmH4C2pUL5fy9jhjOafmCKS8+sCGScEMItApK
         Lvp9GFIMpce5ZLEN1gEMVDTta2pLi8OToRgguuIS74ZMZQTwxA8jP/r3gs9QvdzU2gjN
         7uKt8otiw7vbK7e4ChAZH5MYKTmNXBq01j+R3ZowgBLXKvUAYJg1NVPRsQqT+0nLw7YS
         oKcnxe5pZlPQsOTIzATCDelznHj57UJavzTLLMBto0Ik+rNIiVApVUKysFz+t5U9zm21
         PcB2UeSDZrW1Rh5hN9/O4DxIYl5CUooWecyEQh/iKFShYjX8U/w4iE9DmVEyiOkYg3pd
         hupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696533667; x=1697138467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3YAwa7B2OJPRUP59nwxn3A11jwk1jGLcSNDbqpCUEs=;
        b=DFTsGS3JNfur9zmRJ+hHhC4qT3jVeoo9YgBdsy/LIR2v05ccou61Xp86hMfW4brU1v
         ItA7DNused0a9cOUVO8LTi8fyL+yu4cMsf3NIeuFq+zoh9D0bUoTWVrFT9riahiRUrZr
         DQcT/nw+AA2i83AV2gFTFQsW108kiruXJ/hgwfkBv/89fRRKapGcIE+Rq5cVsVp6KDBu
         2VdyhRrU6T5Q17Ved3bJV69Z9R8HHaZiLGm5tmRtPIaB6PNMxkedS/oYJ9GfYqVX+tge
         QTfFr2Es+BjsktQQD24BOtYQSltLBRSqnjyBlCv8QaPYnVZEiEqPAVOPxiHvkkxNgl32
         Dgug==
X-Gm-Message-State: AOJu0YxmwTOugifaYW1jO469ft11tWB1ki6vHdRs5Dz2kydLr+1WeW8v
        wlq/gqR4x6mT9+8pgy8KXo0k9VvkJXkokIqcW+aPZA==
X-Google-Smtp-Source: AGHT+IFhEXUCf6hg0p0VkgiUHPuy9O4n5JiWEsbvC4N0pJ6GZCevj6BKaE5f4ZMr3qR2O1q/atILq+7gURY5Qemu1P4=
X-Received: by 2002:a05:6122:4201:b0:49a:b587:ab79 with SMTP id
 cm1-20020a056122420100b0049ab587ab79mr1292189vkb.8.1696533666626; Thu, 05 Oct
 2023 12:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org> <CA+G9fYsqbZhSQnEi-qSc7n+4d7nPap8HWcdbZGWLfo3mTH-L7A@mail.gmail.com>
 <20231005172448.GA161140@pevik>
In-Reply-To: <20231005172448.GA161140@pevik>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 6 Oct 2023 00:50:55 +0530
Message-ID: <CA+G9fYuyXgWvsRhznP2x2VE5CvSyCCgcvxPz2J=dbvg6YW2iUA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-nfs@vger.kernel.org, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        LTP List <ltp@lists.linux.it>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Eryu Guan <eguan@redhat.com>, chrubis <chrubis@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 5 Oct 2023 at 22:54, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Naresh,
>
> > On Wed, 4 Oct 2023 at 23:41, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
>
> > > This is the start of the stable review cycle for the 6.1.56 release.
> > > There are 259 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
>
> > > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > > Anything received after that time might be too late.
>
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/pa=
tch-6.1.56-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git linux-6.1.y
> > > and the diffstat can be found below.
>
> > > thanks,
>
> > > greg k-h
>
> > Results from Linaro=E2=80=99s test farm.
> > Regressions on arm64 bcm2711-rpi-4-b device running LTP dio tests on
> Could you please note in your reports also LTP version?

Sure.
We are running LTP Version: 20230516 for our testing.

We will update the latest LTP release (20230929) next week.

> FYI the best LTP release is always the latest release or git master branc=
h.

We have two threads here.
1) LTP release tag testing on all stable-rc branches
2) LTP master testing on a given specific kernel version [a]

[a] https://qa-reports.linaro.org/lkft/ltp-master/

- Naresh
