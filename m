Return-Path: <linux-nfs+bounces-15091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F31B6BC991E
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Oct 2025 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1B774FB05D
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Oct 2025 14:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBB92EBDD7;
	Thu,  9 Oct 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YffHYIU8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D940A2EBDC7;
	Thu,  9 Oct 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020830; cv=none; b=u05+hK8ZM5KPGz+zlufK04yUwyk1+sDNmzEsQR7YFz62G5aE24xQNynG2CSH9Xm9H+p0HF4otNtq1+c49tnHjfpR2vOfZ36lvCTtjlbwrzBDyxz7ZPidHd6/+Sr/J8h8CozPoz4NAuvC91S62nibXAJZyHGRuanoCsGfjD5+xLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020830; c=relaxed/simple;
	bh=Q5d3qq8CBu0CFDJAvr0CttImsV3wUOAnXASWJH919jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YuimJfK2voZBfbyUGiX9+xd4ntvWhe0LRqKhVSWFObqp6+dfs667CyGeAgOk06xDbwsRZ9G/+lXERBLLt6CuT8Fg5WEWUetmc/tdoHJ+SOMFMTuue2DW8sTEYeL4x7tAWbSIWR5c1gB595q3prSYR2V3frBQq3EWp6UjVuoZvIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YffHYIU8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9EFC4CEE7;
	Thu,  9 Oct 2025 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760020828;
	bh=Q5d3qq8CBu0CFDJAvr0CttImsV3wUOAnXASWJH919jg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YffHYIU8YTkZ8mhxH1QAlUKOXIOd/BLmVAAZnXKphxDqO+YxuR7Ji8nlX3/eCrjOr
	 WHh5PKm/nAWsLI4hKSJHAMAs6SmgUq3oY/tAV46KoN0bnT0zTrvBO0PoXAWpfa71+v
	 d+KQETK5PB7nMu+sACmykEgaa/jnquIY0dcr0qWuty4kA7kdhLmIaq4MKe7qC2Xkt/
	 7oS88t+IADooyNhuGklZrfjrD57SY1TmGPPlv5pkRFzGXWbh/JxXToSuvbElrdsdgw
	 Cnoj5VYoFFrTQu6MKnWU1VTgwha2W6Imr4GpOXUqd2OaTkIxJpKZFiguzSSglHbKEw
	 plln46j6tsLew==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Oct 2025 10:40:11 -0400
Subject: [PATCH v3 2/2] sunrpc: add a slot to rqstp->rq_bvec for TCP record
 marker
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-rq_bvec-v3-2-57181360b9cb@kernel.org>
References: <20251009-rq_bvec-v3-0-57181360b9cb@kernel.org>
In-Reply-To: <20251009-rq_bvec-v3-0-57181360b9cb@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>
Cc: Brandon Adams <brandona@meta.com>, linux-nfs@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4629; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Q5d3qq8CBu0CFDJAvr0CttImsV3wUOAnXASWJH919jg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo58lVtzZDNIWPHun+Aq9RuSa1HmnFxegY64W1n
 kYaVRf0qtqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaOfJVQAKCRAADmhBGVaC
 FbmND/9bw1uE4pdATCZMvrFyEnaZ5pkYHHfqAhWZVxSbJHKV9Y1gZtz5XtLgLUpuly/rgU/GZCk
 vCj4wqsp9OJX4mn5RDuOYzGIgOcnxuROfJOFeIpvqja5dt8HsuV57lsCLr3xMr1RkS8glV0O7Fh
 0bfZhMTDuufNWWM4eKDBEhHGcNSJp/JTScUxo+EnrsNCxAyFQwPprxL6sNrQFc6Cgz/x1gXTP2h
 Y7Q2MgXo7uIZEiRGQ2QYmK5p3NFlAfs5mdXZ7zb0CLpqsoNEtudsY+N3ZhAWgZfWnfr4NssmKE7
 lSGLLmJ3Pi8nW5Bhk9ErenKQ0DYrrV5Nx7qpZuCR8l7VY4Zh5tXNBQ/sD4mnmh9BgyGgtbIMHQI
 Bpjm8vM3QcU1BQr3dQcsXWaSehU3nEe96hh6uJtz9dMzu2yPUFlie/uM3fBluFryb/MQZcKROH0
 tYTaWTJAx6K6S8ZIJ1QxUlZ5rjfhpqwTemv8s2FjIoRn1i7diWbJlk30lOhKB32a1C3GEFbU1/l
 potB6Tp1Fc7vREUeXc1q8xNhGoP72bVEZEODGRuumazIuO3G+fE+pxOJwitulr6Kv/H7PxkeSe/
 iHcZMV8AjXAdBY7FOBL5x/iukB6A1Gc7gxLr0i1gJplowqp7/bg7F3xEd9I0QtU/da65YaTOsVA
 Hrhbpw+IWdv2UuQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We've seen some occurrences of messages like this in dmesg on some knfsd
servers:

    xdr_buf_to_bvec: bio_vec array overflow

Usually followed by messages like this that indicate a short send (note
that this message is from an older kernel and the amount that it reports
attempting to send is short by 4 bytes):

    rpc-srv/tcp: nfsd: sent 1048155 when sending 1048152 bytes - shutting down socket

svc_tcp_sendmsg() steals a slot in the rq_bvec array for the TCP record
marker. If the send is an unaligned READ call though, then there may not
be enough slots in the rq_bvec array in some cases.

Add a rqstp->rq_bvec_len field and use that to keep track of the length
of rq_bvec. Use that in place of rq_maxpages where it's iterating over
the bvec.

Fixes: e18e157bb5c8 ("SUNRPC: Send RPC message on TCP with a single sock_sendmsg() call")
Tested-by: Brandon Adams <brandona@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c              | 6 +++---
 include/linux/sunrpc/svc.h | 1 +
 net/sunrpc/svc.c           | 4 +++-
 net/sunrpc/svcsock.c       | 4 ++--
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 77f6879c2e063fa79865100bbc2d1e64eb332f42..6c7224570d2dadae21876e0069e0b2e0551af0fa 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1111,7 +1111,7 @@ nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	v = 0;
 	total = dio_end - dio_start;
-	while (total && v < rqstp->rq_maxpages &&
+	while (total && v < rqstp->rq_bvec_len &&
 	       rqstp->rq_next_page < rqstp->rq_page_end) {
 		len = min_t(size_t, total, PAGE_SIZE);
 		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
@@ -1200,7 +1200,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	v = 0;
 	total = *count;
-	while (total && v < rqstp->rq_maxpages &&
+	while (total && v < rqstp->rq_bvec_len &&
 	       rqstp->rq_next_page < rqstp->rq_page_end) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
 		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
@@ -1318,7 +1318,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (stable && !fhp->fh_use_wgather)
 		kiocb.ki_flags |= IOCB_DSYNC;
 
-	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
+	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_bvec_len, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5506d20857c318774cd223272d4b0022cc19ffb8..0ee1f411860e55d5e0131c29766540f673193d5f 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -206,6 +206,7 @@ struct svc_rqst {
 
 	struct folio_batch	rq_fbatch;
 	struct bio_vec		*rq_bvec;
+	u32			rq_bvec_len;
 
 	__be32			rq_xid;		/* transmission id */
 	u32			rq_prog;	/* program number */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 4704dce7284eccc9e2bc64cf22947666facfa86a..a6bdd83fba77b13f973da66a1bac00050ae922fe 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -706,7 +706,9 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv, node))
 		goto out_enomem;
 
-	rqstp->rq_bvec = kcalloc_node(rqstp->rq_maxpages,
+	/* +1 for the TCP record marker */
+	rqstp->rq_bvec_len = rqstp->rq_maxpages + 1;
+	rqstp->rq_bvec = kcalloc_node(rqstp->rq_bvec_len,
 				      sizeof(struct bio_vec),
 				      GFP_KERNEL, node);
 	if (!rqstp->rq_bvec)
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 377fcaaaa061463fc5c85fc09c7a8eab5e06af77..2075ddec250b3fdb36becca4a53f1c0536f8634a 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -740,7 +740,7 @@ static int svc_udp_sendto(struct svc_rqst *rqstp)
 	if (svc_xprt_is_dead(xprt))
 		goto out_notconn;
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, xdr);
+	count = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_bvec_len, xdr);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,
 		      count, rqstp->rq_res.len);
@@ -1244,7 +1244,7 @@ static int svc_tcp_sendmsg(struct svc_sock *svsk, struct svc_rqst *rqstp,
 	memcpy(buf, &marker, sizeof(marker));
 	bvec_set_virt(rqstp->rq_bvec, buf, sizeof(marker));
 
-	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_maxpages - 1,
+	count = xdr_buf_to_bvec(rqstp->rq_bvec + 1, rqstp->rq_bvec_len - 1,
 				&rqstp->rq_res);
 
 	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, rqstp->rq_bvec,

-- 
2.51.0


