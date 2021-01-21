Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D72F2FEF10
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 16:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733131AbhAUPiL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 10:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733159AbhAUPhu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 10:37:50 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7427C061788
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 07:37:10 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 172956E97; Thu, 21 Jan 2021 10:37:09 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 172956E97
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1611243429;
        bh=zYYBFnv46PLZedrNhXxBIzRuNZv8Kjh7QMOKWphno7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3/W3IZ9QR6LA/qd1X6BCndohge538Wpk9t65iLWOHcrWOzLRm4sj7MZRo3Qkl18Q
         tc/lZRG7JUd8nxz7aDOdDY3ef/V3iC2CGchBT52lOf+fgWzGXnK7o46bBFqXlaafGp
         r4oCxOSfMGKFev38/2SHArb+LKnjEIH/j+ftd5IM=
Date:   Thu, 21 Jan 2021 10:37:09 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Benjamin Maynard <benmaynard@google.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Linux 5.11 Kernel: NFS re-export errors with older nfs-utils
 package versions
Message-ID: <20210121153709.GA18310@fieldses.org>
References: <CA+QRt4vb=DjgcOqGLtfdfKiDaqKED825xNpNyQaaK-df5tCSRQ@mail.gmail.com>
 <20210119180204.GA24213@fieldses.org>
 <CA+QRt4sxwMTTWpropg=O=XdJ42P+2H=jbrwC8E1n=gt+je6iXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QRt4sxwMTTWpropg=O=XdJ42P+2H=jbrwC8E1n=gt+je6iXQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 21, 2021 at 11:21:56AM +0000, Benjamin Maynard wrote:
> That is correct, there is an originating NFS Server (Ubuntu 20.04 -
> 5.4.0-1034-gcp) that is exporting a directory from the local ext4
> filesystem. This is exported with the following options:
> 
> /files 10.0.0.0/8(rw,no_subtree_check,fsid=10)
> 
> This is then mounted from the re-exporting server (export from /proc/mounts):
> 
> 10.70.1.2:/files /files nfs
> rw,sync,noatime,vers=3,rsize=1048576,wsize=1048576,namlen=255,acregmin=600,acregmax=600,acdirmin=600,acdirmax=600,hard,nocto,proto=tcp,nconnect=16,timeo=600,retrans=2,sec=sys,mountaddr=10.70.1.2,mountvers=3,mountport=20048,mountproto=udp,fsc,local_lock=none,addr=10.70.1.2
> 0 0
> 
> We then attempt to re-export the mounted directory from the
> re-exporting server with the following entry in /etc/exports:
> 
> /files   10.67.0.0/16(rw,wdelay,no_root_squash,no_subtree_check,fsid=10,sec=sys,rw,secure,no_root_squash,no_all_squash)
> 
> If you perform this set of steps with the 5.10 kernel with nfs-utils
> 1.3.4 (Ubuntu & Debian default version), the re-export will work. If
> you perform the same set of steps with the ba5e8187c555 patch applied
> (still on nfs-utils 1.3.4) then the re-export will fail with the error
> message "exportfs: /files does not support NFS export". dmesg further
> reveals the cause "check_export: nfs does not support subtree
> checking!".
> 
> This message appears even though we have no_subtree_check set on both
> the exports of the originating NFS server, and the re-export server.
> 
> If you then upgrade nfs-utils to 2.5.2 on the re-export server, the
> re-export works as expected.

Oh, got it, looks like the bug fixed by nfs-utils commit 63f520e8f6f5
"exportfs: Make sure pass all valid export flags to nfsd".

Rough explanation: export information isn't normally passed down to the
kernel when exportfs is called.  Instead the kernel waits till it needs
to know about some new client and/or filesystem and calls up to mountd
to ask for the relevant export entry.

Anyway, that's fine but it means the user doesn't find about errors
right away.

So, trying to be helpful, exportfs actually does pass down a dummy
export to the kernel at exportfs time, just to check for errors like a
typo'd export path or an unexportable filesystem.

Before that fix, it passed down that dumy export without the
"no_subtree_check" flag, even when you set that flag.

So, for nfs reexport, you need an nfs-utils new enough to include that
patch.

We're normally pretty strict about kernel regressions: if something
stopped working on kernel upgrade, that's a bug.  But I think we really
do need to fail attempts to re-export NFS with subtree checking, so
we've got to make an exception here.  Re-export is still a bit of an
experimental feature, so there may be hiccups like this.

--b.
