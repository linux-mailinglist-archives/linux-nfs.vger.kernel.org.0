Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895BE575906
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 03:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiGOBO5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jul 2022 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiGOBO4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Jul 2022 21:14:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465E63925
        for <linux-nfs@vger.kernel.org>; Thu, 14 Jul 2022 18:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657847695; x=1689383695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G3Kxbr0627ygj26eP+ilpweGGG4BpcM3GqZz8nwAFjY=;
  b=lnlPSslS2CRzwVrXnnU6ep34oWgQCGilxIsUPaM4kFpDvy6UO0krv8kg
   Ug+n9k6toNVS8utM3NjOusxNd6xOYRK4ZYCJx237wR2WNyBP22GGgq+tB
   E6znTtKX8C+wlgv1go11LvYm0wms0xPTGsquvLqgL89iuFmV6QcgyKJNg
   lOrmlJ0k0PmwAy1P/rXWMENR220Lxgo0j59KGCFmpNtH04r6MNv4GkFT6
   Ckz4cTYNnxGFWkINR8OLXk9aKxtL9tTycOQ45b+ql/SO2W8fR/k224UtT
   aNVfgK5lg7cIrDUjGaLucj4VdhzxWFHgvSFNbkOqxBQcLaa37Ur66reQx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347351569"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="347351569"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 18:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628916125"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2022 18:14:54 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oC9uv-0001Ll-DB;
        Fri, 15 Jul 2022 01:14:53 +0000
Date:   Fri, 15 Jul 2022 09:14:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: limit the number of v4 clients to 4096 per 4GB
 of system memory
Message-ID: <202207150938.TXWZZpEX-lkp@intel.com>
References: <1657656660-16647-3-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657656660-16647-3-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc6 next-20220714]
[cannot apply to cel-2.6/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dai-Ngo/limit-the-number-of-v4-clients-to-4096-per-4GB-of-system-memory/20220713-041137
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 72a8e05d4f66b5af7854df4490e3135168694b6b
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220715/202207150938.TXWZZpEX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f4722e6591821876532c91087a3ac0e103e8d5d7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dai-Ngo/limit-the-number-of-v4-clients-to-4096-per-4GB-of-system-memory/20220713-041137
        git checkout f4722e6591821876532c91087a3ac0e103e8d5d7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/nfsd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/nfsd/nfsctl.c:1497:42: warning: shift count >= width of type [-Wshift-count-overflow]
           nn->nfs4_max_clients = (((lowmem * 100) >> 32) *
                                                   ^  ~~
   1 warning generated.


vim +1497 fs/nfsd/nfsctl.c

  1463	
  1464	static __net_init int nfsd_init_net(struct net *net)
  1465	{
  1466		int retval;
  1467		unsigned long lowmem;
  1468		struct sysinfo si;
  1469		struct nfsd_net *nn = net_generic(net, nfsd_net_id);
  1470	
  1471		retval = nfsd_export_init(net);
  1472		if (retval)
  1473			goto out_export_error;
  1474		retval = nfsd_idmap_init(net);
  1475		if (retval)
  1476			goto out_idmap_error;
  1477		nn->nfsd_versions = NULL;
  1478		nn->nfsd4_minorversions = NULL;
  1479		retval = nfsd_reply_cache_init(nn);
  1480		if (retval)
  1481			goto out_drc_error;
  1482		nn->nfsd4_lease = 90;	/* default lease time */
  1483		nn->nfsd4_grace = 90;
  1484		nn->somebody_reclaimed = false;
  1485		nn->track_reclaim_completes = false;
  1486		nn->clverifier_counter = prandom_u32();
  1487		nn->clientid_base = prandom_u32();
  1488		nn->clientid_counter = nn->clientid_base + 1;
  1489		nn->s2s_cp_cl_id = nn->clientid_counter++;
  1490	
  1491		get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
  1492		seqlock_init(&nn->writeverf_lock);
  1493	
  1494		atomic_set(&nn->nfs4_client_count, 0);
  1495		si_meminfo(&si);
  1496		lowmem = (si.totalram - si.totalhigh) * si.mem_unit;
> 1497		nn->nfs4_max_clients = (((lowmem * 100) >> 32) *
  1498					NFS4_MAX_CLIENTS_PER_4GB) / 100;
  1499	
  1500		return 0;
  1501	
  1502	out_drc_error:
  1503		nfsd_idmap_shutdown(net);
  1504	out_idmap_error:
  1505		nfsd_export_shutdown(net);
  1506	out_export_error:
  1507		return retval;
  1508	}
  1509	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
