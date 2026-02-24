Return-Path: <linux-nfs+bounces-19175-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCqJNurSnWk0SQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19175-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 17:33:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B7C189D6B
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 17:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25C95302205B
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55B239A7FD;
	Tue, 24 Feb 2026 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts/oGt/j"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E0239E6C;
	Tue, 24 Feb 2026 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950824; cv=none; b=cLaiE5o+hhgWaN06Fzee+4/arSLZnJQ5LvxnJcg/Gz7bCXfyaesTX40WzI/4DYV8TO3pHyYU+YgzdCSGoiYZ59i4hJiXhTLevrBEYez/VySNSdySsdbU/Ble96zsx2Tl9yZpF425jRk+Qa7pJlNwoO9bpZkcQLDsXF4zB9+Y4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950824; c=relaxed/simple;
	bh=vHKIoilwzxpW+uoOuynF4g4jTRM1+6Ulngryfhydq1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hcX+GXLM8apmW1k8hN0MET12JEjLABg3630G9+CTS6/3eBgVzFEQbMY+XeDbA0GXgjuCasa+14cOiY5Bgqgwk1huSjmOi/5o5QN+XG0vWbHpxq57XmpmETYWb2ChMigtLWLq+ftVAbEmgvwpAewPRA8jfQM/p9mI/yk9g8DXCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts/oGt/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76E9C116D0;
	Tue, 24 Feb 2026 16:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771950823;
	bh=vHKIoilwzxpW+uoOuynF4g4jTRM1+6Ulngryfhydq1c=;
	h=From:Date:Subject:To:Cc:From;
	b=ts/oGt/j4WAgU7m6KkwyDgJPwulDpC7XQuIOkQOuUHAzH2MCaq6aZPRlGcQONWjvD
	 W30Klj3p/OzctWu+i9axtvIeU/DMlTtQfa+tFrLpsDNtPQ1Y3q/nmuXEtFXbIC5Gwv
	 IrUodkC/aRDAQwkzkk+AITtUAMmfMrFvQL/Q9RI5tDC8ZgVJ+18//1pofRGcfNuBlu
	 hCPrJnm+jgPGv5dVoN9QBpor6LeaIbhFcLwIJrOh3mWtwzVWx1m94xJ7VnRBHXMB3H
	 xi+iw6+PgUmYhm9MQSjWddI0nCaHb4WSm8uKYpybQSeFWysEYaBo6AKGzy6nYMB4dx
	 0jo5MBKwN8TiA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 24 Feb 2026 11:33:35 -0500
Subject: [PATCH] nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-v4-0-lock-overflow-v1-1-22beeaf5cf6b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBswiaKuEi1KxxoSDQULxLsnL
 d/i/wyRAlOEuckQKHFk7yq6tgF1bu4gZF0NUshBSNlj6lGg9epCnygY6x8cRtWNepo2s2uo4R3
 I8PtPl7WUD+gHK8NkAAAA
X-Change-ID: 20260224-v4-0-lock-overflow-67c17d99afbd
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 security@vger.kernel.org, Nicholas Carlini <npc@anthropic.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2917; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vHKIoilwzxpW+uoOuynF4g4jTRM1+6Ulngryfhydq1c=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpndLmZMkkPWY4pgv/Fsq7IBKKwYVxeNnoheM4/
 u3rmOJ9jfKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaZ3S5gAKCRAADmhBGVaC
 FRooD/9UFFeA+3Djb+O0BylV6nrBLw8DvFDF7BbH1N0kK3wuZ7MlzWUggtqUtj17LLafQl42RhK
 VRYtbXbO6vGOQbaaGjKmTP+uPpzFOXRwj6SFo9eKw1BS/fSNyXHrZBxCZkGvioJ9gkJFts11Ult
 PSxZFjZvFxU9LQVOp4amYIEDP5wzrGJaIkNJ/j1IJTnMHTFNyeaKA5bMwclMKSG6v7Zieqn/gCK
 T7LgO6BaJyKuIFWo4egkt6Xy8cHZu2h1ohMbUUI3Dby4pQ9b6h7ZYyKHdLLIqYoKnSSDid/CMi9
 ORpo0OuLQ2aUfq5OYZH9Qh7OIrLLHk5hP1eG8XreP26v5vQukKfAcmCPWrje3HSkSd4AijrEVHy
 P0oemHJm9xIIBiyIT/ja9U1yT8h4IL4qNSyC/rVokJwXJan7nlbZxlevugOebrjAa8ZPXTfaVsG
 ai7SZ/TxTgu/03RlKLs7bLJbz7PxxX3aJFHv8mTzq2lTQc+zUpY/Cmx5uhmf83NE7XFYkEh2QLf
 otU+MSc+FkYsAuFIjo7W9G6vLfC9WuvG2zopYWkbFh+R8mZIauNdtA37KKjzf9qopasOrVg4hcw
 8ah854EhBO+Gg5sBqIPP5xOI28NYeWdySp6KQfxVxG+JY6faILIzyJpwyYD6bJonzc4H9mjIOkt
 X1bLdzZ3aj6+D1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19175-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anthropic.com:email]
X-Rspamd-Queue-Id: 80B7C189D6B
X-Rspamd-Action: no action

The NFSv4.0 replay cache uses a fixed 112-byte inline buffer
(rp_ibuf[NFSD4_REPLAY_ISIZE]) to store encoded operation responses.
This size was calculated based on OPEN responses and does not account
for LOCK denied responses, which include the conflicting lock owner as
a variable-length field up to 1024 bytes (NFS4_OPAQUE_LIMIT).

When a LOCK operation is denied due to a conflict with an existing lock
that has a large owner, nfsd4_encode_operation() copies the full encoded
response into the undersized replay buffer via read_bytes_from_xdr_buf()
with no bounds check. This results in a slab-out-of-bounds write of up
to 944 bytes past the end of the buffer, corrupting adjacent heap memory.

This can be triggered remotely by an unauthenticated attacker with two
cooperating NFSv4.0 clients: one sets a lock with a large owner string,
then the other requests a conflicting lock to provoke the denial.

We could fix this by increasing NFSD4_REPLAY_ISIZE to allow for a full
opaque, but that would increase the size of every stateowner, when most
lockowners are not that large.

Instead, fix this by checking the encoded response length against
NFSD4_REPLAY_ISIZE before copying into the replay buffer. If the
response is too large, set rp_buflen to 0 to skip caching the replay
payload. The status is still cached, and the client already received the
correct response on the original request.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Tested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
AFAICT, this bug predates the move to git. I suspect it was introduced
when support for LOCK and LOCKT were added, but I didn't bother to go
poking around in the historical tree. This should probably go to all
stable kernels.
---
 fs/nfsd/nfs4xdr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 41dfba5ab8b81aca8b9449a5660b30feb9506060..9d234913100b9b3c5b3f19b307c3d80bcc517b2a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -6281,9 +6281,14 @@ nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4_op *op)
 		int len = xdr->buf->len - (op_status_offset + XDR_UNIT);
 
 		so->so_replay.rp_status = op->status;
-		so->so_replay.rp_buflen = len;
-		read_bytes_from_xdr_buf(xdr->buf, op_status_offset + XDR_UNIT,
+		if (len <= NFSD4_REPLAY_ISIZE) {
+			so->so_replay.rp_buflen = len;
+			read_bytes_from_xdr_buf(xdr->buf,
+						op_status_offset + XDR_UNIT,
 						so->so_replay.rp_buf, len);
+		} else {
+			so->so_replay.rp_buflen = 0;
+		}
 	}
 status:
 	op->status = nfsd4_map_status(op->status,

---
base-commit: 7dff99b354601dd01829e1511711846e04340a69
change-id: 20260224-v4-0-lock-overflow-67c17d99afbd

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


