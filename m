Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7927183161
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 14:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCLN21 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 09:28:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:11090 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgCLN21 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Mar 2020 09:28:27 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 06:28:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="277798906"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 Mar 2020 06:28:25 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jCNsu-000Cx1-O9; Thu, 12 Mar 2020 21:28:24 +0800
Date:   Thu, 12 Mar 2020 21:28:11 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     kbuild-all@lists.01.org, bfields@fieldses.org,
        chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 11/14] nfsd: add user xattr RPC XDR encoding/decoding
 logic
Message-ID: <202003122103.Fb2JQy2Z%lkp@intel.com>
References: <20200311195954.27117-12-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311195954.27117-12-fllinden@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Frank,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on nfsd/nfsd-next]
[also build test WARNING on nfs/linux-next linus/master v5.6-rc5 next-20200312]
[cannot apply to cel/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Frank-van-der-Linden/server-side-user-xattr-support-RFC-8276/20200312-064928
base:   git://linux-nfs.org/~bfields/linux.git nfsd-next
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-174-g094d5a94-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   fs/nfsd/nfs4xdr.c:1860:16: sparse: sparse: incorrect type in assignment (different base types) @@    expected int status @@    got restricted __int status @@
   fs/nfsd/nfs4xdr.c:1860:16: sparse:    expected int status
   fs/nfsd/nfs4xdr.c:1860:16: sparse:    got restricted __be32
   fs/nfsd/nfs4xdr.c:1862:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got be32 @@
   fs/nfsd/nfs4xdr.c:1862:24: sparse:    expected restricted __be32
   fs/nfsd/nfs4xdr.c:1862:24: sparse:    got int status
>> fs/nfsd/nfs4xdr.c:1913:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected int @@    got restricted __be32 [usertypint @@
>> fs/nfsd/nfs4xdr.c:1913:24: sparse:    expected int
>> fs/nfsd/nfs4xdr.c:1913:24: sparse:    got restricted __be32 [usertype]
   fs/nfsd/nfs4xdr.c:1949:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected int @@    got restricted __be32 [usertypint @@
   fs/nfsd/nfs4xdr.c:1949:24: sparse:    expected int
   fs/nfsd/nfs4xdr.c:1949:24: sparse:    got restricted __be32 [usertype]
   fs/nfsd/nfs4xdr.c:1958:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected int @@    got restricted __be32 [usertypint @@
   fs/nfsd/nfs4xdr.c:1958:24: sparse:    expected int
   fs/nfsd/nfs4xdr.c:1958:24: sparse:    got restricted __be32 [usertype]
>> fs/nfsd/nfs4xdr.c:1979:9: sparse: sparse: incorrect type in return expression (different base types) @@    expected int @@    got restricted __be32 [assigned] [usertypint @@
   fs/nfsd/nfs4xdr.c:1979:9: sparse:    expected int
>> fs/nfsd/nfs4xdr.c:1979:9: sparse:    got restricted __be32 [assigned] [usertype] status
>> fs/nfsd/nfs4xdr.c:1997:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got stricted __be32 @@
   fs/nfsd/nfs4xdr.c:1997:24: sparse:    expected restricted __be32
>> fs/nfsd/nfs4xdr.c:1997:24: sparse:    got int [assigned] status
>> fs/nfsd/nfs4xdr.c:2004:24: sparse: sparse: incorrect type in assignment (different base types) @@    expected int [assigned] status @@    got restricted __bint [assigned] status @@
>> fs/nfsd/nfs4xdr.c:2004:24: sparse:    expected int [assigned] status
   fs/nfsd/nfs4xdr.c:2004:24: sparse:    got restricted __be32 [usertype]
   fs/nfsd/nfs4xdr.c:2007:16: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got stricted __be32 @@
   fs/nfsd/nfs4xdr.c:2007:16: sparse:    expected restricted __be32
   fs/nfsd/nfs4xdr.c:2007:16: sparse:    got int [assigned] status
>> fs/nfsd/nfs4xdr.c:2026:16: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __be32 [usertype] status @@    got e] status @@
>> fs/nfsd/nfs4xdr.c:2026:16: sparse:    expected restricted __be32 [usertype] status
>> fs/nfsd/nfs4xdr.c:2026:16: sparse:    got int
>> fs/nfsd/nfs4xdr.c:2044:24: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __be32 [assigned] [usertype] status @@    got e] status @@
>> fs/nfsd/nfs4xdr.c:2044:24: sparse:    expected restricted __be32 [assigned] [usertype] status
   fs/nfsd/nfs4xdr.c:2044:24: sparse:    got int
>> fs/nfsd/nfs4xdr.c:2097:39: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got e32 @@
   fs/nfsd/nfs4xdr.c:2097:39: sparse:    expected restricted __be32
   fs/nfsd/nfs4xdr.c:2097:39: sparse:    got int
   fs/nfsd/nfs4xdr.c:4698:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected int @@    got restricted __be32 [usertypint @@
   fs/nfsd/nfs4xdr.c:4698:24: sparse:    expected int
   fs/nfsd/nfs4xdr.c:4698:24: sparse:    got restricted __be32 [usertype]
   fs/nfsd/nfs4xdr.c:4708:32: sparse: sparse: incorrect type in return expression (different base types) @@    expected int @@    got restricted __be32 [usertypint @@
   fs/nfsd/nfs4xdr.c:4708:32: sparse:    expected int
   fs/nfsd/nfs4xdr.c:4708:32: sparse:    got restricted __be32 [usertype]
   fs/nfsd/nfs4xdr.c:4745:36: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got e32 @@
   fs/nfsd/nfs4xdr.c:4745:36: sparse:    expected restricted __be32
   fs/nfsd/nfs4xdr.c:4745:36: sparse:    got int
   fs/nfsd/nfs4xdr.c:4780:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected int @@    got restricted __be32 [usertypint @@
   fs/nfsd/nfs4xdr.c:4780:24: sparse:    expected int
   fs/nfsd/nfs4xdr.c:4780:24: sparse:    got restricted __be32 [usertype]
   fs/nfsd/nfs4xdr.c:4784:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected int @@    got restricted __be32 [usertypint @@
   fs/nfsd/nfs4xdr.c:4784:24: sparse:    expected int
   fs/nfsd/nfs4xdr.c:4784:24: sparse:    got restricted __be32 [usertype]
   fs/nfsd/nfs4xdr.c:4808:24: sparse: sparse: incorrect type in return expression (different base types) @@    expected restricted __be32 @@    got stricted __be32 @@
   fs/nfsd/nfs4xdr.c:4808:24: sparse:    expected restricted __be32
   fs/nfsd/nfs4xdr.c:4808:24: sparse:    got int [assigned] status
>> fs/nfsd/nfs4xdr.c:4884:15: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [assigned] [usertype] count @@    got ed int [assigned] [usertype] count @@
>> fs/nfsd/nfs4xdr.c:4884:15: sparse:    expected unsigned int [assigned] [usertype] count
   fs/nfsd/nfs4xdr.c:4884:15: sparse:    got restricted __be32 [usertype]

vim +1913 fs/nfsd/nfs4xdr.c

  1881	
  1882	/*
  1883	 * XDR data that is more than PAGE_SIZE in size is normally part of a
  1884	 * read or write. However, the size of extended attributes is limited
  1885	 * by the maximum request size, and then further limited by the underlying
  1886	 * filesystem limits. This can exceed PAGE_SIZE (currently, XATTR_SIZE_MAX
  1887	 * is 64k). Since there is no kvec- or page-based interface to xattrs,
  1888	 * and we're not dealing with contiguous pages, we need to do some copying.
  1889	 */
  1890	
  1891	/*
  1892	 * Decode int to buffer. Uses head and pages constructed by
  1893	 * svcxdr_construct_vector.
  1894	 */
  1895	static int
  1896	nfsd4_vbuf_from_stream(struct nfsd4_compoundargs *argp, struct kvec *head,
  1897			       struct page **pages, char **bufp, u32 buflen)
  1898	{
  1899		char *tmp, *dp;
  1900		u32 len;
  1901	
  1902		if (buflen <= head->iov_len) {
  1903			/*
  1904			 * We're in luck, the head has enough space. Just return
  1905			 * the head, no need for copying.
  1906			 */
  1907			*bufp = head->iov_base;
  1908			return 0;
  1909		}
  1910	
  1911		tmp = svcxdr_tmpalloc(argp, buflen);
  1912		if (tmp == NULL)
> 1913			return nfserr_jukebox;
  1914	
  1915		dp = tmp;
  1916		memcpy(dp, head->iov_base, head->iov_len);
  1917		buflen -= head->iov_len;
  1918		dp += head->iov_len;
  1919	
  1920		while (buflen > 0) {
  1921			len = min_t(u32, buflen, PAGE_SIZE);
  1922			memcpy(dp, page_address(*pages), len);
  1923	
  1924			buflen -= len;
  1925			dp += len;
  1926			pages++;
  1927		}
  1928	
  1929		*bufp = tmp;
  1930		return 0;
  1931	}
  1932	
  1933	/*
  1934	 * Get a user extended attribute name from the XDR buffer.
  1935	 * It will not have the "user." prefix, so prepend it.
  1936	 * Lastly, check for nul characters in the name.
  1937	 */
  1938	static int
  1939	nfsd4_decode_xattr_name(struct nfsd4_compoundargs *argp, char **namep)
  1940	{
  1941		DECODE_HEAD;
  1942		char *name, *sp, *dp;
  1943		u32 namelen, cnt;
  1944	
  1945		READ_BUF(4);
  1946		namelen = be32_to_cpup(p++);
  1947	
  1948		if (namelen > (XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN))
  1949			return nfserr_nametoolong;
  1950	
  1951		if (namelen == 0)
  1952			goto xdr_error;
  1953	
  1954		READ_BUF(namelen);
  1955	
  1956		name = svcxdr_tmpalloc(argp, namelen + XATTR_USER_PREFIX_LEN + 1);
  1957		if (!name)
  1958			return nfserr_jukebox;
  1959	
  1960		memcpy(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
  1961	
  1962		/*
  1963		 * Copy the extended attribute name over while checking for 0
  1964		 * characters.
  1965		 */
  1966		sp = (char *)p;
  1967		dp = name + XATTR_USER_PREFIX_LEN;
  1968		cnt = namelen;
  1969	
  1970		while (cnt-- > 0) {
  1971			if (*sp == '\0')
  1972				goto xdr_error;
  1973			*dp++ = *sp++;
  1974		}
  1975		*dp = '\0';
  1976	
  1977		*namep = name;
  1978	
> 1979		DECODE_TAIL;
  1980	}
  1981	
  1982	/*
  1983	 * A GETXATTR op request comes without a length specifier. We just set the
  1984	 * maximum length for the reply based on XATTR_SIZE_MAX and the maximum
  1985	 * channel reply size, allocate a buffer of that length and pass it to
  1986	 * vfs_getxattr.
  1987	 */
  1988	static __be32
  1989	nfsd4_decode_getxattr(struct nfsd4_compoundargs *argp,
  1990			      struct nfsd4_getxattr *getxattr)
  1991	{
  1992		int status;
  1993		u32 maxcount;
  1994	
  1995		status = nfsd4_decode_xattr_name(argp, &getxattr->getxa_name);
  1996		if (status)
> 1997			return status;
  1998	
  1999		maxcount = svc_max_payload(argp->rqstp);
  2000		maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
  2001	
  2002		getxattr->getxa_buf = svcxdr_tmpalloc(argp, maxcount);
  2003		if (!getxattr->getxa_buf)
> 2004			status = nfserr_jukebox;
  2005		getxattr->getxa_len = maxcount;
  2006	
  2007		return status;
  2008	}
  2009	
  2010	static __be32
  2011	nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
  2012			      struct nfsd4_setxattr *setxattr)
  2013	{
  2014		DECODE_HEAD;
  2015		u32 flags, maxcount, size;
  2016		struct kvec head;
  2017		struct page **pagelist;
  2018	
  2019		READ_BUF(4);
  2020		flags = be32_to_cpup(p++);
  2021	
  2022		if (flags > SETXATTR4_REPLACE)
  2023			return nfserr_inval;
  2024		setxattr->setxa_flags = flags;
  2025	
> 2026		status = nfsd4_decode_xattr_name(argp, &setxattr->setxa_name);
  2027		if (status)
  2028			return status;
  2029	
  2030		maxcount = svc_max_payload(argp->rqstp);
  2031		maxcount = min_t(u32, XATTR_SIZE_MAX, maxcount);
  2032	
  2033		READ_BUF(4);
  2034		size = be32_to_cpup(p++);
  2035		if (size > maxcount)
  2036			return nfserr_xattr2big;
  2037	
  2038		setxattr->setxa_len = size;
  2039		if (size > 0) {
  2040			status = svcxdr_construct_vector(argp, &head, &pagelist, size);
  2041			if (status)
  2042				return status;
  2043	
> 2044			status = nfsd4_vbuf_from_stream(argp, &head, pagelist,
  2045			    &setxattr->setxa_buf, size);
  2046		}
  2047	
  2048		DECODE_TAIL;
  2049	}
  2050	
  2051	static __be32
  2052	nfsd4_decode_listxattrs(struct nfsd4_compoundargs *argp,
  2053				struct nfsd4_listxattrs *listxattrs)
  2054	{
  2055		DECODE_HEAD;
  2056		u32 maxcount;
  2057	
  2058		READ_BUF(12);
  2059		p = xdr_decode_hyper(p, &listxattrs->lsxa_cookie);
  2060	
  2061		/*
  2062		 * If the cookie  is too large to have even one user.x attribute
  2063		 * plus trailing '\0' left in a maximum size buffer, it's invalid.
  2064		 */
  2065		if (listxattrs->lsxa_cookie >=
  2066		    (XATTR_LIST_MAX / (XATTR_USER_PREFIX_LEN + 2)))
  2067			return nfserr_badcookie;
  2068	
  2069		maxcount = be32_to_cpup(p++);
  2070		if (maxcount < 8)
  2071			/* Always need at least 2 words (length and one character) */
  2072			return nfserr_inval;
  2073	
  2074		maxcount = min(maxcount, svc_max_payload(argp->rqstp));
  2075		listxattrs->lsxa_maxcount = maxcount;
  2076	
  2077		/*
  2078		 * Unfortunately, there is no interface to only list xattrs for
  2079		 * one prefix. So there is no good way to convert maxcount to
  2080		 * a maximum value to pass to vfs_listxattr, as we don't know
  2081		 * how many of the returned attributes will be user attributes.
  2082		 *
  2083		 * So, always ask vfs_listxattr for the maximum size, and encode
  2084		 * as many as possible.
  2085		 */
  2086		listxattrs->lsxa_buf = svcxdr_tmpalloc(argp, XATTR_LIST_MAX);
  2087		if (!listxattrs->lsxa_buf)
  2088			status = nfserr_jukebox;
  2089	
  2090		DECODE_TAIL;
  2091	}
  2092	
  2093	static __be32
  2094	nfsd4_decode_removexattr(struct nfsd4_compoundargs *argp,
  2095				 struct nfsd4_removexattr *removexattr)
  2096	{
> 2097		return nfsd4_decode_xattr_name(argp, &removexattr->rmxa_name);
  2098	}
  2099	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
