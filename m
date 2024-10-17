Return-Path: <linux-nfs+bounces-7239-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0CE9A2602
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26C91C21072
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Oct 2024 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D7B1DE8A4;
	Thu, 17 Oct 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUoACcnL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BCB1BFE18
	for <linux-nfs@vger.kernel.org>; Thu, 17 Oct 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729177443; cv=none; b=VtO53Vz1SD5gPBxzvVx2vOHX5foln8F+m8fnKXua4P5/bZMUTq8zxXUfrm8TlUd9Tdi3xK2mbsWmN7OZEUysUhTWzTTnIqW8m71x6KsRQbjMhU/u+sE0CNr2mCfQPxGZ9b+bp3COyoLBKoMmfMX8945oo5M5hyE4KomD2fHqYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729177443; c=relaxed/simple;
	bh=vrhZHDQyud4VCBRJ5vZdNisTRlYabXhblzcG+/VoCOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoFwIemd5oVCjV8w7i8Cs0m6pGcPcnTpmHSgWUWPPUH4iIS98E49bSBGO48xP7orjJXu1zsLYec9seppMMV+Lvvp4slZ2YDe7XZdHHoBVSARmIhw8fLPvrnrbPkku9REPt1O2HV9LkJbd+KKOgxsXBr9W8gY08oZSLpTS7lTMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUoACcnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49111C4CECD;
	Thu, 17 Oct 2024 15:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729177442;
	bh=vrhZHDQyud4VCBRJ5vZdNisTRlYabXhblzcG+/VoCOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUoACcnL1gtgODZ5Qvu5UkLV0U48TeW6UdONxcRzKuVKCd6UAgyWvtvngh5fGbQjU
	 1v1qlWeh6Uf2RyP05wGAKPNokgBfNCBloiWPP5kpEEijYvvZo4KD/JYA2RILsVPDC+
	 7v/wPsX2Bk5rvaogcpEY6yJ2w4ifbsx1hixTZsKJEWo48T1oiEgb0mx/oD/WyGB4Yd
	 2op5CyOvKVHcmVR2XbcBaVok0Htx5vEfTeqOb+ggER4Z+3UkMuIVJ8alikIdvPY6KO
	 bM9gJeSNvPdCFWnuR3XlhbpZ2ZmGEIBP8c+wu4T8PKUsMtRqssxwStFDUKV7XJnrCs
	 PezESDLzvyXVA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/6] NFSD: Remove unused results in nfsd4_encode_pathname4()
Date: Thu, 17 Oct 2024 11:03:54 -0400
Message-ID: <20241017150349.216096-12-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017150349.216096-8-cel@kernel.org>
References: <20241017150349.216096-8-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1686; i=chuck.lever@oracle.com; h=from:subject; bh=CxtjWK1DblEC+SxiE8+kgNZWMWN3G7lFrYgWh8x1x3A=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnESdbCcjrjCeLzHnTya8+Tfm/mPVqrcKx8NRX2 g4XIBwvyGSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZxEnWwAKCRAzarMzb2Z/ lzP8EACMitgqwOrTnmGuKugfuN8KnV7lqNZHyp/fMPc6yV5KnNmo3RF0JHv0k0pbACO8306gxFj /G7ia7+gNb8eAy8i1DZkIvF2fN0pvdO/1mSApBnkyLT1FSC+dtIVpOQvRm5o2SH9dlvGp3YWqTs n7yOdOtx1Bn6Wmv80CC0cZBh6AxdEArORjns0oRbORV3jEvDJpC93pOhG94osGu1Gm5sUWbbTvv ZyC9krDQqlhekaOrAH1dsHTtMw3Bo6Ur+WRfxalf/+pd1ji34ir5jQjvxOpZie0B6ekvLoNQhg/ MZhJvZFmKJaLDf/FVl+8FVJ1dsB/n/DxWpi9gRQdWcLRkxeRYmIhpgfJ2eSk399zP5K+YqcVnQe 6rI2wHoAIkPYZuFFU2+4IjrAe09UbnNBxV5yl2QUvGsyuNZcXQAOyjl0LsvEQa/GUWLEESDrO73 as8gsntGmcR9wOnshh+RYZrehJuUMlis/QnPS3v2EzXCo2XXJXDrI6k4hcSp6hfwoKEiT7SV2/B i77ykkCAks0tDkNQ4RW2PiUdVmYQqlW/oc+0QFqlB6wkP3/LcJLMi/mYSH2nbMp5NE3VAva0uWe qp/jLbHbyPB0mBURcB27nWDvDwdD98TBkrXCh+tlHDglMeWHk+QCjYuri+CXTJaQLbo0/gjAtD0 KFwLUvUiq8eG1Wg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up. The result of "*p++" is saved, but is not used before it
is overwritten. The result of xdr_encode_opaque() is saved each
time through the loop but is never used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ff897a368c01..6633fa06bc91 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2720,7 +2720,6 @@ static __be32 nfsd4_encode_pathname4(struct xdr_stream *xdr,
 				     const struct path *path)
 {
 	struct path cur = *path;
-	__be32 *p;
 	struct dentry **components = NULL;
 	unsigned int ncomponents = 0;
 	__be32 err = nfserr_jukebox;
@@ -2751,24 +2750,19 @@ static __be32 nfsd4_encode_pathname4(struct xdr_stream *xdr,
 		components[ncomponents++] = cur.dentry;
 		cur.dentry = dget_parent(cur.dentry);
 	}
-	err = nfserr_resource;
-	p = xdr_reserve_space(xdr, 4);
-	if (!p)
-		goto out_free;
-	*p++ = cpu_to_be32(ncomponents);
 
+	err = nfserr_resource;
+	if (xdr_stream_encode_u32(xdr, ncomponents) != XDR_UNIT)
+		goto out_free;
 	while (ncomponents) {
 		struct dentry *dentry = components[ncomponents - 1];
-		unsigned int len;
 
 		spin_lock(&dentry->d_lock);
-		len = dentry->d_name.len;
-		p = xdr_reserve_space(xdr, len + 4);
-		if (!p) {
+		if (xdr_stream_encode_opaque(xdr, dentry->d_name.name,
+					     dentry->d_name.len) < 0) {
 			spin_unlock(&dentry->d_lock);
 			goto out_free;
 		}
-		p = xdr_encode_opaque(p, dentry->d_name.name, len);
 		dprintk("/%pd", dentry);
 		spin_unlock(&dentry->d_lock);
 		dput(dentry);
-- 
2.46.2


