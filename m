Return-Path: <linux-nfs+bounces-19090-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF6pCr0sm2llugMAu9opvQ
	(envelope-from <linux-nfs+bounces-19090-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:13 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D84916F9AD
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 17:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C2B5300722E
	for <lists+linux-nfs@lfdr.de>; Sun, 22 Feb 2026 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C97413D891;
	Sun, 22 Feb 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDQaQa96"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C83D3B3
	for <linux-nfs@vger.kernel.org>; Sun, 22 Feb 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777206; cv=none; b=CYE+TiRrl0NwgMiZxi2BaL9P6STtnA0raLz0Cls0j+m/17KfJnoDoZ4fPW0NGNtvvBFjIq1MKr1nMNAhIZtbGkQYAVKbNxU1dh5QAaJFiAb2rLlNFOum3+Rr//9Kyjp5GbKUHmQuKjqUB9gZsWUNYvnbXcC2ImyqZhGK61dzHEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777206; c=relaxed/simple;
	bh=p8FhBUxEKNFAXFuXBq85P7yWfX1TQUzHqVz1UpmQcxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXPw4TBBfYfHxYRwCjVoxyFoMDfOTg4gB/RJc5Amr+gxR13aiOb+pISF6m5ChrpVwP6NC6pvhzpwEGtFEJ315Pxa/3S8ta+mtpZ4Jm6oDSRx1lyadLsR+JARYKOiDiaDpain7w75UdkE9S8/NJSebz71ctuTj9H2DdLXIzV2mo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDQaQa96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF128C116D0;
	Sun, 22 Feb 2026 16:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771777206;
	bh=p8FhBUxEKNFAXFuXBq85P7yWfX1TQUzHqVz1UpmQcxc=;
	h=From:To:Cc:Subject:Date:From;
	b=bDQaQa96m6fnz5lXlYoSs+YkxdipA1+YE9QmgXza7WPAaY64f5uNYtGdxJ9YfAoiO
	 zp4ginJeJtvETndqX/G3SWzcJbwxZ0cwCfI94s+Iwi/BP0t1n2XRBcQNIkbdG/JXU7
	 ZRdBaBDcn4w3FEpsZ9nUNuTiLHeLPlsTicp6XRBAYmu8T6jSwNIP9+DXx37bYPqEFu
	 guHda6FI4EE1/cHIQH0+SlO96fMxRodi9KZBVDEEoj0FKIDiG66UdxZl1gQm34xK28
	 SC7RceEzE6kkedi97kdzt3+2Y7ii3fCYmOkcfGurV2UNNb7YQWA6l2qdugTruXDbXy
	 oC56okQ4/vrGQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 0/6] Optimize NFSD buffer page management
Date: Sun, 22 Feb 2026 11:19:56 -0500
Message-ID: <20260222162002.10613-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19090-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D84916F9AD
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

Chuck Lever (6):
  sunrpc: Tighten bounds checking in svc_rqst_replace_page
  sunrpc: Allocate a separate Reply page array
  sunrpc: Handle NULL entries in svc_rqst_release_pages
  svcrdma: preserve rq_next_page in svc_rdma_save_io_pages
  sunrpc: Track consumed rq_pages entries
  sunrpc: Optimize rq_respages allocation in svc_alloc_arg

 include/linux/sunrpc/svc.h              | 55 ++++++++++++++----------
 net/sunrpc/svc.c                        | 57 ++++++++++++++++++-------
 net/sunrpc/svc_xprt.c                   | 47 +++++++++++++++-----
 net/sunrpc/svcsock.c                    |  7 +--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 15 ++-----
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |  1 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |  6 +--
 7 files changed, 119 insertions(+), 69 deletions(-)

-- 
2.53.0


