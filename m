Return-Path: <linux-nfs+bounces-23235-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hdU4OTz7UGrn9QIAu9opvQ
	(envelope-from <linux-nfs+bounces-23235-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:01:32 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C8673B8BC
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:01:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dWjnQhWk;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23235-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23235-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E85253053444
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 14:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6D331E826;
	Fri, 10 Jul 2026 14:00:27 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EB32E1C4E;
	Fri, 10 Jul 2026 14:00:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692027; cv=none; b=BVVhKOdIECztIJvhUFsSR2IN1l+FXrUCAAxloLlxLgBye4aBpn7bGZqPUDd0ryWuHR8l+rtpO0Hgil36RJzQuYIf/+O7N+5kDBPgu8rUpBJRHJ8qXh6Wx9BFXdSI7CwXW0G0GS/ReOKY+o9MmHjva/pChbuMvvpeCFz0aYPTED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692027; c=relaxed/simple;
	bh=FUD4yD/riJOMTlsN+JqjCYZX5iaCr4b55fbjtTn9SsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oelK4nnbPYy8s6GqETqWAV7l6v7+vKOVnNvxdDmc8ONpGwIns107gU5iURQbIfHt8WhorqKZYXBSD6D5odE8VccqoXa8zKxg8wjenMl7cKv8KMof7SMMXHdKrpojkrFSU0oWANLfTrifI0mC+F4ZtfcE/MzDhrW1CNQMY0vZPu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWjnQhWk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2544D1F000E9;
	Fri, 10 Jul 2026 14:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692025;
	bh=WeG1IBJzOmxlZcls8uuoMy/8/EacdTPLb6j2W8/i8IQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dWjnQhWkf4XjdB0eyK9iRdBqn+RdcPyzsOxk7fdSwwprgKFxL6wk2FzBbid0VM62w
	 acL6HFn+2RE00vgnxTUqF6UNoCU1V6gsgFNdKrqLy5ph7z8EwwoogeWa0NstV/NR7v
	 5R5LwhDFnoRxF7Og9IhHgjfdVPEcfetJLV60lcAGk9PfD8W5uLM1O02A0ptAS2QDEP
	 2f04sTlpAl2ElktvZBVVNJ1c76uG6iHXah5OC1jTtcI8pEi0yc8Uz/9mJx20JluN3b
	 kdHXR3LQ0PzHvsarnLR/6etvHReZmezPPdLP5Iia6JcfODS6oEeJHtb3uZI9SWAdJv
	 3mIjKcNQDTz4A==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Jul 2026 10:00:08 -0400
Subject: [PATCH v3 04/10] nfsd: initialize copy-notify stateid before
 publishing it
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-nfsd-testing-v3-4-a0ff7db6aa3e@kernel.org>
References: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
In-Reply-To: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4050; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FUD4yD/riJOMTlsN+JqjCYZX5iaCr4b55fbjtTn9SsU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqUPrzvH7hSzRWM1xA52Z0IMrxwZh+JIJNEOyK9
 4Sa4iRo5laJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCalD68wAKCRAADmhBGVaC
 FU4rD/4tHv1oxL4xHp5uh8p5g/si0p6BCyTqF9gmk+O8+LWe9pAUhl7TK3/AjMmkMkaX8bkjEJt
 5THQhh7cbZBNDaeTsW5gSgtOiDZykXwUN4zYbuY8x223WycwqJH6buP3gEXiI7Xu9q9qP7pIxK1
 bAtkG2VNH7CHKcPOkUkQMCEuKhc4ME6cnoFGDxvW/oIV/x4mEIeMHvaTa3Mu+6V/tMxwlqaPKq/
 15ldJB/dj1Mr1Ki1SUJ+OeILf+fZFZNKDf3jQBnY2oGEeXMv3WAJ2XLN+7Eg04VVJqwiPIrcLPZ
 Vgj3bsja88FUHkVUi8AWByWxsr1b6QU5MB1HqlxIciC2+UuvZSCfvfa/4AmLmhzxvBddPVen2YX
 mQpjnwbbPxpWjd5wHLXfaU238pdiAVj0lSgD3m1rXHUEhHRQ6Qpnx9t4htgFqjV9gdj7pRqbuvx
 N5Km0uswhZCquH5EbN+t141mb36OGhXf2mAjGeLYJzf6rU11UZsWZ43LHSb5JpZumNJ3UetbeTq
 00KjFD7bByPMfV+a2cFQmH/0iOsr8hJy8h4iEQWxPmMrJ9cKf+IEY3M0/adcRquxUKUOQjQtcCC
 +pOOkOaFcV24jWIbwXiyHsvKmgdQZVsAr+/1aNfZkImqeNgEWxygf7b2vewDE+RMRtffAl7uQ2S
 XDcKgGuAsfNNSoQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23235-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56C8673B8BC

nfsd4_copy_notify() finished initializing the cpntf state after
nfs4_alloc_init_cpntf_state() had already linked it into the
s2s_cp_stateids IDR and the parent's sc_cp_list, with cs_count == 1 (the
membership reference) and none held for the caller. A racing
OFFLOAD_CANCEL (crafted cl_id == nn->s2s_cp_cl_id plus the guessable
so_id) could reach manage_cpntf_state() and free the entry, turning the
caller's subsequent cpn_cnr_stateid read and cp_p_stateid/cp_p_clid
writes into use-after-free. The owning clientid was also only recorded
after publication, so it could not gate an ownership check in that window.

Record cp_p_stateid and cp_p_clid inside nfs4_alloc_init_cpntf_state()
before nfs4_init_cp_state() publishes the entry, and return it with an
extra reference. The caller reads the stateid under that reference and
drops it with nfs4_put_cpntf_state(); on a late error the laundromat
reaps the entry.

Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 16 +++++++++-------
 fs/nfsd/nfs4state.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b9049a3d7c07..506cd4910fb7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2373,7 +2373,6 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfs4_stid *stid = NULL;
 	struct nfs4_cpntf_state *cps;
-	struct nfs4_client *clp = cstate->clp;
 
 	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
 					&cn->cpn_src_stateid, RD_STATE, NULL,
@@ -2387,12 +2386,14 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	cn->cpn_lease_time.tv_nsec = 0;
 
 	status = nfserrno(-ENOMEM);
+	/*
+	 * The returned cps is published and fully initialized, and carries an
+	 * extra reference for us; drop it once we are done with it.
+	 */
 	cps = nfs4_alloc_init_cpntf_state(nn, stid);
 	if (!cps)
 		goto out;
 	memcpy(&cn->cpn_cnr_stateid, &cps->cp_stateid.cs_stid, sizeof(stateid_t));
-	memcpy(&cps->cp_p_stateid, &stid->sc_stateid, sizeof(stateid_t));
-	memcpy(&cps->cp_p_clid, &clp->cl_clientid, sizeof(clientid_t));
 
 	/* For now, only return one server address in cpn_src, the
 	 * address used by the client to connect to this server.
@@ -2401,10 +2402,11 @@ nfsd4_copy_notify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	status = nfsd4_set_netaddr((struct sockaddr *)&rqstp->rq_daddr,
 				 &cn->cpn_src->u.nl4_addr);
 	WARN_ON_ONCE(status);
-	if (status) {
-		nfs4_put_cpntf_state(nn, cps);
-		goto out;
-	}
+	/*
+	 * Drop our extra reference. The membership reference keeps the entry
+	 * alive for a later inter-server READ, or until the laundromat reaps it.
+	 */
+	nfs4_put_cpntf_state(nn, cps);
 out:
 	nfs4_put_stid(stid);
 	return status;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3f83c5107e28..9ae0f18121ef 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -995,7 +995,15 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 	/* So a stale list_del_init() before linking is a no-op. */
 	INIT_LIST_HEAD(&cps->cp_list);
 	cps->cpntf_time = ktime_get_boottime_seconds();
-	refcount_set(&cps->cp_stateid.cs_count, 1);
+	/*
+	 * Fully initialize the entry before nfs4_init_cp_state() publishes it,
+	 * since a concurrent OFFLOAD_CANCEL could then free it. Take an extra
+	 * reference for the caller (dropped with nfs4_put_cpntf_state()).
+	 */
+	memcpy(&cps->cp_p_stateid, &p_stid->sc_stateid, sizeof(stateid_t));
+	memcpy(&cps->cp_p_clid, &p_stid->sc_client->cl_clientid,
+	       sizeof(clientid_t));
+	refcount_set(&cps->cp_stateid.cs_count, 2);
 	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID,
 				p_stid))
 		goto out_free;

-- 
2.55.0


