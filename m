Return-Path: <linux-nfs+bounces-12457-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 324FFAD95EA
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 22:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA4B17AC7C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423223D28A;
	Fri, 13 Jun 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsK6VlUM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2622DF9E
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749845281; cv=none; b=r8Aq85B/ddEJJ+6C6afXZP0GBTCfVa4q8HNHTTk29aSjy8ALiGdk5VyEmavc4nsTEfRu62laOgNJIYhW9y/fTO/5Qv/CJxfczmJiTMotJewdT0Uwf0GX/xp1fE1LO1rMF2UlmMMUwPd45WIfLMnXA+slcQsYXoPDAnji2TQYHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749845281; c=relaxed/simple;
	bh=Y206APWtJ9cy36p7YEHCx6o4jkm/13SWxJ1TBAbqjvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZKxHrhiw2j8yb0fZ1h9Bgg/RQXGmdrINTYOfSbTrr69jcIpBQTnwrHWpgJKexDIb1XpE9MJXcSON7pdEUv/tGufnFFgsC/PbMaNKlp9Kxl77Hh2siLCkXy5Xu5PDpSP/+8ELGdtTtQ98kIkEcuXE/ZOexA7qx+9aRsiWtTh33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsK6VlUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED1DC4CEEB;
	Fri, 13 Jun 2025 20:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749845281;
	bh=Y206APWtJ9cy36p7YEHCx6o4jkm/13SWxJ1TBAbqjvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VsK6VlUMbbgw2EAIzIntFai+JZ5cfXvyCFN6cHreLI0LPx462MzBTwHQtxxeIUbET
	 EOgBdL5SP4FttHy3SEBTiJNlwfBiyAIuNjT5Kej/ShBkkvSc9OBesFjuvAeIe2Uz3j
	 4jzfR0qBISJWg8F7LXKr+vQ4OuuTV18AdlxXEgGq43PFYQNBguCiHe1BytmaLI8VQH
	 99RpmANwOBdF+D8kRP3EwFN6bZTJTUAxHZ+jrRUAqd4viCxIHYN1RCcGd7/JfL1eXo
	 TxWPLD2wQRyrdH4p5c5ZWHg98ZrhAmcVHNlcWwCCDYePV7xI4EiUp6q86zrVQ3FsZW
	 VwbiS1hEWAHOg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 5/5] NFSD: Clean up kdoc for nfsd_file_put_local()
Date: Fri, 13 Jun 2025 16:07:47 -0400
Message-ID: <20250613200747.7110-5-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613200747.7110-1-cel@kernel.org>
References: <20250613200747.7110-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Sparse reports that the synopsis of nfsd_file_put_local() does not
match its kdoc comment. Introduced by commit c25a89770d1f
("nfs_localio: change nfsd_file_put_local() to take a pointer to
__rcu pointer").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e108b6c705b4..732abf6b92a5 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -372,7 +372,7 @@ nfsd_file_put(struct nfsd_file *nf)
 
 /**
  * nfsd_file_put_local - put nfsd_file reference and arm nfsd_net_put in caller
- * @nf: nfsd_file of which to put the reference
+ * @pnf: nfsd_file of which to put the reference
  *
  * First save the associated net to return to caller, then put
  * the reference of the nfsd_file.
-- 
2.49.0


