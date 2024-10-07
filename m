Return-Path: <linux-nfs+bounces-6912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B49935AE
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 20:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2E0B2099F
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F031DD553;
	Mon,  7 Oct 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK2kzakp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE71DCB3A
	for <linux-nfs@vger.kernel.org>; Mon,  7 Oct 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324477; cv=none; b=FEJ2Hj/C3XSTnht0z1F1yLlSUvGbM1DABNVr91d+MXkJs+YmsE1H3EUWUtHo88Wc35lBQRbhoOXLZ2hyFvPBIivrwWFlxnVZ57QH4YN6I6ZEBScz9XP/0otXeRIoW5Dqg3R5qkevMOAm7d8BeYULWM5mTnN4u82MzfV4EBBBOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324477; c=relaxed/simple;
	bh=tMRmWY9VxYBjrs1SPSYjEqj8vp/mCckGXaR2pqoknPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5tIQXUocM4pbhssnnxai31BAphHdyPHJJQx1/QUxg5husjv7a2X3axEd/a7/tYEQ3JOnZr/7RPoetGxnoNrfM2ro9h3yarJxT0kql01vwazPK8UwHSofWmXMIsVy3N83Urhstkd0pjXo9Pp7o7Bw5hdg71RyrHrHEKbdNTdfyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK2kzakp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6024C4CEC6;
	Mon,  7 Oct 2024 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728324477;
	bh=tMRmWY9VxYBjrs1SPSYjEqj8vp/mCckGXaR2pqoknPY=;
	h=From:To:Cc:Subject:Date:From;
	b=NK2kzakpw5cQRog1kxSTyQo4RyTesY870RG7RZCLL2/DUR2G68o+mDu0zYrQld+s1
	 uI8oTy/86LTqVhCv4ulMRg+4gOaxUfBOyJP3C26i4JCjmSiZAxHd9agG9jqmKTyso2
	 pHVp6gDVwwSMkdeDoyFRn2/b6W6OmG3KVpL0TDlPxLJ8vn4g6qJApEbtPCQkj7h2yz
	 Xr9rFu9QrphVVXU1BpU9rpM5ZsCuoN79tppEK0HO9FYDvB92nE1t3uLzxfE2V6weWN
	 suZVkV4GY8NiMyheaTazBhe+UxEsEOGnzQjo14lSHZEjSDF1lDlmqMqgKf0Ze/ezDN
	 OGb7ilfdb1O1w==
From: cel@kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] xdrgen: Add a utility for extracting XDR from RFCs
Date: Mon,  7 Oct 2024 14:07:54 -0400
Message-ID: <20241007180754.112429-1-cel@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

For convenience, copy the XDR extraction script from RFC

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tools/net/sunrpc/extract.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100755 tools/net/sunrpc/extract.sh

diff --git a/tools/net/sunrpc/extract.sh b/tools/net/sunrpc/extract.sh
new file mode 100755
index 000000000000..13b0036eaa81
--- /dev/null
+++ b/tools/net/sunrpc/extract.sh
@@ -0,0 +1,10 @@
+#! /bin/sh
+#
+# Extract an RPC protocol specification from an RFC document.
+# The version of this script comes from RFC 8166.
+#
+# Usage:
+#  $ extract.sh < rfcNNNN.txt > protocol.x
+#
+
+grep '^ *///' | sed 's?^ */// ??' | sed 's?^ *///$??'
-- 
2.46.2


