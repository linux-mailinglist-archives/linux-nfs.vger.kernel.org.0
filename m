Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B857F376
	for <lists+linux-nfs@lfdr.de>; Sun, 24 Jul 2022 08:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiGXGbq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 24 Jul 2022 02:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGXGbp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 24 Jul 2022 02:31:45 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8526A15834
        for <linux-nfs@vger.kernel.org>; Sat, 23 Jul 2022 23:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658644304; x=1690180304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tfHN6tZOaAGKxuKfVMNFkzKAAEFceeVpxkQotb9MDxY=;
  b=Zi1AkCkxvno7bBFWmvFnf9QIYM7xwAqoiwYwFUQgOefxu+ZdIDu38fhy
   htwGoV9N8XhzE799jKC0oorGwHDVBz3DI0eTd5EQBrE96nFOOiWkw0lmu
   crJFzwiYLddF0jmoybQRIECvAHqnYQ5QH8poxi99M2FUdBd+BayKiPrMl
   xeguxjw6RW6dTRI8m5+3Xi5DPG9EZLuGDR3EWK+U5OkznJFfKlU8WWU5r
   eMdT1SSRsC7uhJOEX/RxxnQdPud3CLYI0f4AH3WughzaZqjz4itPeEETy
   RQoL+dvqLZIAoEaoSgcHSwLMpScdOpM87PnZGP6LOaOEdlQD3n52Yyp4H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288277395"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288277395"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 23:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="926509214"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2022 23:31:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFV9S-0003dJ-0E;
        Sun, 24 Jul 2022 06:31:42 +0000
Date:   Sun, 24 Jul 2022 14:30:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v1 02/11] NFSD: Shrink size of struct nfsd4_copy
Message-ID: <202207241457.kBfLhxI3-lkp@intel.com>
References: <165852114903.11403.8544275041086740489.stgit@manet.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165852114903.11403.8544275041086740489.stgit@manet.1015granger.net>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc7 next-20220722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/Put-struct-nfsd4_copy-on-a-diet/20220723-042113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 70664fc10c0d722ec79d746d8ac1db8546c94114
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220724/202207241457.kBfLhxI3-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1968aac547167ef15b3634429e0cfac0c5b38419
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chuck-Lever/Put-struct-nfsd4_copy-on-a-diet/20220723-042113
        git checkout 1968aac547167ef15b3634429e0cfac0c5b38419
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash fs/nfsd/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/nfsd/nfs4proc.c: In function 'nfsd4_setup_inter_ssc':
>> fs/nfsd/nfs4proc.c:1553:41: error: passing argument 1 of 'nfsd4_interssc_connect' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1553 |         status = nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
         |                                         ^~~~~~~~~~~~~
         |                                         |
         |                                         struct nl4_server **
   fs/nfsd/nfs4proc.c:1428:43: note: expected 'struct nl4_server *' but argument is of type 'struct nl4_server **'
    1428 | nfsd4_interssc_connect(struct nl4_server *nss, struct svc_rqst *rqstp,
         |                        ~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/nfsd4_interssc_connect +1553 fs/nfsd/nfs4proc.c

ce0887ac96d35c Olga Kornievskaia 2019-10-09  1527  
f2453978a4f2dd Chuck Lever       2020-04-06  1528  /*
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1529   * Verify COPY destination stateid.
f2453978a4f2dd Chuck Lever       2020-04-06  1530   *
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1531   * Connect to the source server with NFSv4.1.
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1532   * Create the source struct file for nfsd_copy_range.
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1533   * Called with COPY cstate:
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1534   *    SAVED_FH: source filehandle
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1535   *    CURRENT_FH: destination filehandle
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1536   */
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1537  static __be32
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1538  nfsd4_setup_inter_ssc(struct svc_rqst *rqstp,
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1539  		      struct nfsd4_compound_state *cstate,
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1540  		      struct nfsd4_copy *copy, struct vfsmount **mount)
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1541  {
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1542  	struct svc_fh *s_fh = NULL;
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1543  	stateid_t *s_stid = &copy->cp_src_stateid;
b8290ca250fb77 Olga Kornievskaia 2019-12-04  1544  	__be32 status = nfserr_inval;
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1545  
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1546  	/* Verify the destination stateid and set dst struct file*/
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1547  	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1548  					    &copy->cp_dst_stateid,
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1549  					    WR_STATE, &copy->nf_dst, NULL);
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1550  	if (status)
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1551  		goto out;
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1552  
ce0887ac96d35c Olga Kornievskaia 2019-10-09 @1553  	status = nfsd4_interssc_connect(&copy->cp_src, rqstp, mount);
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1554  	if (status)
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1555  		goto out;
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1556  
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1557  	s_fh = &cstate->save_fh;
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1558  
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1559  	copy->c_fh.size = s_fh->fh_handle.fh_size;
d8b26071e65e80 NeilBrown         2021-09-02  1560  	memcpy(copy->c_fh.data, &s_fh->fh_handle.fh_raw, copy->c_fh.size);
3f9544ca62bc13 Olga Kornievskaia 2019-12-04  1561  	copy->stateid.seqid = cpu_to_be32(s_stid->si_generation);
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1562  	memcpy(copy->stateid.other, (void *)&s_stid->si_opaque,
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1563  	       sizeof(stateid_opaque_t));
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1564  
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1565  	status = 0;
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1566  out:
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1567  	return status;
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1568  }
ce0887ac96d35c Olga Kornievskaia 2019-10-09  1569  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
