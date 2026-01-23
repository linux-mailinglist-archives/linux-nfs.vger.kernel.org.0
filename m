Return-Path: <linux-nfs+bounces-18389-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLnLDe/Dc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18389-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:39 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0F379D88
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E1C33036EA6
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F97A23182D;
	Fri, 23 Jan 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TanQG4uj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEC426ED3A
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194405; cv=none; b=j80pFu17b46HG91BHrzk1RbjTxLmW22BK5ResIhervFY+30/0OWlBmj4qXHPBGo+mwXa/t0UwG8LFZjLsvUC9mGYVQx1LBN8mQbIFxYwqHcq/B/c4nfu8bTnk8V0QOLe3QI7gPiP0r39Ur5muATbU20qBfqQZvAylO1XhrED01g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194405; c=relaxed/simple;
	bh=dnJVb4KS+oZtyiiWCyQoaHBT9CaqhTPkOIKKnjtDfKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ov+exlQb8jcLCkEAjaoE2R+UZVY7zQUq3Bid/iw7LscmYNtdgosGnaFO3b5jfnnxO0AbtAoTVaeLZXS6E9WpWXm2h/tX3/dLaMtjlKa3V1yuDJ+SAdingie7RHaddm8epy895icrGU1B9LpHmb9FWViSp/6RkhyIo0Zq+lTk5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TanQG4uj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C799CC116D0;
	Fri, 23 Jan 2026 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194405;
	bh=dnJVb4KS+oZtyiiWCyQoaHBT9CaqhTPkOIKKnjtDfKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TanQG4ujgIzIFQj1dJzIQYsl7oezh2ypXoqyD826R488Tx+IDTyWGIHxEQHDSir9t
	 cvNiXjTWSRdT0mWUfZWxJ6vmozPTYkWAx8c1nBrV/rYhNR/mCuHfXQsehRLkMfJ/kK
	 SPjqxe5Y4jiQOGO1enGMgIbz7ip34Cy9WRe1NuqUDBo2ig2oneljujPPWaIuDSlqmV
	 31JeXr8BsnqVLj5OV1hjHLy+otIhtiGpnqhPEbUOIea+tNp40ExwmEZ7vb654faUVA
	 SKnksNhyaVCfFupmvTCOpArO4mqkFgctxtHL9UDgSZTb0FfecAVW+t8ypfsJsI7SOS
	 bM2s2wiSDAoVA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 28/42] lockd: Use xdrgen XDR functions for the NLMv4 LOCK_RES procedure
Date: Fri, 23 Jan 2026 13:52:45 -0500
Message-ID: <20260123185259.1215767-29-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18389-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E0F379D88
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Convert the LOCK_RES procedure to use xdrgen functions
nlm4_svc_decode_nlm4_res and nlm4_svc_encode_void.
LOCK_RES is a callback procedure where the client sends
lock results back to the server after an async LOCK
request.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments, making the early
defensive memset unnecessary.

This change also corrects the pc_xdrressize field, which
previously contained a placeholder value.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 60c5082cd447..fce3defd1cb3 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1229,15 +1229,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "TEST_RES",
 	},
-	[NLMPROC_LOCK_RES] = {
-		.pc_func = nlm4svc_proc_null,
-		.pc_decode = nlm4svc_decode_void,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_res),
-		.pc_argzero = sizeof(struct nlm_res),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "LOCK_RES",
+	[NLMPROC4_LOCK_RES] = {
+		.pc_func	= nlm4svc_proc_null,
+		.pc_decode	= nlm4_svc_decode_nlm4_res,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_res),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "LOCK_RES",
 	},
 	[NLMPROC_CANCEL_RES] = {
 		.pc_func = nlm4svc_proc_null,
-- 
2.52.0


