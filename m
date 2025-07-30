Return-Path: <linux-nfs+bounces-13325-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A3BB16931
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2183A8FAE
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 23:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902ED156678;
	Wed, 30 Jul 2025 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhYxLfwg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693B1376
	for <linux-nfs@vger.kernel.org>; Wed, 30 Jul 2025 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916726; cv=none; b=C+ff5nj4ILhMoIvx0PEdtcdHcm2XVU6CHR2zHIPVB+MrVgFY2fHLxZJu35WI+q2XbwCHpnAzyBOz5w6O4x/DZ+11GH4b4MPY9ZsFPAAjESPgnEbuOKBSIrCMDzW07OQBIGiLNq3lbQygISDPsMjkxzp6woiKlfsh2tVOzP1wC8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916726; c=relaxed/simple;
	bh=1xmlg5d44oU8mk/pPxylgHhxXO7e0eQpJ0q1x2epsU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufC7ZODWaVZNOm/1g/pR/Esr47w74QVupa3EHxxHSa0SUHu+XH32einxDsYKUSX7k94g3I/yEvh/nH4cua6/qoAs6csnLMtSilhZ/DCFZ9RjCoguI5VL+hWWRhIobdSmVTc+F3S2CUarR4hGJWuO7vG6bw4EOjoA3eTjadPv0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhYxLfwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74B3C4CEE3;
	Wed, 30 Jul 2025 23:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753916725;
	bh=1xmlg5d44oU8mk/pPxylgHhxXO7e0eQpJ0q1x2epsU4=;
	h=From:To:Cc:Subject:Date:From;
	b=DhYxLfwgPBjRLmyhuFzquunrPXwy9rq/F9fP+i5AcGEL+Bkyq0jlBKYHrpV+wlzWY
	 PW2WIYC2blVoELwoPT7ujJ2Xgghx8mR9ADeQY4c6rP/sAN8Fth/0RmJFCJz4PrHy4R
	 wovsrZcnkNJRobnpIrA/mcQgg5L+oazaWBpPXAFDSHU0q3SVVNAhceQl1G0jeT8Hgl
	 I6Tg+UXDTUDFe7UU16wcp/wQknZdK7CstOWg/DEM8YwclnLO94arMXURlnzVhiaK9n
	 hWch4/ql3H6m0wMpOlEDXMBeTztj7Vl1tdW0dab7tcDBXi+mc1fxyEu/sxVskYCItT
	 VjkHfkTU2DxZQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] NFSD DIRECT: add handling for misaligned WRITEs
Date: Wed, 30 Jul 2025 19:05:21 -0400
Message-ID: <20250730230524.84976-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series builds on what has been staged in the nfsd-testing branch.

This code has proven to work well during my testing.  Any suggestions
for further refinement are welcome.

Thanks,
Mike

Mike Snitzer (3):
  NFSD: rename and update nfsd_read_vector_dio trace event to nfsd_analyze_dio
  NFSD: prepare nfsd_vfs_write() to use O_DIRECT on misaligned WRITEs
  NFSD: issue WRITEs using O_DIRECT even if IO is misaligned

 fs/nfsd/trace.h |  37 ++++++----
 fs/nfsd/vfs.c   | 188 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 180 insertions(+), 45 deletions(-)

-- 
2.44.0


