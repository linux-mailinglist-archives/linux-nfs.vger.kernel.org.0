Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0D0C14011C
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 01:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgAQAtW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 16 Jan 2020 19:49:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28546 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729235AbgAQAtW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Jan 2020 19:49:22 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-KhgvyvhuP5WGglsW0BZP2w-1; Thu, 16 Jan 2020 19:49:18 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8887C800D41;
        Fri, 17 Jan 2020 00:49:16 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-126-23.rdu2.redhat.com [10.10.126.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7C8481200;
        Fri, 17 Jan 2020 00:49:15 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 278561A006B; Thu, 16 Jan 2020 19:49:15 -0500 (EST)
Date:   Thu, 16 Jan 2020 19:49:15 -0500
From:   Scott Mayhew <smayhew@redhat.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS:
 Add fs_context support.")
Message-ID: <20200117004915.GA3111@aion.usersys.redhat.com>
References: <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: KhgvyvhuP5WGglsW0BZP2w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aion.usersys.redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 16 Jan 2020, Krzysztof Kozlowski wrote:

> Hi all,
> 
> Bisect pointed to 6d972518b821 ("NFS: Add fs_context support.") for
> failures of mounting NFS v4 root on my boards:
> mount.nfs4 -o vers=4,nolock 192.168.1.10:/srv/nfs/odroidhc1 /new_root
> [ 24.980839] NFS4: Couldn't follow remote path
> [ 24.986201] NFS: Value for 'minorversion' out of range
> mount.nfs4: Numerical result out of range
> 
> https://krzk.eu/#/builders/21/builds/1692
> Full console log:
> https://krzk.eu/#/builders/21/builds/1692/steps/14/logs/serial0
> 
> Enabling NFS v4.1 in defconfig seems to help. I can send patches for
> this (for defconfigs) but probably the root cause should be fixed as
> well.
> 
> Environment:
> 1. Arch ARM Linux
> 2. exynos_defconfig
> 3. Exynos boards (Odroid XU3, etc), ARMv7, octa-core (Cortex-A7+A15),
> Exynos5422 SoC
> 4. systemd, boot up with static IP set in kernel command line
> 5. No swap
> 6. Kernel, DTB and initramfs are downloaded with TFTP
> 7. NFS root from NFSv4 server
> 
> Let me know if you need more details.

I haven't had much luck reproducing this.  I disabled v4.1 in my .config
and I can still boot a VM with NFS root (granted, I don't really use NFS
root so this setup is brand new and pretty basic):

[root@localhost ~]# cat /proc/cmdline
BOOT_IMAGE=mountapi/vmlinuz initrd=mountapi/initrd.img ip=dhcp selinux=0 console=tty0 console=ttyS0,115200 root=nfs4:192.168.122.3:/export/nfsroot/fedora31

[root@localhost ~]# grep nfs /proc/mounts
192.168.122.3:/export/nfsroot/fedora31 / nfs rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.122.69,local_lock=none,addr=192.168.122.3 0 0

Just out of curiousity, what version of the mount.nfs program do you
have in your initramfs?  I'm wondering if it's maybe passing the mount
options differently than mine.  FWIW I'm using version 2.4.2:

[smayhew@aion tmp]$ lsinitrd /var/lib/tftpboot/mountapi/initrd.img|grep mount.nfs
-rwsr-xr-x   1 root     root       208600 Feb 14  2019 usr/sbin/mount.nfs
lrwxrwxrwx   1 root     root            9 Feb 14  2019 usr/sbin/mount.nfs4 -> mount.nfs
[smayhew@aion tmp]$ /usr/lib/dracut/skipcpio /var/lib/tftpboot/mountapi/initrd.img|zcat|cpio -id usr/sbin/mount.nfs
256163 blocks
[smayhew@aion tmp]$ ./usr/sbin/mount.nfs -V
mount.nfs: (linux nfs-utils 2.4.2)
[smayhew@aion tmp]$

-Scott

> 
> Best regards,
> Krzysztof
> 

