Return-Path: <linux-nfs+bounces-23208-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FeJRDhnxT2p8qwIAu9opvQ
	(envelope-from <linux-nfs+bounces-23208-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:06:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 41254734BBF
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 21:06:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=o0HcLNck;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23208-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23208-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C15E530DBE4A
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 18:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524233C2BA3;
	Thu,  9 Jul 2026 18:47:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE63BF662;
	Thu,  9 Jul 2026 18:47:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622879; cv=none; b=j5VMvhAQx7SJjXOa48hvZbpkJL+4VhVgmlKnpfNAW69CtwHfIhs3o9Bve5eW1IUdEbgvKR8KaGHwsVMgBVvPqrmseYh7paKAEbAO1grPXHKz9tASMxI4I0GTSUjXVzBjDon5rumaUI3dBbaNt8YT++AubtJbSzOMaxKmDtNj2iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622879; c=relaxed/simple;
	bh=aJC6Ec7Dj5E4VaNIxW+INc2ceLEqhndzbAWMlswAAfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9JN2lD4s2QZmPvDDPYi01MtzCz1HrB4/0eT7znSLU2N7vaNl3ZpfbzaBS7tXoXEGP36azTNp0EFoDEzgNchi2Hn69bcBOMtWR+EKDH4FtfXJOizLjWl6F+d0Cx59ytu65HjPdxNYUpOGJ5cbdCqAFl8j1xHIXeMNNBBJSqSFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0HcLNck; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7141F00A3A;
	Thu,  9 Jul 2026 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622877;
	bh=JUZVP7Py3+Q+vBeX6wofnvWtUWSGN73DESgZtDe6FMc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=o0HcLNckCbpvX/Bluuw4EcA6xzXi+IOgyEQqz1wcvBPjq5wUqfWN9s8rxtIyuo4hj
	 sU5mF9tAuQ0wCTagf9wtyQHsWNE8z6bU9JzwDS0zMbCLGdKGV/xqF1Tzdch0mWcx0F
	 6HMbuFwkJT/SZpG9EhqE7UjN22WH9HZH02mKeOXhtmR3UYbxSw45nizkZXNA127FEF
	 8uMT3XJ+3TSAAyOGijwinkhHP5qg8UWTU0kEit4ffV7GEh/wfUJqFhgZurzqWNUbXQ
	 36TCiDfM8NeCvZeo7l13vkaLIHxTs8uThnRZRnNeh1LZMhKQmUoHJ7n9o6BAY1EyZc
	 HD4c86wteQQAg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 14:47:43 -0400
Subject: [PATCH v2 06/10] nfsd: revoke copy-notify stateids before dropping
 their reference
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nfsd-testing-v2-6-0a1ba233bf87@kernel.org>
References: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
In-Reply-To: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7043; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=aJC6Ec7Dj5E4VaNIxW+INc2ceLEqhndzbAWMlswAAfw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT+zV+X0uidK/X91QXeWzTR2WXndvmfSg3GYUV
 N5UUzzA/9qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/s1QAKCRAADmhBGVaC
 FRCGD/sGADWU4FOUNgRO/59+nWeiks0WK8UwGcHVmsZubFpRVlAKhYBcaD5zOu0z5LU5W2oI3Wg
 9YfR6OQSsl3LdxCyFQ2Jh9A5/nenCbPC5uRVG96thqXVKjH9hqjmPySYC1iEVYeIix26Wf0T505
 3FDJNnqNBXt96oECvA/Lj3tgBQufgQtsmQnvfe1GzVAWA4cUCHdQLiwtTsoEq7xyjRprgNnlj41
 XiO4Epy9BmNN2tUQkA1ic+icgw+Z2gs/8GpuznylX26/d/5edhD8trbGKm6vYP1seJaWwglqkxq
 1ryZTREaj/DYdDDcLYlSidx5bzkUwr1riZWrACf3wzA5MmP1sq5Adpd1pXBULpe/XYIMtfvaouj
 g/Epovy+0TwTv/95z2/ae+OiAiIkluYv5Z5DpcuXDoqIqFDDLcpYHUhsxuxXrGi1q4grA658dUs
 S07i3+niIxRi2ZG07BOPWnuHDZCKrWLt/SoTnYJNW5coTXh7OMiH6I2KyXZu0Cpoy/0NaZRT6mL
 8Vl/g/9UxnZoYRVOwtnpXvtHHiIBELHQTJQPcnpNdWxpevdocCU/yvbw9vo6h5EvJ+lZd4rHYd3
 NnO5wZsayMN/3e0xTQBoo5rLgtTmxfwyv7ymbfM9NIW5suFRdD5jhlhOJWdQWmVsjxJHdNFlaQt
 /kj54Q56ysG4u0Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23208-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41254734BBF

Copy-notify stateids live in the s2s_cp_stateids IDR and on their parent
stid's sc_cp_list, pinned by a single membership reference.
_free_cpntf_state_locked() only unlinks an entry once its refcount reaches
zero, so any revoke path that runs while a concurrent
find_cpntf_state()/manage_cpntf_state() holder has elevated cs_count drops
the reference without unlinking, leaving the entry discoverable with its
membership reference already consumed. A second revoke or a laundromat tick
then frees it while the reader still holds the pointer -- a
KASAN-detectable use-after-free at the reader's nfs4_put_cpntf_state().

This affected all three revoke paths:

  - The parent-stid drain (nfs4_free_cpntf_statelist()) repeatedly called
    _free_cpntf_state_locked() on the first list entry; a holder that had
    bumped cs_count made it return early, so the next iteration
    re-decremented and burned the holder's reference.

  - OFFLOAD_CANCEL (manage_cpntf_state()) and laundromat expiry likewise
    used _free_cpntf_state_locked() and could drop 2->1 without unlinking.

Add revoke_cpntf_state_locked(), which unhashes the entry from the IDR and
sc_cp_list first (deferring the final free to any holder), and use it from
all three revoke paths. The drain now walks with list_for_each_entry_safe()
and revokes each entry unconditionally, so it terminates in one pass per
entry regardless of cs_count. The unhash is gated on
!list_empty(&cps->cp_list); the idr_remove() gate matters because
idr_alloc_cyclic() may have recycled the so_id by then. Keep
_free_cpntf_state_locked() for the reference-holder put path only, where a
concurrent revoke may already have unlinked the entry (its list_del_init()
then a no-op).

Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 93 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 76c0e08711df..3f58c729edbf 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1037,18 +1037,81 @@ void nfs4_free_copy_state(struct nfsd4_copy *copy)
 	spin_unlock(&nn->s2s_cp_lock);
 }
 
+/*
+ * Drop the parent stid's reference on a cpntf entry that has already been
+ * removed from sc_cp_list and the s2s_cp_stateids IDR. If a concurrent holder
+ * still owns a reference (acquired viamanage_cpntf_state() before the unlink),
+ * that holder's nfs4_put_cpntf_state() will perform the final free.
+ *
+ * The nn->s2s_cp_lock must be held!
+ */
+static void put_cpntf_state_unlinked_locked(struct nfs4_cpntf_state *cps)
+{
+	WARN_ON_ONCE(cps->cp_stateid.cs_type != NFS4_COPYNOTIFY_STID);
+	WARN_ON_ONCE(!list_empty(&cps->cp_list));
+
+	if (refcount_dec_and_test(&cps->cp_stateid.cs_count))
+		kfree(cps);
+}
+
+/*
+ * Unhash the stateid from the s2s stateid hash, and detach it from the sc_cp_list.
+ * Note that this is gated on a list_empty() check, to avoid problems with IDR
+ * hashval reuse.
+ */
+static void nfsd4_unhash_cpntf_state(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
+{
+	lockdep_assert_held(&nn->s2s_cp_lock);
+
+	if (!list_empty(&cps->cp_list)) {
+		list_del_init(&cps->cp_list);
+		idr_remove(&nn->s2s_cp_stateids, cps->cp_stateid.cs_stid.si_opaque.so_id);
+	}
+}
+
+/*
+ * Revoke a copy-notify stateid. Unlink it from the s2s_cp_stateids IDR and
+ * its parent's sc_cp_list first, so no new finder (OFFLOAD_CANCEL, laundromat,
+ * or find_cpntf_state()) can discover it, then drop the membership reference.
+ *
+ * This must be used by every revoke path (cancel, laundromat expiry, drain)
+ * instead of _free_cpntf_state_locked(): the latter only unlinks once the
+ * refcount reaches zero, so revoking while a concurrent reader holds a
+ * reference would leave the entry discoverable with its membership reference
+ * already consumed, allowing a second revoke to over-decrement and free it
+ * out from under the reader.
+ *
+ * If a concurrent holder still owns a reference (e.g. acquired via
+ * find_cpntf_state()), its nfs4_put_cpntf_state() performs the final free.
+ *
+ * The nn->s2s_cp_lock must be held!
+ */
+static void revoke_cpntf_state_locked(struct nfsd_net *nn,
+				      struct nfs4_cpntf_state *cps)
+{
+	nfsd4_unhash_cpntf_state(nn, cps);
+	put_cpntf_state_unlinked_locked(cps);
+}
+
 static void nfs4_free_cpntf_statelist(struct net *net, struct nfs4_stid *stid)
 {
-	struct nfs4_cpntf_state *cps;
+	struct nfs4_cpntf_state *cps, *tmp;
 	struct nfsd_net *nn;
 
 	nn = net_generic(net, nfsd_net_id);
 	spin_lock(&nn->s2s_cp_lock);
-	while (!list_empty(&stid->sc_cp_list)) {
-		cps = list_first_entry(&stid->sc_cp_list,
-				       struct nfs4_cpntf_state, cp_list);
-		_free_cpntf_state_locked(nn, cps);
-	}
+	/*
+	 * Unlink every entry from sc_cp_list and the IDR before dropping
+	 * the parent's reference.  This makes the drain terminate in one
+	 * pass per entry regardless of cs_count: a concurrent holder that
+	 * obtained the entry via manage_cpntf_state() retains its own
+	 * reference, and its eventual nfs4_put_cpntf_state() will see the
+	 * entry already unlinked (list_del_init() in
+	 * _free_cpntf_state_locked makes that a no-op) and drive the final
+	 * kfree itself.
+	 */
+	list_for_each_entry_safe(cps, tmp, &stid->sc_cp_list, cp_list)
+		revoke_cpntf_state_locked(nn, cps);
 	spin_unlock(&nn->s2s_cp_lock);
 }
 
@@ -7495,7 +7558,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		cps = container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
 		if (cps->cp_stateid.cs_type == NFS4_COPYNOTIFY_STID &&
 				state_expired(&lt, cps->cpntf_time))
-			_free_cpntf_state_locked(nn, cps);
+			revoke_cpntf_state_locked(nn, cps);
 	}
 	spin_unlock(&nn->s2s_cp_lock);
 	nfsd4_async_copy_reaper(nn);
@@ -7882,16 +7945,14 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfs4_stid *s,
 out:
 	return status;
 }
-static void
-_free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
+
+static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 {
 	WARN_ON_ONCE(cps->cp_stateid.cs_type != NFS4_COPYNOTIFY_STID);
-	if (!refcount_dec_and_test(&cps->cp_stateid.cs_count))
-		return;
-	list_del_init(&cps->cp_list);
-	idr_remove(&nn->s2s_cp_stateids,
-		   cps->cp_stateid.cs_stid.si_opaque.so_id);
-	kfree(cps);
+	if (refcount_dec_and_test(&cps->cp_stateid.cs_count)) {
+		nfsd4_unhash_cpntf_state(nn, cps);
+		kfree(cps);
+	}
 }
 /*
  * A READ from an inter server to server COPY will have a
@@ -7930,7 +7991,7 @@ __be32 manage_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 			state = NULL;
 			goto unlock;
 		} else {
-			_free_cpntf_state_locked(nn, state);
+			revoke_cpntf_state_locked(nn, state);
 		}
 	}
 unlock:

-- 
2.55.0


