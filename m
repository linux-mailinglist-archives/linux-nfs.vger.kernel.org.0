Return-Path: <linux-nfs+bounces-15593-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CE5C06BFF
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BA8D4F6683
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E36731D36B;
	Fri, 24 Oct 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThGIIE5J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE731C56D
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316996; cv=none; b=tSSrY9XK0mLTu4NAqGeUWcrIvik7XO3QpyufH3Gjc4ZOplJPx7WI29HCa4NAXBh80h03RqJm7F091tJI1fGo47hfmhB6kMnUC+bzJlJOcnbdhI49Xlnyb+oswyK2goEzxl5L82JRZuz1ej67kTYTvfgmxSsntCQtAnDRqRhpAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316996; c=relaxed/simple;
	bh=xengIlVnNPtC9NJpw6B8g1BYZEFAe/PhCWYdgmtBRFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr8QJNNIOkUqmVZIW8HaR7dvbAIlFycwaaxcHwOw7lDbfcriFlZLD1xQVROqH3NoDWFvnP2hR3qO0xzj0vimDQPOKke8lv4fwhN17INPl2beA04V7FmoGbiPBp1I8HJ5DJpG+0RS7Fff6XI0LokkufpUE1ScyBX6fOgu03IzpQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThGIIE5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C4BC4CEF5;
	Fri, 24 Oct 2025 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316995;
	bh=xengIlVnNPtC9NJpw6B8g1BYZEFAe/PhCWYdgmtBRFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThGIIE5JW5DBjP7VZJ7CElMWAktk78nr7RtS8fQNlDEOUrD6JWYGkZLihZsErf2Pj
	 Y1G0GCfK8HifmTWikgmyEKEI909dEC7VyFICrsFiTYlH5+Hr5HJEI5OTVMUfJWeZjy
	 PFsxweVJ+xgT/dDb6Ew7En91Go06dURWr2NXWbwB7l2AYw51F6w/YiWk1yrofJ6Zve
	 z7mq7OLxmHcnEpCqvHcJ4g0sjfkad0aKbBKuoSAk4S8v8RO6oKX1/mzWPDW0TLHYkf
	 46dYVCtLquBbDZfMDFbn67syNCAjrXYYG8lSP5+JCoAzD7B5cIvP++FaxJZ0c4Pm9B
	 IsjvuoJ1TWTIA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 08/14] NFSD: Remove alignment size checking
Date: Fri, 24 Oct 2025 10:43:00 -0400
Message-ID: <20251024144306.35652-9-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024144306.35652-1-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The current set of in-tree file systems do not support alignments
larger than a PAGE, so this check is unnecessary.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b50be92343e3..465d4d091f3d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1270,8 +1270,6 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
 
 	if (unlikely(!nf->nf_dio_mem_align || !dio_blocksize))
 		return false;
-	if (unlikely(dio_blocksize > PAGE_SIZE))
-		return false;
 	if (unlikely(len < dio_blocksize))
 		return false;
 
-- 
2.51.0


