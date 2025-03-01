Return-Path: <linux-nfs+bounces-10401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C63A4AD5D
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 19:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087BA3B50A5
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301E1E5B6B;
	Sat,  1 Mar 2025 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghJUGgKp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9131E5B65
	for <linux-nfs@vger.kernel.org>; Sat,  1 Mar 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853918; cv=none; b=hEcrq3QPcnL/unFlu/crK3jmImTf9p7DQXU3RXswA2noPoRfRnJ6kjm56p17YwloEc/aRcOwlu8/zR562P9czhcGO4mqh4Q4MjoS0gkfRrzQ2VCZM+jIEBInaQ7tUPOHbD1tDXekUFKtsE70odoyimtjgU/gWIfzIBWbjxJ0Uq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853918; c=relaxed/simple;
	bh=ShlpwZvS0/FdZJH/EwCVVZGCktVyn1oBkGmi/uM5D98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MaOYZ2PLSxAyj6pOh7luG++46Vfbp8H/hFViaU6OebsjC88sHj2UZBOhcFJc5OCMOgpmnfdXBBE7UfsqNtMrFjQXeKXd7F9wsY0PJzeAts1VYqTfddAg3irlFEI+3huSwC0JIn4msUNqc5FcPs9QCTLvVpKHerImd3kCnhEIGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghJUGgKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847EAC4CEE2;
	Sat,  1 Mar 2025 18:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740853916;
	bh=ShlpwZvS0/FdZJH/EwCVVZGCktVyn1oBkGmi/uM5D98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghJUGgKpRTG7sHSOY1Ua3iOmrbbHQKOtks/1dgGIkXtz1KUGIZgqGvVeJE/ZuyIZ8
	 7tAZdldod3i0e2DCHa7P8ZT5w09tMFJQ46VitkQvpkHk7g8SPlUty4bFdjgj7ZW5up
	 Q8yiysS821fs51hiZQr7oMJyUatj9Keyu8vbwSR7Dlz0lCfbRVEPvduBxVRfKRb8aM
	 pRkShDrF6P47yF6PUmSpI7TPneymS6VPCPAwGqjKqSNp4Dd5WAeT0elu71GqfptYNC
	 +uTFFAt1kzeB595SKgS3TYuXBfC5SRfynNSI1eCOwmhfRyEFZ3N+EkETr/eTtojDCG
	 CLRKXWtCOd5yA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/5] NFSD: OFFLOAD_CANCEL should mark an async COPY as completed
Date: Sat,  1 Mar 2025 13:31:47 -0500
Message-ID: <20250301183151.11362-2-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250301183151.11362-1-cel@kernel.org>
References: <20250301183151.11362-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Update the status of an async COPY operation when it has been
stopped. OFFLOAD_STATUS needs to indicate that the COPY is no longer
running.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f6e06c779d09..9a0e68aa246f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1379,8 +1379,11 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 static void nfsd4_stop_copy(struct nfsd4_copy *copy)
 {
 	trace_nfsd_copy_async_cancel(copy);
-	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags))
+	if (!test_and_set_bit(NFSD4_COPY_F_STOPPED, &copy->cp_flags)) {
 		kthread_stop(copy->copy_task);
+		copy->nfserr = nfs_ok;
+		set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
+	}
 	nfs4_put_copy(copy);
 }
 
-- 
2.47.0


