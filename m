Return-Path: <linux-nfs+bounces-17411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B88CF0323
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 18:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4E53301339D
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D24723E33D;
	Sat,  3 Jan 2026 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTbKOE9z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655922A4EB
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767460503; cv=none; b=icWT+siUdeOWANROR3Silc7dHQwfrc3Lv218N1GeXqv7Ckvcn6kni7gJBDvViFyo348Boekxj6pi0dWTwYcecoFqxsUfbodY50OxRMZ3F3HIKE1YQE96NBoN7R8gc2oVXNeAMJKTn30nbacbtlumA/fjs2WMs8jzcoHzw7zfudM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767460503; c=relaxed/simple;
	bh=0vUJTHE2KSWHvcmOFnkMnP3miUnGNYxk/vLrkS3TALM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUhbJkf0OlsHA5u9U7bEhgD0IqJkvkHpWQJFDKsLNsdpZ8irBU7ywoG3DOLPcR5RhOWsBUQTXKVKu5IVk+nf3FyQ99IGvNy+EguwAxGoZ4ahtEsLQ8wHScxczv/GITmdDxzTStHv1M/zWQ/yJbA4oOaTOTimIX8WtG3nEcSOLeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTbKOE9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B8FC113D0;
	Sat,  3 Jan 2026 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767460502;
	bh=0vUJTHE2KSWHvcmOFnkMnP3miUnGNYxk/vLrkS3TALM=;
	h=From:To:Cc:Subject:Date:From;
	b=BTbKOE9zDztfT7j/SYpFHRZ5VYcjEulmEc9AXLhfwCsAQuL/+ppN3HsTHu1SnfEKp
	 nqMDVgYDlrPXyfUb2lR8g7DKbOrypTbAhgX4Z+ZkEF8rIt705hWQhx/3VpoRYA+6bt
	 DxfTcUiesK/gYy/S9IZrjY7bALoQLlPFIo/1AWYoNLiHtoA/vts4f2IcDe9M9ZnTPM
	 IjGschXt5RqhkacImaM8hVg4U7ublLBc8pxI0T9dovLvQQWKh3ffANL2GcmOVN9MtM
	 eB9jjPwweQ+WRccdJd7tpn5yKADvYyC91Zpuydb5vX+/ohVtTXF5ml0SMmNubUuhbh
	 /tAgLm0uT5v/A==
From: Trond Myklebust <trondmy@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] Fix misc localio issues
Date: Sat,  3 Jan 2026 12:14:56 -0500
Message-ID: <cover.1767459435.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This series fixes the following issues:
- Data corruption when localio hits a transient error.
- Short write handling can trigger spurious ENOSPC errors


Trond Myklebust (4):
  NFS/localio: Stop further I/O upon hitting an error
  NFS/localio: Deal with page bases that are > PAGE_SIZE
  NFS/localio: Handle short writes by retrying
  NFS/localio: Cleanup the nfs_local_pgio_done() parameters

 fs/nfs/localio.c | 106 +++++++++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 40 deletions(-)

-- 
2.52.0


