Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8756E37FA6F
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 17:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhEMPRz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 11:17:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhEMPRy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 11:17:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lhD4q-0004tp-28; Thu, 13 May 2021 15:16:40 +0000
From:   Colin King <colin.king@canonical.com>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: remove redundant assignment to pointer 'this'
Date:   Thu, 13 May 2021 16:16:39 +0100
Message-Id: <20210513151639.73435-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer 'this' is being initialized with a value that is never read
and it is being updated later with a new value. The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f4ce93d7f26e..712df4b7dcb2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3232,7 +3232,7 @@ bool nfsd4_spo_must_allow(struct svc_rqst *rqstp)
 {
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
 	struct nfsd4_compoundargs *argp = rqstp->rq_argp;
-	struct nfsd4_op *this = &argp->ops[resp->opcnt - 1];
+	struct nfsd4_op *this;
 	struct nfsd4_compound_state *cstate = &resp->cstate;
 	struct nfs4_op_map *allow = &cstate->clp->cl_spo_must_allow;
 	u32 opiter;
-- 
2.30.2

