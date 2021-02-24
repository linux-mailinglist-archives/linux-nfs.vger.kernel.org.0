Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEAC3244AD
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 20:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhBXTfH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 14:35:07 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34678 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbhBXTfA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 14:35:00 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OJTCgF175792;
        Wed, 24 Feb 2021 19:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=tKmckeMnrYmsJ3Ef0l6beGNMoR5kBtp9Zd6i4tpcZBg=;
 b=yiHcBKupiW9xPOXehAskOuD6889PNcSjBtXGXPr2WiihO39X8adgbdAzOto9yCJ2s56c
 cNIm/+91Beo92nt29/OfgpCo2pubkKDiETLacEd5vGx2orE3KllrAaxibK+TX4zHkZTd
 Ib5qczW34AUVF3zFnVdgvjUh873m0xZGOn0mA9oUtM4jS85tZXNQ8Q05ZZPSbTdbSup2
 jYcwlz6xqZKZgMGbvS0DC/xo/tn/NvPIhwaFPj+t/TYMGNn/E9E/M5oXMU2C9EdTMno6
 ZZYCo70Pe9K/fl6RIugsu9BYOlOKsViGetrKeXrm1/ARB1szlw1n0uAmy5FZ16PcLpVR Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36vr626g1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 19:34:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OJUqpJ147821;
        Wed, 24 Feb 2021 19:34:12 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by aserp3030.oracle.com with ESMTP id 36v9m6c0ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 19:34:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hvre6JNGQSSzyYZpCAq2eozswstnZff+Zp0QCUhMQ+TwLhnk86H940ddc0PK/ZxhaEJzwR0/Gm/U29iKiaUHLQvGrME3RTL5C/pflZqZLlslAGtStmnPq63TG/eKIlEPploPyCeatI1ulrUETaSmg4W14IMW/HvNYo6W164u1Z4eigRV5AOrz/9aHCRvfUx2pVlfCgRS8ofY5zxf3mlEKmXQufOt4wTFKEU88WYRk8MM/NBfmPQI6FRdtodRJC6yDE4nYwCDdOa3wmA7cALSRAGFHokpKNrVa2t+xVJNiK2y0fItlPURmg3AJ/dYShtpAYydjCc3Y7CFaiktE5EPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKmckeMnrYmsJ3Ef0l6beGNMoR5kBtp9Zd6i4tpcZBg=;
 b=TUWjI3Id6boTMWEQj7CMv3dyrJq8Y4FWIiZGBxU3lDU5BHjFyfxwEYxcOtkz2GMl5pbh4lHPsEtYNPVqgwOAohIbh9ym6lxIm54ATDKTJEPnhogQMJKJfpwHUYRm+3Eot60s/2aPV/OJRdzJaDYoNmEHfusvrzc9Pwdm911jKRNYurDKdKvWsdWosbjQY5KUWKPoRsrfWPbSJa+zXmnfp73p6q/E/mjXwD9HSlNhLYbY2OAkTjYMU2S7/4uxcrLYzgdxQUF6POm3nILIbsklxyuPQQ0R6NpqHScLeLf3luHqTo9sfvcSsXRI2cRo8ruvA0vIGdVMV60SBgsS92J4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKmckeMnrYmsJ3Ef0l6beGNMoR5kBtp9Zd6i4tpcZBg=;
 b=pZKOgKer7J/HY8tClIMFJrOCxei6PL0mrL7hDrOlhkmgit4FotOsl0N0rBJGjmMJMe3wyCFV1UI3ZRLeXi6h56KbCkWTL07JzEC7MiJ5ejeUzp9piuItK3baEu1FsMnyT5VGwacDrzDFGv+IMlPKTP3t0rtJbQzWiPGh8S0zOTo=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2709.namprd10.prod.outlook.com (2603:10b6:a02:b7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 19:34:10 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 19:34:10 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: Re: [PATCH] nfsd: don't abort copies early
Thread-Topic: [PATCH] nfsd: don't abort copies early
Thread-Index: AQHXCtx0cs5d9peX+k+/c+JLDyWeq6pnsZqAgAAAt4A=
Date:   Wed, 24 Feb 2021 19:34:10 +0000
Message-ID: <59A5F476-EE0C-454F-8365-3F16505D9D45@oracle.com>
References: <20210224183950.GB11591@fieldses.org>
 <20210224193135.GC11591@fieldses.org>
In-Reply-To: <20210224193135.GC11591@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2e448b3-0ff6-48f1-4756-08d8d8fb28f1
x-ms-traffictypediagnostic: BYAPR10MB2709:
x-microsoft-antispam-prvs: <BYAPR10MB2709C9D77F22020245C5ECE5939F9@BYAPR10MB2709.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S9BzUKqgP6jrZ98LGlpsiy/1UxB+rFdiwNFaaalbVVFoXnVQAby4CQ+lHrlrzx8i/772Hy5FoYIiYsrVp9Evsoa1rJ2KDw4hAZKsfReyt7mq1Hr0j0IWRH+yuw54w6OsLw5Iaxmz5hMXJ/0uP2Fzt2o/KiMmnZi1qRU1pNoQoDAr6O3CeQp64aRW8u212wOfqXjg4Fzq4fMbQZSE5lWiOgQcdOVhgBcwmGcPcKQHdtEijAv/DIZfEHJNUbfxdjiL1n+tLSF3LD5E0ceOMae4cB3D5SQIGjPGRZfkJXD9hnEnQceq1XgOEEiqPIH20gRcgvK8D8oE/wpOBpbAuW8cAKpNUpxLY+R9EAVPhoCS4yp2BJhoYsRYygWo4k8va6T1xmafLUuciQId+m4jWyWGdINJvTnl/xB8CZD0HSMKGHKktcISAhl8drrYQm2Q93i0uy5SZA0fLs7sZ6CBoQwwXBD8ubX7zOOv723UjI3b8dgiVwR5y64sCrTcKKn1W468kKYgeU19K3v0vX/6niBEMsXiHcIqPG0zoVIKZiJpxNoknHIC8sl1A7GAAxS8T/53rFf0pX6XMx1AjFks4nV4wg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(2616005)(6916009)(6486002)(44832011)(66446008)(66556008)(66476007)(91956017)(83380400001)(5660300002)(86362001)(76116006)(64756008)(66946007)(71200400001)(54906003)(186003)(33656002)(26005)(478600001)(53546011)(4326008)(36756003)(6506007)(8676002)(2906002)(8936002)(316002)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zbSR7hPHqpvfuBqFEtkdIHT19fJ08n8iPJedW1GSKAHhfGCUWflX9ymXJ9k1?=
 =?us-ascii?Q?Fb1ABuO7j5qWIOK6FCsFdRKttpyqoJbrn75ojQbg3EsGLg5MSqYxlpCBK0Uf?=
 =?us-ascii?Q?YFmYTDqvWh4vJGXx3tk0kFk+hFpo0MNDYnA0I+44UWPYx35E/5jMa6GqJp3J?=
 =?us-ascii?Q?hz/mqVChEGN+43ATKP1OTAQSu0FE/YWLLAcvyYAtYWsIr1q61Z6ejPlf+e82?=
 =?us-ascii?Q?gI2+bNWHFWbiPWmO9fKwS005+ubJRBrUUhukg3Gz5ABNAomPUdbOjALCSXqu?=
 =?us-ascii?Q?+pGZjeRQLMrlN5DVdEgdGtONhCYOQ/sH1YbqBwgWGMs+lVtvOfVmQJAiRCcN?=
 =?us-ascii?Q?aDZK37Lt2HWWauRX8V1F7Bnmz7WzekG5gRAVBWjMzUtw1uQxnoDPpsa/ZR5G?=
 =?us-ascii?Q?4CMhjHxJYF43mp71PwSpfQXxh2RPO+6KAGIxgDBzZFO75JTCI0KpagZ9FnIm?=
 =?us-ascii?Q?Tlr58d/6ohuNmo6qXGsLUwztPlI1vcUD80k57vojjtnI7jRHsfmFWQfVq5NC?=
 =?us-ascii?Q?/25xGbeq6LvUDOAdXCTEC367JGoPZXkx/QiYTEKA26Y0yRLCgRlViPFsObU5?=
 =?us-ascii?Q?SH5u+HPJ3CbvhT/85fshVgQRvzosm1lQyIod3Q4n9uDn0N6HzgH0kR5qV++D?=
 =?us-ascii?Q?P4O4LxufMF8jQag5CoI79oAbojlHNrFuXKp2vCOz12Gb0N8SO+irEiGUCmID?=
 =?us-ascii?Q?As27B8yx8OX3RHAknVJlZyLnJii1H67iVxj7tDpCFT1dsgzv4safsYQgPTw1?=
 =?us-ascii?Q?eR/IQNAXG4aJh/8pdbsUdbXtEy4ZLAyE1TJrItZcJsZzvYxTuncoyXpDmOBq?=
 =?us-ascii?Q?bjd31xfFvim0QEciyWg3buwghM3LL49LOzQfqiIt6e5NvME51iOV2suJ1qAN?=
 =?us-ascii?Q?wCBgj23qbMKINN6paUn5+0Nl4NTzGsSUTiA8pn4TZybCmzXY+SSasdrQI8Ib?=
 =?us-ascii?Q?hgUKjwNQmpIYlMyos6maSffzQOlSEJK87t/Nn3AcruhQ7JlIEpxApzsnWOl5?=
 =?us-ascii?Q?BuJjr/vrHGrUzcRuRj+C7SEe5xu08N5RIMJh38ewsVFrb5voFGDpuigBI4v5?=
 =?us-ascii?Q?Eu80RyU4FJ5QYQt4kN0Iy3zWt52N29pxpDbRuPS4ZBsbGIOPSxYbujTCzJHZ?=
 =?us-ascii?Q?6MgiQZ/U6BkOK1kM6d3WTPIGT6+2l7ortphgqdNK7lasOugbhPLBqKtpw5o8?=
 =?us-ascii?Q?e83BKCQzTC+Z9m2mQI8gToGXQyx6Sh7Ws+ZR432+ajGbifaco3cIExlGeNA0?=
 =?us-ascii?Q?ZZ+YiB+IphRFmc7vY1DxNSpziU8J481vf3FDMtIZ67osjygIjV2RsZDOBCHf?=
 =?us-ascii?Q?QRilXGLBaVKVUeSQZev7oCXIOG4d9FgjFHc0jp2QvMg8Rg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B04A074D2850014B8FD4FA5508F0E3F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e448b3-0ff6-48f1-4756-08d8d8fb28f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 19:34:10.6504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZaEs6BN9bdXFWzYBHjPFZqD97YLsjVhD6986/slHUCWsqggEhwB8M/aCKnSuSAxSNLXrdiaAf3P1K91XaNm5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2709
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240148
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240148
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 24, 2021, at 2:31 PM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> I confess I always have to stare at these comparisons for a minute to
> figure out which way they should go.  And the logic in each of these
> loops is a little repetitive.
>=20
> Would it be worth creating a little state_expired() helper to work out
> the comparison and the new timeout?

That's better, but aren't there already operators on time64_t data objects
that can be used for this?


> --b.
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 61552e89bd89..00fb3603c29e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5363,6 +5363,22 @@ static bool clients_still_reclaiming(struct nfsd_n=
et *nn)
> 	return true;
> }
>=20
> +struct laundry_time {
> +	time64_t cutoff;
> +	time64_t new_timeo;
> +};
> +
> +bool state_expired(struct laundry_time *lt, time64_t last_refresh)
> +{
> +	time64_t time_remaining;
> +
> +	if (last_refresh > lt->cutoff)
> +		return true;
> +	time_remaining =3D lt->cutoff - last_refresh;
> +	lt->new_timeo =3D min(lt->new_timeo, time_remaining);
> +	return false;
> +}
> +
> static time64_t
> nfs4_laundromat(struct nfsd_net *nn)
> {
> @@ -5372,14 +5388,16 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	struct nfs4_ol_stateid *stp;
> 	struct nfsd4_blocked_lock *nbl;
> 	struct list_head *pos, *next, reaplist;
> -	time64_t cutoff =3D ktime_get_boottime_seconds() - nn->nfsd4_lease;
> -	time64_t t, new_timeo =3D nn->nfsd4_lease;
> +	struct laundry_time lt =3D {
> +		.cutoff =3D ktime_get_boottime_seconds() - nn->nfsd4_lease,
> +		.new_timeo =3D nn->nfsd4_lease
> +	};
> 	struct nfs4_cpntf_state *cps;
> 	copy_stateid_t *cps_t;
> 	int i;
>=20
> 	if (clients_still_reclaiming(nn)) {
> -		new_timeo =3D 0;
> +		lt.new_timeo =3D 0;
> 		goto out;
> 	}
> 	nfsd4_end_grace(nn);
> @@ -5389,7 +5407,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	idr_for_each_entry(&nn->s2s_cp_stateids, cps_t, i) {
> 		cps =3D container_of(cps_t, struct nfs4_cpntf_state, cp_stateid);
> 		if (cps->cp_stateid.sc_type =3D=3D NFS4_COPYNOTIFY_STID &&
> -				cps->cpntf_time < cutoff)
> +				state_expired(&lt, cps->cpntf_time))
> 			_free_cpntf_state_locked(nn, cps);
> 	}
> 	spin_unlock(&nn->s2s_cp_lock);
> @@ -5397,11 +5415,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	spin_lock(&nn->client_lock);
> 	list_for_each_safe(pos, next, &nn->client_lru) {
> 		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> -		if (clp->cl_time > cutoff) {
> -			t =3D clp->cl_time - cutoff;
> -			new_timeo =3D min(new_timeo, t);
> +		if (!state_expired(&lt, clp->cl_time))
> 			break;
> -		}
> 		if (mark_client_expired_locked(clp)) {
> 			trace_nfsd_clid_expired(&clp->cl_clientid);
> 			continue;
> @@ -5418,11 +5433,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	spin_lock(&state_lock);
> 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> 		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> -		if (dp->dl_time > cutoff) {
> -			t =3D dp->dl_time - cutoff;
> -			new_timeo =3D min(new_timeo, t);
> +		if (!state_expired(&lt, clp->cl_time))
> 			break;
> -		}
> 		WARN_ON(!unhash_delegation_locked(dp));
> 		list_add(&dp->dl_recall_lru, &reaplist);
> 	}
> @@ -5438,11 +5450,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	while (!list_empty(&nn->close_lru)) {
> 		oo =3D list_first_entry(&nn->close_lru, struct nfs4_openowner,
> 					oo_close_lru);
> -		if (oo->oo_time > cutoff) {
> -			t =3D oo->oo_time - cutoff;
> -			new_timeo =3D min(new_timeo, t);
> +		if (!state_expired(&lt, oo->oo_time))
> 			break;
> -		}
> 		list_del_init(&oo->oo_close_lru);
> 		stp =3D oo->oo_last_closed_stid;
> 		oo->oo_last_closed_stid =3D NULL;
> @@ -5468,11 +5477,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> 	while (!list_empty(&nn->blocked_locks_lru)) {
> 		nbl =3D list_first_entry(&nn->blocked_locks_lru,
> 					struct nfsd4_blocked_lock, nbl_lru);
> -		if (nbl->nbl_time > cutoff) {
> -			t =3D nbl->nbl_time - cutoff;
> -			new_timeo =3D min(new_timeo, t);
> +		if (!state_expired(&lt, oo->oo_time))
> 			break;
> -		}
> 		list_move(&nbl->nbl_lru, &reaplist);
> 		list_del_init(&nbl->nbl_list);
> 	}
> @@ -5485,8 +5491,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> 		free_blocked_lock(nbl);
> 	}
> out:
> -	new_timeo =3D max_t(time64_t, new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> -	return new_timeo;
> +	return max_t(time64_t, lt.new_timeo, NFSD_LAUNDROMAT_MINTIMEOUT);
> }
>=20
> static struct workqueue_struct *laundry_wq;

--
Chuck Lever



