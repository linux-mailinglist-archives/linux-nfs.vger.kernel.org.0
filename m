Return-Path: <linux-nfs+bounces-1251-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49CD836D6E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 18:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85EBC28C455
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8476B55E5F;
	Mon, 22 Jan 2024 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rj/rzkzg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A51E4B3;
	Mon, 22 Jan 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941126; cv=none; b=DCqxxd7frW4YkgCAp1JuSIH3UokONBmOgvvIOWlNJWf1KNGhjNzNk/LsaQ6QXfMDWfk6HOsigmuaSJkJOtp1qk7QIDoar9rGH6o1fV2QCiViO67ocOMzMIlP+z42jaQjoL8l509Z1h1lgnNw1XSfgrisbUpPC1mfZvWtceZ+VgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941126; c=relaxed/simple;
	bh=ncxCdYw0MO9BomJqGZJBlLsA9dRHN7VWjUDWMdHRXwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHTpfMXYu2TqtVU1LrtuixA+AADMGKIhyKpgGuCl4NQEnd5YGUbaHLg/4JK/ht8N847yzdVDUfqJeD7fINPl8R9iIx+g0jkTrSKrWHWU+cE9fO5lgTXIZAgAt7Q5QAXqZIq0Mpl0cBgW3FMW5n3hxeje4OyBC39ROxd8qLYx7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rj/rzkzg; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705941124; x=1737477124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ncxCdYw0MO9BomJqGZJBlLsA9dRHN7VWjUDWMdHRXwY=;
  b=Rj/rzkzgJUF+zq2X1B3loP0QZioLaFIFIQ5INj5IIpif1GrKL5ut+cT/
   LZCuztfC2RGTcXIBqqnHPFC6DQ35+jSvTrV0D7SM5NbDZu7Ox8cqMMYU+
   i2akIWCgLfvWs1J2+SrA7d5uTxLT/pJ3zraXu7134u7giR1NLsPt0LRcg
   BxiyMNrRNpwwxo3YG4k7Z8m4307KN0MWCclMr3JJyf81bRTTACUp3YQ6K
   R4aH4LQ9P1r4AKJwkkUyKmTIY5E0+xfYygVZevhBxvSQRAIQOVLjt8LEE
   iSUpiyAgyqUknrx1B/CRMki1EKmxQj0Gqf59jUt+3WjIM+ZH4oLUWs2+x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="400118311"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="400118311"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 08:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="27709159"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 22 Jan 2024 08:32:01 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRxDK-0006ka-2J;
	Mon, 22 Jan 2024 16:31:58 +0000
Date: Tue, 23 Jan 2024 00:31:37 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
	neilb@suse.de, jlayton@kernel.org, kuba@kernel.org,
	chuck.lever@oracle.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Message-ID: <202401230032.Sx6BKQgl-lkp@intel.com>
References: <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.7]
[cannot apply to linus/master trondmy-nfs/linux-next next-20240122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/NFSD-convert-write_threads-to-netlink-command/20240121-013808
base:   v6.7
patch link:    https://lore.kernel.org/r/f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo%40kernel.org
patch subject: [PATCH v6 3/3] NFSD: add write_ports to netlink command
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20240123/202401230032.Sx6BKQgl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240123/202401230032.Sx6BKQgl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401230032.Sx6BKQgl-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/nfsd/nfsctl.c: In function 'nfsd_nl_listener_set_doit':
>> fs/nfsd/nfsctl.c:2017:17: error: implicit declaration of function 'nfsd_destroy_serv'; did you mean 'nfsd4_destroy_session'? [-Werror=implicit-function-declaration]
    2017 |                 nfsd_destroy_serv(net);
         |                 ^~~~~~~~~~~~~~~~~
         |                 nfsd4_destroy_session
   cc1: some warnings being treated as errors


vim +2017 fs/nfsd/nfsctl.c

  1900	
  1901	/**
  1902	 * nfsd_nl_listener_set_doit - set the nfs running listeners
  1903	 * @skb: reply buffer
  1904	 * @info: netlink metadata and command arguments
  1905	 *
  1906	 * Return 0 on success or a negative errno.
  1907	 */
  1908	int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
  1909	{
  1910		struct nlattr *tb[ARRAY_SIZE(nfsd_server_instance_nl_policy)];
  1911		struct net *net = genl_info_net(info);
  1912		struct svc_xprt *xprt, *tmp_xprt;
  1913		const struct nlattr *attr;
  1914		struct svc_serv *serv;
  1915		const char *xcl_name;
  1916		struct nfsd_net *nn;
  1917		int port, err, rem;
  1918		sa_family_t af;
  1919	
  1920		if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_INSTANCE))
  1921			return -EINVAL;
  1922	
  1923		mutex_lock(&nfsd_mutex);
  1924	
  1925		err = nfsd_create_serv(net);
  1926		if (err) {
  1927			mutex_unlock(&nfsd_mutex);
  1928			return err;
  1929		}
  1930	
  1931		nn = net_generic(net, nfsd_net_id);
  1932		serv = nn->nfsd_serv;
  1933	
  1934		/* 1- create brand new listeners */
  1935		nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
  1936			if (nla_type(attr) != NFSD_A_SERVER_LISTENER_INSTANCE)
  1937				continue;
  1938	
  1939			if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
  1940					     nfsd_server_instance_nl_policy,
  1941					     info->extack) < 0)
  1942				continue;
  1943	
  1944			if (!tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] ||
  1945			    !tb[NFSD_A_SERVER_INSTANCE_PORT])
  1946				continue;
  1947	
  1948			xcl_name = nla_data(tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME]);
  1949			port = nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_PORT]);
  1950			if (port < 1 || port > USHRT_MAX)
  1951				continue;
  1952	
  1953			af = nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_INET_PROTO]);
  1954			if (af != PF_INET && af != PF_INET6)
  1955				continue;
  1956	
  1957			xprt = svc_find_xprt(serv, xcl_name, net, PF_INET, port);
  1958			if (xprt) {
  1959				svc_xprt_put(xprt);
  1960				continue;
  1961			}
  1962	
  1963			/* create new listerner */
  1964			if (svc_xprt_create(serv, xcl_name, net, af, port,
  1965					    SVC_SOCK_ANONYMOUS, get_current_cred()))
  1966				continue;
  1967		}
  1968	
  1969		/* 2- remove stale listeners */
  1970		spin_lock_bh(&serv->sv_lock);
  1971		list_for_each_entry_safe(xprt, tmp_xprt, &serv->sv_permsocks,
  1972					 xpt_list) {
  1973			struct svc_xprt *rqt_xprt = NULL;
  1974	
  1975			nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
  1976				if (nla_type(attr) != NFSD_A_SERVER_LISTENER_INSTANCE)
  1977					continue;
  1978	
  1979				if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
  1980						     nfsd_server_instance_nl_policy,
  1981						     info->extack) < 0)
  1982					continue;
  1983	
  1984				if (!tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] ||
  1985				    !tb[NFSD_A_SERVER_INSTANCE_PORT])
  1986					continue;
  1987	
  1988				xcl_name = nla_data(
  1989					tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME]);
  1990				port = nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_PORT]);
  1991				if (port < 1 || port > USHRT_MAX)
  1992					continue;
  1993	
  1994				af = nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_INET_PROTO]);
  1995				if (af != PF_INET && af != PF_INET6)
  1996					continue;
  1997	
  1998				if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
  1999				    port == svc_xprt_local_port(xprt) &&
  2000				    af == xprt->xpt_local.ss_family &&
  2001				    xprt->xpt_net == net) {
  2002					rqt_xprt = xprt;
  2003					break;
  2004				}
  2005			}
  2006	
  2007			/* remove stale listener */
  2008			if (!rqt_xprt) {
  2009				spin_unlock_bh(&serv->sv_lock);
  2010				svc_xprt_close(xprt);
  2011				spin_lock_bh(&serv->sv_lock);
  2012			}
  2013		}
  2014		spin_unlock_bh(&serv->sv_lock);
  2015	
  2016		if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
> 2017			nfsd_destroy_serv(net);
  2018	
  2019		mutex_unlock(&nfsd_mutex);
  2020	
  2021		return 0;
  2022	}
  2023	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

