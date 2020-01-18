Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336111418AD
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Jan 2020 18:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgARR0T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Jan 2020 12:26:19 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:49936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgARR0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Jan 2020 12:26:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00IHN9mo086388;
        Sat, 18 Jan 2020 17:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2019-08-05; bh=P8gSLqbyZ+NcMaOIXX5PX83T3w37XnsWyqHZwQC9l5k=;
 b=Z/Sa3KmRHeXQ3oJcToDBYWUIhQtulawNpLYOnodZn9VvjYsSeo2sUcPj/Pk+JCLiYIer
 R3rhSBOYAJKP3YMCtv9GtQQZM0aE1z9jLI/M/bQ8UY7sDjlIgR45gQQsFTlRWMvpluq/
 bqg+2beoV6+JPTMPVaBu2CS3dxh5TOyJLscShh9FmaWnnGUyToJYJu/RpkIh3yMjyFdO
 +4GokRyBcay04BciRDqXmxh/XOo+uNshKwf0TDJitfcirO12n2BnK3IV8u7E+muakrgn
 G8eiirJwb/7GWkFe8r0PqPsgaXqZQ1b7lmwFukNWEpTe4LCLCXdRE42klRxh4a6a9ykQ tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xktnqse6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 17:26:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00IHOcF6159339;
        Sat, 18 Jan 2020 17:26:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xksc3yxqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 17:26:13 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00IHQ4Wv021537;
        Sat, 18 Jan 2020 17:26:08 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 18 Jan 2020 09:26:04 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: 'ls -lrt' performance issue on large dir while dir is being
 modified
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <43fae563e93052f9dc9584ddd800770a7b3b10d2.camel@hammerspace.com>
Date:   Sat, 18 Jan 2020 12:26:03 -0500
Cc:     "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9327BCC2-6B75-47E3-8056-30499E090E18@oracle.com>
References: <e04baa28-2460-4ced-e387-618ea32d827c@oracle.com>
 <a41af3d6-8280-e315-fb65-a9285bad50ec@oracle.com>
 <770937d3-9439-db4a-1f6e-59a59f2c08b9@oracle.com>
 <9fdf37ffe4b3f7016a60e3a61c2087a825348b28.camel@hammerspace.com>
 <49bfa6104b6a65311594efd47592b5c2b25d905a.camel@hammerspace.com>
 <8439e738-6c90-29d9-efc8-300420b096b1@oracle.com>
 <43fae563e93052f9dc9584ddd800770a7b3b10d2.camel@hammerspace.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9504 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001180142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9504 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001180142
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 18, 2020, at 10:58 AM, Trond Myklebust =
<trondmy@hammerspace.com> wrote:
>=20
> On Fri, 2020-01-17 at 18:29 -0800, Dai Ngo wrote:
>> Hi Trond,
>>=20
>> On 1/15/20 11:06 AM, Trond Myklebust wrote:
>>> On Wed, 2020-01-15 at 18:54 +0000, Trond Myklebust wrote:
>>>> On Wed, 2020-01-15 at 10:11 -0800, Dai Ngo wrote:
>>>>> Hi Anna, Trond,
>>>>>=20
>>>>> Would you please let me know your opinion regarding reverting
>>>>> the
>>>>> change in
>>>>> nfs_force_use_readdirplus to call nfs_zap_mapping instead of
>>>>> invalidate_mapping_pages.
>>>>> This change is to prevent the cookie of the READDIRPLUS to be
>>>>> reset
>>>>> to 0 while
>>>>> an instance of 'ls' is running and the directory is being
>>>>> modified.
>>>>>=20
>>>>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c index
>>>>>> a73e2f8bd8ec..5d4a64555fa7 100644 --- a/fs/nfs/dir.c +++
>>>>>> b/fs/nfs/dir.c @@ -444,7 +444,7 @@ void
>>>>>> nfs_force_use_readdirplus(struct inode *dir)      if
>>>>>> (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
>>>>>> !list_empty(&nfsi->open_files)) {
>>>>>> set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags); -
>>>>>> invalidate_mapping_pages(dir->i_mapping, 0, -1); +
>>>>>> nfs_zap_mapping(dir, dir->i_mapping);      }  }
>>>>> Thanks,
>>>>> -Dai
>>>>>=20
>>>>> On 12/19/19 8:01 PM, Dai Ngo wrote:
>>>>>> Hi Anna, Trond,
>>>>>>=20
>>>>>> I made a mistake with the 5.5 numbers. The VM that runs 5.5
>>>>>> has
>>>>>> some
>>>>>> problems. There is no regression with 5.5, here are the new
>>>>>> numbers:
>>>>>>=20
>>>>>> Upstream Linux 5.5.0-rc1 [ORI] 93296: 3m10.917s  197891:
>>>>>> 10m35.789s
>>>>>> Upstream Linux 5.5.0-rc1 [MOD] 98614: 1m59.649s  192801:
>>>>>> 3m55.003s
>>>>>>=20
>>>>>> My apologies for the mistake.
>>>>>>=20
>>>>>> Now there is no regression with 5.5, I'd like to get your
>>>>>> opinion
>>>>>> regarding the change to revert the call from
>>>>>> invalidate_mapping_pages
>>>>>> to nfs_zap_mapping in nfs_force_use_readdirplus to prevent
>>>>>> the
>>>>>> current 'ls' from restarting the READDIRPLUS3 from cookie 0.
>>>>>> I'm
>>>>>> not quite sure about the intention of the prior change from
>>>>>> nfs_zap_mapping to invalidate_mapping_pages so that is why
>>>>>> I'm
>>>>>> seeking advise. Or do you have any suggestions to achieve the
>>>>>> same?
>>>>>>=20
>>>>>> Thanks,
>>>>>> -Dai
>>>>>>=20
>>>>>> On 12/17/19 4:34 PM, Dai Ngo wrote:
>>>>>>> Hi,
>>>>>>>=20
>>>>>>> I'd like to report an issue with 'ls -lrt' on NFSv3 client
>>>>>>> takes
>>>>>>> a very long time to display the content of a large
>>>>>>> directory
>>>>>>> (100k - 200k files) while the directory is being modified
>>>>>>> by
>>>>>>> another NFSv3 client.
>>>>>>>=20
>>>>>>> The problem can be reproduced using 3 systems. One system
>>>>>>> serves
>>>>>>> as the NFS server, one system runs as the client that doing
>>>>>>> the
>>>>>>> 'ls -lrt' and another system runs the client that creates
>>>>>>> files
>>>>>>> on the server.
>>>>>>>     Client1 creates files using this simple script:
>>>>>>>=20
>>>>>>>> #!/bin/sh
>>>>>>>>=20
>>>>>>>> if [ $# -lt 2 ]; then
>>>>>>>>         echo "Usage: $0 number_of_files base_filename"
>>>>>>>>         exit
>>>>>>>> fi    nfiles=3D$1
>>>>>>>> fname=3D$2
>>>>>>>> echo "creating $nfiles files using filename[$fname]..."
>>>>>>>> i=3D0         while [ i -lt $nfiles ] ;
>>>>>>>> do            i=3D`expr $i + 1`
>>>>>>>>         echo "xyz" > $fname$i
>>>>>>>>         echo "$fname$i" done
>>>>>>> Client2 runs 'time ls -lrt /tmp/mnt/bd1 |wc -l' in a loop.
>>>>>>>=20
>>>>>>> The network traces and dtrace probes showed numerous
>>>>>>> READDIRPLUS3
>>>>>>> requests restarting  from cookie 0 which seemed to indicate
>>>>>>> the
>>>>>>> cached pages of the directory were invalidated causing the
>>>>>>> pages
>>>>>>> to be refilled starting from cookie 0 until the current
>>>>>>> requested
>>>>>>> cookie.  The cached page invalidation were tracked to
>>>>>>> nfs_force_use_readdirplus().  To verify, I made the below
>>>>>>> modification, ran the test for various kernel versions and
>>>>>>> captured the results shown below.
>>>>>>>=20
>>>>>>> The modification is:
>>>>>>>=20
>>>>>>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>>>>>>> index a73e2f8bd8ec..5d4a64555fa7 100644
>>>>>>>> --- a/fs/nfs/dir.c
>>>>>>>> +++ b/fs/nfs/dir.c
>>>>>>>> @@ -444,7 +444,7 @@ void nfs_force_use_readdirplus(struct
>>>>>>>> inode
>>>>>>>> *dir)
>>>>>>>>      if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
>>>>>>>>          !list_empty(&nfsi->open_files)) {
>>>>>>>>          set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
>>>>>>>> -        invalidate_mapping_pages(dir->i_mapping, 0, -1);
>>>>>>>> +        nfs_zap_mapping(dir, dir->i_mapping);
>>>>>>>>      }
>>>>>>>>  }
>>>> This change is only reverting part of commit 79f687a3de9e. My
>>>> problem
>>>> with that is as follows:
>>>>=20
>>>> RFC1813 states that NFSv3 READDIRPLUS cookies and verifiers must
>>>> match
>>>> those returned by previous READDIRPLUS calls, and READDIR cookies
>>>> and
>>>> verifiers must match those returned by previous READDIR calls. It
>>>> says
>>>> nothing about being able to assume cookies from READDIR and
>>>> READDIRPLUS
>>>> calls are interchangeable. So the only reason I can see for the
>>>> invalidate_mapping_pages() is to ensure that we do separate the
>>>> two
>>>> cookie caches.
>>=20
>> If I understand your concern correctly that in NFSv3 the client must
>> maintain valid cookies and cookie verifiers when switching between
>> READDIR and READDIRPLUS, or vice sersa, then I think the current
>> client
>> code handles this condition ok.
>>=20
>> On the client, both READDIR and READDIRPLUS requests use the cookie
>> values
>> from the same cached pages of the directory so I don't think they can
>> be
>> out of sync when the client switches between READDIRPLUS and READDIR
>> requests for different nfs_readdir calls.
>>=20
>> In fact, currently the first nfs_readdir uses READDIRPLUS's to fill
>> read
>> the entries and if there is no LOOKUP/GETATTR on one of the directory
>> entries then the client reverts to READDIR's for subsequent
>> nfs_readdir
>> calls without invalidating any cached pages of the directory. If
>> there
>> are LOOKUP/GETATTR done on one of the directory entries then
>> nfs_advise_use_readdirplus is called which forces the client to use
>> READDIRPLUS again for the next nfs_readdir.
>>=20
>> Unless the user mounts the export with 'nordirplus' option then the
>> client uses only READDIRs for all requests, no switching takes place.
>=20
>=20
> I don't understand your point.

The original point was that the directory's page cache seems to
be cleared a little too often (quite apart from switching between
READDIRPLUS and READDIR).

I think Dai is saying that cache clearing is appropriate to defer
when the directory's mtime has changed but the READ method remains
the same. Otherwise repeatedly adding a new file to a very large
directory that is being read can trigger a situation where the
reading getdents loop never completes.

My two cents Euro.


> The issue is that
> nfs_advise_use_readdirplus() can cause the behaviour to switch between
> use of READDIRPLUS and use of READDIR from one syscall to getdents() =
to
> the next.
> If the client is using the same page cache, across those syscalls, =
then
> it will end up caching a mixture of cookies. Furthermore, since the
> cookie that is used as an argument to the next call to
> READDIR/READDIRPLUS is taken from that page cache, then we can end up
> calling READDIRPLUS with a cookie that came from READDIR and vice
> versa.
>=20
> As I said, I'm not convinced that is legal in RFC1813 (NFSv3).
>=20
> That is why we want to clear the page cache when we swap between use =
of
> READDIR and use of READDIRPLUS for the case of NFSv3.

Just curious, are you aware of an NFSv3 server implementation that
would have a problem with a client that mixes the cookies?


>> Thanks,
>> -Dai
>>=20
>>>> OTOH, for NFSv4, there is no separate READDIRPLUS function, so
>>>> there
>>>> really does not appear to be any reason to clear the page cache
>>>> at
>>>> all
>>>> as we're switching between requesting attributes or not.
>>>>=20
>>> Sorry... To spell out my objection to this change more clearly: The
>>> call to nfs_zap_mapping() makes no sense in either case.
>>>  * It defers the cache invalidation until the next call to
>>>    rewinddir()/opendir(), so it does not address the NFSv3
>>> concern.
>>>  * It would appear to be entirely superfluous for the NFSv4 case.
>>>=20
>>> So a change that might be acceptable would be to keep the existing
>>> call
>>> to invalidate_mapping_pages() for NFSv3, but to remove it for
>>> NFSv4.
>>>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

--
Chuck Lever



