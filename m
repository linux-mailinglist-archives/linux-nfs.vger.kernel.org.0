Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4897C25E3B9
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Sep 2020 00:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgIDWaA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Sep 2020 18:30:00 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57674 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgIDW36 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Sep 2020 18:29:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084MKVHn038661;
        Fri, 4 Sep 2020 22:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=KGD56e/iWY994DGaK2bn6ocLxZJKLnyBVN4W2FRbCD0=;
 b=k2mXYd6QHd6/UWmA3ZTD9T/3+/ASZBrZIqRRXIZEZL0aJg/dt+fikVNjoA/psHriAJBv
 n96BAM2qB74QOGdho3xrP0Z1dfSmmmx9jRp7Q4BQ1KLRRiYYGKdDGFBY4ZWQwsR+Pgo+
 vrjw4hNZQetGF5SSi2W0EfgMupxSFYBlUliWpxjVO8T+7qh6CCu/2CK/pMrk+qnzebuB
 RBp/1by7jVWEvjgfckctavmE2j6Tz+dRlKQSdvDGvSVYAq2kNKBj+x+VStWnKXjh42uE
 yaQhIgWz+XFdzKzMI9FXAgFYiz++mk32DEwT9t9BlUxjuMjJSrfYJ9gbCQcHJpctk4wT AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eergr7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 22:29:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084MFMOl058253;
        Fri, 4 Sep 2020 22:27:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3380ku4x74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 22:27:53 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084MRqeU003942;
        Fri, 4 Sep 2020 22:27:52 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 15:27:51 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200904220104.GA7212@fieldses.org>
Date:   Fri, 4 Sep 2020 18:27:50 -0400
Cc:     Jeff Layton <jlayton@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <65A920C4-BA5D-43FC-976B-A29C282CF6F4@oracle.com>
References: <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
 <20200810201001.GC13266@fieldses.org>
 <CA3288FC-8B9A-4F19-A51C-E1169726E946@oracle.com>
 <F20E4EC5-71DD-4A92-A583-41BEE177F53C@oracle.com>
 <20200817222034.GA6390@fieldses.org>
 <CD4B80B9-4F58-46B4-872C-F2F139AFB231@oracle.com>
 <20200819212927.GB30476@fieldses.org>
 <5D346E9E-C7C5-49F7-9694-8DD98AF1149A@oracle.com>
 <20200824142237.GA29837@fieldses.org>
 <A3CDC823-B550-4F7A-B592-4B8871131227@oracle.com>
 <20200904220104.GA7212@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040190
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040190
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 4, 2020, at 6:01 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Mon, Aug 24, 2020 at 11:42:18AM -0400, Chuck Lever wrote:
>>=20
>>=20
>>> On Aug 24, 2020, at 10:22 AM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>=20
>>> On Mon, Aug 24, 2020 at 09:39:31AM -0400, Chuck Lever wrote:
>>>>=20
>>>>=20
>>>>> On Aug 19, 2020, at 5:29 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>>>=20
>>>>> On Tue, Aug 18, 2020 at 05:26:26PM -0400, Chuck Lever wrote:
>>>>>>=20
>>>>>>> On Aug 17, 2020, at 6:20 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>>>>>>>=20
>>>>>>> On Sun, Aug 16, 2020 at 04:46:00PM -0400, Chuck Lever wrote:
>>>>>>>=20
>>>>>>>> In order of application:
>>>>>>>>=20
>>>>>>>> 5920afa3c85f ("nfsd: hook nfsd_commit up to the nfsd_file =
cache")
>>>>>>>> 961.68user 5252.40system 20:12.30elapsed 512%CPU, 2541 DELAY =
errors
>>>>>>>> These results are similar to v5.3.
>>>>>>>>=20
>>>>>>>> fd4f83fd7dfb ("nfsd: convert nfs4_file->fi_fds array to use =
nfsd_files")
>>>>>>>> Does not build
>>>>>>>>=20
>>>>>>>> eb82dd393744 ("nfsd: convert fi_deleg_file and ls_file fields =
to nfsd_file")
>>>>>>>> 966.92user 5425.47system 33:52.79elapsed 314%CPU, 1330 DELAY =
errors
>>>>>>>>=20
>>>>>>>> Can you take a look and see if there's anything obvious?
>>>>>>>=20
>>>>>>> Unfortunately nothing about the file cache code is very obvious =
to me.
>>>>>>> I'm looking at it....
>>>>>>>=20
>>>>>>> It adds some new nfserr_jukebox returns in nfsd_file_acquire.  =
Those
>>>>>>> mostly look like kmalloc failures, the one I'm not sure about is =
the
>>>>>>> NFSD_FILE_HASHED check.
>>>>>>>=20
>>>>>>> Or maybe it's the lease break there.
>>>>>>=20
>>>>>> nfsd_file_acquire() always calls fh_verify() before it invokes =
nfsd_open().
>>>>>> Replacing nfs4_get_vfs_file's nfsd_open() call with =
nfsd_file_acquire() adds
>>>>>> almost 10 million fh_verify() calls to my test run.
>>>>>=20
>>>>> Checking out the code as of fd4f83fd7dfb....
>>>>>=20
>>>>> nfsd_file_acquire() calls nfsd_open_verified().
>>>>>=20
>>>>> And nfsd_open() is basically just =
fh_verify()+nfsd_open_verified().
>>>>>=20
>>>>> So it doesn't look like the replacement of nfsd_open() by
>>>>> nfsd_file_acquire() should have changed the number of fh_verify() =
calls.
>>>>=20
>>>> I see a lot more vfs_setlease() failures after fd4f83fd7dfb.
>>>> check_conflicting_open() fails because "inode is open for write":
>>>>=20
>>>> 1780         if (arg =3D=3D F_RDLCK)
>>>> 1781                 return inode_is_open_for_write(inode) ? =
-EAGAIN : 0;
>>>>=20
>>>> The behavior on the wire is that the server simply doesn't hand out
>>>> many delegations.
>>>>=20
>>>> NFSv4 OPEN uses nfsd_file_acquire() now, but I don't see CLOSE
>>>> releasing the cached file descriptor. Wouldn't that cached
>>>> descriptor conflict with subsequent OPENs?
>>>=20
>>> Could be, yes.
>>>=20
>>> That also reminds me of this patch, did I already send it to you?
>>=20
>> I don't have this one. I can try it.
>=20
> No difference, I take it?

It helps a little, but it doesn't appear to address the regression.

It does seem like a reasonable change to take anyway. You could
take both of the earlier patches in this thread for v5.10, IMO.


> There could also be something wrong with =
nfsd4_check_conflicting_opens()
> that's preventing delegations when it shouldn't.

I've added some instrumentation there. It looks like @writes
is still positive because of a previous cached open. The NFS
request stream goes something like this:

OPEN(CREATE) access=3DWRITE name=3Dyada
WRITE
CLOSE
... here is where the cached WR_ONLY open remains

OPEN(NOCREATE) access=3DREAD name=3Dyada
... conflict detected, no soup for you.

I checked, and before the filecache support was added, the server
does offer a read delegation in this case.


> There might also be some way fh_verify() could be smarter.  There's a
> big comment there explaining why we repeat the permission checks each
> time, but maybe we could keep a flag somewhere that tracks whether we
> really need to call nfsd_setuser again.

I'll have a look at that more closely once we are clear of this
performance regression. The architecture of how fh_verify is
used has been around forever, and it seems like a it's a
separate issue.

I've added some tracepoints that report fh_verify calls and each
change to the current FH. Here's a single OPEN call on the server.
Note the number of fh_verify calls and how long they take
(timestamps are seconds since boot). This is from a single-thread
test on the server, so there's no other activity going on.

6398.079629: nfsd_compound:        xid=3D0x59f1891e opcnt=3D5
6398.079632: nfsd_fh_current:      xid=3D0x59f1891e fh_hash=3D0x0a393779
6398.079685: nfsd_fh_verify:       xid=3D0x59f1891e fh_hash=3D0x0a393779 =
type=3DNONE access=3DBYPASS_GSS status=3D0
6398.079687: nfsd_compound_status: xid=3D0x59f1891e op=3D1/5 OP_PUTFH =
status=3D0
6398.079689: nfsd_open_args:       xid=3D0x59f1891e seqid=3D12 =
type=3DNOCREATE claim=3DNULL share=3DREAD name=3DMakefile
6398.079753: nfsd_fh_verify:       xid=3D0x59f1891e fh_hash=3D0x0a393779 =
type=3DDIR access=3DEXEC status=3D0
6398.079789: nfsd_fh_verify:       xid=3D0x59f1891e fh_hash=3D0x2c049d00 =
type=3DREG access=3DREAD|READ_IF_EXEC status=3D0
6398.079830: nfsd_fh_verify:       xid=3D0x59f1891e fh_hash=3D0x2c049d00 =
type=3DREG access=3DREAD|OWNER_OVERRIDE status=3D0
6398.079833: nfsd_file_acquire:    xid=3D0x59f1891e hash=3D0xe28 =
inode=3D0xffff88873f4777b0 may_flags=3DREAD ref=3D2 =
nf_flags=3DHASHED|REFERENCED nf_may=3DREAD nf_file=3D0xffff88872cc53e00 =
status=3D0
6398.079868: generic_add_lease:    dev=3D0x0:0x23 ino=3D0xe42af wcount=3D0=
 rcount=3D1 icount=3D2 fl_owner=3D0xffff88871914cfd8 fl_flags=3DFL_DELEG =
fl_type=3DF_RDLCK
6398.079876: locks_get_lock_context: dev=3D0x0:0x23 ino=3D0xe42af =
type=3DF_RDLCK ctx=3D0xffff8886d8a43b58
6398.079881: nfsd_deleg_open:      client 5f529c2f:b9aedadc stateid =
002471d9:00000001
6398.079883: nfsd_deleg_none:      client 5f529c2f:b9aedadc stateid =
002471d8:00000001
6398.079901: nfsd_fh_current:      xid=3D0x59f1891e fh_hash=3D0x2c049d00
6398.079904: nfsd_compound_status: xid=3D0x59f1891e op=3D2/5 OP_OPEN =
status=3D0
6398.079906: nfsd_compound_status: xid=3D0x59f1891e op=3D3/5 OP_GETFH =
status=3D0
6398.079941: nfsd_fh_verify:       xid=3D0x59f1891e fh_hash=3D0x2c049d00 =
type=3DNONE access=3D status=3D0
6398.079947: nfsd_compound_status: xid=3D0x59f1891e op=3D4/5 OP_ACCESS =
status=3D0
6398.079948: nfsd_get_fattr4:      xid=3D0x59f1891e =
bm[0]=3DTYPE|CHANGE|SIZE|FSID|FILEID =
bm[1]=3DMODE|NUMLINKS|OWNER|OWNER_GROUP|RAWDEV|SPACE_USED|TIME_ACCESS|TIME=
_METADATA|TIME_MODIFY|MOUNTED_ON_FILEID bm[2]=3D
6398.079980: nfsd_fh_verify:       xid=3D0x59f1891e fh_hash=3D0x2c049d00 =
type=3DNONE access=3D status=3D0
6398.079985: nfsd_compound_status: xid=3D0x59f1891e op=3D5/5 OP_GETATTR =
status=3D0


> Based on your and Frank's experiences I'm also sympathetic to the idea
> that maybe the filehandle cache just gets in the way in the v4 case.

I think it does get in the way for NFSv4. Clearly if there are NFSv3
users, the filecache is a good way to block handing out delegations.

For NFSv4, once there are no clients (or local users) using a file,
the server should be permitted to offer delegations on it. I don't
see any benefit to holding onto file descriptors that clients say
explicitly that they are done using.

My worry is that after the 5 kernel releases since this code went in,
it won't be a simple set of reverts to back out NFSv4 filecache usage.


> --b.
>=20
>>> Author: J. Bruce Fields <bfields@redhat.com>
>>> Date:   Fri Jul 17 18:54:54 2020 -0400
>>>=20
>>>   nfsd: Cache R, RW, and W opens separately
>>>=20
>>>   The nfsd open code has always kept separate read-only, read-write, =
and
>>>   write-only opens as necessary to ensure that when a client closes =
or
>>>   downgrades, we don't retain more access than necessary.
>>>=20
>>>   Honestly, I'm not sure if that's completely necessary, but I'd =
rather
>>>   stick to that behavior.
>>>=20
>>>   Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>>>=20
>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>> index 82198d747c4c..4b6f70e0d987 100644
>>> --- a/fs/nfsd/filecache.c
>>> +++ b/fs/nfsd/filecache.c
>>> @@ -891,7 +891,7 @@ nfsd_file_find_locked(struct inode *inode, =
unsigned int may_flags,
>>>=20
>>> 	hlist_for_each_entry_rcu(nf, =
&nfsd_file_hashtbl[hashval].nfb_head,
>>> 				 nf_node, =
lockdep_is_held(&nfsd_file_hashtbl[hashval].nfb_lock)) {
>>> -		if ((need & nf->nf_may) !=3D need)
>>> +		if (nf->nf_may !=3D need)
>>> 			continue;
>>> 		if (nf->nf_inode !=3D inode)
>>> 			continue;
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



