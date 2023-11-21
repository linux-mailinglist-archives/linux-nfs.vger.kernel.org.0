Return-Path: <linux-nfs+bounces-11-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D89827F33FB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A701C21CE4
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B59B18E02;
	Tue, 21 Nov 2023 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgukbjsF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E95674C;
	Tue, 21 Nov 2023 16:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4BAC433C8;
	Tue, 21 Nov 2023 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700584808;
	bh=d5n9vNStvOceqXEbN7a2X4urtfXmU7o7L1d/cHedV5g=;
	h=Subject:From:To:Cc:Date:From;
	b=AgukbjsFECOrP1eXArlfv4HzgZG4q0FiJ8dsCy4I5y+ulWyh+KOA7ZdVD/Egut4EW
	 er63tibTe3YMvQZkRDpbp5PDEY6tCWCgz7BpV5WIdNOqs17/OzfM93YJ8E3wPXZ0xn
	 P72dmYmWOTcJvLoJgMnN34fi+lVceeB9oj45iC75NpejoBvRIVtS0BygKu0wuTHtsz
	 rnkpJ3gR7bLdbKF1EHugjiWdAwp9mII6bdtECvJWJIhiFnO0V1KWM9V4+H+eQJuRp1
	 +UvET2WCvY8BWz7MoQgO8CRRtYgsFKzuh8DlBS5oDZNDOHrjXdA2HhElBqE0ZL0ErR
	 qDUtViGt6iJ4w==
Subject: [PATCH v2 0/6] Was: "Switch NFS server CQs to use soft IRQ"
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Tue, 21 Nov 2023 11:40:07 -0500
Message-ID: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

After testing v1 "Switch NFS server CQs to use soft IRQ", I found
that using soft IRQ for completion handling actually reduced
throughput on a 70/30 8KB read/write test. So I've tossed those
patches out of this series.

Also, Jason reminded me that DMA unmapping is pretty costly, so that
has been moved out of Send completion handling on the NFS server.

---

Chuck Lever (6):
      svcrdma: Eliminate allocation of recv_ctxt objects in backchannel
      svcrdma: Pre-allocate svc_rdma_recv_ctxt objects
      svcrdma: Add a utility workqueue to svcrdma
      svcrdma: Add an async version of svc_rdma_send_ctxt_put()
      svcrdma: Add an async version of svc_rdma_write_info_free()
      svcrdma: Clean up locking


 include/linux/sunrpc/svc_rdma.h            |  6 +-
 net/sunrpc/xprtrdma/svc_rdma.c             | 32 +++++++---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 11 ++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 32 ++++++----
 net/sunrpc/xprtrdma/svc_rdma_rw.c          | 12 +++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 69 ++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  1 +
 7 files changed, 110 insertions(+), 53 deletions(-)

--
Chuck Lever


