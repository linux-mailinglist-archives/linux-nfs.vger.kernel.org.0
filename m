Return-Path: <linux-nfs+bounces-21037-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKpLBSIc6mntuQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21037-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:18:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D28452AF8
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 15:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 964163032373
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302113EF0BF;
	Thu, 23 Apr 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyVfCJyz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD33BE64B;
	Thu, 23 Apr 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949972; cv=none; b=KRieI4XRXUVJtyXnbeHv0jg+y4mOJ6vtYKF0vCrVNn60NeHOlSfhNRjisj/5OeJ1owjmvjOCq3IcuBiR8tgA4VTTQ+/xHDNT8U5PcgDDQGF2uYDxXqvSn+7MvgYoKNZUBF5icBFjWdsu4QuUhbQoD+A5BXfHYAaav/FAh2R2aWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949972; c=relaxed/simple;
	bh=PjsU9Svmz06mzp6rEncT9E/c+j3QoZVc1ar43kaCids=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQVQb6vr9Nf0C5Rtfdpfno9FgOmVQHM4vJg669v3h7CeN4rI6jzEEqW8UI6tlHq0P6mt5hr0bsEukm4L1WzB5u1jnU/DwG1is5kbG+iEzBBZeN3om1GnLydfTCjaYA9G2sKFrXpOfHydFc1xAugVpV84oRvpSkniCjjyE/ktKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyVfCJyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE700C2BCB4;
	Thu, 23 Apr 2026 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776949971;
	bh=PjsU9Svmz06mzp6rEncT9E/c+j3QoZVc1ar43kaCids=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XyVfCJyzEOK6OpBoLoOefj9vIEAfTQY4RMuHpWrtQCKtxw8ZQ2hwX/a4+VoEIL5xZ
	 G2K2PcoYJ26JDjQ7NYsztAgoe63NSUFgOMV/ljxUVxbi68qgqws5++KyIe/QchZzk5
	 9zwmwf751l0WrUfgoqU6E9OjmpI5WRGxdWVhD90X/+Fmdr7iwz+iJZl8uRi9qH17X8
	 OFl6zyCFSjoCTiwgoSUajU1CL6ZvxhP6aDyn4PNCUqy89DMWuYLYZyZ83PhfjM5z+2
	 E5q0KcAfDJ82+5mf5EWd2oc2IY+iotYbZKLoYnM7pl0lwrLN81p+URZBNfX0kIKS4a
	 wscFMoYjBQLWg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 23 Apr 2026 09:12:15 -0400
Subject: [PATCH v10 12/17] f2fs: Add case sensitivity reporting to
 fileattr_get
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-case-sensitivity-v10-12-c385d674a6cf@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=VPjzbnXW1pubGqzv+x/v8JVwQ1rV4VASVn6uK7QQPMw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp6hq01oe4hrZUserJsuf/NEs+cgupLfYyc5a52
 6R79zdge4iJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaeoatAAKCRAzarMzb2Z/
 l4ZBD/9wjTO+FgmmJWESBaRJUhoMgK1nZIp7zgs+Wa6SmIxuIdzrpbMs+xm1OAqllWNB6IIvw0B
 6ccNv0Q6DS6iU8ItuVw3tOp7HLe401lJlgouULwUUMYXLU1E+l+gXr8m6rPUoTXJNEhss2AEH9r
 oBoz6jRj6LaH7on75SZvEW6/28fC3GxcUfB+2I5y6TyDhu/GjizbiI7ZK46ZT3DXHBk8OOk+pjG
 cZv6oeu29/MBQQ4gTDr7WSNkkbIts35lcIrm/W7nq0AY4jAkarHCPcm8j5kVpdQBO15BC/+/6we
 dgM6/p7jV61E5LjEluzL9b55N1ntJRwTHuu6mcTWqif2pT3aOvWkBJNuluEJDOkCG/oFuTyT4dJ
 xBJWjtURC6STk6hOIZTx37/slUhlp1aocnhqnxFEnzCaDVpFw2NGOWUH8Ew7HJdOwt3y+e+52Mc
 ReREwUMol0AizDnbSIpJaq77SJjUp78zfj/DdTmFj1MKChJUM/1jVKcfsVP8rgJl4FPwoyyNsHi
 stShGcmDkz7XyKa4+QD1TfOSqP/TAyHCADwELknIrkme0FX2UNxRnPZA4WAROx7QPVJlg9ab5nu
 9mmP3QrzjSE1I4rilxNUgsThXlThhwP6VYCF4yPRhdhGIhi2m5wrUFRW5Z2ANHDlFbIQsUjHgey
 ihCsVbuZhW2a1+g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21037-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[32];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:query timed out];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 24D28452AF8
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


