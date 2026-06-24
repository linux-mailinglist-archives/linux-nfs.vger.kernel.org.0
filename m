Return-Path: <linux-nfs+bounces-22809-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vLKpGFAZPGpbjwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22809-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:52:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC786C07F3
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:52:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lyFEiZFw;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22809-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22809-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8DEC3020D7C
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B2B3DD85C;
	Wed, 24 Jun 2026 17:52:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60427A10F;
	Wed, 24 Jun 2026 17:51:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323520; cv=none; b=iZJlHWLDxS/E0Nd/9wqEvGmVsiWkA6BGdfAHVfe/U/J7AYtBA7pLjdWsON5ETPgz0dhPV7E0FNNK5zW8mnYxPb64UDVCBWjTAFLozHxkXx9jTAHVNGNVwvx422G48VWTFUFJVHZWgJn1EEG98wD61K/Cb1513vkPtMGF6n9JO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323520; c=relaxed/simple;
	bh=dH6A335LnsrzWCTLNWlzFX7Dqa2P6zcptzpiFKXoIs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tj+j20dkLnYjamAYVc6W4/dt1dWp9j5po+zaMUcxLJ8Zu2gzIdg5gLgJIiQk8M6NncOdFxpZaPdElS2eCwSwg8JXpNrxr55I7TJvwXctMlUHu8rt9taCkBFSHQpvfGTAdBA+6xUcLbL03zuGDg+uMdwLnQ2wl5Qpiidh04OC4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyFEiZFw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5151F00A3D;
	Wed, 24 Jun 2026 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323518;
	bh=FW6xzIBvyfgnTYEYvJJoUqnCS44Rn/7RbrPJb6KbiFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lyFEiZFwcXiPxKANtl19U0BVS1ZBwMy8B00ajT8YGgwHqKVjaCk85UgFz1TfPFG32
	 t+C59iU4KjWM0XKvK36kstNn0ctlSNNkioBThiY9UeF0f823EOgpNMy4sgH02SlWUg
	 UGZSknV6vtLcktvmYwoFyGGPOIKjULQTOyHSNsJNlpH5hpkMN7Ilm2dJQQZOV1GRwx
	 nAKDJ0LGWjLt4TwF2eQS1o9igLo48xo/w33v6h5gbczXeqAqc2VyvcMqsLcq3zUn32
	 K7sb0gyrCPZhw38ccrjcSy0d0nHMa/5NgDyj9sPA5kop68GaBT1j50nLxuroZJrN5F
	 4oGMKSUjn2VDg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 24 Jun 2026 13:51:43 -0400
Subject: [PATCH 1/3] nfsd: fix cpntf publish race in nfs4_init_cp_state
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-nfsd-testing-v1-1-b8853eb22e45@kernel.org>
References: <20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org>
In-Reply-To: <20260624-nfsd-testing-v1-0-b8853eb22e45@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5913; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=BRHy1tpEvaK877qr8SFJXITJSHkoQyJmjdzx+K4NMpI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqPBk7laDSvCXPSKK5vJceOJjjypjgLbsJC+7FK
 1PLlh9Yn2OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajwZOwAKCRAADmhBGVaC
 FY7WEACpvKxOx5yV+G1kFdwoCWGTY1HDORQaxzcsKw9TvIEcWxo05+LFk/DmCK4A/SrfN0JatLm
 d3Qy3Ph3imsk9CQS8aDldTZvSw7cpoX2ZxzS7HIOBtcbRK6g+xUZQnAzbQah98pAV58rfKJ7Whg
 /5IvMyRi1vaaIdM2KT5aQtYVfAzjg5RNNFziadYFLY1UYfGrqvrb3UYmzRh3r6UoWHGD7h33ocN
 YqF+RlnqBuINLZNkmnRmXbWh5t3hv0Hk0sfQDvaRvfEyflkVi3V19TK9/CebhQTgkpOFIGgsdWl
 cbpSpts9z0UB2aKtAJwFFFprQhqt/kfZZjEHps8p9mZOWm+t+ZW80uKrceQYiJuj8P/0hQiyPM0
 eQl/zk9SZ/xONbZClgnaShkh058iw0RbTgKuH+2UCPIYt0qnhYPZIEgLX8WW6MirGET/7R3U3vl
 UKgSfqatiTdWBCgr0O1f61MNyrPDogLnCuhvoujZ5DOnOxTinuFGlqqX4NA8h56IhUFeTSgmMG7
 MlT4pxrcPCC6A+Jc29LdTwMhcx1u3TYTM7Pto2L8emGwKCMYZli9A8xDCmkR6ffr6APDvmB/IFm
 KNkgn8VmeP9U/tm6UuNybmyj0RrwhV8LbPBSKGTPVbZVoj8UBJOQUPo8W5yIg9sOefAVsnMvGQS
 5/xb7vTq5M6J3lw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22809-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFC786C07F3

From: Chris Mason <clm@meta.com>

nfs4_alloc_init_cpntf_state() splits IDR publication and cp_list
linkage across two separate s2s_cp_lock critical sections. The first
installs the new nfs4_cpntf_state into nn->s2s_cp_stateids and then
assigns cs_type = NFS4_COPYNOTIFY_STID; the second acquires the lock
again to list_add() the entry onto p_stid->sc_cp_list. Between the
two, the entry is reachable by so_id with the correct cs_type, but
cp_list is still {NULL, NULL} from kzalloc.

A second NFSv4.2 request can race in that gap:

    CPU 0                              CPU 1
    -----                              -----
    nfs4_alloc_init_cpntf_state()
      nfs4_init_cp_state()
        spin_lock(&s2s_cp_lock)
        idr_alloc_cyclic()
        spin_unlock(&s2s_cp_lock)
      cps->cp_stateid.cs_type =
          NFS4_COPYNOTIFY_STID
                                       nfsd4_offload_cancel()
                                         find_async_copy() -> NULL
                                         manage_cpntf_state(clp!=NULL)
                                           spin_lock(&s2s_cp_lock)
                                           idr_find() -> cps
                                           cs_type check passes
                                           _free_cpntf_state_locked()
                                             refcount_dec_and_test
                                             list_del(&cps->cp_list)
      spin_lock(&s2s_cp_lock)             /* {NULL,NULL} -> oops */
      list_add(&cps->cp_list, ...)

The so_id returned to the client by COPY_NOTIFY is echoed back as
cnr_stateid, so any authenticated NFSv4.2 client can drive
OFFLOAD_CANCEL into manage_cpntf_state() against an entry still in
the window. list_del() on a zeroed list_head dereferences NULL and
oopses the server.

Fold cs_type assignment and the list_add() onto p_stid->sc_cp_list
into the same s2s_cp_lock critical section that runs idr_alloc_cyclic.
A concurrent manage_cpntf_state() now either fails idr_find() (entry
not yet visible) or observes a fully linked cp_list. Initialize
cp_list with INIT_LIST_HEAD() after allocation, and switch
_free_cpntf_state_locked() to list_del_init() so that any stale
unlink on an already-unlinked entry is a benign no-op rather than a
NULL dereference. nfs4_init_copy_state() passes NULL for p_stid and
skips the list_add branch, preserving NFS4_COPY_STID semantics.

Fixes: 624322f1adc5 ("NFSD add COPY_NOTIFY operation")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a4398dc861a5..b8946db3ebaa 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -944,7 +944,7 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
  * Create a unique stateid_t to represent each COPY.
  */
 static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
-			      unsigned char cs_type)
+			      unsigned char cs_type, struct nfs4_stid *p_stid)
 {
 	int new_id;
 
@@ -954,19 +954,37 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&nn->s2s_cp_lock);
 	new_id = idr_alloc_cyclic(&nn->s2s_cp_stateids, stid, 0, 0, GFP_NOWAIT);
-	stid->cs_stid.si_opaque.so_id = new_id;
-	stid->cs_stid.si_generation = 1;
+	if (new_id >= 0) {
+		stid->cs_stid.si_opaque.so_id = new_id;
+		stid->cs_stid.si_generation = 1;
+		/*
+		 * Publish cs_type and link onto the parent stid's
+		 * sc_cp_list inside the same critical section that
+		 * installed the entry into nn->s2s_cp_stateids. A
+		 * concurrent manage_cpntf_state() either fails the
+		 * idr_find() (entry not yet visible) or observes a
+		 * fully linked cp_list, so list_del_init() in
+		 * _free_cpntf_state_locked() is always well-defined.
+		 */
+		stid->cs_type = cs_type;
+		if (p_stid) {
+			struct nfs4_cpntf_state *cps =
+				container_of(stid, struct nfs4_cpntf_state,
+					     cp_stateid);
+
+			list_add(&cps->cp_list, &p_stid->sc_cp_list);
+		}
+	}
 	spin_unlock(&nn->s2s_cp_lock);
 	idr_preload_end();
 	if (new_id < 0)
 		return 0;
-	stid->cs_type = cs_type;
 	return 1;
 }
 
 int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy)
 {
-	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID);
+	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID, NULL);
 }
 
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
@@ -977,13 +995,17 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 	cps = kzalloc_obj(struct nfs4_cpntf_state);
 	if (!cps)
 		return NULL;
+	/*
+	 * Initialize cp_list so any stale unlink (e.g. on an
+	 * entry that never reached its parent's sc_cp_list)
+	 * degrades to a benign self-unlink via list_del_init().
+	 */
+	INIT_LIST_HEAD(&cps->cp_list);
 	cps->cpntf_time = ktime_get_boottime_seconds();
 	refcount_set(&cps->cp_stateid.cs_count, 1);
-	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID))
+	if (!nfs4_init_cp_state(nn, &cps->cp_stateid, NFS4_COPYNOTIFY_STID,
+				p_stid))
 		goto out_free;
-	spin_lock(&nn->s2s_cp_lock);
-	list_add(&cps->cp_list, &p_stid->sc_cp_list);
-	spin_unlock(&nn->s2s_cp_lock);
 	return cps;
 out_free:
 	kfree(cps);
@@ -7854,7 +7876,7 @@ _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps)
 	WARN_ON_ONCE(cps->cp_stateid.cs_type != NFS4_COPYNOTIFY_STID);
 	if (!refcount_dec_and_test(&cps->cp_stateid.cs_count))
 		return;
-	list_del(&cps->cp_list);
+	list_del_init(&cps->cp_list);
 	idr_remove(&nn->s2s_cp_stateids,
 		   cps->cp_stateid.cs_stid.si_opaque.so_id);
 	kfree(cps);

-- 
2.54.0


