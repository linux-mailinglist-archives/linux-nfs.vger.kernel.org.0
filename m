Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF09F2A2D03
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 15:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgKBObf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 09:31:35 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40874 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgKBObf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 09:31:35 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2EPLKd042219;
        Mon, 2 Nov 2020 14:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=BQDJe71X5l6t0vecfZytTzkoHxPWhPbaKkNRsejo630=;
 b=mjwWSevI93WJzam9IOb6T47zzJ89nLLqnCVCGvqCbuHdp6493HOLg9B1p1Ov6mx4yGCk
 fAYSxdMzIxlrbnXYaHXg9lcdyGRzqDDSd7o/CBvFObwLcujnqv9cXTYvP9qwp3nwS0gG
 zgGyLYkoqzFhrsWH+iwpUPmgHWZsBiTTb7cU9oynMQIZuFwS1ixHjU3OICviVMRG7/Ix
 Jb/Mq305A++iR2LhShkCvvjpbDLeGXxLghFTQYDFP7zNwacILtjvYgIyetaKr10A+Yy3
 4LrMMwqpqG+JZrTAH0VpsKzjBfRQuwes90T9u8QjMMTxpB2qHNjDl5gxj6kYpwMYxPnL KA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34hhvc45he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 02 Nov 2020 14:31:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2ETdGs087987;
        Mon, 2 Nov 2020 14:31:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34hvrtxh1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Nov 2020 14:31:28 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A2EVPg1011249;
        Mon, 2 Nov 2020 14:31:25 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 06:31:25 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nfsd: remove unneeded semicolon
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201101153234.2291612-1-trix@redhat.com>
Date:   Mon, 2 Nov 2020 09:31:24 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <A241215F-384F-4BC7-98A4-339D21622B4B@oracle.com>
References: <20201101153234.2291612-1-trix@redhat.com>
To:     trix@redhat.com, Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020115
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 1, 2020, at 10:32 AM, trix@redhat.com wrote:
> 
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> fs/nfsd/nfs4xdr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 259d5ad0e3f4..6020f0ff6795 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -2558,7 +2558,7 @@ static u32 nfs4_file_type(umode_t mode)
> 	case S_IFREG:	return NF4REG;
> 	case S_IFSOCK:	return NF4SOCK;
> 	default:	return NF4BAD;
> -	};
> +	}
> }
> 
> static inline __be32
> -- 
> 2.18.1
> 

I can take this for 5.11.

--
Chuck Lever



