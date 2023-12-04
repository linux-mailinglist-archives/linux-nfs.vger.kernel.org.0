Return-Path: <linux-nfs+bounces-275-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586958037AC
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13518281157
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A93286B3;
	Mon,  4 Dec 2023 14:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE6cMbPy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05B22EEE;
	Mon,  4 Dec 2023 14:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7816AC433C8;
	Mon,  4 Dec 2023 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701701779;
	bh=M/LsVaErmnRZLQ1DWNk6syN2GlSq1DE/S8OHoXQ883U=;
	h=Subject:From:To:Cc:Date:From;
	b=oE6cMbPyjR/lg5sY+LD8dXqvfeX0YEeT6Gh/mwkfE7/YGyd4blchKhckzx5jASNih
	 ZyKyVsoSrZoNJguUnuVs5rGdW68jsWT/4Ryb6bWj4wd9HS7dDZCBjlZ+03js4rSizS
	 f2UeTdqZwzHBrSBsfiZXBZ+3YyJMBo6Fp4dyT6voLONADuLIoTrtzlvK5j7fjcHuGg
	 e1TFU7xolyyrXWnHxvP+3YfXZfHktzDl0esWPmkbEo3jlT+Nj413IWa3muvcwndxXa
	 44h8+tqVyK1T6ZoBEpRxHCok2E35NVHYgIE0STb7GuWgBBpJlG5qKv8KB0i81mFIDt
	 3w7Oy0GXwGG+w==
Subject: [PATCH v1 00/21] svc_rdma_read_info clean ups
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 04 Dec 2023 09:56:18 -0500
Message-ID: 
 <170170144201.54779.9877683240030806819.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

These patches are in preparation for more substantial changes to how
Read chunks are managed by svcrdma. There are a lot of patches in
this series, but each change is narrow and no external behavior
changes are expected.

The main benefit of this series is that svc_rdma_read_info is no
longer dynamically allocated.

---

Chuck Lever (21):
      svcrdma: Reduce size of struct svc_rdma_rw_ctxt
      svcrdma: Acquire the svcxprt_rdma pointer from the CQ context
      svcrdma: Explicitly pass the transport into Write chunk I/O paths
      svcrdma: Explicitly pass the transport into Read chunk I/O paths
      svcrdma: Explicitly pass the transport to svc_rdma_post_chunk_ctxt()
      svcrdma: Pass a pointer to the transport to svc_rdma_cc_release()
      svcrdma: Remove the svc_rdma_chunk_ctxt::cc_rdma field
      svcrdma: Move struct svc_rdma_chunk_ctxt to svc_rdma.h
      svcrdma: Start moving fields out of struct svc_rdma_read_info
      svcrdma: Move svc_rdma_read_info::ri_pageno to struct svc_rdma_recv_ctxt
      svcrdma: Move read_info::ri_pageoff into struct svc_rdma_recv_ctxt
      svcrdma: Update synopsis of svc_rdma_build_read_segment()
      svcrdma: Update synopsis of svc_rdma_build_read_chunk()
      svcrdma: Update synopsis of svc_rdma_read_chunk_range()
      svcrdma: Update the synopsis of svc_rdma_read_data_item()
      svcrdma: Update synopsis of svc_rdma_copy_inline_range()
      svcrdma: Update synopsis of svc_rdma_read_multiple_chunks()
      svcrdma: Update the synopsis of svc_rdma_read_call_chunk()
      svcrdma: Update the synopsis of svc_rdma_read_special()
      svcrdma: Remove struct svc_rdma_read_info
      svcrdma: Move the svc_rdma_cc_init() call


 include/linux/sunrpc/svc_rdma.h         |  30 +++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c       | 310 +++++++++++-------------
 3 files changed, 169 insertions(+), 172 deletions(-)

--
Chuck Lever


