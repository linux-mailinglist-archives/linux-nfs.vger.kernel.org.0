Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1094C05BA
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 01:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiBWAEY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Feb 2022 19:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiBWAEW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Feb 2022 19:04:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49450DF5
        for <linux-nfs@vger.kernel.org>; Tue, 22 Feb 2022 16:03:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 000A3B81CA8
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 00:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E73DC340E8;
        Wed, 23 Feb 2022 00:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645574633;
        bh=5AnU2U/r9nlmACdUQEefVj4WV6rRsj1WFaouTuf6n1I=;
        h=From:To:Cc:Subject:Date:From;
        b=O7xpl9ldH8EURP1c/YrFBVv/Dt9x1uvuGWvxeEz6rqY4lWXEtK92AagSd9lV8rhH1
         pDaV2AVV7UiBnXjPx4QSJl7AFsRBYtGEh3BXHibae3Z/8dUSQOIETs8u9hBwdFq4yL
         kUemH5+ruT9DCxCwDzJJ1uGzfpSj6Us+1cgnDmlOyPeNg4bkxUsjU6uHew2EBrox6A
         NduuD57FBI1elcnPl3XvyOwHKP2smvMR4uFJi3uhRdo4R6TBp56qRpGHL17Jnn9YZC
         ABCPzeHYn0ba9utb4RpafzQEnsyExNhPcbR7j4+/qFrQeTM8pyiBWLyfUErT6OIonU
         C95/V0eQtu6EA==
From:   trondmy@kernel.org
To:     Olga Kornievskaia <kolga@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: NFSv2/v3 clients should never be setting NFS_CAP_XATTR
Date:   Tue, 22 Feb 2022 18:57:27 -0500
Message-Id: <20220222235727.1157439-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that we always initialise the 'xattr_support' field in struct
nfs_fsinfo, so that nfs_server_set_fsinfo() doesn't declare our NFSv2/v3
client to be capable of supporting the NFSv4.2 xattr protocol by setting
the NFS_CAP_XATTR capability.

This configuration can cause nfs_do_access() to set access mode bits
that are unsupported by the NFSv3 ACCESS call, which may confuse
spec-compliant servers.

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Fixes: b78ef845c35d ("NFSv4.2: query the server for extended attribute support")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs3xdr.c | 1 +
 fs/nfs/proc.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index feb6e2e36138..296320f91579 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2229,6 +2229,7 @@ static int decode_fsinfo3resok(struct xdr_stream *xdr,
 	/* ignore properties */
 	result->lease_time = 0;
 	result->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
+	result->xattr_support = 0;
 	return 0;
 }
 
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 73dcaa99fa9b..e3570c656b0f 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -92,6 +92,7 @@ nfs_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
 	info->maxfilesize = 0x7FFFFFFF;
 	info->lease_time = 0;
 	info->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
+	info->xattr_support = 0;
 	return 0;
 }
 
-- 
2.35.1

