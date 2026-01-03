Return-Path: <linux-nfs+bounces-17409-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C654BCF02CD
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 17:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 038CD300C29B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 16:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1632165EA;
	Sat,  3 Jan 2026 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NGO6C6XH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71FD6FC5
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767457585; cv=none; b=CNPxNboz6TDnM6ZBptN6PL+CkmJUfjhT9exFdeBSFkiPSGuR5EPuO6wFBhpMzlnUM0alRsp6wW38WhVtNeSiLRWyz627rLTP+vKaL2bmfkyITSlENQ5B/BOGo6HeXY1m0IgKk4Pl3hxxGqpslF255VGYz3iF3iAXStI8JEOqHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767457585; c=relaxed/simple;
	bh=OWxOb6VTnRAAgbI2d9BeFgE9kL6fOd6E2WPvb6X/EsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mz7Eh53dRhTXi6GtYGPO6nbwsU7eTev8gxWxsVq8xITFsQs1A2aJiKfw1UFhhL8+iw6hq4myJ9jKyHOGVXkjW/qfoL/nSWyquShWgFtS79/KucyfztIlgpB18v6/bPRgLmvptEQsQhuxNWLQC8kbChD+XXkJpT8b1wL0jEh/Srw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NGO6C6XH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767457582; x=1798993582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OWxOb6VTnRAAgbI2d9BeFgE9kL6fOd6E2WPvb6X/EsE=;
  b=NGO6C6XHn0A41kQLc4RJipFSFJbAlccrKOFGg/GdfQz7iKpglTweXys7
   4OLOa/ezlPkgzBBqvivKpWSN/lrkYZZFeLc08sV3HpUWvxPp1bu7ZLYR9
   Awrccsft/AF6+L9vMzuYP+8RBDsIwp7eyawGp4D47krdlbW3Y6+bd2cnl
   zCbj0xz7Dq9M5PHe1uG1JxhQari+fhwMvJuctXePJE2s+YJzXPmbYoJwr
   lEbLUdIHJ7CLs4uuDCoBRVtbFieUp5Avb5HXcpgQkZGfuYuwIMpqFDpgw
   TyGTfb1yAmyRXKb2+/wLZYvlEaNXSIBKnQQRGF9COjpvh0econe6TL8MJ
   Q==;
X-CSE-ConnectionGUID: QMnsQM4NQeSDAIjyq/ppnw==
X-CSE-MsgGUID: 15nOkIuSSui+PItkXziNGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="68805906"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="68805906"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 08:26:21 -0800
X-CSE-ConnectionGUID: K1BT0t4VR6iqr50bA7RJig==
X-CSE-MsgGUID: QNAldfiQT+aaYDB82W4f6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="202493010"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 03 Jan 2026 08:26:19 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vc4SH-000000000jB-1TBA;
	Sat, 03 Jan 2026 16:26:17 +0000
Date: Sat, 3 Jan 2026 17:25:38 +0100
From: kernel test robot <lkp@intel.com>
To: rick.macklem@gmail.com, linux-nfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rick Macklem <rmacklem@uoguelph.ca>
Subject: Re: [PATCH v1 6/7] Set SB_POSIXACL if the server supports the
 extension
Message-ID: <202601031746.QiLqxADW-lkp@intel.com>
References: <20260102232934.1560-7-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102232934.1560-7-rick.macklem@gmail.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on v6.16-rc1 next-20251219]
[cannot apply to linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/rick-macklem-gmail-com/Add-entries-to-the-predefined-client-operations-enum/20260103-073239
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260102232934.1560-7-rick.macklem%40gmail.com
patch subject: [PATCH v1 6/7] Set SB_POSIXACL if the server supports the extension
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260103/202601031746.QiLqxADW-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260103/202601031746.QiLqxADW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601031746.QiLqxADW-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfs/super.c:1356:33: error: use of undeclared identifier 'FATTR4_WORD2_POSIX_DEFAULT_ACL'
    1356 |         if ((server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) &&
         |                                        ^
>> fs/nfs/super.c:1357:33: error: use of undeclared identifier 'FATTR4_WORD2_POSIX_ACCESS_ACL'
    1357 |             (server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL))
         |                                        ^
   2 errors generated.


vim +/FATTR4_WORD2_POSIX_DEFAULT_ACL +1356 fs/nfs/super.c

  1299	
  1300	int nfs_get_tree_common(struct fs_context *fc)
  1301	{
  1302		struct nfs_fs_context *ctx = nfs_fc2context(fc);
  1303		struct super_block *s;
  1304		int (*compare_super)(struct super_block *, struct fs_context *) = nfs_compare_super;
  1305		struct nfs_server *server = ctx->server;
  1306		int error;
  1307	
  1308		ctx->server = NULL;
  1309		if (IS_ERR(server))
  1310			return PTR_ERR(server);
  1311	
  1312		if (server->flags & NFS_MOUNT_UNSHARED)
  1313			compare_super = NULL;
  1314	
  1315		/* -o noac implies -o sync */
  1316		if (server->flags & NFS_MOUNT_NOAC)
  1317			fc->sb_flags |= SB_SYNCHRONOUS;
  1318	
  1319		/* Get a superblock - note that we may end up sharing one that already exists */
  1320		fc->s_fs_info = server;
  1321		s = sget_fc(fc, compare_super, nfs_set_super);
  1322		fc->s_fs_info = NULL;
  1323		if (IS_ERR(s)) {
  1324			error = PTR_ERR(s);
  1325			nfs_errorf(fc, "NFS: Couldn't get superblock");
  1326			goto out_err_nosb;
  1327		}
  1328	
  1329		if (s->s_fs_info != server) {
  1330			nfs_free_server(server);
  1331			server = NULL;
  1332		} else {
  1333			error = super_setup_bdi_name(s, "%u:%u", MAJOR(server->s_dev),
  1334						     MINOR(server->s_dev));
  1335			if (error)
  1336				goto error_splat_super;
  1337			s->s_bdi->io_pages = server->rpages;
  1338			server->super = s;
  1339		}
  1340	
  1341		if (!s->s_root) {
  1342			/* initial superblock/root creation */
  1343			nfs_fill_super(s, ctx);
  1344			error = nfs_get_cache_cookie(s, ctx);
  1345			if (error < 0)
  1346				goto error_splat_super;
  1347		}
  1348	
  1349		error = nfs_get_root(s, fc);
  1350		if (error < 0) {
  1351			nfs_errorf(fc, "NFS: Couldn't get root dentry");
  1352			goto error_splat_super;
  1353		}
  1354	
  1355		/* Set SB_POSIXACL if the server supports the NFSv4.2 extension. */
> 1356		if ((server->attr_bitmask[2] & FATTR4_WORD2_POSIX_DEFAULT_ACL) &&
> 1357		    (server->attr_bitmask[2] & FATTR4_WORD2_POSIX_ACCESS_ACL))
  1358			s->s_flags |= SB_POSIXACL;
  1359	
  1360		s->s_flags |= SB_ACTIVE;
  1361		error = 0;
  1362	
  1363	out:
  1364		return error;
  1365	
  1366	out_err_nosb:
  1367		nfs_free_server(server);
  1368		goto out;
  1369	error_splat_super:
  1370		deactivate_locked_super(s);
  1371		goto out;
  1372	}
  1373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

