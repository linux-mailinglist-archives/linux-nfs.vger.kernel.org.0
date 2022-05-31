Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBA0539559
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 19:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346476AbiEaRS0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 13:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346486AbiEaRS0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 13:18:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1519A14022
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 10:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654017502; x=1685553502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KAPz3dULxchQpvhuAXdTRXaOSnE/EP/xfK7tYE3AhwU=;
  b=RAbbiFQ35b/zNAVoAftvitufSHyB+GdLRKkAjM/6hPXwMaX2tE6h+Cql
   OfQPeoJRosBIAiJXdPamIJnXTMVHBu2MmMmjK8lpAcC2MRMmI/1muVkGm
   rmZEsO7/3yy60sk31vg5zJv0MTObp3gYHcPnYR6j532L+QLOddrRFoGiU
   RhH89gn76SaR6O10+FkkQrKV2TLQbY5g0Cmnrnx6JbVQiNII7fA2CHwp5
   tA9jeaACsQiJKvnWPHhvoAMzbrP+0VmK79z9Hwy6k1TgQrf5RFl86NjFv
   Jqgq6Jr2yhI8C9AH1vdydUDKcb82gs9ipl8TVDrZqXjyPMxOjUac5Hhyu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275052066"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="275052066"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 10:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="706666218"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 31 May 2022 10:18:19 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw5Vb-0002uk-5m;
        Tue, 31 May 2022 17:18:19 +0000
Date:   Wed, 1 Jun 2022 01:17:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     kbuild-all@lists.01.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
Message-ID: <202206010131.m809TcwM-lkp@intel.com>
References: <20220531134854.63115-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531134854.63115-1-olga.kornievskaia@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on v5.18 next-20220531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Olga-Kornievskaia/pNFS-fix-IO-thread-starvation-problem-during-LAYOUTUNAVAILABLE-error/20220531-215040
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220601/202206010131.m809TcwM-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7f80a6c53d6cdb806706a8748cb79348f9906229
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Olga-Kornievskaia/pNFS-fix-IO-thread-starvation-problem-during-LAYOUTUNAVAILABLE-error/20220531-215040
        git checkout 7f80a6c53d6cdb806706a8748cb79348f9906229
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/nfs/pnfs.c: In function 'pnfs_update_layout':
>> fs/nfs/pnfs.c:2164:25: warning: this statement may fall through [-Wimplicit-fallthrough=]
    2164 |                         set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/pnfs.c:2165:17: note: here
    2165 |                 default:
         |                 ^~~~~~~


vim +2164 fs/nfs/pnfs.c

  1952	
  1953	/*
  1954	 * Layout segment is retreived from the server if not cached.
  1955	 * The appropriate layout segment is referenced and returned to the caller.
  1956	 */
  1957	struct pnfs_layout_segment *
  1958	pnfs_update_layout(struct inode *ino,
  1959			   struct nfs_open_context *ctx,
  1960			   loff_t pos,
  1961			   u64 count,
  1962			   enum pnfs_iomode iomode,
  1963			   bool strict_iomode,
  1964			   gfp_t gfp_flags)
  1965	{
  1966		struct pnfs_layout_range arg = {
  1967			.iomode = iomode,
  1968			.offset = pos,
  1969			.length = count,
  1970		};
  1971		unsigned pg_offset;
  1972		struct nfs_server *server = NFS_SERVER(ino);
  1973		struct nfs_client *clp = server->nfs_client;
  1974		struct pnfs_layout_hdr *lo = NULL;
  1975		struct pnfs_layout_segment *lseg = NULL;
  1976		struct nfs4_layoutget *lgp;
  1977		nfs4_stateid stateid;
  1978		long timeout = 0;
  1979		unsigned long giveup = jiffies + (clp->cl_lease_time << 1);
  1980		bool first;
  1981	
  1982		if (!pnfs_enabled_sb(NFS_SERVER(ino))) {
  1983			trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  1984					 PNFS_UPDATE_LAYOUT_NO_PNFS);
  1985			goto out;
  1986		}
  1987	
  1988		if (pnfs_within_mdsthreshold(ctx, ino, iomode)) {
  1989			trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  1990					 PNFS_UPDATE_LAYOUT_MDSTHRESH);
  1991			goto out;
  1992		}
  1993	
  1994	lookup_again:
  1995		lseg = ERR_PTR(nfs4_client_recover_expired_lease(clp));
  1996		if (IS_ERR(lseg))
  1997			goto out;
  1998		first = false;
  1999		spin_lock(&ino->i_lock);
  2000		lo = pnfs_find_alloc_layout(ino, ctx, gfp_flags);
  2001		if (lo == NULL) {
  2002			spin_unlock(&ino->i_lock);
  2003			trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  2004					 PNFS_UPDATE_LAYOUT_NOMEM);
  2005			goto out;
  2006		}
  2007	
  2008		/* Do we even need to bother with this? */
  2009		if (test_bit(NFS_LAYOUT_BULK_RECALL, &lo->plh_flags)) {
  2010			trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  2011					 PNFS_UPDATE_LAYOUT_BULK_RECALL);
  2012			dprintk("%s matches recall, use MDS\n", __func__);
  2013			goto out_unlock;
  2014		}
  2015	
  2016		/* if LAYOUTGET already failed once we don't try again */
  2017		if (pnfs_layout_io_test_failed(lo, iomode)) {
  2018			trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  2019					 PNFS_UPDATE_LAYOUT_IO_TEST_FAIL);
  2020			goto out_unlock;
  2021		}
  2022	
  2023		/*
  2024		 * If the layout segment list is empty, but there are outstanding
  2025		 * layoutget calls, then they might be subject to a layoutrecall.
  2026		 */
  2027		if ((list_empty(&lo->plh_segs) || !pnfs_layout_is_valid(lo)) &&
  2028		    atomic_read(&lo->plh_outstanding) != 0) {
  2029			spin_unlock(&ino->i_lock);
  2030			atomic_inc(&lo->plh_waiting);
  2031			lseg = ERR_PTR(wait_var_event_killable(&lo->plh_outstanding,
  2032						!atomic_read(&lo->plh_outstanding)));
  2033			if (IS_ERR(lseg)) {
  2034				atomic_dec(&lo->plh_waiting);
  2035				goto out_put_layout_hdr;
  2036			}
  2037			if (test_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags)) {
  2038				pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
  2039				lseg = NULL;
  2040				if (atomic_dec_and_test(&lo->plh_waiting))
  2041					clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
  2042				goto out_put_layout_hdr;
  2043			}
  2044			pnfs_put_layout_hdr(lo);
  2045			goto lookup_again;
  2046		}
  2047	
  2048		/*
  2049		 * Because we free lsegs when sending LAYOUTRETURN, we need to wait
  2050		 * for LAYOUTRETURN.
  2051		 */
  2052		if (test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags)) {
  2053			spin_unlock(&ino->i_lock);
  2054			dprintk("%s wait for layoutreturn\n", __func__);
  2055			lseg = ERR_PTR(pnfs_prepare_to_retry_layoutget(lo));
  2056			if (!IS_ERR(lseg)) {
  2057				pnfs_put_layout_hdr(lo);
  2058				dprintk("%s retrying\n", __func__);
  2059				trace_pnfs_update_layout(ino, pos, count, iomode, lo,
  2060							 lseg,
  2061							 PNFS_UPDATE_LAYOUT_RETRY);
  2062				goto lookup_again;
  2063			}
  2064			trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  2065						 PNFS_UPDATE_LAYOUT_RETURN);
  2066			goto out_put_layout_hdr;
  2067		}
  2068	
  2069		lseg = pnfs_find_lseg(lo, &arg, strict_iomode);
  2070		if (lseg) {
  2071			trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  2072					PNFS_UPDATE_LAYOUT_FOUND_CACHED);
  2073			goto out_unlock;
  2074		}
  2075	
  2076		/*
  2077		 * Choose a stateid for the LAYOUTGET. If we don't have a layout
  2078		 * stateid, or it has been invalidated, then we must use the open
  2079		 * stateid.
  2080		 */
  2081		if (test_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags)) {
  2082			int status;
  2083	
  2084			/*
  2085			 * The first layoutget for the file. Need to serialize per
  2086			 * RFC 5661 Errata 3208.
  2087			 */
  2088			if (test_and_set_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
  2089					     &lo->plh_flags)) {
  2090				spin_unlock(&ino->i_lock);
  2091				lseg = ERR_PTR(wait_on_bit(&lo->plh_flags,
  2092							NFS_LAYOUT_FIRST_LAYOUTGET,
  2093							TASK_KILLABLE));
  2094				if (IS_ERR(lseg))
  2095					goto out_put_layout_hdr;
  2096				pnfs_put_layout_hdr(lo);
  2097				dprintk("%s retrying\n", __func__);
  2098				goto lookup_again;
  2099			}
  2100	
  2101			spin_unlock(&ino->i_lock);
  2102			first = true;
  2103			status = nfs4_select_rw_stateid(ctx->state,
  2104						iomode == IOMODE_RW ? FMODE_WRITE : FMODE_READ,
  2105						NULL, &stateid, NULL);
  2106			if (status != 0) {
  2107				lseg = ERR_PTR(status);
  2108				trace_pnfs_update_layout(ino, pos, count,
  2109						iomode, lo, lseg,
  2110						PNFS_UPDATE_LAYOUT_INVALID_OPEN);
  2111				nfs4_schedule_stateid_recovery(server, ctx->state);
  2112				pnfs_clear_first_layoutget(lo);
  2113				pnfs_put_layout_hdr(lo);
  2114				goto lookup_again;
  2115			}
  2116			spin_lock(&ino->i_lock);
  2117		} else {
  2118			nfs4_stateid_copy(&stateid, &lo->plh_stateid);
  2119		}
  2120	
  2121		if (pnfs_layoutgets_blocked(lo)) {
  2122			trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  2123					PNFS_UPDATE_LAYOUT_BLOCKED);
  2124			goto out_unlock;
  2125		}
  2126		nfs_layoutget_begin(lo);
  2127		spin_unlock(&ino->i_lock);
  2128	
  2129		_add_to_server_list(lo, server);
  2130	
  2131		pg_offset = arg.offset & ~PAGE_MASK;
  2132		if (pg_offset) {
  2133			arg.offset -= pg_offset;
  2134			arg.length += pg_offset;
  2135		}
  2136		if (arg.length != NFS4_MAX_UINT64)
  2137			arg.length = PAGE_ALIGN(arg.length);
  2138	
  2139		lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &stateid, &arg, gfp_flags);
  2140		if (!lgp) {
  2141			trace_pnfs_update_layout(ino, pos, count, iomode, lo, NULL,
  2142						 PNFS_UPDATE_LAYOUT_NOMEM);
  2143			nfs_layoutget_end(lo);
  2144			goto out_put_layout_hdr;
  2145		}
  2146	
  2147		lgp->lo = lo;
  2148		pnfs_get_layout_hdr(lo);
  2149	
  2150		lseg = nfs4_proc_layoutget(lgp, &timeout);
  2151		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  2152					 PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET);
  2153		nfs_layoutget_end(lo);
  2154		if (IS_ERR(lseg)) {
  2155			switch(PTR_ERR(lseg)) {
  2156			case -EBUSY:
  2157				if (time_after(jiffies, giveup))
  2158					lseg = NULL;
  2159				break;
  2160			case -ERECALLCONFLICT:
  2161			case -EAGAIN:
  2162				break;
  2163			case -ENODATA:
> 2164				set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
  2165			default:
  2166				if (!nfs_error_is_fatal(PTR_ERR(lseg))) {
  2167					pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
  2168					lseg = NULL;
  2169				}
  2170				goto out_put_layout_hdr;
  2171			}
  2172			if (lseg) {
  2173				if (first)
  2174					pnfs_clear_first_layoutget(lo);
  2175				trace_pnfs_update_layout(ino, pos, count,
  2176					iomode, lo, lseg, PNFS_UPDATE_LAYOUT_RETRY);
  2177				pnfs_put_layout_hdr(lo);
  2178				goto lookup_again;
  2179			}
  2180		} else {
  2181			pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
  2182		}
  2183	
  2184	out_put_layout_hdr:
  2185		if (first)
  2186			pnfs_clear_first_layoutget(lo);
  2187		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
  2188					 PNFS_UPDATE_LAYOUT_EXIT);
  2189		pnfs_put_layout_hdr(lo);
  2190	out:
  2191		dprintk("%s: inode %s/%llu pNFS layout segment %s for "
  2192				"(%s, offset: %llu, length: %llu)\n",
  2193				__func__, ino->i_sb->s_id,
  2194				(unsigned long long)NFS_FILEID(ino),
  2195				IS_ERR_OR_NULL(lseg) ? "not found" : "found",
  2196				iomode==IOMODE_RW ?  "read/write" : "read-only",
  2197				(unsigned long long)pos,
  2198				(unsigned long long)count);
  2199		return lseg;
  2200	out_unlock:
  2201		spin_unlock(&ino->i_lock);
  2202		goto out_put_layout_hdr;
  2203	}
  2204	EXPORT_SYMBOL_GPL(pnfs_update_layout);
  2205	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
