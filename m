Return-Path: <linux-nfs+bounces-19724-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNOTL1UNqGn2nQAAu9opvQ
	(envelope-from <linux-nfs+bounces-19724-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 11:45:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B89451FE852
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 11:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB01D300C6C8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756B93A5E8D;
	Wed,  4 Mar 2026 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/+kkbzt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476633A5E85;
	Wed,  4 Mar 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772621135; cv=none; b=ZbjLCT/mLsxgVW7OoY96X/DRH4NSm5i/zMwYwjuxoNXRI9sTVQJR8esPY3KXwdA0I/fF85aHDfMR1rGhPQwfailpvr0X9KUd5AkKSSre88t7XN/6GhaIFIMklbRLIwAMMV5sQ3b7z2wAT0b8Kr97uEMXjE8CQ8oLVnL0Fzq+kMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772621135; c=relaxed/simple;
	bh=h7E/8o1/7HTV0SVvlIZbDHxgfXZolheekA9fIw186h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NISiMa+i0Qspp7IswbhK5lv4ATt1RbChkARzng2HDtA58pn1wGRYUPh/2eXWkWgZWQrcgp57XYEWktfHQYzH2Oh+lE4cHrN07IpNQd/iOJwXXAOgTFOijQVD1HbJIFirFoCJbtwgYYmsbGgcQMAvqMiL4XRTB5Wy25A8087Dimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/+kkbzt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772621133; x=1804157133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h7E/8o1/7HTV0SVvlIZbDHxgfXZolheekA9fIw186h4=;
  b=A/+kkbztBcLjdMl7mkMCAFjqlZ7/3GEq/QZ+FQIVyI6Ih6IWsJqtS4f7
   +1GD1uNsu+ZKke/nk885Lp/Vc+1lg0v3/Oin5BuVr44hL9K3Q7UZ8T3jf
   R+Lr3gXIJNqyZxGs6BIs8QRMTLYVqztPkzKeFO9mh4NP3XbJO+Npcv6RY
   QXYKHjrsxLGlS6TiGsb488p4U694IqALi9nd4PadEK94Dc86jMrfXjl30
   muMN38JHg1p65+dLqEIlMdeZHlj+9mW24OdJoPE6NjTsfG5249hRHQY9v
   LQgL6DggLkBAt+E7GhrB/+U11RvYX3N+MaGxa9kL1uVb3rUqCkldAFQyA
   g==;
X-CSE-ConnectionGUID: Fgp39bdORZG+99RU+0HuTw==
X-CSE-MsgGUID: WXWxnHQCQFuA2iCiu6siBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77522355"
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="77522355"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 02:45:32 -0800
X-CSE-ConnectionGUID: oVDTgMTCR6Gc0LsRhX4bPw==
X-CSE-MsgGUID: 5mOij3zGQFObPS2/aj14bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,323,1763452800"; 
   d="scan'208";a="222799590"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2026 02:45:28 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxjjJ-000000001fd-2npX;
	Wed, 04 Mar 2026 10:45:25 +0000
Date: Wed, 4 Mar 2026 11:44:26 +0100
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
	alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
Message-ID: <202603041124.uCwVY2n8-lkp@intel.com>
References: <20260304053500.590630-5-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304053500.590630-5-alistair.francis@wdc.com>
X-Rspamd-Queue-Id: B89451FE852
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,suse.de,gmail.com,wdc.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-19724-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org,lists.linux.dev,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,git-scm.com:url,arg.data:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on trondmy-nfs/linux-next]
[also build test ERROR on net/main net-next/main linus/master v7.0-rc2 next-20260303]
[cannot apply to linux-nvme/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20260304-134148
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20260304053500.590630-5-alistair.francis%40wdc.com
patch subject: [PATCH v7 4/5] nvme-tcp: Support KeyUpdate
config: x86_64-rhel-9.4-kunit (https://download.01.org/0day-ci/archive/20260304/202603041124.uCwVY2n8-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260304/202603041124.uCwVY2n8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603041124.uCwVY2n8-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/tcp.c: In function 'nvme_tcp_try_recv':
>> drivers/nvme/host/tcp.c:1429:31: error: 'const struct proto_ops' has no member named 'read_sock_cmsg'; did you mean 'read_sock'?
    1429 |         consumed = sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_recv_skb,
         |                               ^~~~~~~~~~~~~~
         |                               read_sock


vim +1429 drivers/nvme/host/tcp.c

  1417	
  1418	static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
  1419	{
  1420		struct socket *sock = queue->sock;
  1421		struct sock *sk = sock->sk;
  1422		read_descriptor_t rd_desc;
  1423		int consumed;
  1424	
  1425		rd_desc.arg.data = queue;
  1426		rd_desc.count = 1;
  1427		lock_sock(sk);
  1428		queue->nr_cqe = 0;
> 1429		consumed = sock->ops->read_sock_cmsg(sk, &rd_desc, nvme_tcp_recv_skb,
  1430						     nvme_tcp_recv_cmsg);
  1431		release_sock(sk);
  1432		return consumed == -EAGAIN ? 0 : consumed;
  1433	}
  1434	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

