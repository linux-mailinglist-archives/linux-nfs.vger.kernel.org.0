Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA5E5AB976
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Sep 2022 22:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiIBU3u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Sep 2022 16:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIBU3t (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Sep 2022 16:29:49 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A57C2D1EB
        for <linux-nfs@vger.kernel.org>; Fri,  2 Sep 2022 13:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662150587; x=1693686587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OT/Xtt6yjDY9JNOtOArICZI8EWpObk+kEfWJqW9Bm4E=;
  b=X5Xk/C+ErSHS/oraXs4ANvOkpAhxwpK2G0GT521O7y/tWRI7fV4b7K1X
   KIOqnUOvQ8Po2asjk6S4JZnqeuMlvU9HCcHGKoEvGLx3rII5zh+PeyLoZ
   ZA75IxyPw/SaSfXzpM1oBSFYO/iGaFT7x2uLEMnR1JnziLPfDySEry9wH
   N7cjWTnG1+mn1+/6hJKWsSmOW2GivnY6ChpkGCeguZKm46lSezqeoHMSs
   nD55JiFbcrQWxFgJFh9AcoLjwdHHx89V/YFBS/h2UzEcg/4nE4Sk3+hvo
   Oqtc/faYApktsFRHTzifAQ9kd6yuM6Tjq9FoAjOCmUhkEojYRURSlORw9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="276481691"
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="276481691"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 13:29:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,285,1654585200"; 
   d="scan'208";a="941419037"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 02 Sep 2022 13:29:21 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUDI0-0000Zw-2o;
        Fri, 02 Sep 2022 20:29:20 +0000
Date:   Sat, 3 Sep 2022 04:28:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v1] NFSD: Increase NFSD_MAX_OPS_PER_COMPOUND
Message-ID: <202209030446.TMHuJXY9-lkp@intel.com>
References: <166214486962.101939.2252490595444681944.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166214486962.101939.2252490595444681944.stgit@bazille.1015granger.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Chuck,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/NFSD-Increase-NFSD_MAX_OPS_PER_COMPOUND/20220903-025613
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0b3acd1cc0222953035d18176b1e4aa06624fd6e
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209030446.TMHuJXY9-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2b18db50c1618d5efba82c205ab1d127cf210862
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Chuck-Lever/NFSD-Increase-NFSD_MAX_OPS_PER_COMPOUND/20220903-025613
        git checkout 2b18db50c1618d5efba82c205ab1d127cf210862
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/nfsd/nfs4xdr.c: In function 'nfsd4_decode_compound':
   fs/nfsd/nfs4xdr.c:2372:29: error: implicit declaration of function 'vcalloc'; did you mean 'kvcalloc'? [-Werror=implicit-function-declaration]
    2372 |                 argp->ops = vcalloc(argp->opcnt, sizeof(*argp->ops));
         |                             ^~~~~~~
         |                             kvcalloc
>> fs/nfsd/nfs4xdr.c:2372:27: warning: assignment to 'struct nfsd4_op *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    2372 |                 argp->ops = vcalloc(argp->opcnt, sizeof(*argp->ops));
         |                           ^
   fs/nfsd/nfs4xdr.c: In function 'nfsd4_release_compoundargs':
   fs/nfsd/nfs4xdr.c:5396:17: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
    5396 |                 vfree(args->ops);
         |                 ^~~~~
         |                 kvfree
   cc1: some warnings being treated as errors


vim +2372 fs/nfsd/nfs4xdr.c

  2329	
  2330	static bool
  2331	nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
  2332	{
  2333		struct nfsd4_op *op;
  2334		bool cachethis = false;
  2335		int auth_slack= argp->rqstp->rq_auth_slack;
  2336		int max_reply = auth_slack + 8; /* opcnt, status */
  2337		int readcount = 0;
  2338		int readbytes = 0;
  2339		__be32 *p;
  2340		int i;
  2341	
  2342		if (xdr_stream_decode_u32(argp->xdr, &argp->taglen) < 0)
  2343			return false;
  2344		max_reply += XDR_UNIT;
  2345		argp->tag = NULL;
  2346		if (unlikely(argp->taglen)) {
  2347			if (argp->taglen > NFSD4_MAX_TAGLEN)
  2348				return false;
  2349			p = xdr_inline_decode(argp->xdr, argp->taglen);
  2350			if (!p)
  2351				return false;
  2352			argp->tag = svcxdr_savemem(argp, p, argp->taglen);
  2353			if (!argp->tag)
  2354				return false;
  2355			max_reply += xdr_align_size(argp->taglen);
  2356		}
  2357	
  2358		if (xdr_stream_decode_u32(argp->xdr, &argp->minorversion) < 0)
  2359			return false;
  2360		if (xdr_stream_decode_u32(argp->xdr, &argp->opcnt) < 0)
  2361			return false;
  2362	
  2363		/*
  2364		 * NFS4ERR_RESOURCE is a more helpful error than GARBAGE_ARGS
  2365		 * here, so we return success at the xdr level so that
  2366		 * nfsd4_proc can handle this is an NFS-level error.
  2367		 */
  2368		if (argp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
  2369			return true;
  2370	
  2371		if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
> 2372			argp->ops = vcalloc(argp->opcnt, sizeof(*argp->ops));
  2373			if (!argp->ops) {
  2374				argp->ops = argp->iops;
  2375				return false;
  2376			}
  2377		}
  2378	
  2379		if (argp->minorversion > NFSD_SUPPORTED_MINOR_VERSION)
  2380			argp->opcnt = 0;
  2381	
  2382		for (i = 0; i < argp->opcnt; i++) {
  2383			op = &argp->ops[i];
  2384			op->replay = NULL;
  2385	
  2386			if (xdr_stream_decode_u32(argp->xdr, &op->opnum) < 0)
  2387				return false;
  2388			if (nfsd4_opnum_in_range(argp, op)) {
  2389				op->status = nfsd4_dec_ops[op->opnum](argp, &op->u);
  2390				if (op->status != nfs_ok)
  2391					trace_nfsd_compound_decode_err(argp->rqstp,
  2392								       argp->opcnt, i,
  2393								       op->opnum,
  2394								       op->status);
  2395			} else {
  2396				op->opnum = OP_ILLEGAL;
  2397				op->status = nfserr_op_illegal;
  2398			}
  2399			op->opdesc = OPDESC(op);
  2400			/*
  2401			 * We'll try to cache the result in the DRC if any one
  2402			 * op in the compound wants to be cached:
  2403			 */
  2404			cachethis |= nfsd4_cache_this_op(op);
  2405	
  2406			if (op->opnum == OP_READ || op->opnum == OP_READ_PLUS) {
  2407				readcount++;
  2408				readbytes += nfsd4_max_reply(argp->rqstp, op);
  2409			} else
  2410				max_reply += nfsd4_max_reply(argp->rqstp, op);
  2411			/*
  2412			 * OP_LOCK and OP_LOCKT may return a conflicting lock.
  2413			 * (Special case because it will just skip encoding this
  2414			 * if it runs out of xdr buffer space, and it is the only
  2415			 * operation that behaves this way.)
  2416			 */
  2417			if (op->opnum == OP_LOCK || op->opnum == OP_LOCKT)
  2418				max_reply += NFS4_OPAQUE_LIMIT;
  2419	
  2420			if (op->status) {
  2421				argp->opcnt = i+1;
  2422				break;
  2423			}
  2424		}
  2425		/* Sessions make the DRC unnecessary: */
  2426		if (argp->minorversion)
  2427			cachethis = false;
  2428		svc_reserve(argp->rqstp, max_reply + readbytes);
  2429		argp->rqstp->rq_cachetype = cachethis ? RC_REPLBUFF : RC_NOCACHE;
  2430	
  2431		if (readcount > 1 || max_reply > PAGE_SIZE - auth_slack)
  2432			__clear_bit(RQ_SPLICE_OK, &argp->rqstp->rq_flags);
  2433	
  2434		return true;
  2435	}
  2436	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
