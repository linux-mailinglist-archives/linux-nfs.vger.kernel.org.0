Return-Path: <linux-nfs+bounces-5866-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C658A962EA7
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDBA1F21D95
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636C31A2844;
	Wed, 28 Aug 2024 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAUHf1qT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E73736130
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866815; cv=none; b=UWhTJDpn4wPWNSpz12jTo79rCUabeAG3wwJVK2wd7YDtuvKkp+vZkm9GfxE0/2wqWuuHP3zCgOfQ5aVGulSwWdDZGBpmpaPDVum0hsnLlp+E++XlW+XES+d0pXPGrjGFKYkikA6kL2WLr6AcmvAeLlXPODPkc+draYKSd8VWHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866815; c=relaxed/simple;
	bh=weL/JJx77k9JkZr2Zf1H9VVOhRAxDLnAqtd6PdKbXzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WxAPl22fbz44de0mBsyUc+zQp225kRPyhmIcT99kHDPvtZA+CU3QDgUexDvEge2xOZGP+AcCn0p/YZQlG+ajBZasjepdffZ5oXjJqRqivwKUuOqm9rG1rmEblrYw13WT+ZytgDQqXbh1p5SNBwwuNr5cWC1ABKynF8DOzreAypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAUHf1qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313C7C4CEC0;
	Wed, 28 Aug 2024 17:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866814;
	bh=weL/JJx77k9JkZr2Zf1H9VVOhRAxDLnAqtd6PdKbXzo=;
	h=From:To:Cc:Subject:Date:From;
	b=eAUHf1qTP3jJ/XlPAmYRxfMAhBwIYJuzM6BetQsSi4cpZPxhXCiqGi52QVMl/SkQf
	 wu9xiQHUbaWYp29Zp648h5athspiq9/bM0/cr7RVKnRRJdfHoAit3RIsbnpVw8N+BU
	 O5YeQe0Vq65GuWjTMV7BCByyVX9o1WGa6laabbGa/fa4wW4GSf+yQ9OnYpibO0Z1t0
	 /3Z2Fz/AlcuqesySvZq2IOAgGYNZOxuww4kDzOcN4/tUuDG0x9xcHNC4exchMFQvv6
	 OMKLrel5CG3t9pqpDmhJg76WoQTHKDeppizkDvU3o45zGFSuX0CaVTfKLR/Y5771Li
	 cHYWA2pxX1BAQ==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/7] Possible NFSD COPY clean-ups
Date: Wed, 28 Aug 2024 13:40:02 -0400
Message-ID: <20240828174001.322745-9-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=990; i=chuck.lever@oracle.com; h=from:subject; bh=bKdscAwMZWpC4TpIQWcssfpApKVQmy2v+cuoHpJnhng=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmz2DxRvkGh0Obo81Dw3TMyh5Y52GhJt4EFGrzR v9POXSCUV+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZs9g8QAKCRAzarMzb2Z/ l2HCEACUzLJbbZ2GWRy9tUZesLp2XMclid02qg5kFK/UH6M7xMhfQRPD4MpNwwt4suy4rPCU8AT EUd8bKWVqCYBkPCTJgNIPTyK5yr+r3lSOTP697IgOC1iPAESCyDt4iA/fm3fbDSVxKD//VtgV5M OnRqeQeGDj5olrLO+Atr61qfkFTcMFhDyJcEBS/tgIBLDKJ/y/A/X/38bBH85O6DxR2l18qcEc3 dOX1LFUFa3IR4BlSu90x5M6vFDvvYUe0/BkkpyySEvqItoiTN4v2g61lkxHFWZJ3wsy+1G/R1nR ddtkzPL94SkxE0OgBcjM/CbelETeg9pzrTr+JbvlXYcKh3SoUUIX7JC9n1NfYYXRuJHZGsvxj7I 2pMlrEoCi/JIMYyyunkHn1jcs9MYKR6ItClyXHG9JNtk6id9oEDfAcpcccsyq3ijqW5UVSjLvR7 zwT95XoJOWLQ0jPD55RH1smAoQTusLI2WLb4ArDzaSTqMID22U18NLtbuXh3CO1zvBxQRaiFnJC CHU34hr3C6EAJIm1zuE96oFJbUghzLHAG0hioyfmggTqTFwEgQ/cT1sq7ZgTwYrL5yYhyp9aMRD vmUMLfoJtGnKfISCi79qWDlNYSbshvumh0QrIsPO5IpwBtEf8BfhXX9zNdIaAGLIld0prlhIKft za1CL81fLcRt5dA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

While working on OFFLOAD_STATUS and other potential improvements to
Linux NFS's COPY offload implementation, I've come up with a few
server-side observability enhancements and one or two possible bug
fixes. These are candidates to merge for v6.12.

Comments welcome.

Chuck Lever (7):
  NFSD: Async COPY result needs to return a write verifier
  NFSD: Limit the number of concurrent async COPY operations
  NFSD: Display copy stateids with conventional print formatting
  NFSD: Record the callback stateid in copy tracepoints
  NFSD: Clean up extra whitespace in trace_nfsd_copy_done
  NFSD: Document callback stateid laundering
  NFSD: Wrap async copy operations with trace points

 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4proc.c  | 38 +++++++++---------
 fs/nfsd/nfs4state.c | 37 ++++++++++++-----
 fs/nfsd/trace.h     | 97 +++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/xdr4.h      |  1 +
 5 files changed, 137 insertions(+), 37 deletions(-)

-- 
2.46.0


