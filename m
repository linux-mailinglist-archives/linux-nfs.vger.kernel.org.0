Return-Path: <linux-nfs+bounces-18420-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GxoC6cedGk32QAAu9opvQ
	(envelope-from <linux-nfs+bounces-18420-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 02:21:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 235A27BEB8
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 02:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 766D63011743
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 01:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3A71DF75D;
	Sat, 24 Jan 2026 01:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ehYBC/Nk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D751D7E41
	for <linux-nfs@vger.kernel.org>; Sat, 24 Jan 2026 01:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769217698; cv=none; b=Pjm459qtZAXrITIDrCLZhwO+GoZplI6KAz6CiQyN1xSN36nHa0jcRrJ7bTnoH/umYqOq/pWNIuo2r7rIF5TiUTy/bXjo7HCiTbnA2fvUVIflRenANe3RDKu9tmLWEbsCM40Zz8hnXEnNJ4ThhRdv2YJn7plfwCb3x6GVJn7vNOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769217698; c=relaxed/simple;
	bh=9hCnPB1byaSJVZuVJrwFJb3t89Ll+joRWxi/NP/F/Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUOHewbpDd/i4xs8X3T5WzIqChD0KxMIGfDs2vsqRzLtkrTE+ym4TwGFvhgs8A4oOENZL1+k01kuje81GXIIHz+w0mysdQulhebQuZrOPD6zHjWs7Fx8KZ8f3NaLmIGm055Z+yea6XThCEHhH7CCFj3xf/6+3Sr096MFdQ+Lndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ehYBC/Nk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769217697; x=1800753697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9hCnPB1byaSJVZuVJrwFJb3t89Ll+joRWxi/NP/F/Nc=;
  b=ehYBC/Nk3puHtCuh0W1nthAToN7o62Z+evNLz84zldFC01jGXuAzP8tE
   JlsU3+j0E4sMLmKWUntkfEYQk61fazABckewpuV8jdTvDvnzGNXx2ZG2M
   8l1TECMJqtaMsMjkqyd+zUXTcJZ7jWRnrtJG6rDJNWvKG7QPFnIymHM2r
   FA2U6erz+Nr5vw4E9MMwEhoiioP14WMaF41RU2UlvKd1K+4fhD10eNmq8
   het/T7ORgdNDKRe2hCvUMGY43Jue1JmUPA/6Zo2XyvwVQdIUOVg2HK2B0
   6m9cPeKgwFbWjondXTS4nLdLjWpQLbBI+7GRyIsVqB7T8w+ZsJtkjPqpm
   w==;
X-CSE-ConnectionGUID: Asaa432ySmWp+4iNoKjt1Q==
X-CSE-MsgGUID: 23KUu2sHTai/rGHWjN9NUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70194164"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="70194164"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 17:21:37 -0800
X-CSE-ConnectionGUID: 1sWLGvYLR7+EotbRxVlMjw==
X-CSE-MsgGUID: QnKOVIQPSmeKSxpALwJB8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="244781261"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Jan 2026 17:21:35 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjSLE-00000000UeA-0v3S;
	Sat, 24 Jan 2026 01:21:32 +0000
Date: Sat, 24 Jan 2026 09:20:53 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 10/42] lockd: Move xdr.h from include/linux/lockd/ to
 fs/lockd/
Message-ID: <202601240901.DyDjt2Ka-lkp@intel.com>
References: <20260123185259.1215767-11-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123185259.1215767-11-cel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18420-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url]
X-Rspamd-Queue-Id: 235A27BEB8
X-Rspamd-Action: no action

Hi Chuck,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on brauner-vfs/vfs.all linus/master v6.19-rc6 next-20260122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/lockd-Simplify-cast_status-in-svcproc-c/20260124-025646
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260123185259.1215767-11-cel%40kernel.org
patch subject: [PATCH v2 10/42] lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20260124/202601240901.DyDjt2Ka-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601240901.DyDjt2Ka-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601240901.DyDjt2Ka-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfs/nfs3proc.c: In function 'nfs3_proc_lock':
>> fs/nfs/nfs3proc.c:1009:15: error: invalid use of undefined type 'struct file_lock'
    1009 |         if (fl->c.flc_flags & FL_CLOSE) {
         |               ^~
>> fs/nfs/nfs3proc.c:1009:31: error: 'FL_CLOSE' undeclared (first use in this function); did you mean 'OP_CLOSE'?
    1009 |         if (fl->c.flc_flags & FL_CLOSE) {
         |                               ^~~~~~~~
         |                               OP_CLOSE
   fs/nfs/nfs3proc.c:1009:31: note: each undeclared identifier is reported only once for each function it appears in


vim +1009 fs/nfs/nfs3proc.c

f30cb757f680f9 Benjamin Coddington 2017-04-11  1000  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1001  static int
^1da177e4c3f41 Linus Torvalds      2005-04-16  1002  nfs3_proc_lock(struct file *filp, int cmd, struct file_lock *fl)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1003  {
496ad9aa8ef448 Al Viro             2013-01-23  1004  	struct inode *inode = file_inode(filp);
f30cb757f680f9 Benjamin Coddington 2017-04-11  1005  	struct nfs_lock_context *l_ctx = NULL;
f30cb757f680f9 Benjamin Coddington 2017-04-11  1006  	struct nfs_open_context *ctx = nfs_file_open_context(filp);
f30cb757f680f9 Benjamin Coddington 2017-04-11  1007  	int status;
1093a60ef34bb1 Chuck Lever         2008-01-11  1008  
dd1fac6ae648ca Jeff Layton         2024-01-31 @1009  	if (fl->c.flc_flags & FL_CLOSE) {
f30cb757f680f9 Benjamin Coddington 2017-04-11  1010  		l_ctx = nfs_get_lock_context(ctx);
f30cb757f680f9 Benjamin Coddington 2017-04-11  1011  		if (IS_ERR(l_ctx))
f30cb757f680f9 Benjamin Coddington 2017-04-11  1012  			l_ctx = NULL;
f30cb757f680f9 Benjamin Coddington 2017-04-11  1013  		else
f30cb757f680f9 Benjamin Coddington 2017-04-11  1014  			set_bit(NFS_CONTEXT_UNLOCK, &ctx->flags);
f30cb757f680f9 Benjamin Coddington 2017-04-11  1015  	}
f30cb757f680f9 Benjamin Coddington 2017-04-11  1016  
f30cb757f680f9 Benjamin Coddington 2017-04-11  1017  	status = nlmclnt_proc(NFS_SERVER(inode)->nlm_host, cmd, fl, l_ctx);
f30cb757f680f9 Benjamin Coddington 2017-04-11  1018  
f30cb757f680f9 Benjamin Coddington 2017-04-11  1019  	if (l_ctx)
f30cb757f680f9 Benjamin Coddington 2017-04-11  1020  		nfs_put_lock_context(l_ctx);
f30cb757f680f9 Benjamin Coddington 2017-04-11  1021  
f30cb757f680f9 Benjamin Coddington 2017-04-11  1022  	return status;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1023  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  1024  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

