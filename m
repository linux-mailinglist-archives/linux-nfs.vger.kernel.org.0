Return-Path: <linux-nfs+bounces-20958-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBp5C7gk5WmXegEAu9opvQ
	(envelope-from <linux-nfs+bounces-20958-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300BB42522C
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 20:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 627CF302A6A1
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Apr 2026 18:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92742FB969;
	Sun, 19 Apr 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT9fRAKi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DA82FB084;
	Sun, 19 Apr 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624800; cv=none; b=RCIkGyFU1UNohb3vaV1ts05zxew47EFzndsqQwxr0cNtiCyciirhpWJio+E6bCWkA9VNm1rr2kAgvTyHgJoktrjsFmrcHDIYh+apJtkH6eWdxPa5t3IKbKOZqmi3CXu22SKE3rVQ1eUZbdKrIGZeLsknaBsVkMxsJLZLLvr78GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624800; c=relaxed/simple;
	bh=m55klBpWepGYNX/ySIq5sKbX+f4gXOFFZ/my2E5Ew4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OSEh36pbCSYeXrJrrXk9drHcQuSAYpI9APJXQDnTe5+LgesyIa9M/aTYZABuonYtifEROWYon8hmRsEi7Ql/NZZYBCMygqcBbRh9qy1uWpuCxxZ1BEcWEbFKNeb9QyOLP8v7q8kXP0fUy+uitdL79zKZMlTWMU0n4jLGBDh1q7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT9fRAKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C62C2BCB6;
	Sun, 19 Apr 2026 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776624800;
	bh=m55klBpWepGYNX/ySIq5sKbX+f4gXOFFZ/my2E5Ew4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GT9fRAKiAwuXhfG3kVJscq0EHVPEtrhTwnQ92X4Izi3EIqNV9XqEq0SfYb1VdLhJS
	 4ESu7DCKxl+dtS9VV7WSLne2TIKyqAYyK0ELjDNuMNs5Ynk8XyPcZdqaox7GxXkl91
	 vLIsVQZ92Ju4BSyQuEhmdSJJRZ9gMDmPHuvYlG7DAUVBeC+6NfY3JlLJA3aoVQfZWx
	 bPf426sDPRA1tGd/Qk8NBjk2Duh+BsSxJvjg6WKDu41aPbcXzue15pOoljNsOzkLjw
	 /ognCC9AOsPkT2RbaRpX73tyKn4DIhZTImh0u+A5lE9m554O2cye8d1au1mi19t7L2
	 x4jZWa4GofkMQ==
From: Chuck Lever <cel@kernel.org>
Date: Sun, 19 Apr 2026 14:53:00 -0400
Subject: [PATCH v9 2/9] NFSD: Handle layout stid in
 nfsd4_drop_revoked_stid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260419-umount-kills-nfsv4-state-v9-2-0660bd06d2b6@oracle.com>
References: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
In-Reply-To: <20260419-umount-kills-nfsv4-state-v9-0-0660bd06d2b6@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=VFZzM4b70QL9NfjrBwUeg3hfegKPs1VQ1Ib7+4dQt60=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp5SSdaGtlmS08zTZjsnip9Q9jxujNEUOivvU0O
 cQ6Ehm+1Y6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeUknQAKCRAzarMzb2Z/
 l6slEACzAWn03qQWP3EBnJJi/TTUmztSmidJPmI+oAWWGUP1WAl01ZWk9WYNeKy8urcZcMdAvy6
 JZZqvkzAIYVRZsDLtyll+WbYFSjlzVsssBvqR4+Af0WUTFaANptQ6vDfVcxFhX1NV5cUP5+P3/U
 YMxhLTsXD5kIMghYXQpVF2M9oahlVHwno9LdjDg4XFe/4h6z24jQhiO67G83yGY5HgWqo0aHkQ+
 VJClCOlwA4xYLJ79MO+E+G0CSSXazCqWGxlz6YqzTT3Aa4VoOKoJY+B/jnXPMWaWugzxFBJBmJt
 GXhlGXQgwHoyfgJEMFV+pe8QmldND6LVOPFeiqSRo5eQsT0NeuiiNJPLpiLUasVcFvd/Re3+aUu
 pUrT9T/E0I0hW/HyEOVZ3sW/XxRne9x+HPUxYNQA7vq4bBQIjFDkUaiw4kGMXw94WJzPVPhSeBU
 QnI0He6+wlrzmZy8lVzf/WvZD34dvS73gWpGuEwkKPLviouCr123xzjIs273yZp1C2G5M68zbRL
 pY626yZVxbyq9eQT0Xw+3fImyEgcv0bX8D4FnlisQ/KxvgoMZ4Olwjz5/6SEr7G3j03bJnv5yA6
 P1pSLsix4gw6hp1D+mRgvEwWG22GFzG5Nfes8WnOKA2Ok4g67dnKiem91cW+dAm3tQBWSZp7Ptf
 UyzvJ5woTptXFzw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20958-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 300BB42522C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

nfsd4_drop_revoked_stid() has no SC_TYPE_LAYOUT case, so when a
client sends FREE_STATEID for an admin-revoked layout stid, the
default branch releases cl_lock and returns without unhashing or
releasing the stid.  The stid remains in the IDR and on the
per-client list until the client is destroyed.

Remove the layout stid from the per-client list and call
nfs4_put_stid() to drop the creation reference.  When the
refcount reaches zero, nfsd4_free_layout_stateid() handles the
remaining cleanup: cancelling the fence worker, removing from
the per-file list, and freeing the slab object.

Fixes: 1e33e1414bec ("nfsd: allow layout state to be admin-revoked.")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c6cb67cf02ad..ae5e1a20197c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5070,6 +5070,7 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 {
 	struct nfs4_client *cl = s->sc_client;
 	LIST_HEAD(reaplist);
+	struct nfs4_layout_stateid *ls;
 	struct nfs4_ol_stateid *stp;
 	struct nfs4_delegation *dp;
 	bool unhashed;
@@ -5095,6 +5096,12 @@ static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
 		spin_unlock(&cl->cl_lock);
 		nfs4_put_stid(s);
 		break;
+	case SC_TYPE_LAYOUT:
+		ls = layoutstateid(s);
+		list_del_init(&ls->ls_perclnt);
+		spin_unlock(&cl->cl_lock);
+		nfs4_put_stid(s);
+		break;
 	default:
 		spin_unlock(&cl->cl_lock);
 	}

-- 
2.53.0


