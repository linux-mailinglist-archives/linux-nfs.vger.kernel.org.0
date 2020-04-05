Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2491219ED4A
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Apr 2020 20:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgDESH3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 5 Apr 2020 14:07:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgDESH2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 5 Apr 2020 14:07:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 035Hx0S6020471;
        Sun, 5 Apr 2020 18:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=4NXyuWWgh/7OWp3cILwv5QERFtnYtjUMZTPV+RIpTl0=;
 b=jRKFj5B21v5iLIaJ2AlGf0BLRNUiV6diIQ0G/3FyMBuIxUyLsshUbORWPtSJ/0p85R0b
 jtSck9v9ifmvMH875rF8MQFZhRlVGcf8agfVmLmtJz/wY+YyxwDF7BR+kvMOJn5MfNFT
 mzXPEqhtiBA3/7WMw+L4VaS+dzOSyx348J3Hcx7+fFtNKOiw/IF6fcRHbzQpUmLv4/5/
 fgEDN12uB6vL9KxZoJ4oq1rD4F6Jujufo7v2MJTCI9JLqJAeDObS8GU72Lg1izt9dzbO
 HFzcwE9qcHVMKMUq/v0BxS0SX2U8uYnN9hEuT4xhT6R0xcXG4IJgMK0wC0kT9uJzRxNR /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 306jvmuk9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 18:07:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 035I3JO4042118;
        Sun, 5 Apr 2020 18:07:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 307417rura-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 18:07:14 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 035I777K013029;
        Sun, 5 Apr 2020 18:07:07 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Apr 2020 11:07:07 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] SUNRPC/cache: Fix unsafe traverse caused double-free
 in cache_purge
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <e0dd0339-a15e-814d-ac5a-5f51bc15d73c@linux.alibaba.com>
Date:   Sun, 5 Apr 2020 14:07:05 -0400
Cc:     Bruce Fields <bfields@fieldses.org>, Neil Brown <neilb@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <0308EB8A-A8B7-412C-8F93-A444DE47CB1D@oracle.com>
References: <4568a7cf87f110b8e59fda6f53fda34c550ab403.1586108200.git.wuyihao@linux.alibaba.com>
 <e0dd0339-a15e-814d-ac5a-5f51bc15d73c@linux.alibaba.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004050169
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=2
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004050168
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Yihao-

> On Apr 5, 2020, at 1:57 PM, Yihao Wu <wuyihao@linux.alibaba.com> wrote:
> 
> Deleting list entry within hlist_for_each_entry_safe is not safe unless
> next pointer (tmp) is protected too. It's not, because once hash_lock
> is released, cache_clean may delete the entry that tmp points to. Then
> cache_purge can walk to a deleted entry and tries to double free it.
> 
> Fix this bug by holding only the deleted entry's reference.
> 
> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
> v1->v2: Use Neil's better solution
> v2->v3: Fix a checkscript warning
> 
> net/sunrpc/cache.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> index af0ddd28b081..b445874e8e2f 100644
> --- a/net/sunrpc/cache.c
> +++ b/net/sunrpc/cache.c
> @@ -541,7 +541,9 @@ void cache_purge(struct cache_detail *detail)
> 	dprintk("RPC: %d entries in %s cache\n", detail->entries, detail->name);
> 	for (i = 0; i < detail->hash_size; i++) {
> 		head = &detail->hash_table[i];
> -		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {

If review/testing shows you need to respin this patch, I note that "tmp" is
now unused and should be removed. I've pulled v3 into my testing branch and
made that minor change. Thanks!


> +		while (!hlist_empty(head)) {
> +			ch = hlist_entry(head->first, struct cache_head,
> +					 cache_list);
> 			sunrpc_begin_cache_remove_entry(ch, detail);
> 			spin_unlock(&detail->hash_lock);
> 			sunrpc_end_cache_remove_entry(ch, detail);
> -- 
> 2.20.1.2432.ga663e714

--
Chuck Lever



