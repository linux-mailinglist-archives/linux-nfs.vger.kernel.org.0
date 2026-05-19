Return-Path: <linux-nfs+bounces-21701-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE9UO7toDGpXggUAu9opvQ
	(envelope-from <linux-nfs+bounces-21701-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 15:42:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9310857FE0C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 15:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC173097F68
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 13:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51A2352009;
	Tue, 19 May 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ1D+lLn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E9340415
	for <linux-nfs@vger.kernel.org>; Tue, 19 May 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197673; cv=none; b=d1YvhbBuJSRfpvYbyW8JEWAp02prGytNTvWaQPN/c6zctHtm8uBzVU2k6oTJMwYDjh1qPMuuyX2sXmRfpvOXYwRaGD67rz69YQCPhr4C7sYG8ZxVSTgGXfOOyaJ0LaviB9Oiw3GMezTnxcqlaCtnkmiMDDdXzolppLXjYft33Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197673; c=relaxed/simple;
	bh=DV5VxTmlGmVa10UlNFavEQ6ro5NVNtBfZt2lIIAsr7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5OYA6JVXbMpSPMjnDFvG4kPhbxroK+VnJW8NcASmAekMEFLqCPd1c1TT542tYySd7XFP7q7HS1likq3yDRa7bUng4DWglSZVsSc28EBpG/LiktaTw4GWQZPqye3RvsKYskX/qZOtSCy6g8gSXApMgYl+yoMpGM9wwiKcHoND6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ1D+lLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E70C2BCB8;
	Tue, 19 May 2026 13:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779197673;
	bh=DV5VxTmlGmVa10UlNFavEQ6ro5NVNtBfZt2lIIAsr7w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BJ1D+lLnQCteipOixZjp4q/t176B2hdxbj2fxWi1YPFz7LlXDOeEwVoRTU1BDNTHK
	 wt9DHsns6L0ktrEY9xrc13zoIkf0FMn5F+Rru9fPVK2dOuy1KR7iP9zd70ycRaiwe0
	 NBuHr3+oQF8Drg0MsHm9Xa59NjjsZZ6XzkZ5FbKyZL+NrUk2Y+HaY+3NSurxny5Qc6
	 VPMYenn3uN5XdCrjAmt7YwzvsLob/zbecPX5TgVYySncC07CjfwiYRcIQiC8XcVD26
	 B9O/lwPkzdGWDHO80RXccUPTJNFFZjQShXYAvMLrf5jeLJgbb7DTEVS8LdN1d0O7Y8
	 3oNQulI+XC/3g==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 19 May 2026 09:34:21 -0400
Subject: [PATCH 1/2] SUNRPC: Bound-check xdr_buf_to_bvec() stores before
 writing
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-xdr-buf-to-bvec-fix-v1-1-1c9decbd4466@oracle.com>
References: <20260519-xdr-buf-to-bvec-fix-v1-0-1c9decbd4466@oracle.com>
In-Reply-To: <20260519-xdr-buf-to-bvec-fix-v1-0-1c9decbd4466@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=P0QfF8JJQefkNVc5/aznqAbXI/VGsuP0Z0oVNpN/ikM=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDGbnFJewpF2sJYnZikcdRSwykp2sqOxQaAkYu
 uNHhgozGs6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagxm5wAKCRAzarMzb2Z/
 lynOD/9WXpTBY1gyb4rjiLdU20k3fzW2mkKsN1W0ywkwItgHz5UPSYCEzxzcpFkoKg0+DThHRiU
 cNI9qQ2DCZR5Ab/SgFYmSiWL9OV3GoN354I67dXPrBGq05LbdbWEBTOdDoSHc2d4+OtcJGyIcZ/
 lDg96EAJB+gmt9RcuK7WvyzaE8ituGiPHcf29Uzu1gvn6sg62EsIke9HSb5moFXoJshIdjnIIAs
 ZZSS2+R1IXJTRaXaweBjgIEAGX2ygG0cRV4oJDpY9vXsXNYs2nXrmvMACWRl2N1z/Iz+1D+vfdY
 m82WO3i1d6sH5zNCQpZdXeGH0gZKuPMEB0ydGb7uauexhgd2IQho7D0JfqEt23xx79Yq4LB3PMA
 P6DzrIbYYb4+AyUF79nejQj5/P8+zUiafdLnmMz+B0p5SLJV9r8OVjwG7/9Lvzsh+HufAx6x4vl
 VafxAs2eaxQSjZgaa8AJ88h8HqoC4Jo488SDUb+iK6RPrpFzFM4yE0QE6sxnLk4pVsSIPGWa80X
 aNCDw7tv13sQbx8ZtNKi2hbqDDXw6gJPt0iQ0WWM7gZyR/FePyWNNJB5OWRZooLK09yHCiDGc/h
 8NbPxw17IpNTfzOGI7Tfix8pYDkYGx2po/yvqf1HGWoiwoTderzYlQ60c2dy1BvEM6m85fmhoq5
 hicM4xNsB5w4gIQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-21701-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 9310857FE0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

xdr_buf_to_bvec() writes a bio_vec into the caller's array before
testing whether that slot is in range, and the head branch performs
the store with no check at all. When the caller's budget is exactly
used up, the next store lands one element past the end of the array.
The overflow label returns count - 1, which masks the surplus store
but cannot undo it.

rq_bvec, the array passed by nfsd_vfs_write(), is allocated to
exactly rq_maxpages entries with no slack. The OOB store can land in
adjacent slab memory; the bv_len and bv_offset fields written there
are derived from client-supplied RPC payload sizes.

Move the in-range check ahead of the store in the head, page-loop,
and tail branches. With the check at the top of each sequence, count
is incremented only after a successful store, so the overflow label
can return count directly.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 2eb2b9358181 ("SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs directly")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 6bd588dfbfc0..8f52782d8a37 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -152,6 +152,8 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 	unsigned int count = 0;
 
 	if (head->iov_len) {
+		if (unlikely(count >= bvec_size))
+			goto bvec_overflow;
 		bvec_set_virt(bvec++, head->iov_base, head->iov_len);
 		++count;
 	}
@@ -165,25 +167,27 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 		while (remaining > 0) {
 			len = min_t(unsigned int, remaining,
 				    PAGE_SIZE - offset);
+			if (unlikely(count >= bvec_size))
+				goto bvec_overflow;
 			bvec_set_page(bvec++, *pages++, len, offset);
 			remaining -= len;
 			offset = 0;
-			if (unlikely(++count > bvec_size))
-				goto bvec_overflow;
+			++count;
 		}
 	}
 
 	if (tail->iov_len) {
-		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
-		if (unlikely(++count > bvec_size))
+		if (unlikely(count >= bvec_size))
 			goto bvec_overflow;
+		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
+		++count;
 	}
 
 	return count;
 
 bvec_overflow:
 	pr_warn_once("%s: bio_vec array overflow\n", __func__);
-	return count - 1;
+	return count;
 }
 EXPORT_SYMBOL_GPL(xdr_buf_to_bvec);
 

-- 
2.54.0


