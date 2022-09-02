Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D285AA505
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 03:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiIBB1r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 21:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiIBB1q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 21:27:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FDB9FAB8
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 18:27:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c59so821754edf.10
        for <linux-nfs@vger.kernel.org>; Thu, 01 Sep 2022 18:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DQxuj9RL2cs5bylexEdTY0x0pSvnLA10IGivwaFe8Fw=;
        b=iz8cGlQcT7Qv1+2OGsN+MuZgO140gYavfRdojgmtVW3zC29N5w0sEgS381paWC6KrF
         aSs2BsPQ9Npr5j4TuvTf4dJt87jo/dhFPd82vySnKk1agJa7RFJSswYtunN1XmM2tl8m
         EU+eMUaoPgoHgj4NtE0rRwK6DDvc7+JGk7JziC6VLOYQSIkLS01AJq2J/CXKEr8tw8GJ
         WXefqdL6F5H+zBUAVH1LkvHE9myQK+7ZL4ZhBphKlgKjh9S1hiLfSzZqWFdYq0y4GOvg
         kSfGIiG8TmbAeQyNSVfOLB4qd05F17IjNxZRjO2lWiaEHvXSTZMa+zRnuw8pWr6iFJaA
         BEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DQxuj9RL2cs5bylexEdTY0x0pSvnLA10IGivwaFe8Fw=;
        b=dsxdGof6kQwZxNJvhqevCBq7AFpzwNF7rAaAy4/i8IGd+QqlYAjkuOMrBkcIBfQoqU
         dRHhE5cIKuACQvGrBiylqZahWMDwMFh3hdX8cWyfzqG1RxHoIa5UKHkEiIFUgN9mFVln
         WYoegWOA2Uoedomn4zM9IkcUgPfaX2j3YrPrgb17LVH6WR3DKwUzzOkLUjYuBJQDYM7o
         cExiGHz0aEH2ieHd0JMksBwNb1f7dbZaFnGUfOcL3AQOT9POesbn5oSo7OWiDJZYJB5S
         VLrijoKjPuRVj2dut1WsHrgckakwFPTFxGmEiGMb6belzuL7EJ4BzAhL2apSWUG9GjcY
         A62w==
X-Gm-Message-State: ACgBeo0xUdO0rX400Jgm9+vnBF+iVNGdV5GH2zG1avWpteCYIl3P5cz5
        dRA72bjqUaURr52KUCZ/sbIHTTcd7zGW+p+mdL4=
X-Google-Smtp-Source: AA6agR6ZaqvMBo0r5FOiCdNqfeI0LEVj45siNNJqd3UncCtG4Ta5nwqLNGmOwJ3XFzR9HRZBk0jLtbDl4K20jUW2TeA=
X-Received: by 2002:a05:6402:4511:b0:43b:a182:8a0a with SMTP id
 ez17-20020a056402451100b0043ba1828a0amr31014947edb.410.1662082063966; Thu, 01
 Sep 2022 18:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyGkHd+wEHC5NwQGRuQsJie+aPu0RkWNrp_wFo4e+JcQgA@mail.gmail.com>
 <5c423fdf25e6cedb2dcdbb9c8665d6a9ab4ad4b1.camel@kernel.org>
 <CAN-5tyEOTVDhR6FgP7nPVon76qhKkexaWB8AJ_iBVTp6iYOk1g@mail.gmail.com> <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
In-Reply-To: <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 1 Sep 2022 21:27:32 -0400
Message-ID: <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
Subject: Re: Is this nfsd kernel oops known?
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Sep 1, 2022 at 4:09 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Sep 1, 2022, at 9:51 AM, Olga Kornievskaia <aglo@umich.edu> wrote:
> >
> > On Tue, Aug 30, 2022 at 1:49 PM Jeff Layton <jlayton@kernel.org> wrote:
> >>
> >> On Tue, 2022-08-30 at 13:14 -0400, Olga Kornievskaia wrote:
> >>> Hi folks,
> >>>
> >>> Is this a known nfsd kernel oops in 6.0-rc1. Was running xfstests on
> >>> pre-rhel-9.1 client against 6.0-rc1 server when it panic-ed.
> >>>
> >>> [ 5554.769159] BUG: KASAN: null-ptr-deref in kernel_sendpage+0x60/0x220
> >>> [ 5554.770526] Read of size 8 at addr 0000000000000008 by task nfsd/2590
> >>> [ 5554.771899]
> >>
> >> No, I haven't seen this one. I'm guessing the page pointer passed to
> >> kernel_sendpage was probably NULL, so this may be a case where something
> >> walked off the end of the rq_pages array?
> >>
> >> Beyond that I can't tell much from just this stack trace. It might be
> >> nice to see what line of code kernel_sendpage+0x60 refers to on your
> >> kernel.
> >
> > After getting debug symbols this is what gdb told me...
> >
> > (gdb) l *(kernel_sendpage+0x60)
> > 0xffffffff81cbd570 is in kernel_sendpage (./include/linux/page-flags.h:487).
> > 482 TESTCLEARFLAG(LRU, lru, PF_HEAD)
> > 483 PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
> > 484 TESTCLEARFLAG(Active, active, PF_HEAD)
> > 485 PAGEFLAG(Workingset, workingset, PF_HEAD)
> > 486 TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
> > 487 __PAGEFLAG(Slab, slab, PF_NO_TAIL)
> > 488 __PAGEFLAG(SlobFree, slob_free, PF_NO_TAIL)
> > 489 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)   /* Used by some filesystems */
> > 490
> > 491 /* Xen */
> >
> > I'm unable to complete a git bisect. Could somebody suggest what to do
> > when a git bisect midpoint results in an unbootable kernel? I can't
> > "skip" this point can I? I'm not sure if marking it "bad" makes sense
> > since it's not relevant to the actual problem.
>
> Try skipping. I think "git bisect" is supposed to be smart enough
> to figure things out after a skip.
>
> If not, start over and pick endpoints that you think might avoid
> the unbootable kernels. Even adjusting one endpoint a little
> might be enough to make bisect pick new targets that avoid the
> unbootable kernels.

Thanks Chuck. I first, based on a hunch, narrowed down that it's
coming from Al Viro's merge commit. Then I git bisected his 32patches
to the following commit f0f6b614f83dbae99d283b7b12ab5dd2e04df979

[aglo@ipa84 linux-nfs]$ git bisect log
git bisect start
# bad: [f30adc0d332fdfe5315cb98bd6a7ff0d5cf2aa38] Merge tag
'pull-work.iov_iter-rebased' of
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect bad f30adc0d332fdfe5315cb98bd6a7ff0d5cf2aa38
# good: [5d5d353bed32dc3ea52e2619e0d1c60b17133b91] Merge tag
'rproc-v5.20' of
git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
git bisect good 5d5d353bed32dc3ea52e2619e0d1c60b17133b91
# good: [68fe506f3731ecf7881de9512cc5f4c14fd13f3a] unify
xarray_get_pages() and xarray_get_pages_alloc()
git bisect good 68fe506f3731ecf7881de9512cc5f4c14fd13f3a
# good: [dc5801f60b269a73fcce789856c99d1845f75827] af_alg_make_sg():
switch to advancing variant of iov_iter_get_pages()
git bisect good dc5801f60b269a73fcce789856c99d1845f75827
# good: [746de1f86fcd33464acac047f111eea877f2f7a0] pipe_get_pages():
switch to append_pipe()
git bisect good 746de1f86fcd33464acac047f111eea877f2f7a0
# bad: [f0f6b614f83dbae99d283b7b12ab5dd2e04df979] copy_page_to_iter():
don't split high-order page in case of ITER_PIPE
git bisect bad f0f6b614f83dbae99d283b7b12ab5dd2e04df979



> --
> Chuck Lever
>
>
>
