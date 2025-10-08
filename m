Return-Path: <linux-nfs+bounces-15070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EBABC68C8
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Oct 2025 22:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42433BE526
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Oct 2025 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB301E9915;
	Wed,  8 Oct 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVOkAxlO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77311C8630
	for <linux-nfs@vger.kernel.org>; Wed,  8 Oct 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954432; cv=none; b=O8ETCbIgn4J0cmeWkkVh0xSSDYKhccqjsqHwtGeHKLAmiUCgBZfoiOO+OHGksWns+HYEr8nJMq9slJdI9AZpC4OfZiLJwkTVgzpEmVXuf4gF13d6uflDD34Sz+uzTnWpxUe9P/mzyzYRNrXcmEWklQThp1duWwFYKroUfqU5Jns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954432; c=relaxed/simple;
	bh=m8ooDH4npDB9n/vw9oa38r4Yk02lgjhCt1P/1hbDAtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgLIZcjx3O3aMQUJp6iqdEMDDUkSUit+UJ8+UbsUm7aNDXMZLXp6MyJOaHv0xsZUiNGJlA+vLlGIjbFjDuGBk2kyqr0vsgetafo4f29r5ger9ok02pGcaU3DSof2mxkzZCoOiPK7YoTaIJdIp3pVjIsVOX5Sp/GX24V+GVYvMRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVOkAxlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2E5C4CEF9;
	Wed,  8 Oct 2025 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759954432;
	bh=m8ooDH4npDB9n/vw9oa38r4Yk02lgjhCt1P/1hbDAtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sVOkAxlOyk+k7tmFg93WbpFseH8g/EN44tgEsSA842Bmsh6EbF6sMwRv0uAS2WTP4
	 lrAHU5nKiPEofUOtEP3CODLjrkTJ9YaUZRkAKuldEwwoghhU8hrs17XRteV62koHXh
	 nIb5LE91yAp4kcpKOz7eXVBhiS7xjU2H1M2DWqR8QaE11YSXq7q8PQtFFlI/sVLPPU
	 +p62PttOREB2m5A4Yq++GAdJZeSLo1vDbf0x5Q6y2t5Ch7AMhMKHg9rbaoUjP6LMxP
	 dWRVyQI3HzD7wpX5sf6jHzJDGy2RN+pB/sS6i3DZDTdkJVTNgRtsv6CTdlZW3WBl3g
	 gvKADpIZGQejQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 08 Oct 2025 16:13:43 -0400
Subject: [PATCH 2/2] nfsdctl: disable v4.0 by default
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-master-v1-2-c879be4973c8@kernel.org>
References: <20251008-master-v1-0-c879be4973c8@kernel.org>
In-Reply-To: <20251008-master-v1-0-c879be4973c8@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=687; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=m8ooDH4npDB9n/vw9oa38r4Yk02lgjhCt1P/1hbDAtU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo5sX+X5JCrpXPbHiJhvmud/0vFG0yOhGMXnidp
 5mLPzrTEUyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaObF/gAKCRAADmhBGVaC
 FUcJD/9xDb0LwvmM59ibWQxQQZYJLg9CnYJd8JOSm1zqe+hRK+qYFgF+2Sco47ATIJ0Beomu/UP
 HXf2uegOeqUuDAflZJiCU6/je3ec/Pg3s4USoXkcqeyhUJ5eKG5+DRVgDm3bE+Tn8xU7QgvE/iq
 aQa1W1VqkBDCZS70ld3Aams/QnJSIoV4Po3EnQ/t6avE9u4SDq9Mm3CeOl2Xj1e+gZkryRJyGJZ
 9L5jaQkmkWCffiNrfD73UvpI6TMHbsdDcNRKdiDwhzBZegohpve0UxRYJtDW9zZXj3SGqy5etO7
 oNEn0geA2D0k7jSDYIHKEyTTWUkZz/3bTSdXGv42ntp3/i7tInr0Sn95FpPoqkuhDyOCO6F6aEv
 5iSJ1XdJT0N5TDm0D9eMtuWL0hdaD3yp8blwC3CoactGhMcmCZhKMtQ0aDxcwWJ5gcEDMO/cKpz
 DnNSgcy5m77t1uJk1ZLYKQfuOMjhpPDQfT4NMS7VwwOj+fi79kAAlm5JtjwKD6walpRW+bKDC73
 0ZuMTWMCaC4wuYXkzZG+LTF+KwS31nAVWAUc/wsc8jZnq3w6VX0IcTC1s2hSZPgemx4xDYtndUz
 vqe4+NZCR1TEZ5kgmF44sZr/qqyiUD2Kx4FsmsJQ/3nlNZLRMov/Ic85u2Rk9Ocnv2eImF5EpcE
 B1ft7FF2wQsr5Mg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 utils/nfsdctl/nfsdctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index e7a0e12495277d2e98a6c21c7cee29fe459f37cc..87320edd45d4a0066c0b88ea6d7c17bce783e39f 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1474,7 +1474,7 @@ static int configure_versions(void)
 	 * First apply the default versX.Y settings from nfs.conf.
 	 */
 	update_nfsd_version(3, 0, true);
-	update_nfsd_version(4, 0, true);
+	update_nfsd_version(4, 0, false);
 	update_nfsd_version(4, 1, true);
 	update_nfsd_version(4, 2, true);
 

-- 
2.51.0


