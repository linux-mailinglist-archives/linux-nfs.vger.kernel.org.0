Return-Path: <linux-nfs+bounces-5189-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0A940154
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 00:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49595B2182F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 22:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D4189F37;
	Mon, 29 Jul 2024 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXGjHHgH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8161411FD
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292929; cv=none; b=RM8h6bvkq6dk3KnRaMuz6cwfGnDOshcdo91hs40ZBcktmfZ8RQAzAR4iogngdgIGgWu4jLPltsXak+SEDxy8F0k9M1QNVhDjbEJ7mFbed49Gg8qnCiRO4qYPC1vqTqvHYOU1YS1hrHgoLW66KCjQpDXU9WSRZiH/l8+qnG03+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292929; c=relaxed/simple;
	bh=kGkVjkeR+ub08TcvY2MUEqfwX17GViZtwx6w+BwKrw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDSXb501yNscXXwm/YcS6fSwPLTx8nxy4hsB25HXpkt5avFyaIUlVUYW0cYAUPUgInZiAyAepuPhERG5QBxdtvRbnmUXN+M70SHcY6FYEGVjgz0bLUqhedy+jyi9Z0M4Me9ZGGSxHbvFFO/oGINeqtXAH1qcaRQKSxZcpwG0jpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXGjHHgH; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722292928; x=1753828928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kGkVjkeR+ub08TcvY2MUEqfwX17GViZtwx6w+BwKrw0=;
  b=VXGjHHgHzFS1rUSk50ZlFRqNTiXMY7WuIcV7bI6PgrFN2hb0XxzLBqK5
   rJs+q0PQrXAOIbtGXHGM0T/GLFHV37nP0G7q6GuXxuTyQo0EKW09snG7e
   ozAabq//6sOS6LQBcmq4a5k6MuTarZXbg+nh5yAnH8ZFZ5j1RofXQ9grL
   Lkpfd7kFUR5z4seGiqGyJs5hwpvDOP/sqVKQVCKbo8t/JtFbjqcbTjWI8
   orvTGsVWUOZC9LwmSE6k7rdizXLNqKxpQwjiAtTA9kogC67+L1hYcQOvQ
   wGoYjADRVGwIMOA/iVJN4mRTE0gSU+DhJlmrqF6XGkoGcKBub2bQlT1AI
   Q==;
X-CSE-ConnectionGUID: b6vF7VqyQe6c84ot/HNV/g==
X-CSE-MsgGUID: gwRKurL8QlaQaWsHTMI79Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20236343"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="20236343"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 15:42:07 -0700
X-CSE-ConnectionGUID: XUPIBcEmRU28xwJWunpnGw==
X-CSE-MsgGUID: 6tZQkkE8RteE22HIy7Vjlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="54095586"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 29 Jul 2024 15:42:05 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYZ47-000s9Q-1J;
	Mon, 29 Jul 2024 22:42:03 +0000
Date: Tue, 30 Jul 2024 06:41:10 +0800
From: kernel test robot <lkp@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>
Cc: oe-kbuild-all@lists.linux.dev, Dai Ngo <dai.ngo@oracle.com>,
	Olga Kornievskaia <aglo@umich.edu>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
Message-ID: <202407300630.V7R20Aao-lkp@intel.com>
References: <20240728204104.519041-3-sagi@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728204104.519041-3-sagi@grimberg.me>

Hi Sagi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.11-rc1 next-20240729]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sagi-Grimberg/nfsd-don-t-assume-copy-notify-when-preprocessing-the-stateid/20240729-044834
base:   linus/master
patch link:    https://lore.kernel.org/r/20240728204104.519041-3-sagi%40grimberg.me
patch subject: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
config: sparc64-randconfig-r121-20240729 (https://download.01.org/0day-ci/archive/20240730/202407300630.V7R20Aao-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240730/202407300630.V7R20Aao-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407300630.V7R20Aao-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/nfsd/nfs4state.c:5985:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int status @@     got restricted __be32 @@
   fs/nfsd/nfs4state.c:5985:32: sparse:     expected int status
   fs/nfsd/nfs4state.c:5985:32: sparse:     got restricted __be32
   fs/nfsd/nfs4state.c: note: in included file (through include/linux/wait.h, include/linux/wait_bit.h, include/linux/fs.h):
   include/linux/list.h:218:19: sparse: sparse: context imbalance in 'put_clnt_odstate' - unexpected unlock
   fs/nfsd/nfs4state.c:1197:9: sparse: sparse: context imbalance in 'nfs4_put_stid' - unexpected unlock

vim +5985 fs/nfsd/nfs4state.c

  5895	
  5896	/*
  5897	 * The Linux NFS server does not offer write delegations to NFSv4.0
  5898	 * clients in order to avoid conflicts between write delegations and
  5899	 * GETATTRs requesting CHANGE or SIZE attributes.
  5900	 *
  5901	 * With NFSv4.1 and later minorversions, the SEQUENCE operation that
  5902	 * begins each COMPOUND contains a client ID. Delegation recall can
  5903	 * be avoided when the server recognizes the client sending a
  5904	 * GETATTR also holds write delegation it conflicts with.
  5905	 *
  5906	 * However, the NFSv4.0 protocol does not enable a server to
  5907	 * determine that a GETATTR originated from the client holding the
  5908	 * conflicting delegation versus coming from some other client. Per
  5909	 * RFC 7530 Section 16.7.5, the server must recall or send a
  5910	 * CB_GETATTR even when the GETATTR originates from the client that
  5911	 * holds the conflicting delegation.
  5912	 *
  5913	 * An NFSv4.0 client can trigger a pathological situation if it
  5914	 * always sends a DELEGRETURN preceded by a conflicting GETATTR in
  5915	 * the same COMPOUND. COMPOUND execution will always stop at the
  5916	 * GETATTR and the DELEGRETURN will never get executed. The server
  5917	 * eventually revokes the delegation, which can result in loss of
  5918	 * open or lock state.
  5919	 */
  5920	static void
  5921	nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
  5922			struct nfs4_ol_stateid *stp, struct svc_fh *currentfh)
  5923	{
  5924		struct nfs4_delegation *dp;
  5925		struct nfs4_openowner *oo = openowner(stp->st_stateowner);
  5926		struct nfs4_client *clp = stp->st_stid.sc_client;
  5927		struct svc_fh *parent = NULL;
  5928		int cb_up;
  5929		int status = 0;
  5930		struct kstat stat;
  5931		struct path path;
  5932	
  5933		cb_up = nfsd4_cb_channel_good(oo->oo_owner.so_client);
  5934		open->op_recall = false;
  5935		switch (open->op_claim_type) {
  5936			case NFS4_OPEN_CLAIM_PREVIOUS:
  5937				if (!cb_up)
  5938					open->op_recall = true;
  5939				break;
  5940			case NFS4_OPEN_CLAIM_NULL:
  5941				parent = currentfh;
  5942				fallthrough;
  5943			case NFS4_OPEN_CLAIM_FH:
  5944				/*
  5945				 * Let's not give out any delegations till everyone's
  5946				 * had the chance to reclaim theirs, *and* until
  5947				 * NLM locks have all been reclaimed:
  5948				 */
  5949				if (locks_in_grace(clp->net))
  5950					goto out_no_deleg;
  5951				if (!cb_up || !(oo->oo_flags & NFS4_OO_CONFIRMED))
  5952					goto out_no_deleg;
  5953				if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE &&
  5954						!clp->cl_minorversion)
  5955					goto out_no_deleg;
  5956				break;
  5957			default:
  5958				goto out_no_deleg;
  5959		}
  5960		dp = nfs4_set_delegation(open, stp, parent);
  5961		if (IS_ERR(dp))
  5962			goto out_no_deleg;
  5963	
  5964		memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
  5965	
  5966		if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
  5967			open->op_delegate_type = NFS4_OPEN_DELEGATE_WRITE;
  5968			trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
  5969			path.mnt = currentfh->fh_export->ex_path.mnt;
  5970			path.dentry = currentfh->fh_dentry;
  5971			if (vfs_getattr(&path, &stat,
  5972					(STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
  5973					AT_STATX_SYNC_AS_STAT)) {
  5974				nfs4_put_stid(&dp->dl_stid);
  5975				destroy_delegation(dp);
  5976				goto out_no_deleg;
  5977			}
  5978			dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
  5979			dp->dl_cb_fattr.ncf_initial_cinfo =
  5980				nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
  5981			if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) != NFS4_SHARE_ACCESS_BOTH) {
  5982				struct nfsd_file *nf = NULL;
  5983	
  5984				/* make sure the file is opened locally for O_RDWR */
> 5985				status = nfsd_file_acquire_opened(rqstp, currentfh,
  5986					nfs4_access_to_access(NFS4_SHARE_ACCESS_BOTH),
  5987					open->op_filp, &nf);
  5988				if (status) {
  5989					nfs4_put_stid(&dp->dl_stid);
  5990					destroy_delegation(dp);
  5991					goto out_no_deleg;
  5992				}
  5993				stp->st_stid.sc_file->fi_fds[O_RDWR] = nf;
  5994			}
  5995		} else {
  5996			open->op_delegate_type = NFS4_OPEN_DELEGATE_READ;
  5997			trace_nfsd_deleg_read(&dp->dl_stid.sc_stateid);
  5998		}
  5999		nfs4_put_stid(&dp->dl_stid);
  6000		return;
  6001	out_no_deleg:
  6002		open->op_delegate_type = NFS4_OPEN_DELEGATE_NONE;
  6003		if (open->op_claim_type == NFS4_OPEN_CLAIM_PREVIOUS &&
  6004		    open->op_delegate_type != NFS4_OPEN_DELEGATE_NONE) {
  6005			dprintk("NFSD: WARNING: refusing delegation reclaim\n");
  6006			open->op_recall = true;
  6007		}
  6008	
  6009		/* 4.1 client asking for a delegation? */
  6010		if (open->op_deleg_want)
  6011			nfsd4_open_deleg_none_ext(open, status);
  6012		return;
  6013	}
  6014	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

