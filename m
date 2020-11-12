Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D7F2B0F19
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 21:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgKLUjU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 15:39:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47200 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgKLUjU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 15:39:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACKPfSx148711;
        Thu, 12 Nov 2020 20:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=kS0WbmR62LVM3N52MjTur4OLal6/oOlGyBIkWxR6O98=;
 b=AZS7uICogNDuSLR1KOEq+5M99Fqlk8gr5E0bnuclPh/VqLq9/Ss2ZMQHz0O57RMkpEXz
 n960h+lNaZ73cmBnqy27GbrtgMAaHtdXaq5qS9HoRQBg0A8Doo9PgPKzwjDOi19LKFfM
 YxJAMivWzwMCiiC7HcKJNwGY7/DZJdKLP90lMFqsSAYsWDPP/ie251vvkh7jvanvKgMY
 CFRpDAzxCzePBkCVZj5Lyvk6BfLjECMD+P2RzNvSf+ZnPWBDb/m5STUnhRb2k5cdRDng
 RffvObZQ9Dj6LYuQEKM954PphxUZqqUILJpGqzRLfqOvqqGv9/DLR23fa4P/tYYJdlt/ Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 34p72ewqng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 20:39:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACKPKSU098725;
        Thu, 12 Nov 2020 20:39:13 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 34p55rv4wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 20:39:13 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ACKdBEt017916;
        Thu, 12 Nov 2020 20:39:12 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 12:39:11 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] SUNRPC: Fix oops in the rpc_xdr_buf event class
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201112201732.1689680-1-smayhew@redhat.com>
Date:   Thu, 12 Nov 2020 15:39:07 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Scott Mayhew <smayhew@redhat.com>
Content-Transfer-Encoding: 7bit
Message-Id: <7F720342-6027-44B3-BAF2-F1F43721C407@oracle.com>
References: <20201112201732.1689680-1-smayhew@redhat.com>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9803 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 12, 2020, at 3:17 PM, Scott Mayhew <smayhew@redhat.com> wrote:
> 
> Backchannel rpc tasks don't have task->tk_client set, so it's necessary
> to check it for NULL before dereferencing.
> 
> Fixes: c509f15a5801 ("SUNRPC: Split the xdr_buf event class")
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
> include/trace/events/sunrpc.h | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index 2477014e3fa6..2a03263b5f9d 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -68,7 +68,8 @@ DECLARE_EVENT_CLASS(rpc_xdr_buf_class,
> 
> 	TP_fast_assign(
> 		__entry->task_id = task->tk_pid;
> -		__entry->client_id = task->tk_client->cl_clid;
> +		__entry->client_id = task->tk_client ?
> +				     task->tk_client->cl_clid : -1;
> 		__entry->head_base = xdr->head[0].iov_base;
> 		__entry->head_len = xdr->head[0].iov_len;
> 		__entry->tail_base = xdr->tail[0].iov_base;
> -- 
> 2.25.4
> 

Bruce, can you take this one for v5.10-rc ?


--
Chuck Lever



