Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12592BC071
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 17:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgKUQO4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 11:14:56 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40310 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgKUQOz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 11:14:55 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ALG8kI6032062;
        Sat, 21 Nov 2020 16:14:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=phMfl71i/JOLIhTPYqJ45LJVEFX4FqQ8eySFxivv3/A=;
 b=aneKvcXwp0jxAsmoR0t14pQvzhpvzqYWmhiIFQ1YTU7gGrLX7lJl87V8AxmhQO+pIrbl
 M3p8rPbUpAJTIPSRgx/QoxbUvKl0v6xK7KYsibTMWU7iCixdOhrCNS5fPlKfrXYFegyY
 ZEpPurBBM/Yl7WWysTYWb9KtJEIxF6eJJo5h3KQ6QCUJtHrsjzbUvVKpWLMC2Am9E5pE
 AMa8Gv/r1wTgC3km4SWkfto3sU+ZNFuNlPYY1D4yLxj4fvaQ90dQ/vLtjUclzRaJWXdn
 Pxybw8S4j5i+krSES7pfFp0ciz/ve6b4EwHjm4O76WOUd+3pNGUAeSJFlJCOYjR1K+Jc eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34xtukrwjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 21 Nov 2020 16:14:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ALG9goX118405;
        Sat, 21 Nov 2020 16:12:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34xt7hj56d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 21 Nov 2020 16:12:47 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ALGCd7R023518;
        Sat, 21 Nov 2020 16:12:41 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 21 Nov 2020 08:12:38 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v1 0/13] Convert NFS to new netfs and fscache APIs
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1605965348-24468-1-git-send-email-dwysocha@redhat.com>
Date:   Sat, 21 Nov 2020 11:12:37 -0500
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <017D0771-4BA1-4A97-A077-6222B8CF1B57@oracle.com>
References: <1605965348-24468-1-git-send-email-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9812 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9812 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011210111
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Dave-

> On Nov 21, 2020, at 8:29 AM, Dave Wysochanski <dwysocha@redhat.com> =
wrote:
>=20
> These patches update the NFS client to use the new netfs and fscache
> APIs and are at:
> https://github.com/DaveWysochanskiRH/kernel.git
> =
https://github.com/DaveWysochanskiRH/kernel/commit/94e9633d98a5542ea384b10=
95290ac6f915fc917
> =
https://github.com/DaveWysochanskiRH/kernel/releases/tag/fscache-iter-nfs-=
20201120
>=20
> The patches are based on David Howells fscache-iter tree at
> =
https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/=
?h=3Dfscache-iter
>=20
> The first 6 patches refactor some of the NFS read code to facilitate
> re-use, the next 6 patches do the conversion to the new API, and the
> last patch is a somewhat awkward fix for a problem seen in final
> testing.
>=20
> Per David Howell's recent post, note that the new fscache API is
> divided into two separate APIs, a 'netfs' API and an 'fscache' API.
> The netfs API was done to help simplify the IO paths of network
> filesystems, and can be called even when fscache is disabled, thus
> simplifing both readpage and readahead implementations.  However,
> for now these NFS conversion patches only call the netfs API when
> fscache is enabled, similar to the existing NFS code.
>=20
> Trond and Anna, I would appreciate your guidance on this patchset.
> At least I would like your feedback regarding the direction
> you would like these patches to go, in particular, the following
> items:
>=20
> 1. Whether you are ok with using the netfs API unconditionally even
> when fscache is disabled, or prefer this "least invasive to NFS"
> approach.  Note the unconditional use of the netfs API is the
> recommended approach per David's post and the AFS and CEPH
> implementations, but I was unsure if you would accept this
> approach or would prefer to minimize changes to NFS.  Note if
> we keep the current approach to minimize NFS changes, we will
> have to address some problems with page unlocking such as with
> patch 13 in the series.
>=20
> 2. Whether to keep the NFS fscache implementation as "read only"
> or if we add write through support.  Today we only enable fscache
> when a file is open read-only and disable / invalidate when a file
> is open for write.
>=20
> Still TODO
> 1. Address known issues (lockdep, page unlocking), depending on
> what is decided as far as implementation direction
>  a) nfs_issue_op: takes rcu_read_lock but may calls nfs_page_alloc()
>  with GFP_KERNEL which may sleep (dhowells noted this in a review)
>  b) nfs_refresh_inode() takes inode->i_lock but may call
>  __fscache_invalidate() which may sleep (found with lockdep)
> 2. Fixup NFS fscache stats (NFSIOS_FSCACHE_*)
> * Compare with netfs stats and determine if still needed
> 3. Cleanup dfprintks and/or convert to tracepoints
> 4. Further tests (see "Not tested yet")

Can you say whether your approach has any performance impact?
In particular, what comparative benchmarks have been run?


> Checks run
> 1. checkpatch: PASS*
>  * a few warnings, mostly trivial fixups, some unrelated to this set
> 2. kernel builds with each patch: PASS
>  * each patch in series built cleanly which ensure bisection
>=20
> Tests run
> 1. Custom NFS+fscache unit tests for basic operation: PASS*
>  * no oops or data corruptions
>  * Some op counts are a bit off but these are mostly due
>    to statistics not implemented properly (NFSIOS_FSCACHE_*)
> 2. cthon04: PASS (test options "-b -g -s -l", =
fsc,vers=3D3,4.0,4.1,4.2,sec=3Dsys)
> * No failures or oopses for any version or test options
> 3. iozone tests (fsc,vers=3D3,4.0,4.1,4.2,sec=3Dsys): PASS
> * No failures or oopses
> 4. kernel build (fsc,vers=3D3,4.1,4.2): PASS*
>  * all builds finish without errors or data corruption
>  * one lockdep "scheduling while atomic" fired with NFS41 and
>    was due to one an fscache invalidation code path (known issue 'b' =
above)
> 5. xfstests/generic (fsc,vers=3D4.2, nofsc,vers=3D4.2): PASS*
>   * generic/013 (pass but triggers i_lock lockdep warning known issue =
'a' above)
>   * NOTE: The following tests failed with errors, but they
>     also fail on vanilla 5.10-rc4 so are not related to this
>     patchset
>     * generic/074 (lockep invalid wait context - nfs_free_request())
>     * generic/538 (short read)
>     * generic/551 (pread: Unknown error 524, Data verification fail)
>     * generic/568 (ERROR: File grew from 4096 B to 8192 B when writing =
to the fallocated range)
>=20
> Not tested yet:
> * error injections (for example, connection disruptions, server errors =
during IO, etc)
> * pNFS
> * many process mixed read/write on same file
> * performance
> Dave Wysochanski (13):
>  NFS: Clean up nfs_readpage() and nfs_readpages()
>  NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read
>    succeeds
>  NFS: Refactor nfs_readpage() and nfs_readpage_async() to use
>    nfs_readdesc
>  NFS: Call readpage_async_filler() from nfs_readpage_async()
>  NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
>  NFS: Allow internal use of read structs and functions
>  NFS: Convert fscache_acquire_cookie and fscache_relinquish_cookie
>  NFS: Convert fscache_enable_cookie and fscache_disable_cookie
>  NFS: Convert fscache invalidation and update aux_data and i_size
>  NFS: Convert to the netfs API and nfs_readpage to use netfs_readpage
>  NFS: Convert readpage to readahead and use netfs_readahead for =
fscache
>  NFS: Allow NFS use of new fscache API in build
>  NFS: Ensure proper page unlocking when reads fail with retryable
>    errors
>=20
> fs/nfs/Kconfig             |   2 +-
> fs/nfs/direct.c            |   2 +
> fs/nfs/file.c              |  22 ++--
> fs/nfs/fscache-index.c     |  94 --------------
> fs/nfs/fscache.c           | 315 =
++++++++++++++++++++-------------------------
> fs/nfs/fscache.h           | 132 +++++++------------
> fs/nfs/inode.c             |   4 +-
> fs/nfs/internal.h          |   8 ++
> fs/nfs/nfs4proc.c          |   2 +-
> fs/nfs/pagelist.c          |   2 +
> fs/nfs/read.c              | 248 ++++++++++++++++-------------------
> fs/nfs/write.c             |   3 +-
> include/linux/nfs_fs.h     |   5 +-
> include/linux/nfs_iostat.h |   2 +-
> include/linux/nfs_page.h   |   1 +
> include/linux/nfs_xdr.h    |   1 +
> 16 files changed, 339 insertions(+), 504 deletions(-)
>=20
> --=20
> 1.8.3.1
>=20

--
Chuck Lever



