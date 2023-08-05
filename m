Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A226777103F
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Aug 2023 16:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjHEOzX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Aug 2023 10:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHEOzW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Aug 2023 10:55:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6E64237
        for <linux-nfs@vger.kernel.org>; Sat,  5 Aug 2023 07:55:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3753vkZA003797;
        Sat, 5 Aug 2023 14:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ITbfMJ260SxlANcet1LjCEt/T+MOasj7JBkU7TexPRI=;
 b=VRwASmQrNefRynqYymFRPuL5GotA++GfwblaTC2v4pTHFsYQLAEbb9HwXanLazA25F9v
 2IAXLkI0n9R2VRcLhnH4ddYliWabuqaGgLQfV3frSi9eieG6z2FNjK5sCAvyJFCvo+aR
 zxAcH2S7oNoSLg5ym9iGrUQ5facrkZOf5gVFxMIF9RdRkXcuog1MqB6IlxANxUMdSmye
 8klL20x9H7fVwfkq6qL6/kGassegh/yk/wPlbh/Kcr3I3lKCrj/o+6i976qW/jlflaBp
 sjOyBLnaxTL6rkv4Ohir4a8Q09pO4V4JyPwKw8m1rt04ehSUyRDd/PId+QAKEAIecmTR 6g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eyu8dym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Aug 2023 14:55:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 375EUTtQ010572;
        Sat, 5 Aug 2023 14:55:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv1wvdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 05 Aug 2023 14:55:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4WqmIqX+tjeeGAjHjUCJWGq3Chatduehs/ZFNVeNeEODC64F8Gy5kFYsUJuZ7GC3lql9yFX5KefEYV7iNKM1Lv+Br976nmkFV8oxq1nxJ+sQvhDL00rmpU7toc6yODQsHQbMTWKe8zouPDEj94JcZF9rRzC6VUW2t1K5yodNW63peJO8agSh4y898IURUiEFyBoiwfzg9UQr06z0qbUTuje89ByAYJvQ4q4pDa656hjyvNNf+jSGaKUmJ1GTpoaGQDvZ+8DF3+v3DYecRg5JDukIPHaneESSnCCcjKhEFFymm8ZVR8M1LfB1kT1HnD37QBsk5XoV/55rnnBXzPatQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITbfMJ260SxlANcet1LjCEt/T+MOasj7JBkU7TexPRI=;
 b=oYpAAIRggf7TZIhvqJHfiXRhIKaYyqOx9S6j/4xSaAmOEF0CycSGxUnLKmvSZh8VQgH6COuU73etiLEl7oAl54TjJ1pwa+2x8hftMJ8tPOsJ52Hm12050nbYLUydOk/2diMbiHboebKdAfKkhspwNV6VU3qEFWQ2FOtIOaxkddogqkj/NeJ6cRLAy+AkEmCJ3BfOLIrjZ3NobRyMrLPVgc+8uFSzNWQEhzSwrX3CHi7wsUryIXG+81Va7XQdQRPn8/GgVsvdWYVdbJLgb+ZSlvOYDiO1V0HzHDdJHw5hgQEME+ntjmHXVgHWL1f5OimjUtGiiQK+UnOfqPgKUEVA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITbfMJ260SxlANcet1LjCEt/T+MOasj7JBkU7TexPRI=;
 b=S8hHWOFkUJhnJ9XN0HOIVLIHYYKDBnFUKHcVVEvHQtUD+svQWK6teiDkT/9LipIf6/SD56WjmwTtwnFn8bo6i2OkGzQIf4+AMdIo5Q+sR2ZoIp6e5zPLccmNvY0ai/JlZ6QOdJmkDeZnDTIxBViY1m32hFDw+YCjuOlIF+QPRSU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5670.namprd10.prod.outlook.com (2603:10b6:a03:3ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sat, 5 Aug
 2023 14:55:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.025; Sat, 5 Aug 2023
 14:55:08 +0000
Date:   Sat, 5 Aug 2023 10:55:05 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        lorenzo.bianconi@redhat.com, jlayton@kernel.org
Subject: Re: [PATCH v5 2/2] NFSD: add rpc_status entry in nfsd debug
 filesystem
Message-ID: <ZM5iyTzsYspzooDY@tissot.1015granger.net>
References: <cover.1691169103.git.lorenzo@kernel.org>
 <d0b6183a4fda5b333711caee73cbb06ba0147057.1691169103.git.lorenzo@kernel.org>
 <169118885443.32308.7901509987301611166@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169118885443.32308.7901509987301611166@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0397.namprd03.prod.outlook.com
 (2603:10b6:610:11b::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: d20a29fe-9e8c-4c88-2057-08db95c3f5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sadDUCx18n6cOC2g1wmYE2PqvG2YU1rIta1vRVvvT/sVoKPc0m6RYZ/mR7H8BMkRMPQqv2QHzXv7pgKTwJCFLyEGAPyO02haW9TdQ0Q367NSYA0L4Tx0ftUlXpxGrf8E6UT0p/cvespeqgHF+d4iDBYoDfbjM8zvAlmnR0yjvk76+Z5ErnZ2MfeIuWZtnDUwN5CwIbAEOp3qEo9jZpUBTJXpHaND/FWQSefL22SB8ilDk6nDg1FTtb8OOHGMyJV5Gkjtb3m4wn5kCFIcEW+PlRqM7B0enec0NE4py2K7AB9XoJd9evhuhsE5lVYRCSfsrucYSQFy2zXWvA5tXlHd3t3XRcOhtbiX9zGg5klRGDErICWHrmoJG/jnZhYLmPzPVO1OfW5hUii1Ledbe9OJn9abLtmzU1JTSO/F+kvfdo4MBSsdKCGpnqVWAwKT35qD4cZEelXXkC9+Q+P2pvTwRdXK9nc+CutMwz2HKXdUM9suG7sjOezhwtnsjerg3ONxXL3WwNy7CjWQws02YYHSuZAhKHCVBfTPUacFNzmw5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(1800799003)(186006)(966005)(6512007)(9686003)(26005)(6506007)(38100700002)(44832011)(5660300002)(86362001)(30864003)(2906002)(4326008)(6916009)(66476007)(66556008)(66946007)(8936002)(8676002)(316002)(41300700001)(6666004)(6486002)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IpfpMAyE0BZyTgpGuBLBUxAQ0cfGJU6EhOHGpA002FIsVJ2SFZTRd4Mtr96K?=
 =?us-ascii?Q?IwmJhhZgbIJo+6o5PPVCXPlRtwFjNswLVKqGdYEkg/bP4FwI/VgQOiKEAYeq?=
 =?us-ascii?Q?V54/Mcg2f8EhQyj+jz2GuAL617TrxhXT+VWv6L4bFBjcKWJdqqjNl9SQIitM?=
 =?us-ascii?Q?rVOY7A1ucBOWY9HX+jGNR/kh+M+qS9BnEuMupQ+q09eQtH72L38TZsArpbds?=
 =?us-ascii?Q?gQFlSPmTjSB7rYJsQZ8uHa2cXXpjKxGh4Nei86mjKlxVN/h1LXysjr8HiQV8?=
 =?us-ascii?Q?mFbv0YiXxv1vieeVVviqOSzrz0OILJ2y7GLaPCMdqrsOQqrczOOS/KlpetPv?=
 =?us-ascii?Q?vSR2Kdyc9y8Xk0lMYOJqovbORwCgGH0ymyke06fA3xjzIiyUn0jn/qUYG+MP?=
 =?us-ascii?Q?VGo04YdMmorPwQO6VqeRpzluuVOIeTbiph/nqVRp+pF/vQLEyGkntK8RPGYI?=
 =?us-ascii?Q?mh92fi4iJLTr7ypa9eFcAUBONnEltBBBjrA06LDwJc006VDuQOn6jmbd5rfV?=
 =?us-ascii?Q?toG99xOwQ/zy1bKv9VHxOXX5ho4Bb7g+urO4yO1wk9OBBXOzQPM+4LDCAZ6I?=
 =?us-ascii?Q?GYNo0LuFjMPV4oK/qa/RENdS6aVhmc1ycAvgze0aR+VPQeRKGw/lJYQcUqO0?=
 =?us-ascii?Q?xvhWvGHsIGk1JIsJWfnbD7TlxO5M0m0gdgZCDA3eAnd13elluh3qiv8oStzE?=
 =?us-ascii?Q?Io8smQ3P5RxImWnBo6PuwKY3trjup9JH4qPJkUtrK5V3ckOTN7N/4VZ+DPpG?=
 =?us-ascii?Q?1mR9gZs/DwbKmCEaBizJml5msLf+2EPiFs0EXUfK/2AP8vSw7wOh9BGaGfMU?=
 =?us-ascii?Q?JmgZzLu+0NEODrSWT54aVDfnjwDzxGrfqsxtxbO/eoZnh6cuA83s72AcWk27?=
 =?us-ascii?Q?ymTvz811WR2Q7LkCfSLpojoULL9TRtSUj95WkhnwrqeW8053hUjRCypJEPmU?=
 =?us-ascii?Q?ks29NzeZxnTdG2t+7ahV7kIDb75t0nNVJbwN7ieKmMQwhP9MyVkqcETt0X4R?=
 =?us-ascii?Q?z7V9UKy5XAcmpWMv3ypbGOh5+ppc+MPyhPBzvLzz+fu3ectnUsEdPGZZXOjp?=
 =?us-ascii?Q?LQ4OofrEi/Cb6FWu5+rgCRXY53MUerfh5D2lS4fh/wVzb5x7rl19MH71gith?=
 =?us-ascii?Q?zwuQGPYuG81QiKz69MjScSj0+J+zHxBEyjBGzGu93xguyOEQs2o6dvuUIY70?=
 =?us-ascii?Q?2QmWiCARok3YuluVwtjZjcMyAGvNEOGM8xbzBnbNL9Gh7FKK5MafnWZykxRJ?=
 =?us-ascii?Q?EZhYYoxj1oJmVY1U0dieTJhkKWNbFjOzWs2d0/vZIAsGG2TgUMb70wZl1yyg?=
 =?us-ascii?Q?vvvfRcUgImWhUppGyqtKNyk23HnvAoj9VsCdQevUb8pERHfcoA8YPklu8o8f?=
 =?us-ascii?Q?JQgomHWZihZTBCaGNtvxA4rnQogyWtVXk1jK0dsgI1bw6F2R/Qkx8DA+xyvy?=
 =?us-ascii?Q?XZyGpRefbpr86U46rLk2GJI/F0FV2aiLjg619syKuWGrv4iUqZGs80jomjau?=
 =?us-ascii?Q?09nYnoE0Y7CbhvW6BEuem/rclA7xsNL/YDVDjLY2xNwg7EcD3d4mPGYfY2YC?=
 =?us-ascii?Q?khC31Pi8S1EXdZ1w828fM+WPx7bw79Oh0GuS/seq5OQyYnYveXLi72UDgyOx?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wyg6J0JhJe7oTLo6ArXsMQWI0PncRdOkdgoa86MqwW7Kc//dg4yljVaM+VO8wbwWWwfT1ATyIhHlq6XFWzcuxkyCMFSXtza1BSMtwcXlIIvYxLW9y/PzPi6idrJs+NHRwbezEYBnPBoQLrENA3r0G7RJ1ICKt1T5yQcML0Up6HDnfqGigy/FSqHyl9UsPpvft5a0evbyj5v5CRX0J02PSpMCT7jfaWK3IzHB+YTQg6IxOeEa8ZMdsjWeKTf+Bck9+FlKKthN5xrzQX2+j4DNXoRFeU0lnL4R/wrVLenNGZUHHq6cr8pC9XyzqmZ7ysx0scR+Lcc3b2buFv/IS8YgBih/IIMd13BPudEkKmsuFHglhL60NjtzUXvLMlkw2Rx4n9RsiFRutcpitWcKXrp723OB23HSIgSuaLMaGiL+gW1SWG2IFXdvNvFhJbUAPG0QF8qhZkz6RfcV7d0sekctW02NIa1RWcnRII3OXr6SALpEoQWvpXqzrSKADXHc4VRTqan6JjYTzBUFhD+qLvw/sCWRIFbmCtnZ2BI+bj1jN6i/TmJ/ypYGJKkue1LON4nv+eQS6PrVXn4eCwbXa+x6wbJovs62vU9Qf+Ba0MV7S+SDv7FiSaFwTAbJ4m1/yJYzWyy/bHdfdVA9MlqKzSyLzrLD/Z4eNUAVZEB04smE6O0AeTLc5OYAvcnn4/MxFniUTlSEIOMVs7cWJOywkBh66chiM307DsjwJsqd747CA8gY4A/wrZ9RW+wF1O94LS3p+mdMZqKGfHFobx6/xicRH5dd8Hz4wkMwOZHfI9VgonpT64t0eOekyiOu4iKRyg3D31nPD+8wCSrNKHt7Ov64GA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20a29fe-9e8c-4c88-2057-08db95c3f5e3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 14:55:08.0974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X18GZFozM4IwAxQRlJm5j5LN+nvNccHzsxxuHLFm/aOvl6VwUvpYpyxVDe14cmQT6WlkqXzByWOhxsnDqLcIxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-05_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308050141
X-Proofpoint-GUID: khQJlIY4awy__bm6rsl9HtgZKVA39F_N
X-Proofpoint-ORIG-GUID: khQJlIY4awy__bm6rsl9HtgZKVA39F_N
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Aug 05, 2023 at 08:40:54AM +1000, NeilBrown wrote:
> On Sat, 05 Aug 2023, Lorenzo Bianconi wrote:
> > Introduce rpc_status entry in nfsd debug filesystem in order to dump
> > pending RPC requests debugging information.
> > 
> > Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=366
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  fs/nfsd/nfs4proc.c         |   4 +-
> >  fs/nfsd/nfsctl.c           |   9 +++
> >  fs/nfsd/nfsd.h             |   7 ++
> >  fs/nfsd/nfssvc.c           | 140 +++++++++++++++++++++++++++++++++++++
> >  include/linux/sunrpc/svc.h |   1 +
> >  net/sunrpc/svc.c           |   2 +-
> >  6 files changed, 159 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index f0f318e78630..b7ad3081bc36 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2497,8 +2497,6 @@ static inline void nfsd4_increment_op_stats(u32 opnum)
> >  
> >  static const struct nfsd4_operation nfsd4_ops[];
> >  
> > -static const char *nfsd4_op_name(unsigned opnum);
> > -
> >  /*
> >   * Enforce NFSv4.1 COMPOUND ordering rules:
> >   *
> > @@ -3628,7 +3626,7 @@ void warn_on_nonidempotent_op(struct nfsd4_op *op)
> >  	}
> >  }
> >  
> > -static const char *nfsd4_op_name(unsigned opnum)
> > +const char *nfsd4_op_name(unsigned opnum)
> >  {
> >  	if (opnum < ARRAY_SIZE(nfsd4_ops))
> >  		return nfsd4_ops[opnum].op_name;
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 35d2e2cde1eb..d47b98bad96e 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -47,6 +47,7 @@ enum {
> >  	NFSD_MaxBlkSize,
> >  	NFSD_MaxConnections,
> >  	NFSD_Filecache,
> > +	NFSD_Rpc_Status,
> >  	/*
> >  	 * The below MUST come last.  Otherwise we leave a hole in nfsd_files[]
> >  	 * with !CONFIG_NFSD_V4 and simple_fill_super() goes oops
> > @@ -195,6 +196,13 @@ static inline struct net *netns(struct file *file)
> >  	return file_inode(file)->i_sb->s_fs_info;
> >  }
> >  
> > +static const struct file_operations nfsd_rpc_status_operations = {
> > +	.open		= nfsd_rpc_status_open,
> > +	.read		= seq_read,
> > +	.llseek		= seq_lseek,
> > +	.release	= nfsd_pool_stats_release,
>                           ^^^^^^^^^^^^^^^^^^^^^^^
> This looks a bit strange, and nfsd_rpc_status_open is very similar to
> nfsd_pool_stats_open.
> I wonder we could unify some code a bit?
> Maybe change nfsd_pool_stats_operations to nfsd_stats_operations,
> with an "open" operation that inspects file_inode(file)->i_ino and 
> does either nfsd_pool_stats_open or
>     single_open(file, nfsd_rpc_status_show, inode->i_private);
> ??
> 
> Or at least rename nfsd_pool_stats_release to something more generic?
> 
> But that can be added later - it doesn't need to stop this patch
> landing.

Sure, I think this work is about ready to apply. I would like to
start closing in on the set of changes for v6.6 soon.

We can address clean-ups like this via additional patches.


> For this patch and the previous one;
> 
>  Reviewed-by: NeilBrown <neilb@suse.de>

Thank you for your review!


> > +};
> > +
> >  /*
> >   * write_unlock_ip - Release all locks used by a client
> >   *
> > @@ -1400,6 +1408,7 @@ static int nfsd_fill_super(struct super_block *sb, struct fs_context *fc)
> >  		[NFSD_RecoveryDir] = {"nfsv4recoverydir", &transaction_ops, S_IWUSR|S_IRUSR},
> >  		[NFSD_V4EndGrace] = {"v4_end_grace", &transaction_ops, S_IWUSR|S_IRUGO},
> >  #endif
> > +		[NFSD_Rpc_Status] = {"rpc_status", &nfsd_rpc_status_operations, S_IRUGO},
> 
> If this could go earlier so that the array entries are in the same order
> as the enum declaration, that would make me happy ....

I'll see if that works when I apply this.


> >  		/* last one */ {""}
> >  	};
> >  
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index d88498f8b275..50c82bb42e88 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -94,6 +94,7 @@ int		nfsd_get_nrthreads(int n, int *, struct net *);
> >  int		nfsd_set_nrthreads(int n, int *, struct net *);
> >  int		nfsd_pool_stats_open(struct inode *, struct file *);
> >  int		nfsd_pool_stats_release(struct inode *, struct file *);
> > +int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
> >  void		nfsd_shutdown_threads(struct net *net);
> >  
> >  void		nfsd_put(struct net *net);
> > @@ -506,12 +507,18 @@ extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> >  
> >  extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> >  
> > +const char *nfsd4_op_name(unsigned opnum);
> >  #else /* CONFIG_NFSD_V4 */
> >  static inline int nfsd4_is_junction(struct dentry *dentry)
> >  {
> >  	return 0;
> >  }
> >  
> > +static inline const char *nfsd4_op_name(unsigned opnum)
> > +{
> > +	return "unknown_operation";
> > +}
> > +
> >  static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
> >  
> >  #define register_cld_notifier() 0
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 97830e28c140..5e115dbbe9dc 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -1057,6 +1057,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
> >  		goto out_decode_err;
> >  
> > +	/*
> > +	 * Release rq_status_counter setting it to an odd value after the rpc
> > +	 * request has been properly parsed. rq_status_counter is used to
> > +	 * notify the consumers if the rqstp fields are stable
> > +	 * (rq_status_counter is odd) or not meaningful (rq_status_counter
> > +	 * is even).
> > +	 */
> > +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter | 1);
> > +
> >  	rp = NULL;
> >  	switch (nfsd_cache_lookup(rqstp, &rp)) {
> >  	case RC_DOIT:
> > @@ -1074,6 +1083,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
> >  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
> >  		goto out_encode_err;
> >  
> > +	/*
> > +	 * Release rq_status_counter setting it to an even value after the rpc
> > +	 * request has been properly processed.
> > +	 */
> > +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
> > +
> >  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
> >  out_cached_reply:
> >  	return 1;
> > @@ -1149,3 +1164,128 @@ int nfsd_pool_stats_release(struct inode *inode, struct file *file)
> >  	mutex_unlock(&nfsd_mutex);
> >  	return ret;
> >  }
> > +
> > +static int nfsd_rpc_status_show(struct seq_file *m, void *v)
> > +{
> > +	struct inode *inode = file_inode(m->file);
> > +	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> > +	int i;
> > +
> > +	rcu_read_lock();
> > +
> > +	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> > +		struct svc_rqst *rqstp;
> > +
> > +		list_for_each_entry_rcu(rqstp,
> > +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> > +				rq_all) {
> > +			struct {
> > +				struct sockaddr daddr;
> > +				struct sockaddr saddr;
> > +				unsigned long rq_flags;
> > +				const char *pc_name;
> > +				ktime_t rq_stime;
> > +				__be32 rq_xid;
> > +				u32 rq_prog;
> > +				u32 rq_vers;
> > +				/* NFSv4 compund */
> > +				u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> > +				u8 opcnt;
> > +			} rqstp_info;
> > +			unsigned int status_counter;
> > +			char buf[RPC_MAX_ADDRBUFLEN];
> > +			int j;
> > +
> > +			/*
> > +			 * Acquire rq_status_counter before parsing the rqst
> > +			 * fields. rq_status_counter is set to an odd value in
> > +			 * order to notify the consumers the rqstp fields are
> > +			 * meaningful.
> > +			 */
> > +			status_counter = smp_load_acquire(&rqstp->rq_status_counter);
> > +			if (!(status_counter & 1))
> > +				continue;
> > +
> > +			rqstp_info.rq_xid = rqstp->rq_xid;
> > +			rqstp_info.rq_flags = rqstp->rq_flags;
> > +			rqstp_info.rq_prog = rqstp->rq_prog;
> > +			rqstp_info.rq_vers = rqstp->rq_vers;
> > +			rqstp_info.pc_name = svc_proc_name(rqstp);
> > +			rqstp_info.rq_stime = rqstp->rq_stime;
> > +			rqstp_info.opcnt = 0;
> > +			memcpy(&rqstp_info.daddr, svc_daddr(rqstp),
> > +			       sizeof(struct sockaddr));
> > +			memcpy(&rqstp_info.saddr, svc_addr(rqstp),
> > +			       sizeof(struct sockaddr));
> > +
> > +#ifdef CONFIG_NFSD_V4
> > +			if (rqstp->rq_vers == NFS4_VERSION &&
> > +			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
> > +				/* NFSv4 compund */
> > +				struct nfsd4_compoundargs *args = rqstp->rq_argp;
> > +
> > +				rqstp_info.opcnt = args->opcnt;
> > +				for (j = 0; j < rqstp_info.opcnt; j++) {
> > +					struct nfsd4_op *op = &args->ops[j];
> > +
> > +					rqstp_info.opnum[j] = op->opnum;
> > +				}
> > +			}
> > +#endif /* CONFIG_NFSD_V4 */
> > +
> > +			/*
> > +			 * Acquire rq_status_counter before reporting the rqst
> > +			 * fields to the user.
> > +			 */
> > +			if (smp_load_acquire(&rqstp->rq_status_counter) != status_counter)
> > +				continue;
> > +
> > +			seq_printf(m,
> > +				   "0x%08x 0x%08lx 0x%08x NFSv%d %s %016lld",
> > +				   be32_to_cpu(rqstp_info.rq_xid),
> > +				   rqstp_info.rq_flags,
> > +				   rqstp_info.rq_prog,
> > +				   rqstp_info.rq_vers,
> > +				   rqstp_info.pc_name,
> > +				   ktime_to_us(rqstp_info.rq_stime));
> > +			seq_printf(m, " %s",
> > +				   __svc_print_addr(&rqstp_info.saddr, buf,
> > +						    sizeof(buf), false));
> > +			seq_printf(m, " %s",
> > +				   __svc_print_addr(&rqstp_info.daddr, buf,
> > +						    sizeof(buf), false));
> > +			for (j = 0; j < rqstp_info.opcnt; j++)
> > +				seq_printf(m, " %s",
> > +					   nfsd4_op_name(rqstp_info.opnum[j]));
> > +			seq_puts(m, "\n");
> > +		}
> > +	}
> > +
> > +	rcu_read_unlock();
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * nfsd_rpc_status_open - open routine for nfsd_rpc_status handler
> > + * @inode: entry inode pointer.
> > + * @file: entry file pointer.
> > + *
> > + * nfsd_rpc_status_open is the open routine for nfsd_rpc_status procfs handler.
> > + * nfsd_rpc_status dumps pending RPC requests info queued into nfs server.
> > + */
> > +int nfsd_rpc_status_open(struct inode *inode, struct file *file)
> > +{
> > +	struct nfsd_net *nn = net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	if (!nn->nfsd_serv) {
> > +		mutex_unlock(&nfsd_mutex);
> > +		return -ENODEV;
> > +	}
> > +
> > +	svc_get(nn->nfsd_serv);
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return single_open(file, nfsd_rpc_status_show, inode->i_private);
> > +}
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index fe1394cc1371..542a60b78bab 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -270,6 +270,7 @@ struct svc_rqst {
> >  						 * net namespace
> >  						 */
> >  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> > +	unsigned int		rq_status_counter; /* RPC processing counter */
> >  };
> >  
> >  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 587811a002c9..44eac83b35a1 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -1629,7 +1629,7 @@ const char *svc_proc_name(const struct svc_rqst *rqstp)
> >  		return rqstp->rq_procinfo->pc_name;
> >  	return "unknown";
> >  }
> > -
> > +EXPORT_SYMBOL_GPL(svc_proc_name);
> >  
> >  /**
> >   * svc_encode_result_payload - mark a range of bytes as a result payload
> > -- 
> > 2.41.0
> > 
> > 
> 

-- 
Chuck Lever
