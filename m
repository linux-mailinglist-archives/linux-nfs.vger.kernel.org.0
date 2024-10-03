Return-Path: <linux-nfs+bounces-6834-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D1998F69D
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5C51F25CF4
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BC51A705E;
	Thu,  3 Oct 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMVb/gHp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13176EB4A
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981802; cv=none; b=Uv1GRrI3ECUxkALL0JHdZcxX4XcN4dNHJKzw1YzS2n5xfiQu7snBRfH3HOuEgzsrAd2SND7OlmPJkR+7tSrM10BzVMi/6Syv0mIgFtqHRt+sKoPknSppoeP2PA+ZIMlHltt8sObcVi4zS0DrgDmmM4DzbVZZfktuA4rVkpDKGEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981802; c=relaxed/simple;
	bh=0+PUm9bD/Z9aDEFRgodi0+MqUkWZ9gSLz8zL+lzVuG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9FrDQmCxPS6ZDZ1RhZJiuaysOx/fX68AZUJHjmTeXc0rgtjeURr2B8R0zwTnh4AkBIyS/BumLR7rCellwQDylag7EPPNuNGGaMo8M6GcIIVTjsUGPjHqDq3QrWBKZs6kV+CIkOiP11neghdQWerCJGLcME68m+hUwP8Lr7qIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMVb/gHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF98C4CEC5;
	Thu,  3 Oct 2024 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981801;
	bh=0+PUm9bD/Z9aDEFRgodi0+MqUkWZ9gSLz8zL+lzVuG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMVb/gHpDoiLn1klLsE+8fWPpFJmLPDebzSTYfEVIBn/aksirfpq42VZ1SGypV3vK
	 N5rkpwX1XfQ5SGg5HbEnV/f2sGvM98L1E4jdp377zJUm5lAO4U/AP90xdLyp+gcNL0
	 2Zy+h/QJFBzKiwsQLkktTPOD0OePCpIYQu+8S/yYC5MWu+aNX37uaTG4Y1JSXY9a7G
	 n65B4DeDpAp5QOqZX515BRElwT6JwuPNV55PAqKGqNn2dnh0iRHISXRYPqs4clmf4v
	 8tES4uHtZS+Qtow5DBEFTQOcPFR1NFGBGf52t4S9QpXD11vOMHcnd6COgO75cjOAMy
	 C0E2mFGfHrPFQ==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 09/16] xdrgen: XDR width for variable-length array
Date: Thu,  3 Oct 2024 14:54:39 -0400
Message-ID: <20241003185446.82984-10-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003185446.82984-1-cel@kernel.org>
References: <20241003185446.82984-1-cel@kernel.org>
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


