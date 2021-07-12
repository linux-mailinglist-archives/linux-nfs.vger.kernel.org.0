Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1E13C5E99
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jul 2021 16:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhGLOz3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jul 2021 10:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231202AbhGLOz3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 12 Jul 2021 10:55:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0A5D6120A
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jul 2021 14:52:40 +0000 (UTC)
Subject: [PATCH RFC 4/7] NFS: Add a private local dispatcher for NFSv4
 callback operations
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 12 Jul 2021 10:52:40 -0400
Message-ID: <162610156015.2466.9878372753061480550.stgit@klimt.1015granger.net>
In-Reply-To: <162610122257.2466.7452891285800059767.stgit@klimt.1015granger.net>
References: <162610122257.2466.7452891285800059767.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The client's NFSv4 callback service is the only remaining user of
svc_generic_dispatch().

Note that the NFSv4 callback service doesn't use the .pc_encode and
.pc_decode callouts in any substantial way, so they are removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_xdr.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 7ff99155b023..34cb84174196 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -992,6 +992,15 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+static int
+nfs_callback_dispatch(struct svc_rqst *rqstp, __be32 *statp)
+{
+	const struct svc_procedure *procp = rqstp->rq_procinfo;
+
+	*statp = procp->pc_func(rqstp);
+	return !test_bit(RQ_DROPME, &rqstp->rq_flags);
+}
+
 /*
  * Define NFS4 callback COMPOUND ops.
  */
@@ -1080,7 +1089,7 @@ const struct svc_version nfs4_callback_version1 = {
 	.vs_proc = nfs4_callback_procedures1,
 	.vs_count = nfs4_callback_count1,
 	.vs_xdrsize = NFS4_CALLBACK_XDRSIZE,
-	.vs_dispatch = NULL,
+	.vs_dispatch = nfs_callback_dispatch,
 	.vs_hidden = true,
 	.vs_need_cong_ctrl = true,
 };
@@ -1092,7 +1101,7 @@ const struct svc_version nfs4_callback_version4 = {
 	.vs_proc = nfs4_callback_procedures1,
 	.vs_count = nfs4_callback_count4,
 	.vs_xdrsize = NFS4_CALLBACK_XDRSIZE,
-	.vs_dispatch = NULL,
+	.vs_dispatch = nfs_callback_dispatch,
 	.vs_hidden = true,
 	.vs_need_cong_ctrl = true,
 };


