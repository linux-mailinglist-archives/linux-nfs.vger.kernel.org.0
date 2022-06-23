Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B590C557D93
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jun 2022 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiFWOLR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Jun 2022 10:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiFWOLQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Jun 2022 10:11:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC0342489;
        Thu, 23 Jun 2022 07:11:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25NE79bq017786;
        Thu, 23 Jun 2022 14:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cstgx1chhyJd/6gKm7EKKjtB0GVQU2NnY/OXM0Ru5s8=;
 b=XxzYHzlfWijrDOyjZdKGtzb3v5R1+M8Jlx+8YS/yocKQgYnrJqqogLEKg5eamMe6ULLL
 Mb8bt+N9IYz8RqTD/VwYxXUUDgJX/4DAcSucWe8Mdgp/NhOx1upowuqJpC/egRFMXlEx
 Y6phtSYSg5HIAm8kfmaVVFNR0Eu7MRLcrDYOaECPPUwc7tQyjGprWr+ajWkwdH9QAkmM
 L+a8KIRSPhT/Mchi3Y28W7VLFl0vh6Wy5dIFz+9itrkOWZ/s5wm55KSmNUfhVejy+wzV
 guW9JFPUwHWN0pVfharI+mTHo7wHa/p6dV+POG8ICK4I9FZUaCIf+Y/t66xyg6DxvJD7 PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0ka26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 14:11:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25NE6GBF008617;
        Thu, 23 Jun 2022 14:11:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfwp642-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jun 2022 14:11:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo0959t3O12d2YqfeuXvl1J0vQ/hgo2U//bp2WmIBSEvB8ErPJJQfFLxdLf35glQQgxZfFUyHKLMHpesP2For7udNnY/galajZw2POVoVOZsHR5hqMTib4nz39SCHQuPFHt/pYdGf6qp8N8t2RQx5bJDn0TnnjcJdyMe3NAFiPOolVkgmH8Ov5n0BQA4LotWwCx9CI+FevNZz55E+XDxBWCR4Lbbod/QUtjSvfodmWi14PvNKsa+swUcJZKjSAqrDLRy9lI1L1FUMn8Od1hWFUWUSrs65JHYRFFjKAdKL7qawIXCk8KNyMfsDvcHA6wtz+i52HwKpyuVcpO3KYVsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cstgx1chhyJd/6gKm7EKKjtB0GVQU2NnY/OXM0Ru5s8=;
 b=haBPhGB4TY3F2RGv4/0BZykuWoJsa8RG12/GVSN2CQGGgmi7Zw48QA03hMCQH3t+jA9AMS35fFmCBrpKBp9iPDu0QkNWJMj/K3HeAFwzKObnv4AYq4soLNxLvaQ8N+1ub2kCvROICkbuMQRcNVlW60g4s6q6QrX6i3Ww7AJrxpnzu3koPvoWDxBCBvz0iGuNZyCmuDTSD2TmeDscbI7ul0rb4CICyX4QU0e0pQ9SGu7MxhTmrG5cxw4kH2BhC2x4S0SyzkYbQyrzfkhvehe/73wpySIpvjHg8UQZ1jV/4wZ9xRcahLHh/VxEHmiPyO7c65SjZW257AUnPUwl+ZW9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cstgx1chhyJd/6gKm7EKKjtB0GVQU2NnY/OXM0Ru5s8=;
 b=hBA6csCKC2aPJK3H4fcrT93hfnp1qcqA/GAYOpqwLvISPsKmfcxdYcPttBMRDkmM+T26g2+kw4RxSFYXjAmxULg13Ja1N0oIvXEheFYMeIG+zANZ44KvLduXZSI171f8iCuYWFfp289EkosUgcbeznsuTImmrcj5h9U1t1EtBxw=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 23 Jun
 2022 14:11:07 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::c952:6550:162d:4aa]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::c952:6550:162d:4aa%5]) with mapi id 15.20.5373.015; Thu, 23 Jun 2022
 14:11:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Zhang Jiaming <jiaming@nfschina.com>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "liqiong@nfschin.com" <liqiong@nfschin.com>,
        "renyu@nfschina.com" <renyu@nfschina.com>
Subject: Re: [PATCH] NFSD: Fix space and spelling mistake
Thread-Topic: [PATCH] NFSD: Fix space and spelling mistake
Thread-Index: AQHYhtoYxAdfZlU7iU+Z8que/oi17a1dCHQA
Date:   Thu, 23 Jun 2022 14:11:07 +0000
Message-ID: <098E693F-6F7A-4F55-84AE-21FE7498B940@oracle.com>
References: <20220623082005.8521-1-jiaming@nfschina.com>
In-Reply-To: <20220623082005.8521-1-jiaming@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4d1bc99-5f2c-416d-593a-08da55223779
x-ms-traffictypediagnostic: MN2PR10MB4223:EE_
x-microsoft-antispam-prvs: <MN2PR10MB42235BF74F1EC201E7D777DA93B59@MN2PR10MB4223.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0cT+4zZjMrvYZurHDC4uUgClW/GqH6itVWRzqGvJJAaoUOMwivO1Q7/mWR7hDHPywBFaEdiOQsJRbjBARDnnxpTSZk9sxWofG8+WSHy81dHqlXkjO5I2YO1cByityMoZJUwh5lj6kfpeh41X5x6MkdbJBm5LdONoGCcWBMv4Oqz1izjarZurw7dqQlguY2fPaVnMPMzG4UQRqsAg9VV5mKb2dtvjnBNasw0skssmygqC6c4wTFB2dntsOpOnqc+4Jb8AG8/sJ4F2vamkuroPuudfy5sgfAgARJXJVx6QoNY0h9N/Noder5C+OH4HDTuooZxoGJWHJjNG8fxhNk4yWy9Of/PaWKTZalRQ0pPk6nyz1mmSEc7939UEBhgpAzrN/0K25GpSTZNJ9UI1lWtLrXEGSbCbyn9uR5dc58tGZUN9Dcsv0i4d6Yrcq0ZAvWRVFtzyIae4YKYJ37jYPFom/xPJqGRN+WFOnxOJeJJI8FyOGeZrZFgVEc4R3vrK4oBSSlfbUCBi8ERNmdR81TYdFQImzm5ifuu3zn0LRAzlIKVKlax0nkdP5jIuZRxletYThIyzNFEABn8OTszNUSAwwiw2r+FnctO2o4okqfWR0cCXMfK395EdUHII05j+kSTmpVq8b1ILofTT84ASoLHMmecJlMCBgei956gU4HziDVGYAWYToYajbj+B7gll3UpBnupp2euASz8rbED0LdnIxDxt92M2uxrs4GoCLuhLSIy17NMal2FijVFd+Z2v150YVUFtkhMYg3Z+8Z5HkBxKc06jzwb5yaC3Q5MWhyUfoE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(39860400002)(366004)(5660300002)(26005)(478600001)(6512007)(8936002)(6486002)(86362001)(2616005)(41300700001)(83380400001)(2906002)(186003)(53546011)(33656002)(38100700002)(6506007)(4326008)(122000001)(76116006)(66476007)(316002)(64756008)(91956017)(66556008)(66946007)(66446008)(8676002)(6916009)(38070700005)(54906003)(36756003)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bFVoDvEIYzVXU/Xpipktd19fHz/ggLNBtBj5qR4Bw9kFzYkuTBQ8cv3RDEkB?=
 =?us-ascii?Q?fFsp8puxY2LMIUcPzsgZ+/u1/Smrg1khHscdV1u5WXq2veIsafklJ+b6nEs3?=
 =?us-ascii?Q?h8phdGmQv+vFexEe22ppgLuwz7fJKMgSI1Ncev6q1qU8OT5FmarUZpwFIxo/?=
 =?us-ascii?Q?gQ8tilBEh+iv1map2QTfBGFqbewhfQar0Nc6/GjHS49w+pndcUzntdO5I8MO?=
 =?us-ascii?Q?Lv0cCebfNFPB84Dwpu1k4b4oAle1MZTqZ1zKSYgt/JOz3gB6wZ3Yvkd9BkYw?=
 =?us-ascii?Q?EKy63uBunZvjDw+Vt8wTsmviBYLG+uTueC7Kiagju0wWEi9QBVwNPlCJfpuc?=
 =?us-ascii?Q?rRaIjs7cmMCvBmGlvBFFshzQ+7RHt4hnJXUaXv78DwYZ/O2xq3IXINoZHlbm?=
 =?us-ascii?Q?JxG8avtybYLJ/tWPJTYl4aloRlBS59+hzxomJ4uxhR5Oq2qGuBCRyfrGBmrW?=
 =?us-ascii?Q?yTgI3Nj9/IqdtOspMpXCJA7LbZ9AQuLn17nsVpeCE8u5sqJqQNeQEl2DZjA9?=
 =?us-ascii?Q?bdfNvjS1cfTNDaAyNU3CsqnvdaP2oyhGMwaIxmTt1Ml5l75OlzrjbF9dbm3w?=
 =?us-ascii?Q?Y/tF0FgJmfTX+nvOYvRrrXoQmPq5LrLCopu/NHn9mZgRlnRRVd5M/Iu7+Gap?=
 =?us-ascii?Q?aXBQjhih+UPjaOS7obzEiIPKCU6Gt2FQt0Qy2X8qyxLFVI2MLmN1jclFxPBL?=
 =?us-ascii?Q?L/mqhVE4mIDF40aoT7VCzrqca9XsGxjCvE72RexaIVCm4THXHHBghGv8m3pL?=
 =?us-ascii?Q?0TcwEbWEjip7vv42IE445wf2h4YTQMr7WxgD5TT9Vgf1alZ5EnAKyIENow3M?=
 =?us-ascii?Q?4VPRTXgkZGuFeYzUgEjmK7lgl9SiwfOw8qLtxHNF1nPY0FM6HiTIEzh4rEAA?=
 =?us-ascii?Q?SIZrbbSZMSla7RMrzynOhIFyz+1T4yOHWbrRowrfJEtIn7oSO0ayJdOPwmSM?=
 =?us-ascii?Q?+gL10LGd2pcBcYEKWpZTkpeqadtLxjtp8q+6bKnJvU/kCOvDg7TbEKc/XfFi?=
 =?us-ascii?Q?FmUPhww5jo7WXr3zzorDsNineHhcQtpUAInfp67s+/tddRN7eHzfqsOYa6bR?=
 =?us-ascii?Q?cDqyoINNJTcyy+TbXDcTkWjRWh69yjLpZCtUJShfm7hg7PkZdxFoDdAKlU7r?=
 =?us-ascii?Q?HYgAFJgFYl27XLzLUgzmz4CtstrUnmiyrLrEE+sXr0Aa85kN4RmWEtlk0ouJ?=
 =?us-ascii?Q?aaLrSJZS658Ds44ZQFBfq3+O01WPzsGoUsmwvTQjppC4qXT4Sv0EoRB0kQMQ?=
 =?us-ascii?Q?wTZm7eMyGK4x6QC7CFjO2U5C1Zaf0MxCXw8c4Vq0ssjPHH0UKhmyiPgywigz?=
 =?us-ascii?Q?5o1g5QbGprtvoaOcj/nSmx9wd2ovOBnhayDiHknTvEUhPewZ05dvQbYi0XUa?=
 =?us-ascii?Q?TuCdGqVWaRv7D6k1QnB2DL7pxbE4Yt0hcsl5zBsk2t4dhEpUnzIPtof8r52V?=
 =?us-ascii?Q?vMPI5C+TCl86UY9av9yBkVxKxZRzIUbT7Qzi6PaXDoYSd/gNDDK+pHKBI772?=
 =?us-ascii?Q?+miOXAWX+b6mXmgrTWJjXFtjkEpUypuREuR7bCSVl61af2lZUGao2NhDgqRc?=
 =?us-ascii?Q?ALsn2Anc2T2gakQh0//JBMV8wLe5ZowPK7VijH8edYp5OD1Eu4xyk0i1m78b?=
 =?us-ascii?Q?IqOKmZ0gmtSecjrGfeabVSgivqRLlGROO0MmNuMcV71RWVqbzAiEUziEZe7q?=
 =?us-ascii?Q?MqDT5NWstRx5cDL03e8LRX29B43qQ5qX6gYEPkyjgGJiMKBS5VexoHuOBDau?=
 =?us-ascii?Q?pb9vrKe4JD1/IM4nDnTb1X5HN+9eqXM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93362BAC7EF6D0458EFD3E8F768EEF58@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d1bc99-5f2c-416d-593a-08da55223779
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 14:11:07.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ulgrWDAUnSm5BP5HzgwxwMB0jkbEybVnCcKNbpKtmmFtusYSJlufvKvhbS1aE6gFi5RWvGe6S0gJTsLkSYAqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-23_06:2022-06-23,2022-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=734 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206230058
X-Proofpoint-ORIG-GUID: UCy0VSXMgKL6pEV5xeD4BVbw6C5w9000
X-Proofpoint-GUID: UCy0VSXMgKL6pEV5xeD4BVbw6C5w9000
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 23, 2022, at 4:20 AM, Zhang Jiaming <jiaming@nfschina.com> wrote:
>=20
> Add a blank space after ','.
> Change 'succesful' to 'successful'.
>=20
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>

Thanks, applied for the next merge window.


> ---
> fs/nfsd/nfs4proc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 3895eb52d2b1..d267b9bcf1fc 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -828,7 +828,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> 			goto out_umask;
> 		status =3D nfsd_create(rqstp, &cstate->current_fh,
> 				     create->cr_name, create->cr_namelen,
> -				     &create->cr_iattr,S_IFCHR, rdev, &resfh);
> +				     &create->cr_iattr, S_IFCHR, rdev, &resfh);
> 		break;
>=20
> 	case NF4SOCK:
> @@ -2711,7 +2711,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> 		if (op->opdesc->op_flags & OP_MODIFIES_SOMETHING) {
> 			/*
> 			 * Don't execute this op if we couldn't encode a
> -			 * succesful reply:
> +			 * successful reply:
> 			 */
> 			u32 plen =3D op->opdesc->op_rsize_bop(rqstp, op);
> 			/*
> --=20
> 2.25.1
>=20

--
Chuck Lever



