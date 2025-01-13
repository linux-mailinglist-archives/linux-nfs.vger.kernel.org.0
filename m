Return-Path: <linux-nfs+bounces-9181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C974A0C08F
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 19:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7363A35E3
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246062253E7;
	Mon, 13 Jan 2025 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4qpcz65"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7E2253E3;
	Mon, 13 Jan 2025 18:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793404; cv=none; b=STZPPeC+tpbxVMoeBhCkayXedqNnrq7Nbl7AuhawWd9vTlTfj/pHGkhwZ87U/m0THqGw1iT7GEF3dqcg8phNS/Czvg/4JwbScAmYIVLp4OlceHUNUcIeQnqlFX80du0tuQ4QUKoLmNnIpVm0w3jT/9VP4/gmczEc27atAgAESks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793404; c=relaxed/simple;
	bh=4QcOoX8RQgj8Dk9IljYu//Uk97Lg6dqLflcZhL4JsTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGlvUPG+V11fxI9Owu4zHGpj9YsUbgaxjXoZDC/og9DIaCnWAKP7oFqwi0CosuaFxZYQwRbgveYng9/xOUC6duunskfUbUVuwNwDIGs1zH9GURQMHhNRzz+rAEYOUrnwIegkbVSHwMBexTSTD+y2VI4AheUpNDW8KH+yZ+qYnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4qpcz65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9860BC4CED6;
	Mon, 13 Jan 2025 18:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793403;
	bh=4QcOoX8RQgj8Dk9IljYu//Uk97Lg6dqLflcZhL4JsTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4qpcz655n7XL36DUZ0tQ++0c8US7HGZA2hgbN3NQr0iNqocMdcCCq+F/foUKd3AC
	 IMPQ7QfoIcJrV8p+b1CMSauN8nuMpZVDmtJ9eR024MiBvLbrXXwVeeDlC+0mMthKH2
	 zlKfHIYR0K0t/1N5I+hnx7ZND/ZXrGw9FoJ6P4+1ht/1xKJzSDHRfCky7V32/6I+N2
	 hRVn731sUJ5SaGB5EXqMEzfQbxV2CvjXv+uZ0Vq5y2AFItI3YaKYD18g4Xp6VrrXsn
	 s7a3Tc0s03by0a+m902r/vWkB/q4g3IirX95h1Wq9W7bLI3IjYeLGKAmg3RaK1VuqE
	 1dTJTPFuwZnqw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ojeda@kernel.org,
	maennich@google.com
Subject: [PATCH AUTOSEL 5.4 3/4] kheaders: Ignore silly-rename files
Date: Mon, 13 Jan 2025 13:36:32 -0500
Message-Id: <20250113183633.1784590-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183633.1784590-1-sashal@kernel.org>
References: <20250113183633.1784590-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 973b710b8821c3401ad7a25360c89e94b26884ac ]

Tell tar to ignore silly-rename files (".__afs*" and ".nfs*") when building
the header archive.  These occur when a file that is open is unlinked
locally, but hasn't yet been closed.  Such files are visible to the user
via the getdents() syscall and so programs may want to do things with them.

During the kernel build, such files may be made during the processing of
header files and the cleanup may get deferred by fput() which may result in
tar seeing these files when it reads the directory, but they may have
disappeared by the time it tries to open them, causing tar to fail with an
error.  Further, we don't want to include them in the tarball if they still
exist.

With CONFIG_HEADERS_INSTALL=y, something like the following may be seen:

   find: './kernel/.tmp_cpio_dir/include/dt-bindings/reset/.__afs2080': No such file or directory
   tar: ./include/linux/greybus/.__afs3C95: File removed before we read it

The find warning doesn't seem to cause a problem.

Fix this by telling tar when called from in gen_kheaders.sh to exclude such
files.  This only affects afs and nfs; cifs uses the Windows Hidden
attribute to prevent the file from being seen.

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20241213135013.2964079-2-dhowells@redhat.com
cc: Masahiro Yamada <masahiroy@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/gen_kheaders.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 206ab3d41ee7..7fc44d8da205 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -84,6 +84,7 @@ find $cpio_dir -type f -print0 |
 
 # Create archive and try to normalize metadata for reproducibility.
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    --exclude=".__afs*" --exclude=".nfs*" \
     --owner=0 --group=0 --sort=name --numeric-owner --mode=u=rw,go=r,a+X \
     -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 
-- 
2.39.5


