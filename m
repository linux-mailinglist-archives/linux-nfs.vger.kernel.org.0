Return-Path: <linux-nfs+bounces-6818-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0C998F20C
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 17:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35650283187
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D325E19F42F;
	Thu,  3 Oct 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7yjaJKp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F245BE3
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967725; cv=none; b=fi3az8vJDLGwLA9MNQoJCq4tohsbxyXBtbBcmEtC5S1g6LDjuMrud96b44bCHqaO3cCgOSwoSttJ7EFkjgRiXpWULqqYJTN8zbNSiMFPFXSnva3BoCYQX10iiD8fq6kac3+FkDnf4UN3rp4zr9hKyn4eQKHBHQTZv0SzbGcAm2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967725; c=relaxed/simple;
	bh=0+PUm9bD/Z9aDEFRgodi0+MqUkWZ9gSLz8zL+lzVuG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fK5J67jxSRaRKHSY7hwGI1nnwzky9i2cgHFw+BpsY48jmLGdFRlV2/pVDtYSMF96bEPbyLjfacR+m1iWXS1jx2F2xFTEz/w27QaH4xM0rNLplLurMLxFc9NzNuT3zyNnzhZuEaQha1ZnfF9HyA7yQSz8qIjRN9GDFNZpbMuNbjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7yjaJKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A086C4CEC5;
	Thu,  3 Oct 2024 15:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727967725;
	bh=0+PUm9bD/Z9aDEFRgodi0+MqUkWZ9gSLz8zL+lzVuG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I7yjaJKpEDIHJ07hiQlcutaIFvBHxBxDeGN2UvyY2W+cbzvi82z5Y9f5+VxFUDt26
	 0u/BNwJTXSCpDCCrbjrXB5MVS11jmOcHdpVRDlRJ/SsIO3NWu9t9D7GUEXkglYy/+9
	 zqxGGDpsRTUScbJzzdY69OWg/zscuEkuNdR/Vc9yXT7pbfB/i3JK8T6MNHQ3WlJLGQ
	 gNr+wJ52GxDvt0M0fOvcHmkwFrKhKsS42vgKzwoG91sbhcj2kR0x1QVHYQHcfVLmfN
	 +xso0OrnHyRYER41XjQmbycCS0oK1d8fxM+an/wP9lez1oWBEYZhPTs+Ykci/RQb/p
	 ySB424q29KoMA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 09/16] xdrgen: XDR width for variable-length array
Date: Thu,  3 Oct 2024 11:01:51 -0400
Message-ID: <20241003150151.81951-10-cel@kernel.org>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/xdrgen/xdr_ast.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/net/sunrpc/xdrgen/xdr_ast.py b/tools/net/sunrpc/xdrgen/xdr_ast.py
index e9bc81e83b48..cb89d5d9987c 100644
--- a/tools/net/sunrpc/xdrgen/xdr_ast.py
+++ b/tools/net/sunrpc/xdrgen/xdr_ast.py
@@ -220,6 +220,22 @@ class _XdrVariableLengthArray(_XdrDeclaration):
     maxsize: str
     template: str = "variable_length_array"
 
+    def max_width(self) -> int:
+        """Return width of type in XDR_UNITS"""
+        return 1 + (xdr_quadlen(self.maxsize) * max_widths[self.spec.type_name])
+
+    def symbolic_width(self) -> List:
+        """Return list containing XDR width of type's components"""
+        widths = ["XDR_unsigned_int"]
+        if self.maxsize != "0":
+            item_width = " + ".join(symbolic_widths[self.spec.type_name])
+            widths.append("(" + self.maxsize + " * (" + item_width + "))")
+        return widths
+
+    def __post_init__(self):
+        max_widths[self.name] = self.max_width()
+        symbolic_widths[self.name] = self.symbolic_width()
+
 
 @dataclass
 class _XdrOptionalData(_XdrDeclaration):
-- 
2.46.2


