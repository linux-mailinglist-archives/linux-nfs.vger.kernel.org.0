Return-Path: <linux-nfs+bounces-7241-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B89A2604
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 17:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8384F1F25F72
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8641DE4D8;
	Thu, 17 Oct 2024 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePMTC+1B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A231BFE18
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177445; cv=none; b=lCL6PZov+dEfqDX4Z+lYsuhXBjOk++50rqSVeKlpoBgpPvI1IvtjrcrLT6PNM3+GFcJ3ZcvXvzWNcOfnwIYmxl2FzpuGcvq3J6AGDeW11z7pMD9GDJUwsNZJzgG7Jd4LkGS2Eebk+BWsmpJ6aem6YEIDDhbrhkUcYO34OOYUA0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177445; c=relaxed/simple;
	bh=dS1Tu/sC6dRXFOkz4tYFtIN4FQBV3436rhwTvzdFNNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRenbsnyLy8bRVz48NG5zMvpgsftXuV8JY1CPY5gIfomHf4m4CMwvfN1iRTTmP4hny33Gql+/8UvVjNdiHGnTj46QG3inziFH8t5S0zem90ZlFq3Qpu/YLHAOmbFd3QjhS9ZN4K+lghg5prOcCp5DKDt9AmgxibGE4yXMoGJgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePMTC+1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11128C4CEC3;
	Thu, 17 Oct 2024 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177444;
	bh=dS1Tu/sC6dRXFOkz4tYFtIN4FQBV3436rhwTvzdFNNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePMTC+1B6D1gXMvfAKJ5FNPz5qd7luDk9FvUZpFSjMD14wfhpzpKN71ZWXou2EGAX
	 EvsZlTiZzIzZ2Y8VlwM7f+DVCTjjDLOgZaRErFQGJRBXWpiKK+fHZpiIT6PS2NgRJ+
	 8o5TB4X4UexNY8S1XNMpOiSXHObh4U4MzeEKQ0VkqkdQccZfqHx9rpiypoBFhl+6tg
	 NKUDu4Eb3A7dUU3eHq6Y/BoqstgKPFWEcInGDMMcRZSIOjTu0hX7o611KAf1FqhU/F
	 eJyXHkgJhg+cb3iALAOH1Sv1Vx4PH/VhDUeqawXG/atPU+7QubuK17OptPG7tO597/
	 C8Q8VRooKmv+g==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 6/6] NFSD: Cap the number of bytes copied by nfs4_reset_recoverydir()
Date: Thu, 17 Oct 2024 11:03:56 -0400
Message-ID: <20241017150349.216096-14-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017150349.216096-8-cel@kernel.org>
References: <20241017150349.216096-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=755; i=chuck.lever@oracle.com; h=from:subject; bh=rX5d4jWyedyE07RaWCkcii2QPArsQrZ8xrqRtPEaTlI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnESdcTZhtogTD4MVBbuFY/42pvGBSEp4Pj59x7 WEM0bhu5wKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxEnXAAKCRAzarMzb2Z/ l1qQD/44sQQG9QvFQ5n1c5rfE3Z7BsPpuaVXuWPQ49hI0lBRo79RvRHR5D/QT5oKoLE5Rn9FF0A 9hQXm1Fhp/EFGM5wyzQ5134y3OX+MWsV8FpeIX5rnibFyJUq9wOUO0yy97yS6o2tcnWSIaAWq14 6umMpqWadifTxMOblsaZcZXUrWdYU5AeVXmfs1svjYfIEFOWwH4tAGdMsSGvEkNd6mXDjhXC1kq rQPgnJ1uWvd+8aeM2vc/9q6twS5xjAGCPXcW6ICtMfRCmXm9wHCdArflpDovKCcK026nqEnjjAI pmlny2Pk/vQyjQlG3/gXy109odooRXL7tEd4bWDIC9PvG86TK0lxopDXYk56POc+RZwCkr1H/kI po/zFiKVVn/6pWnbafpEgK2p4MiwP+TWPbrzYWAjxtkvvs87piu9u3BUJ715Z1t5SAInxNZ/2v/ BlGMwzOVQ4rS6rwrrNL+DX5kYiALIh/KSTFzzDxa4n80selDNFJB1zfDwCs6OUG3yVimiOHopL1 tKDv6S0Mhihh1IdkUm2sUmDOoiC5Qy6vIQYgGr65fFiKCGuB3RdYfbUU0w7DSXoVgId8m9t7CIM MvkGzJjdCCHmmJMmNEeKQofyYy7rIjAWYbHnOY1rWu7whLP7pIV6HszFHgTt128u13SuEFNg42r YO5E0+yCWC0xJtQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

It's only current caller already length-checks the string, but let's
be safe.

Fixes: 0964a3d3f1aa ("[PATCH] knfsd: nfsd4 reboot dirname fix")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4recover.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index b7d61eb8afe9..4a765555bf84 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -659,7 +659,8 @@ nfs4_reset_recoverydir(char *recdir)
 		return status;
 	status = -ENOTDIR;
 	if (d_is_dir(path.dentry)) {
-		strcpy(user_recovery_dirname, recdir);
+		strscpy(user_recovery_dirname, recdir,
+			sizeof(user_recovery_dirname));
 		status = 0;
 	}
 	path_put(&path);
-- 
2.46.2


