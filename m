Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBC3EC6A1
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Aug 2021 03:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhHOBY2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 Aug 2021 21:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhHOBY1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 Aug 2021 21:24:27 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEA2C061764
        for <linux-nfs@vger.kernel.org>; Sat, 14 Aug 2021 18:23:58 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d1so16713164pll.1
        for <linux-nfs@vger.kernel.org>; Sat, 14 Aug 2021 18:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=71/rYXFFR+lYpJLFLwn15vWcietufe8jW+ZEomEFgs4=;
        b=pq98J5hd8qObSM7B1+++fJRnfwAazRvxXMx381VfR0q3cvYcDiLiIakbgA489cqFrP
         JSBGVfrXtK0y99QCgOuuJG0YgqISI9yLXD/3gNIeqto/qKL+s4ahe3hptnhd34EUffkb
         Zdr80q+YB17PzU1BNuYOzBjaXS8a06kU7tqxnevwP13zqJSI9WES9ZMDQ/GEYVxFjvFZ
         OgzQe89yVNaHfOA6qQ+hEnjkXxKnGK5PerVLz3BD8RwdS5VPOOChVnSGbY+JvCT0sAnX
         EJvpgDZ3dqgaegpXEZOdc0h1GPN3tZyHdMn//33yDAvOKWQcrSZ5OmqytW4W2wwr3KGS
         XPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=71/rYXFFR+lYpJLFLwn15vWcietufe8jW+ZEomEFgs4=;
        b=pe3zISFveNYCqLJIfHg8GJDweKSxQXAagp9mNTPy7evJkNAb3X87mrztaybhmAz35s
         N+l05I/ZaYOIlbAUwJ3dHWxplGCtgn9uKgZcACAOH44OzJagb4Ny6SrOcivTV8OPFI8b
         Uz209RKCj1zvQ1PSGCC8FMzi6VvXxoDZvYK1zgauE/9JMcn7jqiP0Y4lKMph8Mm1KHz3
         CypYFS3Wcr1G8Z6CxioaqVkR3J4zqB+iUa05iUbJ5GtTIfwoVEuXvWVKlavPkksDgMrv
         LwnJyF3yoWj+DQ2FnJFb0tmx82HOeqaOlssMnRkz/Ks10SCV5Zuadrf6d6pHym1Xnl95
         9uhw==
X-Gm-Message-State: AOAM531kDZeahUklqKBGocvVqPodc7UOzEdUBdN6QqraaOHoDV83JjZK
        YwW8LWvPXkbIsu/YhaYn7sMtY2g464s3rEdLwWU=
X-Google-Smtp-Source: ABdhPJwfD3FNhEpvyWCDdcXSz3qoqoQWvbeWu/0vRDMz3qhdWaWvkULe6l9XQ8awLKTJ9bEFkdr3Gfa2gJhJXIt/Nk4=
X-Received: by 2002:a65:4486:: with SMTP id l6mr8894837pgq.145.1628990637772;
 Sat, 14 Aug 2021 18:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
 <162882238416.1695.4958036322575947783@noble.neil.brown.name> <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
In-Reply-To: <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Sat, 14 Aug 2021 18:23:46 -0700
Message-ID: <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I managed to get a cap with several discreet freezes in it, and I
included a chunk with 5 of them in the span of ~3000 frames. I added
packet comments at each frame that the tshark command reported as > 1
sec RPC wait. Just search for "Freeze" in (wire|t)shark in packet
details. This is with kernel 5.13.10 provided by Arch (See
https://github.com/archlinux/linux/compare/a37da2be8e6c85...v5.13.10-arch1
for diff vs mainline, nothing NFS/RPC related I can identify).

I tried unsuccessfully to get any failures with the 5.12.15 kernel.

https://drive.google.com/file/d/1T42iX9xCdF9Oe4f7JXsnWqD8oJPrpMqV/view?usp=sharing

File should be downloadable anonymously.

- mike

On Thu, Aug 12, 2021 at 7:53 PM Mike Javorski <mike.javorski@gmail.com> wrote:
>
> The "semi-known-good" has been the client. I tried updating the server
> multiple times to a 5.13 kernel and each time had to downgrade to the
> last 5.12 kernel that ArchLinux released (5.12.15) to stabilize
> performance. At each attempt, the client was running the same 5.13
> kernel that was being deployed to the server. I never downgraded the
> client.
>
> Thank you for the scripts and all the details, I will test things out
> this weekend when I can dedicate time to it.
>
> - mike
>
> On Thu, Aug 12, 2021 at 7:39 PM NeilBrown <neilb@suse.de> wrote:
> >
> > On Fri, 13 Aug 2021, Mike Javorski wrote:
> > > Neil:
> > >
> > > Apologies for the delay, your message didn't get properly flagged in my email.
> >
> > :-)
> >
> > >
> > > To answer your questions, both client (my Desktop PC) and server (my
> > > NAS) are running ArchLinux; client w/ current kernel (5.13.9), server
> > > w/ current or alternate testing kernels (see below).
> >
> > So the bug could be in the server or the client.  I assume you are
> > careful to test a client against a know-good server, or a server against
> > a known-good client.
> >
> > >                                                                 I
> > > intend to spend some time this weekend attempting to get the tcpdump.
> > > My initial attempts wound up with 400+Mb files which would be
> > > difficult to ship and use for diagnostics.
> >
> > Rather than you sending me the dump, I'll send you the code.
> >
> > Run
> >   tshark -r filename -d tcp.port==2049,rpc -Y 'tcp.port==2049 && rpc.time > 1'
> >
> > This will ensure the NFS traffic is actually decoded as NFS and then
> > report only NFS(rpc) replies that arrive more than 1 second after the
> > request.
> > You can add
> >
> >     -T fields -e frame.number -e rpc.time
> >
> > to find out what the actual delay was.
> >
> > If it reports any, that will be interesting.  Try with a larger time if
> > necessary to get a modest number of hits.  Using editcap and the given
> > frame number you can select out 1000 packets either side of the problem
> > and that should compress to be small enough to transport.
> >
> > However it might not find anything.  If the reply never arrives, you'll
> > never get a reply with a long timeout.  So we need to check that
> > everything got a reply...
> >
> >  tshark -r filename -t tcp.port==2049,rpc  \
> >    -Y 'tcp.port==2049 && rpc.msg == 0' -T fields \
> >    -e rpc.xid -e frame.number | sort > /tmp/requests
> >
> >  tshark -r filename -t tcp.port==2049,rpc  \
> >    -Y 'tcp.port==2049 && rpc.msg == 1' -T fields \
> >    -e rpc.xid -e frame.number | sort > /tmp/replies
> >
> >  join -a1 /tmp/requests /tmp/replies | awk 'NF==2'
> >
> > This should list the xid and frame number of all requests that didn't
> > get a reply.  Again, editcap can extract a range of frames into a file of
> > manageable size.
> >
> > Another possibility is that requests are getting replies, but the reply
> > says "NFS4ERR_DELAY"
> >
> >  tshark -r filename -t tcp.port==2049,rpc -Y nfs.nfsstat4==10008
> >
> > should report any reply with that error code.
> >
> > Hopefully something there will be interesting.
> >
> > NeilBrown
