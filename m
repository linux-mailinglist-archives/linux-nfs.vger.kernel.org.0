Return-Path: <linux-nfs+bounces-11630-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE202AB1D06
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 21:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF32D3BB5DB
	for <lists+linux-nfs@lfdr.de>; Fri,  9 May 2025 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6DF2441AF;
	Fri,  9 May 2025 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwVD4o+o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215D243968;
	Fri,  9 May 2025 19:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746817443; cv=none; b=fRlNdY+ZSjdwiSw0wb3kauZuESyXZgU6A4ieHidHYmuRGEM20TaXZTX+NDTOTqxNCSngOF4SdAJavg6s2CzWM4v21yK1aXq7L3mqeQjhLU2s5/vTwYKwAB/dAPVfOfZSfnHEC1N1vWyIoy5K/pLF1z2I1hsfSQT5830qEZVgzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746817443; c=relaxed/simple;
	bh=lT6tb/kD0CZL1NJf1Wsf3Eb2TQu9M30kw4YTvpeJRag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xquh7X9uncxbMwK0vspSExqaA9jHucEZAwDlmNbH8QP0HaeZPvSnr5RokvakzM/j5VMgW8UHFF0kwnCetkeAERNh2hTPbUJzztHjzBayf4Y+cxT2L1mIy2AOz9MqKw/aAskskftNowGso/V0d4nmdStbPOHn6ll/PSUUfFMgcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwVD4o+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26FEC4CEE9;
	Fri,  9 May 2025 19:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746817443;
	bh=lT6tb/kD0CZL1NJf1Wsf3Eb2TQu9M30kw4YTvpeJRag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GwVD4o+oxeO57prT6s3IZc+0LdOsx9S7shmmk/XXYkSGIcT0dkOpN2wzFpI89tHMv
	 iDGDGAYPS7AEyLcyYMaNxV2atYdlSa5KoKGxOVO6SVgTcUdTvcQCEwyP77JFmd875U
	 mwpoJLhM4LyNTngvcXfqqeQYGcwnqgIVTphhL5cGpVl+gR64Nko1MAr+2iGGyWYuQ/
	 NmRqD8KYWIFlkHuFtDz8lkUgrMZmSJLR9nfMXA2k1KfVeuHPANbUjuxsll0Z2vqZn4
	 99SZV3eWpQVOCKBQ94YqvyiX6j4mW3cg3R18beBzKC0KYvsrUQC3rbt0ha1es6TS/3
	 OCYEdxlallt6Q==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v5 08/19] SUNRPC: Export xdr_buf_to_bvec()
Date: Fri,  9 May 2025 15:03:42 -0400
Message-ID: <20250509190354.5393-9-cel@kernel.org>
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


