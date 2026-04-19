Return-Path: <linux-nfs+bounces-20962-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEhBI7Ek5WmXegEAu9opvQ
	(envelope-from <linux-nfs+bounces-20962-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F82442521B
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89450301178B
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D1E2E6CD5;
	Sun, 19 Apr 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwjzyFnY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E22E62AC;
	Sun, 19 Apr 2026 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624804; cv=none; b=aYtTp/mJyx0MufOppW7RXvfNaVmngPoP25D1bqbDindH1+k3CSQVuDS8/qFJK8LWwmrh1fqfwb8NHAsLQmXbh/wqu4VT1s1Tfn8dCDmN4Ui7gHISJ9tEdfx7p5l+MOyhkB8ONiC4I+vQAs93j7a/MuG7/fg2rc2fKIScQCHRuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624804; c=relaxed/simple;
	bh=Uhj/8f6FRa0X48xFSViYJFr18UqOly5fNpXgvimQfyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eGeXdslkSuDvdlwCOtvfxQyvS9fD/JndRecPLWd3hQ8SgHJMin2uqIoEYq1sjYUQzYddsbeFxbPdIdcbX/l+1RF2oeuDZFvThCfGwoEpRiX0gi0DOE0SLsOvOVGnlFItijMIRnV1n6r7Fl04g172/4YsVCd5CRQLTv7vBf4jjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwjzyFnY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558EBC2BCAF;
	Sun, 19 Apr 2026 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776624803;
	bh=Uhj/8f6FRa0X48xFSViYJFr18UqOly5fNpXgvimQfyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kwjzyFnYFZW7zjvipocfRTw3zk6k3BG0kWzgVAHnFuiMTld9YwSjfgECA1P+rLMIS
	 h0L08ZslNqdjhKZ5UNKQOOhvUtW2oFU6LrHHKUjj1dR3MNg9+k+kfoH6+th+7yrZ/v
	 KmrDsdyWSdqQ2QueYEwlNlqt1iIAW1W3LJqzcSoPaKv57EFWj2INJknQ+xsoNd3+tc
	 fqewyF107CxFhMcahi3H0cn2FqbYgk0vrYd4bxuAv7wmP/kbQzmDn4jQidS/kwDDpE
	 U/JypRtm7tA8/uoMXcRF8zOZo+qToeoouRZiJ6rywFJRV0JbvNtQXCYBXTCXs1impr
	 Xn1Zn6/NP7Bug==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 19 Apr 2026 14:53:04 -0400
Subject: [PATCH v9 6/9] NFSD: Replace idr_for_each_entry_ul in
 find_one_sb_stid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-umount-kills-nfsv4-state-v9-6-0660bd06d2b6@oracle.com>
References: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
In-Reply-To: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=gFq6w2SMcg/HDr83bDGzOlzwepA7RPvucQexOAGIZbA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp5SSdsSbqtd+sHic3uk9wwSCmVSnQicAPmPEFD
 x4ddHDILHyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeUknQAKCRAzarMzb2Z/
 l4J3D/97ciPEwDKFo+k8dp3nTQv7Hkc85VWuBgdnrkCV3sypk9N1z1CUxipW9aDq7aPcXhbp7LW
 GMI+G4MYqBfl71Pb6oL5jnwOvP9N5WYcn+E/I5k5JIUhfbpwvsMdYHigI2/sbwdj9iPIqS4viSG
 i30sf3Lw1PV0QMLV8rcXFu4XemFJSX9iXipLgP1K0BC56ZTZOCpiH+wQPX8teyvCVsh6VutbWSS
 jLXdIgtY33g/FC49VVigt+z5S0kGp/T8s6QGoMuSCWPIcQb3upQg5+SbPbZBhP9fM+lmYxFs8U9
 Hxem+c9aI2WYPtQbyodXB0qo6hRjXfS8x8AkEji9Ozr6/02nmc3CExIytRxZQo4OWcOxI7/5Tm3
 eXQsWFPORiMVfisWSw22BmWcbCHjuq7KqblPJdndekdyllC2xXM+/0EHm0dsKVwIASZwyd00KMD
 FXaVYqXYV+Eidjnu0GEvFdWiLe2jaXBc7pOkSXXp4LHSZmLnj6tFmzByxPyc4Wmbv4Um34C3vaa
 P+ojhJnZSubXUw+cGIkTI0xKSCxLhacYrvxGO58YjvBw/x7qj7DuCNiduWDeb8B2eDsgQk0EeDz
 R5C3l1z32NaNSh6NYKz4AYBr5UOY454ZdVC7dX2reQ0LfP+UczV4MmFRStvQLlvWUY+5jtEWhYb
 0CSy5me8Ji2WoxA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20962-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F82442521B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Replace idr_for_each_entry_ul() with a while loop over
idr_get_next_ul() for consistency with find_one_export_stid(),
added in a subsequent commit.

No change in behavior.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b095b1beaac0..1478ff741b79 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1760,17 +1760,19 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
 					  struct super_block *sb,
 					  unsigned int sc_types)
 {
-	unsigned long id, tmp;
+	unsigned long id = 0;
 	struct nfs4_stid *stid;
 
 	spin_lock(&clp->cl_lock);
-	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
+	while ((stid = idr_get_next_ul(&clp->cl_stateids, &id)) != NULL) {
 		if ((stid->sc_type & sc_types) &&
 		    stid->sc_status == 0 &&
 		    stid->sc_file->fi_inode->i_sb == sb) {
 			refcount_inc(&stid->sc_count);
 			break;
 		}
+		id++;
+	}
 	spin_unlock(&clp->cl_lock);
 	return stid;
 }

-- 
2.53.0


