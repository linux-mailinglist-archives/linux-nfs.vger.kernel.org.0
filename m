Return-Path: <linux-nfs+bounces-11606-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0C8AB018E
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 19:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7558B245AA
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2966283FEB;
	Thu,  8 May 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvBsPXQK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73F283FDB
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725865; cv=none; b=algziWoxnNzM0VECW42YXBb2s+3UHuQOY16/uY1FwSo9ITG/rttacK3Vs+wKz/skI4GAl+SeCwwGgcflbBkIkv89jNgmbtjRVO5jpNHV/12QVJT+cKrvG3mCLXTew0GIaPKC6yKtlji1/uFnWoEBh1MDvwoanRN1QGOi8b2r7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725865; c=relaxed/simple;
	bh=lT6tb/kD0CZL1NJf1Wsf3Eb2TQu9M30kw4YTvpeJRag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTRqWpoFQtQkijlfC9NXCcLlxBqnjlIxDRQz8v4YlSTd0zGEGzssRSluisPn3CrL9gAW2Wxord4i+fRiOOOVM8+5nDM+uOnudoKmAe8P1f1hQ3+4qTLQ68ZNmgYe9fkHLuuCnGGbL51jb/be+BfFf8Fiexr45xQlF1YuiHB2Nqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvBsPXQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E58DC4CEF0;
	Thu,  8 May 2025 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746725864;
	bh=lT6tb/kD0CZL1NJf1Wsf3Eb2TQu9M30kw4YTvpeJRag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EvBsPXQKKK/9KL496kul7RoIJCrIweWNyiLrsU6BuB1KDAjBLbsbMzn4fxV/A3Kj8
	 xhHN9RU0zvGo5jYhgM7qtXlPDhfZTA40fCJIEWXAbQS6mGSAUh2kMri6AW6OKho5fe
	 fGrlwU/2WaTnye2uBMXLzKcan/5NS6z52u0AvnukwAwyUsYsWmsRQccyAeYmmjGOS+
	 v3HX9f987IH0h6oNGwv61U8X4EoP47hV4+wXwBeTvYQ4Gdm/DpRdHB+sXTaASKdjeA
	 dI6SwlZyjaxIvLaotc88ED+XDpJ6pQHoA4bdDd6GWag6uhTBkoN8kVvAdzp81rWleM
	 8K1vSlgiaGafQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/6] SUNRPC: Export xdr_buf_to_bvec()
Date: Thu,  8 May 2025 13:37:36 -0400
Message-ID: <20250508173740.5475-3-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508173740.5475-1-cel@kernel.org>
References: <20250508173740.5475-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Prepare xdr_buf_to_bvec() to be invoked from upper layer protocol
code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xdr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 4e003cb516fe..2ea00e354ba6 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -213,6 +213,7 @@ unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
 	pr_warn_once("%s: bio_vec array overflow\n", __func__);
 	return count - 1;
 }
+EXPORT_SYMBOL_GPL(xdr_buf_to_bvec);
 
 /**
  * xdr_inline_pages - Prepare receive buffer for a large reply
-- 
2.49.0


