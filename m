Return-Path: <linux-nfs+bounces-22448-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MolOCnsWKmoyigMAu9opvQ
	(envelope-from <linux-nfs+bounces-22448-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9A466DBA7
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 03:59:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GL5D8KoF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22448-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22448-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EDA3023E1F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 01:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4056F25A2BB;
	Thu, 11 Jun 2026 01:59:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDB2FC0A
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jun 2026 01:59:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781143161; cv=none; b=DaBMvbAXvblLKBo2gb1tvZdtOUDXDh9yOeVKAM1rAJZgFemPg5mxIw4IQXwSv2jBGfIj8/rreub5LC6wXsxxMGrci611v2YXCxIrc3NqqJa6KxFXkCP6AEQUIqJWsHif0Su02JpuyQUxXoaCIyvV/eIBQRGSUeKeCfWJsT5Pif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781143161; c=relaxed/simple;
	bh=0yakOCDfeReQV3LqtJLF6PltwJAXG34wca5KofZrH+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIddQezjaSguZ1t34cLyW35QjRdehC2LPZnnjdsi+2cmxK2shnOolvxI4tBJrJK+cxsRLCdGNgYdEzu+2owXj/qDkeR3AcwmCs7LEd1YtgX2AmofvBCcNazHn7GqimC5i9mCQdmKYdcYqbDxp6u1FZfazL2SJgAV+FAoqO/vJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GL5D8KoF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0D01F00899;
	Thu, 11 Jun 2026 01:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781143159;
	bh=8+ElolE/6fShLyxFlq9fB9Vma9BAOs2gtSWWtyOgsHE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GL5D8KoFjUgaGO09o0Q8e1eALq5MzivuxguG+bl4iV3B+yEvwS6vSBRg98AxAHJZ+
	 Dvf31gtDnvK+jIC+MdQoQuNopTdFdnBTQ5nvhogWy5oUz93L5/S9ZJ47/tzYTn4CJM
	 9lbIyLO2b9WtG3APBfYmL2cjw6bFZH3EXyoDAA/S2Tc6AGonKOaFtpuGidt1fWzY+o
	 xo7adtFX0Xck/8r9qHccJ/G3oubUaprwaMMz76JfBcRnIchNZDwjtE64pkWs1DzxxN
	 DAytVuyW4kGBzSpwujo/DXW8W5ohEM4Hpf08KrLfMBFU1wIZwvqpv9w+2Zc3zBbhO/
	 AUh5gxIZ0o8uw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 10 Jun 2026 21:58:53 -0400
Subject: [PATCH 1/5] SUNRPC: Add svc_serv_maxthreads() to report the thread
 ceiling
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-nfsd-slot-growth-clamp-v1-1-7b966700df0b@kernel.org>
References: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
In-Reply-To: <20260610-nfsd-slot-growth-clamp-v1-0-7b966700df0b@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Benjamin Coddington <bcodding@hammerspace.com>, 
 Jonathan Flynn <jonathan.flynn@hammerspace.com>, linux-nfs@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4100; i=cel@kernel.org;
 h=from:subject:message-id; bh=0yakOCDfeReQV3LqtJLF6PltwJAXG34wca5KofZrH+8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqKhZ1mQGVZHlepJZtJpbtmVSJ/4TKD1iJBjG1g
 6SHJNOaAjSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaioWdQAKCRAzarMzb2Z/
 l2fOD/4gB68xaBtnl7Qz9f/owJY85f3NLnQRpKnRmASCcj9zxc4uhvOVImIWsOjkhybYuBy0CCl
 4yOyuRLsj8z8hIkT4k6n4jYh3ROaoMKgJOgxir1Ww9oYho9NU16L6h5Qa+2BDp8aOl8JtFNScEv
 dEaWWe26VPzwc+LtATl7Lhkh/I5Rd6GSpIk1+iVxyNScUEkHLdGvvqhS/b+AkItaowH5xZm9Vfm
 mpZxPZhZpY3W86fT42wgllf6zPAMpSB548iTKwQPf6SQLydnJywg7z0ZcQxH5UxrdxbaeRMiPUZ
 d8BaziBEvoa9JE37c9TIIypU0NWJyXpQugb/pLavWsutfzkMn4u8O5xv3l2gBC07tmNT8wONZck
 A544gyHQJDCRFuBjMhQRFaoKng+ZfyJIx6LJh2OygPB4U//jZt6I/GBYbhlfBVb/H8tmSHkq+18
 oRW+YdVMjgLtypntAjxZm+MtzIdupNVXO5/VVkqj12vjaeL0YtL0aOTz2d3pQNgiQ2KseMPq8vx
 8RS4dQxaNtVrAyZXC2zH3msmCIrbNQ8vsDzfQiSYjpFFq08i/PI7KvZo2qGTQoBhU9eXj7uCuJC
 DL9QB4u1JJcnDCWfeAwz9NQYp3aDHbWnpSsObqV7TmVzF8587lPdB6JnNJm+I+iPnCOwTkksCf6
 s1Wt3Oc6dPXvDIg==
X-Developer-Key: i=cel@kernel.org; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22448-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:bcodding@hammerspace.com,m:jonathan.flynn@hammerspace.com,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A9A466DBA7

A pooled RPC service sizes its threads dynamically, growing and
shrinking each pool between its minimum and maximum bounds as load
varies.  The count of running threads therefore reflects recent
demand, not the service's capacity.  A consumer that sizes a data
structure against the concurrency the service can sustain -- NFSD's
NFSv4 session slot tables, for one -- needs that stable ceiling, and
computing it means summing sp_nrthrmax across every pool.

Add svc_serv_maxthreads() so the summation, and its dependence
on the layout of struct svc_serv and struct svc_pool, stays within
sunrpc. The read is lock-free: pool maxima change only when a service
is reconfigured, a path callers already serialize against startup and
shutdown, so a racing reader observes at worst a transient value. This
is acceptable for the sizing heuristics that will consume it.

nfsd_nrthreads() already sums sp_nrthrmax across pools by hand; convert
it to svc_serv_maxthreads(), giving the new export an in-tree consumer
and removing a copy of the dependence on svc_serv internals.

Signed-off-by: Chuck Lever <cel@kernel.org>
---
 fs/nfsd/nfssvc.c           | 12 +++++++++---
 include/linux/sunrpc/svc.h |  1 +
 net/sunrpc/svc.c           | 23 +++++++++++++++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 4f1ab3222a4d..9dcd581d8882 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -237,15 +237,21 @@ static void nfsd_net_free(struct percpu_ref *ref)
  */
 #define	NFSD_MAXSERVS		8192
 
+/**
+ * nfsd_nrthreads - report a namespace's configured nfsd thread count
+ * @net: network namespace to query
+ *
+ * Return: the configured thread ceiling, or 0 when no service runs.
+ */
 int nfsd_nrthreads(struct net *net)
 {
-	int i, rv = 0;
+	int rv = 0;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
+	/* nfsd_mutex keeps nn->nfsd_serv valid across the read. */
 	mutex_lock(&nfsd_mutex);
 	if (nn->nfsd_serv)
-		for (i = 0; i < nn->nfsd_serv->sv_nrpools; ++i)
-			rv += nn->nfsd_serv->sv_pools[i].sp_nrthrmax;
+		rv = svc_serv_maxthreads(nn->nfsd_serv);
 	mutex_unlock(&nfsd_mutex);
 	return rv;
 }
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 4be6204f6630..3a0152d926fb 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -469,6 +469,7 @@ int		   svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool,
 					unsigned int min_threads, unsigned int max_threads);
 int		   svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
 				       unsigned int nrservs);
+unsigned int	   svc_serv_maxthreads(const struct svc_serv *serv);
 int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
 void		   svc_process(struct svc_rqst *rqstp);
 void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 576fa42e7abf..84b5e260b39d 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -954,6 +954,29 @@ svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
 }
 EXPORT_SYMBOL_GPL(svc_set_num_threads);
 
+/**
+ * svc_serv_maxthreads - report a service's configured thread ceiling
+ * @serv: RPC service to query
+ *
+ * A pooled service sizes its threads dynamically, so the number of
+ * threads running at any moment tracks recent load rather than the
+ * service's capacity. The per-pool maximum is the stable figure a
+ * consumer should size against.
+ *
+ * The caller must keep @serv valid for the duration of the call.
+ *
+ * Return: the sum of every pool's maximum thread count.
+ */
+unsigned int svc_serv_maxthreads(const struct svc_serv *serv)
+{
+	unsigned int i, max = 0;
+
+	for (i = 0; i < serv->sv_nrpools; i++)
+		max += data_race(serv->sv_pools[i].sp_nrthrmax);
+	return max;
+}
+EXPORT_SYMBOL_GPL(svc_serv_maxthreads);
+
 /**
  * svc_rqst_replace_page - Replace one page in rq_respages[]
  * @rqstp: svc_rqst with pages to replace

-- 
2.54.0


