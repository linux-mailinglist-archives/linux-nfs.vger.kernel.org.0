Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F507F09E0
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 00:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjKSXjH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 18:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSXjH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 18:39:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548BEB8
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 15:39:03 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJMdPLG007062;
        Sun, 19 Nov 2023 23:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=4b2xYj5ul9g6MtfMAjRtUn4t8cxKyMAylXOq+CtA0vk=;
 b=RLm/yt1UNgUxCctq+gSFOO+Am7diPVpt6Cm/BRhe5mlIjO6z7kh5EeWmSVNS4i6WYDlo
 k4HTE2sKUimcGRyyIvcsXJJMN6wR2akhlrJmBV5+U9wbJsXxsKjZVn84Li8tZvdPS4GL
 Tlv1YRyn++SWynAr/2sTlpy4t/ANoAD1ZuXw6yiz5V8pLeNy2/Xq2fcBKinCLJU0MyIP
 YOdj7GJP+ezBJn9Y7AXvcbY3AI3ZKLscPG7FOUr5iXsb8W6BGxeb4qFYIJ5wsa4JvIP5
 opSdGWh2Y+2lsScASb8V2sJvvHVpqX28dz4vJbcsMyvUpypXJNED2craTIplqKH0lbsV /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekpehme2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 23:38:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJNURV6037527;
        Sun, 19 Nov 2023 23:38:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq4mxp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 23:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NL+Hu0lYuw1QZpHAwfyAIH1cB0gnS7DvfpdGFhFw/uX1GLQ197Ox3Qa/6WeN6ql585U2Pa7SSBYrC4SQoGuwVfLULdslVgcerIuLNZiHlNIHRMw45/Mr5IsMkKDjpwcCecaB0xoWrNieP20/p1GyC9eY3MCU3jFvppz4kiqCfJMXsKJL6pwP/fmfjb5xy7zrVnn7YzbX7pf8vQ7WR7vol/xNeXb3qO3d4G7jseO0zs+dbJoRihQ8dxbaBFK4l9l69oRGUv6/9AdGWk+wDdguRvvaqXQE6JVa2wgKtoL7QillyIXMPiu57pNmk5yMLIFisHIzT3jb/NQiqs9SkBWtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b2xYj5ul9g6MtfMAjRtUn4t8cxKyMAylXOq+CtA0vk=;
 b=bcojoj6gvpGruPgXuD+0hIc5iKuaNfblJR6qGkQEnF1kyVHBhS1cuRP4G7Dn3qCNm5KXx8WKma8FQGeVvHdk2qa5su4U45dcR/hNF+fKv47V1/GjfGAzLvhnPVo0BvbhiBweBQW2DIuPzTUSpufjx2O8x63gSPUp024Uxd3XvU5xmZxsOTxEkj9ZWcEa40jXL5gnVq+6tkjVSLZdzcfFBCM7CrBA+gaEN2TaLOhS1sfbLEk8nXXNjRoJXk+iDq2OdncCMjOKYyVc83xHQh0dD/GsJaU6qVgQX9vBwaWHbhOz+Jr/9+iA472c6PR73aDOD7kTFzqrCOPkTokVp7yqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b2xYj5ul9g6MtfMAjRtUn4t8cxKyMAylXOq+CtA0vk=;
 b=kag8+aOPgS2YiTvdHrjOZEyvPcNhLbT2CO68msNgxLSbXlWJAF9E3hDx5wwyhOK5xqLMmg+TZeIPZbso3dAgJoR6isKbnnN6ZTB1l3FihmwFukyoDifFpB4wLFMoOx15NUagxwjWG1Z1xI0AVhVVwcuCHvDgnrg6GsjUCi+46o8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV8PR10MB7990.namprd10.prod.outlook.com (2603:10b6:408:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 23:38:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Sun, 19 Nov 2023
 23:38:51 +0000
Date:   Sun, 19 Nov 2023 18:38:48 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 1/9] nfsd: hold ->cl_lock for hash_delegation_locked()
Message-ID: <ZVqciNeBnfAaHZ6a@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>
 <20231117022121.23310-2-neilb@suse.de>
 <40e1bf417c635ce303f9e42ddb0e3dbd90022477.camel@kernel.org>
 <170042987584.19300.7721851585544522693@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170042987584.19300.7721851585544522693@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:610:76::31) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV8PR10MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 744407cd-6efa-47ca-b7f9-08dbe958af56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VaQSU+kmAUzc/jNYifUGNw9RVArjOrq38Gcmjl+8aOeQuwm5bq5ZzE5oHl14y8xU8wEp/S1SnGXf7xMbCFiCX1u2dWF+iMLkxtSWIAp8AtZq0yzgBg+B8jLUaU9Ry3a39oK4ZZWydhKlSyNetJsG6xsB2BAL6g6uYWeXWVQ6uRg1wy2oyRVjwF/sAtjv+13q074vpoANseiaVk2ZWAo0NUhistScaVKPHdBiBsDvUSvLK9YADHdrn9y82P1sZtadIYqomTNlHqBn6GDWoOn6/ORp8Q2ViLVls9Q0Vn5hEpT+Z81dFKqgp2+T28Qmu04h7Ucdja1ZFmaz5kEpThANr7jbOpjs2Gu465JQvao8cMlhKaa3HcOaNjU5ds/hAr/qqwinfO+LbbSeVIDxtDeE0yNH2rlj/p00oaNkxVpvBsYaqHTXfDr3PaN8BPsturD29tnPF/WWvC621fEDIYpE3axpfJe+uzdCaTDLajMWg7LCM88czWTZGETuQ6Hgc7XfUuswzPmri3PoeVB7sq3kqW6aWwq1DtoLOsdLCxSU2xyjqn4+bE/wXMr296g9eIPO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(6512007)(26005)(9686003)(4326008)(8676002)(38100700002)(8936002)(4001150100001)(2906002)(44832011)(5660300002)(478600001)(41300700001)(6486002)(6506007)(6666004)(6916009)(66476007)(66946007)(54906003)(316002)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wt60rVysZ955iBCeP2nlzfGKTtsjVtgHXtkkoQigs1KNAKeiBLXa2KiXoeyc?=
 =?us-ascii?Q?CSy5GDiBzCElMAlRyvZezFYqUNNKGeU+G3ORuM9VmxGn+GDEqn9Ysi8gWmLG?=
 =?us-ascii?Q?ygH+hVKXCqDgy1yqijd+rU8Myh9ChU2sDFUt2wjctM4NXvVAfNsUuXuEvtHm?=
 =?us-ascii?Q?DoFqtaM5mw9Ox/WApQpJeGPGjFoPOHX6Gf/9XcPSv7gCu4FHUMYp07oB0jpr?=
 =?us-ascii?Q?Iy9qKkCtmdjcKJJPAtyiLMhn+BE695sIBDv+iifG1J9AUj2bschq9u3B3HUp?=
 =?us-ascii?Q?vwu/z8Kw2HA8zXnzVoEReMXAKsyA2HxDhvhMFoK20m6WLZg+/jcLg47qkeBT?=
 =?us-ascii?Q?eu6U9zTlQpxc88w3lharYnz2ZroiL+9N1jMLfq8wcJLjyV9oWJczwghpshYX?=
 =?us-ascii?Q?86tSeD8RDg1+huajgWHE5LrIs8tPH9Tz+cASLse3MdymY2XvWL5/WuD9tHdj?=
 =?us-ascii?Q?bjlLiOwyn36L50j91TckDDjGCb1nuH5DCZTmoqAaJ2vZm32x/BN7uW/fWgq4?=
 =?us-ascii?Q?xmXjhVlvea6DFfZTm2lWxFQi7nbXmCNpH5BNTdDdimR6M1DC7bRWSsvR4oHw?=
 =?us-ascii?Q?X1rOUJUoMEsndPWu0SFx9KKezlK7SsY7INtPr4KQGkH69+KA96zKsoA4Drxz?=
 =?us-ascii?Q?zc4n+in050MZe6NtOO+yWqueWhYMS1KN09lSRKE3VT0i9Xp7RNfIW1DOvqcL?=
 =?us-ascii?Q?NJF1f4jvgCxHnXkTozVPAbjvNk/UUvaW4U4AkkSm3bA7/iQMl8o93MiZvEPR?=
 =?us-ascii?Q?xxISS+fnn7EeNAKfHfUQ7qiRFqYQhL7Ekc1UXiqlshxMuPnPVFBxP1/GQD3C?=
 =?us-ascii?Q?IGWLkC9E61KStyCFayGoT3ITEFF3j5PcH6T7aK/llo94E0eJqxpvEK558sJk?=
 =?us-ascii?Q?hjrr9TXAflXcUiTaFybuDOrl5B1fjJA+i8ha44vUEoWgHimYz+TOfnQxZWA8?=
 =?us-ascii?Q?7dMaXFTedBnxjC13kR9q+BBgWXLeFUxW3zsurzBLZj/f/kKJuybFEKTp+LDn?=
 =?us-ascii?Q?9yVLtdE0iTw85ao9UgvH9BvLl7PCcyGDj7AlAgnwopfZKzcCtc9dVI0ond0u?=
 =?us-ascii?Q?0mpn4ZpIKAPqmPYgfKNfHK5/i+qcokB24KIifbjXn6kkgLkJFWL9JNDG/Zrd?=
 =?us-ascii?Q?pccw9joSf4oEe92Ty39awu1mq3zwCFuJWu3w8yADZEKxU/m9RTXYEErzJaRW?=
 =?us-ascii?Q?Vp6vJsmmzgBS/xQWqnwNcJvbZN8wQaCKYxXtlHN7YQ4BfzTZ+46OOWlNOmAo?=
 =?us-ascii?Q?NJHcbxsgDbO2c1Ru6GvjSMzWds5Xue7MYZP/5VcbXunGNkW1v5w1xDz3DOMP?=
 =?us-ascii?Q?U1qkuWTFmEZGix28of9BcuZtAuDSuBsnB4jDLgd/C3lSczkgSjL3Sj2W1VEu?=
 =?us-ascii?Q?0xGbTnue/Vh8Vhy1F9FiGFUbhKklgiGtPJaQtOzaE+OvBFslqwELSTZNHmD+?=
 =?us-ascii?Q?qoP03V1HrGHNB3tffRKBSkChUnZVVGvo+O37RlLFRmm5Jr5ZWrvYwcOyhxuG?=
 =?us-ascii?Q?B6U3KHxzpGY6eY8MMK17CFbtK9eeYf5V56QgQSpM/sQ8Zq6npHDck8knBqBE?=
 =?us-ascii?Q?xln/SOQxq8HL19aJswNJU3TGBXNQID9PxbA8ERJjg116RmWpnyjaYU5uObCt?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3lQjykj2h6Ed0gDVsJxCQEkFYuccD7B38rFjlWMLRFK2XrzEeQfZeH7msLBIJgip4Ucdmy5jEM9IwWgkFfYc4ZTttLItvy6w24tmv80gbJSvfpX1eOJxKFnYYQ1T+BiJ/OVvky8cCMr4yOwP0c8DMICFbBH/rWc2gpd3hXyr2IjTv1fSQ8Z+w7vs9u0jgqX/xYIZe+VcDo2x5eSj5VfWcN2phLK932GI9ADUN/MUcaMuarJJCz3GrlW0I+cMuIacptOamHbf0nEmZiyuVmUuubeegNU/fFUBiPNhThSzy1u2xky1w+w0x0igwHkLvyza5ARERQppB219oYwoZntIecFeY5zsRnYeHAt787ry0bkpL5OXW3Qsu4dwx611cEQptRfya3T7F402VubMIB2GBf1f8xPQs91NKFbSyCvz9AQr2ceLPkencYOAMnGHKYN1K/vcs5L73xCaYEQvaPuhAWyIhbfVgn2aIOXhqKa59vgUTHm67F68eNUOGo0bjRDZ74lM4MKvfJxp6/wYgqWPoXumL+olBFndHthFo9/uXR5aqIQpzGhZtvapRIfrYj5PxlBxPaw3T7uzdCEJT+hu4Tjy4As5qIj2bEEGf5qngcDAi5b6zEv8+jivIRMa5i9sfn9Fu/kPsQp5djXrRDHJNOK8x0ruCUpizyCB6bsoe/A0UP662Y1MmIKkuNtPvpOCurbQjDkZ+Rz5sW/ddKR2SH642VNyvIk2Lxhk4MlPQ0W1X0XFI/LQ5ksgRL1eLYNbQqpVmoDqglJtix5lpSUp++821BC0xORNis/5ZpT6WeZ54QSkLo7s0HaW0kx5CTCKMqSRbn4uDWKpnP4MrgbauAoVmmygWe+Fea3aEfsYgReN40cTSJk9Tw0ZqzW3ogNj
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744407cd-6efa-47ca-b7f9-08dbe958af56
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 23:38:51.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDoOlIDL74zVbNODbBIpHU1q4duNNtXwCQFjVn+GBNl71LO5BPdRcE7lIdirTj/BPZkJTwCcBG5aOLhtyE6XSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_19,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=834 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311190181
X-Proofpoint-GUID: BfAXvUArXkTdTXnLw-ySO66yJ-MSy0RN
X-Proofpoint-ORIG-GUID: BfAXvUArXkTdTXnLw-ySO66yJ-MSy0RN
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 20, 2023 at 08:37:55AM +1100, NeilBrown wrote:
> On Fri, 17 Nov 2023, Jeff Layton wrote:
> > On Fri, 2023-11-17 at 13:18 +1100, NeilBrown wrote:
> > > The protocol for creating a new state in nfsd is to allocated the state
> > > leaving it largely uninitialised, add that state to the ->cl_stateids
> > > idr so as to reserve a state id, then complete initialisation of the
> > > state and only set ->sc_type to non-zero once the state is fully
> > > initialised.
> > > 
> > > If a state is found in the idr with ->sc_type == 0, it is ignored.
> > > The ->cl_lock list is used to avoid races - it is held while checking
> > > sc_type during lookup, and held when a non-zero value is stored in
> > > ->sc_type.
> > > 
> > > ... except... hash_delegation_locked() finalises the initialisation of a
> > > delegation state, but does NOT hold ->cl_lock.
> > > 
> > > So this patch takes ->cl_lock at the appropriate time w.r.t other locks,
> > > and so ensures there are no races (which are extremely unlikely in any
> > > case).
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/nfs4state.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 65fd5510323a..6368788a7d4e 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1317,6 +1317,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
> > >  
> > >  	lockdep_assert_held(&state_lock);
> > >  	lockdep_assert_held(&fp->fi_lock);
> > > +	lockdep_assert_held(&clp->cl_lock);
> > >  
> > >  	if (nfs4_delegation_exists(clp, fp))
> > >  		return -EAGAIN;
> > > @@ -5609,12 +5610,14 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
> > >  		goto out_unlock;
> > >  
> > >  	spin_lock(&state_lock);
> > > +	spin_lock(&clp->cl_lock);
> > >  	spin_lock(&fp->fi_lock);
> > >  	if (fp->fi_had_conflict)
> > >  		status = -EAGAIN;
> > >  	else
> > >  		status = hash_delegation_locked(dp, fp);
> > >  	spin_unlock(&fp->fi_lock);
> > > +	spin_unlock(&clp->cl_lock);
> > >  	spin_unlock(&state_lock);
> > >  
> > >  	if (status)
> > 
> > I know it's (supposedly) an unlikely race, but should we send this to
> > stable?
> 
> I don't know.  Once upon a time, "stable" meant something.  There was a
> clear list of rules.  Those seem to have been torn up.  Now it seems to
> be whatever some machine-learning tool chooses.
> If that tool chooses this patch (which I suspect it will), I won't
> object.  But I don't think it is worth encouraging it.

We've asked Sasha and GregKH not to use AUTOSEL on NFSD patches,
promising that we will explicitly mark anything that should be
back-ported.


-- 
Chuck Lever
