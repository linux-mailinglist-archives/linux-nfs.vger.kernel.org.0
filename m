Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7098281677
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Oct 2020 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbgJBPXJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Oct 2020 11:23:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54234 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbgJBPXI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 2 Oct 2020 11:23:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092FJfQk030464;
        Fri, 2 Oct 2020 15:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=rMX121eFLLPwhqQLhwxn+e0hVfcOS3a27Rt7tzJU7e4=;
 b=truDxpu69C2zzNhxrIHGnjbhXNgSlcsWn/orUSG2yOL/GD4TV9fW+w/OVvjE8HDyguuP
 y9X6XnhvhZVq9oB0Ki6U/fbqx/+Cdn9JaVHjpGpevPnhdDH8lVUWJ1Vd9t4jsw7zLRIW
 yeGl19nYV5gtptCx7thuIikvCRfw+DF1bXAFCfdyz2thgKpghEQbmE6hq1sodKrPu9In
 KJk4UO/W69tGe+fOBwf6i7B5MKajTZqr1kLx3orklc1Se67hNfaEfjQRq/n0ekZUCcOu
 I2NYiM/NXqsVHVskQTMugqOp30o2xIpeAsao1Qhg1cpeRMNUBw7vsnk4DjRVtbTP7q54 gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33swkmbft3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 02 Oct 2020 15:23:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 092FJtnn194177;
        Fri, 2 Oct 2020 15:23:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33tfk3ngvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Oct 2020 15:23:06 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 092FN5Ir008588;
        Fri, 2 Oct 2020 15:23:05 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Oct 2020 08:23:05 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] svcrdma: fix bounce buffers for non-zero page offsets
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201002151833.GA988340@gmail.com>
Date:   Fri, 2 Oct 2020 11:23:04 -0400
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <58FBC94E-3F7D-4C23-A720-6588B0B22E86@oracle.com>
References: <20201002144827.984306-1-dan@kernelim.com>
 <7DE1BF37-DF5E-47F2-A24C-A80ED20956CE@oracle.com>
 <20201002151833.GA988340@gmail.com>
To:     Dan Aloni <dan@kernelim.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9762 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010020120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 2, 2020, at 11:18 AM, Dan Aloni <dan@kernelim.com> wrote:
>=20
> On Fri, Oct 02, 2020 at 10:54:28AM -0400, Chuck Lever wrote:
>> Hi Dan-
>>=20
>>> On Oct 2, 2020, at 10:48 AM, Dan Aloni <dan@kernelim.com> wrote:
>>>=20
>>> This was discovered using O_DIRECT and small unaligned file offsets
>>> at the client side.
>>>=20
>>> Fixes: e248aa7be86 ("svcrdma: Remove max_sge check at connect time")
>>> Signed-off-by: Dan Aloni <dan@kernelim.com>
>>> ---
>>> net/sunrpc/xprtrdma/svc_rdma_sendto.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c =
b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>>> index 7b94d971feb3..c991eb1fd4e3 100644
>>> --- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>>> +++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
>>> @@ -638,7 +638,7 @@ static int svc_rdma_pull_up_reply_msg(struct =
svcxprt_rdma *rdma,
>>> 		while (remaining) {
>>> 			len =3D min_t(u32, PAGE_SIZE - pageoff, =
remaining);
>>>=20
>>> -			memcpy(dst, page_address(*ppages), len);
>>> +			memcpy(dst, page_address(*ppages) + pageoff, =
len);
>>=20
>> I'm assuming the only relevant place that sets xdr->page_base
>> is nfsd_splice_actor() ?
>=20
> Yes, and traces at the server indeed indicate that splicing happened.
> This works for both tmpfs and ext4 as host FSes.

Seems plausible, thanks. I'll throw it into my test environment.


--
Chuck Lever



