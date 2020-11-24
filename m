Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE0B2C28B3
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 14:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbgKXNuc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 08:50:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388591AbgKXNuc (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Nov 2020 08:50:32 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99BF520897
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606225831;
        bh=lRdus7alrRq9J5OyXO6Oqs0+q/783G8MRItNfs6uru0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Fynoa0WLc9PBicKj1dTnRdndE7EYUvs3LXUSBG2h2+q13aloO8CDhno5ZNQ/0nhMn
         lcwzB/hudUKkSN6NV+Bg9O17kcLHYu6UFbwyStfmPff1xPs5wh/CFrOwF1PL38sDUh
         1vezYaFlaUO+ocukgseLxEHczTtdPJ/+EQO7DjYs=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 9/9] NFSv4.2: Fix up read_plus() page alignment
Date:   Tue, 24 Nov 2020 08:50:25 -0500
Message-Id: <20201124135025.1097571-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201124135025.1097571-9-trondmy@kernel.org>
References: <20201124135025.1097571-1-trondmy@kernel.org>
 <20201124135025.1097571-2-trondmy@kernel.org>
 <20201124135025.1097571-3-trondmy@kernel.org>
 <20201124135025.1097571-4-trondmy@kernel.org>
 <20201124135025.1097571-5-trondmy@kernel.org>
 <20201124135025.1097571-6-trondmy@kernel.org>
 <20201124135025.1097571-7-trondmy@kernel.org>
 <20201124135025.1097571-8-trondmy@kernel.org>
 <20201124135025.1097571-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Assume that the first record is a data record, and that we have to read
the 8+4 first bytes of that record before the call to nfs_align_pages().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42xdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 6e060a88f98c..f5abace015d7 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -760,14 +760,16 @@ static void nfs4_xdr_enc_read_plus(struct rpc_rqst *req,
 	struct compound_hdr hdr = {
 		.minorversion = nfs4_xdr_minorversion(&args->seq_args),
 	};
+	unsigned int replen;
 
 	encode_compound_hdr(xdr, req, &hdr);
 	encode_sequence(xdr, &args->seq_args, &hdr);
 	encode_putfh(xdr, args->fh, &hdr);
+	replen = hdr.replen + op_decode_hdr_maxsz + 2 + 1 + 3;
 	encode_read_plus(xdr, args, &hdr);
 
 	rpc_prepare_reply_pages(req, args->pages, args->pgbase,
-				args->count, hdr.replen);
+				args->count, replen);
 	encode_nops(&hdr);
 }
 
-- 
2.28.0

