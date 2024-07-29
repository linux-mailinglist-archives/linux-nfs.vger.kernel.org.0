Return-Path: <linux-nfs+bounces-5118-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE9F93EA53
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 02:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52DB2281A41
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 00:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3A7817;
	Mon, 29 Jul 2024 00:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FQPagnj+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ECF801
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213393; cv=none; b=IC9RSBQddyN1Y/GKY1j8oi7ti+c3881Zcc5PgoohQusxdMbCK8xP/9Zs9AnHk91Jb6NM9CDO5h3OeOrBkO54A+H1+EZUH7jPeDOczgoGYkfl4E2u5UzUXXNVEaK7g+BOOOl/kilDMFpMmmuk8laGuGWFKTWmjpdijzozqGqlGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213393; c=relaxed/simple;
	bh=pIvuXtPawSZFWqAUaJ6a8bAjFMPhNwwMVlz/qr6+NuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ef98XhB0iD6DdUJOcZk/HJX7Z8hBGyzRE8gRsdjlbfuHdMdmAZlKUaIea7yqM88UXgcWESKLWRUs7RPz4OcHNwrxihxhpJl7Lw6ZYoyuxxq1y+/p9iuBZSMdJ2YvwSsSesL5TftJUNtGZFU9+Q3CXQmVyJApRDolb8Jom9HnwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FQPagnj+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722213390; x=1753749390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pIvuXtPawSZFWqAUaJ6a8bAjFMPhNwwMVlz/qr6+NuU=;
  b=FQPagnj+9+ByePmrIS0WLBkv++gJHYDQCBhuZZ0VKaXCw0xRoVXxFZpX
   tppAl+Bfn/3qhjSJQbGm09yE99WdKICunjVkz7bWn2W1u/C0Ovx/LfTzO
   m2iO1l0xm9jk0oVYURKky3Cpn87xWP9hqjL9BNgWFAXqKm0Gu5MmiompR
   B901MpIgOWCKTYgWW4bz1HCoMAEdPnjiyc9amhi5Ef6k4NZVuB4MCDfCr
   /iRt9i8cUARsy9bQuKcqNEO2YuuSDPvlZeJ3lsWo4QmxZqnJmLuKJ96MV
   HMqCIUIb50AUUZp1oFPGj0MzD9YSXf6bjLYfPe4zgQMADE6RzF1QlbVfY
   A==;
X-CSE-ConnectionGUID: Qq981x1JQouao2++uzrcpw==
X-CSE-MsgGUID: OFAqt3wZSa6OZ5ynE5O34w==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="12757497"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="12757497"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 17:36:30 -0700
X-CSE-ConnectionGUID: jkKWYy0gTwusdCvlav1xTg==
X-CSE-MsgGUID: DzDc7BwjSAiLAFBsQUB20g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58891448"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 28 Jul 2024 17:36:28 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYENF-000rHG-0R;
	Mon, 29 Jul 2024 00:36:25 +0000
Date: Mon, 29 Jul 2024 08:35:56 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <aglo@umich.edu>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nfsd: resolve possible conflicts of reads using
 special stateids and write delegations
Message-ID: <202407290814.7REsmaH7-lkp@intel.com>
References: <20240728204104.519041-4-sagi@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728204104.519041-4-sagi@grimberg.me>

Hi Sagi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc1 next-20240726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Grimberg/nfsd-don-t-assume-copy-notify-when-preprocessing-the-stateid/20240729-044834
base:   linus/master
patch link:    https://lore.kernel.org/r/20240728204104.519041-4-sagi%40grimberg.me
patch subject: [PATCH v2 3/3] nfsd: resolve possible conflicts of reads using special stateids and write delegations
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240729/202407290814.7REsmaH7-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240729/202407290814.7REsmaH7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407290814.7REsmaH7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfsd/nfs4state.c:8826: warning: Excess function parameter 'inode' description in 'nfsd4_deleg_read_conflict'
>> fs/nfsd/nfs4state.c:8826: warning: Excess function parameter 'modified' description in 'nfsd4_deleg_read_conflict'
>> fs/nfsd/nfs4state.c:8826: warning: Excess function parameter 'size' description in 'nfsd4_deleg_read_conflict'


vim +8826 fs/nfsd/nfs4state.c

  8805	
  8806	/**
  8807	 * nfsd4_deleg_read_conflict - Recall if read causes conflict
  8808	 * @rqstp: RPC transaction context
  8809	 * @clp: nfs client
  8810	 * @fhp: nfs file handle
  8811	 * @inode: file to be checked for a conflict
  8812	 * @modified: return true if file was modified
  8813	 * @size: new size of file if modified is true
  8814	 *
  8815	 * This function is called when there is a conflict between a write
  8816	 * delegation and a read that is using a special stateid where the
  8817	 * we cannot derive the client stateid exsistence. The server
  8818	 * must recall a conflicting delegation before allowing the read
  8819	 * to continue.
  8820	 *
  8821	 * Returns 0 if there is no conflict; otherwise an nfs_stat
  8822	 * code is returned.
  8823	 */
  8824	__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
  8825			struct nfs4_client *clp, struct svc_fh *fhp)
> 8826	{
  8827		struct nfs4_file *fp;
  8828		__be32 status = 0;
  8829	
  8830		fp = nfsd4_file_hash_lookup(fhp);
  8831		if (!fp)
  8832			return nfs_ok;
  8833	
  8834		spin_lock(&state_lock);
  8835		spin_lock(&fp->fi_lock);
  8836		if (!list_empty(&fp->fi_delegations) &&
  8837		    !nfs4_delegation_exists(clp, fp)) {
  8838			/* conflict, recall deleg */
  8839			status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
  8840						NFSD_MAY_READ));
  8841			if (status)
  8842				goto out;
  8843			if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
  8844				status = nfserr_jukebox;
  8845		}
  8846	out:
  8847		spin_unlock(&fp->fi_lock);
  8848		spin_unlock(&state_lock);
  8849		return status;
  8850	}
  8851	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

