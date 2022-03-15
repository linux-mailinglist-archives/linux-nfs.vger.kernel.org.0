Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C9F4D9EE4
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Mar 2022 16:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349688AbiCOPl6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Mar 2022 11:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349442AbiCOPl5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Mar 2022 11:41:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B053B54;
        Tue, 15 Mar 2022 08:40:44 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFRTb3026512;
        Tue, 15 Mar 2022 15:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=5vaK2eq89aC915XbI1RBKSb6iYEGRJnkHkVFpL1heAQ=;
 b=Us4oLdBRTqSMFXflFBdGIph3u1+trdnJqzP8lCco5tCUnTk6Il/mNX4biVApYgm96Bzg
 /1UmnLypWZmYK08DctGPno6akINFdjlLSkiaJQ6Q17JpJ8PGCT8NFPPYBHEc5/beWoz1
 2HH9AMMdxphJBAtPpuX0s7yQCdGaYdbMW8ibq28tZIFPWvODK1YAR0QlSVdtggq79qTZ
 uhbfFw7Ng8BddSIdxBUj25PtlN6awG55fBYxCbs5S3lSD+q2j8AtsCv0G4VL92jhBRmE
 yLvUYlabxhZU6kvZzxY1vzqtgeZfpGXiuj8yK6uqE0nyTZiK1wwGRw81098P0vsuJKf/ 1Q== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rkj6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 15:40:33 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FFWMnq133698;
        Tue, 15 Mar 2022 15:40:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by aserp3030.oracle.com with ESMTP id 3et64tq28e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 15:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSgyfLNG6oNqUlQHaGXym6u9UgX6ILYIp8JUgEKQ8hLS8/XGyWGrO3jXjuFQuwHRlZtfwX/CxKkGH6g/ywSovsU9unykSIHHvMh0DdbL/mpUIY62iCaNQg0exv41OhnpUfsW3LegkUoHEtvhhH13qtsLm9iwNwUST6ck/RUQyIh75Hjqs7sby+QrOHOuFCwIBeCgftIukUpxNmJb71ewxSQ9Z+Bx9UE/C7gkJwVezhp+2wisu/drZ5l6nQq0HovOuiCyJVpuM7XNfKCI0vaDyw7+2UtvDsVVG/OvLsPF5gv/VawN2bhQ+/sly60D9Url5IibITYQxhHVZPv7/F2I6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vaK2eq89aC915XbI1RBKSb6iYEGRJnkHkVFpL1heAQ=;
 b=oJjr0V1VfX6sXz4Kt+IUbyPb+61FfTmsDla3tYhHXQ+9AxIqQp99AVgTTsDgKEh1RfYtLGAxyc5g1RMmFYoY6lkFhvu2SJ9ZIr7V0GhKBGTV0RG/dDjn6GAjtnJba4ES8RkU9JZ9y5PLKbF554U2n5Dfx1vAfzXW4PPz/vPuz4BNSvHlxSrJQq9d6IZVT7CP1bdyk9A4wBVwXA6hLy0h7NdOk86qbWVjH6bDJnzBNayZ+YghvZE7/MRVzUDKpGAc+LCfEB5o/ome0135vHlpzUQelxgAn1WLmDyCVX5a1ZilkBeY0ZYj46CWn2bturRK4DGnfk81jn+Iz5OzLkR7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vaK2eq89aC915XbI1RBKSb6iYEGRJnkHkVFpL1heAQ=;
 b=DxWlNJVaMRrKHM4gRtqVxGySWJmh9p5W8yShEyyOgCuTMDVzuSfzs95FCJfboaw9oyQA/+vvOJLSN6ZtvLOhy6ub+KAWQfEtOlbncDcoEbiKs2I8z6u4Zk2jl203pR37zeE03bU88FhfXifjo8QtIrrJZ0nxGgA1LfoORD3+X6k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4594.namprd10.prod.outlook.com
 (2603:10b6:303:9a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 15:40:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Tue, 15 Mar 2022
 15:40:30 +0000
Date:   Tue, 15 Mar 2022 18:40:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Dan Carpenter <error27@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] NFSD: prevent integer overflow on 32 bit systems
Message-ID: <20220315154002.GO3293@kadam>
References: <20220314140958.GE30883@kili>
 <202203150321.2NA8SWEv-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203150321.2NA8SWEv-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81a72c02-6b1f-48b5-ca05-08da069a22e9
X-MS-TrafficTypeDiagnostic: CO1PR10MB4594:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB45940A67288FAFED9436B4F68E109@CO1PR10MB4594.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NaL+qwL2nl/Z6KjcuBSL5iDsyTYU6EsVqYZIJZncMIriLJvd/O3bzZz1/H8dn/K9SUX+F4PceQVNChaFJuHcrEcHhf7TYH6RWBJdWGQiN0GKveBVH3aD2V3hdTGnuuvOe/wrOYa8h8Qtn5VSqz5WVEEadYYbT3aZJloJ6aAz4NI87RKdVawpwvGpRk9OqwlHreSOIPcjgDICrGbd5SRkY7UwRTEldvnCipHTIZad04M5FGRfluVFxVCwtxCXpiGEhP6djY28AwD7KHN5595iV6X/i1Xpk/J+VEtq+ecr85mMequnlczuPUgm3QcKdRTiVbg4nv/4ArvYZIetytv0doSxC0jeRX+YAhW9Sn2i4BTVJRTBFLP3WcoI52TBAfsrGt8IKDnU2Gn3Ei+mkuDybl1i/N8NpfdYBYw0e1qe8cCz/OHI+rCX7Nm7E+6APNoGSA+noADln+TYQFk+OY6/6u1X8257CHz6Jouv+5UlG5g7EJXGycrNornK/8blX/Vp8VyTnxpm9LKUmuLPpFQiezik/y0ktm9jbJHBBfa/AjTa2eb4fXSzgqIumlyRuiLJZEyisjtqaP40G2DWHBzwO4j0lBHZR9drsThBceNioq366JU1ulyGXpwg0d5hrkqbO4X3289Oyr3msWVo/lnmxOIGoXi7UP8ydaZvNRsp1sm6bMP8YBcfegMEt/h5e0BQbTImLTr1+iQAK/JnSeKpYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(4744005)(6486002)(44832011)(186003)(26005)(5660300002)(8936002)(1076003)(107886003)(6666004)(508600001)(52116002)(4326008)(86362001)(33656002)(6506007)(54906003)(9686003)(316002)(6512007)(66946007)(66476007)(66556008)(33716001)(8676002)(38350700002)(38100700002)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OdWQvJswrKl5yItBeb4DC5srumjjNKAIthPuQSocUZQ1mmjTjA9KTa/v594N?=
 =?us-ascii?Q?IIjNZWGUVfPnGwD2z7UgrjGVe4UKsW+CDcpw4csyplrw+VxwZPrZn/JCYF6H?=
 =?us-ascii?Q?d0s2mPT+K8YVorqct4LMtpxqt2igBc1cYyYSbCXofhppApBYhxpScOI04IJv?=
 =?us-ascii?Q?vukN4MiYPVvYFzaKTiC+E0gn1burLvccE1UGnVtRYTMR6xBDbix+9CTiPRN8?=
 =?us-ascii?Q?4KH0V6BQbAf8iX7ppN+WD6ugc6mQePF41Fk8WFzoeV/WizisWA4oTWYExrby?=
 =?us-ascii?Q?Yp5gsMhhSqQwCScqftV434nB4U0GQN1g0mMsLaI5g4fL0+saarbOaS0W/vvF?=
 =?us-ascii?Q?jM2FMGJTKsz83qO0C0LKK0iFcL/nkDiQ3UuiDYeKLIx6RBdKC8iYItdOZ4c5?=
 =?us-ascii?Q?OSYS2TOj3JXYsfhjhCrL6t1JcqcwBU9fjmV+CGQ/TH9oXaFXgNZCPYLHnDaY?=
 =?us-ascii?Q?tQuIuvB1aLdsX1xq9IkEkmVNXjlVW4JE3GynpjtcVxAQj+MR/YEqdWvrxoJR?=
 =?us-ascii?Q?I6yHL+N/JW49GBamGaNY641Hfvgw7QV5zWoA38mtOXLY8g1/pXoMThRKOSIG?=
 =?us-ascii?Q?Wpq6FpImJXsWscVM70guSxueoh7tlLxF2QzLwt8dLGv3wGdKPN+UfmwoSxzH?=
 =?us-ascii?Q?r71WXdWil3ewlAZ2tJRN8HIZtNGXMnp/nYtuu1LkucNHPKMjvQ0jaRMMR4mk?=
 =?us-ascii?Q?65mxzfSB4Ff9qpkvvEmQmMiN063DMs7sfSgooedoESpa5O6kaykfSRnnBWf4?=
 =?us-ascii?Q?zhbJ+4ojJYdVv5I/SagBWCHtAIlCzsLAqYOvO0VahyjssjwcWKR4QbzfyO1O?=
 =?us-ascii?Q?s5YCHRB90CBJy0urtKQxvU3TFZA0xD7Z1D7vPVndk843GJ+78LLSNyXs6X6R?=
 =?us-ascii?Q?vtyyxE8neFvgPgcOj57W0tD8mlSTyVlehaLqkEX6ugTceMHqc4aazGye3yWu?=
 =?us-ascii?Q?UmRAMbON6lmdwdHTdv6XLxYNfxb+QyRArfvNSQuqCYyYQ+XdIp3tt/KOtHcs?=
 =?us-ascii?Q?6nJUzS7So/PB3xkYjU/DhcvWEMOOCpnyU8NOtV1UCd6FLrh0CqnuJEykKzZ4?=
 =?us-ascii?Q?4IWJEiakOwnuHpIWQr0l7shEEsBQJH/VBaKuIt/judArRakEM2aLl3gbbINO?=
 =?us-ascii?Q?MuDjtWM8catuNgaGz64w70i76lacqYjVe5AD1pX5B+uZVY5u82Yoi8/lm2I3?=
 =?us-ascii?Q?eakSbS4XcbnN5oZbThszxvxNjwdHOeI72E80IC40EE/SbMniKfKswoE28YXY?=
 =?us-ascii?Q?TIvU3uolIPER3WZwh7hTlsR/MT9QRXVcrdwblyE3tNsewEBqaIfCzqceOQGT?=
 =?us-ascii?Q?gRRWSBHqDNAPb1eUM0UlO/Q4z6Ic47TQezlBS47z1bKcIZEz8y68zH9o3vUI?=
 =?us-ascii?Q?LKKPsrrlOy1CW9q4jz4JJW/gGz36X3Qc6gKPneds2seO9zPCGcMC3EIYjWa8?=
 =?us-ascii?Q?wYs+UCvzROTLhm6oCXV9sr+zYRb7GwiyF4PrCvSi6apexwrSbpliPw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a72c02-6b1f-48b5-ca05-08da069a22e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:40:30.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjXULgjR78L0zWMKeSIyYQmcviwqJsE0FWk2KBVXqkaa1HL/nLJdCj1mvTmGg48sm1wcsHDy0zkyDfjOol4qb+50K0Ts5kye5FAisU2wv1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203150101
X-Proofpoint-ORIG-GUID: QhyV_N8ghT14ENEVRwleoKeQun1pMRbf
X-Proofpoint-GUID: QhyV_N8ghT14ENEVRwleoKeQun1pMRbf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 15, 2022 at 03:57:36AM +0800, kernel test robot wrote:
>    In file included from net/ipv4/ipconfig.c:59:
>    In file included from include/linux/nfs_fs.h:31:
>    In file included from include/linux/sunrpc/auth.h:13:
>    In file included from include/linux/sunrpc/sched.h:19:
> >> include/linux/sunrpc/xdr.h:734:10: warning: result of comparison of constant 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
>            if (len > ULONG_MAX / sizeof(*p))
>                ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~

Smatch also wanted to send this warning.  I am testing a fix to silence
this warning in Smatch.  It looks for an some_int > some_expression
where some_expression has ULONG_MAX on the far left hand side of the
binop.  Because the some_expression always starts with ULONG_MAX and
then divides it and/or subtracts from it to get the max.

regards,
dan carpenter

