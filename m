Return-Path: <linux-nfs+bounces-20987-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKwuBjzO52kIBAIAu9opvQ
	(envelope-from <linux-nfs+bounces-20987-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 21:21:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6824643EE89
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E36303DAAB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Apr 2026 19:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD2378D71;
	Tue, 21 Apr 2026 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTftVuXN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FD1377EDF
	for <linux-nfs@vger.kernel.org>; Tue, 21 Apr 2026 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799224; cv=none; b=eVXRcZ7dJ68hAZZqr4hunUsUb1BzYYCrkJgbtTiXIEQBl0GU/UHo039Qla8+RZQOgHpoUUpsICopjFdm49QCefmcAI9TKD9zrJ6Cg+WrUoVx4P9K8W0tZYNG6zfchTRSKocdNvf/lD+yW42jDhxVtJ8lJoh0dKS8CqbKdJnxrU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799224; c=relaxed/simple;
	bh=zgXN9Kk/aNpAte68czcm5kAQvrp6kL4a9UdiudtVmdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AX7bEFVEjKKulQ9L7ygfJYK0IBCaMkhrDMqqWUQLqlBgV+9UuTme5jvG8Z0/NUzcOU3cYd+067VueqzCQRD5itgEwbd1zKAEnpcGnRDMt+e39kE+WGSF+YCDavxBcwtiTYVmwlo+h+Y8kyWQBQjsbLHpwlwa7ghf9dHuQFoJY1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTftVuXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA58C2BCB0;
	Tue, 21 Apr 2026 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776799223;
	bh=zgXN9Kk/aNpAte68czcm5kAQvrp6kL4a9UdiudtVmdI=;
	h=From:To:Cc:Subject:Date:From;
	b=mTftVuXNtIdWDMjiYg5To2wS57C23jtP5wgLdq+e2j190B818L/ZQUoe/tHM/UnFr
	 goa3MNwfN3gBJ6SSesZJyXXHBkpO7KlmJLBaDpANXQshIwl+/Zm4odoX193FuKtggA
	 WUV120qEn1/QpELfvNfsofgkHai5qDeX+IkNqTl7j3ZJwxZVoTlZVvqqAlV1kaZmNz
	 9pQiZr82hQ2Hv4wczHt8V7FVxKDksC8FBOmvcIcuCK9ai4ZcO8XWy/s2S/MbThDxxl
	 xDgcX3kt/nOPRKiTNjhFRw9WDybTLiHiPRP4mScLjtSQ9cuyd/VxJXpmSeSjyy4mOT
	 u0C8s/HbuTObQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	jaeyeong <fin@spl.team>,
	Benjamin Coddington <bcodding@hammerspace.com>
Subject: [PATCH] NFSD: Report whether fh_key was actually updated
Date: Tue, 21 Apr 2026 15:20:21 -0400
Message-ID: <20260421192021.428052-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20987-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,spl.team:email]
X-Rspamd-Queue-Id: 6824643EE89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

The nfsd_ctl_fh_key_set tracepoint was introduced to capture
operator activity on the filehandle signing key. Earlier revisions
logged the key bytes verbatim; the version that landed hashes the
16 key bytes through crc32_le and stores the result.

CRC32 is a linear projection of its input rather than a one-way
function, and truncating any hash of fixed-size secret material
leaves the key recoverable under offline brute force when the
threat model includes an attacker with access to the trace ring.

The operational question the fingerprint was meant to answer is
whether a NFSD_CMD_THREADS_SET call that carries an
NFSD_A_SERVER_FH_KEY attribute actually replaced the active key or
re-installed the value already in place. Answer that question
directly: compare the incoming key bytes against the current
nn->fh_key inside nfsd_nl_fh_key_set() and surface a single bit to
the tracepoint. The event now prints "updated" when the stored
key changed and "unmodified" otherwise. A first set that fails
kmalloc reports "unmodified" because no key was installed.

Reported-by: jaeyeong <fin@spl.team>
Fixes: 62346217fd72 ("NFSD: Add a key for signing filehandles")
Cc: Benjamin Coddington <bcodding@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsctl.c | 18 ++++++++++++++----
 fs/nfsd/trace.h  | 16 +++++++---------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c76849f316f7..064a2e749bc9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1610,16 +1610,27 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 static int nfsd_nl_fh_key_set(const struct nlattr *attr, struct nfsd_net *nn)
 {
 	siphash_key_t *fh_key = nn->fh_key;
+	u64 k0, k1;
+	bool changed;
+
+	k0 = get_unaligned_le64(nla_data(attr));
+	k1 = get_unaligned_le64(nla_data(attr) + 8);
 
 	if (!fh_key) {
 		fh_key = kmalloc(sizeof(siphash_key_t), GFP_KERNEL);
-		if (!fh_key)
+		if (!fh_key) {
+			trace_nfsd_ctl_fh_key_set(false, -ENOMEM);
 			return -ENOMEM;
+		}
 		nn->fh_key = fh_key;
+		changed = true;
+	} else {
+		changed = fh_key->key[0] != k0 || fh_key->key[1] != k1;
 	}
 
-	fh_key->key[0] = get_unaligned_le64(nla_data(attr));
-	fh_key->key[1] = get_unaligned_le64(nla_data(attr) + 8);
+	fh_key->key[0] = k0;
+	fh_key->key[1] = k1;
+	trace_nfsd_ctl_fh_key_set(changed, 0);
 	return 0;
 }
 
@@ -1698,7 +1709,6 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[NFSD_A_SERVER_FH_KEY];
 		if (attr) {
 			ret = nfsd_nl_fh_key_set(attr, nn);
-			trace_nfsd_ctl_fh_key_set((const char *)nn->fh_key, ret);
 			if (ret)
 				goto out_unlock;
 		}
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index a13d18447324..1c5a1e50f946 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -2263,23 +2263,21 @@ TRACE_EVENT(nfsd_end_grace,
 
 TRACE_EVENT(nfsd_ctl_fh_key_set,
 	TP_PROTO(
-		const char *key,
+		bool changed,
 		int result
 	),
-	TP_ARGS(key, result),
+	TP_ARGS(changed, result),
 	TP_STRUCT__entry(
-		__field(u32, key_hash)
+		__field(bool, changed)
 		__field(int, result)
 	),
 	TP_fast_assign(
-		if (key)
-			__entry->key_hash = ~crc32_le(0xFFFFFFFF, key, 16);
-		else
-			__entry->key_hash = 0;
+		__entry->changed = changed;
 		__entry->result = result;
 	),
-	TP_printk("key=0x%08x result=%d",
-		__entry->key_hash, __entry->result
+	TP_printk("key %s, result=%d",
+		__entry->changed ? "updated" : "unmodified",
+		__entry->result
 	)
 );
 
-- 
2.53.0


