Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3694A53BAC4
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jun 2022 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiFBOap (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Jun 2022 10:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiFBOam (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Jun 2022 10:30:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B726D248;
        Thu,  2 Jun 2022 07:30:20 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252EIoWI021177;
        Thu, 2 Jun 2022 14:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=hrnkrU8f6EqnRgLJ8bDWxeDuLro3nh/hoVuWT2TyYDg=;
 b=kUAEXs4WAFm/tcHlPuaOrMx0DGHiY7Mt/hsS7uq1Nc7kyLJIn7G5veUOqSXzP3rUyEHW
 W8kZta0WF4C2/20tHrtifdpwmqZ4bWWt/TKB+iFPk4qUeTvvC+YiI/IdBNDM+2LeS7nC
 KqE1iAPNL5pSXO0fevPLNkL9++F7xDCUG2UWALHm64gxAV7zvljk1BnP8wzpcCnNbFU/
 Q1auaa65Jb1B6mg1c8bo6/CMn9bur7PkvxtRKqf5QJAJiKPs5DjgDP27ksUv+WtmCPlW
 wWBjisp+pPOCagWKI21uXlKpkj9MOCen+hiCVGZUFo8k/CIvAyg7rRaPIXH2EcgpNENM QA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahtm35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 14:30:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 252EG1bp006796;
        Thu, 2 Jun 2022 14:30:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8hv55xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jun 2022 14:30:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ4iA3k9w+UXCLkZdqqT+R1jRLp2Yx5wvNKkav58PNEnHiilfaipK4CqOCxncqVw3WkYMdr6v6qnWAtZK1zDtmTosIe5TJccKTpEdaiUBxNRdoQmuoU1OOsTWEGNg8ybg1VluD+2tOFtlxmHjJG76NXQb7hX1knxCzZ0nrpILE/achNuBCS5Tk56wqtleM8K7UkAPg1pZsZKivDY4weXE6mPmDSOtVN5sIQV7zD9edcgdw9SaHIJhsXcBOBzm9VAZZJSXAxNw3x04PYexFYRvrrec5yz3dQfxceVP8y0Avowj4Kvo8EgNMv6Z6VQOD6kxk0tHVHf2TPQfv5Cpx/qOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrnkrU8f6EqnRgLJ8bDWxeDuLro3nh/hoVuWT2TyYDg=;
 b=m8aimufXruUCY2Wc0UJWyrvonRdmZS7cRx5E2MKbgFppCJKa25lJKhJr0VW2OtgoeSUplPxtqnea56Pg48ZWA8xG6PjaJWwJZEAC8MhXTwGQth64U+GuDk/UFZClowWOKNumsmmuE8iNUcN+m/gSU7EXIeWJ3/wMV5hO0etqgRLayMFbKDqZng3FUShjsJdKHTnHObhcGiFtI3tLvGH4z39CHOWl4sdiwqrAV9M64x+BYIwzzB++ghq3tWX8vHnYAG2/VS63cEDISo5nPaJkcKMt5EQu+5fc+qOJ01InYnX0wQDkIitFw6TX7cqaVt8n+YkqBJ0zn0N1eXmbR9MR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrnkrU8f6EqnRgLJ8bDWxeDuLro3nh/hoVuWT2TyYDg=;
 b=NyKee41RkEdmX61c1lNkVh8+NcPF7VmhEGKdIql1lCemmb7Isx7iTX9z5jhpiSYD93q2JjI5kVPWO1MxTPJ5sThkYfvjOv2p7mi/ygSe5naj5xdrcOFfaVgzicLxmnFzi2WRBDvzW4esstc1TeOIX5mpzPaSagwTuLLVYRS/OYc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB3163.namprd10.prod.outlook.com (2603:10b6:5:1a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Thu, 2 Jun
 2022 14:30:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 14:30:00 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dongliang Mu <dzm91@hust.edu.cn>
CC:     Dongliang Mu <mudongliangabcd@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: make destory function more elegant
Thread-Topic: [PATCH] nfsd: make destory function more elegant
Thread-Index: AQHYdo09HHF+lznAoEyCcgvo6++r9Q==
Date:   Thu, 2 Jun 2022 14:30:00 +0000
Message-ID: <53417E03-4D3C-44DC-AA8A-5F9FE340483A@oracle.com>
References: <20220602055633.849545-1-dzm91@hust.edu.cn>
In-Reply-To: <20220602055633.849545-1-dzm91@hust.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63ab0e50-ab96-46e2-be4f-08da44a45ff4
x-ms-traffictypediagnostic: DM6PR10MB3163:EE_
x-microsoft-antispam-prvs: <DM6PR10MB316392B1652AA1A6F7536D0493DE9@DM6PR10MB3163.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h9mMzXIMlZyIDre50U6qcnd0tqVgeLVyto+n8btZJ+fWAhHoWq6OeJZJSfsT1xgSbCxS94nm06X2a/+XNNVjo4W2+4H2u43ALu2KtxQe6ZbkJ+4lDqIU4qUYpCRKWsMYYpXLaL7RChD3AEC8D+bp53vZov4yTD3j4g/JmPZ1zRMyGhCSxUXZhh7BMJxFBjDvTkllWuZkB2VhvzurQRWJfVbaBJP/h+Tr9qMUez7txaO/G2ZfsPiXyxomvs866EHfqdU9iFT9HSFv/iXww5fvDWk+3J1flW/Lfbeq6ZDFhbpVPXLoBQtQ9shws2ZprEUjq6MssOcynclN/wv5eFIULdA60FsQCpH3A72FIOc4HmQXJk6nBo7UyLiWxPYWDZI0dThramo4TRcAOEnd5IvUsdhMRTyh/53FC2K53doCU5Z+mSoWzNLQABVjuDcb8aXE6o0WIi4gRMimBO0RRaoYntuXLaWPkgRhM/luM1zXOi+yrLGMyOt6HWLF9tcKihlXML7nFOS4b0xZ8F3/yZHxqZLHbteZOIj4YktCI3FgbtqvT7/uPuLCI0kVPM34q9EZvGMbIBrTKTkAOHlGNMIt6HkmEZCShM/KIwtF0Ubw4BjXiD3R8RW0F++wYglvhGbo4bIcsYpzSKWadaPcjP9owrWMZxaCu5F47UorlLFHeu2c4/yh6jxzo5cvnnUWFLm71CmMcUWNn+HQj33/mP0npmkNXAAWmtOxfq7J1yBTgQvbMMMBKJASNge4BsTnmnmC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(6916009)(122000001)(2616005)(91956017)(36756003)(54906003)(76116006)(66946007)(186003)(316002)(508600001)(8936002)(4326008)(66476007)(64756008)(66556008)(66446008)(86362001)(8676002)(38070700005)(6486002)(71200400001)(5660300002)(83380400001)(6506007)(2906002)(26005)(6512007)(38100700002)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GJO/E3EckOE1K0aXIquEOSfvWp7mhOdXd3hQQ+JtGXP9QPQ0mgQOWuI2wdeE?=
 =?us-ascii?Q?AL8taBex4ckQl1CtOX/EgwcShxm0cUPznsTcDimc/L1bD7l1UeS/eVX8O5QP?=
 =?us-ascii?Q?SfyAi3ohrRAdTAuYeeNkf/+zApoIjulpNjVHr+sNMuonz3p0l7Mnm/CrpRfN?=
 =?us-ascii?Q?jEAneG+GGErx0j2aqHWtLFihskRKY42guyMqkRREG0G6P32gnV349HrZtLZf?=
 =?us-ascii?Q?k12zqyGHnxbTkVTLTildRTRxAHl/eQp1ct2St78LsWKqAcSGFzeWDjF6WAYu?=
 =?us-ascii?Q?rU66MnjpjRq86i3UGPU+L2y22ltW2hb/n+XhvLVZ3KSHi2dvdiHX60XG2ykj?=
 =?us-ascii?Q?hqQuFSIE+mLg7Mt+1XVV4J7ewri0ZuYOkb+utZpw7ym8uCYzHK8G7sNbhJLI?=
 =?us-ascii?Q?X/gP2hO5AbsrydS67r8EJwkWRgsDg7YNC4E0WUFDpMFc5efyp9Dh/r2HPdYq?=
 =?us-ascii?Q?S+jOB+sv7UiywGoIC5R/GDcUejwh1eFNTkc3D6erZCnRCgKbInLbWrxMRkYb?=
 =?us-ascii?Q?6xy1i8p+lEMaIHKjxKgO2nblXteLrK5VOlEI9PsNRtWBmW13SFiIYncVGi9a?=
 =?us-ascii?Q?BOlGULo0usru+XKnlMR56WiOXtAvdxnewzluQvpcG5te8xup1KncqWKnhEUd?=
 =?us-ascii?Q?bcTu6L0OhWMIfQD8kpk9woTlS9QJKduIw6Yqnhy+lls4qrc4AbfcyK5P8lQ/?=
 =?us-ascii?Q?hABzH9sobh+GuDq9V4ajSo9lbpmJrXUMelMbA4/IyOcvETRfZYeF2DrYE5tv?=
 =?us-ascii?Q?rC0Rj4x2cXh10IWnYyFWxJo+m0a9ZmI2jMch9Z639s+lNIM51h8yA2MfNSYt?=
 =?us-ascii?Q?k/9OASBjxfWYGIkBIA0qxO3QEqjjJGPQ2aFCRogrbNjLFuu/XQxdIvxSllEN?=
 =?us-ascii?Q?iBZAnIf/V4bfj683AOpIqoGjay44T47UCdoJ0sqrgkXRQA0wtquZG8Uj0CoY?=
 =?us-ascii?Q?4Vq8wSrOXPb+KMKSjXc5VH0riCUUMZ5GxMQznyfx9r5LXxsgPVcrvBXVgmvY?=
 =?us-ascii?Q?Bhs2lieeUz+1HwSqzTNAoYkFvxvvd+ns+GFgwJ8yHVGfyd59epaQeyKnvXZB?=
 =?us-ascii?Q?W2ZWY+u6WNelmDPKz1TeLaG/5K6F9mXJaG5l0ev4oPHZJ5/Sl6eKWtIZyEEu?=
 =?us-ascii?Q?Xa/ynFJiMPQ3alz8qKyHD2rQ+vDvxBn9rhmZBoeISLWiq666QN84HhEDHFl2?=
 =?us-ascii?Q?HxENl6ZkC2urtLYsk1HPc199AUeccCLe4di6f3yWnl209IbeE3sqwYzA/G+2?=
 =?us-ascii?Q?CoV7dclHgskHX3PiEqqvNbj1QATkzbMbqjj90WDr9hX/vP51HoY4eCU3KHT5?=
 =?us-ascii?Q?Gku9VLY3W/vD3Fn/SX6GsXqDH8QXjO2+nX5rIwVXcyeXjPf36kbtVzd4F3EK?=
 =?us-ascii?Q?ALTpihsR58TbTldpdUbg/dDRTPkFSSfimoLaqF5h8Ih/H4beuu3dBVqFiIGI?=
 =?us-ascii?Q?GLKJg3i3Q+1kor2PsF6K5Q2Wwfoqg1QE9zt6S1OJvE+PLLPLrnS+H57nSkp7?=
 =?us-ascii?Q?Rx/EhwaP7Y/R/qnvLKPJSz4fpjGMvqL9AuwxdHeSdA1BEEi9GO1t1YuOS1mk?=
 =?us-ascii?Q?9Me0jtg8jCrXw86p51sQw/+/l51yi5vXC86KcxmZMLhX04KE46jhe11Xv5Jy?=
 =?us-ascii?Q?h5WZKAv7DauS5uohL7gmrOeeHd+dAU2++kMuepgkqOQSXxkXd0/HaYw/TnZg?=
 =?us-ascii?Q?SrblTIfissjes866fFi37CNqJb/Ix8m4rSS2DM45bwX2iscX3cfsvR1C+za7?=
 =?us-ascii?Q?a/8KgkXx/mYT4FMr8BzNZEfbGMmBYMU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <977298A5C8DE9043B2C0D1ADE8FB4C6D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ab0e50-ab96-46e2-be4f-08da44a45ff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 14:30:00.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAdCpTAKQ8pwNcgx45kGYsolURhfrIqcMuW7KOLzJUntQUvFkcbj2zTj/S7tloMBjkUZ29qy6PluJm4LQg/pZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3163
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-02_03:2022-06-02,2022-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=962 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020063
X-Proofpoint-ORIG-GUID: izMy3Cyc_skB1_MbaPdZxP0jOf4Mmj2P
X-Proofpoint-GUID: izMy3Cyc_skB1_MbaPdZxP0jOf4Mmj2P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 2, 2022, at 1:56 AM, Dongliang Mu <dzm91@hust.edu.cn> wrote:
>=20
> From: Dongliang Mu <mudongliangabcd@gmail.com>
>=20
> In init_nfsd, the undo operation of create_proc_exports_entry is:
>=20
>        remove_proc_entry("fs/nfs/exports", NULL);
>        remove_proc_entry("fs/nfs", NULL);
>=20
> This may lead to maintaince issue. Declare the undo function

"maintenance"


> destroy_proc_exports_entry based on CONFIG_PROC_FS

IIUC, the issue is that if CONFIG_PROC_FS is not set,
fs/nfsd/nfsctl.c fails to compile?


> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
> fs/nfsd/nfsctl.c | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 0621c2faf242..83b34ccbef5a 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1450,11 +1450,21 @@ static int create_proc_exports_entry(void)
> 	}
> 	return 0;
> }
> +
> +static void destroy_proc_exports_entry(void)
> +{
> +	remove_proc_entry("fs/nfs/exports", NULL);
> +	remove_proc_entry("fs/nfs", NULL);
> +}
> #else /* CONFIG_PROC_FS */
> static int create_proc_exports_entry(void)
> {
> 	return 0;
> }
> +
> +static void destroy_proc_exports_entry(void)
> +{
> +}
> #endif
>=20
> unsigned int nfsd_net_id;
> @@ -1555,8 +1565,7 @@ static int __init init_nfsd(void)
> out_free_subsys:
> 	unregister_pernet_subsys(&nfsd_net_ops);
> out_free_exports:
> -	remove_proc_entry("fs/nfs/exports", NULL);
> -	remove_proc_entry("fs/nfs", NULL);
> +	destroy_proc_exports_entry();
> out_free_lockd:
> 	nfsd_lockd_shutdown();
> 	nfsd_drc_slab_free();
> @@ -1576,8 +1585,7 @@ static void __exit exit_nfsd(void)
> 	unregister_cld_notifier();
> 	unregister_pernet_subsys(&nfsd_net_ops);
> 	nfsd_drc_slab_free();
> -	remove_proc_entry("fs/nfs/exports", NULL);
> -	remove_proc_entry("fs/nfs", NULL);
> +	destroy_proc_exports_entry();
> 	nfsd_stat_shutdown();
> 	nfsd_lockd_shutdown();
> 	nfsd4_free_slabs();
> --=20
> 2.25.1
>=20

--
Chuck Lever



