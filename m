Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A2932DE6D
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 01:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCEAoo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Mar 2021 19:44:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:39466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhCEAon (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 4 Mar 2021 19:44:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9744DAD29;
        Fri,  5 Mar 2021 00:44:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <SteveD@RedHat.com>
Date:   Fri, 05 Mar 2021 11:43:23 +1100
Subject: [PATCH 3/7] mountd/exports: update man page
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Message-ID: <161490500399.15291.15037203384575681909.stgit@noble>
In-Reply-To: <161490464823.15291.13358214486203434566.stgit@noble>
References: <161490464823.15291.13358214486203434566.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The text in the manpages about the export table is a bit outdated, and
doesn't mention the in-kernel cache which is an import part of
that table.

As a future patch will enable logging of updates to that cache, it is
important to have the caching behaviour documented.  So update that
section of both man pages, and make a few other minor improvements.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/exportd/exportd.man |   46 +++++++++++++++++++++------------------------
 utils/mountd/mountd.man   |   46 ++++++++++++++++++++++++++++-----------------
 2 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/utils/exportd/exportd.man b/utils/exportd/exportd.man
index d788456244b2..0dbf0c80466a 100644
--- a/utils/exportd/exportd.man
+++ b/utils/exportd/exportd.man
@@ -10,30 +10,23 @@ nfsv4.exportd \- NFSv4 Server Mount Daemon
 .SH DESCRIPTION
 The
 .B nfsv4.exportd
-is used to manage NFSv4 exports. The NFSv4 server
-receives a mount request from a client and pass it up to 
-.B nfsv4.exportd. 
-.B nfsv4.exportd 
-then uses the exports(5) export
-table to verify the validity of the mount request.
-.PP
-An NFS server maintains a table of local physical file systems
-that are accessible to NFS clients.
-Each file system in this table is referred to as an
-.IR "exported file system" ,
-or
-.IR export ,
-for short.
-.PP
-Each file system in the export table has an access control list.
+is used to manage NFSv4 exports.
+The NFS server
+.RI ( nfsd )
+maintains a cache of authentication and authorization information which
+is used to identify the source of each requent, and then what access
+permissions that source has to any local filesystem.  When required
+information is not found in the cache, the server sends a request to
 .B nfsv4.exportd
-uses these access control lists to determine
-whether an NFS client is permitted to access a given file system.
-For details on how to manage your NFS server's export table, see the
-.BR exports (5)
-and
-.BR exportfs (8)
-man pages.
+to fill in the missing information.  
+.B nfsv4.exportd
+uses a table of information stored in
+.B /var/lib/nfs/etab
+and maintained by
+.BR exportfs (8),
+possibly based on the contents of 
+.BR exports (5),
+to respond to each request.
 .SH OPTIONS
 .TP
 .B \-d kind " or " \-\-debug kind
@@ -46,7 +39,8 @@ Run in foreground (do not daemonize)
 Display usage message.
 .TP
 .BR "\-t N" " or " "\-\-num\-threads=N " or  " \-\-num\-threads N "
-This option specifies the number of worker threads that rpc.mountd
+This option specifies the number of worker threads that 
+.B nfsv4.exports
 spawns.  The default is 1 thread, which is probably enough.  More
 threads are usually only needed for NFS servers which need to handle
 mount storms of hundreds of NFS mounts in a few seconds, or when
@@ -94,4 +88,6 @@ listing exports, export options, and access control lists
 .BR nfs.conf (5),
 .BR firwall-cmd (1),
 .sp
-RFC 3530 - "Network File System (NFS) version 4 Protocol"
+RFC 7530 - "Network File System (NFS) Version 4 Protocol"
+.br
+RFC 8881 - "Network File System (NFS) Version 4 Minor Version 1 Protocol"
diff --git a/utils/mountd/mountd.man b/utils/mountd/mountd.man
index 9978afcdb4cc..2e191074c65f 100644
--- a/utils/mountd/mountd.man
+++ b/utils/mountd/mountd.man
@@ -13,24 +13,24 @@ The
 .B rpc.mountd
 daemon implements the server side of the NFS MOUNT protocol,
 an NFS side protocol used by NFS version 2 [RFC1094] and NFS version 3 [RFC1813].
+It also responds to requests from the Linux kernel to authenticate
+clients and provides details of access permissions.
 .PP
-An NFS server maintains a table of local physical file systems
-that are accessible to NFS clients.
-Each file system in this table is referred to as an
-.IR "exported file system" ,
-or
-.IR export ,
-for short.
-.PP
-Each file system in the export table has an access control list.
-.B rpc.mountd
-uses these access control lists to determine
-whether an NFS client is permitted to access a given file system.
-For details on how to manage your NFS server's export table, see the
-.BR exports (5)
-and
-.BR exportfs (8)
-man pages.
+The NFS server
+.RI ( nfsd )
+maintains a cache of authentication and authorization information which
+is used to identify the source of each requent, and then what access
+permissions that source has to any local filesystem.  When required
+information is not found in the cache, the server sends a request to
+.B mountd
+to fill in the missing information.  Mountd uses a table of information
+stored in
+.B /var/lib/nfs/etab
+and maintained by
+.BR exportfs (8),
+possibly based on the contents of 
+.BR exports (5),
+to respond to each request.
 .SS Mounting exported NFS File Systems
 The NFS MOUNT protocol has several procedures.
 The most important of these are
@@ -78,6 +78,14 @@ A client may continue accessing an export even after invoking UMNT.
 If the client reboots without sending a UMNT request, stale entries
 remain for that client in
 .IR /var/lib/nfs/rmtab .
+.SS Mounting File Systems with NFSv4
+Version 4 (and later) of NFS does not use a separate NFS MOUNT
+protocol.  Instead mounting is performed using regular NFS requests
+handled by the NFS server in the Linux kernel
+.RI ( nfsd ).
+Consequently
+.I /var/lib/nfs/rmtab
+is not updated to reflect any NFSv4 activity.
 .SH OPTIONS
 .TP
 .B \-d kind " or " \-\-debug kind
@@ -295,5 +303,9 @@ table of clients accessing server's exports
 RFC 1094 - "NFS: Network File System Protocol Specification"
 .br
 RFC 1813 - "NFS Version 3 Protocol Specification"
+.br
+RFC 7530 - "Network File System (NFS) Version 4 Protocol"
+.br
+RFC 8881 - "Network File System (NFS) Version 4 Minor Version 1 Protocol"
 .SH AUTHOR
 Olaf Kirch, H. J. Lu, G. Allan Morris III, and a host of others.


