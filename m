Return-Path: <linux-nfs+bounces-22971-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id arQMLsyRR2pgbQAAu9opvQ
	(envelope-from <linux-nfs+bounces-22971-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 12:41:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB64B701509
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Jul 2026 12:41:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XTgCoTfg;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22971-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22971-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 832113001FB0
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jul 2026 10:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BD93B6361;
	Fri,  3 Jul 2026 10:28:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEA53B5305
	for <linux-nfs@vger.kernel.org>; Fri,  3 Jul 2026 10:28:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074519; cv=none; b=Xb7bI3glpa5cwLHIF04fiTBH22hvzAVUF3fOVB1cmPiGzX705ENf+DGuzNBF/apb5Hq8GhAp5l1sx3HC+JOLIXVHKIwNmC8C8NE5W+ROCuAe+hPXQ+jwSLE3GbpdfKxCkb5Er/WT50sQGiMkUhLqloJmE/XHlayJP/slWVZeZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074519; c=relaxed/simple;
	bh=s+a1TvCidY6rKa7+tJ7kXyNU1jsLYXLQD8C8n9E8gPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPC7fV+6iVaj9oKNwoxZscW/33gOmONK2ezJQk1GcwOO1pb/gsGSDyvQjbR8W6+qffteFOkxrxMymzpR3g06mHTogkck4L3Wek8tDb3dq9pE4hPZ9S6RPr6jWCT0OToPdlLwoYT4NdkWOh9+ycrSTQewOxxeLkSAfeKBqZMKq/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTgCoTfg; arc=none smtp.client-ip=209.85.160.177
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51bfe810293so1988291cf.1
        for <linux-nfs@vger.kernel.org>; Fri, 03 Jul 2026 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783074517; x=1783679317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xQ87Vgx+7GmUr/a8Eh2OpOLrPDatw5mWiln10DDeZ58=;
        b=XTgCoTfghieYqDtqvF81BtYpawL0lUMlfcmhMC3do6kekXgQMkkg2v4gtcAiwcxxeE
         lfB2IJSjxYeHABtzS0Ya1eYeKfOgmBil8F6i1o6o6HAzKEVwNBZofFP2Yft3rA75EXEO
         mbIQq/6+qGBF49iPtv/sxoun/PNaEXpQVDXhmKXrYq0+28804JoaktHXCd6VSw+tvwQJ
         sUdADqL11wElqW60W730Qd4YeANrwNoutcI/9vFOfM1l23qN4sxiXhpURHHFxbYbjyvP
         80WDm1fxBqeQKa/c//iJUXSjv4NeaaK6dobje1hD86wnoPByWP0htsT0n/WONDG4RtTG
         IDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783074517; x=1783679317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xQ87Vgx+7GmUr/a8Eh2OpOLrPDatw5mWiln10DDeZ58=;
        b=KmJj5SH3yIicRaWF6Zfm6idtcBpEfjvpAQVl8v4SWDeH6kX9VTIVxcrJ/kdpLdmaRB
         OG4tES6DhM+L9jXRO8N+TlESVKkddnB+hCG9M9ugxtBmIvgMwx3pv4keJiCNn99DjvxY
         u0FYTumbcOpxm6cKUmhy888VGclKy/Nj6Fm35U7crg8zgXKh6CPpKVsszplr6BUwD7GF
         SVK8G47s6hbjy3o5aV6qFy/BBCtLaTjrkwC8+Y4JJiDGgiKbj+YEiWI2E7UdY9T0Obfy
         2A3GoyPdd6bQHOqyN7MHtxivhtDS8qVyURHB5BiN/Q6UYJcjOUcApO3s4KKC+bKIdKmn
         XHnw==
X-Forwarded-Encrypted: i=1; AFNElJ/RM2JQVAsEFckiyVgUaF082mpFxQm76t5CyCAxcsieO1WXKVKIFAQe1+5k75IQKLE0t9nC6Ryep7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlyoc2SeFlGkjZ9h5hflXyw8cBmDey7nNM2q5zJkmhN4ywbB5u
	n8tZAN9fwT/dPptAuidOohnkRLVxh1YqUoAtSK0dazABJjGUFShfBAVb
X-Gm-Gg: AfdE7ckBh+/yhu0yt+cXGSlJcRmK0mwGX2me5lf9+jQXMQBs92Zqhz2B7YnLxLvtnua
	+5dyIObtPEAfAtgHM17OI5epCVQQLRTJSOYk5mexX5+1rWNynM70mPhingQA0M0qk9cFMknLp0x
	ye6VXwiDedhQzQJcFae6fP3+oFT73kVUM30uoOuivQlgdeZhw+sMSc9FddBmeTj7tKOI7OpltiC
	d67DFXHbdbVSFbH84GF2MQfULW/r21o+Zp8RP9YzAO2l7x+9MzvZn/XL5SmsgjzB4U0wxH0IZif
	iDMWxVcGMDathlPF+72vT8nswrTZLvaRlMAF2fmD01OQ0qWXho/L2q2RTsk68svOIOg5qWGyOOn
	gqTy3SV76tO7cG7WjzncKBuAjfMX9UR4UTjRDt8zdNVPIOveyuYCm/cqq4HLYYV+OS8kNjGZvXB
	ntC65awiTZbtbTvpXhWOZwL7l4Do6LiDKE79vBzVyFbYT4kztZhjMiIlSX4nFHJpeGT7msR+xSR
	4q8
X-Received: by 2002:a05:622a:1:b0:51c:1daf:1978 with SMTP id d75a77b69052e-51c2af1da22mr118286981cf.54.1783074517007;
        Fri, 03 Jul 2026 03:28:37 -0700 (PDT)
Received: from mainer (pool-71-184-152-175.bstnma.fios.verizon.net. [71.184.152.175])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2d688sm14072881cf.17.2026.07.03.03.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 03:28:36 -0700 (PDT)
From: Achilles Gaikwad <achillesgaikwad@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-nfs@vger.kernel.org,
	Achilles Gaikwad <achillesgaikwad@gmail.com>
Subject: [PATCH] NFSv4.2: fix nfs4_listxattr NULL pointer dereference
Date: Fri,  3 Jul 2026 06:27:59 -0400
Message-ID: <20260703102759.9626-1-achillesgaikwad@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22971-lists,linux-nfs=lfdr.de];
	FORGED_SENDER(0.00)[achillesgaikwad@gmail.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,paul-moore.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:stephen.smalley.work@gmail.com,m:paul@paul-moore.com,m:linux-nfs@vger.kernel.org,m:achillesgaikwad@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achillesgaikwad@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB64B701509

A call to listxattr() with a buffer size = 0 returns the actual
size of the buffer needed for a subsequent call. On an NFSv4.2
mount this triggers the following oops:

  [  399.768687] BUG: kernel NULL pointer dereference, address: 0000000000000000
  [  399.768705] RIP: 0010:_copy_from_pages+0x44/0xe0
  [  399.768722] Call Trace:
  [  399.768723]  nfs4_xattr_alloc_entry+0x1bf/0x1e0
  [  399.768730]  nfs4_xattr_cache_set_list+0x43/0x1f0
  [  399.768731]  nfs4_listxattr+0x21f/0x250
  [  399.768733]  vfs_listxattr+0x55/0xa0
  [  399.768736]  listxattr+0x23/0x160
  [  399.768737]  path_listxattrat+0xba/0x1e0
  [  399.768739]  do_syscall_64+0xe2/0x680

security_inode_listsecurity() now decrements the remaining size
even when the buffer is NULL, so in the size-query case 'left'
underflows to a huge size_t value and nfs4_listxattr_nfs4_user()
treats the NULL buffer as real, ending in a NULL dereference in
_copy_from_pages().

Declare 'left' as ssize_t and pass a zero length to
nfs4_listxattr_nfs4_user() when the buffer is NULL.

Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_listsecurity() interface")
Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
---
 fs/nfs/nfs4proc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1360409d8de9..4859c2c96c78 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10585,7 +10585,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	ssize_t error, error2, error3;
-	size_t left = size;
+	ssize_t left = size;
 
 	error = generic_listxattr(dentry, list, left);
 	if (error < 0)
@@ -10600,7 +10600,8 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 		return error2;
 	error2 = size - error - left;
 
-	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
+	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list,
+					  list ? left : 0);
 	if (error3 < 0)
 		return error3;
 

base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
-- 
2.55.0


