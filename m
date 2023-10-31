Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F747DC4CD
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 04:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjJaDSF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 23:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjJaDSF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 23:18:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFED798
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 20:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698722282; x=1730258282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KhUyFYNfZFh/v81qiplfJb7+C9WjHlLSGl/6XH9ssqo=;
  b=TGB4Rl66DFoU4De0t9KHxGN82iu1Td9/8sgj7PvkdIEejuARFPUikun8
   K3gXIsJwF+NjquRZAv50gW4bSwfITKIGfqw0MdoAbeI6VgKPFXir0t+Cd
   UcLxCiJoSDqpF1qB3BDXkVmpn0fMhYNUSA+Pkwgev60Oo7Ixw98D8nhwC
   x2q73zErAC7kPN26V1OkAnMm8XoueYmo/sn5lWVzEQ5jhJVfc5AnSPDIg
   hIXNQGktmMA0Z6OXxNJY4d3luHJZsf3FeMVqs4CN99let8yIpYTH4Q45n
   NwdYk13GiV3wffOUDiXGpZV9J72QfU7zItmtXe2c7l1FZOv7bWefwfjbk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474446125"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="474446125"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 20:18:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="826262180"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="826262180"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2023 20:18:00 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxfGQ-000Dml-0v;
        Tue, 31 Oct 2023 03:17:58 +0000
Date:   Tue, 31 Oct 2023 11:17:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of
 state
Message-ID: <202310311114.Ym5PyQ5Z-lkp@intel.com>
References: <20231027015613.26247-2-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027015613.26247-2-neilb@suse.de>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NeilBrown,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6 next-20231030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/nfsd-prepare-for-supporting-admin-revocation-of-state/20231027-095832
base:   linus/master
patch link:    https://lore.kernel.org/r/20231027015613.26247-2-neilb%40suse.de
patch subject: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of state
config: mips-maltaup_xpa_defconfig (https://download.01.org/0day-ci/archive/20231031/202310311114.Ym5PyQ5Z-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310311114.Ym5PyQ5Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310311114.Ym5PyQ5Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   mipsel-linux-ld: fs/nfsd/nfsctl.o: in function `write_unlock_fs':
>> nfsctl.c:(.text+0x4cc): undefined reference to `nfsd4_revoke_states'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
