Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8887A3D6B5
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 21:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbfFKTWr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 15:22:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37572 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbfFKTWr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 15:22:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BJE2dg136828;
        Tue, 11 Jun 2019 19:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=cQDcJb+5BMO3d5zhtf7bOFNwL1wC4mu5t5RDsS5jkjg=;
 b=CsrmD3jvccDhwppl/vYI320jRtkIWnY4QQaumzMHFq3DpzSafk7WGjAl4P4KL/7SkXKj
 gpy6HOFq4yZLLwcOpjYLx5FZ61t8hqoa7/y7nUMnSweCCTN8vr7sycxMUHCGTarjHMvN
 Xi5JNkKLreO18ueMpXIuoL6MHUoieqxhKqueCWXrpv8f4mWFtw2+cDm0xRl71KGw/YdB
 s9Jke1CcDZBuCwrx/3EMdRjQdTVCxnC+h//bbm0vnBDI+nrymQ/VIfpel3rj2z216Ram
 8ZxDnRDeXDkVdnQWFxLa/57cexxmhR0IAKRC5FKp50pkmDHmE0yj6A2H42NKCVENVOiI CQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t05nqq5ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 19:22:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5BJL8aA172374;
        Tue, 11 Jun 2019 19:22:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t1jphmc0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 19:22:42 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5BJMf5K014940;
        Tue, 11 Jun 2019 19:22:41 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Jun 2019 12:22:41 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] Cache consistency updates
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <d7ac89498918ad28f434d29bf08cf99817b71820.camel@hammerspace.com>
Date:   Tue, 11 Jun 2019 15:22:40 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <96B1828F-268B-4B7D-B256-7FCE4B55B63F@oracle.com>
References: <20190611182511.120074-1-trond.myklebust@hammerspace.com>
 <B29E9170-287F-4E10-B1AE-4E12303435B3@oracle.com>
 <d7ac89498918ad28f434d29bf08cf99817b71820.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906110123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110123
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 11, 2019, at 3:21 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Tue, 2019-06-11 at 14:31 -0400, Chuck Lever wrote:
>>> On Jun 11, 2019, at 2:25 PM, Trond Myklebust <trondmy@gmail.com>
>>> wrote:
>>>=20
>>> Add a 'deferred cache invalidation' mode that we can use when we
>>> thing
>>> the NFS cache may have been changed on the server, but the file in
>>> question is already open and is cached on the client. In order to
>>> avoid
>>> performance issues due to false positive detection of server
>>> changes,
>>> we defer invalidating the cache until the file has been closed, and
>>> the cached data is no longer in active use.
>>>=20
>>> Trond Myklebust (3):
>>> NFS: Fix up ftrace printout of the cache invalidation flags
>>> NFS: Fix up ftrace logging of nfs_inode flags
>>=20
>> I also fixed these items in my for-5.3 patch series, but
>> my patches add TRACE_DEFINE_ENUM definitions.
>=20
> Oh. I missed those because they were embedded with the RDMA changes.
>=20
> Can you please fix them up to also change the (1 << NFS_INO_*) stuff =
to
> use the BIT() macro? That causes an expansion to an unsigned long type
> instead of the current signed int.

Yes, absolutely.


>>> NFS: Add deferred cache invalidation for close-to-open consistency
>>>   violations
>>>=20
>>> fs/nfs/dir.c           |  4 ++++
>>> fs/nfs/inode.c         | 15 +++++++++++----
>>> fs/nfs/nfstrace.h      | 22 ++++++++++++++--------
>>> include/linux/nfs_fs.h |  2 ++
>>> 4 files changed, 31 insertions(+), 12 deletions(-)
>>>=20
>>> --=20
>>> 2.21.0
>>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



