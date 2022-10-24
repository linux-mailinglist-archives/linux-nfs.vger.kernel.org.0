Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76560BF64
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Oct 2022 02:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiJYASC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Oct 2022 20:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiJYARp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Oct 2022 20:17:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059F7915FE
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 15:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3BCBB810B2
        for <linux-nfs@vger.kernel.org>; Mon, 24 Oct 2022 22:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F58C433D6;
        Mon, 24 Oct 2022 22:37:38 +0000 (UTC)
Subject: [PATCH v5 07/13] NFSD: Update file_hashtbl() helpers
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     neilb@suse.de
Date:   Mon, 24 Oct 2022 18:37:37 -0400
Message-ID: <166665105737.50761.10180321804226640809.stgit@klimt.1015granger.net>
In-Reply-To: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
References: <166664935937.50761.7812494396457965637.stgit@klimt.1015granger.net>
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
---
 fs/nfsd/nfs4state.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index db58d5c0bba8..90c991e500a8 100644
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
 


