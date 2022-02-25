Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B014C4ABE
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiBYQaT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 11:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiBYQaS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 11:30:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21B18F231
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 08:29:46 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PEkRc5017395;
        Fri, 25 Feb 2022 16:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ApyO46Q6C20FB3JAC6Fy8F2UxDkGPOuIOZSXUq4J6kw=;
 b=lAfODWRkl+o44V4w11SrtTIOhfLBfdFb9cB/8VuYiAI+Kd52ZtbLKlk4dILh1s7ry31w
 Clflhk0su8RERFrewKNOF1fery+FtsAnrdCfc90KQMHlBDfUke01nF/N2vGr/Hgw1lDM
 IDhkaQNbNfyWru5Kic+APP4uFL5qwYzisjidZaExepKP/5zUhRcnOl2zlX6nEa5o/JZU
 3SKenCatmn4A4NnqkaFmlJowXIobwzZZSGKkCSPzAUUMkgIC81pjaqYbETIC+ggoNO5V
 1dLcHU4dFQZZECLeP7sqpqi70GhdfMktElqsNO1HQutiKh5VTyi0yD9079icEh9xZlnD 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3eexar9mha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 16:29:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21PGFiLV040489;
        Fri, 25 Feb 2022 16:29:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3030.oracle.com with ESMTP id 3eanp0djat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 16:29:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoFiTn1bLP3y605T8QIWLmLFe7WDvpT4UF843uoMWmy0twm6Le4tXl/X3oflRiS0hO3Ndwh/mxifI5ALJ/UvatGeAn3KFjjb3Wl+oN2CdQ3b7XMRnM431RibdJdL+KzfI64wYXTOtjiR/DVuJZO4alz3+9loBLAbVI2tnDVdygQKEpio0OgLpGloxCicJI1ZA+Q3pvZ3wuDj6HR9Ow9l982iBCXlXYtB9/Gs+Ub2Jbg+EMJIMgY9wPcOME12b71hl/bO0+6n9CfNPvV2dO5+s7+f1g5LmIvwDx0jjy8KS9mZiBVauhHMA8Rrupx1hovypO9jxA+eV5CHzFGiqkILNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApyO46Q6C20FB3JAC6Fy8F2UxDkGPOuIOZSXUq4J6kw=;
 b=VbsIS/x/TX80Kck4o71sunC0RXqFbhFsZ87Ee3BLzQkcHQ6kEncCD5bCEDp17EeYWhgtsKjF/NZRHVAnEAcT1V/Qms2x64YcPPsAsPkHXQAPVn9gSeC4DduuD8pr6ennVp+z1gz7EbOmyVyu20ZxYsIZBVSPd6gWYrZDzGq0PxOJW276gpG0RQNRJ6mocLj8lcrfz3nXBzpg7i5kzsvtS2w7vNtBeWAnXCQAuMmFwfP0wB9gyS8LKlryzK4b5JVRLDsi299WAeJS+R2kzZtebOYEw714EUc49z55vQ/I+TNalo+/vqqGR4NVOixP4Hz8YoDsJY/1aVsu4aoAAyGrRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApyO46Q6C20FB3JAC6Fy8F2UxDkGPOuIOZSXUq4J6kw=;
 b=eJuWaBdxmP7QysDHCKpRJRP0GR2Wmh1/bIGRVZTz6JvcQt+TUuJL+llvKlFp8F57uPg4/7ETL1KSLGxu+a7jjrEUvZocbgEffiHBNvXQ58O6ZpmwExo3+gNfxHGRfP5tK6JUZsBeGgnrZP0UeLHx8GU68sA8RnQttxoFtdi5gkw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3001.namprd10.prod.outlook.com (2603:10b6:5:69::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Fri, 25 Feb
 2022 16:29:39 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%9]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 16:29:39 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v14 02/10] NFSD: Add lm_lock_expired call out
Thread-Topic: [PATCH RFC v14 02/10] NFSD: Add lm_lock_expired call out
Thread-Index: AQHYKOGEQdBcKhevikeQgXVTxIOIjqykeAGA
Date:   Fri, 25 Feb 2022 16:29:39 +0000
Message-ID: <648261D6-098A-4326-9D03-516E69A85746@oracle.com>
References: <1645640197-1725-1-git-send-email-dai.ngo@oracle.com>
 <1645640197-1725-3-git-send-email-dai.ngo@oracle.com>
In-Reply-To: <1645640197-1725-3-git-send-email-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e2f19aa-f296-4489-51b6-08d9f87c053b
x-ms-traffictypediagnostic: DM6PR10MB3001:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3001FE41647C0AD018733D1B933E9@DM6PR10MB3001.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xP2wQuEFoswKGQVjRyCtHPrPB/Ycy6ViqSvrle9eO5E9MWaV6hVj70/2VNX14COuJSnvGTPucVW+VuhZgO9mL8kgUgXfu0B7N6HrZ2HYOFUVAF3LqDZV+PC8c6VQ8q4pS+0fKZTxUeDhAr/MzX5Xkyu4QC5hSV8MOZ10RpubywlDJDSNnGP4S4oWb49VmCnzrDvr771vzJVAcRXvgK57VQ6nylICNnqqA1cmpXPtQqk04hVGPn37Er1uHcvX5z6lhb4qkMmkFHyl9f+cHDuhakCeCpa5Aor25Jy1qeeoMgviHjSd/gR+jcqaFZ9eukVh9u+EjOkUiPt/dQfdcidR1BWqf5FeZnarZrAsF2x8RaTZgF7tnGHnIE8zidi0utrQchODBjQ//eZ3mK3x0pVfkqIcFzpX9BFqHFAyenhETEyzVRuK9o0wVL36OvcJW4pL1OjRrrcSA/HmjwP+uuYd8xcTBEya8AA99ElNp8QdfJ6IY/A7BV+SSBsUQCc3bzrjvOXX5wFpw22/gd4ZPtycHsJ3Y7nWP28dgEhCgiMejwZcK05mAOfhvLiINbeldaqjT0p6+LYp62h4EyF2s1cK7CYneRUrO/WZYfw2Z1qYxV0xkWVlXCM9bg9SHMf4TQXqPx/w98XPUii+70IlJDO2vG6EXtvvz6A5cJzB8CUTIxnMzrN2Cq1DdEuO4gz7O86XI5oD991nB5gKU/mSF5arFkcBV5tnyzjFtwdrxF1CcLWteVddn/xuobBhXsSWFmpk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(37006003)(508600001)(76116006)(38070700005)(53546011)(71200400001)(6486002)(6506007)(86362001)(4326008)(91956017)(6862004)(66556008)(66476007)(66446008)(64756008)(8676002)(316002)(54906003)(6636002)(66946007)(83380400001)(186003)(26005)(6512007)(122000001)(36756003)(38100700002)(2616005)(8936002)(33656002)(2906002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fQARjnDZ8a2SL64yAiNQYUFCw9eB98qn7+0z7Fos/glFmwW+SzXoLFF2GaRC?=
 =?us-ascii?Q?rMhHRBBj2cSNK1+vU/zLUaaWD3jq9ad7pzxiv+/8H+7NaasMjaUXeeN/j95T?=
 =?us-ascii?Q?3u7NZI2Jj/vAFzwvXPN7j+cX1tSVWHp/PAcR9eer2ZV8/47TZHSzsOKL0HkN?=
 =?us-ascii?Q?YDqCTC2/bP9RO4mI2R3maEN/P53t94MhA9l86EyBKCP0j51imLSd2Ut1fTp0?=
 =?us-ascii?Q?OdoijB/fmfWFM6CcpJxGfAfCNv1yNAIY77Q6G4lM1y5A6w0nXiCd5Nsm8x59?=
 =?us-ascii?Q?BgtBpbnSdDqS367ZheYDOMrM5NvoyFw0ta/aXmh9Q3/wUEUo8BAp7oGyPaaY?=
 =?us-ascii?Q?yYjjT5RknP4PpwBL8QyBZLot/7TnuphYZBiY6GmjmKe1ge+SnlYu+IsGzdKZ?=
 =?us-ascii?Q?IKQjEX55/WPS9OPpxiTzBA9oOm1rZRXQADN80PVaIYVc4GvAdWqa+EXd6RDJ?=
 =?us-ascii?Q?B5LQs16PK6fj0bNvPhhUKVY3bUxO4vd9jEj2N/K+Evu3vJmUEqu1dL6EhF8D?=
 =?us-ascii?Q?gXUoxvzBD6YbTaKrcbVEspt4fJv/izVOPhJqedfYe1kRuT0IwGhRSc6wPCDe?=
 =?us-ascii?Q?dHFQ/CWhHtpImUA/j6qHYdjkyx1mNUkSGGSsSyJy9oM2QnMEpZ0qv5dAnZ34?=
 =?us-ascii?Q?C+jWHsslk+2t8ve/J40045b/jbTN2ccetI47cQAg93Jhe7TsVdxSxGfp6iz5?=
 =?us-ascii?Q?6xaX0TdtOTKJNz0v7JxHCDuyQMGUu7a83UHV/wtA/chLv4YoV1UWS156kpQy?=
 =?us-ascii?Q?yRwZ/4qMpiNWOI8dG/CmN9W35h+yQBdlrlfCVDbQ+ugq5DJi+O6z6EJWC64c?=
 =?us-ascii?Q?9Tu5+tTCvzSj5TTgWD9plXrqoHt3127JgdB0YLmqmB0OIDY8B78VgxaH8lAo?=
 =?us-ascii?Q?xFqVMbWk572JMuZJcq6vVZp1E5cu/eSwPK4s8PoJdi0ObnPzGxyEaCobqn43?=
 =?us-ascii?Q?TMQAnw+FglqEmUEOOT4C/KRmshhHvd48yEBmWK7KQhcPjJ/HfEsg+0/QpHNk?=
 =?us-ascii?Q?zYlaODsqIJjNnOUZHlLn1P/Jvpq91gp/fxpW1WInvlS81cFdMIA8GJ7RzhCm?=
 =?us-ascii?Q?waWbmD7kE27nEFttIzp1pOhult8fu6MLBzPVl4vmu4ka+ErCdjjUehlv8jEj?=
 =?us-ascii?Q?gp3ETGj5AADmgGmttmY8UTpGXSK9EbPxsEF1IKg3OeFmUpzC/GJGZQz98EYz?=
 =?us-ascii?Q?c8j1WK5oMTiCXjbkh2osiQPAG5yIH1PMrZhFWBrAMFdi/ZMODqWiC4lZC1Mq?=
 =?us-ascii?Q?ur6dseWttJPEtEu8vVgH5/M601zYn+ldNEDZi2ixUsK5APLLQg+T0J0DPzMX?=
 =?us-ascii?Q?DdVINOgh8MUQcFb5r7ZgkewSAnssCo/RIXkfzX5x4KJn6pIN4VTasDi9aU4P?=
 =?us-ascii?Q?75hzW8rF/1fiQpbO2NvXnlCll6ShWhJN2D3gp6jfQYzaqaz0J335hudbxtOp?=
 =?us-ascii?Q?ZCbpF+jssdG2rTVimMTFsgNj2plOF1hcjYNvl9oretVdxROMF/ZnwEcRjuqh?=
 =?us-ascii?Q?FYO1wrWRVwz/r1B5Q4zOnl5BKOhgQJcH1qpUvjc95z3b6lmb3Gql4Aw81U0g?=
 =?us-ascii?Q?nBDhnIfKiaK1adVf6Qduknps0Wn1QjKpYyiMhWSMOw1PHh4DYePXhzHV0NHo?=
 =?us-ascii?Q?WAPEPzHj1Jz2LvdPYqHlRv0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <736FAA40E86F47428EF64F615790A1EB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2f19aa-f296-4489-51b6-08d9f87c053b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 16:29:39.6105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eo1+URPi/6fDFsJyRkOtB3Bn7So6xw3IcI4liSwGP+P5iGCpPd6hQkRKb3uO87Y+x55NxNfvkqyhkjC3yRqr6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3001
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202250096
X-Proofpoint-ORIG-GUID: ywzj9V-HSFBc4yWcYmx3WKi8nPUEP_ZP
X-Proofpoint-GUID: ywzj9V-HSFBc4yWcYmx3WKi8nPUEP_ZP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 23, 2022, at 1:16 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Add callout function nfsd4_lm_lock_expired for lm_lock_expired.
> If lock request has conflict with courtesy client then expire the
> courtesy client and return no conflict to caller.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 37 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 6a10f089ef4c..6bca727978ea 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6578,10 +6578,47 @@ nfsd4_lm_notify(struct file_lock *fl)
> 	}
> }
>=20
> +/**
> + * nfsd4_lm_lock_expired - check if lock conflict can be resolved.
> + *
> + * @fl: pointer to file_lock with a potential conflict
> + * Return values:
> + *   %false: real conflict, lock conflict can not be resolved.
> + *   %true: no conflict, lock conflict was resolved.
> + *
> + * Note that this function is called while the flc_lock is held.
> + */
> +static bool
> +nfsd4_lm_lock_expired(struct file_lock *fl)
> +{
> +	struct nfs4_lockowner *lo;
> +	struct nfs4_client *clp;
> +	bool rc =3D false;
> +
> +	if (!fl)
> +		return false;
> +	lo =3D (struct nfs4_lockowner *)fl->fl_owner;
> +	clp =3D lo->lo_owner.so_client;
> +
> +	/* need to sync with courtesy client trying to reconnect */
> +	spin_lock(&clp->cl_cs_lock);
> +	if (test_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags))
> +		rc =3D true;
> +	else {
> +		if (test_bit(NFSD4_CLIENT_COURTESY, &clp->cl_flags)) {
> +			set_bit(NFSD4_CLIENT_EXPIRED, &clp->cl_flags);
> +			rc =3D  true;
> +		}
> +	}
> +	spin_unlock(&clp->cl_cs_lock);
> +	return rc;
> +}
> +
> static const struct lock_manager_operations nfsd_posix_mng_ops  =3D {
> 	.lm_notify =3D nfsd4_lm_notify,
> 	.lm_get_owner =3D nfsd4_fl_get_owner,
> 	.lm_put_owner =3D nfsd4_fl_put_owner,

I started to pull this series, but quickly realized it isn't
based on the current contents of the NFSD for-next topic
branch, which changes the names of nfsd4_fl_{put,get}_owner
as we discussed during v13 review.

The upshot is that I would have to apply each of these patches
by hand, which is tedious and error prone for more than one
or two patches.

Please pull the latest from my for-next branch, rebase this
series, and then post again. Thanks!


> +	.lm_lock_expired =3D nfsd4_lm_lock_expired,
> };
>=20
> static inline void
> --=20
> 2.9.5
>=20

--
Chuck Lever



