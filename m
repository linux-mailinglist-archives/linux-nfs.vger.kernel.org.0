Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A2931AD16
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Feb 2021 17:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBMQZo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 Feb 2021 11:25:44 -0500
Received: from icebox.esperi.org.uk ([81.187.191.129]:35302 "EHLO
        mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhBMQZn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 Feb 2021 11:25:43 -0500
X-Greylist: delayed 3805 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Feb 2021 11:25:43 EST
Received: from loom (nix@sidle.srvr.nix [192.168.14.8])
        by mail.esperi.org.uk (8.16.1/8.16.1) with ESMTP id 11DFLZXW011636
        for <linux-nfs@vger.kernel.org>; Sat, 13 Feb 2021 15:21:35 GMT
From:   Nick Alcock <nix@esperi.org.uk>
To:     NFS list <linux-nfs@vger.kernel.org>
Subject: Re: steam-associated reproducible hard NFSv4.2 client hang (5.9, 5.10)
Emacs:  because idle RAM is the Devil's playground.
Date:   Sat, 13 Feb 2021 15:21:35 +0000
Message-ID: <87pn14c7sw.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-DCC--Metrics: loom 1481; Body=1 Fuz1=1 Fuz2=1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

(I can't get References: right on this mail due to the original aging
out of my mailbox: archive URL,
https://www.spinics.net/lists/linux-nfs/msg81430.html).

I now have a little lockdep info from this hang (and reports from at
least two others that they've seen similar-looking hangs dating back to
4.19, though much harder to reproduce, taking many hours rather than
five minutes: in one case they report not using NFS in production any
more because of this).

Unfortunately the lockdep info isn't much use:

Feb 13 14:13:12 silk warning: : [  888.834464] Showing all locks held in the system:
Feb 13 14:13:12 silk warning: : [  888.834501] 1 lock held by dmesg/1152:
Feb 13 14:13:12 silk warning: : [  888.834508]  #0: ffff980c3b7200d0 (&user->lock){+.+.}-{3:3}, at: devkmsg_read+0x49/0x2d1
Feb 13 14:13:12 silk warning: : [  888.834540] 2 locks held by tee/1322:
Feb 13 14:13:12 silk warning: : [  888.834546]  #0: ffff980c0809a430 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x6a/0xdc
Feb 13 14:13:12 silk warning: : [  888.834573]  #1: ffff980c3ca7b5e8 (&sb->s_type->i_mutex_key#16){++++}-{3:3}, at: nfs_start_io_write+0x1a/0x45
Feb 13 14:13:12 silk warning: : [  888.834632] 1 lock held by 192.168.16.8-ma/2302:
Feb 13 14:13:12 silk warning: : [  888.834638]  #0: ffff980c0fe6b700 (&acct->lock#2){+.+.}-{3:3}, at: acct_process+0x102/0x2bc

The first of those is my ongoing dmesg -w. The last is process
accounting. The middle one is an ongoing, always-active Xsession-errors
tee over the same NFSv4 connection, which says nothing more than that
writes to this NFS server from this client have hung, which we already
know. There are no signs of locks held by the Steam client which has
hung in the middle of installation.

So whateverthehell this is, it's not blocked on a lock. The NFS client
is hanging all on its own. (I have no idea how clients can block in the
middle of writing if a lock is *not* involved somehow, but that is what
it looks like from the lockdep output.)

Does anyone know how I might start debugging this sod?
