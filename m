Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B68A286D0C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Oct 2020 05:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgJHDLf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Oct 2020 23:11:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:23366 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbgJHDLf (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 7 Oct 2020 23:11:35 -0400
IronPort-SDR: CeruVH9mARTJdhxTL8fbzIQCLml7qCA3v1GMzJea8v+qy1IxzInfh1xUjq8NJ8cc6yHc2NX3+W
 QTAcJ1WLKL/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="229432839"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="229432839"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:11:33 -0700
IronPort-SDR: erwNqWjnS4CLD3OgdapCyludqyPlWa2h//9prhu/kN5m2qg9YXdqfpq2uC+8ZVzxTfTESefpbX
 gTDHPoXks4xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="528301683"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2020 20:11:31 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQML5-0001wU-9m; Thu, 08 Oct 2020 03:11:31 +0000
Date:   Thu, 8 Oct 2020 11:11:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>, bfields@fieldses.org
Cc:     kbuild-all@lists.01.org, linux-nfs@vger.kernel.org
Subject: [RFC PATCH] NFSv4.2: nfs_ssc_clnt_ops_tbl can be static
Message-ID: <20201008031126.GA156798@30b510b0eab4>
References: <20201008012513.89989-2-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008012513.89989-2-dai.ngo@oracle.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 nfs4file.c |    2 +-
 super.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index ea42c39bc2ffd..124876dfd6447 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -28,7 +28,7 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		struct nfs_fh *src_fh, nfs4_stateid *stateid);
 static void __nfs42_ssc_close(struct file *filep);
 
-const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
+static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl = {
 	.sco_owner = THIS_MODULE,
 	.sco_open = __nfs42_ssc_open,
 	.sco_close = __nfs42_ssc_close,
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index c6324e2de1ae5..65636fef6a006 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -86,7 +86,7 @@ const struct super_operations nfs_sops = {
 };
 EXPORT_SYMBOL_GPL(nfs_sops);
 
-const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
+static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl = {
 	.sco_owner = THIS_MODULE,
 	.sco_sb_deactive = nfs_sb_deactive,
 };
