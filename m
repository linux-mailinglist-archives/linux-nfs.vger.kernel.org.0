Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4A58B647
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Aug 2022 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiHFPDu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Aug 2022 11:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHFPDt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 6 Aug 2022 11:03:49 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3910544
        for <linux-nfs@vger.kernel.org>; Sat,  6 Aug 2022 08:03:47 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e15so7128948lfs.0
        for <linux-nfs@vger.kernel.org>; Sat, 06 Aug 2022 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MagR+H3j1Wi7fgh5X2ewupEON4K2U/z119MXqpg+iy4=;
        b=Zy+hgfV6yVzN7qhqbh1JEYdGaFwyYLTnLipJioFfjppOrLdTo353TN2ZCxuRnivmxM
         q1LfkEJAtr6tuC8y7qAtlHIsuzygfNBB4WXCqtZzlI4ZmgLiit3p/ZskILwJKq7LUWFx
         3tf1H8oetrhu1Yz/IJfB0jxEawVMj2o4sYUjnVNVoOREkAtsEk2dPPKE9U4QznEbIblp
         femgH9XqQqLibIF0ZYbjp1wWnZsgXFlEfFwpUemCHebig44Qkf2N9W3agfcT2ae04R3D
         oqIHVkZ4cxOzmac8uEMi0ajgSasrLhrenRuG/YFMaN6pshaRsEi7b+EagNbrM/MHOfn7
         02gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MagR+H3j1Wi7fgh5X2ewupEON4K2U/z119MXqpg+iy4=;
        b=JChkfarmS0Md2zs5z831mXf9fXG3AfftWy+m8TkWb/WXNN8F8bPvDt7+l5hpHAwR9m
         7N/QfE4V+DaRQh1eBDiHIsYbAXpaR5/JAVkCbrdL2Y1hVsP9a5xU6NC3I126Wj+j7nE2
         qVR2WRd3Pyknipf/uKNh0E0za3NoWJYrbtr6tSJ56KgKEHaG6KqdzG+XVWVwVYs3zoJI
         9S+o3E6K0LRX2s1TIRt22m57KCGshbuiYJsa17eNj5Vm0H2bJJi/X07KNrZYx0O4ySO6
         PE7IeqQp+k4Ou2gImUBAxZ7l0jI5hk7B91wcsB0le54PXxjKUXYlMBkiEgM9mcgNAHXs
         n0Sw==
X-Gm-Message-State: ACgBeo0+lIeh2Tx8ng221RMvFjGQ4c7Gt30CsFOgiAl/Y9jGi2gjFeEX
        a9u8Y6ajDvwGOyi3SKnOP4CoSR0FRrrIA4czU5hflA5ipcs=
X-Google-Smtp-Source: AA6agR51Me1tVQ18kNCIyTcAm07CqlAx3ciTEtFdncpPmPjk9+W91GJhiQAIG0nyHRo1PxaGFDpvrLg6phAxbQshKV8=
X-Received: by 2002:a19:5e55:0:b0:48a:f08a:6c3c with SMTP id
 z21-20020a195e55000000b0048af08a6c3cmr3847794lfi.56.1659798226150; Sat, 06
 Aug 2022 08:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAD15GZf0FtU81hwQ+brhnt+sv895=TpAuz-YrMtjfx__FJ28Gg@mail.gmail.com>
 <8ae13798a15c69cf16272579f49768ec92484584.camel@hammerspace.com>
In-Reply-To: <8ae13798a15c69cf16272579f49768ec92484584.camel@hammerspace.com>
From:   Jan Kasiak <j.kasiak@gmail.com>
Date:   Sat, 6 Aug 2022 11:03:34 -0400
Message-ID: <CAD15GZfmpdzMhXquciebs5M4e2kewu+yTUcTx9c-jeSXgZS+XQ@mail.gmail.com>
Subject: Re: Question about nlmclnt_lock
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

The v4 RFCs do mention protocol design flaws, but don't go into more detail.

I was trying to understand those flaws in order to understand how and
why v3 was problematic.

-Jan


On Fri, Aug 5, 2022 at 10:27 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Fri, 2022-08-05 at 19:17 -0400, Jan Kasiak wrote:
> > Hi,
> >
> > I was looking at the code for nlmclnt_lock and wanted to ask a
> > question about how the Linux kernel client and the NLM 4 protocol
> > handle some errors around certain edge cases.
> >
> > Specifically, I think there is a race condition around two threads of
> > the same program acquiring a lock, one of the threads being
> > interrupted, and the NFS client sending an unlock when none of the
> > program threads called unlock.
> >
> > On NFS server machine S:
> > there exists an unlocked file F
> >
> > On NFS client machine C:
> > in program P:
> > thread 1 tries to lock(F) with fd A
> > thread 2 tries to lock(F) with fd B
> >
> > The Linux client will issue two NLM_LOCK calls with the same svid and
> > same range, because it uses the program id to map to an svid.
> >
> > For whatever reason, assume the connection is broken (cable gets
> > pulled etc...)
> > and `status = nlmclnt_call(cred, req, NLMPROC_LOCK);` fails.
> >
> > The Linux client will retry the request, but at some point thread 1
> > receives a signal and nlmclnt_lock breaks out of its loop. Because
> > the
> > Linux client request failed, it will fall through and go to the
> > out_unlock label, where it will want to send an unlock request.
> >
> > Assume that at some point the connection is reestablished.
> >
> > The Linux kernel client now has two outstanding lock requests to send
> > to the remote server: one for a lock that thread 2 is still trying to
> > acquire, and one for an unlock of thread 1 that failed and was
> > interrupted.
> >
> > I'm worried that the Linux client may first send the lock request,
> > and
> > tell thread 2 that it acquired the lock, and then send an unlock
> > request from the cancelled thread 1 request.
> >
> > The server will successfully process both requests, because the svid
> > is the same for both, and the true server side state will be that the
> > file is unlocked.
> >
> > One can talk about the wisdom of using multiple threads to acquire
> > the
> > same file lock, but this behavior is weird, because none of the
> > threads called unlock.
> >
> > I have experimented with reproducing this, but have not been
> > successful in triggering this ordering of events.
> >
> > I've also looked at the code of in clntproc.c and I don't see a spot
> > where outstanding failed lock/unlock requests are checked while
> > processing lock requests?
> >
> > Thanks,
> > -Jan
>
> Nobody here is likely to want to waste much time trying to 'fix' the
> NLM locking protocol. The protocol itself is known to be extremely
> fragile, and the endemic problems constitute some of the main
> motivations for the development of the NFSv4 protocol
> (See https://datatracker.ietf.org/doc/html/rfc2624#section-8
> and https://datatracker.ietf.org/doc/html/rfc7530#section-9).
>
> If you need more reliable support for POSIX locks beyond what exists
> today for NLM, then please consider NFSv4.
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
