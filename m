Return-Path: <linux-nfs+bounces-9179-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 217DBA0C070
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 19:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381DE18820DA
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 18:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0EE215047;
	Mon, 13 Jan 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai8U5LSD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2D214A93;
	Mon, 13 Jan 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793374; cv=none; b=OPFGQDTE07tQZ1TBGFNLLnvqtuRtJSJ45I+Bh2YvabZKPw6B+A2KvLqbpVS+9skbEnG0ucd6VJrePKs28DjyWgM7kabwj/3EPjZOmEZve5BO4KJqhLca4KY4ujPdG+6h7uKkCgg9cQWcvw0k0fQa8u1c7RN8bbuX/bXGm8UfZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793374; c=relaxed/simple;
	bh=3b48l85dvIUMxPN97cnDejNJMgKXH/p1dqq279eatcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0Y5eISP95Q3kZYIVT1qTmaIhLJF2vNtpA6bOqrQ26tw69CBfAPcnQ9H+HC+9KMLgCzqWeKWvd3IaaJYfRtMvQOeeDbkHajjjNnVxhL2kROJ8t9kTp0ab7ocOBz01dmGTxrfAUd/M2mD+VFGaKnl2OOaxW1iUlfeVZ7X2U30A6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ai8U5LSD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C05C4CED6;
	Mon, 13 Jan 2025 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793374;
	bh=3b48l85dvIUMxPN97cnDejNJMgKXH/p1dqq279eatcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ai8U5LSDSUNV8443s7Hl3bphm5wzSqnbNIFfdglBx5BYF9CkY/+4Rs8HkG2mpuHty
	 O+GWiUB2nU/i4Kd3olp3J8qC1Hw8QIiarkcfmIfeMUNtdEgOnoupcdXHXAmPYKiiLE
	 WcgFi5l9aQdlXydyC5rUphNYuaALdrWmeLuyZIMrN7m954lcHQDOT1pV7JvX4/MeI/
	 s4EeM5m9ctRV7PEufjTWlsDi8sYS3sPeZiDZEs+KIO7y1/owW/6YdJ6v2WPKgD/xft
	 eOODTc3aHmnINyAyxd9kpDbYwrXlp5d8Kn6DsqGyCHuG29+6lQ2rFXhBmiE8rHIh7t
	 7lXxuwM4ZBaFQ==
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
Subject: [PATCH AUTOSEL 5.15 4/6] kheaders: Ignore silly-rename files
Date: Mon, 13 Jan 2025 13:35:58 -0500
Message-Id: <20250113183601.1784402-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183601.1784402-1-sashal@kernel.org>
References: <20250113183601.1784402-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.176
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
index c618e37ccea9..1b2b61ca8065 100755
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


