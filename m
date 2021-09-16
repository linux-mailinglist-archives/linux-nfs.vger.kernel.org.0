Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7B840EA93
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Sep 2021 21:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbhIPTFG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Sep 2021 15:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241775AbhIPTEy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Sep 2021 15:04:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86CEA61207;
        Thu, 16 Sep 2021 19:03:33 +0000 (UTC)
Subject: [PATCH] NLM: Remove svcxdr_encode_owner()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dai.ngo@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 16 Sep 2021 15:03:32 -0400
Message-ID: <163181894199.1110.356714948732645250.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dai Ngo reports that, since the XDR overhaul, the NLM server crashes
when the TEST procedure wants to return NLM_DENIED. There is a bug
in svcxdr_encode_owner() that none of our standard test cases found.

Replace the open-coded function with a call to an appropriate
pre-fabricated XDR helper.

Reported-by: Dai Ngo <Dai.Ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcxdr.h |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

This might be a little better for the long term. Comments?

diff --git a/fs/lockd/svcxdr.h b/fs/lockd/svcxdr.h
index c69a0bb76c94..805fb19144d7 100644
--- a/fs/lockd/svcxdr.h
+++ b/fs/lockd/svcxdr.h
@@ -134,18 +134,9 @@ svcxdr_decode_owner(struct xdr_stream *xdr, struct xdr_netobj *obj)
 static inline bool
 svcxdr_encode_owner(struct xdr_stream *xdr, const struct xdr_netobj *obj)
 {
-	unsigned int quadlen = XDR_QUADLEN(obj->len);
-	__be32 *p;
-
-	if (xdr_stream_encode_u32(xdr, obj->len) < 0)
-		return false;
-	p = xdr_reserve_space(xdr, obj->len);
-	if (!p)
+	if (unlikely(obj->len > XDR_MAX_NETOBJ))
 		return false;
-	p[quadlen - 1] = 0;	/* XDR pad */
-	memcpy(p, obj->data, obj->len);
-
-	return true;
+	return xdr_stream_encode_opaque(xdr, obj->data, obj->len) > 0;
 }
 
 #endif /* _LOCKD_SVCXDR_H_ */


