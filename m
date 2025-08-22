Return-Path: <linux-nfs+bounces-13868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BB3B30ECA
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 08:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326841CE51DD
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Aug 2025 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F412E3B1D;
	Fri, 22 Aug 2025 06:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWh3E0gY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A09C218AD2;
	Fri, 22 Aug 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843756; cv=none; b=IcXky6kw6UVCap1SzSTTg2IxO1LgQQ7gbmYDJ6IoEdI5EOY0PpoBEJd7xBkziZJOrx8aMnkyPmzwpF49PlmWsK5S5l6AelYZKh8/vehCDg3NhV8FISCbhZsQxH39GPb1kxEWp+uqf0+6Cbwr54WdL44ChOoq9TtXANpx0w8hj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843756; c=relaxed/simple;
	bh=lQF2ocuOorG+AyNCviJelZCZ4e41pFo8eQYAi3ckwLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn9HZKz55rgJIOwqPXi9Q6TSJ1vWv6TEZ9Rw6jHJ+PzMJgdxWJKvpGF4wMSX2qk5+JV36hIzjKGT/mMr++JWRCwbCyjM8yRaEx8xLLdY0YmLm8nlWGVPhrLK1TDYtU8X/LmnO33XNqgnL5BxwFJVFEonunrb1QMXAc2+y30PQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWh3E0gY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755843754; x=1787379754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lQF2ocuOorG+AyNCviJelZCZ4e41pFo8eQYAi3ckwLw=;
  b=TWh3E0gYll9/+kVtiU04tF5QU6HYgFJnCeQZqT5TDKYOtS3jLnvrbCni
   CkmLKetYPHLD1ZdldfXIaadES1ovG7Hv1DzAo5YpDRt5n8I2GeU4X9jvB
   M1H/pg7Ygw8qIV2tuUSbzgsqXPN9vpSvEADJ/8AiFAtt/effFYthad65q
   TSzfrZNsS85pxLIFDKeQshtm3/KQpoEvWgcC16OoZ8hMZBoLVcQFr0xJQ
   dV+jgCxpX+S+j7LcnYA5iSlzsmYrYCGYwyH1G1bScW3cgkdnzIvkff7EZ
   /1vkV8hjahNCYmLOeOo4+4+1EDTegd43OhoVrGAD0Il++Q6d6q2/kiwa9
   w==;
X-CSE-ConnectionGUID: EtNGsRPwT8indCbXQZp+GQ==
X-CSE-MsgGUID: AJ3HTAMKSsqwjVM9FsOG+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58246260"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="58246260"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 23:22:33 -0700
X-CSE-ConnectionGUID: kwV79w6VQVGef6mJlafI4w==
X-CSE-MsgGUID: jiqm1GsbSPOc/uWbCND9yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168535573"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 21 Aug 2025 23:22:29 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1upLAQ-000KyF-1t;
	Fri, 22 Aug 2025 06:22:26 +0000
Date: Fri, 22 Aug 2025 14:22:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/2] sunrpc: add a Kconfig option to redirect dfprintk()
 output to trace buffer
Message-ID: <202508221433.vcMr9C38-lkp@intel.com>
References: <20250821-nfs-testing-v1-2-f06099963eda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-nfs-testing-v1-2-f06099963eda@kernel.org>

Hi Jeff,

kernel test robot noticed the following build errors:

[auto build test ERROR on 80a1bea0cd81de70c56b37a8292c23d57419776f]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeff-Layton/sunrpc-remove-dfprintk_cont-and-dfprintk_rcu_cont/20250822-011902
base:   80a1bea0cd81de70c56b37a8292c23d57419776f
patch link:    https://lore.kernel.org/r/20250821-nfs-testing-v1-2-f06099963eda%40kernel.org
patch subject: [PATCH 2/2] sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer
config: parisc-randconfig-001-20250822 (https://download.01.org/0day-ci/archive/20250822/202508221433.vcMr9C38-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250822/202508221433.vcMr9C38-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508221433.vcMr9C38-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sunrpc/types.h:16,
                    from include/linux/sunrpc/sched.h:15,
                    from include/linux/sunrpc/clnt.h:20,
                    from fs/nfs/proc.c:39:
   fs/nfs/proc.c: In function 'nfs_proc_get_root':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
      25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   fs/nfs/proc.c:66:2: note: in expansion of macro 'dprintk'
      66 |  dprintk("%s: call getattr\n", __func__);
         |  ^~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/sunrpc/types.h:16,
                    from include/linux/sunrpc/sched.h:15,
                    from include/linux/sunrpc/clnt.h:20,
                    from fs/nfs/nfs2xdr.c:21:
   fs/nfs/nfs2xdr.c: In function 'decode_nfsdata':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
      25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   fs/nfs/nfs2xdr.c:110:2: note: in expansion of macro 'dprintk'
     110 |  dprintk("NFS: server cheating in read result: "
         |  ^~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/sunrpc/types.h:16,
                    from include/linux/sunrpc/sched.h:15,
                    from fs/nfs/unlink.c:12:
   fs/nfs/unlink.c: In function 'nfs_sillyrename':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   fs/nfs/unlink.c:453:2: note: in expansion of macro 'dfprintk'
     453 |  dfprintk(VFS, "NFS: silly-rename(%pd2, ct=%d)\n",
         |  ^~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/nfs_fs.h:30,
                    from fs/nfs/direct.c:52:
   fs/nfs/direct.c: In function 'nfs_file_direct_read':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   fs/nfs/direct.c:444:2: note: in expansion of macro 'dfprintk'
     444 |  dfprintk(FILE, "NFS: direct read(%pD2, %zd@%Ld)\n",
         |  ^~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/sunrpc/types.h:16,
                    from include/linux/sunrpc/sched.h:15,
                    from include/linux/sunrpc/auth.h:13,
                    from include/linux/nfs.h:12,
                    from fs/nfs/export.c:9:
   fs/nfs/export.c: In function 'nfs_encode_fh':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
      25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   fs/nfs/export.c:42:2: note: in expansion of macro 'dprintk'
      42 |  dprintk("%s: max fh len %d inode %p parent %p",
         |  ^~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/sunrpc/types.h:16,
                    from include/linux/sunrpc/sched.h:15,
                    from include/linux/sunrpc/clnt.h:20,
                    from fs/nfs/super.c:34:
   fs/nfs/super.c: In function 'nfs_statfs':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
      25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   fs/nfs/super.c:310:2: note: in expansion of macro 'dprintk'
     310 |  dprintk("%s: statfs error = %d\n", __func__, -error);
         |  ^~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/sunrpc/types.h:16,
                    from include/linux/sunrpc/sched.h:15,
                    from include/linux/sunrpc/clnt.h:20,
                    from fs/nfs/inode.c:27:
   fs/nfs/inode.c: In function 'nfs_ilookup':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
      25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   fs/nfs/inode.c:425:2: note: in expansion of macro 'dprintk'
     425 |  dprintk("%s: returning %p\n", __func__, inode);
         |  ^~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/sunrpc/types.h:16,
                    from include/linux/sunrpc/sched.h:15,
                    from include/linux/sunrpc/clnt.h:20,
                    from fs/nfs/mount_clnt.c:15:
   fs/nfs/mount_clnt.c: In function 'nfs_mount':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
      25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   fs/nfs/mount_clnt.c:168:2: note: in expansion of macro 'dprintk'
     168 |  dprintk("NFS: sending MNT request for %s:%s\n",
         |  ^~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/nfs_fs.h:30,
                    from fs/nfs/fs_context.c:18:
   fs/nfs/fs_context.c: In function 'nfs_validate_transport_protocol':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
      25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   fs/nfs/internal.h:175:5: note: in expansion of macro 'dprintk'
     175 |  ({ dprintk(fmt "\n", ## __VA_ARGS__);  -EINVAL; }))
         |     ^~~~~~~
   fs/nfs/fs_context.c:388:9: note: in expansion of macro 'nfs_invalf'
     388 |  return nfs_invalf(fc, "NFS: Unsupported transport protocol udp");
         |         ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/nfs_fs.h:30,
                    from fs/nfs/file.c:26:
   fs/nfs/file.c: In function 'nfs_file_open':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
      25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   fs/nfs/file.c:66:2: note: in expansion of macro 'dprintk'
      66 |  dprintk("NFS: open file(%pD2)\n", filp);
         |  ^~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/sunrpc/types.h:16,
                    from include/linux/sunrpc/sched.h:15,
                    from include/linux/sunrpc/clnt.h:20,
                    from fs/nfs/write.c:19:
   fs/nfs/write.c: In function 'nfs_update_folio':
>> include/linux/sunrpc/debug.h:36:37: error: implicit declaration of function 'pr_default'; did you mean 'pr_devel'? [-Werror=implicit-function-declaration]
      36 | #  define __sunrpc_printk(fmt, ...) pr_default(fmt, ##__VA_ARGS__)
         |                                     ^~~~~~~~~~
   include/linux/sunrpc/debug.h:42:3: note: in expansion of macro '__sunrpc_printk'
      42 |   __sunrpc_printk(fmt, ##__VA_ARGS__);   \
         |   ^~~~~~~~~~~~~~~
   include/linux/sunrpc/debug.h:25:2: note: in expansion of macro 'dfprintk'
      25 |  dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |  ^~~~~~~~
   fs/nfs/write.c:1348:2: note: in expansion of macro 'dprintk'
    1348 |  dprintk("NFS:       nfs_update_folio(%pD2 %d@%lld)\n", file, count,
         |  ^~~~~~~
   cc1: some warnings being treated as errors
..


vim +36 include/linux/sunrpc/debug.h

    32	
    33	# if IS_ENABLED(CONFIG_SUNRPC_DEBUG_TRACE)
    34	#  define __sunrpc_printk(fmt, ...)	trace_printk(fmt, ##__VA_ARGS__)
    35	# else
  > 36	#  define __sunrpc_printk(fmt, ...)	pr_default(fmt, ##__VA_ARGS__)
    37	# endif
    38	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

