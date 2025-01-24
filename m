Return-Path: <linux-nfs+bounces-9568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA86A1AE05
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 01:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E1E7A4A24
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 00:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D62CA8;
	Fri, 24 Jan 2025 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDOhq5Qn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DBE224CC
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 00:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737680298; cv=none; b=mMp3wR2tnwkDd2mwFmK5hgtyLVzguz0kuyY/Tikx/93dwUzu55U1TJqWYfeycGWcN4BkmS1vlCdCENA+HRFujmWF3vzSXOfo6rA9DofUXZlW5Qmk1mx0Lyu7UCDWGzTcA0bY4UAM01kv+6j7Dq6weViVURltNvJJ12OUNRWl1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737680298; c=relaxed/simple;
	bh=LJBWz7gpPx6pYor80sUUmn3yFQaUSRq1SmFUxTQS2wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDpbz3U/b64ln3R1oalokUQ0rVfI2MUHF9jl6sODVB1IVpVtnhUEqDlZGYN6Y0rrfQHPP63f7wYU+EfUaVlJOS2M1ICT2D2bqeWww3Ee82LoOQehNgq4A0FUVbvsBtBW5ll58Q3K0HZprv03/oGqQnCaHVZ8tcBc7hBrmp0he2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDOhq5Qn; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737680297; x=1769216297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LJBWz7gpPx6pYor80sUUmn3yFQaUSRq1SmFUxTQS2wY=;
  b=XDOhq5QnuhHEvTa+6KpajxUXvsgIGrpSa2UGK3eHkwDkkZqrTdbMWpGC
   ZRDYD2K8H+6o3/FOkwNpgRfQ2IcI2FeSJTs+q43vq7yek5Il7Ati/JUok
   PveGMfBNv72bRhKolZZdiqvMIi470ECyhnfifggVogkWPozZShFU6uO3H
   f+fNgaXA2lP3THUce+D7ZpXHDA+U9RJ74jw9OCxBIexl86EEQeZZzQfdT
   +aT3O56w7r6GhmMFw5zIK51RthhKOsuVqRBvvbHO/JBaa31mVpQzV/myW
   1j4pW5iSkG0gHIbAyI0W104e4Msur7UFmZkRIJDPCGNkAQRylMH+XU93g
   g==;
X-CSE-ConnectionGUID: N5W5Lec1TPaW72rCJSClOA==
X-CSE-MsgGUID: LvFF1bVhTzaaQm5UgD+GWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="25811788"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="25811788"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 16:58:15 -0800
X-CSE-ConnectionGUID: 4UsT8Xz8R32ht4pJyvthmg==
X-CSE-MsgGUID: ELh5nu3KRZCA+ABFH0wYDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; 
   d="scan'208";a="138490980"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 23 Jan 2025 16:58:14 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tb81S-000bvn-30;
	Fri, 24 Jan 2025 00:58:10 +0000
Date: Fri, 24 Jan 2025 08:57:12 +0800
From: kernel test robot <lkp@intel.com>
To: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry from
 the list
Message-ID: <202501240848.ZH81rjTD-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on brauner-vfs/vfs.all linus/master v6.13 next-20250123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Olga-Kornievskaia/llist-add-ability-to-remove-a-particular-entry-from-the-list/20250116-072951
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250115232406.44815-2-okorniev%40redhat.com
patch subject: [PATCH 1/3] llist: add ability to remove a particular entry from the list
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20250124/202501240848.ZH81rjTD-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 19306351a2c45e266fa11b41eb1362b20b6ca56d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250124/202501240848.ZH81rjTD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501240848.ZH81rjTD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/test_bitops.c:10:
   In file included from include/linux/module.h:17:
   In file included from include/linux/kmod.h:9:
   In file included from include/linux/umh.h:4:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:8:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:15:
   In file included from include/linux/smp_types.h:5:
>> include/linux/llist.h:283:7: error: variable 'pos' is uninitialized when used here [-Werror,-Wuninitialized]
     283 |                 if (pos->next == entry) {
         |                     ^~~
   include/linux/llist.h:269:24: note: initialize the variable 'pos' to silence this warning
     269 |         struct llist_node *pos;
         |                               ^
         |                                = NULL
   1 error generated.


vim +/pos +283 include/linux/llist.h

   255	
   256	/**
   257	 * llist_del_entry - remove a particular entry from a lock-less list
   258	 * @head: head of the list to remove the entry from
   259	 * @entry: entry to be removed from the list
   260	 *
   261	 * Walk the list, find the given entry and remove it from the list.
   262	 * The caller must ensure that nothing can race in and change the
   263	 * list while this is running.
   264	 *
   265	 * Returns true if the entry was found and removed.
   266	 */
   267	static inline bool llist_del_entry(struct llist_head *head, struct llist_node *entry)
   268	{
   269		struct llist_node *pos;
   270	
   271		if (!head->first)
   272			return false;
   273	
   274		/* Is it the first entry? */
   275		if (head->first == entry) {
   276			head->first = entry->next;
   277			entry->next = entry;
   278			return true;
   279		}
   280	
   281		/* Find it in the list */
   282		llist_for_each(head->first, pos) {
 > 283			if (pos->next == entry) {
   284				pos->next = entry->next;
   285				entry->next = entry;
   286				return true;
   287			}
   288		}
   289		return false;
   290	}
   291	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

