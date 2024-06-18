Return-Path: <linux-nfs+bounces-3980-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9AE90CEC2
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 15:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1628D2810C3
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24CF1BA87D;
	Tue, 18 Jun 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F7477XZ6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954491BA877;
	Tue, 18 Jun 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714589; cv=none; b=LCt/kJj8WoNSOX6Vg3He2UInlTAXAWQgjnW5zGiqiU8c6XDw2r9PV37h9O6HUNWQjm5AuLnZ9hSk+1qft1whCBeOTZwlqkSDBSkCNBXnQ98EYz6u0zG3PrBqyHto1VVpovqVIXu7JFQYS3Cx2gYhXpiTDep/EGbQzD2chUWyKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714589; c=relaxed/simple;
	bh=QEw1lVVZFFXX5VT3x5lAacBYDpevRca1ieNXuJOWCEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxEwm4Gv/EdWw4nBVGXdevvvMM6gFYI83HAwx/Nn61BqybAIdu4MxGlG+e8Ymt4MvRY+fYqRZ5Ql7L6qW4aXdLrkDvNSC5k45BdohCDcTETdJPOaKld3nNKFWDh36h3vkAwZkoo0e03sdW1dvEios8a7xABuOyVkDuEswL/ZF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F7477XZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B850C4AF1D;
	Tue, 18 Jun 2024 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718714589;
	bh=QEw1lVVZFFXX5VT3x5lAacBYDpevRca1ieNXuJOWCEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7477XZ6UHGQQSVGcJBeXWVjVQOmTy3bggb4cwY1Z5CzGfFyeuJJiTI59qAsEP9zY
	 gMpMNibaz2GdBM11XcLD7e1FjA/iS/ab8e5CN+7jLDoPI9R0bMcZukzx7Y3qSkWeAv
	 EueHMfEX6/OuBq7hDCOO+IOxg9tiESr30Vvxwo2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Shi <alex.shi@linux.alibaba.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 004/770] nfsd/nfs3: remove unused macro nfsd3_fhandleres
Date: Tue, 18 Jun 2024 14:27:37 +0200
Message-ID: <20240618123407.459902824@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
References: <20240618123407.280171066@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Shi <alex.shi@linux.alibaba.com>

[ Upstream commit 71fd721839a74d945c242299f6be29a246fc2131 ]

The macro is unused, remove it to tame gcc warning:
fs/nfsd/nfs3proc.c:702:0: warning: macro "nfsd3_fhandleres" is not used
[-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs3proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 981a4e4c9a3cf..eba84417406ca 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -694,7 +694,6 @@ nfsd3_proc_commit(struct svc_rqst *rqstp)
 #define nfsd3_mkdirargs			nfsd3_createargs
 #define nfsd3_readdirplusargs		nfsd3_readdirargs
 #define nfsd3_fhandleargs		nfsd_fhandle
-#define nfsd3_fhandleres		nfsd3_attrstat
 #define nfsd3_attrstatres		nfsd3_attrstat
 #define nfsd3_wccstatres		nfsd3_attrstat
 #define nfsd3_createres			nfsd3_diropres
-- 
2.43.0




