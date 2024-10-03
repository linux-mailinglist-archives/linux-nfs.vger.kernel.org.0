Return-Path: <linux-nfs+bounces-6816-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515E698F209
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6808C1C21BDA
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC59D19F422;
	Thu,  3 Oct 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvmj8Z5J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8932F19CCFB
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967723; cv=none; b=EByG+ESLmLlTlniRZm4D8WGs7fH/aO29FpqC2eLSFOzXKteHvRdfVChF7JvYR9QvFUW7gq3Jn/j9LOFBSQo2d2CKRfVKfmYknu3tBI9G2Ln7jpPz7VI3bWQ9eblAbileFnWu8KoaFJ3+2BytV7V1+A5THrDNDB+xJW/IOeL/dmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967723; c=relaxed/simple;
	bh=B1K+TALLHIEHvj5rQFKCTcCLrKzUGlUJX2BnsjrwRdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKKRDbLdqgFfEy/ghXbOyo/DwM+QeAKy/NieYc7x3zVbGlEgNP34r4CynZ8FYlbbInYGa+NlXr0f+H3YTpV0xqlGhP404lJ2Qwa9pViJOJtx6HsK+f2otzMy0TNIYYrPuwnWavbSozcD6eUh0MrAiRBG86ZD0klV+Q0nQeqYsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvmj8Z5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD83C4CED2;
	Thu,  3 Oct 2024 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967723;
	bh=B1K+TALLHIEHvj5rQFKCTcCLrKzUGlUJX2BnsjrwRdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tvmj8Z5JRAAW2KQHJ+UFuDX+nhqDcsua64J30IJL9F5SBjmFHgG+Q1I7Yuikj4rF+
	 /DWNnuwRMoW4bSj/smbz54lzTDloMS5blAzj31ZG2u3FUN/58xXmrRy2pEFv66oykr
	 GwPOCwfTPByqMh7IIDU70eGrBH040u8rWM09HMabCdGNcWNH/Krjf1vz9TdUZH0lMa
	 7aP6qi7OwSNxXItS0eUR92KA5FXWEsw4eDcrNovM1FL1i7wcCn7ytjAo/+8jmqBRud
	 wo/gBOA7XBqdGAFL9uP8JRj79Bfhr7txlod7upyh6vMDvBooj1btI9KBHXxe60onx3
	 0tFE+flQSQTSQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 07/16] xdrgen: XDR width for a string
Date: Thu,  3 Oct 2024 11:01:49 -0400
Message-ID: <20241003150151.81951-8-cel@kernel.org>
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

A string works like a variable-length opaque. See Section 4.11 of
RFC 4506.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index 94cdcfb36e77..d5f48c094729 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -172,6 +172,21 @@ class _XdrString(_XdrDeclaration):
     maxsize: str
     template: str = "string"
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return 1 + xdr_quadlen(self.maxsize)
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        widths = ["XDR_unsigned_int"]
+        if self.maxsize != "0":
+            widths.append("XDR_QUADLEN(" + self.maxsize + ")")
+        return widths
+
+    def __post_init__(self):
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
+
 
 @dataclass
 class _XdrFixedLengthArray(_XdrDeclaration):
-- 
2.46.2


