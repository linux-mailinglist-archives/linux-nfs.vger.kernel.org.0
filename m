Return-Path: <linux-nfs+bounces-10909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA25A719D0
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 16:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658667A6767
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Mar 2025 15:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8E1F3BBD;
	Wed, 26 Mar 2025 15:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMU4nPFG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298B014831F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Mar 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001742; cv=none; b=YbRlVLLImHJ04bMJcrgIfgolOl6HzW7ACG48Tbz84v/gIJBhP2HmMCe6EsiakSkOtW0R0JaPdupdck+lQm2/o8lW9ZYg/XOO+/3SRrjfLEeOc2h/cWDCuNENqARTLLQohD3plxWaHFizZ5yX+zPiOPXhQ7HGYLCXUlU5MimlxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001742; c=relaxed/simple;
	bh=nWrSzoUuCGvlctFgTlLRf8dh+g1ib0mRPHeEA9Cal+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCiH8N5ea4wUlO1SbATW9nE4dELu2q6MFZCvvILX16pgb56zH+hr2gdQ7tFZG4ICIzSec/AQoULwOb+KaAMg5iXIbErrXK6WpEdVHBfxcGyaZhRGYKT++aQENpkp2B5Q5OqcGEgPoJRJGknFywp38jaFJB0RkuHF6oHj6uYaCkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMU4nPFG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D48AC4CEE2;
	Wed, 26 Mar 2025 15:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001741;
	bh=nWrSzoUuCGvlctFgTlLRf8dh+g1ib0mRPHeEA9Cal+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMU4nPFG7Oao0U5u6tq5UUC6REMaZHK953xqoZn83whfskV2Jidr4S1unsVv4cUyw
	 mtYTrKVRy8Kmes8vm1b7vI5bydE9OdDU78xqUyxREaXxr9ta/Chv5Kja6Doc0XGRPn
	 HailHqZBbwFYuzW5b6zSYc4aMirRy15jBad+NUZsNTf9swIV79REWijQx4U0L7UfmR
	 v99rhMfWG3JtNzygmGA/8JGAyxeOKYy0WHOVtxdYMf9UI0vY2mzy6VWOcQKy0/DVNz
	 OMsiQl8LQ4ui/fTPZ4excqJgqM5GROmqAXCK0FcgvW0pJ/TdWiynIP18GLNBTfVkXI
	 uTyNqRPkF9AAQ==
Date: Wed, 26 Mar 2025 11:09:00 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfs: add dummy definition for nfsd_file
Message-ID: <Z-QYjLJk8_ttf-kW@kernel.org>
References: <20250215120054.mfvr2fzs5426bthx@pali>
 <4c790142-7126-413d-a2f3-bb080bb26ce6@oracle.com>
 <20250215163800.v4qdyum6slbzbmts@pali>
 <a8e12721-721e-41d1-9192-940c01e7f0f0@oracle.com>
 <20250215165100.jlibe46qwwdfgau5@pali>
 <20250223182746.do2irr7uxpwhjycd@pali>
 <20250318190520.efwb45jarbyacnw4@pali>
 <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ec5e8d-a004-42b7-81ad-05edb1365224@oss.qualcomm.com>

Add dummy definition for nfsd_file in both nfslocalio.c and localio.c
so older gcc (e.g. EL8's 8.5.0) can be used.  Older gcc causes RCU
code (rcu_dereference and rcu_access_pointer) to dereference what
should just be an opaque pointer with its use of typeof.

So without the dummy definition compiling with older gcc fails.

Link: https://lore.kernel.org/all/Zsyhco1OrOI_uSbd@kernel.org/
Fixes: 55a9742d02eff ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c           | 8 ++++++++
 fs/nfs_common/nfslocalio.c | 8 ++++++++
 2 files changed, 16 insertions(+)

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


