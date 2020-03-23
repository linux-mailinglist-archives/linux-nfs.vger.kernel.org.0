Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA3418F62C
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2020 14:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgCWNuo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Mar 2020 09:50:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57086 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgCWNun (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Mar 2020 09:50:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NDiZDk039557;
        Mon, 23 Mar 2020 13:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=CYRbgp/28KuTZ4v1VkhP920Jtz6HQhO6biD7JlF9950=;
 b=AfBftnOVGaJCKANLXX3H76CunBr7GNGm7A6qKa3i9H8We2z0YhdmwL3egRM7XLdhI05o
 OcfBdcF8uo2qPdKcyaJibPSH1XceXQP0VtBxMNNovNo9YZIyokpiU9hN4yihITyHImbQ
 hYoyDP9X9kF6YjEG3T2nCd/EWuUz0ZWswW+zJnal30hC5iEvZ8HxlifhFGJ2WE0YSc65
 6Fo4xr8B2/CcvLQhDvhhSzzUKUBD3CuDFSlvSR2JksVo9j7zmruBFXyHgyvSQL0XX7S6
 LUL37ip58jSA2ZBdMz2onpxHEDLLvvqAzj7e9TGsuWZLt95s9iOrC8zu6xVbWQbXbp8p uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2yx8abume8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 13:50:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NDnlM1045696;
        Mon, 23 Mar 2020 13:50:38 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2yxw7fe5fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 13:50:38 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02NDoZcZ019489;
        Mon, 23 Mar 2020 13:50:36 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 06:50:35 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd: memory corruption in nfsd4_lock()
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <db0980d0-8c99-940a-1748-04e679a366d1@virtuozzo.com>
Date:   Mon, 23 Mar 2020 09:50:34 -0400
Cc:     Bruce Fields <bfields@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B820E18-763C-4562-9F50-56A0F1894406@oracle.com>
References: <db0980d0-8c99-940a-1748-04e679a366d1@virtuozzo.com>
To:     Vasily Averin <vvs@virtuozzo.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 phishscore=0 suspectscore=2 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=2 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230079
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



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

Nit: What do people think about removing this dprintk() as part of the =
fix?


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



