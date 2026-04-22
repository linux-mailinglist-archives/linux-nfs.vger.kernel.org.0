Return-Path: <linux-nfs+bounces-21007-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JqwDvda6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21007-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:34:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C80D844BBA5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E93C3049706
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33403A3E66;
	Wed, 22 Apr 2026 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnaHnaYi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC26A33B6E3;
	Wed, 22 Apr 2026 23:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900638; cv=none; b=d62QAdlPHIYQrf4NcXMQyi0Pk138Dy3mYWV2gbPsJVLnK8greI7ujtgmQs2/KCxm4RlRlahOUi72OlB37WbZbNMHXJ5XEGO/TEQSAxPy702ShoKwjmVro2ZD2rfDyQog82cv7Ipf/RSjGkJUf8/qLrTZQaFtVXtrsJbuw6vkjFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900638; c=relaxed/simple;
	bh=4whuDT2NAsASpb7E7T4HhtgZB89kNBSY63z1QOF+oEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pBnR1XvABcmLBn2KsxSMYbrB9tkQonRH4jUD9uwe+ku2r7dpFWY7TKRzNl+T5t/71sVnMRVeQc0Y6VT6YtiBN4xTj/2LCPux2cuKMeqkUIhrCnDQzFarOtZ3QrenwHJNJPltBa3BeC6fv/z3XeJUud3zx9CeLtnF1mR9bHZZWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnaHnaYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B45EC19425;
	Wed, 22 Apr 2026 23:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900638;
	bh=4whuDT2NAsASpb7E7T4HhtgZB89kNBSY63z1QOF+oEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bnaHnaYi6wS+dpu4hSGk2aKp6qWM+jKNpuqCfpZRt7jst7HBdWHgzDl7X+21Z/6uf
	 cto4ohY7BMSTPGHMk2cc3hVzoceQb0zbLF3JaCb1Sb0ndNJYFttAe0Q8eKVRidzVuh
	 CZtKE0NvGuVe87n5/qDmH0l2r+LHLSX3OkdmM3LnrkUsaLwtINnpDvxocW1PF5ERI4
	 aDGy/w75tRNo9KeRxkTCQq1p4MehJ9Qat1kR9j5gQ7RFVwlRK3npGvkl00FSwlq/Eq
	 85ZHETH2V6C+Zi2OY/436EF/x+rlQ4RsrZ60NCkp3vxAH6MsmS7q7/qT105SEPEWsR
	 3jULWrtGjAI5Q==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:03 -0400
Subject: [PATCH v9 09/17] xfs: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-9-be023cc070e2@oracle.com>
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
 Chuck Lever <chuck.lever@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=DjIMkqqMWUIzhkQeoXVo4WlkiMfqV3S6x//RMb6YZuo=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoFgb8ribB+nCo/33ADy8UGh/WTW9EVvYLDJ
 ZhkLdMmkQKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBQAKCRAzarMzb2Z/
 l/25D/9aqXIUuRxOQWtD0dWT+Q9W3mQd7Y+VY6UFS1LAtmd1vn5g34iB5NU7sM2wxTgYLOK+5/h
 vwoPHpOVaqxvhA6GsenrcETy2xMwbv4PRm6tnvS/4sMYQB6c0PKf9dHVao8x51/6EAQjfhUPPMY
 414gODPEKknMS6bazcGhAiXDJYerPC6pDphIuSsR/PWJWUnOXaDDrBXVgRWxPFfcpdmLmPix+IB
 FtSX59MZOv1IxHSU5cHLjIjSobLGSVYwk7xbu57GH5tp8TQSXvXds7I6J2Lr0gjvdVNbnUbo3Q6
 4xTbfvX28p3m4mKCt3F46liurf+8mcdIkheGpzRFgTcFsq7gwsXX7qR4WAHTD/tM0XN/SXBIubE
 f5ewBjam/sAh+aN3Tr/w2Bt8HXMJOxeUt5W1UL55JgDCLAyaqXP3qDI5VcnfV7wEJe2hh1lqKI3
 S9a2Al02PjUj5s9ZqlbrleD7oOAd1aApbGRdkd3p/o7v6kI0qUlEfVi4IiQMxfCAZxZ+F92nJ/5
 xZtIFCiKxhvUK+GgddMEDsV37U7T7xpubEwcJ1othGDQmliP89lZI2sfdliv3YjargSsSanVWXC
 37e5iAy9sqxBdaj5HqhnLjaiOWTjRBt+/CeMx7uAaav5VUyva44vS/JPXv14RdHDgctXgOF/nAG
 xFtrEcKzj1PPhlw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21007-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: C80D844BBA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need to query whether a filesystem is
case-sensitive. Report case sensitivity via the FS_XFLAG_CASEFOLD
flag in xfs_fileattr_get(). XFS always preserves case. XFS is
case-sensitive by default, but supports ASCII case-insensitive
lookups when formatted with the ASCIICI feature flag.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/xfs_ioctl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index ed9b4846c05f..b3c46a7ece62 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -537,6 +537,13 @@ xfs_fileattr_get(
 	xfs_fill_fsxattr(ip, XFS_DATA_FORK, fa);
 	xfs_iunlock(ip, XFS_ILOCK_SHARED);
 
+	/*
+	 * FS_XFLAG_CASEFOLD indicates case-insensitive lookups with
+	 * case preservation. This matches ASCIICI behavior: lookups
+	 * fold ASCII case while filenames remain stored verbatim.
+	 */
+	if (xfs_has_asciici(ip->i_mount))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 

-- 
2.53.0


