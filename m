Return-Path: <linux-nfs+bounces-18528-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMmUHCUteGl7oQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18528-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jan 2026 04:12:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C908F732
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jan 2026 04:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C83F9302F6A0
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jan 2026 03:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201722FD7A3;
	Tue, 27 Jan 2026 03:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOrXNH/6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38FE2FD695
	for <linux-nfs@vger.kernel.org>; Tue, 27 Jan 2026 03:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483553; cv=none; b=D+0cbeJ5bpnAx1Lvw22wvpJeJbcRM4TQv0vVvqe0v6UbBZKEX+4aQzCVX9vycNzhH8gsx/K2Ye+yCSocePB3bxXeIHm0+585bleg8wdLuTeMmMMqOmTUlU35aSIQUo2Dhes90yGs3fTMJhNGQFyK/5p0N6UbB0C1nDA+WA4j+iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483553; c=relaxed/simple;
	bh=eSfIFIhvMIN6nECtvPL9lx0zvxh3QMv0YBSy9iZEECQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZRVNq64uBTgI4oI4wVi/15mrI7XCnyUmd9szsarYwzdsGTWr5M7uls79zBxAa1Q0DPewyFRxCyCPSKrB1vPXOQX2wDIuHSn8VrNQnjxBSk2Zth/PmgL6w/R70iem0ORzjrxdfMVFaWJjyMescMfvBJodiPya0lmg01E8kB+8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOrXNH/6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769483552; x=1801019552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eSfIFIhvMIN6nECtvPL9lx0zvxh3QMv0YBSy9iZEECQ=;
  b=jOrXNH/6eAUAnHN999zFezk6IxIjnYLbHGwWPvB+BAvVMMiYxHx6vSBD
   tS3C3R+fRSGu/WzqdZmCQmofL7IVRs9ssmWqPv1iMy+psP9uL33MUVjrh
   nsI0htkcEnnV6j7Ami9TWl02cVHMJkIDDEpPeb4oHEiVR1LaLaUvHjzFL
   vObdDqembx02hpYJgQajjsx/9vaugAE3sgemaI+263MF1PyLokRcQiB0Y
   FCg7knB4V4s+1dfKkeXC8/S64wCYoXgFVKmDfa8iUG9F0oOuKx8o07zE3
   j6t9CSypbA3OYOft0i/J8sdVvzpiekXSiHy8vD3LcbFjCHuukZ6GyLux/
   Q==;
X-CSE-ConnectionGUID: lc4M4IbxTzCkQIflTbEO2g==
X-CSE-MsgGUID: IxiPFTULShuMHpww24PD9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81388202"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="81388202"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 19:12:30 -0800
X-CSE-ConnectionGUID: 02k+wq7+Q4CYsAmgZjYogw==
X-CSE-MsgGUID: gFPVzxxER0WvXkR6bC4vrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207910341"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Jan 2026 19:12:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkZVA-00000000XwG-3iCl;
	Tue, 27 Jan 2026 03:12:24 +0000
Date: Tue, 27 Jan 2026 11:12:04 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 11/14] lockd: Move xdr.h from include/linux/lockd/ to
 fs/lockd/
Message-ID: <202601271122.bOzo5v5D-lkp@intel.com>
References: <20260126195535.154697-12-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126195535.154697-12-cel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18528-lists,linux-nfs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: E2C908F732
X-Rspamd-Action: no action

Hi Chuck,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on brauner-vfs/vfs.all linus/master v6.19-rc7 next-20260126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/lockd-Simplify-cast_status-in-svcproc-c/20260127-035838
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260126195535.154697-12-cel%40kernel.org
patch subject: [PATCH v3 11/14] lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
config: parisc-defconfig (https://download.01.org/0day-ci/archive/20260127/202601271122.bOzo5v5D-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601271122.bOzo5v5D-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601271122.bOzo5v5D-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/nfsd/lockd.c:11:
>> include/linux/lockd/bind.h:76:69: warning: 'struct file_lock' declared inside parameter list will not be visible outside of this definition or declaration
      76 | extern int      nlmclnt_proc(struct nlm_host *host, int cmd, struct file_lock *fl, void *data);
         |                                                                     ^~~~~~~~~


vim +76 include/linux/lockd/bind.h

b1ece737f44f91 Benjamin Coddington  2017-04-11  75  
b1ece737f44f91 Benjamin Coddington  2017-04-11 @76  extern int	nlmclnt_proc(struct nlm_host *host, int cmd, struct file_lock *fl, void *data);
40373b125de6ba Trond Myklebust      2019-04-09  77  extern int	lockd_up(struct net *net, const struct cred *cred);
e3f70eadb7dddf Stanislav Kinsbursky 2012-03-29  78  extern void	lockd_down(struct net *net);
^1da177e4c3f41 Linus Torvalds       2005-04-16  79  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

