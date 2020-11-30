Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E442C901D
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgK3Viu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:38:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:37812 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgK3Viu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 16:38:50 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AULP39d037514;
        Mon, 30 Nov 2020 21:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=UjFdXOW7H8yWfyDJfINjgLDnYUhSOKzBwDDOvVIoE9c=;
 b=UdIoFDDu81R/QrRXTfUgNZ3fJaLgKwYvVbj1GKtns++0wpff0IajXzMTmYUi4wwUCnO6
 Sc1XIoVwptXvtiOV7onJcdPh252knLII4PJO2h5t4Rw+NKasBNuuYLOifmQ+qitSAjvu
 Wp4em0vN1FLW8Sv+dgMKloZnBlTQ/dLgeRESleez8UZqJpVTCJh7gk0apDf4G2jd5RuR
 jA8EsBGfSm28BN7zslg/p/ZWFlWp2WY9Sf5xAmFw3N9wnaUv4vNGAkZypXcmHsW0lslh
 yYDEWi0dlG3Iyl1XEpRDkR8bxDnj44uj+UhkcfMBwUqWx2W1pTCMyElcs0rlZMOBOWZG RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 353c2aqma6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Nov 2020 21:38:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AULQ2UF053315;
        Mon, 30 Nov 2020 21:38:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3540ex2v5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Nov 2020 21:38:08 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AULc7nH013276;
        Mon, 30 Nov 2020 21:38:08 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Nov 2020 13:38:07 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] NFSD: Fix 5 seconds delay when doing inter server copy
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20201130212449.3470-1-dai.ngo@oracle.com>
Date:   Mon, 30 Nov 2020 16:38:06 -0500
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7AD569D2-BBEB-4F2D-9673-59E3CA4E89E1@oracle.com>
References: <20201130212449.3470-1-dai.ngo@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9821 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011300135
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 30, 2020, at 4:24 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Since commit b4868b44c5628 ("NFSv4: Wait for stateid updates after
> CLOSE/OPEN_DOWNGRADE"), every inter server copy operation suffers 5
> seconds delay regardless of the size of the copy. The delay is from
> nfs_set_open_stateid_locked when the check by =
nfs_stateid_is_sequential
> fails because the seqid in both nfs4_state and nfs4_stateid are 0.
>=20
> Fix by modifying nfs4_init_cp_state to return the stateid with seqid 1
> instead of 0. This is also to conform with section 4.8 of RFC 7862.
>=20
> Here is the relevant paragraph from section 4.8 of RFC 7862:
>=20
>   A copy offload stateid's seqid MUST NOT be zero.  In the context of =
a
>   copy offload operation, it is inappropriate to indicate "the most
>   recent copy offload operation" using a stateid with a seqid of zero
>   (see Section 8.2.2 of [RFC5661]).  It is inappropriate because the
>   stateid refers to internal state in the server and there may be
>   several asynchronous COPY operations being performed in parallel on
>   the same file by the server.  Therefore, a copy offload stateid with
>   a seqid of zero MUST be considered invalid.
>=20
> Fixes: ce0887ac96d3 ("NFSD add nfs4 inter ssc to nfsd4_copy")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

Applied for the next merge window. See the cel-next topic branch in
this repo:

git://git.linux-nfs.org/projects/cel/cel-2.6.git

See also:

=
http://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dshortlog;h=3Drefs/heads/=
cel-next


> ---
> fs/nfsd/nfs4state.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index d7f27ed6b794..47006eec724e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -769,6 +769,7 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, =
copy_stateid_t *stid,
> 	spin_lock(&nn->s2s_cp_lock);
> 	new_id =3D idr_alloc_cyclic(&nn->s2s_cp_stateids, stid, 0, 0, =
GFP_NOWAIT);
> 	stid->stid.si_opaque.so_id =3D new_id;
> +	stid->stid.si_generation =3D 1;
> 	spin_unlock(&nn->s2s_cp_lock);
> 	idr_preload_end();
> 	if (new_id < 0)
> --=20
> 2.9.5
>=20

--
Chuck Lever



