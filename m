Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10791AD2A0
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Apr 2020 00:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgDPWPA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 18:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgDPWPA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 18:15:00 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23133218AC;
        Thu, 16 Apr 2020 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587075300;
        bh=ZAoqiSLYIHCPiPPHL49mECpuSjsGwo97DueDNKp4HSI=;
        h=From:To:Cc:Subject:Date:From;
        b=bvtMqPtvPFZh1sr5R+aZ70gmoVKJ8qgkeWllH287rnr2m1qmPsLsk9tsrzWt9FAXH
         tGjyY7kGPOkShwEerYN7qFIIX32jG9+Ob22IPIrLzu2bBIiNMrUAI6jAeDfxFhuzZK
         o6Y1VrSA5d/J8IQA5f7EIEL0ywisq0bYkHdKBcts=
From:   trondmy@kernel.org
To:     Steve Dickson <SteveD@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/7] nfs-utils fixes
Date:   Thu, 16 Apr 2020 18:12:45 -0400
Message-Id: <20200416221252.82102-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This patchset fixes a couple of missed API changes in mountd to
ensure that the [exports]rootdir root jail works correctly. It
fixes up the 'same_path' function, as well as 'uuid_by_path'.
It also improves the error handling, and tries to distinguish
between bona fide path resolution problems, and other transient
issues in order to avoid having knfsd return spurious ESTALE
errors.

Trond Myklebust (7):
  mountd: Add a helper nfsd_path_statfs64() for uuid_by_path()
  nfsd: Support running nfsd_name_to_handle_at() in the root jail
  mountd: Fix up path checking helper same_path()
  Fix autoconf probe for 'struct nfs_filehandle'
  mountd: Ensure dump_to_cache() sets errno appropriately
  mountd: Ignore transient and non-fatal filesystem errors in nfsd_fh()
  mountd: Check the stat() return values in match_fsid()

 configure.ac                |   7 +-
 support/include/nfsd_path.h |   9 ++
 support/misc/nfsd_path.c    | 109 ++++++++++++++++++++++
 utils/mountd/cache.c        | 174 ++++++++++++++++++++++++------------
 4 files changed, 242 insertions(+), 57 deletions(-)

-- 
2.25.2

