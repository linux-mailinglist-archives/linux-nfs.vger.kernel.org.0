Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94DB263289
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Sep 2020 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgIIQpt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Sep 2020 12:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbgIIQMj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Sep 2020 12:12:39 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CAC061343
        for <linux-nfs@vger.kernel.org>; Wed,  9 Sep 2020 06:47:35 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CC49A648C; Wed,  9 Sep 2020 09:47:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CC49A648C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599659247;
        bh=ePN74+LcWaPXJfFtcN/i2VJ2z16oL1HQ4dydA/f92eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HI2bpG8kW/7EVAWW5ZbTUia/bVrOazlT95pFFtPCt9+lVNyWfGQtR22gs8djQZ9YV
         phh4XXtOriXEWwqL9WxDTV6hJH9+N8bKVbAltgSxLLuNHCtpqTQHt9eJhjih14ou97
         heQi0xQe7dil+IijIQRQpF3fTMY28nBA/FBtXGbY=
Date:   Wed, 9 Sep 2020 09:47:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>
Cc:     linux-nfs@vger.kernel.org,
        Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Subject: Re: Random IO errors on nfs clients running linux > 4.20
Message-ID: <20200909134727.GA3894@fieldses.org>
References: <20200429171527.GG2531021@var.inittab.org>
 <20200430173200.GE29491@fieldses.org>
 <20200909092900.GO189595@var.inittab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909092900.GO189595@var.inittab.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 09, 2020 at 11:29:00AM +0200, Alberto Gonzalez Iniesta wrote:
> On Thu, Apr 30, 2020 at 01:32:00PM -0400, J. Bruce Fields wrote:
> > On Wed, Apr 29, 2020 at 07:15:27PM +0200, Alberto Gonzalez Iniesta wrote:
> > > I'm sorry for reporting this (a little bit) late, but it took us (Miguel
> > > in Cc:) some time to track this issue to an exact kernel update.
> > > 
> > > We're running a +200 clients NFS server with Ubuntu 16.04 and 18.04
> > > clients. The server runs Debian 8.11 (jessie) with Linux 3.16.0 and
> > > nfs-kernel-server 1:1.2.8-9+deb8u1. It has been working some years now
> > > without issues.
> > > 
> > > But since we started moving clients from Ubuntu 16.04 to Ubuntu 18.04
> > > some of them started experiencing failures while working on NFS mounts.
> > > The failures are arbitrary and sometimes it may take more than 20 minutes
> > > to come out (which made finding out which kernel version introduced
> > > this a pain). We are almost sure that some directories are more prone to
> > > suffer from this than others (maybe related to path length/chars?).
> > > 
> > > The error is also not very "verbose", from an strace:
> > > 
> > > execve("/bin/ls", ["ls", "-lR", "Becas y ayudas/"], 0x7ffccb7f5b20 /* 16 vars */) = 0
> > > [lots of uninteresting output]
> > > openat(AT_FDCWD, "Becas y ayudas/", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
> > > fstat(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
> > > fstat(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
> > > fstat(1, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
> > > ioctl(1, TCGETS, 0x7ffd8b725c80)        = -1 ENOTTY (Inappropriate ioctl for device)
> > > getdents(3, /* 35 entries */, 32768)    = 1936
> > > [lots of lstats)
> > > lstat("Becas y ayudas/Convocatorias", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
> > > getdents(3, 0x561af78de890, 32768)      = -1 EIO (Input/output error)
> > 
> > Ideas off the top of my head....
> > 
> > It'd be really useful to get a network trace--something like tcpdump -s0
> > -wtmp.pcap -i<interface>, then reproduce the problem, then look through
> > it to see if you can find the READDIR or STAT or whatever that results
> > in the unexpected EIO.  But if takes a while to reproduce, that may be
> > difficult.
> > 
> > Is there anything in the logs?
> > 
> > It might be worth turning on some more debug logging--see the "rpcdebug"
> > command.
> 
> Hi, Bruce et at.
> 
> I'm sorry this reply took so long, but with debugging enabled the error
> was harder to reproduce.
> 
> I'm attaching 3 log files (2 with just "nfs" debugging and one with
> "nfs" and "rpc" debugging modules enabled).
> 
> I'm also attaching a pcap file, don't know if it would be useful since
> we run "sec=krb5p".

Yeah, not too useful.

> Let me know if there's anything else I can test/provide.
> These tests were done with Ubuntu's 5.3.0-53-generic.
> 
> Thanks,
> 
> Alberto
> 
> > > (I can send you the full output if you need it)
> > > 
> > > We can run the previous "ls -lR" 20 times and get no error, or get
> > > this "ls: leyendo el directorio 'Becas y ayudas/': Error de entrada/salida"
> > > (ls: reading directorio 'Becas y ayudas/': Input/Output Error") every
> > > now and then.
> > > 
> > > The error happens (obviously?) with ls, rsync and the users's GUI tools.
> > > 
> > > There's nothing in dmesg (or elsewhere).
> > > These are the kernels with tried:
> > > 4.18.0-25   -> Can't reproduce
> > > 4.19.0      -> Can't reproduce
> > > 4.20.17     -> Happening (hard to reproduce)
> > > 5.0.0-15    -> Happening (hard to reproduce)
> > > 5.3.0-45    -> Happening (more frequently)
> > > 5.6.0-rc7   -> Reproduced a couple of times after boot, then nothing
> > > 
> > > We did long (as in daylong) testing trying to reproduce this with all
> > > those kernel versions, so we are pretty sure 4.18 and 4.19 don't
> > > experience this and our Ubuntu 16.04 clients don't have any issue.
> > > 
> > > I know we aren't providing much info but we are really looking forward
> > > to doing all the testing required (we already spent lots of time in it).
> > > 
> > > Thanks for your work.

So all I notice from this one is the readdir EIO came from call_decode.
I suspect that means it failed in the xdr decoding.  Looks like xdr
decoding of the actual directory data (which is the complicated part) is
done later, so this means it failed decoding the header or verifier,
which is a little odd:

> Sep  8 16:03:23 portatil264 kernel: [15033.016276] RPC:  3284 call_decode result -5
> Sep  8 16:03:23 portatil264 kernel: [15033.016281] nfs41_sequence_process: Error 1 free the slot 
> Sep  8 16:03:23 portatil264 kernel: [15033.016286] RPC:       wake_up_first(00000000d3f50f4d "ForeChannel Slot table")
> Sep  8 16:03:23 portatil264 kernel: [15033.016288] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
> Sep  8 16:03:23 portatil264 kernel: [15033.016290] RPC:  3284 return 0, status -5
> Sep  8 16:03:23 portatil264 kernel: [15033.016291] RPC:  3284 release task
> Sep  8 16:03:23 portatil264 kernel: [15033.016295] RPC:       freeing buffer of size 4144 at 00000000a3649daf
> Sep  8 16:03:23 portatil264 kernel: [15033.016298] RPC:  3284 release request 0000000079df89b2
> Sep  8 16:03:23 portatil264 kernel: [15033.016300] RPC:       wake_up_first(00000000c5ee49ee "xprt_backlog")
> Sep  8 16:03:23 portatil264 kernel: [15033.016302] RPC:       rpc_release_client(00000000b930c343)
> Sep  8 16:03:23 portatil264 kernel: [15033.016304] RPC:  3284 freeing task
> Sep  8 16:03:23 portatil264 kernel: [15033.016309] _nfs4_proc_readdir: returns -5
> Sep  8 16:03:23 portatil264 kernel: [15033.016318] NFS: readdir(departamentos/innovacion) returns -5

--b.
