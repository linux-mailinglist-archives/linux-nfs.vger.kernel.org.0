Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD897E1103
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Nov 2023 21:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjKDU54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 4 Nov 2023 16:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjKDU54 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 4 Nov 2023 16:57:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37DD57;
        Sat,  4 Nov 2023 13:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699131473; x=1730667473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xD3w1bNL+ur9+6VloZbIWGyoZwPVfu1r5oIWJE+fszs=;
  b=dtYXgzXhcdAefqbJxyIqINK8OWAwtVztssehzC9Zls5ddH1zJ26j+aAn
   sEXTnvb607SFILfvqUzyhHv8jlDL3em+/32gNy9IV21pReNczz2XF+Au5
   FnShhTpiw+bidc0VnO3ZZnZSUPduo+6xyj42mR0IoewrS+QLq0ivnvbCu
   csB9Z8GzJsEVE5kZ5qvLxfNfiOsXRlOvO+jJWpJxZj74D9kOCgwpT4QUq
   FYbYEoNyvi4xaU4PAxMKkGEfkFtp9AQu5fGkwGV1uzUEXAAMLDLhQVDEQ
   /A+y11rTYo+glutiX93532jpwJhxTSJqt6PIXCh9i9ShJu++KuIFWJ8ys
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="386285112"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="386285112"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 13:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="905677787"
X-IronPort-AV: E=Sophos;i="6.03,278,1694761200"; 
   d="scan'208";a="905677787"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Nov 2023 13:57:50 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzNiG-0004gS-1P;
        Sat, 04 Nov 2023 20:57:48 +0000
Date:   Sun, 5 Nov 2023 04:56:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, lorenzo.bianconi@redhat.com,
        neilb@suse.de, chuck.lever@oracle.com, netdev@vger.kernel.org,
        jlayton@kernel.org, kuba@kernel.org
Subject: Re: [PATCH v4 3/3] NFSD: convert write_ports to netlink command
Message-ID: <202311050409.dPLvgiwN-lkp@intel.com>
References: <153b94db12b5c8fff270706673afffad5d84938c.1699095665.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153b94db12b5c8fff270706673afffad5d84938c.1699095665.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/153b94db12b5c8fff270706673afffad5d84938c.1699095665.git.lorenzo%40kernel.org
patch subject: [PATCH v4 3/3] NFSD: convert write_ports to netlink command
config: alpha-defconfig (https://download.01.org/0day-ci/archive/20231105/202311050409.dPLvgiwN-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311050409.dPLvgiwN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311050409.dPLvgiwN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/nfsd/nfsctl.c: In function 'nfsd_nl_listener_start_doit':
>> fs/nfsd/nfsctl.c:1877:13: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    1877 |         int ret;
         |             ^~~
--
   fs/nfsd/nfsctl.c:1819: warning: expecting prototype for nfsd_nl_version_get_doit(). Prototype was for nfsd_nl_version_get_dumpit() instead
>> fs/nfsd/nfsctl.c:1901: warning: expecting prototype for nfsd_nl_version_get_dumpit(). Prototype was for nfsd_nl_listener_get_dumpit() instead


vim +/ret +1877 fs/nfsd/nfsctl.c

  1867	
  1868	/**
  1869	 * nfsd_nl_listener_start_doit - start the provided nfs server listener
  1870	 * @skb: reply buffer
  1871	 * @info: netlink metadata and command arguments
  1872	 *
  1873	 * Return 0 on success or a negative errno.
  1874	 */
  1875	int nfsd_nl_listener_start_doit(struct sk_buff *skb, struct genl_info *info)
  1876	{
> 1877		int ret;
  1878	
  1879		if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME) ||
  1880		    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_PORT))
  1881			return -EINVAL;
  1882	
  1883		mutex_lock(&nfsd_mutex);
  1884		ret = ___write_ports_addxprt(genl_info_net(info), get_current_cred(),
  1885				nla_data(info->attrs[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME]),
  1886				nla_get_u32(info->attrs[NFSD_A_SERVER_LISTENER_PORT]));
  1887		mutex_unlock(&nfsd_mutex);
  1888	
  1889		return 0;
  1890	}
  1891	
  1892	/**
  1893	 * nfsd_nl_version_get_dumpit - Handle listener_get dumpit
  1894	 * @skb: reply buffer
  1895	 * @cb: netlink metadata and command arguments
  1896	 *
  1897	 * Returns the size of the reply or a negative errno.
  1898	 */
  1899	int nfsd_nl_listener_get_dumpit(struct sk_buff *skb,
  1900					struct netlink_callback *cb)
> 1901	{
  1902		struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
  1903		int i = 0, ret = -ENOMEM;
  1904		struct svc_xprt *xprt;
  1905		struct svc_serv *serv;
  1906	
  1907		mutex_lock(&nfsd_mutex);
  1908	
  1909		serv = nn->nfsd_serv;
  1910		if (!serv) {
  1911			mutex_unlock(&nfsd_mutex);
  1912			return 0;
  1913		}
  1914	
  1915		spin_lock_bh(&serv->sv_lock);
  1916		list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
  1917			void *hdr;
  1918	
  1919			if (i < cb->args[0]) /* already consumed */
  1920				continue;
  1921	
  1922			hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
  1923					  cb->nlh->nlmsg_seq, &nfsd_nl_family,
  1924					  0, NFSD_CMD_LISTENER_GET);
  1925			if (!hdr)
  1926				goto out;
  1927	
  1928			if (nla_put_string(skb, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME,
  1929					   xprt->xpt_class->xcl_name))
  1930				goto out;
  1931	
  1932			if (nla_put_u32(skb, NFSD_A_SERVER_LISTENER_PORT,
  1933					svc_xprt_local_port(xprt)))
  1934				goto out;
  1935	
  1936			genlmsg_end(skb, hdr);
  1937			i++;
  1938		}
  1939		cb->args[0] = i;
  1940		ret = skb->len;
  1941	out:
  1942		spin_unlock_bh(&serv->sv_lock);
  1943	
  1944		mutex_unlock(&nfsd_mutex);
  1945	
  1946		return ret;
  1947	}
  1948	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
