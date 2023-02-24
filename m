Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3DC6A2476
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Feb 2023 23:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBXWs1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 24 Feb 2023 17:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBXWsT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 24 Feb 2023 17:48:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9C970812;
        Fri, 24 Feb 2023 14:48:18 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEoTRq006518;
        Fri, 24 Feb 2023 15:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=Cs9Of6idYsih3VEackTHzcdXStaaV3YJVRN1ZQQeXSY=;
 b=BPpAmPMPxjJd4i2QniS8Q01xyBFIKF9y22gox6QhoVTM2ym3LOmiXMwYnl0ylvve7YvL
 1iDtu8ZA0FFu21kq2gSvGuguKSnnlQlTSKg9egCZRmU4Vkb/QKmVDHI/kXQX5+9qtnMz
 hKWuVSOC2IRlfu2pdZ6C+kK8QkfSmmaqB6+fGX1ZUEBV1QdinljduetifopDo+v2feaX
 3v84twlIDiGDZxhEXKrvzXuF+Xjkep02MK5fuCM48h0aqk5U1ioox3IqdBXBkpRz++M7
 TDevtNZzhPgSFKDRzV2OlN0Kuuv+ik+vEupGX1HiEWG8rciE48/97mLiAsmil6TB5qAZ yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntq7un6sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODj2e3031555;
        Fri, 24 Feb 2023 15:10:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49qpf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd4Q1bycPpGAfY4PwBlZ2ZwD7n1WJv2V2jz+09d6n8tB02u3mgQ772tvN3KeaCLd2ELAUG9JqPKK0RDkbvs96Fhd5LI1SGcfGHko2yc31cW/yVEg5bdNhf3TMJKyXlnvdsOGAiBWtVvWHtUJ8ym4frNyd17MdLZF/ygFC7I0DuUppJWa+l+QsrVuqzB4aDFnIjbSW2JGam+E5pyHMJaI4IZAned+B33JoFuufBYWs4i6JcvQaP+gEmyZ+mBSd0gnBaN5Tp2l9+HECIlknTaIN3keLksQQFH8M10E1jednFQOHrVS1PT4JheFpPpmLdhpYou02Q3y6VHMoT0wrdNruw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cs9Of6idYsih3VEackTHzcdXStaaV3YJVRN1ZQQeXSY=;
 b=l1HYlHlevjTdD004U5VN1LpkImzQKHQZSQL9rkyNR+DC8LYn5B7Og4AkCmubUwX8rEW6t+EScisZnlQFIRxMAMn0hebDPwXrFPh8aR1inXj7XcNwyP8klXAE6BPWEuZteI8E6dwYOUxQnSvMx/OaO8AUpN/1WGg83ITLOGz0RbnQ0XyaBmfD1Ja4Vd88KyRB2DdaZLFBKH5s25Jnj4ZVpPcxiKTXXz96tIcfnL49MnzYW3vfyxnwmMe7sJU94un9CANBagygUVAzaSAvks1VVXOfpNsilxeUru1v5vy+QGD5kM+RCfSyCxnGWIaQWT7uXi2v7x4sgSJR29/XMf7tVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cs9Of6idYsih3VEackTHzcdXStaaV3YJVRN1ZQQeXSY=;
 b=nuWgsksbdEqKo63YfgoT5SWBUMD4ACRu1/llJ5LXguOrjBunVB3/H6h3wY9jOwrBEKfL5PH8QU48WEvnAV9AdWLSJDGmmRG0krVB12RnDvvneqsRbHlUVTacpaPNHcgYN+GOf27XOZH4flOwljWOO4vnr2yUuoMtpMCnWBeosno=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Fri, 24 Feb
 2023 15:10:10 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:10:10 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH 23/27] NFSv4_2: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:08:07 +0000
Message-Id: <20230224150811.80316-24-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::8) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a3886d-2d82-4667-c7d4-08db16793885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fDTlpE4aPw5CsiVqJgaCaZSKMsZojg1hy+yICY0NS3LbAnAXnCL9+JLN/ghcK2KaZlc95aGeDKvZrw/NnOPPV2Akv9iaMqe0gqu2OE5ubtbYxUwX9x4wAZwmPmJHIvgOlQ9nIWqHIqRbaPTdsYV5q2PoZWZfjc9fbeJVXV6FuBjYQ1G81Tug0vJwDeUYHbqrVuIZnNj90y2pGcNJ6yrTqXIBDmeIzkrb7MapxMPedlRKOWqTxZHJvvGmpG8qoAXjv6E0t9YYavEEIkpxSXq1WUJ4vW1B1xaladhQQIWsacGOKfofwswz7UF9eIb2m6FsNaPKARdt3xAAmR0jfZPTYMsYaKLDayGsBtZmTxBmhfvUj2TcOcSJTZoNRKi83ZAgK668EGLNy8EoQK/wyy5zWzEDeeforqKnf8gVOvKsmKnNeIRS/LE12ixIwOfNbkTPCW3wZA5tZDYfvDYHvBHo4kWREwcwT9bP5NNojD5MFIBh3CC8YFG+NbWmF02/fkwBRbYgoPpaf39s0+lw21/3QobBTHwq7vV8nedXAOY/tMQM+rBBTgmKK6l+GOX/YKftKYwOP/QNGciNHlEZoNK3WKZf97WTp/ZlrakesbYsoEYvOTuM35YQY0nuacA8P2uLfEK75/buWeqK8m9zEIWj2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199018)(83380400001)(36756003)(4326008)(66476007)(66556008)(66946007)(6916009)(8676002)(86362001)(2906002)(38100700002)(41300700001)(478600001)(186003)(2616005)(1076003)(54906003)(6666004)(6512007)(6506007)(316002)(8936002)(44832011)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3vb1qaou4XR99N6UhJbBD1rdmbklXvDUyi70HCA5B871LUQ4xml5nlugWeA6?=
 =?us-ascii?Q?4KHrgqnGQpAQx66igr2mmea6Zf7yle0bTFF7a9+nSuYQ84RZncdklPHpPdm1?=
 =?us-ascii?Q?X0x10FjtpPsJhc+Mmj/7yOn568EY5iHiGkniKioO1p2zXMTwFQXwA3edarHA?=
 =?us-ascii?Q?GNqNuU0CrPImKPjF/NWBK4A/m1TYdxK9ziWJnnWS+COGOMmSHolPclOf6z73?=
 =?us-ascii?Q?77ijwB3AyTYPWOO5fkKYgKay+W6Hg+JuqcTEVSp2MnYgQAEUG3ZVo9P2NWYe?=
 =?us-ascii?Q?DMzhAtEE+G4fwN55xeDyOJaBSTnYjaJO9qwUt/xRbM7y0EFZ9shiYqG2RVke?=
 =?us-ascii?Q?ymGPIlqNfo7ozITgQOn19AueogTXzsNf6/Z6zPFtWA+Uys3O1U69E1YpIs/l?=
 =?us-ascii?Q?PEMiCqeMKc06mWqQdqh3ZeisfbW7aoSxCTnd9Vc7YQ9imFS9O/nopaIDWWr8?=
 =?us-ascii?Q?CHfYLOePvZ2iurvUIyeKdx3w52HrsieDWmHkk17l4C1Wvjeb4dw3WEjSyz2u?=
 =?us-ascii?Q?gXJkpuHk18xDiR1UhN/iv+NdBkd9vZMApB+yI+l42AJ2ajk0eb+soN3DkM/P?=
 =?us-ascii?Q?oFTqawdccNBz+3j+eJNgzu0caXjVatJEQWCms+rLT4+JjZN6eElRolSDb4+p?=
 =?us-ascii?Q?i/QLxpPz/1B29haIsPXsoVRzAUmtKeLgydIbIXZPmbbWC+DBZcDszWNHHiq+?=
 =?us-ascii?Q?V75AhXB6voBxWxQTBR09NCaFdRmszFskIhIJ+NGmFXlF8RYVrcXjZ4AaAZfu?=
 =?us-ascii?Q?PCFCdrlQuPAFMb6zJSuokCtOZQNVFov+9UF90TPvKYCkaPY3yPBNYZaSGJRT?=
 =?us-ascii?Q?y3Nds8QFY7+6LeGfBdKAZJblD4NDiJmE1G1FFqM8xQB/2jyLPViDpJcdnYux?=
 =?us-ascii?Q?PvCrlIrKiW2CE5sFx8EQSTsW2qgEw5ijMxsBVqQo3MufwW/QsM3LQctHVkrD?=
 =?us-ascii?Q?bZpxmjeUxE9xnHSZ1J6NyImkndNGLA3rE7MRy2CW3bjIULW9ZofxWgu9IRSA?=
 =?us-ascii?Q?eWLD6z+yPaFAlXXLMCDiZUvQFkLnF52X0IxI79In/Q6fENDpMsvggsXWFuRa?=
 =?us-ascii?Q?C48Ec1M8pc86RCPA/faRLqsGR0f9Vv7j276fPi36ukYwehpKR2JeCqmvLM4n?=
 =?us-ascii?Q?/v5eGP5km3V5crzBOxHqsUUxG54cIUudYM0VEVfaGY5OY4TdGNmDL/VkqQ9B?=
 =?us-ascii?Q?ZfSwHRLLUYJZVOzepTnXYEWhYp5UdlufnLkDfzuDfmAmh8lxfUYfmJH0xJz9?=
 =?us-ascii?Q?rUP5MCDeT4ZuNLZQyw4hiJoI/G4U/CNChJsk3k5KOiSJ8Tic7hiIppAOyH5P?=
 =?us-ascii?Q?BC1VsCPp5BuboAAA1jZCv4v75Berwv6xVofgDhyHcv5JJhQB9rRrLHLXTfd0?=
 =?us-ascii?Q?cV4yRC6Wzl6bHuvKWbRkQtdJ0Wb2zqELdLv2tHgBVT18UfpnsVa4MFZfoFCk?=
 =?us-ascii?Q?mcA8uf9BU+jVY78P0TGhYcVlqwWvWBeR2BBAdUsjCdaGvWxM+3hpMIhY0jnQ?=
 =?us-ascii?Q?hU4ws0d1xp/7UymvagmjysDLi7+4WPTOSCPo4SyRU3tlZWHacObxYZZMCePx?=
 =?us-ascii?Q?qV+DrIfl6DwXR5Z/IFXvgNL1VQaa3yGDsjVxZs6LJ5p3WbtcjkrzjmiXAWOn?=
 =?us-ascii?Q?y7+Rgz9i52+Z0MBCFc+1h7U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BsKV2z9v+EXsiOHoZpBjDH7Rsutn3KRsJ9/ww5TCPdtBgprbKGKscBAMwwBbeiOXzCYp4lFCn1L1RqBaINVrq4cVqfYVHVIQdfoZnbTSLHTWZTXrCNwzr820Cta/yh9ixtiZ/sVNwKsZvMDkt6p5O/wUCCNWYz9QK4FekTppH+Fbv5IKsbqNWctOYkIXddDDcwd+j2j3V15ZMfKqBywCtO7bRIEM8niKV7g34w1Vpr3Rbpj/x1+FAkNHzM+G7YnFL+w0WcATKKPlLf955FKeSqsyXBTq9+IpRrqbIcF7esa9njk6NYHWlZvMuNCDgPICd1F7VuilzpdXGZjZ8QCb9+BgqCQ5XEtSXqMhAo9sMtBiUzvfpwZBH3XvTdx+R0OisNstR1MjbS+6mTEV9THUStvrihTP9r32b4AkxvKg22CJKl5DbZ5LuLtowtXL+6mTfm8cxZHIYXN3akafAJHCt5TfJNdrTCiBaEizmnJRW/5U+5hl72r3v+h6cpIUGQcLQaNPGF5VkSAhJiwQA2yxVkw4j7ua5lbHOiGfGo/FfdSuB0EgKCHBdm81UMYlqUibx1Hov0r2UylHUecLdLejM9ooEQyHuUJI1JDsz6yFE3BSPQWF8GRd9qqxvNt7WG6ocav2Sys01007PyuoixBpivymN55Yb1fcpmSL7qXB91DojPLxfMZjYWpdxb5OZBZO/rSuCMN6eLnEV6jm2mNQTi6MwdjWjprQ25DvP8FBCdVWNqM3l11phoXhSqJz6f/aSL+RN+ZDpjMMdXdEGi9d+AxsEGC5bvBIsAUl06EpMt7RDQzkDb7CP7UFuPdW/J//TB0kVD7ILDpqixqq/v6OEl6VwTB3m76UxprpMR5BXlM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a3886d-2d82-4667-c7d4-08db16793885
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:10:09.9296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hFpEShaY3DOShRJjvT6B1+b7dJdBo02g0+C7WkCeLBQiBGifOcOBGn3a3QSghDKh/i1BbfdtNQmx3ElGKGLig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: 3uH0d4So6JmwVBvEYljvh1SqWAjw3Mn7
X-Proofpoint-ORIG-GUID: 3uH0d4So6JmwVBvEYljvh1SqWAjw3Mn7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfs_common/nfs_ssc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs_common/nfs_ssc.c b/fs/nfs_common/nfs_ssc.c
index 7c1509e968c8..832246b22c51 100644
--- a/fs/nfs_common/nfs_ssc.c
+++ b/fs/nfs_common/nfs_ssc.c
@@ -12,7 +12,6 @@
 #include <linux/nfs_ssc.h>
 #include "../nfs/nfs4_fs.h"
 
-MODULE_LICENSE("GPL");
 
 struct nfs_ssc_client_ops_tbl nfs_ssc_client_tbl;
 EXPORT_SYMBOL_GPL(nfs_ssc_client_tbl);
-- 
2.39.1.268.g9de2f9a303

