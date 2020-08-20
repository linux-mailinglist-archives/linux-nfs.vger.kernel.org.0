Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE71024C657
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Aug 2020 21:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgHTTmU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Aug 2020 15:42:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58614 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgHTTmT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Aug 2020 15:42:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07KJb00X155937;
        Thu, 20 Aug 2020 19:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=C8j5xANtBtiAcIz7Nc6ur/OivPrD+Ni86trsp8DrSTk=;
 b=HxKW2NGte9EEeUygILjJklux74PTNoXAdPLimj68o8vwzL4T8ozLwEtgsaEBfTUzBx/V
 7SJLvVP/m49cxsqMcuO76Ojj8ZytKBAKgGdnZmhoCVMrHV6tl4OIMmCoyBL0jeUZVADV
 t4NJ2hyZANulhPkuuOcegytuWh1vLE9Z4VW9cqVk6fquIHEuseLyNAjAAHF57Wo5998m
 BHcqEa/Cs/oK52hTbNH4tdokRGXKofYAk0P57VDO0aT6Mb3oFemeUa14sQaysp1uiE1B
 JteQiZELvPc7VZR6+df2uXbtrTHaksFms9hVXI14qotxunpj3xC1J769wGJPTa/IfBbM Lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32x8bnjgsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Aug 2020 19:42:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07KJbsSQ083107;
        Thu, 20 Aug 2020 19:42:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 330pvpwxjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 19:42:16 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07KJgF1V000860;
        Thu, 20 Aug 2020 19:42:16 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Aug 2020 12:42:15 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] nfsd: fix oops on mixed NFSv4/NFSv3 client access
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200820193951.GA28555@fieldses.org>
Date:   Thu, 20 Aug 2020 15:42:14 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FECF29B-E908-4408-A70D-A876229BB0DB@oracle.com>
References: <20200820193951.GA28555@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9718 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008200156
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 20, 2020, at 3:39 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> If an NFSv2/v3 client breaks an NFSv4 client's delegation, it will hit =
a
> NULL dereference in nfsd_breaker_owns_lease().
>=20
> Easily reproduceable with for example
>=20
> 	mount -overs=3D4.2 server:/export /mnt/
> 	sleep 1h </mnt/file &
> 	mount -overs=3D3 server:/export /mnt2/
> 	touch /mnt2/file
>=20
> Reported-by: Robert Dinse <nanook@eskimo.com>
> Fixes: 28df3d1539de50 ("nfsd: clients don't need to break their own =
delegations")
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

I think I've got this queued already. Is this different than:

=
http://git.linux-nfs.org/?p=3Dcel/cel-2.6.git;a=3Dcommit;h=3D34b09af4f54e6=
485e28f138ccad159611a240cc1


> ---
> fs/nfsd/nfs4state.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> Oops, I've had this sitting around a couple weeks but I must have
> forgotten to send it in.  This is needed for 5.9.
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4b70657385f2..0e5302f6df52 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4598,6 +4598,8 @@ static bool nfsd_breaker_owns_lease(struct =
file_lock *fl)
> 	if (!i_am_nfsd())
> 		return NULL;
> 	rqst =3D kthread_data(current);
> +	if (!rqst->rq_lease_breaker)
> +		return NULL;
> 	clp =3D *(rqst->rq_lease_breaker);
> 	return dl->dl_stid.sc_client =3D=3D clp;
> }
> --=20
> 2.26.2
>=20

--
Chuck Lever



