Return-Path: <linux-nfs+bounces-13126-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AACB08435
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 07:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD0D4E6158
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jul 2025 05:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085E918D643;
	Thu, 17 Jul 2025 05:13:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABA1114
	for <linux-nfs@vger.kernel.org>; Thu, 17 Jul 2025 05:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752729201; cv=none; b=atyCJNCusfM+CZQj5Xawpdsm0RwJ7hQ6mCgQGl17ZZscdiLyhVwcquGVHYffmbJchLe5G0i52YtSKpy4Knu12x3f1kVwDovAAUKtinrItIHvLJCcm5oGe2LdBr/prkwnn3U2VB2FQ1W2p5zlTF1Qt96VbURKEeR5BNQHOWYgpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752729201; c=relaxed/simple;
	bh=+qyFcK3h8f+8cobQInKIqJy1PsmlBz7J0Q58izK1CoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtZ7+Wc0UiC1rGKLQ3NsQHVdk7fEpaxU9vTzpFVL/zWNPrWkBjpxpSP6M8H7PXWsquTeJH7oJCryBVS0PTo3E9FqQ0t3gEG6EQE4zm9NGRxlCKlPS2iqU1Gb70hRdAl5x4J4xbf5RxcYMT8VBSbHP//Z2IaJejGaRHahsHFKAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F0B6227A87; Thu, 17 Jul 2025 07:13:16 +0200 (CEST)
Date: Thu, 17 Jul 2025 07:13:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/4] NFS: use a hash table for delegation lookup
Message-ID: <20250717051315.GA27362@lst.de>
References: <20250716132657.2167548-5-hch@lst.de> <202507171246.w67NRPWN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507171246.w67NRPWN-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

So nfs4 can be built modular, and delegation.o is built into that,
i.e. we can't call into deletation code from clone_server.

Back to passing a major number to nfs_alloc_server?

On Thu, Jul 17, 2025 at 12:35:07PM +0800, kernel test robot wrote:
> Hi Christoph,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on trondmy-nfs/linux-next]
> [also build test ERROR on linus/master v6.16-rc6 next-20250716]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/NFS-move-the-delegation_watermark-module-parameter/20250716-222708
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> patch link:    https://lore.kernel.org/r/20250716132657.2167548-5-hch%40lst.de
> patch subject: [PATCH 4/4] NFS: use a hash table for delegation lookup
> config: i386-randconfig-013-20250717 (https://download.01.org/0day-ci/archive/20250717/202507171246.w67NRPWN-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507171246.w67NRPWN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507171246.w67NRPWN-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: fs/nfs/client.o: in function `nfs_clone_server':
> >> fs/nfs/client.c:1162: undefined reference to `nfs4_delegation_hash_alloc'
> 
> 
> vim +1162 fs/nfs/client.c
> 
>   1135	
>   1136	/*
>   1137	 * Clone an NFS2, NFS3 or NFS4 server record
>   1138	 */
>   1139	struct nfs_server *nfs_clone_server(struct nfs_server *source,
>   1140					    struct nfs_fh *fh,
>   1141					    struct nfs_fattr *fattr,
>   1142					    rpc_authflavor_t flavor)
>   1143	{
>   1144		struct nfs_server *server;
>   1145		int error;
>   1146	
>   1147		server = nfs_alloc_server();
>   1148		if (!server)
>   1149			return ERR_PTR(-ENOMEM);
>   1150	
>   1151		server->cred = get_cred(source->cred);
>   1152	
>   1153		/* Copy data from the source */
>   1154		server->nfs_client = source->nfs_client;
>   1155		server->destroy = source->destroy;
>   1156		refcount_inc(&server->nfs_client->cl_count);
>   1157		nfs_server_copy_userdata(server, source);
>   1158	
>   1159		server->fsid = fattr->fsid;
>   1160	
>   1161		if (IS_ENABLED(CONFIG_NFS_V4) && server->delegation_hash_table) {
> > 1162			error = nfs4_delegation_hash_alloc(server);
>   1163			if (error)
>   1164				goto out_free_server;
>   1165		}
>   1166	
>   1167		nfs_sysfs_add_server(server);
>   1168	
>   1169		nfs_sysfs_link_rpc_client(server,
>   1170			server->nfs_client->cl_rpcclient, "_state");
>   1171	
>   1172		error = nfs_init_server_rpcclient(server,
>   1173				source->client->cl_timeout,
>   1174				flavor);
>   1175		if (error < 0)
>   1176			goto out_free_delegation_hash;
>   1177	
>   1178		/* probe the filesystem info for this server filesystem */
>   1179		error = nfs_probe_server(server, fh);
>   1180		if (error < 0)
>   1181			goto out_free_delegation_hash;
>   1182	
>   1183		if (server->namelen == 0 || server->namelen > NFS4_MAXNAMLEN)
>   1184			server->namelen = NFS4_MAXNAMLEN;
>   1185	
>   1186		error = nfs_start_lockd(server);
>   1187		if (error < 0)
>   1188			goto out_free_delegation_hash;
>   1189	
>   1190		nfs_server_insert_lists(server);
>   1191		server->mount_time = jiffies;
>   1192	
>   1193		return server;
>   1194	
>   1195	out_free_delegation_hash:
>   1196		kfree(server->delegation_hash_table);
>   1197	out_free_server:
>   1198		nfs_free_server(server);
>   1199		return ERR_PTR(error);
>   1200	}
>   1201	EXPORT_SYMBOL_GPL(nfs_clone_server);
>   1202	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
---end quoted text---

