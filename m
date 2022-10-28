Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4230261151D
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiJ1OtH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 10:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiJ1Os3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 10:48:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C15A1F8128
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 07:47:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38E6CCE2BD5
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 14:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F743C433C1;
        Fri, 28 Oct 2022 14:47:23 +0000 (UTC)
Subject: [PATCH v7 08/14] NFSD: Update file_hashtbl() helpers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de, jlayton@redhat.com
Date:   Fri, 28 Oct 2022 10:47:22 -0400
Message-ID: <166696844244.106044.9547058764290901363.stgit@klimt.1015granger.net>
In-Reply-To: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
References: <166696812922.106044.679812521105874329.stgit@klimt.1015granger.net>
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

Enable callers to use const pointers for type safety.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2e6e1ee096b5..60f1aa2c5442 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -710,7 +710,7 @@ static unsigned int ownerstr_hashval(struct xdr_netobj *ownername)
 #define FILE_HASH_BITS                   8
 #define FILE_HASH_SIZE                  (1 << FILE_HASH_BITS)
 
-static unsigned int file_hashval(struct svc_fh *fh)
+static unsigned int file_hashval(const struct svc_fh *fh)
 {
 	struct inode *inode = d_inode(fh->fh_dentry);
 
@@ -4671,7 +4671,7 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct net *net)
 
 /* search file_hashtbl[] for file */
 static struct nfs4_file *
-find_file_locked(struct svc_fh *fh, unsigned int hashval)
+find_file_locked(const struct svc_fh *fh, unsigned int hashval)
 {
 	struct nfs4_file *fp;
 


