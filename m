Return-Path: <linux-nfs+bounces-21271-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHQxKZ7j8WlZlAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21271-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 12:55:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ADB4933CD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 12:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FE0F3079935
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F4E3EE1ED;
	Wed, 29 Apr 2026 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSQ2X7HY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2F3B9D81
	for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459800; cv=none; b=dJ+4nqcVqLKCfAKu5SBOnzRsGzihZeYTo0uVtFAYQFeE4GhIB46Im5nGIKv33mMGk7UD4W6yNr7PoxdaRW5HaTDlZY10/q645T3F83PvLrRkE7bdOqMaIAZEBAXv2BYbQYwjhCBzcvOCk7T2DG6q27qZOr0Nv5xdOPzsDsr5Dpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459800; c=relaxed/simple;
	bh=N/5fqb+aB65lsYDsWjoyUnZ02f4BDSqEloFWitAhkp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/Ww09S/OF6pPU3BZ+UyKZ4znBbM05XRCzFWSHLMNm7xpt4Yh63ToXBXww/U7fQYyqOjEa2ioDjq2W5Y7LhxQJNb0nfNFiNmD0MiOJ+rIA+i8j0BykMxAmznwkF/H7rJ2NX2Fu6D4hyUQQYkDIzEDwgPmpsxErrYPetWU/gz8XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSQ2X7HY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso127020325e9.1
        for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777459798; x=1778064598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2FyOVAEfkWXswNoEp5C3P/ITYDExEy6ZhNuNWoNGPE=;
        b=QSQ2X7HY8kMb4+n9kTdtd6/TJiA+1SF0Cr7Pha/johrXZKZObVcBr3W6pKiSZKTzR7
         5u9y56BrKRnt3mKV4GjLZ4kcPsckZYXWM/f0Ughigm3fbil3X0758goRgLZk9n3t3mj9
         eoeZuVrNiU4GcXZ/j6+2KDfjcVjfPaH9V0L2iRoOvwAD8RTPEAjM5qzJXeQmF5KwWur5
         gyd+JS3qYkooRIX/0UQkC1BXCnmebyUPPO4pEEEcnZMjFARyuDqFmhq13gIvJGWWnQEA
         lRz5KhEKDZ0Bg6y4tmlX3j1Wkgo6mYuFgpbSk5iEQ+I1zT2OsEDAdEybb76Z6BfSmd68
         5Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777459798; x=1778064598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C2FyOVAEfkWXswNoEp5C3P/ITYDExEy6ZhNuNWoNGPE=;
        b=OoKN3llIWiMvlY9NzK4WP7oOAHTS2aCBV4rssmTm+LC0vMFM+W8Y6WogUCSv8xcxNy
         Y1N+64aOnnh83/BVatktTCuGKhWTQAHuTagZUU3ym1eeWA5FXXAvWgxGNKOqb1IItj0q
         dSzWn6MA8k2h2xdlkQVezEqEOVrYB9+1jlwuFXRz4Qz+3KcG7gpZAytt3lmX1GIobEXY
         WELf2Bzvuw0MFrQfhsBHGuayQ7Yn7k5pDO/mdkYXAfJi8UzvoS98VtrjyWqlEx8XQRcl
         pVMEN2HUSNVN37pyRULgIAMOpaD3DgQuX8bOgkkiubPKyQ1JGrrV9k0j2Ae4twRWkjFS
         S9Vg==
X-Forwarded-Encrypted: i=1; AFNElJ86OEbc3ymB+dQn8xwLM2MXK0aqTlx5qB4JEjAs/P2XvzPk4vTwESiGcmjxHzeQMxSwu4TSW4/mE0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKdUgyGbaoIjGqjBYrZlajGlSa3mwZTYccl+i55jGfpPJIwmU
	hq+qfqThlR7+2LEwm5hFcZQ25rkLI+1GLme+hUGHqhVZvU3c98dWbYXxH2PneMmTdZI=
X-Gm-Gg: AeBDiesu5MRKUs+UMS9XeYTsXDvKP3Y3Oh9Oi2By631z1a9Me+kH+BZ35WcFJE5M1Kl
	dAETcg5EHjgLO7Ttsv3RdW+0s2H++HUqynWF0eL0p0kPkxGK9O2hJ+dTEZVcOIZ7AieIa1GPgvU
	zHKpLJwT/R6Q/rMMPc2FzGt+ywPjQET6ePTqpWhzPkikiLFNm1dnpCYnS/Qy6HlyuWlMaKlMnTp
	EQ2gYo4vaOwZuDFSqZaoKHPWO4rJAjcrhctUkXkogqXKzdPPGpPmZnarCRgMUZlVz2AQDwAD24k
	qbGhlTISeW0hGc6Z+15fUsJnxdU6NcPx26BtMuH5TGCrBWo6vQy4blZzYtT1Z9at9DfZz/oznB9
	tecCCOHJIq3wEf8xDWtU7wNd/sR5+hB3D5mZHvGLnVmbSwvow5LTnETJfFQvJc8WBnN4QHx3JBk
	Qnak1c/KuZ5KachzJLfjeUpqLDunRUBB+5/nn339HkJQjgFlQ8jaCr1Id0w70wCY/aQB7ogiEn8
	/mkqnnI
X-Received: by 2002:a05:600c:859a:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-48a7b5125f3mr40682595e9.5.1777459797446;
        Wed, 29 Apr 2026 03:49:57 -0700 (PDT)
Received: from igorovo6 (185-203-47-240.static.vlasimnet.net. [185.203.47.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b8c2dd7sm37481365e9.0.2026.04.29.03.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:49:57 -0700 (PDT)
From: Igor Raits <igor.raits@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	=?UTF-8?q?Jan=20=C4=8C=C3=ADpa?= <jan.cipa@gooddata.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] NFSv4: clear exception state on successful mkdir retry
Date: Wed, 29 Apr 2026 12:49:38 +0200
Message-ID: <20260429104938.1776671-1-igor.raits@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <177745671692.1474915.5018486129724109553@noble.neil.brown.name>
References: <177745671692.1474915.5018486129724109553@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34ADB4933CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-21271-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igorraits@gmail.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email,gooddata.com:email]

After a server returns NFS4ERR_DELAY for an NFSv4 CREATE issued by
mkdir(2), the client correctly waits and retries.  When the retry
succeeds, however, mkdir(2) can still surface -EEXIST to userspace
even though the directory was just created on the server.

Reproducer (random 16-hex names so collisions are not the cause)
against an in-kernel Linux nfsd; reproduces under both NFSv4.0 and
NFSv4.2:

  N=2000000; base=/var/gdc/export
  for ((i=1; i<=N; i++)); do
      d=$base/$(openssl rand -hex 8)
      mkdir "$d" 2>/dev/null || echo "$(date +%T) failed loop=$i $d"
      rmdir "$d" 2>/dev/null
  done

Failures cluster at the cadence at which the server-side auth/export
cache refresh path causes nfsd to return NFS4ERR_DELAY for CREATE.

A wire trace of one failure (the three CREATE RPCs all come from a
single mkdir(2), generated by the do-while in nfs4_proc_mkdir()):

  client -> server  CREATE name=...  -> NFS4ERR_DELAY
  ~100 ms later
  client -> server  CREATE name=...  -> NFS4_OK         (dir created)
  ~80 us later
  client -> server  CREATE name=...  -> NFS4ERR_EXIST   (correct)

Since commit dd862da61e91 ("nfs: fix incorrect handling of large-number
NFS errors in nfs4_do_mkdir()"), nfs4_handle_exception() is called only
when _nfs4_proc_mkdir() returned an error.  That gate breaks retry-state
hygiene: nfs4_do_handle_exception() resets exception.{delay,recovering,
retry} to 0 on entry, so calling it on success is what previously
cleared the retry flag set by the preceding NFS4ERR_DELAY iteration.
With the gate in place, exception.retry stays at 1 after the successful
retry, the loop runs once more, and the resulting CREATE for an
already-created name yields NFS4ERR_EXIST -> -EEXIST to userspace.

Drop the conditional and call nfs4_handle_exception() unconditionally,
matching every other do-while in fs/nfs/nfs4proc.c (nfs4_proc_symlink(),
nfs4_proc_link(), etc.).  The dentry/status separation introduced by
that commit is preserved.

Fixes: dd862da61e91 ("nfs: fix incorrect handling of large-number NFS errors in nfs4_do_mkdir()")
Reported-and-tested-by: Jan Čípa <jan.cipa@gooddata.com>
Closes: https://lore.kernel.org/linux-nfs/CA+9S74hSp_tJu2Ffe2BPNC2T25gfkhgjjDkdgSsF5c2rnJq_wA@mail.gmail.com/
Reviewed-by: NeilBrown <neil@brown.name>
Cc: stable@vger.kernel.org
Signed-off-by: Igor Raits <igor.raits@gmail.com>
---
 fs/nfs/nfs4proc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a0885ae55abc..ffd14141ea1d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5393,10 +5393,9 @@ static struct dentry *nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
 	do {
 		alias = _nfs4_proc_mkdir(dir, dentry, sattr, label, &err);
 		trace_nfs4_mkdir(dir, &dentry->d_name, err);
+		err = nfs4_handle_exception(NFS_SERVER(dir), err, &exception);
 		if (err)
-			alias = ERR_PTR(nfs4_handle_exception(NFS_SERVER(dir),
-							      err,
-							      &exception));
+			alias = ERR_PTR(err);
 	} while (exception.retry);
 	nfs4_label_release_security(label);
 
-- 
2.53.0


