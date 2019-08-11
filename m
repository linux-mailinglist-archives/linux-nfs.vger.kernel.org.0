Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629448900B
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2019 09:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfHKHBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Aug 2019 03:01:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:15559 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfHKHBm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 11 Aug 2019 03:01:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 00:01:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,372,1559545200"; 
   d="scan'208";a="166412149"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2019 00:01:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hwhrH-000Isl-Fo; Sun, 11 Aug 2019 15:01:39 +0800
Date:   Sun, 11 Aug 2019 15:00:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     kbuild-all@01.org, bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 2/9] NFSD add ca_source_server<> to COPY
Message-ID: <201908111439.mdZo43XD%lkp@intel.com>
References: <20190808201848.36640-3-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808201848.36640-3-olga.kornievskaia@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Olga,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on nfsd/nfsd-next]
[cannot apply to v5.3-rc3 next-20190809]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Olga-Kornievskaia/server-side-support-for-inter-SSC-copy/20190811-120551
base:   git://linux-nfs.org/~bfields/linux.git nfsd-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   include/linux/sched.h:609:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:609:73: sparse: sparse: invalid named zero-width bitfield `value'
   include/linux/sched.h:610:43: sparse: sparse: bad integer constant expression
   include/linux/sched.h:610:67: sparse: sparse: invalid named zero-width bitfield `bucket_id'
   fs/nfsd/nfs4xdr.c:1743:11: sparse: sparse: using member 'nl4_type' in incomplete struct nl4_server
   fs/nfsd/nfs4xdr.c:1746:19: sparse: sparse: using member 'nl4_type' in incomplete struct nl4_server
   fs/nfsd/nfs4xdr.c:1747:14: sparse: sparse: undefined identifier 'NL4_NETADDR'
   fs/nfsd/nfs4xdr.c:1748:28: sparse: sparse: using member 'u' in incomplete struct nl4_server
   fs/nfsd/nfs4xdr.c:1751:22: sparse: sparse: using member 'netid_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1752:26: sparse: sparse: using member 'netid_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1755:17: sparse: sparse: using member 'netid_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1755:17: sparse: sparse: using member 'netid_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1755:17: sparse: sparse: using member 'netid_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1756:17: sparse: sparse: using member 'netid' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1756:17: sparse: sparse: using member 'netid_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1758:22: sparse: sparse: using member 'addr_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1759:26: sparse: sparse: using member 'addr_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1762:17: sparse: sparse: using member 'addr_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1762:17: sparse: sparse: using member 'addr_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1762:17: sparse: sparse: using member 'addr_len' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1763:17: sparse: sparse: using member 'addr' in incomplete struct nfs42_netaddr
   fs/nfsd/nfs4xdr.c:1763:17: sparse: sparse: using member 'addr_len' in incomplete struct nfs42_netaddr
>> fs/nfsd/nfs4xdr.c:1747:14: sparse: sparse: incompatible types for 'case' statement
   fs/nfsd/nfs4xdr.c:1747:14: sparse: sparse: Expected constant expression in case statement

vim +/case +1747 fs/nfsd/nfs4xdr.c

  1735	
  1736	static __be32 nfsd4_decode_nl4_server(struct nfsd4_compoundargs *argp,
  1737					      struct nl4_server *ns)
  1738	{
  1739		DECODE_HEAD;
  1740		struct nfs42_netaddr *naddr;
  1741	
  1742		READ_BUF(4);
  1743		ns->nl4_type = be32_to_cpup(p++);
  1744	
  1745		/* currently support for 1 inter-server source server */
  1746		switch (ns->nl4_type) {
> 1747		case NL4_NETADDR:
  1748			naddr = &ns->u.nl4_addr;
  1749	
  1750			READ_BUF(4);
  1751			naddr->netid_len = be32_to_cpup(p++);
  1752			if (naddr->netid_len > RPCBIND_MAXNETIDLEN)
  1753				goto xdr_error;
  1754	
  1755			READ_BUF(naddr->netid_len + 4); /* 4 for uaddr len */
> 1756			COPYMEM(naddr->netid, naddr->netid_len);
  1757	
  1758			naddr->addr_len = be32_to_cpup(p++);
  1759			if (naddr->addr_len > RPCBIND_MAXUADDRLEN)
  1760				goto xdr_error;
  1761	
  1762			READ_BUF(naddr->addr_len);
  1763			COPYMEM(naddr->addr, naddr->addr_len);
  1764			break;
  1765		default:
  1766			goto xdr_error;
  1767		}
  1768		DECODE_TAIL;
  1769	}
  1770	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
