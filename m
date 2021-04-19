Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB23364D35
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 23:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbhDSVk6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 17:40:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36292 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbhDSVkz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Apr 2021 17:40:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JLUnNW189013;
        Mon, 19 Apr 2021 21:40:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EGbTgUyJwRF/+xl7HZHt0Wc3Cde9AhXsN92y/D1zY7Y=;
 b=eVNu9zSX3DUdgny8eDpALAXp0xQ6lJW7rWiPqIxmBiD9aUDlwdCnA6JWOwInQyLvnU6p
 ZkCofE8maebue6e/k0PHUcXfrlqZ79SQ0CJV7mXpdp23izLYEHWU8Fd59vq8voNk/c8i
 D16D4AK6/Xh4LgG/ojIkirzSkzGqgf3Rr8xq/Jal14YHCPbDx9AK3r02vwBin30KoPvO
 DTx1O3LvTrLt6HcIjEVv+CCNJc0j/xOc/tOvz0f7KNdXr/ZnasGa7KyaA2XtpkrPTwFe
 uS51FMQjf3uuIdth0MyqeYZp5li6sukJXQ4ftAz/T2rbW5UHGEAFDz8Ye7/rW5cxlNog 6Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37yveacvdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 21:40:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13JLUqtX081687;
        Mon, 19 Apr 2021 21:40:21 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 38098p8buw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Apr 2021 21:40:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwbPG6vLUBTgqid/hgTDiIGXDaKjbD2HKbnMGJpUrIAY3Gd+xnHTQwGxJfAxv3686qhL9GtfolHxXmaTlTG2HmXSt1GG96rVPgGA3DF6FJ8zPSnbWTe2NRYDq+ZZeUTKLozNQlsnRgytR+QP/Hm2E5toO4yqSe3QjKlTBmvlRzwa+pmtwTYJGoa/jkgi+mlSo7QX9kTS4lE6z/DlP2LeZo+JD2LpXiY7q3cR67ucN5Zm6wU7A3APN9gULpsQZPEGqf7zbQ+yX/B3th6hPI74u4gTZv4Vb/6uRnwbIoCcOi/azsuVZUAA9d5rhehjePxDFbs5WHKrgyWnWmX4QXAA9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGbTgUyJwRF/+xl7HZHt0Wc3Cde9AhXsN92y/D1zY7Y=;
 b=jFgaC9ut8OzHXvYRlS4kUO9wpVWsasB2P5mrSUShP8q16niw9xC0TLM4UOSRewFIoLj0ocnk5dKBBsS+qk+k1/9pRg2r3jip4d3COsr9h5eiU+vuZjUXvhBBcHA5qqKN31kckc32lm5sZjYdD0cZabf6Z7l7pk9ctM64hdRQEHm4d0hsWN/RfnNuymRqdC84UZYEiG5QwqF74FDFFIOi/cUkyCcMB1RfFT2vbNIqtFyvVn30LfhumW9IeGQYvNMidCiavwTtJT1PBpajal9rdLCx45q42ZPsMhm8mElVEq6Desg+6wv/EA4oHSH8UKL4/82kKuOg2eYiI+PW9AJZMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGbTgUyJwRF/+xl7HZHt0Wc3Cde9AhXsN92y/D1zY7Y=;
 b=ZpANBTMidREKKYJv0dg0Yr5ikqrCPpCBaXAR0nNIQF3PyZ5aXfJQ/hIHW9nPdBiGJ+9J/FTnT2I2lO6Yc0VxKXWzMYntPiD+4ISrbKqmSoeAWYO/LmaUE7MJBT1QRBuQ12bOYmiYqygUMMeOEbgVD5mFhl3kHJ081btGjWPOGhg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB5471.namprd10.prod.outlook.com (2603:10b6:a03:302::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 21:40:19 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 21:40:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: Fix warning unused SSC variables from kernel
 test robot.
Thread-Topic: [PATCH 1/1] NFSD: Fix warning unused SSC variables from kernel
 test robot.
Thread-Index: AQHXNWQBx2D73VuHJEqJuBKG6jJsf6q8XmYA
Date:   Mon, 19 Apr 2021 21:40:19 +0000
Message-ID: <65AE91F6-1BFD-4936-9385-D75B7ACABDAB@oracle.com>
References: <20210419213556.75204-1-dai.ngo@oracle.com>
In-Reply-To: <20210419213556.75204-1-dai.ngo@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18dd8f0b-c923-46ea-85ce-08d9037bba5e
x-ms-traffictypediagnostic: SJ0PR10MB5471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR10MB54718F7298692C81AFE312BB93499@SJ0PR10MB5471.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:138;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VqZBLzXtq8DQRli6TyBB1Le42GnSLwJSzYJMTFkNYhBZ7EieLmRoDjVyAV5+EGdxaocPmmuxMW1DjHJdLOaVJrtO8uMyZglYRFHOIhyUoolZtq4XZhzedG1e2hKhyuLlPnKhdNK9wyegr5vuCR7LHKl8J//q4nhEaqJPRbGhgXko5kAvTJg8NtsB2YfdSU4dQQJFrVJWUjhmqWwV6HfFp2syDWQ4quGQc4El2ApOg1+AiHINNGm4p5RDz8L5Qw0gSXytXeEABvcDKQhYgB4OxOJy6DtG3qqSP1NfH9Nh3nILNDUG4x10iJbRm3tQgxSlyV5VXzOq0XlL1AiLPv4QzpXxEzgv+eVC6sOm5nVfuvo+7fRemfyz8RMJaLxyUxZFt9JS9TID1jX+1JqEICLqNVxBiCkV14AQzTkzbCUN7PI4WsmEyIUAt+Oxczszg5OqK3erKzKi1dTXJ3bAi8bZyaVMIkTNiEOK6eJzJ8dfE+hJusY9LQNncrVWx3z/YTclN3Z8EaMR7uhpeyPdRL5uxA8latyGuJv/wYulnBJ9tnxaQGIwUjrEIs8OUMxiOL/fkcWXdlwle+oR6orL/K+cmejBy4yqAo/U5nq2cqt3A/E3muUBeMa7rWKh959WDb/zRjQvTpMCOwOCnuv6J7wQCUN/DB0xiqDqB9txQHikSag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(33656002)(5660300002)(71200400001)(478600001)(66476007)(316002)(38100700002)(76116006)(2616005)(8936002)(6636002)(83380400001)(6512007)(66556008)(64756008)(122000001)(66946007)(6862004)(54906003)(26005)(8676002)(2906002)(36756003)(4326008)(66446008)(6486002)(91956017)(186003)(53546011)(37006003)(86362001)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x/QZDaz+jX+CGlwmeNrj07rE8jsll4+bi0YOtZ05oZ5yRlFRpzFFSnY3Iptk?=
 =?us-ascii?Q?9pcHe26cSgYN3OPHsLf2jWckFqDkcqDbPLsu7OiumPiodpu5fn7P13ksrbs9?=
 =?us-ascii?Q?7jwEH40HmqWiOp7N/b8obYwxYKdkm5AJcXnjP0FdeBhqYYtstHTzJdGsnNpv?=
 =?us-ascii?Q?SkIfGtKegJpO03gZD3bYiehY4X+ErFtI79Cmxoo9NeKmYki87MnC1fogPiTo?=
 =?us-ascii?Q?xDuS6ryhtPUDtMsJfg0yWNG3N3AoEF5LmmxSGkkDcKzxKwX6D4G2a8z1hLmY?=
 =?us-ascii?Q?HkncQe0dfIs2yoAOura3rwGbV1Dkdf3fDq51cwgxjilIRHu9QAa1gsvb+Rv3?=
 =?us-ascii?Q?L4mkgfiCvxZsE3Smu2jEtmnI53cLpVPlXJVZQZZgcA5y3FuFB1WyZTv/L9d2?=
 =?us-ascii?Q?hmUP0EPDF6PE2rEXbPa/xmU48LDRe+Zj2CcAtbFGaybc90gVVxP5xpRAlem7?=
 =?us-ascii?Q?/c0hxsnOeFUFJxPWJJxJuKLrPAqMVXq9bFHtK2WD+GZLKw3e1M/5bgZMjBn6?=
 =?us-ascii?Q?pwCV8RRy4uvYnOB2v6hjyVeGpIz1QoLm5ttK2INWcxfDK8IE5anfxvl8vnIx?=
 =?us-ascii?Q?11mH1ippBp/NY2W58dS+sbQ9P6bpn4Yk1od0GfD9WIV3SkJsZMieIfY/S7+t?=
 =?us-ascii?Q?CIkaEZ6IAuqz8bDXMFfebuCiBgUczP+rNWbjnlNFRE1G0XqPzzXean9y72oD?=
 =?us-ascii?Q?QBGGFz1s2800LHEMU4g+fBKYZHfjDm06+4oIqvV0hM5cPUYexYOZJP7P3GDw?=
 =?us-ascii?Q?OQTIUITLCaBLKKJkQz+UwV2cVJMVC/CAeSLITJ3CActj/4LYxfJTQUcsfDV8?=
 =?us-ascii?Q?nrXYX+EmvMwoFmW77P+Fwwyw8IRYMlQAHDcFdK/KYyW8CtTrpF7Cc6c8W+aY?=
 =?us-ascii?Q?whfe5O2kogcBOgGuPrS0YsKzdA6X/+cIf6yQeudWD7C7uLlxR8cpzWLLPfOj?=
 =?us-ascii?Q?A074WH6dxh9FK75NAy91ovhnGjBtXCG0Rw2g9BXjl03zBBiLqYD906oWH2Fn?=
 =?us-ascii?Q?3+qbynidyjVhPa42wWo0QmJWdpFxtxjEoSbXxRbQHNwnJ9x53/hC973rYKDm?=
 =?us-ascii?Q?+MPSs4o8AMG/YUFqM73w5FT6HPklrNUeWuaoe1MGT82YNjFi6NgWyAyOuUD8?=
 =?us-ascii?Q?rt1SXP1nqrP2elPOKNcgSH7bh6nm/fcbwk7ezK8OgO91p1rhUAPAp9AJ8tPn?=
 =?us-ascii?Q?CkDaQeUZdV6fN0TIJIJnjVStgTUNRM6MBY6zZ9nglt5XxfZQCHAuGefqpyLV?=
 =?us-ascii?Q?rIR279iwCI5JO9B0NfMEKuz3DqklvQqG3lgeibPuBVVn5WM/HM/6ujZDuaBw?=
 =?us-ascii?Q?21yjwi5crPGavNqv/kQuS0Gp8k7cQiHnfdPedM/rBPeKmg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC9D11825CBD324BB6B85225681E47A3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dd8f0b-c923-46ea-85ce-08d9037bba5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 21:40:19.1466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LWa8yx8LVAwxT2hA6MiYg8uQoKf8/hB3MaX3O7LTOeLCy+dpSrq89xXpuFwWkTiI8GHB4k3b/izlvVy96ikx9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5471
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190147
X-Proofpoint-GUID: DXMBXhmky4XutE-Gk_Qv7h8CpGpXtFFe
X-Proofpoint-ORIG-GUID: DXMBXhmky4XutE-Gk_Qv7h8CpGpXtFFe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9959 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104190147
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Dai-

> On Apr 19, 2021, at 5:35 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>=20
> Compiler warning unused variables when NFS_V4_2 is configured and
> NFSD_V4 is not:
>=20
> fs/nfs/super.c:90:40: warning: unused variable 'nfs_ssc_clnt_ops_tbl'
> static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl =3D {
>=20
> fs/nfs/nfs4file.c:410:41: warning: unused variable 'nfs4_ssc_clnt_ops_tbl=
'
> static const struct nfs4_ssc_client_ops nfs4_ssc_clnt_ops_tbl =3D {
>=20
> Fix by moving nfs_ssc_clnt_ops_tbl and nfs4_ssc_clnt_ops_tbl to
> under NFSD_V4 since they are only used when NFSD_V4 is configured.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
> fs/nfs/nfs4file.c | 2 ++
> fs/nfs/super.c    | 2 +-
> 2 files changed, 3 insertions(+), 1 deletion(-)

I think because these are client-side source files, the patch
should go to Trond.


> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 441a2fa073c8..400c8db05808 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -313,6 +313,7 @@ static loff_t nfs42_remap_file_range(struct file *src=
_file, loff_t src_off,
> 	return ret < 0 ? ret : count;
> }
>=20
> +#ifdef CONFIG_NFSD_V4
> static int read_name_gen =3D 1;
> #define SSC_READ_NAME_BODY "ssc_read_%d"
>=20
> @@ -411,6 +412,7 @@ static const struct nfs4_ssc_client_ops nfs4_ssc_clnt=
_ops_tbl =3D {
> 	.sco_open =3D __nfs42_ssc_open,
> 	.sco_close =3D __nfs42_ssc_close,
> };
> +#endif	/* CONFIG_NFSD_V4 */
>=20
> /**
>  * nfs42_ssc_register_ops - Wrapper to register NFS_V4 ops in nfs_common
> diff --git a/fs/nfs/super.c b/fs/nfs/super.c
> index 94885c6f8f54..a7af01bad344 100644
> --- a/fs/nfs/super.c
> +++ b/fs/nfs/super.c
> @@ -86,7 +86,7 @@ const struct super_operations nfs_sops =3D {
> };
> EXPORT_SYMBOL_GPL(nfs_sops);
>=20
> -#ifdef CONFIG_NFS_V4_2
> +#ifdef CONFIG_NFSD_V4
> static const struct nfs_ssc_client_ops nfs_ssc_clnt_ops_tbl =3D {
> 	.sco_sb_deactive =3D nfs_sb_deactive,
> };
> --=20
> 2.9.5
>=20

--
Chuck Lever



