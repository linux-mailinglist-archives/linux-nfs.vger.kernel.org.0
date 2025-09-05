Return-Path: <linux-nfs+bounces-14085-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C43B463BC
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 21:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC23A1C877E5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 19:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2BD27F4CA;
	Fri,  5 Sep 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KR5QIzZ2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7471272E51
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100923; cv=none; b=o0644FLKPia9AabRI49XxeA4pvZIapN3+JRWcr4Ud2wtDNElE+683IxeskuFdjEQEItVL5U4yabSmExvzijNlt2ViCExX7DEndeMlX3Sgk7SCs9Vk/fZXevU2YToKDVFKdqaJJquNJfjKmHGNXb0wvl1HwEeDspmA8nLPvzYEm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100923; c=relaxed/simple;
	bh=4r23KAEeZZ94r+eQOISf0mfu152VGWw/2tN4Pe1iPJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Try3TeuLilq728FCPLlhhsYDDgvRvfClrA8f8RwME57PwhIS3hDMLJf1Efz7swOv1Q/hf6h9kAELQ0Qe70g9AomuOAJW5mvb5+v5u8pNtRAzHjdzdA+7dBLX99nhM8osG5Ja/iC5u9U3BWedMch0ZavGFGegneyQVtiKFzLfbRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR5QIzZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E92C4CEF1
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757100923;
	bh=4r23KAEeZZ94r+eQOISf0mfu152VGWw/2tN4Pe1iPJ8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KR5QIzZ2PDYri5NN1Vll5fmUHtOseQPlj9fitypy2BdWxQjfv4XD8xcxeEnbTquvZ
	 gFqnsTqDEAhi02wsFF0YMNAjUYWKd2dgRtI8gKstOsJKSnmFlOvAEDaYlJqUcXQoHX
	 fLismWoh77s+KodPwHhhKJokO7rVEXbJkIdQKb2LdY6S/rbRExnEGtlp1q89vWsnsm
	 iOtgXfOM7lqcIraTAB5vcpclKahbskycSqR1W3Ru3eWN69ScE8ofUr8Po1IWdPLxAa
	 +pXVSN6UrA2EHrMWbxrLpiecLxBRRejCbHz9nf2vbJJ84vdAqhMNltaL30Irdw6N/o
	 tUbf8Nm9x304A==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] NFSv4.2: Serialise O_DIRECT i/o and fallocate()
Date: Fri,  5 Sep 2025 15:35:18 -0400
Message-ID: <db04e223ed0ab5a564bcd486cfdf60ec1339d740.1757100278.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757100278.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that all O_DIRECT reads and writes complete before calling
fallocate so that we don't race w.r.t. attribute updates.

Fixes: 99f237832243 ("NFSv4.2: Always flush out writes in nfs42_proc_fallocate()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 4420b8740e2f..bd45423668e2 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -114,6 +114,7 @@ static int nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	exception.inode = inode;
 	exception.state = lock->open_context->state;
 
+	nfs_file_block_o_direct(NFS_I(inode));
 	err = nfs_sync_inode(inode);
 	if (err)
 		goto out;
-- 
2.51.0


