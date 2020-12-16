Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4C12DBA33
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 05:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgLPEpA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Dec 2020 23:45:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:59142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgLPEo7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 15 Dec 2020 23:44:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20B2AAF0C;
        Wed, 16 Dec 2020 04:44:04 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Date:   Wed, 16 Dec 2020 15:43:03 +1100
Subject: [PATCH 7/7] mount: update nfsmount.conf man page
Cc:     Justin Mitchell <jumitche@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org
Message-ID: <160809378309.7232.17026645167363254754.stgit@noble>
In-Reply-To: <160809318571.7232.10427700322834760606.stgit@noble>
References: <160809318571.7232.10427700322834760606.stgit@noble>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Multiple changes including:
- using \[dq] for double quotes rather than \(lq and \(rq.
  In almost every case, a regular ASCII double quote is being
  referred to, so that is what we should use.
- clean up indenting in examples.
- be explicit about case-insensitive matching.
- give more details about permitted options, including the
  need to use =true and =false for flags
- explain Backgroud, Forground and Sloppy
- remain trailing white space

Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/mount/nfsmount.conf.man |  110 ++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 40 deletions(-)

diff --git a/utils/mount/nfsmount.conf.man b/utils/mount/nfsmount.conf.man
index 4f8f351addf4..73c3e1188541 100644
--- a/utils/mount/nfsmount.conf.man
+++ b/utils/mount/nfsmount.conf.man
@@ -1,53 +1,84 @@
-.\"@(#)nfsmount.conf.5"
-.TH NFSMOUNT.CONF 5 "9 October 2012"
+."@(#)nfsmount.conf.5"
+.TH NFSMOUNT.CONF 5 "16 December 2020"
 .SH NAME
 nfsmount.conf - Configuration file for NFS mounts
 .SH SYNOPSIS
 Configuration file for NFS mounts that allows options
 to be set globally, per server or per mount point.
 .SH DESCRIPTION
-The configuration file is made up of multiple sections 
-followed by variables associated with that section.
-A section is defined by a string enclosed by 
+The configuration file is made up of multiple section headers
+followed by variable assignments associated with that section.
+A section header is defined by a string enclosed by
 .BR [
-and 
+and
 .BR ]
-branches.
-Variables are assignment statements that assign values 
-to particular variables using the  
-.BR = 
-operator, as in 
+brackets.
+Variable assignments are assignment statements that assign values
+to particular variables using the
+.BR =
+operator, as in
 .BR Proto=Tcp .
-The variables that can be assigned are exactly the set of NFS specific
+The variables that can be assigned are the set of NFS specific
 mount options listed in
-.BR nfs (5).
+.BR nfs (5)
+together with the filesystem-independant mount options listed in
+.BR mount (8)
+and three additions:
+.B Sloppy=True
+has the same effect as the
+.B -s
+option to
+.IR mount ,
+and
+.B Foreground=True
+and
+.B Background=True
+have the same effect as
+.B bg
+and
+.BR fg .
+.PP
+Options in the config file may be given in upper, lower, or mixed case
+and will be shifted to lower case before being passed to the filesystem.
+.PP
+Boolean mount options which do not need an equals sign must be given as
+.RI \[dq] option =True".
+Instead of preceeding such an option with
+.RB \[dq] no \[dq]
+its negation must be given as
+.RI \[dq] option =False".
 .PP
 Sections are broken up into three basic categories:
 Global options, Server options and Mount Point options.
 .HP
 .B [ NFSMount_Global_Options ]
 - This statically named section
-defines all of the global mount options that can be 
+defines all of the global mount options that can be
 applied to every NFS mount.
 .HP
-.B [ Server \(lqServer_Name\(rq ] 
-- This section defines all the mount options that should 
-be used on mounts to a particular NFS server. The 
-.I \(lqServer_Name\(rq
-strings needs to be surrounded by '\(lq' and 
-be an exact match of the server name used in the 
+.B [ Server \[dq]Server_Name\[dq] ]
+- This section defines all the mount options that should
+be used on mounts to a particular NFS server. The
+.I \[dq]Server_Name\[dq]
+strings needs to be surrounded by '\[dq]' and be an exact match
+(ignoring case) of the server name used in the
 .B mount
-command. 
+command.
 .HP
-.B [ MountPoint \(lqMount_Point\(rq ]
-- This section defines all the mount options that 
+.B [ MountPoint \[dq]Mount_Point\[dq] ]
+- This section defines all the mount options that
 should be used on a particular mount point.
-The 
-.I \(lqMount_Point\(rq
-string needs to be surrounded by '\(lq' and be an 
-exact match of the mount point used in the 
-.BR mount 
-command.
+The
+.I \[dq]Mount_Point\[dq]
+string needs to be surrounded by '\[dq]' and be an
+exact match of the mount point used in the
+.BR mount
+command.  Though path names are usually case-sensitive, the Mount_Point
+name is matched insensitive to case.
+.PP
+The sections are processed in the reverse of the order listed above, and
+any options already seen, either in a previous section or on the
+command line, will be ignored when seen again.
 .SH EXAMPLES
 .PP
 These are some example lines of how sections and variables
@@ -57,43 +88,42 @@ are defined in the configuration file.
 .br
     Proto=Tcp
 .RS
-.HP
+.PP
 The TCP/IPv4 protocol will be used on every NFS mount.
-.HP
 .RE
-[ Server \(lqnfsserver.foo.com\(rq ]
+.PP
+[ Server \[dq]nfsserver.foo.com\[dq] ]
 .br
     rsize=32k
 .br
     wsize=32k
 .br
     proto=udp6
-.HP
 .RS
+.PP
 A 32k (32768 bytes) block size will be used as the read and write
 size on all mounts to the 'nfsserver.foo.com' server.  UDP/IPv6
 is the protocol to be used.
-.HP
 .RE
-.BR 
-[ MountPoint \(lq/export/home\(rq ]
+.PP
+[ MountPoint \[dq]/export/home\[dq] ]
 .br
     Background=True
 .RS
-.HP
+.PP
 All mounts to the '/export/home' export will be performed in
 the background (i.e. done asynchronously).
-.HP
+.RE
 .SH FILES
 .TP 10n
 .I /etc/nfsmount.conf
 Default NFS mount configuration file
 .TP 10n
 .I /etc/nfsmount.conf.d
-When this directory exists and files ending 
+When this directory exists and files ending
 with ".conf" exist, those files will be
 used to set configuration variables. These
-files will override variables set 
+files will override variables set
 in /etc/nfsmount.conf
 .PD
 .SH SEE ALSO


