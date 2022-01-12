Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973AB48C413
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jan 2022 13:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353187AbiALMdp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jan 2022 07:33:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:12290 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240219AbiALMdp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jan 2022 07:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641990825; x=1673526825;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vvh6IIGBSYSmjaCnGq3TAQf6swL7PGPQ3vOcYGZvUw0=;
  b=KnQe3wyXZrzRChBsPmX7VqCeOfw4if3O654MUqBuZxl8NsvGbUBoztcE
   QYQtbtKltM7Co5IpUb7NoK3635t/ZAdDMiKMBAcSo7OoFdlswgvph9TW/
   pgafY8n2nWNIah+QyafWdektuGt7a30TjDQex0emxSylIm4/a6zB2JKpq
   HYUhtuVrL5IHBlAxhNQU6wmFLJiW2cROYTRX+VLNzwd2rCHClVtr9s/D7
   Umy8u6CtiCqWQVAFyAHIQGK/j1u8BL3LseYNbyJtG78uRZ9ITm7Yw0fPf
   VYi4NfLJ/XRIGZiKGxxDJlLqqtis9ULFXQLS/aaS1HvqMXLku43MoJUvo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="224418168"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="224418168"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 04:33:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="529156514"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Jan 2022 04:33:42 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7cow-0005mw-9L; Wed, 12 Jan 2022 12:33:42 +0000
Date:   Wed, 12 Jan 2022 20:33:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Olga Kornievskaia <kolga@netapp.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [linux-next:master 11662/12034] fs/nfs/nfs4proc.c:4008:5: sparse:
 sparse: symbol 'nfs4_discover_trunking' was not declared. Should it be
 static?
Message-ID: <202201122012.9sn7Q8EF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   32ce2abb03cfae17a9eb42bd6b1b619b72f23f20
commit: 82ebfb0d633383ee00156e2b5bfa9ddf8c550b65 [11662/12034] NFSv4.1 query for fs_location attr on a new file system
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220112/202201122012.9sn7Q8EF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=82ebfb0d633383ee00156e2b5bfa9ddf8c550b65
        git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
        git fetch --no-tags linux-next master
        git checkout 82ebfb0d633383ee00156e2b5bfa9ddf8c550b65
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/nfs/nfs4proc.c:4008:5: sparse: sparse: symbol 'nfs4_discover_trunking' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
