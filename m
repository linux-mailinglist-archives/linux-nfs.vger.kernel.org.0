Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC75025DBE4
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgIDOgr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 10:36:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgIDOgo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 10:36:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084EKGgX107179;
        Fri, 4 Sep 2020 14:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=dT/454RrLv7aKbmr1HQ5R5wzNM0Orwd7LvPSGJ6qYuo=;
 b=RZpjzvOK7y/O/eJmK8tclVuOtVuxa+OoRGy1PixW4sj7Pd3aIYEQB9UangmoqkFbJZT4
 UJGEqIFyVb+x3SzbYAUjbQiIE9jfmX9XXQNSglLx3CegADqQ1Q4cYiZbNZxxsgzRzuAq
 xPSi+jVgcL1Wi9O6XDiIdCufnpQfxqpTUjAxsj1P+CdVgYbCqnORR7EwL+WBDbe/Sbk9
 mhVFWXrz8irmoahdKPp8JeZevyJLl1pQ1UihFqx+AtaQt24TfSqubrmAb2izJJKE5kzY
 HJFGXxmdTIoUp3FyPSuIPqFWDwCuK9rMiaWF4twKQyw/XfWv7AdNYEkrO/Q0NENrOh/r EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eymprx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 14:36:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084ELsSq127436;
        Fri, 4 Sep 2020 14:36:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33b7v2q4g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 14:36:39 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084EabpD028576;
        Fri, 4 Sep 2020 14:36:38 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 07:36:37 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200904142923.GE26706@fieldses.org>
Date:   Fri, 4 Sep 2020 10:36:36 -0400
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C73640A5-E374-46D7-9F35-EF34B17E4F3C@oracle.com>
References: <20200828212521.GA33226@pick.fieldses.org>
 <20200828215627.GB33226@pick.fieldses.org>
 <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
 <20200901164938.GC12082@fieldses.org>
 <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
 <20200901191854.GD12082@fieldses.org> <20200904135259.GB26706@fieldses.org>
 <00931C34-6C86-46A2-A3B3-9727DA5E739E@oracle.com>
 <20200904140324.GC26706@fieldses.org>
 <164C37D9-8044-4CF4-99A1-5FB722A16B8E@oracle.com>
 <20200904142923.GE26706@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040129
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 4, 2020, at 10:29 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Fri, Sep 04, 2020 at 10:07:22AM -0400, Chuck Lever wrote:
>> My primary concern is that the result of a file copy operation should
>> look the same on NFS/TCP (with READ_PLUS) and NFS/RDMA (with =
SEEK_DATA/HOLE).
>=20
> I'm not sure what you mean.
>=20
> I don't see the spec providing any guarantee of consistency between
> READ_PLUS and SEEK.

IMO this is an implementation quality issue, not a spec compliance
issue.


> It also doesn't guarantee that the results tell you
> anything about how the file is actually stored--a returned "hole" =
could
> represent an unallocated segment, or a fully allocated segment that's
> filled with zeroes, or some combination.

Understood, but the resulting copied file should look the same whether
it was read from the server using READ_PLUS or SEEK_DATA/HOLE.


> So, for example, if you implemented an optimized copy that used
> ALLOCATE, DEALLOCATE, SEEK and/or READ_PLUS to avoid reading and =
writing
> a lot of zeroes--there's no guarantee that the target file would end =
up
> allocated in the same way as the source.



--
Chuck Lever



