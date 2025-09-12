Return-Path: <linux-nfs+bounces-14391-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54604B55837
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB863B0517
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624532BF49;
	Fri, 12 Sep 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsUBPayi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097032A83C
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711652; cv=none; b=Ui/kf/f4G6TeXCWjTZTi0EFlDZCfFGS7t20ItGOO/c7ha0ZxnQDJWfVZXMjaqr83FjKrZt+ULHEIGJp0t6R17E8/SN+cRc308kq7ByIyVaAMnrQptUFdZTe+qV1iXFpgvNXCu/gWXJio/KTPnHMIPHr3m2EoGz2BIf2v1eRq7/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711652; c=relaxed/simple;
	bh=gsXe4OT5E9GcuJIR0E9v3ll3paEpYIHbNtqvm6J0lbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H7H7HHzjY81L/3pkrsqE0tJG5MW+FPmgmau4un44MajhaPf7bkjEGF/d9yRgegv0P03WVgotr6isXG1Y2PidfL4odmesVRLrZ0xSzBz5G3Xp0FBALl53nutY876bDJnPGxEWf8u7En0BtVwdB7Zf+m3yMn6XAjm90n1VTCB/yR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsUBPayi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877C0C4CEF1;
	Fri, 12 Sep 2025 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711651;
	bh=gsXe4OT5E9GcuJIR0E9v3ll3paEpYIHbNtqvm6J0lbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=YsUBPayiylXmW6ZxHDIJC3btxygnAh8tvOtYJ1ND9DmwHs1bVipxeErXK2OTcgqE7
	 722xkhf8YIx2+QYuC7PLeQf3icXzDBJn1lf2oyHc4nNW5Sn7demQzThItNgDnIEFLb
	 ehpQB1E+Oie3p3b9a7bC9cdt5mwZIRoY5U1GTQJZqLBF1+BDJe06tGgWgWOPgoMTkk
	 GdVFBrwXgGu2cne1lv3MVuLKFGud+q+G9G/JKrN2KJTk7VKEiBNUgNe3EdZNIE50AH
	 gaTKnauM3sHravWVEzfH1C/Rs6uto5nK3JmlNb43lw1f9BUgxs7vw2vfyoPoI7/AIv
	 ACnjsaMivGSlw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 0/9] SUNRPC: Convert the scratch page into a scratch folio
Date: Fri, 12 Sep 2025 17:14:00 -0400
Message-ID: <20250912211410.837006-1-anna@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

This is the first of a handful of patchsets I've been working on to
convert our usage of 'struct page's into 'struct folio's. I figured I
would start things off easy with converting the scratch page set to the
xdr_buf before I dive into converting over the page array.

What do you all think?
Anna


Anna Schumaker (9):
  SUNRPC: Introduce xdr_set_scratch_folio()
  NFS: Update readdir to use a scratch folio
  NFS: Update getacl to use xdr_set_scratch_folio()
  NFS: Update listxattr to use xdr_set_scratch_folio()
  NFS: Update the blocklayout to use xdr_set_scratch_folio()
  NFS: Update the filelayout to use xdr_set_scratch_folio()
  NFS: Update the flexfilelayout driver to use xdr_set_scratch_folio()
  SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()
  SUNRPC: Update gssx_accept_sec_context() to use
    xdr_set_scratch_folio()

 fs/nfs/blocklayout/blocklayout.c          |  8 ++++----
 fs/nfs/blocklayout/dev.c                  |  8 ++++----
 fs/nfs/dir.c                              |  8 ++++----
 fs/nfs/filelayout/filelayout.c            | 10 +++++-----
 fs/nfs/filelayout/filelayoutdev.c         | 10 +++++-----
 fs/nfs/flexfilelayout/flexfilelayout.c    |  8 ++++----
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 10 +++++-----
 fs/nfs/nfs42proc.c                        |  4 ++--
 fs/nfs/nfs42xdr.c                         |  2 +-
 fs/nfs/nfs4proc.c                         |  4 ++--
 fs/nfs/nfs4xdr.c                          |  2 +-
 include/linux/nfs_xdr.h                   |  4 ++--
 include/linux/sunrpc/svc.h                |  4 ++--
 include/linux/sunrpc/xdr.h                |  8 ++++----
 net/sunrpc/auth_gss/gss_rpc_xdr.c         |  8 ++++----
 net/sunrpc/svc.c                          | 10 +++++-----
 16 files changed, 54 insertions(+), 54 deletions(-)

-- 
2.51.0


