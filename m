Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0ED9EA4D
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfH0OBu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 10:01:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45176 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfH0OBt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Aug 2019 10:01:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RDx08H065074;
        Tue, 27 Aug 2019 14:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=W15wvTw4AbjdbzrcKX4gvatc0xF9G+pntEhBCo6jtlk=;
 b=HgB9r/cUaRdCdsCuUtwPvLd5qzpSGHzcZvX/Ox7IF4B6ZM+zL8mDblKQ/qKF1ZkjhTVH
 qBJyeDqdLR+id5gfQm3JqEU3PhNBAZQ/6KncTxQqvBkTrlVjzDl576qAllqdA+hLtW6w
 8qFovAiFEKnE0ESfohVdWB0JwrxKulMjGvOQY2mQWIr7vFLFW4SWEEfWgp7eMJhSEmLt
 FjfybykhiY6XLu7foxBUFDxos0bEINKhzXDl3L7IZ9eALp1jwpw1FwQFUMpKrvzAAM4d
 nuCgaT3c95gFonue0zGPi5VWivcK/gwT31lO/P2YHXdeJJ3eME4W1uuoiIZHJ8Ovh/6E Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2un5h58ckv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 14:01:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7RDwOH7181407;
        Tue, 27 Aug 2019 13:59:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2umj2yqrhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Aug 2019 13:59:32 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7RDxRGS027235;
        Tue, 27 Aug 2019 13:59:30 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Aug 2019 06:59:27 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 0/3] Handling NFSv3 I/O errors in knfsd
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
Date:   Tue, 27 Aug 2019 09:59:25 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Jeff Layton <jlayton@poochiereds.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <61F77AD6-BD02-4322-B944-0DC263EB9BD8@oracle.com>
References: <20190826165021.81075-1-trond.myklebust@hammerspace.com>
 <20190826205156.GA27834@fieldses.org>
 <ef9f2791ef395d7c968a386ce0a32ea503d6478f.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908270151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9361 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908270151
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 26, 2019, at 5:02 PM, Trond Myklebust <trondmy@hammerspace.com> =
wrote:
>=20
> On Mon, 2019-08-26 at 16:51 -0400, J. Bruce Fields wrote:
>> On Mon, Aug 26, 2019 at 12:50:18PM -0400, Trond Myklebust wrote:
>>> Recently, a number of changes went into the kernel to try to ensure
>>> that I/O errors (specifically write errors) are reported to the
>>> application once and only once. The vehicle for ensuring the errors
>>> are reported is the struct file, which uses the 'f_wb_err' field to
>>> track which errors have been reported.
>>>=20
>>> The problem is that errors are mainly intended to be reported
>>> through
>>> fsync(). If the client is doing synchronous writes, then all is
>>> well,
>>> but if it is doing unstable writes, then the errors may not be
>>> reported until the client calls COMMIT. If the file cache has
>>> thrown out the struct file, due to memory pressure, or just because
>>> the client took a long while between the last WRITE and the COMMIT,
>>> then the error report may be lost, and the client may just think
>>> its data is safely stored.
>>=20
>> These were lost before the file caching patches as well, right?  Or
>> is
>> there some regression?=20
>=20
> Correct. This is not a regression, but an attempt to fix a problem =
that
> has existed for some time now.
>=20
>>=20
>>> Note that the problem is compounded by the fact that NFSv3 is
>>> stateless,
>>> so the server never knows that the client may have rebooted, so
>>> there
>>> can be no guarantee that a COMMIT will ever be sent.
>>>=20
>>> The following patch set attempts to remedy the situation using 2
>>> strategies:
>>>=20
>>> 1) If the inode is dirty, then avoid garbage collecting the file
>>>   from the file cache.
>>> 2) If the file is closed, and we see that it would have reported
>>>   an error to COMMIT, then we bump the boot verifier in order to
>>>   ensure the client retransmits all its writes.
>>=20
>> Sounds sensible to me.
>>=20
>>> Note that if multiple clients were writing to the same file, then
>>> we probably want to bump the boot verifier anyway, since only one
>>> COMMIT will see the error report (because the cached file is also
>>> shared).
>>=20
>> I'm confused by the "probably should".  So that's future work?  I
>> guess
>> it'd mean some additional work to identify that case.  You can't
>> really
>> even distinguish clients in the NFSv3 case, but I suppose you could
>> use
>> IP address or TCP connection as an approximation.
>=20
> I'm suggesting we should do this too, but I haven't done so yet in
> these patches. I'd like to hear other opinions (particularly from you,
> Chuck and Jeff).

The strategy of handling these errors more carefully seems good.
Bumping the write/commit verifier so the client writes again to
retrieve the latent error is clever!

It's not clear to me though that the NFSv3 protocol can deal with
the multi-client write scenario, since it is stateless. We are now
making it stateful in some sense by preserving error state on the
server across NFS requests, without having any sense of an open
file in the protocol itself.

Would an "approximation" without open state be good enough? I
assume you are doing this to more fully support the FlexFiles
layout type. Do you have any analysis or thought about this next
step?

I also echo Bruce's concern about whether the client implementations
are up to snuff. There could be long-standing bugs or their protocol
implementation could be missing parts. This is more curiosity than
an objection, but maybe noting which client implementations you've
tested with would be good.


>> --b.
>>=20
>>> So in order to implement the above strategy, we first have to do
>>> the following: split up the file cache to act per net namespace,
>>> since the boot verifier is per net namespace. Then add a helper
>>> to update the boot verifier.
>>>=20
>>> Trond Myklebust (3):
>>>  nfsd: nfsd_file cache entries should be per net namespace
>>>  nfsd: Support the server resetting the boot verifier
>>>  nfsd: Don't garbage collect files that might contain write errors
>>>=20
>>> fs/nfsd/export.c    |  2 +-
>>> fs/nfsd/filecache.c | 76 +++++++++++++++++++++++++++++++++++++--
>>> ------
>>> fs/nfsd/filecache.h |  3 +-
>>> fs/nfsd/netns.h     |  4 +++
>>> fs/nfsd/nfs3xdr.c   | 13 +++++---
>>> fs/nfsd/nfs4proc.c  | 14 +++------
>>> fs/nfsd/nfsctl.c    |  1 +
>>> fs/nfsd/nfssvc.c    | 32 ++++++++++++++++++-
>>> 8 files changed, 115 insertions(+), 30 deletions(-)
>>>=20
>>> --=20
>>> 2.21.0
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



