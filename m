Return-Path: <linux-nfs+bounces-19279-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNYdNhBdoGm3igQAu9opvQ
	(envelope-from <linux-nfs+bounces-19279-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:47:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFD61A7D72
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 15:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4AA73006813
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Feb 2026 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC292DB79D;
	Thu, 26 Feb 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYQGLYMh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1E285056
	for <linux-nfs@vger.kernel.org>; Thu, 26 Feb 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772117262; cv=none; b=TSHy23KBVm2J1xTUaw/ME2mTmEDWwCLQZ2vQIl6E5CRG25/kpcjRyniyF0L7mkAERNhbjJAH54Y8+biTuROCOq9HhKY2MyGcOVjbI9LsQ+sC9C3iI1/pJ2xtYNTY1jfJnS0ytpTAlSInFRbsD5DkzDJFR/JKgmyqNdB4137DtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772117262; c=relaxed/simple;
	bh=A5VWLX59xpGPw/zUBlmH3Q6b+BexIJyxH4xEkjEqkVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FF9cDGE1rmFdQM9gg/NTs4K8SZnQJdJb5uZ+XcexjMNkB0b55ZR3EFG3Q3x9t+bg3GIc2PMFu1v6yb660kmEUAJi9dZBfHhBkq3xYK6dsX4Ta8znXGfaFBT/7p7fOgdj0PpfmuG4DcfvuAwDuGA87eSBGoH5GgxW0EdQRVC4G+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYQGLYMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13415C116C6;
	Thu, 26 Feb 2026 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772117262;
	bh=A5VWLX59xpGPw/zUBlmH3Q6b+BexIJyxH4xEkjEqkVA=;
	h=From:To:Cc:Subject:Date:From;
	b=DYQGLYMhpl4yyDdm5xS6CtuOq9hsKQBqcWHR4ue6boqrZwf7wBEOSMCVurTleRsbv
	 BtPNtM6oTHoRYHM9hhz8nKgPtXyuqUZc3efiqXS2L59vAhVI3DVImJVREntcfAuHAj
	 WKh+69YmBP8NsbJRl1ZQ298Qe0UGzkAt7Bplqhf2yrAa+kxn8csPKj41NjPCWW+lKj
	 N2haNM3wB7GmX9oeQv5TzDBYxA/RxuqY2gBA8aL8gSIBr1aBObZtP4rrUNJ3rRzVrW
	 5gTLw0cmXVXSpqIUHGvSDixPDW+YR7xVM2Wh4ZiayFNnJZzTc++nHCl0Iyj1ueBI37
	 q/vNvX97IhPiA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 0/6] Optimize NFSD buffer page management
Date: Thu, 26 Feb 2026 09:47:33 -0500
Message-ID: <20260226144739.193129-1-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19279-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 7DFD61A7D72
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

This series solves two problems. First:

 NFSv3 operations have complementary Request and Response sizes.
 When a Request message is large, the corresponding Response
 message is small, and vice versa. The sum of the two message
 sizes is never more than the maximum transport payload size. So
 NFSD could get away with maintaining a single array of pages,
 split between the RPC send and Receive buffer.

 NFSv4 is not as cut and dried. An NFSv4 client may construct an
 NFSv4 COMPOUND that is arbitrarily complex, mixing operations
 that can have large Request size with operations that have a
 large Response size. The resulting server-side buffer size
 requirement can be larger than the maximum transport payload size.

 Therefore we must increase the allocated RPC Call landing zone and
 the RPC Reply construction zone to ensure that arbitrary NFSv4
 COMPOUNDs can be handled.

Second:

 Due to the above, and because NFSD can now handle payload sizes
 considerably larger than 1MB, the number of array entries that
 alloc_bulk_pages() walks through to reset the rqst page arrays
 after each RPC completes has increased dramatically.

 But we observe that the mean size of NFS requests remains smaller
 than a few pages. If only a few pages are consumed while processing
 each RPC, then traversing all of the pages in the page arrays for
 refills is wasted effort. The CPU cost of walking these arrays is
 noticeable in "perf" captures.

 It would be more efficient to keep track of which entries need to
 be refilled, since that is likely to be a small number in the most
 common case, and use alloc_bulk_pages() to fill only those entries.
 
---

Changes since RFC:
- Clarify a number of comments based on review (NeilBrown)
- Possible NFSv3 waste is still open for discussion

Chuck Lever (6):
  SUNRPC: Tighten bounds checking in svc_rqst_replace_page
  SUNRPC: Allocate a separate Reply page array
  SUNRPC: Handle NULL entries in svc_rqst_release_pages
  svcrdma: preserve rq_next_page in svc_rdma_save_io_pages
  SUNRPC: Track consumed rq_pages entries
  SUNRPC: Optimize rq_respages allocation in svc_alloc_arg

 include/linux/sunrpc/svc.h              | 61 +++++++++++++++----------
 net/sunrpc/svc.c                        | 59 +++++++++++++++++-------
 net/sunrpc/svc_xprt.c                   | 47 +++++++++++++++----
 net/sunrpc/svcsock.c                    |  7 +--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 15 ++----
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |  1 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |  6 +--
 7 files changed, 125 insertions(+), 71 deletions(-)

-- 
2.53.0


