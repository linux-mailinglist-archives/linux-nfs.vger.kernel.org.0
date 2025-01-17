Return-Path: <linux-nfs+bounces-9331-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F598A148B5
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 05:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF95161FA8
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 04:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D231F63DE;
	Fri, 17 Jan 2025 04:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuJgRXCC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB51F63C5
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 04:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737086926; cv=none; b=gzqtOWJLWz7nyPBX67eUCbcmmHEio2qdmAvv2Z/jN6KjkoMtOeGnh9B6948pDgD2CCZP3tBE1N/A1QdKyl9ntWDIMUhngztH1bFyaVNHL1li0mjuZJWi+3sZPBq2HHNfArqUPJ2Pd+eQNCkmSR92zNAgS3k4MP0a0h5vjXtfdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737086926; c=relaxed/simple;
	bh=XN2HDfZSi4E3Bt+VVA24AJFY8CsxsUSIXmQ6j6uCaFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNyW3BLwh3ouqZH9QF4uPxOwf8AJ/mKKZ0jwxKXNbGDKChXUse8VcjcjyAQfddwcm4nD+atxRC8C48ZINVSAq6RROX/gbiEunrciUX/UhAn8vJ2V9WngDSfjmuruymzAQOilWFWw8eYpVbVQGZ8hnW1Ab5ODRXfph7u0mHetGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuJgRXCC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737086925; x=1768622925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XN2HDfZSi4E3Bt+VVA24AJFY8CsxsUSIXmQ6j6uCaFk=;
  b=GuJgRXCCYvWJNfz+rajUes17UMIh+eYUYoSsG3/8HQVVMpjWyRHXhddO
   D91iLUC1UwKNkTxQcVkAwi5E+PDt8+c23Sr1xK6A+HV8hMhPst3ES5tOS
   lBmSnfTr+ASJFbcI62c3Fy2lmFuKtM6yZE2xHsyU56kIAeYVlD/w31kVG
   gkDCOUjd1IMO6bMy4LN8kdF/InxgU96as7IQneIaKVwwXhWMwhuXCuypq
   TvjNJM0JgmK8EWffERmpsAe310Mp+DgBH4kmLpNbeFQ1xEmCI6v+M/aZU
   uaJf+XzEQuDagKVOXH+v4MQhdTeA9xP9+Hg2ug+OhBH4pYJ8xgn2tN+CI
   w==;
X-CSE-ConnectionGUID: cwRh55qXSDWf0cOqt0hcZA==
X-CSE-MsgGUID: amoYAWwBTbqq+BaTryfvkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48902126"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="48902126"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 20:08:44 -0800
X-CSE-ConnectionGUID: A8Lle1YRR/e8h5Q/GwxktA==
X-CSE-MsgGUID: PRnAfN2IRtSTwPu5kmybSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142979125"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Jan 2025 20:08:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYdey-000Sjx-1i;
	Fri, 17 Jan 2025 04:08:40 +0000
Date: Fri, 17 Jan 2025 12:08:08 +0800
From: kernel test robot <lkp@intel.com>
To: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry from
 the list
Message-ID: <202501171112.wcOmBz6B-lkp@intel.com>
References: <20250115232406.44815-2-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115232406.44815-2-okorniev@redhat.com>

Hi Olga,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on brauner-vfs/vfs.all linus/master v6.13-rc7 next-20250116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Olga-Kornievskaia/llist-add-ability-to-remove-a-particular-entry-from-the-list/20250116-072951
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250115232406.44815-2-okorniev%40redhat.com
patch subject: [PATCH 1/3] llist: add ability to remove a particular entry from the list
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250117/202501171112.wcOmBz6B-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250117/202501171112.wcOmBz6B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501171112.wcOmBz6B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> clang diag: include/linux/llist.h:283:7: warning: variable 'pos' is uninitialized when used here [-Wuninitialized]
   clang diag: include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
   clang diag: include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

