Return-Path: <linux-nfs+bounces-19817-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCBIDnHRqWmYFgEAu9opvQ
	(envelope-from <linux-nfs+bounces-19817-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 19:54:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5097B21728B
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Mar 2026 19:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23FDA3088255
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Mar 2026 18:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA172DF3EA;
	Thu,  5 Mar 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euQFlkQF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BC2DE709;
	Thu,  5 Mar 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736794; cv=none; b=hF80Qohz4Oqih67zfXTH0Cnj2V/iUJAX/bHabkbPAQFBXSBYZfbMOL9lPB3MXTMX7SJ1ph7U38OBdB2hkXp+jyvk/S2VUWd0+PlGzoZuhcbkzrwrvTxgrx90li0CjkxuICKclfsWMr++obka0dSIWplj6UmcpwsrOUYT76jLFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736794; c=relaxed/simple;
	bh=g2igT+ahgcS7QSpap1Cf/wWgQ6g5HUPnMGKeQOS2u4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVtsf/wDHyD0O4sN8XQH23xGaw5M6q8+qVBtwn50+so+kB+yjggtSVA0DiI+IkChQAPoVD+Y79EzemrOMKX2b05T6r6B62cKskf2tcL2dFT7PloEa5d/sTIUajeRK0KfzeIEJE4Hj5+R9oZ55cCvlpre9VxtUymRNXVRl7acfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euQFlkQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA8FC19422;
	Thu,  5 Mar 2026 18:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772736794;
	bh=g2igT+ahgcS7QSpap1Cf/wWgQ6g5HUPnMGKeQOS2u4o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=euQFlkQFIpMb3Z+HSU03FiN1GAD9FnfhLWGz6cyerBOjIrF9/EnhnCRWXNkssQ59V
	 Oc8QlbkglsKU1pBJaXzinGlYTOa3lrv5csYfqyOSl9KEMG/aqwaJYUD1sISjcJqJqX
	 K4A5x9487coeuVmIGnlHjzn/EpjGpoyK2YuntFNOEDozOh26eLQbPf7ZfPndy5xjCy
	 yLj9xZNKXyZSGLVPo+7BajnCVvEcoHyjOsE5apYhQs1ULU/7ivyeNdSwuhYFPLMzAC
	 MIBNs82YLjMwK21FXc2C9BgHr/eOXuvvSsFJfU/jKm7/d7GSm62bvIhu47QZ9v+8+2
	 221Ip5bRXkX1A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Mar 2026 13:53:03 -0500
Subject: [PATCH 1/2] nfs: fix utimensat() for atime with delegated
 timestamps
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-nfs-7-1-v1-1-e2200f69e543@kernel.org>
References: <20260305-nfs-7-1-v1-0-e2200f69e543@kernel.org>
In-Reply-To: <20260305-nfs-7-1-v1-0-e2200f69e543@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=g2igT+ahgcS7QSpap1Cf/wWgQ6g5HUPnMGKeQOS2u4o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpqdEYnM4fpCgBGHhQcnL0jbwKgG/hRvV3Yc4CD
 pK44U4t06KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaanRGAAKCRAADmhBGVaC
 FYuMEAC2emzo3UG9BMOgGCRE1C7j03/0FVfw6swXBtsi48LN6Iwgp87Mk7zxSvzjcnPBBcm4gis
 i7G2lHJMOcQBD3Vny+OuhlUrBis0IQ4h4Uue3q/6yoHsr/1b4fIEAih/UdQXNFl3RjUnjEnsCrq
 zuYLF01HjwS1/asOiZr4HU7BoiYfi+84cJjzTxIvmOBDtmWznDVxkLbwBgDn2JXB46H5XAyXOJ+
 hi0jXAqqZWoSh/M++CqTRSluTfE8W1ljDnF00iwSnkbQgESEUnfXcDgsQNXz3B4Kpe+MLR61o43
 5ZeiJToLvTt3U9isnlaKQrYD3OOFQe1VhzLsbZLYfKk/pII+Eq9pLHphxJitssu2LW0gLtcdNtw
 3eHifvsNd78F8foANvH7ocGj+RbkcqFjt7dRhf8dbYkl+KWXWPNUW1uU00R8LfIGd5AMEG6TyRn
 rtuc3RhnFI6/IiLyTwXrYbU38g2UNbl7EXGksggU2D5VcHuQFb6Vkg0JCo0HFkKWTtoVLTgdlHe
 QoNu6z0221UueeExRkCK0avBghh2J9GuLOXyyLLBbZ5iKThHMVPhMM4lJFSZ8AV5PmA9Srcq/bB
 4PpJJP1+tpjBnP+tUvbD3w3S3jlAGqpq1GLeS70bYR4xs9OZ6Js54BKvO/ga+VtkKkH9ylSlepK
 WSLenMv3R0Z3lYQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Queue-Id: 5097B21728B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19817-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,umich.edu:email]
X-Rspamd-Action: no action

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


