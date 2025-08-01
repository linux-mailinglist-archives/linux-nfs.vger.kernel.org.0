Return-Path: <linux-nfs+bounces-13370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD44DB1801A
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 12:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A711C80616
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15F222D786;
	Fri,  1 Aug 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wmw2u53q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79DC20E030
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043836; cv=none; b=EV894mQssfSSjQsskGDASf3qElDk8od2CgKzQOmO7KX+Muq8G7kSaXCsYh7q+8/PqrzIpIbihjrry+T2rw/V1xx9EFUMUlanupRtYY7Oa4XdlJ7DoGdCOInU1+Cn7IAAQXSrYNoZfiUUoIo5kR0pALPRNvQ3sgOC0xC46MyR/oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043836; c=relaxed/simple;
	bh=6C8VKyzSCeZeFS+cVdPFYBYpvnRjlsMbaaS+Hg0OF7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8Ks2VgSxissLVtVgX/ULTJqttg4rARqKWsIvJte/DCJaag3o5zYq7gnXW8985zgN8J4XNOFzANCY/Yz+PhmOi75G9sBFxesKLhKh5ZpnIJkDwxhm0Psi611ZewXhY1vQXiqByxr+73gr2Uj+brbPvGmWHhgW7XWgQ07m6MgUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wmw2u53q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754043834; x=1785579834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6C8VKyzSCeZeFS+cVdPFYBYpvnRjlsMbaaS+Hg0OF7M=;
  b=Wmw2u53qKWSCaQlAUHGIroDZAjnoOzh+VpIvHo7VBUlQjZKpF7hbKPH+
   hVxU+QHkg7OIuNtBTqfk77mP8pV6HwxB3jLpkgRSWQDe00jiL4hLpvAe6
   XfrVOkEmpsOVFYuJ1ZR0k/U8AQBq//ZzYf071pI5XXTFv1N367JeeeIO6
   lEb1Vej5+wejm+sfv5jRPzfIuPRzNLWLZjWRtWc2D3uBTzYXJd8WdZXPi
   tl4nPNLgZwLsrxrfQQow0N2NnCEv466J66MECJ0s8YQJVCoORvk6NBRi/
   x+XRaY/spG0a6jvzBI74+S1w2pHK8/7XP1KXj2GdkQcvZps+7+2fn5auC
   Q==;
X-CSE-ConnectionGUID: kvG+baI2RlaKKl70Iy1gUg==
X-CSE-MsgGUID: xGZCB4HgSEmID7I6xS49gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="67084979"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="67084979"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 03:23:54 -0700
X-CSE-ConnectionGUID: gX+9Eb8KRCqk+WtatOXhFg==
X-CSE-MsgGUID: L2D/5umOQnmLUkIdxObthA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163096369"
Received: from lkp-server01.sh.intel.com (HELO 160750d4a34c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 01 Aug 2025 03:23:52 -0700
Received: from kbuild by 160750d4a34c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uhmvV-0004XU-2G;
	Fri, 01 Aug 2025 10:23:49 +0000
Date: Fri, 1 Aug 2025 18:23:14 +0800
From: kernel test robot <lkp@intel.com>
To: Scott Mayhew <smayhew@redhat.com>, chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: decouple the xprtsec policy check from
 check_nfsd_access()
Message-ID: <202508011835.YXIfu0oy-lkp@intel.com>
References: <20250731211441.1908508-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731211441.1908508-1-smayhew@redhat.com>

Hi Scott,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.16 next-20250801]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Scott-Mayhew/nfsd-decouple-the-xprtsec-policy-check-from-check_nfsd_access/20250801-051621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20250731211441.1908508-1-smayhew%40redhat.com
patch subject: [PATCH] nfsd: decouple the xprtsec policy check from check_nfsd_access()
config: i386-buildonly-randconfig-003-20250801 (https://download.01.org/0day-ci/archive/20250801/202508011835.YXIfu0oy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250801/202508011835.YXIfu0oy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508011835.YXIfu0oy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nfsd/export.c: In function 'exp_rootfh':
   fs/nfsd/export.c:1029:34: warning: variable 'inode' set but not used [-Wunused-but-set-variable]
    1029 |         struct inode            *inode;
         |                                  ^~~~~
   fs/nfsd/export.c: In function 'check_nfsd_access':
>> fs/nfsd/export.c:1153:26: warning: variable 'xprt' set but not used [-Wunused-but-set-variable]
    1153 |         struct svc_xprt *xprt;
         |                          ^~~~


vim +/xprt +1153 fs/nfsd/export.c

  1138	
  1139	/**
  1140	 * check_nfsd_access - check if access to export is allowed.
  1141	 * @exp: svc_export that is being accessed.
  1142	 * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
  1143	 * @may_bypass_gss: reduce strictness of authorization check
  1144	 *
  1145	 * Return values:
  1146	 *   %nfs_ok if access is granted, or
  1147	 *   %nfserr_wrongsec if access is denied
  1148	 */
  1149	__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
  1150				 bool may_bypass_gss)
  1151	{
  1152		struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> 1153		struct svc_xprt *xprt;
  1154	
  1155		/*
  1156		 * If rqstp is NULL, this is a LOCALIO request which will only
  1157		 * ever use a filehandle/credential pair for which access has
  1158		 * been affirmed (by ACCESS or OPEN NFS requests) over the
  1159		 * wire. So there is no need for further checks here.
  1160		 */
  1161		if (!rqstp)
  1162			return nfs_ok;
  1163	
  1164		xprt = rqstp->rq_xprt;
  1165	
  1166		/* legacy gss-only clients are always OK: */
  1167		if (exp->ex_client == rqstp->rq_gssclient)
  1168			return nfs_ok;
  1169		/* ip-address based client; check sec= export option: */
  1170		for (f = exp->ex_flavors; f < end; f++) {
  1171			if (f->pseudoflavor == rqstp->rq_cred.cr_flavor)
  1172				return nfs_ok;
  1173		}
  1174		/* defaults in absence of sec= options: */
  1175		if (exp->ex_nflavors == 0) {
  1176			if (rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
  1177			    rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)
  1178				return nfs_ok;
  1179		}
  1180	
  1181		/* If the compound op contains a spo_must_allowed op,
  1182		 * it will be sent with integrity/protection which
  1183		 * will have to be expressly allowed on mounts that
  1184		 * don't support it
  1185		 */
  1186	
  1187		if (nfsd4_spo_must_allow(rqstp))
  1188			return nfs_ok;
  1189	
  1190		/* Some calls may be processed without authentication
  1191		 * on GSS exports. For example NFS2/3 calls on root
  1192		 * directory, see section 2.3.2 of rfc 2623.
  1193		 * For "may_bypass_gss" check that export has really
  1194		 * enabled some flavor with authentication (GSS or any
  1195		 * other) and also check that the used auth flavor is
  1196		 * without authentication (none or sys).
  1197		 */
  1198		if (may_bypass_gss && (
  1199		     rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
  1200		     rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)) {
  1201			for (f = exp->ex_flavors; f < end; f++) {
  1202				if (f->pseudoflavor >= RPC_AUTH_DES)
  1203					return 0;
  1204			}
  1205		}
  1206	
  1207		return nfserr_wrongsec;
  1208	}
  1209	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

