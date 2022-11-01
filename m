Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2145F6150AE
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Nov 2022 18:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiKARau (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Nov 2022 13:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiKARat (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Nov 2022 13:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095841C114
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 10:30:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98C69616D4
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 17:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF786C433C1
        for <linux-nfs@vger.kernel.org>; Tue,  1 Nov 2022 17:30:47 +0000 (UTC)
Subject: [PATCH] NFSD: Flesh out a documenting comment for filecache.c
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 01 Nov 2022 13:30:46 -0400
Message-ID: <166732362009.147807.16481897041798638515.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Record what we've learned recently about the NFSD filecache in a
documenting comment so our future selves don't forget what all this
is for.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

Here's what I had in mind for the top-of-file comment.


diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 28f91c97e045..02b4871b9ffc 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -2,6 +2,30 @@
  * Open file cache.
  *
  * (c) 2015 - Jeff Layton <jeff.layton@primarydata.com>
+ *
+ * An nfsd_file object is a per-file collection of open state that binds
+ * together:
+ *   - a struct file *
+ *   - a user credential
+ *   - a network namespace
+ *   - a read-ahead context
+ *   - monitoring for writeback errors
+ *
+ * nfsd_file objects are reference-counted. Consumers acquire a new
+ * object via the nfsd_file_acquire API. They manage their interest in
+ * the acquired object, and hence the object's reference count, via
+ * nfsd_file_get and nfsd_file_put. There are two varieties of nfsd_file
+ * object:
+ *
+ *  * non-garbage-collected: When a consumer wants to precisely control
+ *    the lifetime of a file's open state, it acquires a non-garbage-
+ *    collected nfsd_file. The final nfsd_file_put releases the open
+ *    state immediately.
+ *
+ *  * garbage-collected: When a consumer does not control the lifetime
+ *    of open state, it acquires a garbage-collected nfsd_file. The
+ *    final nfsd_file_put allows the open state to linger for a period
+ *    during which it may be re-used.
  */
 
 #include <linux/hash.h>


