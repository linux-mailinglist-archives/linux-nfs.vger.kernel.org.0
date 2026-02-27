Return-Path: <linux-nfs+bounces-19416-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGNcJvGqoWm1vQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19416-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:32:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F41441B9011
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1DC8303CE27
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC94244692;
	Fri, 27 Feb 2026 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5GlOZM0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20F20B212
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202092; cv=none; b=KIDwF+CtbKYdK8bAazCLRRMUwpUGS26lCKBJvXQ1uRm8u0MA1lu+F0lO11H0UIf4YrInPhPkAVdYZ0+QdKViy1IxgCm7cAvA4GZJRb5cFDLFu2LX/lusLb2a/AhT79VY8cncxrw8IEx/qQnH51AasSdiNbRHz9Ev1YO0fqPNhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202092; c=relaxed/simple;
	bh=ZOmTIo50fH6c4ujpWPybnS/mBqgKW8YwmdlzpgQ06gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/VIAz45PPHlcU000oEZs0rKfzexg48Bvo+D2F/JPA2Cb2SyeyYa8mxF/ErXHnaDR24H8xU0dxjcAXrN4f+KI5yyLiNDDuga/TuuDbhJP74iFqj9qUvb+JZ2UKzQ1VLCOASuauPFMGgwaedmAkjjwyH9XG9hy5wXBjMwaThLpU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5GlOZM0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772202090; x=1803738090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZOmTIo50fH6c4ujpWPybnS/mBqgKW8YwmdlzpgQ06gI=;
  b=g5GlOZM0OC9JUv3guVPtFRKdHg20XP1En7y4r1sYOrs3Y+A7iznO347N
   2recQ0e+6xO08Hhc7YGNi5lZNSpFsSIPJUk/uPljRhmhC7iQiSqu2JDyA
   mFVk4R91kTj6FFed8wmKXjs8QoQuW1pipcesSLfWeThw3bWW8o9cCw94Y
   xAtZIEuxob4R2LDaMzJ+Tr8DlLF4ai1QfrkfXf0yZRIP7w+4bt3lP1Lqp
   pgqcyCLUEYhmfPjQ0hUmIYaN+EGi1QbruHxbPl27UhyXAwcM+V2svAkSO
   A8Tp+/imf7O7ZzYLKMgh9zUcFRXvkuEttneUj+fhAkWQw2Owy4pxd7LGD
   g==;
X-CSE-ConnectionGUID: tAy2ddavSae70mJ0sm/R/Q==
X-CSE-MsgGUID: DgHKTZipQM+vti0JjuDz6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="83614930"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="83614930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 06:21:29 -0800
X-CSE-ConnectionGUID: xg/LfvwLTdCzmHoL4C4PPQ==
X-CSE-MsgGUID: o+6egniDQsiRNZi4nk7xjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="215546798"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 27 Feb 2026 06:21:26 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvyhl-00000000Aep-419p;
	Fri, 27 Feb 2026 14:21:20 +0000
Date: Fri, 27 Feb 2026 22:20:04 +0800
From: kernel test robot <lkp@intel.com>
To: Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	tom@talpey.com, hch@lst.de
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 1/1] NFSD: move accumulated callback ops to per-net
 namespace
Message-ID: <202602272240.e34pGKuR-lkp@intel.com>
References: <20260225172624.707224-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225172624.707224-1-dai.ngo@oracle.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-19416-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: F41441B9011
X-Rspamd-Action: no action

Hi Dai,

kernel test robot noticed the following build errors:

[auto build test ERROR on brauner-vfs/vfs.all]
[also build test ERROR on linus/master v7.0-rc1 next-20260226]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dai-Ngo/NFSD-move-accumulated-callback-ops-to-per-net-namespace/20260226-012940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20260225172624.707224-1-dai.ngo%40oracle.com
patch subject: [PATCH v3 1/1] NFSD: move accumulated callback ops to per-net namespace
config: parisc-randconfig-002-20260227 (https://download.01.org/0day-ci/archive/20260227/202602272240.e34pGKuR-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602272240.e34pGKuR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602272240.e34pGKuR-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "nfsd_net_cb_stats_shutdown" [fs/nfsd/nfsd.ko] undefined!
>> ERROR: modpost: "nfsd_net_cb_stats_init" [fs/nfsd/nfsd.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

