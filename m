Return-Path: <linux-nfs+bounces-4283-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEA79158A9
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 23:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F11BAB207B8
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 21:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C11A01BD;
	Mon, 24 Jun 2024 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPqnN8hv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C419AD93
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719263670; cv=none; b=PYGhvgbKezHmGywTAoFNm3PY3nHd9J2zsP/DWfgRJUZdbRj6vg95l4Z8dtGa1kH6iLSitqxFTel1Z6nX869nunVCHPfAnAjI18CKPqKTghyPhlvzR98wOYfSO6UbwaI9Ht0PB12Io5JQf5MLY932ZllgejPj2erSwMx5omHkhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719263670; c=relaxed/simple;
	bh=4RQBqRUSNxjzHncQ0QYq2XDe6G/NCxmWF8SJKYlm2mM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TOAuPfcs5NNdOlca2Pt+MRrfxKa9YiWXdZCMSW5g3liDssKTwkcrLwdSsBJH1WkAsP6AGt+vrQBQdgnaW+AYHX12TYmc/3Sn6ac0wwZtRrfZsu5ufhmByym/jNtcMSzyn2Er4JoXDLzMDtnYZRTXEtXuOoYz/e7Yy/QQrDUmWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPqnN8hv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE0CC2BBFC;
	Mon, 24 Jun 2024 21:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719263669;
	bh=4RQBqRUSNxjzHncQ0QYq2XDe6G/NCxmWF8SJKYlm2mM=;
	h=From:To:Cc:Subject:Date:From;
	b=WPqnN8hvX0tRzd5SDi10sDqJvz4ENArNrTuEumtcSQCXnkphoFHFYhwPapi1Wx8BJ
	 Y/EcvbDaVrq0oLMoJuoSmW+kQG8AvB4NzaaC3smhYxE/vgAckrFbIxVwQQPzSYDduF
	 n8vdtOFdiyVSLV9hhmgeDu+3oUA3DcNE5ql9NuoLYVrs5+A8tskKwWrvRZNOva9ZMw
	 j7MbkStvUu1gEIT46CJN6HJ80KtQhQt3KjlTwu4CjH/Tf0M/ZjrMK8md2IH26YFC2q
	 88WuiqkI22lDjsw2S4EV7KEcJDLgExADBsNOuB17lCdMc4AVd3z+PHkP++Kbx3tdAl
	 bllVyC8kInc0g==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: [PATCH] MAINTAINERS: Add a bugzilla link for NFSD
Date: Mon, 24 Jun 2024 17:14:16 -0400
Message-ID: <20240624211415.262398-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=958; i=chuck.lever@oracle.com; h=from:subject; bh=bqED3cZ26lsPwkYX1RzwNcoLZs7oGGCtOU3oyBnJw98=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmeeGncG0nQfKb5/SGvD9daw1+IeH86MaTJUkfU GVmFazQbBCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnnhpwAKCRAzarMzb2Z/ l5+gEACs5cjNTjCSha3LlREndFowsUCAXgNDtJdSFwHv0yY8z8+e6xq6qqiMPjXK5EkrWYFn31I Dsni+YH6/31gkQm6KAyF+mbBfKhMDqpCw5cvAys0o2yiOjpxuNJX8g38mIfOk75oBd7u/UcO+nV tPGb4ylGEMI6+pa0W9gLRA2HUk5EAZm7HSetZ87AfitGyYDyku2f28G0mYILNbKcfvJn+elaN/u 0lCtj9Vc8zwlYkgfULCiulWji4T0L7SBQeY61lXU4VqMD69DyLhglStGSaQJf2Rgm8WQSUYZb5b oQtn44BVUN00iXFb0JeVifDNH0QSuP2UWC8UFsYmzJfaxhjGaw6IxvcUnFV8+1f/6gMav8bzKUn adcAC+yGOG2waYS2ctNfbPVo0AG5nemHMVb2/608P9ZK6PTTxUZJhYiNWvBqbYtgu6SDx1MY2xq XmWcQLRRIEnSRkr0fEIEx5EOobPSuag4N9zQlWw9lzyIVdlUR0bu10uoRSZrzIGlH64LoxddSlK CleVROhGValzot+WqDBFGV10ZARoySFmtExyz3tYa/ET7m//OGVgYlysVFwmQDprcLOdzMnEfX8 T+6PB/sYsTatNkP2x7TcYeu2pvxO6Ja6mT7xpPvv2DM+Ccq8TI+I7wu4XqmThlM2YVtIyIBxYvm Lz0Ro3NYLL3ORSQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

I recently found out about B: for noting where subsystem bugs can be
filed. I do pay attention to bugzilla.kernel.org. The Linux NFS
community has decided to steer kernel NFS issues to the kernel.org
bugzilla instead of bugzilla.linux-nfs.org.

Remove the W: entry; the sourceforge information is stale and
unmaintained.

Cc: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ca8f35dfe03..a91e510bc303 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11980,7 +11980,7 @@ R:	Dai Ngo <Dai.Ngo@oracle.com>
 R:	Tom Talpey <tom@talpey.com>
 L:	linux-nfs@vger.kernel.org
 S:	Supported
-W:	http://nfs.sourceforge.net/
+B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
 F:	Documentation/filesystems/nfs/
 F:	fs/lockd/
-- 
2.45.1


