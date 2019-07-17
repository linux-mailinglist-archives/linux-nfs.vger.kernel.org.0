Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 710A36C0D6
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jul 2019 20:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGQSNF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jul 2019 14:13:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54932 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfGQSNF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 17 Jul 2019 14:13:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HI9B2M098651;
        Wed, 17 Jul 2019 18:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=xYUQhCC6mvEgCpQqswuZXWY/CRagRo/4lCv9KlsqPpI=;
 b=fxCzVmek5S3fPyzBHQDuvwTwQpM9FfkHdT3bZkV36bK7YOtntIzHDnc5M2WN3ChJlnXU
 N7A7ci1kZOHTlhQNGu4tPkEiWE9BJ9niHL7t09jhtRuw/EjwRlOKYdP2VH6v1xQVZYDl
 sUQxZOe7Hqtu5ZV/75QMQIl8gXnbiuDXeHgrGV4cacnx+YNINQjJV3ncLriOMgdxhrmj
 1QP5QD+jJfL0XXpJvjKgzzFyqmclB9otSCTPMOWDwpmokoysHFSj/1MT1Rp9nbv2IWt6
 hQ67HqP88gHHoaAsu7sywfDVbPWu7ydlpf2XkvLx0LsoKp7UZQTn4cs51nbRv2UtEvzf mA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tq7xr4fyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 18:13:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6HI7gEr177982;
        Wed, 17 Jul 2019 18:13:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tt77h9p5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 18:13:00 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6HICvFC007838;
        Wed, 17 Jul 2019 18:12:59 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 18:12:57 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] SUNRPC: Fix up backchannel slot table accounting
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <97e9839faef3d1bc901d4ced3d0cf2e0bf2a0bd1.camel@hammerspace.com>
Date:   Wed, 17 Jul 2019 14:12:56 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F138F86C-84FB-4FEA-8240-FDAD6FD4CE38@oracle.com>
References: <20190716200157.38583-1-trond.myklebust@hammerspace.com>
 <99A569FB-DD7F-4547-AB06-FEB5DABA8488@oracle.com>
 <97e9839faef3d1bc901d4ced3d0cf2e0bf2a0bd1.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170208
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9321 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170208
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 17, 2019, at 1:19 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Wed, 2019-07-17 at 09:55 -0400, Chuck Lever wrote:
>> Hi Trond-
>>=20
>>> On Jul 16, 2019, at 4:01 PM, Trond Myklebust <trondmy@gmail.com>
>>> wrote:
>>>=20
>>> Add a per-transport maximum limit in the socket case, and add
>>> helpers to allow the NFSv4 code to discover that limit.
>>=20
>> For RDMA, the number of credits is permitted to change during the
>> life
>> of the connection, so this is not a fixed limit for such transports.
>=20
> This is defining a maximum value, which is used for backchannel =
session
> slot negotiation.
>=20
>>=20
>> And, AFAICT, it's not necessary to know the transport's limit. The
>> lesser of the NFS backchannel and RPC/RDMA reverse credit limit will
>> be used.
>=20
> The server needs to know how many requests it can send in parallel on
> the back channel. If it sends too many, which it can and will do on
> TCP, then we currently break the connection, and so callbacks end up
> being dropped or missed altogether.

IIUC, RPC/RDMA has a fixed maximum constant. Would you like a patch at
some point that advertises that constant via ->bc_num_slots ?


--
Chuck Lever



