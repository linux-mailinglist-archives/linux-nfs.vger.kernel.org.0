Return-Path: <linux-nfs+bounces-2646-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC88990F0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Apr 2024 00:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7F828974E
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Apr 2024 22:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528C13C3DD;
	Thu,  4 Apr 2024 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GRaDjyOL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7EA13C3D4
	for <linux-nfs@vger.kernel.org>; Thu,  4 Apr 2024 22:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712268141; cv=none; b=peQ1gv0UlP7nmHztYPiFZYvzEs5xqYrdgJYADio8sEGHJw+uQ/61rxsALJV/FxS1NItuYz21WsjV6dFLD0kCazKaJR3MBL5OTuA7/3yWj4hgIfPVHY7E1gOGFRzIvghbOBp1feNnf7WCljY//cBcmlJRq6SuTH2qd4dfK3ex8rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712268141; c=relaxed/simple;
	bh=EFR1zWoItOU7NC9RM5bLP4vvAk/9WGJk7I3fLJlLU5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MSVxdTh4o0wP5Jv9QaIqg3hENuU4LScm6gl0/2vq7VfOPxhnhJ8WhI7ffcprL8JLwIriNxkMKC16l7A519Uat7548p49zQOkP6lIaFJL6Sp7S4twCTNefeNvYDYbO2MmZtH2qGV3IljbT1YpEBowUumH9bzcRC7d6Wyr45ONObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GRaDjyOL; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712268139; x=1743804139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3AlEgsFDSJ43hdyMtPohDeKkRewRXR+tPnBjTCs+sFk=;
  b=GRaDjyOLqddTuSOYUV/PNgMb0VMCiYo+3GQFHzLdwA97cXW24MnpjWoE
   CQx6iUFn1G6aOPbnpTAIBxUYnI7QY3Fg9vv5/Y8qJGrqE2YnFsX+Vofug
   Hyym+Sm1/x1HElhgSi8sJhVqOyyT5CLe4bgA472QkwqykreeeekflS3Vp
   M=;
X-IronPort-AV: E=Sophos;i="6.07,180,1708387200"; 
   d="scan'208";a="624541143"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 22:02:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:16658]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.213:2525] with esmtp (Farcaster)
 id b7ccf3d5-ca9f-4cf5-bd8c-ac5f6fc06e0e; Thu, 4 Apr 2024 22:02:16 +0000 (UTC)
X-Farcaster-Flow-ID: b7ccf3d5-ca9f-4cf5-bd8c-ac5f6fc06e0e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 22:02:16 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 22:02:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lkp@intel.com>
CC: <kuniyu@amazon.com>, <linux-nfs@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, <trond.myklebust@hammerspace.com>
Subject: Re: [trondmy-nfs:testing 31/31] fs/nfs/inode.c:2434:13: warning: assignment to 'int' from 'struct proc_dir_entry *' makes integer from pointer without a cast
Date: Thu, 4 Apr 2024 15:02:05 -0700
Message-ID: <20240404220205.50324-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202404050536.TP9zhcZf-lkp@intel.com>
References: <202404050536.TP9zhcZf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: kernel test robot <lkp@intel.com>
Date: Fri, 5 Apr 2024 05:48:13 +0800
> tree:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git testing
> head:   f290a586e31f8965387dde660729c716a3af9b6c
> commit: f290a586e31f8965387dde660729c716a3af9b6c [31/31] nfs: Handle error of rpc_proc_register() in nfs_net_init().
> config: arc-defconfig (https://download.01.org/0day-ci/archive/20240405/202404050536.TP9zhcZf-lkp@intel.com/config)
> compiler: arc-elf-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404050536.TP9zhcZf-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404050536.TP9zhcZf-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    fs/nfs/inode.c: In function 'nfs_net_init':
> >> fs/nfs/inode.c:2434:13: warning: assignment to 'int' from 'struct proc_dir_entry *' makes integer from pointer without a cast [-Wint-conversion]
>     2434 |         err = rpc_proc_register(net, &nn->rpcstats);
>          |             ^

Ugh... sorry I forgot to turn on RPC after defconfig...

I'll post v2 soon.

Thanks!



> 
> 
> vim +2434 fs/nfs/inode.c
> 
>   2426	
>   2427	static int nfs_net_init(struct net *net)
>   2428	{
>   2429		struct nfs_net *nn = net_generic(net, nfs_net_id);
>   2430		int err;
>   2431	
>   2432		nfs_clients_init(net);
>   2433	
> > 2434		err = rpc_proc_register(net, &nn->rpcstats);
>   2435		if (err) {
>   2436			nfs_clients_exit(net);
>   2437			return err;
>   2438		}
>   2439	
>   2440		return nfs_fs_proc_net_init(net);
>   2441	}
>   2442	
> 

