Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD42815EA
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbgJBPAA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 11:00:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33162 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388078AbgJBO77 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 10:59:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092ExixE191394;
        Fri, 2 Oct 2020 14:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=IclA+epoTSyaeJIUzAo58CxQhYKxEH0O2LGgv7PdzlA=;
 b=cpGVg5pSolg4XWsd3Rrvs2vDch6eh83G9kvGNDbUgwcNQyFpS+Il657W9l5fYyehvplQ
 miDP+WneNJQ2COt5cfQtf2ckGm+2dg1vE10ft4SofpRCR7waBQYDYtXpyE6dDwJZZAWB
 SyYdj8u4ewcY5KIvoMCivQcxcLV6FdqdgWGGNfNnowdsOUja1iRKpw/fudpS66rNHPzs
 OFL/e8gtYkvlXEolqJgRMdQeIJdOAQxTaTdaHIchn5zPGpI/ZMMTdewDE2mCY8sJ/as7
 nX7EbdrCMlXlPwEwo0Nka8UD1kL6A+pjXuC/EXqJKg4Xf2NcLJvPE3lJdxXcIWaq7gvq Vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33swkmbc40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 14:59:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092Eosqv129271;
        Fri, 2 Oct 2020 14:59:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 33tfdxpfqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Oct 2020 14:59:57 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 092Exuff007551;
        Fri, 2 Oct 2020 14:59:56 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Oct 2020 07:59:55 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] svcrdma: fix bounce buffers for non-zero page offsets
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201002144827.984306-1-dan@kernelim.com>
Date:   Fri, 2 Oct 2020 10:54:28 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DE1BF37-DF5E-47F2-A24C-A80ED20956CE@oracle.com>
References: <20201002144827.984306-1-dan@kernelim.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010020117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dan-

> On Oct 2, 2020, at 10:48 AM, Dan Aloni <dan@kernelim.com> wrote:
>=20
> This was discovered using O_DIRECT and small unaligned file offsets
> at the client side.
>=20
> Fixes: e248aa7be86 ("svcrdma: Remove max_sge check at connect time")
> Signed-off-by: Dan Aloni <dan@kernelim.com>
> ---
> net/sunrpc/xprtrdma/svc_rdma_sendto.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c =
b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> index 7b94d971feb3..c991eb1fd4e3 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
> @@ -638,7 +638,7 @@ static int svc_rdma_pull_up_reply_msg(struct =
svcxprt_rdma *rdma,
> 		while (remaining) {
> 			len =3D min_t(u32, PAGE_SIZE - pageoff, =
remaining);
>=20
> -			memcpy(dst, page_address(*ppages), len);
> +			memcpy(dst, page_address(*ppages) + pageoff, =
len);

I'm assuming the only relevant place that sets xdr->page_base
is nfsd_splice_actor() ?


> 			remaining -=3D len;
> 			dst +=3D len;
> 			pageoff =3D 0;
> --=20
> 2.26.2
>=20

--
Chuck Lever



