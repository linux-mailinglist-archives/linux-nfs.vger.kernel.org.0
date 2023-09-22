Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D337ABAC9
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 23:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjIVVAn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 17:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIVVAm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 17:00:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B541102
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 14:00:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c02f371fccso8827131fa.0
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1695416432; x=1696021232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7+A4x8AojOFChIXYgxF+9JsnZkvN0bxLe0sXYCHV4c=;
        b=AGU19nzrByQZMfyy30rc/XEQQjK4MKtr+jfLf8jaMnKHkDr8dGeViZP7h9N/ofrZLl
         DtdY83kYQGUtT4YyuvIJB1xBY269oY26crS3lUv8E6lQjn0XtCyyk6ZsqYBrOkVBlUtd
         1v7weGmHVLXIuQa2NyXCJzlDGr8f+OHR+YWy2WO+j8NT0xv6xviNn12eR3/9R4gA9403
         6I2yGapCPhWlKTgA5pUVaLkeTF0zsktghyHFAwImD3e52fAyxjphHJaVbfgxAJBGzEkX
         If6S4YFsxJ+I4WQ5gyNCctwNuI88k9+WgRbR7oFSKzu5CP0W3QadFd+lfK17bIMmprjA
         jgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695416432; x=1696021232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7+A4x8AojOFChIXYgxF+9JsnZkvN0bxLe0sXYCHV4c=;
        b=KLgsixcBwb9yvD9ho/lw8uBvFfF34q2YYUZ9wvR5Sge430lIl87v3Y9kR2P/m8WqKA
         4RllE4qmzRUowRrJGY/yOWt34qeYmUWXQZB9MVvJyEblj46RYaZ80dJnlec0nfPl1u13
         9LfqvVck3sTbYODcxYAtcOVGSmC/S6qZiqWq5eB0x5ppJGnzFGFwFduqrAgt6yixiwH3
         b4uAffLj95Oq2TqoQH2O+A/JltKgXWBswsf5lwNzVxuKBZFuKlviTInXuemoWvJ/D5fu
         YWMgVNDhai9FlJR/5ZIPDa5uMee0m8PBPj+7Rbtao58C0MQ2svPbqdRhGhKLtHY3STWw
         Yrfw==
X-Gm-Message-State: AOJu0Yw6Lq/4fXb4PSfvIRemf4J2wdH5BifTmPLPjhX+T9UZdevswuDu
        cvlLUSNogAgXyOBtXvonA02c6Ea6rkDP5Iyl3C47Y5J4
X-Google-Smtp-Source: AGHT+IEhHTLKpGy0EW6BHNAuT6A8M14Ax1Gvo9WVQyP0pQnhdJ0VgXkd66p5g7VASJUutMOGCi9H8dmwBcmZPde5uyA=
X-Received: by 2002:a2e:2203:0:b0:2bb:8d47:9d95 with SMTP id
 i3-20020a2e2203000000b002bb8d479d95mr278517lji.2.1695416432289; Fri, 22 Sep
 2023 14:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230917230551.30483-1-trondmy@kernel.org> <20230917230551.30483-2-trondmy@kernel.org>
 <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>
 <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>
 <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com> <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
In-Reply-To: <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Fri, 22 Sep 2023 17:00:20 -0400
Message-ID: <CAN-5tyE8u1HCrS9KWQywc3BDvPG2ceZG4kn_vDkJjS-W2mL1KQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 22, 2023 at 3:05=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Fri, 2023-09-22 at 13:22 -0400, Olga Kornievskaia wrote:
> > On Wed, Sep 20, 2023 at 8:27=E2=80=AFPM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Wed, 2023-09-20 at 15:38 -0400, Anna Schumaker wrote:
> > > > Hi Trond,
> > > >
> > > > On Sun, Sep 17, 2023 at 7:12=E2=80=AFPM <trondmy@kernel.org> wrote:
> > > > >
> > > > > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > > >
> > > > > Commit 4dc73c679114 reintroduces the deadlock that was fixed by
> > > > > commit
> > > > > aeabb3c96186 ("NFSv4: Fix a NFSv4 state manager deadlock")
> > > > > because
> > > > > it
> > > > > prevents the setup of new threads to handle reboot recovery,
> > > > > while
> > > > > the
> > > > > older recovery thread is stuck returning delegations.
> > > >
> > > > I'm seeing a possible deadlock with xfstests generic/472 on NFS
> > > > v4.x
> > > > after applying this patch. The test itself checks for various
> > > > swapfile
> > > > edge cases, so it seems likely something is going on there.
> > > >
> > > > Let me know if you need more info
> > > > Anna
> > > >
> > >
> > > Did you turn off delegations on your server? If you don't, then
> > > swap
> > > will deadlock itself under various scenarios.
> >
> > Is there documentation somewhere that says that delegations must be
> > turned off on the server if NFS over swap is enabled?
>
> I think the question is more generally "Is there documentation for NFS
> swap?"
>
> >
> > If the client can't handle delegations + swap, then shouldn't this be
> > solved by (1) checking if we are in NFS over swap and then
> > proactively
> > setting 'dont want delegation' on open and/or (2) proactively return
> > the delegation if received so that we don't get into the deadlock?
>
> We could do that for NFSv4.1 and NFSv4.2, but the protocol will not
> allow us to do that for NFSv4.0.
>
> >
> > I think this is similar to Anna's. With this patch, I'm running into
> > a
> > problem running against an ONTAP server using xfstests (no problems
> > without the patch). During the run two stuck threads are:
> > [root@unknown000c291be8aa aglo]# cat /proc/3724/stack
> > [<0>] nfs4_run_state_manager+0x1c0/0x1f8 [nfsv4]
> > [<0>] kthread+0x100/0x110
> > [<0>] ret_from_fork+0x10/0x20
> > [root@unknown000c291be8aa aglo]# cat /proc/3725/stack
> > [<0>] nfs_wait_bit_killable+0x1c/0x88 [nfs]
> > [<0>] nfs4_wait_clnt_recover+0xb4/0xf0 [nfsv4]
> > [<0>] nfs4_client_recover_expired_lease+0x34/0x88 [nfsv4]
> > [<0>] _nfs4_do_open.isra.0+0x94/0x408 [nfsv4]
> > [<0>] nfs4_do_open+0x9c/0x238 [nfsv4]
> > [<0>] nfs4_atomic_open+0x100/0x118 [nfsv4]
> > [<0>] nfs4_file_open+0x11c/0x240 [nfsv4]
> > [<0>] do_dentry_open+0x140/0x528
> > [<0>] vfs_open+0x30/0x38
> > [<0>] do_open+0x14c/0x360
> > [<0>] path_openat+0x104/0x250
> > [<0>] do_filp_open+0x84/0x138
> > [<0>] file_open_name+0x134/0x190
> > [<0>] __do_sys_swapoff+0x58/0x6e8
> > [<0>] __arm64_sys_swapoff+0x18/0x28
> > [<0>] invoke_syscall.constprop.0+0x7c/0xd0
> > [<0>] do_el0_svc+0xb4/0xd0
> > [<0>] el0_svc+0x50/0x228
> > [<0>] el0t_64_sync_handler+0x134/0x150
> > [<0>] el0t_64_sync+0x17c/0x180
>
> Oh crap... Yes, that is a bug. Can you please apply the attached patch
> on top of the original, and see if that fixes the problem?

I can't consistently reproduce the problem. Out of several xfstests
runs a couple got stuck in that state. So when I apply that patch and
run, I can't tell if i'm no longer hitting or if I'm just not hitting
the right condition.

Given I don't exactly know what's caused it I'm trying to find
something I can hit consistently. Any ideas? I mean this stack trace
seems to imply a recovery open but I'm not doing any server reboots or
connection drops.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
