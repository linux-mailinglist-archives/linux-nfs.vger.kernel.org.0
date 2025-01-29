Return-Path: <linux-nfs+bounces-9774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E83A226DD
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 00:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B48F18875FD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E31E990E;
	Wed, 29 Jan 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK8XqOna"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E41E9904;
	Wed, 29 Jan 2025 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192859; cv=none; b=Pt1ZLsZxStvn9Fh2RHhVeBd/4NmsMGikE8cjXmQDNV49StOeKy2+Xt21ubO2R7ONA7qaKmHVdnzHfQfY90IwOZG/WCCVklIknplPMW3I9389Tjsb/l4I7j0kY5/qz75IoUuIpj+6oVFjqjUFNoaxVOw7fXsqujiwXFm22OwOVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192859; c=relaxed/simple;
	bh=KLezOvtJaSEl8tcY+wBxmhbYNw75f3c7qDVJYdTgOrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZbAe9K1GgbqdjDTLIQJ19NaDwpjo3g7wbckUAGimc1AZWSPiCGyRWjh6CBricU66/iVekkQMVB7FN3+qYQJKmddG/p+qz+peNKWlOmXMoYm0qvWxLJFLyH9dvRDo257+CHQqqNobKNVXDa5ZeMYWvAlF2iG7ikAzI5jE5r/6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK8XqOna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB2FC4CEE7;
	Wed, 29 Jan 2025 23:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738192858;
	bh=KLezOvtJaSEl8tcY+wBxmhbYNw75f3c7qDVJYdTgOrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hK8XqOnaV2z8TV0lR03BzO41BXnfKInPKdVpxqGKNqOMkUw0DA75gDh8vEyPIqqWG
	 UXf57GzoJtwWtrBhd7v6+CP9Z3B76UXPa/PDN9Fp9K+yz0AEzEtDzbUAz6b2OIdYEl
	 oE2PFJvHGNfA6988N0DUGv2YxcEjNaPDcld5j+LYEYWbOKiZvzDCpOuLjZpP3ICHFL
	 aiWcem7bJc+ci7vKVBelLv1/8xRn28zynhlDU8NXk5ujqd3p0/MSiwW4rozcwHgyOu
	 N1K7cwEiikYZW6EL8elWRwCwyA43sSyV1Ts1QcAMx5wxvaW0gNiaMn0ul9JQ5zXarp
	 bm1+pfyhoKLgA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 29 Jan 2025 18:20:45 -0500
Subject: [PATCH v3 5/6] nfsd: remove unneeded forward declaration of
 nfsd4_mark_cb_fault()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-nfsd-6-14-v3-5-506e71e39e6b@kernel.org>
References: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
In-Reply-To: <20250129-nfsd-6-14-v3-0-506e71e39e6b@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=613; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KLezOvtJaSEl8tcY+wBxmhbYNw75f3c7qDVJYdTgOrQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnmrfUkAiR05FUARY271IxLnDvsNCkLPEDdxPsb
 ZElzD+DaD+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ5q31AAKCRAADmhBGVaC
 FYPcD/4mpgQyet/q4HeP5RLpmvw6VAxHIy14AxUu4Uj4sAM6ed6jJmDoE/3WHS8BTGEBRTFSxvJ
 ShRy0dDO+eWtLKpFCiyNulrwwxaMLVj/3dgUqW0EiBJIuhlymPsw6fvxSJgkhyeEx39YCe1I5cw
 kNH6hdFB263DAyUFtBAN3zMsOZmA/EUtocQanNhzPUULe6vdZHhZ1zazKCLNf5FQnl0pcbLRmFo
 oZ6+u9Epkt94CjT7oZf/GTxq+/QgZZ8NEDctBuhCZlBzqCMRW1sSUlm7C1x3aneJKoSjdDetuzv
 cNag4riAEQlT3mYfTAp2mp8Nie2BPqkQEEi8CzHf2a9lT8XPD56u9XE9GGGwM71pgzbG7J3g8nS
 J5yVLdPzHGlvGJQ0j8XV5g16HWntijL6tCdBPc5DQ9ld4GGQINkN2aNMFsmAQ65y0zTb3/dtmQ6
 2bd5zf/CT0O9COxRvFLEL8+rSwjNhhQUD9undfRIiUCZWnIIQyxX7DEnCFD5JML5O78qtcvb39B
 7NZfGIVMuD37cWE39b2FDh26I+LwOaXF0BNcls2S8GsIsb985y92PObmXN1+uyC7ZQLLJlIDpwu
 ZizAKlXA8heUJ7XMjYYDEUpVYv7h/tvLpdb/JddOTTkJV0qki9OLBc9XHx2NZHhYGfgKn4g1OiJ
 cRO0pKgsymanNNA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This isn't needed.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 109e8f872eaf2227ee30a1df3df86ab1ad88c384..c8834454bcc7b5044de42ec8622653a44dbb0812 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -45,9 +45,6 @@
 #include "nfs4xdr_gen.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
-
-static void nfsd4_mark_cb_fault(struct nfs4_client *clp);
-
 #define NFSPROC4_CB_NULL 0
 #define NFSPROC4_CB_COMPOUND 1
 

-- 
2.48.1


