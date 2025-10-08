Return-Path: <linux-nfs+bounces-15048-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBDABC54DC
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 15:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC257188DD9F
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD4D2874F6;
	Wed,  8 Oct 2025 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkDKQnai"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE916F288
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931558; cv=none; b=g3lYjUiIKfnM6iwiaqrgsaYEZhAbkH+uSHZKL7jmnPvGeJV4a4OlW5jHVQKFlm4deif8COlo+HepsD2bPJQ1eJqtiLeBWUG0marKcP0q3dsA1y+FRQ6DN0WY7brUBC2rfOxFosA7sEVv0GJdXB1ZjigazLWZceKFl0LQPrx0KIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931558; c=relaxed/simple;
	bh=dYzPQOvu9HJaBr2NCS5weigu1JDNpQGRi20zW3kgvek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nG8HUC1dmNsHogLdY7epf9vc0jTXIFyZaki3KlqlbF8InFdxIsQGeKdVPKDLOWOCAoeNAm6atrsFoS3q2BxlY/R2YGnavahn36379s5UnwMhXp+endBYEez2mAiPZ8cv7cYVtEqEvA4lfOkqBfZLoQTjcAzYhXtHqjNPdeDjZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkDKQnai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11667C4CEFF;
	Wed,  8 Oct 2025 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759931557;
	bh=dYzPQOvu9HJaBr2NCS5weigu1JDNpQGRi20zW3kgvek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkDKQnaiKa/oeF/o9p3jNFG1rWNVAm7JALxo/EiknWSSww/MXvDQ+e58f60RNiQWJ
	 0iXYGl+X5iwKPtKDC9TtnO+IiuCIG7fm5JYvdXeDH1ZsQqg2jQetqJMowK924X1hRJ
	 uui+tawGMoediC7A4u/pLdKtpc0trnEJdcpz4xGo3sO7y4QQAQTUwIHhlRw+UHGx6I
	 Lc8oS+RuzyqWLhCAHqH6HFPsnc0AF/DkSeEx3JQkpnitRHNWbmxJDtXE17VbBgbCn0
	 q0OJ3gP2E3n3A03nvl4FKHxydZoWUKmj9Ut/9iYra4UpKUNuhuVU6+asK4sdI21dU5
	 OT1lwPwzdfaOg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v6 3/6] NFSD: Recover from vfs_getattr() failure in nfsd_file_get_dio_attrs()
Date: Wed,  8 Oct 2025 09:52:27 -0400
Message-ID: <20251008135230.2629-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008135230.2629-1-cel@kernel.org>
References: <20251008135230.2629-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

A vfs_getattr() failure is rare but not totally impossible. It
typically means nfsd_do_file_acquire() raced with the file system
being shut down. Ensure the nfsd_file is not leaked in this case.

Fixes: d11f6cd1bb4a ("NFSD: filecache: add STATX_DIOALIGN and STATX_DIO_READ_ALIGN support")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a238b6725008..482feb0b55ad 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1198,8 +1198,11 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 			}
 			status = nfserrno(ret);
 			trace_nfsd_file_open(nf, status);
-			if (status == nfs_ok)
+			if (status == nfs_ok) {
 				status = nfsd_file_get_dio_attrs(fhp, nf);
+				if (status != nfs_ok)
+					goto construction_err;
+			}
 		}
 	} else
 		status = nfserr_jukebox;
-- 
2.51.0


