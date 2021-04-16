Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3512362862
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhDPTMK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Apr 2021 15:12:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38850 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbhDPTMH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Apr 2021 15:12:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GJ5k93016367;
        Fri, 16 Apr 2021 19:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kXVDo+clivxliWG5iLn0DTlNAWF4vZ7A7HBTLOXHid0=;
 b=oDBAf72pyzAbmhpgEgI9/hPdrky1no+LkQxSOBVFT0bn5L3AW4eiTswx+sPY314mPKye
 U6N2C7UiTMmcX5hrBHu4St2EE3Gfy3bSFZ5YvpprQGHFGRvT2Vue+ze0z8WGBAeLzgM/
 PUfUHOnqGZ491HniXd2xbkl1pFYwmIHzWHydLY5SIXhMux8js0DRljEZ3G/iwTXjuwG0
 FDTs+F/YhYAnII477ersm/qr5ukg7DHI4rTMCwgpxKEkMnK0FuUBgSsRCBdfvi3ulAGt
 3+UCINuMJq5tyNdWjLEkkyasrHQIa8SCZHP62ALIMW+6s95W+KWMFZXZru9JwfwG7CID 7g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 37u4nnt2kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 19:11:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GJ5qj5136050;
        Fri, 16 Apr 2021 19:11:38 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2050.outbound.protection.outlook.com [104.47.37.50])
        by aserp3020.oracle.com with ESMTP id 37unx4wrbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 19:11:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW6SfiWSqGGbx1Q1wrrY9tZBxqbyxsmE/cHAqqrOGaf96bO9nanMoQQxoyVDoDMyF/vS9xB7qKPGb94WGNJIFY8cv1ZWpFhzxYauviF1oFY7mxHN476Fjz5K8XxoVOrCAdUNrNtOVza2PSL7QfJ8owF5jukyRgRK/7dqdsQnJlBieyGSWanAU/Ry9xhkYphXIYKIYw1iUTDxkN+q7xOwGbJAiU9/kxxEOABYs/r91I/FdmOCngUyNd74rGngZ0f0ryh6bQ94NpA+P9356k5z2V8v+1A71zpy4UOe//9kx0eQJKsVFI7eK0PRSy5gqsRxRkw+mWmw8n7WtNNjXHgWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXVDo+clivxliWG5iLn0DTlNAWF4vZ7A7HBTLOXHid0=;
 b=SUbkOXcYF2FRp1XulqZanB7Vuwywmqr1vqcYUsMNuQjIFkv70vTegStbrpynoIfvWYo+3ANhZ6ahr1g/80rmWstmvAqEK7wZz08G5XdNaLchDvpg4GawOqW+5hYlKG3+XUVAxucRu7kFBwSr3wh9WscDMlvva9KLVDCsSBsO4AAzT/0lQyusHiPzvo6mbowwnOWdfziVfRIHtqyTrxW72XWpbIPzZkZdCeEVoeFgVcwxbefhuJTrxCey9UizeqlvUI1XrxxW/EYFyjp258PZjlIvFFszyqsvUcC1FHyr/NwL7l8w4qS2tX/3+NwBrD89GxwNWpOu7mRTOEisuRkE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXVDo+clivxliWG5iLn0DTlNAWF4vZ7A7HBTLOXHid0=;
 b=X5y4YGR08zF6hLkHiHHzAOmU2exGVbb+zBC1TQ4SSGURG5V0ayzfS3CHEgorDv/41fG70B0v8wmjHkeBMFebIsMczhdjs1xZEF1I1BoEHe9uIsCOxGsDJKbVPAq3GMEPy2SKD240pjnXLQqEYfN0egGm3+T7o9KUbLlPrAGZwsE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2760.namprd10.prod.outlook.com (2603:10b6:a02:a9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Fri, 16 Apr
 2021 19:11:36 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.018; Fri, 16 Apr 2021
 19:11:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/5] nfsd: ensure new clients break delegations
Thread-Topic: [PATCH 1/5] nfsd: ensure new clients break delegations
Thread-Index: AQHXMupj8yPyCxQuREas8WmnEN293Kq3gs8A
Date:   Fri, 16 Apr 2021 19:11:36 +0000
Message-ID: <742D63C9-53E9-45B2-9604-C8DBB42EC810@oracle.com>
References: <1618596018-9899-1-git-send-email-bfields@redhat.com>
In-Reply-To: <1618596018-9899-1-git-send-email-bfields@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efd3f806-5836-42e0-b6c2-08d9010b7505
x-ms-traffictypediagnostic: BYAPR10MB2760:
x-microsoft-antispam-prvs: <BYAPR10MB27609439E6C3BF8D2A5636A4934C9@BYAPR10MB2760.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WFhlZTDEAcmJA8Nhr5t5f5sbEZekekRvkqoUmJrPll63Y0nkg+wA7NvhvA1MyW35rHpRQ7EK1iP3VM+RT7RCwrkwGR2wwNuwL+Z4A+mJCf3Et1BK5ewyKLj07ldn2cpVYQxjzLAOy0WjL0+Q+LrfRwMFa6srgplXqY8z3pZUOa6D2AlP5zCpPlpZkCI2BOPEbvEVRKztawaHCX/i2BZtcZsBZz7CAGm66ZDSUzc2QTZESTTvgjYq4YV1o9XB5Uh9XYP1++EaT4ugTe9p6z56lslOP5GQWzwB30JeXpaYqaC9ou8hGjIaFIUDBLDPhC6k8sNA7TFbnpFN7wY33to26Z1j+Da458HxnL7EwpuU4UHjeGILe+BhxnzuR2rF8xmGPSaurDxsi2WUWDbN97bVnSmMmyyRnyynf6C/S6FwgkrMK+E5ARljzB/uDBbl469/AR7vfIT+ICclUArssVn9ks/WZYSDc+O9UZpos5dREc3ySol68V+oyHTe1kYuqlfTDSk31/EA4U4tZPVImq4eFxNgItSMRfaEO789CaZ2k3GTDLfyKh5abD4aRz2BtH7//R5BfDRzvUtTkXjyahw09B4ECoIL68fL2A7ItuAf5JbRoDP8uXxAZ7DAqHx8d1o5Xr7hbyn62lSWUGvngDl6h0d9qyfTIp+cLwf3Rmzderc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(5660300002)(316002)(6486002)(8676002)(83380400001)(6512007)(36756003)(6916009)(66446008)(33656002)(66946007)(2906002)(508600001)(86362001)(2616005)(186003)(8936002)(76116006)(122000001)(71200400001)(38100700002)(6506007)(66556008)(91956017)(4326008)(66476007)(26005)(64756008)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KfS3sz/Qy5HEVKI09xaW58zoVpPEeRBT1kbumOpTr0PCfVmpnlq+00h5ABae?=
 =?us-ascii?Q?pbwKOURhV8VJBWJQZVx62YTKeZc270Kqswzfi9fZ9UFtEHTdlOO3HExc/WYG?=
 =?us-ascii?Q?KF+XpsOVTBZdv42ith4pLUoO+HbdWidvw3OEvZ1LKRdGWpWRSKZn2gKXPfOe?=
 =?us-ascii?Q?G+72p0C7KC0BVbH1x7hk5nzriw+OMnaVkGBH28gZg92ycwaYjFgF5jEVxINI?=
 =?us-ascii?Q?RBzYDPuLOXYmE90ed8d4ky5eGUd/pREkf8I+i5oRL7kwn/kXOc1J7RgXxK2e?=
 =?us-ascii?Q?0S176cMdLrNkDtJshBSFWddq6kbwZbT+Y0N8sOSuyMXkXGnWlYph4g+LK+7q?=
 =?us-ascii?Q?G776J7JOs6RfZg/gmKIKS4WAkEnY8iudDTPyIf4jg6qvvIg2bAS5SKQ143W3?=
 =?us-ascii?Q?wTIGvrARUoV97DGz8miKsbYHIxDPYC6eZtI+de2TzwY9GzR1uqkxVPtnUPE1?=
 =?us-ascii?Q?BYM3IOLNF7kLTi9Pc0RIoCkXnwLzDiXlmqed1IoSF7oe0RqsH+MAS7VODokq?=
 =?us-ascii?Q?/yzmpIL962TxcCOLlwdHe2he3w0RuwUKBFMg8XeCwV78wjh9yClxJcxKGEiM?=
 =?us-ascii?Q?UVpu8xyiRWY7//iAvKyVGKiK8TR/bp9fo4Rgd08CCJ4DLHQbVzjMU2YmK7bQ?=
 =?us-ascii?Q?ZgUwbLJJ9V3hZbNtmLQTQSMVKCTR4jK3R7Y3VbEHmcBaoAMDqgozUxsUbNSO?=
 =?us-ascii?Q?eDaZiFjaJYb32lFu0vtVC3Exw51eWmj9yNq4uhhTDfQxZOQ9ALyPFye0KbbV?=
 =?us-ascii?Q?kOuVOf6qGIyJwxb5lqQwRM0wP4+2DVEkHhZ8dbPMZ1ybVsg0hYQD6ccgrDKL?=
 =?us-ascii?Q?+lBgvIRBOooKMAG99QE3Nw1UsqPLrs+TeFnK0JL41wR0ncfzjB27/cVrA2MG?=
 =?us-ascii?Q?mwMa1NvCNb5TpwxYvs2abEojifNcRkWbJ2VV23RxQlH3J9xyURRmlqC/5+xe?=
 =?us-ascii?Q?C1oaG76rdSbFxMr8Qq65IBRjP1+was0qh/4uk+hYK14Q9L9EJFaTF0sDQp/J?=
 =?us-ascii?Q?DVHvLI9wg6QkZ1P+I3+my271GQkSgVp8xeWMudyHb0oSFjppwz6sHXK1iujZ?=
 =?us-ascii?Q?IMFew4kFSXr4v5oscd1OaS+UE7bTuUI5JjWmexSWM+8J0ksVf0fyJHssmL3d?=
 =?us-ascii?Q?3j3qrvRPHUgw24XLZNH7FXPznv4rgsdIXX0sQ2SvE3VfeyHBs1bQr/ownXmp?=
 =?us-ascii?Q?64g2VMmsdGF0FwKfn+1wH4o4pU/r5CzA6kV25mJjHNGbzaquurAngKHR+CSW?=
 =?us-ascii?Q?QBeGy+X0OL8y41JAmZOsmuw3EgaqFbDQWzypYJ3SaOwlvsD430OXC/LUulNY?=
 =?us-ascii?Q?ByMCVRXb6sEawozvug3jUC2qPbjsXd8Co05sVUlP67COsA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B723AE35CDE97148991327E11898AE25@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd3f806-5836-42e0-b6c2-08d9010b7505
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 19:11:36.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t/iYoWDCMLPnXc9nRlXql4e4XFiSLjnvrdiDHzzbJYBUxPmmkd2YDOLL1+Ztl4UebUaznnU+sWz4dM0qSyjsWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2760
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160134
X-Proofpoint-ORIG-GUID: 4EaWxO_pG5gQPciVA6lkN1VToaUAgGXv
X-Proofpoint-GUID: 4EaWxO_pG5gQPciVA6lkN1VToaUAgGXv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160134
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 16, 2021, at 2:00 PM, J. Bruce Fields <bfields@redhat.com> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> If nfsd already has an open file that it plans to use for IO from
> another,

from another... client?


> it may not need to do another vfs open, but it still may need
> to break any delegations in case the existing opens are for another
> client.
>=20
> Symptoms are that we may incorrectly fail to break a delegation on a
> write open from a different client, when the delegation-holding client
> already has a write open.
>=20
> Fixes: 28df3d1539de ("nfsd: clients don't need to break their own delegat=
ions")
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/nfsd/nfs4state.c | 24 +++++++++++++++++++-----
> 1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 97447a64bad0..886e50ed07c2 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4869,6 +4869,11 @@ static __be32 nfs4_get_vfs_file(struct svc_rqst *r=
qstp, struct nfs4_file *fp,
> 	if (nf)
> 		nfsd_file_put(nf);
>=20
> +	status =3D nfserrno(nfsd_open_break_lease(cur_fh->fh_dentry->d_inode,
> +								access));
> +	if (status)
> +		goto out_put_access;
> +
> 	status =3D nfsd4_truncate(rqstp, cur_fh, open);
> 	if (status)
> 		goto out_put_access;
> @@ -6849,11 +6854,20 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> static __be32 nfsd_test_lock(struct svc_rqst *rqstp, struct svc_fh *fhp, =
struct file_lock *lock)
> {
> 	struct nfsd_file *nf;
> -	__be32 err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> -	if (!err) {
> -		err =3D nfserrno(vfs_test_lock(nf->nf_file, lock));
> -		nfsd_file_put(nf);
> -	}
> +	__be32 err;
> +
> +	err =3D nfsd_file_acquire(rqstp, fhp, NFSD_MAY_READ, &nf);
> +	if (err)
> +		return err;
> +	fh_lock(fhp); /* to block new leases till after test_lock: */
> +	err =3D nfserrno(nfsd_open_break_lease(fhp->fh_dentry->d_inode,
> +							NFSD_MAY_READ));
> +	if (err)
> +		goto out;
> +	err =3D nfserrno(vfs_test_lock(nf->nf_file, lock));
> +out:
> +	fh_unlock(fhp);
> +	nfsd_file_put(nf);
> 	return err;
> }
>=20
> --=20
> 2.30.2
>=20

--
Chuck Lever



