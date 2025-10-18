Return-Path: <linux-nfs+bounces-15362-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99727BEC329
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 02:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43D844F281C
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621D71A9FBA;
	Sat, 18 Oct 2025 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STtD32dC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC672602
	for <linux-nfs@vger.kernel.org>; Sat, 18 Oct 2025 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760748877; cv=none; b=m57z+QsDoGkTjm8Y6HUV/sXzAg2fLpcIhmgbXPHgIy+OVIxXZv7SXAiSpt4bRVTjKKx+wMeOo9P8gfaMKGjABFMaB6k1tlB0EjlSgag1Y2+pF6RqNfGnsqs0gKzN9GVLeYwgJnN/KaNq1uH8i33h6lE63hVSvYy6d/9oqlxIftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760748877; c=relaxed/simple;
	bh=B15E/XvtU53JnQeCw/30oPwurIRfv/7XgeKvDwMLVYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1HFXcK+YZd68BIThievC7lLi7E1uvDXXbxMml446VNmCOy3sRlXlPeGvgFzXiec0uaneNcTt7OjRgq1wagqmkLHzaTZHl28NUEQmwTSZ1y0mS2LvbXBBLu1zj1p58h5JcfJPSCAG4lQqY8SAqiLKy8H66YM5mH9GKsTxULhMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STtD32dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C86DC113D0;
	Sat, 18 Oct 2025 00:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760748876;
	bh=B15E/XvtU53JnQeCw/30oPwurIRfv/7XgeKvDwMLVYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=STtD32dCcPPk8ar7ior53pi9/5sikgzHEdx1HkkCPQLELYknbI16QYQ4M8htYREQi
	 aqkaRScx6tG0SyK4GlvOvtWUcy4Z8avQadvu4R3ZPLHTGnJazxofxnji08v6sDV0mK
	 8pAz4sCCsEzUx1cMSbqviv4tZQ4whvTjW7L+Z8y1ahsE/JS9rmNiMj0rwqL+vLMHsh
	 sl/1cZoLq/kWNe4vCFpkZJ2c+6HtbErfE9HoilYJTudZV2IrdfyNoa/y54o1hUWPe6
	 KvdazOFe/DRfBAgxIZFIe/oIF+s74I9FlvKPX2KJ+DsOe5i+lMhK091SmjFAKXIcF5
	 TpLXm4CSMDKTg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 3/3] svcrdma: Mark Read chunks
Date: Fri, 17 Oct 2025 20:54:31 -0400
Message-ID: <20251018005431.3403-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018005431.3403-1-cel@kernel.org>
References: <20251018005431.3403-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The upper layer may want to know when the receive buffer's .pages
array is guaranteed to contain only an opaque payload. This permits
the upper layer to optimize its buffer handling.

NB: Since svc_rdma_recvfrom.c is under net/, we use the comment
style that is preferred in the networking layer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e7e4a39ca6c6..b1a0c72f73de 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -815,6 +815,11 @@ static void svc_rdma_read_complete_one(struct svc_rqst *rqstp,
 	buf->page_len = length;
 	buf->len += length;
 	buf->buflen += length;
+
+	/* Transport guarantees that only the chunk payload
+	 * appears in buf->pages.
+	 */
+	buf->flags |= XDRBUF_READ;
 }
 
 /* Finish constructing the RPC Call message in rqstp::rq_arg.
-- 
2.51.0


