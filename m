Return-Path: <linux-nfs+bounces-13124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89A7B0841B
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 06:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C77BA856
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 04:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C062B202997;
	Thu, 17 Jul 2025 04:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTKbb0pp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1BF2556E
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 04:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752726926; cv=none; b=eJlXearwMqkhmm9PueObtSzAx9tBoN+6FL4db3WOpxH9cRgaaiM/R8NyaaAZAXKgfRHkbQXl7PKC1YM7wxRbFltaCtZDQBpl2sa2sCJdOwQnSz1P/7GvbIyanVV46hIUS4LjhNeG2CWusIyIk8C0yM1W7d8GR3DtCasY3aYZ3+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752726926; c=relaxed/simple;
	bh=Y+GBUNYoFmTj3TRd9W9ZVegJYdDmPDpwQ7FrxZnbxTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbW173suRjIbil89OZLvrV6cJCTOBC5V+1Uqay+Rf7+JPucHJ/TMPoz3bOEUf4Gc99lO7ulYVUT4bJ8SQ11NTKe7H57nVLp9nTuBBRUS4rrONJjQ5hJfGm//F0ivQDlgE7JSA2zIE3H5HajdXLALjJkoYHgiaVQFi1mms6pqiQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTKbb0pp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752726926; x=1784262926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y+GBUNYoFmTj3TRd9W9ZVegJYdDmPDpwQ7FrxZnbxTg=;
  b=WTKbb0ppLH6uupJ/elP4CJ9KHBKxT5SmpXAX7ue6V0hIFkSYLqB5f8c2
   3ptRtzIbu0horZVcJwaDwcbBv0w9qEbIc4Q5RRDQf84nvrW5gHSAnqQKO
   Ikw4DlzEEGI5XQSCs2+8knqGBpOpKvMlioX1vuY+TFDZsuJGqcl5J8tjU
   AkECnz6lsvpHXtnCfzXNIBJLMbVO95mcQQx3nJRf7I3qXJD8eTIU3P9oW
   11Hz1a+X2dNXqToZpt77ytQg3I8QqzHB/PGMbKu/BLMbRq+ahuWhJEfzZ
   MBuAw4RHJh/ShD2ncZzGPrpu0ij5oOCfE5oTtcAKFoSpTwVfeoD/yRL+v
   A==;
X-CSE-ConnectionGUID: +x61Koy2RcCCsHRch1kX7A==
X-CSE-MsgGUID: oOwQLlj5RKeZEV6Xz/NAeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58657219"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="58657219"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 21:35:26 -0700
X-CSE-ConnectionGUID: Je1JB7WrSSqDRS1vZcfHkA==
X-CSE-MsgGUID: TJoyXuxaStKR0QRoE1Tzkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="158392716"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 16 Jul 2025 21:35:23 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucGL2-000D9P-2j;
	Thu, 17 Jul 2025 04:35:20 +0000
Date: Thu, 17 Jul 2025 12:35:07 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/4] NFS: use a hash table for delegation lookup
Message-ID: <202507171246.w67NRPWN-lkp@intel.com>
References: <20250716132657.2167548-5-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716132657.2167548-5-hch@lst.de>

Hi Christoph,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on linus/master v6.16-rc6 next-20250716]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/NFS-move-the-delegation_watermark-module-parameter/20250716-222708
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250716132657.2167548-5-hch%40lst.de
patch subject: [PATCH 4/4] NFS: use a hash table for delegation lookup
config: i386-randconfig-013-20250717 (https://download.01.org/0day-ci/archive/20250717/202507171246.w67NRPWN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171246.w67NRPWN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507171246.w67NRPWN-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: fs/nfs/client.o: in function `nfs_clone_server':
>> fs/nfs/client.c:1162: undefined reference to `nfs4_delegation_hash_alloc'


vim +1162 fs/nfs/client.c

  1135	
  1136	/*
  1137	 * Clone an NFS2, NFS3 or NFS4 server record
  1138	 */
  1139	struct nfs_server *nfs_clone_server(struct nfs_server *source,
  1140					    struct nfs_fh *fh,
  1141					    struct nfs_fattr *fattr,
  1142					    rpc_authflavor_t flavor)
  1143	{
  1144		struct nfs_server *server;
  1145		int error;
  1146	
  1147		server = nfs_alloc_server();
  1148		if (!server)
  1149			return ERR_PTR(-ENOMEM);
  1150	
  1151		server->cred = get_cred(source->cred);
  1152	
  1153		/* Copy data from the source */
  1154		server->nfs_client = source->nfs_client;
  1155		server->destroy = source->destroy;
  1156		refcount_inc(&server->nfs_client->cl_count);
  1157		nfs_server_copy_userdata(server, source);
  1158	
  1159		server->fsid = fattr->fsid;
  1160	
  1161		if (IS_ENABLED(CONFIG_NFS_V4) && server->delegation_hash_table) {
> 1162			error = nfs4_delegation_hash_alloc(server);
  1163			if (error)
  1164				goto out_free_server;
  1165		}
  1166	
  1167		nfs_sysfs_add_server(server);
  1168	
  1169		nfs_sysfs_link_rpc_client(server,
  1170			server->nfs_client->cl_rpcclient, "_state");
  1171	
  1172		error = nfs_init_server_rpcclient(server,
  1173				source->client->cl_timeout,
  1174				flavor);
  1175		if (error < 0)
  1176			goto out_free_delegation_hash;
  1177	
  1178		/* probe the filesystem info for this server filesystem */
  1179		error = nfs_probe_server(server, fh);
  1180		if (error < 0)
  1181			goto out_free_delegation_hash;
  1182	
  1183		if (server->namelen == 0 || server->namelen > NFS4_MAXNAMLEN)
  1184			server->namelen = NFS4_MAXNAMLEN;
  1185	
  1186		error = nfs_start_lockd(server);
  1187		if (error < 0)
  1188			goto out_free_delegation_hash;
  1189	
  1190		nfs_server_insert_lists(server);
  1191		server->mount_time = jiffies;
  1192	
  1193		return server;
  1194	
  1195	out_free_delegation_hash:
  1196		kfree(server->delegation_hash_table);
  1197	out_free_server:
  1198		nfs_free_server(server);
  1199		return ERR_PTR(error);
  1200	}
  1201	EXPORT_SYMBOL_GPL(nfs_clone_server);
  1202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

