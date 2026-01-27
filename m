Return-Path: <linux-nfs+bounces-18529-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GeIB6NFeGmqpAEAu9opvQ
	(envelope-from <linux-nfs+bounces-18529-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jan 2026 05:57:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 836528FE8E
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jan 2026 05:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A1BF3029A47
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Jan 2026 04:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0F2DAFB5;
	Tue, 27 Jan 2026 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kqp2vqAC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CBD2E173D
	for <linux-nfs@vger.kernel.org>; Tue, 27 Jan 2026 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769489822; cv=none; b=DEJ5jbfu9vlQrtxnS3/j/j9IjtXP3L4YhtbYpo6wiUrMYWV3nDE/sQ1YGKacms6f49J56JBNn8yvJCIEOKHM2FQ/NswVUVKRi4HELWu/LxlrUVAgyUszdpOunvReTFVSNStYbdJmxPSFx0RgFIm39TROxtCwPVMEgj2E89pYDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769489822; c=relaxed/simple;
	bh=iCCD613JRllm9h3TTRIOf9U7yT/wcqwphBj87uNAy8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOnel28MPp118KzBGAOruV5PyP96pERpQnieiz3R9UwnrV/SQ2UOg6IkM/rR6U7D2f/DU6D/cHpVENQLFub5Mwob2J81mL85jbM9SzUB0cGPeq9++uRvfDWOGgwUHGQ3RefWpuRpON/yt31BxG0YHzkUqPK/aSP1kbUZ23yNAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kqp2vqAC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769489821; x=1801025821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iCCD613JRllm9h3TTRIOf9U7yT/wcqwphBj87uNAy8M=;
  b=Kqp2vqACtapW+BuDiq4TkCwvC0n6p6MF38jOuDIt8F6hytCQXzV5nJAu
   EG2RBBOufC6sixzm1Bcwtzc/O/4Fs0Uv4lKLefjyi/+9CRq/QZGxwF7TC
   SojAYK9bj4dwVtNMRK/xEdaNbS7kdTeslcsKLJdJzPQh98hrq+C++XK/8
   UIIPTI7Rzdkdsu0be0JV4jaiuDW1+lD71n/+GKJ1AZcA87HdwXTPpeN4R
   wfCevYGhKFMIsc5D31e7RJprAfouSojDGYDQvmRt8KenD1Nd/L98w0EwZ
   9uKb4KvA2gqp8O2Ibt7Hl+fWGHBoojp8SXkAF+zikSwLnBGf07VvuU2AR
   w==;
X-CSE-ConnectionGUID: cFm/HXN2QTGovThTDr97kw==
X-CSE-MsgGUID: VAWy5XIST9acujYQDSQySg==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70576408"
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="70576408"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 20:56:56 -0800
X-CSE-ConnectionGUID: RnL5XyQ0TyifckmNW9deyg==
X-CSE-MsgGUID: BjAW/y1nS+OoBpGBNWqn3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,256,1763452800"; 
   d="scan'208";a="207103829"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 26 Jan 2026 20:56:53 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkb8E-00000000Y0S-2WGC;
	Tue, 27 Jan 2026 04:56:50 +0000
Date: Tue, 27 Jan 2026 12:56:47 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3 11/14] lockd: Move xdr.h from include/linux/lockd/ to
 fs/lockd/
Message-ID: <202601271247.TFeb5MO5-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18529-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,01.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 836528FE8E
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
config: s390-defconfig (https://download.01.org/0day-ci/archive/20260127/202601271247.TFeb5MO5-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601271247.TFeb5MO5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601271247.TFeb5MO5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/nfsd/lockd.c:11:
>> include/linux/lockd/bind.h:76:64: warning: declaration of 'struct file_lock' will not be visible outside of this function [-Wvisibility]
      76 | extern int      nlmclnt_proc(struct nlm_host *host, int cmd, struct file_lock *fl, void *data);
         |                                                                     ^
   1 warning generated.


vim +76 include/linux/lockd/bind.h

b1ece737f44f91d Benjamin Coddington  2017-04-11  75  
b1ece737f44f91d Benjamin Coddington  2017-04-11 @76  extern int	nlmclnt_proc(struct nlm_host *host, int cmd, struct file_lock *fl, void *data);
40373b125de6bab Trond Myklebust      2019-04-09  77  extern int	lockd_up(struct net *net, const struct cred *cred);
e3f70eadb7dddfb Stanislav Kinsbursky 2012-03-29  78  extern void	lockd_down(struct net *net);
^1da177e4c3f415 Linus Torvalds       2005-04-16  79  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

