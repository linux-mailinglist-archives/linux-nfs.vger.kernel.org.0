Return-Path: <linux-nfs+bounces-11079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21218A8363B
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 04:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653597B075A
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 02:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1599136327;
	Thu, 10 Apr 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX14iY83"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD38C2AD21
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744250947; cv=none; b=V3du9CbI3C0ZbvBPCY1yEZh6UY1SRtzqwfMKLnOEDPMPiMTZktjswFJ6J7ULm9+fVnshUC7CfMpw4MnVs3FtSnj5Ua4jN4yC0otGOoygk09tEQAK2vJgNrJlx8qA5e7TYBHEtsGADwxqwF5R2+bJYN7sXBFlynby7sXlD9tRtNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744250947; c=relaxed/simple;
	bh=n16H/jfO4cB4gFr2y1suuFB0nRcXAY1JA/0ODWz+9F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a72I1n8EGIinoZUHV9ggfe08bQcSdDjhKIrv6MYk/Y5Vh4kHgMgXaXQYOKtLmQhToQxOiS7N6sy4Toj94teYx5vBqkEl2uXPD+aKoSuvLII40kkb6T2s8EekK/B7DJK43yo5G82QHuaRMGL/2t6RfohQh7lswrZlJVrDhDiEn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX14iY83; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A3BC4CEE2;
	Thu, 10 Apr 2025 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744250947;
	bh=n16H/jfO4cB4gFr2y1suuFB0nRcXAY1JA/0ODWz+9F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SX14iY83Cv5WpqF0fv6U4ES9JyMnZdz4604lf/JBVF7gPMt/MlFGh6NCKiuDqWnLC
	 OY6qiLBExaIICb08yHOXSKJh0Jz0Q1IEkRorYQ1qefG0OpwLjkWfKqT0ONf7r927s7
	 +10OsgYL8MBFEGG+/7pYlQpFBwwwmdsT6BJh2DuNdyQTzrGAbqvQORhS+1cSFe2xtC
	 dhUS1YHT16n/DfBTzhemH8EfUo9/u1AK04TdoiAjRIZHNxKKk59kCvllayQ+S0yALM
	 UvmrYP1kU+OLv1i+43AiyjMQjYHDsOUhjo7t/mWHnZgIZU3ciJ8ngXN1FrDePKnqTj
	 HhvO8EKmtQCGw==
Date: Wed, 9 Apr 2025 22:09:05 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH v2] nfs: add dummy definition for nfsd_file
Message-ID: <Z_coQbSdvMWD92IA@kernel.org>
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali>
 <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
 <Z-QYjLJk8_ttf-kW@kernel.org>
 <3911d932-5ad3-4cc9-98c9-408818cdb4cf@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3911d932-5ad3-4cc9-98c9-408818cdb4cf@wanadoo.fr>

Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
so various compilers (e.g. gcc 8.5.0 and 9.5.0) can be used. Otherwise
RCU code (rcu_dereference and rcu_access_pointer) will dereference
what should just be an opaque pointer (by using typeof(*ptr)).

Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Cc: stable@vger.kernel.org
Tested-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Tested-by: Pali Rohár <pali@kernel.org>
Tested-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           | 8 ++++++++
 fs/nfs_common/nfslocalio.c | 8 ++++++++
 2 files changed, 16 insertions(+)

v2: fix email used in S-o-B, added 3 Tested-by:s and adjust commit header.

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 5c21caeae075..830078e5866b 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -46,6 +46,14 @@ struct nfs_local_fsync_ctx {
 	struct completion	*done;
 };
 
+/*
+ * nfsd_file structure is purposely kept opaque to NFS client.
+ * This is a dummy definition to make RCU compilation happy.
+ */
+struct nfsd_file {
+	int undefined__;
+};
+
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
index 6a0bdea6d644..f3274a70ce5e 100644
--- a/fs/nfs_common/nfslocalio.c
+++ b/fs/nfs_common/nfslocalio.c
@@ -271,6 +271,14 @@ struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
 }
 EXPORT_SYMBOL_GPL(nfs_open_local_fh);
 
+/*
+ * nfsd_file structure is purposely kept opaque to NFS client.
+ * This is a dummy definition to make RCU compilation happy.
+ */
+struct nfsd_file {
+	int undefined__;
+};
+
 void nfs_close_local_fh(struct nfs_file_localio *nfl)
 {
 	struct nfsd_file *ro_nf = NULL;
-- 
2.44.0


