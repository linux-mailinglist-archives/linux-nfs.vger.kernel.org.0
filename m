Return-Path: <linux-nfs+bounces-15681-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15063C0E311
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B667B34DADC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F930594F;
	Mon, 27 Oct 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkkjH8V0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C425B30D
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573397; cv=none; b=NS9dN0+YWr2yE8aompwrV+27L1K0oKfdpNckpZMdMf1VMEmxRLvXUXHdYNuAhFHD2dtuZ+o9maxpYXQ1qnY3HkjSYq6sSH7a6VksAhxnnGC4iczKkccxdevBxc1/bBL6ao+Lh/VVMQnDvLiF4r12oJXsXzpiFbbBPaHIcK/892w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573397; c=relaxed/simple;
	bh=T1a2q3aqhoQHMXcudghFY8omjzBhhA181uvq3J43iu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwefvFWcHAyTTIa/elWS4cKXezY+Bm+MEiKePehFixUzlym5dAmi2GeXG4wPP/8M8c8A/YvRhVqqKCpQMhJjFK+JUYD8xNjivJEDqtSI+sMgG1lMaeZERdNQEumoFqo8AhWiNnInWudIeQsQnq4j3owmZOYVcLihQfqKKRJ9bG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkkjH8V0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EB3C113D0;
	Mon, 27 Oct 2025 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761573397;
	bh=T1a2q3aqhoQHMXcudghFY8omjzBhhA181uvq3J43iu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkkjH8V0Ve+1wmJcwNVuLPQjFT4knPoPi9AZBlzJSuSk0O+WVsIfjHpPmry5nYybP
	 1UVcQujuFfsiNhtB6FE3pmirW3/KT8Fc98QMpJdGh9ZyrSu+Q0VWu4yhRf18kqJF9g
	 SWQ4zNgNuYiFtkybRCtlXWPy1HFkGKJykcTQkIUBaViWxBIhDhi5czVaLE6CGNA3xq
	 nd1C1g4lP2lWfHBHpJfDWDXOMJcF4BdA5L2tyvUjkdfuLM/Rf5bWh2ueuzGmEfbY5u
	 y1xTOyfOxFT5EO7sX3jMHcwr2xP1QuAvwGvSf8z7F5+6djFfeafLnBRyysJPR/mnkG
	 5SjyovzOr99cw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 3/3] xdrgen: Fix the variable-length opaque field decoder template
Date: Mon, 27 Oct 2025 09:56:33 -0400
Message-ID: <20251027135633.9573-3-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027135633.9573-1-cel@kernel.org>
References: <20251027135633.9573-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Ensure that variable-length opaques are decoded into the named
field, and do not overwrite the structure itself.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../xdrgen/templates/C/struct/decoder/variable_length_opaque.j2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2 b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2
index 9a814de54ae8..65698e20d8cd 100644
--- a/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2
+++ b/tools/net/sunrpc/xdrgen/templates/C/struct/decoder/variable_length_opaque.j2
@@ -2,5 +2,5 @@
 {% if annotate %}
 	/* member {{ name }} (variable-length opaque) */
 {% endif %}
-	if (!xdrgen_decode_opaque(xdr, (opaque *)ptr, {{ maxsize }}))
+	if (!xdrgen_decode_opaque(xdr, &ptr->{{ name }}, {{ maxsize }}))
 		return false;
-- 
2.51.0


