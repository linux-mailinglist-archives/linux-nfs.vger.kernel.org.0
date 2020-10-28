Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C872B29DA19
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Oct 2020 00:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbgJ1XOY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Oct 2020 19:14:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52246 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390211AbgJ1XNE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Oct 2020 19:13:04 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SD5EvT038593;
        Wed, 28 Oct 2020 13:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=84rMQMVIKIwbl5Ysxwce04riRMGp2/LSnCibTJwyYDA=;
 b=NDSVfD+YARnLMWSzHgRIrv+3DN5JZ4Dt983zLdmkGyrIJt1Htu/C31IDhQxS1wDbaiLf
 gXccEtORj9k1T4aPD4UQmTci6jGDIqXcTbePcaXoTqk6tnEgH98Ug5KPy6EP4gxiWc8k
 akMhApPuIPEp3S3Q/aFpB2RbLCviGcI9MLOKchpyuoB9uX7F2286jkswckh0aFOpBh8V
 wHJYdjMq9Tvjo3zw86TOAqoHF4NwarQg+9w3Xj7rmLxsNcl59Jpi9pLg0ETEUaC9Ys08
 eFGHWuCLLtcfoZi8zMCQDpS1+fNZlWooiTrqriaW9LRLMcoXi4JVEYuViKhSpzZAjihr XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34c9sayexh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:10:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDALZQ179926;
        Wed, 28 Oct 2020 13:10:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 34cx1ry9gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:10:46 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SDAjG6003717;
        Wed, 28 Oct 2020 13:10:45 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 06:10:45 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 00/20] NFSD support for multiple RPC/RDMA chunks
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201028071601.GA114054@unreal>
Date:   Wed, 28 Oct 2020 09:10:42 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <386B59D5-BBAB-464A-A37F-13290CBE51E6@oracle.com>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
 <20201027060823.GF4821@unreal>
 <DAC657D8-D254-452C-9B21-3053F70C8C73@oracle.com>
 <20201028071601.GA114054@unreal>
To:     Leon Romanovsky <leon@kernel.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280088
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 28, 2020, at 3:16 AM, Leon Romanovsky <leon@kernel.org> wrote:
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
>>=20
>> And the Linux NFS server implementation (the non-transport specific
>> part) already supports multiple data payloads per NFSv4 COMPOUND.
>=20
> Thanks, I just got different feeling then I read the cover letter.
> You presented it like no one needs this feature.

Understood. I'll incorporate a summary of the content of this thread
in the cover letter for the next version of the series.

--
Chuck Lever



