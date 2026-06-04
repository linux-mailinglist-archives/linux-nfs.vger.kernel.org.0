Return-Path: <linux-nfs+bounces-22287-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S2CYG7SzIWoCLwEAu9opvQ
	(envelope-from <linux-nfs+bounces-22287-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:19:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD8F642457
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Jun 2026 19:19:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="X/PvuDo0";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22287-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22287-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D64EA309202E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jun 2026 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4114963AC;
	Thu,  4 Jun 2026 17:06:50 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279F9495508;
	Thu,  4 Jun 2026 17:06:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592810; cv=none; b=nnWaiStgyl6DZJZ4eyhDY3ZYB846Cg45QhRV7LUf1UiHyhnqeCoySYX1rgg2DrIuQM+mejHgANFH/StbgSz3PzfGKc28H7BL2BupXJ7VrMIedA9t2ueUozeUSLnMGRUkLf3A/6DJLPzB0R3FXee7JmTc9c14jtaw6h+9Y70i64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592810; c=relaxed/simple;
	bh=ftAxrdPriY0WcHxCkg13L6r0TduSmPxi/nn8jjE1+Yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FtNo11zEkE+zute8lAZxmr1o6TeTs772igeBo44QxZSd9L6Uxy/lYowfRbD+HXlfgHJ+JYpMEcD2fDO48fufC25VjSW8S9mJ9bOtH2rvL6ab3jDzmX7Pr2JP0AeoLvwSkg2PpTmmCxjtDWqtON9UlMHH76xSCTId+4Z03FR3gdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/PvuDo0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174FA1F0089C;
	Thu,  4 Jun 2026 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780592808;
	bh=d2huuTK9ZxPA7L0qJjj9z+F/Ga71JVz97xw0njjbtJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=X/PvuDo0l56SrP5VeEUWgNQCPAjiBSuujw/9eZX65Oz9kPDBcY3UpBWir0vT+aK28
	 8p/V7pIaXZk6A7okWU3dtCBCH/E8aivax6NHtIx8w8Y3Gnp3ISnxUOjntoLrA5yOPE
	 whHeJ4H5rf8Z3GfJhNFuJQn1Epk36CXycNc6njH5oLZGt4MofWtlkFV0flIR7DFn4E
	 3qHHn42dT4yXv1eaZzCVheN3jwG5W0qRq3fN92AT6MpPEHFQtG6Oy6UIbUbkHUCNCL
	 VfPr3BX9PxNqch0Noj64d+0SJy+r+8KsjEqVIKM2zyQ22OJmkxMrOthI3sU/SK+pO9
	 pW3kMqnUQZaKg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:06:37 -0400
Subject: [PATCH 5/8] xprtrdma: Fix bcall rep leak and unbounded peek
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-xprtrdma-refcount-v1-5-f74553f461e9@oracle.com>
References: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
In-Reply-To: <20260604-xprtrdma-refcount-v1-0-f74553f461e9@oracle.com>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chris Mason <clm@meta.com>, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3173;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=dVp+xmEAx00FVxlqkOihBWp0qexlTQwTVu44FFbwLUY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbCm9T++UIrzZ2Gwng7k084/l0kfZOfRKQQE5
 WxyI6wvHfuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiGwpgAKCRAzarMzb2Z/
 l1WEEACGQOmdxv84x102CvjGScfEb2o6YAzWFyGqrRmFEu/RMm1tVZPTnP5N0z0piaRwtw0lkDs
 BiCwOLv5dczk0mO1sk5h5HNg5XwGDmv6ygfm+yesoERF68YH1dOYsy+HMO/AEAC8t7O0vC8Elxs
 PjHuoV63vp99cxFlm74UxweHnCJar+Tjh0jAsLMvlArx5tz/vL7sNmAmvTkicwy5GqgIDNMp/7m
 x3MgKD/Feh4ph3NoXgaLlj9eqKNB2zpCc1GXQxMeaEUkySKa0Ed39zQFtc4C19ss/LhWDl5BPmi
 cX0liOWELxJ9t4ds4HxMr+JIs0cjvjo9bcvlIf06plzrAy8M1bAg/ricd2iT7u8QW/Ps5IIUjjH
 SV5ZXmMeVJ5MtFgvPB6EjrfN+YZGHIXRpC2OhmwzNMCkvzIOvApRCV533IfUezZMhYuoCuolRa+
 YsUw06L0R6Vy9YY7J4kTxATOlE1TpQnxUIlNzBSAkuGh+pdS4fRE0s/VNZ4b+bmdWATR6ax4NOo
 RFTFYUEyrUIgxs9czBciDHSQutxLt1zlP+paiJvvb0X15EHxWWuwd1MsnrZR5jM99qd13pLSLE3
 O40o5J4MhYYlP4BEVehUL87eNVda6yZLEP0hVQasCKkjWJb9q31RprJ9uIHwNPhtjDHTmjZY4jm
 nko8TLiUmV41yQw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:clm@meta.com,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22287-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AD8F642457

From: Chris Mason <clm@meta.com>

rpcrdma_is_bcall() decodes a reply's first words to decide whether
the frame is a backchannel call. Two issues in that decode path
let a short or malformed reply leak the receive buffer and drain
the Receive queue.

First, the speculative peek

    p = xdr_inline_decode(xdr, 0);
    /* five p++ reads follow */

asks xdr_inline_decode() for zero bytes, which returns xdr->p
without consulting xdr->end. The five subsequent __be32 reads can
then walk up to 20 bytes past the wire payload into stale regbuf
contents and misclassify the reply as a backchannel call.

Second, after the post-peek

    p = xdr_inline_decode(xdr, 3 * sizeof(*p));
    if (unlikely(!p))
            return true;

the short-header arm returns true without calling
rpcrdma_bc_receive_call(). The contract with the caller is that a
true return transfers ownership of rep to the backchannel path:

    rpcrdma_reply_handler()
      if (rpcrdma_is_bcall(r_xprt, rep))
              return;        /* bare return, skips out_post */
      ...
    out_post:
      rpcrdma_post_recvs(r_xprt, credits + ...);

Because rpcrdma_bc_receive_call() never ran, no one took rep, but
rpcrdma_reply_handler still bare-returns past rpcrdma_rep_put()
and rpcrdma_post_recvs(). The rep, with its persistently
DMA-mapped receive buffer, is orphaned on rb_all_reps and freed
only at transport teardown. This completion reposts nothing, so
its slot is reclaimed only when a later forward-channel reply
reaches out_post and rpcrdma_post_recvs() allocates a fresh rep to
backfill; absent that traffic the Receive queue drains and the
peer's Sends draw RNR NAKs.

Fix by consulting xdr->end after the zero-length peek so the five
__be32 reads cannot run unless 20 bytes of wire payload remain. A
byte-precise comparison against xdr->end is required because a
non-4-aligned receive rounds the stream's word count up past the
true payload. Also return false from the short-header arm so the
reply falls through the normal out_norqst cleanup chain
(rpcrdma_rep_put() plus rpcrdma_post_recvs()).

Fixes: 41c8f70f5a3d ("xprtrdma: Harden backchannel call decoding")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index f115baba6d56..63e64d53e289 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1088,6 +1088,8 @@ rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
 
 	/* Peek at stream contents without advancing. */
 	p = xdr_inline_decode(xdr, 0);
+	if ((char *)xdr->end - (char *)p < 5 * XDR_UNIT)
+		return false;
 
 	/* Chunk lists */
 	if (xdr_item_is_present(p++))
@@ -1112,7 +1114,7 @@ rpcrdma_is_bcall(struct rpcrdma_xprt *r_xprt, struct rpcrdma_rep *rep)
 	 */
 	p = xdr_inline_decode(xdr, 3 * sizeof(*p));
 	if (unlikely(!p))
-		return true;
+		return false;
 
 	rpcrdma_bc_receive_call(r_xprt, rep);
 	return true;

-- 
2.54.0


