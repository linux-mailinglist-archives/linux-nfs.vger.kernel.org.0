Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2D525DC94
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 16:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730729AbgIDO6z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 10:58:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41038 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbgIDO6y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 10:58:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084Enj81134767;
        Fri, 4 Sep 2020 14:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=AInjStGSjvh0jwL5MpPP/UjC516Eom3Q0twkAWLD/Zo=;
 b=p2rc6gaIrd1TTyXkzQEd54QrGvlEa/TZ4CGHjEtDLJEmKnLpyuk4+6eR/HUzAzxeoVXn
 9A9N2/oMIW8qh2k847fZitZ10TsmSB6t2DNIzpCgLmiG2iSBZTpBqwF53ctTc/CfvQbx
 QGHUJx4Eve9vNa5h41R6KW/YNiOxc19LXgnEtvuw1D3U2VewnGbCYbUohNe5mQfsM6we
 tIN6KbYw7ak64R0qLbKEEVRolg3wBqPhK88gjH5TcSa/mWlYMOyXVg0tXyijFsbjJgOv
 vLoebueDXV4j37yAX8OBUvyKLOld6b56g8daQeyIt/J5XN8iLDhXAEIDeg06UJGpn3oO sQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 339dmndbv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 14:58:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084EpMJr140222;
        Fri, 4 Sep 2020 14:58:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3380ktkhc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 14:58:46 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084Ewit2009027;
        Fri, 4 Sep 2020 14:58:46 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 07:58:44 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200904144932.GA349848@pick.fieldses.org>
Date:   Fri, 4 Sep 2020 10:58:43 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <45DCF35D-A919-4A99-9B6D-0952ED0A78E5@oracle.com>
References: <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
 <20200901164938.GC12082@fieldses.org>
 <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
 <20200901191854.GD12082@fieldses.org> <20200904135259.GB26706@fieldses.org>
 <00931C34-6C86-46A2-A3B3-9727DA5E739E@oracle.com>
 <20200904140324.GC26706@fieldses.org>
 <164C37D9-8044-4CF4-99A1-5FB722A16B8E@oracle.com>
 <20200904142923.GE26706@fieldses.org>
 <C73640A5-E374-46D7-9F35-EF34B17E4F3C@oracle.com>
 <20200904144932.GA349848@pick.fieldses.org>
To:     Bruce Fields <bfields@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040131
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 4, 2020, at 10:49 AM, J. Bruce Fields <bfields@redhat.com> wrote:
> 
> On Fri, Sep 04, 2020 at 10:36:36AM -0400, Chuck Lever wrote:
>>> On Sep 4, 2020, at 10:29 AM, Bruce Fields <bfields@fieldses.org> wrote:
>>> It also doesn't guarantee that the results tell you
>>> anything about how the file is actually stored--a returned "hole" could
>>> represent an unallocated segment, or a fully allocated segment that's
>>> filled with zeroes, or some combination.
>> 
>> Understood, but the resulting copied file should look the same whether
>> it was read from the server using READ_PLUS or SEEK_DATA/HOLE.
> 
> I'm uncomfortable about promising that.

The server should be able to represent a file with holes
in exactly the same way with both mechanisms, unless there
is a significant flaw in the protocols or implementation.

The client's behavior is also important here, so the
guarantee would have to be about how the server presents
the holes. A quality client implementation would be able
to use this guarantee to reconstruct the holes exactly.


> What do you think might go wrong otherwise?

I don't see a data corruption issue here, if that's what
you mean.

Suppose the server has a large file with a lot of holes,
and these holes are all unallocated. This might be
typical of a container image.

Suppose further the client is able to punch holes in a
destination file as a thin provisioning mechanism.

Now, suppose we copy the file via TCP/READ_PLUS, and
that preserves the holes.

Copy with RDMA/SEEK_HOLE and maybe it doesn't preserve
holes. The destination file is now significantly larger
and less efficiently stored.

Or maybe it's the other way around. Either way, one
mechanism is hole-preserving and one isn't.

A quality implementation would try to preserve holes as
much as possible so that the server can make smart storage
provisioning decisions.

--
Chuck Lever



