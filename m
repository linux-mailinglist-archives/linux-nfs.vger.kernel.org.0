Return-Path: <linux-nfs+bounces-10725-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C97CA6AC56
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 18:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F6C8A4EDC
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BB8225A3B;
	Thu, 20 Mar 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vF2hBy5m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213DC225A2C
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492684; cv=none; b=UWZkNLwYFFk1wtlNRLWbVfBYoksBmbYVJBf8cTJhbnTisbmu05NxHi6HMLV29vRx6ocV1+IbOf2fnxGdVmxSO+B+WPM6MiyPwDXf1OjFuLl/JVSlRlCnFWXHXqgpRZ5psAb29km4U4ioffHTF0L8cgEiWTSsxnEy05VNe3BTw+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492684; c=relaxed/simple;
	bh=jnTPJqa6Izobe6HDXFtsTWdev0EwPrgei021SBLB+S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gf3+5fZVgw1DmkEOyxfWRTQvNC/ZhD10eWwe7goZNxUpZZ6nvZzQh6mzNIpml+nR4YcXFnEBCgmeVlxCdmDmXvWDuEhKqeE0J+RTC0uWplYM6yFRWYlgVsqdkm9eXymdmYDv/oHUaxc63BRa3LUwsQhCwl0Z8lkRZ46dW4RKsdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vF2hBy5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFDBC4CEE7;
	Thu, 20 Mar 2025 17:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492684;
	bh=jnTPJqa6Izobe6HDXFtsTWdev0EwPrgei021SBLB+S4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vF2hBy5mxxkZ069lVSfcujzZdqRqKc0MO0H28hVnQuMBPegVjwASdRAcIVUgW9O2d
	 ihs8QfMUCXJAXBIAdyPGpo2cNhKUU3S1/g/IweoaSBpesjhS1RM8yq7xXO4JhHDkMW
	 LSQkY4hhA8bPWdpUUDolNBFvkUcqToxVIFhBgrquphI7RjS5uvSR3mX+TG6xW+USA7
	 c0DD1FPsDBEd3hz34u7XmD5fcf5oIVznJ8f8Bn73aScYJQe+JsQG52lkGwdcU8sxLE
	 Z3lzNfuLe1w3OXbdQcxVkz+xvy8Nvy1dJ4S2pfVogGwlAbN0c54DldQjYoDexfqqKX
	 A7KzAGT4rhMjw==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 4/4] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Thu, 20 Mar 2025 13:44:40 -0400
Message-ID: <cb9deab71af721c93086c37e8d6350bf75fe9a57.1742490771.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742490771.git.trond.myklebust@hammerspace.com>
References: <cover.1742490771.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the client should see an ENETDOWN when trying to connect to the data
server, it might still be able to talk to the metadata server through
another NIC. If so, report the error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index f89fdba7289d..61ad269c825f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1274,6 +1274,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.48.1


