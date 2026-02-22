Return-Path: <linux-nfs+bounces-19094-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK1MF8Qsm2llugMAu9opvQ
	(envelope-from <linux-nfs+bounces-19094-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A473316F9CF
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BF5C300C36C
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A4D13D891;
	Sun, 22 Feb 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpAqjIvs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADB3D3B3
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777210; cv=none; b=a+L+x3ip062IKJNyeSCAHY2j9U3cgEpnUIlU72Y5iGSVc+8IpP3t9aXOduo1wcR7Q2mBLGi9t1B3ugy4Fbb8s11NSOL3a4E5a+BE1I5fZtV6DGnsdEa6+V+e7IB7u2nh5TWtl5i9vSWVXGDzqFoivG7d9zJTRSe6kSXkIYDxZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777210; c=relaxed/simple;
	bh=4drtyQqJi6epl5UJ7/kbc4iy6grWlDqd+DG4WPbY8VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYqYQXheqs9KnpuVtBm9swwqQcefSfmYBY8qcUKNn15uZ/z7aG7145ooyTSuzPxyyKTQxezZpbYibjHAkTEe81g4zOyBm34nyyjx5J1B/SGQ8Sa3sI3p7kjbPnCApHDRnsKC84DtSVeRRl+xgd+eenumq78kBIZZqTW16S0eobg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpAqjIvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EACC19425;
	Sun, 22 Feb 2026 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771777209;
	bh=4drtyQqJi6epl5UJ7/kbc4iy6grWlDqd+DG4WPbY8VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpAqjIvszT44fa+li/Mph/k5AaoiBch1Ams7fBHu/UAin0aqunYBwqxnJWfDMXKWP
	 iV8qY7piE1+/HxHVYdUvgM4PDjw0epN8Qv5uFBLZ4TTpCmBVBEFma327bZ3RdawPV5
	 0sYgNCU51KB2iQ/um3I996cHrhXjVi5YRwd65pgSkr6/FkZSrDo6FRtSaqr4gfnIgp
	 TmdB3fxRhMHY/urvGQVANY0vpF0mStWtUYXQA8EyQSqGsxSWkNn4TaOzx6SmFItosx
	 6c6BHFYx1yNxRpz5EDUG9uz9GauB9ZiZLzVHHLxozJzKE31WQAVQ5HsKZ0fGOU8n6P
	 PtrRwGIrNpxRw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/6] svcrdma: preserve rq_next_page in svc_rdma_save_io_pages
Date: Sun, 22 Feb 2026 11:20:00 -0500
Message-ID: <20260222162002.10613-5-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222162002.10613-1-cel@kernel.org>
References: <20260222162002.10613-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19094-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A473316F9CF
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_save_io_pages() transfers response pages to the send
context and sets those slots to NULL. It then resets rq_next_page
to equal rq_respages, hiding the NULL region from
svc_rqst_release_pages().

Now that svc_rqst_release_pages() handles NULL entries, this
reset is no longer necessary. Removing it preserves the
invariant that the range [rq_respages, rq_next_page) accurately
describes how many response pages were consumed, enabling a
subsequent optimization in svc_alloc_arg() that refills only
the consumed range.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 914cd263c2f1..17c8429da9d5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -858,7 +858,8 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 
 /* The svc_rqst and all resources it owns are released as soon as
  * svc_rdma_sendto returns. Transfer pages under I/O to the ctxt
- * so they are released by the Send completion handler.
+ * so they are released only after Send completion, and not by
+ * svc_rqst_release_pages().
  */
 static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
 				   struct svc_rdma_send_ctxt *ctxt)
@@ -870,9 +871,6 @@ static void svc_rdma_save_io_pages(struct svc_rqst *rqstp,
 		ctxt->sc_pages[i] = rqstp->rq_respages[i];
 		rqstp->rq_respages[i] = NULL;
 	}
-
-	/* Prevent svc_xprt_release from releasing pages in rq_pages */
-	rqstp->rq_next_page = rqstp->rq_respages;
 }
 
 /* Prepare the portion of the RPC Reply that will be transmitted
-- 
2.53.0


