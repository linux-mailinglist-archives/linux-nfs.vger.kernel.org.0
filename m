Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59817AEED8
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Sep 2023 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjIZOzb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 10:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjIZOzb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 10:55:31 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E01E6
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 07:55:24 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49334907238so3045955e0c.3
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695740123; x=1696344923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogwwEPMa8h2GBhOf4Oqk2ajjAq9Jd1T46SJLWRKRCuw=;
        b=Gb4mLuSBd9u5T8G6xoKHtpu2/xfrinUZ2P91RqeGLJOV+rYbC7wWRVjkQ1mQn7Wgp5
         8KD4RinIGQMM82b19Wtg4eoFIsr1z88Xp8ma4RV0uKsZX+0QZ3dEmkrH3Sj8xeblwOwf
         HnF8+ubKnVX8x+6VsyYiuY7hdlkPjO/+IW5MM/6XXgC5WVli4py/Nqi51njIKCElGI8u
         XkR4uKOjolOtHWyuQwApdRlC/dxaByEFtmIj4uRWowJq9HsqqxZ532mTzIpk/ABgoju+
         C0YuU31kwWx/Kd6r9sf3HHaqb1d/UX/rIiu4Pd82rA99igAR+fclDY8mQT1SRBFRPxQt
         CABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740123; x=1696344923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogwwEPMa8h2GBhOf4Oqk2ajjAq9Jd1T46SJLWRKRCuw=;
        b=kD5AAt/EBe5Van/eIdIrCWK9arvwZTADf/DsHsunx0Om38/45lGdCIRzmec6bvbVs8
         E3yTIo6siOQsARz7NptK5HNbL6yYoeOM8/unz9xgZ2958GdL6C26DiA3b03uVaAnZjWJ
         cpDb8kCatfnTRNI+c9ohkKONefmWZ9BNbauvCMg0iYeI0CqYk7AlVcRyfTDv3KmOHN5O
         NOzHhEYmS9QWO3a9oPvbJ4pF75nN9kCCTMH7P4bYmW1VVjG7XamiEdOOj85o+kA6hYWF
         +Kpu7qMwGEuQmNoje5KcLMWZGQ5SPURDj/gDQLG5YxJVnEHjq2rboWSor+CUmLlZ7955
         O8Dw==
X-Gm-Message-State: AOJu0YzV8kQqL0FNJFrOpO2MOL5lpsY8Kx9D3KjOgYs/e4OPHeKiU5TM
        Lie7rfqrimMnsJdcXaqsQu90t0BDwfnl3l32lfc=
X-Google-Smtp-Source: AGHT+IFlGS+nbrF9QlHN6U7otCnbYvFOU7YSrW2XrXySgmbeM6SDnEW2jO3ptk4G8kSj/uFtrKaOEEaD8OdTDhp0a4o=
X-Received: by 2002:a1f:6643:0:b0:487:d56f:fc82 with SMTP id
 a64-20020a1f6643000000b00487d56ffc82mr5952101vkc.6.1695740123217; Tue, 26 Sep
 2023 07:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230917230551.30483-1-trondmy@kernel.org> <20230917230551.30483-2-trondmy@kernel.org>
 <CAFX2Jfn-6J1RAiz7Vjjet+EW4jDFVRcQ9ahsZVp69AW=MC5tpg@mail.gmail.com>
 <9eda74d7438ee0a82323058b9d4c2b98f4e434cf.camel@hammerspace.com>
 <CAN-5tyEvYBr-bqOeO2Umt2DVa_CkKxT8_2Zo8Q1mfa9RN9VxQg@mail.gmail.com>
 <077cb75b44afd2404629c1388a92ca61da5092b1.camel@hammerspace.com>
 <CAN-5tyE8u1HCrS9KWQywc3BDvPG2ceZG4kn_vDkJjS-W2mL1KQ@mail.gmail.com>
 <c1c6106c3b4a6106ff706130fe551b424512dd34.camel@hammerspace.com> <29ac4c1f8017735a6d4f8e48e04172dc91d461ae.camel@hammerspace.com>
In-Reply-To: <29ac4c1f8017735a6d4f8e48e04172dc91d461ae.camel@hammerspace.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 26 Sep 2023 10:55:07 -0400
Message-ID: <CAFX2Jf=Kw2sSGuNLZoCF3w8x-DeO3L_y5ZGeQRurh6LTMo8Hxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] NFSv4: Fix a state manager thread deadlock regression
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "aglo@umich.edu" <aglo@umich.edu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "neilb@suse.de" <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Sep 24, 2023 at 1:08=E2=80=AFPM Trond Myklebust <trondmy@hammerspac=
e.com> wrote:
>
> On Fri, 2023-09-22 at 17:06 -0400, Trond Myklebust wrote:
> > On Fri, 2023-09-22 at 17:00 -0400, Olga Kornievskaia wrote:
> > > On Fri, Sep 22, 2023 at 3:05=E2=80=AFPM Trond Myklebust
> > > >
> > > > Oh crap... Yes, that is a bug. Can you please apply the attached
> > > > patch
> > > > on top of the original, and see if that fixes the problem?
> > >
> > > I can't consistently reproduce the problem. Out of several xfstests
> > > runs a couple got stuck in that state. So when I apply that patch
> > > and
> > > run, I can't tell if i'm no longer hitting or if I'm just not
> > > hitting
> > > the right condition.
> > >
> > > Given I don't exactly know what's caused it I'm trying to find
> > > something I can hit consistently. Any ideas? I mean this stack
> > > trace
> > > seems to imply a recovery open but I'm not doing any server reboots
> > > or
> > > connection drops.
> > >
> > > >
> >
> > If I'm right about the root cause, then just turning off delegations
> > on
> > the server, setting up a NFS swap partition and then running some
> > ordinary file open/close workload against the exact same server would
> > probably suffice to trigger your stack trace 100% reliably.
> >
> > I'll see if I can find time to test it over the weekend.
>
> >
>
> Yep... Creating a 4G empty file on /mnt/nfs/swap/swapfile, running
> mkswap  and then swapon followed by a simple bash line of
>         echo "foo" >/mnt/nfs/foobar
>
> will immediately lead to a hang. When I look at the stack for the bash
> process, I see the following dump, which matches yours:
>
> [root@vmw-test-1 ~]# cat /proc/1120/stack
> [<0>] nfs_wait_bit_killable+0x11/0x60 [nfs]
> [<0>] nfs4_wait_clnt_recover+0x54/0x90 [nfsv4]
> [<0>] nfs4_client_recover_expired_lease+0x29/0x60 [nfsv4]
> [<0>] nfs4_do_open+0x170/0xa90 [nfsv4]
> [<0>] nfs4_atomic_open+0x94/0x100 [nfsv4]
> [<0>] nfs_atomic_open+0x2d9/0x670 [nfs]
> [<0>] path_openat+0x3c3/0xd40
> [<0>] do_filp_open+0xb4/0x160
> [<0>] do_sys_openat2+0x81/0xe0
> [<0>] __x64_sys_openat+0x81/0xa0
> [<0>] do_syscall_64+0x68/0xa0
> [<0>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
> With the fix I sent you:
>
> [root@vmw-test-1 ~]# mount -t nfs -overs=3D4.2 vmw-test-2:/export /mnt/nf=
s
> [root@vmw-test-1 ~]# mkswap /mnt/nfs/swap/swapfile
> mkswap: /mnt/nfs/swap/swapfile: warning: wiping old swap signature.
> Setting up swapspace version 1, size =3D 4 GiB (4294963200 bytes)
> no label, UUID=3D1360b0a3-833a-4ba7-b467-8a59d3723013
> [root@vmw-test-1 ~]# swapon /mnt/nfs/swap/swapfile
> [root@vmw-test-1 ~]# ps -efww | grep manage
> root        1214       2  0 13:04 ?        00:00:00 [192.168.76.251-manag=
er]
> root        1216    1147  0 13:04 pts/0    00:00:00 grep --color=3Dauto m=
anage
> [root@vmw-test-1 ~]# echo "foo" >/mnt/nfs/foobar
> [root@vmw-test-1 ~]# cat /mnt/nfs/foobar
> foo
>
> So that returns behaviour to normal in my testing, and I no longer see
> the hangs.
>
> Let me send out a PATCHv2...

I'm liking patch v2 much better! I was testing with a Linux server
with default configuration, and it's nice that the xfstests swapfile
tests aren't hanging anymore :)

Anna

> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
