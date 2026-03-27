Return-Path: <linux-nfs+bounces-20450-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBWLOG1mxmnnJgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20450-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 12:13:49 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 841053432E7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 12:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4B2A3018F1B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 11:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE2B2DF707;
	Fri, 27 Mar 2026 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNLXz7E0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3883CEB8E;
	Fri, 27 Mar 2026 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774610014; cv=none; b=Dw+lR1I+nDsGyJTyRKSMR736MTcLUnVUYeZk6AiNGxkNofsozW/1qYOVFzTPpBvPN465Ngu3SVJc+/jO+ucjdnzceI9y2G28HDhsej07hvCeHRU4iyNHHObPB/WDL53XpjBr3R6zww+hI4uDm3AlFBK7eQ3kCe48W2+CWKFVnFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774610014; c=relaxed/simple;
	bh=nJUYpm8Tn5AiiOGRCA1EAgbdYknTx+zBAyjjwOQbGKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IV4xUtt05v8I06LnRD9P422cja6mh/LEdIO6btQ0vZYl7G9alJrCj9lhkNJNtgrJohN4R0+D+ta3nUuq/fAS6kT0IkgOe7tDtyugOH+U1IpTAbdZSaj2Y/A8ICKBysJ+zFv/J7Y3kiJd2Bk1AV/8HuoAsgHxla5d9PmduLAY094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNLXz7E0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774610009; x=1806146009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJUYpm8Tn5AiiOGRCA1EAgbdYknTx+zBAyjjwOQbGKs=;
  b=TNLXz7E0KMvW8KIEQcBeikponG+ikWWkc3DM3afK+h56DaiHNpWcdS+d
   xr7EeNBIH+BHICpTdmCElwY43haplm+Nhon+Ehu05lkgEfU/Cb7KC6vjL
   QlIYzX89KnU4om0fs1qMJmWRcvgHaFBRegmWYxSFXmQMGhOy0K8nUJ3y1
   f/fNl5acR/lQX9wmZOU9dYU5Wd+HEdLFlFonu68tPR1/8oGgUq7zvKtuR
   xF6hpg/gI9zpB5SVjvbi4DcqeKI+Ptw5EQ/xJmpmX6sKWrfFYG8MgUSCD
   7cmpoQChgI7xEvfXUDPs4KbNVfX/K9F1m36Qio8NSAzesz/9pCxCvWFz1
   w==;
X-CSE-ConnectionGUID: zVxFhiGWQqiMbJS6zYLpMQ==
X-CSE-MsgGUID: lTIcrEomR0SWDnAeZF2vyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79541073"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="79541073"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 04:13:28 -0700
X-CSE-ConnectionGUID: FbS0Pl5SS72d8TkKR100bQ==
X-CSE-MsgGUID: Whxc+k1LRE+NYZQX0v1XmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="224329385"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Mar 2026 04:13:26 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w657z-00000000ACT-0qDN;
	Fri, 27 Mar 2026 11:13:23 +0000
Date: Fri, 27 Mar 2026 19:13:12 +0800
From: kernel test robot <lkp@intel.com>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v5 1/7] NFSD: Extract revoke_one_stid() utility function
Message-ID: <202603271905.vZdE0ulk-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20450-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 841053432E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Chuck,

kernel test robot noticed the following build errors:

[auto build test ERROR on 65058e9e9b20619f920397f529072e853dd43811]

url:    https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/NFSD-Extract-revoke_one_stid-utility-function/20260327-081757
base:   65058e9e9b20619f920397f529072e853dd43811
patch link:    https://lore.kernel.org/r/20260326-umount-kills-nfsv4-state-v5-1-d2ce071b3570%40oracle.com
patch subject: [PATCH v5 1/7] NFSD: Extract revoke_one_stid() utility function
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260327/202603271905.vZdE0ulk-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603271905.vZdE0ulk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603271905.vZdE0ulk-lkp@intel.com/

All errors (new ones prefixed by >>):

>> fs/nfsd/nfs4state.c:1830:14: error: use of undeclared identifier 'state_lock'; did you mean 'task_lock'?
    1830 |                 spin_lock(&state_lock);
         |                            ^~~~~~~~~~
         |                            task_lock
   include/linux/sched/task.h:216:20: note: 'task_lock' declared here
     216 | static inline void task_lock(struct task_struct *p)
         |                    ^
   fs/nfsd/nfs4state.c:1833:16: error: use of undeclared identifier 'state_lock'; did you mean 'task_lock'?
    1833 |                 spin_unlock(&state_lock);
         |                              ^~~~~~~~~~
         |                              task_lock
   include/linux/sched/task.h:216:20: note: 'task_lock' declared here
     216 | static inline void task_lock(struct task_struct *p)
         |                    ^
   2 errors generated.


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

