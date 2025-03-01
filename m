Return-Path: <linux-nfs+bounces-10398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE6A4AD5A
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 19:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F251896C7F
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 18:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0643070808;
	Sat,  1 Mar 2025 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0MsFbwW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D421823F37C
	for <linux-nfs@vger.kernel.org>; Sat,  1 Mar 2025 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740853915; cv=none; b=qQlfRIPqWxxNrzlgvwG5dUGCIxgk4nmvjNcafLkA3xtPLSQA8eoJ9A4ImlP4XDNYFoi/deKvNR0FkUChl8HEziFVUQvM9hd4wKfMyrdNhuC821dUBuJeWa+95hVJbPTCiHVWRjq86+MIufKrtVtIwDEn9ociYw3vrF3GVoj1rpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740853915; c=relaxed/simple;
	bh=Vk04tEd8JRTsftssTdNqtvOU/+Zz7FoEVLJ5XD23uP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tXIYZpOF7NR7/gxgUfiPFjKeQq9kA+7vHGlJvcym31slDmgFhIzaUzSg9plK2aDAerBboYbmesnvHQGqGrNC1qNJbQa67Pe5J/CFaoQ8FC7hwUG/o4zPkyr3m1n628I2+s7HjLSS8LVKOGCZ69nzjUCqtS/lTxXgBm8O6NEfZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0MsFbwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97435C4CEDD;
	Sat,  1 Mar 2025 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740853915;
	bh=Vk04tEd8JRTsftssTdNqtvOU/+Zz7FoEVLJ5XD23uP8=;
	h=From:To:Cc:Subject:Date:From;
	b=S0MsFbwWrcl7iV0qZtoRe9BG2av/tuwFDiWXkEn57LbDOV6iHIczRVqR39qTQL1FF
	 LQMX3XjZLx9YoA+YW266dYTTVSfYuDq5aOy+iM4W2XXfUGlGTlBSX1U+FvZ8SkKphN
	 GNSDa7h5MTZVJjjyhjw5Fo6uufcq3VYsFi57s0a7ToQ4ElahlrhYAbL+pdUuOviXya
	 U6ULaxnwy+d6PUKjGfJjV4+QRNrNUYrr1J6/yQC/1iZKEkL+DETx0GskuWi+zLZmLh
	 /M14bgDN4NuyFzHU2B57hqj0g2X+Zz2qFCgSrmEDm45P0v9uuhH5ExBr2ilymuw5zv
	 1CXLcHodYLwMg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/5] Implement referring call lists for CB_OFFLOAD
Date: Sat,  1 Mar 2025 13:31:46 -0500
Message-ID: <20250301183151.11362-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I've built a naive proof-of-concept of the csa_referring_call_list
argument of the CB_SEQUENCE operation, and hooked it up for the
CB_OFFLOAD callback operation.

This has been pushed to my kernel.org "fix-async-copy" branch for
folks to play around with.

I've done some basic testing with a server that ensures the
CB_OFFLOAD callback is sent before the COPY reply, while running a
network capture. Operation appears correct, Wireshark is happy
with the construction of the XDR, and the CB_SEQUENCE arguments
match the SEQUENCE operation in the COPY COMPOUND.

I'd like to include this series in nfsd-testing.

Changes since RFC:
- Add a field to struct nfsd4_slot that records its table index
- Include a few additional COPY-related fixes
- Some operational testing has been done

Chuck Lever (5):
  NFSD: OFFLOAD_CANCEL should mark an async COPY as completed
  NFSD: Shorten CB_OFFLOAD response to NFS4ERR_DELAY
  NFSD: Implement CB_SEQUENCE referring call lists
  NFSD: Record each NFSv4 call's session slot index
  NFSD: Use a referring call list for CB_OFFLOAD

 fs/nfsd/nfs4callback.c | 132 +++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfs4proc.c     |  16 ++++-
 fs/nfsd/nfs4state.c    |  38 ++++++------
 fs/nfsd/state.h        |  23 +++++++
 fs/nfsd/xdr4.h         |   4 ++
 fs/nfsd/xdr4cb.h       |   5 +-
 6 files changed, 193 insertions(+), 25 deletions(-)

-- 
2.47.0


