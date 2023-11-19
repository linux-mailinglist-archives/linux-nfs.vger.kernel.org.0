Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408BA7F09E3
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Nov 2023 00:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjKSXot (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Nov 2023 18:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjKSXos (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Nov 2023 18:44:48 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881F2139
        for <linux-nfs@vger.kernel.org>; Sun, 19 Nov 2023 15:44:45 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJMebjk008014;
        Sun, 19 Nov 2023 23:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=YUXwNvIA6GRsuCE8stOj7UEYLY8Qs9yEkuEa/APboGQ=;
 b=KUdtQmfeygm+p7cplShbWgiTuo8quKEKNQjKcVhNOyLk7PvEpr0VV1DZy16Y60/1bu8/
 /IB7WRcRnWw4WviSK3x7/H2ZyWJtUwEtwe0NhnBRnM1H8jMcG51SIjDj5vpz+0qU7ocb
 /cWiOYYPlAJEGkNfI4pRD2zH1goAkCANbKF7UR93wEGMOnu/0gn0P6KF5RjGWFSKvaeO
 MqxR/Sg5ihFQ/g0n8SJdHGV6MDgwBf5wP3bf8V08WHHEYoWON+4iNEHB9d1RpBCQhfWx
 vqEKRUC7nOr/2wOdvhs1yMj1JZ1drjniYUdxXapFRs6DI/toDvkmCc0WA1lj5TXpxKY/ mg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem24sm5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 23:44:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJItCll002439;
        Sun, 19 Nov 2023 23:44:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq4mxby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Nov 2023 23:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBVO/OKvyzkIZ/hxpEd69OjoFKRwKTiRkgZrnfZODmWG0HAzBQKjx4RVNyUopyS8ajJl7+wqF9CLeSL2eifZtE7Xsq9mOxpUrphV8zIMq4CyELwHdEiSESyaBCwBCYYdomvBrx4boi8VoSVncBvrqiBEaxmdht9oRLzIZVxnRlznMoAmYIyqEnywg/2KXo3n449Gjzud/3Kdb6qjkeWJrPA1BOa7qyzGsIfsdEQur9YSyY2y/rcXiPWg4nTgAbEwEMAklWAzieVzU6PrzBE4vnqf/SjlpUeNHWLKV9FGdmWwyA/BwscnmDGEOBSFhkaKmnmw/afKorOmi04WpIsW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUXwNvIA6GRsuCE8stOj7UEYLY8Qs9yEkuEa/APboGQ=;
 b=EbHZIIc9XGouk7Yt4rAEy8ulQ02UhQ+TYVN5pe64Qt80sCK3rKuxFwGQAxMpz4GPcoWSyZqtUsnuOCPjI/SfN2HVC3idFKLiFpOZYIoiA5VLiTd3OLffBOt93TH3wEHAu9KLd79OAtmxxOm4E1QDBhdKYT8YzxoBhThgNFUfdh5U9qa7x9zjemoYvnkzHiWkIEMo9Stpjbi/ZoOWjlCUFV3RDjSN9c0UcXHjyDpSySSkscgX0ciuEBiumRzNEvdvYyZgTqZWvuz9ADyVtuj8Q0MqNANqwYKx+GnUGfLNgGCsrNDDXu/zCaoICVyEZlKD5V81RfxlI5fGwzJMKBUSKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUXwNvIA6GRsuCE8stOj7UEYLY8Qs9yEkuEa/APboGQ=;
 b=qj4Hf+zvMi3/7ITCqC5WZyBvTTFdNH5q1U//lbj8/x0hYnTDhsYJdIv0lGQeemXvvJU0eJihVtPDIz+wdye2eve+QmvXBx9v0t5rvO4Q6D59gRuQqn8IGt4+4N+NQK8yzKwTugDzP0pBn/Wl1OAdQKAwycnKvQ4kst4dC4mVJUA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB4888.namprd10.prod.outlook.com (2603:10b6:408:115::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Sun, 19 Nov
 2023 23:44:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.027; Sun, 19 Nov 2023
 23:44:34 +0000
Date:   Sun, 19 Nov 2023 18:44:31 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 6/9] nfsd: allow admin-revoked NFSv4.0 state to be freed.
Message-ID: <ZVqd3wt18EXETm+i@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>
 <20231117022121.23310-7-neilb@suse.de>
 <ZVfF8R2t3WH7FqVd@tissot.1015granger.net>
 <170043402394.19300.7144468429486716541@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170043402394.19300.7144468429486716541@noble.neil.brown.name>
X-ClientProxiedBy: CH2PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:610:58::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BN0PR10MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: e220b77a-f996-442c-1703-08dbe9597be6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qL4SMDT+F0Ej4QmjKOW5FdkLVEuWhG1iilvIVuEW6gSSev1IPto/MiE0OuVdIIML9pyeDdDDN3RY5TWZqSXVMKEioL4cFj2Y0V3yEc8KYdopOfaLJUwfO5GqRz4i4xB6+ZYyBGvkBFWJ4a19b5jrtySM3nMrxh1G/BHLC14pNK832qxy6ejONwgqbRGbatGVh19ZnritYQ9uZIEBasdpTwFrc1Y+a7ztNLJKYEhgHmIFnyP4JNvqJ0PyiLpEv6aFwlqxrl4NUfU47MJpb2USZn6CrIEIIdq/hI3oBiBsETqYvkamTq9EaLIaV9OfgfWs69hv3V6i+PoBptsMcisvJf0SWkJbZCIlxsNEXmsEYY4ZsdT/q2JYvGREbnnZ7J2wDHUtTW+uld3soI8syfYSe3pZsuEfqtg0zaKMmb7g0Chdc4AXEXfiyVpMNXWYo4Pk8VpLWrgRrYTZZ/8CoO0fmiGvZfHrJglyM1alsfT7Exmqfh6fNEslPRPX+Dz3XloGRyjLOrPiN8CoXtCjYkFRx3JmpxWyPiBLPkYmKQ1Z0eKzY5CWkD5nOLZRgqwrvdOO1ik9+Mlu3jpgRPTzTEDLnmvjXdB8i0Zma5c27woikI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(44832011)(2906002)(41300700001)(8936002)(4326008)(8676002)(5660300002)(66946007)(66476007)(66556008)(54906003)(316002)(6916009)(38100700002)(6512007)(9686003)(6506007)(6666004)(86362001)(6486002)(478600001)(83380400001)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5nQO6n+YHmJ2sVXzqfy2zakEmXYc/HkzgJhKf22g5ptoy62WF33poezXnuVQ?=
 =?us-ascii?Q?RoYxi9VhLiYNFuCMCR2gWAbt2xm+gcIZR93E9PIzhPLW3whwz7qprRoaHHDf?=
 =?us-ascii?Q?CWTUJbUlSpXUvcKQrJVlLVxoy5doE2k/Sm0b8E6rMH0swcOwFptp1JLjDA3E?=
 =?us-ascii?Q?IUxVXUh+S3ET+eZUXObVVotsss9JePG8ckFRcrhjyfBk4ryVLHhNEXiRfwBa?=
 =?us-ascii?Q?BtkXPXxZiVpZlq15GuuFMWtULPu8iYV98kg6pFgGPJCoR+ieSoL3lKjXg7Ft?=
 =?us-ascii?Q?KC0TRBkSBL0jj13GwYBhEHEhsR4HzLuyaR+v/U2r/ZC5L21r1E1bjrXfV9UT?=
 =?us-ascii?Q?DUKLp6l01uoZwe8kvbURZqadqobcyuYAPTFHbEMD/2fb+V9Lhped3nVZ92HL?=
 =?us-ascii?Q?zZX2m5M0JnIddgqhhkNALa1/wpsRitxQETL6cBBZIesDlBvVqJdpoXB/X9jq?=
 =?us-ascii?Q?xVmWAFB7+npltatMiJMKUksON6bujo4+gKMZLw+gIAIQ8tB5C+y+Mo+QmhnG?=
 =?us-ascii?Q?TmQq+RmExckjdUNm4zuN9UX/CSBz4CQkAWz4KsSkbLkNFOgZ7Z3PD/0/OPHW?=
 =?us-ascii?Q?wLOTEdVMml0G+EN7OQs2Syti0zKhN7ZteQOVCCB7WkcWPhP0PNV0wEQN4xw0?=
 =?us-ascii?Q?IExTubZGidRQulCFH5uxxR4PDVFUfviY9iQoi7aG3n9u1CYMq1lmGFHZOFMr?=
 =?us-ascii?Q?vlMWOupzE5EwqQ/zs3gAtl1sz6b1oK4qdAevOllJSxl9sIn2V4MmjFIFU1Du?=
 =?us-ascii?Q?Fa83gHBt0SffEglSptA7QaVuNKc5BmKDQvv36mf0POVs6WkU3z0XEoo83M/X?=
 =?us-ascii?Q?lqi99uTJ3DAnUbAR463EfSrzUvRQTKEXk8t/pItLeqCPgjPVcxD8+8C5bgsg?=
 =?us-ascii?Q?eYoEc3doZnlVVRoXTt1DW8Oe0DERzYQ527yYa/sHZ6sapSZeAgbyfwsY53OE?=
 =?us-ascii?Q?Jg6d6ELHOSzxkiEI3wsCpV/W1YMghdjeehuc8ALP5PLPUarVJ8E9SlujNNbH?=
 =?us-ascii?Q?IfGB/bhxD3Q3t/dyFS39Q6Cyu3I3H6xwurExxFc9SWRiqvIVx5ZhGm2V2+Jl?=
 =?us-ascii?Q?EKmKF4J0mPmwqKamkuAM6/C5qHL4DQLl9mdl7c6V8CINfxcqarbdgfr47gXF?=
 =?us-ascii?Q?Hcxij+2vm6aFAZPOXHukOQfL0yJf6mt3ziUI3T6uNM08235K0/9UtYqw2gtP?=
 =?us-ascii?Q?79qxJubb9g1sAQPOWBtnBxNLy4nfA12gj9NmEU7nrQeZA1z+IG5vKYfl5iGI?=
 =?us-ascii?Q?mKAqGyWJ1gmUQwsDYsd4c4kOLc6RacZDr20OYlWDyB9Brh1xHaEyctFqhI+9?=
 =?us-ascii?Q?AlJOf9P5u/2OFI4Uj+ezAF+TVMMR6kNcfN0jBRelD4N66hPSVp/gPh3QC5i6?=
 =?us-ascii?Q?gEZxJT+BgVYFqO1YQpE0VkEcweBITWYil6ptKupKB9W77fjbVk5PSDl/Fn15?=
 =?us-ascii?Q?qxQuC93dZNBOg9x/TYnYRSyZ8e4YDxH6NRq8SxqPlzdpnSrnXI96RCSPPGdj?=
 =?us-ascii?Q?vPxxn7apdGI47kpShPEzoOL/2pIPMX90HL/1yGzyUJYgwpBrN4XkmrwPOCq1?=
 =?us-ascii?Q?lpp//3tQEgCfHXh1AIum46fm0x8MoM43WO7rwsY5D9bYyJxAJwM+VNFGaUZV?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SobYzbwrp4OHJY614EasqCrXtV6MA/DkYsQcf0GchRPENFGi7EFMQKCDTRQkr1VjNDZfMwEhVYR1SljgSb9mEuzMWL4S5eUsFiq+twV18JFiQ2aoiynl1GEOeSiEL8nwybkrLvKkJSkL4nm5Yg1LrJCOwORZvitGDf0bwQHWoXS/FJ/KK239TEmmGV7j7FqpjA+2FcBiBH24I0ElzsTHIR3NOWVFgr/qm5cTTpqeaYnw+O6taNR6zqnELFbXZnXfx726H3RNWVqvGUTzdeTByZlRy+TUOcAaFXRdUvnGcDTI8X7zzmntmsOBSjLVb4rI/6aJtLSl/Z2rztsjIuB1vBiXhCco6UuZ28ukoDC5xnyTPCSJhiBFe7s1rrZF+rOmNcmuVj8g34qIqHKq1R8ke4LV8KTxy8kTdFls+NFfq4eylUEPLpHBj5NB/zQRfcXD2/QGIVJNYSIq4hYwkrxlBI6hzXKV98ifMJsgHFbY0/YFbc3jOzjO82VD8BGGbt2gA+lf8xk1uHWJBHjci+4ujka8+oYX5l2L27yAjnz8xVM2qtt+gw8AqyDT2y/+PGDgvlV2mA2mtoKFoO5s/8SBfj/s2Dqj0zJdb2jUonAn6zhaHcqlm8X1RV/Gq3tZtWdGZ+b9Acrx0KjfzAl26F8kP80N19/QdYcYGdM9P1bA5ZsPg+eC9ZmH6n+CipIdVhUt+XvMXyxjps2X8tkSDK2UEvQt48f4E3alrQtHN0xOgGuq644wDqMnk9BxiObXlnfhWeK4PBkyB2iX4ZLZqVz9uuah7s0KBwyDDW8P7Xa+Vr62P3PQEx0qJ6xNmPl/0h6iKpeIkQ8u9Y8wgWUlh5nNysS7N3wi2flHNxveEl1UbFZKMRP3t7ey1u2ZQMwHnvyL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e220b77a-f996-442c-1703-08dbe9597be6
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 23:44:34.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewbN+1m++CaP8HQubUk3Rnv7/I9CyutnwgYEeR0Bdk3Sh5x5v1PoqiFkjSTdceYzHrKEVDbCsKSAcBPLkSr2MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_20,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311190182
X-Proofpoint-GUID: d4SL7g74lQyfRaNRRjwsSU7bZKFAVRm1
X-Proofpoint-ORIG-GUID: d4SL7g74lQyfRaNRRjwsSU7bZKFAVRm1
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 20, 2023 at 09:47:03AM +1100, NeilBrown wrote:
> On Sat, 18 Nov 2023, Chuck Lever wrote:
> > On Fri, Nov 17, 2023 at 01:18:52PM +1100, NeilBrown wrote:
> > > For NFSv4.1 and later the client easily discovers if there is any
> > > admin-revoked state and will then find and explicitly free it.
> > > 
> > > For NFSv4.0 there is no such mechanism.  The client can only find that
> > > state is admin-revoked if it tries to use that state, and there is no
> > > way for it to explicitly free the state.  So the server must hold on to
> > > the stateid (at least) for an indefinite amount of time.  A
> > > RELEASE_LOCKOWNER request might justify forgetting some of these
> > > stateids, as would the whole clients lease lapsing, but these are not
> > > reliable.
> > > 
> > > This patch takes two approaches.
> > > 
> > > Whenever a client uses an revoked stateid, that stateid is then
> > > discarded and will not be recognised again.  This might confuse a client
> > > which expect to get NFS4ERR_ADMIN_REVOKED consistently once it get it at
> > > all, but should mostly work.  Hopefully one error will lead to other
> > > resources being closed (e.g.  process exits), which will result in more
> > > stateid being freed when a CLOSE attempt gets NFS4ERR_ADMIN_REVOKED.
> > > 
> > > Also, any admin-revoked stateids that have been that way for more than
> > > one lease time are periodically revoke.
> > > 
> > > No actual freeing of state happens in this patch.  That will come in
> > > future patches which handle the different sorts of revoked state.
> > > 
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfsd/netns.h     |  4 ++
> > >  fs/nfsd/nfs4state.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 100 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > index ec49b200b797..02f8fa095b0f 100644
> > > --- a/fs/nfsd/netns.h
> > > +++ b/fs/nfsd/netns.h
> > > @@ -197,6 +197,10 @@ struct nfsd_net {
> > >  	atomic_t		nfsd_courtesy_clients;
> > >  	struct shrinker		nfsd_client_shrinker;
> > >  	struct work_struct	nfsd_shrinker_work;
> > > +
> > > +	/* last time an admin-revoke happened for NFSv4.0 */
> > > +	time64_t		nfs40_last_revoke;
> > > +
> > >  };
> > 
> > This hunk doesn't apply to nfsd-next due to v6.7-rc changes to NFSD
> > to implement a dynamic shrinker. So I stopped my review here for
> > now.
> 
> I didn't a rebase onto nfsd-next and there were no conflicts!
> 
> I guess the change from
>   	struct work_struct	nfsd_shrinker_work;
> to
>   	struct work_struct	*nfsd_shrinker_work;
> 
> was technically a conflict but I'm surprised your tool complained..

That was the change I noticed when it failed to apply. "stg import"
is pretty picky, unfortunately...


-- 
Chuck Lever
