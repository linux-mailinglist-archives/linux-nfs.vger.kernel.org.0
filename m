Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084805393A6
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345587AbiEaPKH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 11:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345531AbiEaPJ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 11:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6C4994F3
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 08:09:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 253246134A
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 15:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B749C385A9;
        Tue, 31 May 2022 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009795;
        bh=6Q9iVIuD/A7lIpuUFB4UsLVVfl7axXZUL2athRvSggg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhLAc8SINDZoyqg74RpEQGdkNtUnUCPdXXUVLtkb6Rcq1+ISNr3LZ3k40HoQm8TGQ
         wwho/6fNuir6USvRdO6ZQbUJ5b0LGTT3D1c0fGe9unZWMu3pOco6r39UZfdclEQcA+
         1gBReSheyifFZvRQreFVnY0G4wWR9CYtf/sVEtC6A6DOr0sm1Re+68wbgKrUzqHiVe
         vko+GD3Dw4AaQi8jC/0Qxkhx9uIx1udfg/kRZ97ZtjHVBSiOqB1mdFku2jNYWJ3th6
         aYeAhqA2WumK9yYJyiKHyek21t0Lg16ddEzVCFeL7mp4bt4l+OTN6HdlzG5r5Yt08S
         NT0XlInHH6jdQ==
From:   trondmy@kernel.org
To:     Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] pNFS: Avoid a live lock condition in pnfs_update_layout()
Date:   Tue, 31 May 2022 11:03:07 -0400
Message-Id: <20220531150307.6170-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531150307.6170-1-trondmy@kernel.org>
References: <20220531150307.6170-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're about to send the first layoutget for an empty layout, we want
to make sure that we drain out the existing pending layoutget calls
first. The reason is that these layouts may have been already implicitly
returned to the server by a recall to which the client gave a
NFS4ERR_NOMATCHING_LAYOUT response.

The problem is that wait_var_event_killable() could in principle see the
plh_outstanding count go back to '1' when the first process to wake up
starts sending a new layoutget. If it fails to get a layout, then this
loop can continue ad infinitum...

Fixes: 0b77f97a7e42 ("NFSv4/pnfs: Fix layoutget behaviour after invalidation")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/callback_proc.c |  1 +
 fs/nfs/pnfs.c          | 15 +++++++++------
 fs/nfs/pnfs.h          |  1 +
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index c8520284dda7..c1eda73254e1 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -288,6 +288,7 @@ static u32 initiate_file_draining(struct nfs_client *clp,
 		rv = NFS4_OK;
 		break;
 	case -ENOENT:
+		set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
 		/* Embrace your forgetfulness! */
 		rv = NFS4ERR_NOMATCHING_LAYOUT;
 
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 4609e641710e..41a9b6b58fb9 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -469,6 +469,7 @@ pnfs_mark_layout_stateid_invalid(struct pnfs_layout_hdr *lo,
 		pnfs_clear_lseg_state(lseg, lseg_list);
 	pnfs_clear_layoutreturn_info(lo);
 	pnfs_free_returned_lsegs(lo, lseg_list, &range, 0);
+	set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
 	if (test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags) &&
 	    !test_and_set_bit(NFS_LAYOUT_RETURN_LOCK, &lo->plh_flags))
 		pnfs_clear_layoutreturn_waitbit(lo);
@@ -1917,8 +1918,9 @@ static void nfs_layoutget_begin(struct pnfs_layout_hdr *lo)
 
 static void nfs_layoutget_end(struct pnfs_layout_hdr *lo)
 {
-	if (atomic_dec_and_test(&lo->plh_outstanding))
-		wake_up_var(&lo->plh_outstanding);
+	if (atomic_dec_and_test(&lo->plh_outstanding) &&
+	    test_and_clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags))
+		wake_up_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN);
 }
 
 static bool pnfs_is_first_layoutget(struct pnfs_layout_hdr *lo)
@@ -2025,11 +2027,11 @@ pnfs_update_layout(struct inode *ino,
 	 * If the layout segment list is empty, but there are outstanding
 	 * layoutget calls, then they might be subject to a layoutrecall.
 	 */
-	if ((list_empty(&lo->plh_segs) || !pnfs_layout_is_valid(lo)) &&
+	if (test_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags) &&
 	    atomic_read(&lo->plh_outstanding) != 0) {
 		spin_unlock(&ino->i_lock);
-		lseg = ERR_PTR(wait_var_event_killable(&lo->plh_outstanding,
-					!atomic_read(&lo->plh_outstanding)));
+		lseg = ERR_PTR(wait_on_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN,
+					   TASK_KILLABLE));
 		if (IS_ERR(lseg))
 			goto out_put_layout_hdr;
 		pnfs_put_layout_hdr(lo);
@@ -2413,7 +2415,8 @@ pnfs_layout_process(struct nfs4_layoutget *lgp)
 		goto out_forget;
 	}
 
-	if (!pnfs_layout_is_valid(lo) && !pnfs_is_first_layoutget(lo))
+	if (test_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags) &&
+	    !pnfs_is_first_layoutget(lo))
 		goto out_forget;
 
 	if (nfs4_stateid_match_other(&lo->plh_stateid, &res->stateid)) {
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 07f11489e4e9..f331f067691b 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -105,6 +105,7 @@ enum {
 	NFS_LAYOUT_FIRST_LAYOUTGET,	/* Serialize first layoutget */
 	NFS_LAYOUT_INODE_FREEING,	/* The inode is being freed */
 	NFS_LAYOUT_HASHED,		/* The layout visible */
+	NFS_LAYOUT_DRAIN,
 };
 
 enum layoutdriver_policy_flags {
-- 
2.36.1

