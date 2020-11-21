Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD52BC07C
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 17:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgKUQSG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 11:18:06 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42884 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgKUQSF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 11:18:05 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ALG8ZNl032024;
        Sat, 21 Nov 2020 16:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=s+yJHNSOJ6dowRbC8cmNMXHStZCqIri3avYKy8KL4eo=;
 b=lmeunS9MoJYW06mXQyw8+dv5uu8PLSxyrmM+JoglTXLePXcdQJOSaO96jT/kVgprSXN8
 +3lJKZspewp6a7IwipGU8ST/ZbbcfXxV4JrsFDHzDFR8bCOq+rZ1m3pEscwuy25MBScj
 MhwSjfAr08mId9wxgYnO80KARvzxGgtLy4dUh70PUyW1MchSwpH2nd6kRTPeFP+pB/Qo
 5mHzKZrzXJqsrYhdwCPEglRnCzxm9u9LD1ppvLJMSWogyze9t8b9Kyjp/e7CN2GgLput
 sfxkiHgHVo7vZPZeR0Fn8h35y631rdkbKYqVu+8id1cVDyD2L4TieAec+eGiZdjCc7gq TA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34xtukrwtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 21 Nov 2020 16:17:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ALGFfLF127549;
        Sat, 21 Nov 2020 16:15:58 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34xt7hj75b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Nov 2020 16:15:58 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ALGFt7j017261;
        Sat, 21 Nov 2020 16:15:57 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Nov 2020 08:15:55 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 001/118] NFSD: Fix returned READDIR offset cookie
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201121005932.GD7705@fieldses.org>
Date:   Sat, 21 Nov 2020 11:15:54 -0500
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <771378A0-2051-4F9A-846E-91B132D698F2@oracle.com>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
 <160590443133.1340.6772360578279663543.stgit@klimt.1015granger.net>
 <20201121005932.GD7705@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9812 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9812 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210111
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 20, 2020, at 7:59 PM, bfields@fieldses.org wrote:
> 
> On Fri, Nov 20, 2020 at 03:33:51PM -0500, Chuck Lever wrote:
>> Code inspection shows that the server's NFSv3 READDIR implementation
>> returns the same offset cookie as the client sent, instead of the
>> last cookie it returns in the reply's dirlist. This is unlike the
>> NFSv2 READDIR, NFSv3 READDIRPLUS, and NFSv4 READDIR implementations,
>> and it's been like this since the beginning of kernel git history.
> 
> Surely this should have caused actual failures in practice.
> 
>> I copied the logic from nfsd3_proc_readdirplus().
>> 
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs3proc.c |    7 ++++---
>> 1 file changed, 4 insertions(+), 3 deletions(-)
>> 
>> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
>> index d9be589fed15..e0ad18d6b5a8 100644
>> --- a/fs/nfsd/nfs3proc.c
>> +++ b/fs/nfsd/nfs3proc.c
>> @@ -430,6 +430,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>> 	struct nfsd3_readdirargs *argp = rqstp->rq_argp;
>> 	struct nfsd3_readdirres  *resp = rqstp->rq_resp;
>> 	int		count = 0;
>> +	loff_t		offset;
>> 	struct page	**p;
>> 	caddr_t		page_addr = NULL;
>> 
>> @@ -448,7 +449,9 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>> 	resp->common.err = nfs_ok;
>> 	resp->buffer = argp->buffer;
>> 	resp->rqstp = rqstp;
>> -	resp->status = nfsd_readdir(rqstp, &resp->fh, (loff_t *)&argp->cookie,
> 
> Doesn't nfsd_readdir() update argp->cookie to point to the last offset?
> 
>> +	offset = argp->cookie;
>> +
>> +	resp->status = nfsd_readdir(rqstp, &resp->fh, &offset,
>> 				    &resp->common, nfs3svc_encode_entry);
>> 	memcpy(resp->verf, argp->verf, 8);
>> 	count = 0;
>> @@ -464,8 +467,6 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>> 	}
>> 	resp->count = count >> 2;
>> 	if (resp->offset) {
>> -		loff_t offset = argp->cookie;
> 
> So, this shouldn't be equal to the initial cookie any more.
> 
> Am I missing something?

No, my mistake. This works as we expect. Thanks for the review!

However, I find it confusing that nfsd3_proc_readdir() is structured
differently than the other three readdir proc methods, and for no
documented reason.

Would you still be willing to consider this patch relabeled as a clean-up ?


> --b.
> 
>> -
>> 		if (unlikely(resp->offset1)) {
>> 			/* we ended up with offset on a page boundary */
>> 			*resp->offset = htonl(offset >> 32);
>> 

--
Chuck Lever



