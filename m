Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D310E18E650
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Mar 2020 04:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCVDn5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Mar 2020 23:43:57 -0400
Received: from s58.linuxpl.com ([5.9.16.239]:53266 "EHLO s58.linuxpl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbgCVDn5 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 21 Mar 2020 23:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=belsznica.pl; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5RqKex8KbYpbGsT6RWzmMGGHCMZsA9dtLWNVMB80qA0=; b=cQtHnIpEtNZ6je+2B6gcw1YOfE
        Xe8+atZplu2RFWPzaLXLuMTkXcwLoh1dxClqfre7RuAiIe+BMENJG4vEVtyYOCIg6d3S76l6Cqo7s
        857zykRv8mR8KvhqYeiIKyboekUfFpFdKhLuyieW03fa5Z6+rSCQ8QH3SjCfx1c4omGXCkhCVejZU
        Rg113Os2xT+2dcBECK8mkNDGQ54sgSfnAuPNqAtpWg9lASk8MftvEdrN6Unu7Xa2ynrOtFUbE4XHu
        D30kr6O/HVfYk+cX7cBeI2/5CnjPRDudkkTAykLkZKue6eUR18fa86B8DH4kkoRAjA+qlFYccwwWz
        7hPUz35A==;
Received: from user-5-173-97-3.play-internet.pl ([5.173.97.3] helo=mordimer)
        by s58.linuxpl.com with esmtpa (Exim 4.92.3)
        (envelope-from <jasiu@belsznica.pl>)
        id 1jFrWj-000827-Ax; Sun, 22 Mar 2020 04:43:53 +0100
Received: from mordimer (localhost [127.0.0.1])
        by mordimer (Postfix) with ESMTP id 454BF60192;
        Sun, 22 Mar 2020 04:43:53 +0100 (CET)
Date:   Sun, 22 Mar 2020 04:43:52 +0100
From:   Jan Psota <jasiu@belsznica.pl>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: refcount underflow in nfsd41_destroy_cb
Message-ID: <20200322044352.2ff1fbd8.jasiu@belsznica.pl>
In-Reply-To: <44C9D860-4F51-46B1-88A3-D10DDEF4BD8E@oracle.com>
References: <CAHmME9ro8BPBTMfu8dEbGmkH7qHLdQ=CXGEOW2C7MR4bmT6T+w@mail.gmail.com>
 <44C9D860-4F51-46B1-88A3-D10DDEF4BD8E@oracle.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Operating-System: Linux; Gentoo
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Chuck Lever <chuck.lever@oracle.com> napisa=B3(a):
> Jan, how are you reproducing this?

It looks like it's taking place on server on high NFS load and about
a day after boot! (as I noticed looking into last -x results, below)
Then system runs all right for a month (to be rebooted on new kernel
[not always] or something like this).

We have some NFS-rooted machines:
/systemd on / type nfs4 (rw,relatime,vers=3D4.2,rsize=3D4096,wsize=3D4096,n=
amlen=3D255,hard,proto=3Dtcp,
	timeo=3D10,retrans=3D2,sec=3Dsys,clientaddr=3D192.168.1.18,local_lock=3Dno=
ne,addr=3D192.168.1.1)

Server has 10Gb Aquantia AQC107 card connected to Mikrotik CSS326
switch. Clients running distcc (aside from acting as workstations)
are connected on 1Gb ethernet. Server runs Gentoo Linux on OpenRC
(stations have Systemd) with recent gcc-9.3, binutils-2.34 and
glibc-2.30, has 32 GB RAM and AMD Phenom II X6 1090T CPU.

/var/tmp/portage, where compilation takes place, normally is on client
tmpfs, but when there is not enough space to compile huge program, I
switch it to server exported NFS
(/etc/exports opts: -rw,async,no_root_squash,no_subtree_check)

# "grep nfs.*destroy /var/log/messages" mixed with "last -x"

reboot   system boot  5.5.1-gentoo     Mon Feb  3 00:20 - 15:22 (25+15:01)
Feb  4 17:44:39 agro kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
	rust compilation, kernel 5.5.1-gentoo

reboot   system boot  5.5.6-gentoo     Fri Feb 28 15:23 - 16:25 (14+01:02)
Feb 29 13:51:49 agro kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
	rust compilation, kernel 5.5.6-gentoo

reboot   system boot  5.5.9-gentoo     Fri Mar 13 16:27 - 00:04 (4+07:36)
Mar 14 18:03:49 agro kernel:  nfsd41_destroy_cb+0x2c/0x40 [nfsd]
	libpciaccess compilation, kernel=20

reboot   system boot  5.6.0-rc6        Wed Mar 18 00:06 - 20:39 (2+20:32)
Mar 19 11:08:07 agro kernel:  nfsd41_destroy_cb+0x36/0x50 [nfsd]
	linux-firmware merge
*
reboot   system boot  5.6.0-rc6        Fri Mar 20 20:40 - 02:40  (05:59)
Mar 20 21:43:34 agro kernel:  nfsd41_destroy_cb+0x36/0x50 [nfsd]
	zstd compilation
*
reboot   system boot  5.6.0-rc6        Sat Mar 21 02:42   still running
Mar 21 17:34:43 agro kernel:  nfsd41_destroy_cb+0x36/0x50 [nfsd]
	nodejs compilation

* - I noticed kernel fault looking for a reason, why WireGuard refused
to connect with _some_ remote peers so I rebooted the server and it helped.
