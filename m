Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71508823C8
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2019 19:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbfHERPq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Aug 2019 13:15:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42562 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHERPp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Aug 2019 13:15:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75HE8Io145577;
        Mon, 5 Aug 2019 17:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=nPFbMWDy/GPZ7qzfaZqz6U6+uWj0/xLsMBVQnP4Sfiw=;
 b=KBw3Y+0yGPt4x914tL/z2ZGH0gzolkKnoJNLuxRSLTsTqxj85gHV4zMqrIISLfrTa9YS
 BtjkPDvuMdSXu6EJ3VbezizS0grQE4TX1HLlq7lgkRKM3kOCdN3lPFEeA4c2rDEfdStu
 SMUksNORwHAh6PRmXdbXWRz6/BgdgDJS0/Z+E0MHt3ElLUTf62UdoAq7QPqTczoM+VFI
 m9bDcaOM6z9gxLODEJOGJraC5jIDxRojAmiRZ9eU6Q3HosCBZddAQ2UOLJWBKZMZpbrg
 CzJ6Kp68V2sdTEBmbLZCs4S2vi4iYOYNOulWc1SS1JK40Lo2nNrz3obR3JTBKtiPfb8S nA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u527pghux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 17:15:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x75H1j1A177873;
        Mon, 5 Aug 2019 17:15:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2u5233d9s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Aug 2019 17:15:33 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x75HFV0I022474;
        Mon, 5 Aug 2019 17:15:31 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Aug 2019 10:15:23 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v3] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <f181b5b6-df7c-d657-4ec6-4a4e56a9b5ff@acm.org>
Date:   Mon, 5 Aug 2019 13:15:22 -0400
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <87D288BC-65F8-4678-A8C5-DEF7C3355BC7@oracle.com>
References: <20190729171923.13428.52555.stgit@manet.1015granger.net>
 <f181b5b6-df7c-d657-4ec6-4a4e56a9b5ff@acm.org>
To:     Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908050185
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908050185
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bart-

> On Aug 5, 2019, at 12:09 PM, Bart Van Assche <bvanassche@acm.org> =
wrote:
>=20
> On 7/29/19 10:22 AM, Chuck Lever wrote:
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c =
b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index 1a039f1..e25c70a 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -1767,8 +1767,8 @@ static int srpt_create_ch_ib(struct =
srpt_rdma_ch *ch)
>>  		goto out;
>>    retry:
>> -	ch->cq =3D ib_alloc_cq(sdev->device, ch, ch->rq_size + sq_size,
>> -			0 /* XXX: spread CQs */, IB_POLL_WORKQUEUE);
>> +	ch->cq =3D ib_alloc_cq_any(sdev->device, ch, ch->rq_size + =
sq_size,
>> +				 IB_POLL_WORKQUEUE);
>>  	if (IS_ERR(ch->cq)) {
>>  		ret =3D PTR_ERR(ch->cq);
>>  		pr_err("failed to create CQ cqe=3D %d ret=3D %d\n",
> Hi Chuck,
>=20
> Please Cc me for future srp and srpt patches. I think my name appears =
next to both drivers in the MAINTAINERS file.

I see your name listed, but I thought the rule was to Cc: the mailing =
list
which is listed for that component. My bad.

--
Chuck Lever



