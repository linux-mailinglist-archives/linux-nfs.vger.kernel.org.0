Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC74B7861D1
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Aug 2023 22:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjHWUzd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Aug 2023 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbjHWUza (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Aug 2023 16:55:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11B10C8;
        Wed, 23 Aug 2023 13:55:28 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NHx1YD002575;
        Wed, 23 Aug 2023 20:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=E24tp1VRva9c2MFwCZOtI8pGOltMRFkPBnLZDIygGck=;
 b=iF6asC+feHXv7SbljULO0GgCaRBSMUggjvNavnbkDGy9nilQpQPOBBJr6D93cUSCVaUv
 RRi1YTdekDZb5JCIn/Vk6xS/yixUAPm1Vh6nyZ+YDx3BVNFs1ALNfZrZ4gtXjggk196e
 sxM3oCHWrdeZWvCKBd4SqkF8G4zFflBXKwbKtwzJlTb9TofEfpVGK2gB7Y3xy1tjBRha
 sSf7hD9Z1uHqZYQkPn1carwEPBkD8CFJIPDEU5T+wsRQwN54TZ8rpFz2oKAxw2pgfi4Z
 PqVt0C96U4e9fhPkTV64hqf6uxC8fG1GYrAltzcZ6QDWpijDhPkNxoWWpPQFe9HbQdsN hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yv2u4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 20:55:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37NJIkLU002240;
        Wed, 23 Aug 2023 20:55:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yvv695-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 20:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGWTJNpWjGqU2X0tN8jfc1flq+ikLUii6r9I7dTSV//QgO6KK04tsg4sGdKkBGsg/3b+x84Ej07o7b2ADliOd0I3DrEoZiCNuzYI+z6iOxsageAQ2S3fPUcE5aKzAxw6v+M5Ls1BMpJ3E8XdpNNoTen+cX8tmutWSgidGypeIWpq21GfDTnCu3nXJVjo6Go6Tr0KrzBqjAvQJESl3JA1gp2n9Um1KFFcOi5tzxUwHbkwtHPamYGPHGVa3PGeN+uQ+RvuLkoaFIWOhVqrZPJNQ1d34YhGxrXv/ktRcBdBiRO8kOHGmR/imPLrc/6iXqQHUPrNisnACspbJFlcnkNfWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E24tp1VRva9c2MFwCZOtI8pGOltMRFkPBnLZDIygGck=;
 b=AZdyJyzily4pZFqCke1WG9kjWmMc1dsUYupGpRN6HLAPPzdMfeP5l2iU9lfQTdnFIbKb4Z/yiFXWYSEqcYsAQM79F6S5PaiDIotbYBIP6UywFJUKtgc52TgcPuA5VlAOIVQ2SxSMmQsw4XJfTneP2AkAU+drdGJsC18BEiMcks4SZ8HYLOXcdDT3MbhiWlMBH/JELp+DhPFHRzddnyl/ks16OOkAQ3xi1+ZpZ0SgImxTkCGwqQn4V1YRUl+H7OJpjiVBW3pvjjdig4Der6h4KAuctADYjo4PVLPTQkTcCzg9k2o6EHEIG40BNwLNOVXyg8zIME5Jl6ZXT+O2ON3JfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E24tp1VRva9c2MFwCZOtI8pGOltMRFkPBnLZDIygGck=;
 b=GbcEeRWeGwMIoyuiwhMNUggI+vzEA6ZHaH1bq1P2Rhf7w88YYknOXrA+mFpssuO3lzrzdYg8ANV5vwF6zk3XYhuViFfSaBlyMIkA+nQfgcgOh1MRED7ACiiOuictlBfWYp0EKWRyIXl/q904nSK901vCaGTS8bfKYoCIAdxJmj8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6473.namprd10.prod.outlook.com (2603:10b6:806:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 20:55:06 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.020; Wed, 23 Aug 2023
 20:55:05 +0000
Date:   Wed, 23 Aug 2023 16:55:02 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Yue Haibing <yuehaibing@huawei.com>,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        jlayton@kernel.org, kolga@netapp.com, Dai.Ngo@oracle.com,
        tom@talpey.com, kuba@kernel.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH -next] SUNRPC: Remove unused declaration rpc_modcount()
Message-ID: <ZOZyJsV0Qkz8/NhP@tissot.1015granger.net>
References: <20230809141426.41192-1-yuehaibing@huawei.com>
 <169161700457.32308.8657894998370155540@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169161700457.32308.8657894998370155540@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:610:38::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 00e4a321-bf1f-4a8b-97a9-08dba41b3a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1u32u+ZUUC/GpSINiV8LGDxLxaaXWnwnwPouN8iTAsluuskwIt0OqeCfAtuM13lwkapQGAluZVt2J7EbcZNfKE+GczzCrBihPLIi7Jkz60V/imRT5tLzfUM50YK7BLMK2BAnHP0m0lJTC9zD0FfgPd7mgeHuvrpeeoVpky5/7YmgVco4OTTd6NwCuxyu6KTXRalbUFEcz0BLZtMnBudrguyw4iWSUoREHwQehXe1/7vmEX9kufvQ5hHzaffZ1bKJ60XCqZ/2Zr7BUt81qyl38/VKWZjJn4fxjPf0/uImLc87W46CbklhUk10LIgqHVa4jBSAK8zREsgQE3dL8tJhX+VQkjOywQVypwNWfGmVO5PAAVrfE5JDrPUKUhUPb31c0/gnDYpemas/SxvTkzm2fJ2kJzR3IkqM7SMtYLjM/d7WXi1N/4S9SK38yCDKkjY6+6w08nmxVxmlibEusmYkxLtjTvOztpv1Y++5weIm+igU4WmWXovgCSfu9kiXun59vL1J7+Msqj6vK98rB/xfBQP5Bxp1nMP8zyNKCiv/GsQHmRHqyGHzSgaoMxgm8PrgJ3xkfDfAXrD0sHik1tdZBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(346002)(396003)(186009)(1800799009)(451199024)(478600001)(6666004)(966005)(6486002)(26005)(6506007)(9686003)(6512007)(7416002)(2906002)(5660300002)(8936002)(4326008)(41300700001)(6916009)(86362001)(66556008)(316002)(8676002)(66946007)(44832011)(66476007)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2sOBT3hI62Cq17OC181LE7dIpY/4aFU9lexW5LfuM1CDDUWwOGsG9ITTBnpN?=
 =?us-ascii?Q?9EN1/VvnxVYmNzkhSzLD80mwalNXmgtOMAuA5HSKvI+Zed5101NBhJDWEsYq?=
 =?us-ascii?Q?TzCHuqq/S7LCUZ2wEqJMzn8zcJe6A9wphYsO7tctbSH+B1BJaNzqW30hVZ8P?=
 =?us-ascii?Q?/gtjHYn5AYxn4iJMdejLdIE0Q3rbIVOOcXVfia4O15V273OV5p9Zm9D9HqYi?=
 =?us-ascii?Q?eoQk3MDANpk9yrVTV5fDvrqQTKnRk49vtC3g27ZAh5O7pszcvBsEdKP+CISX?=
 =?us-ascii?Q?XpNByiQsylggzBdqWT1010Qkk4n/fNYp4WxisU1iZ6cEHQrEi6JwSLzBUVXs?=
 =?us-ascii?Q?IAzMay+Esp/qujygDrOPcHhmq9Vrw/XbZ5NXZFDhucihsECSHBgj1RwhVCu0?=
 =?us-ascii?Q?nElpiCnVJlKiu9PHzQKj+nieH9wbhjdpCOq8yA9KROCUjC7Af8jPsi8q7hNg?=
 =?us-ascii?Q?7JDaJU5DzCbAWwJQv3RM26kYjHZmZpoQp0bMzyvm1TeTg3FfINRD2PO/1fdz?=
 =?us-ascii?Q?IKCe8wwfupp0vQD2OkUhA4BMUwh1nEHsbE8O4uf4/VkfI64hSgz5in7cdGDj?=
 =?us-ascii?Q?5NbaidvM7q0HwXpWLJIgxJ3d38DnOG0ZW82nhTCN1BcARmIzDPXxbO6p6HF7?=
 =?us-ascii?Q?FgX00s0CUPcF0EHWXuemwJeVbMTixss5kscu3ymb3t1+EMXkZmzpPaePE4Ym?=
 =?us-ascii?Q?Y9vHm1jFREqdlrBJeDjalcc9TXlL9YwKyWfmY1NGFNHWzep2Mb26HE3OPrBg?=
 =?us-ascii?Q?gNhWo7oKKwxGwGmNxX4tnG88dg50J+cul793ePf1ZDAQMagUMJRb27HJbDq8?=
 =?us-ascii?Q?Yr8gGQ/RJX0k1H+WXj6OInj+minb9eofGgBMS5RQ/FKPPOeBt1jokMLZkwIk?=
 =?us-ascii?Q?T+sMlQxwHqCSVZiD+kiYmQlOslzzjW1NCm1YtkeuLDRmSPf2tBgbfl3VNj6w?=
 =?us-ascii?Q?lXqgy7NkzOF1+thtycJ3nKg5M+E2iP97Kj9M+LCbprwIivHEEv7JunUCiCHz?=
 =?us-ascii?Q?V8BbqjDMOkrIXeB0+Zc9kDs5UyJ8obcUTfdslr4IsCCnXtUVD8HR6XAqbsNt?=
 =?us-ascii?Q?UOpAlsXF+ny5199y94GC0jqQ9QA1BqjhWEOF01xDk4mQlGX8DbfEV5q+jbfU?=
 =?us-ascii?Q?4jymIgBRO9ydU5SL5+WQ9jrNb8nMXJDV5yJFScibsygDxvM4tQ/KUtl7h7HF?=
 =?us-ascii?Q?H2W0jDAcvHR7yNFep3kKLhSOV2JQiJP8FICZfZrrAyXDgZZ6gII6rvHV+18R?=
 =?us-ascii?Q?a+Zp4rOE9rgZof56PqyMTMCwZ6PbU67ppy9UDFY4l9mPeSkinm7R2PT45reZ?=
 =?us-ascii?Q?B1+a9SEeAcl5Opq4bJrVkoCijYclSRc20et8vADBT90UWEziwQfPk6FKuvQl?=
 =?us-ascii?Q?fnKY/fNjQ+LzDyF9qckjDSDMKo23a5TV647ftWpdOA54Itkd4iSJlZ0rmPWk?=
 =?us-ascii?Q?PQZWP8qTqVWbYWXntIIlAg758k6ewrXlC/ImCDW5aOfywvemJaN3kjo9u3Jl?=
 =?us-ascii?Q?E65GDVsGbd1Pm4DsxgnUeYj9YNwoSo94Li2eW+kAEZdv68nxfumAOS1Dh0XT?=
 =?us-ascii?Q?vFJW56iRq1LjyVOBYzHwp7Ti1bdQsDPhih4PJ9xsmCSPJ1q8dldu04QWXFGU?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?oJD0+oEXGdKawMkNKw1xQYPboOlxpeNjBUWTg/9OTnds0yP0QpczpDSaPv7A?=
 =?us-ascii?Q?d2ybhOT4Uu/HpIj+YEdMadiV2yNs/rBsV84qwfIbQsAbd2sfPHxGm3VZyQT5?=
 =?us-ascii?Q?CjDgrA1qcqPNXxeV40Eybz+/Jp7ccjkGACdWVbqaVvKwGILWbswCAjnT/gDc?=
 =?us-ascii?Q?yRqu1F/bEymK8Nr/2Yr4+m7/OztC/pMWOD0iwXvaTvxzg7PZ6gWg2jXFjZWR?=
 =?us-ascii?Q?cI7HiX6OJ28Jhq5bzWCZYV0fMP2LkYb3K0SOBCGNHppQHjPqBDLO0ODiRU/q?=
 =?us-ascii?Q?mA0rB4i1GHKjYWEPs/toace5qjHa4dbkjvW8H3SQGijNBTlo+8Y8imime4pF?=
 =?us-ascii?Q?4XiDUCVYh6ROkK4aXt/VagxAaP8BhTrQiMKe4vPYqibwqbonKcsj6NxAT1eD?=
 =?us-ascii?Q?DF4qv9XFuR92dFlt36+dqZtdDWEApHk7W8wuehdO3Tc17RBNZrch5b7MFjuv?=
 =?us-ascii?Q?DbysGZyhGUezXnZvQFsIuc2JgKQcB0nLSIq8MlSRAlwoVlbN/77AX/zan2SZ?=
 =?us-ascii?Q?pHRldjQYNii4tEEzNVpbsoy87im7q8CJlhFoE9Y93rt5Kbo5rl29qJkEE//k?=
 =?us-ascii?Q?cb+oEqEPC17gwBWoGahIG42xBT0UzB6SKLmFKuQrgukYwM4aTI1vhT0ly8wN?=
 =?us-ascii?Q?8QMqf3+9VEupNtCJSHaUVIK/w5ov3iSrMb2WQaCd8owfvHraUuA0xk+AcNeh?=
 =?us-ascii?Q?SgAu0YCSiROHaG7Oa0B6QEieINNond8/TcXbYi/dZXOufb1MSLnvBzn248SR?=
 =?us-ascii?Q?Wfq8Dh1bXt6RIyswl/VLurfXQB7xzpEbMESS6NyUirC8xo38iTWJaih3uKXC?=
 =?us-ascii?Q?RdYEMIZxvpgn1+gov08CxIDwbu4BRS97mPrec8gB8GVMHuEsw8k5IvpKKiM0?=
 =?us-ascii?Q?+NLLkek6VVMgTO8lUh2i91VtzgbgPMO0nMqcCizAUFeU5urC2U4ZM83g48NY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e4a321-bf1f-4a8b-97a9-08dba41b3a81
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 20:55:05.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4o5KISWF5vqitC9ts3tOSwhtn4y3WDY40qxEV8Hc05q2G3JHFej6rCVIRdOdUeBiPQAF1s7OI4pCEFTbhMgS/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6473
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_15,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=918 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230190
X-Proofpoint-GUID: gQipjurn36Vh5CJ9lcpezS1B0WjC_b3w
X-Proofpoint-ORIG-GUID: gQipjurn36Vh5CJ9lcpezS1B0WjC_b3w
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 10, 2023 at 07:36:44AM +1000, NeilBrown wrote:
> On Thu, 10 Aug 2023, Yue Haibing wrote:
> > These declarations are never implemented since the beginning of git history.
> > Remove these, then merge the two #ifdef block for simplification.
> 
> For the historically minded, this was added in 2.1.79
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/net/sunrpc/stats.c?id=ae04feb38f319f0d389ea9e41d10986dba22b46d
> 
> and removed in 2.3.27.
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/diff/net/sunrpc/stats.c?id=53022f15f8c0381a9b55bbe2893a5f9f6abda6f3
> 
> Reviewed-by: NeilBrown <neilb@suse.de>

Thanks, Neil. It isn't yet clear to me which tree this should go
through: nfsd or NFS client. I can take it just to get things
moving...


> Thanks,
> NeilBrown
> 
> > 
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> > ---
> >  include/linux/sunrpc/stats.h | 23 +++++++----------------
> >  1 file changed, 7 insertions(+), 16 deletions(-)
> > 
> > diff --git a/include/linux/sunrpc/stats.h b/include/linux/sunrpc/stats.h
> > index d94d4f410507..3ce1550d1beb 100644
> > --- a/include/linux/sunrpc/stats.h
> > +++ b/include/linux/sunrpc/stats.h
> > @@ -43,22 +43,6 @@ struct net;
> >  #ifdef CONFIG_PROC_FS
> >  int			rpc_proc_init(struct net *);
> >  void			rpc_proc_exit(struct net *);
> > -#else
> > -static inline int rpc_proc_init(struct net *net)
> > -{
> > -	return 0;
> > -}
> > -
> > -static inline void rpc_proc_exit(struct net *net)
> > -{
> > -}
> > -#endif
> > -
> > -#ifdef MODULE
> > -void			rpc_modcount(struct inode *, int);
> > -#endif
> > -
> > -#ifdef CONFIG_PROC_FS
> >  struct proc_dir_entry *	rpc_proc_register(struct net *,struct rpc_stat *);
> >  void			rpc_proc_unregister(struct net *,const char *);
> >  void			rpc_proc_zero(const struct rpc_program *);
> > @@ -69,7 +53,14 @@ void			svc_proc_unregister(struct net *, const char *);
> >  void			svc_seq_show(struct seq_file *,
> >  				     const struct svc_stat *);
> >  #else
> > +static inline int rpc_proc_init(struct net *net)
> > +{
> > +	return 0;
> > +}
> >  
> > +static inline void rpc_proc_exit(struct net *net)
> > +{
> > +}
> >  static inline struct proc_dir_entry *rpc_proc_register(struct net *net, struct rpc_stat *s) { return NULL; }
> >  static inline void rpc_proc_unregister(struct net *net, const char *p) {}
> >  static inline void rpc_proc_zero(const struct rpc_program *p) {}
> > -- 
> > 2.34.1
> > 
> > 
> 

-- 
Chuck Lever
