Return-Path: <linux-nfs+bounces-21010-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AfgLjNb6WndXwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21010-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:35:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685F444BC34
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 01:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6A223135743
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Apr 2026 23:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD93A3E8F;
	Wed, 22 Apr 2026 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il7N3dGq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252A33B6E3;
	Wed, 22 Apr 2026 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900646; cv=none; b=DgabAxbhUiZnEfEcbqM87e0XIAO3qzLo0k31t5oiTnesX78bkMaS4v1FLW8sAz+dmyfRhGAzF8MNZG+XwrTOKXk6Bcp3pcLs87RorvNyoGwNPmxrA9NDiidufPbLgiW0bQodwQu3o5YdiVbwIX/RVPpNMGiVOFoDdVquAW9XJCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900646; c=relaxed/simple;
	bh=PjsU9Svmz06mzp6rEncT9E/c+j3QoZVc1ar43kaCids=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sByMEm+VKsuhEWc5uzn+OwrDR6JVMseCgOQlRR8efJlNWjj9QZE5MbvAm3IwGzB9t9vQ5gRmDwHUsbi8LoXTGT1uBaIW6wt4HajMfC2IsNLdCcGX0W62J/99/eJVdkk47kYjHAiyl80wMmVnMvNY5TSEZdBFugc/up33LiWLAQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il7N3dGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE58C2BCB4;
	Wed, 22 Apr 2026 23:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776900645;
	bh=PjsU9Svmz06mzp6rEncT9E/c+j3QoZVc1ar43kaCids=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=il7N3dGqj0CggeHfeUKm2GgxwU7TmpzqTirAkrMvLZV84Z5Ys3t0NO5UfPyqwBQ4w
	 KfkNQkGt6XesfFbIpALB85c/t+u6iWyj0pGW1K1ZQI2ph8ZTRxmpYVsKivD1RIngU2
	 GmBgccGOgHGI7UcfNkpTNp/rqhSuReDPRkivzSk75Ww+ni9fHUfSwoJJY+HUEkvzkB
	 JOPwCPnWyyDvZ/htWc3L/42TCeWrFSmjWrSf1iTeGjYapMRIOdesYftUN0xl76qiXv
	 2l+GQXZx7hZghbxGgEtjG31ruvSBlp0yE2vPdkbxo/3seAX/x9/WgAZOCgCWUDBj0Q
	 //meVAlWqzAmA==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 22 Apr 2026 19:30:06 -0400
Subject: [PATCH v9 12/17] f2fs: Add case sensitivity reporting to
 fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-case-sensitivity-v9-12-be023cc070e2@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=VPjzbnXW1pubGqzv+x/v8JVwQ1rV4VASVn6uK7QQPMw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6VoGUJjs9CvzEarp5VOjWZnmXKebFLgGJvGS4
 HWl/+7McbaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaelaBgAKCRAzarMzb2Z/
 l5VJEACcD/MoAmNmtfPCbhXwyXSyo/LDgCQ9S7FiAtuTBH1mbE3CWSXtfrmueyUzcuGWbvTWuLd
 6VRIdx2ood3dd0HWhRVh85EAnKNK4OLI4Q2BRlzhWtD1TaLnq1LKeiCU31d8QgNhrnk9Z8b6AaA
 ABJxaW/nMl1g7foin4qMFu7IueKML9wyKSI4NvfqNzvuJ45I2LW+E0jcR++1lrBFO+lF+YXgaE7
 88eABqKP00oJNVNgGbMF9pY8b//R3V6u/nZrV/CgADJMSC5g8OaR6nEI9iOtsU81XjAk1CzgY6V
 LbjL9BwK6mZuj7vZAcep4x/g3qNL3tk8JNRRXHIW4A4nAutITm8WSk3d7zYvn1V0CLvpYWl6XVj
 5Au3BWnDEwD8TNv5e2cVTgSrL2SEuB5nTxZgWMob1QY/DNhCOOc9dBI62V1tp/Y2J6dx8AzMJkP
 MNzH+uIdoxpRGAo3u21a5A58cX9IPQGIhygMpa0+VczI0+exxGrP+Nb2kYLmwErkiIQX/wnus4m
 /HFCC5xmpAEDMzANfBaifXgPSR7V/oCkxFAtCf4h/r/PHG8jRTcF9jwJtrtyEEiBypUk8f5y0nM
 l79H+tg7pEauZNiiAFtt83HEiGxmHrYK8ITV0Gu1ruMxFPyMuj5quEpf/6WfLePQfc3KEtbmOde
 mgcBPtMCLfcCYhg==
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
	TAGGED_FROM(0.00)[bounces-21010-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 685F444BC34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

NFS and other remote filesystem protocols need to determine
whether a local filesystem performs case-insensitive lookups
so they can provide correct semantics to clients. Without
this information, f2fs exports cannot properly advertise
their filename case behavior.

Report f2fs case sensitivity behavior via the FS_XFLAG_CASEFOLD
flag. Like ext4, f2fs supports per-directory case folding via
the casefold flag (IS_CASEFOLDED). f2fs always preserves case
at rest.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/f2fs/file.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fb12c5c9affd..347568ff0d58 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3463,6 +3463,14 @@ int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa->fsx_projid = from_kprojid(&init_user_ns, fi->i_projid);
 
+	/*
+	 * Casefold is a per-directory attribute in f2fs; the on-disk
+	 * name is preserved regardless. Report FS_XFLAG_CASEFOLD for
+	 * casefolded directories so callers (e.g. NFS export) can
+	 * advertise case-insensitive lookup semantics for that tree.
+	 */
+	if (IS_CASEFOLDED(inode))
+		fa->fsx_xflags |= FS_XFLAG_CASEFOLD;
 	return 0;
 }
 

-- 
2.53.0


