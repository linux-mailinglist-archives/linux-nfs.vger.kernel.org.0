Return-Path: <linux-nfs+bounces-18518-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI89H2vRd2mFlwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18518-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 111018D2E2
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 21:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F352304E6E0
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7601DDC07;
	Mon, 26 Jan 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1g8S3TK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E802D7397
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459983; cv=none; b=bZ2FFqV5TyiljBnX8HEamc6Z7wrvcCN8t8cQTUM6l26tXuRrT/nlv7zoiqYhpmD1V1r6ZZGWyZxU8bQdPh1RWvWWdp4ZmRfJFTOqZscpYlQXU5JouHQnCZBnhVuUGaXBa+pIWZovCpqnMWlfunH3nQof6b5hlZUI1R6krCm4NBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459983; c=relaxed/simple;
	bh=gFUlx0IwSfj3hIPTZ6awsfM6q5N3bsSHJYkf49n+de8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nay11JwZ6n037mJ+6XUWAM4N5Bc4u4twVfjhFLyJ/yWc8M+UkGv4+hK4yZ77pDB1g1ivcZpAyqFnnG6UkRX+ULnlQYJ8riPLzhy4fJFExtUC7mtw5FfB0PUJhHDY8lhRV43YpAVaxBJUAuhzQl54ShWuegTT68XyURcVkcvswcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1g8S3TK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B5BC19425;
	Mon, 26 Jan 2026 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459983;
	bh=gFUlx0IwSfj3hIPTZ6awsfM6q5N3bsSHJYkf49n+de8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1g8S3TKATjOqlNmxFR1EYBTK/k/bJdPctj/GdkppQMWy7ArEYOU+UmFluzz+TVCO
	 H1Pm4sMLBZS7XLbCxKwIjv2h8ZAwXdXsfo2LI5OMl365BAaPf+4tIazuY+sid8OVUX
	 dCLhe6BSAOcjVcBEuhAfabQiV5CHxJPE/tsg+VqzFmUWE0rWq5wSNjZJxY0zv0V6wx
	 1GBhox2WYJf31VxLAGNqNkp5i1LyVbCSgvrEHYCrnv6B2GAyGT7NldGn2T6LtCc3HO
	 DnqOlcyaaYApPviAcXfAlHjkzzux2uhbqFd6qj8S77+5lauyTJ2yAQ+hyH4poKzHhB
	 TWbzM49FjjuCg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v2 07/14] NFS: Make the various NFS v4.0 operations static again
Date: Mon, 26 Jan 2026 15:39:31 -0500
Message-ID: <20260126203938.450304-8-anna@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126203938.450304-1-anna@kernel.org>
References: <20260126203938.450304-1-anna@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18518-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 111018D2E2
X-Rspamd-Action: no action

From: Anna Schumaker <anna.schumaker@oracle.com>

They don't need to be visible outside of nfs40proc.c anymore now that
the minor version ops have been moved over.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/nfs40.h     |  5 -----
 fs/nfs/nfs40proc.c | 10 +++++-----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/nfs40.h b/fs/nfs/nfs40.h
index 05ba9f1afe7c..272e1ffdb161 100644
--- a/fs/nfs/nfs40.h
+++ b/fs/nfs/nfs40.h
@@ -4,11 +4,6 @@
 
 
 /* nfs40proc.c */
-extern const struct rpc_call_ops nfs40_call_sync_ops;
-extern const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops;
-extern const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops;
-extern const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops;
-extern const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops;
 extern const struct nfs4_minor_version_ops nfs_v4_0_minor_ops;
 
 /* nfs40state.c */
diff --git a/fs/nfs/nfs40proc.c b/fs/nfs/nfs40proc.c
index 36802f9b94b5..5968a3318d14 100644
--- a/fs/nfs/nfs40proc.c
+++ b/fs/nfs/nfs40proc.c
@@ -309,12 +309,12 @@ nfs4_release_lockowner(struct nfs_server *server, struct nfs4_lock_state *lsp)
 	rpc_call_async(server->client, &msg, 0, &nfs4_release_lockowner_ops, data);
 }
 
-const struct rpc_call_ops nfs40_call_sync_ops = {
+static const struct rpc_call_ops nfs40_call_sync_ops = {
 	.rpc_call_prepare = nfs40_call_sync_prepare,
 	.rpc_call_done = nfs40_call_sync_done,
 };
 
-const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops = {
+static const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops = {
 	.owner_flag_bit = NFS_OWNER_RECLAIM_REBOOT,
 	.state_flag_bit	= NFS_STATE_RECLAIM_REBOOT,
 	.recover_open	= nfs4_open_reclaim,
@@ -323,7 +323,7 @@ const struct nfs4_state_recovery_ops nfs40_reboot_recovery_ops = {
 	.detect_trunking = nfs40_discover_server_trunking,
 };
 
-const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops = {
+static const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops = {
 	.owner_flag_bit = NFS_OWNER_RECLAIM_NOGRACE,
 	.state_flag_bit	= NFS_STATE_RECLAIM_NOGRACE,
 	.recover_open	= nfs40_open_expired,
@@ -331,13 +331,13 @@ const struct nfs4_state_recovery_ops nfs40_nograce_recovery_ops = {
 	.establish_clid = nfs4_init_clientid,
 };
 
-const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops = {
+static const struct nfs4_state_maintenance_ops nfs40_state_renewal_ops = {
 	.sched_state_renewal = nfs4_proc_async_renew,
 	.get_state_renewal_cred = nfs4_get_renew_cred,
 	.renew_lease = nfs4_proc_renew,
 };
 
-const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops = {
+static const struct nfs4_mig_recovery_ops nfs40_mig_recovery_ops = {
 	.get_locations = _nfs40_proc_get_locations,
 	.fsid_present = _nfs40_proc_fsid_present,
 };
-- 
2.52.0


