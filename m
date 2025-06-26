Return-Path: <linux-nfs+bounces-12800-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B37FAEAAC9
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Jun 2025 01:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E1916BCFC
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Jun 2025 23:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608DB12DDA1;
	Thu, 26 Jun 2025 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWQapn7V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD521B185
	for <linux-nfs@vger.kernel.org>; Thu, 26 Jun 2025 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981384; cv=none; b=PaO4BCA1ir+F4SvGqYni/b0To9eTbtmNs5kY/UbFtkG1d0yR7Yol8bSwUPEA2QbTWlzsbfh3HNjgDVTkLhpFhlD3Hrqctd3ta27nN9XX5lhUhGenlL5+suOeVSpiNZCqD6jevfP2QbGjpXuQpOMGy17vG/GY6YwTYTSQY85LLPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981384; c=relaxed/simple;
	bh=s+sHXnMIu9ogKtKBJRsBiK9Etovg11vexBmTduJQ9mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Coehyk1Lg26yFPeS+7MOHWZg8Me9VYlWvK/ZL+WD/XKt/DrNeksO4Q6/8F1zEB05Knc3RPimYHM5kaN8VGGY+7X/6XuSrb6T9yiu/kzSmuxz9f2679Vs7Fe4Y0EhIvgOriDntc3e7M2jUdxOB5V21lfYI5GTcYQ/vI67qm+SIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWQapn7V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750981382; x=1782517382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+sHXnMIu9ogKtKBJRsBiK9Etovg11vexBmTduJQ9mg=;
  b=eWQapn7VsJCbYlpHZrxoGiGajDd2IOVM7TCqVnlTNnHZ6ikormHaxA5e
   J5N0jbUXG3CTL88J31yAsTZp/88C3VuIkiDJec3swzSAtgK3xv58Yxlnj
   aLpTIYsWWJd6Wd68QJOUVMlsAD7ciKkp+ZkNpF1IayTWO7s0d6CC/MjKo
   bBOOA7mSEbaKLeMh4eLA76YniiAHNx0DBpM+DVWE9SjDFD4IDF/27TXbv
   V52uI9Br6frlsbLyZX5GD+pDGwNcrxvfriJmRZC1jP5gZekiK3HKXD6bp
   WRqaHjhVScEEa/6G4tsovV9Zrh9uMolIKMJYChy+2ohzgCfOZNxl7R7gC
   w==;
X-CSE-ConnectionGUID: Oz56atXgTGu7xFtAajStGA==
X-CSE-MsgGUID: uqhmakuZRZucRRVwc75xTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57077584"
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="57077584"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 16:43:02 -0700
X-CSE-ConnectionGUID: ylBp68rwRX6NV3ZHbObM+Q==
X-CSE-MsgGUID: 5Bv4H2IUT8aJCbK+/gPg+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,268,1744095600"; 
   d="scan'208";a="183691181"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 26 Jun 2025 16:42:59 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUwF7-000Vdg-0Z;
	Thu, 26 Jun 2025 23:42:57 +0000
Date: Fri, 27 Jun 2025 07:42:33 +0800
From: kernel test robot <lkp@intel.com>
To: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>, linux-nfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	root max-exfl020 <root@max-exfl020.desy.de>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: Re: [PATCH] pNFS/flexfiles: don't attempt pnfs on fatal DS errors
Message-ID: <202506270701.wUk38xC4-lkp@intel.com>
References: <20250626091202.130567-1-tigran.mkrtchyan@desy.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626091202.130567-1-tigran.mkrtchyan@desy.de>

Hi Tigran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.16-rc3 next-20250626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tigran-Mkrtchyan/pNFS-flexfiles-don-t-attempt-pnfs-on-fatal-DS-errors/20250626-171336
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250626091202.130567-1-tigran.mkrtchyan%40desy.de
patch subject: [PATCH] pNFS/flexfiles: don't attempt pnfs on fatal DS errors
config: i386-buildonly-randconfig-005-20250627 (https://download.01.org/0day-ci/archive/20250627/202506270701.wUk38xC4-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506270701.wUk38xC4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506270701.wUk38xC4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nfs/flexfilelayout/flexfilelayoutdev.c:56:9: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
      56 |         int i, ret = -ENOMEM;
         |                ^
>> fs/nfs/flexfilelayout/flexfilelayoutdev.c:379:6: warning: variable 'status' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     379 |         if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/flexfilelayout/flexfilelayoutdev.c:421:15: note: uninitialized use occurs here
     421 |         ds = ERR_PTR(status);
         |                      ^~~~~~
   fs/nfs/flexfilelayout/flexfilelayoutdev.c:379:2: note: remove the 'if' if its condition is always false
     379 |         if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     380 |                 goto noconnect;
         |                 ~~~~~~~~~~~~~~
   fs/nfs/flexfilelayout/flexfilelayoutdev.c:377:12: note: initialize the variable 'status' to silence this warning
     377 |         int status;
         |                   ^
         |                    = 0
   2 warnings generated.


vim +379 fs/nfs/flexfilelayout/flexfilelayoutdev.c

cefa587a40bb53 Trond Myklebust       2019-02-28  350  
95e2b7e95d43c5 Jeff Layton           2016-05-17  351  /**
95e2b7e95d43c5 Jeff Layton           2016-05-17  352   * nfs4_ff_layout_prepare_ds - prepare a DS connection for an RPC call
95e2b7e95d43c5 Jeff Layton           2016-05-17  353   * @lseg: the layout segment we're operating on
2444ff277a686d Trond Myklebust       2019-02-14  354   * @mirror: layout mirror describing the DS to use
95e2b7e95d43c5 Jeff Layton           2016-05-17  355   * @fail_return: return layout on connect failure?
95e2b7e95d43c5 Jeff Layton           2016-05-17  356   *
95e2b7e95d43c5 Jeff Layton           2016-05-17  357   * Try to prepare a DS connection to accept an RPC call. This involves
95e2b7e95d43c5 Jeff Layton           2016-05-17  358   * selecting a mirror to use and connecting the client to it if it's not
95e2b7e95d43c5 Jeff Layton           2016-05-17  359   * already connected.
95e2b7e95d43c5 Jeff Layton           2016-05-17  360   *
95e2b7e95d43c5 Jeff Layton           2016-05-17  361   * Since we only need a single functioning mirror to satisfy a read, we don't
95e2b7e95d43c5 Jeff Layton           2016-05-17  362   * want to return the layout if there is one. For writes though, any down
95e2b7e95d43c5 Jeff Layton           2016-05-17  363   * mirror should result in a LAYOUTRETURN. @fail_return is how we distinguish
95e2b7e95d43c5 Jeff Layton           2016-05-17  364   * between the two cases.
95e2b7e95d43c5 Jeff Layton           2016-05-17  365   *
95e2b7e95d43c5 Jeff Layton           2016-05-17  366   * Returns a pointer to a connected DS object on success or NULL on failure.
95e2b7e95d43c5 Jeff Layton           2016-05-17  367   */
d67ae825a59d63 Tom Haynes            2014-12-11  368  struct nfs4_pnfs_ds *
2444ff277a686d Trond Myklebust       2019-02-14  369  nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
2444ff277a686d Trond Myklebust       2019-02-14  370  			  struct nfs4_ff_layout_mirror *mirror,
d67ae825a59d63 Tom Haynes            2014-12-11  371  			  bool fail_return)
d67ae825a59d63 Tom Haynes            2014-12-11  372  {
6468b866bac7de root max-exfl020      2025-06-26  373  	struct nfs4_pnfs_ds *ds = ERR_PTR(-EAGAIN);
d67ae825a59d63 Tom Haynes            2014-12-11  374  	struct inode *ino = lseg->pls_layout->plh_inode;
d67ae825a59d63 Tom Haynes            2014-12-11  375  	struct nfs_server *s = NFS_SERVER(ino);
d67ae825a59d63 Tom Haynes            2014-12-11  376  	unsigned int max_payload;
a33e4b036d4612 Weston Andros Adamson 2017-03-09  377  	int status;
d67ae825a59d63 Tom Haynes            2014-12-11  378  
cefa587a40bb53 Trond Myklebust       2019-02-28 @379  	if (!ff_layout_init_mirror_ds(lseg->pls_layout, mirror))
0a156dd58274b0 Trond Myklebust       2019-02-27  380  		goto noconnect;
d67ae825a59d63 Tom Haynes            2014-12-11  381  
d67ae825a59d63 Tom Haynes            2014-12-11  382  	ds = mirror->mirror_ds->ds;
a2915fa06227b0 Baptiste Lepers       2021-09-06  383  	if (READ_ONCE(ds->ds_clp))
a2915fa06227b0 Baptiste Lepers       2021-09-06  384  		goto out;
d67ae825a59d63 Tom Haynes            2014-12-11  385  	/* matching smp_wmb() in _nfs4_pnfs_v3/4_ds_connect */
d67ae825a59d63 Tom Haynes            2014-12-11  386  	smp_rmb();
d67ae825a59d63 Tom Haynes            2014-12-11  387  
d67ae825a59d63 Tom Haynes            2014-12-11  388  	/* FIXME: For now we assume the server sent only one version of NFS
d67ae825a59d63 Tom Haynes            2014-12-11  389  	 * to use for the DS.
d67ae825a59d63 Tom Haynes            2014-12-11  390  	 */
2444ff277a686d Trond Myklebust       2019-02-14  391  	status = nfs4_pnfs_ds_connect(s, ds, &mirror->mirror_ds->id_node,
2444ff277a686d Trond Myklebust       2019-02-14  392  			     dataserver_timeo, dataserver_retrans,
d67ae825a59d63 Tom Haynes            2014-12-11  393  			     mirror->mirror_ds->ds_versions[0].version,
7d38de3ffa75f9 Anna Schumaker        2016-11-17  394  			     mirror->mirror_ds->ds_versions[0].minor_version);
d67ae825a59d63 Tom Haynes            2014-12-11  395  
d67ae825a59d63 Tom Haynes            2014-12-11  396  	/* connect success, check rsize/wsize limit */
260f32adb88dad Trond Myklebust       2017-04-20  397  	if (!status) {
d488b9d01fbc2f Trond Myklebust       2024-09-05  398  		/*
d488b9d01fbc2f Trond Myklebust       2024-09-05  399  		 * ds_clp is put in destroy_ds().
d488b9d01fbc2f Trond Myklebust       2024-09-05  400  		 * keep ds_clp even if DS is local, so that if local IO cannot
d488b9d01fbc2f Trond Myklebust       2024-09-05  401  		 * proceed somehow, we can fall back to NFS whenever we want.
d488b9d01fbc2f Trond Myklebust       2024-09-05  402  		 */
1ff4716f420b5a Mike Snitzer          2025-05-13  403  		nfs_local_probe_async(ds->ds_clp);
d67ae825a59d63 Tom Haynes            2014-12-11  404  		max_payload =
d67ae825a59d63 Tom Haynes            2014-12-11  405  			nfs_block_size(rpc_max_payload(ds->ds_clp->cl_rpcclient),
d67ae825a59d63 Tom Haynes            2014-12-11  406  				       NULL);
d67ae825a59d63 Tom Haynes            2014-12-11  407  		if (mirror->mirror_ds->ds_versions[0].rsize > max_payload)
d67ae825a59d63 Tom Haynes            2014-12-11  408  			mirror->mirror_ds->ds_versions[0].rsize = max_payload;
d67ae825a59d63 Tom Haynes            2014-12-11  409  		if (mirror->mirror_ds->ds_versions[0].wsize > max_payload)
d67ae825a59d63 Tom Haynes            2014-12-11  410  			mirror->mirror_ds->ds_versions[0].wsize = max_payload;
3dc147359e3dcd Trond Myklebust       2016-08-29  411  		goto out;
3dc147359e3dcd Trond Myklebust       2016-08-29  412  	}
0a156dd58274b0 Trond Myklebust       2019-02-27  413  noconnect:
d67ae825a59d63 Tom Haynes            2014-12-11  414  	ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
d67ae825a59d63 Tom Haynes            2014-12-11  415  				 mirror, lseg->pls_range.offset,
d67ae825a59d63 Tom Haynes            2014-12-11  416  				 lseg->pls_range.length, NFS4ERR_NXIO,
d67ae825a59d63 Tom Haynes            2014-12-11  417  				 OP_ILLEGAL, GFP_NOIO);
f0922a6c0cdb92 Trond Myklebust       2019-02-10  418  	ff_layout_send_layouterror(lseg);
094069f1d96f69 Jeff Layton           2016-05-17  419  	if (fail_return || !ff_layout_has_available_ds(lseg))
d67ae825a59d63 Tom Haynes            2014-12-11  420  		pnfs_error_mark_layout_for_return(ino, lseg);
6468b866bac7de root max-exfl020      2025-06-26  421  	ds = ERR_PTR(status);
d67ae825a59d63 Tom Haynes            2014-12-11  422  out:
d67ae825a59d63 Tom Haynes            2014-12-11  423  	return ds;
d67ae825a59d63 Tom Haynes            2014-12-11  424  }
d67ae825a59d63 Tom Haynes            2014-12-11  425  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

