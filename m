Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0FD4E2A68
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Mar 2022 15:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353158AbiCUOX2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 10:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348849AbiCUORX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 10:17:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B29C182DAC;
        Mon, 21 Mar 2022 07:12:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LCw9kq022265;
        Mon, 21 Mar 2022 14:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5briRE4OFKx0BvTEv2Sd3ZQ473qQ6o/YA0/GB0+ww6M=;
 b=gsJ2+Ovitmt/pGv5etx0qU7cuvyk2vbXawD2ljoK49zYEVtiAMlASUVCLikjxZpXUvd3
 xr1cUAQ5hpFGNPCj733p9O4S2LYMC6uJX+RYnHep2AX+5CtQBmbc7UCulM3OVyemlaN8
 XlNiz+vQTccGAUqQR7iD2M6o29P3SsFQYZYfrhOiAh7OzYf0tnE1u2+rWcW718V1VjIO
 CxaX59QSbIPgfe2z/y2QWk1gqdc2bI3ThCJyswODdbU/mS57bHrIVoYjNlbebof3IvOk
 46xOgDTiF8YI4DiOCazYqYBR8szV7+tjq+WdbHJwE+n/qi9TiENzOgL4Bpv+NI5QTFFJ 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kckctx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 14:12:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22LE5eu8051632;
        Mon, 21 Mar 2022 14:12:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3020.oracle.com with ESMTP id 3exawgsdgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 14:12:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUoQUdY6i/xa97J7e9uDbrFNyzYdJw31h2V9yOld+FQzSutDUflE4M5QGs2n4/fbvT4q+94IXmrKak/YFtCyuBdGwgphL+7q7M2jhCJA3N3Xsh8Wa/SGgZZ5iQvpCnb4d3NgKbViBo3Avai0IGKdonASJCMT9CBHY8Wvo2CF+5sgT95/SsUyQYwAKlRM5EeoWU50ZyqmzA5LNjVtMX9v5+okZkXFvjhK9i8hO4JGS+EWy2wwOI5sE4MViqAI3tWTXfAeMqqdGEEFVftCxAMUPey1tmVahCkKfJA1VvyE8PuYzVmf610dHJ7vkjkSUXfc9WlE9p7dJqNKLFnH1mL3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5briRE4OFKx0BvTEv2Sd3ZQ473qQ6o/YA0/GB0+ww6M=;
 b=mghtzu/HEP66vvLpMq4JRBpQmKUknrsmhxz+RzKdA9mAhm+VA023X8RPzqsJRQnCu/Op+BLD+M0XqdwcshEyN2/a8eV6/OONqGrp4ih7yYY1czWVYvM7dKWz6JA8gw8O0Wu0IT/+HW2XVE9El+1v4VCE2rD7ZJmTCNg54nge0sbYUJE1Ir2l26z2HLqdpGYEVbaIFgt8QlLbAElUxWm/Sy9Isy9iVEb+L/18vIwgEruGQ+m3iTHScs1QlO2LZ1k3qircfdEPkTlA0W5lmUU/opreZHIgLm7ERbrwHY+3i58gJpMaC14jWVvEZpJMvOwIPw5HoiqL/I/GC8JcIqSm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5briRE4OFKx0BvTEv2Sd3ZQ473qQ6o/YA0/GB0+ww6M=;
 b=ifkXCYkuQNGH8Kimf2ln5q01WY0LXHYpZhDw46htf/1sAtZWGohMHOBv9AnVfXshXfb84/EQoNqDRv5glGl/P/UC/LjJ9x16seMK/ubhL+YoNjFMXZlX5EdWafxpzvJ6bTNXELJXNSXDqCXXCKCGN+Q12FjljDzCuOZGK8kaezQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN6PR1001MB2195.namprd10.prod.outlook.com (2603:10b6:405:2f::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 14:12:31 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%6]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 14:12:31 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] nfsd changes for 5.18
Thread-Topic: [GIT PULL] nfsd changes for 5.18
Thread-Index: AQHYPS20fAQVNPncPEij/Iui6rmM7w==
Date:   Mon, 21 Mar 2022 14:12:31 +0000
Message-ID: <EF97E1F5-B70F-4F9F-AC6D-7B48336AE3E5@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8880ec03-47db-412a-238c-08da0b44d6fe
x-ms-traffictypediagnostic: BN6PR1001MB2195:EE_
x-microsoft-antispam-prvs: <BN6PR1001MB2195742EE6B81D0B5E4FCD9E93169@BN6PR1001MB2195.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sGUPJkNiHc+KFHo28Fbj8/hYkyH/VANpBOTPzZFw2st1xGCIEcnueS5lrFH+2g6biz7TiNdSOTShq6gMArD3xAERXwt5IAajcGc5yK8LtmAusS0PB12Cf/PNWey9RbdzChesD/JaM3SRnIFU9FfwkrsVgesxL9h1u+CJ85h/FZlzDykzIs5x4g+touJGyXpPDK5mruji9L1L5YxCSe/0Z9Sq70xGWJ4xQNFTPmzW1eWgtQdg74GTVPkOCX8v6JrQKtjzeraQWa1KeefIfswtB17hi2eO+QsqQ/9FKrYsQBTDWhECqkWvL1MrmOnazPIzNgtSl4As2cS9n3NgaQtreLeMF6kikVCEJASdHl+Gg33IFqEC/t1TPBqTZ+GrVyDyH/P2SUjtzE+AM3INCwwFjpN/tq7JAevWcbmWNruXCT8lejzboGhKHWFO3v9QzZ9rRBlGKOZnQevQAaQXh9MJlEXgNogrpCBKrGhc71D1mm1h1UkpvxuKkDeODeF3y0sw1apwi/I0ftCMXIafvRrMvDXaRzTk/aOHU9raZdBiKoQVAhc60pOT44UKVU8LB1L2hJe8I+1fCa+wo0eGzc+jX9hVbKq7GOvPUb0FrbANgmvYlsyqg6rwK5FyUnwtqPNXKifIrYc4wdcolAi9BtVOCGc8VoqLvIvagI4V7fdlsdf16t7EzAnO3Z8QOMxmac4Zl34ALhXzHrll7ar/mwxqm3dJcHNZmqZmxwJRlQ/YCbb/A0lFa3csS2sQjG8ZOQi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(6916009)(186003)(36756003)(38100700002)(316002)(5660300002)(54906003)(2906002)(38070700005)(26005)(83380400001)(122000001)(66946007)(8936002)(66446008)(66556008)(64756008)(66476007)(508600001)(86362001)(4326008)(6486002)(91956017)(71200400001)(6512007)(76116006)(33656002)(6506007)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZbXkULaoVPtYJo1AhZRmh6VuZAYC04+crQXa9wSuTr5rolLYsndAKIuvIkl5?=
 =?us-ascii?Q?8KO+AVBdvRY+bUZfPGrZ2XUQSV+QmYdWLRtGrtTv8sADVv/n8MMjpT2tU8zE?=
 =?us-ascii?Q?MyR480TpJBEIIjHiFSY1SjMd9toUySWFBty9Gsl2XfwZUx8ine/PCkVF2m9+?=
 =?us-ascii?Q?/f+uFeghtVUcCU9qiV6kYOlXfNEPEuptg3Xd2JNqTyiUbeXcyUZNL7ZFsiR2?=
 =?us-ascii?Q?Jp75nr/0RQWfJiuoCpwo1U5I+7LvRNKN1/YRKlobO9Y/TIHM9b9j61ByAAVf?=
 =?us-ascii?Q?OFGmB0YXY9tu4UmVuc1QxwZ0WD56Acd0sgccwrDRpVHAkCD691mGk6GnsguC?=
 =?us-ascii?Q?bEdKnGrH7d40HmJCBCaoHspv6ma2Z/knlnMQviMaZ4igebT0E+gAeP4ngjEb?=
 =?us-ascii?Q?crjR45sFNMFXDjFRaTW4yr6JHdlrLnukE4nvbh3s2r8Od9jhhe/42UbHSy71?=
 =?us-ascii?Q?uVZ568zWjyTrnNTL55b5A+tSqto/RS1cnJRv5ysf1M6feVO4a1x9gaeuIAIZ?=
 =?us-ascii?Q?YHYJSQei+qu1BNC8k3UemBJPjADE6D1Ey8WKUezpoIGR1mTNqafgbrqX0bL4?=
 =?us-ascii?Q?zHtMXLllgFMQwhFKbP3+xxtNjZtyILnAc4MFEGel7SnBn3gcRS8yr6MuEf+9?=
 =?us-ascii?Q?tGHKhVNEwE7OmSHE9cL+HRatxzKfjD7j0OOZmPj0+wTeSpmfLEIRHuHuvB+C?=
 =?us-ascii?Q?mgyt4zxSJ11drSjTj3SnadU2/iY867ZPqyutdHVGz4tInTQpQ3O60Q75nbX5?=
 =?us-ascii?Q?NZicLW+qW2v1ikVYP88zYv5peOrXMJ0DblF35ncFL7Y+3aZtEXWDEIDy8sna?=
 =?us-ascii?Q?dvGAyuPO8O+HWqtrdSxV6sh+NXzvEzzZ5wr4nIwNdXy9JBJcKuZQreArR/+Z?=
 =?us-ascii?Q?fsdqitbSVFITUlg8+oYS+O3Fzf+y9zJn+nx6XcM9TPF+uYNiwXp5ZwujJCTj?=
 =?us-ascii?Q?7XWdfLdZLbhs1GmAHfeo7f8x+sW+Cm+tgKmf/myS5uTB94jfsB9pRO7SdOI+?=
 =?us-ascii?Q?RmTVlsbOiQKPhl5eYq8iEvdvP/jkaWva/MgTVnpXTOhNneZ5TtEUl4AoyeVF?=
 =?us-ascii?Q?4Fzj8SRQ4C834SmsbeeDTVUtPY4apn2u+x+Yjt5wtZddMxbwGMcGm3xzPJgx?=
 =?us-ascii?Q?OSahU6pBXDm7NuvQzimt2FMEDtRgRvELyHW/cgeo7p6ItjoT5XvrJr7Upm/I?=
 =?us-ascii?Q?QHBW2skUiDbhv2dXYTLmoEbq/GSWkIIsQu/CzZ4sp6Xtj+EdPpQUXWek/vcC?=
 =?us-ascii?Q?XcdoH7//VG1kiuwlrAm+LLqbT7i2wI9Lwst+14NHr3XpO/934kZMhASx1Vbp?=
 =?us-ascii?Q?1n6uwt+WPJ+CgQ6pECQnbghE0rx7IRzsZgZExREFIjTBJ/2LQvc5D9zGJd7g?=
 =?us-ascii?Q?2JoJA8bGH4Sw6NwTRTrQWpbe8fNWYs80JxzfnhEVYsVp794RUxuiQm5a1f+v?=
 =?us-ascii?Q?BVU91SnQKBerW1GBrhqXiXjJxtHJfVduhf1s8FnHMl7phe2iDtozZA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15A950188BADE844A84255D3DECEA892@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8880ec03-47db-412a-238c-08da0b44d6fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 14:12:31.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yZN6Ai9BERGTTUatU66eY1e5NFK3uyflTodpr8edXQLwqPGxF9J1lhjPIjqWS685vqV8RnUqo89/8pk9iMhFxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2195
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10292 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210091
X-Proofpoint-GUID: BG6b7t1nCVG1AaLHlIqA1UKdF68fMvzF
X-Proofpoint-ORIG-GUID: BG6b7t1nCVG1AaLHlIqA1UKdF68fMvzF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus-

The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3=
:

  Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-5.1=
8

for you to fetch changes up to 4fc5f5346592cdc91689455d83885b0af65d71b8:

  nfsd: fix using the correct variable for sizeof() (2022-03-20 12:49:38 -0=
400)

----------------------------------------------------------------
New features:
- NFSv3 support in NFSD is now always built
- Added NFSD support for the NFSv4 birth-time file attribute
- Added support for storing and displaying sockaddrs in trace points
- NFSD now recognizes RPC_AUTH_TLS probes

Performance improvements:
- Optimized the svc transport enqueuing mechanism
- Added micro-optimizations for the duplicate reply cache

Notable bug fixes:
- Allocation of the NFSD file cache hash table is more reliable

----------------------------------------------------------------
Amir Goldstein (1):
      nfsd: more robust allocation failure handling in nfsd_file_cache_init

Bill Wendling (1):
      nfsd: use correct format characters

Chuck Lever (22):
      NFSD: De-duplicate hash bucket indexing
      NFSD: Skip extra computation for RC_NOCACHE case
      NFSD: Streamline the rare "found" case
      tracing: Introduce helpers to safely handle dynamic-sized sockaddrs
      NFSD: Use __sockaddr field to store socket addresses
      NFSD: Remove NFSD_PROC_ARGS_* macros
      SUNRPC: Improve sockaddr handling in the svc_xprt_create_error trace =
point
      SUNRPC: Same as SVC_RQST_ENDPOINT, but without the xid
      SUNRPC: Record endpoint information in trace log
      SUNRPC: Remove the .svo_enqueue_xprt method
      SUNRPC: Merge svc_do_enqueue_xprt() into svc_enqueue_xprt()
      SUNRPC: Remove svo_shutdown method
      SUNRPC: Rename svc_create_xprt()
      SUNRPC: Rename svc_close_xprt()
      SUNRPC: Remove svc_shutdown_net()
      NFSD: Remove svc_serv_ops::svo_module
      NFSD: Move svc_serv_ops::svo_function into struct svc_serv
      SUNRPC: Teach server to recognize RPC_AUTH_TLS
      NFSD: Remove CONFIG_NFSD_V3
      arch: Remove references to CONFIG_NFSD_V3 in the default configs
      NFSD: Clean up _lm_ operation names
      NFSD: Fix nfsd_breaker_owns_lease() return values

Dai Ngo (1):
      fs/lock: documentation cleanup. Replace inode->i_lock with flc_lock.

Dan Carpenter (2):
      NFSD: prevent underflow in nfssvc_decode_writeargs()
      NFSD: prevent integer overflow on 32 bit systems

Jakob Koschel (1):
      nfsd: fix using the correct variable for sizeof()

Ondrej Valousek (1):
      nfsd: Add support for the birth time attribute

Steven Rostedt (Google) (1):
      tracing: Update print fmt check to handle new __get_sockaddr() macro

 Documentation/filesystems/locking.rst       |   6 +--
 arch/alpha/configs/defconfig                |   1 -
 arch/arm/configs/davinci_all_defconfig      |   1 -
 arch/arm/configs/ezx_defconfig              |   1 -
 arch/arm/configs/imote2_defconfig           |   1 -
 arch/arm/configs/integrator_defconfig       |   1 -
 arch/arm/configs/iop32x_defconfig           |   1 -
 arch/arm/configs/keystone_defconfig         |   1 -
 arch/arm/configs/lart_defconfig             |   1 -
 arch/arm/configs/netwinder_defconfig        |   1 -
 arch/arm/configs/versatile_defconfig        |   1 -
 arch/arm/configs/viper_defconfig            |   1 -
 arch/arm/configs/zeus_defconfig             |   1 -
 arch/ia64/configs/zx1_defconfig             |   1 -
 arch/m68k/configs/amiga_defconfig           |   1 -
 arch/m68k/configs/apollo_defconfig          |   1 -
 arch/m68k/configs/atari_defconfig           |   1 -
 arch/m68k/configs/bvme6000_defconfig        |   1 -
 arch/m68k/configs/hp300_defconfig           |   1 -
 arch/m68k/configs/mac_defconfig             |   1 -
 arch/m68k/configs/multi_defconfig           |   1 -
 arch/m68k/configs/mvme147_defconfig         |   1 -
 arch/m68k/configs/mvme16x_defconfig         |   1 -
 arch/m68k/configs/q40_defconfig             |   1 -
 arch/m68k/configs/sun3_defconfig            |   1 -
 arch/m68k/configs/sun3x_defconfig           |   1 -
 arch/mips/configs/cobalt_defconfig          |   1 -
 arch/mips/configs/decstation_64_defconfig   |   1 -
 arch/mips/configs/decstation_defconfig      |   1 -
 arch/mips/configs/decstation_r4k_defconfig  |   1 -
 arch/mips/configs/ip22_defconfig            |   1 -
 arch/mips/configs/ip32_defconfig            |   1 -
 arch/mips/configs/jazz_defconfig            |   1 -
 arch/mips/configs/malta_defconfig           |   1 -
 arch/mips/configs/malta_kvm_defconfig       |   1 -
 arch/mips/configs/maltaup_xpa_defconfig     |   1 -
 arch/mips/configs/rm200_defconfig           |   1 -
 arch/mips/configs/tb0219_defconfig          |   1 -
 arch/mips/configs/tb0226_defconfig          |   1 -
 arch/mips/configs/tb0287_defconfig          |   1 -
 arch/mips/configs/workpad_defconfig         |   1 -
 arch/parisc/configs/generic-32bit_defconfig |   1 -
 arch/powerpc/configs/linkstation_defconfig  |   1 -
 arch/powerpc/configs/mvme5100_defconfig     |   1 -
 arch/sh/configs/ap325rxa_defconfig          |   1 -
 arch/sh/configs/ecovec24_defconfig          |   1 -
 arch/sh/configs/landisk_defconfig           |   1 -
 arch/sh/configs/sdk7780_defconfig           |   1 -
 arch/sh/configs/se7724_defconfig            |   1 -
 arch/sh/configs/sh03_defconfig              |   1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig   |   1 -
 arch/sh/configs/titan_defconfig             |   1 -
 fs/Kconfig                                  |   2 +-
 fs/lockd/svc.c                              |  24 +++------
 fs/nfs/callback.c                           |  66 ++++++++----------------=
-
 fs/nfs/nfs4state.c                          |   1 -
 fs/nfsd/Kconfig                             |  12 +----
 fs/nfsd/Makefile                            |   3 +-
 fs/nfsd/filecache.c                         |   6 +--
 fs/nfsd/flexfilelayout.c                    |   2 +-
 fs/nfsd/nfs4layouts.c                       |   2 +-
 fs/nfsd/nfs4state.c                         |  20 +++++---
 fs/nfsd/nfs4xdr.c                           |  10 ++++
 fs/nfsd/nfscache.c                          |  33 ++++++-------
 fs/nfsd/nfsctl.c                            |  10 ++--
 fs/nfsd/nfsd.h                              |   2 +-
 fs/nfsd/nfsfh.c                             |   4 --
 fs/nfsd/nfsfh.h                             |  20 --------
 fs/nfsd/nfsproc.c                           |   2 +-
 fs/nfsd/nfssvc.c                            |  25 +++-------
 fs/nfsd/trace.h                             | 107 ++++++++++++++++++------=
----------------
 fs/nfsd/vfs.c                               |   9 ----
 fs/nfsd/vfs.h                               |   2 -
 fs/nfsd/xdr.h                               |   2 +-
 include/linux/sunrpc/svc.h                  |  26 ++--------
 include/linux/sunrpc/svc_xprt.h             |  12 +++--
 include/linux/sunrpc/xdr.h                  |   2 +
 include/trace/bpf_probe.h                   |   6 +++
 include/trace/events/sunrpc.h               | 244 ++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++-----------------------------------
 include/trace/perf.h                        |   6 +++
 include/trace/trace_events.h                |  55 ++++++++++++++++++++-
 kernel/module.c                             |   2 +-
 kernel/trace/trace_events.c                 |   6 +++
 net/sunrpc/svc.c                            |  50 ++++++++++---------
 net/sunrpc/svc_xprt.c                       |  68 ++++++++++++++++--------=
--
 net/sunrpc/svcauth.c                        |   2 +
 net/sunrpc/svcauth_unix.c                   |  60 +++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c  |   2 +-
 88 files changed, 512 insertions(+), 450 deletions(-)

--
Chuck Lever



