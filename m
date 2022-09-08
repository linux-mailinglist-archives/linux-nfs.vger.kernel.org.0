Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD55B28D7
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 23:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiIHV5p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 17:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiIHV5K (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 17:57:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11513B13A
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 14:56:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288Kfvba002695;
        Thu, 8 Sep 2022 21:56:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Dbx6Neu8szm3ofDUojpAIVruASTwFTbjbdzjeXdkUHY=;
 b=ga5Cg/CKD2xknf+XrNgbJk3ULeBH86YHmzHsg+5+EsJsAbcAz4WeRWa6Tt326ngy0e8N
 rYnCxk1aTaYBB+pvhFZmOPFnuIki9C5HFeIgxo68HnptK3C25vMwLc6LYlCHi6Kc+4R6
 e5zX/D0Xw6SB/2RlJQZn2T6dpbYdbK18b+Jh/w1i6JEaw2pOEjNSXNcyeGqUIltKkMXR
 Dlh7KaYuTl/0H7OHmgRslEoXjmwE5Wl4qnCpvUysgcOn7s+VHf3cdFTPnJO4Wj9j5u/8
 dU+a2kJqIu69sYNaKETrLKo4z298RkIwAU6R39S6avmc3La0SdBF3MSlSygcyjcPis59 uQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtan20e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 21:56:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288IL0Bq006868;
        Thu, 8 Sep 2022 21:56:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6t39s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 21:56:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6RJMNdX7WrsCyWUxaX5QsBeFq0w+pf3KTEHIaSWRLe4IyisNm4gt1DzOo/ARQOT/bpFDKf7DcHByqE9sHukWpaLYg+dNRfRwvINPP9SS7Lz34XwdaoRQ7dZylq0rM5ZJeWD7lKOhtZwqRzTvA/yjM1JZAEia1vUW3ahweP0H8kXglmts8zRtPl2ewH9IJ8+JmzB70AI8XJFJ40gk5DIv53go/77nOgOfs07p2winBLA+fDNqDlv4U8+OoW5P1c5a5DkEY8jMmVQ3BP39kOZZ1HDoKmLbD1lppRRT6dcnmNYITjaV6nDXzU4iu9eSC0cjEqI3H7Oc5nYkTLydatidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbx6Neu8szm3ofDUojpAIVruASTwFTbjbdzjeXdkUHY=;
 b=E6m7aYsYEoMQFNPiVexvINfMjSd/q5BIzJLpP8e/3XKc7HmiH0eyn3g6y3y5WNT7UdzR9yciShhwLt4wQcfkENuIkBRuxnZa2BfQNoFsseItTBTW7L1Y8UnXkH8JuCG/YxTbbuvU+gGBwtkck/OzD0dQbxUGh89jYgGb5f9E71rqGufmrXoy5YXqGlh3kzph/CLu/m2kDYOfaTijhhO7G5N2mtCQBj8UcJRdw0TI0d0QeXbGqKzFreLgTWmXdqCP9k1CsR5F54MRKjiKxPlEfMypdnsdlZi/Yyg/dAhyJcMLH9XSuuv9ugLhAyKXHzVZ+xTXD2UcbOwXr7BqdxV8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbx6Neu8szm3ofDUojpAIVruASTwFTbjbdzjeXdkUHY=;
 b=MyhhB3SlAzD75K5dwy0U0ptKm4NgOCxhUi3VpHUhtdIUX+8QmTUDdRzSuTlVtDFPJ96qjyRDfKgfWvBCC7GrE0b07vOkS+HMqMRHbTFR6mpfle5gT2Dw3U4cqu3UHZeoOEETUiCcspXVyn9i0PHMMQkYTMtwn/EgWJ3+wD/HXFI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4546.namprd10.prod.outlook.com (2603:10b6:303:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 21:56:02 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 21:56:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: fix regression with setting ACLs.
Thread-Topic: [PATCH] NFSD: fix regression with setting ACLs.
Thread-Index: AQHYwyfx77joTMXnVUySUNNO2fuZsq3WFUIA
Date:   Thu, 8 Sep 2022 21:56:02 +0000
Message-ID: <CC08244F-518D-496D-ACDD-7DBA912C6AAD@oracle.com>
References: <166260292002.30452.4279820246560338475@noble.neil.brown.name>
In-Reply-To: <166260292002.30452.4279820246560338475@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CO1PR10MB4546:EE_
x-ms-office365-filtering-correlation-id: 5b26a7d1-48fb-4bb2-8b2b-08da91e4ec3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NsiREguH/qhBujSefQetImt5ykARjn11X8QhaJKFqm+TnYS5GXo+JTu3GvwA7NBPg7DvnQWUluKwXS9EwXItkyIHUaqpllrG/21DcGC0Di/fygSXlas0Bh0ZxQ4jYBRSoi7LfM+0Gc87eiuPUd2B7T2ly8jQdCnwq5bnDfFwZcIpcyOcfd/K5c/UzzZMHOKx2vR1p2m80HTM/2+/B9yqO3RnoOa7rl1pnAiJsAaP0XJth5JrdLzwuriUUlmQyTgbK9wHAC/UDUWB8/lpM8HTpCR7czemVb+WA/nozR9LGwFeQOb9X/dN2mulhnwwMClUAhVl+W9OzOLtiv+tW5rteIhzPu4g5FVyTpaNkTT3p9TCoOPAFI/8Pyd92LhUCFriHN1nvT1whVCpo+oD1BrdHToXNj1YZv9kJM0HkilthIQ/MJ+CIlgrF3k/Dl84aqWom+oM2/87yneJl2sM/cQqw6zZa0kJGm6HKjsLXfkNgcy/FKzOnbd4NYqybJX8DNPjj7Esc9gtBQ5wPk26/5TtOv0VpCw+cdSbM9bJWggHHf9hV35qKFH5xshKyZHsumh3SSt1XKX8+lr9d1Eskf9nr+KToWfXMVXY2H/qF3QU/yCsXz5/aJS2M+KmqVpWZltLa+4x0kCfmHIZJxnTZBibsgvvLmkmBcW5v7jtYtlEj2sQmsIU9pyLlJlYyqx0IEwjkXTGnv1vH5l/5hlzmu6eA6prMAh7hLL+vsXF2F2AIjF/AFub7X/7AFW7bC7zv9NuTfHGGYSX4/SYGBOKM771sEzkKO/iKnsh4UsQJ9avHMc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(136003)(346002)(366004)(38100700002)(38070700005)(122000001)(316002)(6916009)(71200400001)(54906003)(5660300002)(8936002)(76116006)(91956017)(2906002)(8676002)(4326008)(66946007)(66556008)(66476007)(66446008)(64756008)(186003)(2616005)(53546011)(41300700001)(83380400001)(478600001)(6486002)(6512007)(6506007)(33656002)(26005)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fkgQa2WTWB9zOdqrah+3wZnfyC+wSLJqEjloaPeUqgPwP9F/hcyHfI+By6ye?=
 =?us-ascii?Q?6RApFLkcwODipbK0HsGJ/3QkDHWPjftJBpQ45OHSCzfDGpmk7XsISbqlB+Ee?=
 =?us-ascii?Q?EekyP0U9/NcULaijAkvrDBAEf2+uR0E3Nhl9rInd5Khr7cE6TkGdm36GfeWt?=
 =?us-ascii?Q?hw2IUUzpEwVv24FsunPQCeMzeFHw9kMmP1a+/jE5atCs6/48SfcOAl1G8EO8?=
 =?us-ascii?Q?ScB9VpArC9ZrwrNW0g+oqXraZU9883IpT56MbQjMVETtSDvv4EJjXd3LQ5mc?=
 =?us-ascii?Q?EzxPiYBZ0UbC5FHMKMPyKDOvVor1nlLmWgJMPvL7gjUP19Y/FFOBDSVFiilu?=
 =?us-ascii?Q?N49rLPRhHHqPQHmmaRf9VHlgi/t/5EA6/tNH1BsUVoFqhKnSVB29Dy+A7shq?=
 =?us-ascii?Q?1asarTO8tHBv58HoJb4ZEM5HweIGno992206f0+TI+Yxsfz+5VVPvy8S0p3T?=
 =?us-ascii?Q?4499AJflNIWutUvLraTRUzIbmsyn6QY7gsjfslEnrC4M/4FJIwGu7rjhK5GQ?=
 =?us-ascii?Q?rGndI/v6FLxpT7PfsJKrnJ25IFeh30/e/78Mt5QF0ULxwdJguodK+KblxWbX?=
 =?us-ascii?Q?dhg2R/3Bo3h3EwiHeWPgCC6yMMaTum++u1SAw4yogBHDIlsj0cIv+c/QEY99?=
 =?us-ascii?Q?qjVy9pq/YKHG9f3Y7ZprQ7Lce/XL5ZVgLov6u1+h3Ic/OC/xMoqNc4dTeOku?=
 =?us-ascii?Q?hXbIrr1+BPQtQzpjR6LFTV+E53ZVxN/xx1sO/rUF5AkXYQq5CrSknklpjB9m?=
 =?us-ascii?Q?QYifzxDAqTDBMSr9DjjBfALIdsbhnRfuUpRzakZCbQWQw/Ku0W7PXj4H6fCy?=
 =?us-ascii?Q?KtmfUpfUAFpSYI2Maq8QwF+QeLoFdAl8aNaN+D2URuHuk7GGfqcNjVKcNJkW?=
 =?us-ascii?Q?ntemHKvsFf1epw/qM1lreljpzOmzucJcZ2mCwPaz3TSNkNmBFkmSlBK1Msrm?=
 =?us-ascii?Q?2V58vhHOdXzepHx25mwrSwHB/mALq2iL9y4ju6MBwyVtQfPFU429oE1SjWYW?=
 =?us-ascii?Q?/I5yYdUzLAN18PmVRW9Z/5yBvUhF9LCJO7WqTvxzntanlNzdSs8SLJbn96v6?=
 =?us-ascii?Q?aoaUO7AjjfoBn2QihQqonrIeMCP9ScQ36ZZPuZPd1wWdLiL1zw6fjeoZFeGv?=
 =?us-ascii?Q?rZ2AtmSR1yxHIzmr64d5ybyodBO3sR/XoqO8JmVN2DnR5AoGSsjWxhXMB5DI?=
 =?us-ascii?Q?wEA2jIihqufdkIpbLpFHcil6lJzOJtHdzcRmSy8Fj3hHljPbh+Audj0iGHga?=
 =?us-ascii?Q?v3s+Ub3F2exafxuWtq7NwII4JsN7qEtRWuvVmFFhQidUouZkEtbA/QC6CYAW?=
 =?us-ascii?Q?JDoroT7RD7u5ElQoKPdG+NIZvYxYHxp4MPureYrFRIAnNbZYJO+T/Mijrj/5?=
 =?us-ascii?Q?JBrcQT6Ee/PH3mevrLJ11vgo7YMfDr5pt9kj6e3Wh0/KXK+hlka6i8xhTsGb?=
 =?us-ascii?Q?brigu5F2B0WDvLHpMq6evvRv/YWMNEXszP1l75htTQw2nykJGK7J3SKLTpx+?=
 =?us-ascii?Q?/lGY3dwSv4E9e8NHp+jgbZLBuKgA5hEjf93l6wy9GJwmGdhchpU4iMsZk35n?=
 =?us-ascii?Q?EVKeLWOnFmEZpqq20uy/dw2Dnf0e6vNXUl1NQmThN9QHpwrL4wxGDPjEQYiL?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FB41F466085A34BA69B5F5D4CEF6710@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b26a7d1-48fb-4bb2-8b2b-08da91e4ec3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 21:56:02.8151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBNi3A4qv+ScUnV41+AFqQK2oEjVP3u2IIRYfy00I8HAknFQqGxVYus+djgWZUf01qsHjLZZe5iJi7Er4TIZbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080078
X-Proofpoint-ORIG-GUID: liLAe7gYoxaTXkeHs-okBYPvjsGB7GN7
X-Proofpoint-GUID: liLAe7gYoxaTXkeHs-okBYPvjsGB7GN7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 7, 2022, at 10:08 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> A recent patch moved ACL setting into nfsd_setattr().
> Unfortunately it didn't work as nfsd_setattr() aborts early if
> iap->ia_valid is 0.
>=20
> Remove this test, and instead avoid calling notify_change() when
> ia_valid is 0.
>=20
> This means that nfsd_setattr() will now *always* lock the inode.
> Previously it didn't if only a ATTR_MODE change was requested on a
> symlink (see Commit 15b7a1b86d66 ("[PATCH] knfsd: fix setattr-on-symlink
> error return")). I don't think this change really matters.
>=20
> Fixes: c0cbe70742f4 ("NFSD: add posix ACLs to struct nfsd_attrs")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> fs/nfsd/vfs.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 9f486b788ed0..bffb31540df8 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -353,7 +353,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> 	int		accmode =3D NFSD_MAY_SATTR;
> 	umode_t		ftype =3D 0;
> 	__be32		err;
> -	int		host_err;
> +	int		host_err =3D 0;
> 	bool		get_write_count;
> 	bool		size_change =3D (iap->ia_valid & ATTR_SIZE);
>=20
> @@ -395,9 +395,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
> 	if (S_ISLNK(inode->i_mode))
> 		iap->ia_valid &=3D ~ATTR_MODE;

Thank you for the fix, Neil. I've applied this to 6.0-rc.


> -	if (!iap->ia_valid)
> -		return 0;
> -
> 	nfsd_sanitize_attrs(inode, iap);
>=20
> 	if (check_guard && guardtime !=3D inode->i_ctime.tv_sec)
> @@ -448,8 +445,10 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> 			goto out_unlock;
> 	}
>=20
> -	iap->ia_valid |=3D ATTR_CTIME;
> -	host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> +	if (iap->ia_valid) {
> +		iap->ia_valid |=3D ATTR_CTIME;
> +		host_err =3D notify_change(&init_user_ns, dentry, iap, NULL);
> +	}
>=20
> out_unlock:
> 	if (attr->na_seclabel && attr->na_seclabel->len)
> --=20
> 2.37.1
>=20

--
Chuck Lever



