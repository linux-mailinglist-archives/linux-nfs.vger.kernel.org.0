Return-Path: <linux-nfs+bounces-21213-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHqkEepd8GnDSQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21213-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:12:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B514B47E86E
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 09:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB2003051D10
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2026 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDE8399013;
	Tue, 28 Apr 2026 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+K1tX1K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88AE22A4E9;
	Tue, 28 Apr 2026 07:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360223; cv=none; b=OJvLAvD95NmuadSal2SwLPgLuT9/ewRWaj39AVIPdo9zH5W4nvo743G0JVAJcNf4nOEc5CDh3ksOvKEa1PfLkXnf8UfUfhveqWxcthpwrOTAKv6Xc3meORq6o+1nfUsVsFwPteJKlU5av5mrn3iyUjrKtM3DgLxNTK0c1JUfGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360223; c=relaxed/simple;
	bh=SSAdEWM+ofXOJU1zf9WFQv+WMKZekPpJCkvMvEn6hf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSSQQC+6Ezp8vhKAtiIW6dOaBO92FLzgjWRbxSTZ2fhdLpWVnxoapFLAaO9osM1KR0IIfpj+WGxICs/fyxJ1HvtEtMG6Gu0VW7b2ypOUSGmJ8e618/rPouVEXvl8JfTT5YwZA43j3JXAo/hY18OKIJm3lOMI8DIDZ4sXxFE4QTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+K1tX1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFB7C2BCAF;
	Tue, 28 Apr 2026 07:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360223;
	bh=SSAdEWM+ofXOJU1zf9WFQv+WMKZekPpJCkvMvEn6hf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H+K1tX1KrM6PpZWjqHAGoSBuJpMajHH7U65z1gi+pkK5a2aGJIyWTuRfWDC5bBB0i
	 LkYvjTRG0pWNPW43ZiGJs0iZtyKGlN9dHplPBL2WZYNhhsojgG/iVJO6+A/JHy5Vyz
	 O5Wib/TB0emC1NvDqsh5rplppOyvcWx/hi5Uk4HdOIC+50fk7DH9EfWC1G8ywLVngt
	 gtYuv+x/6A3ze1YAKZH+SnH4ZutqKKGzQruUdW9XoVrxm8bFGJgCLoAB76rgAfH/95
	 xcXWVnQ++UA1RYkWYkL7MQZrMwNu6QaFAuiaP1XhoPPo7OyaBieh8yxBeCPekO34/O
	 e+IqjP0epH4Lw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 28 Apr 2026 08:09:45 +0100
Subject: [PATCH v3 01/28] filelock: pass current blocking lease to
 trace_break_lease_block() rather than "new_fl"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-dir-deleg-v3-1-5a0780ba9def@kernel.org>
References: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
In-Reply-To: <20260428-dir-deleg-v3-0-5a0780ba9def@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SSAdEWM+ofXOJU1zf9WFQv+WMKZekPpJCkvMvEn6hf0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp8F1MMl3pxBzY0cOV4TMIfAHAgj72nno40qM2+
 xd/NyEzwuWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCafBdTAAKCRAADmhBGVaC
 Fdr+EACXrGFa/aD+nrNW0vYZ04n+m5eXgR+iObb1IXpwnjxtC3iejDkdQwgYVEKJ7YoRMWe2x1V
 5yLx86tiD8Jww15Zfj2ZeKKevZPkQ2ts4NNaUxE61B6UbfQCSE8W0YwOSVVjRxcp9wtnPQSyk1W
 1ZPYGhmOx8zIV9mbs/LnuPZmcdSL5Hvnrr1wh6zUJhmdTCebHpnRWVQwRrKpj1GsQk4h+xMnBvP
 8/OQsbBl32CZ+N3nEyy8Xq5D51bYktMEa0QByzFZJBmFdmIAQsAxYGANYu2kD5ysS3yVsQqaM1E
 39YhnZVgGkIGDSQmT8OA0HBIr4Lp9/Rq3RNBuAdHM0ug4xTy7M5gpAInBYTaVrypkuZDSB3NiV8
 sZy02fvD0XT6MQQhHIeK65PFWxvIGUnjsQgF+qrcfUxhFSzmW1h4KhdYMwVVzIZ0Uy5J8/mR5V7
 2b6Hpg4OvCyCGLCvp7mgZy8PIIOdT0Z107Ao3YDg14Wm7A69dgtRk2GuHAgKp9tQJy2XKHkBIUr
 6sJkIfgqBdi5ak+9gcM4vCiemKn4v0jwwT113kY/NhTRAYpwHspsdlgHCadMnBrMQMezgUe7y95
 kudXxeEqiCYASQ4EA05aUu88QFt9WFnoaNV8xs1MwdHtF/ovDvo7O222i4Z3lDtEV1Y5YzMJ7bq
 yuERRHBaWrYwPVQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: B514B47E86E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21213-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The break_lease_block tracepoint currently just shows the type of
"new_fl", which we can predict from the "flags" value. Switch it to
display info about "fl" instead, as that's the file_lease on which the
code is blocking.

For trace_break_lease_unblock(), pass it a NULL pointer. "fl" may have
been freed by that point, and passing it the info in new_fl is
deceptive.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 8e44b1f6c15a..d82c5be7aa5b 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1691,7 +1691,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	} else
 		break_time++;
 	locks_insert_block(&fl->c, &new_fl->c, leases_conflict);
-	trace_break_lease_block(inode, new_fl);
+	trace_break_lease_block(inode, fl);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 
@@ -1702,7 +1702,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
 
 	percpu_down_read(&file_rwsem);
 	spin_lock(&ctx->flc_lock);
-	trace_break_lease_unblock(inode, new_fl);
+	trace_break_lease_unblock(inode, NULL);
 	__locks_delete_block(&new_fl->c);
 	if (error >= 0) {
 		/*

-- 
2.54.0


