Return-Path: <linux-nfs+bounces-11301-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06ACA9E5FC
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 03:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C3417717A
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Apr 2025 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABD378F3A;
	Mon, 28 Apr 2025 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRIVw3wL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFAE14F90
	for <linux-nfs@vger.kernel.org>; Mon, 28 Apr 2025 01:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745805222; cv=none; b=Vx2qmXuOsTUgMHydSCb3Io4dUvZ6JzykAl8NhwAuC5TMjrAPPVRno7A1Hv3EjDd1CeHkpDYBmr1tnX3H1kLO/T917D3MlNq4Q7I+t1wc9V5lk+MnA6cIwn+hOfOclF4qdAHHpg2bcmmBj/WAgsGYIE8qL5AkTL6GFKI9PSG2QYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745805222; c=relaxed/simple;
	bh=P8TorOk5myL/XVwjznZVA/KsJ4kW28jYflsXZJyX2f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3piFldgHRSqeDcU/bbqAW8QfkR9vbRCtJq935xsTwmzI+oa353QGc3ENW7LCFJT24ZqFDnszLV1Xxk83kq/4pvja4XFobALEa1rLGeZtKKOTGdrA7y0jdknxNE+QueU1XKb7sc0K7432eAqwZmj7STSg+sUeimWqpVQmhbdrDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRIVw3wL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745805221; x=1777341221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P8TorOk5myL/XVwjznZVA/KsJ4kW28jYflsXZJyX2f4=;
  b=GRIVw3wLcHpBzNzsdm8R7KXCJ7k9+ANdmCZsUutAE3x1STb7reGlznXR
   hPrYNEibXTTC7pVjtYKcMsJJR8Q/cNOyzIXncsuyE6C5TAWaS5R73FgF7
   XkF/eYTwhN+hsvVeOhMw1nT8/G1CuGeFoZXg5VJVG8qc/CpGMxCdosoPN
   NEn7/9ka3aNIt7GBO61MSDxhJ41YqhxrM3zEQSdzzD5fGliEi4B7sgdIV
   fouhXVYdxc0RkvYon2zLaut5UhkabIUXEV2tkFB8rgaARZ7yUYz6fYeNZ
   zOLdOvo5Kfv16fonwLSwxEaMUYbvklSUTycd69xv86jRfv9VIAXsAE2lz
   Q==;
X-CSE-ConnectionGUID: XtUh8haKT+61mekdDRpjVA==
X-CSE-MsgGUID: bljiGhA7SC60NSrNkN0EFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="47398650"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="47398650"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 18:53:41 -0700
X-CSE-ConnectionGUID: TsWwCYQwTh6wyHL3yHdWvQ==
X-CSE-MsgGUID: cPaMhLeZRCOAsgiy0SDahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133690933"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Apr 2025 18:53:38 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u9Dge-0006XJ-1f;
	Mon, 28 Apr 2025 01:53:36 +0000
Date: Mon, 28 Apr 2025 09:53:22 +0800
From: kernel test robot <lkp@intel.com>
To: trondmy@kernel.org, Anna Schumaker <anna@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFS: Avoid flushing data while holding directory locks
 in nfs_rename()
Message-ID: <202504280902.aKsSfRfW-lkp@intel.com>
References: <a804c54445a3f028007763e05285d765afcab0f9.1745794273.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a804c54445a3f028007763e05285d765afcab0f9.1745794273.git.trond.myklebust@hammerspace.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.15-rc3 next-20250424]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/trondmy-kernel-org/NFS-Avoid-flushing-data-while-holding-directory-locks-in-nfs_rename/20250428-070327
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/a804c54445a3f028007763e05285d765afcab0f9.1745794273.git.trond.myklebust%40hammerspace.com
patch subject: [PATCH] NFS: Avoid flushing data while holding directory locks in nfs_rename()
config: i386-buildonly-randconfig-004-20250428 (https://download.01.org/0day-ci/archive/20250428/202504280902.aKsSfRfW-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250428/202504280902.aKsSfRfW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504280902.aKsSfRfW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfs/client.c:1109:10: error: no member named 'fh_expire_type' in 'struct nfs_server'
    1109 |         server->fh_expire_type = NFS_FH_VOL_RENAME;
         |         ~~~~~~  ^
>> fs/nfs/client.c:1109:27: error: use of undeclared identifier 'NFS_FH_VOL_RENAME'
    1109 |         server->fh_expire_type = NFS_FH_VOL_RENAME;
         |                                  ^
   2 errors generated.
--
>> fs/nfs/dir.c:2686:14: error: no member named 'fh_expire_type' in 'struct nfs_server'
    2686 |         if (server->fh_expire_type & NFS_FH_RENAME_UNSAFE)
         |             ~~~~~~  ^
>> fs/nfs/dir.c:2686:31: error: use of undeclared identifier 'NFS_FH_RENAME_UNSAFE'
    2686 |         if (server->fh_expire_type & NFS_FH_RENAME_UNSAFE)
         |                                      ^
   fs/nfs/dir.c:2687:20: error: no member named 'fh_expire_type' in 'struct nfs_server'
    2687 |                 return !(server->fh_expire_type & NFS_FH_NOEXPIRE_WITH_OPEN);
         |                          ~~~~~~  ^
>> fs/nfs/dir.c:2687:37: error: use of undeclared identifier 'NFS_FH_NOEXPIRE_WITH_OPEN'
    2687 |                 return !(server->fh_expire_type & NFS_FH_NOEXPIRE_WITH_OPEN);
         |                                                   ^
   4 errors generated.


vim +1109 fs/nfs/client.c

  1067	
  1068	/*
  1069	 * Create a version 2 or 3 volume record
  1070	 * - keyed on server and FSID
  1071	 */
  1072	struct nfs_server *nfs_create_server(struct fs_context *fc)
  1073	{
  1074		struct nfs_fs_context *ctx = nfs_fc2context(fc);
  1075		struct nfs_server *server;
  1076		struct nfs_fattr *fattr;
  1077		int error;
  1078	
  1079		server = nfs_alloc_server();
  1080		if (!server)
  1081			return ERR_PTR(-ENOMEM);
  1082	
  1083		server->cred = get_cred(fc->cred);
  1084	
  1085		error = -ENOMEM;
  1086		fattr = nfs_alloc_fattr();
  1087		if (fattr == NULL)
  1088			goto error;
  1089	
  1090		/* Get a client representation */
  1091		error = nfs_init_server(server, fc);
  1092		if (error < 0)
  1093			goto error;
  1094	
  1095		/* Probe the root fh to retrieve its FSID */
  1096		error = nfs_probe_fsinfo(server, ctx->mntfh, fattr);
  1097		if (error < 0)
  1098			goto error;
  1099		if (server->nfs_client->rpc_ops->version == 3) {
  1100			if (server->namelen == 0 || server->namelen > NFS3_MAXNAMLEN)
  1101				server->namelen = NFS3_MAXNAMLEN;
  1102			if (!(ctx->flags & NFS_MOUNT_NORDIRPLUS))
  1103				server->caps |= NFS_CAP_READDIRPLUS;
  1104		} else {
  1105			if (server->namelen == 0 || server->namelen > NFS2_MAXNAMLEN)
  1106				server->namelen = NFS2_MAXNAMLEN;
  1107		}
  1108		/* Linux 'subtree_check' borkenness mandates this setting */
> 1109		server->fh_expire_type = NFS_FH_VOL_RENAME;
  1110	
  1111		if (!(fattr->valid & NFS_ATTR_FATTR)) {
  1112			error = ctx->nfs_mod->rpc_ops->getattr(server, ctx->mntfh,
  1113							       fattr, NULL);
  1114			if (error < 0) {
  1115				dprintk("nfs_create_server: getattr error = %d\n", -error);
  1116				goto error;
  1117			}
  1118		}
  1119		memcpy(&server->fsid, &fattr->fsid, sizeof(server->fsid));
  1120	
  1121		dprintk("Server FSID: %llx:%llx\n",
  1122			(unsigned long long) server->fsid.major,
  1123			(unsigned long long) server->fsid.minor);
  1124	
  1125		nfs_server_insert_lists(server);
  1126		server->mount_time = jiffies;
  1127		nfs_free_fattr(fattr);
  1128		return server;
  1129	
  1130	error:
  1131		nfs_free_fattr(fattr);
  1132		nfs_free_server(server);
  1133		return ERR_PTR(error);
  1134	}
  1135	EXPORT_SYMBOL_GPL(nfs_create_server);
  1136	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

