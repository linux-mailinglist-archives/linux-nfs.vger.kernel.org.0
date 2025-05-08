Return-Path: <linux-nfs+bounces-11597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AD6AAF52C
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 10:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F056D4E6EF3
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 08:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6A515748F;
	Thu,  8 May 2025 08:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTkzk+v3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348E221F0B;
	Thu,  8 May 2025 08:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746691719; cv=none; b=bY5/4rSOSJNgdShoxxc+XmjMSn0PtbUV1e4BG6E2HeOHG02FaxXCOVnbU7wrfPXR44xFEO5f3rkZaVmOLaRE+57DTY+Dr9VtRMN9Bngep2avtdgqPwVNNJeLhYp72XlYtaHkz5BWXdZVLUfYgsPJUKQt+egJPHV+YLtuku/fSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746691719; c=relaxed/simple;
	bh=9VeFsQN1AkRdLpG34SjQt68RYpYDAPfiWncjBdqi8ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZSces/5/vPzqV3pCIYe20FDo9t2DWPou1g71h4Kbs4BtUovjeLCfFQ8xmkv3Vlc4UyXQH2zVPhVDnev2lH/gcQzAxDJvWt47XGJsBEZna9MTUq+XF/67F7OfMwmpLJdEhpj9xo6rl3DNcwrfwgGPx3W7wn7bNWp6qf8FkQ6ZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTkzk+v3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746691717; x=1778227717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VeFsQN1AkRdLpG34SjQt68RYpYDAPfiWncjBdqi8ag=;
  b=aTkzk+v320WKCoCsAHECQcI+U137VeosHNuIBSoRRyY5oY+TmRXI2ziy
   h5KcOI3Ua4iqGw5Jmr0bDG3qbBUXC8+JoE0VHVBon/XP7M/voazceWs8V
   1oUzKRwYW+2Es7gSR9qJXp7f1wqtVulBZwZL1NlerthV8OM5ZZRq5cfyg
   eiR9nZ7kEueQHmP8JH7S6A44sEkqmAZnuqCqz8ndxAD2+B65vdUIYmo/y
   OqJnWZ/eLL0xJWVMUWdImcS41OLvw9L/SGAWvrIm4DqbHihT2E54QL08J
   jpug66FYZhQemu+CMMax0zhBBfyK0xhwEztHb2mp90VXA9Nlw+TO1WuoS
   w==;
X-CSE-ConnectionGUID: nfWpKuWbQPuax/vt0PI5Ig==
X-CSE-MsgGUID: mhALdaRXRtqkuZi4XzHH9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58662588"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="58662588"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 01:08:37 -0700
X-CSE-ConnectionGUID: AFuGBNaOQQytHInhNl7AOA==
X-CSE-MsgGUID: s2jHfI+NSrmHpoRmsHykdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="137210046"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 May 2025 01:08:34 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCwIx-000Am7-2a;
	Thu, 08 May 2025 08:08:31 +0000
Date: Thu, 8 May 2025 16:07:55 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Anna Schumaker <anna@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>, linux-nfs@vger.kernel.org,
	kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
	keyrings@vger.kernel.org
Subject: Re: [PATCH 1/2] NFS: support the kernel keyring for TLS
Message-ID: <202505081535.3PS62D63-lkp@intel.com>
References: <20250507080944.3947782-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507080944.3947782-2-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.15-rc5 next-20250507]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/nfs-create-a-kernel-keyring/20250507-171041
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250507080944.3947782-2-hch%40lst.de
patch subject: [PATCH 1/2] NFS: support the kernel keyring for TLS
config: hexagon-defconfig (https://download.01.org/0day-ci/archive/20250508/202505081535.3PS62D63-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250508/202505081535.3PS62D63-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505081535.3PS62D63-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfs/fs_context.c:567:37: error: incomplete definition of type 'struct key'
     567 |         if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
         |                                         ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:45:37: note: expanded from macro 'bitop'
      45 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
>> fs/nfs/fs_context.c:567:37: error: incomplete definition of type 'struct key'
     567 |         if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
         |                                         ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:46:16: note: expanded from macro 'bitop'
      46 |           (uintptr_t)(addr) != (uintptr_t)NULL &&                       \
         |                       ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
>> fs/nfs/fs_context.c:567:37: error: incomplete definition of type 'struct key'
     567 |         if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
         |                                         ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:47:50: note: expanded from macro 'bitop'
      47 |           __builtin_constant_p(*(const unsigned long *)(addr))) ?       \
         |                                                         ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
>> fs/nfs/fs_context.c:567:15: error: use of undeclared identifier 'KEY_FLAG_REVOKED'
     567 |         if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
         |                      ^
>> fs/nfs/fs_context.c:567:37: error: incomplete definition of type 'struct key'
     567 |         if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
         |                                         ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:48:17: note: expanded from macro 'bitop'
      48 |          const##op(nr, addr) : op(nr, addr))
         |                        ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
>> fs/nfs/fs_context.c:567:37: error: incomplete definition of type 'struct key'
     567 |         if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
         |                                         ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:48:32: note: expanded from macro 'bitop'
      48 |          const##op(nr, addr) : op(nr, addr))
         |                                       ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
>> fs/nfs/fs_context.c:567:15: error: use of undeclared identifier 'KEY_FLAG_REVOKED'
     567 |         if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
         |                      ^
>> fs/nfs/fs_context.c:567:15: error: use of undeclared identifier 'KEY_FLAG_REVOKED'
   fs/nfs/fs_context.c:568:41: error: incomplete definition of type 'struct key'
     568 |             test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
         |                                             ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:45:37: note: expanded from macro 'bitop'
      45 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
   fs/nfs/fs_context.c:568:41: error: incomplete definition of type 'struct key'
     568 |             test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
         |                                             ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:46:16: note: expanded from macro 'bitop'
      46 |           (uintptr_t)(addr) != (uintptr_t)NULL &&                       \
         |                       ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
   fs/nfs/fs_context.c:568:41: error: incomplete definition of type 'struct key'
     568 |             test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
         |                                             ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:47:50: note: expanded from macro 'bitop'
      47 |           __builtin_constant_p(*(const unsigned long *)(addr))) ?       \
         |                                                         ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
>> fs/nfs/fs_context.c:568:15: error: use of undeclared identifier 'KEY_FLAG_INVALIDATED'
     568 |             test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
         |                      ^
   fs/nfs/fs_context.c:568:41: error: incomplete definition of type 'struct key'
     568 |             test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
         |                                             ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:48:17: note: expanded from macro 'bitop'
      48 |          const##op(nr, addr) : op(nr, addr))
         |                        ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
   fs/nfs/fs_context.c:568:41: error: incomplete definition of type 'struct key'
     568 |             test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
         |                                             ~~~^
   include/linux/bitops.h:61:50: note: expanded from macro 'test_bit'
      61 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                                              ^~~~
   include/linux/bitops.h:48:32: note: expanded from macro 'bitop'
      48 |          const##op(nr, addr) : op(nr, addr))
         |                                       ^~~~
   include/linux/key.h:33:8: note: forward declaration of 'struct key'
      33 | struct key;
         |        ^
>> fs/nfs/fs_context.c:568:15: error: use of undeclared identifier 'KEY_FLAG_INVALIDATED'
     568 |             test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
         |                      ^
>> fs/nfs/fs_context.c:568:15: error: use of undeclared identifier 'KEY_FLAG_INVALIDATED'
   16 errors generated.


vim +567 fs/nfs/fs_context.c

   557	
   558	static int nfs_tls_key_verify(key_serial_t key_id)
   559	{
   560		struct key *key = key_lookup(key_id);
   561		int error = 0;
   562	
   563		if (IS_ERR(key)) {
   564			pr_err("key id %08x not found\n", key_id);
   565			return PTR_ERR(key);
   566		}
 > 567		if (test_bit(KEY_FLAG_REVOKED, &key->flags) ||
 > 568		    test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
   569			pr_err("key id %08x revoked\n", key_id);
   570			error = -EKEYREVOKED;
   571		}
   572	
   573		key_put(key);
   574		return error;
   575	}
   576	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

