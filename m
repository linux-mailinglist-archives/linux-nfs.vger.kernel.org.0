Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8737723CF5F
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 21:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgHETUE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 15:20:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42444 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgHETT6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Aug 2020 15:19:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075JHGdE017141;
        Wed, 5 Aug 2020 19:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=T2eH2sPQXA7hDRLlLWECaYUHOpbHA+rbjHDVJSVB96M=;
 b=JEkUTHfaY/shrFk1E4JMJ+osmrrPPtG0SSWq9QicDrCxHvqWWSU2RdYTuzIYzs7b3Md9
 occcGtNhJG72l/OUeMJGMvoCpFXejlvFO2/LBVcL2KzP41SwsLsuQecv8gz8FQ+3WQqW
 km+4aL38SulyEWIkUrl7UNO8xpkfWWER4x9fu6SGuXHsl8SfPN8AoNeB0Kuy3tnULXYX
 vmYdyQnzCAJ7ylv5VZtjuQ3HgD5JxwnLpF3M+v+foank4vbogE5skOF9A5ul3Rm5cD3c
 pIzEBFCZ+LjxX0DvTDB0SQ9yFIiFA1CJx6Q6ZQ/H+2yZ8SnvXpp5Wzx7/7svkiohFNTH xQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32qycph81s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 19:19:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075JD01E148633;
        Wed, 5 Aug 2020 19:17:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32qy8kv44r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 19:17:55 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 075JHsVE023408;
        Wed, 5 Aug 2020 19:17:55 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Aug 2020 12:17:54 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] nfsd: fix oops on mixed NFSv4/NFSv3 client access
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200805191011.GB14429@fieldses.org>
Date:   Wed, 5 Aug 2020 15:17:54 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7E5BAD1-FB46-4A0D-9D3A-031E9C09002C@oracle.com>
References: <20200805191011.GB14429@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9704 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050151
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

> On Aug 5, 2020, at 3:10 PM, bfields@fieldses.org wrote:
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

May I add

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D208807

And send this in the first NFSD v5.9 -rc pull request?


> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/nfsd/nfs4state.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 9fc0a1b9e4dd..45f3832d70d4 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4597,6 +4597,8 @@ static bool nfsd_breaker_owns_lease(struct =
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



