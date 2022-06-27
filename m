Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6055D535
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jun 2022 15:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiF0OvC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jun 2022 10:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiF0OvB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jun 2022 10:51:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962A013F27;
        Mon, 27 Jun 2022 07:51:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDdDxX002132;
        Mon, 27 Jun 2022 14:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GLOe9lxkfuX+Gw1KqeixsrAKsvM7NMK0r19OKjprfz0=;
 b=nUrDxAOiFMGXoMJyfKJLn93hZeq4fp5CaN8l6n5NW15U+qPjp0FN+vuFN24n0/Q3/kas
 DCDvQMeOa/039AVOWLUGPwUC4cgQ+/mcrCHqWhmbSH+wPClraVlMuCkLFSrnnGKmBfCp
 sajCYLU/2Lb/PchSk2DVWv+JybNu8ZQqR0FDTwwKpQFhy9BXslXuV/aOGpSNJgOIVBKO
 sWtxGqv8tHeuObs/4TKll0qvdIEF0T+Y4+fvMAGbGhxxUI8l83jnrzgHj5trEQIM1QeD
 wATi1mdx5X+OmRK5krbWL5eiL/jzy9/qXImIHnFzTMb7mmJo6GTqZ05XRHsPfMFU1ft1 +Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52betq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 14:50:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25REiqou003624;
        Mon, 27 Jun 2022 14:50:07 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt1p22d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 14:50:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naeYvD5IBjQ00k/c3lcsQd+fgDUdYq9WC+Jz0iEUc8rJOT4gaRiWXKasPdmyRq7mH3Eclh2fV3f+OelIc7Q72DgioacFOv8+A7QGwHboKK0FcgeCPEdz+0iuTcXvNJovRNdWIwJifp1kq8jzYfDbXOPWrxqqhSUs/obdpibYah/snNI5OGr7LVpvhKkYz9pINehE6oEafWtipRRIUAt4XRWiJZVAIvAu/3DdNgGaA6FQbnNw05FSJIUtEaRiQ+eXuVEojyrF5ytLOIFbpBeYCU0940H+hTXetBu1vbQQOOX6Mr+UHvsHjbcjIJ9/e8IHPdAv9e1GBg03zPu68P927A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLOe9lxkfuX+Gw1KqeixsrAKsvM7NMK0r19OKjprfz0=;
 b=iCEUQC8AW/vLhTj6LMgQC32pzliMou0Yv47rvQn/dqwoSnIqPxCN7uLXjg+ag8H9QJ+LCG69U7lc3io7RKGWmqJ6xHI41IGNL/SIri6UDtnkBsGLvH2WifnC5244JpW8bA7MfuascVmErhyn/emYyc6JzB8qDXDSeOkFnGrGOWVag99r1HvsAA5a8gbcgr/w9kSytfxdDvV/CPlYuSt16kDBvY+Qsfwimvrnd1MWz2HwyD2LS1pW5b1xKoYXJZTHLAcw7vXwMCL/o2/QXwUEm20re9c04e63pNWOL0+00IaI+9njEVJvy6a6of51f0LgkEcGhMjp5A7XtUag5KEilA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLOe9lxkfuX+Gw1KqeixsrAKsvM7NMK0r19OKjprfz0=;
 b=fUvkhip6ZTsdyGm5rLWcwgICDayYjMtrIKqsVPk1GDqNZPpZ/m9uG1+Cvxw4+NPbeZCiHpmispTmkMOl+HyhxWV320ACDENO7LbD+4sQjdVuMv+GQ88oRy1+MApcJjMfyfmbkB+aHpKX2hc1+GyhKVgEIe60ujvHhIdzwQank+8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 14:50:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 14:50:05 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
CC:     Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Subject: Re: [PATCH] NFSD: restore EINVAL error translation in nfsd_commit()
Thread-Topic: [PATCH] NFSD: restore EINVAL error translation in nfsd_commit()
Thread-Index: AQHYiNWUeae+GVdydkKNOxhPY75Q261jWLMA
Date:   Mon, 27 Jun 2022 14:50:05 +0000
Message-ID: <9AB7582F-468D-4074-A295-E5536884E9AF@oracle.com>
References: <1656190363-29148-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1656190363-29148-1-git-send-email-khoroshilov@ispras.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f684464-cfdf-4a66-b77d-08da584c529a
x-ms-traffictypediagnostic: BLAPR10MB5108:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjPmqJih8nwWyYBxLIOW6EcKnlrrZYLiEL3/jNB5VXWpvCikrFvt3fcQWfbfd5kBOkLz/lB1f4dY4A3QMOzjNwldkWzK8YMpeUKK/27MxrcGpZgDd8bH8wka8CL7tvHLqy10jCjfTTLliJFd5P6AJ6qYamstQewQCfLiuAihmHOVRrMEz0h5FxsNeYlDTnc6DI3zA0AZRq7vPLltgmPh7dOQ2vL9vsYAyuP7epnBG2lpLpxBjH/umG14b9Vo1lt4i64uGXzJIJmn5SNQac8MixAMWmxXZPs79ui6z/CIRFvZ0fBrZVHg1NKmm6Cp/6PBaNg+uqTNZuKBebXU5r6JU1t8RymGKUg2Xperlk26shwABAFGG0sG46P05yUSPp0+B7aynrhTIAwaJ5jRQBXIqKGSZ2M291CbWulaV4vrkGPExnJmknoWdgb+TdTEOwGoVC4voMSE5WAVgFQTKLmzqZOFN5zGAhtlZT4ObYwhWe+rma0CoCJnf86244syU3Ba95E1iVwYBYGpI3POK0DbwwrYlflP8e3Jn2CI7egRp5NLXS0VEIsWgPeb/nV/XWtYXa9PYTnUPbpSzShnCsngDKJprTm3BiYYhK4Ixc0J/Smenh7kTulqm6MTHxQRFOwnhob0j5AUYHnOqu/7ZII6OAK3tl3jzwG2bC6JVbQ9q9/p6GBEHq++OmEaGDfLwk8n9SNOo0GZEKcLhHGlzmivwZWAPuUavJWdLSFq+F/MQMa4IpZhFYnLzeecB1dUw4SgJox5wE3ms0lTG8EXeKGYcbLhfUuURg8JtJ1m43MpbHnsKyabMizJj2EsCCzwfopzHm+TkcPWWakMP47OxFuSv7+OkO9YyOl+bwIP1VDAZEc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(2616005)(53546011)(38100700002)(71200400001)(41300700001)(86362001)(6506007)(2906002)(36756003)(8936002)(966005)(478600001)(186003)(5660300002)(83380400001)(26005)(76116006)(38070700005)(122000001)(6512007)(33656002)(64756008)(66476007)(66446008)(8676002)(54906003)(6916009)(6486002)(66556008)(66946007)(316002)(4326008)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C6XYD2w2sc97t2vy6ufb3nnBiWzw/r0B1FrWGSk9yiPYHKslA/TKL4dOSkh7?=
 =?us-ascii?Q?YSNVJGaF/HAmyWD4Z9vHsGIGkEAvZ6ud8ygj3gAOFA7TGh7Exl292sAzeR3Q?=
 =?us-ascii?Q?d5rhh34/gGe0Bzkt82bl7iE/K2xUhc5Vs7cPssfdqEl8jp79PA0ybMFVpDCa?=
 =?us-ascii?Q?Q6dfVuwze6bKEjG+ebrCj7aaUR3vpz3+s/q+wpYDxm++Yt/DVuFNKDpPQ6t2?=
 =?us-ascii?Q?+kptjM+YDwizHm0jBOrLdWKOAH3klUDp/K3nEA300YWaSqJtB1PcjOJwwWLH?=
 =?us-ascii?Q?W0W0dfwChWiBv7pM5zRbCPDkAoCzdtOiGOgMy1JSLPZuGytvw/qyLlkaFm7j?=
 =?us-ascii?Q?TKaYeUVqWz2/2drd7Y3+HEZv0pKsNm71SYI6dnxeM0IHivOABqI2jAFnSxPH?=
 =?us-ascii?Q?ewgQb3gEfMJaW2s05J2mXWPu89tv4nW9qfn9bUoHISlubOlTtla05MxcyHND?=
 =?us-ascii?Q?/A1B09D81PwP/DPvegvvzdjns2w6RitSklUAw6dccFZMK+ZUsj6KImFLCBGn?=
 =?us-ascii?Q?2ddNfMQR8JZPiF0kvmg3/lA+zGj3OjAxMEw0TOUlZ16j6dN5ghI3dA2mHWZB?=
 =?us-ascii?Q?YPXDBdr0PBjtjBEgoYmUtKRtJjoTzNhkVKpV4lOTtcKvBGgrb7bDzOZvkX/H?=
 =?us-ascii?Q?oTKo2TupJnOUoL4RDpprLhWEu3s2Kpghx7QMAKFc2XCvz/6Qyxyamvmen/Zu?=
 =?us-ascii?Q?8zBfiA2WEJk+x6QDIyTQTXKAwui7chxBaAToP0oTyrYAqY08aw2ojSNdxZ4k?=
 =?us-ascii?Q?ky60MF38VZ0rJy9AarRMakbJGU4EK5bUY657mLrNfLmNJeuqAWNBcmj2ySDL?=
 =?us-ascii?Q?fnUxHinvAY/ElQujp1pA4CmH9jUc36Yrd/gYKPgnCmFt+eIx0BA0Zuct2YKF?=
 =?us-ascii?Q?ZEI/TJQkM+aZ7vp+Y74d6Nc/IMD7/+3Fg4nExxo6REqBctajbn7rOnXQ1fwf?=
 =?us-ascii?Q?aONQDNMBpp87bslJZtqleUd0LFEFLBzoArW9G/HzCzpdcWDQZwg84j43DYNu?=
 =?us-ascii?Q?CFOvsJdkyxTxM+7ppD63V/Vwlk2eDJTtXmpFqFzfFsPRxmW0JIkI2TZAQ09R?=
 =?us-ascii?Q?GFj+DD0WYPPlczMWCXp9JxyZN65OeUrKeLSn/s4spsZessQAOdp4WAeEW1mO?=
 =?us-ascii?Q?4pADsGcbU4oG8FWIZmz7Ju4gWIpuo0h360VWgcms3YDsAehhmibQq+YUVl9v?=
 =?us-ascii?Q?WNIelvKm8oGNZ4HJDCa7jXZZrhmDomkPnn8AdP9ft+xD2QSxz36BlV0vC9GN?=
 =?us-ascii?Q?tFoZOrXrF5tc0tgcD/fIBP42Os0PemF+QExZ4QejK5pFAQ60KNrPt++L2owI?=
 =?us-ascii?Q?Kq6XItwMWhPLwqEkLEhq2DTe2NUGzKkRvM3inbtRZlSbAoDgllu4t7CQlu2T?=
 =?us-ascii?Q?UFRuRdh3t2xQa154sW1kHeRSQa7RNSUiretJXX0JS8QagP6Oyktq2hBI/LBE?=
 =?us-ascii?Q?XpFa6O3twjE7Q5wEYNEi+eIONp19w28c2oNO+X90gARZPkYq33+sRojOeT/n?=
 =?us-ascii?Q?PN+YwLO440cEN5vt8YVm8uI8GziON8S6bg8so2yTciWYM+M6ABav+y6vCCGE?=
 =?us-ascii?Q?td1a1aUqpW//8+s5nYQPpaqzbJfb5OgO89Uzj1cBrafx5HsN6RKOrKEnZnaK?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E933CEACC894594B920DF9CBAA3D5F24@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f684464-cfdf-4a66-b77d-08da584c529a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 14:50:05.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kgxl10YJgCpx6g/SyTmWQmpc3Yavy6e2G9ZudACUQg0gDledQS/vJIt2OGZ5jE7EdzGOUjPdYtjJPFHxT/kGZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270065
X-Proofpoint-ORIG-GUID: V64WZALkhm3hhSFYEzHkyAPf8D0Gtoon
X-Proofpoint-GUID: V64WZALkhm3hhSFYEzHkyAPf8D0Gtoon
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Alexey-

> On Jun 25, 2022, at 4:52 PM, Alexey Khoroshilov <khoroshilov@ispras.ru> w=
rote:
>=20
> commit 555dbf1a9aac ("nfsd: Replace use of rwsem with errseq_t")
> incidentally broke translation of -EINVAL to nfserr_notsupp.
> The patch restores that.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 555dbf1a9aac ("nfsd: Replace use of rwsem with errseq_t")

LGTM. Applied to the for-rc topic branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/vfs.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 840e3af63a6f..1b09d7293bc5 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1173,6 +1173,7 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *=
fhp, u64 offset,
> 			nfsd_copy_write_verifier(verf, nn);
> 			err2 =3D filemap_check_wb_err(nf->nf_file->f_mapping,
> 						    since);
> +			err =3D nfserrno(err2);
> 			break;
> 		case -EINVAL:
> 			err =3D nfserr_notsupp;
> @@ -1180,8 +1181,8 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *=
fhp, u64 offset,
> 		default:
> 			nfsd_reset_write_verifier(nn);
> 			trace_nfsd_writeverf_reset(nn, rqstp, err2);
> +			err =3D nfserrno(err2);
> 		}
> -		err =3D nfserrno(err2);
> 	} else
> 		nfsd_copy_write_verifier(verf, nn);
>=20
> --=20
> 2.7.4
>=20

--
Chuck Lever



