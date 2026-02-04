Return-Path: <linux-nfs+bounces-18694-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCslEyEfg2nWhwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18694-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 11:27:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3912E47B4
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 11:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC81530086C4
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414373DA7C6;
	Wed,  4 Feb 2026 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aY0nA+PG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11053D905F;
	Wed,  4 Feb 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200841; cv=none; b=llkAbeLCa+2H4OIpxKXorFJw8AdLTdW4Xblj7PO/eEd1/LMv/35J/DMA0OFqHJrAxD52rl9J4yupw2Bj8rrTJw+omgD8U7Bu+UTX+e9M8A9jKoClnEt2uYCsioZCpywLjx3nMFou81O5W8rK2vEgzeDtu1ylrU6bnScKBzvTHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200841; c=relaxed/simple;
	bh=JRuJQPv7aGONantzYfoKczNuuZ11CoKjZlMrKsbTBFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdpvtcD8b490hISZJSs5YJ/vnA4j7M+zL00INMfIjYzY+hpeZ6CydurMt41oHoRRPLqMWVAuL9I+Udgles/ExkHs69Kv2pCOWZ1Gd4/BwfqJY8W3+j3NDPfBMse3gS1zFHd4f3dd/mQEbYqfyJ/91I7CSZQQXX6DhwWKbYkY9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aY0nA+PG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770200841; x=1801736841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JRuJQPv7aGONantzYfoKczNuuZ11CoKjZlMrKsbTBFk=;
  b=aY0nA+PGWRpSb7iBKNVC2hNXKgySApxq9C5mUOfFRph+FYV8XDcVpnV9
   E9Z3ZPceqCflw9io1hUToD5z7a7mZ7G626WGGSq0V4NXbrWtE6voeDYG7
   AalZadeTto8fw5ksgT5pQFhFFB2pwN8f6/KNNHDttLTi7mxIBLV3bFSd9
   GaoVNKHsrF4ehIVjrU0prErd9LtrDA9xZkSMlP24T+EsetB+TKQqQFABU
   2ZkFJLEOyQjiRfnuYjymSfBqW+30vXAF3AiggRcSybb+BtLZQBpljwWcK
   JFKVA6+rr6V5h19vrtFq2Mm0mO/568V2d2Bualj2FXqwW/B99qFnajTC3
   g==;
X-CSE-ConnectionGUID: qSVT54T0TOuVAGgOHvhWog==
X-CSE-MsgGUID: jSMu27GRSs+0kJ8vm0Wnvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71289074"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71289074"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:27:20 -0800
X-CSE-ConnectionGUID: JMrX+m0kRKmijS8TxMkcxA==
X-CSE-MsgGUID: 2O+MoJj/RYOefVIj1fTogA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="247714930"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Feb 2026 02:27:16 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vna6M-00000000hgS-0LaR;
	Wed, 04 Feb 2026 10:27:14 +0000
Date: Wed, 4 Feb 2026 18:26:14 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] sunrpc: Fix compilation error (`make W=1`) when
 dprintk() is no-op
Message-ID: <202602041851.8AI0nchL-lkp@intel.com>
References: <20260204010415.2149607-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204010415.2149607-1-andriy.shevchenko@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[lists.linux.dev,redhat.com,oracle.com,talpey.com,kernel.org,gmail.com,google.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-18694-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3912E47B4
X-Rspamd-Action: no action

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on linus/master v6.19-rc8 next-20260203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/sunrpc-Fix-compilation-error-make-W-1-when-dprintk-is-no-op/20260204-091033
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260204010415.2149607-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op
config: powerpc-randconfig-r131-20260204 (https://download.01.org/0day-ci/archive/20260204/202602041851.8AI0nchL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260204/202602041851.8AI0nchL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602041851.8AI0nchL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/nfs/getroot.c:90:17: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/getroot.c:90:17: sparse:    void
   fs/nfs/getroot.c:90:17: sparse:    int
   fs/nfs/getroot.c:98:17: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/getroot.c:98:17: sparse:    void
   fs/nfs/getroot.c:98:17: sparse:    int
   fs/nfs/getroot.c:114:17: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/getroot.c:114:17: sparse:    void
   fs/nfs/getroot.c:114:17: sparse:    int
--
   fs/nfs/namespace.c:381:1: sparse: sparse: bad integer constant expression
   fs/nfs/namespace.c:381:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/namespace.c:382:1: sparse: sparse: bad integer constant expression
   fs/nfs/namespace.c:382:1: sparse: sparse: static assertion failed: "MODULE_INFO(parm, ...) contains embedded NUL byte"
>> fs/nfs/namespace.c:304:17: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/namespace.c:304:17: sparse:    void
   fs/nfs/namespace.c:304:17: sparse:    int
--
   fs/nfs/nfs4super.c:313:1: sparse: sparse: bad integer constant expression
   fs/nfs/nfs4super.c:313:1: sparse: sparse: static assertion failed: "MODULE_INFO(description, ...) contains embedded NUL byte"
   fs/nfs/nfs4super.c:314:1: sparse: sparse: bad integer constant expression
   fs/nfs/nfs4super.c:314:1: sparse: sparse: static assertion failed: "MODULE_INFO(file, ...) contains embedded NUL byte"
   fs/nfs/nfs4super.c:314:1: sparse: sparse: bad integer constant expression
   fs/nfs/nfs4super.c:314:1: sparse: sparse: static assertion failed: "MODULE_INFO(license, ...) contains embedded NUL byte"
>> fs/nfs/nfs4super.c:232:17: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/nfs4super.c:232:17: sparse:    void
   fs/nfs/nfs4super.c:232:17: sparse:    int
   fs/nfs/nfs4super.c:255:17: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/nfs4super.c:255:17: sparse:    void
   fs/nfs/nfs4super.c:255:17: sparse:    int
--
   fs/nfs/super.c:1436:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1436:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1437:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1437:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1438:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1438:1: sparse: sparse: static assertion failed: "MODULE_INFO(parm, ...) contains embedded NUL byte"
   fs/nfs/super.c:1440:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1440:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1441:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1441:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1442:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1442:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1444:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1444:1: sparse: sparse: static assertion failed: "MODULE_INFO(parm, ...) contains embedded NUL byte"
   fs/nfs/super.c:1446:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1446:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1447:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1447:1: sparse: sparse: static assertion failed: "MODULE_INFO(parm, ...) contains embedded NUL byte"
   fs/nfs/super.c:1449:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1449:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1450:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1450:1: sparse: sparse: static assertion failed: "MODULE_INFO(parm, ...) contains embedded NUL byte"
   fs/nfs/super.c:1452:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1452:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1453:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1453:1: sparse: sparse: static assertion failed: "MODULE_INFO(parm, ...) contains embedded NUL byte"
   fs/nfs/super.c:1455:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1455:1: sparse: sparse: static assertion failed: "MODULE_INFO(parm, ...) contains embedded NUL byte"
   fs/nfs/super.c:1457:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1457:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1458:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1458:1: sparse: sparse: static assertion failed: "MODULE_INFO(parm, ...) contains embedded NUL byte"
   fs/nfs/super.c:1462:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1462:1: sparse: sparse: static assertion failed: "MODULE_INFO(parmtype, ...) contains embedded NUL byte"
   fs/nfs/super.c:1463:1: sparse: sparse: bad integer constant expression
   fs/nfs/super.c:1463:1: sparse: sparse: static assertion failed: "MODULE_INFO(parm, ...) contains embedded NUL byte"
>> fs/nfs/super.c:1325:17: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/super.c:1325:17: sparse:    void
   fs/nfs/super.c:1325:17: sparse:    int
   fs/nfs/super.c:1351:17: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/super.c:1351:17: sparse:    void
   fs/nfs/super.c:1351:17: sparse:    int
--
   fs/nfs/fs_context.c:1773:1: sparse: sparse: bad integer constant expression
   fs/nfs/fs_context.c:1773:1: sparse: sparse: static assertion failed: "MODULE_INFO(alias, ...) contains embedded NUL byte"
   fs/nfs/fs_context.c:1785:1: sparse: sparse: bad integer constant expression
   fs/nfs/fs_context.c:1785:1: sparse: sparse: static assertion failed: "MODULE_INFO(alias, ...) contains embedded NUL byte"
   fs/nfs/fs_context.c:1786:1: sparse: sparse: bad integer constant expression
   fs/nfs/fs_context.c:1786:1: sparse: sparse: static assertion failed: "MODULE_INFO(alias, ...) contains embedded NUL byte"
>> fs/nfs/fs_context.c:1119:9: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/fs_context.c:1119:9: sparse:    void
   fs/nfs/fs_context.c:1119:9: sparse:    int
   fs/nfs/fs_context.c:1122:9: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/fs_context.c:1122:9: sparse:    void
   fs/nfs/fs_context.c:1122:9: sparse:    int
   fs/nfs/fs_context.c:1125:9: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/fs_context.c:1125:9: sparse:    void
   fs/nfs/fs_context.c:1125:9: sparse:    int
   fs/nfs/fs_context.c:1590:9: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/fs_context.c:1590:9: sparse:    void
   fs/nfs/fs_context.c:1590:9: sparse:    int
   fs/nfs/fs_context.c:1604:9: sparse: sparse: incompatible types in conditional expression (different base types):
   fs/nfs/fs_context.c:1604:9: sparse:    void
   fs/nfs/fs_context.c:1604:9: sparse:    int

vim +90 fs/nfs/getroot.c

b09b9417d074e0 Trond Myklebust 2007-10-25  63  
54ceac45159860 David Howells   2006-08-22  64  /*
6d26c5e4d83cd3 Li Lingfeng     2024-08-24  65   * get a root dentry from the root filehandle
54ceac45159860 David Howells   2006-08-22  66   */
62a55d088cd87d Scott Mayhew    2019-12-10  67  int nfs_get_root(struct super_block *s, struct fs_context *fc)
54ceac45159860 David Howells   2006-08-22  68  {
62a55d088cd87d Scott Mayhew    2019-12-10  69  	struct nfs_fs_context *ctx = nfs_fc2context(fc);
eae00c5d6e48cc Scott Mayhew    2021-06-22  70  	struct nfs_server *server = NFS_SB(s), *clone_server;
54ceac45159860 David Howells   2006-08-22  71  	struct nfs_fsinfo fsinfo;
62a55d088cd87d Scott Mayhew    2019-12-10  72  	struct dentry *root;
54ceac45159860 David Howells   2006-08-22  73  	struct inode *inode;
62a55d088cd87d Scott Mayhew    2019-12-10  74  	char *name;
62a55d088cd87d Scott Mayhew    2019-12-10  75  	int error = -ENOMEM;
779df6a5480f13 Scott Mayhew    2020-03-03  76  	unsigned long kflags = 0, kflags_out = 0;
54ceac45159860 David Howells   2006-08-22  77  
62a55d088cd87d Scott Mayhew    2019-12-10  78  	name = kstrdup(fc->source, GFP_KERNEL);
b1942c5f8cf3be Al Viro         2011-03-16  79  	if (!name)
62a55d088cd87d Scott Mayhew    2019-12-10  80  		goto out;
b1942c5f8cf3be Al Viro         2011-03-16  81  
54ceac45159860 David Howells   2006-08-22  82  	/* get the actual root for this mount */
d755ad8dc752d4 Anna Schumaker  2021-10-22  83  	fsinfo.fattr = nfs_alloc_fattr_with_label(server);
62a55d088cd87d Scott Mayhew    2019-12-10  84  	if (fsinfo.fattr == NULL)
62a55d088cd87d Scott Mayhew    2019-12-10  85  		goto out_name;
54ceac45159860 David Howells   2006-08-22  86  
62a55d088cd87d Scott Mayhew    2019-12-10  87  	error = server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, &fsinfo);
54ceac45159860 David Howells   2006-08-22  88  	if (error < 0) {
54ceac45159860 David Howells   2006-08-22  89  		dprintk("nfs_get_root: getattr error = %d\n", -error);
ce8866f0913ff1 Scott Mayhew    2019-12-10 @90  		nfs_errorf(fc, "NFS: Couldn't getattr on root");

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

