Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D1529C214
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 18:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1819939AbgJ0RbX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 13:31:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58586 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1819447AbgJ0RaJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Oct 2020 13:30:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RHJpjA035966;
        Tue, 27 Oct 2020 17:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=/8XvTAsg8nY/7dtMegiNl3lPyG1gHOa+DpOe1QAzegg=;
 b=PHfiwRp0dls7RVWFwENLItplBrpOZYwDeKc7ZQox7ZIV+YLpVvZy1Z8+JhclkiKn1Ypr
 yVmpgbRBSvA2C+rN86kapNSpd08xdoTb7E+44I5UTN6noZYxwrmvnpXe4hUKaDJ6HVMu
 UV2UikbnJfnsH0heTTsV9Na9Pb3mcXueY48rS7lmo7cBStshOjENb9l8bAux3AvyTco0
 almB19G/51kRACgYsp5k6hGFT96MH4CdJvcRflFxOM06dcN9oCb61GVZ7KldJZBhrymq
 yf5O4lUpvhOY1J1WhOFFkIiAyPjOYhu79XlEOXhQYCRJP/SMEhPcL7sREllE0kDONsWI 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34c9sauhvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 17:30:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RHG3M6019976;
        Tue, 27 Oct 2020 17:30:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34cx5xdjj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 17:30:04 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09RHU1GY016924;
        Tue, 27 Oct 2020 17:30:01 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 10:30:00 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 00/20] NFSD support for multiple RPC/RDMA chunks
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201027172545.GB1644@fieldses.org>
Date:   Tue, 27 Oct 2020 13:29:59 -0400
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D00EBDE2-D748-4977-9E2D-186BFAD56ED5@oracle.com>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
 <20201027060823.GF4821@unreal>
 <DAC657D8-D254-452C-9B21-3053F70C8C73@oracle.com>
 <20201027172545.GB1644@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270104
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 27, 2020, at 1:25 PM, bfields@fieldses.org wrote:
>=20
> On Tue, Oct 27, 2020 at 09:24:54AM -0400, Chuck Lever wrote:
>> Hi Leon-
>>=20
>>> On Oct 27, 2020, at 2:08 AM, Leon Romanovsky <leon@kernel.org> =
wrote:
>>>=20
>>> On Mon, Oct 26, 2020 at 02:53:53PM -0400, Chuck Lever wrote:
>>>> This series implements support for multiple RPC/RDMA chunks per RPC
>>>> transaction. This is one of the few remaining generalities that the
>>>> Linux NFS/RDMA server implementation lacks.
>>>>=20
>>>> There is currently one known NFS/RDMA client implementation that =
can
>>>> send multiple chunks per RPC, and that is Solaris. Multiple chunks
>>>> are rare enough that the Linux NFS/RDMA implementation has been
>>>> successful without this support for many years.
>>>=20
>>> So why do we need it? Solaris is dead, and like you wrote Linux =
systems
>>> work without this feature just fine, what are the benefits? Who will =
use it?
>>=20
>> The Linux NFS implementation is living. We can add the ability
>> to provision multiple chunks per RPC to the Linux NFS client at
>> any time.
>>=20
>> Likewise any actively developed NFS/RDMA implementation can add
>> this feature. The RPC/RDMA version 1 protocol does not have the
>> ability to communicate the maximum number of chunks the server
>> will accept per RPC.
>>=20
>> Other server implementations do support multiple chunks per RPC.
>> The Linux NFS/RDMA server implementation has always been incomplete
>> in this regard.
>=20
> Can the client can detect the server's lack of support and fall back, =
or
> does the server's incompleteness violate the RFC in some way that can
> actually cause a failure to interoperate?

The latter. Currently the client has no way to detect that our server
does not comply with RFC 8166, which places no arbitrary limits on
the number of chunks per RPC.

If a client attempts to send more than one chunk the RPC fails (or
worse). RPC/RDMA version 1 does not provide a way to indicate that
the failure was because the client sent too many chunks, so the
client has to terminate the RPC transaction with an error.


>> And the Linux NFS server implementation (the non-transport specific
>> part) already supports multiple data payloads per NFSv4 COMPOUND.
>>=20
>>=20
>> Restoring a little more of the cover letter:
>>=20
>>>> Along with multiple chunk support, this series adds the following
>>>> benefits:
>>>>=20
>>>> - More robust input sanitization of RPC/RDMA headers
>>>> - An internal representation of chunks that is agnostic to their
>>>> wire format
>>=20
>> The Linux NFS/RDMA server implementation does need to have better
>> input sanitization.
>>=20
>> And there is a version 2 of RPC/RDMA under active development:
>>=20
>> =
https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rpcrdma-version-two/
>>=20
>> Having some protocol version agnosticism in our transport might
>> be necessary eventually.
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



