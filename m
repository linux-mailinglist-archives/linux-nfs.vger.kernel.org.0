Return-Path: <linux-nfs+bounces-7595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CAD9B7BD9
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 14:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA732820AF
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 13:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931BA19D091;
	Thu, 31 Oct 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYSMAGQv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4A13D886
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382011; cv=none; b=gCV1gFvmSaiZvNJwYZkfPOBQtzS4oRyW7QFHdXYUU7d5afj1WGLFDqEVkBia2MMBGJbjhjTcu6iLmOWWsRXtWMka/vq+eeUcA+CB1dGBf3oPzYjXH+pnhOn46GB4E87h8Wzy3Db8n++QQ87K0lcNzHopTxh5bQ8xHIPNF6V8j8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382011; c=relaxed/simple;
	bh=7L4huf/Ukf4NF4amVZBztxBLIviaIwEJxvWXwyG9/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iz81ogZL1Phwgjj9NYPAL9vQ4fBqhx+9h5PxNQ3YTqK+rQlE+rUWKw0zSd0TOC9SJkIUbjfBUlL55QFC5nv5g7kZqhebwFckkRkZCmggY5S7ziRmcKzvtna4M7RgRZaFiPJlxONTNdjFlilTBIOamfSlT4kocsV2t6oQx1iM1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYSMAGQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365D1C4CEF4;
	Thu, 31 Oct 2024 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730382010;
	bh=7L4huf/Ukf4NF4amVZBztxBLIviaIwEJxvWXwyG9/FQ=;
	h=From:To:Cc:Subject:Date:From;
	b=GYSMAGQv10uNe7NCEcUInMaa6h9+CrBnQEydOcPu4VcY1TroGnRYpUv6qTfNkdPPV
	 E8WDLurSJUWe8ovlhqSwpqmCsddDOP+VEtjB0VprNkqJl2ZYcUKfEpuvvge9AkWyXf
	 Qf09ofWntAV010kYboZWHtPNEl+growlN344iFYMBY0JRK0KgPD3ADp0dNljbywBsB
	 hOyDe5CwiPdV/aE+V6848kaa5nyvRNX5oLaTmaa95Xkj76Ooc8BfMBZtQhVCEouqga
	 HzcYpGFTVDZ/s3anaXyI7PBouvKersQRQm67UPKjuL3fPrmZNX5ktzINTa/FcwUyd0
	 vA8oH2DbeaBcQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 0/8] async COPY fixes for NFSD
Date: Thu, 31 Oct 2024 09:40:01 -0400
Message-ID: <20241031134000.53396-10-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=chuck.lever@oracle.com; h=from:subject; bh=QkMD/yQRiBefnYdvEbKSgt+6Vv6tyFVsI+4578/pSko=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBnI4iw9FKiqrtQqHR5zGBWzpFAU7ooIKuqh+3i4 md+apJV4X2JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZyOIsAAKCRAzarMzb2Z/ l8NqD/9kx1N2IQswKoRdv2l0qBKrZmmrRC7YABOqwodrXlRTaayZ8kO0CFwXZ0pGJXxE+Ei06JR iI1GuhBHZ4fpXO7zwdShLMRgiqgniv7m9NMnQ4UMy2jthKumo/CKts+rw3HUDA7obv0JXcSMxs6 Rs95JS8C5cs/iBgHlwgz6/xAnR+0dji9NO0SsQvorOB8W3I+XbWB9J47q7GEu1pP454b0AWl5lq UIHV2fkeVJMZ9vcDS+pm3t8XyiPQj4sRSVRDEaIi3mqNEYzDAf4J0iQaaQhcXVbBNGijh/dC0gU ZihU5sl3pYgeeEuGb3P8dxScOhcxIaf3t1rxcYp9RLyQURnwMQmPsg3qS/Wp/XSqbqq9y7NasH9 K6S5NDICpxgWmQzv837vso1EttRyfU7SKeAgR0CTtRp0Kx282kL3njpiR4usk4cwbl7Pyd//ZzD 8fJyg5vUNJq3tFxNFzQRq2yTiXi5wBU/LU2sUVZPtKuD9y+WO26qjzLts/dnhjU5t8ZEqT3v1iq 1/PA8Y3FGdOt7+L/GvYKYxi522P0X7EKil5JrQyqdcYY+P9sE9cskqdnGvBVH1jjt7fnfSORWLf FD0OcTnm1wBpE4YL6LIoV6V05TX7iiD2t4fWW6bWNhor8KQwmyB+zQItIAOPqIwE/jOtBEgGxml Cx+AHwb2a1f7flA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Extend the life of async COPY state IDs so that clients get
actionable OFFLOAD_STATUS results after COPY operations complete.
This lifetime extension comports with RFC 7862, although does not
bring NFSD fully into compliance.

There are a number of other small fixes to improve observability,
behavior during temporary resource shortages, and behavior during
client shutdown.

Async COPY remains disabled in NFSD until the Linux client has grown
support for OFFLOAD_STATUS. Patches for that are available in the
"fix-async-copy" branch of:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Changes since previous versions:
- Loads of testing, improvements, and re-organization

Chuck Lever (8):
  NFSD: Add a tracepoint to record canceled async COPY operations
  NFSD: Fix nfsd4_shutdown_copy()
  NFSD: Free async copy information in nfsd4_cb_offload_release()
  NFSD: Handle an NFS4ERR_DELAY response to CB_OFFLOAD
  NFSD: Block DESTROY_CLIENTID only when there are ongoing async COPY
    operations
  NFSD: Add a laundromat reaper for async copy state
  NFSD: Add nfsd4_copy time-to-live
  NFSD: Send CB_OFFLOAD on graceful shutdown

 fs/nfsd/nfs4proc.c  | 101 ++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4state.c |   3 +-
 fs/nfsd/state.h     |  17 ++++++++
 fs/nfsd/trace.h     |  11 ++++-
 fs/nfsd/xdr4.h      |   6 +++
 5 files changed, 128 insertions(+), 10 deletions(-)

-- 
2.47.0


