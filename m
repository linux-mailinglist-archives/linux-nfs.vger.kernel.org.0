Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907ED780CA7
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244449AbjHRNiu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 09:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377280AbjHRNiq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 09:38:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457003589
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 06:38:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IC95JI003081;
        Fri, 18 Aug 2023 13:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=OTL3uYgv7nAnFdOp93VK5VcnvCvPsvAj2ffMwaPW5UQ=;
 b=Ry840tgRC8/fKvZKzYECVdBxfX0dGrpVJ/p9OYPrFD8LbDIpV2VdBbaNZXawaZCZS215
 /1ZaBrRtqZZJAAo+q/SHLN4woEVOr167fXiTQgQC686Rthlg/vIyQWzYcIQVDkGO0g2p
 JZQJWcfWQsB5Y9dQSQP8bGF0CjetpI7rlaI348DZyRhi+pQwOUDQFmVSCCnLuir5gMPh
 xHGUC8pAbJm8V4elcHk9R0/mZnP3auxo+9p4X7zJhW7QlN0o2195rU0lzyIBp5SsyVGp
 6QmYeeiL1Ye5CBZ/g5ifRsJkebz3UMgerhlHKICfS0mNCJut0cty/mPRWspMksvDHIQd 1w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfuqp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 13:38:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37ICFbHM006639;
        Fri, 18 Aug 2023 13:38:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey2h69et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 13:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaMZFlbS4qsGukVa1682uLnIWyugJpE9ou04BdlOfqUjtJvvd3GkBfmx2SyGRdX/JXvsA+Vz4eIH/zbTdYQxkGDsaEhybZByRoAMLXxglDpw/i40CdU7usM5V8FFrS+xxSbisUlsueQGuMMH0tI/wWJUAnSYlG2yCupB30itCij8H+/Vb5lpZitPsF62m91ohIzbY7PlbwBg2+Hn+4rSHIa0HmEVaXAf6dg5TtUfc/m6r+gXto8/j4jPduUuZ/vGXaEViLyDrgIfjhyvNIMRdWMeG5NgT1s5AbWNcaptctXv9fWZ6Bz0ASyqMvP9woSpyiNMjScsvQw0GDDtgKp58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTL3uYgv7nAnFdOp93VK5VcnvCvPsvAj2ffMwaPW5UQ=;
 b=hW9vf8baIslmdl73DuXB42/jYxr9+9bZIXLNohm2VfbiKoabhEC+p1J55HPAgA0y9J/VulFG3DZhwlFXRMy6mtURUauyyRcHN+yoaS92KGWc8DSmCxpsRPLG2pDuOpJrrzj9IIP99CpIyw3qJa5w1zy6j8bsW2UkFMi79KyWuYs1zJlDQdacfxS8L0F/Bn/dD3WFP1r/aNFYi0J3TBkfmSqD7Osku+dNOckcbCrO0A02ECkoJEQQHNiY1fQYLl5ww4U3nCyJHyD7SZQZatAdVIxVuuHK05i6F1Yti6tL0tAbSiVvguSLeIKlTMAHtinOvUpxgzt1eaKsuaEUmVtiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTL3uYgv7nAnFdOp93VK5VcnvCvPsvAj2ffMwaPW5UQ=;
 b=J0k8HybaKuN16T9X5MENB0KueLq6C4NZvH2gQ3sDaNYbOx/OBZ9mQhUMPo2jKI3qb5UbyPLXWyr4WB8GPgMXA82V778T1VYjnxZdJ/gbEGF4rpt8yhtZkjzMr7DsEozbrAvCzQ2RilLe2J6PW274ZuOmksCnt02x1zyfc8ElLyU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5403.namprd10.prod.outlook.com (2603:10b6:510:e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 13:38:27 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 13:38:26 +0000
Date:   Fri, 18 Aug 2023 09:38:23 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 06/10] SUNRPC/svc: add light-weight queuing mechanism.
Message-ID: <ZN90Tz2sDLs1Lmyd@tissot.1015granger.net>
References: <20230815015426.5091-1-neilb@suse.de>
 <20230815015426.5091-7-neilb@suse.de>
 <ZN4xgOjEIDe0rX3i@tissot.1015granger.net>
 <169230997620.11967.10640869594379522024@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169230997620.11967.10640869594379522024@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:610:b3::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH0PR10MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 64bcaa98-029f-4ad7-4bcd-08db9ff066b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DMAuUIf8q7TmpY+JwmsZtGLNVmwtxPIoqAlRxf3VegAcJZOEPIx9jbNd+tEaqZBnwdEVzWersHzF99AONGHUIqlujYdJk6wDxKZRCz0V8OpHxr706x++J+/8kHZtzKpHpW0vEV4pcXCbwYzirT81WoJPG/o5Wsazv8YQ3bq2v0Z8i3T8hY0SnoBBBG6vyNh/xxjyza520oDYaDki4glescY36m2MFO2mJKtaRx/5mVy8uDGdQFT4qmrhgwXlmZaj8iJn3vru5lVX8GIhUCf2kF0gq498TAZix+lRiSsZhyBA7H5QR3S7iBv8nEjULW4GYk+RtUjasihG0udCYEBwSnYL6UTMwCMeGq2h9Aj0k+C9Uw9AKLSOTnzxWkZhFMCMUjJWyZ+PAoVLgaYz1coJass2RGLUH20ydO7vLYszn4M/8VTUe/LUvQMIZUrJsaJ7jQxzFu7yM3OAWOJS3KoQ4QfNBHsU60XYTG6BBLWSFpoISUxQ0gxd3jbN3zyVlFINiO+5HnJQAwiWOtfSs15L3P+0HosKnmKyugrLCzXKnvclMdduDxf9Izo+XcYC8ylXy7afD2JJqHwQEJsHOBhzkc5k1cH8Agu2n40RoRgYCJaOOx1EPR1UC7auLIimyqbu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6486002)(6506007)(38100700002)(9686003)(6512007)(86362001)(26005)(83380400001)(2906002)(66946007)(66476007)(66556008)(316002)(6916009)(41300700001)(44832011)(5660300002)(8676002)(4326008)(8936002)(478600001)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?srkyFSfTqyAV/4FsardUdmqsit+MVE97uhawW3oYGPIFFz55tSE+UiU1lggp?=
 =?us-ascii?Q?1PnfY3UL47qWbVzVd9hloi9ljYNmdiWgAuWKheC6OvYI4BJINzv3k2mSpkK9?=
 =?us-ascii?Q?N96sgbAnrsr8u98zBIz5S7ZG78/MibcWTExtZ2owkUVQMp2seBKXv9KC7FCx?=
 =?us-ascii?Q?yiyscOB8itsjmGUqJaMiBmzu8TnstfPn5nWeB2SP41WHpySi7pGEId5aALyb?=
 =?us-ascii?Q?R/9+4WnLDprlZcWq3oofbH/sR/62RJRVUKDuRNNzn/vIGzlQejHXJYhZVt80?=
 =?us-ascii?Q?VI0tRBIL/0JD1pzCRH+lAolMyxdhU1LTsc7YxZWZlXxBNw9BFREkUGt3lbAr?=
 =?us-ascii?Q?ttDjyyzqZIgjTOSqJdprJYBu1q8BWnezHuWXAg9sFsAzyh8NhZmyXWrfUPF5?=
 =?us-ascii?Q?ksmHrn8qpdtGRrW46MXGTX0SyoGfSXsW/LoxHPEcNfpDQy3bsOk69CTI6pXi?=
 =?us-ascii?Q?WEIg5+eLwSsfzQEpbKPwxXn7e1bDg4GmaeeZldgDXDRWIqKiF2RimJ8zkX9/?=
 =?us-ascii?Q?Pw3lzBvNFOujUBceVv+FUxcFUJ5t0FZEA7wvMo2McJ8cII2yPjxnBg8ZMmeZ?=
 =?us-ascii?Q?nG4SAeVGwxhNqmi+6eZnVbgrzs1hWeBa6jkWeLphrnjqpwUBQuT70jFfcCMS?=
 =?us-ascii?Q?RE1CqtNVD6ybqiffNQXmsHpv86l0VMVu2fhaAF5KaGEuft7D8goFLqY7qshG?=
 =?us-ascii?Q?LvrUKCeT37LzpUSLo9j+fSgp86+sCEah1+xsbZ6coli65GsuVgPgq2je2+gj?=
 =?us-ascii?Q?rcmnF+keSya79Z7EFcZSIKOs+EI24nhrYXdyD53C4z39WpJ5GeCQjPFiYJBi?=
 =?us-ascii?Q?3ptkYncLkDVNuGRGOdDQ0Fb8RnWynkjaTuPe5N1RlAtAnMiQoNbAL8tq8SRI?=
 =?us-ascii?Q?qkpNs2rfTr9yQrfdZX+lRtt1gS+ZSg52XmTzknV2dv1zzB55LmHxCrriMxkI?=
 =?us-ascii?Q?Tpsl/Tk/FCyFpntiE99qD1XIHBtlvrEk2R4ZEPNoybYWFanTdnjdWJ5pZeip?=
 =?us-ascii?Q?W/qNaBrUbp/jxHqdNv7rJO1zxG8WQ7ev+ccCjF97g5oirkIx/V7nRzwN5e6z?=
 =?us-ascii?Q?3AFruFv17n3YqnFqNaG28zdlWhH0UfBvYQvtnycaBZeva0SF2cUpvOtwfOnN?=
 =?us-ascii?Q?APpBS/+qBtF3KXlC42UE7O8IuK+xfX3t11QjLkqvfkrVqdgrHUk+ZyiDOVKI?=
 =?us-ascii?Q?gZq/VeRJpTiCiboBiZDk5P17mnJbRm0w9bfV37tlPpu5rX/OsLk1oeua7qJk?=
 =?us-ascii?Q?Bm5iLxN1ifWKCUT0BvJk0jHZoNMmgK86RKulSchnML4iAuvG7p74INyD4zXP?=
 =?us-ascii?Q?73eKivFFE25EpFhdytMkDlb6jAQeqoPNTHtoLbGLCmMNKy/mdiRnbqNU84/i?=
 =?us-ascii?Q?khXoDsm21W6qjuvttALZmwNFivlqETv2miME5KokN2Fu70Ah9CWdLxrdRDKc?=
 =?us-ascii?Q?beCm0F8lvMybRE20JhnSBYHgpN2U729sq/Ncl4xVuVxxrsRUqqLLtvsqQB0q?=
 =?us-ascii?Q?ISytdXkHGG8Qj9tLQ5PIm+F4rYUUwsyiXjAeK6ao6f7+dq9rz+FqFhQmFx8K?=
 =?us-ascii?Q?8y+PpQTbSMQ+/W1ftMx1oX7T1aNyMMN3GGWI3IKUqFMEn0MzaBHlplSPWyGd?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PPI+c86SL+v60tWgGtFLEB+Lrvq2mwUS5t+8vjqbLuemGvBsHF4fGL+r227gNtE1Omsjb6b+1xned4anGDbgzWD3eu+CtcHg4VmM3u4B3McR3z5tFwtDmhlhJdUpaTZI5vrUuZGJtfG42lR1RwGabdHWzd01JKTQtU/MxWnMmoXqnnc+ltYQJPOmmaZl6SCKNpclMOpretx80eYkOMTJCQNDmoFgWtMJ/LeMEA1405aLLP2LRmvbBow0M7sC7AJ0zDJmiGoFjfHbAQJ7vV/NO5XOK2NvgApdS/+iYnutgm0HLRw1sAp9xsoi/7+qP18FWtRhIk8v0+4CqHwcW5K86UqyjKxDxuOhVvMRfzHkHa51XOWl+ggTBhfKdvfjzo9kyTC6zm/zm4CEI6ptnIWKKZ3C0uFpQclJ6pQJ0Ty5E+Yie6XxJqYBzKmpGmM5V+/lWE2qxwJgPCwLAlkiK1W2xIDhRdA5zZ1w9rxBV43igYyL4f6IFdEh3YS2rf2sVxcs/bTdpXcVsDzSfqYtmYtfN5bnTz9srwboy308VEkb5mV2uvLEUgxX74e9GI7jEnq9RbLl+8NAOoNK4+x8pmTiSI2yK1tHN8hHgbf94w3Oaa3zOOZf+Nmbt6AHsLtAnAW5Hdal4a3ZDvcco0nY2ekYFYvlB55CqNdm/NqAXEtxAqTGQyw8DOtLqrbfRAo/TorE+tPVFfpfs7veIvdDIU/Ct+u3+qTJHeSkSBj3G/RGF0H8qnOWuYjxTcqBMN1GS+a6hGmCQNApGGnptS0xweo6b5Gt3ngGzgGoVnc62qId6I9+v8AaUjpfPqd9JF75sDAS
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bcaa98-029f-4ad7-4bcd-08db9ff066b3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 13:38:26.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRGTaXS/KWVxbxDTy3l0XRLBDDDBzGHbLQs2eFw8+C20VaRTsL5UQizSDZSj6xngiemp9Z+npktP4RTxKnsRMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_17,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 mlxlogscore=751 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180125
X-Proofpoint-ORIG-GUID: kZJo6Pg8rICkyi_H5LMwu8xSJ-vR5-8W
X-Proofpoint-GUID: kZJo6Pg8rICkyi_H5LMwu8xSJ-vR5-8W
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 18, 2023 at 08:06:16AM +1000, NeilBrown wrote:
> On Fri, 18 Aug 2023, Chuck Lever wrote:
> > On Tue, Aug 15, 2023 at 11:54:22AM +1000, NeilBrown wrote:
> > > lwq is a FIFO single-linked queue that only requires a spinlock
> > > for dequeueing, which happens in process context.  Enqueueing is atomic
> > > with no spinlock and can happen in any context.
> > > 
> > > Include a unit test for basic functionality - runs a boot/module-load
> > > time.  Does not use kunit framework.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  include/linux/sunrpc/svc_lwq.h |  79 +++++++++++++++++++
> > 
> > I'm wondering what your longer-term intentions are for this new
> > mechanism. If it is only useful for SunRPC, then perhaps this
> > header belongs under net/sunrpc instead.
> 
> I try to avoid long-term intentions, they rarely work out :-)
> 
> I did want to put it under net/sunrpc.  But that requires moving
> structure definitions for svc_pool, svc_serv, and svc_xprt into
> net/sunrpc - which I would like to do.
> But there are a few places where svc_xprt (at least) is accessed from
> fs/nfsd/ either directly (xpt_flags, xpt_cred, xpt_local ...) or
> through inlines. (svc_xprt_get(), svc_xpt_set_local() ...).
> 
> We we would need to create APIs to replace the direct accesses, and turn
> the inlines into EXPORT_SYMBOL function.
> 
> So I don't think it is practical.

Fair enough. It doesn't look difficult to fix those issues (which
are effectively layering violations) but perhaps that's for another
day.

Meanwhile, do these new files need names that begin with "svc_" ?
I don't see anything server-specific about them. I'd prefer just
"lwq.[ch]".


-- 
Chuck Lever
