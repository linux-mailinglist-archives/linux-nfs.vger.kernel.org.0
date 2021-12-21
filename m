Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7EC47C712
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 19:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbhLUSzo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Dec 2021 13:55:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36186 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241613AbhLUSzn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 13:55:43 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 433631F43227
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1640112942; bh=KiejPSdYWwZWIDImvY8uKQpvAzfQ50qpR1+VWqWnoRQ=;
        h=Date:From:To:Cc:Subject:From;
        b=SUXl0HTDujcu3SWWJRpRHWF+zT8cL22bcdbsMRlxDJCCxZ3mjtFWIel+ux7LbHJ2s
         4regin0H6NjVWMjq1IbW//rEmhIndgfmh2S9yq1Z4xnlXyuJXYxwNnO5iCJ58f6T/f
         IGQcKuzGNsY03KNw5V/pzBEVfCcEiuSRas0Mhss3Gat+qiW6IJhLbEAVYLieJcSR+h
         9stFowDKrBlz1t/WWxRnVGYLPYjyWTdLtxRZY6/KH1gfjZu5c3JKO9Q18sG80IDfB0
         Iyzmmv0Rj/jqoqaFPNmChRbUtelIE/iFCuiY3E8g0MJ3i+xNuL1DMBSXgDhZ+RJrYr
         E0aI5hO1IZZbg==
Date:   Tue, 21 Dec 2021 23:55:35 +0500
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        "open list:KERNEL NFSD, SUNRPC, AND LOCKD SERVERS" 
        <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] nfs: check nf pointer for validity before use
Message-ID: <YcIjJ4jN3ax1rqaE@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Pointer nf can be NULL. It should be validated before dereferencing it.

Fixes: 8628027ba8 ("nfs: block notification on fs with its own ->lock")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 fs/nfsd/nfs4state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a526d4183348..bdd30988e615 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6947,6 +6947,11 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
+	if (!nf) {
+		status = nfserr_openmode;
+		goto out;
+	}
+
 	/*
 	 * Most filesystems with their own ->lock operations will block
 	 * the nfsd thread waiting to acquire the lock.  That leads to
@@ -6957,11 +6962,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (nf->nf_file->f_op->lock)
 		fl_flags &= ~FL_SLEEP;
 
-	if (!nf) {
-		status = nfserr_openmode;
-		goto out;
-	}
-
 	nbl = find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
 	if (!nbl) {
 		dprintk("NFSD: %s: unable to allocate block!\n", __func__);
-- 
2.30.2

