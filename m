Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA16A3926
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Feb 2023 03:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjB0C6X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Feb 2023 21:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjB0C6X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Feb 2023 21:58:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DA87A96;
        Sun, 26 Feb 2023 18:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=nk7Pr1obO0KzFpH/1rdv7+SUyAIN0BhF0eRcIL8vnR4=; b=4Nwn5v+X79NKJEsKF+Vd4+Rveq
        caJOLBqnQZxIEDT3U0y41MLkQc0r8B3O0wAJ4bXkSENTHbKnKdtrf5qIzQLCI8gzHJVZPVNScUIEn
        dKvbxFdKO5V6aUxZ5szLnQn2qqctQOvPag4WgJQbj/fNNI8pAB7/0Wvl1rq09sSahfyGJuycDe8DR
        LOPi3UmwrQfuplC/ybH8Ohayrs4hslJ8YcRGhDpDJYEA1PgPi+94KvEp62ol4JcEAvQl0dIdC+oA8
        JdNE9M/HYBCPM4G6/ObV9pnf06ai+3cek5sAkwp1Gzx/kE6PfPsBhlM9G0p2IEC/b/G7K8ou2JN2p
        prKlftcw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWTiT-008JyX-8P; Mon, 27 Feb 2023 02:58:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] Documentation: kernel-parameters: sort NFS parameters
Date:   Sun, 26 Feb 2023 18:58:16 -0800
Message-Id: <20230227025816.1083-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Sort the NFS kernel command line parameters. This is done in 4 groups
so as to not have them intermingled: 'nfs' module parameters, 'nfs4'
module parameters, 'nfsd' module parameters, and nfs "global" (__setup,
no module) parameters.

There were 5 parameters which were listed with a space between the
parameter name and the following '=' sign. The space has been
removed since module parameters expect 'parameter=' with no intervening
space.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |   74 +++++++-------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff -- a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3428,14 +3428,13 @@
 			1 to enable accounting
 			Default value is 0.
 
-	nfsaddrs=	[NFS] Deprecated.  Use ip= instead.
-			See Documentation/admin-guide/nfs/nfsroot.rst.
-
-	nfsroot=	[NFS] nfs root filesystem for disk-less boxes.
-			See Documentation/admin-guide/nfs/nfsroot.rst.
+	nfs.cache_getent=
+			[NFS] sets the pathname to the program which is used
+			to update the NFS client cache entries.
 
-	nfsrootdebug	[NFS] enable nfsroot debugging messages.
-			See Documentation/admin-guide/nfs/nfsroot.rst.
+	nfs.cache_getent_timeout=
+			[NFS] sets the timeout after which an attempt to
+			update a cache entry is deemed to have failed.
 
 	nfs.callback_nr_threads=
 			[NFSv4] set the total number of threads that the
@@ -3446,18 +3445,6 @@
 			[NFS] set the TCP port on which the NFSv4 callback
 			channel should listen.
 
-	nfs.cache_getent=
-			[NFS] sets the pathname to the program which is used
-			to update the NFS client cache entries.
-
-	nfs.cache_getent_timeout=
-			[NFS] sets the timeout after which an attempt to
-			update a cache entry is deemed to have failed.
-
-	nfs.idmap_cache_timeout=
-			[NFS] set the maximum lifetime for idmapper cache
-			entries.
-
 	nfs.enable_ino64=
 			[NFS] enable 64-bit inode numbers.
 			If zero, the NFS client will fake up a 32-bit inode
@@ -3465,6 +3452,10 @@
 			of returning the full 64-bit number.
 			The default is to return 64-bit inode numbers.
 
+	nfs.idmap_cache_timeout=
+			[NFS] set the maximum lifetime for idmapper cache
+			entries.
+
 	nfs.max_session_cb_slots=
 			[NFSv4.1] Sets the maximum number of session
 			slots the client will assign to the callback
@@ -3492,21 +3483,14 @@
 			will be autodetected by the client, and it will fall
 			back to using the idmapper.
 			To turn off this behaviour, set the value to '0'.
+
 	nfs.nfs4_unique_id=
 			[NFS4] Specify an additional fixed unique ident-
 			ification string that NFSv4 clients can insert into
 			their nfs_client_id4 string.  This is typically a
 			UUID that is generated at system install time.
 
-	nfs.send_implementation_id =
-			[NFSv4.1] Send client implementation identification
-			information in exchange_id requests.
-			If zero, no implementation identification information
-			will be sent.
-			The default is to send the implementation identification
-			information.
-
-	nfs.recover_lost_locks =
+	nfs.recover_lost_locks=
 			[NFSv4] Attempt to recover locks that were lost due
 			to a lease timeout on the server. Please note that
 			doing this risks data corruption, since there are
@@ -3518,7 +3502,15 @@
 			The default parameter value of '0' causes the kernel
 			not to attempt recovery of lost locks.
 
-	nfs4.layoutstats_timer =
+	nfs.send_implementation_id=
+			[NFSv4.1] Send client implementation identification
+			information in exchange_id requests.
+			If zero, no implementation identification information
+			will be sent.
+			The default is to send the implementation identification
+			information.
+
+	nfs4.layoutstats_timer=
 			[NFSv4.2] Change the rate at which the kernel sends
 			layoutstats to the pNFS metadata server.
 
@@ -3527,12 +3519,19 @@
 			driver. A non-zero value sets the minimum interval
 			in seconds between layoutstats transmissions.
 
-	nfsd.inter_copy_offload_enable =
+	nfsd.inter_copy_offload_enable=
 			[NFSv4.2] When set to 1, the server will support
 			server-to-server copies for which this server is
 			the destination of the copy.
 
-	nfsd.nfsd4_ssc_umount_timeout =
+	nfsd.nfs4_disable_idmapping=
+			[NFSv4] When set to the default of '1', the NFSv4
+			server will return only numeric uids and gids to
+			clients using auth_sys, and will accept numeric uids
+			and gids from such clients.  This is intended to ease
+			migration from NFSv2/v3.
+
+	nfsd.nfsd4_ssc_umount_timeout=
 			[NFSv4.2] When used as the destination of a
 			server-to-server copy, knfsd temporarily mounts
 			the source server.  It caches the mount in case
@@ -3540,13 +3539,14 @@
 			used for the number of milliseconds specified by
 			this parameter.
 
-	nfsd.nfs4_disable_idmapping=
-			[NFSv4] When set to the default of '1', the NFSv4
-			server will return only numeric uids and gids to
-			clients using auth_sys, and will accept numeric uids
-			and gids from such clients.  This is intended to ease
-			migration from NFSv2/v3.
+	nfsaddrs=	[NFS] Deprecated.  Use ip= instead.
+			See Documentation/admin-guide/nfs/nfsroot.rst.
+
+	nfsroot=	[NFS] nfs root filesystem for disk-less boxes.
+			See Documentation/admin-guide/nfs/nfsroot.rst.
 
+	nfsrootdebug	[NFS] enable nfsroot debugging messages.
+			See Documentation/admin-guide/nfs/nfsroot.rst.
 
 	nmi_backtrace.backtrace_idle [KNL]
 			Dump stacks even of idle CPUs in response to an
