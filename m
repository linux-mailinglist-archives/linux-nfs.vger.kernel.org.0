Return-Path: <linux-nfs+bounces-9785-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C87A22F39
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CB4B7A1435
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 14:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737B1E98F9;
	Thu, 30 Jan 2025 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EefcbhtR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05F1E3DC8;
	Thu, 30 Jan 2025 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246782; cv=none; b=XbZw56gnhL2KkkYzm7lA50jsEl+N+0Rt/v2sN/JOceckFiey4VrfPxIx4H66x5Mnn6mYAH+F4WaRW/MPdCEffiNRxYhs0WqCv8j51IgMUVLa/mvaW7m4nSNvVni+P4pMEP/tOyrIaBPWQFaMnweBsNzgDrUeXY2Yzc5l6v+hcKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246782; c=relaxed/simple;
	bh=Bsv2iW63WoGZ0KDHVebw9lAh6mApNHHvA7ec+yONvMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7MNtg3XlX/qefNJe2yb8PUuacsYJsm+fxAuSRv4eV8td8IflVgVJbI/yVya0e+ZZJemT3usj6Ay8xQIARqiH/+3WBPHQRTu/N4/gN0+VKtstyDuvy/kZxDX/8xEZbzVKQPVQPawudpDjoId88Y95q74+QhAdLL3uBLD0+q+W0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EefcbhtR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DECC4CED2;
	Thu, 30 Jan 2025 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246782;
	bh=Bsv2iW63WoGZ0KDHVebw9lAh6mApNHHvA7ec+yONvMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EefcbhtR44DhcdKa6E9/2GIJJbimTUz85PWezw6rndsQ0uOPSfgf6oCWtjAIpKu3V
	 z/YXckvkh+Lt2InU4etX23B5vWXlPsA8Tjb6r8tF98N8wXdT+dxpHkRZeEw5G2TDE9
	 NauWqQTSo5IWfSpZBJzzcDDD9E4tZXHY0xP6FINM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 65/91] kheaders: Ignore silly-rename files
Date: Thu, 30 Jan 2025 15:01:24 +0100
Message-ID: <20250130140136.291051235@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140133.662535583@linuxfoundation.org>
References: <20250130140133.662535583@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 206ab3d41ee76..7fc44d8da2052 100755
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




