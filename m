Return-Path: <linux-nfs+bounces-19283-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MlxCBxdoGm3igQAu9opvQ
	(envelope-from <linux-nfs+bounces-19283-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:47:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35FC1A7D8D
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63D0F30236A5
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E89285056;
	Thu, 26 Feb 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvflI6Rz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553C154BE2
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117266; cv=none; b=tYgfcod+80GFVTn7c/K2paw0Vs1ItS0wppe106UpsUy1zy2HuYvjdhQ8HmGTB1uUXHoSNYcEYw7XEFrpn0TpQh/iL0gxDaS4RVOqFkjLSYwT5B2CwOdisqPzynKQdBH4OFhxLhJTbV7SMh0bqERc+8SD2Z8EwTobAqWHwftMOHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117266; c=relaxed/simple;
	bh=cBTvvClSqXVHpXDzszZLwTPzHhrSx/vZp9+o2+aUSms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trlmF+Plt0SHv6NpVQejaW9EPYa/fQREaNZuwAj9GMpcxzfqeOqmjJ2I+gyf2RN34vztiATT91Ew3rQwnStyW3f4ZhLCoTmIrXVel83ueO/XegpfRyuw0uniGippdmpZlVDwIkKEhBGXnpmaEH7ccFzgHerxb1FKrU+cDBGVEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvflI6Rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630C0C116C6;
	Thu, 26 Feb 2026 14:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117266;
	bh=cBTvvClSqXVHpXDzszZLwTPzHhrSx/vZp9+o2+aUSms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MvflI6Rzf8kVR7fO/VSRe1VM9nw4H6ECRRA5P3PJU7jCOlITukESfvLJunjPTQe2C
	 Bw1rZUptWI9SH5R2SUEKUMR1D0ynW+vWDdLCNjZ28DyX1oQ2Le9ukt2JemmHOMvueU
	 Xkb8P9HlUGNJH/OCmq0HuGZkap2Blrk44zQb80qSP6ORFaVHV5BmZuDwo4O2C/tX06
	 YX5RHHs5j5+34s52/7qWxWCl5Sy3AoigvAAY69feVkguNgEnwudMU2ZCl4Rv7cBY3Q
	 30jtiBxAiSAX1JWdNttPxrj8baUQIq56f0wSrctLkqlxY0ok/NS6AdnDPkZzduUyhA
	 OrODvtMCpICmg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/6] svcrdma: preserve rq_next_page in svc_rdma_save_io_pages
Date: Thu, 26 Feb 2026 09:47:37 -0500
Message-ID: <20260226144739.193129-5-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226144739.193129-1-cel@kernel.org>
References: <20260226144739.193129-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19283-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: B35FC1A7D8D
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_save_io_pages() transfers response pages to the send
context and sets those slots to NULL. It then resets rq_next_page to
equal rq_respages, hiding the NULL region from
svc_rqst_release_pages().

Now that svc_rqst_release_pages() handles NULL entries, this reset
is no longer necessary. Removing it preserves the invariant that the
range [rq_respages, rq_next_page) accurately describes how many
response pages were consumed, enabling a subsequent optimization in
svc_alloc_arg() that refills only the consumed range.

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


