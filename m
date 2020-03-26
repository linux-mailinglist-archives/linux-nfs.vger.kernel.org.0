Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E11943A5
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCZPzq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 11:55:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50456 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgCZPzq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 11:55:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QFn9ce007073;
        Thu, 26 Mar 2020 15:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=M3fBdqs013ErGxj7QI2NXZPfPsz0DC2QSu5ns6vXYb4=;
 b=SVc9Wlz8tjbLpOMs8WyqgRuwU54bf9ag9kmbpPwdqq02mHFLlqgW4msI8+Bq/VgGQUWE
 VjIj96553SuJlwxveahkOxzkyejGTaLIYLdMtu5BCV8MRlEmXc/afmo8KZn20V1SX+WU
 XpWVJctYA8VD2cJnJD5ChvD7hhm1jyAr21uvyKCNgVX8m2mcspWfTRAS+6ohpA12/LA/
 H9zGJIK25FQHbQG4UdabVn8uVD4fe4uKGaCRPcHEC4nqVqttDVy8QEaMEFov62tiIynh
 D5TJlqgSfPpPPJofLzKh97QnBA6XZX/F6jDGomVs1YNSfzIwmQgbAtJWHOiH0etsRlsS zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2ywavmgnj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 15:55:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QFogHP183897;
        Thu, 26 Mar 2020 15:55:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2yxw4twq4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 15:55:39 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QFtc2G015040;
        Thu, 26 Mar 2020 15:55:39 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 08:55:38 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: memory corruption in nfsd4_lock()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <db0980d0-8c99-940a-1748-04e679a366d1@virtuozzo.com>
Date:   Thu, 26 Mar 2020 11:55:36 -0400
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E365A05-4D39-4BF9-8E44-244136173FC7@oracle.com>
References: <db0980d0-8c99-940a-1748-04e679a366d1@virtuozzo.com>
To:     Vasily Averin <vvs@virtuozzo.com>, Jeff Layton <jlayton@kernel.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=2 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260122
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Howdy-

> On Mar 23, 2020, at 3:55 AM, Vasily Averin <vvs@virtuozzo.com> wrote:
>=20
> New struct nfsd4_blocked_lock allocated in find_or_allocate_block()
> does not initialised nbl_list and nbl_lru.
> If conflock allocation fails rollback can call list_del_init()
> access uninitialized fields and corrupt memory.
>=20
> Fixes: 76d348fadff5 ("nfsd: have nfsd4_lock use blocking locks for =
v4.1+ lock")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

I'm not certain where we stand with this one. Jeff, are you OK
with me taking this for v5.7, or is there additional work needed?

I can drop the dprintk when I merge it.


> ---
> fs/nfsd/nfs4state.c | 32 +++++++++++++++-----------------
> 1 file changed, 15 insertions(+), 17 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 369e574c5092..176ef8d24fae 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6524,6 +6524,13 @@ nfsd4_lock(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 		goto out;
> 	}
>=20
> +	conflock =3D locks_alloc_lock();
> +	if (!conflock) {
> +		dprintk("NFSD: %s: unable to allocate lock!\n", =
__func__);
> +		status =3D nfserr_jukebox;
> +		goto out;
> +	}
> +
> 	nbl =3D find_or_allocate_block(lock_sop, &fp->fi_fhandle, nn);
> 	if (!nbl) {
> 		dprintk("NFSD: %s: unable to allocate block!\n", =
__func__);
> @@ -6542,13 +6549,6 @@ nfsd4_lock(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 	file_lock->fl_end =3D last_byte_offset(lock->lk_offset, =
lock->lk_length);
> 	nfs4_transform_lock_offset(file_lock);
>=20
> -	conflock =3D locks_alloc_lock();
> -	if (!conflock) {
> -		dprintk("NFSD: %s: unable to allocate lock!\n", =
__func__);
> -		status =3D nfserr_jukebox;
> -		goto out;
> -	}
> -
> 	if (fl_flags & FL_SLEEP) {
> 		nbl->nbl_time =3D jiffies;
> 		spin_lock(&nn->blocked_locks_lock);
> @@ -6581,17 +6581,15 @@ nfsd4_lock(struct svc_rqst *rqstp, struct =
nfsd4_compound_state *cstate,
> 		status =3D nfserrno(err);
> 		break;
> 	}
> -out:
> -	if (nbl) {
> -		/* dequeue it if we queued it before */
> -		if (fl_flags & FL_SLEEP) {
> -			spin_lock(&nn->blocked_locks_lock);
> -			list_del_init(&nbl->nbl_list);
> -			list_del_init(&nbl->nbl_lru);
> -			spin_unlock(&nn->blocked_locks_lock);
> -		}
> -		free_blocked_lock(nbl);
> +	/* dequeue it if we queued it before */
> +	if (fl_flags & FL_SLEEP) {
> +		spin_lock(&nn->blocked_locks_lock);
> +		list_del_init(&nbl->nbl_list);
> +		list_del_init(&nbl->nbl_lru);
> +		spin_unlock(&nn->blocked_locks_lock);
> 	}
> +	free_blocked_lock(nbl);
> +out:
> 	if (nf)
> 		nfsd_file_put(nf);
> 	if (lock_stp) {
> --=20
> 2.17.1
>=20

--
Chuck Lever



