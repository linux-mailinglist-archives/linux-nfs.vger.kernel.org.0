Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA5265034
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Sep 2020 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgIJUIA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Sep 2020 16:08:00 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55905 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIJUGs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Sep 2020 16:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1599768408; x=1631304408;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=U/17dhFzVoYN9syJU0oQsrBTAZmFFgl6ZBB+fFcBKbI=;
  b=P0+QiFT3pdlo82QijmaIxYWMeP677hIVhgWbBJLGg/aOv17OJQ6CRjAK
   TuIksi1THBISk+xvd4wH27t/q4+jiG8kVu2/H9UiohVp+dfvjngzRddK+
   G/23OmNzh83bjk+rhMmkN1p1xn/gKLJzEfd4BtFnh1AGn8I3t0d3p64ji
   k=;
X-IronPort-AV: E=Sophos;i="5.76,413,1592870400"; 
   d="scan'208";a="53085255"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Sep 2020 20:06:47 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id A5863282108;
        Thu, 10 Sep 2020 20:06:45 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 20:06:44 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 20:06:44 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Thu, 10 Sep 2020 20:06:44 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 6992FC1429; Thu, 10 Sep 2020 20:06:44 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>, <dhowells@redhat.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH] nfs: round down reported block numbers in statfs
Date:   Thu, 10 Sep 2020 20:06:44 +0000
Message-ID: <20200910200644.8165-1-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs_statfs rounds up the numbers of blocks as computed
from the numbers the server return values.

This works out well if the client block size, which is
the same as wrsize, is smaller than or equal to the actual
filesystem block size on the server.

But, for NFS4, the size is usually larger (1M), meaning
that statfs reports more free space than actually is
available. This confuses, for example, fstest generic/103.

Given a choice between reporting too much or too little
space, the latter is the safer option, so don't round
up the number of blocks. This also simplifies the code.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/super.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7a70287f21a2..45d368a5cc95 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -217,8 +217,6 @@ EXPORT_SYMBOL_GPL(nfs_client_for_each_server);
 int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct nfs_server *server = NFS_SB(dentry->d_sb);
-	unsigned char blockbits;
-	unsigned long blockres;
 	struct nfs_fh *fh = NFS_FH(d_inode(dentry));
 	struct nfs_fsstat res;
 	int error = -ENOMEM;
@@ -241,26 +239,11 @@ int nfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	buf->f_type = NFS_SUPER_MAGIC;
 
-	/*
-	 * Current versions of glibc do not correctly handle the
-	 * case where f_frsize != f_bsize.  Eventually we want to
-	 * report the value of wtmult in this field.
-	 */
-	buf->f_frsize = dentry->d_sb->s_blocksize;
-
-	/*
-	 * On most *nix systems, f_blocks, f_bfree, and f_bavail
-	 * are reported in units of f_frsize.  Linux hasn't had
-	 * an f_frsize field in its statfs struct until recently,
-	 * thus historically Linux's sys_statfs reports these
-	 * fields in units of f_bsize.
-	 */
 	buf->f_bsize = dentry->d_sb->s_blocksize;
-	blockbits = dentry->d_sb->s_blocksize_bits;
-	blockres = (1 << blockbits) - 1;
-	buf->f_blocks = (res.tbytes + blockres) >> blockbits;
-	buf->f_bfree = (res.fbytes + blockres) >> blockbits;
-	buf->f_bavail = (res.abytes + blockres) >> blockbits;
+
+	buf->f_blocks = res.tbytes / buf->f_bsize;
+	buf->f_bfree = res.fbytes / buf->f_bsize;
+	buf->f_bavail = res.abytes / buf->f_bsize;
 
 	buf->f_files = res.tfiles;
 	buf->f_ffree = res.afiles;
-- 
2.16.6

