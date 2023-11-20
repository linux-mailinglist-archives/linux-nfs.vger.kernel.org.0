Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4897F1CF8
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 19:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjKTSyE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Nov 2023 13:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjKTSyD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Nov 2023 13:54:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63499CD
        for <linux-nfs@vger.kernel.org>; Mon, 20 Nov 2023 10:54:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5742C433C8;
        Mon, 20 Nov 2023 18:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700506440;
        bh=wH8+ABfImSH1anKlpGvfw6l9o3CrTtDa9WKQyMNkuIs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oFDgVmVvHJ3Nz+PQKJ2iA1VuoL0eNAWgOnB4nYg1LkBNmdHU+plklZZI0fRjC5IN8
         OvkOau/aqd4Mp3NxVvGvwdd/NSKK+JWXPyJ4Mb9I5CqWaEcuTrLiqKfMSLRXg/4jMh
         A1m8cdkwotEFZfyS7w5O2tTVK5seD6SQTkQQKEx2Me0ZoBY+2FE/Rgc4iRiBwsBKWZ
         dyWLquaEPJN9qlXamE1zLp5zKUd1+cMiEgYutMnb+j9/CtU7YKye7RRGT7SIFN2k6J
         AE4v0C+tsYnREfsLhPCTHty8mKiqi//jc7R0sII9uFOjTLh4b2Diu+aTC+Cvz0zic2
         aRQzxdaMUZRAw==
Subject: [PATCH RFC 4/5] nfsref: Improve nfsref(5)
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 20 Nov 2023 13:53:58 -0500
Message-ID: <170050643888.123525.15735019118169614157.stgit@manet.1015granger.net>
In-Reply-To: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
References: <170050610386.123525.8429348635736141592.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Neil Brown says:
> ... I found the man page a bit confusing.  It starts off talking about
> "referrals", which are suitably defined.  Then drifts into talking about
> "junctions" which might be the same thing, but aren't defined.
>
> The intro suggests that the admin can use "refer=" in /etc/exports, but
> doesn't say why they might want to use "nfsref" instead, or how the two
> relate.
>
> Description says "Other administrative commands provide richer access to
> junction information." but there are no pointers in "See Also".
>
> The --type option, we are told, can specify nfs-fedfs but there is no
> further mention of this, or any pointers to more info.  Maybe add
> "(deprecated)"??

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 utils/nfsref/nfsref.man |   60 ++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/utils/nfsref/nfsref.man b/utils/nfsref/nfsref.man
index 12615497a404..1970f9dd4144 100644
--- a/utils/nfsref/nfsref.man
+++ b/utils/nfsref/nfsref.man
@@ -53,33 +53,37 @@ nfsref \- manage NFS referrals
 NFS version 4 introduces the concept of
 .I file system referrals
 to NFS.
-A file system referral is like a symbolic link on a file server
-to another file system share, possibly on another file server.
-On an NFS client, a referral behaves like an automounted directory.
-The client, under the server's direction, mounts a new NFS export
-automatically when an application first accesses that directory.
 .P
-Referrals are typically used to construct a single file name space
-across multiple file servers.
-Because file servers control the shape of the name space,
-no client configuration is required,
-and all clients see the same referral information.
+A file system referral is like a symbolic link
+(or,
+.IR symlink )
+to another file system share, typically on another file server.
+An NFS client, under the server's direction,
+mounts the referred-to NFS export
+automatically when an application first accesses it.
 .P
-The Linux NFS server supports NFS version 4 referrals.
-Administrators can specify the
-.B refer=
-export option in
-.I /etc/exports
-to configure a list of exports from which the client can choose.
-See
-.BR exports (5)
-for details.
+NFSv4 referrals can be used to transparently redirect clients
+to file systems that have been moved elsewhere, or
+to construct a single file name space across multiple file servers.
+Because file servers control the shape of the whole file name space,
+no client configuration is required.
 .P
 .SH DESCRIPTION
+A
+.I junction
+is a file system object on an NFS server that,
+when an NFS client encounters it, triggers a referral.
+Similar to a symlink, a junction contains one or more target locations
+that the server sends to clients in the form of an NFSv4 referral.
+.P
+On Linux, an existing directory can be converted to a junction
+and back atomically and without the loss of the directory contents.
+When a directory acts as a junction, it's local content is hidden
+from NFSv4 clients.
+.P
 The
 .BR nfsref (8)
-command is a simple way to get started managing junction metadata.
-Other administrative commands provide richer access to junction information.
+command is a simple way to get started managing junctions and their content.
 .SS Subcommands
 Valid
 .BR nfsref (8)
@@ -135,6 +139,10 @@ For the
 .B add
 subcommand, the default value if this option is not specified is
 .BR nfs-basic .
+The
+.B nfs-fedfs
+type is not used in this implementation.
+.IP
 For the
 .B remove
 and
@@ -163,18 +171,12 @@ you might issue this command as root:
 .sp
 # mkdir /home
 .br
-# nfsref --type=nfs-basic add /home home.example.net /
+# nfsref add /home home.example.net /
 .br
 Created junction /home.
 .sp
 .RE
-.SH FILES
-.TP
-.I /etc/exports
-NFS server export table
 .SH "SEE ALSO"
-.BR exports (5)
-.sp
-RFC 5661 for a description of NFS version 4 referrals
+RFC 8881 for a description of the NFS version 4 referral mechanism
 .SH "AUTHOR"
 Chuck Lever <chuck.lever@oracle.com>


