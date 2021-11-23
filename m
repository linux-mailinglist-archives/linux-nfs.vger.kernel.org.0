Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E86545A92D
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhKWQs7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Nov 2021 11:48:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42022 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239022AbhKWQsz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Nov 2021 11:48:55 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ANGivxc011200;
        Tue, 23 Nov 2021 16:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Eb4a3CIEjt8Y72Lzcz2tBXhOtMyp+EeA7P7yPFQnhKY=;
 b=CVd117gq1ib8BaaNdREEjcBIIuGcIiiESnwtDr+FliJw5roParM9I1rAbiG8lmmjceZD
 0wYhmMmCQ1E/IKSWJfLP43eAGf9I6dYah/xiRn3EJf7kffv4Cu7oT5Bm1pJ1i+IYwZ7R
 2XIRiI2WTdmvrpAlPsVoamGwXHG2d8i3n7YaYfMUvtR1EwChK4njtb1AOZl57pyFPIbD
 AiITK2l80REzoz+TMf5/QTPsWTHFD0FlALiBErzZFsxmaRt7r235O1agBjsm/ZRtloVh
 WGrWi3LzJ0M6/axwiF7QsrnYASXgvhP4mb4G+yZFpjU6bb8kM1AfH6WGi9tn0HYk4vT/ OA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cg69mjtk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 16:45:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ANGUnTb084613;
        Tue, 23 Nov 2021 16:45:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3ceq2eh0d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 16:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flP+d24PLrswgVhZqDuS0YOI0+rDSK/43mfzdNtrNYqSqXU+MGxazijuTKr5yY7OpdpmhhgkLJYHAqBIdNggVt4E7jbBkmcxfPyN5Yt5aI1myu7qrnWQDZ7Y1QcJelaisLctLI0t7wzH8yEwdv6bgtJvzT7hRIGZZnVYYO2YmC1fZQFxpAt+hlyBsnyy2WXvTr0jsjqqKELny3hm4elHn7jjnIgOG7X/EKxeufXU0wO7q8hlNO/By/hCT6HPK+qwj/UotT90vOiZcO7fTIO8EXvpPm9VG1Cr9rzgi+q4SnKwsIIPiBOlPPQWT0+LXlbb9gzzWfAw6ES6uzfA0QO6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eb4a3CIEjt8Y72Lzcz2tBXhOtMyp+EeA7P7yPFQnhKY=;
 b=Xrfb8+iF+NP0ZP/YeACUPqNsWnKgAfcjuw9JzWkHE4o73d9IOiNg82WQzszvA+AfvwYnf2SO3jFRIol/BKDtsUIxMNCZOe+iL8/C3wN4/UP3J93zBVio5P6Z7+aZWUKlSBRQg0J20eXApLBjR11p7P7gHAJw1rd0GbinI5bjrXKi+GYWG30eDLz0ZLeGrMn5CN9qqlLMhbKY69b6GuZ9QEQquVG9UkXG9cWg6vwBhwt/pqYzRbdti2HsNn265FmAxw/dSD5Zhw4wgeJaqoejY70Xo6Extva2tCFpfJP7w63B/uiCCm9bp5EoBmGJwLrF8Q9JEdCPJPBSYxsA3WxA7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb4a3CIEjt8Y72Lzcz2tBXhOtMyp+EeA7P7yPFQnhKY=;
 b=HuIB5+tHdlRcn+N/MGhCnxt/zOX/863Zj8BHalaFdjg7gOwC1F69O6+H3IFTZ9B5JhlJjhstyzHErWuq7a/DUgM3PUo0YXLghS1CAb5CarARIAz7jfuASaAJe3LGeilVCdoAIRVcjVQjVLep1ZNRA5tOzD/KLT/ewaayu41gTso=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2968.namprd10.prod.outlook.com (2603:10b6:a03:85::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 16:45:29 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%7]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 16:45:29 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 01/19] SUNRPC/NFSD: clean up get/put functions.
Thread-Topic: [PATCH 01/19] SUNRPC/NFSD: clean up get/put functions.
Thread-Index: AQHX4AnIG1p3xmGNtkiIHNAf/2dSk6wRUvYA
Date:   Tue, 23 Nov 2021 16:45:29 +0000
Message-ID: <92C7D2FA-6C7B-4209-B1B4-3B81B2B276F4@oracle.com>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
 <163763097540.7284.6343105121634986097.stgit@noble.brown>
In-Reply-To: <163763097540.7284.6343105121634986097.stgit@noble.brown>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6daeebc-7d8c-4b93-5123-08d9aea0a86f
x-ms-traffictypediagnostic: BYAPR10MB2968:
x-microsoft-antispam-prvs: <BYAPR10MB296878E842C1A810F06C495E93609@BYAPR10MB2968.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2zgNThgfzIkBSb46KhicWz2HI5MSgIza3ZYezdfyLoEzA2VCmapVlJucovkk2UAKhOpb9nJRq5bmwm60wN3TNZjtGdYoZl12mjD+G5BbiSJN8zrzTHtxxS70K3Hb9eifIrpYfR2KFs/LWvAK0AcRzhR1B4mp5mFfUuFb+7IL59qiKT22CBROz9gqxhkHnyNw3lL9F3ss/wCocIjf1307rDmF9uok969IG5GiIoFU3jfpJAANlRsQzy+ykRD8Tcc/kfmxo714evn3C0LiE0DpehQ0C2DnVGuFTqIPlaaTbbd4lJnRQ3vtAQrln08w86TdZZPKWpL8NDaXJ5M6ZwXyTJuTfXEMO1GNr5MxDDP6x4q5UnbQ2wJHWB7lT16fgrO6P0mkG052kQ3xJY9T2/jHOnd0SeWlu/iDD7Vyc1Kd+5frb+Gkzg9PRQS+K+cFdxrAuQN/W1fErlrtAQRM0EUVVpKR0oLf8Y89Ku46WeqxohpSXxCgO+Ow60GoLa7Zep/Loo1nqblKfrp7eswsQoz8H/1rdhuDXiFcXqd8QmvHTzkUmEFNAoJaLGU6bke1fD8dHwUeovkkVcu3zzmmFl9fQV+JzL6u0UpopJPNljZ1SHBatxLJZWAIlywr01kgPOvloBhx2lgDzyabbIXOnJaxUe1WyF6REcj+espVIRK0JZbgl9f5bcHgoYdnmvzTumJz3Iygzx+eG0sBHv1LArwQZeexCXsJ0nv3dqmUNsfINSjh0PyaeezTitHUKv6k/dW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(64756008)(66476007)(38100700002)(122000001)(38070700005)(66946007)(186003)(66446008)(2906002)(33656002)(66556008)(316002)(4326008)(54906003)(83380400001)(5660300002)(30864003)(6486002)(2616005)(8676002)(6512007)(8936002)(71200400001)(53546011)(6506007)(36756003)(508600001)(6916009)(76116006)(91956017)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cXL19vDLKVEOjjoz/l5urmW371gbXeUNi6WBjBCHcm/1OvNKwzsIFjiBIZzp?=
 =?us-ascii?Q?RgsU5Yv8S9pFLTY0kDpGovUlQHh48jOQQQyMrTy/wvokmqIVC1jMf+Fw3FYA?=
 =?us-ascii?Q?eRsr0gt6GyDSJkNKAEAkWIEwbXaBnfEM2eNXebFT9yEmjw5pw+tINCa4GwQ4?=
 =?us-ascii?Q?0CpezX9A1QIxyM095lLlNyYDs/K3RTFLo/WJ+n2u/uvQacKdEwTvoF4AOh0t?=
 =?us-ascii?Q?3nUugwnm9NMquflHTJrUsvmn2v7sKR79L6yg2grptstA9s38Pws8gR2mrK6N?=
 =?us-ascii?Q?fbJEdVB3tauc2UlTeB+54Q3tC2szGmOuAs3DpDC5P171ZeNO06txZjm2VRCg?=
 =?us-ascii?Q?RTNaXTx2UriuEpZnztKj6tfhODl/FCLMa/3y4YPkqUsgGhWdDiJyC3OnUilp?=
 =?us-ascii?Q?v4QfRrU9ZSgQvQwC/KE8sPUk81DR5iF/A8RN9etFpEjo3X0gy37c/R2Sfr8M?=
 =?us-ascii?Q?20OiL+o/fjd50CMrSVtZK0hTP2uLTdp60Tdu1JMtA6CzkWBmqldaaXcsL9Q6?=
 =?us-ascii?Q?v8im7vfYP2R5UAGlluygtIyN4PRVxAQMTCssqPjoDVVClA4UXQC/Sb/PpTTy?=
 =?us-ascii?Q?guuAfUtIAEfKY/CPbARlfBzvwxZef4Zkz1JqWqkB7bMkcUi0bQnp9JkAj47t?=
 =?us-ascii?Q?unmxkuSPKn/PouvZT5ZD0S+3IiOFgUOIdOPmO08f8I17jHikBGW2Ab68wyT9?=
 =?us-ascii?Q?jLcucbTgenxowvbBiv7L9SeU0INahRqbVPRNCf4rQh1+m3YD4SIxYA8r0lia?=
 =?us-ascii?Q?Nov+3cgQVvJWhrGSlGAlP5XkKukFPsPnGZD0DAfb843Y00ODWu1TO63RXv2R?=
 =?us-ascii?Q?f4Mb9Z5SrDGrsay6419QYu8uch4rufjUXG7534Et8dKoHYOAG19QbbmcvzY1?=
 =?us-ascii?Q?AVd6N+hxboZ8HQe+7zWbqv2y0wItvH6IZgSrovog2E6MgE7K85m0edM9J2vh?=
 =?us-ascii?Q?ZaPTNbbfNPKeYJoYbMq0WhwTC8idJg8/8P0Z5lkQQP9HL2ynnuuv8ZE8l9/4?=
 =?us-ascii?Q?Jl5tzMKI0l5wZ4aFpYG/bSiwz4SP8qV4YyVwN2WyenZnJlSPLCifzTeeFcS2?=
 =?us-ascii?Q?hb2tAYuUaOyW+mRFfzQGP5kibKg/gyrc0oa0bnOgHZB3osfmvdgbicKEiyIU?=
 =?us-ascii?Q?r9tCUgs16QxzvegzOTCJekNyQqLpTTo7Gk76fXHVYRPYPUkTdKM/M1qSQluA?=
 =?us-ascii?Q?BrvgmjNuWFBWJZgoz6OjzjJ4cEyvgXl/SnrdS7jV0sKt7WYoag3/9jGu78z2?=
 =?us-ascii?Q?IjLSKZQ9QFH1hRyN1QOSkUOx6wfu7cEPs7LJBGlExR1RddIWwBngTlNOLIRn?=
 =?us-ascii?Q?oeowm908N6JQ11dfoYcn/E3ys2yyRfeC2iW+ovo2kGJqmWM2uRkA+zjEaQW2?=
 =?us-ascii?Q?C/zDcswBXGI/gT1FxP+frThFJyyY0wL23+Sv++JZnxjXN4gdeqfsscfhSHWE?=
 =?us-ascii?Q?UlaVO4rN5N+TzXuFSRZgNwcGPm79MmlsE2b6f0Upglex3QgQLoh8i3DWc0rL?=
 =?us-ascii?Q?N2uFVXGZcU80YA45nsGrZ8Z9p445VQ/dg0nbSmM/Is3xL6yO+CtWCFqAs20h?=
 =?us-ascii?Q?OLOdJuysIN8nARHl+OJcEAdrn+ZEuKrzxR1OuY6ysypDoQv27aYlwnMmbVxT?=
 =?us-ascii?Q?HoIFZDYqmQsK6wPzvk73ifA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE3927714E549E42B88C9AA94DF0B930@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6daeebc-7d8c-4b93-5123-08d9aea0a86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 16:45:29.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rg3Yt0kLByDruamOfvCUmI4syqinNFqoBpMD9mHl55/AhY+lPWgsnLXdB52k24EHe/MT1eqvQCWrXfRTe75G9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2968
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111230084
X-Proofpoint-GUID: 7fWXrV9WKy9JbY2GTW-pWjAPcptzA56J
X-Proofpoint-ORIG-GUID: 7fWXrV9WKy9JbY2GTW-pWjAPcptzA56J
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

Some further custodial requests below...


> On Nov 22, 2021, at 8:29 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> svc_destroy() is poorly named - it doesn't necessarily destroy the svc,
> it might just reduce the ref count.
> nfsd_destroy() is poorly named for the same reason.
>=20
> This patch:
> - removes the refcount functionality from svc_destroy(), moving it to
>   a new svc_put().  Almost all previous callers of svc_destroy() now
>   call svc_put().
> - renames nfsd_destroy() to nfsd_put() and improves the code, using
>   the new svc_destroy() rather than svc_put()
> - also changes svc_get() to return the serv, which simplifies
>   some code a little.
>=20
> The only non-trivial part of this is that svc_destroy() would call
> svc_sock_update() on a non-final decrement.  It can no longer do that,
> and svc_put() isn't really a good place of it.  This call is now made
> from svc_exit_thread() which seems like a good place.  This makes the
> call *before* sv_nrthreads is decremented rather than after.  This
> is not particularly important as the call just sets a flag which
> causes sv_nrthreads set be checked later.  A subsequent patch will
> improve the ordering.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/lockd/svc.c             |   12 +++---------
> fs/nfs/callback.c          |   20 ++++----------------
> fs/nfsd/nfsctl.c           |    4 ++--
> fs/nfsd/nfsd.h             |    2 +-
> fs/nfsd/nfssvc.c           |   30 ++++++++++++++++--------------
> include/linux/sunrpc/svc.h |   29 +++++++++++++++++++++++++----
> net/sunrpc/svc.c           |   19 +++++--------------
> 7 files changed, 56 insertions(+), 60 deletions(-)
>=20
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index b220e1b91726..135bd86ed3ad 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -430,14 +430,8 @@ static struct svc_serv *lockd_create_svc(void)
> 	/*
> 	 * Check whether we're already up and running.
> 	 */
> -	if (nlmsvc_rqst) {
> -		/*
> -		 * Note: increase service usage, because later in case of error
> -		 * svc_destroy() will be called.
> -		 */
> -		svc_get(nlmsvc_rqst->rq_server);
> -		return nlmsvc_rqst->rq_server;
> -	}
> +	if (nlmsvc_rqst)
> +		return svc_get(nlmsvc_rqst->rq_server);

The svc_get-related changes seem like they could be split
into a separate clean-up patch.


> 	/*
> 	 * Sanity check: if there's no pid,
> @@ -497,7 +491,7 @@ int lockd_up(struct net *net, const struct cred *cred=
)
> 	 * so we exit through here on both success and failure.
> 	 */
> err_put:
> -	svc_destroy(serv);
> +	svc_put(serv);
> err_create:
> 	mutex_unlock(&nlmsvc_mutex);
> 	return error;
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 86d856de1389..edbc7579b4aa 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -266,14 +266,8 @@ static struct svc_serv *nfs_callback_create_svc(int =
minorversion)
> 	/*
> 	 * Check whether we're already up and running.
> 	 */
> -	if (cb_info->serv) {
> -		/*
> -		 * Note: increase service usage, because later in case of error
> -		 * svc_destroy() will be called.
> -		 */
> -		svc_get(cb_info->serv);
> -		return cb_info->serv;
> -	}
> +	if (cb_info->serv)
> +		return svc_get(cb_info->serv);
>=20
> 	switch (minorversion) {
> 	case 0:
> @@ -335,16 +329,10 @@ int nfs_callback_up(u32 minorversion, struct rpc_xp=
rt *xprt)
> 		goto err_start;
>=20
> 	cb_info->users++;
> -	/*
> -	 * svc_create creates the svc_serv with sv_nrthreads =3D=3D 1, and then
> -	 * svc_prepare_thread increments that. So we need to call svc_destroy
> -	 * on both success and failure so that the refcount is 1 when the
> -	 * thread exits.
> -	 */
> err_net:
> 	if (!cb_info->users)
> 		cb_info->serv =3D NULL;
> -	svc_destroy(serv);
> +	svc_put(serv);
> err_create:
> 	mutex_unlock(&nfs_callback_mutex);
> 	return ret;
> @@ -370,7 +358,7 @@ void nfs_callback_down(int minorversion, struct net *=
net)
> 	if (cb_info->users =3D=3D 0) {
> 		svc_get(serv);
> 		serv->sv_ops->svo_setup(serv, NULL, 0);
> -		svc_destroy(serv);
> +		svc_put(serv);
> 		dprintk("nfs_callback_down: service destroyed\n");
> 		cb_info->serv =3D NULL;
> 	}
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index af8531c3854a..5eb564e58a9b 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -743,7 +743,7 @@ static ssize_t __write_ports_addfd(char *buf, struct =
net *net, const struct cred
>=20
> 	err =3D svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cr=
ed);
> 	if (err < 0) {
> -		nfsd_destroy(net);
> +		nfsd_put(net);

Seems like there should be a matching nfsd_get() somewhere.
Perhaps it can just be an alias for svc_get()?


> 		return err;
> 	}
>=20
> @@ -796,7 +796,7 @@ static ssize_t __write_ports_addxprt(char *buf, struc=
t net *net, const struct cr
> 	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
> 		nn->nfsd_serv->sv_nrthreads--;
> 	 else
> -		nfsd_destroy(net);
> +		nfsd_put(net);
> 	return err;
> }
>=20
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 498e5a489826..3e5008b475ff 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -97,7 +97,7 @@ int		nfsd_pool_stats_open(struct inode *, struct file *=
);
> int		nfsd_pool_stats_release(struct inode *, struct file *);
> void		nfsd_shutdown_threads(struct net *net);
>=20
> -void		nfsd_destroy(struct net *net);
> +void		nfsd_put(struct net *net);
>=20
> bool		i_am_nfsd(void);
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 80431921e5d7..2ab0e650a0e2 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -623,7 +623,7 @@ void nfsd_shutdown_threads(struct net *net)
> 	svc_get(serv);
> 	/* Kill outstanding nfsd threads */
> 	serv->sv_ops->svo_setup(serv, NULL, 0);
> -	nfsd_destroy(net);
> +	nfsd_put(net);
> 	mutex_unlock(&nfsd_mutex);
> 	/* Wait for shutdown of nfsd_serv to complete */
> 	wait_for_completion(&nn->nfsd_shutdown_complete);
> @@ -656,7 +656,10 @@ int nfsd_create_serv(struct net *net)
> 	nn->nfsd_serv->sv_maxconn =3D nn->max_connections;
> 	error =3D svc_bind(nn->nfsd_serv, net);
> 	if (error < 0) {
> -		svc_destroy(nn->nfsd_serv);
> +		/* NOT nfsd_put() as notifiers (see below) haven't
> +		 * been set up yet.
> +		 */
> +		svc_put(nn->nfsd_serv);
> 		nfsd_complete_shutdown(net);
> 		return error;
> 	}
> @@ -697,16 +700,16 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct=
 net *net)
> 	return 0;
> }
>=20
> -void nfsd_destroy(struct net *net)
> +void nfsd_put(struct net *net)
> {
> 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -	int destroy =3D (nn->nfsd_serv->sv_nrthreads =3D=3D 1);
>=20
> -	if (destroy)
> +	nn->nfsd_serv->sv_nrthreads --;

checkpatch.pl screamed about the whitespace between the variable
and the unary operator here and in svc_put().


> +	if (nn->nfsd_serv->sv_nrthreads =3D=3D 0) {
> 		svc_shutdown_net(nn->nfsd_serv, net);
> -	svc_destroy(nn->nfsd_serv);
> -	if (destroy)
> +		svc_destroy(nn->nfsd_serv);
> 		nfsd_complete_shutdown(net);
> +	}
> }
>=20
> int nfsd_set_nrthreads(int n, int *nthreads, struct net *net)
> @@ -758,7 +761,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct n=
et *net)
> 		if (err)
> 			break;
> 	}
> -	nfsd_destroy(net);
> +	nfsd_put(net);
> 	return err;
> }
>=20
> @@ -795,7 +798,7 @@ nfsd_svc(int nrservs, struct net *net, const struct c=
red *cred)
>=20
> 	error =3D nfsd_startup_net(net, cred);
> 	if (error)
> -		goto out_destroy;
> +		goto out_put;
> 	error =3D nn->nfsd_serv->sv_ops->svo_setup(nn->nfsd_serv,
> 			NULL, nrservs);
> 	if (error)
> @@ -808,8 +811,8 @@ nfsd_svc(int nrservs, struct net *net, const struct c=
red *cred)
> out_shutdown:
> 	if (error < 0 && !nfsd_up_before)
> 		nfsd_shutdown_net(net);
> -out_destroy:
> -	nfsd_destroy(net);		/* Release server */
> +out_put:
> +	nfsd_put(net);
> out:
> 	mutex_unlock(&nfsd_mutex);
> 	return error;
> @@ -982,7 +985,7 @@ nfsd(void *vrqstp)
> 	/* Release the thread */
> 	svc_exit_thread(rqstp);
>=20
> -	nfsd_destroy(net);
> +	nfsd_put(net);
>=20
> 	/* Release module */
> 	mutex_unlock(&nfsd_mutex);
> @@ -1109,8 +1112,7 @@ int nfsd_pool_stats_release(struct inode *inode, st=
ruct file *file)
> 	struct net *net =3D inode->i_sb->s_fs_info;
>=20
> 	mutex_lock(&nfsd_mutex);
> -	/* this function really, really should have been called svc_put() */
> -	nfsd_destroy(net);
> +	nfsd_put(net);
> 	mutex_unlock(&nfsd_mutex);
> 	return ret;
> }
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 0ae28ae6caf2..d87c3392a1e9 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -114,15 +114,37 @@ struct svc_serv {
> #endif /* CONFIG_SUNRPC_BACKCHANNEL */
> };
>=20
> -/*
> - * We use sv_nrthreads as a reference count.  svc_destroy() drops
> +/**
> + * svc_get() - increment reference count on a SUNRPC serv
> + * @serv:  the svc_serv to have count incremented
> + *
> + * Returns: the svc_serv that was passed in.
> + *
> + * We use sv_nrthreads as a reference count.  svc_put() drops
>  * this refcount, so we need to bump it up around operations that
>  * change the number of threads.  Horrible, but there it is.
>  * Should be called with the "service mutex" held.
>  */
> -static inline void svc_get(struct svc_serv *serv)
> +static inline struct svc_serv *svc_get(struct svc_serv *serv)
> {
> 	serv->sv_nrthreads++;
> +	return serv;
> +}
> +
> +void svc_destroy(struct svc_serv *serv);
> +
> +/**
> + * svc_put - decrement reference count on a SUNRPC serv
> + * @serv:  the svc_serv to have count decremented
> + *
> + * When the reference count reaches zero, svc_destroy()
> + * is called to clean up and free the serv.
> + */
> +static inline void svc_put(struct svc_serv *serv)
> +{
> +	serv->sv_nrthreads --;
> +	if (serv->sv_nrthreads =3D=3D 0)

Nit: The usual idiom is "if (--serv->sv_nrthreads =3D=3D 0)"


> +		svc_destroy(serv);
> }
>=20
> /*
> @@ -514,7 +536,6 @@ struct svc_serv *  svc_create_pooled(struct svc_progr=
am *, unsigned int,
> int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
> int		   svc_set_num_threads_sync(struct svc_serv *, struct svc_pool *, in=
t);
> int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
> -void		   svc_destroy(struct svc_serv *);
> void		   svc_shutdown_net(struct svc_serv *, struct net *);
> int		   svc_process(struct svc_rqst *);
> int		   bc_svc_process(struct svc_serv *, struct rpc_rqst *,
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 4292278a9552..55a1bf0d129f 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -528,17 +528,7 @@ EXPORT_SYMBOL_GPL(svc_shutdown_net);
> void
> svc_destroy(struct svc_serv *serv)
> {
> -	dprintk("svc: svc_destroy(%s, %d)\n",
> -				serv->sv_program->pg_name,
> -				serv->sv_nrthreads);
> -
> -	if (serv->sv_nrthreads) {
> -		if (--(serv->sv_nrthreads) !=3D 0) {
> -			svc_sock_update_bufs(serv);
> -			return;
> -		}
> -	} else
> -		printk("svc_destroy: no threads for serv=3D%p!\n", serv);
> +	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);

Maybe the dprintk is unnecessary. I would prefer a trace
point if there is real value in observing destruction of
particular svc_serv objects.

Likewise in subsequent patches.

Also... since we're in the clean-up frame of mind, if you
see a BUG() call site remaining in a hunk, ask yourself
if we really need to kill the kernel at that point, or
if a WARN would suffice.


> 	del_timer_sync(&serv->sv_temptimer);
>=20
> @@ -892,9 +882,10 @@ svc_exit_thread(struct svc_rqst *rqstp)
>=20
> 	svc_rqst_free(rqstp);
>=20
> -	/* Release the server */
> -	if (serv)
> -		svc_destroy(serv);
> +	if (!serv)
> +		return;
> +	svc_sock_update_bufs(serv);

I don't object to moving the svc_sock_update_bufs() call
site. But....

Note for someday: I'm not sure of a better way of handling
buffer size changes, but this seems like all kinds layering
violation.


> +	svc_destroy(serv);
> }
> EXPORT_SYMBOL_GPL(svc_exit_thread);
>=20
>=20
>=20

--
Chuck Lever



