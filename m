Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3823541D6
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Apr 2021 13:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhDELsY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 07:48:24 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:53538 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbhDELsY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Apr 2021 07:48:24 -0400
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.16.1/8.16.1) with ESMTP id 135BmGo3021488;
        Mon, 5 Apr 2021 12:48:16 +0100
From:   Nix <nix@esperi.org.uk>
To:     "bfields\@fieldses.org" <bfields@fieldses.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: steam-associated reproducible hard NFSv4.2 client hang (5.9, 5.10)
References: <877dourt7c.fsf@esperi.org.uk>
        <20210223225701.GD8042@fieldses.org>
        <fde7a43ac9b61a1aff53381d0ab7b48b78cb79db.camel@hammerspace.com>
        <20210224020140.GA26848@fieldses.org> <875z16m8oh.fsf@esperi.org.uk>
        <20210401134442.GB13277@fieldses.org> <87eeftlljk.fsf@esperi.org.uk>
        <20210402192059.GA16427@fieldses.org>
Emacs:  featuring the world's first municipal garbage collector!
Date:   Mon, 05 Apr 2021 12:48:16 +0100
In-Reply-To: <20210402192059.GA16427@fieldses.org> (bfields@fieldses.org's
        message of "Fri, 2 Apr 2021 15:20:59 -0400")
Message-ID: <87wnthhrzz.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1480; Body=3 Fuz1=3 Fuz2=3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2 Apr 2021, bfields@fieldses.org said:
> Sorry, did you say whether nfsd threads or rpc.mountd are blocked?

... just about to switch into debugging this, but it does seem to me
that if nfsd threads or (especially) mountd on the server side were
blocked, I'd see misbehaviour with mounts from every client, not just a
few of them. This doesn't happen.

While this is going on, my firewall and other clients not engaging in
the problematic Steam-related activity can talk NFSv4 to the server
perfectly happily: indeed this is actually a problem when debugging
because I have to quiesce the bloody things as much as I can to stop
their RPC traffic flooding the log with irrelevant junk :)

Recovery from this consists only of rebooting the stuck client: the
server and all other clients don't need touching (indeed, I'm typing
this in an emacs on that server, and since it was last rebooted it's
been hit by a client experiencing this hang at least five times: the
mailserver also keeps its mailspool on that server as well, and no
problems there either).

(The server also has fairly silly amounts of RAM compared to the load
it's placed under. I'm not concerned about the possibility of rpc.mountd
getting swapped out. It just doesn't happen. Even things like git gc of
the entire Chromium git repo proceed without swapping.)


btw, the filesystem layout on this machine is, in part:

/dev/main/root             xfs      4294993920  738953092 3556040828  18% /
/dev/mapper/main-vms       xfs      1073231868  406045460  667186408  38% /vm
/dev/mapper/main-steam     ext4     1055852896   85367140  916781564   9% /pkg/non-free/steam
/dev/mapper/main-archive   xfs      3219652608 2761922796  457729812  86% /usr/archive
/dev/mapper/main-pete      xfs      2468405656 2216785448  251620208  90% /usr/archive/music/Pete
/dev/mapper/main-phones    xfs        52411388    4354092   48057296   9% /.nfs/nix/share/phones
/dev/mapper/main-unifi     xfs        10491804    1130228    9361576  11% /var/lib/unifi
/dev/mapper/oracrypt-plain 2147510784  144030636 2003480148   7% /home/oranix/oracle/private

... and you'll note that the exported fs I'm seeing hangs on is actually
*not* the $HOME on the root fs: it's /pkg/non-free/steam, which is ext4
purely because so many games on x86 still fail horribly when 64-bit
inodes are used, and ext4 can emit 32-bit inodes on biggish fses without
horrible performance consequences, unlike xfs.  The relevant import line:

loom:/pkg/non-free/steam/.steam /home/nix/.steam nfs defaults,_netdev

(so it is imported to *subdirectory* of a directory which is a mounted
NFS export, and *that* one is exported from /). The hang also happens
when using nfusr as the NFS client for the .steam import, so whatever it
is isn't just down to the client...

The primary reason I'm using one big fs for almost everything on this
server build is, uh, NFSv4. My last machine had lots of little
filesystems, and the result somehow confused the NFS pseudoroot
construction process so badly that most of the things I tried to export
never appeared on NFSv4, only on v3: only those exports which *were* on
the root filesystem were ever available for NFSv4 mounting, so I was
stuck with v3 on that machine. At (IIRC) Chuck Lever's suggestion (many
years ago, so he probably won't remember) I varied things when I built a
new server and was happy to find that with a less baroque setup and a
bigger rootfs with more stuff on it, NFSv4 seemed perfectly happy and
the pseudoroot was populated fine.

OK let's collect some logs so we're not reasoning in the absence of data
any more. Back soon! (I hope.)
