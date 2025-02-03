Return-Path: <linux-nfs+bounces-9864-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47FDA25DB0
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 16:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA1616B358
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Feb 2025 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47CD207A05;
	Mon,  3 Feb 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g75EGXNI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801751F37B8
	for <linux-nfs@vger.kernel.org>; Mon,  3 Feb 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594186; cv=none; b=qkk+f+7ZJnZ/MMlUgr4OrASlqJrBuHkHQ18FypwavIJntZlbFO2BM52Fkr9vVqjYBGKZE2W8mRZNtm+xVYNef+u7WQVGqEjrem2OgwxuvfRF/Zt2u9Xe7PSsOU4wyQbGinxWBMO6oov2C6v0v2UkJRgQjCLSyTlFZjtqwW3yeNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594186; c=relaxed/simple;
	bh=WepdfxE40+Da9OYNVWb2JxOZldzUUjZRl9VtR45AzHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZP076niIunZMKVtoO5iHQ+Jtj4A+z9BnFWlniVFf4v6polIziFNXdVNiDaNXqzVOioBZDU+rVY5cqi9861LUPxwrRnwlLBJ/wVjMXeA6xJBMWO3jPUrlVWfoEdP7mty1HWcIdhhDlU3ZG/3+EKBk1CFre+ue+IeceL5k+m8EW0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g75EGXNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB7C4CED2;
	Mon,  3 Feb 2025 14:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738594185;
	bh=WepdfxE40+Da9OYNVWb2JxOZldzUUjZRl9VtR45AzHo=;
	h=From:To:Cc:Subject:Date:From;
	b=g75EGXNILK7MmD5TNF2DYZW8wJWBkLncN51WnSOSWH8EoeCf5q0xfM2LsBtyDlo4M
	 mMbbTyi8DtP1Ao0OAfrTth+kEq0LFNYtFOZakj74a9Vf0cOCS63NWfP/7VokNf1zvI
	 z1+SVjV1rPWEwcTr46QS3ZixuQx6ojLmRg5gSfh936woHU/oFqcnEwtkwWBakHwO8j
	 orrTrTfaPimB0jZUrWLWAwb2qMsWm8hyT98JX3zR2xtXgPg0S5F78crs8NPxydi/uU
	 9Jrxw7gJ5ThJaQ1tNwZzr321Sn3ebmDrSkWTJNkIDije1Lzmdbvuf2dunN3A2/9jPv
	 dK41ydn0b+34A==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Fix trace_nfsd_slot_seqid_sequence
Date: Mon,  3 Feb 2025 09:49:42 -0500
Message-ID: <20250203144942.68547-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

While running down the problem triggered by disconnect injection,
I noticed the "in use" string was actually never hooked up in this
trace point, so it always showed the traced slot as not in use. But
what might be more useful is showing all the slot status flags.

Also, this trace point can record and report the slot's index
number, which among other things is useful for troubleshooting slot
table expansion and contraction.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/trace.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index ad2c0c432d08..49bbd26ffcdb 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -803,6 +803,14 @@ DEFINE_EVENT(nfsd_cs_slot_class, nfsd_##name, \
 DEFINE_CS_SLOT_EVENT(slot_seqid_conf);
 DEFINE_CS_SLOT_EVENT(slot_seqid_unconf);
 
+#define show_nfs_slot_flags(val)					\
+	__print_flags(val, "|",						\
+		{ NFSD4_SLOT_INUSE,		"INUSE" },		\
+		{ NFSD4_SLOT_CACHETHIS,		"CACHETHIS" },		\
+		{ NFSD4_SLOT_INITIALIZED,	"INITIALIZED" },	\
+		{ NFSD4_SLOT_CACHED,		"CACHED" },		\
+		{ NFSD4_SLOT_REUSED,		"REUSED" })
+
 TRACE_EVENT(nfsd_slot_seqid_sequence,
 	TP_PROTO(
 		const struct nfs4_client *clp,
@@ -813,10 +821,11 @@ TRACE_EVENT(nfsd_slot_seqid_sequence,
 	TP_STRUCT__entry(
 		__field(u32, seqid)
 		__field(u32, slot_seqid)
+		__field(u32, slot_index)
+		__field(unsigned long, slot_flags)
 		__field(u32, cl_boot)
 		__field(u32, cl_id)
 		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
-		__field(bool, in_use)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
@@ -825,11 +834,13 @@ TRACE_EVENT(nfsd_slot_seqid_sequence,
 				  clp->cl_cb_conn.cb_addrlen);
 		__entry->seqid = seq->seqid;
 		__entry->slot_seqid = slot->sl_seqid;
+		__entry->slot_index = seq->slotid;
+		__entry->slot_flags = slot->sl_flags;
 	),
-	TP_printk("addr=%pISpc client %08x:%08x seqid=%u slot_seqid=%u (%sin use)",
+	TP_printk("addr=%pISpc client %08x:%08x idx=%u seqid=%u slot_seqid=%u flags=%s",
 		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
-		__entry->seqid, __entry->slot_seqid,
-		__entry->in_use ? "" : "not "
+		__entry->slot_index, __entry->seqid, __entry->slot_seqid,
+		show_nfs_slot_flags(__entry->slot_flags)
 	)
 );
 
-- 
2.47.0


