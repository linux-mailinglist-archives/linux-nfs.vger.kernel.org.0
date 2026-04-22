Return-Path: <linux-nfs+bounces-21005-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKJtOM1a6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21005-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:33:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A2444BB10
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E38953109E53
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5919A3A1E9B;
	Wed, 22 Apr 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3XdQt3G"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B233B6E3;
	Wed, 22 Apr 2026 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900634; cv=none; b=pjqTEqDF7LNwb4g14MSAi4JJtZvCvUwWog+RRDw+8fmRlBIHyb3ljVHiOKPyE1mx4Pzrq4PUnCsc2SnuhtL8t/LyI16lkwtTIL9a/EgRN0DwclMqyp4I1SxCE6qTbN9p5UfuSwQ2Cefca8KuoIDhy0KRNPsynZymAg7f75uJjTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900634; c=relaxed/simple;
	bh=PcroO5CweiTdfrAbvYqaLqKDeO9OE61yEag4vDGPG8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nvwe72pTSEzDxEhbxU7mfzHAV+aSOPO2laOidjX75s1SIU0xBapreOdIA9mGisP9BLRq51PN/JMKIuLGX5jzuEGX2ODrRxjrR5j+FSF1+UzdqZd2P4yiVUcjBccOBbYQZ04UwI+dm0D56OhKLn500ps8dFF94fH/MbY1xXumOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3XdQt3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B716FC19425;
	Wed, 22 Apr 2026 23:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900633;
	bh=PcroO5CweiTdfrAbvYqaLqKDeO9OE61yEag4vDGPG8Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a3XdQt3Gn+AWljtg1JgKHnMFskrXRQkdifjAYtRnz3vVeVZq+OzHdNBzDPQmSd07t
	 owTjiQgraE8bS26TcX2l1URUgEGWan2h6QFEIDXf1eSMIlulMsTE2MKWfBw7Gko6Ic
	 OUq7QWVLi7rDV4OWz/UqvEyfR4upp76XBTUI+H5MweZ8DxmUMlrp9beGuSvQLpyXGD
	 3qAgnhkys6dz7xmsqUlGWgREOf5SLeO9PGxZhj7ySoKDpKpe9xTJ/e22Swei4MxtNZ
	 Gu88sQMedIr/++xFZj9gfbAkfbRtp2XqRmE+LdDyXbIHReBU6eMcCgpvXUzApcZlrS
	 NzUrMNAaeJbsw==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:01 -0400
Subject: [PATCH v9 07/17] hfsplus: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-7-be023cc070e2@oracle.com>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
In-Reply-To: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
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
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoF9zDZc9sCCBTCQGhgFXZOUxhLZqkiabRzh
 m2Dce5ZLVCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 l7QQD/9NPdB+1IIja3d/pborFSqA2NE3c/tzM3HQaZsVQelKHPaLICOeBWaW4M1L7qVwHb+pR9C
 lDudkaTgbZ8PTRzTtCB47xQwT4WoeuaVyoHy3aAYytqPo2JYe/8ZkMib9uMNg8brK6L8qCZRlUt
 X6zWuNycOEJAkfNGyHRn0frVkzsKT5TY+rqxRP1vvLljxGysVsi7GN9wAXDYFtiE7rSH0imu+VU
 qG+9YSAwe9yiomEAoRcHwXfn3sYARNaKqVbWyNqbjyUVoICozcOvAzrYCbOc3posJTLN/JilYH+
 wWC6aLVqG9y5gMTYD4DqVhxiq/VaIUyGjMnFp8cWPd7MR+zx8YnVEXgqLkgBHTgbzOOvo8FrFHm
 Xn1vI8PQNHBT0MOTh0Xw40YO1cUG4Q3Qllu0Neo/mB6Wdaf52/z2AdCQiUsrIFVz91oTx0XLtql
 D3PYQJDJRrwNTWo7pRgxEMhVCDakfO59yt5aXSjdHPOiqW32a420yu6PRZKRkdi6s7LjaJguA/G
 YWxS8wZwyZcycHO/nagVb27/jJxJmueeeQicDaA2ynQfyh2WzcRpW5XDMbBUQU6B4QoxmJwAqIc
 Guqq0pW88+GuBS8FhBNXtr6tDk0xeIVb0qOafK6JQ2sJIlQkz/YVXo5FYrL2lAF8Zxt3aaY29bb
 BPOiedPDny3snbA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21005-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko.com:email,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 93A2444BB10
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


