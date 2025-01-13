Return-Path: <linux-nfs+bounces-9180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F105A0C082
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 19:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B04169104
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 18:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA418223713;
	Mon, 13 Jan 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqu7iAwM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067422370A;
	Mon, 13 Jan 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793390; cv=none; b=cF/x4+tAjxltbFUJF1nDHkIhUOP2qQ/2EN4jl58lkP6ZizcvebxnBAgXJuCREBYGmYZrbHjzkmWfqubO2HvubCMZutU0c0LpzeAds2BAGs+juG0vTlU6Ee19AjaOEk94NbRzxn96/icXchVFe/ALPnQswylcbPzndzUnQangGK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793390; c=relaxed/simple;
	bh=4QcOoX8RQgj8Dk9IljYu//Uk97Lg6dqLflcZhL4JsTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qiFaCcTJz0C/9mgqAfIAKylW4wEwT1XXnQoO4zryVWb2zna5E8RiujwfbHSg1Nnc/hkw2uU+aFb9IN5bQZZtxx42pOE+djDtAjvqHfxeGlBpvwdqvUbSPlrIUYZwfpOZov+6UOzTIuMx8H6qOb/3msr9iqKOOcBs4N45OK7zLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqu7iAwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5914AC4CED6;
	Mon, 13 Jan 2025 18:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793390;
	bh=4QcOoX8RQgj8Dk9IljYu//Uk97Lg6dqLflcZhL4JsTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pqu7iAwMcA0kwPhsdvO67OnfbB9lDpc1LBr9NUcjnZVsPJYJIKv9cxTyLHm66EWeP
	 xRtsrkiFbGBCqggYm2X33GG5NtApFazvikoi0NxL0FWr+wI5rY9fgUHN+zEVqBoyea
	 rOg4oZocEwTjHmsgOZz6hbDfdP4RpSFPJzGiKbxuIsR1YyETqcNxB7VMqDusvozMuc
	 s9al4ZPHs22p8o96IN6Vw0SdrrdVdbTVxvQ1Iq6N/1GpKpcWo15caEpNlRGA5meitf
	 B01WGFVsX08mchYqY7wzekJ6siWfwG2w8kyX8Wdn34NTkzP7TsIEAuhVmoR0i66O3c
	 ExBl4DNefBHKg==
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
Subject: [PATCH AUTOSEL 5.10 4/5] kheaders: Ignore silly-rename files
Date: Mon, 13 Jan 2025 13:36:18 -0500
Message-Id: <20250113183619.1784510-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183619.1784510-1-sashal@kernel.org>
References: <20250113183619.1784510-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.233
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


