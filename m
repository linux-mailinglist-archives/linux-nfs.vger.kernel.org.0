Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB663754
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 15:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfGIN4l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 09:56:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:21495 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfGIN4l (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Jul 2019 09:56:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 06:56:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="170598144"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 Jul 2019 06:56:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hkqbn-000D77-7b; Tue, 09 Jul 2019 21:56:39 +0800
Date:   Tue, 9 Jul 2019 21:55:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     kbuild-all@01.org, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] nfsd4: __get_nfsdfs_client() can be static
Message-ID: <20190709135544.GA4675@lkp-kbuild04>
References: <201907092159.SKYltvLT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907092159.SKYltvLT%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Fixes: 97ad4031e295 ("nfsd4: add a client info file")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 nfsctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 4683ba5..72fad54 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1218,7 +1218,7 @@ static void clear_ncl(struct inode *inode)
 }
 
 
-struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
+static struct nfsdfs_client *__get_nfsdfs_client(struct inode *inode)
 {
 	struct nfsdfs_client *nc = inode->i_private;
 
