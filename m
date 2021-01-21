Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7637B2FF8FC
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Jan 2021 00:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbhAUXf3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 18:35:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47302 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbhAUXf1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 18:35:27 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LNSn8N159990;
        Thu, 21 Jan 2021 23:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=csoqgEIjczb3sETE2DJ1NgzGBRnvzjFAPEjUoN4MJUA=;
 b=QcyFLbU+3mLpZJDU7Ge7pZqnMWV3/U9YopAUb91zm+Z7nDq/puXgNvRWPnGmrEy7y5eJ
 +fV81UAlsflYXKb6iLncHDw4Q/+LBB0Dh+Ts+ogR9XZ+zW16gqigoQ07DeW7roMVeTb1
 p6LqT1nGxPlXgVVVJcBl98dzuynoMe3/PSwoc6OkWSlQyECARqbbasznn7RLivZucI5H
 Eq3VVuY2Sl3i3j5J9niXCa8sroqhdVcJrFK/wJhwCrYN7X2sk4DlrFw1WmNcAI/spoyu
 VrpVsBIkl2+THwXVQ8JOUjYKbvjx1QjbnhYcovQ5Nx/294A6BmneVhHT1yw3qQarFca/ /Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 3668qrhtkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 23:34:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10LNW2hH048632;
        Thu, 21 Jan 2021 23:34:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 3668rgjkx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 23:34:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqHWltQ8EsqZWkSvTs3aq1CuKc41medZIDbi9WBEWXA0wnwQN6buUsVzBkeh7CsbwwFJwdW0LZYf1LPyICYLTuEJ1iv8wD4sZptDlDLyRlSKSB1cUZ2E/G8FYAx+dp+Wv2h0wVZWxPyfyZivRnadz60xtnlKtrOECobzZYZAi2K+PJH3f2lJVgBZnu49z3nQNWtrjIj4LzE8mHWCymKiFVKqLnKCwcAY6SZiYoTn9Ty35NNF0ZjoCZuGYvJatBsulZ/TyoQO1FZKzjmjhapOmOPQ+yEWBg3xHo13agUFpzxajjFsKYcY46g8pa98+PblUHFTlxfS9kzWYZNMrFd0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csoqgEIjczb3sETE2DJ1NgzGBRnvzjFAPEjUoN4MJUA=;
 b=XotBt7EnJhxpEwj/i8J/lUTuByIeSap6wJ5n9zVdevqiB2hwSl20zjSLNlMABDVL182LMI34TqdZHY4a55OCDeiwmHQA6HIaMKgnnETh9c7pr68AdvOI95BbRzy+5V07VL61XZCzlKgC/VOFsNbJrlAOGPhSKwW1LF9uC4Ho6q8vevU8F+wsfweQ0+AbU4+qP1Ud2KIhA16U/ImaixztUtxf+AyeW5YT78kEtdYM6Lndk6ZNRYcllRD/Brim+jq25XmlzWho9nIim3o+Rm1TKDnZOWdmu5VNDaPHrtXX+/1nmcGgpk0CNpmwmBXG2zBiqDo3AZF5/zPjixV3aofLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csoqgEIjczb3sETE2DJ1NgzGBRnvzjFAPEjUoN4MJUA=;
 b=rTOTA2U2CHaii+O/Ld49Ml9gWhEXbpDIxwOBNel3RbNKJq5L6R2yXxrP801+ix3lhOi2H7mlSaqzJl1jKyOp5fdY/4lu4I4/5FtMPW1apHyLM5R3HwywmI5r57N7FDw6u6Q9jhB8H4kEaP/hcWa5QQrp26vYNum6kMv2aiV3NNQ=
Received: from CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8)
 by MWHPR10MB1309.namprd10.prod.outlook.com (2603:10b6:300:1e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Thu, 21 Jan
 2021 23:34:40 +0000
Received: from CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::dc95:1194:d2b5:b147]) by CO1PR10MB4673.namprd10.prod.outlook.com
 ([fe80::dc95:1194:d2b5:b147%7]) with mapi id 15.20.3784.014; Thu, 21 Jan 2021
 23:34:40 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3 9/9] nfsd: cstate->session->se_client -> cstate->clp
Thread-Topic: [PATCH v3 9/9] nfsd: cstate->session->se_client -> cstate->clp
Thread-Index: AQHW8Ejb6TgigXAr7Uun09HH2mtsGqoyu2aA
Date:   Thu, 21 Jan 2021 23:34:39 +0000
Message-ID: <E452A0A0-4015-4901-8EC5-27EB73BEEC3F@oracle.com>
References: <20210121204251.GB13298@pick.fieldses.org>
 <1611269865-30153-1-git-send-email-bfields@redhat.com>
 <1611269865-30153-9-git-send-email-bfields@redhat.com>
In-Reply-To: <1611269865-30153-9-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f78ad99-7c59-4c1b-c164-08d8be651f65
x-ms-traffictypediagnostic: MWHPR10MB1309:
x-microsoft-antispam-prvs: <MWHPR10MB1309100B2095BF642D769F0193A10@MWHPR10MB1309.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHdzn+ZXQ/WuzeBsD9j48QYkC2vqJqklKLJPmeGVFHqf/37YcctST8TamDTC/6w25rLl/DEHG1fot1kbOTNDSytTEgQgSXDMZCxH0l0En5TgltR/T3I+cZNp4bXJM4e/0YRVm1YbalmRohokmokMUmoIZssuQjlYTNPzlZJvtvQLVKizbFq7ebqKq8zK7axdkzgAfYRGx5jJtzsIQD1pVLLacccqwuuXEIEg44KjcmTHGz7019STDelFdO2UKKaLYgG4OWBps34t8t9EdGNNEHf/n65mkjha/gBvKk3HQKk8VBX/goKyi9JjCz1FeBaaqDBTWKlZ1RskEu79PzZQJ456boALT77ohqa3FKQJl9GhLlplHPdnnGmC7cgS9cF6MoFEkOrbG8K/S2ydCNfl3wL/oujJ/1br3STbA2TrFhZ58jKTzVFnqTTeEa/sWdg8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4673.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(6486002)(26005)(186003)(66946007)(91956017)(8676002)(66476007)(53546011)(2616005)(6916009)(64756008)(2906002)(76116006)(6512007)(83380400001)(66446008)(33656002)(316002)(5660300002)(8936002)(508600001)(66556008)(36756003)(71200400001)(44832011)(4326008)(6506007)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UM6w9LtneN2DyIEevtSXKrkC9HjcqpvNjz9V+12L9kGij1vW4FbN7KQzVVVI?=
 =?us-ascii?Q?77wOfWtuu0yCFli6BxpwRB2/1QnusFzVAejgfc3LfcsoErNbpj+5LleVNDZH?=
 =?us-ascii?Q?ACYYHK5kxUK3G6oOw1ZEgtzG70UkUMTIBohWcQmciHrH7s76UPl2fxOhOdzl?=
 =?us-ascii?Q?DZeNaiP98iaMz7dEOBb0wwAjppjIniZKQ0Qjv7xviEkBAYRoCNGaJKLFbvl6?=
 =?us-ascii?Q?hwg/ngmTO5OuP7ic+59WmE/ioo4vWQqNYhO0/pc/saOoE6/yswrkgtMo786T?=
 =?us-ascii?Q?xNrIQt/uKxyjr7mioDg3BgSH3akwqoEa258JHp2xu08o6VxNXFTne1695PbP?=
 =?us-ascii?Q?XB++1dDIDcwC6OdHxAPwRNjwUVkzuNBN0nikWFm6jTVwppQWr9ApJoL/VxPH?=
 =?us-ascii?Q?DEsisC59r6nuvzj/Gwq/HaoIiULNtK17kcLYx54vWLMzAOe6PAnOqy3QMkjA?=
 =?us-ascii?Q?3nd827LZE+gZNkSCUU8foYIkILuHw7TU8rMmWY0mTZ74orhzoqMThR+fnxAq?=
 =?us-ascii?Q?Vxo1hTmWAsW1HMr9nR1HqqKbweSe1kOvixWN6V7ZovanxijwL42DhlAicysC?=
 =?us-ascii?Q?RptHvmP/i7NhNrmtvAB9dL45RCY1B/ab9fu0oe8ON8jDuin58bTFwEgPmC+k?=
 =?us-ascii?Q?8/h+SYKYyoLTN0y4KRCbdtd+FbePTwZ5jN/KiRvgjYskFJAwbhRRhg7l1pss?=
 =?us-ascii?Q?VQYyxtfcs9oEYxKk7+/uNCSNygmmlRM5z4OlH5aDjtCPCbHNxB5RZ+4yT6pq?=
 =?us-ascii?Q?Qa3NM1vVykd4LxEhtvnZBcMZbHrTqBTc1srrlzyQqrafC0r6bkSIK9koZHr+?=
 =?us-ascii?Q?EXN71QzmuR2y3msEr1DH8KqQuGO6I1hYrrUMLB76CuEOV3VNcrMG3O70izMG?=
 =?us-ascii?Q?qwOd7lTSFpk281qD/2QXRAaH9vvLB5hAzVGNEVvUAY+VOAIJ9b5ClLS4sqQR?=
 =?us-ascii?Q?txbG1HXRgRKBcyIQfv7dBvp6/xvGhwRJ6VFueAd9/GmqO07u+HXVPJI871Y5?=
 =?us-ascii?Q?F29b?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1077F8AE7DAE624DAB413A553EB2337D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4673.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f78ad99-7c59-4c1b-c164-08d8be651f65
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 23:34:39.9596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riUA4Ajwlz3NGEH90AgVJn0xJ93HRs84wrBlZFKm3rVgEQI/TiblIXpXqcJ+tLp0p16pBA+43YeQY2aldbFpvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1309
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=955 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210117
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9871 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210117
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

> On Jan 21, 2021, at 5:57 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> I'm not sure why we're writing this out the hard way in so many places.
>=20
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>

Thanks. v3 of this series has been committed to the for-next branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

in preparation for the v5.12 merge window.


> ---
> fs/nfsd/nfs4proc.c  |  5 ++---
> fs/nfsd/nfs4state.c | 16 ++++++++--------
> 2 files changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 567af1f10d2c..f63a12a5278a 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -373,8 +373,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compo=
und_state *cstate,
> 	 * Before RECLAIM_COMPLETE done, server should deny new lock
> 	 */
> 	if (nfsd4_has_session(cstate) &&
> -	    !test_bit(NFSD4_CLIENT_RECLAIM_COMPLETE,
> -		      &cstate->session->se_client->cl_flags) &&
> +	    !test_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &cstate->clp->cl_flags) &&
> 	    open->op_claim_type !=3D NFS4_OPEN_CLAIM_PREVIOUS)
> 		return nfserr_grace;
>=20
> @@ -1882,7 +1881,7 @@ nfsd4_getdeviceinfo(struct svc_rqst *rqstp,
> 	nfserr =3D nfs_ok;
> 	if (gdp->gd_maxcount !=3D 0) {
> 		nfserr =3D ops->proc_getdeviceinfo(exp->ex_path.mnt->mnt_sb,
> -				rqstp, cstate->session->se_client, gdp);
> +				rqstp, cstate->clp, gdp);
> 	}
>=20
> 	gdp->gd_notify_types &=3D ops->notify_types;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 389456937bbe..f554e3480bb1 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -3891,6 +3891,7 @@ nfsd4_reclaim_complete(struct svc_rqst *rqstp,
> 		struct nfsd4_compound_state *cstate, union nfsd4_op_u *u)
> {
> 	struct nfsd4_reclaim_complete *rc =3D &u->reclaim_complete;
> +	struct nfs4_client *clp =3D cstate->clp;
> 	__be32 status =3D 0;
>=20
> 	if (rc->rca_one_fs) {
> @@ -3904,12 +3905,11 @@ nfsd4_reclaim_complete(struct svc_rqst *rqstp,
> 	}
>=20
> 	status =3D nfserr_complete_already;
> -	if (test_and_set_bit(NFSD4_CLIENT_RECLAIM_COMPLETE,
> -			     &cstate->session->se_client->cl_flags))
> +	if (test_and_set_bit(NFSD4_CLIENT_RECLAIM_COMPLETE, &clp->cl_flags))
> 		goto out;
>=20
> 	status =3D nfserr_stale_clientid;
> -	if (is_client_expired(cstate->session->se_client))
> +	if (is_client_expired(clp))
> 		/*
> 		 * The following error isn't really legal.
> 		 * But we only get here if the client just explicitly
> @@ -3920,8 +3920,8 @@ nfsd4_reclaim_complete(struct svc_rqst *rqstp,
> 		goto out;
>=20
> 	status =3D nfs_ok;
> -	nfsd4_client_record_create(cstate->session->se_client);
> -	inc_reclaim_complete(cstate->session->se_client);
> +	nfsd4_client_record_create(clp);
> +	inc_reclaim_complete(clp);
> out:
> 	return status;
> }
> @@ -5918,7 +5918,7 @@ nfsd4_test_stateid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> {
> 	struct nfsd4_test_stateid *test_stateid =3D &u->test_stateid;
> 	struct nfsd4_test_stateid_id *stateid;
> -	struct nfs4_client *cl =3D cstate->session->se_client;
> +	struct nfs4_client *cl =3D cstate->clp;
>=20
> 	list_for_each_entry(stateid, &test_stateid->ts_stateid_list, ts_id_list)
> 		stateid->ts_id_status =3D
> @@ -5964,7 +5964,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> 	stateid_t *stateid =3D &free_stateid->fr_stateid;
> 	struct nfs4_stid *s;
> 	struct nfs4_delegation *dp;
> -	struct nfs4_client *cl =3D cstate->session->se_client;
> +	struct nfs4_client *cl =3D cstate->clp;
> 	__be32 ret =3D nfserr_bad_stateid;
>=20
> 	spin_lock(&cl->cl_lock);
> @@ -6693,7 +6693,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 		if (nfsd4_has_session(cstate))
> 			/* See rfc 5661 18.10.3: given clientid is ignored: */
> 			memcpy(&lock->lk_new_clientid,
> -				&cstate->session->se_client->cl_clientid,
> +				&cstate->clp->cl_clientid,
> 				sizeof(clientid_t));
>=20
> 		/* validate and update open stateid and open seqid */
> --=20
> 2.29.2
>=20

--
Chuck Lever



