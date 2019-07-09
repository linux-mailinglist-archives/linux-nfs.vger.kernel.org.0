Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F389363A33
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2019 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfGIRdN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 13:33:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:42018 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfGIRdN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Jul 2019 13:33:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 10:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="167481530"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jul 2019 10:33:12 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hktzL-0007ry-SG; Wed, 10 Jul 2019 01:33:11 +0800
Date:   Wed, 10 Jul 2019 01:32:17 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     kbuild-all@01.org, Jeff Layton <jlayton@kernel.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [linux-next:master 11868/13492] fs/nfsd/nfs4state.c:2508:6: sparse:
 sparse: symbol 'force_expire_client' was not declared. Should it be static?
Message-ID: <201907100149.XLk4C7WJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git master
head:   4608a726c66807c27bc7d91bdf8a288254e29985
commit: 89c905beccbbafa88490c8c4c35eaec5ce4c1329 [11868/13492] nfsd: allow forced expiration of NFSv4 clients
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout 89c905beccbbafa88490c8c4c35eaec5ce4c1329
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   fs/nfsd/nfs4state.c:2352:23: sparse: sparse: unknown escape sequence: '%'
   fs/nfsd/nfs4state.c:2352:23: sparse: sparse: unknown escape sequence: '%'
   fs/nfsd/nfs4state.c:2355:23: sparse: sparse: unknown escape sequence: '%'
   fs/nfsd/nfs4state.c:2355:23: sparse: sparse: unknown escape sequence: '%'
   fs/nfsd/nfs4state.c:1907:6: sparse: sparse: symbol 'drop_client' was not declared. Should it be static?
>> fs/nfsd/nfs4state.c:2508:6: sparse: sparse: symbol 'force_expire_client' was not declared. Should it be static?
   include/linux/rculist.h:455:20: sparse: sparse: context imbalance in 'put_nfs4_file' - unexpected unlock
   include/linux/list.h:125:25: sparse: sparse: context imbalance in 'put_clnt_odstate' - unexpected unlock
   fs/nfsd/nfs4state.c:915:9: sparse: sparse: context imbalance in 'nfs4_put_stid' - unexpected unlock

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
