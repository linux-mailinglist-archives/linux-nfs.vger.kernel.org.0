Return-Path: <linux-nfs+bounces-8991-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BBA06747
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 22:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2FE188A583
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 21:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13B3202C58;
	Wed,  8 Jan 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTfaz2Vh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4520468E
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736372249; cv=none; b=qK/fs/ZQ7OIbmG3EV/kPBqE0WHsUSg/l9R24+C8aXWX5BPNX6HJyXXNQLZRgB6Rleb3RtjNuK+zmbiuuqO725cg5h/TbZVnZQazGpydrW0BRm4MFzi0irLB0yV/y23GW5ZtohjvFEnFqTSuH+xF7ZGJKmdpFlGQy3KlIzWqMzZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736372249; c=relaxed/simple;
	bh=HXmXUXLSrd7RgDLMydjovtSkU8JwcPnmzJgtXPt5m9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhnWrY9nF5d/T2DXfFVouKjX8TNP4VU8Naz2wKKDyw2LKoGaWVIqkuSn19zQruDb7Z+COWl34Raf6525cJVkIGqGH0kStnGjMt6bvjRyeg3gVVfxiPIFxJNvEV/fNItkFzTeSjy0C21/ZjxPgP+34Kce32xFZD9dHItIyrP1gPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTfaz2Vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA80DC4CEDF;
	Wed,  8 Jan 2025 21:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736372249;
	bh=HXmXUXLSrd7RgDLMydjovtSkU8JwcPnmzJgtXPt5m9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gTfaz2VhMJMHTkH3eHW+BotCZ/ZRbX5jRKTqw8Fi/w35eNwhcW8PGZ7sUdVLk9VhX
	 SyfS1rBisz7lQw1vZUuPkN/rOmUcWK55//BQIb8uCg4FhD73MfM7kca8TF52MBd7z1
	 ZDI7eRkx0dvmWxsxyTe3UEzHu1wK2Dn5y2YWwsps1CDaDfdZhsCFWbJdTkUI+U84Cu
	 PbcZKbCvbWIz//Fa/WRh7PRg5Uu50IAgVkl+kLTR/enu0P37e4W0VGoWVnc916/hEj
	 QixlYoAEQcazrCL2mLtORnDOs07/s/z9bdDJagFW1AIloJt9/xSpqiJJLlzPIfRZoI
	 Q8q+/cz0szstg==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	steved@redhat.com
Cc: anna@kernel.org
Subject: [PATCH NFS-UTILS 03/10] rpcctl: Fix flake8 bare exception error
Date: Wed,  8 Jan 2025 16:37:19 -0500
Message-ID: <20250108213726.260664-4-anna@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108213726.260664-1-anna@kernel.org>
References: <20250108213726.260664-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 tools/rpcctl/rpcctl.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/rpcctl/rpcctl.py b/tools/rpcctl/rpcctl.py
index ec43d12afc41..c6e73aad8bb9 100755
--- a/tools/rpcctl/rpcctl.py
+++ b/tools/rpcctl/rpcctl.py
@@ -23,7 +23,7 @@ def read_addr_file(path):
     try:
         with open(path, 'r') as f:
             return f.readline().strip()
-    except:
+    except FileNotFoundError:
         return "(enoent)"
 
 
-- 
2.47.1


