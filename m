Return-Path: <linux-nfs+bounces-9332-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D90A148B6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 05:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EB71886250
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 04:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BD025765;
	Fri, 17 Jan 2025 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEfvAW4B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01851F63DD
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737086927; cv=none; b=LJntqQi2zlBVyXaiEBCSrYhEezol7j+XmZTudx75wzNBdf1v/jU5v32MiglFNJCfQbyvRT9JnXZ6rXd0ckZAPtSDDJI2Sz1bzXQjSK+6UMNY0JDA3dI7s9mIcF6wDmpDiuqxBnIR6kWbnil+Bfi8nv3fW+if+IhnBjCLWv/qvJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737086927; c=relaxed/simple;
	bh=fm0fs58+uy4E7RC/zVKOcN9L7JDQCBTiGjTPpjzx8Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltJxRX3qSUgse6bg7L0QgoBidAieuZOcfvArpnDLJb1oO683Go8e9tQ1s64ugEFvOb5BMMlTyv6iHn2HVnO3LTssHp6e3S/ihYRcrt6/UyKC44D1HKZ5KGtL4bMTuU2qFj2+hyrwWdFZrz2jVF6+p6jEHisRLxYIVNusdvaRQGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEfvAW4B; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737086926; x=1768622926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fm0fs58+uy4E7RC/zVKOcN9L7JDQCBTiGjTPpjzx8Ac=;
  b=HEfvAW4Brm8RZE2eqkakQrpJSjPDwp0TRjqy8id221MR+wjRCb0DwWTD
   CIjoQK424+VtXEZXBflV/NsvmOfoQgsV7Wz6pA2edy3HcObhBaxPyhndH
   jPvmiIOr18IFvfvSSTxHDJIE3ZBW5qsR2R+kIkS7kwz+eXGUZwFuLExre
   xN9agDIP7cxgGbNU2icFRc/0VuNjrX/E4VYtJF5rDJm0tnQCRZRnrUcel
   93nQDLlWuspmp6RvVhTQWouUMERlIOii9wNxwlrz+SuypjAdn93trOEEM
   7H0Z5ifzjAtdDjdAtOvmsgInWKn3BRHuAJODh2ZRcbuxnK5/QFwWLcMph
   g==;
X-CSE-ConnectionGUID: 4+rfxHVtSj2p5ml6+8jwgA==
X-CSE-MsgGUID: qjsSBMbLTAi8oEESmgoocg==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48902133"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="48902133"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 20:08:45 -0800
X-CSE-ConnectionGUID: bCrjebbvSniZQXFICjXtvQ==
X-CSE-MsgGUID: BFgR0q09TS2Px0wP1/9Y0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142979124"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 16 Jan 2025 20:08:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYdey-000Sjv-1d;
	Fri, 17 Jan 2025 04:08:40 +0000
Date: Fri, 17 Jan 2025 12:08:06 +0800
From: kernel test robot <lkp@intel.com>
To: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>
Subject: Re: [PATCH 1/3] llist: add ability to remove a particular entry from
 the list
Message-ID: <202501171157.gr1JO94W-lkp@intel.com>
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
[also build test ERROR on brauner-vfs/vfs.all linus/master v6.13-rc7 next-20250116]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Olga-Kornievskaia/llist-add-ability-to-remove-a-particular-entry-from-the-list/20250116-072951
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250115232406.44815-2-okorniev%40redhat.com
patch subject: [PATCH 1/3] llist: add ability to remove a particular entry from the list
config: s390-randconfig-002-20250117 (https://download.01.org/0day-ci/archive/20250117/202501171157.gr1JO94W-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project c23f2417dc5f6dc371afb07af5627ec2a9d373a0)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250117/202501171157.gr1JO94W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501171157.gr1JO94W-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:7:
   In file included from include/linux/hardirq.h:5:
   In file included from include/linux/context_tracking_state.h:5:
   In file included from include/linux/percpu.h:5:
   In file included from include/linux/alloc_tag.h:14:
   In file included from include/linux/smp.h:15:
   In file included from include/linux/smp_types.h:5:
>> include/linux/llist.h:283:7: warning: variable 'pos' is uninitialized when used here [-Wuninitialized]
     283 |                 if (pos->next == entry) {
         |                     ^~~
   include/linux/llist.h:269:24: note: initialize the variable 'pos' to silence this warning
     269 |         struct llist_node *pos;
         |                               ^
         |                                = NULL
   In file included from arch/s390/kernel/asm-offsets.c:11:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.
--
   In file included from <built-in>:4:
   In file included from lib/vdso/getrandom.c:8:
   In file included from include/vdso/datapage.h:164:
   In file included from arch/s390/include/asm/vdso/gettimeofday.h:11:
   In file included from arch/s390/include/asm/syscall.h:13:
   In file included from include/linux/sched.h:20:
   In file included from include/linux/smp_types.h:5:
>> include/linux/llist.h:283:7: warning: variable 'pos' is uninitialized when used here [-Wuninitialized]
     283 |                 if (pos->next == entry) {
         |                     ^~~
   include/linux/llist.h:269:24: note: initialize the variable 'pos' to silence this warning
     269 |         struct llist_node *pos;
         |                               ^
         |                                = NULL
   1 warning generated.
--
   In file included from lib/vsprintf.c:22:
   In file included from include/linux/clk.h:14:
   In file included from include/linux/notifier.h:14:
   In file included from include/linux/mutex.h:17:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:15:
   In file included from include/linux/smp_types.h:5:
>> include/linux/llist.h:283:7: warning: variable 'pos' is uninitialized when used here [-Wuninitialized]
     283 |                 if (pos->next == entry) {
         |                     ^~~
   include/linux/llist.h:269:24: note: initialize the variable 'pos' to silence this warning
     269 |         struct llist_node *pos;
         |                               ^
         |                                = NULL
   In file included from lib/vsprintf.c:25:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from lib/vsprintf.c:50:
   In file included from lib/../mm/internal.h:13:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
   6 warnings generated.
--
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
   In file included from lib/test_bitops.c:10:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   4 errors generated.
--
   In file included from lib/test_maple_tree.c:10:
   In file included from include/linux/maple_tree.h:12:
   In file included from include/linux/rcupdate.h:29:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:15:
   In file included from include/linux/smp_types.h:5:
>> include/linux/llist.h:283:7: warning: variable 'pos' is uninitialized when used here [-Wuninitialized]
     283 |                 if (pos->next == entry) {
         |                     ^~~
   include/linux/llist.h:269:24: note: initialize the variable 'pos' to silence this warning
     269 |         struct llist_node *pos;
         |                               ^
         |                                = NULL
   In file included from lib/test_maple_tree.c:11:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   lib/test_maple_tree.c:212:26: warning: unused function 'not_empty' [-Wunused-function]
     212 | static inline __init int not_empty(struct maple_node *node)
         |                          ^~~~~~~~~
   5 warnings generated.
--
   In file included from lib/locking-selftest.c:14:
   In file included from include/linux/rwsem.h:15:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:15:
   In file included from include/linux/smp_types.h:5:
>> include/linux/llist.h:283:7: warning: variable 'pos' is uninitialized when used here [-Wuninitialized]
     283 |                 if (pos->next == entry) {
         |                     ^~~
   include/linux/llist.h:269:24: note: initialize the variable 'pos' to silence this warning
     269 |         struct llist_node *pos;
         |                               ^
         |                                = NULL
   In file included from lib/locking-selftest.c:22:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   lib/locking-selftest.c:2510:1: warning: unused function 'class_HARDIRQ_lock_ptr' [-Wunused-function]
    2510 | DEFINE_LOCK_GUARD_0(HARDIRQ, HARDIRQ_ENTER(), HARDIRQ_EXIT())
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:407:49: note: expanded from macro 'DEFINE_LOCK_GUARD_0'
     407 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
         |                                                                         ^
     408 | __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)                \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:378:21: note: expanded from macro '\
   __DEFINE_UNLOCK_GUARD'
     378 | static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)     \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:93:1: note: expanded from here
      93 | class_HARDIRQ_lock_ptr
         | ^~~~~~~~~~~~~~~~~~~~~~
   lib/locking-selftest.c:2511:1: warning: unused function 'class_NOTTHREADED_HARDIRQ_lock_ptr' [-Wunused-function]
    2511 | DEFINE_LOCK_GUARD_0(NOTTHREADED_HARDIRQ,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    2512 |         do {
         |         ~~~~
    2513 |                 local_irq_disable();
         |                 ~~~~~~~~~~~~~~~~~~~~
    2514 |                 __irq_enter();
         |                 ~~~~~~~~~~~~~~
    2515 |                 WARN_ON(!in_irq());
         |                 ~~~~~~~~~~~~~~~~~~~
    2516 |         } while(0), HARDIRQ_EXIT())
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:407:49: note: expanded from macro 'DEFINE_LOCK_GUARD_0'
     407 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
         |                                                                         ^
     408 | __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)                \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:378:21: note: expanded from macro '\
   __DEFINE_UNLOCK_GUARD'
     378 | static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)     \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:121:1: note: expanded from here
     121 | class_NOTTHREADED_HARDIRQ_lock_ptr
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/locking-selftest.c:2517:1: warning: unused function 'class_SOFTIRQ_lock_ptr' [-Wunused-function]
    2517 | DEFINE_LOCK_GUARD_0(SOFTIRQ, SOFTIRQ_ENTER(), SOFTIRQ_EXIT())
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:407:49: note: expanded from macro 'DEFINE_LOCK_GUARD_0'
     407 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
         |                                                                         ^
     408 | __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)                \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:378:21: note: expanded from macro '\
   __DEFINE_UNLOCK_GUARD'
     378 | static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)     \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:141:1: note: expanded from here
     141 | class_SOFTIRQ_lock_ptr
         | ^~~~~~~~~~~~~~~~~~~~~~
   lib/locking-selftest.c:2520:1: warning: unused function 'class_RCU_lock_ptr' [-Wunused-function]
    2520 | DEFINE_LOCK_GUARD_0(RCU, rcu_read_lock(), rcu_read_unlock())
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:407:49: note: expanded from macro 'DEFINE_LOCK_GUARD_0'
     407 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
         |                                                                         ^
     408 | __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)                \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:378:21: note: expanded from macro '\
   __DEFINE_UNLOCK_GUARD'
     378 | static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)     \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:159:1: note: expanded from here
     159 | class_RCU_lock_ptr
         | ^~~~~~~~~~~~~~~~~~
   lib/locking-selftest.c:2521:1: warning: unused function 'class_RCU_BH_lock_ptr' [-Wunused-function]
    2521 | DEFINE_LOCK_GUARD_0(RCU_BH, rcu_read_lock_bh(), rcu_read_unlock_bh())
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:407:49: note: expanded from macro 'DEFINE_LOCK_GUARD_0'
     407 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
         |                                                                         ^
--
   In file included from kernel/bpf/kmem_cache_iter.c:3:
   In file included from include/linux/bpf.h:10:
   In file included from include/linux/workqueue.h:9:
   In file included from include/linux/timer.h:8:
   In file included from include/linux/debugobjects.h:6:
   In file included from include/linux/spinlock.h:63:
   In file included from include/linux/lockdep.h:14:
   In file included from include/linux/smp.h:15:
   In file included from include/linux/smp_types.h:5:
>> include/linux/llist.h:283:7: warning: variable 'pos' is uninitialized when used here [-Wuninitialized]
     283 |                 if (pos->next == entry) {
         |                     ^~~
   include/linux/llist.h:269:24: note: initialize the variable 'pos' to silence this warning
     269 |         struct llist_node *pos;
         |                               ^
         |                                = NULL
   In file included from kernel/bpf/kmem_cache_iter.c:3:
   In file included from include/linux/bpf.h:20:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   kernel/bpf/kmem_cache_iter.c:227:27: warning: bitwise operation between different enumeration types ('enum bpf_reg_type' and 'enum bpf_type_flag') [-Wenum-enum-conversion]
     227 |                   PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },
         |                   ~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   5 warnings generated.
..


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

