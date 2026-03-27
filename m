Return-Path: <linux-nfs+bounces-20449-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JvuDRhYxmkrJAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20449-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 11:12:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34807342443
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 11:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E0A2307E7F5
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7063A9D8B;
	Fri, 27 Mar 2026 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K59sa5VI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C73A9DAE;
	Fri, 27 Mar 2026 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606108; cv=none; b=Ke0T2uffZmpouXVB3X8nBGWPj3hM5RkncS6hozPmLFlW1auwSQS6phj5nQL2iuCRGKphrmiw/YdJalGPejo6FRCkOZ/9kY744xiaj+JmMuerNiUi1m7Ty6jZh31wyk21fkln04zTKs5vC4SNwGwL91kRP4al/3rvkzeBiceO4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606108; c=relaxed/simple;
	bh=nfJEz6wPuVKV8Cl7qtJJ9mGOW0YUkHEiV0LQPiDonk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olduCawrQj91PYfuBtnE3h18ZA5E5gVcGXI8xPs4E6JaE0qF0kMazoM3K5DEhdCGAs9dxaIn1391mQfKWuNkSWdDaxIOBlCICxw1rh5obTbws0i8P/xJg64BYWEKw5ubg5Nrfn6SRl5979FzAhqYubG3erZvfJCGwTXAVpn1YrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K59sa5VI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774606106; x=1806142106;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nfJEz6wPuVKV8Cl7qtJJ9mGOW0YUkHEiV0LQPiDonk0=;
  b=K59sa5VIrncpkOSCAuwPYcjxDTx9wa/vvFnHuSVuBCVXZxcfbAzKmhg/
   83RuTpCSvA2d7RIZq5Hjuup6qye1r3yRa/rCV8e3j/pnjavM1JZkC4s9D
   Q+aVoW06EzdfQWIrt+owMV5yZpSeu0xgrWB1W0IlJ1ctwNCIhWnlHCeg+
   yy1XlovHqB7mNrxX6hZpRXgG9f59Ptm5jaAotkzfiye2c88Ji0iOKbf3h
   ftcH5GZA7htn3pkHbhMVH/KICtI4lGwGO5gqxDw87M258/SwxKYowvS9O
   0xwbzDdtex0XNh6ZLQhDlb07EZ/+vfPECfpHwoMmLilbjzKm29+bDTvXs
   A==;
X-CSE-ConnectionGUID: 4rHSeMj3SiWQYjmtMfGPsg==
X-CSE-MsgGUID: mZprEZeqRtSsnvTTKnvz8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79581550"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="79581550"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 03:08:25 -0700
X-CSE-ConnectionGUID: 2W9uDgkIRfuEhcY4dYfpgA==
X-CSE-MsgGUID: +GzRkPzkQU6S4yIEB6A96Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255773478"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 03:08:22 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6471-00000000A8r-1qp5;
	Fri, 27 Mar 2026 10:08:19 +0000
Date: Fri, 27 Mar 2026 18:08:18 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 1/7] NFSD: Extract revoke_one_stid() utility function
Message-ID: <202603271711.Pbg3v6zE-lkp@intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-20449-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 34807342443
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuck,

kernel test robot noticed the following build errors:

[auto build test ERROR on 65058e9e9b20619f920397f529072e853dd43811]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/NFSD-Extract-revoke_one_stid-utility-function/20260327-081757
base:   65058e9e9b20619f920397f529072e853dd43811
patch link:    https://lore.kernel.org/r/20260326-umount-kills-nfsv4-state-v5-1-d2ce071b3570%40oracle.com
patch subject: [PATCH v5 1/7] NFSD: Extract revoke_one_stid() utility function
config: s390-defconfig (https://download.01.org/0day-ci/archive/20260327/202603271711.Pbg3v6zE-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 054e11d1a17e5ba88bb1a8ef32fad3346e80b186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603271711.Pbg3v6zE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603271711.Pbg3v6zE-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfsd/nfs4state.c:1830:14: error: use of undeclared identifier 'state_lock'; did you mean 'task_lock'?
    1830 |                 spin_lock(&state_lock);
         |                            ^~~~~~~~~~
         |                            task_lock
   include/linux/sched/task.h:216:20: note: 'task_lock' declared here
     216 | static inline void task_lock(struct task_struct *p)
         |                    ^
>> fs/nfsd/nfs4state.c:1830:13: error: incompatible pointer types passing 'void (*)(struct task_struct *)' to parameter of type 'spinlock_t *' (aka 'struct spinlock *') [-Wincompatible-pointer-types]
    1830 |                 spin_lock(&state_lock);
         |                           ^~~~~~~~~~~
   include/linux/spinlock.h:338:51: note: passing argument to parameter 'lock' here
     338 | static __always_inline void spin_lock(spinlock_t *lock)
         |                                                   ^
   fs/nfsd/nfs4state.c:1833:16: error: use of undeclared identifier 'state_lock'; did you mean 'task_lock'?
    1833 |                 spin_unlock(&state_lock);
         |                              ^~~~~~~~~~
         |                              task_lock
   include/linux/sched/task.h:216:20: note: 'task_lock' declared here
     216 | static inline void task_lock(struct task_struct *p)
         |                    ^
   fs/nfsd/nfs4state.c:1833:15: error: incompatible pointer types passing 'void (*)(struct task_struct *)' to parameter of type 'spinlock_t *' (aka 'struct spinlock *') [-Wincompatible-pointer-types]
    1833 |                 spin_unlock(&state_lock);
         |                             ^~~~~~~~~~~
   include/linux/spinlock.h:386:53: note: passing argument to parameter 'lock' here
     386 | static __always_inline void spin_unlock(spinlock_t *lock)
         |                                                     ^
   4 errors generated.


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

