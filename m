Return-Path: <linux-nfs+bounces-16827-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40544C99575
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Dec 2025 23:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2697D4E3662
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Dec 2025 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880FE28640F;
	Mon,  1 Dec 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2npYNd2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567252882D0
	for <linux-nfs@vger.kernel.org>; Mon,  1 Dec 2025 22:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626998; cv=none; b=a7LRdr2pylREHCZVYP/Zgz5FGme3u5fsSQTne+0heWQdY39rDgagcM8XOOm6Ij1WQfFRzKLmsxI9vulQegFpxGO7Q9FbB+aLHIbm1BXogb8syoTT4wBCETXBpbaoztaJaB+06oOSlfDXd9q1DP555uYkslVxoBMQuuwCi1GMh2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626998; c=relaxed/simple;
	bh=BuwSKx1ApxyAgaAodqp1g+S1DHbEzRDtk8nCbKOMDoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KzzoJ9tZ5T0i1+zbJa10eFC85yj8WVAn9jigaIZ62L5YsFLpfbBni7lOOm7j22uvGKhTae1dLwzgOVMkOrA1XPGpG7jNv04U4uWu3nUemghTrxsIDu8IWOXb6LDeNe94sUo+ieZd1A/QV5jtP13NZ9SfGy1hwyH9hMIiNnJszjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2npYNd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF0FC4CEF1;
	Mon,  1 Dec 2025 22:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764626998;
	bh=BuwSKx1ApxyAgaAodqp1g+S1DHbEzRDtk8nCbKOMDoY=;
	h=From:To:Cc:Subject:Date:From;
	b=m2npYNd2Nkh3WDILKbxpTJ0CCy/80yTKogMxpgywX9YKN+2Nsr7/CW5KYKs1D6756
	 VYz3OfQNF5fvnMPUoa47glsx35RaVmJKSVV9mOopodVEo838B2Uh2sabkvctuG9ELu
	 RYQTR8IZA/f2Z1AQyCe8LWpbHDNCDuoOe+WrJwcPShAfhzSpHcX0fchWNUHPgV/6Bc
	 tbedYgNHerO2BtglfGxJsFHmP9aPDilmRncyOBZLLFgP4z1y4sDpGuFaTlFA+r1Dh5
	 xbeu/hHiM/d2pvIUDQ9SWElFl8xxaSZckT5o+S68yEUS/NJy8ebaOS8LJJ4dVVEUdm
	 4bzo9Dk1jg0EA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1] nfsd: fix nfsd_file reference leak in nfsd4_add_rdaccess_to_wrdeleg()
Date: Mon,  1 Dec 2025 17:09:55 -0500
Message-ID: <20251201220955.1949-1-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

nfsd4_add_rdaccess_to_wrdeleg() unconditionally overwrites
fp->fi_fds[O_RDONLY] with a newly acquired nfsd_file. However, if
the file already has a READ open from a previous OPEN operation,
this overwrites the existing pointer without releasing its reference,
orphaning the previous reference.

Additionally, the function originally stored the same nfsd_file
pointer in both fp->fi_fds[O_RDONLY] and fp->fi_rdeleg_file with
only a single reference. When put_deleg_file() runs, it clears
fi_rdeleg_file and calls nfs4_file_put_access() to release the file.

However, nfs4_file_put_access() only releases fi_fds[O_RDONLY] when
the fi_access[O_RDONLY] counter drops to zero. If another READ open
exists on the file, the counter remains elevated and the nfsd_file
reference from the delegation is never released. This potentially
causes open conflicts on that file.

But, on server shutdown, these leaks cause __nfsd_file_cache_purge()
to encounter files with an elevated reference count that cannot be
cleaned up, ultimately triggering a BUG() in kmem_cache_destroy()
because there are still nfsd_file objects allocated in that cache.

Fixes: e7a8ebc305f2 ("NFSD: Offer write deleg for OPEN4_SHARE_ACCESS_WRITE")
X-Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 35004568d43e..11877b96dc4c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1218,8 +1218,10 @@ static void put_deleg_file(struct nfs4_file *fp)
 
 	if (nf)
 		nfsd_file_put(nf);
-	if (rnf)
+	if (rnf) {
+		nfsd_file_put(rnf);
 		nfs4_file_put_access(fp, NFS4_SHARE_ACCESS_READ);
+	}
 }
 
 static void nfsd4_finalize_deleg_timestamps(struct nfs4_delegation *dp, struct file *f)
@@ -6231,10 +6233,14 @@ nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
 		fp = stp->st_stid.sc_file;
 		spin_lock(&fp->fi_lock);
 		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
-		fp = stp->st_stid.sc_file;
-		fp->fi_fds[O_RDONLY] = nf;
-		fp->fi_rdeleg_file = nf;
+		if (!fp->fi_fds[O_RDONLY]) {
+			fp->fi_fds[O_RDONLY] = nf;
+			nf = NULL;
+		}
+		fp->fi_rdeleg_file = nfsd_file_get(fp->fi_fds[O_RDONLY]);
 		spin_unlock(&fp->fi_lock);
+		if (nf)
+			nfsd_file_put(nf);
 	}
 	return true;
 }
-- 
2.52.0


