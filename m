Return-Path: <linux-nfs+bounces-16442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F301C638F1
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 11:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66BB0347BED
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DFA25FA0E;
	Mon, 17 Nov 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk7vmSDd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF812D4814
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763375076; cv=none; b=esjH17F7WO7VNNgQNplGdpPYnz/gDdI2iHAFG4K9HjitpwVknkSVEO8fp77Bv6GJqMA48h0whvMuMNKVIQ8tHVI9rXIVQn//9dZaCoyx7IaE8eD7RAbd+kX6TgvwnrPN5ZszfuAQLqIoPLcWO1AW6nu0DTyr8KlzoxMMEBc3OE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763375076; c=relaxed/simple;
	bh=LNCQEMXCQO/IzxGrcaCjK6kN1HgVp+VverOv3+N3XSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c06DADpBt6E05LfTWwPRmkIpIoXjnNUK0YbgwPoTeEjkYKH5nI0XTYQeVDWb5RdMMq4Lry4/Hm8RNhS8V5zmOTBpTYjpRlp2B5Ep1Z9QUzC2OYbGINRrG6mRwlzK8A6HHDQkqjrvMTNTnKeEp3Wp7wmfrfmBmT+vZKuMgLh8LHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk7vmSDd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so3203846b3a.1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 02:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763375074; x=1763979874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YegcrtYKw6c3GMjDjKdiR8erxA2dzjJHu7b2KiL+EbQ=;
        b=Lk7vmSDdl31qLB1aUP9ZmSEr2hQRnD/UBaLkZP6xNtCRrL1cOAq1wCEfRzFeRnzkRP
         JRY7SDWxvYXDxiAm0RbNdU39aNfSKPLbCSDeQ1ORGVMIfSCULbN+w1y97lcRIGFvaTaJ
         2B80Haugm+zE3KUa00Gh9azQZEHJSfDlOKO+/CHWwQHytgHd+v2ymtNggTyGv4i0oNA6
         nsoRNKm7YM5ZkfehcNZNdieblIC3aLFpe3PJfEv+Tk23Noq872SQQKKQRNatMK5vL/il
         VgD7xf/tRU6XmdsK+8Xft98yy+Qz02LTdJYsnpUBApSamdzhCb4Cb2Vs9JaJtLgjdYd6
         37LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763375074; x=1763979874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YegcrtYKw6c3GMjDjKdiR8erxA2dzjJHu7b2KiL+EbQ=;
        b=YtM1xgpJhL6V3fUV+xJcID/y7r661AWJ8ecEQD1FnRyU4FQi62sySNMPIEGO1mFmun
         cUMtZLo26Bv/st/5/+h6nx6JsoN6+lmybd3NgKgKUiLITb5DUcbBMG1mH/buOf1AwyV+
         vbEBGjhxb3QturqW9KFJyaORy0GiVWRxaLID5UKi0rAUMhTAwfWFGpTb8xQFs0d4AImE
         9F5UOEAWd63z6Py1OiqTajEkiYPXqDDJ7IRcGmtyMBGdV5f3sgtDETM8UCeE90f43pFZ
         MpbpO3+WbcHf3JpAO1+E/yyn1blRlYgqltVKGQij73HgtcxJH/AG8LlJKG0108EJU26O
         y0lA==
X-Forwarded-Encrypted: i=1; AJvYcCUXnW/A0yueAybUdjo/aFD1Fjiq1r4fma+4t8t+ur8EoHRpegpDqMjNulwMZJDHEITTy36hmXytx3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1bpdQa3vk9XM8vKitlE58ORSiyrU1/MK/0SwYgA+F3L7CQS+n
	SUNQWh16wzcmjJ6+JUhtetDq3pJr3/Gxc+AH/7Xsg8eO4fhMRvCbZuYs
X-Gm-Gg: ASbGnctA8EN6m5yTVEVtLJyey01V9m3MoAojyga95I8XiBCIzCVvb26BpNdHDN04ckf
	UVMbd93AkX9Ob0MqF+wtSuKXjJ9FslwO75lavPLm7KrB42AtVXolMQFHSZE7572mpCOb1zfF36n
	JKljfzXZj0ZuUv/9Aceg5btUZfH2B+vGNtGVayswZPwgwgXEOQvCCheSZ2pIRZ1i16dUHBxuVJo
	OUZMEqzcZQLxVyIGOoQNtzDXCyZl7agYLzGdMHHSraw+OX3cUI4ie41sqstNEuvSA5c6B1hbETG
	ijfrMF8aggbSRv1Df7l5hcuLzSf1AZZ8X94k6ew1x+NfYns+vNApBjZuQ73gyp3zQmyvIJ8nUZs
	w6yivxzgFvvZ0oFYPjzzDUuldXdxt4UxCjShes4LwOq3Wl+WziljOwk06+MybbetEvwwYymynm5
	YYPiBMMNw+2dsJJ4xpDjwsHA==
X-Google-Smtp-Source: AGHT+IHdvgJS80Jkj5pOFW//8f5CWandIPTgwltBhE5basyfsKAVb9E1KjEb1vJsOAErLT07gquO4Q==
X-Received: by 2002:a05:6a00:2e24:b0:7b8:ac7f:5955 with SMTP id d2e1a72fcca58-7ba3be8c3e6mr15490075b3a.17.1763375073765;
        Mon, 17 Nov 2025 02:24:33 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927c23103sm12376936b3a.65.2025.11.17.02.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:24:32 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id BDB6643812E1; Mon, 17 Nov 2025 17:24:25 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux NFS <linux-nfs@vger.kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] NFS: nfsd-maintainer-entry-profile: Inline function name prefixes
Date: Mon, 17 Nov 2025 17:24:17 +0700
Message-ID: <20251117102416.12418-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=bagasdotme@gmail.com; h=from:subject; bh=LNCQEMXCQO/IzxGrcaCjK6kN1HgVp+VverOv3+N3XSA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJlS388mdQpLcnBN/7vkK/PL48qf11w9Zyl9XN/hU2PgF N1b98MndZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAii18wMux11FhlJJLofbTZ yujfa9PXNScXydyXT/R0Frr5qUhJ9xnD/5gygVVinktsFq77dvLby7mpsrJ7d92Km1BqdKL7bPz WfFYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports htmldocs warnings:

Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst:185: ERROR: Unknown target name: "nfsd". [docutils]
Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst:188: ERROR: Unknown target name: "nfsdn". [docutils]
Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst:192: ERROR: Unknown target name: "nfsd4m". [docutils]

These are due to Sphinx confusing function name prefixes for external
link syntax. Fix the warnings by inlining the prefixes.

Fixes: 3a1ce35030e1e0 ("NFSD: Add a subsystem policy document")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20251117174218.29365f30@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../filesystems/nfs/nfsd-maintainer-entry-profile.rst       | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst b/Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst
index cebbbdad871042..4d6b57dbab2a24 100644
--- a/Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst
+++ b/Documentation/filesystems/nfs/nfsd-maintainer-entry-profile.rst
@@ -182,15 +182,15 @@ with the following exceptions:
   + static inline functions
   + static functions that are callbacks/virtual functions
 
-- All new function names start with "nfsd_" for non-NFS-version-
+- All new function names start with ``nfsd_`` for non-NFS-version-
   specific functions.
 
 - New function names that are specific to NFSv2 or NFSv3, or are
-  used by all minor versions of NFSv4, use "nfsdN_" where N is
+  used by all minor versions of NFSv4, use ``nfsdN_`` where N is
   the version.
 
 - New function names specific to an NFSv4 minor version can be
-  named with "nfsd4M_" where M is the minor version.
+  named with ``nfsd4M_`` where M is the minor version.
 
 Patch preparation
 ~~~~~~~~~~~~~~~~~

base-commit: 377c0011055db83991c430961b639465d29ffb23
-- 
An old man doll... just what I always wanted! - Clara


