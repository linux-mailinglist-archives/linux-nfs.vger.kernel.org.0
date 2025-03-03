Return-Path: <linux-nfs+bounces-10424-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE089A4CA0A
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34AF178894
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Mar 2025 17:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864023FC4E;
	Mon,  3 Mar 2025 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y64vweQ9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B023FC41;
	Mon,  3 Mar 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022778; cv=none; b=fWaAFUK/DS+LfxNAgz1IcCpud8pDKue7xU0m8FJG4Ox314+e6BukuvGTZYsbksNt86bWUamerEaqhRColU80X3P1+p+7NRhtL7dpsBLO8Uq5YOGlkGvDos5pJoh7ZWeuIdbQ7EpWUyu0CkAMqiklVXTylDZOHgPSYh6RtMIVlcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022778; c=relaxed/simple;
	bh=ligIRskMGI2mV0cB3fQGOC9rdkD5pCR+/sRa7O/I+mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZimIUtUPKqjCve0LYLEVz9ZF3V56oSEl6fiiVxIb8RVZR+LuIXVIGqEmxFrGzKDsKWkyyjmrZYDWi26f+y+IwAYwvOiFoMpwVyef4lEHMs10fnLcXHMVD0YdzraUXzCTEKTuLgCU2yBUWGHatm61DMtckva8CVlFANDMt26v9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y64vweQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F4AC4CEED;
	Mon,  3 Mar 2025 17:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741022777;
	bh=ligIRskMGI2mV0cB3fQGOC9rdkD5pCR+/sRa7O/I+mw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y64vweQ9292qpLCUMqoQHwGmp/9RDoz5DVIg8T2qg7wrSzWhV/RILm4N2xCSC0peJ
	 gxmxBw8PRSKW07/tK7pn15vmqr0bhoQdqZJbvd0OqhyPbgQCa3c4ArcC+uGIIkJzWU
	 DD1Lk/k2RFcSmWUJDPE6YaT97bpLsx6pYMCse7UTt8yrN+axeOHNnomc1nCKOj1zJD
	 g2ijZn0jWXQh0uoBoNEL9YGfeC4ImPRIlpp1HbNZiW8ML0GoS9fMzSc5PtYdMojPUY
	 dShlUmDf1eW2TcDZfGlTTzxZabnCUQk5KGHuHruiZ5nRA0D3C5gfG+a58rxNSyf+zh
	 DC6jLY9Ewm2XA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 03 Mar 2025 12:26:01 -0500
Subject: [PATCH 3/5] nfsd: remove obsolete comment from nfs4_alloc_stid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-nfsd-cleanup-v1-3-14068e8f59c5@kernel.org>
References: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
In-Reply-To: <20250303-nfsd-cleanup-v1-0-14068e8f59c5@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ligIRskMGI2mV0cB3fQGOC9rdkD5pCR+/sRa7O/I+mw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnxeY1HutDQSlAnbxV16/ZyBkhuB9knC0rcD7hE
 66FVpRyANiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ8XmNQAKCRAADmhBGVaC
 FYNzEACPaIIuStNWQbooMdPCkNFqqsgi02PbpU3RhvYL/OWDZeOqKQNz/zXeyVkGktc2KJhXHYa
 6l49mND3sgtSPkrnLedQLxNqtaByZFPS/2ww+Sc9q/PpJ5CBgFDCkyI5puXWIC7i5eK8+7mZMWf
 PDdy6lvycVZS23HEbtuLHH8tKnXwaJnghLnwApEEGRaHboS+FrvDpDqRmID8BAdi7DRDpc9npKw
 Ehc81xIVc88XMYXatla6jzwcWjhXMKHQ7yRFAQjBdWUVI7vrN/kMO+L+VJf82zcNbWwJO1rfCzw
 Z/+HObpQMLR+1BH6bJRBs/LqjXlWnj+vx5TX8CT9SRSL/NDhXKmLjp/TltDhaG8v3MksYgtmFp5
 220B5WBsBIO+8BUYbeoJdLlu0APcwBw5x6n8++webELRb/OGO7orZzb2TiTw5B5qxMS9trnu2F1
 2AaswMWR0EUhA4fmjvBb6YkH/1OsvdwAxhSIuhM2IcQlFrKPhoFBpURTG2cn/8sdkKAYtm+BxvH
 Sa0e+S4OJHvpwTBcvKHdFjppFSAM8vXNQas2mDb6meVXQoUmgtlXxqy0RS4AZnAREOSSiP4XCIs
 WwK/LdSlCMRnDu+JyCpdfqbfvatzbLHcltoOxntHc7vRbBvwCP5gmGGbzravgm/J90+S7FjsPiL
 hJG1Dlma23WPKpA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

idr_alloc_cyclic() is what guarantees that now, not this long-gone trick.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e245c479ef271b6d6b20bcaf468f6de40d62ee00..a7bac93445e2fdbe743b77e66238d652094907cb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -946,15 +946,6 @@ struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *sla
 	spin_lock_init(&stid->sc_lock);
 	INIT_LIST_HEAD(&stid->sc_cp_list);
 
-	/*
-	 * It shouldn't be a problem to reuse an opaque stateid value.
-	 * I don't think it is for 4.1.  But with 4.0 I worry that, for
-	 * example, a stray write retransmission could be accepted by
-	 * the server when it should have been rejected.  Therefore,
-	 * adopt a trick from the sctp code to attempt to maximize the
-	 * amount of time until an id is reused, by ensuring they always
-	 * "increase" (mod INT_MAX):
-	 */
 	return stid;
 out_free:
 	kmem_cache_free(slab, stid);

-- 
2.48.1


