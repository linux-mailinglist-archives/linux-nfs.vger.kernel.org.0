Return-Path: <linux-nfs+bounces-14070-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D296B45A24
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 16:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD587A2BD9
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD73680A9;
	Fri,  5 Sep 2025 14:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjinW2AM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15C13629AA;
	Fri,  5 Sep 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081548; cv=none; b=cOpIyu5yY5amXZ80unqaHEfXuvp4QUHnkRJ/U6TCRJeTTyydgXQS/3bo/RJF86+Osn0cmuqUtmUzRh8e9oCliX3imG17fSEFa1DfN1uVhiQMcJx+BxyIxOw/yGGRRRq+veFHS9j/Ew7N8CLEJR1MdOA8dfIoMQtnzQ0bqMS/7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081548; c=relaxed/simple;
	bh=d623E1liTi60iAjibtCqAAj0iSP9kDrLBmukVMoZ1bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjM9X/Ime8juQdzb/0xNyQRxJOj67G7dKvIjV+bG8nzXXsD+3WBn9N92CSp7+y84YC1QWMZR5v9rU3VM5e5JkIXCUVCPUZzhvDkz1+rI+HIjF+dH7Pk9YoBNyxamRjDnKex2QK7RLIxDnzb5WBBmuvcWOOolBHy0i3XxJvVJotQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjinW2AM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757081547; x=1788617547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d623E1liTi60iAjibtCqAAj0iSP9kDrLBmukVMoZ1bw=;
  b=SjinW2AMkl6n+hWtGWiJfjLUszTi95scFPJuHB6xC4N9NMhYIppFTEOD
   3QH+oUBAVvTaiTPNJOla4TARj+rCpgzwKPa83ZQwvIoyDNJbWvwOdoVRq
   RdVMHJReSCymw7NyRSyfntY4i3TGSf3xDfr+z9Z8cVDX6b6K4FcmyDiMX
   mt3tu+Fi1JrRDlIR0dzAnihx5yayBszH9aEi7zLlEvAqxhiZqKlzKwEX7
   dxA1thkRgsFs2sCuNwmLv1dBKlw0UO/Vu8UYadQ9XDzIu6zFyhobF6xRu
   QcUhJnAH1VD//86vmwnOuO4XkWorgX59aQAK7pOE7qriz4wTDcNWFjW1E
   A==;
X-CSE-ConnectionGUID: JTCJvgHKRc+ls2p+T2XNVg==
X-CSE-MsgGUID: 32uftZGBSJOmtlIh3NRn/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="62065757"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="62065757"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 07:12:26 -0700
X-CSE-ConnectionGUID: 9mM/JCghRqKBgJuUXE6PAQ==
X-CSE-MsgGUID: X78LcsnRTRWksMka9TIijg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="176511026"
Received: from lkp-server01.sh.intel.com (HELO 114d98da2b6c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 05 Sep 2025 07:12:22 -0700
Received: from kbuild by 114d98da2b6c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uuXAq-0000UZ-1Z;
	Fri, 05 Sep 2025 14:12:20 +0000
Date: Fri, 5 Sep 2025 22:11:58 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 2/7] net/handshake: Make handshake_req_cancel public
Message-ID: <202509052149.ChcoGfkh-lkp@intel.com>
References: <20250905024659.811386-3-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905024659.811386-3-alistair.francis@wdc.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on net/main net-next/main linus/master linux-nvme/for-next v6.17-rc4 next-20250905]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20250905-105201
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250905024659.811386-3-alistair.francis%40wdc.com
patch subject: [PATCH v2 2/7] net/handshake: Make handshake_req_cancel public
config: x86_64-randconfig-001-20250905 (https://download.01.org/0day-ci/archive/20250905/202509052149.ChcoGfkh-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250905/202509052149.ChcoGfkh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509052149.ChcoGfkh-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/handshake/handshake-test.c: In function 'handshake_req_submit_test4':
>> net/handshake/handshake-test.c:237:9: error: implicit declaration of function 'handshake_req_cancel'; did you mean 'handshake_req_next'? [-Werror=implicit-function-declaration]
     237 |         handshake_req_cancel(sock->sk);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         handshake_req_next
   cc1: some warnings being treated as errors


vim +237 net/handshake/handshake-test.c

88232ec1ec5ecf Chuck Lever 2023-04-17  207  
88232ec1ec5ecf Chuck Lever 2023-04-17  208  static void handshake_req_submit_test4(struct kunit *test)
88232ec1ec5ecf Chuck Lever 2023-04-17  209  {
88232ec1ec5ecf Chuck Lever 2023-04-17  210  	struct handshake_req *req, *result;
88232ec1ec5ecf Chuck Lever 2023-04-17  211  	struct socket *sock;
18c40a1cc1d990 Chuck Lever 2023-05-19  212  	struct file *filp;
88232ec1ec5ecf Chuck Lever 2023-04-17  213  	int err;
88232ec1ec5ecf Chuck Lever 2023-04-17  214  
88232ec1ec5ecf Chuck Lever 2023-04-17  215  	/* Arrange */
88232ec1ec5ecf Chuck Lever 2023-04-17  216  	req = handshake_req_alloc(&handshake_req_alloc_proto_good, GFP_KERNEL);
88232ec1ec5ecf Chuck Lever 2023-04-17  217  	KUNIT_ASSERT_NOT_NULL(test, req);
88232ec1ec5ecf Chuck Lever 2023-04-17  218  
88232ec1ec5ecf Chuck Lever 2023-04-17  219  	err = __sock_create(&init_net, PF_INET, SOCK_STREAM, IPPROTO_TCP,
88232ec1ec5ecf Chuck Lever 2023-04-17  220  			    &sock, 1);
88232ec1ec5ecf Chuck Lever 2023-04-17  221  	KUNIT_ASSERT_EQ(test, err, 0);
18c40a1cc1d990 Chuck Lever 2023-05-19  222  	filp = sock_alloc_file(sock, O_NONBLOCK, NULL);
18c40a1cc1d990 Chuck Lever 2023-05-19  223  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, filp);
88232ec1ec5ecf Chuck Lever 2023-04-17  224  	KUNIT_ASSERT_NOT_NULL(test, sock->sk);
18c40a1cc1d990 Chuck Lever 2023-05-19  225  	sock->file = filp;
88232ec1ec5ecf Chuck Lever 2023-04-17  226  
88232ec1ec5ecf Chuck Lever 2023-04-17  227  	err = handshake_req_submit(sock, req, GFP_KERNEL);
88232ec1ec5ecf Chuck Lever 2023-04-17  228  	KUNIT_ASSERT_EQ(test, err, 0);
88232ec1ec5ecf Chuck Lever 2023-04-17  229  
88232ec1ec5ecf Chuck Lever 2023-04-17  230  	/* Act */
88232ec1ec5ecf Chuck Lever 2023-04-17  231  	result = handshake_req_hash_lookup(sock->sk);
88232ec1ec5ecf Chuck Lever 2023-04-17  232  
88232ec1ec5ecf Chuck Lever 2023-04-17  233  	/* Assert */
88232ec1ec5ecf Chuck Lever 2023-04-17  234  	KUNIT_EXPECT_NOT_NULL(test, result);
88232ec1ec5ecf Chuck Lever 2023-04-17  235  	KUNIT_EXPECT_PTR_EQ(test, req, result);
88232ec1ec5ecf Chuck Lever 2023-04-17  236  
88232ec1ec5ecf Chuck Lever 2023-04-17 @237  	handshake_req_cancel(sock->sk);
4a0f07d71b0483 Jinjie Ruan 2023-09-19  238  	fput(filp);
88232ec1ec5ecf Chuck Lever 2023-04-17  239  }
88232ec1ec5ecf Chuck Lever 2023-04-17  240  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

