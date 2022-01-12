Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470DF48C40C
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jan 2022 13:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiALMcp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jan 2022 07:32:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:12209 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240219AbiALMco (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jan 2022 07:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641990764; x=1673526764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=17feNRCWxaaCotEaxWchhHxpKB2++aseGYBTFYm3A1E=;
  b=f0WcNd0Ntzfy2JSRxx59uutoPn0041jOsv4R0J5EYpwyFyKnWz4Rro6Y
   Rqj6TOZXRIlEOptwwymqBuMMnzwJW+scTNlxey4AF8jyOTbEHoa1y9Ima
   +gf8YTPVJjT0CxeyJ+/fl2nLFfIy3KWGY+UbM2zoY6OQ/OaZo9bdE4/YE
   59LVQVSB9lbjbnt8Ypbk3Zs/9Oxj7iRasuQvqLCJHYSlzMCRcJ5Ewcz9x
   osFdM+5EU2DXyoWbri8iWrftotMnx9bhW7pTQULo9NK4UVVGA/mvWTFzz
   Xi2e4Nrcb1nbeJtW+o4AB7XHx4qH41SB8IOZ4de0G4hYpr9I6sgfqqvZy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="224418034"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="224418034"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 04:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="592990198"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2022 04:32:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7cny-0005mi-6L; Wed, 12 Jan 2022 12:32:42 +0000
Date:   Wed, 12 Jan 2022 20:32:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Olga Kornievskaia <kolga@netapp.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] nfs4_discover_trunking() can be static
Message-ID: <20220112123218.GA25976@65a275238185>
References: <202201122012.9sn7Q8EF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201122012.9sn7Q8EF-lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

fs/nfs/nfs4proc.c:4008:5: warning: symbol 'nfs4_discover_trunking' was not declared. Should it be static?

Fixes: 82ebfb0d6333 ("NFSv4.1 query for fs_location attr on a new file system")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 nfs4proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a93deeca0c86f..7a59ec2d7dacc 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4005,7 +4005,7 @@ static int _nfs4_discover_trunking(struct nfs_server *server,
 	return status;
 }
 
-int nfs4_discover_trunking(struct nfs_server *server, struct nfs_fh *fhandle)
+static int nfs4_discover_trunking(struct nfs_server *server, struct nfs_fh *fhandle)
 {
 	struct nfs4_exception exception = {
 		.interruptible = true,
