Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B975F788F1A
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Aug 2023 21:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjHYTFN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Aug 2023 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjHYTEl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Aug 2023 15:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9C2269E
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 12:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3000C664CF
        for <linux-nfs@vger.kernel.org>; Fri, 25 Aug 2023 19:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61AA1C433C8;
        Fri, 25 Aug 2023 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692990264;
        bh=dh4BMSz1eaZB6T+6rPQNHmQQV+4CbhTMN22I+CDAyN0=;
        h=Subject:From:To:Cc:Date:From;
        b=a+zTQRIVyi2K5w/AHt4p7VbmRDeY5t5peDyO54+pMHwcLHveDQOA8PYm3TwuvgQZw
         J4Lk5YXHx9Dr67JKUPmaB53jc2BEbUxgopMpBPTpqicqob9GcPWKcVYfjgB0XcphNB
         muiy9QbgNPKCkl8Bw+0lcenK2TqbtGNT0JeOXppRwVyxjWKQxlgqdkoVpMijVyp3fQ
         xqCOv0WAkbhnPcQINCx5Y3K9HW2+KBc0i9vrhfu9OcN0MV3z5eUcpIBYRFNIMSk95K
         +aQJi5dvFbq4DV/I/q/+WzjiKpcWVbfrduTYXuaObZOVgldVo+lMPm5kpe7u9ImCMw
         iCnzpEbsBpY1A==
Subject: [PATCH v1] Documentation: Add missing documentation for EXPORT_OP
 flags
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Fri, 25 Aug 2023 15:04:23 -0400
Message-ID: <169299026325.2390.1015871591753526415.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The commits that introduced these flags neglected to update the
Documentation/filesystems/nfs/exporting.rst file.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 Documentation/filesystems/nfs/exporting.rst |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 3d97b8d8f735..02c8c6e9cdb2 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -215,3 +215,28 @@ following flags are defined:
     This flag causes nfsd to close any open files for this inode _before_
     calling into the vfs to do an unlink or a rename that would replace
     an existing file.
+
+  EXPORT_OP_REMOTE_FS - Backing storage for this filesystem is remote
+    PF_LOCAL_THROTTLE exists for loop-back NFSD, where a thread needs to
+    write to one bdi (the final bdi) in order to free up writes queued
+    to another bdi (the client bdi). Such threads get a private balance
+    of dirty pages so that dirty pages for the client bdi do not imact
+    the daemon writing to the final bdi. For filesystems whose durable
+    storage is not local (such as exported NFS filesystems), this
+    constraint has negative consequences.
+
+  EXPORT_OP_NOATOMIC_ATTR - Filesystem does not update attributes atomically
+    EXPORT_OP_NOATOMIC_ATTR indicates that the exported filesystem
+    cannot provide the semantics required by the "atomic" boolean in
+    NFSv4's change_info4. This boolean indicates to a client whether the
+    returned before and after change attributes were obtained atomically
+    with the respect to the requested metadata operation (UNLINK,
+    OPEN/CREATE, MKDIR, etc).
+
+  EXPORT_OP_FLUSH_ON_CLOSE - Filesystem flushes file data on close(2)
+    On most filesystems, inodes can remain under writeback after the
+    file is closed. NFSD relies on client activity or local flusher
+    threads to handle writeback. Certain filesystems, such as NFS, flush
+    all of an inode's dirty data on last close. Exports that behave this
+    way should set EXPORT_OP_FLUSH_ON_CLOSE so that NFSD knows to skip
+    waiting for writeback when closing such files.


