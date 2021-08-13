Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03E93EAE4A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Aug 2021 03:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhHMBwV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Aug 2021 21:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHMBwV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Aug 2021 21:52:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDACC061756
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 18:51:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id w6so2852786plg.9
        for <linux-nfs@vger.kernel.org>; Thu, 12 Aug 2021 18:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZxXv421+RWilYuUCoIrdCe7+AHWPW+C3VaPMm9I46bQ=;
        b=LeMQ9BbsSKix7rE8B3sgwuUBkwB5drJVP0aHwC3VGD0AkpTxBY/IjOAyzop8AQ/fF3
         HyYl4XaWhtkCIa9dk3/FuBsg3Eqs077hq5lLfyOAi2+muh67uAmK3vzXXgicivVP/N1J
         WD0NZBL1Ck/ewHA6/+fc7sw60ZJ1fZXNWfnhcOTuyQqNOkajBeHL1nsQYSxMIrHHchYq
         c1jpHe/200k41y3BMaBWeClUWDnSoTSCuW+XSP7kO0iaE3g2bkoI6fcKvV/kBdWzAZgm
         C8DuAbFNfgA4blXp8W8nz5hWj8jIL06W8bh1oqaGpRUxNWi/4DQhrXIAdECqni2fj+IU
         SH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZxXv421+RWilYuUCoIrdCe7+AHWPW+C3VaPMm9I46bQ=;
        b=eLIK7JP5ZH3epW595XgCczvBS/Tyy7DMKLB+oRW48oRsXcDBOzOqIH+RZoV7C5JWrw
         WP/pZRkq62ODP268THtqOqVYSQNR+n/uYq07UKvSvD9rd0GC3EG2NBk+v6idaq8Rp0co
         uuhKaTcRByrJx8O9zV0Q6lfUeaYJSlNxPjmY8j8fhRZ5PdkwPKpa8TAXXRRfwpw2tQlF
         sQnTRJV/eZizgvbb4iNIUQyhK0qJTS8oE5fv6obyblntgwfD/kEHDRgSgpuXThl1hAcp
         f46oT8c9er8yXrskpMkgxVlTJf1jzjpc1/5XOk8xY88C2UMgl2hVpQO9FTFnrbwDIU1Z
         gleA==
X-Gm-Message-State: AOAM532wD7Z5q00ZUjzGesqS5Uh5xzgbZbO5hhUomjR0l/Qb46JNcz21
        gZcSe5+BXDWEf/j4FayS/tnE4tqEcmKmM/VlQUo=
X-Google-Smtp-Source: ABdhPJyO6qp4r9WPRJkmH7Rq7uRydcT6XD8XY4zTBPQMH1RDCdiKw3bnFhdOl6+UuGLiDzqIMTphXYECDf7IYn0vee0=
X-Received: by 2002:a05:6a00:ac6:b029:374:a33b:a74 with SMTP id
 c6-20020a056a000ac6b0290374a33b0a74mr23806pfl.51.1628819514539; Thu, 12 Aug
 2021 18:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com> <162855893202.12431.3423894387218130632@noble.neil.brown.name>
In-Reply-To: <162855893202.12431.3423894387218130632@noble.neil.brown.name>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Thu, 12 Aug 2021 18:51:43 -0700
Message-ID: <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Neil:

Apologies for the delay, your message didn't get properly flagged in my email.

To answer your questions, both client (my Desktop PC) and server (my
NAS) are running ArchLinux; client w/ current kernel (5.13.9), server
w/ current or alternate testing kernels (see below).
The server is running the kernel nfs server
The client is using the built-in nfs client, and the "mount" output
indicates it is using nfs with "ver=4.2"
Both machines are plugged into the same network switch.
At time of testing, there is only one client active.
The files in this case are static media files (some years old), and
there are no co-occurring writes to the files being read (or even to
the same directory)

It was suggested on my archlinux bug report that I try a kernel just
before the 5.13 NFS changes landed, and right after to see if they
trigger the behavior, as well as trying a vanilla 5.14 rc kernel. I
still need to test more, but I was able to get the freezes with
5.14-rc4, but so far inconclusive for the earlier 5.13 kernels. I
intend to spend some time this weekend attempting to get the tcpdump.
My initial attempts wound up with 400+Mb files which would be
difficult to ship and use for diagnostics.

- mike


On Mon, Aug 9, 2021 at 6:28 PM NeilBrown <neilb@suse.de> wrote:
>
> On Tue, 10 Aug 2021, Mike Javorski wrote:
> > Managed to get the rpcdebug info for some freezes today. I had a loop
> > running to call the rpcbind command that Neil provided and then sleep
> > for 2 seconds. Each triggering event was the opening of a new video
> > file (I was shuffling through files with mpv). I haven't managed to
> > get a tcp capture yet trying to get one that isn't too massive, but
> > the timing is tricky, and this doesn't happen every time.
> >
>
> Thanks for the logs.
>
> They show consistent "a:call_status" and "q:xprt_pending".  They also
> show a timeout in the range 10000-20000.  This number is in 'jiffies',
> which is normally millisecs, so 10 to 20 seconds.
>
> That means the RPC layer (thinks it has) sent a request (made a call)
> and is waiting for a reply to arrive over the network transport (i.e.
> the TCP connection).  However that would typically involve a much longer
> timeout.  For NFSv3 and 4.0, 60 seconds is the norm.  For NFSv4.1 I
> *think* there is no timeout as NFS never resends requests unless the TCP
> connection is broken.  So I don't know what to make of that.
>
> Given the fact that it recovers in 5-10 seconds, it seems very likely
> that it actually has sent the request (presumably the timeout doesn't
> expire).  Mostly likely the server is being delayed in replying.  A
> tcpdump trace would confirm this.
>
> I don't think you've said anything about what NFS server you are using.
> It is Linux, or something else?  If Linux, what kernel do you run there?
>
> One thing that might cause a delay when accessing a file is if some
> other client has a 'delegation' and takes a while to return it.
> e.g.
>   client2 creates a file for writing
>   server gives it a 'write delegation'
>   client2 queues up lots of write request
>   client1 asks to read the file.
>   server says to client2 "please return the delegation"
>   client2 starts flushing its data, but either takes too long or
>    has some other hiccup. Eventually it is returned, or the server
>    revokes it
>   server tells clients one it can read now.
>
> This is leading to me asking: do you have other NFS clients that might
> be accessing the same file, or might have accessed it recently?
>
> NeilBrown
>
>
> > -----------------------------
> >
> > [31229.965368] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31229.965370] 44224 c801      0 8c478d70 2473aa3b    15395  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31229.965411] 44225 c801      0 8c478d70 a7d3b9b8    15395  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31231.966982] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31231.966986] 44224 c801      0 8c478d70 2473aa3b    14795  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31231.967027] 44225 c801      0 8c478d70 a7d3b9b8    14795  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31233.968741] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31233.968745] 44224 c801      0 8c478d70 2473aa3b    14194  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31233.968787] 44225 c801      0 8c478d70 a7d3b9b8    14194  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> >
> > -----------------------------
> >
> > [31292.534529] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31292.534530] 45744 c801      0 8c478d70 2473aa3b    15340  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31292.534554] 45745 c801      0 8c478d70 50cbef7b    15342  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31294.536203] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31294.536206] 45744 c801      0 8c478d70 2473aa3b    14740  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31294.536232] 45745 c801      0 8c478d70 50cbef7b    14742  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31296.537826] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31296.537830] 45744 c801      0 8c478d70 2473aa3b    14139  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31296.537871] 45745 c801      0 8c478d70 50cbef7b    14141  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31298.539474] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31298.539478] 45744 c801      0 8c478d70 2473aa3b    13539  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31298.539522] 45745 c801      0 8c478d70 50cbef7b    13541  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31300.541040] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31300.541044] 46048 c801      0 8c478d70 50cbef7b    17965  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31300.541108] 46049 c801      0 8c478d70 2473aa3b    17965  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31302.542632] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31302.542635] 46922 c801      0 8c478d70 50cbef7b    18000  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> >
> > ---------------------------
> >
> > [31375.046020] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31375.046022] 47336 c801      0 8c478d70 cebaa9a6    15964  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31375.046048] 47337 c801      0 8c478d70 f7145d4d    15964  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31377.047361] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31377.047365] 47336 c801      0 8c478d70 cebaa9a6    15364  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31377.047406] 47337 c801      0 8c478d70 f7145d4d    15364  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31379.048801] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31379.048805] 47336 c801      0 8c478d70 cebaa9a6    14764  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31379.048845] 47337 c801      0 8c478d70 f7145d4d    14764  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31381.050376] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31381.050380] 47336 c801      0 8c478d70 cebaa9a6    14163  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31381.050421] 47337 c801      0 8c478d70 f7145d4d    14163  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31383.051746] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31383.051749] 47336 c801      0 8c478d70 cebaa9a6    13563  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31383.051775] 47337 c801      0 8c478d70 f7145d4d    13563  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31385.053182] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31385.053185] 47342 c801      0 8c478d70 f7145d4d    17980  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31387.054422] -pid- flgs status -client- --rqstp- -timeout ---ops--
> > [31387.054426] 47818 c801      0 8c478d70 f7145d4d    17761  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> > [31387.054467] 47819 c801      0 8c478d70 cebaa9a6    17762  8531859
> > nfsv4 READ a:call_status [sunrpc] q:xprt_pending
> >
> >
> > - mike
> >
> >
> > On Sun, Aug 8, 2021 at 5:28 PM Mike Javorski <mike.javorski@gmail.com> wrote:
> > >
> > > Appreciate the insights Neil. I will make an attempt to
> > > trigger/capture the fault if I can.
> > >
> > > - mike
> > >
> > > On Sun, Aug 8, 2021 at 5:01 PM NeilBrown <neilb@suse.de> wrote:
> > > >
> > > > On Mon, 09 Aug 2021, Mike Javorski wrote:
> > > > > I have been experiencing nfs file access hangs with multiple release
> > > > > versions of the 5.13.x linux kernel. In each case, all file transfers
> > > > > freeze for 5-10 seconds and then resume. This seems worse when reading
> > > > > through many files sequentially.
> > > >
> > > > A particularly useful debugging tool for NFS freezes is to run
> > > >
> > > >   rpcdebug -m rpc -c all
> > > >
> > > > while the system appears frozen.  As you only have a 5-10 second window
> > > > this might be tricky.
> > > > Setting or clearing debug flags in the rpc module (whether they are
> > > > already set or not) has a side effect if listing all RPC "tasks" which a
> > > > waiting for a reply.  Seeing that task list can often be useful.
> > > >
> > > > The task list appears in "dmesg" output.  If there are not tasks
> > > > waiting, nothing will be written which might lead you to think it didn't
> > > > work.
> > > >
> > > > As Chuck hinted, tcpdump is invaluable for this sort of problem.
> > > >   tcpdump -s 0 -w /tmp/somefile.pcap port 2049
> > > >
> > > > will capture NFS traffic.  If this can start before a hang, and finish
> > > > after, it may contain useful information.  Doing that in a way that
> > > > doesn't create an enormous file might be a challenge.  It would help if
> > > > you found a way trigger the problem.  Take note of the circumstances
> > > > when it seems to happen the most.  If you can only produce a large file,
> > > > we can probably still work with it.
> > > >   tshark -r /tmp/somefile.pcap
> > > > will report the capture one line per packet.  You can look for the
> > > > appropriate timestamp, note the frame numbers, and use "editcap"
> > > > to extract a suitable range of packets.
> > > >
> > > > NeilBrown
> > > >
> > > >
> > > > >
> > > > > My server:
> > > > > - Archlinux w/ a distribution provided kernel package
> > > > > - filesystems exported with "rw,sync,no_subtree_check,insecure" options
> > > > >
> > > > > Client:
> > > > > - Archlinux w/ latest distribution provided kernel (5.13.9-arch1-1 at writing)
> > > > > - nfs mounted via /net autofs with "soft,nodev,nosuid" options
> > > > > (ver=4.2 is indicated in mount)
> > > > >
> > > > > I have tried the 5.13.x kernel several times since the first arch
> > > > > release (most recently with 5.13.9-arch1-1), all with similar results.
> > > > > Each time, I am forced to downgrade the linux package to a 5.12.x
> > > > > kernel (5.12.15-arch1 as of writing) to clear up the transfer issues
> > > > > and stabilize performance. No other changes are made between tests. I
> > > > > have confirmed the freezing behavior using both ext4 and btrfs
> > > > > filesystems exported from this server.
> > > > >
> > > > > At this point I would appreciate some guidance in what to provide in
> > > > > order to diagnose and resolve this issue. I don't have a lot of kernel
> > > > > debugging experience, so instruction would be helpful.
> > > > >
> > > > > - mike
> > > > >
> > > > >
> >
> >
