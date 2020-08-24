Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1026B25014D
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Aug 2020 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHXPml (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Aug 2020 11:42:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48432 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgHXPmd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Aug 2020 11:42:33 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OFdF9e010041;
        Mon, 24 Aug 2020 15:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=SZR0DvYF7pHYg2+d4bsj4eCJvykHBvbCBA7NOptCKgQ=;
 b=XVURKlZLwvR79BGSffCYmW1pCi6goLoZVvrIVelSF3VytKlVUarnLLQklkLUtA76WMG0
 yprayHfuSN3VZXrxug5syM40pLDegZrLrarxCQDG3XFZPLKsi/x/QIH2UeVx+cRagTqu
 gmc2qFCaHhm8ZxPHnzgGcSam4bWtkqghGp6LmJxpp1T5YCl+UtexX/+3Tr4QySs/oCSy
 EiCoboxaCw3lj3wdNhLT6AgsvduheBpeDIBP2F62zM1uy773/bSlab0nfBf3PCI4lVXT
 K9jzD6MZzB5c/qt70tda/FMYmZyEUsHbM26tLMI6aSdgk8xAdJtPrw7HpWDFnWQKyk7S yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 333w6tkuv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 15:42:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OFZFDs100766;
        Mon, 24 Aug 2020 15:42:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 333r9he1eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 15:42:20 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07OFgJA8008340;
        Mon, 24 Aug 2020 15:42:19 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 08:42:19 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200824142237.GA29837@fieldses.org>
Date:   Mon, 24 Aug 2020 11:42:18 -0400
Cc:     Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3CDC823-B550-4F7A-B592-4B8871131227@oracle.com>
References: <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
 <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
 <20200810201001.GC13266@fieldses.org>
 <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
 <F20E4EC5-71DD-4A92-A583-41BEE177F53C@oracle.com>
 <20200817222034.GA6390@fieldses.org>
 <CD4B80B9-4F58-46B4-872C-F2F139AFB231@oracle.com>
 <20200819212927.GB30476@fieldses.org>
 <5D346E9E-C7C5-49F7-9694-8DD98AF1149A@oracle.com>
 <20200824142237.GA29837@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9722 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240125
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 24, 2020, at 10:22 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Mon, Aug 24, 2020 at 09:39:31AM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Aug 19, 2020, at 5:29 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Tue, Aug 18, 2020 at 05:26:26PM -0400, Chuck Lever wrote:
>>>>=20
>>>>> On Aug 17, 2020, at 6:20 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>>>=20
>>>>> On Sun, Aug 16, 2020 at 04:46:00PM -0400, Chuck Lever wrote:
>>>>>=20
>>>>>> In order of application:
>>>>>>=20
>>>>>> 5920afa3c85f ("nfsd: hook nfsd_commit up to the nfsd_file cache")
>>>>>> 961.68user 5252.40system 20:12.30elapsed 512%CPU, 2541 DELAY =
errors
>>>>>> These results are similar to v5.3.
>>>>>>=20
>>>>>> fd4f83fd7dfb ("nfsd: convert nfs4_file->fi_fds array to use =
nfsd_files")
>>>>>> Does not build
>>>>>>=20
>>>>>> eb82dd393744 ("nfsd: convert fi_deleg_file and ls_file fields to =
nfsd_file")
>>>>>> 966.92user 5425.47system 33:52.79elapsed 314%CPU, 1330 DELAY =
errors
>>>>>>=20
>>>>>> Can you take a look and see if there's anything obvious?
>>>>>=20
>>>>> Unfortunately nothing about the file cache code is very obvious to =
me.
>>>>> I'm looking at it....
>>>>>=20
>>>>> It adds some new nfserr_jukebox returns in nfsd_file_acquire.  =
Those
>>>>> mostly look like kmalloc failures, the one I'm not sure about is =
the
>>>>> NFSD_FILE_HASHED check.
>>>>>=20
>>>>> Or maybe it's the lease break there.
>>>>=20
>>>> nfsd_file_acquire() always calls fh_verify() before it invokes =
nfsd_open().
>>>> Replacing nfs4_get_vfs_file's nfsd_open() call with =
nfsd_file_acquire() adds
>>>> almost 10 million fh_verify() calls to my test run.
>>>=20
>>> Checking out the code as of fd4f83fd7dfb....
>>>=20
>>> nfsd_file_acquire() calls nfsd_open_verified().
>>>=20
>>> And nfsd_open() is basically just fh_verify()+nfsd_open_verified().
>>>=20
>>> So it doesn't look like the replacement of nfsd_open() by
>>> nfsd_file_acquire() should have changed the number of fh_verify() =
calls.
>>=20
>> I see a lot more vfs_setlease() failures after fd4f83fd7dfb.
>> check_conflicting_open() fails because "inode is open for write":
>>=20
>> 1780         if (arg =3D=3D F_RDLCK)
>> 1781                 return inode_is_open_for_write(inode) ? -EAGAIN =
: 0;
>>=20
>> The behavior on the wire is that the server simply doesn't hand out
>> many delegations.
>>=20
>> NFSv4 OPEN uses nfsd_file_acquire() now, but I don't see CLOSE
>> releasing the cached file descriptor. Wouldn't that cached
>> descriptor conflict with subsequent OPENs?
>=20
> Could be, yes.
>=20
> That also reminds me of this patch, did I already send it to you?

I don't have this one. I can try it.


> --b.
>=20
> commit 055e7b94ef32
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Fri Jul 17 18:54:54 2020 -0400
>=20
>    nfsd: Cache R, RW, and W opens separately
>=20
>    The nfsd open code has always kept separate read-only, read-write, =
and
>    write-only opens as necessary to ensure that when a client closes =
or
>    downgrades, we don't retain more access than necessary.
>=20
>    Honestly, I'm not sure if that's completely necessary, but I'd =
rather
>    stick to that behavior.
>=20
>    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 82198d747c4c..4b6f70e0d987 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -891,7 +891,7 @@ nfsd_file_find_locked(struct inode *inode, =
unsigned int may_flags,
>=20
> 	hlist_for_each_entry_rcu(nf, =
&nfsd_file_hashtbl[hashval].nfb_head,
> 				 nf_node, =
lockdep_is_held(&nfsd_file_hashtbl[hashval].nfb_lock)) {
> -		if ((need & nf->nf_may) !=3D need)
> +		if (nf->nf_may !=3D need)
> 			continue;
> 		if (nf->nf_inode !=3D inode)
> 			continue;

--
Chuck Lever



