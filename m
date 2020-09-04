Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33625DAF7
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Sep 2020 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgIDOIA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 10:08:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58150 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgIDOHx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 10:07:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084E3uX3054043;
        Fri, 4 Sep 2020 14:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=qxtFgr86oV+IjGR8yr8SrNVkT1Tqmi9HhSdso83XHzU=;
 b=wyxzL+GSCfyHytVbgj29BoiMNtfE320RRVGpgYeCj7TiTXoCFHt/JNkOxgH3KAbBKAVX
 iHRP4aUGJpxkPWVTYcBxXx7Z68dUEhqwgw2W5pk/AofND6UJhwVqWlX/KNxRhTP97ujc
 WFSg/ga38jn/dWun4tD4ZesyquIqmhXmPPowzMyzBe/E9HNssaLtH6N9Xyfh2OOFxkgz
 0CpWdi2VRxUA6TkVUTkyvBeQ9N2JVIri18SzvwRjM1IkmO8coJv4Ly6phsvCB4Ekm5Hv
 3g9AE99mt8moQ5zQW4k2OqU7MtvRZqVvdn13NcluHW0GzRAXSCE7JM5jG3+Rq0/no7AV NQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 339dmnd3p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 14:07:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084E6l5b002551;
        Fri, 4 Sep 2020 14:07:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3380xd9e80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 14:07:25 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084E7O3g020140;
        Fri, 4 Sep 2020 14:07:24 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 07:07:23 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v4 2/5] NFSD: Add READ_PLUS data support
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200904140324.GC26706@fieldses.org>
Date:   Fri, 4 Sep 2020 10:07:22 -0400
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <164C37D9-8044-4CF4-99A1-5FB722A16B8E@oracle.com>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
 <20200817165310.354092-3-Anna.Schumaker@Netapp.com>
 <20200828212521.GA33226@pick.fieldses.org>
 <20200828215627.GB33226@pick.fieldses.org>
 <CAFX2Jfn3LN9Zc-=4mAm1mQ3k8PN6C1yF4xqh6B-yyXCxFnp7hQ@mail.gmail.com>
 <20200901164938.GC12082@fieldses.org>
 <CAFX2Jf=vmnfV_4=401=BFnmZJCOqfEWTQRPHzRHePpJrTCcb7w@mail.gmail.com>
 <20200901191854.GD12082@fieldses.org> <20200904135259.GB26706@fieldses.org>
 <00931C34-6C86-46A2-A3B3-9727DA5E739E@oracle.com>
 <20200904140324.GC26706@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040129
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040129
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 4, 2020, at 10:03 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Fri, Sep 04, 2020 at 09:56:19AM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Sep 4, 2020, at 9:52 AM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Tue, Sep 01, 2020 at 03:18:54PM -0400, J. Bruce Fields wrote:
>>>> On Tue, Sep 01, 2020 at 01:40:16PM -0400, Anna Schumaker wrote:
>>>>> On Tue, Sep 1, 2020 at 12:49 PM J. Bruce Fields =
<bfields@fieldses.org> wrote:
>>>>>>=20
>>>>>> On Mon, Aug 31, 2020 at 02:16:26PM -0400, Anna Schumaker wrote:
>>>>>>> On Fri, Aug 28, 2020 at 5:56 PM J. Bruce Fields =
<bfields@redhat.com> wrote:
>>>>>>>> We really don't want to bother encoding small holes.  I doubt
>>>>>>>> filesystems want to bother with them either.  Do they give us =
any
>>>>>>>> guarantees as to the minimum size of a hole?
>>>>>>>=20
>>>>>>> The minimum size seems to be PAGE_SIZE from everything I've =
seen.
>>>>>>=20
>>>>>> OK, can we make that assumption explicit?  It'd simplify stuff =
like
>>>>>> this.
>>>>>=20
>>>>> I'm okay with that, but it's technically up to the underlying =
filesystem.
>>>>=20
>>>> Maybe we should ask on linux-fsdevel.
>>>>=20
>>>> Maybe minimum hole length isn't the right question: suppose at time =
1 a
>>>> file has a single hole at bytes 100-200, then it's modified so at =
time 2
>>>> it has a hole at bytes 50-150.  If you lseek(fd, 0, SEEK_HOLE) at =
time
>>>> 1, you'll get 100.  Then if you lseek(fd, 100, SEEK_DATA) at time =
2,
>>>> you'll get 150.  So you'll encode a 50-byte hole in the READ_PLUS =
reply
>>>> even though the file never had a hole smaller than 100 bytes.
>>>>=20
>>>> Minimum hole alignment might be the right idea.
>>>>=20
>>>> If we can't get that: maybe just teach encode_read to stop when it
>>>> *either* returns maxcount worth of file data (and holes) *or* =
maxcount
>>>> of encoded xdr data, just to prevent a weird filesystem from =
triggering
>>>> a bug.
>>>=20
>>> Alternatively, if it's easier, we could enforce a minimum alignment =
by
>>> rounding up the result of SEEK_HOLE to the nearest multiple of (say) =
512
>>> bytes, and rounding down the result of SEEK_DATA.
>>=20
>> Perhaps it goes without saying, but is there an effort to
>> ensure that the set of holes is represented in exactly the
>> same way when accessing a file via READ_PLUS and
>> SEEK_DATA/HOLE ?
>=20
> So you're thinking of something like a pynfs test that creates a file
> with holes and then tries reading through it with READ_PLUS and SEEK =
and
> comparing the results?

I hadn't considered a particular test platform, but yes, a regression
test like that would be appropriate.


> There are lots of legitimate reasons that test might "fail"--servers
> aren't required to support holes at all, and have a lot of lattitude
> about how to report them.

Agreed that the test would need to account for server support for holes.


> But it might be a good idea to test anyway.

My primary concern is that the result of a file copy operation should
look the same on NFS/TCP (with READ_PLUS) and NFS/RDMA (with =
SEEK_DATA/HOLE).


--
Chuck Lever



