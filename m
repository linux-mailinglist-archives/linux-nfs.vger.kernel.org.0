Return-Path: <linux-nfs+bounces-20365-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AObjNVzLwmkBmQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20365-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 18:35:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E8D31A1EE
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C78530480B9
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0403407595;
	Tue, 24 Mar 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/Z4Z/t/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9E240758E;
	Tue, 24 Mar 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373538; cv=none; b=GrYcymlaoL0txqUv1fsKk5z3I5x1dse96AhUv3wARr4sG1lOZVMO/I1rcfUIOlcvLRdMJOZh5L91mYtN1TZpLHC9Af4hV2PDB/tPm4OGVpR03aCTUE2fWbAzPzRNw+xcSkHFahpaHFRS3ee4BMWu/AB+aAGF/mu81LJi9cIhlo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373538; c=relaxed/simple;
	bh=AOjD8zFqz3UKl9M/3fUGPTeSXDBXvJKvQHy4gsFjQIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cThCFF6K5HsbadivwKpL351QwPJx3Hh5gkNZnXAALDmMel8PUpEnin5DvSMCI1Y6Z1IMR5KB4/qgruuMOWj1ATy0FRDb8mMYuPwJc9PPX4gzVm9sGaobxCUi+be7IT9iijxsNA5RKcRxyPmwVM11gSCaNAbR+XgT946hEVYzU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/Z4Z/t/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B347DC2BC87;
	Tue, 24 Mar 2026 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774373538;
	bh=AOjD8zFqz3UKl9M/3fUGPTeSXDBXvJKvQHy4gsFjQIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i/Z4Z/t/YLBjRHYkS04UwjiLGTVP/DFxGRCLktEh/FhNOXfzLOp0UnHInukFn6pbx
	 ME04fMbl4kAAppaLi44cgH/ZrGw6nyrf3iu6Ls7WkkdfKW5w2tQpF1X8yj6EgaRwcT
	 MRIRsWbjiaaxvTygjXqa8K4/tuM2sZmclKgDIrozasv6N43KXZ3vRdhndKnDG8ix1n
	 DGiP7b3C2kBTP7BX6TYy4yrCfvDtL7C1qqg51xV3kJgHCg6BI6XNV0zRjyxJzwNPmk
	 HvtJaH2vFA7RT466zsydqwTOglaLVZ2MOsQzB2mJRaRUGfRnNrvi73xHJ8HJ4G8czA
	 UwfZedhiYdt7A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 24 Mar 2026 13:32:11 -0400
Subject: [PATCH v2 1/2] nfs: fix utimensat() for atime with delegated
 timestamps
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-nfs-7-1-v2-1-d110da3c0036@kernel.org>
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
In-Reply-To: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AOjD8zFqz3UKl9M/3fUGPTeSXDBXvJKvQHy4gsFjQIQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpwsqgYk2UMGvXNmntncvmMKFZOgYPej1663gYV
 e+aYzJLDeOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacLKoAAKCRAADmhBGVaC
 FTXHD/4u55JTmrcx1hJrcxAz7gokvtpcBY32elXYkUPQ0eZDKmfjv6gm8eUuUV9vReywKVdwths
 gvCNgAZEqj15w0h4YOmbVuLRTFiPFQnl1K4DzOp5dbIgJtyBiD45+1TIxtx0alUTMld06KV33J3
 2n8mzd3suJJHFcUqGxw/kLLDxOerylAwB3GUIpMc8ln7VBbxCyRHCzz9D/XSJaC+LzRKrhlfedd
 CZ5dwiIOEyH6rkZfotcLiEzmCTlAxCsiVY8BnynGzrXbKDVoDpCCMaK6C5bv6ZlMHRzggfaMWsP
 6/xVJd0ak18qqVBLZXzJypqW5d6wDzP4OeGL6VuonZjLfGrq3L/eFs+V6JNjrtz0XDMioGS/5NO
 rKDNKJnIZEbk60II/TacelfG6jMmtSu7D/FHxjzwv9a8X55hYWPN85kLVGynkUXGtdiQHrFaun6
 aLJDPndOUV7z3VK1kxKNSAoE9ATnhbuz6WaH9Tt82pgHrqR21vznLBZDRUOvag7UIzWsby+9bqH
 Lwdi9Hvg4MoFcdEXIerg0CF7e2X0xVI5auWDQ8G61eNqQWTv5Vwsh+T9sHOD+gfa/qVUox9LZ2I
 XB0CnvmiLg01ux3qkyuXQUr7cj1S2gLe9ZzKT94EwAVZpmsaX9gK01kCkWGQl2y2D0Wm1jn7L15
 DDoQClmWPVvSRHw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20365-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,umich.edu:email]
X-Rspamd-Queue-Id: 35E8D31A1EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfstest generic/221 is failing with delegated timestamps enabled.  When
the client holds a WRITE_ATTRS_DELEG delegation, and a userland process
does a utimensat() for only the atime, the ctime is not properly
updated. The problem is that the client tries to cache the atime update,
but there is no mtime update, so the delegated attribute update never
updates the ctime.

Delegated timestamps don't have a mechanism to update the ctime in
accordance with atime-only changes due to utimensat() and the like.
Change the client to issue an RPC in this case, so that the ctime gets
properly updated alongside the atime.

Fixes: 40f45ab3814f ("NFS: Further fixes to attribute delegation a/mtime changes")
Reported-by: Olga Kornievskaia <aglo@umich.edu>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/inode.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4786343eeee0f874aa1f31ace2f35fdcb83fc7a6..3a5bba7e3c92d4d4fcd65234cd2f10e56f78dee0 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -757,14 +757,7 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	} else if (nfs_have_delegated_atime(inode) &&
 		   attr->ia_valid & ATTR_ATIME &&
 		   !(attr->ia_valid & ATTR_MTIME)) {
-		if (attr->ia_valid & ATTR_ATIME_SET) {
-			if (uid_eq(task_uid, owner_uid)) {
-				spin_lock(&inode->i_lock);
-				nfs_set_timestamps_to_ts(inode, attr);
-				spin_unlock(&inode->i_lock);
-				attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
-			}
-		} else {
+		if (!(attr->ia_valid & ATTR_ATIME_SET)) {
 			nfs_update_delegated_atime(inode);
 			attr->ia_valid &= ~ATTR_ATIME;
 		}

-- 
2.53.0


