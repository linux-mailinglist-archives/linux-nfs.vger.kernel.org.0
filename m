Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B9653961A
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 20:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbiEaST1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242745AbiEaST0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 14:19:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31CC996B6
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654021164; x=1685557164;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AQ2jpwxkSoJ4R9OnKoOl1TS+/6tsTed7RS6cZR1YS0k=;
  b=Z35tOOJtfH2wUIAMRq0MnJvwxXVheQOuO5XhDkBx4tH8AuBVunlugKPh
   og6Ygo2ujVKOuZQL1udn7B7gCasqA4RHl49tIMQDv7x0c0c9Ddw3C3ssR
   GF35mpsCPhfXckEUJ5AeEuB8vxBzMqBF+k1a1J+5V5BhaQz8DguKTDw7W
   3h4yIOax5VsJt2Nk4Kx7ZUVGBWw5Af+wH5oaqVxC2zrlttWn9Nj3wqBJ6
   b9+schB8L6BwuaLWewMn3kycDrwHtGOpVIApQINfKmIYil4qwkd/Pg/kY
   B5GD5taqx8yQGVvXrXrE2fTR6NZ9y/7+B9qYJiuHaeRP+F9x0+7K/KHcb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275350628"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275350628"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 11:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="576531724"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 31 May 2022 11:19:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw6Se-0002xG-Jh;
        Tue, 31 May 2022 18:19:20 +0000
Date:   Wed, 1 Jun 2022 02:19:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] pNFS: fix IO thread starvation problem during
 LAYOUTUNAVAILABLE error
Message-ID: <202206010223.Zov1XR1x-lkp@intel.com>
References: <20220531134854.63115-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531134854.63115-1-olga.kornievskaia@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220601/202206010223.Zov1XR1x-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c825abd6b0198fb088d9752f556a70705bc99dfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7f80a6c53d6cdb806706a8748cb79348f9906229
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Olga-Kornievskaia/pNFS-fix-IO-thread-starvation-problem-during-LAYOUTUNAVAILABLE-error/20220531-215040
        git checkout 7f80a6c53d6cdb806706a8748cb79348f9906229
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/nfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/nfs/pnfs.c:2165:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
                   default:
                   ^
   fs/nfs/pnfs.c:2165:3: note: insert '__attribute__((fallthrough));' to silence this warning
                   default:
                   ^
                   __attribute__((fallthrough)); 
   fs/nfs/pnfs.c:2165:3: note: insert 'break;' to avoid fall-through
                   default:
                   ^
                   break; 
   1 warning generated.


vim +2165 fs/nfs/pnfs.c

78746a384c88c64 Fred Isaman           2016-09-22  1952  
e5e940170b2136a Benny Halevy          2010-10-20  1953  /*
e5e940170b2136a Benny Halevy          2010-10-20  1954   * Layout segment is retreived from the server if not cached.
e5e940170b2136a Benny Halevy          2010-10-20  1955   * The appropriate layout segment is referenced and returned to the caller.
e5e940170b2136a Benny Halevy          2010-10-20  1956   */
7c24d9489fe57d6 Andy Adamson          2011-06-13  1957  struct pnfs_layout_segment *
e5e940170b2136a Benny Halevy          2010-10-20  1958  pnfs_update_layout(struct inode *ino,
e5e940170b2136a Benny Halevy          2010-10-20  1959  		   struct nfs_open_context *ctx,
fb3296eb4636763 Benny Halevy          2011-05-22  1960  		   loff_t pos,
fb3296eb4636763 Benny Halevy          2011-05-22  1961  		   u64 count,
a75b9df9d3bfc3c Trond Myklebust       2011-05-11  1962  		   enum pnfs_iomode iomode,
c7d73af2d249f03 Tom Haynes            2016-05-25  1963  		   bool strict_iomode,
a75b9df9d3bfc3c Trond Myklebust       2011-05-11  1964  		   gfp_t gfp_flags)
e5e940170b2136a Benny Halevy          2010-10-20  1965  {
fb3296eb4636763 Benny Halevy          2011-05-22  1966  	struct pnfs_layout_range arg = {
fb3296eb4636763 Benny Halevy          2011-05-22  1967  		.iomode = iomode,
fb3296eb4636763 Benny Halevy          2011-05-22  1968  		.offset = pos,
fb3296eb4636763 Benny Halevy          2011-05-22  1969  		.length = count,
fb3296eb4636763 Benny Halevy          2011-05-22  1970  	};
70d2f7b1ea19b7e Trond Myklebust       2017-09-11  1971  	unsigned pg_offset;
6382a44138e7aa4 Weston Andros Adamson 2011-06-01  1972  	struct nfs_server *server = NFS_SERVER(ino);
6382a44138e7aa4 Weston Andros Adamson 2011-06-01  1973  	struct nfs_client *clp = server->nfs_client;
183d9e7b112aaed Jeff Layton           2016-05-17  1974  	struct pnfs_layout_hdr *lo = NULL;
e5e940170b2136a Benny Halevy          2010-10-20  1975  	struct pnfs_layout_segment *lseg = NULL;
587f03deb69bdbf Fred Isaman           2016-09-21  1976  	struct nfs4_layoutget *lgp;
183d9e7b112aaed Jeff Layton           2016-05-17  1977  	nfs4_stateid stateid;
183d9e7b112aaed Jeff Layton           2016-05-17  1978  	long timeout = 0;
66b53f325876703 Trond Myklebust       2016-07-14  1979  	unsigned long giveup = jiffies + (clp->cl_lease_time << 1);
3000512137602b8 Weston Andros Adamson 2013-02-28  1980  	bool first;
e5e940170b2136a Benny Halevy          2010-10-20  1981  
9a4bf31d05a801e Jeff Layton           2015-12-10  1982  	if (!pnfs_enabled_sb(NFS_SERVER(ino))) {
183d9e7b112aaed Jeff Layton           2016-05-17  1983  		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
9a4bf31d05a801e Jeff Layton           2015-12-10  1984  				 PNFS_UPDATE_LAYOUT_NO_PNFS);
f86bbcf85db3259 Trond Myklebust       2012-09-26  1985  		goto out;
9a4bf31d05a801e Jeff Layton           2015-12-10  1986  	}
d23d61c8d351f5c Andy Adamson          2012-05-23  1987  
9a4bf31d05a801e Jeff Layton           2015-12-10  1988  	if (pnfs_within_mdsthreshold(ctx, ino, iomode)) {
183d9e7b112aaed Jeff Layton           2016-05-17  1989  		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
9a4bf31d05a801e Jeff Layton           2015-12-10  1990  				 PNFS_UPDATE_LAYOUT_MDSTHRESH);
f86bbcf85db3259 Trond Myklebust       2012-09-26  1991  		goto out;
9a4bf31d05a801e Jeff Layton           2015-12-10  1992  	}
d23d61c8d351f5c Andy Adamson          2012-05-23  1993  
9bf87482ddc6f8d Peng Tao              2014-08-22  1994  lookup_again:
d03360aaf5ccac4 Trond Myklebust       2018-09-05  1995  	lseg = ERR_PTR(nfs4_client_recover_expired_lease(clp));
d03360aaf5ccac4 Trond Myklebust       2018-09-05  1996  	if (IS_ERR(lseg))
d03360aaf5ccac4 Trond Myklebust       2018-09-05  1997  		goto out;
9bf87482ddc6f8d Peng Tao              2014-08-22  1998  	first = false;
e5e940170b2136a Benny Halevy          2010-10-20  1999  	spin_lock(&ino->i_lock);
9fa4075878a5faa Peng Tao              2011-07-30  2000  	lo = pnfs_find_alloc_layout(ino, ctx, gfp_flags);
830ffb565760234 Trond Myklebust       2012-09-20  2001  	if (lo == NULL) {
830ffb565760234 Trond Myklebust       2012-09-20  2002  		spin_unlock(&ino->i_lock);
183d9e7b112aaed Jeff Layton           2016-05-17  2003  		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
9a4bf31d05a801e Jeff Layton           2015-12-10  2004  				 PNFS_UPDATE_LAYOUT_NOMEM);
830ffb565760234 Trond Myklebust       2012-09-20  2005  		goto out;
830ffb565760234 Trond Myklebust       2012-09-20  2006  	}
e5e940170b2136a Benny Halevy          2010-10-20  2007  
43f1b3da8b35d70 Fred Isaman           2011-01-06  2008  	/* Do we even need to bother with this? */
a59c30acfbe701d Trond Myklebust       2012-03-01  2009  	if (test_bit(NFS_LAYOUT_BULK_RECALL, &lo->plh_flags)) {
183d9e7b112aaed Jeff Layton           2016-05-17  2010  		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
9a4bf31d05a801e Jeff Layton           2015-12-10  2011  				 PNFS_UPDATE_LAYOUT_BULK_RECALL);
43f1b3da8b35d70 Fred Isaman           2011-01-06  2012  		dprintk("%s matches recall, use MDS\n", __func__);
e5e940170b2136a Benny Halevy          2010-10-20  2013  		goto out_unlock;
e5e940170b2136a Benny Halevy          2010-10-20  2014  	}
e5e940170b2136a Benny Halevy          2010-10-20  2015  
e5e940170b2136a Benny Halevy          2010-10-20  2016  	/* if LAYOUTGET already failed once we don't try again */
2e5b29f0448be9e Trond Myklebust       2015-12-14  2017  	if (pnfs_layout_io_test_failed(lo, iomode)) {
183d9e7b112aaed Jeff Layton           2016-05-17  2018  		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
9a4bf31d05a801e Jeff Layton           2015-12-10  2019  				 PNFS_UPDATE_LAYOUT_IO_TEST_FAIL);
e5e940170b2136a Benny Halevy          2010-10-20  2020  		goto out_unlock;
9a4bf31d05a801e Jeff Layton           2015-12-10  2021  	}
e5e940170b2136a Benny Halevy          2010-10-20  2022  
411ae722d10a6d4 Trond Myklebust       2018-06-23  2023  	/*
411ae722d10a6d4 Trond Myklebust       2018-06-23  2024  	 * If the layout segment list is empty, but there are outstanding
411ae722d10a6d4 Trond Myklebust       2018-06-23  2025  	 * layoutget calls, then they might be subject to a layoutrecall.
411ae722d10a6d4 Trond Myklebust       2018-06-23  2026  	 */
0b77f97a7e42adc Trond Myklebust       2021-07-02  2027  	if ((list_empty(&lo->plh_segs) || !pnfs_layout_is_valid(lo)) &&
411ae722d10a6d4 Trond Myklebust       2018-06-23  2028  	    atomic_read(&lo->plh_outstanding) != 0) {
411ae722d10a6d4 Trond Myklebust       2018-06-23  2029  		spin_unlock(&ino->i_lock);
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2030  		atomic_inc(&lo->plh_waiting);
d03360aaf5ccac4 Trond Myklebust       2018-09-05  2031  		lseg = ERR_PTR(wait_var_event_killable(&lo->plh_outstanding,
400417b05f3ec05 Trond Myklebust       2019-03-12  2032  					!atomic_read(&lo->plh_outstanding)));
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2033  		if (IS_ERR(lseg)) {
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2034  			atomic_dec(&lo->plh_waiting);
411ae722d10a6d4 Trond Myklebust       2018-06-23  2035  			goto out_put_layout_hdr;
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2036  		}
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2037  		if (test_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags)) {
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2038  			pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2039  			lseg = NULL;
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2040  			if (atomic_dec_and_test(&lo->plh_waiting))
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2041  				clear_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2042  			goto out_put_layout_hdr;
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2043  		}
411ae722d10a6d4 Trond Myklebust       2018-06-23  2044  		pnfs_put_layout_hdr(lo);
411ae722d10a6d4 Trond Myklebust       2018-06-23  2045  		goto lookup_again;
411ae722d10a6d4 Trond Myklebust       2018-06-23  2046  	}
411ae722d10a6d4 Trond Myklebust       2018-06-23  2047  
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2048  	/*
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2049  	 * Because we free lsegs when sending LAYOUTRETURN, we need to wait
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2050  	 * for LAYOUTRETURN.
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2051  	 */
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2052  	if (test_bit(NFS_LAYOUT_RETURN, &lo->plh_flags)) {
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2053  		spin_unlock(&ino->i_lock);
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2054  		dprintk("%s wait for layoutreturn\n", __func__);
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2055  		lseg = ERR_PTR(pnfs_prepare_to_retry_layoutget(lo));
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2056  		if (!IS_ERR(lseg)) {
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2057  			pnfs_put_layout_hdr(lo);
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2058  			dprintk("%s retrying\n", __func__);
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2059  			trace_pnfs_update_layout(ino, pos, count, iomode, lo,
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2060  						 lseg,
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2061  						 PNFS_UPDATE_LAYOUT_RETRY);
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2062  			goto lookup_again;
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2063  		}
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2064  		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2065  					 PNFS_UPDATE_LAYOUT_RETURN);
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2066  		goto out_put_layout_hdr;
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2067  	}
2c8d5fc37fe2384 Trond Myklebust       2021-01-05  2068  
c7d73af2d249f03 Tom Haynes            2016-05-25  2069  	lseg = pnfs_find_lseg(lo, &arg, strict_iomode);
183d9e7b112aaed Jeff Layton           2016-05-17  2070  	if (lseg) {
183d9e7b112aaed Jeff Layton           2016-05-17  2071  		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
183d9e7b112aaed Jeff Layton           2016-05-17  2072  				PNFS_UPDATE_LAYOUT_FOUND_CACHED);
183d9e7b112aaed Jeff Layton           2016-05-17  2073  		goto out_unlock;
183d9e7b112aaed Jeff Layton           2016-05-17  2074  	}
183d9e7b112aaed Jeff Layton           2016-05-17  2075  
183d9e7b112aaed Jeff Layton           2016-05-17  2076  	/*
183d9e7b112aaed Jeff Layton           2016-05-17  2077  	 * Choose a stateid for the LAYOUTGET. If we don't have a layout
183d9e7b112aaed Jeff Layton           2016-05-17  2078  	 * stateid, or it has been invalidated, then we must use the open
183d9e7b112aaed Jeff Layton           2016-05-17  2079  	 * stateid.
183d9e7b112aaed Jeff Layton           2016-05-17  2080  	 */
67a3b721462c9b3 Trond Myklebust       2016-06-17  2081  	if (test_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags)) {
d9aba2b40de6fdd Trond Myklebust       2019-07-16  2082  		int status;
183d9e7b112aaed Jeff Layton           2016-05-17  2083  
183d9e7b112aaed Jeff Layton           2016-05-17  2084  		/*
183d9e7b112aaed Jeff Layton           2016-05-17  2085  		 * The first layoutget for the file. Need to serialize per
9bf87482ddc6f8d Peng Tao              2014-08-22  2086  		 * RFC 5661 Errata 3208.
9bf87482ddc6f8d Peng Tao              2014-08-22  2087  		 */
9bf87482ddc6f8d Peng Tao              2014-08-22  2088  		if (test_and_set_bit(NFS_LAYOUT_FIRST_LAYOUTGET,
9bf87482ddc6f8d Peng Tao              2014-08-22  2089  				     &lo->plh_flags)) {
9bf87482ddc6f8d Peng Tao              2014-08-22  2090  			spin_unlock(&ino->i_lock);
d03360aaf5ccac4 Trond Myklebust       2018-09-05  2091  			lseg = ERR_PTR(wait_on_bit(&lo->plh_flags,
d03360aaf5ccac4 Trond Myklebust       2018-09-05  2092  						NFS_LAYOUT_FIRST_LAYOUTGET,
d03360aaf5ccac4 Trond Myklebust       2018-09-05  2093  						TASK_KILLABLE));
d03360aaf5ccac4 Trond Myklebust       2018-09-05  2094  			if (IS_ERR(lseg))
d03360aaf5ccac4 Trond Myklebust       2018-09-05  2095  				goto out_put_layout_hdr;
9bf87482ddc6f8d Peng Tao              2014-08-22  2096  			pnfs_put_layout_hdr(lo);
183d9e7b112aaed Jeff Layton           2016-05-17  2097  			dprintk("%s retrying\n", __func__);
9bf87482ddc6f8d Peng Tao              2014-08-22  2098  			goto lookup_again;
9bf87482ddc6f8d Peng Tao              2014-08-22  2099  		}
183d9e7b112aaed Jeff Layton           2016-05-17  2100  
fbf4bcc9a837312 Trond Myklebust       2020-04-13  2101  		spin_unlock(&ino->i_lock);
183d9e7b112aaed Jeff Layton           2016-05-17  2102  		first = true;
d9aba2b40de6fdd Trond Myklebust       2019-07-16  2103  		status = nfs4_select_rw_stateid(ctx->state,
70d2f7b1ea19b7e Trond Myklebust       2017-09-11  2104  					iomode == IOMODE_RW ? FMODE_WRITE : FMODE_READ,
d9aba2b40de6fdd Trond Myklebust       2019-07-16  2105  					NULL, &stateid, NULL);
d9aba2b40de6fdd Trond Myklebust       2019-07-16  2106  		if (status != 0) {
731c74dd987e4f1 Trond Myklebust       2019-07-22  2107  			lseg = ERR_PTR(status);
70d2f7b1ea19b7e Trond Myklebust       2017-09-11  2108  			trace_pnfs_update_layout(ino, pos, count,
70d2f7b1ea19b7e Trond Myklebust       2017-09-11  2109  					iomode, lo, lseg,
70d2f7b1ea19b7e Trond Myklebust       2017-09-11  2110  					PNFS_UPDATE_LAYOUT_INVALID_OPEN);
d9aba2b40de6fdd Trond Myklebust       2019-07-16  2111  			nfs4_schedule_stateid_recovery(server, ctx->state);
d9aba2b40de6fdd Trond Myklebust       2019-07-16  2112  			pnfs_clear_first_layoutget(lo);
d9aba2b40de6fdd Trond Myklebust       2019-07-16  2113  			pnfs_put_layout_hdr(lo);
d9aba2b40de6fdd Trond Myklebust       2019-07-16  2114  			goto lookup_again;
70d2f7b1ea19b7e Trond Myklebust       2017-09-11  2115  		}
fbf4bcc9a837312 Trond Myklebust       2020-04-13  2116  		spin_lock(&ino->i_lock);
9bf87482ddc6f8d Peng Tao              2014-08-22  2117  	} else {
183d9e7b112aaed Jeff Layton           2016-05-17  2118  		nfs4_stateid_copy(&stateid, &lo->plh_stateid);
9a4bf31d05a801e Jeff Layton           2015-12-10  2119  	}
568e8c494ded95a Andy Adamson          2011-03-01  2120  
9a4bf31d05a801e Jeff Layton           2015-12-10  2121  	if (pnfs_layoutgets_blocked(lo)) {
183d9e7b112aaed Jeff Layton           2016-05-17  2122  		trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
9a4bf31d05a801e Jeff Layton           2015-12-10  2123  				PNFS_UPDATE_LAYOUT_BLOCKED);
cf7d63f1f989571 Fred Isaman           2011-01-06  2124  		goto out_unlock;
9a4bf31d05a801e Jeff Layton           2015-12-10  2125  	}
411ae722d10a6d4 Trond Myklebust       2018-06-23  2126  	nfs_layoutget_begin(lo);
f49f9baac8f63de Fred Isaman           2011-02-03  2127  	spin_unlock(&ino->i_lock);
3000512137602b8 Weston Andros Adamson 2013-02-28  2128  
78746a384c88c64 Fred Isaman           2016-09-22  2129  	_add_to_server_list(lo, server);
e5e940170b2136a Benny Halevy          2010-10-20  2130  
09cbfeaf1a5a67b Kirill A. Shutemov    2016-04-01  2131  	pg_offset = arg.offset & ~PAGE_MASK;
707ed5fdb587c71 Benny Halevy          2011-05-22  2132  	if (pg_offset) {
707ed5fdb587c71 Benny Halevy          2011-05-22  2133  		arg.offset -= pg_offset;
707ed5fdb587c71 Benny Halevy          2011-05-22  2134  		arg.length += pg_offset;
707ed5fdb587c71 Benny Halevy          2011-05-22  2135  	}
7c24d9489fe57d6 Andy Adamson          2011-06-13  2136  	if (arg.length != NFS4_MAX_UINT64)
09cbfeaf1a5a67b Kirill A. Shutemov    2016-04-01  2137  		arg.length = PAGE_ALIGN(arg.length);
707ed5fdb587c71 Benny Halevy          2011-05-22  2138  
5e36e2a9411210b Fred Isaman           2016-10-06  2139  	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &stateid, &arg, gfp_flags);
587f03deb69bdbf Fred Isaman           2016-09-21  2140  	if (!lgp) {
587f03deb69bdbf Fred Isaman           2016-09-21  2141  		trace_pnfs_update_layout(ino, pos, count, iomode, lo, NULL,
587f03deb69bdbf Fred Isaman           2016-09-21  2142  					 PNFS_UPDATE_LAYOUT_NOMEM);
411ae722d10a6d4 Trond Myklebust       2018-06-23  2143  		nfs_layoutget_end(lo);
587f03deb69bdbf Fred Isaman           2016-09-21  2144  		goto out_put_layout_hdr;
587f03deb69bdbf Fred Isaman           2016-09-21  2145  	}
587f03deb69bdbf Fred Isaman           2016-09-21  2146  
b4e89bcba2b3a96 Trond Myklebust       2021-07-02  2147  	lgp->lo = lo;
b4e89bcba2b3a96 Trond Myklebust       2021-07-02  2148  	pnfs_get_layout_hdr(lo);
b4e89bcba2b3a96 Trond Myklebust       2021-07-02  2149  
dacb452db873347 Fred Isaman           2016-09-19  2150  	lseg = nfs4_proc_layoutget(lgp, &timeout);
183d9e7b112aaed Jeff Layton           2016-05-17  2151  	trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
183d9e7b112aaed Jeff Layton           2016-05-17  2152  				 PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET);
411ae722d10a6d4 Trond Myklebust       2018-06-23  2153  	nfs_layoutget_end(lo);
83026d80a16ea6a Jeff Layton           2016-05-17  2154  	if (IS_ERR(lseg)) {
183d9e7b112aaed Jeff Layton           2016-05-17  2155  		switch(PTR_ERR(lseg)) {
e85d7ee42003314 Trond Myklebust       2016-07-14  2156  		case -EBUSY:
183d9e7b112aaed Jeff Layton           2016-05-17  2157  			if (time_after(jiffies, giveup))
183d9e7b112aaed Jeff Layton           2016-05-17  2158  				lseg = NULL;
66b53f325876703 Trond Myklebust       2016-07-14  2159  			break;
66b53f325876703 Trond Myklebust       2016-07-14  2160  		case -ERECALLCONFLICT:
183d9e7b112aaed Jeff Layton           2016-05-17  2161  		case -EAGAIN:
56b38a1f7c78151 Trond Myklebust       2016-07-14  2162  			break;
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2163  		case -ENODATA:
7f80a6c53d6cdb8 Olga Kornievskaia     2022-05-31  2164  			set_bit(NFS_LAYOUT_DRAIN, &lo->plh_flags);
183d9e7b112aaed Jeff Layton           2016-05-17 @2165  		default:
83026d80a16ea6a Jeff Layton           2016-05-17  2166  			if (!nfs_error_is_fatal(PTR_ERR(lseg))) {
83026d80a16ea6a Jeff Layton           2016-05-17  2167  				pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
83026d80a16ea6a Jeff Layton           2016-05-17  2168  				lseg = NULL;
83026d80a16ea6a Jeff Layton           2016-05-17  2169  			}
56b38a1f7c78151 Trond Myklebust       2016-07-14  2170  			goto out_put_layout_hdr;
56b38a1f7c78151 Trond Myklebust       2016-07-14  2171  		}
56b38a1f7c78151 Trond Myklebust       2016-07-14  2172  		if (lseg) {
56b38a1f7c78151 Trond Myklebust       2016-07-14  2173  			if (first)
56b38a1f7c78151 Trond Myklebust       2016-07-14  2174  				pnfs_clear_first_layoutget(lo);
56b38a1f7c78151 Trond Myklebust       2016-07-14  2175  			trace_pnfs_update_layout(ino, pos, count,
56b38a1f7c78151 Trond Myklebust       2016-07-14  2176  				iomode, lo, lseg, PNFS_UPDATE_LAYOUT_RETRY);
56b38a1f7c78151 Trond Myklebust       2016-07-14  2177  			pnfs_put_layout_hdr(lo);
56b38a1f7c78151 Trond Myklebust       2016-07-14  2178  			goto lookup_again;
183d9e7b112aaed Jeff Layton           2016-05-17  2179  		}
83026d80a16ea6a Jeff Layton           2016-05-17  2180  	} else {
83026d80a16ea6a Jeff Layton           2016-05-17  2181  		pnfs_layout_clear_fail_bit(lo, pnfs_iomode_to_fail_bit(iomode));
83026d80a16ea6a Jeff Layton           2016-05-17  2182  	}
83026d80a16ea6a Jeff Layton           2016-05-17  2183  
830ffb565760234 Trond Myklebust       2012-09-20  2184  out_put_layout_hdr:
d67ae825a59d639 Tom Haynes            2014-12-11  2185  	if (first)
d67ae825a59d639 Tom Haynes            2014-12-11  2186  		pnfs_clear_first_layoutget(lo);
d5b9216fd5114be Trond Myklebust       2019-07-18  2187  	trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
d5b9216fd5114be Trond Myklebust       2019-07-18  2188  				 PNFS_UPDATE_LAYOUT_EXIT);
70c3bd2bdf9a3c7 Trond Myklebust       2012-09-18  2189  	pnfs_put_layout_hdr(lo);
e5e940170b2136a Benny Halevy          2010-10-20  2190  out:
f86bbcf85db3259 Trond Myklebust       2012-09-26  2191  	dprintk("%s: inode %s/%llu pNFS layout segment %s for "
f86bbcf85db3259 Trond Myklebust       2012-09-26  2192  			"(%s, offset: %llu, length: %llu)\n",
f86bbcf85db3259 Trond Myklebust       2012-09-26  2193  			__func__, ino->i_sb->s_id,
f86bbcf85db3259 Trond Myklebust       2012-09-26  2194  			(unsigned long long)NFS_FILEID(ino),
d600ad1f2bdbf97 Peng Tao              2015-12-04  2195  			IS_ERR_OR_NULL(lseg) ? "not found" : "found",
f86bbcf85db3259 Trond Myklebust       2012-09-26  2196  			iomode==IOMODE_RW ?  "read/write" : "read-only",
f86bbcf85db3259 Trond Myklebust       2012-09-26  2197  			(unsigned long long)pos,
f86bbcf85db3259 Trond Myklebust       2012-09-26  2198  			(unsigned long long)count);
e5e940170b2136a Benny Halevy          2010-10-20  2199  	return lseg;
e5e940170b2136a Benny Halevy          2010-10-20  2200  out_unlock:
e5e940170b2136a Benny Halevy          2010-10-20  2201  	spin_unlock(&ino->i_lock);
830ffb565760234 Trond Myklebust       2012-09-20  2202  	goto out_put_layout_hdr;
e5e940170b2136a Benny Halevy          2010-10-20  2203  }
7c24d9489fe57d6 Andy Adamson          2011-06-13  2204  EXPORT_SYMBOL_GPL(pnfs_update_layout);
b1f69b754ee312e Andy Adamson          2010-10-20  2205  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
