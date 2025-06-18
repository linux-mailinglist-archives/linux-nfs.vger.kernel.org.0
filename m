Return-Path: <linux-nfs+bounces-12562-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39866ADEDA8
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 15:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7922E189CFC8
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jun 2025 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2302EA172;
	Wed, 18 Jun 2025 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClOI7Rs3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13F02BEC2F;
	Wed, 18 Jun 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750252778; cv=none; b=SUeJgyvL163g03YZCoyUVDdZlKbq+rDnSzBZG9trFO1gxBdukIHBGFwQV9nTWGCd0fL28on3atFnCl34VQAG1WnWPvR6c3/zEGJNSf9bX0LxwYp+CfVRBQX1NDWFKzwEkNR5luYrc0f3Cann7gkozJ4tnkWEs14N5P+4ON0WnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750252778; c=relaxed/simple;
	bh=zGIuSYzsW7L1kI0d7VvIIUwr4KTHRTjT1NEmYU5gr9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpicCgEDDa1QISgSA+u1lgDIwNwfNvJhSYykDEMQjqqEDHbySG28mWk7tJe45cuaGmlzq0kM+P9Q3PnSY8G72NgONDP2ey3N7IXYFhvFcwBpZz4H67lp9rsdaHVEdyhl7MUyfGx592OH/S01f5PcqvpdGYo54FswtWPO/ifdPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClOI7Rs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95891C4CEF2;
	Wed, 18 Jun 2025 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750252776;
	bh=zGIuSYzsW7L1kI0d7VvIIUwr4KTHRTjT1NEmYU5gr9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ClOI7Rs3v86C3p4OEFVsMh5vAXXblhJF8wkNCuZvLb8oB0oyS6aSOtUPlODEygqpE
	 hpXQeMco8pG4woA/dej7mlqOGeEnTCgIliHoa2xuYjRiwsFVCcz25que6H7R73N2Xm
	 k7W1MwzlkC4rcxqW9nJ0N3TRt+Pm/MKAixb4l397ci+OA1hpaeoeIZB1c368YnfkLQ
	 8/ZQrCulVst7JX7wKkwPb9sBliwRbDnZoufjf+yks7B+C3Xf4mlTO7ha28YgqCdx0H
	 oLno6PArPSRplttgo7NdSmcEpfccIXLB7HmFEXrbZ5Hm2UVrxQxk9dW0fGANnk0SbC
	 HBjwKKl6221fg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Jun 2025 09:19:15 -0400
Subject: [PATCH v2 4/4] nfs: new tracepoint in match_stateid operation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-nfs-tracepoints-v2-4-540c9fb48da2@kernel.org>
References: <20250618-nfs-tracepoints-v2-0-540c9fb48da2@kernel.org>
In-Reply-To: <20250618-nfs-tracepoints-v2-0-540c9fb48da2@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Coddington <bcodding@redhat.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3248; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zGIuSYzsW7L1kI0d7VvIIUwr4KTHRTjT1NEmYU5gr9I=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUrzk9fTt4CRwXi/jdESGg2KIS0UNF8aszEA/c
 cFOPoLVnuCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFK85AAKCRAADmhBGVaC
 FYkyD/46wifNI7p3s+K5D5MMBDFsaLzxWprDwrxESCJtD3wsDX2VLj4ZgM1wtBmk0TbazvypfGQ
 efJizHpcD9OcvcLlsjcO7slKK+nXKPTZ2DVfs/w7P5RE1XdoH/qG+EWHv/OMYgoeEEF0W4XsJGZ
 bQfkcZnSBpfhqN21l2/zycicPdt+N1Ld34IHobFSv18oC5hSOUJUsu92Ks7ap1XcPjtmSaO5CHm
 KDqefpJV44OXzATEEo8HeCymSn50809DC7f90FwWYZtuprCY7dgKNWjG62hmuGfgIXB4N0Wbl6V
 y2VxLebohOWbrwi/oJUvqBbH7ytAC9AriYSAFm03xZ85D1P3IkcOr1sQNPJ78eGiV4ZOwtI6E9Q
 +Jut65wwIwihdOPAG4v7wJRmOb1rsz1+zrPjw/AuFKTirBhPkXGkc4+HITYVNLZkxNj5VU33NFA
 90CMRHTBADfhNpWLq21+wpPMnbAyB/6aFn3ctBPfnSeKjLQ8xFcYUnR6tr7LqvKylHurncSDmTI
 /bCH8jeegi0e2FyJ7iaAfmvrN9n0xWfBpP0OAtqL5Fnu1KyvL/kwOE9gPEtysFzP5F09LKDwIWf
 bFtG6HJCLdB2JDp3J3rRIIzXMSDQPYp6MnmDRP908T5brMyMKig80Qxvbxb5yHUb8/8zK+hHlrg
 H84CQFi2e6IqdMg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add new tracepoints in the NFSv4 match_stateid minorversion op that show
the info in both stateids.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4proc.c  |  4 ++++
 fs/nfs/nfs4trace.h | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 341740fa293d8fb1cfabe0813c7fcadf04df4f62..80126290589aaccd801c8965252523894e37c44a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10680,6 +10680,8 @@ nfs41_free_lock_state(struct nfs_server *server, struct nfs4_lock_state *lsp)
 static bool nfs41_match_stateid(const nfs4_stateid *s1,
 		const nfs4_stateid *s2)
 {
+	trace_nfs41_match_stateid(s1, s2);
+
 	if (s1->type != s2->type)
 		return false;
 
@@ -10697,6 +10699,8 @@ static bool nfs41_match_stateid(const nfs4_stateid *s1,
 static bool nfs4_match_stateid(const nfs4_stateid *s1,
 		const nfs4_stateid *s2)
 {
+	trace_nfs4_match_stateid(s1, s2);
+
 	return nfs4_stateid_match(s1, s2);
 }
 
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 73a6b60a848066546c2ae98b4982b0ab36bb0f73..c1a332da565d31e808d9230089c92c5ec472da81 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1497,6 +1497,63 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_recall);
 DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_layoutrecall_file);
 
+#define show_stateid_type(type) \
+	__print_symbolic(type, \
+		{ NFS4_INVALID_STATEID_TYPE,	"INVALID" }, \
+		{ NFS4_SPECIAL_STATEID_TYPE,	"SPECIAL" }, \
+		{ NFS4_OPEN_STATEID_TYPE,	"OPEN" }, \
+		{ NFS4_LOCK_STATEID_TYPE,	"LOCK" }, \
+		{ NFS4_DELEGATION_STATEID_TYPE,	"DELEGATION" }, \
+		{ NFS4_LAYOUT_STATEID_TYPE,	"LAYOUT" },	\
+		{ NFS4_PNFS_DS_STATEID_TYPE,	"PNFS_DS" }, \
+		{ NFS4_REVOKED_STATEID_TYPE,	"REVOKED" }, \
+		{ NFS4_FREED_STATEID_TYPE,	"FREED" })
+
+DECLARE_EVENT_CLASS(nfs4_match_stateid_event,
+		TP_PROTO(
+			const nfs4_stateid *s1,
+			const nfs4_stateid *s2
+		),
+
+		TP_ARGS(s1, s2),
+
+		TP_STRUCT__entry(
+			__field(int, s1_seq)
+			__field(int, s2_seq)
+			__field(u32, s1_hash)
+			__field(u32, s2_hash)
+			__field(int, s1_type)
+			__field(int, s2_type)
+		),
+
+		TP_fast_assign(
+			__entry->s1_seq = s1->seqid;
+			__entry->s1_hash = nfs_stateid_hash(s1);
+			__entry->s1_type = s1->type;
+			__entry->s2_seq = s2->seqid;
+			__entry->s2_hash = nfs_stateid_hash(s2);
+			__entry->s2_type = s2->type;
+		),
+
+		TP_printk(
+			"s1=%s:%x:%u s2=%s:%x:%u",
+			show_stateid_type(__entry->s1_type),
+			__entry->s1_hash, __entry->s1_seq,
+			show_stateid_type(__entry->s2_type),
+			__entry->s2_hash, __entry->s2_seq
+		)
+);
+
+#define DEFINE_NFS4_MATCH_STATEID_EVENT(name) \
+	DEFINE_EVENT(nfs4_match_stateid_event, name, \
+			TP_PROTO( \
+				const nfs4_stateid *s1, \
+				const nfs4_stateid *s2 \
+			), \
+			TP_ARGS(s1, s2))
+DEFINE_NFS4_MATCH_STATEID_EVENT(nfs41_match_stateid);
+DEFINE_NFS4_MATCH_STATEID_EVENT(nfs4_match_stateid);
+
 DECLARE_EVENT_CLASS(nfs4_idmap_event,
 		TP_PROTO(
 			const char *name,

-- 
2.49.0


