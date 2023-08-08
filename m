Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB34774F96
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 01:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjHHXx5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 19:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHHXx4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 19:53:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D3BD
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 16:53:55 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DATGQ029222;
        Tue, 8 Aug 2023 15:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=be27OJkndEfdjQoz9XCFYhLPjVEEMLy5Jy9AGjoOgpc=;
 b=f3x3FtGYsUb+8KbC18k9HrwZlm6J5lzD2iFKaCqHCVXYdFkJlOKqydrnM36YOmQDXbRO
 2VyvJMRcQ/DvzY29ro5VtwC8a7IULXH5zx512eC5FvtMFifUlXmYBfEkwlsiG7HQLU2t
 CCZdVLxQ+WIrMQfsCeSP7b0aa/VaZtA1hzSP424tm71V5qt8H06qk6m6G8+pnDK4mqsc
 KwUjM1Efh+4torv9XmAld4TKLID4MzzO0BlaqzSjm+wUgyDYx9W5mcKGrTZNjVpIYs4T
 17FYjEsXKSRhJordbr/WvfiLgsx3llHcfMHzBCsB2sakwgAgfBVQ/s3/98pLWHwGaqg2 wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbc5fy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 15:18:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378EKDdn023045;
        Tue, 8 Aug 2023 15:18:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv66hbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 15:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ity+IieCrR4D346udzlgJvdCfFbzkIdbMyRD/Dos6M0Efl3mehmUEL2QwQFrMjh2WJSrDJzJ/Oa4L2Yx8Fg13ydf4VuJb/AQnuRitR5k+viI5R8itQo+hc3aTTzbBqChqzD724ZwuvFHxULXbR/zXm8pXMxOcO1W7lZWDUwcXGN3dnyNkhCy961pHJQRV5MXfEhcgOt6+h82CKK5bT+bq2awN7MsMNamn4EcJuBu4Ju+1qmbny7gueird2x0K/x3XapbaOqI4x9JEH0PU88JzZ81ZgFHvxuiet23yEa3GFtBC1fb9PMYdZmHOHoKMGg8A3WD5b16KERZ1w+xYZ8ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be27OJkndEfdjQoz9XCFYhLPjVEEMLy5Jy9AGjoOgpc=;
 b=jmHCTJ+MUAofMzjQVqf9hblhdyoh7jI+WmusRaSbTTKbMKvpQXXy7gQWZacYtGzAd0cBa2fyrwKQRXC5J7iaqVuCVhsdpgezyUfsRvLzWyfsRH1tFPj+MRbmbaHdrX9MkQz72eGZoYeaJshMSkrY7bW1SOdLwdEZmrlQ6XZpIKdIrake64vPqB7aEwoA8BqTZULKwlABGlW+VK4PsJu/S2NcUNNSynA3gDQ61zHY7zLLzBSgE44kMypmHe28GYNLI7ipA3hnTDKmBOWG3sYj36M7UHQRMB5uY4E+16c5F3+GEC+KElR9/DnY7cwbpoQcFxIuCFS9udooI3S3K05Ysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be27OJkndEfdjQoz9XCFYhLPjVEEMLy5Jy9AGjoOgpc=;
 b=kmxIY5eDF9CM+XZXjwZ4sjwuQglZXG8F3L1fcHAsGdVwexmDiMPNOEXiiqlU7NqwGH7FlY5MT8L46UAgIQYBB/2woECV4Rz2ofLNSJ7EnZEJ/mqFhiBw801aHc0//JJyC+Dp8uwYIXgzKONbxMq+dk7q4cboyCGFB6TInQDx7us=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB6970.namprd10.prod.outlook.com (2603:10b6:806:315::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Tue, 8 Aug
 2023 15:18:24 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:18:23 +0000
Date:   Tue, 8 Aug 2023 11:18:15 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
Message-ID: <ZNJctyaMBVuoT6yz@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>
 <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
 <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>
 <ZNJLQIxweTaEsu16@tissot.1015granger.net>
 <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>
X-ClientProxiedBy: CH2PR18CA0045.namprd18.prod.outlook.com
 (2603:10b6:610:55::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c236016-d536-453e-2e8c-08db9822b51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F2kU2/7W2+3m3vov6WR/5QYwVaxQhUOJX4rDHHmQomFtfSzB0R26ncKEWMSxdQ7boiWJ8ypULMNPQNS2iozTI47jyngljSMPXc+wgQXEAsWQjYEoL5RxYxWHX4DS404zZYlH3WATP/4raJ3o91H6Ks9B8jWlruknPlVIHcnVzKiYsrgbuMdpHNpBl+3MojYO2YkfD0ew/Ul0LfAfOhN36LWU6v7EYv64VnD5fEiWmpBBuU8BZiRYsAlwcqimTaJcxC1Xa8w4M+zZCyZiplHJaBQJ6BN1t8N5hGMnn9YrWw0+JhA6EWuFhFlqW8YqtYINqgyd/Cs/lNODDeze7GnF2+DnLymM/XUdfhJVElTMZvqQJGb28zSLW1WSmk5mOpX5LZ/0Dq1fEYhJQbjHREjlBIGoCvC2B3p3dWCuheJD8b1JvzgdKDuk+nOnF0g3yyYo8QGh6bHBpkgCvz9hYdZIuIKXm0NDeBt0PhUMEkwFcG4ZYUkmvPkbIN89A5fV26gBBgt5jrHHBYxMryZVXR97PepEPjRShutKS2+PV3iP49aCzW0SPKI/xLyjL3ZnDgnp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(376002)(366004)(1800799003)(451199021)(186006)(6486002)(6666004)(9686003)(6512007)(86362001)(26005)(38100700002)(6506007)(83380400001)(66946007)(66556008)(66476007)(6916009)(4326008)(2906002)(316002)(5660300002)(44832011)(8936002)(8676002)(478600001)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jTDZxA+JvJrK5TeJ5Ri8UvGj7Ccq0RTMvFKxnKolYk/bF5pQGrb0e8yoh4GW?=
 =?us-ascii?Q?xGDiac8TBbAMXLmXj9XeiKuupJVUL9YJP1sChshIAdgwnr8BLerJvxIPA8sd?=
 =?us-ascii?Q?Adouy0rWrcsE/GPMK9acsumn8juUarJZvTC8wXiXcVjLFm9Mdv/SaXAO+Zl8?=
 =?us-ascii?Q?MfKOhCpsjgDAt7oSnq23lDnjI2jxTEpI5+OPn43ZnEXEJv0TO9eUdcC1USXl?=
 =?us-ascii?Q?q7d662yA4jNjhBHrh3Mlwvp4xxZztBzpYVsrJN3tnePxADH7j53q0XFFjf0U?=
 =?us-ascii?Q?hYqJEn/yAkkdpduL5D/+10MBd2o3qa0suRpSr6gzjpAYCoeNXvTBLZ9MDzcx?=
 =?us-ascii?Q?2h97ys5q0662d5wpKm0Hr/oceX59zv2scheuYUgdFA0t5iWPpq02kph0uA5O?=
 =?us-ascii?Q?OzoBWHGfFiWldtk8w3pOox5/07iCigWVUdgey96m6YKUlUheI19XrZ8j0NMv?=
 =?us-ascii?Q?pwYNFesKMpbBs5ERkDc4CTB/fcqpEFU+/ki7CVn6GK6w1RkSqlsrgOGfppR9?=
 =?us-ascii?Q?P9LsyBJPm7H5fvRr81uBEVdO6lD0MqQvZahb/61oqNm4BMUhYkS+G8uZrMy2?=
 =?us-ascii?Q?zY6DsF9TAEnTagnce9kl6xF3dSS4y6s58vU8UcdZuGGp48DYeD5z8dBSZ2+v?=
 =?us-ascii?Q?EBl7zA4Ynvb0WURtBOQphdZlmQ9hgAOyU2106R7ip23gowLONGpeWD9X2ruG?=
 =?us-ascii?Q?M6eftJ5igRqSObGcoKNdh91y/atc80sYWgH7CfLuqfcrsELn+LfSjVgtQBq5?=
 =?us-ascii?Q?EqlrAAaLKTdsmsegZpAby3ah/cDT048xGjROzZLzgYuj6N6NNMM7QmFPYMJe?=
 =?us-ascii?Q?MQtU+rORoKSpObtNlA1lOAgVS8zwHkV0+UifVeLfJGrFlTeU7A71ACE2beJs?=
 =?us-ascii?Q?DPx06Jf86VLGHxzZumFIp2eLQN55TCrLDjq6pDuLGuAsVMS+6SfiZXafqPAh?=
 =?us-ascii?Q?nTosX+/Jm3Dt5vxGBGsUXhCof/VLpnNba4bJ/o+33q51c4jeR1dd4e43+anT?=
 =?us-ascii?Q?C23BZ3kbGaFLTQvWFaPYtnuZ0ILe69WcAsS4HU9Nu8o8VRCgSeDQFTE51mu0?=
 =?us-ascii?Q?3BmUpOYNKCtIe+QG3Rl05lbklJlOnhVTlN7ThDG7NqFKKDvtHBbBGFUvb52/?=
 =?us-ascii?Q?mzwfoCOtI+AlCJjKSjRaCUI04Rgk7txgYV0z8Rj1e3Uls0j/cibbjKALm+j0?=
 =?us-ascii?Q?gFCFKFKebyCag3Zf6R7yMLquN+T2S2AxdMSSJvgM+5tpLlWzmlhAc5OXZbNx?=
 =?us-ascii?Q?hS5ClT4XhQAtFsVc/E7XGArrZs1kL6oZVfcy/gXPNUlU3w/7NLG7YVx/+ce1?=
 =?us-ascii?Q?qLmMynKc8wrsennKk/nsBWcJJDepiWvXwMfq5vF5oFJFelSIzBfG3GT8dzh8?=
 =?us-ascii?Q?EZEmkKuMX7mFTYktCkz49W26SRpEKx6TN59K3/0zJZQ0jUO5wYAzSQUmptju?=
 =?us-ascii?Q?5a0RSf8qzQk1i6H7hNQCNeNWErE6uY94hMq/VD+9gahXmx6OAQdzqZlqnQmI?=
 =?us-ascii?Q?TALDc8GLqeXfCnUZU95BkhNdt0HLOFUMsnbbbtEjtEA35Y3fmWW3CKNpPTqP?=
 =?us-ascii?Q?G3FUSbLENb2rHIUNIWRubaQwVkmFMrgxY+p4DY6P59YnVMPnmj/j7urqXw0Z?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IkolZT6HvxCVwPchTWlrHzd1S1zF5f999ttpCx+Sco41hcWLETUwPKqPQMYaz2mw/VWFKFDcrqldSfay4aueyNlKXZyDjDyBYV8O+3GHHQvaKRNU1KGAnqO39qgtUKPfqu63ujpX6KBzAtwRevIYGBcC+IvPuf+kqHtpbBQDxcyOk89uE90d1fuT7ysT7ceVEJNlHgROfikyTNVzAf6r2qVE+HrwbWUNp9s0U1HRxeQr6z3AVWLQWM7TanbGc/mlmcmLO6oAmtHHO1MXLVRApYN52+Q+MxAqy+FhV989E4W8TKp2juuDhCgpR45MqPFT7qdx/tgmfR/WNP625w16s9nYkvZ42BP2+uJ97on0zBMqUqkFxW4ZfYeORfi2GhJQx0A1ao3/9EabSFtZkHopGOXzt3Z6W7MQvgAfRJnMDDK2hyFt3vh2CDqqy+UsWqUTdAbOvw16deNLLuTYgB3NgyxntwdOfUp6793EfWcJoZZqh23NLhZjoa1IyaUNP7RnkHkpgxGWaEuYbl1+/5JHKKzUzRm74e8JOaAJedwt78PBJ0Vx9gq+lJGNPrWvwhWDw36wxmE/gkd9B70wzvelluEV+2Izb/d9DrOw2ujCk5rZxFwYb24angvYs9tIQ7KQrKN+TgtLGhWtsXHB+aXImvPsK8RNSL6EYvW5GTFCJqo5iMF4nQS47EuZZcRzEzp4yC4PJDtua0VpKYt3FzYR+Jsi/p8BVuUH+qGjALP7+FmUjbquA/vY0ZOId9+cdiBlxpZnzian8bfx61TS+jC1CIGKebcjXKH0gzQnRY7P5VB7d+ynJHqp13pU/eF4fOURbGp1IoR8PO6kqApX4E4bhg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c236016-d536-453e-2e8c-08db9822b51c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:18:23.9021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5OJ5TXithEwwP750krE7QSfhEv726k9C+CiPeqUYeHXR//w68E7DhWx4WIXLEGFDECSvEiTMhrjlN/+4R6RdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6970
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_13,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=509 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080137
X-Proofpoint-ORIG-GUID: uv8rJ5Zc5OwnwiP6cPgNTrROLBf9PnLF
X-Proofpoint-GUID: uv8rJ5Zc5OwnwiP6cPgNTrROLBf9PnLF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 08, 2023 at 10:20:44AM -0400, Jeff Layton wrote:
> On Tue, 2023-08-08 at 10:03 -0400, Chuck Lever wrote:
> > On Tue, Aug 08, 2023 at 09:48:42AM -0400, Jeff Layton wrote:
> > > On Tue, 2023-08-08 at 09:24 -0400, Chuck Lever wrote:
> > > > On Tue, Aug 08, 2023 at 09:33:23PM +1000, NeilBrown wrote:
> > > > > On Tue, 08 Aug 2023, Lorenzo Bianconi wrote:
> > > > > > Introduce version field to nfsd_rpc_status handler in order to help
> > > > > > the user to maintain backward compatibility.
> > > > > 
> > > > > I wonder if this really helps.  What do I do if I see a version that I
> > > > > don't understand?  Ignore the whole file?  That doesn't make for a good
> > > > > user experience.
> > > > 
> > > > There is no UX consideration here. A user browsing the file directly
> > > > will not care about the version.
> > > > 
> > > > This file is intended to be parsable by scripts and they have to
> > > > keep up with the occasional changes in format. Scripts can handle an
> > > > unrecogized version however they like.
> > > > 
> > > > This is what we typically get with a made-up format that isn't .ini
> > > > or JSON or XML. The file format isn't self-documenting. The final
> > > > field on each row is a variable number of tokens, so it will be
> > > > nearly impossible to simply add another field without breaking
> > > > something.
> > > > 
> > > 
> > > It shouldn't be a variable number of tokens per line.
> > 
> > That's how NFSv4 COMPOUND operations are displayed. For example:
> > 
> > 0x5d58666f 0x000000d1 0x000186a3 NFSv4 COMPOUND 0000062034739371 192.168.103.67 0 192.168.103.56 20049 OP_SEQUENCE OP_PUTFH OP_READ
> > 
> > The list of operations in the displayed compound are currently
> > blank-separated tokens at the end of each row.
> > 
> 
> Oh! That's a bug in missed in my latest review then. The operations
> field was delimited by ':' chars at one point. Lorenzo, did you mean to
> change that?
> 
> IMO, the list of operations should be one field, separated by a distinct
> delimiter (like ':').
> 
> > 
> > > If there is, then that's a bug, IMO. We do want it to be simple to
> > > just add a new field, published version info notwithstanding.
> > 
> > They could be wrapped in curly braces, or separated by commas, to
> > make them all one token.
> > 
> > I haven't looked at NFSv3 output yet, but I expect those extra
> > tokens won't even be there in that case.
> > 
> 
> That's probably another bug. Anything not a v4 COMPOUND should have
> something as a placeholder. It could just be a single '-' character.
> 
> > JSON, yaml, or xml would all address the extensibility problem, just
> > as an alternative thought.
> > 
> 
> It would probably be fairly simple to output well-formed yaml instead.
> JSON and XML are a bit more of a pain.

If folks don't mind, I would like more structured output like one of
these self-documenting formats. (I know I said I didn't care before,
but I'm beginning to care now ;-)

I'm also wondering if we really ought not add another file under
/proc, which is essentially obsolete. Would /sys/fs/nfsd/yada be
better for this facility?

I hesitate to even mention network namespaces...


> For now, we can change the output. We do need to have this settled
> before this goes to Linus' tree though.

Agreed. As fair warning, I might drop this from v6.6 if we need more
time to get it right. That doesn't mean I'm not excited about having
this facility available for all our users.


-- 
Chuck Lever
