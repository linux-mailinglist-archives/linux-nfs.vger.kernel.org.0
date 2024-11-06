Return-Path: <linux-nfs+bounces-7733-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC839BF8C3
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 22:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B8F1C21977
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 21:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097C318FDA5;
	Wed,  6 Nov 2024 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZxGJYNn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78971684AC
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930108; cv=none; b=WDFzLGwpepFCLjZRSJ4SJ8qnXstiFUPu8TP946B3gISM5JDr1B7ooCSDgZFvkF366SpXsxyO8PPAAR3hU9jr9Qjdl5JJyxpzwlcT9zQZsHUTkdTy75L+L5QmJmRbFNy20m1nzovchFtkDlbpy0IvXNPyzxhVf0S0yrBaL1MYIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930108; c=relaxed/simple;
	bh=4KeOiCyEhz2ncdZDw3G5IJSoCIg2/MBwxYcSOb0HKOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MOxJ6mtOYsFoqe8EFKlmxcm9mUsuHM84wuPsBJqDa2dScs+KRloW71U/9nNIhd8IsZn/WAlVG4rtGc/sOhcZMGk8wE9pzpnZbP+8f/EDsy4hz0itAfqOUcjU33FbzhsSG0fDRstfjTzr6Qz1G65sQbHhXCKpfm3yplSDwJ+wWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZxGJYNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA956C4CEC6;
	Wed,  6 Nov 2024 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730930108;
	bh=4KeOiCyEhz2ncdZDw3G5IJSoCIg2/MBwxYcSOb0HKOw=;
	h=From:To:Cc:Subject:Date:From;
	b=dZxGJYNn4qBGzDOdGEGXbrCVcmA4JQ2Nukqe5wyXJYSoDojGE0uKhG0XKHHy0RzIs
	 qs3M3jtFcMrODNhTQQxR6u45dYhkRt68jMi0skm4tRjHZu9czF0ds0sGSMpNrmu2+s
	 hIyMxoylhHbIMjHHZP5buMx9DIkpzuoeufAwrgtl2E+UAeKEcBqAQ+TFpiHE8SQNDt
	 AG7TutqudvPyLBHM35NJuDIMeQJESkP0oK14kVIQyiC95d+KCMPvg0gT2i9+gGJWch
	 ziqyGimLFrLu79obTta3jzKJHvOWDg01hRppfso2+S+te6o9y9AB/zL+ArZ4VtNUOV
	 D5jSIWinhoM8g==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2] NFSD: Fix READDIR on NFSv3 mounts of ext4 exports
Date: Wed,  6 Nov 2024 16:55:05 -0500
Message-ID: <20241106215505.115774-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I noticed that recently, simple operations like "make" started
failing on NFSv3 mounts of ext4 exports. Network capture shows that
READDIRPLUS operated correctly but READDIR failed with
NFS3ERR_INVAL. The vfs_llseek() call returned EINVAL when it is
passed a non-zero starting directory cookie.

I bisected to commit c689bdd3bffa ("nfsd: further centralize
protocol version checks.").

Turns out that nfsd3_proc_readdir() does not call fh_verify() before
it calls nfsd_readdir(), so the new fhp->fh_64bit_cookies boolean is
not set properly. This leaves the NFSD_MAY_64BIT_COOKIE unset when
the directory is opened.

For ext4, this causes the wrong "max file size" value to be used
when sanity checking the incoming directory cookie (which is a seek
offset value).

The fhp->fh_64bit_cookies boolean is /always/ properly initialized
after nfsd_open() returns. There doesn't seem to be a reason for the
generic NFSD open helper to handle the f_mode fix-up for
directories, so just move that to the one caller that tries to open
an S_IFDIR with NFSD_MAY_64BIT_COOKIE.

Suggested-by: NeilBrown <neilb@suse.de>
Fixes: c689bdd3bffa ("nfsd: further centralize protocol version checks.")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

I'd like to get rolling with CI on this fix so it can go into
v6.12-rc this week, so I authored this version based on Neil's
suggestion.

Note that removing the NFSD_MAY_64BIT_COOKIE flag entirely conflicts
with the addition of NFSD_MAY_LOCALIO in v6.13. I've postponed the
clean-up parts of this patch until then to help make merging this
fix more smooth.


diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 22325b590e17..d6d4f2a0e898 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -903,11 +903,6 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		goto out;
 	}
 
-	if (may_flags & NFSD_MAY_64BIT_COOKIE)
-		file->f_mode |= FMODE_64BITHASH;
-	else
-		file->f_mode |= FMODE_32BITHASH;
-
 	*filp = file;
 out:
 	return host_err;
@@ -2174,13 +2169,15 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t *offsetp,
 	loff_t		offset = *offsetp;
 	int             may_flags = NFSD_MAY_READ;
 
-	if (fhp->fh_64bit_cookies)
-		may_flags |= NFSD_MAY_64BIT_COOKIE;
-
 	err = nfsd_open(rqstp, fhp, S_IFDIR, may_flags, &file);
 	if (err)
 		goto out;
 
+	if (fhp->fh_64bit_cookies)
+		file->f_mode |= FMODE_64BITHASH;
+	else
+		file->f_mode |= FMODE_32BITHASH;
+
 	offset = vfs_llseek(file, offset, SEEK_SET);
 	if (offset < 0) {
 		err = nfserrno((int)offset);
-- 
2.47.0


