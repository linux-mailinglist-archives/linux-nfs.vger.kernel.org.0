Return-Path: <linux-nfs+bounces-9178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE3EA0C04E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 19:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD381887E39
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394B20CCC4;
	Mon, 13 Jan 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNTjw58a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5B20C49F;
	Mon, 13 Jan 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793348; cv=none; b=AvLWqDetV1MuW6Ex3T36+daBAoIQLqPzks7N3JibRuXHWzsXerfa7QKJE4CIGVv8Ep0SQR5962ZhZyEqdoqjPsO5NQhsznMNfGy5pkvNBeHl9h9JIXhEuse0+ndbhkXNF32vDSpFQfT+xbo4eweTd2SaVtyZDrEO60wdr6b/uXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793348; c=relaxed/simple;
	bh=NweWt3/VFkOQG4Bzl/1bOMVfAobk9wNdlubl0XEoTUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H28zBXRqLrof1m2thFRoERH7/Yesbi4xYlzEL/dTGyQKjWdO3fm3XMTw/f/cmiAdOhJNQ+TYYZp5zLRPuY37cYWsz+OVUU7ShdpO3MET7gotoP1oNCKt4go98dzUnLcB96R9O0nVdKMdxbQfKFdAijp77rKKFGeALEBON5NBBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNTjw58a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BDDC4CED6;
	Mon, 13 Jan 2025 18:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793348;
	bh=NweWt3/VFkOQG4Bzl/1bOMVfAobk9wNdlubl0XEoTUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aNTjw58awZxiNFhLX15R328lOKibNBUFU4mE2ece64nuQzyyxDcY6yJrwkDEIqThe
	 FwKPkr95Ywy+w+N4dqGm5B5CMYoflCwYNNS0avHppQm0OeyWsTOGUoqporpFjgK5hu
	 EufZGu3ealEqPmhDLpVEtip3DDT+2CmLxidQ1c60ylPrVIsy7xyrVGRZXuDVbiBSSh
	 Dh8fN9j8d3AIT4tLTBWPkN+A3yCZlnSRuoOO1scS/U1XJ3BMxwWZsxJDoaowHPFkI4
	 KlRu3sWStQLqC+5/S7KAwEEA8Ol9TdRDoB7Gqm1bM3rrLNR5nUz51PLLdSx74Z5rMJ
	 OrE96fb1AznAg==
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
Subject: [PATCH AUTOSEL 6.1 04/10] kheaders: Ignore silly-rename files
Date: Mon, 13 Jan 2025 13:35:30 -0500
Message-Id: <20250113183537.1784136-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183537.1784136-1-sashal@kernel.org>
References: <20250113183537.1784136-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.124
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
index 12bcd08fe79d..5d506c6e8c0e 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -82,6 +82,7 @@ find $cpio_dir -type f -print0 |
 
 # Create archive and try to normalize metadata for reproducibility.
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    --exclude=".__afs*" --exclude=".nfs*" \
     --owner=0 --group=0 --sort=name --numeric-owner --mode=u=rw,go=r,a+X \
     -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 
-- 
2.39.5


