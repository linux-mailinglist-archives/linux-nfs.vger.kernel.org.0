Return-Path: <linux-nfs+bounces-21972-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJGHIvWuFWpkXwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21972-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:32:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 056655D79B9
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 16:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9AD430A57E0
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 14:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1043FFAA0;
	Tue, 26 May 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/wTJ9Vu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB92400DE5;
	Tue, 26 May 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805373; cv=none; b=HnYUVHoOwYYqAFgfSFDxnjkDF8D117XPfoYNRid9iXKHP3UKMO8hX226bJKrjZBlYKC9z8Q2x9iUL+SCDWxuCOllicBupru8UJukojqHYCUpOeAheXnMqktVCLq8qiBWRP5fSg1SM0+Hz4j/VwDgmel92ITkLbl859D4Be+7zjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805373; c=relaxed/simple;
	bh=kGUmIZWrDXMr7CnhQIijQxZyxmBTgyKxodRxeOsPPso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z5BnLD0cPTh//KddDpX4QNbTIqJeWUCEi5A8Ys5Xgmjl0UbVcGMRXW0Ov0YVuw2ga0cYUbV7VK6x69gIuDopf8q7IHhRc/v0Tf7WSIWncyUfp8v5B6njt4m816tzwr63hQW9VuCAjGpZvxGewu2WDYecosNQguTDB/2Uu/Y4VXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/wTJ9Vu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916D51F000E9;
	Tue, 26 May 2026 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805372;
	bh=FnEFiueMfDYasE+fIcAIJK6apLT79VJZel7Aq2p8J24=;
	h=From:Date:Subject:To:Cc;
	b=S/wTJ9Vul1PiOslZoeyihwvsDEjj8SAPM6aqFH6b3DR6RCQ1LvEjfQCVUHYh6K7PM
	 u+Dss0ZYbx6rN7YEt934uHJkQorSjcdY06cBzZ9g2PGPPSVqXMKHkGpp7XWpcJio7P
	 BlqyDm/9uUNLmXBxTBzU/LlouzFM0T6tYO0RglaeTzNsRdbpZv3IrtNk1XYuyri9mW
	 i3g2on2fEsd4lIM7OpNdPHYaBQ2dUt21zheUsQHOdnNcnP3tprwaU9keqiFXgLQG1R
	 2gbaNUmjzFmQ44W+y/L+0UHK5YvQ6T061bONssOfCtGl/fkjpjpScmFpoRV8pqjaFd
	 3aGdCJ1FRNQRQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 26 May 2026 10:22:41 -0400
Subject: [PATCH] nfsd: don't free session slots that are still in use
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-v1-1-504a6a7fd9b4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQrCMBBA0auUWRtIYi3Vq4gMMZnYwTKxGStC6
 d0NLt/m/w2UKpPCpdug0oeVizS4QwdxCvIgw6kZvPWDPfnBSNbUo9KykkRCnSrLE9eQsQjOJSR
 KqHN5G3ce++OdrBtDhJZ7Vcr8/a+ut33/AcbSVoB6AAAA
X-Change-ID: 20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-19843be018ac
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=kGUmIZWrDXMr7CnhQIijQxZyxmBTgyKxodRxeOsPPso=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFay31qbVX33tpKIaJq81so+v0ZyggGL0fZl+F
 DLMKDrXaLyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahWstwAKCRAADmhBGVaC
 FajdD/kBOyQCnB9oDwy6RVzwBw4W0EyoSgGFh7mtVihetIpzop8TKRc7Mcu8BjZEKNCTvikm9+g
 uke8SiedcY4jnvgnfN8fxc/wyniRfTFr8Ykkv2RRLPcQfT0LOQOC7yMn32G6jbJSJ8vR0LFaiwe
 gEXosbAA6mgrYqFyxhJc6qcahAPYLmiH1Q0aqO7hYPiFxL2utU55NRGrnsljc2vPu6hZIame4Bc
 wgm4XJ/AcCoSjbBXWjKwXVq4RtXasaguULKBgi5Z91Mt82eTVi5M+BeLESoDE/GixJhxdCvikU6
 sHC2X7tFpSmbA6yWrXr/CQYK3OyDSd4Ho8ZJ+lIBv5MBLD5D03a9PnhM9z8ti2U8Y1jYCB+gsfk
 Mc7nWDFS6OuCqoPC3k8u6/fsHS8lP+HnoYGhxz5OejqXCCzbFyBuqJIzOiapKBbglDvAVYRWIJ1
 XpWAaT0VKOmZh5EDSMp2JwGD8pvpWenFLerrRQ956ag58ZMebD2EOukZ/6BL3dCi0W8DeuhnEsR
 G04JB8ZbBtnJfpWrwk1ajEmhlRdw2mpUKKuwtBqa6oqKfflgHMG4CUy0MV18RZ/Bm8TFX7M8Lfb
 DZ5Nieq0WoWvyNd4hAaKJdtmbdJcITSUNLDO9PwaP0UPt5B1cPqn84YT29p5V861lf+rQpT6Tvr
 crLe61A6VwXmP1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21972-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 056655D79B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_sequence() can free the very slot it is currently processing.
When the session shrinker has reduced se_target_maxslots below
se_fchannel.maxreqs, the shrink path checks three conditions before
calling free_session_slots():

  1. se_target_maxslots < maxreqs  (shrink was advertised)
  2. slot->sl_generation == se_slot_gen  (slot is up-to-date)
  3. seq->maxslots <= se_target_maxslots  (client acknowledges)

However, seq->slotid is never checked against se_target_maxslots.
A client using a slot in the range [se_target_maxslots, maxreqs) can
satisfy all three conditions: its slot has the current generation
(set by a prior SEQUENCE), and it sends sa_highest_slotid <=
se_target_maxslots to acknowledge the reduction.

free_session_slots() then kfrees every slot at index >=
se_target_maxslots, including the caller's own slot. The function
continues to write sl_seqid, sl_flags, sl_generation, and stores the
dangling pointer in cstate->slot. Later, nfsd4_store_cache_entry()
copies up to maxresp_cached bytes of the compound reply into the freed
sl_data[] array, corrupting whatever slab object now occupies that
address.

This is a remotely triggerable heap use-after-free from any
authenticated NFSv4.1+ client with an established session, requiring
only that the kernel memory shrinker has run against nfsd session slots
(a normal occurrence under memory pressure).

Fix this by adding a check that the current request's slotid is below
the shrink boundary before allowing the slot reduction to proceed.

Fixes: 8fb77d12c76e ("nfsd: add support for freeing unused session-DRC slots")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5cbf626ab9b..f90ad8281a95 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -4848,7 +4848,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
 	    slot->sl_generation == session->se_slot_gen &&
-	    seq->maxslots <= session->se_target_maxslots)
+	    seq->maxslots <= session->se_target_maxslots &&
+	    seq->slotid < session->se_target_maxslots)
 		/* Client acknowledged our reduce maxreqs */
 		free_session_slots(session, session->se_target_maxslots);
 

---
base-commit: 97bac3c7a039675d7ae71fbdf3a7c39e840339b6
change-id: 20260526-nfsd4_sequence_shrink_uaf_on_loaded_slot-19843be018ac

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


