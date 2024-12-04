Return-Path: <linux-nfs+bounces-8342-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B59E39FC
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 13:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DCCDB24212
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539E1B0F1A;
	Wed,  4 Dec 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsAux2YV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DAA1B6CF9
	for <linux-nfs@vger.kernel.org>; Wed,  4 Dec 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315224; cv=none; b=NyDF+3MvGT9FxI+KNddFgpVb5pgFzJX9hG4uVLsb9UsOmJOz8F3sjychnd264ADVgn7oB//9NKexjzE2BdOHXz7Iw0SCAXSNSM9xcgQGBQpOX3yZWe+mIaZiday8py2UdzKMXKY+RvWR5iYqaa1duWkCuQSUFLCXdPGqSR5PmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315224; c=relaxed/simple;
	bh=LYYCIj0NL0rTx72/1sxRiv5FXsD1F+nydLeDSXsUxdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6+aG0Eq72bPNkBGA4FLX1g2u49MGK+hHsowyjrLS70NudVMfs6HYmS0k4TXTa0fjP5A5D0+/SyUq1Ic7Dz4l2CSDkxHFan7YCba7URXWhABEADGb0Y77gEuKPjD//td/FT3+JSMwYQigE15GcwJxazRVy4touFBec5rF7GhzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsAux2YV; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733315223; x=1764851223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LYYCIj0NL0rTx72/1sxRiv5FXsD1F+nydLeDSXsUxdI=;
  b=hsAux2YVjYKrVVZWEmbdX/DD0uwpudVVoyY9Om01HyQs0YDmB0tTeqvS
   xYxqyFHHsL6FZjAfNhbT3TjKs0eTlv6vgvRZrTvh6zJz+rr8Xe2dGtFkv
   tXaO9C+mVngxr7KQ443NLHemrW/SdG/ddl4ToFUQ0UdNf3UambK85eiZU
   aOuu11hSmNSzQQjtYnkKg5koDEXUSNA91ySc2KJWaOgbyg86dx1jrlqAb
   axgp+LwjhSRKxW4aVa5XqI9+ZCAXid48kj5B9g+v1IIZT7PuU3UEW6fOq
   /77DxiiPPntCdjfBItiuCoQynt+O1c0ovs95pNw+RJr335vt+/jNsGLDU
   g==;
X-CSE-ConnectionGUID: mAuak3izSCOBFC+Wqg2alQ==
X-CSE-MsgGUID: 7wqpp9YyTdqhwHwQnu8aRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44954194"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44954194"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:27:03 -0800
X-CSE-ConnectionGUID: 6gRbt8nvS6OfoB7VXbkZ5g==
X-CSE-MsgGUID: 3RyWak2fSx201/pQ5cSdfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93614813"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 04 Dec 2024 04:27:00 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIoT3-00030n-2v;
	Wed, 04 Dec 2024 12:26:57 +0000
Date: Wed, 4 Dec 2024 20:26:33 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Disseldorp <ddiss@suse.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFS: move _maxsz and _sz #defines to the function
 which they describe.
Message-ID: <202412042050.xy58M3zN-lkp@intel.com>
References: <20241204025703.2662394-3-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204025703.2662394-3-neilb@suse.de>

Hi NeilBrown,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.13-rc1 next-20241203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/NFS-fix-open_owner_id_maxsz-and-related-fields/20241204-124433
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20241204025703.2662394-3-neilb%40suse.de
patch subject: [PATCH 2/2] NFS: move _maxsz and _sz #defines to the function which they describe.
config: powerpc-linkstation_defconfig (https://download.01.org/0day-ci/archive/20241204/202412042050.xy58M3zN-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412042050.xy58M3zN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412042050.xy58M3zN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/nfs/nfs4xdr.c:40:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> fs/nfs/nfs4xdr.c:3040:9: warning: 'decode_sequence_maxsz' macro redefined [-Wmacro-redefined]
    3040 | #define decode_sequence_maxsz   (op_decode_hdr_maxsz + \
         |         ^
   fs/nfs/nfs4xdr.c:135:9: note: previous definition is here
     135 | #define decode_sequence_maxsz   0
         |         ^
>> fs/nfs/nfs4xdr.c:6068:9: warning: 'encode_sequence_maxsz' macro redefined [-Wmacro-redefined]
    6068 | #define encode_sequence_maxsz   (op_encode_hdr_maxsz + \
         |         ^
   fs/nfs/nfs4xdr.c:134:9: note: previous definition is here
     134 | #define encode_sequence_maxsz   0
         |         ^
   3 warnings generated.


vim +/decode_sequence_maxsz +3040 fs/nfs/nfs4xdr.c

  3039	
> 3040	#define decode_sequence_maxsz	(op_decode_hdr_maxsz + \
  3041					XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN) + 5)
  3042	static int decode_sequence(struct xdr_stream *xdr,
  3043				   struct nfs4_sequence_res *res,
  3044				   struct rpc_rqst *rqstp)
  3045	{
  3046	#if defined(CONFIG_NFS_V4_1)
  3047		struct nfs4_session *session;
  3048		struct nfs4_sessionid id;
  3049		u32 dummy;
  3050		int status;
  3051		__be32 *p;
  3052	
  3053		if (res->sr_slot == NULL)
  3054			return 0;
  3055		if (!res->sr_slot->table->session)
  3056			return 0;
  3057	
  3058		status = decode_op_hdr(xdr, OP_SEQUENCE);
  3059		if (!status)
  3060			status = decode_sessionid(xdr, &id);
  3061		if (unlikely(status))
  3062			goto out_err;
  3063	
  3064		/*
  3065		 * If the server returns different values for sessionID, slotID or
  3066		 * sequence number, the server is looney tunes.
  3067		 */
  3068		status = -EREMOTEIO;
  3069		session = res->sr_slot->table->session;
  3070	
  3071		if (memcmp(id.data, session->sess_id.data,
  3072			   NFS4_MAX_SESSIONID_LEN)) {
  3073			dprintk("%s Invalid session id\n", __func__);
  3074			goto out_err;
  3075		}
  3076	
  3077		p = xdr_inline_decode(xdr, 20);
  3078		if (unlikely(!p))
  3079			goto out_overflow;
  3080	
  3081		/* seqid */
  3082		dummy = be32_to_cpup(p++);
  3083		if (dummy != res->sr_slot->seq_nr) {
  3084			dprintk("%s Invalid sequence number\n", __func__);
  3085			goto out_err;
  3086		}
  3087		/* slot id */
  3088		dummy = be32_to_cpup(p++);
  3089		if (dummy != res->sr_slot->slot_nr) {
  3090			dprintk("%s Invalid slot id\n", __func__);
  3091			goto out_err;
  3092		}
  3093		/* highest slot id */
  3094		res->sr_highest_slotid = be32_to_cpup(p++);
  3095		/* target highest slot id */
  3096		res->sr_target_highest_slotid = be32_to_cpup(p++);
  3097		/* result flags */
  3098		res->sr_status_flags = be32_to_cpup(p);
  3099		status = 0;
  3100	out_err:
  3101		res->sr_status = status;
  3102		return status;
  3103	out_overflow:
  3104		status = -EIO;
  3105		goto out_err;
  3106	#else  /* CONFIG_NFS_V4_1 */
  3107		return 0;
  3108	#endif /* CONFIG_NFS_V4_1 */
  3109	}
  3110	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

