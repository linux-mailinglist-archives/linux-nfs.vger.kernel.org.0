Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5F3E506D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 02:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbhHJAul (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Aug 2021 20:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhHJAuk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Aug 2021 20:50:40 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD8C0613D3
        for <linux-nfs@vger.kernel.org>; Mon,  9 Aug 2021 17:50:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c16so18646207plh.7
        for <linux-nfs@vger.kernel.org>; Mon, 09 Aug 2021 17:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/5H1fmHVLJ8WPclm4fIdOK4R2sVXaDazjuNGVOpqFUY=;
        b=MMYMcDfGKK+lCN8x4/UuMUE1bxkQamcV7FBPw0qdo1Cp2P42c+1HhAkvmip/bUhxYH
         vvxmTKRIUZg+0gv7eKtiHHpBpYuxkviZyiALvujHwyAUYRH9Jf1S8j7Tt1bzv93buLL3
         gXIHHkgRAIwYrBd4UgiuXXFpgKX3tr/8C2xxnMWo6daEkz89gY2owYJHRFJ+Jhg/pVKm
         msFp0BsjgpVJg4GPGsidENfc/ayMoJopr+xUqdHoMgV+n7P5CE30e0FG8dYTW3njhSrg
         iv6y8BUPyL5tRc7CDA5HH6JizP6c/nYTXtq/RA96Qe5AL11MP1UyTtlFDW0IBYKvAp2R
         EV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/5H1fmHVLJ8WPclm4fIdOK4R2sVXaDazjuNGVOpqFUY=;
        b=lw84Q8ewbJ5/14iIC/xlfyl7wRQLjN1cbshQYzlt0lDBBRrSqgHnZDTcytX1P5L3yf
         YG1TCnWjlWo9XNjYEPg1DmgZRqH3bmIPxZS0pV1KQegftgIzHPnaoFYj6Fxa71dgpA5Y
         KbnCaXNRqvX9H4CnWgOXAK4+3jixcWbffnBWZbRdpmqFtLKPu/czQb8gWYmYgdzaQkUi
         +jatzTnXJhUy35gWbl696i15ZCiY/PkC4zRIyddzrR5ewSwc8IwtyvkyRolOxVOcN6hf
         7slXeZaI1q3Jo4KtO7TF4nJD4LuhSBr6VB3M0yQSiQL0wpoYpLIBvQWukLIcTi82LrrS
         gBCQ==
X-Gm-Message-State: AOAM531IwHbowtsbLYUZmncRgQT3W7xRkjHBAznOISC8muBR8BF0bP2Y
        aAE07rczNKAJ7xRFCSFCFiNafD2wCSnMu/da+pHx5mF8EEUwSQ==
X-Google-Smtp-Source: ABdhPJy4cG2ufTNuuNWIItf2EVFRugw00GYkI/OzhZ0pn8qU35jVRKUZvMFODs1llYDwdrBvkfstYW0AlvYhi5aSB6w=
X-Received: by 2002:a17:90a:509:: with SMTP id h9mr1973169pjh.71.1628556619032;
 Mon, 09 Aug 2021 17:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
 <162846730406.22632.14734595494457390936@noble.neil.brown.name> <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
In-Reply-To: <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>
From:   Mike Javorski <mike.javorski@gmail.com>
Date:   Mon, 9 Aug 2021 17:50:08 -0700
Message-ID: <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Managed to get the rpcdebug info for some freezes today. I had a loop
running to call the rpcbind command that Neil provided and then sleep
for 2 seconds. Each triggering event was the opening of a new video
file (I was shuffling through files with mpv). I haven't managed to
get a tcp capture yet trying to get one that isn't too massive, but
the timing is tricky, and this doesn't happen every time.

-----------------------------

[31229.965368] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31229.965370] 44224 c801      0 8c478d70 2473aa3b    15395  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31229.965411] 44225 c801      0 8c478d70 a7d3b9b8    15395  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31231.966982] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31231.966986] 44224 c801      0 8c478d70 2473aa3b    14795  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31231.967027] 44225 c801      0 8c478d70 a7d3b9b8    14795  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31233.968741] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31233.968745] 44224 c801      0 8c478d70 2473aa3b    14194  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31233.968787] 44225 c801      0 8c478d70 a7d3b9b8    14194  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending

-----------------------------

[31292.534529] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31292.534530] 45744 c801      0 8c478d70 2473aa3b    15340  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31292.534554] 45745 c801      0 8c478d70 50cbef7b    15342  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31294.536203] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31294.536206] 45744 c801      0 8c478d70 2473aa3b    14740  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31294.536232] 45745 c801      0 8c478d70 50cbef7b    14742  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31296.537826] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31296.537830] 45744 c801      0 8c478d70 2473aa3b    14139  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31296.537871] 45745 c801      0 8c478d70 50cbef7b    14141  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31298.539474] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31298.539478] 45744 c801      0 8c478d70 2473aa3b    13539  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31298.539522] 45745 c801      0 8c478d70 50cbef7b    13541  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31300.541040] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31300.541044] 46048 c801      0 8c478d70 50cbef7b    17965  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31300.541108] 46049 c801      0 8c478d70 2473aa3b    17965  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31302.542632] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31302.542635] 46922 c801      0 8c478d70 50cbef7b    18000  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending

---------------------------

[31375.046020] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31375.046022] 47336 c801      0 8c478d70 cebaa9a6    15964  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31375.046048] 47337 c801      0 8c478d70 f7145d4d    15964  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31377.047361] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31377.047365] 47336 c801      0 8c478d70 cebaa9a6    15364  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31377.047406] 47337 c801      0 8c478d70 f7145d4d    15364  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31379.048801] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31379.048805] 47336 c801      0 8c478d70 cebaa9a6    14764  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31379.048845] 47337 c801      0 8c478d70 f7145d4d    14764  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31381.050376] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31381.050380] 47336 c801      0 8c478d70 cebaa9a6    14163  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31381.050421] 47337 c801      0 8c478d70 f7145d4d    14163  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31383.051746] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31383.051749] 47336 c801      0 8c478d70 cebaa9a6    13563  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31383.051775] 47337 c801      0 8c478d70 f7145d4d    13563  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31385.053182] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31385.053185] 47342 c801      0 8c478d70 f7145d4d    17980  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31387.054422] -pid- flgs status -client- --rqstp- -timeout ---ops--
[31387.054426] 47818 c801      0 8c478d70 f7145d4d    17761  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending
[31387.054467] 47819 c801      0 8c478d70 cebaa9a6    17762  8531859
nfsv4 READ a:call_status [sunrpc] q:xprt_pending


- mike


On Sun, Aug 8, 2021 at 5:28 PM Mike Javorski <mike.javorski@gmail.com> wrote:
>
> Appreciate the insights Neil. I will make an attempt to
> trigger/capture the fault if I can.
>
> - mike
>
> On Sun, Aug 8, 2021 at 5:01 PM NeilBrown <neilb@suse.de> wrote:
> >
> > On Mon, 09 Aug 2021, Mike Javorski wrote:
> > > I have been experiencing nfs file access hangs with multiple release
> > > versions of the 5.13.x linux kernel. In each case, all file transfers
> > > freeze for 5-10 seconds and then resume. This seems worse when reading
> > > through many files sequentially.
> >
> > A particularly useful debugging tool for NFS freezes is to run
> >
> >   rpcdebug -m rpc -c all
> >
> > while the system appears frozen.  As you only have a 5-10 second window
> > this might be tricky.
> > Setting or clearing debug flags in the rpc module (whether they are
> > already set or not) has a side effect if listing all RPC "tasks" which a
> > waiting for a reply.  Seeing that task list can often be useful.
> >
> > The task list appears in "dmesg" output.  If there are not tasks
> > waiting, nothing will be written which might lead you to think it didn't
> > work.
> >
> > As Chuck hinted, tcpdump is invaluable for this sort of problem.
> >   tcpdump -s 0 -w /tmp/somefile.pcap port 2049
> >
> > will capture NFS traffic.  If this can start before a hang, and finish
> > after, it may contain useful information.  Doing that in a way that
> > doesn't create an enormous file might be a challenge.  It would help if
> > you found a way trigger the problem.  Take note of the circumstances
> > when it seems to happen the most.  If you can only produce a large file,
> > we can probably still work with it.
> >   tshark -r /tmp/somefile.pcap
> > will report the capture one line per packet.  You can look for the
> > appropriate timestamp, note the frame numbers, and use "editcap"
> > to extract a suitable range of packets.
> >
> > NeilBrown
> >
> >
> > >
> > > My server:
> > > - Archlinux w/ a distribution provided kernel package
> > > - filesystems exported with "rw,sync,no_subtree_check,insecure" options
> > >
> > > Client:
> > > - Archlinux w/ latest distribution provided kernel (5.13.9-arch1-1 at writing)
> > > - nfs mounted via /net autofs with "soft,nodev,nosuid" options
> > > (ver=4.2 is indicated in mount)
> > >
> > > I have tried the 5.13.x kernel several times since the first arch
> > > release (most recently with 5.13.9-arch1-1), all with similar results.
> > > Each time, I am forced to downgrade the linux package to a 5.12.x
> > > kernel (5.12.15-arch1 as of writing) to clear up the transfer issues
> > > and stabilize performance. No other changes are made between tests. I
> > > have confirmed the freezing behavior using both ext4 and btrfs
> > > filesystems exported from this server.
> > >
> > > At this point I would appreciate some guidance in what to provide in
> > > order to diagnose and resolve this issue. I don't have a lot of kernel
> > > debugging experience, so instruction would be helpful.
> > >
> > > - mike
> > >
> > >
