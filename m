Return-Path: <linux-nfs+bounces-7532-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1749B3373
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 15:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4D91F2507B
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 14:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DD31DDA34;
	Mon, 28 Oct 2024 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYnA9gSp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDEE1DDA20;
	Mon, 28 Oct 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125596; cv=none; b=hDOl9imbciGHt/S7wiGZva+DMSl4Gb29gjc5NM5JUsj7jcboTGGB6Y4+HWDcvAC6GoaPft5/ftSFVcTafeUBnEhWvQPwIbSHnJzBq2YNzIwEwF5flI4cmUylV7f3S/WiFpQTiAkbWc4x6T018GD5qhiAZmwCBy8eUFTWt3qJnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125596; c=relaxed/simple;
	bh=p4VGMc8h2qr9R0nDq8FcMQDQE1A2vctuSCvyEbI+Bp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O6+s/kufoqMKQpM5imrnISfgOgVUTuZLzBIx2qrXawHuF0QoDgQyDWdtf3uc/xgEM52poOii8qLkV6XbzI5GduPvvgcJc5LgXejXDUwvnOijPVWdAFSSmpHIgeF4Iz0s1MrIA+2aKMpnmI29NHziVPhqcmCvMUrySGN4WpTsGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYnA9gSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3F0C4CEE4;
	Mon, 28 Oct 2024 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125596;
	bh=p4VGMc8h2qr9R0nDq8FcMQDQE1A2vctuSCvyEbI+Bp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cYnA9gSp8kJ2BMK4mvKNUy1N1S7jo2X9xuKfi8N5MJNevd4SOvusV2Un5EkHK1NrO
	 OjBxqYiPUNkMjhwLqQwlCKHEZNQnXz6KAjCmKdNbRjOcUxeFXrGRs325hS+sg6x2ZA
	 1gsjxxlTgJcjYdvRi0OaqajtcZNQxBuwCP48s8eORKB++5NlmuLiJjYVhU0snZBQh2
	 RJ6s4Db7TUwBm8X+Cb0MMzpOac8zSVJ+hL27HRyuKgdf9F0UpiQFrv8iN+RGcuVnmh
	 bO7UnuAzxczcywlXX4MZPd4bfbdEj4lRvVsjMS+nPhl2E3thmPViAl1Y+/6hzTUPJC
	 EBN1StrzgnWag==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 28 Oct 2024 10:26:26 -0400
Subject: [PATCH 1/2] nfsd: remove nfsd4_session->se_bchannel
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-bcwide-v1-1-0e75a8219dc0@kernel.org>
References: <20241028-bcwide-v1-0-0e75a8219dc0@kernel.org>
In-Reply-To: <20241028-bcwide-v1-0-0e75a8219dc0@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=p4VGMc8h2qr9R0nDq8FcMQDQE1A2vctuSCvyEbI+Bp8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnH58ajWce8Brs7dSd1s/ZG9UQf8oyBFQxsjDn+
 tKRfOWqVnOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZx+fGgAKCRAADmhBGVaC
 Fd3KEACGyHyaE3hJ5vtDjqok95VzXD9f5BstTjsgNg0gMu//4S1sSsgwJEUYmD2K5d6rIp5C1ap
 salAB4JgiywSDw+H1yHf4XZ7K1XSeI3XNJHdBsllanSSOyjX5wZLzQhO2t1hRLhWNkgVm34NXZS
 wD97NTQzWU4Fjkf34zRkUG+ybIzObVUtux4CTjeTTow9fdVUWV5ZcvhCvulfAqr83+swOnYEx4G
 ompZDls/PDcE5Zn54qfADAbcZLDmyfeXM9XjEkJ9HkM6ljqhhRZZgVCEuSfA5TjMffJ5n81IXzq
 WIejWuTDrr+cTz8qcJf9atZHOCmvPoSH7nIMx7sF3z5RfyjSSz96cLuh7t4fH7RpbrJolJZOjML
 n1SXK9b3DETvpXj/ikFmUNDB0jsUqQlL7pklwGKeLoUhLZRhTJxdahU5EiYM55+KM28tiltBVZ+
 cgJzsXpeWF3aSr9vdVd2LoOCJJtlqxI1gwS+78KrYUjId8sqWVls6sGssK+/110TXcIlvYRQZTf
 39Gnt5AJVZqnUlh0Y/xt5KhiCnlXzwuyJ9aEmbN7G2EkP5xoAV7dnOHjwY+ey/W72jEJ4kpkqNd
 11+Xpi2PEdDHbgz5umZSSRL52zGLbwinpbS1eXGaM921NRjkNFznNz6KOvOrfdxs2TiKrEb7lXx
 MwAcB/ZemkD92rw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This field is written and is never consulted again. Remove it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 2 --
 fs/nfsd/state.h     | 1 -
 2 files changed, 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index cbde4da967d8521d90ee0614335d5b1a2adc2352..5b718b349396f1aecd0ad4c63b2f43342841bbd4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2002,8 +2002,6 @@ static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *fattrs,
 	}
 
 	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
-	memcpy(&new->se_bchannel, battrs, sizeof(struct nfsd4_channel_attrs));
-
 	return new;
 out_free:
 	while (i--)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index cc00d6b64b88f0bde30c2a372540f6c243c06d23..41cda86fea1f6166a0fd0215d3d458c93ced3e6a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -322,7 +322,6 @@ struct nfsd4_session {
 	struct nfs4_client	*se_client;
 	struct nfs4_sessionid	se_sessionid;
 	struct nfsd4_channel_attrs se_fchannel;
-	struct nfsd4_channel_attrs se_bchannel;
 	struct nfsd4_cb_sec	se_cb_sec;
 	struct list_head	se_conns;
 	u32			se_cb_prog;

-- 
2.47.0


