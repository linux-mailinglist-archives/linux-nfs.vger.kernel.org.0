Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A27F1BE507
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD2RVT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Apr 2020 13:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2RVT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Apr 2020 13:21:19 -0400
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Apr 2020 10:21:19 PDT
Received: from etc.inittab.org (etc.inittab.org [IPv6:2001:41d0:2:234d::31c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9416BC03C1AE
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2020 10:21:19 -0700 (PDT)
Received: from var.inittab.org (89.141.236.227.dyn.user.ono.com [89.141.236.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: smtp_auth_agi@correo-e.org)
        by etc.inittab.org (Postfix) with ESMTPSA id 20086A00F8;
        Wed, 29 Apr 2020 19:15:28 +0200 (CEST)
Received: by var.inittab.org (Postfix, from userid 1000)
        id A4EE14267A; Wed, 29 Apr 2020 19:15:27 +0200 (CEST)
Date:   Wed, 29 Apr 2020 19:15:27 +0200
From:   Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>
To:     linux-nfs@vger.kernel.org
Cc:     Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Subject: Random IO errors on nfs clients running linux > 4.20
Message-ID: <20200429171527.GG2531021@var.inittab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello NFS maintainers,

I'm sorry for reporting this (a little bit) late, but it took us (Miguel
in Cc:) some time to track this issue to an exact kernel update.

We're running a +200 clients NFS server with Ubuntu 16.04 and 18.04
clients. The server runs Debian 8.11 (jessie) with Linux 3.16.0 and
nfs-kernel-server 1:1.2.8-9+deb8u1. It has been working some years now
without issues.

But since we started moving clients from Ubuntu 16.04 to Ubuntu 18.04
some of them started experiencing failures while working on NFS mounts.
The failures are arbitrary and sometimes it may take more than 20 minutes
to come out (which made finding out which kernel version introduced
this a pain). We are almost sure that some directories are more prone to
suffer from this than others (maybe related to path length/chars?).

The error is also not very "verbose", from an strace:

execve("/bin/ls", ["ls", "-lR", "Becas y ayudas/"], 0x7ffccb7f5b20 /* 16 vars */) = 0
[lots of uninteresting output]
openat(AT_FDCWD, "Becas y ayudas/", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3
fstat(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
fstat(3, {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
fstat(1, {st_mode=S_IFCHR|0666, st_rdev=makedev(1, 3), ...}) = 0
ioctl(1, TCGETS, 0x7ffd8b725c80)        = -1 ENOTTY (Inappropriate ioctl for device)
getdents(3, /* 35 entries */, 32768)    = 1936
[lots of lstats)
lstat("Becas y ayudas/Convocatorias", {st_mode=S_IFDIR|0775, st_size=4096, ...}) = 0
getdents(3, 0x561af78de890, 32768)      = -1 EIO (Input/output error)

(I can send you the full output if you need it)

We can run the previous "ls -lR" 20 times and get no error, or get
this "ls: leyendo el directorio 'Becas y ayudas/': Error de entrada/salida"
(ls: reading directorio 'Becas y ayudas/': Input/Output Error") every
now and then.

The error happens (obviously?) with ls, rsync and the users's GUI tools.

There's nothing in dmesg (or elsewhere).
These are the kernels with tried:
4.18.0-25   -> Can't reproduce
4.19.0      -> Can't reproduce
4.20.17     -> Happening (hard to reproduce)
5.0.0-15    -> Happening (hard to reproduce)
5.3.0-45    -> Happening (more frequently)
5.6.0-rc7   -> Reproduced a couple of times after boot, then nothing

We did long (as in daylong) testing trying to reproduce this with all
those kernel versions, so we are pretty sure 4.18 and 4.19 don't
experience this and our Ubuntu 16.04 clients don't have any issue.

I know we aren't providing much info but we are really looking forward
to doing all the testing required (we already spent lots of time in it).

Thanks for your work.

Regards,

Alberto

-- 
Alberto González Iniesta             | Universidad a Distancia
alberto.gonzalez@udima.es            | de Madrid
