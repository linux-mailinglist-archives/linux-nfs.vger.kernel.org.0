Return-Path: <linux-nfs+bounces-6829-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F798F698
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 20:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB9C2842DB
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4FD1AB6C3;
	Thu,  3 Oct 2024 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKewUetz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D731AB506
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981752; cv=none; b=o1aLv21jeYBwIgsUlY49YoajbqOEJ6oS+9SM9CO/YwKoXHB++RP06sOu6T8vQOxXekUM40e6X5RNUa15vvyXk+jhRZCrxjnNjIeYMUfp4WgMTaHUjoV6YefOHhUn9YVbZkSgswOiLPvKL4f2Q+CotUYRKG6Zu0a6sr5F2cCcdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981752; c=relaxed/simple;
	bh=SoSWvT0n8eQFx0vdcmEa/oaMA3v+0uKf/pAk5pq1oZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYnzGe+2wmbv7U/9H09YQqf711ld498UhJ60IKm3mBTJR5v4fR1/mNEQ/qBkPohQ5lljh0YJg+B6qJo093UXCd7mD0L9v8C/sNG+Ursro5L33sgZeCgEV7J2HPwuk3gswNFZAcGTGIVRJDQiWYzOlfj0Lmpx/tDfnXPSmAczxIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKewUetz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFBBC4CEC5;
	Thu,  3 Oct 2024 18:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727981751;
	bh=SoSWvT0n8eQFx0vdcmEa/oaMA3v+0uKf/pAk5pq1oZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKewUetzV702WNuJ9Gn+g7G6Kkf9pJGQif0Ju4ZlcZEo9hCIpiT3fVMCmel7Daadc
	 9S4OOlaQ+3cwjagfsAIFjAsAuSeuBKM95uT1ZTMWM9jcYGP7ZdyqHs/n08eFaLnWfa
	 U2vJjjq8FWMTTJH/NzPNDuO5xwOxr2vIjq9+xA08TE3Ibd9GKhQIdFsHBunI/616fe
	 qTZ9Oyk9LsYu8kKM0bLX5cjoj9q2nruM7Vw38Bmi1B9Qax85WVRFBtYlUgiVBmo7xR
	 5QTsoz7fnez9rti9xcZ+SsGkfBZUTm/QCbCb5hF5PN4GjlkUVmHB83VVAac2lOJ0g1
	 pvZNCTBVe7fVA==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 04/16] xdrgen: XDR widths for enum types
Date: Thu,  3 Oct 2024 14:54:34 -0400
Message-ID: <20241003185446.82984-5-cel@kernel.org>
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


