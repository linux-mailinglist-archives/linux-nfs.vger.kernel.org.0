Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABB62D7CD3
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395153AbgLKR1H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:27:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395250AbgLKR0q (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:26:46 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 12/15] NFSv4.2: Handle hole lengths that exceed the READ_PLUS read buffer
Date:   Fri, 11 Dec 2020 12:25:18 -0500
Message-Id: <20201211172521.5567-13-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-12-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
 <20201211172521.5567-3-trondmy@kernel.org>
 <20201211172521.5567-4-trondmy@kernel.org>
 <20201211172521.5567-5-trondmy@kernel.org>
 <20201211172521.5567-6-trondmy@kernel.org>
 <20201211172521.5567-7-trondmy@kernel.org>
 <20201211172521.5567-8-trondmy@kernel.org>
 <20201211172521.5567-9-trondmy@kernel.org>
 <20201211172521.5567-10-trondmy@kernel.org>
 <20201211172521.5567-11-trondmy@kernel.org>
 <20201211172521.5567-12-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a hole extends beyond the READ_PLUS read buffer, then we want to fill
just the remaining buffer with zeros. Also ignore eof...

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42xdr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index f9faa131a4f5..6ba2a28e7e03 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1080,6 +1080,12 @@ static int decode_read_plus_hole(struct xdr_stream *xdr,
 		}
 		length -= args->offset + res->count - offset;
 	}
+	if (length + res->count > args->count) {
+		*eof = 0;
+		if (unlikely(res->count >= args->count))
+			return 1;
+		length = args->count - res->count;
+	}
 	recvd = xdr_expand_hole(xdr, res->count, length);
 	res->count += recvd;
 
-- 
2.29.2

