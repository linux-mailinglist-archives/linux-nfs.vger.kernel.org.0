Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1814A24A4A2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Aug 2020 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHSRIG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Aug 2020 13:08:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58160 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgHSRIF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Aug 2020 13:08:05 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07JH1eM1139888;
        Wed, 19 Aug 2020 17:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=6uZtmXRVD83YOaCyt2HmI/Rqk1vXFGz1fDGljlP/dbU=;
 b=l+fq/gn/Hesn1qsNvmYRYkhgCyYAy+8CFJRC4rKERVb4LbSp+4mh809Y7OlUI+rXWFie
 JLKT12FEBQi177BOqyEeCcucLBR4Zo8XfQcyWLTrpAaF7lTa/tUDZQYkw4aF66ja8EFm
 3Ujk3AmdcvRaA8kI8EFMKXMqYAHafHsaLFT3oLgW8mLqHriqynbiqFByfQoSaTk6C0u9
 GaOWzrW4CothDJ7h94iCgTOC/HiEXNE3+WXwibDsD9F7uBTjCb/MMKua+x7S1BCQAm/T
 5G6rz+ls4UnquHLeOYEvFv7K6LsyQbfYYF+uGvWK22I//PYqU3PPvRIboWnb8tK2+LYh 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32x7nmktgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Aug 2020 17:07:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07JH4LGd077696;
        Wed, 19 Aug 2020 17:07:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32xs9pgh8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Aug 2020 17:07:57 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07JH7vMI013180;
        Wed, 19 Aug 2020 17:07:57 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Aug 2020 10:07:57 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v4 0/5] NFSD: Add support for the v4.2 READ_PLUS operation
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
Date:   Wed, 19 Aug 2020 13:07:55 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <739EC59F-CC22-4064-9A74-5DF4E5455AB3@oracle.com>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
To:     Anna Schumaker <schumaker.anna@gmail.com>,
        Bruce Fields <bfields@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190142
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Aug 17, 2020, at 12:53 PM, schumaker.anna@gmail.com wrote:
>=20
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>=20
> These patches add server support for the READ_PLUS operation, which
> breaks read requests into several "data" and "hole" segments when
> replying to the client.
>=20
> - Changes since v3:
>  - Combine first two patches related to xdr_reserve_space_vec()
>  - Remove unnecessary call to svc_encode_read_payload()

My vote is let's merge v3 and continue refining.


> Here are the results of some performance tests I ran on some lab
> machines. I tested by reading various 2G files from a few different =
underlying
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
>=20
> I added some extra data collection (client cpu percentage and sys =
time),
> but the extra data means I couldn't figure out a way to break this =
down
> into a concise table. I cut out v3 and v4.0 performance numbers to get
> the size down, but I kept v4.1 for comparison because it uses the same
> code that v4.2 without read plus uses.
>=20
>=20
> Read Plus Results (ext4):
>  data
>   :... v4.1 ... Uncached ... 20.540 s, 105 MB/s, 0.65 s kern, 3% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 20.605 s, 104 MB/s, 0.65 s kern, 3% cpu
>        :....... Cached ..... 18.253 s, 118 MB/s, 0.67 s kern, 3% cpu
>  hole
>   :... v4.1 ... Uncached ... 18.255 s, 118 MB/s, 0.72 s kern,  3% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern,  3% cpu
>   :... v4.2 ... Uncached ...  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
>        :....... Cached .....  0.845 s, 2.5 GB/s, 0.72 s kern, 85% cpu
>  mixed-4d
>   :... v4.1 ... Uncached ... 54.691 s,  39 MB/s, 0.75 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 51.587 s,  42 MB/s, 0.75 s kern, 1% cpu
>        :....... Cached .....  9.215 s, 233 MB/s, 0.67 s kern, 7% cpu
>  mixed-8d
>   :... v4.1 ... Uncached ... 37.072 s,  58 MB/s, 0.67 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 33.259 s,  65 MB/s, 0.68 s kern, 2% cpu
>        :....... Cached .....  9.172 s, 234 MB/s, 0.67 s kern, 7% cpu
>  mixed-16d
>   :... v4.1 ... Uncached ... 27.138 s,  79 MB/s, 0.73 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 23.042 s,  93 MB/s, 0.73 s kern, 3% cpu
>        :....... Cached .....  9.150 s, 235 MB/s, 0.66 s kern, 7% cpu
>  mixed-32d
>   :... v4.1 ... Uncached ... 25.326 s,  85 MB/s, 0.68 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 21.125 s, 102 MB/s, 0.69 s kern, 3% cpu
>        :....... Cached .....  9.140 s, 235 MB/s, 0.67 s kern, 7% cpu
>  mixed-4h
>   :... v4.1 ... Uncached ... 58.317 s,  37 MB/s, 0.75 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 51.878 s,  41 MB/s, 0.74 s kern, 1% cpu
>        :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
>  mixed-8h
>   :... v4.1 ... Uncached ... 36.855 s,  58 MB/s, 0.68 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 29.457 s,  73 MB/s, 0.68 s kern, 2% cpu
>        :....... Cached .....  9.172 s, 234 MB/s, 0.67 s kern, 7% cpu
>  mixed-16h
>   :... v4.1 ... Uncached ... 26.460 s,  81 MB/s, 0.74 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 19.587 s, 110 MB/s, 0.74 s kern, 3% cpu
>        :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
>  mixed-32h
>   :... v4.1 ... Uncached ... 25.495 s,  84 MB/s, 0.69 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 17.634 s, 122 MB/s, 0.69 s kern, 3% cpu
>        :....... Cached .....  9.140 s, 235 MB/s, 0.68 s kern, 7% cpu
>=20
>=20
>=20
> Read Plus Results (xfs):
>  data
>   :... v4.1 ... Uncached ... 20.230 s, 106 MB/s, 0.65 s kern, 3% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 20.724 s, 104 MB/s, 0.65 s kern, 3% cpu
>        :....... Cached ..... 18.253 s, 118 MB/s, 0.67 s kern, 3% cpu
>  hole
>   :... v4.1 ... Uncached ... 18.255 s, 118 MB/s, 0.68 s kern,  3% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.69 s kern,  3% cpu
>   :... v4.2 ... Uncached ...  0.904 s, 2.4 GB/s, 0.72 s kern, 79% cpu
>        :....... Cached .....  0.908 s, 2.4 GB/s, 0.73 s kern, 80% cpu
>  mixed-4d
>   :... v4.1 ... Uncached ... 57.553 s,  37 MB/s, 0.77 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 37.162 s,  58 MB/s, 0.73 s kern, 1% cpu
>        :....... Cached .....  9.215 s, 233 MB/s, 0.67 s kern, 7% cpu
>  mixed-8d
>   :... v4.1 ... Uncached ... 36.754 s,  58 MB/s, 0.69 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 24.454 s,  88 MB/s, 0.69 s kern, 2% cpu
>        :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
>  mixed-16d
>   :... v4.1 ... Uncached ... 27.156 s,  79 MB/s, 0.73 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 22.934 s,  94 MB/s, 0.72 s kern, 3% cpu
>        :....... Cached .....  9.150 s, 235 MB/s, 0.68 s kern, 7% cpu
>  mixed-32d
>   :... v4.1 ... Uncached ... 27.849 s,  77 MB/s, 0.68 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 23.670 s,  91 MB/s, 0.67 s kern, 2% cpu
>        :....... Cached .....  9.139 s, 235 MB/s, 0.64 s kern, 7% cpu
>  mixed-4h
>   :... v4.1 ... Uncached ... 57.639 s,  37 MB/s, 0.72 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.69 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 35.503 s,  61 MB/s, 0.72 s kern, 2% cpu
>        :....... Cached .....  9.215 s, 233 MB/s, 0.66 s kern, 7% cpu
>  mixed-8h
>   :... v4.1 ... Uncached ... 37.044 s,  58 MB/s, 0.71 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 23.779 s,  90 MB/s, 0.69 s kern, 2% cpu
>        :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
>  mixed-16h
>   :... v4.1 ... Uncached ... 27.167 s,  79 MB/s, 0.73 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 19.088 s, 113 MB/s, 0.75 s kern, 3% cpu
>        :....... Cached .....  9.159 s, 234 MB/s, 0.66 s kern, 7% cpu
>  mixed-32h
>   :... v4.1 ... Uncached ... 27.592 s,  78 MB/s, 0.71 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.68 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 19.682 s, 109 MB/s, 0.67 s kern, 3% cpu
>        :....... Cached .....  9.140 s, 235 MB/s, 0.67 s kern, 7% cpu
>=20
>=20
>=20
> Read Plus Results (btrfs):
>  data
>   :... v4.1 ... Uncached ... 21.317 s, 101 MB/s, 0.63 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.67 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 28.665 s,  75 MB/s, 0.65 s kern, 2% cpu
>        :....... Cached ..... 18.253 s, 118 MB/s, 0.66 s kern, 3% cpu
>  hole
>   :... v4.1 ... Uncached ... 18.256 s, 118 MB/s, 0.70 s kern,  3% cpu
>   :    :....... Cached ..... 18.254 s, 118 MB/s, 0.73 s kern,  4% cpu
>   :... v4.2 ... Uncached ...  0.851 s, 2.5 GB/s, 0.72 s kern, 84% cpu
>        :....... Cached .....  0.847 s, 2.5 GB/s, 0.73 s kern, 86% cpu
>  mixed-4d
>   :... v4.1 ... Uncached ... 56.857 s,  38 MB/s, 0.76 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.72 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 54.455 s,  39 MB/s, 0.73 s kern, 1% cpu
>        :....... Cached .....  9.215 s, 233 MB/s, 0.68 s kern, 7% cpu
>  mixed-8d
>   :... v4.1 ... Uncached ... 36.641 s,  59 MB/s, 0.68 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 33.205 s,  65 MB/s, 0.67 s kern, 2% cpu
>        :....... Cached .....  9.172 s, 234 MB/s, 0.65 s kern, 7% cpu
>  mixed-16d
>   :... v4.1 ... Uncached ... 28.653 s,  75 MB/s, 0.72 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 25.748 s,  83 MB/s, 0.71 s kern, 2% cpu
>        :....... Cached .....  9.150 s, 235 MB/s, 0.64 s kern, 7% cpu
>  mixed-32d
>   :... v4.1 ... Uncached ... 28.886 s,  74 MB/s, 0.67 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.71 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 24.724 s,  87 MB/s, 0.74 s kern, 2% cpu
>        :....... Cached .....  9.140 s, 235 MB/s, 0.63 s kern, 6% cpu
>  mixed-4h
>   :... v4.1 ... Uncached ...  52.181 s,  41 MB/s, 0.73 s kern, 1% cpu
>   :    :....... Cached .....  18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 150.341 s,  14 MB/s, 0.72 s kern, 0% cpu
>        :....... Cached .....   9.216 s, 233 MB/s, 0.63 s kern, 6% cpu
>  mixed-8h
>   :... v4.1 ... Uncached ... 36.945 s,  58 MB/s, 0.68 s kern, 1% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.65 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 79.781 s,  27 MB/s, 0.68 s kern, 0% cpu
>        :....... Cached .....  9.172 s, 234 MB/s, 0.66 s kern, 7% cpu
>  mixed-16h
>   :... v4.1 ... Uncached ... 28.651 s,  75 MB/s, 0.73 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.66 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 47.428 s,  45 MB/s, 0.71 s kern, 1% cpu
>        :....... Cached .....  9.150 s, 235 MB/s, 0.67 s kern, 7% cpu
>  mixed-32h
>   :... v4.1 ... Uncached ... 28.618 s,  75 MB/s, 0.69 s kern, 2% cpu
>   :    :....... Cached ..... 18.252 s, 118 MB/s, 0.70 s kern, 3% cpu
>   :... v4.2 ... Uncached ... 38.813 s,  55 MB/s, 0.67 s kern, 1% cpu
>        :....... Cached .....  9.140 s, 235 MB/s, 0.61 s kern, 6% cpu
>=20
>=20
>=20
> Thoughts?
> Anna
>=20
>=20
> Anna Schumaker (5):
>  SUNRPC/NFSD: Implement xdr_reserve_space_vec()
>  NFSD: Add READ_PLUS data support
>  NFSD: Add READ_PLUS hole segment encoding
>  NFSD: Return both a hole and a data segment
>  NFSD: Encode a full READ_PLUS reply
>=20
> fs/nfsd/nfs4proc.c         |  17 ++++
> fs/nfsd/nfs4xdr.c          | 167 +++++++++++++++++++++++++++++++------
> include/linux/sunrpc/xdr.h |   2 +
> net/sunrpc/xdr.c           |  45 ++++++++++
> 4 files changed, 204 insertions(+), 27 deletions(-)
>=20
> --=20
> 2.28.0
>=20

--
Chuck Lever



