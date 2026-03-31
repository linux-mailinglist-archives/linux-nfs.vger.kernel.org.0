Return-Path: <linux-nfs+bounces-20562-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IDZEcopzGkmQgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20562-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:08:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D577A370FFC
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 22:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 867FB3056363
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB3B426694;
	Tue, 31 Mar 2026 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MP1fnYKS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508373CF021;
	Tue, 31 Mar 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774987614; cv=none; b=jb1gWNatkQLX+JKk1maUeC4DSVbHh6Oz0mh5J7HXww4XOAYWS8b96T1bkiugmpxVtH8dhE9wr2vGdpj31Pa4sm4t6FKLYz4g7I7CqtZjb8VN/Xn+ucCbbs0SstXBrKyy6sTgS5Uhybs4LLV4no/9MM9XluWjzyvqu/amcfiiQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774987614; c=relaxed/simple;
	bh=il5/x3ykx+5nnRfT8kfkQDO33GzbY7CCfqP5dLEA2aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZK2iMiESurMOVCAB9qMansYjeQeE3qWiYVOPgoyiZUZXaYL5Y7frDtIBkfk/l03AOWXtJ8BLGfpGju2JqXpa2ZZ3SWrZlr2E9kDmRX5iE8HqMzzreZ3SsYHnnkMgZCs6cFQI4NqBktArl27KR6ikfS9XgqtusRzc6WCWh9ktULM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MP1fnYKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6369AC2BCB4;
	Tue, 31 Mar 2026 20:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774987614;
	bh=il5/x3ykx+5nnRfT8kfkQDO33GzbY7CCfqP5dLEA2aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MP1fnYKSuIpR1kSGaOzby/WByy5wLHN1xDLjI0rEtoGVLKQT4E/Tnys5o2p11S/Z5
	 62Suvczedb/fapDpCjACbl2/mDlRR1xUW/hCYpWXQWa9+9Jo+gKmvDcJGnMSoRqopD
	 QZzqYLl/Vxzm3AFY9e5riJWWLq6M0duAec4LtycjuBPp3z9HA70WMPRMZrqsLxap3r
	 8zf3C+6NtJ7wuq3ZLrGq+QP99TIvbPuUDLuz3R0pjPWaRT7d93RsJthU+WhkCDGPV4
	 c/tUvhT295+baGmNbyAo1Nd2ad+AuU29oQN3cKlobl0cs2+XIcAIO0Gp6A0XFKbVbU
	 AUQQv7H2K7d0w==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 31 Mar 2026 16:06:11 -0400
Subject: [PATCH v6 4/5] NFSD: Replace idr_for_each_entry_ul in
 find_one_sb_stid()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-umount-kills-nfsv4-state-v6-4-18250f95f22a@oracle.com>
References: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
In-Reply-To: <20260331-umount-kills-nfsv4-state-v6-0-18250f95f22a@oracle.com>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=AfX62FgEvlkafx4AOtCAMdyoap+9uGdmZK9an+BSRcU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpzClZiP9uPFT2jKytEJundjMuYxH8o7bj5QVg9
 8Yy8LxuhyGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacwpWQAKCRAzarMzb2Z/
 lwfFEACZKQxCvySsJPDR5FY1tswQikC79l13VS5bttAWFAH/7Q/PclBx5qRgcQ8Szg6Cmp2ekFm
 BoktwybaWB9t33ySxffaS0uW2XzVHDF0XO8wtPE02v143MtFKfeSq20nf/0KTC8gOlQNFRdMjiD
 z5/CcjmzgMxegYlayyb0fcUV4iwfjNGM6B3wEXnQJgALOZc+2PktBkOYnlShiiLqtEb/evjd68a
 EQPjmD9iJu9zyJ4G8ljF52OCpthVp/CSOr3XHQxoBXwUijvmHN00kW/jRcrei27E6JX83XWjZHa
 UbmO7RhCDj76MH01PvEGsVIceKMM6SOXL94nGYCyIqgpNNPN2X/u7luwAEjohASyqQVcOP0OUJI
 bLHkWE3GX2lo7+ggFJu0pdaBYH5N2Qx+sLgSycexaAPSiw1oGXMs1p8z+jP5DPag7XdbatNO41B
 x1Lho16/HO6IC2EJtXsbMkfH8Ck0YVj0QQInUdq/8oaMpIG/JtcBsjY2+hKzMrgWiBW6iLs/SIE
 8qapBDIrbY+ON0Igvd2K3D5vMKSb8s4M7OzBBPpDrc9PfKPqzfxDl7tBP8nsoLiGpMuNLEyrQ0m
 +Mq7CfITu4z25DVLGEfaa/GL2LTDNEl/DgJgyvvQcL3zYC5zZJhCNxxi+0ai8J54VbulPOGxvuP
 g9hcZVaSDvtmhZw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20562-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Queue-Id: D577A370FFC
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
index 14df5afdb884..518dc74862ad 100644
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


