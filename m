Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1E159BE2
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2020 23:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBKWDA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Feb 2020 17:03:00 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33142 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgBKWDA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Feb 2020 17:03:00 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BM1DdN132971;
        Tue, 11 Feb 2020 22:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=35xH38iFZ69eYqUNWH4Ucbj+Q+nrNh/jTYNJiJ6bnzY=;
 b=YRdF8F2EYzEixOWu5xbeTRs/UCQ68dNhrCTXRzFMSuqN3GOyyy4ZrIBCPp9hHMP8J5Pf
 jYiSBUoaVAZrxydC52xbyps6F64mEF5c9o9Cbhadxq5JrwlyuSnYOuJEkI9GEie4lkmt
 UE3oDE8DCaIgAAHaTYyFcHOwDAoNojBQIZI30rIAmjvtf3n3piwhfbnXjvMI12X9b+sp
 lBqwbL0ZFa0wr4f0aBEN8bhpyukRYGo7uKMkTi1iJAUdNlEP2yXd2VHb7S7Rk5+ZYYH8
 ksKUg0jN6u1H2rXvVh71VYW4k7UXqRrm+mWZsD8lAuwWcKbkA4LNm1MfLuozLm0+3tBy Dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2y2p3sebjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 22:02:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01BLuSSF124790;
        Tue, 11 Feb 2020 22:00:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2y26st4yny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 22:00:50 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01BM0ndW001936;
        Tue, 11 Feb 2020 22:00:49 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Feb 2020 14:00:49 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1] xprtrdma: Fix DMA scatter-gather list mapping
 imbalance
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <8781b043-74a6-4ee0-d1c9-46f797b4aec2@tomt.net>
Date:   Tue, 11 Feb 2020 17:00:48 -0500
Cc:     robin.murphy@arm.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC2EEB01-5C19-4FB5-B103-D9ADF09E07FA@oracle.com>
References: <158145102079.515252.3226617475691911684.stgit@morisot.1015granger.net>
 <8781b043-74a6-4ee0-d1c9-46f797b4aec2@tomt.net>
To:     Andre Tomt <andre@tomt.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002110142
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Andre, thanks for trying this out.

> On Feb 11, 2020, at 3:50 PM, Andre Tomt <andre@tomt.net> wrote:
>=20
> On 11.02.2020 20:58, Chuck Lever wrote:
>> The @nents value that was passed to ib_dma_map_sg() has to be passed
>> to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
>> concatenate sg entries, it will return a different nents value than
>> it was passed.
>> The bug was exposed by recent changes to the AMD IOMMU driver.
>=20
> This seems to fail differently on my system; mount fails with:
> mount.nfs: mount system call failed
>=20
> and the kernel log reports:
> [   38.890344] NFS: Registering the id_resolver key type
> [   38.890351] Key type id_resolver registered
> [   38.890352] Key type id_legacy registered
> [   38.901799] NFS: nfs4_discover_server_trunking unhandled error -5. =
Exiting with error EIO
> [   38.901817] NFS4: Couldn't follow remote path
>=20
> amd_iommu=3Doff still works
>=20
> One detail I accidentally left out of the original report is that the =
server (intel system) is running Ubuntu 20.04 ("beta") userspace, and =
AMD clients are Ubuntu 19.10 userspace. Although I dont believe this to =
matter at this point.

Next thing to try:

# trace-cmd record -e sunrpc -e rpcrdma

then issue the mount command. Once it completes, ^C the trace-cmd and =
send me trace.dat.

Try this with both the v5.4 kernel and the v5.5 kernel (and note that =
trace-cmd overwrites trace.dat, so copy it out between tests).


>> Reported-by: Andre Tomt <andre@tomt.net>
>> Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> Fixes: 1f541895dae9 ("xprtrdma: Don't defer MR recovery if ro_map =
fails")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/frwr_ops.c |    5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>> Hey Andre, please try this out. It just reverts the bit of brokenness =
that
>> Robin observed this morning. I've done basic testing here with Intel
>> IOMMU systems, no change in behavior (ie, all good to go).
>> diff --git a/net/sunrpc/xprtrdma/frwr_ops.c =
b/net/sunrpc/xprtrdma/frwr_ops.c
>> index 095be887753e..449bb51e4fe8 100644
>> --- a/net/sunrpc/xprtrdma/frwr_ops.c
>> +++ b/net/sunrpc/xprtrdma/frwr_ops.c
>> @@ -313,10 +313,9 @@ struct rpcrdma_mr_seg *frwr_map(struct =
rpcrdma_xprt *r_xprt,
>>  			break;
>>  	}
>>  	mr->mr_dir =3D rpcrdma_data_dir(writing);
>> +	mr->mr_nents =3D i;
>>  -	mr->mr_nents =3D
>> -		ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, =
mr->mr_dir);
>> -	if (!mr->mr_nents)
>> +	if (!ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir))
>>  		goto out_dmamap_err;
>>    	ibmr =3D mr->frwr.fr_mr;
>=20

--
Chuck Lever



