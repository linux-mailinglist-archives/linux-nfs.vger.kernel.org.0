Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76267493E37
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jan 2022 17:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351854AbiASQTB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jan 2022 11:19:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20910 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346196AbiASQTA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jan 2022 11:19:00 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JE42KB010647;
        Wed, 19 Jan 2022 16:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=k8dh32Ritnzmk2hdmQewQZTi2qo17f464Fb7HgR9kcQ=;
 b=Zjrb5F6fn6HgsorY6WWyDztIu0uQrxLvNluAoTlBksnbrmfVUhn4BqMJ7CxFmiUxzLei
 UZLFai+NJO1ABQY+v+Po3coWRoObFFmr+CfFJvKPfWoPTfoyM9T4SjicDIQYQUUQMlZh
 LkjwP/m2YjrN+SMxLGh866TS37BpJyDZXkS+8cpoTP6eLi7zSKesdP3xhLnNKlgkKQ2r
 qTbnylK3leJ3v7HVfvGZJJmXIA4egaVCjAzIZq2brNzpAaMWGLQhFD9dXOWnqH7omCWN
 N6eVYSFvTxZ6Mzq4EQpWT5NSAQVSVgDsYETk61l36wfsD+vfzbv3v/XYL/Ot+eMhXLN1 aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52wkex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 16:18:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20JGGcFi052510;
        Wed, 19 Jan 2022 16:18:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 3dkkd0kgcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 16:18:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX/jeU18jD0VzTy7I+C3D0RpFUoL78+FrxqG45nIQqEDms9yvBaMi4Pp1UZmw8zhx5ipuu4ju3E4osPlmAbSy36jHVHby+trAcBbVFhqp39N6F2uGHBFrkVlj9R3HFa9yQrG671Bs2iQTV3CGQSqxhlb7RUUYaJc9MiCUE5JjbVXH+phXT1yMNOHCf2SSlcmGqaUCLpxyoNJUb40x3JfmNoRSQwWzTIU6QS7RfEzolqbzqUvyKfyWfk1fJDxdzFvF2rbtjHJmLY2ADMfFNt+Zw+arseIWyt4+VMZKf91gEdJ5EvLpRO8+dipToBDpsIGtV7zaEnkEvC5j7vlUw7Gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8dh32Ritnzmk2hdmQewQZTi2qo17f464Fb7HgR9kcQ=;
 b=XG7EwrFJosqHlgieMdAUL0zEPpe/lxvTSGIvArrrMAuY+qzGHYjV17twZ5xM4662rjbPwEdck339ThwEExGSp5eifZ4we1gZDsoVWDZlEvAHPtTuG8VRoMxyy5y/wUEOaOUXtesYhC1oiwlfkQYnxklhYIGl9QmRvN4NsjGugYwh+RKLJN0Dq9fGJrQx4BeID+IjTBRrzMefNh+/dMExRJTmaC6kYK+qkeIzqF+L04IniCi24Bqv4ps7x9IAgJn7qsN/g1oDOk/t+Q6eVpviLaOQCYhfl84ds2ihvcEOo/Gq3PlYJEZvDF4NmQJtOEPlxE+vfpMrx+R3jOD++ZbSTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8dh32Ritnzmk2hdmQewQZTi2qo17f464Fb7HgR9kcQ=;
 b=c27XDlbHCTvPE0i7RL3xrr/w6WqPl9OW9yAacKd58Csfiq+qRlvkOCtH/68JJMoS5XIgvztnyNfa/XPdYSOAbsNRYedILV+w+KuePpkKb7V539XmYxQxPMtk3amRvt+pKwI4ATmdq/GW81/WoWXhMvRLJVLJS9HR+xt0Vn0uQUw=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by MN2PR10MB3232.namprd10.prod.outlook.com (2603:10b6:208:126::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 19 Jan
 2022 16:18:11 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.008; Wed, 19 Jan 2022
 16:18:10 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Jonathan Woithe <jwoithe@just42.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] lockd: fix server crash on reboot of client holding
 lock
Thread-Topic: [PATCH 1/2] lockd: fix server crash on reboot of client holding
 lock
Thread-Index: AQHYDLbN5l3eHxKrf0S5rkJdvCtsdaxqht8A
Date:   Wed, 19 Jan 2022 16:18:10 +0000
Message-ID: <6349BB98-FB18-4ABC-A893-1CCB1E5CA3E5@oracle.com>
References: <20220114103901.GA22009@marvin.atrad.com.au>
 <C7A57602-4DDD-4952-BA38-03F819DBD296@oracle.com>
 <20220115081420.GB8808@marvin.atrad.com.au>
 <927EED04-840E-4DA6-B2B1-B604A7577B4E@oracle.com>
 <20220115212336.GB30050@marvin.atrad.com.au>
 <20220116220627.GA19813@marvin.atrad.com.au>
 <1E71316C-9EE8-4C71-ADA1-71E2910CA070@oracle.com>
 <20220117074430.GA22026@marvin.atrad.com.au>
 <20220117220851.GA8494@marvin.atrad.com.au>
 <20220117221156.GB3090@fieldses.org> <20220118220016.GB16108@fieldses.org>
In-Reply-To: <20220118220016.GB16108@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ddb9f65-8bac-4d20-11dd-08d9db674970
x-ms-traffictypediagnostic: MN2PR10MB3232:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3232B44EA1A91D18564DF12193599@MN2PR10MB3232.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OYoEr3ehvagb2XIEooETqoCYZrjSbulj5Xn5V79xmgGf7eIQ5XJovFLy47O6YkJx2zvLMe3xbBgclF4z+TQ282lt0J3ITa6dnZExNohE8zkasZbAuM7tmpZeXQr82aV8NuvHHjrQJl8ZG340qM0znCvedKDM2NguIQkSW+PCnvncfiq9A4vXO4xGoyejnPq3S/LQfYAKOphsnE03yXVoeGPdSVMBMj3GXMz0aFZvkmtNhizbUnFnF88Tox/d+5hNtEcddwvuEThvwzr0UVeCkkCHBHa/dLtumQ2L3SdZ8344+lkxRfLD8cQEknRriAz4xNvhf6t8aUSveSX5fKHnAAv2LVbe/gKeOyhNUkYVWjivihL0sE4bL3f9/990crcY2tWADEUxoxv2sAqWG7219oQuSndM+r37/Hk7SWYAew0JyYUzWNDkijPMc8Ull8nEnsSeujgpThry09lRWd1bX0/C9CHVtYV3zPEliVgl5vK7/OUY7tE7ofoIX36/oc38+CZb7rQYXEvO3ykL94ipXBU+vblGtinedjZlE/zTKqqRY/6hoZZtagIBmwQcN5Vj2Vm/q+AJ1rEF2+j5Nz+GbyRYTGFIpTMI45FBamkOIGfX0EkqKcnGEUlp2SbEnW8cnkBRFxmxa/TbYnPPv3g1AUsHNwEZW7HkWa/Fw4vaKqHLaM6kxMbBWA73D2D8rROV5FzVvBtOuo0tlxSXa23Y7KwH2EKtBdvInVGfrMuOndQrakSI0fovaApXAVqXaXkY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(71200400001)(83380400001)(53546011)(54906003)(5660300002)(33656002)(6512007)(66476007)(6506007)(8936002)(38070700005)(2906002)(4326008)(316002)(36756003)(186003)(26005)(38100700002)(2616005)(122000001)(76116006)(8676002)(6486002)(6916009)(66946007)(66556008)(66446008)(64756008)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qWjfwlczhKG6l3vPSBsI+YnArihvqWp6g3U/uI1eaeWvR0OHk/4Zurebsh9P?=
 =?us-ascii?Q?yzTLUIWFJCj//tKRRsaSF7NjNBc6GjS0fJX7aJhq0f5fhM6ugfsIa4q0deDf?=
 =?us-ascii?Q?i5TGrjybVEtXsNp2oXLlS9RO6JDYkI70fMnw4LykylCoByaVclqVIZuKzm5h?=
 =?us-ascii?Q?ciIkQFcthgweN+E67EHzE75hRmc980xSrbUmyfK48gn2jzW9p1B7HlY6YJWR?=
 =?us-ascii?Q?Q1MVRhq3hhLptYG/Hbf3EtY8C0ie4q1wk50+2t6UAOMquAdtyrNM/4RrcIWe?=
 =?us-ascii?Q?VYz3mbrv0N7DEYiZeectHivSzpVdB9HLOl1DO7bBvfdxR1wpQUuYjqJwtRPm?=
 =?us-ascii?Q?uplGznh/UNkQ89Ua+q3I3zVKeg/jX8kc+3/udg+iSASbxWY2t3W8+Is/pYk+?=
 =?us-ascii?Q?UOehyjjPyn/i8XOH5iSDXnzLcMWQhT6W9SwQPSaj/wCijy8PYtS6efHjBm/M?=
 =?us-ascii?Q?Jhgc5Lk02yFiWicNzRzsdEmHIXzF99q/cgvNx5V+usWtnQh73ne0KpfOrIJk?=
 =?us-ascii?Q?ppzPSLmNUlkj62nE8pxG0NE8IwhB7eTuzkyozIuqfDesQF6pDAT5nTEGpiMV?=
 =?us-ascii?Q?2mbWP/PRTzWSgpZHwUrvCbuVYu9S7ketm+5qHhWu3ZAAaYNXmBDF4fe4PKCR?=
 =?us-ascii?Q?S5PdUuMiM+s7GGhenZS/804Ag5bX4UVbpNSXduiGJQ/KUU+/CVoOATF2xpX4?=
 =?us-ascii?Q?t08+Sp7rj9OouXit1ff+qWT2Jsx7RhZ2Qm6Queo50LqDBV6IzAaZ5Dxz4a3q?=
 =?us-ascii?Q?TSiDK+Yn8mMelIDoz0BqQk8+qL1gH6BAYHCaNFFbp1VlfhadcGPM1QN+DLFv?=
 =?us-ascii?Q?HirzyQY7LwmkRbP422o4k1ec3UwOrjH2mTLLs/SMkGHHHda3Fy2N1s3HBxy3?=
 =?us-ascii?Q?BWVoUw67mGaz6UqqiIkEkNi7vk1m1R+NHQ67swmnXyHgIaTd005DIb94i7z4?=
 =?us-ascii?Q?nitwHg//LGGV+QdF1aVzGSkPQ5aNS39l5+IxobViVsFDZu6tStwa4otDCm9q?=
 =?us-ascii?Q?h0MrD2RfF524Krgw6/TJJm2p0V8a+zn6+zCC7KxJVz0erQPJXyI3j+6+yPez?=
 =?us-ascii?Q?Q0iFMszymcUtFZkGJyJoJl3cAUyW2DNNM2CSWYGcRRu1A4ucrTjAdToNupjr?=
 =?us-ascii?Q?6hGbiewkDS26vDYyDI/JtXVBBubW5Q+ul0GX1uF2rGm07ulSGiWCFISSX6Wc?=
 =?us-ascii?Q?R98TWRzxyXahnZTpdjnDgdy3UzMWgixv7n9SO3fazctqH/wxra5gfKvTbj8R?=
 =?us-ascii?Q?XmEqb3RBT2pdoqbs2spnB1oLWJgSWq9Ybvh/UM4WwXweOFoKFE/4uoZZATwY?=
 =?us-ascii?Q?ZMCuT0ulc0Xa1h7S5q3EBUhmSQVJ6+PGEGoV5Zhib8heUrz3Z09ZkQXWGT+2?=
 =?us-ascii?Q?O7IhK8AB52Rg2WmWpbhyiS+Cx83Jr4n6fMPAm2l28DCRJZD7s5+ooRfBcWQL?=
 =?us-ascii?Q?6ExBV5NadtQ8QZon0eEk+0rKJhAh4kXeP33EIaIIqqF/Kh/hGUk59FilpJRd?=
 =?us-ascii?Q?6s5oeMt/2/FCjo+dZdxKQmPzpBfDkiz5gHgNtEVn6B8bzKeXLGr0gr43i+kS?=
 =?us-ascii?Q?eYXvX+tJ9aZElkGERu2+ADLw/nfIV107xrdV6v5KfbHhPBn8nicBhGxkN1yh?=
 =?us-ascii?Q?tqW0sA5Bn6reaJVEvpNYi4I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3840395BEB22B94DB7B2BB93ABFF0115@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddb9f65-8bac-4d20-11dd-08d9db674970
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 16:18:10.9050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpkU6VeZZoEp6klfBDG5AxK/wZI34D7j0p1OI44j0+Sh/qRy/+hA4XAkaGJL/lfj4Hr/bBt79Jll8B7yHwDWHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3232
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190092
X-Proofpoint-GUID: V29crvpbN5ZYx2oqg2o_evRyxfk4xJT3
X-Proofpoint-ORIG-GUID: V29crvpbN5ZYx2oqg2o_evRyxfk4xJT3
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 18, 2022, at 5:00 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> From: "J. Bruce Fields" <bfields@redhat.com>
>=20
> I thought I was iterating over the array when actually the iteration is
> over the values contained in the array?
>=20
> Ugh, keep it simple.
>=20
> Symptoms were a null deference in vfs_lock_file() when an NFSv3 client
> that previously held a lock came back up and sent a notify.
>=20
> Reported-by: Jonathan Woithe <jwoithe@just42.net>
> Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
> fs/lockd/svcsubs.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index cb3a7512c33e..54c2e42130ca 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -179,19 +179,20 @@ nlm_delete_file(struct nlm_file *file)
> static int nlm_unlock_files(struct nlm_file *file)
> {
> 	struct file_lock lock;
> -	struct file *f;
>=20
> 	lock.fl_type  =3D F_UNLCK;
> 	lock.fl_start =3D 0;
> 	lock.fl_end   =3D OFFSET_MAX;
> -	for (f =3D file->f_file[0]; f <=3D file->f_file[1]; f++) {
> -		if (f && vfs_lock_file(f, F_SETLK, &lock, NULL) < 0) {
> -			pr_warn("lockd: unlock failure in %s:%d\n",
> -				__FILE__, __LINE__);
> -			return 1;
> -		}
> -	}
> +	if (file->f_file[O_RDONLY] &&
> +	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
> +		goto out_err;
> +	if (file->f_file[O_WRONLY] &&
> +	    vfs_lock_file(file->f_file[O_WRONLY], F_SETLK, &lock, NULL))
> +		goto out_err;
> 	return 0;
> +out_err:
> +	pr_warn("lockd: unlock failure in %s:%d\n", __FILE__, __LINE__);
> +	return 1;
> }
>=20
> /*
> --=20
> 2.34.1
>=20

Hi Bruce, thanks for the fixes. They've passed my basic smoke tests.
I've applied both patches for the very next nfsd PR. See:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git for-next

--
Chuck Lever



