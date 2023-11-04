Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446837E1036
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Nov 2023 17:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjKDQBv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Nov 2023 12:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKDQBv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Nov 2023 12:01:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA59D;
        Sat,  4 Nov 2023 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699113708; x=1730649708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z0TvjFW6shOaVrj/gHyQGZOL1wvBmK+eISB4Yp325Ps=;
  b=U8Usw6VDfMRsfFLIVWfhS2fN1pJm+ChIlNXYIZBbUvr2Vup7zjHjvZWj
   F50fUlv0I7Mtbd7EVmymmovBRwKGD0mMxguj7QfPnK8STMMoVZZnz7bm5
   VQpi5saZX6GmqfMJra+Th929D0nqXmmyTmZ6mapMr+/v/TmVDOJ2ORUBB
   U/7ANGtntI07JSh+rRpVEgEsEXaCbEyTSTuDRmtKlVjCf/spIyDOBIArE
   KQX4NU1NoqX37UpgoJt8TvfgWmUGi/gaZzaQCIyu71Xl726ljpvORolIR
   NL5MTxsFfgxBgT224lPEJZyX6KYM3utBc7eE9p07HzaLCJR2UP2/hcsyI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="391964109"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="391964109"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 09:01:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="852557303"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="852557303"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Nov 2023 09:01:45 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzJ5j-0004Wi-1F;
        Sat, 04 Nov 2023 16:01:43 +0000
Date:   Sun, 5 Nov 2023 00:01:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
        neilb@suse.de, chuck.lever@oracle.com, netdev@vger.kernel.org,
        jlayton@kernel.org, kuba@kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: convert write_version to netlink command
Message-ID: <202311042320.nQOTYxhs-lkp@intel.com>
References: <3785da26e14c13e194510eaad9c6bd846d691d5f.1699095665.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3785da26e14c13e194510eaad9c6bd846d691d5f.1699095665.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Lorenzo,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20231103]
[cannot apply to trondmy-nfs/linux-next v6.6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/NFSD-convert-write_threads-to-netlink-command/20231104-202515
base:   linus/master
patch link:    https://lore.kernel.org/r/3785da26e14c13e194510eaad9c6bd846d691d5f.1699095665.git.lorenzo%40kernel.org
patch subject: [PATCH v4 2/3] NFSD: convert write_version to netlink command
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20231104/202311042320.nQOTYxhs-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311042320.nQOTYxhs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311042320.nQOTYxhs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfsd/nfsctl.c:1810: warning: expecting prototype for nfsd_nl_version_get_doit(). Prototype was for nfsd_nl_version_get_dumpit() instead


vim +1810 fs/nfsd/nfsctl.c

  1800	
  1801	/**
  1802	 * nfsd_nl_version_get_doit - Handle verion_get dumpit
  1803	 * @skb: reply buffer
  1804	 * @cb: netlink metadata and command arguments
  1805	 *
  1806	 * Returns the size of the reply or a negative errno.
  1807	 */
  1808	int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
  1809				       struct netlink_callback *cb)
> 1810	{
  1811		struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
  1812		int i, ret = -ENOMEM;
  1813	
  1814		mutex_lock(&nfsd_mutex);
  1815	
  1816		for (i = 2; i <= 4; i++) {
  1817			int j;
  1818	
  1819			if (i < cb->args[0]) /* already consumed */
  1820				continue;
  1821	
  1822			if (!nfsd_vers(nn, i, NFSD_AVAIL))
  1823				continue;
  1824	
  1825			for (j = 0; j <= NFSD_SUPPORTED_MINOR_VERSION; j++) {
  1826				void *hdr;
  1827	
  1828				if (!nfsd_vers(nn, i, NFSD_TEST))
  1829					continue;
  1830	
  1831				/* NFSv{2,3} does not support minor numbers */
  1832				if (i < 4 && j)
  1833					continue;
  1834	
  1835				if (i == 4 && !nfsd_minorversion(nn, j, NFSD_TEST))
  1836					continue;
  1837	
  1838				hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
  1839						  cb->nlh->nlmsg_seq, &nfsd_nl_family,
  1840						  0, NFSD_CMD_VERSION_GET);
  1841				if (!hdr)
  1842					goto out;
  1843	
  1844				if (nla_put_u32(skb, NFSD_A_SERVER_VERSION_MAJOR, i) ||
  1845				    nla_put_u32(skb, NFSD_A_SERVER_VERSION_MINOR, j))
  1846					goto out;
  1847	
  1848				genlmsg_end(skb, hdr);
  1849			}
  1850		}
  1851		cb->args[0] = i;
  1852		ret = skb->len;
  1853	out:
  1854		mutex_unlock(&nfsd_mutex);
  1855	
  1856		return ret;
  1857	}
  1858	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
