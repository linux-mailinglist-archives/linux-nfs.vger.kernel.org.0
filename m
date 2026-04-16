Return-Path: <linux-nfs+bounces-20875-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HFlLSof4WlbpQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20875-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:40:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AAC41309C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30842302ED57
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B573358D3;
	Thu, 16 Apr 2026 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJZNcGH0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51860335554;
	Thu, 16 Apr 2026 17:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360941; cv=none; b=IaKUopuiUvCJKIXPMoc/RWA0s6/buHBc0ouJQzWzXb62wQAP4u3kQRFob6s2XRWaeMV9kQEZyaTEXdT7FgXHafKMEvImQMw4eBnKnDDNXSmMP2wJ9p7oJC/F2pDzYSlTvailw72jjPT6eS0+GSV3l2Qnof76apf8vhxJZc00Ook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360941; c=relaxed/simple;
	bh=JPuUub7ZoVIR3lKaHdVQ99YpUWe8z2ubqieFVVVxAmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFFEnGsktfv/UwLnFu0dzbp0xXnifezBv4Jyi1nrgnNIHQYf2Z7OwFUSlw82sWFRfI5bPJ1Qdx6Erhhi/bnEE6n0Z5PRcKYk3k0AMn4Pr3zptOEt80X6cFlEgXv4B0LNtHKAOyD/GQkjKzcolc3bw2ZVIG0F5n3WdyRks8xTGA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJZNcGH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C05C2BCB8;
	Thu, 16 Apr 2026 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360940;
	bh=JPuUub7ZoVIR3lKaHdVQ99YpUWe8z2ubqieFVVVxAmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NJZNcGH0kf0c4iQoCjif3NQ4hczSmLnHXeIPBNSCfXKWIcyeUjcFh+4M2Y27ZfTpD
	 mHMCOyXrxmPeJm4ITv3dcP2//zcvx8K/pRJRkVrFHdQFuJXC8l9XBVbyJA40Ubufcg
	 Vu9muF4mgO99joN15HwLmllInhT+1KdxlKb/fNgHI18/EE0nmcEoJb/q5HF0B2G2Mt
	 B+TN9UEBNKjUKw0G7IVaSEVBponlH1gRcdDflFe1SWpnGD4azo2XwFnd66/xOezQab
	 3+2cRHOvvlA2/ZmNEkWfiB6nPX3lRP1PhH5BHrnPcN4360XycG22qxZSSq02teM7bn
	 mwLQ9BT8Puwbg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 16 Apr 2026 10:35:04 -0700
Subject: [PATCH v2 03/28] filelock: add a tracepoint to start of
 break_lease()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-dir-deleg-v2-3-851426a550f6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JPuUub7ZoVIR3lKaHdVQ99YpUWe8z2ubqieFVVVxAmU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBp4R3hhDHtZ2kdmL1V/EJQPbDZuO3kgR4jcEy7J
 i7ej4j/0vGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaeEd4QAKCRAADmhBGVaC
 FUJ6D/0c1hJyv1gKxxIoafujMCgQe0/RImc+hwNc+tdYdG1Y0YIZ6yR/R9fNMyYLeqVoUIRfzCL
 raJtveA+S0f0xCOVCDbTsN84j/k0DTqPZGKQysmLkoaxLA7BN8b7tnDOykku0NnYDiCLfYFEqdQ
 ss2nnluZ2Q+XxUZ7LBlAnx+T6aRnqwK8xMf7GHg2Jr8KG5op+6Lz4vuvlWvyI04gVTGYGOgp6sU
 BCXKRQ/D1l2YsTeB8++DlrsIZVRlyMe7ssMXdxySCEQd18b3m4yJGVM8aWh5/a/ZXHZ52E7IBPQ
 QkXiJrQ0ml/E2Y79EUfbwiT6Yzl3oCyc6xctngYIJYXHNwPfUnlgX4q4Xjo17M88Fn5BkQABT7j
 C2B77M1ZTG5tBvApEK2MMvtd8k1mPV5EvJ++KGLvaD7Ok0YGUyKKHQT1KLkYyY+Bhp/Ixh58W51
 Q2HfnNfDnBUGD9v989ncYyXSYtH0Sr1Ygl2fY14gGzCA4anfKApTd7NA0n4orFysXODNMsGGSUU
 hCyqwSsOFr0zmE4Ssbini4UwW6O12A4UVduR46l9ZSUu48rJLxsfsLuuFH9dqy5dT86xpNhEnRx
 mQjfJKaaaZXrFTeJnksPF2s7BZQw3ck8j7LHYQkz/PWnGEhtTerntZkmjAp7W0mp+lRwL85VJkx
 OyieSAgSPTUnoaA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
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
	TAGGED_FROM(0.00)[bounces-20875-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 14AAC41309C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

...mostly to show the LEASE_BREAK_* flags.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/locks.c                      |  2 ++
 include/trace/events/filelock.h | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/fs/locks.c b/fs/locks.c
index 8b5958f34b61..792c3920b33a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1651,6 +1651,8 @@ int __break_lease(struct inode *inode, unsigned int flags)
 	bool want_write = !(flags & LEASE_BREAK_OPEN_RDONLY);
 	int error = 0;
 
+	trace_break_lease(inode, flags);
+
 	type = break_lease_flags_to_type(flags);
 	if (!type)
 		return -EINVAL;
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index ef4bb0afb86a..fff0ee2d452d 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -120,6 +120,39 @@ DEFINE_EVENT(filelock_lock, flock_lock_inode,
 		TP_PROTO(struct inode *inode, struct file_lock *fl, int ret),
 		TP_ARGS(inode, fl, ret));
 
+#define show_lease_break_flags(val)					\
+	__print_flags(val, "|",						\
+		{ LEASE_BREAK_LEASE,		"LEASE" },		\
+		{ LEASE_BREAK_DELEG,		"DELEG" },		\
+		{ LEASE_BREAK_LAYOUT,		"LAYOUT" },		\
+		{ LEASE_BREAK_NONBLOCK,		"NONBLOCK" },		\
+		{ LEASE_BREAK_OPEN_RDONLY,	"OPEN_RDONLY" },	\
+		{ LEASE_BREAK_DIR_CREATE,	"DIR_CREATE" },		\
+		{ LEASE_BREAK_DIR_DELETE,	"DIR_DELETE" },		\
+		{ LEASE_BREAK_DIR_RENAME,	"DIR_RENAME" })
+
+TRACE_EVENT(break_lease,
+	TP_PROTO(struct inode *inode, unsigned int flags),
+
+	TP_ARGS(inode, flags),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, i_ino)
+		__field(dev_t, s_dev)
+		__field(unsigned int, flags)
+	),
+
+	TP_fast_assign(
+		__entry->s_dev = inode->i_sb->s_dev;
+		__entry->i_ino = inode->i_ino;
+		__entry->flags = flags;
+	),
+
+	TP_printk("dev=0x%x:0x%x ino=0x%lx flags=%s",
+		  MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+		  __entry->i_ino, show_lease_break_flags(__entry->flags))
+);
+
 DECLARE_EVENT_CLASS(filelock_lease,
 	TP_PROTO(struct inode *inode, struct file_lease *fl),
 

-- 
2.53.0


