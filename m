Return-Path: <linux-nfs+bounces-8343-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36099E3CDB
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 15:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5401CB39B68
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Dec 2024 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00C1F8AD6;
	Wed,  4 Dec 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ej8G7Xci"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9701EE006
	for <linux-nfs@vger.kernel.org>; Wed,  4 Dec 2024 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321042; cv=none; b=bdxlvYTf6wcfa1YIpdEP7RzAmlBsRTNrPvnFUonOzecOmstFfXDDGVM3J/ybu6/4OI+My8AoANMnPCND0kag+GqgpdJ5RRzd3Eblu3+XQsoTNV6fjE87ehzXRwT+n4xzANtoYL/Bi5gbDjBBUxBzNSvRWodrrT0u1pzp0y6/d4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321042; c=relaxed/simple;
	bh=ps12D0bZwaHSb7xCO9IWU0B3C0hpC+lWqvNS9LburUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTpgLThIwJbJfA/ZCKPNTz7tjNpy3d9F6c0CuETsuOC/u1/2eJj8tWu4Sd1rDJJpfWlCh+5FuPLImJNtCpkqiaSDGb7R789SkhwZh5EscGagD2yhm/zWufDldMiQyopCZNIOu+ZN8P0Eh1Ki99UV8AbmVBwvOd0rgkQ1fVhitbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ej8G7Xci; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733321041; x=1764857041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ps12D0bZwaHSb7xCO9IWU0B3C0hpC+lWqvNS9LburUk=;
  b=ej8G7XcixhiHQU45JrnQWFal8RFp+q2VyA1OjZCH/tEr3m3CBEAsabfs
   vZXaw6fmOBxl/gtoKABGUsfK+W7RNT7u45eZ7TjC3L1b0q1AyPCOhS3BE
   JxRRFizi04lY8oB1amApJeUC+KAGdhq5ebdToMGRbfg+U+9W1pmgHsKBK
   Brc6bsroBsPiJ9Izj6EMZsYAvHWPCGzQ+ZIAodg0I1szl146PrhbR/hTc
   2CeVq4HnjpTapv6Ms8ixax/w9J9WwppbUG27z+rM/YDwFXLjtS0ENkOGm
   6Az0AKbPE6DvXUjAkGqmE8R0tyUi2p1118opQ2dTB22Oweb7JT96FAi83
   Q==;
X-CSE-ConnectionGUID: Q67cROpdTiuL8uSouB5zUw==
X-CSE-MsgGUID: Um8B6spMR+W0C5UpTDZCKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44617548"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44617548"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:03:59 -0800
X-CSE-ConnectionGUID: gjC+p+6jSOm3xsHwcCUIuA==
X-CSE-MsgGUID: ntkKCBwAQ+69Ytn2tRSSBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94600329"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Dec 2024 06:03:57 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIpys-00035B-24;
	Wed, 04 Dec 2024 14:03:54 +0000
Date: Wed, 4 Dec 2024 22:03:35 +0800
From: kernel test robot <lkp@intel.com>
To: NeilBrown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, David Disseldorp <ddiss@suse.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFS: move _maxsz and _sz #defines to the function
 which they describe.
Message-ID: <202412042135.z6hANLmp-lkp@intel.com>
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
config: x86_64-randconfig-161 (https://download.01.org/0day-ci/archive/20241204/202412042135.z6hANLmp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241204/202412042135.z6hANLmp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412042135.z6hANLmp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfs/nfs4xdr.c:3040: warning: "decode_sequence_maxsz" redefined
    3040 | #define decode_sequence_maxsz   (op_decode_hdr_maxsz + \
         | 
   fs/nfs/nfs4xdr.c:135: note: this is the location of the previous definition
     135 | #define decode_sequence_maxsz   0
         | 
>> fs/nfs/nfs4xdr.c:6068: warning: "encode_sequence_maxsz" redefined
    6068 | #define encode_sequence_maxsz   (op_encode_hdr_maxsz + \
         | 
   fs/nfs/nfs4xdr.c:134: note: this is the location of the previous definition
     134 | #define encode_sequence_maxsz   0
         | 


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

