Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658DC32C69B
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Mar 2021 02:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390023AbhCDA3g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Mar 2021 19:29:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58574 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384232AbhCCPic (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Mar 2021 10:38:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123FT9xf042666;
        Wed, 3 Mar 2021 15:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=bk3dD6jEATJvdAoTEmmZuICpSHvBbsPZuHAyI2/90Xk=;
 b=yOV/Tcxw50BYmbLUQwVxUChoHim0FLEb2lP2r5q0RjKHv2gPjkj0//1HbzwKpozQoy4f
 iQyrItnnFqYFD7yIj/OM9WISHyBEmu+53mUlJMwAjZO/iJzMaUtTv2y8G73PMGPyv2f7
 jUne2sSQCNX9uJJ/YxDf8KJnv3DunqwRCxtJEY7wcI3LsSOfjyo5tKA9g+o9HHwwh0PD
 KSumS5YAjt6wBKbASjEty/l1bUpJl9wxEl10K8HHshhsmkb4WzyrtR1t4Zlxhgp1lyIV
 6RcLhcfj9yJjmCBF7XEuqmPFe/EsgKRtWcjILbFVN7Z6gJ9lTIhnt3iGXP0i7c07VsxD GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36ybkbbycq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 15:37:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 123FV2uM139982;
        Wed, 3 Mar 2021 15:37:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by userp3030.oracle.com with ESMTP id 37000ykams-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Mar 2021 15:37:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/hMeVWzjOQE7xEyMEHsNxDf1BmA9hw54b2+IU+MCtiOXo4vk+erK0j42ESyngeAqOAKVF9xDxfS7MWqCSjyRQzGu5/gfQgD4WgN00e/GQ6X4U2hrNsodGmnbzcUCfdPHU0YJQXfJLcEARVwbzA4U9KgQN4+3fkW4rt9sF1RzEi6sWIRp/agO6qt+qmydrD499DPy8FRZieI8p2srVRgi13kp6iQ2V6c3H0EE2WkbsA9Nihz4WVzhUf7czC3Q+Y7prVBMrWw6S0B+/FwnooqXmDKqBflJzkVWcy2hxEPcryq2ohrQc5qW4JLGKesjM/uJSVpFZ1m4lpqGF9IyuTt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk3dD6jEATJvdAoTEmmZuICpSHvBbsPZuHAyI2/90Xk=;
 b=MoEdJtJMToc2ItdvORkWmcAUesoJh9mUhXrBfZnuJG4AU0nm6DgqgSdwzRsGPOC/xlXOJ1KwDCxY89fgC76RBABJETB92DMIdEVQ86MioJ4YOeKdeo+8KegUaZUgX1iRi146vZ3QSs3ARRsJGgpHQoCF8OM/Oz/OQt9ADCKlFWu9zPET8A8OcoWMezEQfa1nZGGROSEM9ygI2hPgD0Ahdrg029r4/uM/EvZE2n5J8yszqvUXN26LxY4Z9u26NIbrdacLbg4cOmYppcZurlpumv7oQc/lohZk+ksqZqi8AW6zaklqHv9WdxI51v4cBdTy75lHHsDBmKE752uYH6k+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk3dD6jEATJvdAoTEmmZuICpSHvBbsPZuHAyI2/90Xk=;
 b=lxa0b5pN9I+r3tF+jhrT++Hw+hvUn3a95OtuljgjVmTTdbNH1E58MDA45IkDjIBBv0RYW30mopEVRH0484fQirLdUXu89T2yRzuX8RNAn5QaRb0XD7aEjKOAIDd52BawtnYhcX/92xzqWiToOTjHxSEoF3Nv0ADAcWWYAWOdUCs=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3605.namprd10.prod.outlook.com (2603:10b6:a03:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 15:37:20 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 15:37:19 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfsd: helper for laundromat expiry calculations
Thread-Topic: [PATCH] nfsd: helper for laundromat expiry calculations
Thread-Index: AQHXD3s3GSu7nxFDKU+a9rc0Y7q7iqpyZzqA
Date:   Wed, 3 Mar 2021 15:37:19 +0000
Message-ID: <763CD926-3A57-47C8-9E81-0E1151B2D074@oracle.com>
References: <20210302154623.GA2263@fieldses.org>
In-Reply-To: <20210302154623.GA2263@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd24dee0-6f39-4c35-ae9c-08d8de5a3b83
x-ms-traffictypediagnostic: BYAPR10MB3605:
x-microsoft-antispam-prvs: <BYAPR10MB360599B12BB344A2971F50A793989@BYAPR10MB3605.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wVEhCmubjC7YsX03leluQxmmhpsrrwm7G50VPNEduoF+L/6p04tYjVwD6Ia/uucKpEvJUkFCCRs6PMQ/N+Wwl4fVCi60S2AdMhGasJYT1UlCefNeAlbeBpvYykghUduAS3bRWW98rm7QiOiZxEkPT70iBK0s4yG59pjWoN5pMOGUJG1C0x4Mnn/LEU9d7LCRMCbDta8VHcr1OuL067eOBQtqId/aSLOI05ockpU0ws1JEBjcJa40BMic+T3Dyvyf1HdJg0qPBzONYgn24E0bOsL3Ec3xag9XQv7MDn04Iri3QQdSKeu2EoE9Vymp72pvmfq5yB/V/A6T9p57sGlXATkazde8AuPrFkRkXJAVbVVbPxy0ibZndRknZxqHZGhu8H8MS6SjFFbvTc+ouAFiJYULXTqR4CI3PClKcIuVJVPGiKEUla7ooQlETtmVIR+5TpJreiXYMjnIvZTkjpTfgkY/by0kYNJcS7KpfSncn4rKu+SrVkGQoZwcSuL1w5azT4bduFO90HNe13Z0WsHXXKKkdQJU4W2hlvIQhmIWf+WDKCVlL73BsCJ5rQ++x5pOTuWwCQ8KS44CS75j9uQqFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(136003)(396003)(91956017)(8936002)(8676002)(6512007)(4326008)(71200400001)(36756003)(6486002)(33656002)(76116006)(66946007)(5660300002)(316002)(66446008)(83380400001)(64756008)(66556008)(66476007)(6916009)(26005)(86362001)(53546011)(2616005)(6506007)(44832011)(186003)(2906002)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1Gi8Z9p5zdXHEhdlaqf7FOYrAj2ycdhxgRk4s39OxPJYTWRC1f0CqH29YbH9?=
 =?us-ascii?Q?mfN8YPDfcfRCMOtJ6+g8s9ECnN8nMBENfJCgVyEHNzkZW0MkRGDmomcP6Pmw?=
 =?us-ascii?Q?uH1p9MnwuFscBZ42sPxqXOlIbvNuHnOvwcKrSIDX4KNrzO7/7kfuj0HALbt1?=
 =?us-ascii?Q?MmjqM5vZ7wp5//K3ItBGWyWeJgmzs9egR/Ilu8iijDZ1IcGIrhSyLoLduxTm?=
 =?us-ascii?Q?s/zaCKrvzIZsh6HyI4zFti6tD1xsjqTEzUV2ObVcNFs3H+3cGSm7dleJ6ews?=
 =?us-ascii?Q?n2H0F8u0VJMCE3y9S9/2BsmQAdyF9N4G0rGtYslkeWnaOY+XsmrA5OdiQhNi?=
 =?us-ascii?Q?ORZ5eN4wypQunavr8hpTTDlimyU8uJdtWj6x+NDhmwu6AZ91GtlI/Y4uhvW4?=
 =?us-ascii?Q?kwKcLgooOCaEK6SpUlHoyDRJI+Kdqm8GFoza5uqmElGDCrjQ9pIkg7CM2lnS?=
 =?us-ascii?Q?+6Fo3upehSMearu2vyLp3q0CnnIJhkfdGg84XnmmhZn/EP464EpiQEiww7Sc?=
 =?us-ascii?Q?RSKQOlfeYf8C7sIwqoyoWqEelA24RPYsxv5DNgDSX7esBEYhB2hkc/t+qkHS?=
 =?us-ascii?Q?ZNCooq8YEBd831boL00xjjZJV47eerre0JNCxOVP4jQ/tQvDrPWKVoajw1cq?=
 =?us-ascii?Q?eSvI7ZG1u85TlEE4w8iCWSi7sdIz2QT3bot1Z53MzjueHTEt3epRUG0jr/Gf?=
 =?us-ascii?Q?zbqqw44b3C+M1xEhtmP4zLqhDWrHWBJziO5GLHYd7hZbYmHvi3DszPELAkdk?=
 =?us-ascii?Q?TOqfwxxzTZ9gnR9ifr/7RntokxZhicgJSlnFF50cQgwZd6immTmNiPIXppGv?=
 =?us-ascii?Q?E6cLHEiql/495aEcZG4taCdAZG+D5BLX+H4p4c5RMivs6H2BW7tewdTrUGeJ?=
 =?us-ascii?Q?wv3+YM2IZ+VApPJIIhBHlsmv1oTmWVWhRUukbVSBK94gQP5JzTRZ+eMSAXYf?=
 =?us-ascii?Q?Wgq5bhktgDFItYYr+Gz1CW/GgO/vx4rhnoVXXO+ZNiTxyybSbXLrC8Sk+3tp?=
 =?us-ascii?Q?aQ3POi5XHWJapuW7KQcXimDKc2xoxVvtLJJZKZs+xaDzNL/r1aC6HgVVwvFp?=
 =?us-ascii?Q?Cda2kT53PX9eKftoVSEKUJxS84qUV6HIJcJImte0U238LGPofISp4h19S2FB?=
 =?us-ascii?Q?EuEMNob7sDNh63/H8aLc0jJLcJ2vftny6qQEem0WkyTKY8teODd9CtuLJP/j?=
 =?us-ascii?Q?o0/iNeL64OkOmZMkKMbaoG55x8CVw0+P3eXAP+VY2TtJZ04wTX1DcmFJNvT4?=
 =?us-ascii?Q?PqJoODCVcq/yzHpekoInWyWPzXrlJw8Kr/PGBz+KEnb8AzIsxnqLe0+5ZI8K?=
 =?us-ascii?Q?0INYFIVbDqsdHPxPruEm2ZoZe2PLfLpwv7rT0ReM+M8m+w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7872E4186C82464B88D9382776642334@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd24dee0-6f39-4c35-ae9c-08d8de5a3b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 15:37:19.9465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sNSlHgBzBciS0rAuEfZa5UGAec73LV5/ueAkfXAqoYx4SKqhSzWVCJgUyA20jgyYTaQBrADnpp1DZmxccHp8lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3605
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103030119
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030119
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 2, 2021, at 10:46 AM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> We do this same logic repeatedly, and it's easy to get the sense of the
> comparison wrong.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/nfsd/nfs4state.c | 49 +++++++++++++++++++++++++--------------------
> 1 file changed, 27 insertions(+), 22 deletions(-)
>=20
> My original version of this patch... actually got the sense of the
> comparison wrong!
>=20
> Now actually tested.

Thanks, and pushed to the for-next topic branch of

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 61552e89bd89..8e6938902b49 100644
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
> +	if (last_refresh < lt->cutoff)
> +		return true;
> +	time_remaining =3D last_refresh - lt->cutoff;
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
> +		if (!state_expired(&lt, dp->dl_time))
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
> +		if (!state_expired(&lt, nbl->nbl_time))
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
> --=20
> 2.29.2
>=20

--
Chuck Lever



