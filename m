Return-Path: <linux-nfs+bounces-21032-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLOqKZMc6mntuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21032-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A4A452BFA
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C102830D6A6E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6653EFD36;
	Thu, 23 Apr 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+BrX7Kp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D53EE1C7;
	Thu, 23 Apr 2026 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949960; cv=none; b=oMsdf/UJ/CDsjeCINL6OdobJL2h+MCipnmthdcTV7RwcWBLmoZzNubuA7h80VKl/tZaLlOvv+2Nqj2JV6izzRwo5O+qVMDmlpnr08rHdL36U/AzypUO7GVe0oAwEFaq6y/gXB/yx2xIxcFs+q0zOZJFbeYludJlpFbmYWD+8r5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949960; c=relaxed/simple;
	bh=PcroO5CweiTdfrAbvYqaLqKDeO9OE61yEag4vDGPG8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N//itoNNnoYiIykctctjH3WQocp29IFoCI0kNLalsT7hkIunpKO3T26eOGip3DauzEycQWHPwMmqiJdOnMUuuOUUYd/dF1TfT2KiUXsf/XmoWkIZqyjMkvhuZCahxCSDNCLc5DOjow8QgcenT5wKR3H5Smeo4i67q7kmePitUNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+BrX7Kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6368C2BCB3;
	Thu, 23 Apr 2026 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949960;
	bh=PcroO5CweiTdfrAbvYqaLqKDeO9OE61yEag4vDGPG8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U+BrX7Kpru1Z5vLLQGmNkrh0X+a/0S2y1SxgkwTj8x7IqYZH84nwgjrAgws+s34y0
	 uMXR/osBApQcJN0TxLJOrsbt9cEcIXETBXSYPmX3AgZzJoiPdVbr5AnnyfprQQnq4l
	 q+0+tgrPmJ+f/OM+TXc+LeujetMf87cAlKqTlueJqDmsomwCoppVHN08Z1lIwL31eh
	 Jh4I7cKU2fdfXJfCSOKPiLMSLZGE3/2OVoYLgA/8Nqg90L2ly7qW8Kxl3DQu36S9LM
	 Ph15NzQqClaJmKDFccVzy6gudH/6DfXnqHCOz4PU8A04iXXKnA6/EdNnWJi2dINxJW
	 Kkb9XZR6cMCww==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:10 -0400
Subject: [PATCH v10 07/17] hfsplus: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-7-c385d674a6cf@oracle.com>
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1527;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=DsH9Ul/eRW+1BLm1emwHx7xWw9r+GnxZnlKzlLXX6Ts=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hqzledoq5XU2wz0+X3f+duTtSNUJibxmcFar
 OSNbaZOMQOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoaswAKCRAzarMzb2Z/
 l/7uEACLjPNxrxqT92fHYGwoeDC62hHSmHNtL5PA/eDaGqYBX+8ikTmCRtH1IHbD8Y2GQcvRMkj
 6scugmG/j9aoOyA92lSo5qApBHdsdLthvIroO2meGzBVl5Q7EpCUsumNOuePGwvEE5h4WyG/y6s
 BAc+Yc18V3INM+F3mskeafT5/N1CyV058tQ0S1tqO6KYdNz6lPXihvR298D/h3PxduB3XMmYEdC
 nIpYULJxPA/p4fdqcWZ24T/xh4n4zLj63/42dhtMOXLM4MNYz0QjO8WIF1AsZtb8XUzTA6KaAO7
 b+GnKK0UIJCriuO932xLUs0vTJUUgdLpvSG34lfqc+jQitJvPd6HIol+g14JHfYcTBnXB62CIoX
 Mvs7oUSAjbpdbJjaMpMRfU2Shn7Z1iO0eFXR/KXXM9geiRk/vBowbBnbHbL55AkTuIvd/1gVbL3
 ETpkIPi96Vt0STINJKeOLfmqt5yr2nzV4Y3ZEVJylzwIWGplGwWemPUK6Nr/7ZOlYqxDj8kyhSu
 Kbsm95yz+hAxXwAFbdgoXeGnZoZiMHar34U6TieCNDlY7yrpc8Sjlx52904s3afWaDye+m2n+Yj
 HzLRXXhZlRL606EVDdTsw/NwWkxOA99uN2YmLU+mIC29r4Qwv6lO1v8gzqQqPyQf64ksnftrl4y
 WQsqhWziknVseNg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21032-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:server fail];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 78A4A452BFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Add case sensitivity reporting to the existing hfsplus_fileattr_get()
function via the FS_XFLAG_CASEFOLD flag. HFS+ always preserves case
at rest.

Case sensitivity depends on how the volume was formatted: HFSX
volumes may be either case-sensitive or case-insensitive, indicated
by the HFSPLUS_SB_CASEFOLD superblock flag.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfsplus/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index d05891ec492e..ffbb57493d7b 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -740,6 +740,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	unsigned int flags = 0;
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -751,6 +752,15 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 
 	fileattr_fill_flags(fa, flags);
 
+	/*
+	 * HFS+ always preserves case at rest. Standard HFS+ volumes
+	 * are case-insensitive; HFSX volumes may be either
+	 * case-sensitive or case-insensitive depending on how they
+	 * were formatted. HFSPLUS_SB_CASEFOLD is set in both
+	 * case-insensitive variants.
+	 */
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 

-- 
2.53.0


