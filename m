Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B8638B46B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhETQk1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 12:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234143AbhETQkZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 12:40:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E116A6101E
        for <linux-nfs@vger.kernel.org>; Thu, 20 May 2021 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528744;
        bh=QG9VEfbtIpT7JADx7YKWFUCM8PdvubfdMOLJWmdE44k=;
        h=From:To:Subject:Date:From;
        b=lDZR2U3gGcgEF3oOpXPMRjC2yXfqUWMVljWq3sFzeABV+ej1hqHhjqTERdGZcGsJh
         arTVxCELCPq97lBgdfwuljNElXBc89TfrRByXkyFXh+mzYssLa739ktTj6wutC7Fpv
         wfMWmSINSTPF5uVn0IHKlkaRufyp+mosVLfqQRm0e9lyTJoW07oft/ZqY14BIj9g/c
         1XmskEeYEa43xwUwep0NNiotXLyP5bQawL0qBXjeo5oTZ5hXaNMo7ZNUKsmL/x/XqH
         NOdmFyctl4YN2AmuBkCJJYIjKv3XuxDsOpIxAIh1+yKP+KNfU/+AzZMJwONO9gpAdW
         hOhY4WhMcLskA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] Add support for application leases to NFSv4
Date:   Thu, 20 May 2021 12:38:58 -0400
Message-Id: <20210520163902.215745-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the client holds a delegation, it should be able to offer all the
guarantees that are needed to support application leases and
delegations. The main use case here is when re-exporting NFSv4.

Trond Myklebust (4):
  NFSv4: Fix delegation return in cases where we have to retry
  NFSv4: Add lease breakpoints in case of a delegation recall or return
  NFSv4: Add support for application leases underpinned by a delegation
  NFS: nfs_find_open_context() may only select open files

 fs/nfs/delegation.c    | 94 ++++++++++++++++++++++++++++++++----------
 fs/nfs/delegation.h    |  1 +
 fs/nfs/inode.c         |  4 ++
 fs/nfs/nfs4_fs.h       |  4 +-
 fs/nfs/nfs4file.c      |  8 +++-
 fs/nfs/nfs4proc.c      | 37 +++++++++++++++++
 include/linux/nfs_fs.h |  1 +
 7 files changed, 126 insertions(+), 23 deletions(-)

-- 
2.31.1

