Return-Path: <linux-nfs+bounces-15939-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DD4C2D44E
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24C334E25D9
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B98D31A54A;
	Mon,  3 Nov 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjLyxvoh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718B3101C2
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188839; cv=none; b=WN4KW8AOc0ymgJ8gFrl9RwhFqu7u6NP7Mf4Rw4YdEif06Cv5vhY/6B3C3+mxKRk2/02zNluHQhAGY19VtStJk3e8NCAOBmOkaOOKv9g3epR7sK6DMSzrbZIoS2zXvjiKEiLU0kwhLmgTm7wUzMJ6Gh5El/+y4Oco5uwUa4WJ3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188839; c=relaxed/simple;
	bh=0BGOG3vt9rZrmia7TsZrcMkXBa/idQS9ZzIQkuAd6Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3F66HaaTYo7BoR1SiUOjsNWHa+l5D+IgFCscuh/de6eUI9VAWjaHLWKJw8v3crXt2UyK7+DlKtUbp0IccBPyt4N/LABGKJYNjkkcBtrazLA5Q5EO8f7l5ePSUoxCypLUAMY7eb/23CDUxFDWARq3zEtoeI0pu+MezgRhwMy6r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjLyxvoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170B4C4CEE7;
	Mon,  3 Nov 2025 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188838;
	bh=0BGOG3vt9rZrmia7TsZrcMkXBa/idQS9ZzIQkuAd6Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qjLyxvohReD7cncJHuLp+F/z6J8qsTzX6TjkK1mbMUybcI88oqAiz2xsEAp8yV8rb
	 8hIh420+f2jaGLaDO/mJHqE6DHtMcfUErCM4Ez5NtSwV7wOdmfFG0HOXxXnPmqqDew
	 4i652vuH3u/vkxWKZF3FSpHTzeo08t7fX/+GWBnD1U7JrAjaCFNSsRM54OjhyHac54
	 lcA+5cK9NVbe/Q9B61JSJIn/uvdo/nRwRayCIbV2EMtjnvpdzkL39JvTiEapVN0T6n
	 BdtKcrM6n8cmupCGhKWpvV1KHulIvILEFN+DuKr4JlE/dDtPt0k4gLLjIn/7QK8OFd
	 Ove4Z6vMhdFYA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v9 05/12] NFSD: Remove alignment size checking
Date: Mon,  3 Nov 2025 11:53:44 -0500
Message-ID: <20251103165351.10261-6-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103165351.10261-1-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Noted that the NFS client's LOCALIO code still retains this check.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 30094d8f489e..80bc105eb0b6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1269,8 +1269,6 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
 
 	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
 		return false;
-	if (unlikely(dio_blocksize > PAGE_SIZE))
-		return false;
 	if (unlikely(len < dio_blocksize))
 		return false;
 
-- 
2.51.0


