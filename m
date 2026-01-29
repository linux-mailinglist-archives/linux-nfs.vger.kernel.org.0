Return-Path: <linux-nfs+bounces-18591-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPN4MEEHe2maAgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18591-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:07:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F7CAC6C7
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 08:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C7192300615E
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jan 2026 07:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB76C3783B8;
	Thu, 29 Jan 2026 07:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ee2I1eWv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E737997D
	for <linux-nfs@vger.kernel.org>; Thu, 29 Jan 2026 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670463; cv=none; b=cArMnGWBn98/22O0OZBBR0Ovqpm+xPsu/JjdRmZUOOQr/ABAAybStY5NBJfV8A6kg7uRddyNLCWE+RVRSJIeOt2dEXgVkhUXB8/Qd0afb0b2JBe8Ru54l+SG+w0nXY272XWiol9LZeOevl6qutYNCGFMgLbctIAZ2UNvPoy0cNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670463; c=relaxed/simple;
	bh=q/B7Xv4Frj1COfnRtZPlFut9RqtlSyViLkzTSyN72U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKHBk6p6XcjWaMwp/6d+vVBZnrs/uUC7i5BtskQfMbGcN73HwK52gkcYAvZ2LCfQhNQMBBIx10uC2wbLRozVk4mr1+iTCJiM96PbkPU96u8txF0mWBZ5r7hbmCIvK92YUXWIzPWuBwkGSVYR03n+OdOtS+39bA7qUvANOM24zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ee2I1eWv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769670462; x=1801206462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q/B7Xv4Frj1COfnRtZPlFut9RqtlSyViLkzTSyN72U4=;
  b=ee2I1eWvxKMz7kcNjgc4VP6G/xJ0Ex98fvrJhGG8aBRVc3v8q/aFx656
   SNoDnayzYhH1kFBeFOA0ap+yX05hFv/loXV0wpuGR4vRZ1zyZg14zSbQZ
   nQ9RqkN3dVLoC7Lt+7eNCXvQAQbE6cb72dCVO/XG6gLaojn7WjVIfC+5S
   +6OODo/NW/s59PBSq/8y9NymqFjBlkkWxenIatmaThMBeEvUaqa6Pv5mp
   zkWJ/ZqoUrMjE0zp28HdR5wj4Y/bLuX6rTMj0EZUzw5gJ6sakgubo10Lk
   HUa7KF3SGvB420xoDNhl2MURGXDPsJrDvEaWnYlv2/WU9eEsBOoFsU0Ou
   w==;
X-CSE-ConnectionGUID: UOqZjnQUQPyCO15XjWcBXQ==
X-CSE-MsgGUID: UlvLj1mgTqGbCYqad/3rvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="81535947"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="81535947"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 23:07:42 -0800
X-CSE-ConnectionGUID: a+FeyiCHROSCuRKO3w/sXg==
X-CSE-MsgGUID: pd3W7R02TACkeIi4MaLWRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="208390423"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 28 Jan 2026 23:07:39 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlM7t-00000000bC4-1V8m;
	Thu, 29 Jan 2026 07:07:37 +0000
Date: Thu, 29 Jan 2026 15:06:38 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 11/14] lockd: Move xdr.h from include/linux/lockd/ to
 fs/lockd/
Message-ID: <202601291442.Ys0V3xFD-lkp@intel.com>
References: <20260128151935.1646063-12-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128151935.1646063-12-cel@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18591-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 64F7CAC6C7
X-Rspamd-Action: no action

Hi Chuck,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on brauner-vfs/vfs.all linus/master v6.19-rc7 next-20260128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/lockd-Simplify-cast_status-in-svcproc-c/20260128-232322
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260128151935.1646063-12-cel%40kernel.org
patch subject: [PATCH v4 11/14] lockd: Move xdr.h from include/linux/lockd/ to fs/lockd/
config: arm-randconfig-r112-20260129 (https://download.01.org/0day-ci/archive/20260129/202601291442.Ys0V3xFD-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601291442.Ys0V3xFD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601291442.Ys0V3xFD-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfs/proc.c: In function 'nfs_lock_check_bounds':
>> fs/nfs/proc.c:677:26: error: invalid use of undefined type 'const struct file_lock'
     677 |         start = (__s32)fl->fl_start;
         |                          ^~
   fs/nfs/proc.c:678:32: error: invalid use of undefined type 'const struct file_lock'
     678 |         if ((loff_t)start != fl->fl_start)
         |                                ^~
   fs/nfs/proc.c:681:15: error: invalid use of undefined type 'const struct file_lock'
     681 |         if (fl->fl_end != OFFSET_MAX) {
         |               ^~
   fs/nfs/proc.c:682:32: error: invalid use of undefined type 'const struct file_lock'
     682 |                 end = (__s32)fl->fl_end;
         |                                ^~
   fs/nfs/proc.c:683:38: error: invalid use of undefined type 'const struct file_lock'
     683 |                 if ((loff_t)end != fl->fl_end)
         |                                      ^~


vim +677 fs/nfs/proc.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  670  
2116271a347d11 Trond Myklebust 2008-05-20  671  /* Helper functions for NFS lock bounds checking */
2116271a347d11 Trond Myklebust 2008-05-20  672  #define NFS_LOCK32_OFFSET_MAX ((__s32)0x7fffffffUL)
2116271a347d11 Trond Myklebust 2008-05-20  673  static int nfs_lock_check_bounds(const struct file_lock *fl)
2116271a347d11 Trond Myklebust 2008-05-20  674  {
2116271a347d11 Trond Myklebust 2008-05-20  675  	__s32 start, end;
2116271a347d11 Trond Myklebust 2008-05-20  676  
2116271a347d11 Trond Myklebust 2008-05-20 @677  	start = (__s32)fl->fl_start;
2116271a347d11 Trond Myklebust 2008-05-20  678  	if ((loff_t)start != fl->fl_start)
2116271a347d11 Trond Myklebust 2008-05-20  679  		goto out_einval;
2116271a347d11 Trond Myklebust 2008-05-20  680  
2116271a347d11 Trond Myklebust 2008-05-20  681  	if (fl->fl_end != OFFSET_MAX) {
2116271a347d11 Trond Myklebust 2008-05-20  682  		end = (__s32)fl->fl_end;
2116271a347d11 Trond Myklebust 2008-05-20  683  		if ((loff_t)end != fl->fl_end)
2116271a347d11 Trond Myklebust 2008-05-20  684  			goto out_einval;
2116271a347d11 Trond Myklebust 2008-05-20  685  	} else
2116271a347d11 Trond Myklebust 2008-05-20  686  		end = NFS_LOCK32_OFFSET_MAX;
2116271a347d11 Trond Myklebust 2008-05-20  687  
2116271a347d11 Trond Myklebust 2008-05-20  688  	if (start < 0 || start > end)
2116271a347d11 Trond Myklebust 2008-05-20  689  		goto out_einval;
2116271a347d11 Trond Myklebust 2008-05-20  690  	return 0;
2116271a347d11 Trond Myklebust 2008-05-20  691  out_einval:
2116271a347d11 Trond Myklebust 2008-05-20  692  	return -EINVAL;
2116271a347d11 Trond Myklebust 2008-05-20  693  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  694  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

