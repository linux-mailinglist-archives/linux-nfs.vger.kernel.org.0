Return-Path: <linux-nfs+bounces-21091-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHSCHhkf7GmpUgAAu9opvQ
	(envelope-from <linux-nfs+bounces-21091-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:55:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02447464A17
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 03:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E77B302E7D1
	for <lists+linux-nfs@lfdr.de>; Sat, 25 Apr 2026 01:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF15F2517AC;
	Sat, 25 Apr 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFIOSmTU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFE224B05;
	Sat, 25 Apr 2026 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777082021; cv=none; b=M4xOu2Dxp/C/Sb1QifbqUc/eESpUbgbtQcHuaWdpUNjD+V7OzaR3Cv9aRmNmjTRItMy3apIjvrJLS1qsi2Xq8GV7i+hZbfN8Q/BGMCkGSUaECtO3FurWbK3XJ2tkSJ5usqGvE3crm5GEI7ut5DY4UZ9xh7gYcb0BTI/8ZApXbDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777082021; c=relaxed/simple;
	bh=oRDGC96aXLrYGoaLGWDMb1hUHb5uY4mVyf16uiV2qPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TWwOY/BOMickuVAWh2VrPBCmGBNfSkKnqiFdeeL2mLuSfIDQ81+0c9sZjWO7P/QwosUfRSu2dvLh3h96E/L4zGukSoMs+iBF5z3b1A1GBz+IyKjWsgzL89MoDv4cDHjItZM5RIxUiGEfFzt+3nDS7lXB+pT7e675wcGLbVG3LNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFIOSmTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC06C2BCB6;
	Sat, 25 Apr 2026 01:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777082021;
	bh=oRDGC96aXLrYGoaLGWDMb1hUHb5uY4mVyf16uiV2qPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oFIOSmTU2nhLm7K9+JpqJ9d5kWh4Uf7fpNodaD6YWmjrJ4yyGvopEvJViPasI0nmQ
	 VK8NZq+CThLHyQdjaq79rzmS56kUemS4V1peJSEVtKktXl/6+3XAFMuYj6d0lHYph8
	 kafByR1dboAtJWBjbq8iyRdxQyf6N19kuRjythCLSoRc4TTWOpV64mGE6F7Waeisxi
	 G/K854a0Exs9tEfTOWqY+M1QQuz5fS/2X9hCOC4Wvm0/HJQDb4yDheDPLnoxUDY+yl
	 LUs0NeatZhbKlgF568h5vyfnZuen2p9Mq0zwV7osGoA59hCN1Aho6GiV7cizMAaAhc
	 xS9nLQB+Mlisw==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 24 Apr 2026 21:53:09 -0400
Subject: [PATCH v11 07/15] hfsplus: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-case-sensitivity-v11-7-de5619beddaf@oracle.com>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
 linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
 almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
 glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
 adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, 
 pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
 trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, 
 hansg@kernel.org, senozhatsky@chromium.org, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Roland Mainz <roland.mainz@nrubsig.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=GH3KwkswOpLheXLhG9bp+y8vR50klKh2XxRFWosaGQw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp7B6QNmj81GM08BqfbJycnCt6uIXkx7PkUPmCT
 PsNKSwA0VmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaewekAAKCRAzarMzb2Z/
 l2PBD/wL9qDmPVh0AFBM5UbZyA8/ZailA6PaV0N5R1QyRq5wfKCOp7xkGRD6enKq24kxShCYkpL
 tm1OBWZBPH+lIUiuy+wWPySjdk1BsT0SrppjgXbnVMHzlsTKCPI4daviYHU5EBqEMSPznjqo2pb
 eBB/hFCjyWtk2K6VnDWu/RFxa89dniD1CgkbS4MZh2RgcGkDOBcZ325NEYCE1rg0J3g3vuiQbOF
 Izja/7zVl2L54lEOj/h+BLYPmOXT2T/pIMvcdMNHTcNtEtoMuPfNaOz+Fz01108trrpSH/djHgO
 HrncxA8pcsqiOM4fBOMDrCkPAEjmRQPy7fu2EWu1G/dMXUWYDE7GVJNy8BEAUXZhGDCl9HklwEA
 o+GBAO/7/SKRipZz5PR9oj6uIHQ2ROL23qpKs9jiMqxugb1olcdRth9aEoY7Wyc5fi1Nygj28MF
 0ILw4CdA/2Qq6jlUyKnv1BbWQpslm3T+u4np9UbPWvahRQTpvGFBqFBjzkyxjNjT8jPjnM+kexc
 mF5b/zImKIi/CitshFezOBSvm+MrrwSyvjeGbkmWIH6xfFXLnR6duJnJp8otkzl/s9UpStUkMa0
 JtnhL3Pk8E2UxPjf+oR0oXrb9xVifqi9sHOCMqHCtWUnbtlNoxZkWdr8tHKpY9X5dX8K0iPNEgu
 5Cf62172SzTHlFQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 02447464A17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21091-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nrubsig.org:email,dubeyko.com:email,oracle.com:mid,oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

Add case sensitivity reporting to the existing hfsplus_fileattr_get()
function via the FS_XFLAG_CASEFOLD flag. HFS+ always preserves case
at rest.

Case sensitivity depends on how the volume was formatted: HFSX
volumes may be either case-sensitive or case-insensitive, indicated
by the HFSPLUS_SB_CASEFOLD superblock flag.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfsplus/inode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index d05891ec492e..38b6eb659a79 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -740,6 +740,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	unsigned int flags = 0;
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -751,6 +752,17 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 
 	fileattr_fill_flags(fa, flags);
 
+	/*
+	 * HFS+ always preserves case at rest. Standard HFS+ volumes
+	 * are case-insensitive; HFSX volumes may be either
+	 * case-sensitive or case-insensitive depending on how they
+	 * were formatted. HFSPLUS_SB_CASEFOLD is set in both
+	 * case-insensitive variants.
+	 */
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags)) {
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
+		fa->flags |= FS_CASEFOLD_FL;
+	}
 	return 0;
 }
 

-- 
2.53.0


