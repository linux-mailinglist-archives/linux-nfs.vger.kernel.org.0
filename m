Return-Path: <linux-nfs+bounces-17031-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 267DCCB57ED
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 11:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7467E3013EAC
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 10:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4102FF676;
	Thu, 11 Dec 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0dGyY9l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65F22FD686;
	Thu, 11 Dec 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765448278; cv=none; b=LePyNoGRgRgHAuI8/YtWf6WbHmM+LmrHolKiOffkarhHNgirgU6+U8tgKAvU+9M3IB+Ovb4OKrP7JOjoXHFfSgwvwtSKynspPse8lXPmJ9MpWSvryDZ1xViGAhk4lJpqJpew+W3ufDclF/Bz+yjRVOK6rErkW1qKpgFPSbSoh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765448278; c=relaxed/simple;
	bh=U+gWkDuNiMhTlH/DnWuoVu3EFr3ns7aeV78BqpnNJoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6zsxcbg1SDRetWb+2D52RF/rCNfmTJMoCOXw+Dv3V0LWSs1XpQQ8mkYv3HmXgDgbSpfPnU7mT2/Kiohe9njdVBqNcJZgYQPpo0+fkUInVlry6mXw+z7DjugR8tmn0uaJXakZCU5c5JqhHCLoavS/1wBDvlh7ZRd1S70Uai7ZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0dGyY9l; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765448277; x=1796984277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U+gWkDuNiMhTlH/DnWuoVu3EFr3ns7aeV78BqpnNJoc=;
  b=I0dGyY9l61g2S8d7g5+e83w+t6GEq+jmWshCzbtR9itIVvyJmeKQZJFU
   dwLXLFJtysrRzvP1IO2Lwds7eEGrqGQo6a/mRkx/iuHsvThrQPklFLTCk
   2Ey8KFfpkK86YRORL6ut3Pqs+gtl5sUefER+rsVq+h9nm+c+WVIBl3iM3
   mbBQ4BiVGrBZbfoAjRBkIMFQdZ481/+M/0CpRl1UKQvqg4mXSy8Nm4qRp
   G/dARv1Jh6V7yWnEw9TEGq8JT0AiiADnJIZ48k1OS3sFyl5uwpFsRzVLx
   ktC1qm9wJrCuUqeO9dkJo9QIVDBYIyvJ33vORSr80RLx4FAFQreAIo2F3
   g==;
X-CSE-ConnectionGUID: fLbmTfeYRoqdmJMXO/Ijkw==
X-CSE-MsgGUID: D+lLnb/FS82RzqaIk0YHjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67313229"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="67313229"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 02:17:56 -0800
X-CSE-ConnectionGUID: xaqSbdJkSDuwASJeo9jtjw==
X-CSE-MsgGUID: SPGgn1BxTUWlSYeut3HCXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="197591204"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 11 Dec 2025 02:17:54 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTdk7-000000004Vp-1qpo;
	Thu, 11 Dec 2025 10:17:51 +0000
Date: Thu, 11 Dec 2025 18:17:35 +0800
From: kernel test robot <lkp@intel.com>
To: Pycode <pycode42@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Removed unused variable
Message-ID: <202512111818.jPAPY3vr-lkp@intel.com>
References: <aTnfSQJ4QsfwTSf0@raspberrypi>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTnfSQJ4QsfwTSf0@raspberrypi>

Hi Pycode,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.18 next-20251211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pycode/Removed-unused-variable/20251211-050134
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/aTnfSQJ4QsfwTSf0%40raspberrypi
patch subject: [PATCH] Removed unused variable
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20251211/202512111818.jPAPY3vr-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 6ec8c4351cfc1d0627d1633b02ea787bd29c77d8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251211/202512111818.jPAPY3vr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512111818.jPAPY3vr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:48: error: use of undeclared identifier 'ret'; did you mean 'net'?
     182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
         |                                                       ^~~
         |                                                       net
   include/linux/sunrpc/debug.h:25:28: note: expanded from macro 'dprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |                                   ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:42:26: note: expanded from macro 'dfprintk'
      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
         |                                        ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:34:57: note: expanded from macro '__sunrpc_printk'
      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
         |                                                             ^~~~~~~~~~~
   include/linux/kernel.h:276:26: note: expanded from macro 'trace_printk'
     276 |                 do_trace_printk(fmt, ##__VA_ARGS__);    \
         |                                        ^~~~~~~~~~~
   include/linux/kernel.h:287:37: note: expanded from macro 'do_trace_printk'
     287 |         __trace_printk_check_format(fmt, ##args);                       \
         |                                            ^~~~
   include/linux/kernel.h:239:40: note: expanded from macro '__trace_printk_check_format'
     239 |                 ____trace_printk_check_format(fmt, ##args);             \
         |                                                      ^~~~
   fs/nfs/flexfilelayout/flexfilelayoutdev.c:52:14: note: 'net' declared here
      52 |         struct net *net = server->nfs_client->cl_net;
         |                     ^
>> fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:48: warning: format specifies type 'int' but the argument has type 'struct net *' [-Wformat]
     182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
         |                                      ~~               ^~~
   include/linux/sunrpc/debug.h:25:28: note: expanded from macro 'dprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |                            ~~~    ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:42:26: note: expanded from macro 'dfprintk'
      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:34:57: note: expanded from macro '__sunrpc_printk'
      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
         |                                                      ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:276:26: note: expanded from macro 'trace_printk'
     276 |                 do_trace_printk(fmt, ##__VA_ARGS__);    \
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:287:37: note: expanded from macro 'do_trace_printk'
     287 |         __trace_printk_check_format(fmt, ##args);                       \
         |                                     ~~~    ^~~~
   include/linux/kernel.h:239:40: note: expanded from macro '__trace_printk_check_format'
     239 |                 ____trace_printk_check_format(fmt, ##args);             \
         |                                               ~~~    ^~~~
   fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:48: error: use of undeclared identifier 'ret'; did you mean 'net'?
     182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
         |                                                       ^~~
         |                                                       net
   include/linux/sunrpc/debug.h:25:28: note: expanded from macro 'dprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |                                   ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:42:26: note: expanded from macro 'dfprintk'
      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
         |                                        ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:34:57: note: expanded from macro '__sunrpc_printk'
      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
         |                                                             ^~~~~~~~~~~
   include/linux/kernel.h:276:26: note: expanded from macro 'trace_printk'
     276 |                 do_trace_printk(fmt, ##__VA_ARGS__);    \
         |                                        ^~~~~~~~~~~
   include/linux/kernel.h:290:50: note: expanded from macro 'do_trace_printk'
     290 |                 __trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);   \
         |                                                                ^~~~
   fs/nfs/flexfilelayout/flexfilelayoutdev.c:52:14: note: 'net' declared here
      52 |         struct net *net = server->nfs_client->cl_net;
         |                     ^
   fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:48: error: use of undeclared identifier 'ret'; did you mean 'net'?
     182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
         |                                                       ^~~
         |                                                       net
   include/linux/sunrpc/debug.h:25:28: note: expanded from macro 'dprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |                                   ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:42:26: note: expanded from macro 'dfprintk'
      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
         |                                        ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:34:57: note: expanded from macro '__sunrpc_printk'
      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
         |                                                             ^~~~~~~~~~~
   include/linux/kernel.h:276:26: note: expanded from macro 'trace_printk'
     276 |                 do_trace_printk(fmt, ##__VA_ARGS__);    \
         |                                        ^~~~~~~~~~~
   include/linux/kernel.h:292:36: note: expanded from macro 'do_trace_printk'
     292 |                 __trace_printk(_THIS_IP_, fmt, ##args);                 \
         |                                                  ^~~~
   fs/nfs/flexfilelayout/flexfilelayoutdev.c:52:14: note: 'net' declared here
      52 |         struct net *net = server->nfs_client->cl_net;
         |                     ^
>> fs/nfs/flexfilelayout/flexfilelayoutdev.c:182:48: warning: format specifies type 'int' but the argument has type 'struct net *' [-Wformat]
     182 |         dprintk("%s ERROR: returning %d\n", __func__, ret);
         |                                      ~~               ^~~
   include/linux/sunrpc/debug.h:25:28: note: expanded from macro 'dprintk'
      25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
         |                            ~~~    ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:42:26: note: expanded from macro 'dfprintk'
      42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/sunrpc/debug.h:34:57: note: expanded from macro '__sunrpc_printk'
      34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
         |                                                      ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:276:26: note: expanded from macro 'trace_printk'
     276 |                 do_trace_printk(fmt, ##__VA_ARGS__);    \
         |                                 ~~~    ^~~~~~~~~~~
   include/linux/kernel.h:292:36: note: expanded from macro 'do_trace_printk'
     292 |                 __trace_printk(_THIS_IP_, fmt, ##args);                 \
         |                                           ~~~    ^~~~
   2 warnings and 3 errors generated.


vim +182 fs/nfs/flexfilelayout/flexfilelayoutdev.c

d67ae825a59d63 Tom Haynes       2014-12-11   39  
d67ae825a59d63 Tom Haynes       2014-12-11   40  /* Decode opaque device data and construct new_ds using it */
d67ae825a59d63 Tom Haynes       2014-12-11   41  struct nfs4_ff_layout_ds *
d67ae825a59d63 Tom Haynes       2014-12-11   42  nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
d67ae825a59d63 Tom Haynes       2014-12-11   43  			    gfp_t gfp_flags)
d67ae825a59d63 Tom Haynes       2014-12-11   44  {
d67ae825a59d63 Tom Haynes       2014-12-11   45  	struct xdr_stream stream;
d67ae825a59d63 Tom Haynes       2014-12-11   46  	struct xdr_buf buf;
4b7c3b4c673d40 Anna Schumaker   2025-06-30   47  	struct folio *scratch;
d67ae825a59d63 Tom Haynes       2014-12-11   48  	struct list_head dsaddrs;
d67ae825a59d63 Tom Haynes       2014-12-11   49  	struct nfs4_pnfs_ds_addr *da;
d67ae825a59d63 Tom Haynes       2014-12-11   50  	struct nfs4_ff_layout_ds *new_ds = NULL;
d67ae825a59d63 Tom Haynes       2014-12-11   51  	struct nfs4_ff_ds_version *ds_versions = NULL;
6b9785dc8b13d9 Jeff Layton      2025-04-10   52  	struct net *net = server->nfs_client->cl_net;
d67ae825a59d63 Tom Haynes       2014-12-11   53  	u32 mp_count;
d67ae825a59d63 Tom Haynes       2014-12-11   54  	u32 version_count;
d67ae825a59d63 Tom Haynes       2014-12-11   55  	__be32 *p;
07df4d912b7c38 Pycode           2025-12-10   56  	int i = -ENOMEM;
d67ae825a59d63 Tom Haynes       2014-12-11   57  
d67ae825a59d63 Tom Haynes       2014-12-11   58  	/* set up xdr stream */
4b7c3b4c673d40 Anna Schumaker   2025-06-30   59  	scratch = folio_alloc(gfp_flags, 0);
d67ae825a59d63 Tom Haynes       2014-12-11   60  	if (!scratch)
d67ae825a59d63 Tom Haynes       2014-12-11   61  		goto out_err;
d67ae825a59d63 Tom Haynes       2014-12-11   62  
d67ae825a59d63 Tom Haynes       2014-12-11   63  	new_ds = kzalloc(sizeof(struct nfs4_ff_layout_ds), gfp_flags);
d67ae825a59d63 Tom Haynes       2014-12-11   64  	if (!new_ds)
d67ae825a59d63 Tom Haynes       2014-12-11   65  		goto out_scratch;
d67ae825a59d63 Tom Haynes       2014-12-11   66  
d67ae825a59d63 Tom Haynes       2014-12-11   67  	nfs4_init_deviceid_node(&new_ds->id_node,
d67ae825a59d63 Tom Haynes       2014-12-11   68  				server,
d67ae825a59d63 Tom Haynes       2014-12-11   69  				&pdev->dev_id);
d67ae825a59d63 Tom Haynes       2014-12-11   70  	INIT_LIST_HEAD(&dsaddrs);
d67ae825a59d63 Tom Haynes       2014-12-11   71  
d67ae825a59d63 Tom Haynes       2014-12-11   72  	xdr_init_decode_pages(&stream, &buf, pdev->pages, pdev->pglen);
4b7c3b4c673d40 Anna Schumaker   2025-06-30   73  	xdr_set_scratch_folio(&stream, scratch);
d67ae825a59d63 Tom Haynes       2014-12-11   74  
d67ae825a59d63 Tom Haynes       2014-12-11   75  	/* multipath count */
d67ae825a59d63 Tom Haynes       2014-12-11   76  	p = xdr_inline_decode(&stream, 4);
d67ae825a59d63 Tom Haynes       2014-12-11   77  	if (unlikely(!p))
d67ae825a59d63 Tom Haynes       2014-12-11   78  		goto out_err_drain_dsaddrs;
d67ae825a59d63 Tom Haynes       2014-12-11   79  	mp_count = be32_to_cpup(p);
d67ae825a59d63 Tom Haynes       2014-12-11   80  	dprintk("%s: multipath ds count %d\n", __func__, mp_count);
d67ae825a59d63 Tom Haynes       2014-12-11   81  
d67ae825a59d63 Tom Haynes       2014-12-11   82  	for (i = 0; i < mp_count; i++) {
d67ae825a59d63 Tom Haynes       2014-12-11   83  		/* multipath ds */
6b9785dc8b13d9 Jeff Layton      2025-04-10   84  		da = nfs4_decode_mp_ds_addr(net, &stream, gfp_flags);
d67ae825a59d63 Tom Haynes       2014-12-11   85  		if (da)
d67ae825a59d63 Tom Haynes       2014-12-11   86  			list_add_tail(&da->da_node, &dsaddrs);
d67ae825a59d63 Tom Haynes       2014-12-11   87  	}
d67ae825a59d63 Tom Haynes       2014-12-11   88  	if (list_empty(&dsaddrs)) {
d67ae825a59d63 Tom Haynes       2014-12-11   89  		dprintk("%s: no suitable DS addresses found\n",
d67ae825a59d63 Tom Haynes       2014-12-11   90  			__func__);
d67ae825a59d63 Tom Haynes       2014-12-11   91  		goto out_err_drain_dsaddrs;
d67ae825a59d63 Tom Haynes       2014-12-11   92  	}
d67ae825a59d63 Tom Haynes       2014-12-11   93  
d67ae825a59d63 Tom Haynes       2014-12-11   94  	/* version count */
d67ae825a59d63 Tom Haynes       2014-12-11   95  	p = xdr_inline_decode(&stream, 4);
d67ae825a59d63 Tom Haynes       2014-12-11   96  	if (unlikely(!p))
d67ae825a59d63 Tom Haynes       2014-12-11   97  		goto out_err_drain_dsaddrs;
d67ae825a59d63 Tom Haynes       2014-12-11   98  	version_count = be32_to_cpup(p);
d67ae825a59d63 Tom Haynes       2014-12-11   99  	dprintk("%s: version count %d\n", __func__, version_count);
d67ae825a59d63 Tom Haynes       2014-12-11  100  
6396bb221514d2 Kees Cook        2018-06-12  101  	ds_versions = kcalloc(version_count,
6396bb221514d2 Kees Cook        2018-06-12  102  			      sizeof(struct nfs4_ff_ds_version),
d67ae825a59d63 Tom Haynes       2014-12-11  103  			      gfp_flags);
d67ae825a59d63 Tom Haynes       2014-12-11  104  	if (!ds_versions)
d67ae825a59d63 Tom Haynes       2014-12-11  105  		goto out_scratch;
d67ae825a59d63 Tom Haynes       2014-12-11  106  
d67ae825a59d63 Tom Haynes       2014-12-11  107  	for (i = 0; i < version_count; i++) {
d67ae825a59d63 Tom Haynes       2014-12-11  108  		/* 20 = version(4) + minor_version(4) + rsize(4) + wsize(4) +
d67ae825a59d63 Tom Haynes       2014-12-11  109  		 * tightly_coupled(4) */
d67ae825a59d63 Tom Haynes       2014-12-11  110  		p = xdr_inline_decode(&stream, 20);
d67ae825a59d63 Tom Haynes       2014-12-11  111  		if (unlikely(!p))
d67ae825a59d63 Tom Haynes       2014-12-11  112  			goto out_err_drain_dsaddrs;
d67ae825a59d63 Tom Haynes       2014-12-11  113  		ds_versions[i].version = be32_to_cpup(p++);
d67ae825a59d63 Tom Haynes       2014-12-11  114  		ds_versions[i].minor_version = be32_to_cpup(p++);
940261a195080c Anna Schumaker   2022-06-17  115  		ds_versions[i].rsize = nfs_io_size(be32_to_cpup(p++),
940261a195080c Anna Schumaker   2022-06-17  116  						   server->nfs_client->cl_proto);
940261a195080c Anna Schumaker   2022-06-17  117  		ds_versions[i].wsize = nfs_io_size(be32_to_cpup(p++),
940261a195080c Anna Schumaker   2022-06-17  118  						   server->nfs_client->cl_proto);
d67ae825a59d63 Tom Haynes       2014-12-11  119  		ds_versions[i].tightly_coupled = be32_to_cpup(p);
d67ae825a59d63 Tom Haynes       2014-12-11  120  
d67ae825a59d63 Tom Haynes       2014-12-11  121  		if (ds_versions[i].rsize > NFS_MAX_FILE_IO_SIZE)
d67ae825a59d63 Tom Haynes       2014-12-11  122  			ds_versions[i].rsize = NFS_MAX_FILE_IO_SIZE;
d67ae825a59d63 Tom Haynes       2014-12-11  123  		if (ds_versions[i].wsize > NFS_MAX_FILE_IO_SIZE)
d67ae825a59d63 Tom Haynes       2014-12-11  124  			ds_versions[i].wsize = NFS_MAX_FILE_IO_SIZE;
d67ae825a59d63 Tom Haynes       2014-12-11  125  
a7878ca140084e Tigran Mkrtchyan 2017-04-04  126  		/*
a7878ca140084e Tigran Mkrtchyan 2017-04-04  127  		 * check for valid major/minor combination.
a7878ca140084e Tigran Mkrtchyan 2017-04-04  128  		 * currently we support dataserver which talk:
a7878ca140084e Tigran Mkrtchyan 2017-04-04  129  		 *   v3, v4.0, v4.1, v4.2
a7878ca140084e Tigran Mkrtchyan 2017-04-04  130  		 */
a7878ca140084e Tigran Mkrtchyan 2017-04-04  131  		if (!((ds_versions[i].version == 3 && ds_versions[i].minor_version == 0) ||
a7878ca140084e Tigran Mkrtchyan 2017-04-04  132  			(ds_versions[i].version == 4 && ds_versions[i].minor_version < 3))) {
d67ae825a59d63 Tom Haynes       2014-12-11  133  			dprintk("%s: [%d] unsupported ds version %d-%d\n", __func__,
d67ae825a59d63 Tom Haynes       2014-12-11  134  				i, ds_versions[i].version,
d67ae825a59d63 Tom Haynes       2014-12-11  135  				ds_versions[i].minor_version);
d67ae825a59d63 Tom Haynes       2014-12-11  136  			goto out_err_drain_dsaddrs;
d67ae825a59d63 Tom Haynes       2014-12-11  137  		}
d67ae825a59d63 Tom Haynes       2014-12-11  138  
d67ae825a59d63 Tom Haynes       2014-12-11  139  		dprintk("%s: [%d] vers %u minor_ver %u rsize %u wsize %u coupled %d\n",
d67ae825a59d63 Tom Haynes       2014-12-11  140  			__func__, i, ds_versions[i].version,
d67ae825a59d63 Tom Haynes       2014-12-11  141  			ds_versions[i].minor_version,
d67ae825a59d63 Tom Haynes       2014-12-11  142  			ds_versions[i].rsize,
d67ae825a59d63 Tom Haynes       2014-12-11  143  			ds_versions[i].wsize,
d67ae825a59d63 Tom Haynes       2014-12-11  144  			ds_versions[i].tightly_coupled);
d67ae825a59d63 Tom Haynes       2014-12-11  145  	}
d67ae825a59d63 Tom Haynes       2014-12-11  146  
d67ae825a59d63 Tom Haynes       2014-12-11  147  	new_ds->ds_versions = ds_versions;
d67ae825a59d63 Tom Haynes       2014-12-11  148  	new_ds->ds_versions_cnt = version_count;
d67ae825a59d63 Tom Haynes       2014-12-11  149  
6b9785dc8b13d9 Jeff Layton      2025-04-10  150  	new_ds->ds = nfs4_pnfs_ds_add(net, &dsaddrs, gfp_flags);
d67ae825a59d63 Tom Haynes       2014-12-11  151  	if (!new_ds->ds)
d67ae825a59d63 Tom Haynes       2014-12-11  152  		goto out_err_drain_dsaddrs;
d67ae825a59d63 Tom Haynes       2014-12-11  153  
d67ae825a59d63 Tom Haynes       2014-12-11  154  	/* If DS was already in cache, free ds addrs */
d67ae825a59d63 Tom Haynes       2014-12-11  155  	while (!list_empty(&dsaddrs)) {
d67ae825a59d63 Tom Haynes       2014-12-11  156  		da = list_first_entry(&dsaddrs,
d67ae825a59d63 Tom Haynes       2014-12-11  157  				      struct nfs4_pnfs_ds_addr,
d67ae825a59d63 Tom Haynes       2014-12-11  158  				      da_node);
d67ae825a59d63 Tom Haynes       2014-12-11  159  		list_del_init(&da->da_node);
d67ae825a59d63 Tom Haynes       2014-12-11  160  		kfree(da->da_remotestr);
d67ae825a59d63 Tom Haynes       2014-12-11  161  		kfree(da);
d67ae825a59d63 Tom Haynes       2014-12-11  162  	}
d67ae825a59d63 Tom Haynes       2014-12-11  163  
4b7c3b4c673d40 Anna Schumaker   2025-06-30  164  	folio_put(scratch);
d67ae825a59d63 Tom Haynes       2014-12-11  165  	return new_ds;
d67ae825a59d63 Tom Haynes       2014-12-11  166  
d67ae825a59d63 Tom Haynes       2014-12-11  167  out_err_drain_dsaddrs:
d67ae825a59d63 Tom Haynes       2014-12-11  168  	while (!list_empty(&dsaddrs)) {
d67ae825a59d63 Tom Haynes       2014-12-11  169  		da = list_first_entry(&dsaddrs, struct nfs4_pnfs_ds_addr,
d67ae825a59d63 Tom Haynes       2014-12-11  170  				      da_node);
d67ae825a59d63 Tom Haynes       2014-12-11  171  		list_del_init(&da->da_node);
d67ae825a59d63 Tom Haynes       2014-12-11  172  		kfree(da->da_remotestr);
d67ae825a59d63 Tom Haynes       2014-12-11  173  		kfree(da);
d67ae825a59d63 Tom Haynes       2014-12-11  174  	}
d67ae825a59d63 Tom Haynes       2014-12-11  175  
d67ae825a59d63 Tom Haynes       2014-12-11  176  	kfree(ds_versions);
d67ae825a59d63 Tom Haynes       2014-12-11  177  out_scratch:
4b7c3b4c673d40 Anna Schumaker   2025-06-30  178  	folio_put(scratch);
d67ae825a59d63 Tom Haynes       2014-12-11  179  out_err:
d67ae825a59d63 Tom Haynes       2014-12-11  180  	kfree(new_ds);
d67ae825a59d63 Tom Haynes       2014-12-11  181  
d67ae825a59d63 Tom Haynes       2014-12-11 @182  	dprintk("%s ERROR: returning %d\n", __func__, ret);
d67ae825a59d63 Tom Haynes       2014-12-11  183  	return NULL;
d67ae825a59d63 Tom Haynes       2014-12-11  184  }
d67ae825a59d63 Tom Haynes       2014-12-11  185  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

