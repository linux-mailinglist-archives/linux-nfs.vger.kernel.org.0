Return-Path: <linux-nfs+bounces-11569-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDA8AAE267
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CA61BC4357
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1A02820AC;
	Wed,  7 May 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgjg0lr3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587112E40E
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626852; cv=none; b=Tw3+nWzpPZFPhLC1GmOlI20uuBJMPJvutJaXX1Z1IgGUoq+ikNwLlQn2klpr9XxNe9yUT0dourzvJQnx1n5AWc+RL9CI4UC0qT4atddprIDdHjVKe8KeOsZ4LZyVW16eJ+1fIz9LBhrO6buIrWFtrN4BMuAbkQQ+LbGuVmU2cnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626852; c=relaxed/simple;
	bh=QiBO1+m4t/dnUMHZsES/SPrMPRULxIFEFi/m0aPXjmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5J/IH0Pu/MsCeRh+UJFtKetlI+AfWpk/4cPyKjuKksrdzdEKQ8dma42ZiPEy/bCKoENoB6RRoTD9nb1ACRG7+LKeAB3/LfF+6MwWq1lPY4a7z8zFI7lxz4nJgaCuPBC2yRcBL1IZzXFabw6qRMDZAbfbFniMKjIaz95Pb0OE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgjg0lr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE30C4CEE2;
	Wed,  7 May 2025 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746626852;
	bh=QiBO1+m4t/dnUMHZsES/SPrMPRULxIFEFi/m0aPXjmc=;
	h=From:To:Cc:Subject:Date:From;
	b=Wgjg0lr3k5PpnUv6b35JX2mJOMMdzwn2B0HFxbpillo2milV/xN4YZJ0TK1Xnz9bO
	 f/VaYi00G+8jI4jTzTyh2aSsxdFIgqmLBb0Yba+5qAxzQ6n9CdaFvKNcUKVcIo4J1T
	 Gx4LL+fckW8x95xJkO6Gm5VmBKMu7iHa46dLwWV62JOMMgFSKPBjHKLPg+fLs+ed20
	 elgiZZWcokLzkCjK5mcIDXEESb5M3oEOp2NNBcpKa63WJe8IQKYcIqG9tVhHcdEC82
	 IjGzbnlRwvEnLT5uzCe+G4dk3ben5L8nFlY7L5up/ubHFty0LFwxlI5IT0H9eQQTJx
	 z5kWxw+SjyXYw==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/4] Remove svc_rqst :: rq_vec
Date: Wed,  7 May 2025 10:07:24 -0400
Message-ID: <20250507140728.6497-1-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I intend to insert these into the series that expands the maximum
r/wsize, once they are reviewed.

Testing has shown no correctness issues, but some unexpected
performance variation that I still need to chase down.

Chuck Lever (4):
  NFSD: Use rqstp->rq_bvec in nfsd_iter_read()
  NFSD: De-duplicate the svc_fill_write_vector() call sites
  NFSD: Use rqstp->rq_bvec in nfsd_iter_write()
  SUNRPC: Remove svc_rqst :: rq_vec

 fs/nfsd/nfs3proc.c         |  5 +---
 fs/nfsd/nfs4proc.c         |  8 ++---
 fs/nfsd/nfsproc.c          |  9 ++----
 fs/nfsd/vfs.c              | 61 +++++++++++++++++++++++++++-----------
 fs/nfsd/vfs.h              | 10 +++----
 include/linux/sunrpc/svc.h |  3 +-
 net/sunrpc/svc.c           | 33 ++++++++++-----------
 7 files changed, 71 insertions(+), 58 deletions(-)

-- 
2.49.0


