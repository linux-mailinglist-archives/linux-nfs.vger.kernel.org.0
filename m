Return-Path: <linux-nfs+bounces-20151-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM9DIP87tGmDjQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20151-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 17:31:59 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3852870E7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 17:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 671F2303B4FB
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D6A39BFEC;
	Fri, 13 Mar 2026 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk0qTJIg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B9D3C278E
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419512; cv=none; b=qk9+McHPe/1FlMu9nzzpmPfB409vxy7UZb1WDNbz4A+936W575NTmy/g+IMJ8ftvLysaOqYKfCKFd1FgCslh0c4XuOTbOl/TpPXzEx0pwHYCPRpY2rMFt3Kqzc26VBcogChbseoee72NIRphfO3P0s8W8A151/fJh31sbB2afC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419512; c=relaxed/simple;
	bh=1ytohX8j/sC0jQKAjlqkuCTSF4myeUyjpHEyXgJB9so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nktE/Qb5OXydTwgq1zlACCwZ9HFJI0RiniuvAkbMi72o9iObeR9posFjRapAjzBJXPEMaZeHkkGuaAa4aC3wmej38oQYDgBgqZynVq3HKIrwDoL4jMq8wIig4rwIAjHyrAwjz6zq2mp/9XJJkiq3XSwYhdOZt99drSBWWrbfxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk0qTJIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E42C2BC86;
	Fri, 13 Mar 2026 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773419511;
	bh=1ytohX8j/sC0jQKAjlqkuCTSF4myeUyjpHEyXgJB9so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gk0qTJIgqOtLYQMorHjfMf/k055/Xl6YafZK9qyoY8ZE+TriuuLhAfQMwB9qC7mgc
	 yeivvVM+PeS5BRZY5ZCyVw5wUdAzmugoXJcciX2HaN6J8NgNPfE10J+x53vG/GprZw
	 +yDSSRDEG/r96ZQIkw8ZrgugmO1HGr8VQyp9xQA4UYJ8dE40UTJTL5IVdLWfHcIR6h
	 LLxWM3e6h6J3TRUbSwWAQwUBElHZBOQ2R8yIKwxNMm27a685BHdi0GGWKO+UJueclj
	 1WxzfisllkHp38vtoS0B0UyluCevx8XeSqFoN+m2QZXhkR13mDfo8gwK5uVVEsKKEy
	 kWrO62t8lu0Qw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 1/2] NFSD: use per-operation statidx for callback procedures
Date: Fri, 13 Mar 2026 12:31:47 -0400
Message-ID: <20260313163148.281676-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313163148.281676-1-cel@kernel.org>
References: <20260313163148.281676-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20151-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: EC3852870E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The callback RPC procedure table uses NFSPROC4_CB_##call for
p_statidx, which maps CB_NULL to index 0 and every
compound-based callback (CB_RECALL, CB_LAYOUT, CB_OFFLOAD,
etc.) to index 1. All compound callback operations therefore
share a single statistics counter, making per-operation
accounting impossible.

Assign p_statidx from the NFSPROC4_CLNT_##proc enum instead,
giving each callback operation its own counter slot. The
counts array is already sized by ARRAY_SIZE(nfs4_cb_procedures),
so no allocation change is needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index aea8bdd2fdc4..74effafdd0dc 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1016,7 +1016,7 @@ static int nfs4_xdr_dec_cb_offload(struct rpc_rqst *rqstp,
 	.p_decode  = nfs4_xdr_dec_##restype,				\
 	.p_arglen  = NFS4_enc_##argtype##_sz,				\
 	.p_replen  = NFS4_dec_##restype##_sz,				\
-	.p_statidx = NFSPROC4_CB_##call,				\
+	.p_statidx = NFSPROC4_CLNT_##proc,				\
 	.p_name    = #proc,						\
 }
 
-- 
2.53.0


