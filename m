Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045854862F2
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 11:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbiAFKab (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 05:30:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60678 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237059AbiAFKaa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 05:30:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206A4trN013467;
        Thu, 6 Jan 2022 10:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=QOIYCO5Mq/8wgW+ma8KCHp8s5yBJ0L/78FN75t3HCp4=;
 b=ty9/HpUD6XKEfj5o/akhI7Jpamiq2dbjUWuCcp48poCDRgSOTDH/S4QukDonxEeP7ZRD
 CvOu9ulqdbLzhimaRv/IVihr3EHyWifB1NjgA2NKfWXgBPx2Dv6UkVm8tz5SaXadKGWf
 zAV5vOJbwHWoBCDeNqRWy/VbPDqj3RVj13i35WwP6JfGNP35tYosxdN7tnsRCAE+d2VV
 1A7WDKrqfDF2s1mk8p/JgiiPL9MXhC6i0+OrQbyv4VdHZS6iwmor96ECI4t6nB5EJy7z
 yXWgLQEtJ+u/zHrNHT+9qxn0ELvOZ3ILOMfQlH064skm0CVuDBKeI9EB9rLgD71neIF6 Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ddmpmhb1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:30:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206AUCtH019303;
        Thu, 6 Jan 2022 10:30:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by aserp3030.oracle.com with ESMTP id 3ddmqhdfjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 10:30:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0+/yGN2XP1lorZHWKM9VxQ5vkEVY4XYOVSSemc9cMsQk/Ayk8bAcBjWuHwZ+JKTdxF6IXyqXkfni+S02RpBEb3qwEn0gnLzXwo92he2WdQILyCrprmGR3cQYKskeuMx+vW9rQR061EYNfI4A8v2L3SgHEmEq7HWTES2U3qP2AYLs/Nlnu/zA8maMRC3fywuuCwJF/A8UVJlFdX+0FbSOOk7Oi0uu/E+OY8LhiI+MaVoLNMBFIiladl1ccB6rl9b8HpbGGtKe2xMRE5W/q3j0R5fpvEgRPUV1buVte02tNGfvf+DN0U8HKPG57jwARoMMntHxeUPHnpvdOaJL2C7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOIYCO5Mq/8wgW+ma8KCHp8s5yBJ0L/78FN75t3HCp4=;
 b=bEqp+RmbVOjgvhwE+qn6o08XJMP/1H++Rf3ulU5UrbMDYltIQ3OGgLNYz0uZg/EYwhww6tQiLBTwUiCMIP3OXcUWImggoXuJsM6y/Snbk1T5GGaBm67bmElXnO0/4oKckQF67FGN6XEHfHCSQGvgwdcrjYe9kmJopYrTfwz7nMe5K4ZjGK6Sapjcp38klfpKypNqXs7RycMDYJ0W38nOdT3RYcRiWhnWc5pE7ZIiFGQgG2oMkOOoDoM9Ie9Gdw/9hIXSzhLN1s4tjINbI57SD65Jmdg/DwbRhE00Dixa00g4gu8vT9uG5ig48fVJzO/gIpi1JgHsq5jV3DQgaRwlJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOIYCO5Mq/8wgW+ma8KCHp8s5yBJ0L/78FN75t3HCp4=;
 b=T3pqct/WACJB09fUuJLCkHAetQEMmTePN57dZ2FrS7w1GYLq2bZI5BM+3xsDW/8svNJ4UJtdpCciXj7iHTCYj+Kz90Fu79z+9EXvnu5VaPrSyvz6TM2DgXWcN9bXwWrOXlPH/yT1/vc95whLoxVQf7ihytPkxTwOqOjz6QowmQw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1885.namprd10.prod.outlook.com
 (2603:10b6:300:10a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 10:30:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 10:30:18 +0000
Date:   Thu, 6 Jan 2022 13:29:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vasily Averin <vvs@virtuozzo.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org, kernel@openvz.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: local_lock: handle async processing of F_SETLK with
 FL_SLEEP
Message-ID: <202112281211.SsWl4cfI-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6613b17b-43bd-07d0-2ca7-1581a39cdf7b@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48cdbd5d-f290-418e-4b3c-08d9d0ff8884
X-MS-TrafficTypeDiagnostic: MWHPR10MB1885:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB188528789E42A542CE699CE98E4C9@MWHPR10MB1885.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0xXOTttXXPpYgPiyIvsMrxLFmxJ0I2YyxjFflee7a6vn6S40IokXAMjE8+APEsoy4s51wLrwx9Og8xzFHsGZ56+Q71MoN8pe4hhDYzYJD9M6wW9o8IrGc1WZrUKGg2WcovP5IHINIQpHSjsmQ5OVQcW7FAJc2PJRjIdFk9oXrPGTou/P/v/4xIeVeU0kiiHH0Ux/oQKOwY8UdiKdGN2kXlPjgJuh0gapwJ4gIO/WWwd0Oun9R+g28tiokj5bkJaryYMP2eHUcwqcOiRW1dyW1k/6qeLBWscQDCT9lz3q7niMXRsP6oKlrCh/6kvUXrBjIr+EbcQT251fePAHgna8gdr0ow+ySqEBgqYIq4OClJTmoO2VfoBITiE9pW7Zhn0O3XVw1brFpant6uoaRmOj3KTHQdotHa16HtC1h/TcYcWNvFWY7ioz0ieXIGvdPlMBQOJ9fX/g9fTvzCsyKa63gRTe85Y+rQ7Wf8fMa0f4vf71h+BtzFB+NoW3Dh+P3fiNqwP/GNHBEsa6+DbEcDDtMxO1/Q3PAzU9hktFAuTYRNz5JwO4ryqi4y6i60WEXfmujk0i2OvrwaCDnS4Bs5Utfx+IGpWSm+ycc3K7E40dW3Ys89l8yZW9Ba3/vUMH6dntAjuRyn7WyFLwIoPgg3j9WabLi6FM7PaXFbZHGh5heeG6AluPUl0FfUlbyMD94qYw/A7qnavmvINMUAH70TABeia2mjMGBgvQ0piEk5WlLaxeBR7l+JaFAYGcMZZXsOtYEtGVFA0WkwsVHFmlzbW7ySTn6tP8B/jykdg+JwdaRZVZqrNydNLxngqf96egx6aeZGv3bHZxUwwSRDbWmxQsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(508600001)(8676002)(8936002)(83380400001)(1076003)(966005)(86362001)(5660300002)(26005)(66946007)(110136005)(2906002)(6506007)(66556008)(66476007)(36756003)(9686003)(38350700002)(44832011)(38100700002)(6666004)(52116002)(6486002)(4001150100001)(4326008)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNGSxBhj1I1s+QWvsjkWYpN1HEVFzkAmwDUe7EqBz0OvKwnaZ2EnjIYZ/Go2?=
 =?us-ascii?Q?xrxeGu1LlXdzLVoYKOQipJoYdo9pKdFF9XWZZyFxFZaSvV4ryRiRFBw7eTYA?=
 =?us-ascii?Q?RaoQP0otjv8tukXXTiPFYx03oRgSsU6Bv67GDTy7Ma7/F0ptVo96EvcrDFwu?=
 =?us-ascii?Q?h5+RkJtYODmosVqF54sm9uMJJ7cX5J/84wYbUEHdRorBCSRedT3L0CB7D+Am?=
 =?us-ascii?Q?7ChiFtyNjs85OvwWJuS+8UgneB6mTYBgLv3opRX8gv3QoUAKOVTe73ON4lOP?=
 =?us-ascii?Q?EjmpELPEpCSy+f+QegHZLcx+a3hmbbsSsqa/gf1OhXyWc4vW9FFMiacUFk1s?=
 =?us-ascii?Q?gHmcMInNBDXmPjeQU4z1ONWRWPzDxtcjsJlE/Y7LXXQfviFgJFCzGYhdQRvA?=
 =?us-ascii?Q?cYlQYndiK78QV/y4bFJafmoTHqcfGjWVeNBM6MpPZuHKbjLZ4fsokYW6Nf2H?=
 =?us-ascii?Q?5/abiwuyoiJVZJuQkdOFBcIyi4jCR9ynqQxHaVlUfcCr9KIHnsIQ6EXl5y40?=
 =?us-ascii?Q?sQDcOA6qKdkSe4G0VLgTmlESA3nxdy6eZ4T1iFtLQ6THKq/wzzL4eThCCaoy?=
 =?us-ascii?Q?wCnQWTPccBmrGLmargO9HBsma+w+qSH/nrsDCCyfiq3P/WFkbmiOrDdeXxo8?=
 =?us-ascii?Q?IDXRRqtSUpmHdKfSYDleMKSx7sDtneeUDE68eOxu9Tz6mqhhb2Sdl3XEkeGa?=
 =?us-ascii?Q?yy1L6VOD/6eV3RAiPQJtJBZHxEgMnJDyy/+lgCf+fIW327mmrXLDbkS+7RkM?=
 =?us-ascii?Q?YBZ3hEPy7DqBmVJAdxn/VMfhfw/DybXbkLwfV8paznA0dCUvO1/AZmPklDp5?=
 =?us-ascii?Q?wNwCUi3dH+0s7JwHToQxT14wyL/gM4xByKsnBJMAZmWk0zzyyXLeaHP4lIMm?=
 =?us-ascii?Q?uUQ7gKt2038GK7Ui94laa91+pHPsrlYgiF3kVWhX0Ojw6goFRYTDRysY6Ta+?=
 =?us-ascii?Q?Ln1aRSKRfDOya17EXUivUfQCTapbXtcazJllASzc6CAGHSiJQ3LwAEpgoRu/?=
 =?us-ascii?Q?Y/o2Jyt8SS/k70smF3KWniwjJhrA64dB8xaiNDjWU+BN3G3hI9ZxzqSepB3M?=
 =?us-ascii?Q?XMiQ7Vqbee7CMvFq6w7CpHMlu7sUd7JsveWpZWxfJKxf9JBkfjO8/uxCyyZg?=
 =?us-ascii?Q?gN363z4dp99aekidpuQ5F1doT+yUbFJSjjnLCcjRO6jOZeqbDm79crckClO8?=
 =?us-ascii?Q?RNVtut71k2AVwKnKBQ6ylsQRoVW6cNRfFqvPTfbMxk8pugUvzqrjMpt7tb9W?=
 =?us-ascii?Q?mE7SB9hPd3ycJet1kDSZdV6hpyZu45MyPnT+Ep3Hw4y6VdwStvmwj7AcfgsW?=
 =?us-ascii?Q?+WOOff/xyD1nU6tVCOZH9/sLRjmgJu7SfxTkfFVBn32hdLdynPtcAO4rNuFe?=
 =?us-ascii?Q?wDTkgY7gi1i/SGlsaT5TNAMB/KNC8ZOBP6HGI1bMpab5TZfuK1Ho6jmgXTFH?=
 =?us-ascii?Q?eGyJo6fddKZV49TlZVgAX58fALbx49gjKskc3LCfar0fA/gviJlth+XtmqEW?=
 =?us-ascii?Q?fkaaOox9FubNcwcrXP4J/jLTlN6u8yFEUwhbz/nySQ5ICw6x/Z5bovjN0pCq?=
 =?us-ascii?Q?4HFKH44I8eAfYsIVUDQGqyHz8jbWaB1qXUZGZVrkxZKZQF1lqxf1hT087YqT?=
 =?us-ascii?Q?1JbWYdOjP7bW9HcZPVN8j5HcZgmNjo6kRR0aIt3CoaUbBsDXJfbbvpAHKGeC?=
 =?us-ascii?Q?aUEk643nCy+yY5AZUtrXRFSt3Fs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cdbd5d-f290-418e-4b3c-08d9d0ff8884
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 10:30:17.8994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TY9kybB+1WM/cvsxSkdiWizx1IxEFGfgXS/aYPQ8kEaATU2jNUBoTPE5Mk/pDxIGKLuLtsNLc8DBdmPyY8pRxW/BCJOaT0VSo8U1Pf0jnCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1885
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2112160000
 definitions=main-2201060074
X-Proofpoint-GUID: w-csOos1BsLRa7R_bJm4ksyPkLfEHbEU
X-Proofpoint-ORIG-GUID: w-csOos1BsLRa7R_bJm4ksyPkLfEHbEU
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Vasily,

url:    https://github.com/0day-ci/linux/commits/Vasily-Averin/nfs-local_lock-handle-async-processing-of-F_SETLK-with-FL_SLEEP/20211227-184705
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
config: i386-randconfig-m021-20211227 (https://download.01.org/0day-ci/archive/20211228/202112281211.SsWl4cfI-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
fs/nfs/file.c:772 do_setlk() warn: should this be a bitwise op?

vim +772 fs/nfs/file.c

5eebde23223aeb Suresh Jayaraman 2010-09-23  752  static int
5eebde23223aeb Suresh Jayaraman 2010-09-23  753  do_setlk(struct file *filp, int cmd, struct file_lock *fl, int is_local)
^1da177e4c3f41 Linus Torvalds   2005-04-16  754  {
^1da177e4c3f41 Linus Torvalds   2005-04-16  755  	struct inode *inode = filp->f_mapping->host;
^1da177e4c3f41 Linus Torvalds   2005-04-16  756  	int status;
^1da177e4c3f41 Linus Torvalds   2005-04-16  757  
^1da177e4c3f41 Linus Torvalds   2005-04-16  758  	/*
^1da177e4c3f41 Linus Torvalds   2005-04-16  759  	 * Flush all pending writes before doing anything
^1da177e4c3f41 Linus Torvalds   2005-04-16  760  	 * with locks..
^1da177e4c3f41 Linus Torvalds   2005-04-16  761  	 */
29884df0d89c1d Trond Myklebust  2005-12-13  762  	status = nfs_sync_mapping(filp->f_mapping);
29884df0d89c1d Trond Myklebust  2005-12-13  763  	if (status != 0)
^1da177e4c3f41 Linus Torvalds   2005-04-16  764  		goto out;
^1da177e4c3f41 Linus Torvalds   2005-04-16  765  
5eebde23223aeb Suresh Jayaraman 2010-09-23  766  	/*
5eebde23223aeb Suresh Jayaraman 2010-09-23  767  	 * Use local locking if mounted with "-onolock" or with appropriate
5eebde23223aeb Suresh Jayaraman 2010-09-23  768  	 * "-olocal_lock="
5eebde23223aeb Suresh Jayaraman 2010-09-23  769  	 */
5eebde23223aeb Suresh Jayaraman 2010-09-23  770  	if (!is_local)
^1da177e4c3f41 Linus Torvalds   2005-04-16  771  		status = NFS_PROTO(inode)->lock(filp, cmd, fl);
00e7edbaaa914f Vasily Averin    2021-12-27 @772  	else if ((fl->fl_flags && FL_SLEEP) && IS_SETLK(cmd))
                                                                               ^
&& vs &

00e7edbaaa914f Vasily Averin    2021-12-27  773  		status = posix_lock_file(filp, fl, NULL);
c4d7c402b788b7 Trond Myklebust  2008-04-01  774  	else
75575ddf29cbbf Jeff Layton      2016-09-17  775  		status = locks_lock_file_wait(filp, fl);
00e7edbaaa914f Vasily Averin    2021-12-27  776  	if (status)
^1da177e4c3f41 Linus Torvalds   2005-04-16  777  		goto out;
6b96724e507fec Ricardo Labiaga  2010-10-12  778  
^1da177e4c3f41 Linus Torvalds   2005-04-16  779  	/*
779eafab06036f NeilBrown        2017-08-18  780  	 * Invalidate cache to prevent missing any changes.  If
779eafab06036f NeilBrown        2017-08-18  781  	 * the file is mapped, clear the page cache as well so
779eafab06036f NeilBrown        2017-08-18  782  	 * those mappings will be loaded.
6b96724e507fec Ricardo Labiaga  2010-10-12  783  	 *
^1da177e4c3f41 Linus Torvalds   2005-04-16  784  	 * This makes locking act as a cache coherency point.
^1da177e4c3f41 Linus Torvalds   2005-04-16  785  	 */
29884df0d89c1d Trond Myklebust  2005-12-13  786  	nfs_sync_mapping(filp->f_mapping);
779eafab06036f NeilBrown        2017-08-18  787  	if (!NFS_PROTO(inode)->have_delegation(inode, FMODE_READ)) {
442ce0499c0535 NeilBrown        2017-07-24  788  		nfs_zap_caches(inode);
779eafab06036f NeilBrown        2017-08-18  789  		if (mapping_mapped(filp->f_mapping))
779eafab06036f NeilBrown        2017-08-18  790  			nfs_revalidate_mapping(inode, filp->f_mapping);
779eafab06036f NeilBrown        2017-08-18  791  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  792  out:
^1da177e4c3f41 Linus Torvalds   2005-04-16  793  	return status;
^1da177e4c3f41 Linus Torvalds   2005-04-16  794  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

