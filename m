Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5730E3E3D48
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Aug 2021 02:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhHIACI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 20:02:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39292 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhHIACI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 20:02:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CEB401FD75;
        Mon,  9 Aug 2021 00:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628467307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4/DSlm9Nzewss/sroErMK53xOSo/L5fzmIg76hQxM4=;
        b=ZGVicFtYjVPfZh5DhR1k4RNGJh6xgLGt8XRLmvVjh5yGe8WZSbLo4xe2DLE4M0D5QS1Rp1
        2Ooi/pL6/rvmYK8jMW9Xzp651t4E1v5vMV9/Rt2YfmlVFe05vDRbaUMpBtQ1DZj5epmzry
        5zApMwffRJi3oR1wlEN5TJY4zxmp+Xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628467307;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4/DSlm9Nzewss/sroErMK53xOSo/L5fzmIg76hQxM4=;
        b=xHpjWkM2gTJ3XUlJlIMCrz5x0ZOiblq4KtdU+HM/WIojZpUuLMg1K756+zUNi3+SDaNRuY
        dIpK7ILn6wUGObCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE77E13A9F;
        Mon,  9 Aug 2021 00:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e6LAKmpwEGEFWwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 09 Aug 2021 00:01:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>
Date:   Mon, 09 Aug 2021 10:01:44 +1000
Message-id: <162846730406.22632.14734595494457390936@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 09 Aug 2021, Mike Javorski wrote:
> I have been experiencing nfs file access hangs with multiple release
> versions of the 5.13.x linux kernel. In each case, all file transfers
> freeze for 5-10 seconds and then resume. This seems worse when reading
> through many files sequentially.

A particularly useful debugging tool for NFS freezes is to run

  rpcdebug -m rpc -c all

while the system appears frozen.  As you only have a 5-10 second window
this might be tricky.
Setting or clearing debug flags in the rpc module (whether they are
already set or not) has a side effect if listing all RPC "tasks" which a
waiting for a reply.  Seeing that task list can often be useful.

The task list appears in "dmesg" output.  If there are not tasks
waiting, nothing will be written which might lead you to think it didn't
work.

As Chuck hinted, tcpdump is invaluable for this sort of problem.
  tcpdump -s 0 -w /tmp/somefile.pcap port 2049

will capture NFS traffic.  If this can start before a hang, and finish
after, it may contain useful information.  Doing that in a way that
doesn't create an enormous file might be a challenge.  It would help if
you found a way trigger the problem.  Take note of the circumstances
when it seems to happen the most.  If you can only produce a large file,
we can probably still work with it.
  tshark -r /tmp/somefile.pcap
will report the capture one line per packet.  You can look for the
appropriate timestamp, note the frame numbers, and use "editcap"
to extract a suitable range of packets.

NeilBrown


>=20
> My server:
> - Archlinux w/ a distribution provided kernel package
> - filesystems exported with "rw,sync,no_subtree_check,insecure" options
>=20
> Client:
> - Archlinux w/ latest distribution provided kernel (5.13.9-arch1-1 at writi=
ng)
> - nfs mounted via /net autofs with "soft,nodev,nosuid" options
> (ver=3D4.2 is indicated in mount)
>=20
> I have tried the 5.13.x kernel several times since the first arch
> release (most recently with 5.13.9-arch1-1), all with similar results.
> Each time, I am forced to downgrade the linux package to a 5.12.x
> kernel (5.12.15-arch1 as of writing) to clear up the transfer issues
> and stabilize performance. No other changes are made between tests. I
> have confirmed the freezing behavior using both ext4 and btrfs
> filesystems exported from this server.
>=20
> At this point I would appreciate some guidance in what to provide in
> order to diagnose and resolve this issue. I don't have a lot of kernel
> debugging experience, so instruction would be helpful.
>=20
> - mike
>=20
>=20
