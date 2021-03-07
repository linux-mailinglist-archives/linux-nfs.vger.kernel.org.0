Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047673303F2
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Mar 2021 19:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhCGSap (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Mar 2021 13:30:45 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43459 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231464AbhCGSaZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 7 Mar 2021 13:30:25 -0500
Received: from [192.168.0.5] (ip5f5aea7c.dynamic.kabel-deutschland.de [95.90.234.124])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D7FAF206446A2;
        Sun,  7 Mar 2021 19:30:16 +0100 (CET)
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
From:   Donald Buczek <buczek@molgen.mpg.de>
Subject: [BUG] nfs-utils: mountd doesn't work with elder glibc versions
Message-ID: <ed75ac87-04ca-c1fe-ad70-7e9f47eef456@molgen.mpg.de>
Date:   Sun, 7 Mar 2021 19:30:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

we noticed that our exports don't work with nfs-utils 2.5.3.

The reason is, that 76c21e3f ("mountd: Check the stat() return values in match_fsid()") added a new error handling. It sets errno to 0 and assumes that it is stable when there are no errors. However, this conflicts with the logic in support/misc/xstat.c, which sets errno to ENOSYS if glibc doesn't support statx() or has an incomplete emulation.

We have glibc 2.27 which doesn't support statx().

root@dose:~# findmnt /amd/dose/0
TARGET      SOURCE    FSTYPE OPTIONS
/amd/dose/0 /dev/vda2 xfs    rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota
root@dose:~# /usr/sbin/rpc.mountd --foreground --manage-gids -d all &
[1] 26777
root@dose:~# rpc.mountd: Version 2.5.3 starting
root@dose:~# exportfs dose:/amd/dose/0
root@dose:~# mount dose:/amd/dose/0 /mnt
rpc.mountd: auth_unix_ip: inbuf 'nfsd 141.14.17.51'
rpc.mountd: auth_unix_ip: inbuf 'nfsd 141.14.17.51'
rpc.mountd: auth_unix_ip: client 0x459850 'dose.molgen.mpg.de'
rpc.mountd: v4root_create: path '/' flags 0x12403
rpc.mountd: auth_unix_ip: inbuf 'nfsd 141.14.17.51'
rpc.mountd: auth_unix_ip: client 0x459850 'dose.molgen.mpg.de'
rpc.mountd: v4root_create: path '/amd' flags 0x10403
rpc.mountd: v4root_create: path '/amd/dose' flags 0x10403
rpc.mountd: auth_unix_ip: client 0x451010 'dose.molgen.mpg.de'
rpc.mountd: rpc.mountd: nfsd_fh: inbuf 'dose.molgen.mpg.de 1 \x00000000'nfsd_fh: inbuf 'dose.molgen.mpg.de 1 \x00000000'

rpc.mountd: nfsd_fh: found 0x45b1c0 path /
rpc.mountd: nfsd_fh: found 0x45c070 path /
rpc.mountd: nfsd_export: inbuf 'dose.molgen.mpg.de /amd'rpc.mountd:
nfsd_export: inbuf 'dose.molgen.mpg.de /amd'
rpc.mountd: nfsd_export: found 0x442eb0 path /amdrpc.mountd:
nfsd_export: found 0x45b6d0 path /amd
rpc.mountd: rpc.mountd: nfsd_fh: inbuf 'dose.molgen.mpg.de 7 \x83000000000000005e2eaee859174457bcd564e9512178dc'nfsd_fh: inbuf 'dose.molgen.mpg.de 7 \x83000000000000005e2eaee859174457bcd564e9512178dc'

rpc.mountd: nfsd_fh: found 0x442ec0 path /amdrpc.mountd:
nfsd_fh: found 0x45b6e0 path /amd
rpc.mountd: nfsd_export: inbuf 'dose.molgen.mpg.de /amd/dose'
rpc.mountd: nfsd_export: inbuf 'dose.molgen.mpg.de /amd/dose'
rpc.mountd: rpc.mountd: nfsd_export: found 0x4433d0 path /amd/dosenfsd_export: found 0x45bbf0 path /amd/dose

rpc.mountd: nfsd_fh: inbuf 'dose.molgen.mpg.de 7 \x81000820000000005e2eaee859174457bcd564e9512178dc'rpc.mountd:
nfsd_fh: inbuf 'dose.molgen.mpg.de 7 \x81000820000000005e2eaee859174457bcd564e9512178dc'
rpc.mountd: nfsd_fh: found 0x4433e0 path /amd/dose
rpc.mountd: nfsd_fh: found 0x45bc00 path /amd/dose
rpc.mountd: nfsd_export: inbuf 'dose.molgen.mpg.de /amd/dose/0'
rpc.mountd: nfsd_export: inbuf 'dose.molgen.mpg.de /amd/dose/0'
rpc.mountd: nfsd_export: found 0x443550 path /amd/dose/0
rpc.mountd: nfsd_fh: inbuf 'dose.molgen.mpg.de 6 \xa7287020bece44b09df5b577a4b82823'
rpc.mountd: nfsd_export: found 0x45bb40 path /amd/dose/0
rpc.mountd: nfsd_fh: found (nil) path (null)rpc.mountd:
nfsd_fh: inbuf 'dose.molgen.mpg.de 6 \xa7287020bece44b09df5b577a4b82823'
rpc.mountd: nfsd_fh: found (nil) path (null)

( mount hangs until interrupted )

With the following workaround, things works again:

diff --git a/support/export/cache.c b/support/export/cache.c
index f1569afb..1b671c32 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -722,7 +722,7 @@ match:
  path_error:
         if (path_lookup_error(errno))
                 goto nomatch;
-       return -1;
+       return 0;
  }
  
  static struct addrinfo *lookup_client_addr(char *dom)

Another minor one, I noticed when searching for the above:

diff --git a/support/misc/mountpoint.c b/support/misc/mountpoint.c
index 14d6731d..ae664d6a 100644
--- a/support/misc/mountpoint.c
+++ b/support/misc/mountpoint.c
@@ -37,7 +37,7 @@ check_is_mountpoint(const char *path, int (mystat)(const char *, struct stat *))
                 rv = 0;
         else
                 if (stb.st_dev != pstb.st_dev ||
-                   stb.st_ino == pstb.st_ino)
+                   stb.st_ino != pstb.st_ino)
                         rv = 1;
                 else
                         rv = 0;

I just assume, this would be right and might be relevant to exported bind mounts. But I didn't try to trigger the assumed bug here.

Best
   Donald
