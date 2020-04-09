Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC45E1A397C
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2020 20:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDISBk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Apr 2020 14:01:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41208 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDISBj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Apr 2020 14:01:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039HvqsS143622;
        Thu, 9 Apr 2020 18:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=AtqCSEnZenvGDp1JOs7m+2nTzMRaM4LcMCGPy/aqKXc=;
 b=oZRuik+fE2MMAfJXr0Dzj4Ucp6tCiallJ2Y5CHCVD9SRjfLB8dTAUkksq0j87nT4pK2s
 MuyaPkCqSLXbCkMfoFEm3B7pFucLu4y+pIWXhGidkjkDSo7FiydWl8OA8Hm2W9e9Iwi9
 vceQYWu4tYLHpzpN5jB/eoxB5OQYc4uydzB4qwvncjhtL52siNA+zL6HTm9pFQ0094uJ
 BeW5Uy+1s2a1qHvHQ6IUEU7eg4ajGu1rrUoLDRGvSYhrWjml0aVdDND9wxebx49t84CO
 2qzxk9kGqYSfczauLFThOTyjb1oBmiALgOSGt6fiZeH0/NNeL2/MRq+gYFSys4QoJa9h tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3091m131g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 18:01:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039HueGY048553;
        Thu, 9 Apr 2020 17:59:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 309gdccpxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 17:59:35 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 039HxXY1005016;
        Thu, 9 Apr 2020 17:59:34 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 10:59:33 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 3/3] svcrdma: Fix leak of svc_rdma_recv_ctxt objects
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200409174750.GK11886@ziepe.ca>
Date:   Thu, 9 Apr 2020 13:59:32 -0400
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E152D35-987D-4507-95FA-9848253103BD@oracle.com>
References: <20200407190938.24045.64947.stgit@klimt.1015granger.net>
 <20200407191106.24045.88035.stgit@klimt.1015granger.net>
 <20200408060242.GB3310@unreal>
 <D3CFDCAA-589C-4B3F-B769-099BF775D098@oracle.com>
 <20200409174750.GK11886@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090130
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 9, 2020, at 1:47 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>=20
> On Thu, Apr 09, 2020 at 10:33:32AM -0400, Chuck Lever wrote:
>> Hi Leon-
>>=20
>>> On Apr 8, 2020, at 2:02 AM, Leon Romanovsky <leon@kernel.org> wrote:
>>>=20
>>> On Tue, Apr 07, 2020 at 03:11:06PM -0400, Chuck Lever wrote:
>>>> Utilize the xpo_release_rqst transport method to ensure that each
>>>> rqstp's svc_rdma_recv_ctxt object is released even when the server
>>>> cannot return a Reply for that rqstp.
>>>>=20
>>>> Without this fix, each RPC whose Reply cannot be sent leaks one
>>>> svc_rdma_recv_ctxt. This is a 2.5KB structure, a 4KB DMA-mapped
>>>> Receive buffer, and any pages that might be part of the Reply
>>>> message.
>>>>=20
>>>> The leak is infrequent unless the network fabric is unreliable or
>>>> Kerberos is in use, as GSS sequence window overruns, which result
>>>> in connection loss, are more common on fast transports.
>>>>=20
>>>> Fixes: 3a88092ee319 ("svcrdma: Preserve Receive buffer until ... ")
>>>=20
>>> Chuck,
>>>=20
>>> Can you please don't mangle the Fixes line?
>>=20
>> I've read e-mail from others that advocate this form of mangling
>> instead of using commit message lines that are too long.
>=20
> Really?

Yep.


> At least I won't accept Fixes lines that are not in the cannonical
> format, I routinely fix these things in all sorts of ways, but I've
> never seen someone shorten it with ...

It seems that is a Maintainers preference.


>>> A lot of automatization is relying on the fact that this line is =
canonical,
>>> both in format and in the actual content.
>>=20
>> Understood, but checkpatch.pl does not complain about it. Perhaps,
>> therefore, it is the automation that is not correct.
>=20
> checkpatch.pl doesn't check Fixes lines for correctness,

It certainly does check Fixes: lines for correctness. Lately, it's
been warning about commit IDs that are not exactly 12 hexits long,
and cases where the commit ID does not actually exist in the local
repository.

It used to complain about "..." as well, until someone said that is
a frequently-used modification to keep the line length manageable.
I think that might be why checkpatch.pl no longer checks the tag's
short description.


> because it
> doesn't have access to the git or something. This was talked about
> too.. Stephen likes to check them as part of linux-next though.
>=20
> However, checkpatch.pl does not complain for long lines on Fixes:
> tags demanding they be shortened

Maybe not, but I don't think that's always been the case. <shrug>


>> The commit ID is what automation should key off of. The short
>> description is only for human consumption.=20
>=20
> Right, so if the actual commit message isn't included so humans can
> read it then what was the point of including anything?

I didn't invent the Fixes: tag, and I didn't invent shortening it.
That had to come from somewhere as well. So here we are.

No matter, though. Now that I know this community's preference, I
will stick to it. Will you take "yes" for an answer? ;-)


--
Chuck Lever



