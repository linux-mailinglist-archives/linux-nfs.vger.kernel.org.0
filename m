Return-Path: <linux-nfs+bounces-18423-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONmOLW41dGlx3QAAu9opvQ
	(envelope-from <linux-nfs+bounces-18423-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 03:58:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 197BD7C434
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 03:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB898301104F
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 02:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39F243367;
	Sat, 24 Jan 2026 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uz8ZgoWA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D07B233128
	for <linux-nfs@vger.kernel.org>; Sat, 24 Jan 2026 02:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769223529; cv=none; b=GEJ6QD0/6eykXVTgZPrsZLuwDVaUxXY7ywaIKi6DH/llyrjUtMBHTMKtDa73WiZOOTe+OEAFsgzep5nTXOqtT09s/2RUxvunRlkmQ9NcYR6VPJxDTu9gBvJZhfGRIhCs/bDfOLuQ/nJA7cHqE0dgB2hRnM6DeOzMEFTnZN+qL4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769223529; c=relaxed/simple;
	bh=RXqeDU6gC2mvNgdtpzSZvyeer07O7qrlSDjR3Gux3GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dygsdwXbqwB8vZxK1aP8nOkn9MfVWEKNEZuQGsY/H8nhy1rn6jR0hhpu4vebJrJK459gggfGPHWLouRwpIYsmYhxxtxYHncUZ2JXFZwdMq+1RL1yXOICMOYtXr6n0hGACeXRXomSk2DDxvI1YXLUUvp0rTI9b3kSTgXVM9APeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uz8ZgoWA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769223523; x=1800759523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RXqeDU6gC2mvNgdtpzSZvyeer07O7qrlSDjR3Gux3GI=;
  b=Uz8ZgoWA5ltORBqczc3F0Bpn7ve0mnQ4I6ii3xHe0bjW+juApI0jF5K4
   DEifGi6Y1FUs2lIim2daUNvTFAbXB6HFmantT1XEPJfcduIMWBjkvsCV1
   8ePGNDO82i9AUnI/OhQJl9NsA0509L/lp+XJrtwILvm1L/KqOX6TwxWX0
   W5OV5b5CkyltxuHJsDXTnHaf68b6vDJco0jrhHTAEumO9HD8M1G3nRyEI
   2ePdcvKqa3F/bL4GNeqVwge19vF70te2DyytZodyU0/qagyoYJXY9hbz7
   rYRVIs7s0EhdApcM0KO28sNbcirbgls6KSUcgKu1b0YMqZNGztp/5XENx
   g==;
X-CSE-ConnectionGUID: pD1y21KRTti/G6PG2al+Xw==
X-CSE-MsgGUID: 5e9P6IWFQBGvEwcnEmmsCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="69671622"
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="69671622"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 18:58:42 -0800
X-CSE-ConnectionGUID: Kh5BP03HSzigihKInjRbQQ==
X-CSE-MsgGUID: ycFyA9aBQyqmTym301dDDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,249,1763452800"; 
   d="scan'208";a="207088789"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 23 Jan 2026 18:58:40 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjTrB-00000000Uk4-2f6B;
	Sat, 24 Jan 2026 02:58:37 +0000
Date: Sat, 24 Jan 2026 10:57:52 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 10/42] lockd: Move xdr.h from include/linux/lockd/ to
 fs/lockd/
Message-ID: <202601241020.YgD8ze9Q-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18423-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 197BD7C434
X-Rspamd-Action: no action

Hi Chuck,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on brauner-vfs/vfs.all linus/master v6.19-rc6 next-20260123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/lockd-Simplify-cast_status-in-svcproc-c/20260124-025646
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260123185259.1215767-11-cel%40kernel.org
patch subject: [PATCH v2 10/42] lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
config: hexagon-defconfig (https://download.01.org/0day-ci/archive/20260124/202601241020.YgD8ze9Q-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601241020.YgD8ze9Q-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601241020.YgD8ze9Q-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfs/nfs3proc.c:1009:8: error: incomplete definition of type 'struct file_lock'
    1009 |         if (fl->c.flc_flags & FL_CLOSE) {
         |             ~~^
   include/linux/fs.h:1332:8: note: forward declaration of 'struct file_lock'
    1332 | struct file_lock;
         |        ^
>> fs/nfs/nfs3proc.c:1009:24: error: use of undeclared identifier 'FL_CLOSE'; did you mean 'OP_CLOSE'?
    1009 |         if (fl->c.flc_flags & FL_CLOSE) {
         |                               ^~~~~~~~
         |                               OP_CLOSE
   include/linux/nfs4.h:83:2: note: 'OP_CLOSE' declared here
      83 |         OP_CLOSE = 4,
         |         ^
   2 errors generated.


vim +1009 fs/nfs/nfs3proc.c

f30cb757f680f96 Benjamin Coddington 2017-04-11  1000  
^1da177e4c3f415 Linus Torvalds      2005-04-16  1001  static int
^1da177e4c3f415 Linus Torvalds      2005-04-16  1002  nfs3_proc_lock(struct file *filp, int cmd, struct file_lock *fl)
^1da177e4c3f415 Linus Torvalds      2005-04-16  1003  {
496ad9aa8ef4480 Al Viro             2013-01-23  1004  	struct inode *inode = file_inode(filp);
f30cb757f680f96 Benjamin Coddington 2017-04-11  1005  	struct nfs_lock_context *l_ctx = NULL;
f30cb757f680f96 Benjamin Coddington 2017-04-11  1006  	struct nfs_open_context *ctx = nfs_file_open_context(filp);
f30cb757f680f96 Benjamin Coddington 2017-04-11  1007  	int status;
1093a60ef34bb12 Chuck Lever         2008-01-11  1008  
dd1fac6ae648cac Jeff Layton         2024-01-31 @1009  	if (fl->c.flc_flags & FL_CLOSE) {
f30cb757f680f96 Benjamin Coddington 2017-04-11  1010  		l_ctx = nfs_get_lock_context(ctx);
f30cb757f680f96 Benjamin Coddington 2017-04-11  1011  		if (IS_ERR(l_ctx))
f30cb757f680f96 Benjamin Coddington 2017-04-11  1012  			l_ctx = NULL;
f30cb757f680f96 Benjamin Coddington 2017-04-11  1013  		else
f30cb757f680f96 Benjamin Coddington 2017-04-11  1014  			set_bit(NFS_CONTEXT_UNLOCK, &ctx->flags);
f30cb757f680f96 Benjamin Coddington 2017-04-11  1015  	}
f30cb757f680f96 Benjamin Coddington 2017-04-11  1016  
f30cb757f680f96 Benjamin Coddington 2017-04-11  1017  	status = nlmclnt_proc(NFS_SERVER(inode)->nlm_host, cmd, fl, l_ctx);
f30cb757f680f96 Benjamin Coddington 2017-04-11  1018  
f30cb757f680f96 Benjamin Coddington 2017-04-11  1019  	if (l_ctx)
f30cb757f680f96 Benjamin Coddington 2017-04-11  1020  		nfs_put_lock_context(l_ctx);
f30cb757f680f96 Benjamin Coddington 2017-04-11  1021  
f30cb757f680f96 Benjamin Coddington 2017-04-11  1022  	return status;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1023  }
^1da177e4c3f415 Linus Torvalds      2005-04-16  1024  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

