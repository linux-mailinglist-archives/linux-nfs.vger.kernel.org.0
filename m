Return-Path: <linux-nfs+bounces-18322-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAx/JPhycmlpkwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18322-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 19:56:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC026CC5A
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 19:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00D853005EBE
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB493389E05;
	Thu, 22 Jan 2026 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF5K+XyN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211537AA9E;
	Thu, 22 Jan 2026 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108213; cv=none; b=GR7GBAY7UgVTr8zap/GAQCI9bjGoCPbitRJCyDPVpIcSfHUkUGdjRyjS/aO45zchgu7iG0KKgILdew+HrmjBYNLmlaN2GBYJJtAgoNDV/laexV/2a5Ks8qEHojyo3WeawTbnug1hXJtXdeI6Ue9nzMJ9/Jrx3ZXSts55+ScrKBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108213; c=relaxed/simple;
	bh=ZEQAs6/qtq0mr4Pp/8oWNfVoIYbPVy4RXXg2bml3N48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q2Yk9KoLBkuTB5Ns3G0OzmClmFRRHwbTse9cSn5IgxqeJFB2McqKlo7cZHH70WSe3KZny+Y38hW8TdNbO88ftp1PGrNi9+r+al4H3jSB4qsM3d/U4/YfdO8H+LvQ0U7uRv89gsAoDU2W3WfEJZTVkRjaOPir8OrcydGsyBwW7jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF5K+XyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E50C116C6;
	Thu, 22 Jan 2026 18:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769108212;
	bh=ZEQAs6/qtq0mr4Pp/8oWNfVoIYbPVy4RXXg2bml3N48=;
	h=From:Date:Subject:To:Cc:From;
	b=jF5K+XyNKT4ELutmV00D587xz46wf2Su1IJrpTvKJ4XbzqBJ7r/Bo98CgtGKbNWVk
	 clG0xufP67hcVOhTWAHf521jq8Xt9VvMFz59PU2te1tQwdBUS17unqETGMhk+jgbJk
	 Jxna51Su+e5SzfABtBDQ706lwtsB2PecUh/s1erDeYFIejEK0UellyO41SlrZgHzCa
	 UfjYZhuJ59kytRyWNOkn6t+WUFPTPSoQbbG02PhdHz9gFrzZnvTTkPAuZrUF0CPkVn
	 t9+Cm+42wg/sR495sCP9D19R65HN80xvki3bCChXM9Kn8Rij2EKn89IR/xSUwYDfPV
	 S8rAmapdOBKJg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 22 Jan 2026 13:56:42 -0500
Subject: [PATCH] nfsd: remove min_threads file from nfsdfs
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-minthreads-v1-1-e6d967a90ddb@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyMj3dzMvJKMotTElGJdIwMDixSLRAszMwtTJaCGgqLUtMwKsGHRsbW
 1ALa0l5xcAAAA
X-Change-ID: 20260122-minthreads-2008d8a86685
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4169; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ZEQAs6/qtq0mr4Pp/8oWNfVoIYbPVy4RXXg2bml3N48=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpcnLuKvBo40jPJpWylsDOkEJ4oURpoGMZLfJL8
 5sUnoA5e2aJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaXJy7gAKCRAADmhBGVaC
 FblIEACBRR4ALu35VmEaAgFQHnj4zNUCr2dIlGw31KK7msxw6PfTRwrZFVlceuvs3laPTYKv4wm
 jRcH0J1RkFjTlx+Vge/dPZ6L8REv2iYvR8czbX1A/Ev8l2bqiON79gvLOWbSnYJI46lPx6Dupjq
 zsC5fconhbpGSoIR8DNsTZVneMTrNjP0WvdOCk4c98zIxIiUctIV9mZlqQNXjNgTyPv0YO+KrFg
 kQjPEFXThtwNV6bqvuBlmvnGQFon71lOLZQVijNXo+RGmX85ziK0K62g+/Ab6xmp2EefeSZq6Ij
 FXfVSgYL7r2VaiF9DNoWS9kXXzWWCH1WRJ5VtO4XGwgvKOAleeBxgxpDEyXi8HqOIYNU+tkQVYK
 jaQoGw9vKFsj+kiCjgd7C1I9+veiLDYGHFMjhJmnmBLUtgyqqmjYDUlGldm6JySqzB8LtRxDX4m
 +Izb4SeuKHKoc5H9mb2IPgJaDwke5vicUwRNyzX7Z7IXwdhtwnAgwnA0lmiZCKgbFe2zvL/Ndmg
 b/SymDOcUeW6Sof9bV2IoIXchlcWWVsXE/ime2EPGdmWiUAfiSxa1X//LR+/WHHCgoTsRtjUXr5
 mPLbM60uPKwKjPoBiNXt39tq6+xCA538Iezf1q4khPQqdNnYMqDRXEGCNjkcn6p3OfWZvsddyvO
 O3n+4YvwzCmN2pQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18322-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CC026CC5A
X-Rspamd-Action: no action

It was handy while I was developing the dynamic threading patches, but
we don't have any plans to make this setting available via legacy
rpc.nfsd. Remove the min_threads file from nfsdfs since only netlink
interfaces were intended to get support for this.

Fixes: d086653f3250 ("nfsd: add controls to set the minimum number of threads per pool")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
As we discussed in another thread, this file should never have been
added to the procfs interfaces. This patch just removes it, and leaves
netlink as the sole way to set min-threads.
---
 fs/nfsd/nfsctl.c | 44 --------------------------------------------
 1 file changed, 44 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 30caefb2522f59ca3e0e069e5cd70abe45308c20..7587c64bf26d9108f4202e723b35457077d00de2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -48,7 +48,6 @@ enum {
 	NFSD_Versions,
 	NFSD_Ports,
 	NFSD_MaxBlkSize,
-	NFSD_MinThreads,
 	NFSD_Filecache,
 	NFSD_Leasetime,
 	NFSD_Gracetime,
@@ -68,7 +67,6 @@ static ssize_t write_pool_threads(struct file *file, char *buf, size_t size);
 static ssize_t write_versions(struct file *file, char *buf, size_t size);
 static ssize_t write_ports(struct file *file, char *buf, size_t size);
 static ssize_t write_maxblksize(struct file *file, char *buf, size_t size);
-static ssize_t write_minthreads(struct file *file, char *buf, size_t size);
 #ifdef CONFIG_NFSD_V4
 static ssize_t write_leasetime(struct file *file, char *buf, size_t size);
 static ssize_t write_gracetime(struct file *file, char *buf, size_t size);
@@ -87,7 +85,6 @@ static ssize_t (*const write_op[])(struct file *, char *, size_t) = {
 	[NFSD_Versions] = write_versions,
 	[NFSD_Ports] = write_ports,
 	[NFSD_MaxBlkSize] = write_maxblksize,
-	[NFSD_MinThreads] = write_minthreads,
 #ifdef CONFIG_NFSD_V4
 	[NFSD_Leasetime] = write_leasetime,
 	[NFSD_Gracetime] = write_gracetime,
@@ -910,46 +907,6 @@ static ssize_t write_maxblksize(struct file *file, char *buf, size_t size)
 							nfsd_max_blksize);
 }
 
-/*
- * write_minthreads - Set or report the current min number of threads per pool
- *
- * Input:
- *			buf:		ignored
- *			size:		zero
- * OR
- *
- * Input:
- *			buf:		C string containing an unsigned
- *					integer value representing the new
- *					min number of threads per pool
- *			size:		non-zero length of C string in @buf
- * Output:
- *	On success:	passed-in buffer filled with '\n'-terminated C string
- *			containing numeric value of min_threads setting
- *			for this net namespace;
- *			return code is the size in bytes of the string
- *	On error:	return code is zero or a negative errno value
- */
-static ssize_t write_minthreads(struct file *file, char *buf, size_t size)
-{
-	char *mesg = buf;
-	struct nfsd_net *nn = net_generic(netns(file), nfsd_net_id);
-	unsigned int minthreads = nn->min_threads;
-
-	if (size > 0) {
-		int rv = get_uint(&mesg, &minthreads);
-
-		if (rv)
-			return rv;
-		trace_nfsd_ctl_minthreads(netns(file), minthreads);
-		mutex_lock(&nfsd_mutex);
-		nn->min_threads = minthreads;
-		mutex_unlock(&nfsd_mutex);
-	}
-
-	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%u\n", minthreads);
-}
-
 #ifdef CONFIG_NFSD_V4
 static ssize_t __nfsd4_write_time(struct file *file, char *buf, size_t size,
 				  time64_t *time, struct nfsd_net *nn)
@@ -1342,7 +1299,6 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
 		[NFSD_Versions] = {"versions", &transaction_ops, S_IWUSR|S_IRUSR},
 		[NFSD_Ports] = {"portlist", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_MaxBlkSize] = {"max_block_size", &transaction_ops, S_IWUSR|S_IRUGO},
-		[NFSD_MinThreads] = {"min_threads", &transaction_ops, S_IWUSR|S_IRUGO},
 		[NFSD_Filecache] = {"filecache", &nfsd_file_cache_stats_fops, S_IRUGO},
 #ifdef CONFIG_NFSD_V4
 		[NFSD_Leasetime] = {"nfsv4leasetime", &transaction_ops, S_IWUSR|S_IRUSR},

---
base-commit: d561c36ceba65324973356b738511b90b6e58b22
change-id: 20260122-minthreads-2008d8a86685

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


