Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF078E59A
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 07:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241162AbjHaFSZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 01:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHaFSY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 01:18:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8CFE0
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 22:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693459101; x=1724995101;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hBA0985FlWT2HBzqPJsfw1oXGOgIwWsU4Cj0vcDGvxo=;
  b=L4cl4Z6OsQpSY33YSIbaJvVQDahTeW5tSRm0xx449AQjRvkVaDmlCd/y
   5SGAtRNu3av3hco6/c40KmF0rxh8sXkjD9qbLREEVsDENDq2bkcn5FQaE
   pGHjboB5ciucxwUeV4zo6EeySjOlhKpDpJUJqL++YMLqz1EH9q3X3h139
   /47Yy1pP2BMZ/f+eIjBxXy6VkDDHCliF76A3EMwxSkRls/Jewypm8EApj
   6biZ1cSpRliSxAo5UhVbqQQBPiCkfO28H/b/ATDAARk4lGd0lDw6CSdcU
   xjKO6GBVYwVLk53E80KiKrkChWh3WXxiX0IuRmnEtGe2n/1qmzbz8Y2Ns
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="379565661"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="379565661"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 22:18:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="768664273"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="768664273"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2023 22:18:18 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qba4Q-000Ae9-0B;
        Thu, 31 Aug 2023 05:18:18 +0000
Date:   Thu, 31 Aug 2023 13:18:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        jlayton@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSD: add trace points to track server copy progress
Message-ID: <202308311350.wOmbsChS-lkp@intel.com>
References: <1693439219-19467-2-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693439219-19467-2-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dai,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5 next-20230830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dai-Ngo/NFSD-add-trace-points-to-track-server-copy-progress/20230831-074806
base:   linus/master
patch link:    https://lore.kernel.org/r/1693439219-19467-2-git-send-email-dai.ngo%40oracle.com
patch subject: [PATCH 2/2] NFSD: add trace points to track server copy progress
config: s390-defconfig (https://download.01.org/0day-ci/archive/20230831/202308311350.wOmbsChS-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230831/202308311350.wOmbsChS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308311350.wOmbsChS-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfsd/nfs4proc.c: In function 'nfsd4_do_async_copy':
>> fs/nfsd/nfs4proc.c:1730:9: error: implicit declaration of function 'trace_nfsd4_copy_do_async'; did you mean 'nfsd4_copy_is_async'? [-Werror=implicit-function-declaration]
    1730 |         trace_nfsd4_copy_do_async(copy);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
         |         nfsd4_copy_is_async
   fs/nfsd/nfs4proc.c: In function 'nfsd4_copy':
>> fs/nfsd/nfs4proc.c:1771:17: error: implicit declaration of function 'trace_nfsd4_copy_inter'; did you mean 'trace_nfsd_ctl_time'? [-Werror=implicit-function-declaration]
    1771 |                 trace_nfsd4_copy_inter(copy);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 trace_nfsd_ctl_time
>> fs/nfsd/nfs4proc.c:1778:25: error: implicit declaration of function 'trace_nfsd4_copy_done'; did you mean 'trace_nfsd_read_done'? [-Werror=implicit-function-declaration]
    1778 |                         trace_nfsd4_copy_done(copy, status);
         |                         ^~~~~~~~~~~~~~~~~~~~~
         |                         trace_nfsd_read_done
>> fs/nfsd/nfs4proc.c:1782:17: error: implicit declaration of function 'trace_nfsd4_copy_intra'; did you mean 'trace_nfsd_cb_setup'? [-Werror=implicit-function-declaration]
    1782 |                 trace_nfsd4_copy_intra(copy);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 trace_nfsd_cb_setup
   cc1: some warnings being treated as errors


vim +1730 fs/nfsd/nfs4proc.c

  1717	
  1718	/**
  1719	 * nfsd4_do_async_copy - kthread function for background server-side COPY
  1720	 * @data: arguments for COPY operation
  1721	 *
  1722	 * Return values:
  1723	 *   %0: Copy operation is done.
  1724	 */
  1725	static int nfsd4_do_async_copy(void *data)
  1726	{
  1727		struct nfsd4_copy *copy = (struct nfsd4_copy *)data;
  1728		__be32 nfserr;
  1729	
> 1730		trace_nfsd4_copy_do_async(copy);
  1731		if (nfsd4_ssc_is_inter(copy)) {
  1732			struct file *filp;
  1733	
  1734			filp = nfs42_ssc_open(copy->ss_nsui->nsui_vfsmount,
  1735					      &copy->c_fh, &copy->stateid);
  1736			if (IS_ERR(filp)) {
  1737				switch (PTR_ERR(filp)) {
  1738				case -EBADF:
  1739					nfserr = nfserr_wrong_type;
  1740					break;
  1741				default:
  1742					nfserr = nfserr_offload_denied;
  1743				}
  1744				/* ss_mnt will be unmounted by the laundromat */
  1745				goto do_callback;
  1746			}
  1747			nfserr = nfsd4_do_copy(copy, filp, copy->nf_dst->nf_file,
  1748					       false);
  1749			nfsd4_cleanup_inter_ssc(copy->ss_nsui, filp, copy->nf_dst);
  1750		} else {
  1751			nfserr = nfsd4_do_copy(copy, copy->nf_src->nf_file,
  1752					       copy->nf_dst->nf_file, false);
  1753		}
  1754	
  1755	do_callback:
  1756		nfsd4_send_cb_offload(copy, nfserr);
  1757		cleanup_async_copy(copy);
  1758		return 0;
  1759	}
  1760	
  1761	static __be32
  1762	nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
  1763			union nfsd4_op_u *u)
  1764	{
  1765		struct nfsd4_copy *copy = &u->copy;
  1766		__be32 status;
  1767		struct nfsd4_copy *async_copy = NULL;
  1768	
  1769		copy->cp_clp = cstate->clp;
  1770		if (nfsd4_ssc_is_inter(copy)) {
> 1771			trace_nfsd4_copy_inter(copy);
  1772			if (!inter_copy_offload_enable || nfsd4_copy_is_sync(copy)) {
  1773				status = nfserr_notsupp;
  1774				goto out;
  1775			}
  1776			status = nfsd4_setup_inter_ssc(rqstp, cstate, copy);
  1777			if (status) {
> 1778				trace_nfsd4_copy_done(copy, status);
  1779				return nfserr_offload_denied;
  1780			}
  1781		} else {
> 1782			trace_nfsd4_copy_intra(copy);
  1783			status = nfsd4_setup_intra_ssc(rqstp, cstate, copy);
  1784			if (status) {
  1785				trace_nfsd4_copy_done(copy, status);
  1786				return status;
  1787			}
  1788		}
  1789	
  1790		memcpy(&copy->fh, &cstate->current_fh.fh_handle,
  1791			sizeof(struct knfsd_fh));
  1792		if (nfsd4_copy_is_async(copy)) {
  1793			struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
  1794	
  1795			status = nfserrno(-ENOMEM);
  1796			async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
  1797			if (!async_copy)
  1798				goto out_err;
  1799			INIT_LIST_HEAD(&async_copy->copies);
  1800			refcount_set(&async_copy->refcount, 1);
  1801			async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
  1802			if (!async_copy->cp_src)
  1803				goto out_err;
  1804			if (!nfs4_init_copy_state(nn, copy))
  1805				goto out_err;
  1806			memcpy(&copy->cp_res.cb_stateid, &copy->cp_stateid.cs_stid,
  1807				sizeof(copy->cp_res.cb_stateid));
  1808			dup_copy_fields(copy, async_copy);
  1809			async_copy->copy_task = kthread_create(nfsd4_do_async_copy,
  1810					async_copy, "%s", "copy thread");
  1811			if (IS_ERR(async_copy->copy_task))
  1812				goto out_err;
  1813			spin_lock(&async_copy->cp_clp->async_lock);
  1814			list_add(&async_copy->copies,
  1815					&async_copy->cp_clp->async_copies);
  1816			spin_unlock(&async_copy->cp_clp->async_lock);
  1817			wake_up_process(async_copy->copy_task);
  1818			status = nfs_ok;
  1819		} else {
  1820			status = nfsd4_do_copy(copy, copy->nf_src->nf_file,
  1821					       copy->nf_dst->nf_file, true);
  1822		}
  1823	out:
  1824		trace_nfsd4_copy_done(copy, status);
  1825		release_copy_files(copy);
  1826		return status;
  1827	out_err:
  1828		if (nfsd4_ssc_is_inter(copy)) {
  1829			/*
  1830			 * Source's vfsmount of inter-copy will be unmounted
  1831			 * by the laundromat. Use copy instead of async_copy
  1832			 * since async_copy->ss_nsui might not be set yet.
  1833			 */
  1834			refcount_dec(&copy->ss_nsui->nsui_refcnt);
  1835		}
  1836		if (async_copy)
  1837			cleanup_async_copy(async_copy);
  1838		status = nfserrno(-ENOMEM);
  1839		goto out;
  1840	}
  1841	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
