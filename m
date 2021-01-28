Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58AA3079EC
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jan 2021 16:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhA1PiB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jan 2021 10:38:01 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47806 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhA1Phy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jan 2021 10:37:54 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SFIptg161799;
        Thu, 28 Jan 2021 15:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=21VLjNvM302lRR/6cnbJgfLuEvCdqWx+uAOjYilyyBg=;
 b=0afOxSFUaB7KxA8NfhXtoo2CmgT9tpwzGJbs22nnVK7qCFiyv5c8vNkJG0D+ffcngkv0
 t/29K7w45uj7FTHunO4GDNEBujk1G/5p4aoUQa77EZOqtLk0tLcg+apklC1lmv9KEqrj
 5+uDaia69TST3EBZ14oIjv5m+JCS+0XVix3gqWEMHj/ODdqTMvzHbd9GPPfsk+e84m5d
 6KzIBzYBzNm0jRyLvPpdpdobxlgjxbAWPhQT4vnYxILka2ydjq7UX06BTBt65ZptGzN9
 iIba781syil/VvPM2g3XCg5TEpLiOk9HssxDEzhcXmLrYe7TWreSJgO0mpc2uVMYEmMk kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 368brkvnfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 15:37:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SFKd7h029971;
        Thu, 28 Jan 2021 15:35:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 368wq1u4gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 15:35:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10SFZ4kG013685;
        Thu, 28 Jan 2021 15:35:04 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jan 2021 07:35:03 -0800
Date:   Thu, 28 Jan 2021 18:34:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] nfsd: fix check of statid returned from call to
 find_stateid_by_type
Message-ID: <20210128153456.GI2696@kadam>
References: <20210128144935.640026-1-colin.king@canonical.com>
 <793C88A3-B117-4138-B74A-845E0BD383C9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <793C88A3-B117-4138-B74A-845E0BD383C9@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280079
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280079
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jan 28, 2021 at 03:05:06PM +0000, Chuck Lever wrote:
> Hi Colin-
> 
> > On Jan 28, 2021, at 9:49 AM, Colin King <colin.king@canonical.com> wrote:
> > 
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The call to find_stateid_by_type is setting the return value in *stid
> > yet the NULL check of the return is checking stid instead of *stid.
> > Fix this by adding in the missing pointer * operator.
> > 
> > Addresses-Coverity: ("Dereference before null check")
> > Fixes: 6cdaa72d4dde ("nfsd: find_cpntf_state cleanup")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Thanks for your patch. I've committed it to the for-next branch at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> 
> in preparation for the v5.12 merge window, with the following changes:
> 
> - ^statid^stateid
> - Fixes: tag removed, since no stable backport is necessary
> 
> The commit you are fixing has not been merged upstream yet.

Fixes tags don't meant the patch has to be backported.  Is your tree
rebased?  In that case, the fixes tag probably doesn't make sense
because the tag can change.  You might want to just consider folding
Colin's fix into the original commit.

Fixes tags are used for a lot of different things:
1)  If there is a fixes tag, then you can tell it does *NOT* have to
    be back ported because the original commit is not in the stable
    tree.  It saves time for the stable maintainers.
2)  Metrics to figure out how quickly we are fixing bugs.
3)  Sometimes the Fixes tag helps because we want to review the original
    patch to see what the intent was.

All sorts of stuff.  Etc.

regards,
dan carpenter

