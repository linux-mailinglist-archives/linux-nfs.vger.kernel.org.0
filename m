Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAA9767C4D
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Jul 2023 07:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjG2FSN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 29 Jul 2023 01:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjG2FSM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 29 Jul 2023 01:18:12 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A9249CA
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 22:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690607891; x=1722143891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7cmaRRN7TV7H7ttnySmbspcm7hKB1B3+5D1I6uIIp8=;
  b=f+yc9o2fHzBfVe2A1eqpSKoQrPT0Ws5zB3xeYQbsCatsDfzDZA6qahTt
   7NsOPbQFgibweDrNNMwCMkoCB4ASPNceWsjxGnhYQG+xP540Edds1omdV
   hImxpK/+G3dwIgJ6ND577lS65b5VkduEblxJ2Kr1UtyaO3Id7taIdFOSf
   corCRLAg/ddLsjSsN86c7vFfTqgvdA0j/7vsOi/fCToiKdrm33TWfsWxm
   NHD0cg/vUMWGt+gXUjDKGunbQr9Jx/qej5y+nuthCpQgAVrqAUKfpdyBm
   s4Rz7JDbeaOdS6awap8zBbx7aeOAuFQQ2q5q5afqaX1A9ZbGrcouMIKC9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="372364244"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="372364244"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 22:18:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="841557656"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="841557656"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2023 22:18:09 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPcLA-0003qs-1K;
        Sat, 29 Jul 2023 05:18:08 +0000
Date:   Sat, 29 Jul 2023 13:18:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de
Subject: Re: [PATCH v4 2/2] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <202307291354.ujwCaQTt-lkp@intel.com>
References: <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230728]
[cannot apply to trondmy-nfs/linux-next linus/master v6.5-rc3 v6.5-rc2 v6.5-rc1 v6.5-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/SUNRPC-add-verbose-parameter-to-__svc_print_addr/20230729-024652
base:   next-20230728
patch link:    https://lore.kernel.org/r/a23a0482a465299ac06d07d191e0c9377a11a4d1.1690569488.git.lorenzo%40kernel.org
patch subject: [PATCH v4 2/2] NFSD: add rpc_status entry in nfsd debug filesystem
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20230729/202307291354.ujwCaQTt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291354.ujwCaQTt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291354.ujwCaQTt-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/nfsd/nfssvc.c: In function 'nfsd_rpc_status_show':
>> fs/nfsd/nfssvc.c:1241:44: error: implicit declaration of function 'nfsd4_op_name'; did you mean 'nfsd_rename'? [-Werror=implicit-function-declaration]
    1241 |                                            nfsd4_op_name(rqstp_info.opnum[j]),
         |                                            ^~~~~~~~~~~~~
         |                                            nfsd_rename
>> fs/nfsd/nfssvc.c:1240:50: warning: format '%s' expects argument of type 'char *', but argument 3 has type 'int' [-Wformat=]
    1240 |                                 seq_printf(m, " %s%s",
         |                                                 ~^
         |                                                  |
         |                                                  char *
         |                                                 %d
    1241 |                                            nfsd4_op_name(rqstp_info.opnum[j]),
         |                                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                            |
         |                                            int
   cc1: some warnings being treated as errors


vim +1241 fs/nfsd/nfssvc.c

  1216	
  1217				/* In order to detect if the RPC request is pending and
  1218				 * RPC info are stable we check if rq_status_counter
  1219				 * has been incremented during the handler processing.
  1220				 */
  1221				if (status_counter != atomic_read(&rqstp->rq_status_counter))
  1222					continue;
  1223	
  1224				seq_printf(m,
  1225					   "0x%08x, 0x%08lx, 0x%08x, NFSv%d, %s, %016lld,",
  1226					   be32_to_cpu(rqstp_info.rq_xid),
  1227					   rqstp_info.rq_flags,
  1228					   rqstp_info.rq_prog,
  1229					   rqstp_info.rq_vers,
  1230					   rqstp_info.pc_name,
  1231					   ktime_to_us(rqstp_info.rq_stime));
  1232	
  1233				seq_printf(m, " %s,",
  1234					   __svc_print_addr(&rqstp_info.saddr, buf,
  1235							    sizeof(buf), false));
  1236				seq_printf(m, " %s,",
  1237					   __svc_print_addr(&rqstp_info.daddr, buf,
  1238							    sizeof(buf), false));
  1239				for (j = 0; j < opcnt; j++)
> 1240					seq_printf(m, " %s%s",
> 1241						   nfsd4_op_name(rqstp_info.opnum[j]),
  1242						   j == opcnt - 1 ? "," : "");
  1243				seq_puts(m, "\n");
  1244			}
  1245		}
  1246	
  1247		rcu_read_unlock();
  1248	
  1249		return 0;
  1250	}
  1251	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
