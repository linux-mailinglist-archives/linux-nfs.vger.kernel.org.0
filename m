Return-Path: <linux-nfs+bounces-6813-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13ED498F207
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1991F21AD4
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90D41A0719;
	Thu,  3 Oct 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHHZSoAZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615416F0F0
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967720; cv=none; b=hAIIlwAaCEH+BEmrtoBZ1qM1d9Q+zW4KWziLETRjwBQ/1UNJnk7Dor4n0bVl7WtMAv7YIvHAMp6FMpgyM1P/0cvtTswV/+MU2pxyZpSVr11td5x2M+clS3Y4Trr9UV2od5Zxy68IYNtTc8qUpqZb+FMbXB4u3T6ahCnNtg5Su9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967720; c=relaxed/simple;
	bh=SoSWvT0n8eQFx0vdcmEa/oaMA3v+0uKf/pAk5pq1oZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ga3qct1ws6Bxru3a3FNh2SGUMA2BjM8Gvg24aP+E/P6DwHutE7Wfz3e/ggGrwc0+EiLm5Bkqi2X+QRWyOBbMn0HJLRrwA1Hq9eBt8rcaGl1GkT5/wPHjd+A85tBnhfdDFI0/Pxfdu8PMqMP06bG4gOP+OsstwWIOqhwyMotJ2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHHZSoAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CE0C4CEC5;
	Thu,  3 Oct 2024 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967720;
	bh=SoSWvT0n8eQFx0vdcmEa/oaMA3v+0uKf/pAk5pq1oZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHHZSoAZIODCV+blaL4tniSbCbVsjRfvCa9KsPe6TJrnz2UmmaKHdP/oyRCQPi8bh
	 W+zUPLav1UX5Gwkk9jjN62QfF1S6+Q5fp8zC5Cny8H9pMKjDx+2Z5Z0imWcot3ne5z
	 bjbn0Y3nNZ+8OqD5FYzUQQCK2LKQUw+iIH/n/rZ1rg9RbhXtod4TY9jHaP1ySUWhox
	 k7RfuviEdqqix0Cm6WSoWGrMTSroNAqSCAmg1XHsRfhcEDr2+Y43AD7b0mH0hxXbu7
	 818SDWKQ4teiIM0x7Rei9HUAt6A62KNxn8/pWCcsfdzH8IE2JtwXqByAVAGz4aXUiK
	 qSYXC1rSEbQyg==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 04/16] xdrgen: XDR widths for enum types
Date: Thu,  3 Oct 2024 11:01:46 -0400
Message-ID: <20241003150151.81951-5-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003150151.81951-1-cel@kernel.org>
References: <20241003150151.81951-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

RFC 4506 says that an XDR enum is represented as a signed integer
on the wire; thus its width is 1 XDR_UNIT.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index f1d93a1d0ed8..fbee954c7f70 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -227,6 +227,18 @@ class _XdrEnum(_XdrAst):
     maximum: int
     enumerators: List[_XdrEnumerator]
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return 1
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        return ["XDR_int"]
+
+    def __post_init__(self):
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
+
 
 @dataclass
 class _XdrStruct(_XdrAst):
-- 
2.46.2


