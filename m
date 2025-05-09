Return-Path: <linux-nfs+bounces-11624-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C57AB1CFB
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BC6167074
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD0624291E;
	Fri,  9 May 2025 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkvwSfcE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8992242909;
	Fri,  9 May 2025 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817439; cv=none; b=aTbMmNL51ke90joZQMJEAZpXx4KYYJHPCQAYhjIfLx6UW+hQeTPR2c3y6JmvJDNxdTNQUtmIN6EPHT31YOprkBkX4xEB95ugyxfSTtUB9Af6OQgvBlHzhyDSOLt7jFSFV6YvVI/5wUa1RnY/02hOeg+UNVLNJQXdjNfPjFLrK7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817439; c=relaxed/simple;
	bh=ZELpgg+4FVsSnEdEHEp2bzubVRI6D/i04bcZdZG8eLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEQdc/+4QY/QBikVk4P7onE7cIEdXQmtlgUoG+B9z0ObmN9UJTgcVx16ShrVqfY7Qx9S/UTi0mCgPZTHyWb7CjHAl0434wotmsTT5C9OqaLQVjVhJ7dadsx61c1Ok5h13Jyd5efaK5bb4YH7dqK+oW1WNUikiWNF1jAVtgG+VxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkvwSfcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CF8C4CEF0;
	Fri,  9 May 2025 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817438;
	bh=ZELpgg+4FVsSnEdEHEp2bzubVRI6D/i04bcZdZG8eLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rkvwSfcEGbbvJgGEsG6qL8EQHacH6OOlUVD6y91OFHoaEjnWEKmhrTOJYg4L0Z07r
	 1J5CYQ7RHgWre9vM7AdbcT8RyaxTUNGV7AGYrCyZMXMzuCkgv/47PRZYY8c6DmeTFc
	 k+3BZuGGN5BRtM00lNxhQxNEbJJgqxipOkOx8DGzf65HAOntBWtRZMW72k4qXbXTIj
	 Eyg72D2PluLFDiOVmtJBUH/Hu9v6SXQ7YShR9xmMyTQ9XYPv4xGD0KLDBUQb1J1UuJ
	 S0f/NFe7nbh1C+z7SPPlMs744cO5Y2nRD0t3oFNH7uxNBR6MwpThv5b8//EAK+53tq
	 NDTUHcRHGVTjQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 02/19] sunrpc: Add a helper to derive maxpages from sv_max_mesg
Date: Fri,  9 May 2025 15:03:36 -0400
Message-ID: <20250509190354.5393-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509190354.5393-1-cel@kernel.org>
References: <20250509190354.5393-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

This page count is to be used to allocate various arrays of pages
and bio_vecs, replacing the fixed RPCSVC_MAXPAGES value.

The documenting comment is somewhat stale -- of course NFSv4
COMPOUND procedures may have multiple payloads.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 74658cca0f38..749f8e53e8a6 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -159,6 +159,23 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
 				+ 2 + 1)
 
+/**
+ * svc_serv_maxpages - maximum count of pages needed for one RPC message
+ * @serv: RPC service context
+ *
+ * Returns a count of pages or vectors that can hold the maximum
+ * size RPC message for @serv.
+ *
+ * Each request/reply pair can have at most one "payload", plus two
+ * pages, one for the request, and one for the reply.
+ * nfsd_splice_actor() might need an extra page when a READ payload
+ * is not page-aligned.
+ */
+static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
+{
+	return DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2 + 1;
+}
+
 /*
  * The context of a single thread, including the request currently being
  * processed.
-- 
2.49.0


