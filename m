Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B72EA338
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 03:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhAECNg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 21:13:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38964 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbhAECNf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 21:13:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10528h0L066218;
        Tue, 5 Jan 2021 02:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=Bn511VIMHgVFEeI9cbuoXXxWQdeDUuzXNQSjbF1JMJY=;
 b=wtIFLSEdPuKGgL6Tx1UYqma36sPa0hDyrknSXselWl8UtuEuHNJs80YcVXDqs7OlXxSU
 tMJ28MIfbI0I0jbhT5+2m843G8C4pYKDULAwP716ysVTJ/YQeVb6UGJOzM5Ia3SQ7VW/
 TmcXMXepJ73bcAhUpM31UrnMm9UD7d0urGcPLciF3EY4tBvHXkHbEX/kQDIgnDPxF+rc
 os7uYTmKgp6qT9MCezj6FKUk1kNK3fSnVz4ZjDN/LpnhY7KRkp4zPv5M7okgJil0nQ14
 mgc7V2GTgGzezsxpEtavaCjZ7zUSZFUZX/t6VqOPj7tJy0gSkfM1ngiumKm7F3dthLD8 0A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35tebapyd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 02:12:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1052AXpR097386;
        Tue, 5 Jan 2021 02:12:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35v4rausv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 02:12:49 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1052CkPk009937;
        Tue, 5 Jan 2021 02:12:48 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 02:12:41 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 1/2] nfsd: protect concurrent access to nfsd stats
 counters
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CAOQ4uxg_ZMPp_Huh3RS=bmFzoNtLicFdkoOQfZni9g_o+CBhDg@mail.gmail.com>
Date:   Mon, 4 Jan 2021 21:12:40 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AF5EDF2D-6164-42A6-96E9-72E75D3F226A@oracle.com>
References: <20201228170344.22867-1-amir73il@gmail.com>
 <20201228170344.22867-2-amir73il@gmail.com>
 <20210104215528.GA27763@fieldses.org>
 <CAOQ4uxg_ZMPp_Huh3RS=bmFzoNtLicFdkoOQfZni9g_o+CBhDg@mail.gmail.com>
To:     Amir Goldstein <amir73il@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050011
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 4, 2021, at 5:22 PM, Amir Goldstein <amir73il@gmail.com> wrote:
>=20
> On Mon, Jan 4, 2021 at 11:55 PM J . Bruce Fields =
<bfields@fieldses.org> wrote:
>>=20
>> Thanks for looking at this, it's long overdue!
>>=20
>> On Mon, Dec 28, 2020 at 07:03:43PM +0200, Amir Goldstein wrote:
>>> nfsd stats counters can be updated by concurrent nfsd threads =
without any
>>> protection.
>>>=20
>>> Convert some nfsd_stats and nfsd_net struct members to use percpu =
counters.
>>>=20
>>> There are several members of struct nfsd_stats that are reported in =
file
>>> /proc/net/rpc/nfsd by never updated. Those have been left untouched.
>>=20
>> Looking through the history, the code that updated fh_lookup, for
>> example, was removed in 2002.
>>=20
>> I'd be OK with removing those entirely, maybe just leave a /* =
deprecated
>> field */ comment where we printk the hard-coded 0's.  If somebody =
wants
>> to know more they can still find the answers in git.
>>=20
>=20
> Sure. I can send a followup patch.
>=20
>>> The longest_chain* members of struct nfsd_net remain unprotected.
>>>=20
>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>> ---
>>> fs/nfsd/netns.h    | 20 +++++++----
>>> fs/nfsd/nfs4proc.c |  2 +-
>>> fs/nfsd/nfscache.c | 52 +++++++++++++++++++--------
>>> fs/nfsd/nfsctl.c   |  5 ++-
>>> fs/nfsd/nfsfh.c    |  2 +-
>>> fs/nfsd/stats.c    | 87 =
++++++++++++++++++++++++++++++++++++----------
>>> fs/nfsd/stats.h    | 42 +++++++++++++++-------
>>> fs/nfsd/vfs.c      |  4 +--
>>> 8 files changed, 156 insertions(+), 58 deletions(-)
>>>=20
>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>> index 7346acda9d76..080c5389b2e7 100644
>>> --- a/fs/nfsd/netns.h
>>> +++ b/fs/nfsd/netns.h
>>> @@ -10,6 +10,7 @@
>>>=20
>>> #include <net/net_namespace.h>
>>> #include <net/netns/generic.h>
>>> +#include <linux/percpu_counter.h>
>>>=20
>>> /* Hash tables for nfs4_clientid state */
>>> #define CLIENT_HASH_BITS                 4
>>> @@ -149,20 +150,25 @@ struct nfsd_net {
>>>=20
>>>      /*
>>>       * Stats and other tracking of on the duplicate reply cache.
>>> -      * These fields and the "rc" fields in nfsdstats are modified
>>> -      * with only the per-bucket cache lock, which isn't really =
safe
>>> -      * and should be fixed if we want the statistics to be
>>> -      * completely accurate.
>>> +      * The longest_chain* fields are modified with only the =
per-bucket
>>> +      * cache lock, which isn't really safe and should be fixed if =
we want
>>> +      * these statistics to be completely accurate.
>>>       */
>>>=20
>>>      /* total number of entries */
>>>      atomic_t                 num_drc_entries;
>>>=20
>>> +     /* Reference to below counters as array for init/destroy */
>>> +     struct percpu_counter    counters[0];
>>=20
>> This feels slightly too clever for its own good, but....  OK, I see
>> there's a bunch of initializations to do in the nfsdstats case, and =
you
>> don't want to open code all that (and its error handling).  I guess I
>=20
> Yeh, look at ceph_metric_init() and imagine what nfsdstats init
> would look like.
>=20
>> don't have a better idea.  Is this a common pattern elsewhere?
>>=20
>=20
> Sort of. Inspired by xfsstats and related macros (fs/xfs/xfs_stats.h).
> I have tried several approaches and this one ended up being the
> cleanest and smallest patch.
>=20
> The cleaner way would be an actual percpu_counter array and
> convert all callers to use enum index to array like the dqstats =
counters
> (include/linux/quota.h), but IMO current patch is enough.

I'd prefer the "array with enum indices" approach. The current
patch risks breaking C aliasing rules, IMHO -- with undefined
consequences. I don't see a compelling reason we have to take
that risk, however small it might be.

At the very least, you could make the counters array and the
set of counters into a union, but I'd prefer always accessing
the underlying memory using the same high-level language
constructs. That way, humans and compilers agree on what's
going on here.


--
Chuck Lever



