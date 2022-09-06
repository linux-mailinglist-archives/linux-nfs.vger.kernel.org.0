Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D3B5AF056
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Sep 2022 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiIFQZb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Sep 2022 12:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiIFQXU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Sep 2022 12:23:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9965CA59A8
        for <linux-nfs@vger.kernel.org>; Tue,  6 Sep 2022 08:52:30 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286FY5Z6031662;
        Tue, 6 Sep 2022 15:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sQHYeWn6TdSjbRrH0xBRFp+8d5h6EK+UKK1G3wYExos=;
 b=JUWGiGdCGKjD/BAs3ND9gnogr6IEhabW0aiQR3r62pb4bfv+zaA+yGUwA5rGnljffZTO
 Ly1CZXqD+iq4qEiUPfgmmZLKwQNu+qaOSdrp6EgRmHBzcW7UtJixhvil4Sx6Ooa+p6Y2
 A5yuFMtmJkLlxSQcVKKhbi/qZcpxly1XEmJQnF+yLo8SsxTIeF/WGjX6gHQg1iDq3xlJ
 DJAVQNBJ9A5SlmqGGsTGbZmDw+tUc8kdmt2DkI0mc+ctZ6uZD8VuC4dpata3DWPnTd3c
 BXJZnjN8JQ9foge0ph6XTgmWPVBT/B5RPgqrYiIXzTaZ6CBvkape2nvg6zJW9IYlpuyO bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc68ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 15:52:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286FKkZp031226;
        Tue, 6 Sep 2022 15:52:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc32e9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 15:52:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ksw0iADbzbBwVP7ZJ7t0YzsIlklduElF/aU6LF3Qr2kOg8iKsWFozYllsoC53r8ilHvsIHd8bnfEW+Mf5o+xXVMa5R/ThLBNzK3ls9TMYPq0lyyP+yBmPc5pqp7sQBA1AEm+R4quRYoq8k7Z78eM7Q1bpzWsFQFd7L/qfsHYqMSvzPVa0XYdD67irCm2vBNuVRB0nSBLpm43SRKGOeZN4dVIG+mWtvmA5WIvv6bRDwEkz3FvT5Xp/zB8qFrNrdgGh6oBWJ63ZOZgI3G3Y6AjvRUJS8OqxKeyrE+hgPgBhK91+G++coiQitB5x+saCYPpgD5YnU4PiFcTC0Xbw1ZfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQHYeWn6TdSjbRrH0xBRFp+8d5h6EK+UKK1G3wYExos=;
 b=Sb/I3sMEU3Vn+d8hst0pxrTAvmgPaRGb8T1zJJyEmqtDQzo7O+MzdcqvW9qrUi2izFOnWpy0CzKkuJNVzzkKbVrrfk5jTn6srRJLsvEoyRFMACu5UEtgbNPvvAjjukVGWXyq6oZsaxrCqRWa67pQSD6KHQ7CNTavSR+YU5g2XtdnnhYVyK9gJBa/GPNMVrehzNpmd0QbIvCbY0mT+RNqF0d9570m2YiZ52LR1X4v6+4hEh7onySaelkexmlYtn+P4n3963NLodhPSOgYcZ/Vatoem1KaF0jlVH2CSRcbNnVF6Tro2pwwrskl0wEWpgCuAi0f/WR6TRLRx5hjb7A9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQHYeWn6TdSjbRrH0xBRFp+8d5h6EK+UKK1G3wYExos=;
 b=jelhOf5NZ5nyyEa3O7E3hFydx+uf4lQmnQGe+tRFLuo0k1o6uRdjxOL5LA3VdM0z56PEbe0pqTKWv2mue8Ba2UTXfgojmW2cM9UadL1OoHnXkxidR2XalC+Pqzj7FPiK1ARFYeL3b1b3P2YQzXPxedvJUsKnE9VujbnEx/WExaw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5405.namprd10.prod.outlook.com (2603:10b6:a03:3bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 15:52:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::25d6:da15:34d:92fa%4]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 15:52:21 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] NFSD: drop fname and flen args from nfsd_create_locked()
Thread-Topic: [PATCH] NFSD: drop fname and flen args from nfsd_create_locked()
Thread-Index: AQHYwYmOsGXYUqioTkmbZZGrEXuJEK3SjjcA
Date:   Tue, 6 Sep 2022 15:52:21 +0000
Message-ID: <4CDD093E-BEB5-446E-96DC-C73DA86587AE@oracle.com>
References: <166242493965.1168.6227147868888984691@noble.neil.brown.name>
In-Reply-To: <166242493965.1168.6227147868888984691@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73d537ca-7885-4a0c-af56-08da901fc8e5
x-ms-traffictypediagnostic: SJ0PR10MB5405:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MaOFLNXbOg5sNpKAey4LzhqRFG8wFlwpWjkhMz95CdQUZk7PzO2qVKyVRTDGLO67gOFbfQ1YPDeooIKkpu1/Frvaz650XpMVykcrpXbwFFrN3inApehlrPSFhjjNZimKuD7Ckl448c2oUakoCukT+DbdDhCjiLi3FEtnMhkq1T4Ygni13Z6N2KFmnfoCGX0XbxquTVLaZYUa3flbGEf1/rW90x3lT4rLLgejWRIc3GwOLKMDqk1Tdsy0Pxr5iCjgVAh3l1xebiKOLQ1B/8LZhLRrJJh40FpysBC6yvgbloRTEbbqmbRTr2CC2IRxdRYaLlIVLHcmsMKwZCDs/82ecmFJVLMnf0L0Yq3hiNv/xs1d5Ec8wIgO5QPVzqMlZk20MSYD1Jnr0YySfa02nYQFku1pDw4CBok5rvlUWhcaDvwkImggSSrESsFgxc2r2/Zklsv2HUx1CUjGemjOOGxFsitjwmzCThhK5JSN4GyDsvFE5+0pVTlAc3nw2e0kagercOH+WNDbnHgJvTpITx+e+MSXLj+dwngiszG45ESFvJae6Z/yNutI9zj+ZoqAULUNDIf7GmtKZq1oioMaKw6GqQvn2GV0JNg0s3CwOWObUMyjXdm7DUmYfc/CZg3FoP4vGbpFP7Vw+NNvMH47HHySLx20LAAk617/lG1tOMsGRVe1C6vA+wwV+XFVFUSsTLU25PGq2mElhLVXoWHqEfcJx0eju7eZnkIN86894WoScgmY9QWQm6j/O2Vf6Nm4vT+LinAzlJC6NWbY+Cg5DRR8PxUjiDHwUFsfKrNs+tyiu3o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(346002)(39860400002)(8676002)(64756008)(66446008)(6486002)(66476007)(83380400001)(76116006)(66946007)(66556008)(38070700005)(4326008)(33656002)(91956017)(478600001)(6506007)(2906002)(5660300002)(26005)(6512007)(53546011)(8936002)(186003)(86362001)(2616005)(41300700001)(36756003)(316002)(122000001)(38100700002)(71200400001)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h0gPC9Fx9wBT61ZWF68PkM4QYLURXFJQ1+IprSAk9LBfTJAOwud6dlw9CCMr?=
 =?us-ascii?Q?ZpmKDLgqoy5a+YbTf9+MZMaG9nDlItYiAwseNpZmdCrYFfrAtWvF81uhLbz6?=
 =?us-ascii?Q?RruDJrlwTgUsE8a5bu8MtMfD+L8ES+jqmpTABVF+hIXn7YnHu98/PlxYyjbV?=
 =?us-ascii?Q?Sx5Pg+cfoq//huZPCv97P24495IiwGT+039ohmmtcJtkPmDo0Sb/6DuVWXBh?=
 =?us-ascii?Q?/xnip8JjOtYz/yaAR36zQRJKrN7O6pRNyv3q/HOFd0LF2zIINEhW+W6cb5ZE?=
 =?us-ascii?Q?v4P51ZzKTi/JaMfteMmMMxBzq9Oq2zmH82o4zxQonT9BMIdGNpRM2rQlb/Bs?=
 =?us-ascii?Q?lQSPiUNFgw2CR2KznWo9L/J0gUBcjq/Bzyk4yJf3EZnVvuaedM0Wd8RFIHsv?=
 =?us-ascii?Q?QQGhMBQNWNE9YMnCuIClv2aawdGhpA7aZzleF6F0KbLbWU2vrcLgWrd4WWAt?=
 =?us-ascii?Q?l9ZQR6NtE4W5xJyWUcHoAvY/TLKf4KnsQJGZ16X8R6EgrkLVqjTxldIG1e3D?=
 =?us-ascii?Q?kXE8rwPTK6JDKVrBNPyjLwmWmIp8zwZgHQbmN1+s5/AVBjEmsaExy6dsOj19?=
 =?us-ascii?Q?vnkjja2DAFGtUjCt/4PlmgZCzzLdbQrzWwlkH+1MW2GUefFzNeMYg0SZkIk7?=
 =?us-ascii?Q?stkb4i3Ckx5bL+K8+qsMZPDqPiB8InX6FPfgOC37XTZvX+gnSjt1s5ALeb9s?=
 =?us-ascii?Q?pgtAdbUsZneclRNZyrHibtE/ZRwHUmKS2ZvecI8UutEmJHGIvbu13KTXCsAD?=
 =?us-ascii?Q?qFMkLwoJDDb/D9+sDlHr6byU2Eo0OKQTC8YGnbUfavc2EpSmQ3jo1i/+3icw?=
 =?us-ascii?Q?lu2LHonBapdohSolfvShGO4iGG3/JEHso/gWCu7ptBrXDcGC5NEV0tr+pg+g?=
 =?us-ascii?Q?vloVlyMgovGAziK/KPYBXUWVPdpkdnZUJS6hKEwFIYztGVPYAswLyOst/3eb?=
 =?us-ascii?Q?tOaY6gwuY4l85MMxOk4foSwg1JQRoIQYINdkIZ6pjEwc4ZAAwg8WZgVvjH97?=
 =?us-ascii?Q?svD7hYdmkNWaqnpDZ+3lh5tMEkL+pmvlne/9Or1pZcQzfmuS4A1ciXECIO1M?=
 =?us-ascii?Q?XucfkYooXwv73WCPy+/vz8YTzSUloJlOuV9j6aEJ6gdrBW/SDA4oZEK3cY5S?=
 =?us-ascii?Q?31oSdRVIQfhMMOPXZbqkFksb0aSgC4omqeKVHPDIv88pFysFxELUQJ9LKY/t?=
 =?us-ascii?Q?DWhYtI9mrJ+gUrwcS74y7J1V9ywoRAWH5MXCplSxnqST5cxZgCdV1sL+e+Dk?=
 =?us-ascii?Q?vdNDaTGPdXtShmpUW9enlksYGcWBzpgs7XfNkPV+7zwA1vEHPtwFdusQKY5i?=
 =?us-ascii?Q?rObTpsvwIGrR4oYcHace2dGcqhuBVV8snCLH0hzLhWWpS5kyeX/aCAofSBJl?=
 =?us-ascii?Q?uS9ttU/mV4Ae8vfdJikKHvVpgGljeVU8/iqMh3lB4VYG5GsRu+3jCfUPmk+j?=
 =?us-ascii?Q?5To8hUyM8OZAxlvGw8DQrL3LnbaCBOqbgufh1aYNYRYU5SCHi4Ok13JU7xEu?=
 =?us-ascii?Q?JU4T207r2Pc79A2IOPKKcQizXv1Hi3ysVbbI5dUGPuzO1cxrrZ+wWUU7eTxk?=
 =?us-ascii?Q?4tANakWJfNYqEhBBfaKuxT3m/ZtDPbUzqfL35Iv5TMpf9vUp1hT4BvxvuEGE?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1F23995ED9AE8E4C9DC874CF0525527D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d537ca-7885-4a0c-af56-08da901fc8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 15:52:21.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XctZgH4CFUD4kZ7HwAhfhfxOiyMN0RxL6R0Oddk+mKMi9G9BEmjZdI9d2i/oiIKIvlOgeczUfpffQZticShdLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5405
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060075
X-Proofpoint-ORIG-GUID: W4bj96aDW0FSrT68iB3cDiODuw9baGz3
X-Proofpoint-GUID: W4bj96aDW0FSrT68iB3cDiODuw9baGz3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 5, 2022, at 8:42 PM, NeilBrown <neilb@suse.de> wrote:
>=20
>=20
> nfsd_create_locked() does not use the "fname" and "flen" arguments, so
> drop them from declaration and all callers.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>

Looks like this has been around since 2016. Applied to for-next
with whitespace adjustments. Thanks!


> ---
> fs/nfsd/nfsproc.c | 4 ++--
> fs/nfsd/vfs.c     | 4 ++--
> fs/nfsd/vfs.h     | 2 +-
> 3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 7381972f1677..9c766ac2cc68 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -390,8 +390,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> 	resp->status =3D nfs_ok;
> 	if (!inode) {
> 		/* File doesn't exist. Create it and set attrs */
> -		resp->status =3D nfsd_create_locked(rqstp, dirfhp, argp->name,
> -						  argp->len, &attrs, type, rdev,
> +		resp->status =3D nfsd_create_locked(rqstp, dirfhp,
> +						  &attrs, type, rdev,
> 						  newfhp);
> 	} else if (type =3D=3D S_IFREG) {
> 		dprintk("nfsd:   existing %s, valid=3D%x, size=3D%ld\n",
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 9f486b788ed0..528afc3be7af 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1252,7 +1252,7 @@ nfsd_check_ignore_resizing(struct iattr *iap)
> /* The parent directory should already be locked: */
> __be32
> nfsd_create_locked(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -		   char *fname, int flen, struct nfsd_attrs *attrs,
> +		   struct nfsd_attrs *attrs,
> 		   int type, dev_t rdev, struct svc_fh *resfhp)
> {
> 	struct dentry	*dentry, *dchild;
> @@ -1379,7 +1379,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *=
fhp,
> 	if (err)
> 		goto out_unlock;
> 	fh_fill_pre_attrs(fhp);
> -	err =3D nfsd_create_locked(rqstp, fhp, fname, flen, attrs, type,
> +	err =3D nfsd_create_locked(rqstp, fhp, attrs, type,
> 				 rdev, resfhp);
> 	fh_fill_post_attrs(fhp);
> out_unlock:
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index c95cd414b4bb..0bf5c7e79abe 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -79,7 +79,7 @@ __be32		nfsd4_clone_file_range(struct svc_rqst *rqstp,
> 				       u64 count, bool sync);
> #endif /* CONFIG_NFSD_V4 */
> __be32		nfsd_create_locked(struct svc_rqst *, struct svc_fh *,
> -				char *name, int len, struct nfsd_attrs *attrs,
> +				struct nfsd_attrs *attrs,
> 				int type, dev_t rdev, struct svc_fh *res);
> __be32		nfsd_create(struct svc_rqst *, struct svc_fh *,
> 				char *name, int len, struct nfsd_attrs *attrs,
> --=20
> 2.37.1
>=20

--
Chuck Lever



