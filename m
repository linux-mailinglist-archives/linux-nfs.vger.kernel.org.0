Return-Path: <linux-nfs+bounces-20447-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id w4tbOSEVxmkGGQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20447-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 06:26:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D7C33F3BC
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 06:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95BE9304EAA1
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 05:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA13195EF;
	Fri, 27 Mar 2026 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGO44JYy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78C25EF87;
	Fri, 27 Mar 2026 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774589214; cv=none; b=XloGWDSkSMx9pkAni9lzHwpXfsi0b88XNy5k1+W6b+qVBhadQF9tQBt5bKvY+E65v9emXBuyW0e4Q18RRLCNvNtGF8NAmD4pe9Ju3ejsV/ZNZgsA9aHES9nkuo9whtNlJbfnJShpFh2MrXVAhNRz/+FfxZBH/6O19QuQyWEq7e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774589214; c=relaxed/simple;
	bh=0NvdU30yd+O/PNabiDauHBwgThhg6DzK5S6xWv5y7hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foYRia85PSWYbGr3xf5lxLLLonF9fZMgH847Z2U3rWAzWhGPRmBd/BGWAnsprt185xwKmIVFg5oAugojcZJE/JSfKMcVnwdV8/uWf/et2FmhXKBu8nzzse6GHu0v0YsWAMCmByQh+nfv4T2og6rytn3W3zSo8ZO4sIDRkCzM2PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGO44JYy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774589213; x=1806125213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0NvdU30yd+O/PNabiDauHBwgThhg6DzK5S6xWv5y7hA=;
  b=DGO44JYyCKxmAoaDekfNBtfuCKaSy346tC3Ky8h6FRQf+dBtg1ifewvC
   SIH1Wxppkv0L/kSAUFuI+7aXFQgEDh50Z0YGNcXnouCGgrRe962ccknOs
   FFGuqOoi+dvVrqycxafGbpg2O+2+xDCsFLd/8Y1hJ11oS9XwnpDhnZQQ8
   aS49aS3bnS1Qwo84FqXYx7uE1usc6upHZmwK05ut2xcGr/FbpsFUHs6IY
   olfNzG5okNVSKrekJd9VCvFuPopFwtnW46JknT1NkrKpIIq9GkDVKDlqt
   qOSfUsewoQcGYYr8pEzFAh5NAbeTfoJvB8SWAFsqf7mQ9Jsid6uXf74Ar
   g==;
X-CSE-ConnectionGUID: LFNDsmX7R6uD8Mgu+/fIzg==
X-CSE-MsgGUID: 3Rs69HyfSQKRYckoBj2wGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="78254803"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="78254803"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 22:26:53 -0700
X-CSE-ConnectionGUID: +aZcZ+2NSieSOEaKngZHWw==
X-CSE-MsgGUID: i+SMycimSQ2Igf1wBTyDsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="225459176"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2026 22:26:51 -0700
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5zia-000000007Rx-1KrO;
	Fri, 27 Mar 2026 05:26:48 +0000
Date: Fri, 27 Mar 2026 06:26:00 +0100
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 1/7] NFSD: Extract revoke_one_stid() utility function
Message-ID: <202603270614.CgH26mor-lkp@intel.com>
References: <20260326-umount-kills-nfsv4-state-v5-1-d2ce071b3570@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-umount-kills-nfsv4-state-v5-1-d2ce071b3570@oracle.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20447-lists,linux-nfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 08D7C33F3BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuck,

kernel test robot noticed the following build errors:

[auto build test ERROR on 65058e9e9b20619f920397f529072e853dd43811]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/NFSD-Extract-revoke_one_stid-utility-function/20260327-081757
base:   65058e9e9b20619f920397f529072e853dd43811
patch link:    https://lore.kernel.org/r/20260326-umount-kills-nfsv4-state-v5-1-d2ce071b3570%40oracle.com
patch subject: [PATCH v5 1/7] NFSD: Extract revoke_one_stid() utility function
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260327/202603270614.CgH26mor-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603270614.CgH26mor-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603270614.CgH26mor-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfsd/nfs4state.c: In function 'revoke_one_stid':
>> fs/nfsd/nfs4state.c:1830:28: error: 'state_lock' undeclared (first use in this function); did you mean 'task_lock'?
    1830 |                 spin_lock(&state_lock);
         |                            ^~~~~~~~~~
         |                            task_lock
   fs/nfsd/nfs4state.c:1830:28: note: each undeclared identifier is reported only once for each function it appears in


vim +1830 fs/nfsd/nfs4state.c

  1805	
  1806	static void revoke_one_stid(struct nfs4_client *clp, struct nfs4_stid *stid)
  1807	{
  1808		struct nfs4_ol_stateid *stp;
  1809		struct nfs4_delegation *dp;
  1810	
  1811		switch (stid->sc_type) {
  1812		case SC_TYPE_OPEN:
  1813			stp = openlockstateid(stid);
  1814			mutex_lock_nested(&stp->st_mutex, OPEN_STATEID_MUTEX);
  1815			revoke_ol_stid(clp, stp);
  1816			mutex_unlock(&stp->st_mutex);
  1817			break;
  1818		case SC_TYPE_LOCK:
  1819			stp = openlockstateid(stid);
  1820			mutex_lock_nested(&stp->st_mutex, LOCK_STATEID_MUTEX);
  1821			revoke_ol_stid(clp, stp);
  1822			mutex_unlock(&stp->st_mutex);
  1823			break;
  1824		case SC_TYPE_DELEG:
  1825			/*
  1826			 * Extra reference guards against concurrent FREE_STATEID.
  1827			 */
  1828			refcount_inc(&stid->sc_count);
  1829			dp = delegstateid(stid);
> 1830			spin_lock(&state_lock);
  1831			if (!unhash_delegation_locked(dp, SC_STATUS_ADMIN_REVOKED))
  1832				dp = NULL;
  1833			spin_unlock(&state_lock);
  1834			if (dp)
  1835				revoke_delegation(dp);
  1836			else
  1837				nfs4_put_stid(stid);
  1838			break;
  1839		case SC_TYPE_LAYOUT:
  1840			nfsd4_close_layout(layoutstateid(stid));
  1841			break;
  1842		}
  1843	}
  1844	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

