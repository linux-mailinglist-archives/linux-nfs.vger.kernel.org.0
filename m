Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251C82BC192
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 19:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgKUSsK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 13:48:10 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgKUSsJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 13:48:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ALIg5mn117115;
        Sat, 21 Nov 2020 18:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Cruu9JbLlV+smQ7d4A8nDCmYfDaad2vLt5wnXPtXbkE=;
 b=oKqgTzyKuJlVVJh3aIbvfOLawKsp61nzUeqUD8dW7hdJAUYtMJdReClHPBt7dl6RAjYA
 l6zN3phvdcM2xpvlCyldOf9gEWpn4l82IwLZ4IYFKMtos1bURhSScAiriMB53mhh+Qct
 pLjI/H1MCi5JkWbf3uoUrMbH9qcXNSTRRMczgymHggt8x6w5UlXieU3nalTVq57Op8z/
 2iNmAqfSrPjbI5tmoUb1RUxcGvW8+y6VG3d3s/bwmIjOX7oVfC9A/W0aBUhZmDhnlemx
 JkM5/qXyPzcYvcsiu9Ul0mOV+7PfOrOg4OcwUhfo2t+MKgCOPxuqsTI9ywcRqOUYFftx Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34xuhmh39w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 21 Nov 2020 18:48:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ALIjp2h010226;
        Sat, 21 Nov 2020 18:48:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34xt7hnjaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Nov 2020 18:48:00 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ALIltGg003036;
        Sat, 21 Nov 2020 18:47:57 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Nov 2020 10:47:54 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1 0/13] Convert NFS to new netfs and fscache APIs
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALF+zOnqDeFS+WHe8XUAhbzhkYOBMp2JrAFvqcHqxKsBDzycwA@mail.gmail.com>
Date:   Sat, 21 Nov 2020 13:47:53 -0500
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0A640C47-5F51-47E8-864D-E0E980F8B310@oracle.com>
References: <1605965348-24468-1-git-send-email-dwysocha@redhat.com>
 <017D0771-4BA1-4A97-A077-6222B8CF1B57@oracle.com>
 <CALF+zOmTSqJycjadduibk2sA-iqB3_FdtAX8zGtx4Qn1hXNCKA@mail.gmail.com>
 <6773E22E-57CC-4555-8B27-2B52034DD24D@oracle.com>
 <CALF+zOnqDeFS+WHe8XUAhbzhkYOBMp2JrAFvqcHqxKsBDzycwA@mail.gmail.com>
To:     David Wysochanski <dwysocha@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9812 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9812 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210131
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 21, 2020, at 1:28 PM, David Wysochanski <dwysocha@redhat.com> =
wrote:
>=20
> On Sat, Nov 21, 2020 at 12:16 PM Chuck Lever <chuck.lever@oracle.com> =
wrote:
>>=20
>>=20
>>=20
>>> On Nov 21, 2020, at 12:01 PM, David Wysochanski =
<dwysocha@redhat.com> wrote:
>>>=20
>>> On Sat, Nov 21, 2020 at 11:14 AM Chuck Lever =
<chuck.lever@oracle.com> wrote:
>>>>=20
>>>> Hi Dave-
>>>>=20
>>>>> On Nov 21, 2020, at 8:29 AM, Dave Wysochanski =
<dwysocha@redhat.com> wrote:
>>>>>=20
>>>>> These patches update the NFS client to use the new netfs and =
fscache
>>>>> APIs and are at:
>>>>> https://github.com/DaveWysochanskiRH/kernel.git
>>>>> =
https://github.com/DaveWysochanskiRH/kernel/commit/94e9633d98a5542ea384b10=
95290ac6f915fc917
>>>>> =
https://github.com/DaveWysochanskiRH/kernel/releases/tag/fscache-iter-nfs-=
20201120
>>>>>=20
>>>>> The patches are based on David Howells fscache-iter tree at
>>>>> =
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dfscache-iter
>>>>>=20
>>>>> The first 6 patches refactor some of the NFS read code to =
facilitate
>>>>> re-use, the next 6 patches do the conversion to the new API, and =
the
>>>>> last patch is a somewhat awkward fix for a problem seen in final
>>>>> testing.
>>>>>=20
>>>>> Per David Howell's recent post, note that the new fscache API is
>>>>> divided into two separate APIs, a 'netfs' API and an 'fscache' =
API.
>>>>> The netfs API was done to help simplify the IO paths of network
>>>>> filesystems, and can be called even when fscache is disabled, thus
>>>>> simplifing both readpage and readahead implementations.  However,
>>>>> for now these NFS conversion patches only call the netfs API when
>>>>> fscache is enabled, similar to the existing NFS code.
>>>>>=20
>>>>> Trond and Anna, I would appreciate your guidance on this patchset.
>>>>> At least I would like your feedback regarding the direction
>>>>> you would like these patches to go, in particular, the following
>>>>> items:
>>>>>=20
>>>>> 1. Whether you are ok with using the netfs API unconditionally =
even
>>>>> when fscache is disabled, or prefer this "least invasive to NFS"
>>>>> approach.  Note the unconditional use of the netfs API is the
>>>>> recommended approach per David's post and the AFS and CEPH
>>>>> implementations, but I was unsure if you would accept this
>>>>> approach or would prefer to minimize changes to NFS.  Note if
>>>>> we keep the current approach to minimize NFS changes, we will
>>>>> have to address some problems with page unlocking such as with
>>>>> patch 13 in the series.
>>>>>=20
>>>>> 2. Whether to keep the NFS fscache implementation as "read only"
>>>>> or if we add write through support.  Today we only enable fscache
>>>>> when a file is open read-only and disable / invalidate when a file
>>>>> is open for write.
>>>>>=20
>>>>> Still TODO
>>>>> 1. Address known issues (lockdep, page unlocking), depending on
>>>>> what is decided as far as implementation direction
>>>>> a) nfs_issue_op: takes rcu_read_lock but may calls =
nfs_page_alloc()
>>>>> with GFP_KERNEL which may sleep (dhowells noted this in a review)
>>>>> b) nfs_refresh_inode() takes inode->i_lock but may call
>>>>> __fscache_invalidate() which may sleep (found with lockdep)
>>>>> 2. Fixup NFS fscache stats (NFSIOS_FSCACHE_*)
>>>>> * Compare with netfs stats and determine if still needed
>>>>> 3. Cleanup dfprintks and/or convert to tracepoints
>>>>> 4. Further tests (see "Not tested yet")
>>>>=20
>>>> Can you say whether your approach has any performance impact?
>>> No I cannot.
>>>=20
>>>> In particular, what comparative benchmarks have been run?
>>>>=20
>>> No comparisons so far, but note the last bullet - "performance".
>>>=20
>>> Are you wondering about performance with/without fscache for this
>>> series, or the old vs new fscache, or something else?
>>=20
>> I'd like to have some explicit performance-related merge worthiness
>> criteria. For example: "No performance regressions, and here's how
>> we're going to determine that we're good: fio / iozone / yada with
>> NFS/TCP and NFS/RDMA on 100GbE; for very little additional CPU
>> cost measured via perf xyzzy. Also some benchmark that measures lock
>> contention."
>>=20
>> We haven't been especially careful about this in the past when
>> reworking the client's primary I/O paths. Nothing unreasonable, but
>> it should be stated up front where we want to end up.
>>=20
> Makes sense.
>=20
>> Another approach might be: we're going to start by making fscache
>> opt-in. As confidence increases over time and good performance is
>> demonstrated, then we'll unify the fscache and non-cached I/O paths.
>>=20
> It sounds like what you want is what I've done in this first =
implementation.

My understanding is that you haven't decided whether to take the
opt-in approach or to convert the primary I/O paths right now.


> This implementation takes a "least invasive to NFS" approach, staying
> with the old fscache on/off logic, even though this was not ideal or =
what
> was recommended as the end game for the netfs API.

I'm not taking a position on your two approaches, but I would like
that when the time comes to take the approach that involves full
integration, we should have an agreed-upon set of performance
goals. I don't want that integration to cause our high performance
environments (NFS/RDMA, for instance) to lose out from that
integration.

Btw, it isn't clear yet that we need to use the fscache APIs to
introduce proper huge page support. One of our current efforts is
to convert xdr_buf from the use of an array of struct page pointers
to an array of struct bio_vec pointers. In that case each entry in
the array carries the size of the thing that the entry points to,
which today is always PAGE_SIZE, but in the future could be much
larger.


>>>>> Checks run
>>>>> 1. checkpatch: PASS*
>>>>> * a few warnings, mostly trivial fixups, some unrelated to this =
set
>>>>> 2. kernel builds with each patch: PASS
>>>>> * each patch in series built cleanly which ensure bisection
>>>>>=20
>>>>> Tests run
>>>>> 1. Custom NFS+fscache unit tests for basic operation: PASS*
>>>>> * no oops or data corruptions
>>>>> * Some op counts are a bit off but these are mostly due
>>>>>  to statistics not implemented properly (NFSIOS_FSCACHE_*)
>>>>> 2. cthon04: PASS (test options "-b -g -s -l", =
fsc,vers=3D3,4.0,4.1,4.2,sec=3Dsys)
>>>>> * No failures or oopses for any version or test options
>>>>> 3. iozone tests (fsc,vers=3D3,4.0,4.1,4.2,sec=3Dsys): PASS
>>>>> * No failures or oopses
>>>>> 4. kernel build (fsc,vers=3D3,4.1,4.2): PASS*
>>>>> * all builds finish without errors or data corruption
>>>>> * one lockdep "scheduling while atomic" fired with NFS41 and
>>>>>  was due to one an fscache invalidation code path (known issue 'b' =
above)
>>>>> 5. xfstests/generic (fsc,vers=3D4.2, nofsc,vers=3D4.2): PASS*
>>>>> * generic/013 (pass but triggers i_lock lockdep warning known =
issue 'a' above)
>>>>> * NOTE: The following tests failed with errors, but they
>>>>>   also fail on vanilla 5.10-rc4 so are not related to this
>>>>>   patchset
>>>>>   * generic/074 (lockep invalid wait context - nfs_free_request())
>>>>>   * generic/538 (short read)
>>>>>   * generic/551 (pread: Unknown error 524, Data verification fail)
>>>>>   * generic/568 (ERROR: File grew from 4096 B to 8192 B when =
writing to the fallocated range)
>>>>>=20
>>>>> Not tested yet:
>>>>> * error injections (for example, connection disruptions, server =
errors during IO, etc)
>>>>> * pNFS
>>>>> * many process mixed read/write on same file
>>>>> * performance
>>>>> Dave Wysochanski (13):
>>>>> NFS: Clean up nfs_readpage() and nfs_readpages()
>>>>> NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read
>>>>>  succeeds
>>>>> NFS: Refactor nfs_readpage() and nfs_readpage_async() to use
>>>>>  nfs_readdesc
>>>>> NFS: Call readpage_async_filler() from nfs_readpage_async()
>>>>> NFS: Add nfs_pageio_complete_read() and remove =
nfs_readpage_async()
>>>>> NFS: Allow internal use of read structs and functions
>>>>> NFS: Convert fscache_acquire_cookie and fscache_relinquish_cookie
>>>>> NFS: Convert fscache_enable_cookie and fscache_disable_cookie
>>>>> NFS: Convert fscache invalidation and update aux_data and i_size
>>>>> NFS: Convert to the netfs API and nfs_readpage to use =
netfs_readpage
>>>>> NFS: Convert readpage to readahead and use netfs_readahead for =
fscache
>>>>> NFS: Allow NFS use of new fscache API in build
>>>>> NFS: Ensure proper page unlocking when reads fail with retryable
>>>>>  errors
>>>>>=20
>>>>> fs/nfs/Kconfig             |   2 +-
>>>>> fs/nfs/direct.c            |   2 +
>>>>> fs/nfs/file.c              |  22 ++--
>>>>> fs/nfs/fscache-index.c     |  94 --------------
>>>>> fs/nfs/fscache.c           | 315 =
++++++++++++++++++++-------------------------
>>>>> fs/nfs/fscache.h           | 132 +++++++------------
>>>>> fs/nfs/inode.c             |   4 +-
>>>>> fs/nfs/internal.h          |   8 ++
>>>>> fs/nfs/nfs4proc.c          |   2 +-
>>>>> fs/nfs/pagelist.c          |   2 +
>>>>> fs/nfs/read.c              | 248 =
++++++++++++++++-------------------
>>>>> fs/nfs/write.c             |   3 +-
>>>>> include/linux/nfs_fs.h     |   5 +-
>>>>> include/linux/nfs_iostat.h |   2 +-
>>>>> include/linux/nfs_page.h   |   1 +
>>>>> include/linux/nfs_xdr.h    |   1 +
>>>>> 16 files changed, 339 insertions(+), 504 deletions(-)
>>>>>=20
>>>>> --
>>>>> 1.8.3.1
>>>>>=20
>>>>=20
>>>> --
>>>> Chuck Lever
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



