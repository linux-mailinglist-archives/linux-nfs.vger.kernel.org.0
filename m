Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8978B63A36
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfGIRdO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 13:33:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:18911 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfGIRdN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Jul 2019 13:33:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 10:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="192760185"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jul 2019 10:33:12 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hktzL-0007sG-UM; Wed, 10 Jul 2019 01:33:11 +0800
Date:   Wed, 10 Jul 2019 01:32:17 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     kbuild-all@01.org, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] nfsd: force_expire_client() can be static
Message-ID: <20190709173217.GA70574@lkp-kbuild04>
References: <201907100149.XLk4C7WJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201907100149.XLk4C7WJ%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Fixes: 89c905beccbb ("nfsd: allow forced expiration of NFSv4 clients")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 nfs4state.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e6229bf..9012d78 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2505,7 +2505,7 @@ static const struct file_operations client_states_fops = {
  * so the caller has a guarantee that the client's locks are gone by
  * the time the write returns:
  */
-void force_expire_client(struct nfs4_client *clp)
+static void force_expire_client(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	bool already_expired;
