Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9391A4DBD
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Apr 2020 06:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgDKEKk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Apr 2020 00:10:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:45308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgDKEKj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 11 Apr 2020 00:10:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB629ABEC;
        Sat, 11 Apr 2020 04:10:37 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        paulmck@linux.ibm.com, paulmck@linux.vnet.ibm.com, neilb@suse.com
Date:   Sat, 11 Apr 2020 14:10:30 +1000
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>, 340442286 <340442286@qq.com>
Subject: Re: ping: [PATCH v3] NFS:remove redundant call to nfs_do_access
In-Reply-To: <CAABZP2yNZoSGr+t6T6KdFhu_3xM1HsM_ft1rK=gHRyyRTbCUMw@mail.gmail.com>
References: <CAABZP2yNZoSGr+t6T6KdFhu_3xM1HsM_ft1rK=gHRyyRTbCUMw@mail.gmail.com>
Message-ID: <87369avf0p.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sat, Apr 11 2020, Zhouyi Zhou wrote:

> ping

You patch has landed in Linux.

Commit eb095c14030f ("NFS:remove redundant call to nfs_do_access")

Thanks,
NeilBrown

>
> On 3/6/20, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>> In function nfs_permission:
>> 1. the rcu_read_lock and rcu_read_unlock around nfs_do_access
>> is unnecessary because the rcu critical data structure is already
>> protected in subsidiary function nfs_access_get_cached_rcu. No other
>> data structure needs rcu_read_lock in nfs_do_access.
>>
>> 2. call nfs_do_access once is enough, because:
>> 2-1. when mask has MAY_NOT_BLOCK bit
>> The second call to nfs_do_access will not happen.
>>
>> 2-2. when mask has no MAY_NOT_BLOCK bit
>> The second call to nfs_do_access will happen if res == -ECHILD, which
>> means the first nfs_do_access goes out after statement if (!may_block).
>> The second call to nfs_do_access will go through this procedure once
>> again except continue the work after if (!may_block).
>> But above work can be performed by only one call to nfs_do_access
>> without mangling the mask flag.
>>
>> Tested in x86_64
>> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
>> ---
>>  fs/nfs/dir.c |    9 +--------
>>  1 files changed, 1 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>> index 193d6fb..37b0c10 100644
>> --- a/fs/nfs/dir.c
>> +++ b/fs/nfs/dir.c
>> @@ -2732,14 +2732,7 @@ int nfs_permission(struct inode *inode, int mask)
>>  	if (!NFS_PROTO(inode)->access)
>>  		goto out_notsup;
>>
>> -	/* Always try fast lookups first */
>> -	rcu_read_lock();
>> -	res = nfs_do_access(inode, cred, mask|MAY_NOT_BLOCK);
>> -	rcu_read_unlock();
>> -	if (res == -ECHILD && !(mask & MAY_NOT_BLOCK)) {
>> -		/* Fast lookup failed, try the slow way */
>> -		res = nfs_do_access(inode, cred, mask);
>> -	}
>> +	res = nfs_do_access(inode, cred, mask);
>>  out:
>>  	if (!res && (mask & MAY_EXEC))
>>  		res = nfs_execute_ok(inode, mask);
>> --
>> 1.7.1
>>
>>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6RQzYACgkQOeye3VZi
gbn7xhAAsvrb+15Fe7QfLaEuxgtbQQoCLrhGEDcJo5Rk2ltFTy1WU6P+ZGpJoXj3
fQlq/CwjfK1spl4n8CXY+/sDiWzqNw2HNlsIAVM1FLp9/Ipd5qNjvgRgRbSyzgVc
M2Dfvpj9hR02TPT1gwmP4GGMEWs/tHASVGyN4nxup13MH6jbsvw5NK99kqnNF+3U
7GiqQ5pyL3y0kJ0Vhk2hZE+WT6Gc+TCtkA5dheUPo5WlEJomeaCOD/rKfctLaMn2
eJXlIVn6gJfD982oOimye3eUuGD+t3ryH9RM8+JLCidZkd4K4zq2Yxc9k2hY5pAm
APNq+CaAZe0uAGLuPaCLbJmz8Bk/HO9G1/CHV6OkGyoys3JUKUKTJMI8s+MovpXr
fdy0uRWeAXxFgrFfKqtTahICs8A7P9OlSEBbMEwLAR2q47xbDsn2SLlulISLTWLB
LA587FYK5DgraocM6TQSaeWVF8tiiL7GYfrqoIy+A0sYJVXc9AoTy3Pe/mmYwAJr
Ygp8Pua4IDWPVI6uRQyfepQqIzdtZp70nVBnlJd3id7I6QD5pvRgAFLL1z5ZvhA0
W9Z03bMSH6XxsIP7SR4n6zzbxDqFbpTOKH0iwCuV6P8/xR/dWwr/nL8PUkaMa5of
/pfsztD+3SpneRA3jCVsG/HNA2qlofvRbKpPEgzN+rIRGxSn+NY=
=M6gY
-----END PGP SIGNATURE-----
--=-=-=--
