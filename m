Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207D3349BB6
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 22:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCYVed (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 17:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbhCYVeW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 17:34:22 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF198C06174A
        for <linux-nfs@vger.kernel.org>; Thu, 25 Mar 2021 14:34:22 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id C26566D16; Thu, 25 Mar 2021 17:34:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org C26566D16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1616708061;
        bh=5KrUTVgQrTVlUzS34jfxzrAzcye/x4HcoSBTBwe3eCI=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=b8niUMIFyXR+Bn2453A4GoM/fvXiNuOhPhMoiO8SdgVunuYMIknxepT/t+DYDdCTH
         ppMfCzycUwziTVeXPk0K9x0rZBY3Oz3jP+Cef/tBTgnhvwqbwWqzYqQi1LDqCaXhkx
         4+u5UrYElQol0NnTjjDG8Vf+phHBV9ehv6Off5LU=
Date:   Thu, 25 Mar 2021 17:34:21 -0400
To:     Benjamin Maynard <benmaynard@google.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Input/output errors when mounting re-exported directories that
 use crossmounts
Message-ID: <20210325213421.GC18351@fieldses.org>
References: <CA+QRt4vr+CUgP-4xkVQwLWNZMHo-w6TwU8bFwzuZcUc1RPi-RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QRt4vr+CUgP-4xkVQwLWNZMHo-w6TwU8bFwzuZcUc1RPi-RA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 23, 2021 at 08:08:38PM +0000, Benjamin Maynard wrote:
> Hi Linux NFS Mailing List,
> 
> Please excuse any incorrect terminology - I'm not an expert in this
> space but am learning :).
> 
> I have recently been experimenting with NFS re-exporting in the 5.11
> kernel and have come across an interesting quirk when re-exporting a
> directory that has subdirectories on different filesystems. I'll do my
> best to give a concise overview of my setup and the issue I am seeing
> below.

I bet you're encountering a special case of the rule that the "fsid="
option is required on any export of an NFS filesystem.

The "fsid=" option on the parent export doesn't help us with any
children found underneath that export, different filesystems have to
have different fsids.

So, you probably hit the first -EINVAL in fs/nfsd/export.c
check_export().  You could confirm that by turning on some debugging on
the re-exporting server (rpcdebug -m nfsd -s export) and checking the
logs, which should get "exp_export: export of non-dev fs without fsid"
when you hit the IO error.

The re-export server wants to encode into each filehandle something that
identifies the specific filesystem being exported.  Otherwise it's stuck
when it gets a filehandle back from the client--the operation it uses to
map the incoming filehandle to a dentry can't work without a superblock.

In theory, if it can at least determine that the filehandle is for an
object on an NFS filesystem, and figure out which server the
filesystem's from, it could (given some new interface) ask the NFS
client to work out the rest....  I've got only vague ideas here and no
real plan for a fix.

So, for now at least, this just doesn't work.

--b.

> 
> I'll use the following terms to describe the components from here on out:
> 
> Source NFS Filer: Refers to the originating NFS Server that contains
> the exports that we want to re-export (Ubuntu 20.04.2 /
> 5.4.0-1038-gcp).
> Re-exporting NFS Filer: Refers to the NFS Server that is mounting and
> re-exporting the Source NFS Filer (Ubuntu 20.10 /
> 5.11.0-051100-generic).
> NFS Client: Refers to the server that is mounting the re-exported
> directories on the Re-exporting NFS Filer (Ubuntu 18.04 /
> 5.4.0-1036-gcp).
> 
> (Source NFS Filer <-- Re-exporting NFS Filer <-- NFS Client)
> 
> ---
> Source NFS Filer:
> 
> The source NFS Filer consists of two directories that are each mounted
> to filesystems on different disks:
> 
> root@demo-nfs-filer-kernel-community:/home/benmaynard# lsblk
> NAME MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
> sdb 8:16 0 100G 0 disk /files
> sdc 8:32 0 100G 0 disk /files/disk2
> 
> The /files directory is then exported from the source filer, with the
> crossmnt option set so that clients can move to the child filesystems:
> 
> root@demo-nfs-filer-kernel-community:/files# cat /etc/exports
> /files 10.0.0.0/8(rw,wdelay,no_root_squash,no_subtree_check,fsid=10,sec=sys,rw,secure,no_root_squash,no_all_squash,crossmnt)
> 
> -- 
> Re-exporting NFS Filer:
> 
> >From the Re-exporting NFS Filer, I can then mount this exported directory:
> 
> root@reexport-server:/home/benmaynard# mount -t nfs -o vers=3,sync
> 10.67.10.54:/files /files
> 
> I am able to successfully list the contents of both the /files and
> /files/disk2 directories:
> 
> root@reexport-server:/home/benmaynard# ls /files/
> a_file disk2 lost+found
> 
> root@reexport-server:/home/benmaynard# ls /files/disk2/
> b_file lost+found
> 
> Now time to re-export (using the same options as the Source NFS Filer
> including crossmnt):
> 
> root@reexport-server:/home/benmaynard# cat /etc/exports
> /files 10.0.0.0/8(rw,wdelay,no_root_squash,no_subtree_check,fsid=10,sec=sys,rw,secure,no_root_squash,no_all_squash,crossmnt)
> 
> --
> NFS Client:
> 
> I now want to mount the re-exported directory from my NFS Client:
> root@client-vm:/home/benmaynard# mount -t nfs -o vers=3,sync
> 10.67.10.51:/files /files
> 
> The mount completes successfully, but when listing the contents of the
> directory I receive a Input/output error for the directory that is on
> a different filesystem:
> 
> root@client-vm:/home/benmaynard# ls /files
> ls: cannot access '/files/disk2': Input/output error
> a_file disk2 lost+found
> 
> 
> root@client-vm:/home/benmaynard# ls /files/disk2
> ls: cannot access '/files/disk2': Input/output error
> 
> If I unmount and mount the Source NFS Filer directly, I am able to
> read all of the files. The problem seems to be caused by the
> re-export.
> 
> In my efforts to resolve this I tried a number of different options,
> and the only way I was able to get things working was to explicitly
> re-export the directories that are on different filesystems from the
> Re-Exporting NFS Filer (Source NFS Filer exports and NFS Client mount
> command remains unchanged):
> 
> root@reexport-server:/home/benmaynard# cat /etc/exports
> /files 10.0.0.0/8(rw,wdelay,no_root_squash,no_subtree_check,fsid=10,sec=sys,rw,secure,no_root_squash,no_all_squash,crossmnt)
> /files/disk2 10.0.0.0/8(rw,wdelay,no_root_squash,no_subtree_check,fsid=20,sec=sys,rw,secure,no_root_squash,no_all_squash,crossmnt)
> 
> With these export options I can successfully mount the Re-exporting
> NFS filer and browse both directores:
> 
> root@client-vm:/home/benmaynard# mount -t nfs -o vers=3,sync
> 10.67.10.51:/files /files
> root@client-vm:/home/benmaynard# ls /files
> a_file disk2 lost+found
> root@client-vm:/home/benmaynard# ls /files/disk2/
> b_file lost+found
> 
> It appears as if the issue is something to do with the re-export, but
> I am struggling to track down the actual cause.
> 
> This is causing some challenges as the source NFS filer that I am
> using in production has 1000's of subdirectories on different volumes.
> Manually re-exporting each of these from our re-export server is a
> challenge.
> 
> I have a lab environment configured so happy to do some more testing
> or run commands if it helps with troubleshooting.
