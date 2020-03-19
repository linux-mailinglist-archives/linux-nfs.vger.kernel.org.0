Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67718C02A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 20:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgCSTPg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 15:15:36 -0400
Received: from fieldses.org ([173.255.197.46]:47018 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgCSTPg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 19 Mar 2020 15:15:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 94BBE83B; Thu, 19 Mar 2020 15:15:32 -0400 (EDT)
Date:   Thu, 19 Mar 2020 15:15:32 -0400
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfsd(7): minimal updates
Message-ID: <20200319191532.GB2624@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

The nfsd(7) man page has some useful documentation of the files under
/proc/fs/nfsd/ and proc/net/rpc, but it's many years out of date.

As a start, banish any discussion of the long-deprecated nfsctl
systemcall to a NOTES section at the end, and admit that there are more
than 3 files under /proc/fs/nfsd/.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 utils/exportfs/nfsd.man | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/utils/exportfs/nfsd.man b/utils/exportfs/nfsd.man
index 9efa29f9f01c..1392f3926053 100644
--- a/utils/exportfs/nfsd.man
+++ b/utils/exportfs/nfsd.man
@@ -13,14 +13,8 @@ nfsd \- special filesystem for controlling Linux NFS server
 The
 .B nfsd
 filesystem is a special filesystem which provides access to the Linux
-NFS server.  The filesystem consists of a single directory which
-contains a number of files.  These files are actually gateways into
-the NFS server.  Writing to them can affect the server.  Reading from
-them can provide information about the server.
-.P
-This file system is only available in Linux 2.6 and later series
-kernels (and in the later parts of the 2.5 development series leading
-up to 2.6).  This man page does not apply to 2.4 and earlier.
+NFS server.  Writing to files in this filesystem can affect the server.
+Reading from them can provide information about the server.
 .P
 As well as this filesystem, there are a collection of files in the
 .B procfs
@@ -38,13 +32,10 @@ filesystem mounted at
 .B /proc/fs/nfsd
 or
 .BR /proc/fs/nfs .
-If it is not mounted, they will fall-back on 2.4 style functionality.
-This involves accessing the NFS server via a systemcall.  This
-systemcall is scheduled to be removed after the 2.6 kernel series.
 .SH DETAILS
-The three files in the
+Files in the
 .B nfsd
-filesystem are:
+filesystem include:
 .TP
 .B exports
 This file contains a list of filesystems that are currently exported
@@ -191,6 +182,16 @@ number represents a bit-pattern where bits that are set cause certain
 classes of tracing to be enabled.  Consult the kernel header files to
 find out what number correspond to what tracing.
 
+.SH NOTES
+This file system is only available in Linux 2.6 and later series
+kernels (and in the later parts of the 2.5 development series leading
+up to 2.6).  This man page does not apply to 2.4 and earlier.
+.P
+Previously the nfsctl systemcall was used for communication between nfsd
+and user utilities.  That systemcall was removed in kernel version 3.1.
+Older nfs-utils versions were able to fall back to nfsctl if necessary;
+that was removed from nfs-utils 1.3.5.
+
 .SH SEE ALSO
 .BR nfsd (8),
 .BR rpc.nfsd (8),
-- 
2.25.1

