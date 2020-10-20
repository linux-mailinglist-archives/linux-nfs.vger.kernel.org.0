Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E82F29423E
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Oct 2020 20:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389151AbgJTSji (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Oct 2020 14:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389145AbgJTSji (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 20 Oct 2020 14:39:38 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B899421D7B;
        Tue, 20 Oct 2020 18:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603219178;
        bh=W5LjpHWQlr0scG8t+aiOKmCqvvPLgdMoOg7OLT1cL/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xeGgy8nrxtQjqnLgfGK+8KbU9hrD5fUrMU/aR3GrYMpZNKpcaktWKlYe39QckXqnJ
         eVI7ZqCacW6IWX2p/F3Od1vM+xWVcGdZS9nlInB5K88yMbySmMHyia8BB3gO+VdiaD
         qGhFTM7NQjoPsSinfIJ3AOrdEPsQP/esOFrprKxo=
From:   trondmy@kernel.org
To:     Daire Byrne <daire@dneg.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/3] Add NFSv3 emulation of the lookupp operation
Date:   Tue, 20 Oct 2020 14:37:15 -0400
Message-Id: <20201020183718.14618-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
References: <279389889.68934777.1603124383614.JavaMail.zimbra@dneg.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In order to use the open-by-filehandle functionality with NFSv3, we
need to ensure that the NFS client can convert disconnected dentries
into connected ones by doing a reverse walk of the filesystem path.
To do so, NFSv4 provides the LOOKUPP operation, which does not
exist in NFSv3, but which can usually be emulated using lookup("..").

v2:
 - Fix compilation issues for "NFSv3: Refactor nfs3_proc_lookup() to
   split out the dentry"
v3:
 - Fix the string length calculation
 - Apply the NFS_MOUNT_SOFTREVAL flag in both the NFSv3 and NFSv4 lookupp

Trond Myklebust (3):
  NFSv3: Refactor nfs3_proc_lookup() to split out the dentry
  NFSv3: Add emulation of the lookupp() operation
  NFSv4: Observe the NFS_MOUNT_SOFTREVAL flag in _nfs4_proc_lookupp

 fs/nfs/nfs3proc.c | 48 ++++++++++++++++++++++++++++++++++++-----------
 fs/nfs/nfs4proc.c |  6 +++++-
 2 files changed, 42 insertions(+), 12 deletions(-)

-- 
2.26.2

