Return-Path: <linux-nfs+bounces-10589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C41BDA5F7DC
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 15:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039BF3BF449
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Mar 2025 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056C5267B85;
	Thu, 13 Mar 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwVkRVgK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9497267B78
	for <linux-nfs@vger.kernel.org>; Thu, 13 Mar 2025 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875711; cv=none; b=ZEHo5vlfI+GpqD2sVvyMjEgcqiCycFJBDChhOWwlslNiGHWIKc8s+zxzYkUo2v/K/jW/OUXhkIPY9LzDXXs9hgA+Z6uxvn6VaxQffZ5zRarwbrXatut0SjSdTKTSOJAradYs3KIYu8l2ZLH2tfusY0LG/DBNJ80OnSF/ntznU8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875711; c=relaxed/simple;
	bh=OpYwmQPmrqlJTZZ6sU8LZ7L9FwnCsY6dvYTHXKnIMfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGMfaGk2kBFgqV2kOjBGqXFX2zG5Ux2peYIfNWjotndVbR7yyDtDT/L8hQEDA4uMLo5LUb5jYCuyL1mso6gJVnxpuJQXjUHggEejlYGqkBxX74mpDNLYQk9xIzZIt9e1FVjuslSL+j1T8gm/pXNc4OYGXMJAybEDO7z+gLVUIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwVkRVgK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741875710; x=1773411710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OpYwmQPmrqlJTZZ6sU8LZ7L9FwnCsY6dvYTHXKnIMfQ=;
  b=IwVkRVgKUo4gI4lBCmGv2LrOsaORHjKasFrRT39lsYR1gI8twKHUIcke
   5dxJ0jWwRXcf3+YSClSMmHq1h75qySrCHWiDuPB0u2851nxg292CRhGyp
   cB60A5IICuEr8zi3aIqW75CoRcg0Htw70Qo/I/qfL0krw596j7U9o1d4v
   mVoqTLoS5m87ILBR9ppox8sz2FjQnOpkHj2z+vRQkV2043D3Wp055YnPm
   3hgPXRE/l+WyzRxjqtwKxk4uUSTLU2+zlDLOMYt8K7Ri8jOecPAcSO20I
   6Rk47ImmzyiFCmJvfxqg3Oyvw9CHC/imyaQhT9LHcr5QorOAQYmWhjEfl
   Q==;
X-CSE-ConnectionGUID: pE5Hz5SvRC62ZXgE3sYKsA==
X-CSE-MsgGUID: oQvfiudgRye/hr7epSS7JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43173172"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43173172"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:21:49 -0700
X-CSE-ConnectionGUID: DA8+2EygTLKqTYIg6NYG4w==
X-CSE-MsgGUID: BvUfFDhXR2C8Qpi6peqVXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126026776"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 07:21:47 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsjRQ-0009Vg-32;
	Thu, 13 Mar 2025 14:21:44 +0000
Date: Thu, 13 Mar 2025 22:20:45 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFS: New mount option force_rdirplus
Message-ID: <202503132212.aPAVQklX-lkp@intel.com>
References: <4a471ab1bdea1052f45d894c967d0a6b6e38d4a6.1741806879.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a471ab1bdea1052f45d894c967d0a6b6e38d4a6.1741806879.git.bcodding@redhat.com>

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2408a807bfc3f738850ef5ad5e3fd59d66168996]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Coddington/NFS-New-mount-option-force_rdirplus/20250313-034816
base:   2408a807bfc3f738850ef5ad5e3fd59d66168996
patch link:    https://lore.kernel.org/r/4a471ab1bdea1052f45d894c967d0a6b6e38d4a6.1741806879.git.bcodding%40redhat.com
patch subject: [PATCH 1/1] NFS: New mount option force_rdirplus
config: i386-randconfig-003-20250313 (https://download.01.org/0day-ci/archive/20250313/202503132212.aPAVQklX-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250313/202503132212.aPAVQklX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503132212.aPAVQklX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfs/fs_context.c:642:19: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
     642 |                         if (ctx->flags && NFS_MOUNT_FORCE_RDIRPLUS)
         |                                        ^  ~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/fs_context.c:642:19: note: use '&' for a bitwise operation
     642 |                         if (ctx->flags && NFS_MOUNT_FORCE_RDIRPLUS)
         |                                        ^~
         |                                        &
   fs/nfs/fs_context.c:642:19: note: remove constant to silence this warning
     642 |                         if (ctx->flags && NFS_MOUNT_FORCE_RDIRPLUS)
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/fs_context.c:650:18: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
     650 |                 if (ctx->flags && NFS_MOUNT_NORDIRPLUS)
         |                                ^  ~~~~~~~~~~~~~~~~~~~~
   fs/nfs/fs_context.c:650:18: note: use '&' for a bitwise operation
     650 |                 if (ctx->flags && NFS_MOUNT_NORDIRPLUS)
         |                                ^~
         |                                &
   fs/nfs/fs_context.c:650:18: note: remove constant to silence this warning
     650 |                 if (ctx->flags && NFS_MOUNT_NORDIRPLUS)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.
--
>> fs/nfs/dir.c:669:29: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
     669 |         if (NFS_SERVER(dir)->flags && NFS_MOUNT_FORCE_RDIRPLUS)
         |                                    ^  ~~~~~~~~~~~~~~~~~~~~~~~~
   fs/nfs/dir.c:669:29: note: use '&' for a bitwise operation
     669 |         if (NFS_SERVER(dir)->flags && NFS_MOUNT_FORCE_RDIRPLUS)
         |                                    ^~
         |                                    &
   fs/nfs/dir.c:669:29: note: remove constant to silence this warning
     669 |         if (NFS_SERVER(dir)->flags && NFS_MOUNT_FORCE_RDIRPLUS)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +642 fs/nfs/fs_context.c

   529	
   530	/*
   531	 * Parse a single mount parameter.
   532	 */
   533	static int nfs_fs_context_parse_param(struct fs_context *fc,
   534					      struct fs_parameter *param)
   535	{
   536		struct fs_parse_result result;
   537		struct nfs_fs_context *ctx = nfs_fc2context(fc);
   538		unsigned short protofamily, mountfamily;
   539		unsigned int len;
   540		int ret, opt;
   541	
   542		trace_nfs_mount_option(param);
   543	
   544		opt = fs_parse(fc, nfs_fs_parameters, param, &result);
   545		if (opt < 0)
   546			return (opt == -ENOPARAM && ctx->sloppy) ? 1 : opt;
   547	
   548		if (fc->security)
   549			ctx->has_sec_mnt_opts = 1;
   550	
   551		switch (opt) {
   552		case Opt_source:
   553			if (fc->source)
   554				return nfs_invalf(fc, "NFS: Multiple sources not supported");
   555			fc->source = param->string;
   556			param->string = NULL;
   557			break;
   558	
   559			/*
   560			 * boolean options:  foo/nofoo
   561			 */
   562		case Opt_soft:
   563			ctx->flags |= NFS_MOUNT_SOFT;
   564			ctx->flags &= ~NFS_MOUNT_SOFTERR;
   565			break;
   566		case Opt_softerr:
   567			ctx->flags |= NFS_MOUNT_SOFTERR | NFS_MOUNT_SOFTREVAL;
   568			ctx->flags &= ~NFS_MOUNT_SOFT;
   569			break;
   570		case Opt_hard:
   571			ctx->flags &= ~(NFS_MOUNT_SOFT |
   572					NFS_MOUNT_SOFTERR |
   573					NFS_MOUNT_SOFTREVAL);
   574			break;
   575		case Opt_softreval:
   576			if (result.negated)
   577				ctx->flags &= ~NFS_MOUNT_SOFTREVAL;
   578			else
   579				ctx->flags |= NFS_MOUNT_SOFTREVAL;
   580			break;
   581		case Opt_posix:
   582			if (result.negated)
   583				ctx->flags &= ~NFS_MOUNT_POSIX;
   584			else
   585				ctx->flags |= NFS_MOUNT_POSIX;
   586			break;
   587		case Opt_cto:
   588			if (result.negated)
   589				ctx->flags |= NFS_MOUNT_NOCTO;
   590			else
   591				ctx->flags &= ~NFS_MOUNT_NOCTO;
   592			break;
   593		case Opt_trunkdiscovery:
   594			if (result.negated)
   595				ctx->flags &= ~NFS_MOUNT_TRUNK_DISCOVERY;
   596			else
   597				ctx->flags |= NFS_MOUNT_TRUNK_DISCOVERY;
   598			break;
   599		case Opt_alignwrite:
   600			if (result.negated)
   601				ctx->flags |= NFS_MOUNT_NO_ALIGNWRITE;
   602			else
   603				ctx->flags &= ~NFS_MOUNT_NO_ALIGNWRITE;
   604			break;
   605		case Opt_ac:
   606			if (result.negated)
   607				ctx->flags |= NFS_MOUNT_NOAC;
   608			else
   609				ctx->flags &= ~NFS_MOUNT_NOAC;
   610			break;
   611		case Opt_lock:
   612			if (result.negated) {
   613				ctx->lock_status = NFS_LOCK_NOLOCK;
   614				ctx->flags |= NFS_MOUNT_NONLM;
   615				ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
   616			} else {
   617				ctx->lock_status = NFS_LOCK_LOCK;
   618				ctx->flags &= ~NFS_MOUNT_NONLM;
   619				ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK | NFS_MOUNT_LOCAL_FCNTL);
   620			}
   621			break;
   622		case Opt_udp:
   623			ctx->flags &= ~NFS_MOUNT_TCP;
   624			ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
   625			break;
   626		case Opt_tcp:
   627		case Opt_rdma:
   628			ctx->flags |= NFS_MOUNT_TCP; /* for side protocols */
   629			ret = xprt_find_transport_ident(param->key);
   630			if (ret < 0)
   631				goto out_bad_transport;
   632			ctx->nfs_server.protocol = ret;
   633			break;
   634		case Opt_acl:
   635			if (result.negated)
   636				ctx->flags |= NFS_MOUNT_NOACL;
   637			else
   638				ctx->flags &= ~NFS_MOUNT_NOACL;
   639			break;
   640		case Opt_rdirplus:
   641			if (result.negated) {
 > 642				if (ctx->flags && NFS_MOUNT_FORCE_RDIRPLUS)
   643					return nfs_invalf(fc, "NFS: Cannot both force and disable READDIR PLUS");
   644				ctx->flags |= NFS_MOUNT_NORDIRPLUS;
   645			} else {
   646				ctx->flags &= ~NFS_MOUNT_NORDIRPLUS;
   647			}
   648			break;
   649		case Opt_force_rdirplus:
   650			if (ctx->flags && NFS_MOUNT_NORDIRPLUS)
   651				return nfs_invalf(fc, "NFS: Cannot both force and disable READDIR PLUS");
   652			ctx->flags |= NFS_MOUNT_FORCE_RDIRPLUS;
   653			break;
   654		case Opt_sharecache:
   655			if (result.negated)
   656				ctx->flags |= NFS_MOUNT_UNSHARED;
   657			else
   658				ctx->flags &= ~NFS_MOUNT_UNSHARED;
   659			break;
   660		case Opt_resvport:
   661			if (result.negated)
   662				ctx->flags |= NFS_MOUNT_NORESVPORT;
   663			else
   664				ctx->flags &= ~NFS_MOUNT_NORESVPORT;
   665			break;
   666		case Opt_fscache_flag:
   667			if (result.negated)
   668				ctx->options &= ~NFS_OPTION_FSCACHE;
   669			else
   670				ctx->options |= NFS_OPTION_FSCACHE;
   671			kfree(ctx->fscache_uniq);
   672			ctx->fscache_uniq = NULL;
   673			break;
   674		case Opt_fscache:
   675			trace_nfs_mount_assign(param->key, param->string);
   676			ctx->options |= NFS_OPTION_FSCACHE;
   677			kfree(ctx->fscache_uniq);
   678			ctx->fscache_uniq = param->string;
   679			param->string = NULL;
   680			break;
   681		case Opt_migration:
   682			if (result.negated)
   683				ctx->options &= ~NFS_OPTION_MIGRATION;
   684			else
   685				ctx->options |= NFS_OPTION_MIGRATION;
   686			break;
   687	
   688			/*
   689			 * options that take numeric values
   690			 */
   691		case Opt_port:
   692			if (result.uint_32 > USHRT_MAX)
   693				goto out_of_bounds;
   694			ctx->nfs_server.port = result.uint_32;
   695			break;
   696		case Opt_rsize:
   697			ctx->rsize = result.uint_32;
   698			break;
   699		case Opt_wsize:
   700			ctx->wsize = result.uint_32;
   701			break;
   702		case Opt_bsize:
   703			ctx->bsize = result.uint_32;
   704			break;
   705		case Opt_timeo:
   706			if (result.uint_32 < 1 || result.uint_32 > INT_MAX)
   707				goto out_of_bounds;
   708			ctx->timeo = result.uint_32;
   709			break;
   710		case Opt_retrans:
   711			if (result.uint_32 > INT_MAX)
   712				goto out_of_bounds;
   713			ctx->retrans = result.uint_32;
   714			break;
   715		case Opt_acregmin:
   716			ctx->acregmin = result.uint_32;
   717			break;
   718		case Opt_acregmax:
   719			ctx->acregmax = result.uint_32;
   720			break;
   721		case Opt_acdirmin:
   722			ctx->acdirmin = result.uint_32;
   723			break;
   724		case Opt_acdirmax:
   725			ctx->acdirmax = result.uint_32;
   726			break;
   727		case Opt_actimeo:
   728			ctx->acregmin = result.uint_32;
   729			ctx->acregmax = result.uint_32;
   730			ctx->acdirmin = result.uint_32;
   731			ctx->acdirmax = result.uint_32;
   732			break;
   733		case Opt_namelen:
   734			ctx->namlen = result.uint_32;
   735			break;
   736		case Opt_mountport:
   737			if (result.uint_32 > USHRT_MAX)
   738				goto out_of_bounds;
   739			ctx->mount_server.port = result.uint_32;
   740			break;
   741		case Opt_mountvers:
   742			if (result.uint_32 < NFS_MNT_VERSION ||
   743			    result.uint_32 > NFS_MNT3_VERSION)
   744				goto out_of_bounds;
   745			ctx->mount_server.version = result.uint_32;
   746			break;
   747		case Opt_minorversion:
   748			if (result.uint_32 > NFS4_MAX_MINOR_VERSION)
   749				goto out_of_bounds;
   750			ctx->minorversion = result.uint_32;
   751			break;
   752	
   753			/*
   754			 * options that take text values
   755			 */
   756		case Opt_v:
   757			ret = nfs_parse_version_string(fc, param->key + 1);
   758			if (ret < 0)
   759				return ret;
   760			break;
   761		case Opt_vers:
   762			if (!param->string)
   763				goto out_invalid_value;
   764			trace_nfs_mount_assign(param->key, param->string);
   765			ret = nfs_parse_version_string(fc, param->string);
   766			if (ret < 0)
   767				return ret;
   768			break;
   769		case Opt_sec:
   770			ret = nfs_parse_security_flavors(fc, param);
   771			if (ret < 0)
   772				return ret;
   773			break;
   774		case Opt_xprtsec:
   775			ret = nfs_parse_xprtsec_policy(fc, param);
   776			if (ret < 0)
   777				return ret;
   778			break;
   779	
   780		case Opt_proto:
   781			if (!param->string)
   782				goto out_invalid_value;
   783			trace_nfs_mount_assign(param->key, param->string);
   784			protofamily = AF_INET;
   785			switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
   786			case Opt_xprt_udp6:
   787				protofamily = AF_INET6;
   788				fallthrough;
   789			case Opt_xprt_udp:
   790				ctx->flags &= ~NFS_MOUNT_TCP;
   791				ctx->nfs_server.protocol = XPRT_TRANSPORT_UDP;
   792				break;
   793			case Opt_xprt_tcp6:
   794				protofamily = AF_INET6;
   795				fallthrough;
   796			case Opt_xprt_tcp:
   797				ctx->flags |= NFS_MOUNT_TCP;
   798				ctx->nfs_server.protocol = XPRT_TRANSPORT_TCP;
   799				break;
   800			case Opt_xprt_rdma6:
   801				protofamily = AF_INET6;
   802				fallthrough;
   803			case Opt_xprt_rdma:
   804				/* vector side protocols to TCP */
   805				ctx->flags |= NFS_MOUNT_TCP;
   806				ret = xprt_find_transport_ident(param->string);
   807				if (ret < 0)
   808					goto out_bad_transport;
   809				ctx->nfs_server.protocol = ret;
   810				break;
   811			default:
   812				goto out_bad_transport;
   813			}
   814	
   815			ctx->protofamily = protofamily;
   816			break;
   817	
   818		case Opt_mountproto:
   819			if (!param->string)
   820				goto out_invalid_value;
   821			trace_nfs_mount_assign(param->key, param->string);
   822			mountfamily = AF_INET;
   823			switch (lookup_constant(nfs_xprt_protocol_tokens, param->string, -1)) {
   824			case Opt_xprt_udp6:
   825				mountfamily = AF_INET6;
   826				fallthrough;
   827			case Opt_xprt_udp:
   828				ctx->mount_server.protocol = XPRT_TRANSPORT_UDP;
   829				break;
   830			case Opt_xprt_tcp6:
   831				mountfamily = AF_INET6;
   832				fallthrough;
   833			case Opt_xprt_tcp:
   834				ctx->mount_server.protocol = XPRT_TRANSPORT_TCP;
   835				break;
   836			case Opt_xprt_rdma: /* not used for side protocols */
   837			default:
   838				goto out_bad_transport;
   839			}
   840			ctx->mountfamily = mountfamily;
   841			break;
   842	
   843		case Opt_addr:
   844			trace_nfs_mount_assign(param->key, param->string);
   845			len = rpc_pton(fc->net_ns, param->string, param->size,
   846				       &ctx->nfs_server.address,
   847				       sizeof(ctx->nfs_server._address));
   848			if (len == 0)
   849				goto out_invalid_address;
   850			ctx->nfs_server.addrlen = len;
   851			break;
   852		case Opt_clientaddr:
   853			trace_nfs_mount_assign(param->key, param->string);
   854			kfree(ctx->client_address);
   855			ctx->client_address = param->string;
   856			param->string = NULL;
   857			break;
   858		case Opt_mounthost:
   859			trace_nfs_mount_assign(param->key, param->string);
   860			kfree(ctx->mount_server.hostname);
   861			ctx->mount_server.hostname = param->string;
   862			param->string = NULL;
   863			break;
   864		case Opt_mountaddr:
   865			trace_nfs_mount_assign(param->key, param->string);
   866			len = rpc_pton(fc->net_ns, param->string, param->size,
   867				       &ctx->mount_server.address,
   868				       sizeof(ctx->mount_server._address));
   869			if (len == 0)
   870				goto out_invalid_address;
   871			ctx->mount_server.addrlen = len;
   872			break;
   873		case Opt_nconnect:
   874			trace_nfs_mount_assign(param->key, param->string);
   875			if (result.uint_32 < 1 || result.uint_32 > NFS_MAX_CONNECTIONS)
   876				goto out_of_bounds;
   877			ctx->nfs_server.nconnect = result.uint_32;
   878			break;
   879		case Opt_max_connect:
   880			trace_nfs_mount_assign(param->key, param->string);
   881			if (result.uint_32 < 1 || result.uint_32 > NFS_MAX_TRANSPORTS)
   882				goto out_of_bounds;
   883			ctx->nfs_server.max_connect = result.uint_32;
   884			break;
   885		case Opt_lookupcache:
   886			trace_nfs_mount_assign(param->key, param->string);
   887			switch (result.uint_32) {
   888			case Opt_lookupcache_all:
   889				ctx->flags &= ~(NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE);
   890				break;
   891			case Opt_lookupcache_positive:
   892				ctx->flags &= ~NFS_MOUNT_LOOKUP_CACHE_NONE;
   893				ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG;
   894				break;
   895			case Opt_lookupcache_none:
   896				ctx->flags |= NFS_MOUNT_LOOKUP_CACHE_NONEG|NFS_MOUNT_LOOKUP_CACHE_NONE;
   897				break;
   898			default:
   899				goto out_invalid_value;
   900			}
   901			break;
   902		case Opt_local_lock:
   903			trace_nfs_mount_assign(param->key, param->string);
   904			switch (result.uint_32) {
   905			case Opt_local_lock_all:
   906				ctx->flags |= (NFS_MOUNT_LOCAL_FLOCK |
   907					       NFS_MOUNT_LOCAL_FCNTL);
   908				break;
   909			case Opt_local_lock_flock:
   910				ctx->flags |= NFS_MOUNT_LOCAL_FLOCK;
   911				break;
   912			case Opt_local_lock_posix:
   913				ctx->flags |= NFS_MOUNT_LOCAL_FCNTL;
   914				break;
   915			case Opt_local_lock_none:
   916				ctx->flags &= ~(NFS_MOUNT_LOCAL_FLOCK |
   917						NFS_MOUNT_LOCAL_FCNTL);
   918				break;
   919			default:
   920				goto out_invalid_value;
   921			}
   922			break;
   923		case Opt_write:
   924			trace_nfs_mount_assign(param->key, param->string);
   925			switch (result.uint_32) {
   926			case Opt_write_lazy:
   927				ctx->flags &=
   928					~(NFS_MOUNT_WRITE_EAGER | NFS_MOUNT_WRITE_WAIT);
   929				break;
   930			case Opt_write_eager:
   931				ctx->flags |= NFS_MOUNT_WRITE_EAGER;
   932				ctx->flags &= ~NFS_MOUNT_WRITE_WAIT;
   933				break;
   934			case Opt_write_wait:
   935				ctx->flags |=
   936					NFS_MOUNT_WRITE_EAGER | NFS_MOUNT_WRITE_WAIT;
   937				break;
   938			default:
   939				goto out_invalid_value;
   940			}
   941			break;
   942	
   943			/*
   944			 * Special options
   945			 */
   946		case Opt_sloppy:
   947			ctx->sloppy = true;
   948			break;
   949		}
   950	
   951		return 0;
   952	
   953	out_invalid_value:
   954		return nfs_invalf(fc, "NFS: Bad mount option value specified");
   955	out_invalid_address:
   956		return nfs_invalf(fc, "NFS: Bad IP address specified");
   957	out_of_bounds:
   958		return nfs_invalf(fc, "NFS: Value for '%s' out of range", param->key);
   959	out_bad_transport:
   960		return nfs_invalf(fc, "NFS: Unrecognized transport protocol");
   961	}
   962	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

