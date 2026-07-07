Return-Path: <linux-nfs+bounces-23139-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OcPSDhoaTWqDvAEAu9opvQ
	(envelope-from <linux-nfs+bounces-23139-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 17:24:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2A71D399
	for <lists+linux-nfs@lfdr.de>; Tue, 07 Jul 2026 17:24:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GFd+A+DA;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23139-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23139-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7DEC3013BA0
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jul 2026 15:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098B33F588;
	Tue,  7 Jul 2026 15:24:01 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D813EBF36
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jul 2026 15:23:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437841; cv=none; b=ihLS7xg37GGxCi+v2KeN09UNgMgizawfMZuRJ75pID7Fm+usrVdb9GWj9Zg6EnoVWV1lXk1OE9qYAN+3jbABp5dAZK2lFe5cutlVmkq0vf0Q+LvOIdDz+oa2Fd7JwLXP+3ufKzZRPXU+98ormlaqcdeeWo0FCkf6x76EoNqm0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437841; c=relaxed/simple;
	bh=DcskmWiYpWxeg5Fi4znambpcFfjcuYecnOLuH/KYEaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2zC3L+hEKf0JJiI43+T6Yd/2kpfvwvIMHMH9K6iTxqsy95dohQrV5zBdYan0BZKNvILotQ1ZiGa8AJKfhVOIHDUvYYwGkV/4hYC7TzgEM5IUaeehWBDvcbS9Fp8oTWBvfIlcZJ9lai5gFEodQMX56NCYc2rI4K6oqEmA1BxnXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFd+A+DA; arc=none smtp.client-ip=209.85.222.174
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-920f33347f5so212605185a.3
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jul 2026 08:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783437839; x=1784042639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWs8o677+cowbofw6u2468FYLFBQAbffMlciJq0SXrY=;
        b=GFd+A+DAgfiyOzWOj2YOq06lJOHuYBwRuTI522giU+HH+CxmML04eM2V206CBkWCao
         3kDJ128Y2SVRSCCKY+hdonxcoCJUzdezv8FK11b9rapmkSwlTlgcQiRxjhvirLup50pA
         TsvhU/PjnAG55D5wjKf7ZKVILHN8V6SzGATozSOFTgDpsTjbFqWEUD6Ug8PXH+2IGOXf
         zE8McxPeVtb/ecCo6R57Yx3wJ0MbgNfN85mfZ/kEwpMcoD+8ZLqj7R63J9Aal6teGKxG
         Trx0DbfuKOgzlLM1b2Z+ZJMpZp8cG/fpCz2I/B18mHmNj/6KbIl2fYGwwVLB55m4IBHp
         c2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783437839; x=1784042639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWs8o677+cowbofw6u2468FYLFBQAbffMlciJq0SXrY=;
        b=V+gVZpi2uKN/GDnFTXKNOS14hTeKCn2rBvFo7TV1GT6TwFkHcxgAGcuyP910qry5UW
         J/yluCwgJFVBcRsr3uQxoadN9siwRtUGKmsq/QwGRovzHLAOEV8OF9M7sT7ItmgNerck
         TE7m5Bk9Nv9ISexUB5QYgWcqfUFH0YS5Ik47CN5LB1jASPvoHGOPkVC7GJ+WrEcqm3b1
         7p5rqhdAtk/kLw6yRE5NHtjD37MYy52QhSkKBDM946xsHuAJneFRnHfRn6t6bEzLf7E9
         j19e21PUtLPBk+V9PsZxeAvB6F32Yt5Rkxfp66A0eXLd9Rn/ktcbuUsSQ6wbh4ro1fkx
         YRAg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2JverCe/HRWX6Oec2NWFfRgLa94u8bzJ8IJIpWFpBErnjfOzLrVtkWXeRpyyVtyUDZK8fHIky2Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIA71vKBF+aoVKvTDMNpTVoyFXfdpZvJQNiJb1aHWA00Bxp/Ot
	0g6wnylBVToUURE/maagANN+xDv//t7wdB9iESKnr6nl7r2l2W1eB+G6
X-Gm-Gg: AfdE7cnOu0eRD/fPSp9Eu6stNtQPtBjW9WsKWRLS7pzoGNGNTkKM7QSgz3sMLmtmaXu
	/XVQq4CHInZGXIzlzONKMCLi2g+K5glMA63d+TQQQXkZWiMM+NFlLrBYDwP3OW59961FrHYWlcw
	DVMHpsl7P0HklSltdTt65voGRbuYFl3j+1IP5NbctqEloLzNySyXoSEQmtyK72S2FNs5Dkbzzsl
	Nkc/09RpIV9kVubyMKhpPSGo/KHQ6acKeNqwSmyPP5wlTpIdcsd8GZw9F3AS3mxDMrEsYT/Po79
	rv0ZE1mkJkSfc9Z3+Se9SeNot4w08Oitvs4uOIXaY9T/9Cp8VuxanKZiBF0s8OZ4X3+mTMEYLJB
	imzNi9YTMbAzYgzxDr5qI0v7Jj5VDqR+/ayJC0CUak9QdsLamy63kDh4Lz83BTousEIlFDERqlA
	Y7XOFldP7Ht13TRRJAfLw1LDkR/oxuJ9dkF9TawHI282KCg+owxTRBxv9NtqcYKRo/KyEz7Xg=
X-Received: by 2002:a05:620a:290a:b0:92e:7ed1:3595 with SMTP id af79cd13be357-92ebb7164demr663575685a.69.1783437836871;
        Tue, 07 Jul 2026 08:23:56 -0700 (PDT)
Received: from mainer (pool-71-174-70-84.bstnma.fios.verizon.net. [71.174.70.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b9db95sm1163467685a.14.2026.07.07.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 08:23:56 -0700 (PDT)
From: Achilles Gaikwad <achillesgaikwad@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	linux-nfs@vger.kernel.org,
	achillesgaikwad@gmail.com
Subject: [PATCH v2] NFSv4.2: fix nfs4_listxattr size accounting
Date: Tue,  7 Jul 2026 11:23:05 -0400
Message-ID: <20260707152305.15324-1-achillesgaikwad@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703102759.9626-1-achillesgaikwad@gmail.com>
References: <20260703102759.9626-1-achillesgaikwad@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[paul-moore.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23139-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:paul@paul-moore.com,m:stephen.smalley.work@gmail.com,m:linux-nfs@vger.kernel.org,m:achillesgaikwad@gmail.com,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[achillesgaikwad@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achillesgaikwad@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00B2A71D399

A call to listxattr() with a buffer size of 0 returns the actual
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

security_inode_listsecurity() (via the xattr_list_one() helper) now
decrements the remaining size even when the buffer pointer is NULL, so
in the size-query case, 'left' underflows to a huge size_t value. As a
result, nfs4_listxattr_nfs4_user() treats the NULL buffer as a real one,
leading to a NULL pointer dereference in _copy_from_pages().

security_inode_listsecurity() does not return the number of bytes
it added to the list, so the code derived it as
'size - error - left'. That is also wrong in the size-query case:
the generic_listxattr() contribution is only subtracted from 'left'
when a buffer is present. Thus, the query result comes up short by
exactly that contribution (e.g., "system.nfs4_acl" on a mount with
ACL support), and a caller that allocates the returned size gets
-ERANGE on the subsequent call.

Declare 'left' as ssize_t, use a scratch copy to measure security
hook consumption, and only decrement 'left' if a buffer is present.

Fixes: f71ece9712b7 ("security,fs,nfs,net: update security_inode_listsecurity() interface")
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Achilles Gaikwad <achillesgaikwad@gmail.com>
---
Changes in v2:
 - Use a scratch variable to track security label size directly,
   replacing the old formula that undercounted the size-query case.
 - Drop the now-unneeded NULL-buffer special case for
   nfs4_listxattr_nfs4_user().
 - Retitled from "fix nfs4_listxattr NULL pointer dereference"
   (the same accounting bug caused both the oops and the undercount).
v1: https://lore.kernel.org/linux-nfs/20260703102759.9626-1-achillesgaikwad@gmail.com/
 fs/nfs/nfs4proc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1360409d8de9..a3415082d610 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10585,7 +10585,8 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
 	ssize_t error, error2, error3;
-	size_t left = size;
+	ssize_t left = size;
+	ssize_t left2;
 
 	error = generic_listxattr(dentry, list, left);
 	if (error < 0)
@@ -10595,10 +10596,13 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 		left -= error;
 	}
 
-	error2 = security_inode_listsecurity(d_inode(dentry), &list, &left);
+	left2 = left;
+	error2 = security_inode_listsecurity(d_inode(dentry), &list, &left2);
 	if (error2 < 0)
 		return error2;
-	error2 = size - error - left;
+	error2 = left - left2;
+	if (list)
+		left -= error2;
 
 	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
 	if (error3 < 0)

base-commit: 6eb8711ece2ce27e52e327a5b7a628ed39b97f45
-- 
2.55.0


