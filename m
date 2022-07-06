Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6619A568B55
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiGFOgh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 10:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiGFOgg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 10:36:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F721836D
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 07:36:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266E4SaE015830
        for <linux-nfs@vger.kernel.org>; Wed, 6 Jul 2022 14:36:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xR/zf1c9XNwBGhuy3RSeEEECbBK5EKJ45LwGhJFrfpA=;
 b=HZE2OksDGwbyDlxVMK81GEzPfvl9wdrPUL013AoMUa9AzdZw5WmlvD05l2pr/WJOuqP0
 3uSjsDMiV7lWkbgpzhG3OUKk8jJM+QMe+zjEc19MZZQ7G93KA1vLIsQNpK+bkOdo288s
 x1shpUEn7FnJjgSWqROGkvD08jDOEOYLrF24r7WMCr4Ku4v6HMlAIrzRYoFGpQBD81ob
 t9aEK5LQkRHKOef/8nP4hO12WlCqbX7xOl1hG/pYwG1y0OZ6kEjlSWjuxtOhNHf3YPsO
 Dx0vsokLOV3RN92HqZocZJEVKF/qKq6paMhwXIyAzr8z4tJa7mkTFLe88twQWkHmv8HG sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h4ubyj781-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 06 Jul 2022 14:36:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 266EFSRH029106
        for <linux-nfs@vger.kernel.org>; Wed, 6 Jul 2022 14:36:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h4ud8417b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-nfs@vger.kernel.org>; Wed, 06 Jul 2022 14:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbLIol5FVzUyTi65xrnBfu0JEPLlJKtvt2jPed6FoLr+Qa0ykZzWx4b0Sanza85Bf1a6DoedswgHPTkWvaoxu7KZ2ByHo/nBVrAj/b0FIYSeRv55q3v1iGtO70aXatBTs7lU/XAYaCyWw0+61MtoG+zo+ufiDtgt+tLeiQm9/gVWmxiwbHdEIPnaEaEoPvrilw3qMkhNCbOJ/YvIZ6+W1xowZRwydtJ1UiPA6TI70UmVJ70MwCFLmmRukjKI5en7KBvugzyO81Y31g4+MmFu9M0lLTgZDfVBDBXqsQnxqvrp0aKeOa8E2SlDRHmL8YgZ3PedLh9X9vX72QnShRVxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR/zf1c9XNwBGhuy3RSeEEECbBK5EKJ45LwGhJFrfpA=;
 b=ggcR78uQNwJRRJp9yeTSlqqhZPN6TJp2ioIWVoEWg6USOcgn9doaSISeFJKkMpisWQHzJdZaxeap5gi6rmEdK5zTqSXePpclr4LtrUmS312KALTkeKWBJGRBCWlJ5j9O2Wvhsy+E4EWGT6f59YLtviRveeSOQ9OAxTgvrRw9YTsrFXHTGbKYi1jTsBSSXrWXbcVpM814jJ2P9SuwfmiOBiCcnrxLu2AYcts+RfbMJVifhK1odnKgk4lz1+Pnuqf1/rvCBpIS43I6USNZ/BNVGFRwCZMpWs+ZT1sjoFoNsmUfcJUJkQELi1UAeFUerPxV1koeIKHn7nYSNB5N1ieHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR/zf1c9XNwBGhuy3RSeEEECbBK5EKJ45LwGhJFrfpA=;
 b=bnQrtUYQ35Ggmo/djdEN7L5cA9LpGij5VhDj4CnvO7NvDbEiKPR97AxpKzOVo/qvA2CXX0RZY1e/jUiI/K9vuP7UsYwhxrcoVVllfUQlTKbN7hz9sXx227c8ERLE7NwLw1pXAeNZWw397dU2mBd5E+cX5vSvPHLdmE9DUDbyzbQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6079.namprd10.prod.outlook.com (2603:10b6:8:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 14:36:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::9920:1ac4:2d14:e703%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 14:36:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] NFSD: Convert the filecache to use rhashtable
Thread-Topic: [bug report] NFSD: Convert the filecache to use rhashtable
Thread-Index: AQHYkUVgYVBJYFhFt0y2rm3oVQFHY61xaQaA
Date:   Wed, 6 Jul 2022 14:36:32 +0000
Message-ID: <CEE385C8-21BD-47CE-8F9C-50D6E2B02DAF@oracle.com>
References: <YsWdMVpiHhDjfEPg@kili>
In-Reply-To: <YsWdMVpiHhDjfEPg@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a57e71f6-c8e6-408e-f997-08da5f5cebd8
x-ms-traffictypediagnostic: DS0PR10MB6079:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cfe93DNxJSAo/vi7w1/IloC1ss9ThMKUwpwPQnOpxoqvpDkF53ILgr2tUXzbzf2GZTQ+U1w+W2h9/86QFuCoE7zg/00r81a3Mvbr774RcXYWG0okN8mVJBtiSjVBcImBbDcUAG60maud1f/wjt47njjnC+C+qih4ayATY8HzM7INMzKTSt4dWuvkSegthPyLrEJRcJniHD26cVlOZXIXUxeZ6oxSFYJeQwwOkhHbQoxmg+bwD2AUJToEy/70URGgiVwQBZtgk02B+9YIISc2JwQwl/bQ4Bc5Sw8+wYwRReuUu2HG2jR9PG/iM+2t9r+maNQwEMPP0KrVf8WJWeRg0DYZcCMsiYJdGJb/ouMx/rdMor9An1q5eJghiPJPjFb1YefyECgprBHe9Tq+uOYHhKu9BIHZPg1Ab5Zyifj2yhXCrRx0rI8R02yUxhNV20NzPhrUL7oBOnwON9GJuoreTllBRrgsy6c3iVu9fn/ca1fntIMSh2M6VQZBMwIVmcMfQBOUgLYrzqa9uHJsxgofEUNISknGrFbBohcw11VKPIMzV3tQ0bzXGXkmjxbBdsXVdLqIy5/SMkrKH7ISoAIxMcVnGYo9KVFh4YmQVZoIpLt4iD18sxW7NnRBFBzOTENsHB6ItlSSjOSrjCmp4QE+gBIaE+DA/STiJjy7D7WEwXWjzxGLZHL9cIILwEvq9TGJSbF4Lm+JW3LG7u27TvgW+9eax2VFu2CUX0bgH92RPJ/Nqji8yIB1B622rQXUS5neHeJYkWepaladjQwgli8jRkXUcFfuRGi0EyRScdQ3TcPAekJhGDY1SEY0rVomkZNJtX5SFQQbEmz2PzIeS9XANwIaEEcK3UCBGMUFw7KWfMU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(366004)(396003)(346002)(86362001)(36756003)(33656002)(38100700002)(2616005)(186003)(83380400001)(53546011)(6512007)(26005)(122000001)(38070700005)(71200400001)(8936002)(37006003)(6636002)(76116006)(64756008)(66446008)(66476007)(66946007)(6506007)(4326008)(91956017)(8676002)(316002)(41300700001)(6486002)(478600001)(66556008)(5660300002)(2906002)(6862004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bRLoh+UUN4d9QOZBye+UHqJ/PJacwCc9rXq3gubVKvBd83Bg0st75wWhDUb6?=
 =?us-ascii?Q?8ZBUAWcbQouIG0CEYC41FtRwXk/ihT8gFl/KILiog4QLpNgu7g58+3L0yA0b?=
 =?us-ascii?Q?1Mh4+SjMHj3Mi5LLTNgujUYNtm7b+iYQOZCr6HVT9aHRm9PL9zB4fy+slnNq?=
 =?us-ascii?Q?U+8kXOxmDXCogGCkBDx+a9IDA29gLdaB7FS+/wohEGZIb7R9d4mupiphdzKD?=
 =?us-ascii?Q?Mb/9Sf57zXmg/Pua5aOXqbFPkzDO+R1Br0F+6YORbjQ3tSEUk9mXj1w4foZZ?=
 =?us-ascii?Q?wLRiXMErhjU7qiGRTETGYkiSYL8uBKbM7Jmj90lRI0fomBKYnFYG98GvphfC?=
 =?us-ascii?Q?SvwlG6sTLJZPJP1IgiUVfquQ8P2FaOro3v8iwe8xHiUiDEZrFuemz+KECjTO?=
 =?us-ascii?Q?ppDu/DQXpbqMCZnDP7e+ITtirBOCGIDK7N8nPp4Mzt+uWFEJy0YUSAlbHLlL?=
 =?us-ascii?Q?yqtIALh0yNCXzd3bsaij2VEYIXpu2TebcriNBxHaChDXLURiXsD9rhn1KNVU?=
 =?us-ascii?Q?xK8Fhy2TkQ9kSSTuVhk4rewaxtBKY7u28M+MU0jqV74BxCJ+KgocHtO2GVO/?=
 =?us-ascii?Q?FqrjRZigBa1k9WPC8INrnthJiKGqWsJPqS8eZyQaY0LezgcZr1IMxZJ4J68/?=
 =?us-ascii?Q?zLQfuI6JCUhfdO0yL4E4tAwB7W251H3ifcMije4yMsv6JqIunn1SSVnD+rRf?=
 =?us-ascii?Q?r0vV/oNatFRduvmYJ6pONVtqg8zct37z6SlMdzKuWdnaAStdsF74K8eG7Tri?=
 =?us-ascii?Q?YiLbohBJY+tNAW+VC8yLbXpyoa05mvPIaEn+qKH8t6aQ6rofip57v8gxNeVB?=
 =?us-ascii?Q?npOUbmSh3s6g0VRJS2DRchyz7gae++2oNECS/sjbcuSPIR8EnOn9e9LQj0z6?=
 =?us-ascii?Q?Y5cxCVHLJ5WzwL7F38WMc0d3cNW0VtDQ+9SevCMie9dgpXAfd6v9Fmme7Ba1?=
 =?us-ascii?Q?PqRTqPMN2GXJ5FEA/9FTkSEzx8naS1Q6KVwpuIe55UPw7I6dP54ySu/fvBiI?=
 =?us-ascii?Q?KUSW/eHTaeDUz0IGXfFhYuO45IYiPlU4yzv8yFYhOD+GXL1fQINYhg4sL+fh?=
 =?us-ascii?Q?j++yW8ZqtIt62Yr6ueTxZWe/FiFyvSI5qKsLy5MNxIVz5pxgxez3pUXCL0PL?=
 =?us-ascii?Q?7bY0jL7X3vL7jU1DkY+qAsoAWnCM3u9lsxwCx4IehmrQqH72MxAvDoLsv0vA?=
 =?us-ascii?Q?XIoCQ50iUFG4/tf72JcDvBB80WM8EMPKdpCk6w15B8kB98HKTbDw2EEFZ2Qy?=
 =?us-ascii?Q?mB9iDdXNgUbT0qlGTmPHE/CwB4fNz150CxaQFKsftD+yy+6Hv4h1t05vlKGH?=
 =?us-ascii?Q?IpMYyF6bAopRW1fozaR1SDAOeQP+8q0e/U0Q78Te5aDQ8rQI2oRJwD9SVVmV?=
 =?us-ascii?Q?/HQy9CvIaw82rwS03FFiEsNFAeTQldmeL+VcC3JdGz5hVWEXUaBxCK8ILu8z?=
 =?us-ascii?Q?DwYNtJa1D8W4qeeULfkYgQYdnH8zOlUTqMlK6ntbBQ7urrhbCoCha54+JcWt?=
 =?us-ascii?Q?cVvtePLCOfvB78ESxaAwxs3f7uS9sXKmVMohEroXJS+G8ymwlSQfkBUFJu5P?=
 =?us-ascii?Q?IbDnwVw167Vrj1+zH1VcWVrNVI5Fzh5flcbAOFefrm+MKW4evCX2vnG8gzDL?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2ED90343219F143B8976C7B5AC675B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57e71f6-c8e6-408e-f997-08da5f5cebd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 14:36:32.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0q9CQZx0yOlVXtbUW5+Qpxu3/+ZkPznqvK/ur05ujfN465iIiEb48/MtKeeGvIfxl3TlqX60ewOkWW1S66pTFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6079
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-06_08:2022-06-28,2022-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060057
X-Proofpoint-GUID: Bwz_nwejkpr08jvzPNJoF2HKWB8HUJ4W
X-Proofpoint-ORIG-GUID: Bwz_nwejkpr08jvzPNJoF2HKWB8HUJ4W
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 6, 2022, at 10:33 AM, Dan Carpenter <dan.carpenter@oracle.com> wro=
te:
>=20
> Hello Chuck Lever,
>=20
> The patch 125b58c13f71: "NFSD: Convert the filecache to use
> rhashtable" from Jun 28, 2022, leads to the following Smatch static
> checker warning:
>=20
> 	fs/nfsd/filecache.c:1117 nfsd_file_do_acquire()
> 	warn: 'new' was already freed.
>=20
> fs/nfsd/filecache.c
>    1066 static __be32
>    1067 nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
>    1068                      unsigned int may_flags, struct nfsd_file **p=
nf, bool open)
>    1069 {
>    1070         struct nfsd_file_lookup_key key =3D {
>    1071                 .type        =3D NFSD_FILE_KEY_FULL,
>    1072                 .need        =3D may_flags & NFSD_FILE_MAY_MASK,
>    1073                 .net        =3D SVC_NET(rqstp),
>    1074                 .cred        =3D current_cred(),
>    1075         };
>    1076         struct nfsd_file *nf, *new;
>    1077         bool retry =3D true;
>    1078         __be32 status;
>    1079=20
>    1080         status =3D fh_verify(rqstp, fhp, S_IFREG,
>    1081                                 may_flags|NFSD_MAY_OWNER_OVERRIDE=
);
>    1082         if (status !=3D nfs_ok)
>    1083                 return status;
>    1084         key.inode =3D d_inode(fhp->fh_dentry);
>    1085=20
>    1086 retry:
>    1087         /* Avoid allocation if the item is already in cache */
>    1088         nf =3D rhashtable_lookup_fast(&nfsd_file_rhash_tbl, &key,
>    1089                                     nfsd_file_rhash_params);
>    1090         if (nf)
>    1091                 nf =3D nfsd_file_get(nf);
>    1092         if (nf)
>    1093                 goto wait_for_construction;
>    1094=20
>    1095         new =3D nfsd_file_alloc(&key, may_flags);
>    1096         if (!new) {
>    1097                 status =3D nfserr_jukebox;
>    1098                 goto out_status;
>    1099         }
>    1100=20
>    1101         nf =3D rhashtable_lookup_get_insert_key(&nfsd_file_rhash_=
tbl,
>    1102                                               &key, &new->nf_rhas=
h,
>    1103                                               nfsd_file_rhash_par=
ams);
>    1104         if (!nf) {
>    1105                 nf =3D new;
>    1106                 goto open_file;
>    1107         }
>    1108         nfsd_file_slab_free(&new->nf_rcu);
>                                      ^^^^^^^^^^^
> This frees "new".
>=20
>    1109         if (IS_ERR(nf)) {
>    1110                 trace_nfsd_file_insert_err(rqstp, key.inode, may_=
flags, PTR_ERR(nf));
>    1111                 nf =3D NULL;
>    1112                 status =3D nfserr_jukebox;
>    1113                 goto out_status;
>    1114         }
>    1115         nf =3D nfsd_file_get(nf);
>    1116         if (nf =3D=3D NULL) {
> --> 1117                 nf =3D new;
>                              ^^^
> Use after free

Ugh. I wonder why I haven't hit this already.

Thanks Dan!


>    1118                 goto open_file;
>    1119         }
>    1120=20
>    1121 wait_for_construction:
>    1122         wait_on_bit(&nf->nf_flags, NFSD_FILE_PENDING, TASK_UNINTE=
RRUPTIBLE);
>    1123=20
>    1124         /* Did construction of this file fail? */
>    1125         if (!test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
>    1126                 trace_nfsd_file_cons_err(rqstp, key.inode, may_fl=
ags, nf);
>    1127                 if (!retry) {
>    1128                         status =3D nfserr_jukebox;
>    1129                         goto out;
>    1130                 }
>    1131                 retry =3D false;
>    1132                 nfsd_file_put_noref(nf);
>    1133                 goto retry;
>    1134         }
>    1135=20
>    1136         nfsd_file_lru_remove(nf);
>    1137         this_cpu_inc(nfsd_file_cache_hits);
>    1138=20
>    1139         if (!(may_flags & NFSD_MAY_NOT_BREAK_LEASE)) {
>    1140                 bool write =3D (may_flags & NFSD_MAY_WRITE);
>    1141=20
>    1142                 if (test_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags)=
 ||
>    1143                     (test_bit(NFSD_FILE_BREAK_WRITE, &nf->nf_flag=
s) && write)) {
>    1144                         status =3D nfserrno(nfsd_open_break_lease=
(
>    1145                                         file_inode(nf->nf_file), =
may_flags));
>    1146                         if (status =3D=3D nfs_ok) {
>    1147                                 clear_bit(NFSD_FILE_BREAK_READ, &=
nf->nf_flags);
>    1148                                 if (write)
>    1149                                         clear_bit(NFSD_FILE_BREAK=
_WRITE,
>    1150                                                   &nf->nf_flags);
>    1151                         }
>    1152                 }
>    1153         }
>    1154 out:
>    1155         if (status =3D=3D nfs_ok) {
>    1156                 if (open)
>    1157                         this_cpu_inc(nfsd_file_acquisitions);
>    1158                 *pnf =3D nf;
>    1159         } else {
>    1160                 nfsd_file_put(nf);
>    1161                 nf =3D NULL;
>    1162         }
>    1163=20
>    1164 out_status:
>    1165         if (open)
>    1166                 trace_nfsd_file_acquire(rqstp, key.inode, may_fla=
gs, nf, status);
>    1167         return status;
>    1168=20
>    1169 open_file:
>    1170         trace_nfsd_file_alloc(nf);
>    1171         nf->nf_mark =3D nfsd_file_mark_find_or_create(nf);
>    1172         if (nf->nf_mark) {
>    1173                 if (open) {
>    1174                         status =3D nfsd_open_verified(rqstp, fhp,=
 may_flags,
>    1175                                                     &nf->nf_file)=
;
>    1176                         trace_nfsd_file_open(nf, status);
>    1177                 } else
>    1178                         status =3D nfs_ok;
>    1179         } else
>    1180                 status =3D nfserr_jukebox;
>    1181         /*
>    1182          * If construction failed, or we raced with a call to unl=
ink()
>    1183          * then unhash.
>    1184          */
>    1185         if (status !=3D nfs_ok || key.inode->i_nlink =3D=3D 0)
>    1186                 if (nfsd_file_unhash(nf))
>    1187                         nfsd_file_put_noref(nf);
>    1188         clear_bit_unlock(NFSD_FILE_PENDING, &nf->nf_flags);
>    1189         smp_mb__after_atomic();
>    1190         wake_up_bit(&nf->nf_flags, NFSD_FILE_PENDING);
>    1191         goto out;
>    1192 }
>=20
> regards,
> dan carpenter

--
Chuck Lever



