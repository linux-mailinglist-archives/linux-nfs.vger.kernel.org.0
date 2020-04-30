Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7192C1C03EB
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2020 19:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgD3RcB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Apr 2020 13:32:01 -0400
Received: from fieldses.org ([173.255.197.46]:38468 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD3RcB (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 Apr 2020 13:32:01 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A11D61C29; Thu, 30 Apr 2020 13:32:00 -0400 (EDT)
Date:   Thu, 30 Apr 2020 13:32:00 -0400
To:     Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>
Cc:     linux-nfs@vger.kernel.org,
        Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Subject: Re: Random IO errors on nfs clients running linux > 4.20
Message-ID: <20200430173200.GE29491@fieldses.org>
References: <20200429171527.GG2531021@var.inittab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429171527.GG2531021@var.inittab.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 29, 2020 at 07:15:27PM +0200, Alberto Gonzalez Iniesta wrote:
> I'm sorry for reporting this (a little bit) late, but it took us (Miguel
> in Cc:) some time to track this issue to an exact kernel update.
> 
> We're running a +200 clients NFS server with Ubuntu 16.04 and 18.04
> clients. The server runs Debian 8.11 (jessie) with Linux 3.16.0 and
> nfs-kernel-server 1:1.2.8-9+deb8u1. It has been working some years now
> without issues.
> 
> But since we started moving clients from Ubuntu 16.04 to Ubuntu 18.04
> some of them started experiencing failures while working on NFS mounts.
> The failures are arbitrary and sometimes it may take more than 20 minutes
> to come out (which made finding out which kernel version introduced
> this a pain). We are almost sure that some directories are more prone to
> suffer from this than others (maybe related to path length/chars?).
> 
> The error is also not very "verbose", from an strace:
> 
> execve("/bin/ls", ["ls", "-lR", "Becas y ayudas/"], 0x7ffccb7f5b20 /* 16 vars */) = 0
> [lots of uninteresting output]
> openat(AT_FDCWD, "Becas y ayudas/", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
> fstat(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
> fstat(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
> fstat(1, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
> ioctl(1, TCGETS, 0x7ffd8b725c80)        = -1 ENOTTY (Inappropriate ioctl for device)
> getdents(3, /* 35 entries */, 32768)    = 1936
> [lots of lstats)
> lstat("Becas y ayudas/Convocatorias", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
> getdents(3, 0x561af78de890, 32768)      = -1 EIO (Input/output error)

Ideas off the top of my head....

It'd be really useful to get a network trace--something like tcpdump -s0
-wtmp.pcap -i<interface>, then reproduce the problem, then look through
it to see if you can find the READDIR or STAT or whatever that results
in the unexpected EIO.  But if takes a while to reproduce, that may be
difficult.

Is there anything in the logs?

It might be worth turning on some more debug logging--see the "rpcdebug"
command.

--b.

> 
> (I can send you the full output if you need it)
> 
> We can run the previous "ls -lR" 20 times and get no error, or get
> this "ls: leyendo el directorio 'Becas y ayudas/': Error de entrada/salida"
> (ls: reading directorio 'Becas y ayudas/': Input/Output Error") every
> now and then.
> 
> The error happens (obviously?) with ls, rsync and the users's GUI tools.
> 
> There's nothing in dmesg (or elsewhere).
> These are the kernels with tried:
> 4.18.0-25   -> Can't reproduce
> 4.19.0      -> Can't reproduce
> 4.20.17     -> Happening (hard to reproduce)
> 5.0.0-15    -> Happening (hard to reproduce)
> 5.3.0-45    -> Happening (more frequently)
> 5.6.0-rc7   -> Reproduced a couple of times after boot, then nothing
> 
> We did long (as in daylong) testing trying to reproduce this with all
> those kernel versions, so we are pretty sure 4.18 and 4.19 don't
> experience this and our Ubuntu 16.04 clients don't have any issue.
> 
> I know we aren't providing much info but we are really looking forward
> to doing all the testing required (we already spent lots of time in it).
> 
> Thanks for your work.
> 
> Regards,
> 
> Alberto
> 
> -- 
> Alberto González Iniesta             | Universidad a Distancia
> alberto.gonzalez@udima.es            | de Madrid
