Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D407235F53A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351577AbhDNNoj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351611AbhDNNoY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB437611F2
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407843;
        bh=q48Ky1nmUGHIcEwWxnjWjx302h1CqIWJtkjhILW9cRg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VahL8dUEqpHO0tu1pFExulwvsjiVE3gcE3SnZlJ4kSNIlLC97NkpIwlC4UXsUtc+5
         uhl7+ftsWjg8YDFREAig80cVPHN3UHaOapzKYMKJxEEjWLr2f9SKq0+NYEOQZY7D/o
         P41Lx684c1z+D4+cu4rl9BK4PMmhwwZIgHvv+wWzsvP6iPV9gQzJ+MI6Q4BwsaKGkZ
         aetNPGBiw1wVh6WV/X5U+7JYcOd0hf8kGLOKbdqaBfyabGkt4/q0AM/94C10WL+Ua0
         aOXcxPfFcBry85oJfrpcX8rNMlJOdJivUAnULNcGDt3Xs459zxe8jlUAG0bN2LWV1Q
         saVALbctB74EQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 18/26] NFSv4: Fix value of decode_fsinfo_maxsz
Date:   Wed, 14 Apr 2021 09:43:45 -0400
Message-Id: <20210414134353.11860-19-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-18-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
 <20210414134353.11860-11-trondmy@kernel.org>
 <20210414134353.11860-12-trondmy@kernel.org>
 <20210414134353.11860-13-trondmy@kernel.org>
 <20210414134353.11860-14-trondmy@kernel.org>
 <20210414134353.11860-15-trondmy@kernel.org>
 <20210414134353.11860-16-trondmy@kernel.org>
 <20210414134353.11860-17-trondmy@kernel.org>
 <20210414134353.11860-18-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

At least two extra fields have been added to fsinfo since this was last
updated.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4xdr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index ac6b79ee9355..d8a1911dd39e 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -144,7 +144,16 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
  * layout types will be returned.
  */
 #define decode_fsinfo_maxsz	(op_decode_hdr_maxsz + \
-				 nfs4_fattr_bitmap_maxsz + 4 + 8 + 5)
+				 nfs4_fattr_bitmap_maxsz + 1 + \
+				 1 /* lease time */ + \
+				 2 /* max filesize */ + \
+				 2 /* max read */ + \
+				 2 /* max write */ + \
+				 nfstime4_maxsz /* time delta */ + \
+				 5 /* fs layout types */ + \
+				 1 /* layout blksize */ + \
+				 1 /* clone blksize */ + \
+				 1 /* xattr support */)
 #define encode_renew_maxsz	(op_encode_hdr_maxsz + 3)
 #define decode_renew_maxsz	(op_decode_hdr_maxsz)
 #define encode_setclientid_maxsz \
-- 
2.30.2

