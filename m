Return-Path: <linux-nfs+bounces-12072-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B31C8ACC5A8
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 13:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C768E3A510F
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jun 2025 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F871230BC0;
	Tue,  3 Jun 2025 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3kSKcAg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB2230996;
	Tue,  3 Jun 2025 11:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950955; cv=none; b=D/YstddC+9kp4sZeyO3katyhwewyRLA/M0mfuDoOrdUWu7a3TEYXWvgHGUxONOwow0Pw9Vq90WYb7VsalmuAe9ciK7RthfVJVXl0ZyNaNha6Vea11hbsaZtcZE63Up9maz7eT4UwEDcO4KtHKf0igKi+3l6n6+rlLfpxLB65P3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950955; c=relaxed/simple;
	bh=c7h8+OhpYcCD6Yk5zHGJK/qie7KtLBAdPzz1KfmEVdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MKGGcVoTU3TxsRYR+H2E2pbjcibDBBSiZSgdV0+lAD3HRS/p7/jZHwuhxDzkIHyTUp1VbVo0lfXaKu6b+nYwn7QIQDWvJ4NLsmWyeB0GJU+krLmYKak8C0KtI6sbHmP8znpxT3O2Jx61UcvAPSK7sydIIn9+3dhafaMKrN/UJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3kSKcAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32584C4CEF7;
	Tue,  3 Jun 2025 11:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950954;
	bh=c7h8+OhpYcCD6Yk5zHGJK/qie7KtLBAdPzz1KfmEVdo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C3kSKcAgJZvQ6f4PNIGiwPxsqOZB8zL5Y8ARssc3kDF+uFgXB2uC7E6SPCnroPa4e
	 fDGi2JXBzTUMMeB0Xenbun/LvWGpdpN+Ov/t3RwFDEKFJAupz8mqAbrTwtZ13UuuB7
	 LqSn4votctAPE8k1XzMmRVV4hk3MeRAGbwmWapfuDtiPgujuTOW8zo4W3co0D8/a9A
	 NUbOMJfSHc5oT0SriG5RecKnXXKljC3K6ujqeoF2xRHv8XLh06Dj9cLvMbF8LjSG03
	 5m0NDYwXE/XqM4wO9i8xDRZAbR606SEv3gScm9dbwziN15LNAPlYEdBSNTjfcN9OOt
	 xOZTLcRG8igHw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 03 Jun 2025 07:42:26 -0400
Subject: [PATCH 4/4] nfs: new tracepoint in match_stateid operation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-nfs-tracepoints-v1-4-d2615f3bbe6c@kernel.org>
References: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
In-Reply-To: <20250603-nfs-tracepoints-v1-0-d2615f3bbe6c@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3148; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=c7h8+OhpYcCD6Yk5zHGJK/qie7KtLBAdPzz1KfmEVdo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPt+n75SWhIaAqoSPoH8ePvJqY5cSE5S6LFj/P
 m+MLEP7lMaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD7fpwAKCRAADmhBGVaC
 FWnpD/9vw6c2W8gv85a1bMuJBlvxVUyNaNqD+7LXNEabNduCdHjLvoyPkKNfaFJ+0K8NGMCVdd1
 DkukeJilk5QMFijlIBTHvy/qjzdK2nrcxeLZuAF/2QvPvM+EqvjWsmKXKgj5Y8/s1jddEZC3Csz
 vs+TUu6KiBQXxnXAoWlUDShTFbygLq3vraCBkBQfkYoTNnmrBuZ28eWg4O1dZU4j+fraEHwxMTY
 Xocot81E3+678BnqciwRm7kQg0Y7eV61TOL8DlMHV5ID2mG511ZCamS2GxBjZwIQYxyqo6o7vCy
 JdWuqdsUf8ItHbFEVrGNW2y9tOEC+gjj6aW+1sV+2BbcpJkPuS+aKW6mDbfCr73MTJ2C8u3VNGg
 gYivm9b1z3ifeySa3twTFx4BwkrawwReC27Fjm22ge8t3mofTV2zfW1CfCK4XwfmswF/tn2hpRt
 Xb+CJL53KZ1rwuZy4oGjN3kNtyBaZ1XK8gPpDR4UKrr2fWw7HzCZMy/zYbRN+YAAKAkzZJFXuzw
 hTYzuZO+Q5Oxx6015aBuHFem5BncQ4Jt4WQsWJmjrKYy2B/gsNystNIDSktOQ8FGL0YZMAmIruB
 ciHiSjqwWkaeE+pF5M2eDE0d60JJqchQwpLuR4rd1T9KE94Y4O69ElehoDljdpfU2KyfyksyHum
 eS+ap3HPBCMK+Ug==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add new tracepoints in the NFSv4 match_stateid minorversion op that show
the info in both stateids.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4proc.c  |  4 ++++
 fs/nfs/nfs4trace.h | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index 73a6b60a848066546c2ae98b4982b0ab36bb0f73..9b56ce9f2f3dcb31a3e21d5740bcf62aca814214 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1497,6 +1497,62 @@ DECLARE_EVENT_CLASS(nfs4_inode_stateid_callback_event,
 DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_recall);
 DEFINE_NFS4_INODE_STATEID_CALLBACK_EVENT(nfs4_cb_layoutrecall_file);
 
+#define show_stateid_type(type) \
+	__print_symbolic(type, \
+		{ NFS4_INVALID_STATEID_TYPE, "INVALID" }, \
+		{ NFS4_SPECIAL_STATEID_TYPE, "SPECIAL" }, \
+		{ NFS4_OPEN_STATEID_TYPE, "OPEN" }, \
+		{ NFS4_LOCK_STATEID_TYPE, "LOCK" }, \
+		{ NFS4_DELEGATION_STATEID_TYPE, "DELEGATION" }, \
+		{ NFS4_LAYOUT_STATEID_TYPE, "LAYOUT" },	\
+		{ NFS4_PNFS_DS_STATEID_TYPE, "PNFS_DS" }, \
+		{ NFS4_REVOKED_STATEID_TYPE, "REVOKED" })
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


