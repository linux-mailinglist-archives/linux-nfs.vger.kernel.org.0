Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924763B44A3
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Jun 2021 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFYNki (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Jun 2021 09:40:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52786 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229615AbhFYNkg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Jun 2021 09:40:36 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15PDbJke003492;
        Fri, 25 Jun 2021 13:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=ZI+dD/tJ40mx8OrHqJr/VRR+/Kj6rLgw+Qzusipc/J4=;
 b=T2Dgkk+gM+5CaU2VR0WRyT5Fs+/1biygG1ej4Sg5flPMev2M9hZKJ/jqfHS7ZanOvjEZ
 5C9+pxXHO5ozE6ps37E61Wo/U+bdZMX3fQ0qe1tvt3UARcS+PbbjuRamU5IgFcIbTeS5
 aRy+6dEx9Yny4X1sdp7BdLTq2pKJe7LvveUkyFBqhfd26Rjso94LMmIWgt4y78ZsPcNW
 OQEOVXM2UZpQsaYimF0PlFwBOcbiB6yHXGPnFU6Jie3jjsQ6A9h7paDMgWRKd3nHtUSq
 RBTVPQZQ3PK79Bl1YVcAhvv1tDfhjaF+IL5Pf9P6rATVUCK22jk684Em/1lZuDF9r0fD tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39d2ahsbjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 13:38:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15PDZrcp135931;
        Fri, 25 Jun 2021 13:38:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39d243h79s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 13:38:05 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15PDc4PL143007;
        Fri, 25 Jun 2021 13:38:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 39d243h78m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Jun 2021 13:38:04 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15PDbxT6023763;
        Fri, 25 Jun 2021 13:37:59 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 25 Jun 2021 06:37:58 -0700
Date:   Fri, 25 Jun 2021 16:37:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Cc:     lkp@intel.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/rfc] NFS: introduce NFS namespaces.
Message-ID: <202106252106.UEbAG2Yp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162458475606.28671.1835069742861755259@noble.neil.brown.name>
C:      kbuild-all@lists.01.org
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: _RgGWDgDHEFW3ySJs9bxzJtwzVt-gVYk
X-Proofpoint-GUID: _RgGWDgDHEFW3ySJs9bxzJtwzVt-gVYk
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi NeilBrown,

url:    https://github.com/0day-ci/linux/commits/NeilBrown/NFS-introduce-NFS-namespaces/20210625-093359
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: x86_64-randconfig-m001-20210622 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/nfs/nfs4proc.c:6270 nfs4_init_uniform_client_string() error: we previously assumed 'clp->cl_namespace' could be null (see line 6247)

Old smatch warnings:
fs/nfs/nfs4proc.c:1382 nfs4_opendata_alloc() error: we previously assumed 'c' could be null (see line 1350)

vim +6270 fs/nfs/nfs4proc.c

873e385116b2cc Jeff Layton     2015-06-09  6234  static int
873e385116b2cc Jeff Layton     2015-06-09  6235  nfs4_init_uniform_client_string(struct nfs_client *clp)
873e385116b2cc Jeff Layton     2015-06-09  6236  {
1aee551334cda1 Trond Myklebust 2020-10-07  6237  	char buf[NFS4_CLIENT_ID_UNIQ_LEN];
1aee551334cda1 Trond Myklebust 2020-10-07  6238  	size_t buflen;
873e385116b2cc Jeff Layton     2015-06-09  6239  	size_t len;
873e385116b2cc Jeff Layton     2015-06-09  6240  	char *str;
ceb3a16c070c40 Trond Myklebust 2015-01-03  6241  
ceb3a16c070c40 Trond Myklebust 2015-01-03  6242  	if (clp->cl_owner_id != NULL)
873e385116b2cc Jeff Layton     2015-06-09  6243  		return 0;
6f2ea7f2a3ff3c Chuck Lever     2012-09-14  6244  
873e385116b2cc Jeff Layton     2015-06-09  6245  	len = 10 + 10 + 1 + 10 + 1 +
873e385116b2cc Jeff Layton     2015-06-09  6246  		strlen(clp->cl_rpcclient->cl_nodename) + 1;
0575ca34891617 NeilBrown       2021-06-25 @6247  	if (clp->cl_namespace)
                                                        ^^^^^^^^^^^^^^^^^^^^^^
Checks for NULL

0575ca34891617 NeilBrown       2021-06-25  6248  		len += strlen(clp->cl_namespace) + 1;
873e385116b2cc Jeff Layton     2015-06-09  6249  
39d43d164127da Trond Myklebust 2020-10-07  6250  	buflen = nfs4_get_uniquifier(clp, buf, sizeof(buf));
1aee551334cda1 Trond Myklebust 2020-10-07  6251  	if (buflen)
1aee551334cda1 Trond Myklebust 2020-10-07  6252  		len += buflen + 1;
1aee551334cda1 Trond Myklebust 2020-10-07  6253  
873e385116b2cc Jeff Layton     2015-06-09  6254  	if (len > NFS4_OPAQUE_LIMIT + 1)
873e385116b2cc Jeff Layton     2015-06-09  6255  		return -EINVAL;
873e385116b2cc Jeff Layton     2015-06-09  6256  
873e385116b2cc Jeff Layton     2015-06-09  6257  	/*
873e385116b2cc Jeff Layton     2015-06-09  6258  	 * Since this string is allocated at mount time, and held until the
873e385116b2cc Jeff Layton     2015-06-09  6259  	 * nfs_client is destroyed, we can use GFP_KERNEL here w/o worrying
873e385116b2cc Jeff Layton     2015-06-09  6260  	 * about a memory-reclaim deadlock.
873e385116b2cc Jeff Layton     2015-06-09  6261  	 */
873e385116b2cc Jeff Layton     2015-06-09  6262  	str = kmalloc(len, GFP_KERNEL);
873e385116b2cc Jeff Layton     2015-06-09  6263  	if (!str)
873e385116b2cc Jeff Layton     2015-06-09  6264  		return -ENOMEM;
873e385116b2cc Jeff Layton     2015-06-09  6265  
1aee551334cda1 Trond Myklebust 2020-10-07  6266  	if (buflen)
0575ca34891617 NeilBrown       2021-06-25  6267  		scnprintf(str, len, "Linux NFSv%u.%u %s/%s%s%s",
1aee551334cda1 Trond Myklebust 2020-10-07  6268  			  clp->rpc_ops->version, clp->cl_minorversion,
0575ca34891617 NeilBrown       2021-06-25  6269  			  buf, clp->cl_rpcclient->cl_nodename,
0575ca34891617 NeilBrown       2021-06-25 @6270  			  *clp->cl_namespace ? "/" : "",
                                                                          ^^^^^^^^^^^^^^^^^^
Unchecked dereference

0575ca34891617 NeilBrown       2021-06-25  6271  			  clp->cl_namespace);
1aee551334cda1 Trond Myklebust 2020-10-07  6272  	else
0575ca34891617 NeilBrown       2021-06-25  6273  		scnprintf(str, len, "Linux NFSv%u.%u %s%s%s",
e984a55a7418f7 Chuck Lever     2012-09-14  6274  			  clp->rpc_ops->version, clp->cl_minorversion,
0575ca34891617 NeilBrown       2021-06-25  6275  			  clp->cl_rpcclient->cl_nodename,
0575ca34891617 NeilBrown       2021-06-25  6276  			  *clp->cl_namespace ? "/" : "",
                                                                          ^^^^^^^^^^^^^^^^^^
Unchecked dereference

0575ca34891617 NeilBrown       2021-06-25  6277  			  clp->cl_namespace);
873e385116b2cc Jeff Layton     2015-06-09  6278  	clp->cl_owner_id = str;
873e385116b2cc Jeff Layton     2015-06-09  6279  	return 0;
e984a55a7418f7 Chuck Lever     2012-09-14  6280  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

