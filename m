Return-Path: <linux-nfs+bounces-20873-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNtcHk8e4WlbpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20873-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:37:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA9412E57
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA99430552AC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F5F331A63;
	Thu, 16 Apr 2026 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWFdwN3Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE643290BD;
	Thu, 16 Apr 2026 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360938; cv=none; b=cesrovXyJPWs4dm6syxROMnE57DXr2q1H6A0w4j8DxzqBN6AjFnhyX/iHo5f6zkdwVVS0aSk1SbuvRQJxYRjCIyD9Sa0VBx2W3XPUQBd2Qu7KtCsr2J6nOdKO0A00n9+8+szWKd1Q2MjUi7AhshK7uBb9SOmFDcpfFCrWSRu1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360938; c=relaxed/simple;
	bh=hy4fR49cODLkMnwvsyfpWAIKbslQm/A1Of95HRTY4zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bb70nbERDXsOlOkIc9LUBiyNPnaHW8OhnBcpP6lzt60prcucM6Gs66FegXTF1kCXKlGUtaxYzXxDP188vO9Jduds8SS0sSbUP3KHYNQ9oDJCN13wyDk5a0Nc0q9yZoPUWfmnBzaOz5G9bYiUaUSlyXg5xUTqHSDTDHqZo+T8syY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWFdwN3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FDCC2BCB4;
	Thu, 16 Apr 2026 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360938;
	bh=hy4fR49cODLkMnwvsyfpWAIKbslQm/A1Of95HRTY4zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lWFdwN3Q/UAcn+C9CPQOTQ7HzyxJ/ZaQziZD8AX5+wVEQeYJyTT0+TlGxY4nILHyC
	 ap9FppbFW7EtK1kaR5He183m+28Ii802rqrmTmRovnFWzr4z7HVtHkkuQuokV4PwnD
	 DeT2LYj7KT9mHQjRpce1WOEwMZX951j9K7jIHHHAPGUEirshQTFs57fAInqjcLtzMp
	 4yT2oz8X4DMY+2v7ZiCf7YqWmJY9oeq6kDOuaiSR8/isDV/ZFQgTerf4Tpw8C4ZWI/
	 UgPkWm/V82V6iDZLk56VOaFmE6TgpOUbC7NsJJAbvLiPT/MfXqb8x3ttX7wNXNpNQq
	 qiHmMqES5B8Yg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:02 -0700
Subject: [PATCH v2 01/28] filelock: pass current blocking lease to
 trace_break_lease_block() rather than "new_fl"
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-1-851426a550f6@kernel.org>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
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
 h=from:subject:message-id; bh=hy4fR49cODLkMnwvsyfpWAIKbslQm/A1Of95HRTY4zw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3hB23T2zAbHeOnnfCrcnRyrngbcnJWhRUKd
 m+66UY+Iu6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd4QAKCRAADmhBGVaC
 FRSoEACIDDlDdkmYmszQjlyr9wdSKQE472tRHa7ievqqfQ91rFc0oYwedW0ggwNyo3J1sHRmP6T
 KahTB2oITsZBiCortO3WRAzQ7Ja48UC82phe480AgKBKm3aQuhIzP4i2OXjFVFf3ryWMX97DVXh
 7UaQALqRKUcya4Tqc1jAg5ox+gvVM8peSp0ANFFBe8OIG/wQ9HLihfkb3+LewzKqOR3hIFw/Z4v
 1MJOM1K0Ie8Vsfn43DwhmxEzbaYIwDOsRiaXdQZoqAwll5L8xaC73lmVRCmvC4ld9pbRRuaeYUo
 e3aj9eB7sqfcqRUir/eh4iqkZGw6WWTVSfAGTR9fAjomlIqSuiBoete71mh5w2yHOvS2izge9We
 Qrspflv5LRyuFu+q2SfC0xgb/E4ldEGR1TN9G2a3bkLjBvG9m4LW4F6+CHbh3GLv51Cj6xkF+gc
 FmrQvGyH9zd2Y/TK5bppBpXw1Z1ENWUQBQEeKR0CF0blMVYz4A3iBHrpB3z+DScp0c4wVTUeOxj
 DElw42o+1eNQAtoIoEsWjO4KOmEBjd6ZeSBCsXeU61fYcOfIH3ZjmdpzNvHTQhfc36ODxs0klFe
 0IGPi1G22jA7bxNrsWuDF1Niw2a4J3BcGd6qPZAE02eVF5cfWHETHoVXA0AmRdyjigQ2Zzp2fE5
 E66rDcWSYfi0RYw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20873-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10DA9412E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
2.53.0


