Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99082478568
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 08:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhLQHKD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 02:10:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:61939 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhLQHKC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 17 Dec 2021 02:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639725002; x=1671261002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ix1MLGs2iQBvH41yLtq1HDNUa2s5pR3C+iSNwiUOCsQ=;
  b=W0/lrhkC/FZcMNY1LaE6NVIw7CcMqmT0sy8eHtVZeGS7ITDgmIexZFgk
   mFgFBf/XUYzdfFoMzE5JwOcAt2aiNeszuNXPLuNcP9udic74kbwyKD3sE
   FyYVUJd9U1Py/9cMR2kL35b6AvqQTrjQlxPf1YJ4YJgk1AAPSpARMvbjD
   iYDjZpY7VDjX4wg6CM5X2ZQk6aDn7WhbheCzHZJj1jUPASrigXE0MSM+v
   Yijp6BCXeLyg8x6Ru5a9DDS7/F1dk/cy3S1Cr1cgP5cNa6JTTggV2uzSh
   mNy7jl1OAHd88ejYmHHphd1DYPrM76OiUm710jKLNwmjtNHB8MOjA7yeg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="219712095"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="219712095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 23:10:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="465029821"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 16 Dec 2021 23:09:57 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1my7NN-0004OD-49; Fri, 17 Dec 2021 07:09:57 +0000
Date:   Fri, 17 Dec 2021 15:09:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] MM: submit multipage reads for SWP_FS_OPS
 swap-space
Message-ID: <202112171515.XWCl9bpF-lkp@intel.com>
References: <163969850296.20885.16043920355602134308.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163969850296.20885.16043920355602134308.stgit@noble.brown>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NeilBrown,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on cifs/for-next]
[also build test ERROR on axboe-block/for-next rostedt-trace/for-next linus/master v5.16-rc5]
[cannot apply to trondmy-nfs/linux-next hnaz-mm/master mszeredi-vfs/overlayfs-next next-20211216]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/NeilBrown/Repair-SWAP-over-NFS/20211217-075659
base:   git://git.samba.org/sfrench/cifs-2.6.git for-next
config: nds32-allnoconfig (https://download.01.org/0day-ci/archive/20211217/202112171515.XWCl9bpF-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d34716a962c31e9e0a6e40a702e581a02b7e29f7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review NeilBrown/Repair-SWAP-over-NFS/20211217-075659
        git checkout d34716a962c31e9e0a6e40a702e581a02b7e29f7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/memory.c: In function 'do_swap_page':
>> mm/memory.c:3541:33: error: too many arguments to function 'swap_readpage'
    3541 |                                 swap_readpage(page, true, NULL);
         |                                 ^~~~~~~~~~~~~
   In file included from mm/memory.c:88:
   mm/swap.h:61:19: note: declared here
      61 | static inline int swap_readpage(struct page *page, bool do_poll)
         |                   ^~~~~~~~~~~~~


vim +/swap_readpage +3541 mm/memory.c

  3462	
  3463	/*
  3464	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  3465	 * but allow concurrent faults), and pte mapped but not yet locked.
  3466	 * We return with pte unmapped and unlocked.
  3467	 *
  3468	 * We return with the mmap_lock locked or unlocked in the same cases
  3469	 * as does filemap_fault().
  3470	 */
  3471	vm_fault_t do_swap_page(struct vm_fault *vmf)
  3472	{
  3473		struct vm_area_struct *vma = vmf->vma;
  3474		struct page *page = NULL, *swapcache;
  3475		struct swap_info_struct *si = NULL;
  3476		swp_entry_t entry;
  3477		pte_t pte;
  3478		int locked;
  3479		int exclusive = 0;
  3480		vm_fault_t ret = 0;
  3481		void *shadow = NULL;
  3482	
  3483		if (!pte_unmap_same(vmf))
  3484			goto out;
  3485	
  3486		entry = pte_to_swp_entry(vmf->orig_pte);
  3487		if (unlikely(non_swap_entry(entry))) {
  3488			if (is_migration_entry(entry)) {
  3489				migration_entry_wait(vma->vm_mm, vmf->pmd,
  3490						     vmf->address);
  3491			} else if (is_device_exclusive_entry(entry)) {
  3492				vmf->page = pfn_swap_entry_to_page(entry);
  3493				ret = remove_device_exclusive_entry(vmf);
  3494			} else if (is_device_private_entry(entry)) {
  3495				vmf->page = pfn_swap_entry_to_page(entry);
  3496				ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
  3497			} else if (is_hwpoison_entry(entry)) {
  3498				ret = VM_FAULT_HWPOISON;
  3499			} else {
  3500				print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
  3501				ret = VM_FAULT_SIGBUS;
  3502			}
  3503			goto out;
  3504		}
  3505	
  3506		/* Prevent swapoff from happening to us. */
  3507		si = get_swap_device(entry);
  3508		if (unlikely(!si))
  3509			goto out;
  3510	
  3511		delayacct_set_flag(current, DELAYACCT_PF_SWAPIN);
  3512		page = lookup_swap_cache(entry, vma, vmf->address);
  3513		swapcache = page;
  3514	
  3515		if (!page) {
  3516			if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
  3517			    __swap_count(entry) == 1) {
  3518				/* skip swapcache */
  3519				page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
  3520								vmf->address);
  3521				if (page) {
  3522					__SetPageLocked(page);
  3523					__SetPageSwapBacked(page);
  3524	
  3525					if (mem_cgroup_swapin_charge_page(page,
  3526						vma->vm_mm, GFP_KERNEL, entry)) {
  3527						ret = VM_FAULT_OOM;
  3528						goto out_page;
  3529					}
  3530					mem_cgroup_swapin_uncharge_swap(entry);
  3531	
  3532					shadow = get_shadow_from_swap_cache(entry);
  3533					if (shadow)
  3534						workingset_refault(page_folio(page),
  3535									shadow);
  3536	
  3537					lru_cache_add(page);
  3538	
  3539					/* To provide entry to swap_readpage() */
  3540					set_page_private(page, entry.val);
> 3541					swap_readpage(page, true, NULL);
  3542					set_page_private(page, 0);
  3543				}
  3544			} else {
  3545				page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
  3546							vmf);
  3547				swapcache = page;
  3548			}
  3549	
  3550			if (!page) {
  3551				/*
  3552				 * Back out if somebody else faulted in this pte
  3553				 * while we released the pte lock.
  3554				 */
  3555				vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  3556						vmf->address, &vmf->ptl);
  3557				if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
  3558					ret = VM_FAULT_OOM;
  3559				delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
  3560				goto unlock;
  3561			}
  3562	
  3563			/* Had to read the page from swap area: Major fault */
  3564			ret = VM_FAULT_MAJOR;
  3565			count_vm_event(PGMAJFAULT);
  3566			count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
  3567		} else if (PageHWPoison(page)) {
  3568			/*
  3569			 * hwpoisoned dirty swapcache pages are kept for killing
  3570			 * owner processes (which may be unknown at hwpoison time)
  3571			 */
  3572			ret = VM_FAULT_HWPOISON;
  3573			delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
  3574			goto out_release;
  3575		}
  3576	
  3577		locked = lock_page_or_retry(page, vma->vm_mm, vmf->flags);
  3578	
  3579		delayacct_clear_flag(current, DELAYACCT_PF_SWAPIN);
  3580		if (!locked) {
  3581			ret |= VM_FAULT_RETRY;
  3582			goto out_release;
  3583		}
  3584	
  3585		/*
  3586		 * Make sure try_to_free_swap or reuse_swap_page or swapoff did not
  3587		 * release the swapcache from under us.  The page pin, and pte_same
  3588		 * test below, are not enough to exclude that.  Even if it is still
  3589		 * swapcache, we need to check that the page's swap has not changed.
  3590		 */
  3591		if (unlikely((!PageSwapCache(page) ||
  3592				page_private(page) != entry.val)) && swapcache)
  3593			goto out_page;
  3594	
  3595		page = ksm_might_need_to_copy(page, vma, vmf->address);
  3596		if (unlikely(!page)) {
  3597			ret = VM_FAULT_OOM;
  3598			page = swapcache;
  3599			goto out_page;
  3600		}
  3601	
  3602		cgroup_throttle_swaprate(page, GFP_KERNEL);
  3603	
  3604		/*
  3605		 * Back out if somebody else already faulted in this pte.
  3606		 */
  3607		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
  3608				&vmf->ptl);
  3609		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte)))
  3610			goto out_nomap;
  3611	
  3612		if (unlikely(!PageUptodate(page))) {
  3613			ret = VM_FAULT_SIGBUS;
  3614			goto out_nomap;
  3615		}
  3616	
  3617		/*
  3618		 * The page isn't present yet, go ahead with the fault.
  3619		 *
  3620		 * Be careful about the sequence of operations here.
  3621		 * To get its accounting right, reuse_swap_page() must be called
  3622		 * while the page is counted on swap but not yet in mapcount i.e.
  3623		 * before page_add_anon_rmap() and swap_free(); try_to_free_swap()
  3624		 * must be called after the swap_free(), or it will never succeed.
  3625		 */
  3626	
  3627		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
  3628		dec_mm_counter_fast(vma->vm_mm, MM_SWAPENTS);
  3629		pte = mk_pte(page, vma->vm_page_prot);
  3630		if ((vmf->flags & FAULT_FLAG_WRITE) && reuse_swap_page(page, NULL)) {
  3631			pte = maybe_mkwrite(pte_mkdirty(pte), vma);
  3632			vmf->flags &= ~FAULT_FLAG_WRITE;
  3633			ret |= VM_FAULT_WRITE;
  3634			exclusive = RMAP_EXCLUSIVE;
  3635		}
  3636		flush_icache_page(vma, page);
  3637		if (pte_swp_soft_dirty(vmf->orig_pte))
  3638			pte = pte_mksoft_dirty(pte);
  3639		if (pte_swp_uffd_wp(vmf->orig_pte)) {
  3640			pte = pte_mkuffd_wp(pte);
  3641			pte = pte_wrprotect(pte);
  3642		}
  3643		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
  3644		arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
  3645		vmf->orig_pte = pte;
  3646	
  3647		/* ksm created a completely new copy */
  3648		if (unlikely(page != swapcache && swapcache)) {
  3649			page_add_new_anon_rmap(page, vma, vmf->address, false);
  3650			lru_cache_add_inactive_or_unevictable(page, vma);
  3651		} else {
  3652			do_page_add_anon_rmap(page, vma, vmf->address, exclusive);
  3653		}
  3654	
  3655		swap_free(entry);
  3656		if (mem_cgroup_swap_full(page) ||
  3657		    (vma->vm_flags & VM_LOCKED) || PageMlocked(page))
  3658			try_to_free_swap(page);
  3659		unlock_page(page);
  3660		if (page != swapcache && swapcache) {
  3661			/*
  3662			 * Hold the lock to avoid the swap entry to be reused
  3663			 * until we take the PT lock for the pte_same() check
  3664			 * (to avoid false positives from pte_same). For
  3665			 * further safety release the lock after the swap_free
  3666			 * so that the swap count won't change under a
  3667			 * parallel locked swapcache.
  3668			 */
  3669			unlock_page(swapcache);
  3670			put_page(swapcache);
  3671		}
  3672	
  3673		if (vmf->flags & FAULT_FLAG_WRITE) {
  3674			ret |= do_wp_page(vmf);
  3675			if (ret & VM_FAULT_ERROR)
  3676				ret &= VM_FAULT_ERROR;
  3677			goto out;
  3678		}
  3679	
  3680		/* No need to invalidate - it was non-present before */
  3681		update_mmu_cache(vma, vmf->address, vmf->pte);
  3682	unlock:
  3683		pte_unmap_unlock(vmf->pte, vmf->ptl);
  3684	out:
  3685		if (si)
  3686			put_swap_device(si);
  3687		return ret;
  3688	out_nomap:
  3689		pte_unmap_unlock(vmf->pte, vmf->ptl);
  3690	out_page:
  3691		unlock_page(page);
  3692	out_release:
  3693		put_page(page);
  3694		if (page != swapcache && swapcache) {
  3695			unlock_page(swapcache);
  3696			put_page(swapcache);
  3697		}
  3698		if (si)
  3699			put_swap_device(si);
  3700		return ret;
  3701	}
  3702	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
