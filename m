Return-Path: <linux-nfs+bounces-6844-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA1D98F713
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 21:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6C728337B
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Oct 2024 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27171AC884;
	Thu,  3 Oct 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCenL5EZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AE1A727F
	for <linux-nfs@vger.kernel.org>; Thu,  3 Oct 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727984108; cv=none; b=ZELKyFs9ZwYFuscXqVK3vCLl9vsT6JZG7DopOTTqAVqAXzEylvY2BtsBfnjlB1HpSLcyLiuu4oXOD5Hmpn3QfgxgQmx/KzhX2sXktxv+qpZnE7XaflGtJ4DuuByzfa0N7sKwKZZD7VdKrcxxhNma5FvGNycQamp7OlIc46uP+Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727984108; c=relaxed/simple;
	bh=XPyoE9dVY62vPXx3WG6hzS+O/HREZFHslty1olFBUd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sapppmdngj2QQ26SdT/VmpiqrfcZhuR2PfGNisVB0mSJ26Qn4VDctFpuWduSUg+MM3luuyeb0C9ScZySuoatgmd/oMHzBZi6ZuzRVGllMYEMakEyS1WHeJoEoEd36O6AVqL0IU6B6TF4/HX9bpSY538vHRMpnImzsYvf8FztUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCenL5EZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A92C4CEC5;
	Thu,  3 Oct 2024 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727984108;
	bh=XPyoE9dVY62vPXx3WG6hzS+O/HREZFHslty1olFBUd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCenL5EZMr/nA0+LlZCBKbVw9taIcMw+uF1nwRwJiF7O/XkJqP52IGbIgNZ8KS2/r
	 mf0/8GH3Vj4QWZITHqPdhgWJWXJrA6ph5yFWrHEd2Sz27VBkPEyLo+EV2iIp1ba0Qr
	 k7++ZwgvMfyCpvbLQqZtS7vYk6EL20BrbVIxFA+VQYT0bHNQ4MKhhvFjkcXwDek5l5
	 c1z/JR8cIui9uIjlZ2vZagPuGr0BwHpstjglSgrUiBe3Es0uSmgHUM0YMevvdJaD3j
	 yjyt6PeXoYkCTRnPL+yk4Tx+bt6N2DNAI2EaKHpGlm7vYmmM5PJf15rqtdLFyY+wuv
	 qwO/x76w38aKA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [6.12-rc2 v2 PATCH 2/7] nfs_common: fix Kconfig for NFS_COMMON_LOCALIO_SUPPORT
Date: Thu,  3 Oct 2024 15:34:59 -0400
Message-ID: <20241003193504.34640-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241003193504.34640-1-snitzer@kernel.org>
References: <20241003193504.34640-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'default n' that was in NFS_COMMON_LOCALIO_SUPPORT caused these
extra defaults to be missed:
        default y if NFSD=y || NFS_FS=y
	default m if NFSD=m && NFS_FS=m

Remove the 'default n' for NFS_COMMON_LOCALIO_SUPPORT so that the
correct tristate is selected based on how NFSD and NFS_FS are
configured.  This fixes the reported case where NFS_FS=y but
NFS_COMMON_LOCALIO_SUPPORT=m, it is now correctly set to =y.

In addition, add extra 'depends on NFS_LOCALIO' to
NFS_COMMON_LOCALIO_SUPPORT so that if NFS_LOCALIO isn't set then
NFS_COMMON_LOCALIO_SUPPORT will not be either.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410031944.hMCFY9BO-lkp@intel.com/
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index 24d4e4b419d1..da8ad9aba3e9 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -384,7 +384,7 @@ config NFS_COMMON
 
 config NFS_COMMON_LOCALIO_SUPPORT
 	tristate
-	default n
+	depends on NFS_LOCALIO
 	default y if NFSD=y || NFS_FS=y
 	default m if NFSD=m && NFS_FS=m
 	select SUNRPC
-- 
2.44.0


