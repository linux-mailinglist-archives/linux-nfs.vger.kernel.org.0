Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1D62FDC39
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Jan 2021 23:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbhATWA7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Jan 2021 17:00:59 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40264 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436697AbhATVDM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Jan 2021 16:03:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KKsZJE082196;
        Wed, 20 Jan 2021 21:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ccOU9zMtl4JgyE3IqbO78uybBugHsAZ8wBcI5N9rr7I=;
 b=pTd2gNP0VURqX/DDCm2lO1l6lWPnYhQMVF7ism4M4ou+EWbR54NTSFWQK8mBtCQmSczf
 WeDy5zYVdaWhPUYxGTikH0zY5unIgMCDOgBPbsM9RFXF4YHXKHwedlx6DWqdfeSWMj2T
 vJcNYaevgJlvkuvjnJws0ubk4ehlK5uRiUMSioXOxaJwCi94ho0A9u5/nolOut5il1QR
 r6gIjAt0v9xoAXMqjiWHVgDG10v1/6xMNq8Sh5NlnuaX+29vQpjnWfZEpVIokJwXUJyj
 n49Y6XPFSpoUs2GDncbw7+P7fYKck4zhTLzlHwsufKElc8hosIMSVfXZ3Z4Lh2ogfG9j lg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3668qrcf4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 21:02:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10KKxovR017160;
        Wed, 20 Jan 2021 21:02:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3668remfbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 21:02:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkj950VfQhT7bAK1xl/hAS/gz0K6XDFNUAfXXoyiF+lJ70LdlQjPJhJsXFJUS+aeNDj+Y8dH9IWjuxWDhMyVBDR4/uTEFFB9wojecedjOPn4eE/TcAbyTzYRINr98xR8ueu/pP9ceYmvhD/RR1nPYsTQkUrV9uw+rcT66zWA9KBqWKUxVKaQCO5ejQJTa60FqE3zAnLqpCoLInv5jW1ifMpyclEhUvHtCnsDr7Ua5keGGOIXQWAhmWw5KBAlhyr0UWcaW41R/T7SVGn8nMfnVVCCnRIZiEBMUt+2MFlj9UQu8gDPsDkt+Zy/Hw2LVOjLM94bfiAXlk1tNtK7+0kwTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccOU9zMtl4JgyE3IqbO78uybBugHsAZ8wBcI5N9rr7I=;
 b=cGTBB94b1UMVco1fmtZgO9s/IHu/lFAXTrOORQFsPsWmXs9hX1+dQeA1z7ZfjBLFVoKDrAx5hWWWcYz5z3LvaFnfFtqncNtfJBQfbYlCcOtyaPn0c08v3Pm4UjZjHdQIqT2JQEesyWKYr0FFdSTNWHfJivdaVfDltWxcDd35uL1qQwOqUl+jO4QiNKPQ7G9X1Lykv6mzIecKcqbeYxJUaHCgwKn7ktEqGueRj+Y1xAQ/w1p5CKWet8Ss/MgongoVEZq9wLSS3Y/4n3jL+npjcPDhTXEkGxOl4lAhg34sxw6WrwT5bvW1XqKgdbKcYYuy/MvaZZlctyVpzO0Xrpszxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccOU9zMtl4JgyE3IqbO78uybBugHsAZ8wBcI5N9rr7I=;
 b=EBhHYTFzFSGqOjyyTI27eqqLjQcA28cDH1uJsNzvycIzR1Fp0CTdHbN0dWQQadQY51oHybutHT7dNEYiYfYBzyFtQidUT0uFyz07Zzhy9U0v3an+d+q9ZFlr65D2LUZMOrsAIlZf7vw5BdBK4yhWFOvvkY9KcnBzsG1VfRuiX38=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2693.namprd10.prod.outlook.com (2603:10b6:a02:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Wed, 20 Jan
 2021 21:02:25 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 21:02:25 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 4/8] nfsd: refactor lookup_clientid
Thread-Topic: [PATCH 4/8] nfsd: refactor lookup_clientid
Thread-Index: AQHW7rNqZSoyw/V3W0GmJH/akLdGV6oxAbMA
Date:   Wed, 20 Jan 2021 21:02:25 +0000
Message-ID: <D646BC66-D79B-4EA7-807E-A60B5255FFF9@oracle.com>
References: <1611095729-31104-1-git-send-email-bfields@redhat.com>
 <1611095729-31104-5-git-send-email-bfields@redhat.com>
In-Reply-To: <1611095729-31104-5-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4341d947-8cfe-4772-707a-08d8bd86b02b
x-ms-traffictypediagnostic: BYAPR10MB2693:
x-microsoft-antispam-prvs: <BYAPR10MB2693392328D18B4843E6F6F293A29@BYAPR10MB2693.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNBT4N0w8N0Puwf17qA2SyWYyCsOETn0CU9D5HAqP3sYMsPy8NJpHI6yS/UqMdmieLSgKTniN8Nf3zsQv4f3dC5kGn0wP8TDMUeYtaLfg4FUlDzfdvWGI+DPwPJaMsw5Yz7ATklJSh7q4wu9CWkeInPhnCkdvFihL9i7Gp4jCA67VuR1mjHU2qmAagT/arvgHo4SSGpbgSYkrvwRvGnDku5GmBJxSVpPy1NWxPmR/ojxtr5y20u5+Af+sQPoDe4rCGBwuk23eeEsys+OT1rDZHQfTB5JTpywrugkdFNsUpkbCOpw52Mrxh0coM7GIuU5iMkWTpmqAZT6JvQFWiZG8Kd3lKU6jlZ3+QcwRPdM3BysMF4ZFUNQKa1N9RkOUU6o0pTUPFMZSLCE0vECOKf2jEkH0+92GT40+gadulzC+qvIugU27YMtETEDXqsRuX5JU7kN14q76IuJWXXtAh1Mze9Pr3jGF6yWqICBct7/LBoaMIK5LfF6SjkNCfIWjQSoRtl0rl1mFiVtZGMrOyZl6E+8RYQTV/H3HH/UuX++JSRNmNPZN6vEVeMqVhqLkU3uDhSvaKpH74SPATuWP8cjyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(64756008)(6512007)(26005)(66556008)(66946007)(66446008)(91956017)(2616005)(83380400001)(6506007)(33656002)(86362001)(66476007)(53546011)(186003)(36756003)(8936002)(2906002)(76116006)(316002)(6486002)(6916009)(44832011)(8676002)(71200400001)(5660300002)(508600001)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?E2mifHpmpgdr23XcdtTkgeV1xCsryAHvVpWQOTGEfTHhYyDtFAxfzjfLA2ug?=
 =?us-ascii?Q?CCT0Ifp5KwalivJAcW8ezyZNvvrSHedR/lF2PpKihnQZHSvEDGtCQPXH6XOm?=
 =?us-ascii?Q?tZsQertHCd35F1/8BepbBP5sxUc3rl+RFy78TBcSlxEw6uPXXQ+rQunpRZZZ?=
 =?us-ascii?Q?Jy6tX/7sKXpcN1zhKF7APTxsj5Jmc4RxeW7Mh0kmqwnRGKWNLWbthA3R27mr?=
 =?us-ascii?Q?ytLpbKFBg1uga05lbh+mTKZ+VJekRLkCimNeXb4fYVUpNQ2mS0bP+wP+HuDl?=
 =?us-ascii?Q?P0JXaO81JUq7Zx0BhD1cPW9+4SLqlgD8RhNMKPpDMvPU2Nqi/sHtojG0lOzD?=
 =?us-ascii?Q?N0ln7sS8B7cuqEHt1SaV45eJPs9OMT81R1frsEAEiSuq1A3kSTCssU3oU4IW?=
 =?us-ascii?Q?tYvh11ui5UR0yOzj5D+Wh2cMpDJ6dewMNDhLzlPoPO1IAUKitFxSgklPB3eT?=
 =?us-ascii?Q?nxg3WK6b2G6Sfqw5MHupkcg6qTMrjs/hVxRiBKlIMqQlvPevTThRbfKX1V6W?=
 =?us-ascii?Q?7smCMAxei+T2MZ+ynvOQHQIDToke23iiFA93uOY2uPo17++Z6ikvPmI4CDVd?=
 =?us-ascii?Q?IwuuRU4jufnbYLJLgBww88wNik/W4lLNjeOGrDk33Xzl6zUllJCucpQk3ZlF?=
 =?us-ascii?Q?8i5OHQcKzJBf7pBYYhosdcman0nU5o375BR+P27xRCRH6cZx2YPLkyyE6kk7?=
 =?us-ascii?Q?R2QfPwbWrZhawlCcps6VmvApC6LlsOU7ew9BNJpxvd2bGw2mwUbH2XnX4OS9?=
 =?us-ascii?Q?YVB89j8FzbMFPHCrlb6WwOC6hy/KpQfULpup++HaDzQVrgtm4oNXTP2u0W7B?=
 =?us-ascii?Q?sG9J99pQfghFovNi4Q4T3wMT4vrIgVR4mZjC7h6MxD4+RYWG7urrDMgR/nIy?=
 =?us-ascii?Q?vS0r4mJJDjyGXCqhLVxf/q6rmDFzwwBpzCkoqSgIx6l3PYnoLBhcplcoNJDM?=
 =?us-ascii?Q?bl98AugeSoA165JQOF1jzONTdkOE3MjWatRxexplpxLNmdVlsJjUwLI+Tkpo?=
 =?us-ascii?Q?BtIs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <789747F01D04A44B813CEC215A972C82@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4341d947-8cfe-4772-707a-08d8bd86b02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 21:02:25.0564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ei8WKFSAOq7C0aYMum1I4t52yY/NXguqRwCDlXJ7dNuzf7N3IoU0+/FYpjRAbDOpcX58ZhwwhCuT4AZZS6G1UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2693
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101200121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9870 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200120
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 19, 2021, at 5:35 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> I think set_client is a better name, and the lookup itself I want to
> use somewhere else.

Should this be two patches?
- Rename lookup_clientid() to set_client()
- Refactor the lookup_clientid() helper

nfs4state.c stops compiling with this patch. See below.


> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/nfsd/nfs4state.c | 50 ++++++++++++++++++++++-----------------------
> 1 file changed, 24 insertions(+), 26 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ba955bbf21df..d7128e16c86e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4633,40 +4633,40 @@ static __be32 nfsd4_check_seqid(struct nfsd4_comp=
ound_state *cstate, struct nfs4
> 	return nfserr_bad_seqid;
> }
>=20
> -static __be32 lookup_clientid(clientid_t *clid,
> +static struct nfs4_client *lookup_clientid(clientid_t *clid, bool sessio=
ns,
> +						struct nfsd_net *nn)
> +{
> +	struct nfs4_client *found;
> +
> +	spin_lock(&nn->client_lock);
> +	found =3D find_confirmed_client(clid, sessions, nn);
> +	if (found)
> +		atomic_inc(&found->cl_rpc_users);
> +	spin_unlock(&nn->client_lock);
> +	return found;
> +}
> +
> +static __be32 set_client(clientid_t *clid,
> 		struct nfsd4_compound_state *cstate,
> 		struct nfsd_net *nn,
> 		bool sessions)
> {
> -	struct nfs4_client *found;
> -
> 	if (cstate->clp) {
> -		found =3D cstate->clp;
> -		if (!same_clid(&found->cl_clientid, clid))
> +		if (!same_clid(&cstate->clp->cl_clientid, clid))
> 			return nfserr_stale_clientid;
> 		return nfs_ok;
> 	}
> -
> 	if (STALE_CLIENTID(clid, nn))
> 		return nfserr_stale_clientid;
> -
> 	/*
> 	 * For v4.1+ we get the client in the SEQUENCE op. If we don't have one
> 	 * cached already then we know this is for is for v4.0 and "sessions"
> 	 * will be false.
> 	 */
> 	WARN_ON_ONCE(cstate->session);
> -	spin_lock(&nn->client_lock);
> -	found =3D find_confirmed_client(clid, sessions, nn);
> -	if (!found) {
> -		spin_unlock(&nn->client_lock);
> +	cstate->clp =3D lookup_clientid(clid, sessions, nn);
> +	if (!cstate->clp)
> 		return nfserr_expired;
> -	}
> -	atomic_inc(&found->cl_rpc_users);
> -	spin_unlock(&nn->client_lock);
> -
> -	/* Cache the nfs4_client in cstate! */
> -	cstate->clp =3D found;
> 	return nfs_ok;
> }
>=20
> @@ -4688,7 +4688,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cs=
tate,
> 	if (open->op_file =3D=3D NULL)
> 		return nfserr_jukebox;
>=20
> -	status =3D lookup_clientid(clientid, cstate, nn, false);
> +	status =3D set_client(clientid, cstate, nn, false);
> 	if (status)
> 		return status;
> 	clp =3D cstate->clp;
> @@ -5298,7 +5298,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> 	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp), nfsd_net_id);
>=20
> 	trace_nfsd_clid_renew(clid);
> -	status =3D lookup_clientid(clid, cstate, nn, false);
> +	status =3D set_client(clid, cstate, nn, false);
> 	if (status)
> 		return status;
> 	clp =3D cstate->clp;
> @@ -5681,8 +5681,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *c=
state,
> 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
> 		CLOSE_STATEID(stateid))
> 		return nfserr_bad_stateid;
> -	status =3D lookup_clientid(&stateid->si_opaque.so_clid, cstate, nn,
> -				 false);
> +	status =3D set_client(&stateid->si_opaque.so_clid, cstate, nn, false);
> 	if (status =3D=3D nfserr_stale_clientid) {
> 		if (cstate->session)
> 			return nfserr_bad_stateid;
> @@ -5821,7 +5820,7 @@ static __be32 find_cpntf_state(struct nfsd_net *nn,=
 stateid_t *st,
>=20
> 	cps->cpntf_time =3D ktime_get_boottime_seconds();
> 	memset(&cstate, 0, sizeof(cstate));
> -	status =3D lookup_clientid(&cps->cp_p_clid, &cstate, nn, true);
> +	status =3D set_clientid(&cps->cp_p_clid, &cstate, nn, true);

This doesn't compile. I think you meant set_client() here.


> 	if (status)
> 		goto out;
> 	status =3D nfsd4_lookup_stateid(&cstate, &cps->cp_p_stateid,
> @@ -6900,8 +6899,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
> 		 return nfserr_inval;
>=20
> 	if (!nfsd4_has_session(cstate)) {
> -		status =3D lookup_clientid(&lockt->lt_clientid, cstate, nn,
> -					 false);
> +		status =3D set_client(&lockt->lt_clientid, cstate, nn, false);
> 		if (status)
> 			goto out;
> 	}
> @@ -7085,7 +7083,7 @@ nfsd4_release_lockowner(struct svc_rqst *rqstp,
> 	dprintk("nfsd4_release_lockowner clientid: (%08x/%08x):\n",
> 		clid->cl_boot, clid->cl_id);
>=20
> -	status =3D lookup_clientid(clid, cstate, nn, false);
> +	status =3D set_client(clid, cstate, nn, false);
> 	if (status)
> 		return status;
>=20
> @@ -7232,7 +7230,7 @@ nfs4_check_open_reclaim(clientid_t *clid,
> 	__be32 status;
>=20
> 	/* find clientid in conf_id_hashtbl */
> -	status =3D lookup_clientid(clid, cstate, nn, false);
> +	status =3D set_clientid(clid, cstate, nn, false);

Ditto.


> 	if (status)
> 		return nfserr_reclaim_bad;
>=20
> --=20
> 2.29.2
>=20

--
Chuck Lever



