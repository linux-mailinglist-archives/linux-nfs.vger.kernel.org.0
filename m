Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349137F09E1
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 00:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjKSXlp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 18:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSXlo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 18:41:44 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F25B8
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 15:41:40 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJMeGTC015966;
        Sun, 19 Nov 2023 23:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=QaBe6zwyiAdxqlbdUkWbu9FprohzyvbBJrWHuG2fAro=;
 b=qXfQDoSnWQeW9K0lLfEevsrlmQaDOED6dzeh+D3okLRmTWMF1OWvLXdedOESM6KS+rpJ
 i5rsPd0zHDDcO0LmbDxtXiScH1SzFFLDXZBu75ssckpqeFOt4rJ5yNYEaLFv/3WQbPz+
 hz/uG3e7Kc7zjUGjAaL1a9LrEAVYwMby+M2CaefBxV6QbmP4iNxxB6B/AjrxY406FqY+
 SQc550loxEOrsgQz7BnrcAG9ronOqki3SoMf5fBJuBURFykM+JzLCJKeTXP/n4YVoCpN
 QjEEgNlbbxgF221GYelf0WsfnOLnSM7QvMwLbprYQjNxIxSHoFrOKXeDtpArzBtlBCfE Eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uentv9hqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 23:41:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJM2I7L002375;
        Sun, 19 Nov 2023 23:41:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq4mw44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 23:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9C7iohDNUTIW3tENXFpzXcZnffwe9yiRA6gOnQGJqggRC1EyW8MoBLOW9X9zpgVKk1KWfp9CjKxdM4ihSYCHSSP0Wj/8aHtQJddovbakRcj5Uw3cpglUmLSysLFRys5l3+iym33Bpeh9wN1P4b1Mc4EdgxZ/3W2Jt1bL8RBg9xNs/eFe+tVYsXmOwbYOvxWVJqCpxhv2CtIDqc096cQOtTjG78piUWQhe4hy7sVdiFVWV1KC7wX4M0BUfPu2w2z6SFa/svGRHsi+xyuw9j+Z4WucdDsMIx7BZZZVWcLJRTR3aSP7BxW+/WIYh9HCGQWuDOPeB3+ZlLpw9m8TRRcMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaBe6zwyiAdxqlbdUkWbu9FprohzyvbBJrWHuG2fAro=;
 b=NgLlhIZ9FhPVQl7jMdSBG2m8aXphrH/cGOYx/MMjRE8naEKjXdNekGm9i8T+VJKKhEmhKZL3Wn8w2/+HM28eZTj7IQdq1QOJX3hOn9KezcAdxXpZywvu5+QqyDsbpVGKbh7BjM8j+VpnSbPRj7HxN0HvAcb4ihSdnQHEOyf8dJ9SpQhm7ZwOKn4byLz702TMB4HlPds627uqpeFG7iGDll/UDkxyCpYtuEojJzSZsj5XuRJVhpt6FtMPQSazQS9mikwz4oz7szNg6Pk2pLM3SMxGKKHqli4iLrjRAaFCASNFNHzZt+UGkCqsbOR33qLsVV2120O9NyGtAK33jd4FBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaBe6zwyiAdxqlbdUkWbu9FprohzyvbBJrWHuG2fAro=;
 b=kKoglyQCDMYb6J4uP6WpiruGxK6yoBYJmMGbH5KebOJK4MfuSWT5SgS0H20CnV5NQQOO7J/lKbD/GAieSVkBoMkDQEXEzB3G+fFXn1A1DpUzyhfbx62TyTgve64c1Iy8ZiBKnh9/v38mXcs7JiQKSIBPx+TyTuMRAxWXNEVmju4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7990.namprd10.prod.outlook.com (2603:10b6:408:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 23:41:21 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Sun, 19 Nov 2023
 23:41:21 +0000
Date:   Sun, 19 Nov 2023 18:41:18 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 2/9] nfsd: avoid race after unhash_delegation_locked()
Message-ID: <ZVqdHt4vamFPiXHR@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>
 <20231117022121.23310-3-neilb@suse.de>
 <40e3c09538c58818e5ab0c713a49d62304c4c4a0.camel@kernel.org>
 <ZVfCTVTmNd0cgqcY@tissot.1015granger.net>
 <170043262319.19300.1603901477254585695@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170043262319.19300.1603901477254585695@noble.neil.brown.name>
X-ClientProxiedBy: CH5PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: e61f0b0f-8368-48de-6442-08dbe95908bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6pfvZIw19ge7nRFrYIrQUqCMLLnWyI1b69++HMaCTkR0EnO9JwINLkvcUsHc1b/o+moHtNfFnvJYFTN1qiU3ZRsYJXtnI3g/pu6t3LRhLaav+FpnF3CxJe+ghsJ8sFBbjTnD5iMvYXQDEVwvHFJ40DgIOwNJTwaF2gdh6C43vQOwFZHBTUWO27DqBdDWN80QKwLZAc/2etC4bZFAKIeRKI8C/LPX3T4aF8NY/HTwRqZ1ahRGIVHR+HqY5+3UNTCZfyQHRsCSfkBkok9E9QwtkKU/OS1pwufuoZCQbURZWe3xdwwo8guRXHTWp1RpOniLJ0yLaGNJgufEHXhLm88wuvjsvAFl5Ogwj8Iz6cQmUKOsbfcHiHigqoXCcWBk/GV/8fhx3WCd0gqSVY8vRwOFOyxYeckGqXXxHbvFKzFcSCiUJLrw5xk2uXNJsChFtKs53+sTO5lUR66pah1rbJ96k0lyVzLzSW3AO6tqB4By/VSQPE4v8kITp+A4bq82FkmtSPihg0k5ZOrXSnmluuWfKq60nTdLgsGpfRKF/NaQrl06gsJm/cFeCYfKylAii11n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6512007)(26005)(9686003)(4326008)(8676002)(38100700002)(8936002)(4001150100001)(2906002)(44832011)(5660300002)(478600001)(41300700001)(6486002)(6506007)(6666004)(6916009)(66476007)(66946007)(54906003)(316002)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKjjdPxvc7i6jq1MPbH8T+3zII6zH33roeG5ZwmqQsmglb7NbCak2u+LBnDo?=
 =?us-ascii?Q?9zgeXVZ5gp6r0D7cii7bhwQVp0QCSP8UTR1mzu/TLAY0c9+b6WRlcJsluEm/?=
 =?us-ascii?Q?I25N/HcRKbyIDgMnHuWQoRNfGGv5HtwMk18lIZx6QpVcW6VluGQWp+t8NIPB?=
 =?us-ascii?Q?6netlPHKOo5VYCFfAx27HN8WZluketjAwR5rul8ceDQQY4cowyyvuFw33yz2?=
 =?us-ascii?Q?E+v3yfziBGpQNE7Ku0w6UnGb426okA1PACle/FsDvKQAe+rg6wJWueY7Jqf2?=
 =?us-ascii?Q?mrzWTOfOSA8mtOqc1DG9Nks18hbFY7pS9qfW9285t7KIW5aG2WY3+W2vqHMn?=
 =?us-ascii?Q?dtXqyial4gBsckQcwK3hxj4euyBQh/m7vL79xuDenfIpFg6uvF8m2VrmUbB7?=
 =?us-ascii?Q?0UoGKT6gZqUN2SkdK3itT1vtR580L1B4Dt6Zp4OoLBnOrLy05xcpv+nRdb9c?=
 =?us-ascii?Q?NOCD5lt9ccQjGeYGWhFj5k8lDm2j+IDKkRuVqEnuNXg/xvVvZXR3t8TXndKl?=
 =?us-ascii?Q?uMlFaSo4JQB9I9MZRZb5/BobQwx3rgmsFjf+CxJlMjUl+/Cut89JySkKfwCD?=
 =?us-ascii?Q?uuBg7//YgH9H2f2TCWt4VuF37GsyBVUwGsFtQS05eeiJ5Nc0NlVn20qLvFem?=
 =?us-ascii?Q?DCWd/qkwkbzlTskN7/22GC8nulTfS2k3HQkYSlxfNeVWsLP/SUkkz9LSXDjW?=
 =?us-ascii?Q?lCKT/9uJwyYzhlCtW/wr2RID/qkK4jNCPddeSLfeBrzp2JfT3w0S7imK42Qu?=
 =?us-ascii?Q?7RVcYUs5Ljx9PnZh8Qton3X2mO4qeIXH92rEyrZbvmfVIHx85ZW/FTiFKUC+?=
 =?us-ascii?Q?l/5fG1pTr0JNPtZiUadViad6xRIekZvqrrnT5UC3niIQBD8Iv+p6tKUjWXWj?=
 =?us-ascii?Q?eoQI/MG9yRUTzkvr+rYbxFjqRNWfnzJtXiTV/hTZl3U5bYoAPSHu6owksWq3?=
 =?us-ascii?Q?prwJoG11MZWLRanlm1zx6jGfNmf3jm1sAVVO2cxLeDFyEwLI5dfOmcbWyIW6?=
 =?us-ascii?Q?HfBvOq5eKSEpgPN/ZkyYhMihRvuFEDgsBbraHdwN88iKM6b2Qp21dgjxdw6N?=
 =?us-ascii?Q?10O9dFubMba0mdYF1XWILl45d9sriNKy6VxFkoZYa/pc4EEciiRmrgkkpGlD?=
 =?us-ascii?Q?6JnCuXPcPG8AHh9Ai0HgycLLuFuonL4kGW2QQqutsaFZsC/iQVRN/rgdrnQZ?=
 =?us-ascii?Q?cr+eO3S3O3upt+gDX0qKjIHUFYrcAx061OjNmfY/l8mCG8Cww/LAIHrCGm6y?=
 =?us-ascii?Q?nPq8tbCJhJAq+89T9bM/03TwFbclCf6gfnkhqntbsZdblYBlObX03VkUrqkb?=
 =?us-ascii?Q?1ygKiF77ett+Yid+XcKPuP+/PTBdVI/o7VJvDQmm6frHasA9whIUsIn5v0z9?=
 =?us-ascii?Q?KSZJt+YuC3eWzwarwbHfDGIBg2xPfqURC3XNMMQ9MGW+96SmjIP7c0J836ZF?=
 =?us-ascii?Q?6OFUMzPXGwlUax8sFn0Z1XWREiovD4AiFmfytGf3ACmndSZyiYR8n6BItLga?=
 =?us-ascii?Q?Qp/3dkmE3QGfZOVlWFj+Bepg+6bTCf70w2i7R3aNcYJdYZ9ZCQgJIhdDvAyW?=
 =?us-ascii?Q?P6YaP6YELFi4eGR/JAOQeQfPI1XwIHAVYa0hwt/O2C+HnkZD56GpChJMsHIT?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d5JT8mKnxNP+Xzn1P1LOhmbiakLWdYTT3p5PuHLeFLuRE9p72Gj8vkjOG/J6N2z6tsBKPIeDccgoJrnY48Hk6XvUU+Wniojlpki9ioN0Lyk9QLabj5DmbxNBTETAQ7NTPqWV3s9cmNhyiWm75LP/S7gWZQeXBuzgR4h/+SBZ/7+J2L4wTd4P5l6DIYOJgX5VKQ/XUfmV4UHczABMo5c74b3Ml4hdjqRGzYhB8wbDXkR+8gflmhiiRHNhhip2l30ptRIjhVsNod5LvsJj20twLWvPeNcCaHyhMqx4Jndh+OeGgOWLWveNIinZu08SEMDP8oXizdht0O8Ph+3eHMltpHNpf7YNolw++Gc0iMAcFZUdEl2IgJM05QVJuT/aZqGFeb1ceQGtdPvZ37nAdf2HJcRjkCamVe9MZBErBPBTPH0DTaarWbD1aaHu0YjFAcl2tkYOSzgaRx/WqwSBLjcMm261BAlqIKCJ3rsgnTiSl8fOt0Bbz+13TKd5yUU4yXYOKxTW/zxWSH9bHAbFP6mONwXVjeyk7UTbLQUtNsDt6jnFQFnJ6CGTtklpnQqa5GJOL9n2/DfFlEy/aYQM8TdP6KD2VUbDPuUjFQGGsKVMboBeTNp+/DuWW93VSRcTFUJfQlKGhVYMgf8SG9m8RX+rMshoNA2c4fKlS9ItM63vm6zjsoxW8bNk/8H4o49UVH4wzg9y81793SRJJcbmdbZ2/HF1n/7mLoAj7McAC9KRx5dVrXm2soCgWUlEB7dlWc56M3qTm1wSFrTmosELNspXCYnnFBaZF0WS6vfCNowZ749wn03oQMF2xO6Y4PYJRguZnoESQ1W8Pb9YdSTRoQ5NwTtg3GO0KmA4c39wZHJI8Jo5Bi++AtPBQmOTHspxN4tF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e61f0b0f-8368-48de-6442-08dbe95908bf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 23:41:21.2476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB/eMMjskF1lAuNn3MjgBlMeKnd73Lc5e6K2cSj7gY6l00Fb2oKUA4ZlUGVMeUgxJUaboSaht5vCd5FzbrWnRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_20,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311190181
X-Proofpoint-ORIG-GUID: 4qi8k_snFAhdSzQxdTuQ_pVSB_Y_zckd
X-Proofpoint-GUID: 4qi8k_snFAhdSzQxdTuQ_pVSB_Y_zckd
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 20, 2023 at 09:23:43AM +1100, NeilBrown wrote:
> On Sat, 18 Nov 2023, Chuck Lever wrote:
> > On Fri, Nov 17, 2023 at 06:41:37AM -0500, Jeff Layton wrote:
> > > On Fri, 2023-11-17 at 13:18 +1100, NeilBrown wrote:
> > > > NFS4_CLOSED_DELEG_STID and NFS4_REVOKED_DELEG_STID are similar in
> > > > purpose.
> > > > REVOKED is used for NFSv4.1 states which have been revoked because the
> > > > lease has expired.  CLOSED is used in other cases.
> > > > The difference has two practical effects.
> > > > 1/ REVOKED states are on the ->cl_revoked list
> > > > 2/ REVOKED states result in nfserr_deleg_revoked from
> > > >    nfsd4_verify_open_stid() asnd nfsd4_validate_stateid while
> > > >    CLOSED states result in nfserr_bad_stid.
> > > > 
> > > > Currently a state that is being revoked is first set to "CLOSED" in
> > > > unhash_delegation_locked(), then possibly to "REVOKED" in
> > > > revoke_delegation(), at which point it is added to the cl_revoked list.
> > > > 
> > > > It is possible that a stateid test could see the CLOSED state
> > > > which really should be REVOKED, and so return the wrong error code.  So
> > > > it is safest to remove this window of inconsistency.
> > > > 
> > > > With this patch, unhash_delegation_locked() always set the state
> > > > correctly, and revoke_delegation() no longer changes the state.
> > > > 
> > > > Also remove a redundant test on minorversion when
> > > > NFS4_REVOKED_DELEG_STID is seen - it can only be seen when minorversion
> > > > is non-zero.
> > > > 
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 20 ++++++++++----------
> > > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 6368788a7d4e..7469583382fb 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -1334,7 +1334,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
> > > >  }
> > > >  
> > > >  static bool
> > > > -unhash_delegation_locked(struct nfs4_delegation *dp)
> > > > +unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
> > 
> > unsigned short type ?
> 
> At this stage in the series 'type' is still an unsigned char.  I don't
> want to get ahead of myself.
> 
> > 
> > 
> > > >  {
> > > >  	struct nfs4_file *fp = dp->dl_stid.sc_file;
> > > >  
> > > > @@ -1343,7 +1343,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
> > > >  	if (!delegation_hashed(dp))
> > > >  		return false;
> > > >  
> > > > -	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
> > > > +	if (dp->dl_stid.sc_client->cl_minorversion == 0)
> > > > +		type = NFS4_CLOSED_DELEG_STID;
> > > > +	dp->dl_stid.sc_type = type;
> > > >  	/* Ensure that deleg break won't try to requeue it */
> > > >  	++dp->dl_time;
> > > >  	spin_lock(&fp->fi_lock);
> > > > @@ -1359,7 +1361,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
> > > >  	bool unhashed;
> > > >  
> > > >  	spin_lock(&state_lock);
> > > > -	unhashed = unhash_delegation_locked(dp);
> > > > +	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> > > >  	spin_unlock(&state_lock);
> > > >  	if (unhashed)
> > > >  		destroy_unhashed_deleg(dp);
> > > > @@ -1373,9 +1375,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
> > > >  
> > > >  	trace_nfsd_stid_revoke(&dp->dl_stid);
> > > >  
> > > > -	if (clp->cl_minorversion) {
> > > > +	if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
> > > >  		spin_lock(&clp->cl_lock);
> > > > -		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
> > > >  		refcount_inc(&dp->dl_stid.sc_count);
> > > >  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> > > >  		spin_unlock(&clp->cl_lock);
> > > > @@ -2234,7 +2235,7 @@ __destroy_client(struct nfs4_client *clp)
> > > >  	spin_lock(&state_lock);
> > > >  	while (!list_empty(&clp->cl_delegations)) {
> > > >  		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
> > > > -		WARN_ON(!unhash_delegation_locked(dp));
> > > > +		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));
> > > >  		list_add(&dp->dl_recall_lru, &reaplist);
> > > >  	}
> > > >  	spin_unlock(&state_lock);
> > > > @@ -5197,8 +5198,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
> > > >  		goto out;
> > > >  	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
> > > >  		nfs4_put_stid(&deleg->dl_stid);
> > > > -		if (cl->cl_minorversion)
> > > > -			status = nfserr_deleg_revoked;
> > > > +		status = nfserr_deleg_revoked;
> > > >  		goto out;
> > > >  	}
> > > >  	flags = share_access_to_flags(open->op_share_access);
> > > > @@ -6235,7 +6235,7 @@ nfs4_laundromat(struct nfsd_net *nn)
> > > >  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> > > >  		if (!state_expired(&lt, dp->dl_time))
> > > >  			break;
> > > > -		WARN_ON(!unhash_delegation_locked(dp));
> > > > +		WARN_ON(!unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID));
> > > >  		list_add(&dp->dl_recall_lru, &reaplist);
> > > >  	}
> > > >  	spin_unlock(&state_lock);
> > > > @@ -8350,7 +8350,7 @@ nfs4_state_shutdown_net(struct net *net)
> > > >  	spin_lock(&state_lock);
> > > >  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> > > >  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> > > > -		WARN_ON(!unhash_delegation_locked(dp));
> > > > +		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));
> > 
> > Neil, what say we get rid of these WARN_ONs?
> > 
> 
> I've added a patch with this intro:
> Author: NeilBrown <neilb@suse.de>
> Date:   Mon Nov 20 09:15:46 2023 +1100
> 
>     nfsd: don't call functions with side-effecting inside WARN_ON()
>     
>     Code like:
>     
>         WARN_ON(foo())
>     
>     looks like an assertion and might not be expected to have any side
>     effects.
>     When testing if a function with side-effects fails a construct like
>     
>         if (foo())
>            WARN_ON(1);
>     
>     makes the intent more obvious.
>     
>     nfsd has several WARN_ON calls where the test has side effects, so it
>     would be good to change them.  These cases don't really need the
>     WARN_ON.  They have never failed in 8 years of usage so let's just
>     remove the WARN_ON wrapper.
>     
>     Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>     Signed-off-by: NeilBrown <neilb@suse.de>
> 
> it removes 5 WARN_ONs from unhash_delegation_locked() calls.
> They were added by
>  Commit 3fcbbd244ed1 ("nfsd: ensure that delegation stateid hash references are only put once")
> in 4.3

Very sensible, thank you!


> Thanks,
> NeilBrown
> 
> > 
> > > >  		list_add(&dp->dl_recall_lru, &reaplist);
> > > >  	}
> > > >  	spin_unlock(&state_lock);
> > > 
> > > Same question here. Should this go to stable? I guess the race is not
> > > generally fatal...
> > 
> > Again, there's no existing bug report, so no urgency to get this
> > backported. I would see these changes soak in upstream rather than
> > pull them into stable quickly only to discover another bug has been
> > introduced.
> > 
> > We don't have a failing test or a data corruption risk, as far as
> > I can tell.
> > 
> > 
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > 
> > -- 
> > Chuck Lever
> > 
> 

-- 
Chuck Lever
