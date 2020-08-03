Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AD23ACEF
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Aug 2020 21:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgHCT0b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Aug 2020 15:26:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHCT0a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Aug 2020 15:26:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073J7v2v131164;
        Mon, 3 Aug 2020 19:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=hkNPEbW4Uc/K6bVYf0I/h54yFsofSOjZQ4nXBW1+gYo=;
 b=fLoMnr/2zascx35Vfn60zpZ0Xprq0zV4+5iVf+lw24wUhHQLlHhLW3na8/ZtgJ06imsM
 YBGqCMOG2eYpRI8TusGkOmqbOCU7VtBBCH9+NkDW1Ok+24MfxpazY09nTBqxQnwcG2/D
 w8gClGF6NQWpOyqS7x1GjIFAEO95z3PYg+5dU3B7U2xjxh0z6bjAY0HuvjXKfHMuIECV
 Z52vfs+oSRdFIPe/ZB3+mzQzKhgEdMwuJsyw9DSIJqXSObTcW4Rf1OXybvrvpv7VdIga
 InA5GnLS+Dbhvb7cXptZ5iexuzjWm41MF3mtn75nLCNtwOkR784b1ltVj6UcqkRFMoqb fQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32nc9yexfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 03 Aug 2020 19:26:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073J7ejq194450;
        Mon, 3 Aug 2020 19:26:24 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32njavd4a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Aug 2020 19:26:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 073JQNVV030683;
        Mon, 3 Aug 2020 19:26:23 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Aug 2020 12:26:22 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 0/6] NFSD: Add support for the v4.2 READ_PLUS operation
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
Date:   Mon, 3 Aug 2020 15:26:21 -0400
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D209BB0-F94C-4E53-89B2-1054E22069F9@oracle.com>
References: <20200803165954.1348263-1-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030133
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

> On Aug 3, 2020, at 12:59 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> These patches add server support for the READ_PLUS operation, which
> breaks read requests into several "data" and "hole" segments when
> replying to the client.

At this point, I've wrapped up the content of the "feature" pull
request for v5.9, so Bruce and I are assuming this series is not
for v5.9.


> Here are the results of some performance tests I ran on my own virtual
> machines, which does still have the slow SEEK_HOLE/SEEK_DATA behavior.
> A recent minimum-compiler-version patch makes installing newer kernels
> difficult on the lab machines I have access to, but I'll still try to
> collect that data since it seemed promising during my last posting
> (https://www.spinics.net/lists/linux-nfs/msg76487.html).

Nit: I've seen other maintainers prefer the use of lore.kernel.org
over spinics or mail.info for patch descriptions and cover letters.


> I tested by reading various 2G files from a few different underlying
> filesystems and across several NFS versions. I used the `vmtouch` =
utility
> to make sure files were only cached when we wanted them to be. In =
addition
> to 100% data and 100% hole cases, I also tested with files that =
alternate
> between data and hole segments. These files have either 4K, 8K, 16K, =
or 32K
> segment sizes and start with either data or hole segments. So the file
> mixed-4d has a 4K segment size beginning with a data segment, but =
mixed-32h
> has 32K segments beginning with a hole. The units are in seconds, with =
the
> first number for each NFS version being the uncached read time and the =
second
> number is for when the file is cached on the server.

In a VM environment, counting bytes transferred might be a more
useful comparison than seconds. I'm not sure if the table reports
wall clock time or something else. At what layer was the timing
measured?

CPU utilization might be interesting to report on the client
because clients would have to more work assembling a file with
holes in it.

Also the benefit of READ_PLUS might be more plain if you chose a
larger file size (by perhaps a factor of 100).

Not clear what the purpose of the v3, v4.0, and v4.1 columns is.


>          |         v3        |        v4.0       |        v4.1       | =
       v4.2       |
> ext4      | uncached:  cached | uncached:  cached | uncached:  cached =
| uncached:  cached |
> =
----------|-------------------|-------------------|-------------------|---=
----------------|
> data      |   2.697 :   1.365 |   2.539 :   1.482 |   2.246 :   1.595 =
|   2.516 :   1.716 |
> hole      |   2.389 :   1.480 |   1.692 :   1.444 |   1.904 :   1.539 =
|   1.042 :   1.005 |
> mixed-4d  |   2.426 :   1.448 |   2.468 :   1.480 |   2.258 :   1.731 =
|   2.408 :   1.674 |
> mixed-8d  |   2.446 :   1.592 |   2.497 :   1.523 |   2.240 :   1.736 =
|   2.179 :   1.547 |
> mixed-16d |   2.608 :   1.575 |   2.446 :   1.582 |   2.330 :   1.670 =
|   2.192 :   1.488 |
> mixed-32d |   2.544 :   1.587 |   2.164 :   1.499 |   2.076 :   1.452 =
|   1.982 :   1.346 |
> mixed-4h  |   2.591 :   1.486 |   2.233 :   1.503 |   2.190 :   1.520 =
|   3.679 :   1.815 |
> mixed-8h  |   2.498 :   1.547 |   2.168 :   1.510 |   2.098 :   1.511 =
|   2.815 :   1.484 |
> mixed-16h |   2.480 :   1.664 |   2.152 :   1.597 |   2.096 :   1.537 =
|   2.288 :   1.580 |
> mixed-32h |   2.520 :   1.467 |   2.171 :   1.496 |   2.246 :   1.593 =
|   2.066 :   1.389 |
>=20
>          |         v3        |        v4.0       |        v4.1       | =
       v4.2       |
> xfs       | uncached:  cached | uncached:  cached | uncached:  cached =
| uncached:  cached |
> =
----------|-------------------|-------------------|-------------------|---=
----------------|
> data      |   2.074 :   1.353 |   2.129 :   1.489 |   2.198 :   1.564 =
|   2.579 :   1.719 |
> hole      |   1.714 :   1.430 |   1.647 :   1.440 |   1.748 :   1.464 =
|   1.019 :   1.028 |
> mixed-4d  |   2.699 :   1.561 |   2.782 :   1.657 |   2.800 :   1.619 =
|   2.848 :   2.166 |
> mixed-8d  |   2.204 :   1.540 |   2.346 :   1.595 |   2.356 :   1.589 =
|   2.335 :   1.809 |
> mixed-16d |   2.034 :   1.445 |   2.212 :   1.561 |   2.172 :   1.546 =
|   2.127 :   1.658 |
> mixed-32d |   1.982 :   1.480 |   2.135 :   1.544 |   2.136 :   1.565 =
|   2.024 :   1.555 |
> mixed-4h  |   2.600 :   1.549 |   2.790 :   1.660 |   2.745 :   1.634 =
|   8.949 :   2.529 |
> mixed-8h  |   2.283 :   1.555 |   2.414 :   1.605 |   2.373 :   1.607 =
|   5.626 :   2.015 |
> mixed-16h |   2.115 :   1.512 |   2.247 :   1.593 |   2.217 :   1.608 =
|   3.740 :   1.803 |
> mixed-32h |   2.069 :   1.499 |   2.212 :   1.582 |   2.235 :   1.631 =
|   2.819 :   1.542 |
>=20
>          |         v3        |        v4.0       |        v4.1       | =
       v4.2       |
> btrfs     | uncached:  cached | uncached:  cached | uncached:  cached =
| uncached:  cached |
> =
----------|-------------------|-------------------|-------------------|---=
----------------|
> data      |   2.417 :   1.317 |   2.095 :   1.445 |   2.145 :   1.523 =
|   2.615 :   1.713 |
> hole      |   2.107 :   1.483 |   2.121 :   1.496 |   2.106 :   1.461 =
|   1.011 :   1.061 |
> mixed-4d  |   2.348 :   1.471 |   2.370 :   1.523 |   2.379 :   1.499 =
|   3.028 : 225.812 |
> mixed-8d  |   2.227 :   1.476 |   2.231 :   1.467 |   2.272 :   1.529 =
|   2.723 :  36.179 |
> mixed-16d |   2.175 :   1.460 |   2.208 :   1.457 |   2.200 :   1.464 =
|   2.526 :  10.371 |
> mixed-32d |   2.148 :   1.501 |   2.191 :   1.468 |   2.167 :   1.471 =
|   2.455 :   3.367 |
> mixed-4h  |   2.362 :   1.561 |   2.387 :   1.513 |   2.352 :   1.536 =
|   5.935 :  41.494 |
> mixed-8h  |   2.241 :   1.477 |   2.251 :   1.503 |   2.256 :   1.496 =
|   3.672 :  10.261 |
> mixed-16h |   2.238 :   1.477 |   2.188 :   1.496 |   2.183 :   1.503 =
|   2.955 :   3.809 |
> mixed-32h |   2.146 :   1.490 |   2.135 :   1.523 |   2.157 :   1.557 =
|   2.327 :   2.088 |
>=20
> Anna Schumaker (6):
>  SUNRPC: Implement xdr_reserve_space_vec()
>  NFSD: nfsd4_encode_readv() can use xdr_reserve_space_vec()
>  NFSD: Add READ_PLUS data support
>  NFSD: Add READ_PLUS hole segment encoding
>  NFSD: Return both a hole and a data segment
>  NFSD: Encode a full READ_PLUS reply
>=20
> fs/nfsd/nfs4proc.c         |  17 ++++
> fs/nfsd/nfs4xdr.c          | 169 +++++++++++++++++++++++++++++++------
> include/linux/sunrpc/xdr.h |   2 +
> net/sunrpc/xdr.c           |  45 ++++++++++
> 4 files changed, 206 insertions(+), 27 deletions(-)
>=20
> --=20
> 2.27.0
>=20

--
Chuck Lever



