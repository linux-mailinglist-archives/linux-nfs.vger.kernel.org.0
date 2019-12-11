Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63CBF11A051
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2019 02:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfLKBCU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 20:02:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:28676 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbfLKBCU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Dec 2019 20:02:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 17:02:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,301,1571727600"; 
   d="gz'50?scan'50,208,50";a="225338061"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Dec 2019 17:02:15 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ieqOM-0004Aw-U6; Wed, 11 Dec 2019 09:02:14 +0800
Date:   Wed, 11 Dec 2019 09:01:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     madhuparnabhowmik04@gmail.com
Cc:     kbuild-all@lists.01.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, paulmck@kernel.org,
        joel@joelfernandes.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] fs: nfs: dir.c: Fix sparse error
Message-ID: <201912110621.WJ6oENgf%lkp@intel.com>
References: <20191210054639.30003-1-madhuparnabhowmik04@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="k6avryosbp3gkfsn"
Content-Disposition: inline
In-Reply-To: <20191210054639.30003-1-madhuparnabhowmik04@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--k6avryosbp3gkfsn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on nfs/linux-next]
[cannot apply to v5.5-rc1 next-20191210]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/madhuparnabhowmik04-gmail-com/fs-nfs-dir-c-Fix-sparse-error/20191210-173307
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: s390-debug_defconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/rbtree.h:22:0,
                    from include/linux/mm_types.h:10,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from fs/nfs/dir.c:21:
   fs/nfs/dir.c: In function 'nfs_access_get_cached_rcu':
>> fs/nfs/dir.c:2353:23: error: implicit declaration of function 'list_tail_rcu'; did you mean 'list_del_rcu'? [-Werror=implicit-function-declaration]
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
                          ^
   include/linux/rcupdate.h:319:10: note: in definition of macro '__rcu_dereference_check'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
             ^
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> fs/nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:319:9: error: invalid type argument of unary '*' (have 'int')
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
            ^
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> fs/nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
   include/linux/rcupdate.h:319:35: error: invalid type argument of unary '*' (have 'int')
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                      ^
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> fs/nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11:0,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from fs/nfs/dir.c:21:
   include/linux/compiler.h:263:20: error: lvalue required as unary '&' operand
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                       ^
   include/linux/compiler.h:269:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
>> include/linux/rcupdate.h:319:48: note: in expansion of macro 'READ_ONCE'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                                   ^~~~~~~~~
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> fs/nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
   include/linux/compiler.h:265:28: error: lvalue required as unary '&' operand
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                               ^
   include/linux/compiler.h:269:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
>> include/linux/rcupdate.h:319:48: note: in expansion of macro 'READ_ONCE'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                                   ^~~~~~~~~
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> fs/nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
   In file included from include/linux/rbtree.h:22:0,
                    from include/linux/mm_types.h:10,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from fs/nfs/dir.c:21:
   include/linux/rcupdate.h:322:11: error: invalid type argument of unary '*' (have 'int')
     ((typeof(*p) __force __kernel *)(________p1)); \
              ^
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/rbtree.h:22:0,
                    from include/linux/mm_types.h:10,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from fs//nfs/dir.c:21:
   fs//nfs/dir.c: In function 'nfs_access_get_cached_rcu':
   fs//nfs/dir.c:2353:23: error: implicit declaration of function 'list_tail_rcu'; did you mean 'list_del_rcu'? [-Werror=implicit-function-declaration]
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
                          ^
   include/linux/rcupdate.h:319:10: note: in definition of macro '__rcu_dereference_check'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
             ^
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
   fs//nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:319:9: error: invalid type argument of unary '*' (have 'int')
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
            ^
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
   fs//nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
   include/linux/rcupdate.h:319:35: error: invalid type argument of unary '*' (have 'int')
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                      ^
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
   fs//nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11:0,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from fs//nfs/dir.c:21:
   include/linux/compiler.h:263:20: error: lvalue required as unary '&' operand
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                       ^
   include/linux/compiler.h:269:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
>> include/linux/rcupdate.h:319:48: note: in expansion of macro 'READ_ONCE'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                                   ^~~~~~~~~
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
   fs//nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
   include/linux/compiler.h:265:28: error: lvalue required as unary '&' operand
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                               ^
   include/linux/compiler.h:269:22: note: in expansion of macro '__READ_ONCE'
    #define READ_ONCE(x) __READ_ONCE(x, 1)
                         ^~~~~~~~~~~
>> include/linux/rcupdate.h:319:48: note: in expansion of macro 'READ_ONCE'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                                   ^~~~~~~~~
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
   fs//nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
   In file included from include/linux/rbtree.h:22:0,
                    from include/linux/mm_types.h:10,
                    from include/linux/mmzone.h:21,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:13,
                    from fs//nfs/dir.c:21:
   include/linux/rcupdate.h:322:11: error: invalid type argument of unary '*' (have 'int')
     ((typeof(*p) __force __kernel *)(________p1)); \
              ^
>> include/linux/rcupdate.h:456:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rcupdate.h:514:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
   fs//nfs/dir.c:2353:7: note: in expansion of macro 'rcu_dereference'
     lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
          ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +2353 fs/nfs/dir.c

  2339	
  2340	static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res)
  2341	{
  2342		/* Only check the most recently returned cache entry,
  2343		 * but do it without locking.
  2344		 */
  2345		struct nfs_inode *nfsi = NFS_I(inode);
  2346		struct nfs_access_entry *cache;
  2347		int err = -ECHILD;
  2348		struct list_head *lh;
  2349	
  2350		rcu_read_lock();
  2351		if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
  2352			goto out;
> 2353		lh = rcu_dereference(list_tail_rcu(&nfsi->access_cache_entry_lru));
  2354		cache = list_entry(lh, struct nfs_access_entry, lru);
  2355		if (lh == &nfsi->access_cache_entry_lru ||
  2356		    cred != cache->cred)
  2357			cache = NULL;
  2358		if (cache == NULL)
  2359			goto out;
  2360		if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_ACCESS))
  2361			goto out;
  2362		res->cred = cache->cred;
  2363		res->mask = cache->mask;
  2364		err = 0;
  2365	out:
  2366		rcu_read_unlock();
  2367		return err;
  2368	}
  2369	

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--k6avryosbp3gkfsn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--k6avryosbp3gkfsn--
