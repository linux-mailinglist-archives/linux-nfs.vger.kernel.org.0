Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080762345D6
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jul 2020 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgGaMbJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jul 2020 08:31:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37810 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732902AbgGaMbJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jul 2020 08:31:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VCGwmO061038;
        Fri, 31 Jul 2020 12:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=S2FJno61QIe7o+ADEVkw0UIBI1L/nLqkAaDZ/z8Qr6k=;
 b=NwmBChcM+3JNewyStFy+vkarODb/HYYdFDltyNBaR51ceaCT5S9eVvCstCNlLZVxIXuR
 UmXfiX+Az5pShvnQQeLux65Ed2nRalT9S4kZXprJI345agXlBMERaeBb7Lem1TAUYbPp
 oHfoaQ01047dWh8It22ii2Ts51k4s+mn1pePT0ZkIWUAGJbl68JejQDBX0Bzkw/aRYxg
 9GwtEg4SvPQhanNNvNyHqx+G7lYwV+XtR8sNCqEYi+qwNAN4Q0v2eribCme069Lf+nPF
 LCOTYxgEz1pHLyKl/TdZ1pWmThA7Uk3MQ/KqZeAx1Z7tA221t+iB29hXylljlVlJQ4UW Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 32hu1jrte7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jul 2020 12:30:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VCIdvP009788;
        Fri, 31 Jul 2020 12:30:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32hu63yr0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 12:30:55 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VCUrjT000606;
        Fri, 31 Jul 2020 12:30:54 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 Jul 2020 05:30:53 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH -next] nfsd: use DEFINE_SPINLOCK() for spinlock
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200725085642.98356-1-miaoqinglang@huawei.com>
Date:   Fri, 31 Jul 2020 08:30:52 -0400
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <161A0175-C77B-4252-9D1E-22FEC7EEADE9@oracle.com>
References: <20200725085642.98356-1-miaoqinglang@huawei.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=2 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310092
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello-

> On Jul 25, 2020, at 4:56 AM, Qinglang Miao <miaoqinglang@huawei.com> wrote:
> 
> nfsd_drc_lock can be initialized automatically with
> DEFINE_SPINLOCK() rather than explicitly calling spin_lock_init().
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Thanks for your patch.

I am quite honestly on the fence about this one. It doesn't
seem to make a difference behaviorally or in terms of code
legibility.

A broader clean-up that moves set_max_drc and those global
variables into nfs4state.c might be better, but again, there
isn't much to justify such a change.

Bruce, any thoughts?


> ---
> fs/nfsd/nfssvc.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index b603dfcdd..20f0a27fe 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -88,7 +88,7 @@ DEFINE_MUTEX(nfsd_mutex);
>  * version 4.1 DRC caches.
>  * nfsd_drc_pages_used tracks the current version 4.1 DRC memory usage.
>  */
> -spinlock_t	nfsd_drc_lock;
> +DEFINE_SPINLOCK(nfsd_drc_lock);
> unsigned long	nfsd_drc_max_mem;
> unsigned long	nfsd_drc_mem_used;
> 
> @@ -568,7 +568,6 @@ static void set_max_drc(void)
> 	nfsd_drc_max_mem = (nr_free_buffer_pages()
> 					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> 	nfsd_drc_mem_used = 0;
> -	spin_lock_init(&nfsd_drc_lock);
> 	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
> }
> 
> -- 
> 2.25.1
> 

--
Chuck Lever



