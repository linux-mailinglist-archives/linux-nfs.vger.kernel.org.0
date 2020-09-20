Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F89271376
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Sep 2020 13:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgITLQN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Sep 2020 07:16:13 -0400
Received: from cerberus.halldom.com ([79.135.97.241]:56749 "EHLO
        cerberus.halldom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgITLQM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Sep 2020 07:16:12 -0400
X-Greylist: delayed 4412 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Sep 2020 07:16:12 EDT
Received: from ceres.halldom.com ([79.135.97.244]:53301)
        by cerberus.halldom.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <chris.hall@gmch.uk>)
        id 1kJwB3-00025N-Tu; Sun, 20 Sep 2020 11:02:37 +0100
Subject: Fwd: Re: mount.nfs4 and logging
References: <20200919214707.GC22544@fieldses.org>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
From:   Chris Hall <chris.hall@gmch.uk>
X-Forwarded-Message-Id: <20200919214707.GC22544@fieldses.org>
Message-ID: <8c44e6ce-7810-bba1-8779-127938fed1ab@gmch.uk>
Date:   Sun, 20 Sep 2020 11:02:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200919214707.GC22544@fieldses.org>
Content-Type: multipart/mixed;
 boundary="------------919966CE451F944E35489939"
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------919966CE451F944E35489939
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


Steve,

Forwarded to you as suggested by Bruce Fields -- see below.

Chris


-------- Forwarded Message --------

On Sat, Sep 19, 2020 at 06:49:40PM +0100, Chris Hall wrote:
> On 19/09/2020 17:33, J. Bruce Fields wrote:
> >On Tue, Sep 15, 2020 at 02:06:23PM +0100, Chris Hall wrote:
> >>Also FWIW, I gather that this is configuration for the client-side
> >>'mount' of nfs exports, *only*.  I suppose it should be obvious that
> >>this has absolutely nothing to do with configuring (server-side)
> >>'mountd'.  Speaking as a fully paid up moron-in-a-hurry, it has
> >>taken me a while to work that out :-(  [I suggest that the comments
> >>in the .conf files and the man-page could say that nfs.conf is
> >>server-side and nfsmount.conf is client-side -- just a few words,
> >>for the avoidance of doubt.]
> >
> >That sounds sensible.  If you're feeling industrious, you can
> >
> >	git clone git://linux-nfs.org/~steved/nfs-utils
> >
> >and patch those files and mail us a patch....
> 
> Enclosed are suggested updates.

Oh, great, thanks.  Steve Dickson handles these, so send it to
steved@redhat.com, cc: linux-nfs@vger.kernel.org, and he should pick it
up.

--b.

> Chris



--------------919966CE451F944E35489939
Content-Type: text/plain; charset=UTF-8;
 name="gmch-nfs-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gmch-nfs-patch"

diff --git a/nfs.conf b/nfs.conf
index 186a5b19..9bfa0302 100644
--- a/nfs.conf
+++ b/nfs.conf
@@ -2,6 +2,8 @@
 # This is a general configuration for the
 # NFS daemons and tools
 #
+# Note that this is configuration for server-side NFS, only.
+#
 [general]
 # pipefs-directory=/var/lib/nfs/rpc_pipefs
 #
diff --git a/systemd/nfs.conf.man b/systemd/nfs.conf.man
index 3f1c7261..a647a29b 100644
--- a/systemd/nfs.conf.man
+++ b/systemd/nfs.conf.man
@@ -3,6 +3,9 @@
 nfs.conf \- general configuration for NFS daemons and tools
 .SH SYNOPSIS
 .I /etc/nfs.conf
+.PP
+Note that this is configuration for server-side NFS, only.  See 
+nfsmount.conf for the configuration of client-side NFS.
 .SH DESCRIPTION
 .PP
 This file contains site-specific configuration for various NFS daemons
diff --git a/utils/mount/nfsmount.conf b/utils/mount/nfsmount.conf
index 6bdc225a..79d23caa 100644
--- a/utils/mount/nfsmount.conf
+++ b/utils/mount/nfsmount.conf
@@ -1,6 +1,8 @@
 #
 # /etc/nfsmount.conf - see nfsmount.conf(5) for details
 #
+# Note that this is configuration for client-side mount operations, only.
+#
 # This is an NFS mount configuration file. This file can be broken
 # up into three different sections: Mount, Server and Global
 # 
@@ -115,16 +117,20 @@
 # Sets all attributes times to the same time (in seconds)
 # actimeo=30
 #
-# Server Mountd port mountport
+# Server Mountd port mountport - do *not* set this if *any* server
+#                                being used only supports nfs4
 # mountport=4001
 #
-# Server Mountd Protocol
+# Server Mountd Protocol       - do *not* set this if *any* server
+#                                being used only supports nfs4
 # mountproto=tcp
 #
-# Server Mountd Version
+# Server Mountd Version        - do *not* set this if *any* server
+#                                being used only supports nfs4
 # mountvers=3
 #
-# Server Mountd Host
+# Server Mountd Host           - do *not* set this if *any* server
+#                                being used only supports nfs4
 # mounthost=hostname
 #
 # Server Port
diff --git a/utils/mount/nfsmount.conf.man b/utils/mount/nfsmount.conf.man
index 3aa34564..f8dfb7d6 100644
--- a/utils/mount/nfsmount.conf.man
+++ b/utils/mount/nfsmount.conf.man
@@ -5,6 +5,9 @@ nfsmount.conf - Configuration file for NFS mounts
 .SH SYNOPSIS
 Configuration file for NFS mounts that allows options
 to be set globally, per server or per mount point.
+.PP
+Note that this is configuration for client-side mount operations,
+only.  See nfs.conf for the configuration of server-side NFS.
 .SH DESCRIPTION
 The configuration file is made up of multiple sections 
 followed by variables associated with that section.

--------------919966CE451F944E35489939--
