Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC9B3CAD58
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 21:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbhGOT6I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Jul 2021 15:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244507AbhGOT4C (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 15 Jul 2021 15:56:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7853613C3;
        Thu, 15 Jul 2021 19:52:31 +0000 (UTC)
Subject: [PATCH v2 5/7] NFS: Remove unused callback void decoder
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 15 Jul 2021 15:52:31 -0400
Message-ID: <162637875110.728653.5728103112495625271.stgit@manet.1015granger.net>
In-Reply-To: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
References: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: The callback RPC dispatcher no longer invokes these call
outs, although svc_process_common() relies on seeing a .pc_encode
function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback_xdr.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index e30374e363a6..c1d08ab1fe22 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -63,11 +63,10 @@ static __be32 nfs4_callback_null(struct svc_rqst *rqstp)
 	return htonl(NFS4_OK);
 }
 
-static int nfs4_decode_void(struct svc_rqst *rqstp, __be32 *p)
-{
-	return xdr_argsize_check(rqstp, p);
-}
-
+/*
+ * svc_process_common() looks for an XDR encoder to know when
+ * not to drop a Reply.
+ */
 static int nfs4_encode_void(struct svc_rqst *rqstp, __be32 *p)
 {
 	return xdr_ressize_check(rqstp, p);
@@ -1067,7 +1066,6 @@ static struct callback_op callback_ops[] = {
 static const struct svc_procedure nfs4_callback_procedures1[] = {
 	[CB_NULL] = {
 		.pc_func = nfs4_callback_null,
-		.pc_decode = nfs4_decode_void,
 		.pc_encode = nfs4_encode_void,
 		.pc_xdrressize = 1,
 		.pc_name = "NULL",


