Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA8E14094E
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 12:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgAQLxJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 06:53:09 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46182 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgAQLxJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 06:53:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id m8so21984952edi.13;
        Fri, 17 Jan 2020 03:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKdnPvrm4XqMvrjQ2dfGnlSEg6gPU/txEANGd2eQZo4=;
        b=jekwxujQS0b8jsiVV/xJq8w8DVcsb89U0bUo+972Xv/eeEQ0pugKVMnJ2hwRf3uHOF
         /pYohq11j2jH4HZkAJJ9YbX12K09MYzTgXJIGNNFt+ydLqxfCnML/OfQZryixLwzIvvt
         R+EXYDdUAAPHAY0+SF/l1JlDv3SeDjthjeqhjKewE+BrSW5cehbaHNWT79pWTCkC2sy3
         8bupjQ0aS0gUwcNWtfPP/BLM7cQ5XUeoy2xuZ1Ee8diJpxDWi3iaDU/o0/sDQ4mjdsa4
         zrKNYMr84WZsYEt1TSm344MlBby7Jzu60wqbhHlnEg2JLZ+NPCE+t+mnhWcVk7ohISBU
         To9A==
X-Gm-Message-State: APjAAAXkhcnmHzchwbctbrUnpCW38mfeREvC6o91/U4vFGdRIuh51oIZ
        gcz7wHPmudB7jSBOjlyr90g=
X-Google-Smtp-Source: APXvYqyJYaULhFt1JslVWWk56YksGhYVnODsLZVw982YOzL+r3B3r1azE4odt+I4vV/lEcnrlj1L0A==
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr7651287ejj.6.1579261986993;
        Fri, 17 Jan 2020 03:53:06 -0800 (PST)
Received: from pi3 ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id by2sm800412ejb.45.2020.01.17.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:53:06 -0800 (PST)
Date:   Fri, 17 Jan 2020 12:53:04 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [BISECT BUG] NFS v4 root not working after 6d972518b821 ("NFS:
 Add fs_context support.")
Message-ID: <20200117115304.GA12197@pi3>
References: <CAJKOXPeCVwZfBsCVbc9RQUGi0UfWQw0uFamPiQasiO8fSthFsQ@mail.gmail.com>
 <20200117004915.GA3111@aion.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200117004915.GA3111@aion.usersys.redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 16, 2020 at 07:49:15PM -0500, Scott Mayhew wrote:
> On Thu, 16 Jan 2020, Krzysztof Kozlowski wrote:
> 
> > Hi all,
> > 
> > Bisect pointed to 6d972518b821 ("NFS: Add fs_context support.") for
> > failures of mounting NFS v4 root on my boards:
> > mount.nfs4 -o vers=4,nolock 192.168.1.10:/srv/nfs/odroidhc1 /new_root
> > [ 24.980839] NFS4: Couldn't follow remote path
> > [ 24.986201] NFS: Value for 'minorversion' out of range
> > mount.nfs4: Numerical result out of range
> > 
> > https://krzk.eu/#/builders/21/builds/1692
> > Full console log:
> > https://krzk.eu/#/builders/21/builds/1692/steps/14/logs/serial0
> > 
> > Enabling NFS v4.1 in defconfig seems to help. I can send patches for
> > this (for defconfigs) but probably the root cause should be fixed as
> > well.
> > 
> > Environment:
> > 1. Arch ARM Linux
> > 2. exynos_defconfig
> > 3. Exynos boards (Odroid XU3, etc), ARMv7, octa-core (Cortex-A7+A15),
> > Exynos5422 SoC
> > 4. systemd, boot up with static IP set in kernel command line
> > 5. No swap
> > 6. Kernel, DTB and initramfs are downloaded with TFTP
> > 7. NFS root from NFSv4 server
> > 
> > Let me know if you need more details.
> 
> I haven't had much luck reproducing this.  I disabled v4.1 in my .config
> and I can still boot a VM with NFS root (granted, I don't really use NFS
> root so this setup is brand new and pretty basic):
> 
> [root@localhost ~]# cat /proc/cmdline
> BOOT_IMAGE=mountapi/vmlinuz initrd=mountapi/initrd.img ip=dhcp selinux=0 console=tty0 console=ttyS0,115200 root=nfs4:192.168.122.3:/export/nfsroot/fedora31
> 
> [root@localhost ~]# grep nfs /proc/mounts
> 192.168.122.3:/export/nfsroot/fedora31 / nfs rw,relatime,vers=4.0,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.122.69,local_lock=none,addr=192.168.122.3 0 0
> 
> Just out of curiousity, what version of the mount.nfs program do you
> have in your initramfs?  I'm wondering if it's maybe passing the mount
> options differently than mine.  FWIW I'm using version 2.4.2:
> 
> [smayhew@aion tmp]$ lsinitrd /var/lib/tftpboot/mountapi/initrd.img|grep mount.nfs
> -rwsr-xr-x   1 root     root       208600 Feb 14  2019 usr/sbin/mount.nfs
> lrwxrwxrwx   1 root     root            9 Feb 14  2019 usr/sbin/mount.nfs4 -> mount.nfs
> [smayhew@aion tmp]$ /usr/lib/dracut/skipcpio /var/lib/tftpboot/mountapi/initrd.img|zcat|cpio -id usr/sbin/mount.nfs
> 256163 blocks
> [smayhew@aion tmp]$ ./usr/sbin/mount.nfs -V
> mount.nfs: (linux nfs-utils 2.4.2)
> [smayhew@aion tmp]$
>

My binary is:
mount.nfs4: (linux nfs-utils 3.1.1)

This is pretty weird... I extracted this binary from a running system
(Arch Linux Arm) and put into the initramfs. However now my Arch Linux
is shipped with v2.4.2-1...

Best regards,
Krzysztof

