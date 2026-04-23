Return-Path: <linux-nfs+bounces-21034-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMPgCacc6mntuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21034-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8588452C22
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6213A30B5F5B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9033F0773;
	Thu, 23 Apr 2026 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5gScez2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B743BE64B;
	Thu, 23 Apr 2026 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949965; cv=none; b=QBt22csGPtPxdIHMlybHU0ehmnp98yUTsiYxnqBlovq2a9l3xJUQx59ppzGuVA8Lwr/qj4H1C7MFhaDY+k3B0WgOIGjaBxHXjjuI05zhxNmToO9e56NHvfWog73ROeHP/kFaPuIWSrLO0HnyTz4s9wbSuN15IDySMem4B19kyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949965; c=relaxed/simple;
	bh=Q/Z3eU7E7G5VuhyXLGLHVQn/X3HZutM3gSylfnZVEPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfsgS7G4OwN7fRA8HPnyHPfrLH40ko016tT/tB7V9I577X36aHbbhpZ+g7DlPn+bmV7YEY394naLFWzLRy/hM5ik7hmhjGs17XpVBcCK8eic1BNwKIIfOiU2YWyb8xKmFiXiK+Ib+HUNFJS7dd3aKaPrO9LQm4ty5P3dOEgs6rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5gScez2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87020C2BCAF;
	Thu, 23 Apr 2026 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949964;
	bh=Q/Z3eU7E7G5VuhyXLGLHVQn/X3HZutM3gSylfnZVEPg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b5gScez2YED5kR4UfP7ePXzzEJBb5rUkzl2kaWZ8I3PLFUgBLAbDFoL6fUBrKhQsb
	 vY7VDji9bHDReQ5D8SfrPb4vl99b0Oo3UsSGYWGGc6n9UsMvzFdSxZSJDss0CoTzxm
	 oltz16gygeIH57IBkctp753tNu/+G9aCXfA4LYLnB+fzWUhEYju83IJ+sXU8smvzdP
	 o+gArT4pCLP3Z68PxSt9h0Z8PImmccL9/D2lM0DQUcfIGgWnhyzpGjghvJmtKcZ2CS
	 2Li5JyuynrqBOkmQMrKRlm0LlfT8IpYZyQRNIRA2/V8vsfwlaqqrWEO3GQQBydWlvP
	 pDCsYsSZbsNbw==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:12 -0400
Subject: [PATCH v10 09/17] xfs: Report case sensitivity in fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-9-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=f8bPTEa6xHOGMJ4BkwBw/MA1JRSPvJxuTKAc3AxqaEI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq080HBIoQoVwdco58yDR8YVIdkIx/l7nWCL
 p17rvkKMhqJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 ly/ED/9AmddXjVCN3aojVl3dq7vYD4dHLpYLDtV64JoEYigKfl8rORJ11NTU+gqKE1e24B60uJk
 pdFiokvjs9qrW2JRbQFgIwW6hTV815teXb8jU9fS7kXCDGUBNNqBMi1AURxGS0+cKMvJOsG7wvl
 yputvf+P5kAEyAepPLwNZDeQ3ZsFw0aB/O7Wo43QmTRdbwp5K86ykLPGRxjf5QHuw2z9nn4q9XZ
 EvfnjgtzDe+CRaFbZFrJD1YflFdVfMzmJ8y8OhJ3VPs7+SCXwRGJqQ4t7WOPHwHRUxId1+yvGLf
 jlpNGlpLScKmAZy0wex1OROguQuASjnDTEND3+Rnxm7dmTYA08JqC8C9yRPit0M62pGj9Y9V162
 sSMrVUnmNayFOLfJuFGyYOD1C8vpsqsOVB6H47ikng+DKH85GPzl26ob1o/KebclsssdTPgwdzq
 +yVZixdIvTd7o/xyqgFffTVmBgYCW6aG0Wx7eB5CQMmPAcy+0BrbsuRaTuWhzqAVS8OgqfF7X8N
 ZVh4zYhE3s/YMsVzb78E+fwRyV7Gs+2vW5BtzPVat9FZxYtahS7k+5fIlWewHB0u/Ps+LzSnUJT
 Hch9406DJ+hMcAznh9G3hlsmcRQPA7MlqUf7my4whGQPZvztR/OETamaDE6BzniYdfmQ2AAjG9L
 zRv4taVhhDcNCMQ==
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
	TAGGED_FROM(0.00)[bounces-21034-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:server fail];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C8588452C22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Upper layers such as NFSD need to query whether a filesystem
is case-sensitive. Add FS_XFLAG_CASEFOLD to xfs_ip2xflags()
when the filesystem is formatted with the ASCIICI feature
flag. This serves both FS_IOC_FSGETXATTR (via xfs_fill_fsxattr() in
xfs_fileattr_get()) and XFS_IOC_BULKSTAT (which populates bs_xflags
directly from xfs_ip2xflags()), so bulkstat consumers and per-inode
queries see a consistent view of the filesystem's case-folding
behavior.

XFS always preserves case. XFS is case-sensitive by default, but
supports ASCII case-insensitive lookups when formatted with the
ASCIICI feature flag.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/xfs/libxfs/xfs_inode_util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
index 551fa51befb6..82be54b6f8d3 100644
--- a/fs/xfs/libxfs/xfs_inode_util.c
+++ b/fs/xfs/libxfs/xfs_inode_util.c
@@ -130,6 +130,8 @@ xfs_ip2xflags(
 
 	if (xfs_inode_has_attr_fork(ip))
 		flags |= FS_XFLAG_HASATTR;
+	if (xfs_has_asciici(ip->i_mount))
+		flags |= FS_XFLAG_CASEFOLD;
 	return flags;
 }
 

-- 
2.53.0


