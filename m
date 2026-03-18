Return-Path: <linux-nfs+bounces-20248-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPYnOPOzumlWawIAu9opvQ
	(envelope-from <linux-nfs+bounces-20248-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:17:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6272BCE59
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 15:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16A42301A17A
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Mar 2026 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A790E3DBD57;
	Wed, 18 Mar 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCGDIJV6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2369A3DBD4B;
	Wed, 18 Mar 2026 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843329; cv=none; b=jLVbPZA/G2RINfeJPK4apKOuyqrpG/8XEUpFuni/LX9nO3kSeIasemmymoOhNfOWw5oqkru9/FDViKs5oSmiBLUAEScGW7j3TNLHUryOSJLRVN5CODCmdJ/Kty0ya4J4O5uvGwrSHNTiIVFKj2DA9ZxbfoOLkw8C8gSFUqv/WVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843329; c=relaxed/simple;
	bh=JA6v4oF7mEEQmo7HtqYq0yNFQC0ELJtYS7uwxQ0sWas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=buT91qUfkwO2oBW0lXVYJ0+s1uLflFtkDUe8vzInPbYq5Tiep4tVHnboyr8mJ5W3AZnimhB0yjdiYypL56Mbbc1AEf2p4NeDgfXivdZiS0b3r5JfnawBHkMhngfjh5QVIKtI6HnaNzB4Pxoh7pK3vyYTn9Ln8YnjMS60gzV9Xzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCGDIJV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D753C2BC87;
	Wed, 18 Mar 2026 14:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843328;
	bh=JA6v4oF7mEEQmo7HtqYq0yNFQC0ELJtYS7uwxQ0sWas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SCGDIJV6WSYm5zoVOm46adxzDWNJ+vKr0XyZ7WAZ9x4briTHlS+pK+cEdbwo2kHvy
	 GYifJrfzIE9xBs0ytvuZSimT0Ml2mHEkb6hq5Er+OdZE9jwtE5Tr7Qs9ebq1swS0Sd
	 3Zgv4cFevwKHCKtzd6+l5VLefsM7490QxzIVJpFSsASeE2r99/rHZqBw6aSoMwl3bV
	 HsY0Yrn0ELSKEHqEWzDCs3n7WgS0RKvhL86hAc6tAfbfGSnyg/l/mNda02+F3HRxgf
	 A0s5/RJW/KYA7up2EDMBoFyT5oTYFry4fVPSjZ45fgPx8vlk2VxFODj6JvAZy/wGo6
	 kvUgxhNn1Nj1g==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 18 Mar 2026 10:15:06 -0400
Subject: [PATCH v4 4/6] NFSD: Refactor find_one_sb_stid() into
 find_next_sb_stid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-umount-kills-nfsv4-state-v4-4-56aad44ab982@oracle.com>
References: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
In-Reply-To: <20260318-umount-kills-nfsv4-state-v4-0-56aad44ab982@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=8LQjHeFkOcpRUhyGcvySZVICzqwy16sGiJ2xanmktXs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpurN84mdV7Dt4Da4Ka2BzD0kmvaSkT+fD71K/G
 u7tuvBN6/OJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabqzfAAKCRAzarMzb2Z/
 lydKEACnl14C9l61ippzyrv/RUILW2NmtHWCqchEoIuhXuKK2SCv21Gn+V7rzLnnAgiKVhR9pNe
 aj5IvjqwuF9gLmGHUx44r8JJKbqZoXdzuYi9fypZ7IUsgXoVfssmeev7eL89kGqvaSsUpMySici
 CpC6XN17Seuqc/h0H3FHc0Pwsic4ydfNm37mXyMZJwWLfkacuuuM0qURdb0rkzrB9RRXWyvkLoT
 LOj5XD9WxDJKKQOgT9KFjl4MIzCkSr/n6wDgUcJu5LxY1T4srZksfdCu4QL48g0KJtbTP/igpih
 81R6ro8pk+vEOW/iW8JcSPi6s5eaC/bsId87DmZ41XWXwHbul8IuKfUmfxNX4lGP6fP0tMEQORH
 X7+d1f0I0v9sOTDe+UbUHp4yYPbMtSw7JmS4LuqmwI5XpY1h5CcdmB/tf0FGq3UjuQs9KISqioj
 h+rfAPYp4UfL2q1DpPgU+i1enDSI4xHFKvc+ER7ezLssr2uMPN0kFg1e0jtIvPQBb4w/KE+0Br+
 WjNBXxlNF1aV/yfgbEo6LnAe5iBAzCxl0MdNzajrJOWtdZDqy/QdNJr6sYmY8/zXm7tZUlZzZgz
 cajguEyq/qZG+rlHCn6NIwrW83ng4Ha4ZgnONbA/+G3f7UndSCSmFjCT+zEDRnkYIqi9wpnbmIO
 u3rcdoLejyxSvzA==
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
	TAGGED_FROM(0.00)[bounces-20248-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C6272BCE59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Export-scoped state revocation, added in a subsequent commit,
needs to advance past non-matching stids within the same
client without restarting from position zero on each call.

Extract find_next_sb_stid(), which accepts a starting IDR
position and can resume iteration across multiple calls.
find_one_sb_stid() becomes a thin wrapper that starts from
position zero.

No change in behavior.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d476192e4b27..891669b32804 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1738,25 +1738,40 @@ static void release_openowner(struct nfs4_openowner *oo)
 	nfs4_put_stateowner(&oo->oo_owner);
 }
 
-static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
-					  struct super_block *sb,
-					  unsigned int sc_types)
+/*
+ * On return of a non-NULL stid, @id holds that entry's IDR key;
+ * caller must increment @id before the next call to advance past it.
+ */
+static struct nfs4_stid *find_next_sb_stid(struct nfs4_client *clp,
+					   struct super_block *sb,
+					   unsigned int sc_types,
+					   unsigned long *id)
 {
-	unsigned long id, tmp;
 	struct nfs4_stid *stid;
 
 	spin_lock(&clp->cl_lock);
-	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
+	while ((stid = idr_get_next_ul(&clp->cl_stateids, id)) != NULL) {
 		if ((stid->sc_type & sc_types) &&
 		    stid->sc_status == 0 &&
 		    stid->sc_file->fi_inode->i_sb == sb) {
 			refcount_inc(&stid->sc_count);
 			break;
 		}
+		(*id)++;
+	}
 	spin_unlock(&clp->cl_lock);
 	return stid;
 }
 
+static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
+					  struct super_block *sb,
+					  unsigned int sc_types)
+{
+	unsigned long id = 0;
+
+	return find_next_sb_stid(clp, sb, sc_types, &id);
+}
+
 static void revoke_ol_stid(struct nfs4_client *clp,
 			   struct nfs4_ol_stateid *stp)
 {

-- 
2.53.0


