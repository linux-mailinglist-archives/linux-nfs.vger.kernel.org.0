Return-Path: <linux-nfs+bounces-11628-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E071AB1CFE
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 742751C06DAF
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811BD241674;
	Fri,  9 May 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE1t4n9u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DBC242D9F;
	Fri,  9 May 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817442; cv=none; b=ooIR4SFXBUp1VsWVYeYh5tcpwUW3/0wNCK5vJ81VCU8tdkSyrO9DlYWZwsCBQ+d4oVtQ+JIRp1z1FJaQtvL9WQN5TfFOAYRRn0Tt8zbEZrFkktuxDX+ZMgLs0yiDCG/v8FrPG5wJ6p5kmua7wagUiQoZWEcAvW5f4AH702hOsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817442; c=relaxed/simple;
	bh=d+6yNkdfB1wIHXDMYFeRnAp5j3cUOzXn3TkJoEgkx5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6OGGqiqWV1uXxyOqNAlyPxqgEpxjPNBcuWpc9ooh3O295C5KfFRofO5ct6C8AZg5trySNr+QQDPxsoIU2PSpU/4aaFoj3IeczMHp2Ynsz5T6lIrNhjxdwtbsz9rrOUbfj5p5URejX72VqLEX7+WpX+8beQ6z6Viorq8Z79jFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE1t4n9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F519C4CEF0;
	Fri,  9 May 2025 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817441;
	bh=d+6yNkdfB1wIHXDMYFeRnAp5j3cUOzXn3TkJoEgkx5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rE1t4n9uD+BfNUtQpubwx7RmDzm7wNdI+wC69SMkY0OfmXr7xpjxtAojRJVG4AmHq
	 if9rapO5JjclijrcBREtKAuyXkHmlMPEtIq8IkIQnDDXRBIpBWXeOmXZQ0ejQYvYCf
	 cXZD+Idg8N5Wqb0W+OG5dJ2v0HabBBfyJsAH47Os6Nb9lX885YcGut/8VcEEby/bTL
	 L8qKXqYdwc2GN5iLcpwbNQddEk6yq1fZSlXGE1A7dhQTyf6uZ58gqGvw8sv+SEvzQc
	 tWE+4YWOTs2ho5eGqV8+/F09CRaYZQgo+Bk8rhR1sYu/taNn5qs8JV6QPG2IN912HM
	 YKwctQY1zJnXQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v5 06/19] NFSD: Use rqstp->rq_bvec in nfsd_iter_read()
Date: Fri,  9 May 2025 15:03:40 -0400
Message-ID: <20250509190354.5393-7-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

If we can get rid of all uses of rq_vec, then it can be removed.
Replace one use of rqstp::rq_vec with rqstp::rq_bvec.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index d0dfd97de4d3..7cfd26dec5a8 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1085,23 +1085,23 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned long v, total;
 	struct iov_iter iter;
 	loff_t ppos = offset;
-	struct page *page;
 	ssize_t host_err;
+	size_t len;
 
 	v = 0;
 	total = *count;
 	while (total) {
-		page = *(rqstp->rq_next_page++);
-		rqstp->rq_vec[v].iov_base = page_address(page) + base;
-		rqstp->rq_vec[v].iov_len = min_t(size_t, total, PAGE_SIZE - base);
-		total -= rqstp->rq_vec[v].iov_len;
+		len = min_t(size_t, total, PAGE_SIZE - base);
+		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
+			      len, base);
+		total -= len;
 		++v;
 		base = 0;
 	}
-	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
+	WARN_ON_ONCE(v > rqstp->rq_maxpages);
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
+	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
 	host_err = vfs_iter_read(file, &iter, &ppos, 0);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
-- 
2.49.0


