Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A17EC508
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Nov 2019 15:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfKAOuB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 Nov 2019 10:50:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51954 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfKAOuB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 Nov 2019 10:50:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1Emkb9163690;
        Fri, 1 Nov 2019 14:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=b/zsX7xacin0Z3COe7oVyGWvFG2k0RA9kiXi2XBFznQ=;
 b=WgUzmNLs7VBxNg9uI6rVQprNhCqjhZCJwOL5YfYMxfICPNuE5PLZC2ZmxYP4fGyYNtru
 /CSbxn73QhZUi5Lc4pgqXcJ/rPP3MWAS+3IduTdPh4zy8+wuw6bhkboWaau6+Rr6DpsF
 UMBMWu4bvt4A/tiPrl0s9Vp17sXsJytLSWX1eVG9MWsA6OqA2E2nyCMIY3VACiCOc24w
 +yse3irkV/0mvVH63Jqg5gsDn8J4z48/REj3RihTJZYC6H4CnyrEAsWM/7X6d8oda94P
 NpfWy/3uamQktdIXAgheP9SR7Hibpxq8CPWSvidfgsLu9y7U7g7TX7t3+YkVoC2L68iU cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vxwhftcax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 14:49:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA1Em4F5020552;
        Fri, 1 Nov 2019 14:49:31 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2vyqpgbmky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Nov 2019 14:49:31 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA1EnTiP011122;
        Fri, 1 Nov 2019 14:49:29 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Nov 2019 07:49:28 -0700
Date:   Fri, 1 Nov 2019 17:49:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Mao Wenan <maowenan@huawei.com>, Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Dros Adamson <dros@primarydata.com>,
        jeff.layton@primarydata.com, richard.sharpe@primarydata.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] nfsd: Drop LIST_HEAD where the variable it
 declares is never used.
Message-ID: <20191101144921.GA10409@kadam>
References: <20191101114054.50225-1-maowenan@huawei.com>
 <7E1B5E17-FF35-472B-8316-D4C01085BAE4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E1B5E17-FF35-472B-8316-D4C01085BAE4@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=945
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911010148
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9427 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911010149
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 01, 2019 at 09:36:27AM -0400, Chuck Lever wrote:
> Hi Mao-
> 
> > On Nov 1, 2019, at 7:40 AM, Mao Wenan <maowenan@huawei.com> wrote:
> > 
> > The declarations were introduced with the file, but the declared
> > variables were not used.
> > 
> > Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
> 
> I'm not sure a Fixes: tag is necessary here? 65294c1f2c5e
> works fine without this change, and it's not something we
> would need to backport into stable kernels.
> 
> This is more of a clean up patch.
> 

Fixes is not really related to backports or stable.  I would agree that
this isn't a bug but just a cleanup, but the problem is that other
people want Fixes tags for everything...

Yesterday I sent a cleanup patch and I almost put the Fixes tag under
the --- cut off but in the end I just deleted it...  It's hard to know
what the right thing is.

regards,
dan carpenter

