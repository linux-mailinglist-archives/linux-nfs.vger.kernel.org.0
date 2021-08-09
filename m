Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F53D3E3D52
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 02:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhHIA3R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 20:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhHIA3R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 20:29:17 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96AAC061760
        for <linux-nfs@vger.kernel.org>; Sun,  8 Aug 2021 17:28:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id j3so14564403plx.4
        for <linux-nfs@vger.kernel.org>; Sun, 08 Aug 2021 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTQAbzTf9ULU0kxq5RVe3UvFkDJIkSogU54CcY+eeF4=;
        b=bfjqJjykzDBi01hxfPK2tUKnrh5Wk8kNPx1u7oZNjR/yJDSid8ddjwFPy4kjls6Vio
         pvPwcbpMikv/y5GU91WO4zpdug4yzbXUar+QXqPWTwuyb4rlGK1W6kGBR1R1m8yl2PrR
         Vm2sQsiUlxLgjynC927jxSK3K/Gci5R9vAB2VksoKQLEyqepAyBuuZN0o6Wso9yRL0Ut
         wBkXcmA/XYxVFDcfuQlBI7PHZgQ5iieh7Ooap/OvWpeGwgXmsOfJ2No9grLBz9jWcM6c
         O8zCP/wty7eb3pHDJtcT/rav2yQLk+eM9g1LCn2eB+c94oyEDWp2AOMeKzw0U79XAwQA
         6Vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTQAbzTf9ULU0kxq5RVe3UvFkDJIkSogU54CcY+eeF4=;
        b=A1jbFNCXk0WbgtBd5A8lt3uLp8ImuGzFkcXkbxf2lMLKEy2Ws6PYwk9ywSUcdXUFRt
         QFQ2C0fTqMQVN72EACpeSKo6NLE/AegAz9afZI1/8NisjFoXtgnWZdYeJ0wUctNr5eCK
         xekFclkVaN0MDngjZfDAItRv1uXpTfbqndwghhZHmChLzyc3qL65PX7BluQDAfKvGsLH
         e88ePDWKZiVC1iU/yguNyH6ckD5uwQWVAT5/GTVrfjgAiV0cWg3dzNyGasj7i6cvKL2b
         16LxTomzgn2OHKVfo1iv6KK//YGd25SmCzFGJ1sFTSuD0yotfBA/sWE5+bkV+RcFqLyv
         l4jQ==
X-Gm-Message-State: AOAM531IfT6F/f3zharZ/r62FwYSaI4OhEnF9pmp/Ki8iaZdps+cqrCx
        F3xDk5ZRlNXnoB5AHBJKVTO2oYaqkib9LmYJZOgql0EWfHk=
X-Google-Smtp-Source: ABdhPJyWNZ2gBBQuG7lJ++liv7Q1rZYSoJLFkIGtUOPiQnxMxNTSlFyrbhhgK0svspzcsPOFBGqFukAX0kQ9UvkZpNc=
X-Received: by 2002:a65:40c8:: with SMTP id u8mr50716pgp.145.1628468935277;
 Sun, 08 Aug 2021 17:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
In-Reply-To: <162846730406.22632.14734595494457390936@noble.neil.brown.name>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Sun, 8 Aug 2021 17:28:44 -0700
Message-ID: <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Appreciate the insights Neil. I will make an attempt to
trigger/capture the fault if I can.

- mike

On Sun, Aug 8, 2021 at 5:01 PM NeilBrown <neilb@suse.de> wrote:
>
> On Mon, 09 Aug 2021, Mike Javorski wrote:
> > I have been experiencing nfs file access hangs with multiple release
> > versions of the 5.13.x linux kernel. In each case, all file transfers
> > freeze for 5-10 seconds and then resume. This seems worse when reading
> > through many files sequentially.
>
> A particularly useful debugging tool for NFS freezes is to run
>
>   rpcdebug -m rpc -c all
>
> while the system appears frozen.  As you only have a 5-10 second window
> this might be tricky.
> Setting or clearing debug flags in the rpc module (whether they are
> already set or not) has a side effect if listing all RPC "tasks" which a
> waiting for a reply.  Seeing that task list can often be useful.
>
> The task list appears in "dmesg" output.  If there are not tasks
> waiting, nothing will be written which might lead you to think it didn't
> work.
>
> As Chuck hinted, tcpdump is invaluable for this sort of problem.
>   tcpdump -s 0 -w /tmp/somefile.pcap port 2049
>
> will capture NFS traffic.  If this can start before a hang, and finish
> after, it may contain useful information.  Doing that in a way that
> doesn't create an enormous file might be a challenge.  It would help if
> you found a way trigger the problem.  Take note of the circumstances
> when it seems to happen the most.  If you can only produce a large file,
> we can probably still work with it.
>   tshark -r /tmp/somefile.pcap
> will report the capture one line per packet.  You can look for the
> appropriate timestamp, note the frame numbers, and use "editcap"
> to extract a suitable range of packets.
>
> NeilBrown
>
>
> >
> > My server:
> > - Archlinux w/ a distribution provided kernel package
> > - filesystems exported with "rw,sync,no_subtree_check,insecure" options
> >
> > Client:
> > - Archlinux w/ latest distribution provided kernel (5.13.9-arch1-1 at writing)
> > - nfs mounted via /net autofs with "soft,nodev,nosuid" options
> > (ver=4.2 is indicated in mount)
> >
> > I have tried the 5.13.x kernel several times since the first arch
> > release (most recently with 5.13.9-arch1-1), all with similar results.
> > Each time, I am forced to downgrade the linux package to a 5.12.x
> > kernel (5.12.15-arch1 as of writing) to clear up the transfer issues
> > and stabilize performance. No other changes are made between tests. I
> > have confirmed the freezing behavior using both ext4 and btrfs
> > filesystems exported from this server.
> >
> > At this point I would appreciate some guidance in what to provide in
> > order to diagnose and resolve this issue. I don't have a lot of kernel
> > debugging experience, so instruction would be helpful.
> >
> > - mike
> >
> >
