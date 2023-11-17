Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF47EF810
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 20:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjKQTwW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Nov 2023 14:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjKQTwU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Nov 2023 14:52:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929DEAD
        for <linux-nfs@vger.kernel.org>; Fri, 17 Nov 2023 11:52:15 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHINxe9016729;
        Fri, 17 Nov 2023 19:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ILhsPGAOC1c/ZzP9u8IAZxrwKoi/pndSbidRbYGxJc0=;
 b=omOHI/neR76h5PM4aVTqPete8f1JLbUj5T/paA7ZPTsaEkgJtoF04Cd5EO7YiqOV1ATa
 Uc7MdTeAbXk8jAEPBV4ztVzS18h9GDUaugsd6iw/URFNiyr0dYxKnJKXC9WwvGyyr/gC
 opixGIUamUYRp9tIV5w82Lhrz+54xtWg5oYWoZ0rnEuCAqoPVrH23xs/ahPoFGPr4+ix
 VT5cGgaSJ3N8Mao7m6yJtCKL1iwiCY2pgrSMtjQNz5mrZ/TO0IT+hbReYA4Cs0Y23SbY
 rXXE3mnzyw42TkXdJrigF9KptcEDgJ38k8Y7WYlR/+ZXK8v4KbA53XESFCGH1DSDf/aM 7w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qde0rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 19:52:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHIh1Mv012363;
        Fri, 17 Nov 2023 19:52:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqxa9qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 19:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuXjlN1cOiUWoREHnsCTFl5l/R9dHQdr+G8YxdtfzRupCk+VvjLwKZ55xBe/6oAWW9YsX6jmUWajUaQRLlilrIcJE8k3obXBxhB9cplTKVqg0leaNztUoSYkD9l32Ynjjlmt97PbgGp6RyN4UsE//8GqvHPB3u75+lRtQ4+mLTXtbMv11dzP9OknBr6pqv45vtT+wfa4kEzxhu6fbGy03o41ERMisyA6Kd9Y4hBJZctSiiaJCuq9c9Xgsv7onO/gaeXZS+GPnx/KGcgLX0MQj9YcyWVAjnBepwbo8tLhnhWbpXbAgRuEvQsJ4Kj/wwhkDdPKTAR14Y++lcWbsxpnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILhsPGAOC1c/ZzP9u8IAZxrwKoi/pndSbidRbYGxJc0=;
 b=nEkuz4UIADiHU2+bl3k0/cBJ/HkwUATMFGXdZjmFZwRDxw3TEqv4i8jpGw/hEManntYuB1d8ms+PvCEj+AdjAtCz8WqcWsFgFBhDbU6eGuNYjQCwHYrj3IJUtzphwi9/3bgw2mRK9ynveSOnalnUqnFVQGq4tZdOs0qcuj5LrYfqTN7zJrY4DSbqOckpO1Gt/5HS9Dt9/S0r+lR2YYmlr+oEraCADBR0K+PXwrZDoGBEjhbeUsfSl3FgJO5YWzgd2GGDOJk2BZzahPADOYP/NklyausZciW/Ja4OfAShxApdkK3M/AjQ0+JKDa20Fn1spKh4KQVROWygwBg4YZnOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILhsPGAOC1c/ZzP9u8IAZxrwKoi/pndSbidRbYGxJc0=;
 b=mc2GMcoeod+a7PHCiDFJ/E6dWka2hT0MDGQKcAEn5RxFZQIfz/GK1KX3DXiRzWBkwc/QDKzG7pQ/WSh54I981W4q/8mtXVdWo9uLMWZN7fEiWSIqRvIMAElG/YjGBoNI6geC3K8B9L/4ibzhWgX5gwc3l3yMJ0fapm/6q08Ikw8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 19:52:03 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 19:52:03 +0000
Date:   Fri, 17 Nov 2023 14:52:01 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH 3/9] nfsd: split sc_status out of sc_type
Message-ID: <ZVfEYfslqZDvwW/X@tissot.1015granger.net>
References: <20231117022121.23310-1-neilb@suse.de>
 <20231117022121.23310-4-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117022121.23310-4-neilb@suse.de>
X-ClientProxiedBy: CH0PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:610:76::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH2PR10MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bed0d57-9f83-4946-e621-08dbe7a6abcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQVkxHDjwz5xufTNl5WsFMvUIJgQ1Sm8OEZ9T3iGer9YiOIkDzWICNjvInzj5bMaex/sqlWmnAjIdEoTovuVdGx66ITd4mqozh4XXHmwHbcm+W9kJ7EnuhTEbPsZ+UrpSFN0128hghWH9dEZ7iVTsmCULweGLDRc6zGWXr7EI/dW8+GrwmFTqyGVUkn3zaRcQ/IRN1ntxWorTPJfXwYET4BbIY/qiiLPQGktZpDzGvQ6KQ+wbqARGw4EzA4rGc7UDEwMO8VEK/xZBzFLMy+xB2qP/VNqX91atWMYOc7s6P6b30uIXpgqV1fnlDtCzl/RMtF5HgCPK5NI5Jh9s+w5JDtsKyOCJ9htV/93BpVYJ1WiOhyWrdTAXIR/x2pZygqC6cPt7240ouNe/7WO78h+MVqnYH6l3Q0nsXUYZTukFGtXeoNNXmMakT0cxVqaFhX/nB2cTLvqJojCO+bTAktj40EmneBZOmd9Egh1LusyMZzKquiwS4bGuHMqseukJp1IHS5prCLbUxVSm5xgQb9pcgF5VirPl9nm8rJCZW0U0QPGaKY/+zM/B045JVoeyIJk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(30864003)(6486002)(83380400001)(6506007)(9686003)(6512007)(26005)(478600001)(41300700001)(2906002)(86362001)(6916009)(66946007)(66556008)(66476007)(44832011)(54906003)(316002)(8936002)(4326008)(8676002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MFzaihc+gM6g4iiNFwzQhJKcXAZWQw1m2+GVT0Gea0Cg+3oOxipy+sstopkM?=
 =?us-ascii?Q?iLCn2r9uWzu/6Rfw8s4a2oP1Sc3PV+uiSFJJ+JRyRpBK21m6SGcjAU/CRpBS?=
 =?us-ascii?Q?q7Yh1+N61An2r+LfE2Tm6ZclZJLQcJuGJqlrK37l+6bNw6fIJgSGV6TZ9HS1?=
 =?us-ascii?Q?zkyoX5N33C00CrvrbyHldYQVPxJGImFO54dvGLz315zKjU+7J6o8ewm7k6nx?=
 =?us-ascii?Q?MAJDajrV6UN54WOzbo/8vVX/YMIA8yIzP/0nVxqbKGfJDDm/JqbK1Yxm9Jji?=
 =?us-ascii?Q?+FLv9Fp7LNkINgI2qzjhfsypswHZik3KQ2X9aBrisKAZg245BrIETcyRG+8U?=
 =?us-ascii?Q?9jkJSmwoYS+WVeaKXLzumlhfQT49wB7d15U5qp2novYmJuR+BuqI2taP8D0x?=
 =?us-ascii?Q?TKSbPRPwgf7qHv62sk6l3fnYFgYOR4sFyvJ8jOFPiPKYpLfIAGMWz2W4Aqdu?=
 =?us-ascii?Q?Z1aTY/rANRw2sVon1/n+7ecPtnwh3JdhVq+VZsOrZZ5p98PIuq+UmPtzgq6U?=
 =?us-ascii?Q?ufVw6U90OoLB47q1AAptlhlMiORi9yazk5YhqSNYGbhp7Na7Bddg/AAFdIYE?=
 =?us-ascii?Q?C9QFdQpKc1CyeQw0vgFMQ4UFolvu/J0Pi3M3d3ifsL3QygM7AbCQr8Z1Zktw?=
 =?us-ascii?Q?WXrD8M4wkKF8pU3Iw0nZ6PSg/CvLgA8H1lrfBvhM5tKAETbMjOTThZj1c6iJ?=
 =?us-ascii?Q?IttKrDSfFDm8LZMd0WBPstkfA+VrR7z9MuhBeb0UAg9UQObMGIGyOSc+Kaxm?=
 =?us-ascii?Q?BBYwIqXBCe7jr//3oYLAYL8z8mCiFerJuE8RmfBXTQhnS1YnMrF1CDpD7vvD?=
 =?us-ascii?Q?IRfaO5RTGVx0CnCYClpciYVZSnfakVUQULrGqCJdw6CO/hLtdBK173Skx84D?=
 =?us-ascii?Q?SgCpgA06aKa1iU+mik5tRXP9+wFyYMzd96s0lo4fJJ2vrCe7akjNKFS4INt8?=
 =?us-ascii?Q?1hSBpTFPMXNwEx6aiJi7TskHjo8IXzzhzGKu1lJSjz547WHQ+8VNMMDc1GLs?=
 =?us-ascii?Q?t07recrCWJwAQl3KHr4dHYlB8/7SJH1u/02oTQYuC5Tznj4asCJ/mJuIwfgm?=
 =?us-ascii?Q?0J1MTMu2Lt+uvtgaJJhnFXVPvZ1P9NArIzTDnQfzfyP9z1w7QVZXp0qMV3Gc?=
 =?us-ascii?Q?L2vW+9Z6VGfSSpT0z0QIuqpIoR1y+Gp2Y2Y0H8/Hwv3ySVr0141ZAz42RlMn?=
 =?us-ascii?Q?ppWvr9sLlYE3WzdhYjss1mFifuYZhWWmjhHM2vhRAlMbtnBPSi7e1Jxb3LR0?=
 =?us-ascii?Q?qwptFinvYnNo5ZmqfWI/NqJmvP9nDsDmpzIv4miyLSPXGBz40PbjzYZSWO5C?=
 =?us-ascii?Q?VY3eB/MM627lOBNWFQ+LQIMh/Ogn6Mr8Yyf2eeha1hZiJV0FDdxd7Dmie2mY?=
 =?us-ascii?Q?dt+2ulWb+Xw8QJq8ZD6NDy3sRH8nfSwyjvhAX3SRw3hckl5/lP1eYsVUFlUn?=
 =?us-ascii?Q?4ui6cVrNxctCUc8kwxzJsvynHcZfjakkPsNAxtYWAoKIXmSCpLUmVKGG0EOr?=
 =?us-ascii?Q?FoUKRZAMRa+vYe6RHhp03FOCSrvF3wbMWKlg3UtUrSzdrx1QulooRjOFIOpK?=
 =?us-ascii?Q?cvGHq75eVN8XlnnCYNGX9L+XrNa8i8f0yx3zrVX2m3diYUUsuiBt/pOVnPDh?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rzTrwjJZYEou90qgShBnvX77BkSa7Ca5dt70tRhTkwUAlqMBPMbPuzsiFr7O9iSUvR7nORbExVqlPqpPrpITfNc/8A1auFLx3S8E2EBk7ha0yElXOkA2FomEpk31cXxXYL5BYrDvlGi5iewx64ElLe7+L9SC2d8svhTF2fBJG6b6jkIgXh5Wg7z+H55+bgHTnRAmKj5F85eLT863HnHeL3VotloYXsz2bWQogEp5dKMNDrVvZpvPQ9w9fDRWcYxpGx0JGgBpjNOwTAjs/Fjk5uYGGrh7yZ9hk/L7RF614le3jTaqAp2GYYaZWl2zTRmowEjmsX4nPi2IGJqbaNITKyo2SvgNSyT5rH9xyqPfyxGbAi7KwZvRO8EeYIXpA2Ig4+n2SMsXadYhsWQiL1VGsptRSlY8aaPVVfAdYQeWvQuXBrlbQpafh8AO+9qYFRpcsowJiu45F2eans5UJcQKMCalGfLCsdWe/LRYjOODOV40ssFFK08tWkCtJlQU32fY3D97i/xD0CXFyKN+84/Tlc4fYUsUDfTeX6TR0JFgDcpUSk71U16jLEEnxeoSegoMn7sKN47KFKpCUTiZniaPWkV6GAi84OvffRYNGzPyAJGxhzCBSiPlRcY3NlNFb9mEYeWdg8AMMl3kCzE0R2TCLedP/7uwFNktPprsyWOZtDWKrvZsjLMgZ1R7u3yREv2mHhSqqvpoztS37JFODoc8oU3VW6/tiNPRv1DZq6crAYW/LUtkDuVuDzjhKGjtjw+g+SiOvQeQFJG3UEWSzSTF6MQ/Lmd6qZVQdONSQwpBoXJfQ8yEy5lJAdm9HAIasq6DAzcvVRWpDCkNpMPUYbYRGTb+r9uHIhHCu8JIbKRDbPZ4yTgQtNuFl1gE2a6QV2Wz
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bed0d57-9f83-4946-e621-08dbe7a6abcc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 19:52:03.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUJUCC3t5aJe+4mpm1IDpnW0KqKDW/YVkFBjPHHBPwWPtJEtnXM2Ynvs4m/OeehTYkUSUraBsrNpyBPZZare8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_19,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311170151
X-Proofpoint-ORIG-GUID: 2_T0sBTHXHJponD_YFJ3iDDx0feUAExV
X-Proofpoint-GUID: 2_T0sBTHXHJponD_YFJ3iDDx0feUAExV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 17, 2023 at 01:18:49PM +1100, NeilBrown wrote:
> sc_type identifies the type of a state - open, lock, deleg, layout - and
> also the status of a state - closed or revoked.
> 
> This is a bit untidy and could get worse when "admin-revoked" states are
> added.  So clean it up.
> 
> With this patch, the type is now all that is stored in sc_type.  This is
> zero when the state is first added to ->cl_stateids (causing it to be
> ignored), and is then set appropriately once it is fully initialised.
> It is set under ->cl_lock to ensure atomicity w.r.t lookup.  It is now
> never cleared.
> 
> sc_type is still a bit-set even though at most one bit is set.  This allows
> lookup functions to be given a bitmap of acceptable types.
> 
> cl_type is now an unsigned short rather than char.  There is no value in

s/cl_type/sc_type


> restricting to just 8 bits.  When passed to a function or stored in local
> variable, "unsigned int" is used.

This seems confusing, and I'd prefer not to introduce implicit type
conversions where they aren't truly necessary. Why not use "unsigned
short" or even "unsigned int" everywhere?


> The status is stored in a separate short named "cl_status".  It has two
> flags: NFS4_STID_CLOSED and NFS4_STID_REVOKED.

s/cl_status/sc_status


> CLOSED combines NFS4_CLOSED_STID, NFS4_CLOSED_DELEG_STID, and is used
> for LOCK_STID and LAYOUT_STID instead of setting the sc_type to zero.
> These flags are only ever set, never cleared.
> For deleg stateids they are set under the global state_lock.
> For open and lock stateids they are set under ->cl_lock.
> For layout stateids they are set under ->ls_lock
> 
> nfs4_unhash_stid() has been removed, and we never set sc_type = 0.  This
> was only used for LOCK and LAYOUT stids and they now use
> NFS4_STID_CLOSED.
> 
> Also TRACE_DEFINE_NUM() calls for the various STD #define have been
> removed because these things are not enums, and so that call is
> incorrect.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4layouts.c |   6 +-
>  fs/nfsd/nfs4state.c   | 165 +++++++++++++++++++++---------------------
>  fs/nfsd/state.h       |  40 +++++++---
>  fs/nfsd/trace.h       |  23 +++---
>  4 files changed, 122 insertions(+), 112 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 5e8096bc5eaa..eb8bb05a8df5 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -269,13 +269,13 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
>  {
>  	struct nfs4_layout_stateid *ls;
>  	struct nfs4_stid *stid;
> -	unsigned char typemask = NFS4_LAYOUT_STID;
> +	unsigned int typemask = NFS4_LAYOUT_STID;
>  	__be32 status;
>  
>  	if (create)
>  		typemask |= (NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID);
>  
> -	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &stid,
> +	status = nfsd4_lookup_stateid(cstate, stateid, typemask, 0, &stid,
>  			net_generic(SVC_NET(rqstp), nfsd_net_id));
>  	if (status)
>  		goto out;
> @@ -518,7 +518,7 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
>  		lrp->lrs_present = true;
>  	} else {
>  		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
> -		nfs4_unhash_stid(&ls->ls_stid);
> +		ls->ls_stid.sc_status |= NFS4_STID_CLOSED;
>  		lrp->lrs_present = false;
>  	}
>  	spin_unlock(&ls->ls_lock);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7469583382fb..b1fdd0ee0f5c 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1265,11 +1265,6 @@ static void destroy_unhashed_deleg(struct nfs4_delegation *dp)
>  	nfs4_put_stid(&dp->dl_stid);
>  }
>  
> -void nfs4_unhash_stid(struct nfs4_stid *s)
> -{
> -	s->sc_type = 0;
> -}
> -
>  /**
>   * nfs4_delegation_exists - Discover if this delegation already exists
>   * @clp:     a pointer to the nfs4_client we're granting a delegation to
> @@ -1334,7 +1329,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
>  }
>  
>  static bool
> -unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
> +unhash_delegation_locked(struct nfs4_delegation *dp, unsigned int statusmask)
>  {
>  	struct nfs4_file *fp = dp->dl_stid.sc_file;
>  
> @@ -1344,8 +1339,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
>  		return false;
>  
>  	if (dp->dl_stid.sc_client->cl_minorversion == 0)
> -		type = NFS4_CLOSED_DELEG_STID;
> -	dp->dl_stid.sc_type = type;
> +		statusmask = NFS4_STID_CLOSED;
> +	dp->dl_stid.sc_status |= statusmask;
> +
>  	/* Ensure that deleg break won't try to requeue it */
>  	++dp->dl_time;
>  	spin_lock(&fp->fi_lock);
> @@ -1361,7 +1357,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
>  	bool unhashed;
>  
>  	spin_lock(&state_lock);
> -	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
> +	unhashed = unhash_delegation_locked(dp, NFS4_STID_CLOSED);
>  	spin_unlock(&state_lock);
>  	if (unhashed)
>  		destroy_unhashed_deleg(dp);
> @@ -1375,7 +1371,7 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>  
>  	trace_nfsd_stid_revoke(&dp->dl_stid);
>  
> -	if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
> +	if (dp->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		spin_lock(&clp->cl_lock);
>  		refcount_inc(&dp->dl_stid.sc_count);
>  		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
> @@ -1384,8 +1380,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
>  	destroy_unhashed_deleg(dp);
>  }
>  
> -/* 
> - * SETCLIENTID state 
> +/*
> + * SETCLIENTID state
>   */
>  
>  static unsigned int clientid_hashval(u32 id)
> @@ -1548,7 +1544,7 @@ static bool unhash_lock_stateid(struct nfs4_ol_stateid *stp)
>  	if (!unhash_ol_stateid(stp))
>  		return false;
>  	list_del_init(&stp->st_locks);
> -	nfs4_unhash_stid(&stp->st_stid);
> +	stp->st_stid.sc_status |= NFS4_STID_CLOSED;
>  	return true;
>  }
>  
> @@ -1627,6 +1623,7 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
>  	LIST_HEAD(reaplist);
>  
>  	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |= NFS4_STID_CLOSED;
>  	if (unhash_open_stateid(stp, &reaplist))
>  		put_ol_stateid_locked(stp, &reaplist);
>  	spin_unlock(&stp->st_stid.sc_client->cl_lock);
> @@ -2235,7 +2232,7 @@ __destroy_client(struct nfs4_client *clp)
>  	spin_lock(&state_lock);
>  	while (!list_empty(&clp->cl_delegations)) {
>  		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
> -		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));
> +		WARN_ON(!unhash_delegation_locked(dp, NFS4_STID_CLOSED));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -2467,14 +2464,16 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
>  }
>  
>  static struct nfs4_stid *
> -find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
> +find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
> +		     unsigned int typemask, unsigned int ok_states)
>  {
>  	struct nfs4_stid *s;
>  
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, t);
>  	if (s != NULL) {
> -		if (typemask & s->sc_type)
> +		if ((s->sc_status & ~ok_states) == 0 &&
> +		    (typemask & s->sc_type))
>  			refcount_inc(&s->sc_count);
>  		else
>  			s = NULL;
> @@ -4584,7 +4583,8 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
>  			continue;
>  		if (local->st_stateowner != &oo->oo_owner)
>  			continue;
> -		if (local->st_stid.sc_type == NFS4_OPEN_STID) {
> +		if (local->st_stid.sc_type == NFS4_OPEN_STID &&
> +		    !local->st_stid.sc_status) {
>  			ret = local;
>  			refcount_inc(&ret->st_stid.sc_count);
>  			break;
> @@ -4598,17 +4598,10 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
>  {
>  	__be32 ret = nfs_ok;
>  
> -	switch (s->sc_type) {
> -	default:
> -		break;
> -	case 0:
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
> -		ret = nfserr_bad_stateid;
> -		break;
> -	case NFS4_REVOKED_DELEG_STID:
> +	if (s->sc_status & NFS4_STID_REVOKED)
>  		ret = nfserr_deleg_revoked;
> -	}
> +	else if (s->sc_status & NFS4_STID_CLOSED)
> +		ret = nfserr_bad_stateid;
>  	return ret;
>  }
>  
> @@ -4921,9 +4914,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
>  
>  	trace_nfsd_cb_recall_done(&dp->dl_stid.sc_stateid, task);
>  
> -	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID ||
> -	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID)
> -	        return 1;
> +	if (dp->dl_stid.sc_status)
> +		/* CLOSED or REVOKED */
> +		return 1;
>  
>  	switch (task->tk_status) {
>  	case 0:
> @@ -5168,12 +5161,12 @@ static int share_access_to_flags(u32 share_access)
>  	return share_access == NFS4_SHARE_ACCESS_READ ? RD_STATE : WR_STATE;
>  }
>  
> -static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl, stateid_t *s)
> +static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl,
> +						  stateid_t *s)
>  {
>  	struct nfs4_stid *ret;
>  
> -	ret = find_stateid_by_type(cl, s,
> -				NFS4_DELEG_STID|NFS4_REVOKED_DELEG_STID);
> +	ret = find_stateid_by_type(cl, s, NFS4_DELEG_STID, NFS4_STID_REVOKED);
>  	if (!ret)
>  		return NULL;
>  	return delegstateid(ret);
> @@ -5196,7 +5189,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
>  	deleg = find_deleg_stateid(cl, &open->op_delegate_stateid);
>  	if (deleg == NULL)
>  		goto out;
> -	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
> +	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
>  		nfs4_put_stid(&deleg->dl_stid);
>  		status = nfserr_deleg_revoked;
>  		goto out;
> @@ -5843,7 +5836,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>  	} else {
>  		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
>  		if (status) {
> -			stp->st_stid.sc_type = NFS4_CLOSED_STID;
>  			release_open_stateid(stp);
>  			mutex_unlock(&stp->st_mutex);
>  			goto out;
> @@ -6235,7 +6227,7 @@ nfs4_laundromat(struct nfsd_net *nn)
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
>  		if (!state_expired(&lt, dp->dl_time))
>  			break;
> -		WARN_ON(!unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID));
> +		WARN_ON(!unhash_delegation_locked(dp, NFS4_STID_REVOKED));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> @@ -6474,22 +6466,20 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  	status = nfsd4_stid_check_stateid_generation(stateid, s, 1);
>  	if (status)
>  		goto out_unlock;
> +	status = nfsd4_verify_open_stid(s);
> +	if (status)
> +		goto out_unlock;
> +
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
>  		status = nfs_ok;
>  		break;
> -	case NFS4_REVOKED_DELEG_STID:
> -		status = nfserr_deleg_revoked;
> -		break;
>  	case NFS4_OPEN_STID:
>  	case NFS4_LOCK_STID:
>  		status = nfsd4_check_openowner_confirmed(openlockstateid(s));
>  		break;
>  	default:
>  		printk("unknown stateid type %x\n", s->sc_type);
> -		fallthrough;
> -	case NFS4_CLOSED_STID:
> -	case NFS4_CLOSED_DELEG_STID:
>  		status = nfserr_bad_stateid;
>  	}
>  out_unlock:
> @@ -6499,7 +6489,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
>  
>  __be32
>  nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> +		     stateid_t *stateid,
> +		     unsigned int typemask, unsigned int statusmask,
>  		     struct nfs4_stid **s, struct nfsd_net *nn)
>  {
>  	__be32 status;
> @@ -6510,10 +6501,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  	 *  only return revoked delegations if explicitly asked.
>  	 *  otherwise we report revoked or bad_stateid status.
>  	 */
> -	if (typemask & NFS4_REVOKED_DELEG_STID)
> +	if (statusmask & NFS4_STID_REVOKED)
>  		return_revoked = true;
> -	else if (typemask & NFS4_DELEG_STID)
> -		typemask |= NFS4_REVOKED_DELEG_STID;
> +	if (typemask & NFS4_DELEG_STID)
> +		/* Always allow REVOKED for DELEG so we can
> +		 * retturn the appropriate error.
> +		 */
> +		statusmask |= NFS4_STID_REVOKED;
>  
>  	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>  		CLOSE_STATEID(stateid))
> @@ -6526,14 +6520,12 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>  	}
>  	if (status)
>  		return status;
> -	stid = find_stateid_by_type(cstate->clp, stateid, typemask);
> +	stid = find_stateid_by_type(cstate->clp, stateid, typemask, statusmask);
>  	if (!stid)
>  		return nfserr_bad_stateid;
> -	if ((stid->sc_type == NFS4_REVOKED_DELEG_STID) && !return_revoked) {
> +	if ((stid->sc_status & NFS4_STID_REVOKED) && !return_revoked) {
>  		nfs4_put_stid(stid);
> -		if (cstate->minorversion)
> -			return nfserr_deleg_revoked;
> -		return nfserr_bad_stateid;
> +		return nfserr_deleg_revoked;
>  	}
>  	*s = stid;
>  	return nfs_ok;
> @@ -6544,7 +6536,7 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>  {
>  	struct nfsd_file *ret = NULL;
>  
> -	if (!s)
> +	if (!s || s->sc_status)
>  		return NULL;
>  
>  	switch (s->sc_type) {
> @@ -6667,7 +6659,8 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
>  		goto out;
>  
>  	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
> -			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
> +				     NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> +				     0);
>  	if (*stid)
>  		status = nfs_ok;
>  	else
> @@ -6725,7 +6718,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  
>  	status = nfsd4_lookup_stateid(cstate, stateid,
>  				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
> -				&s, nn);
> +				0, &s, nn);
>  	if (status == nfserr_bad_stateid)
>  		status = find_cpntf_state(nn, stateid, &s);
>  	if (status)
> @@ -6743,9 +6736,6 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  	case NFS4_LOCK_STID:
>  		status = nfs4_check_olstateid(openlockstateid(s), flags);
>  		break;
> -	default:
> -		status = nfserr_bad_stateid;
> -		break;
>  	}
>  	if (status)
>  		goto out;
> @@ -6824,11 +6814,20 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	spin_lock(&cl->cl_lock);
>  	s = find_stateid_locked(cl, stateid);
> -	if (!s)
> +	if (!s || s->sc_status & NFS4_STID_CLOSED)
>  		goto out_unlock;
>  	spin_lock(&s->sc_lock);
>  	switch (s->sc_type) {
>  	case NFS4_DELEG_STID:
> +		if (s->sc_status & NFS4_STID_REVOKED) {
> +			spin_unlock(&s->sc_lock);
> +			dp = delegstateid(s);
> +			list_del_init(&dp->dl_recall_lru);
> +			spin_unlock(&cl->cl_lock);
> +			nfs4_put_stid(s);
> +			ret = nfs_ok;
> +			goto out;
> +		}
>  		ret = nfserr_locks_held;
>  		break;
>  	case NFS4_OPEN_STID:
> @@ -6843,14 +6842,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		spin_unlock(&cl->cl_lock);
>  		ret = nfsd4_free_lock_stateid(stateid, s);
>  		goto out;
> -	case NFS4_REVOKED_DELEG_STID:
> -		spin_unlock(&s->sc_lock);
> -		dp = delegstateid(s);
> -		list_del_init(&dp->dl_recall_lru);
> -		spin_unlock(&cl->cl_lock);
> -		nfs4_put_stid(s);
> -		ret = nfs_ok;
> -		goto out;
>  	/* Default falls through and returns nfserr_bad_stateid */
>  	}
>  	spin_unlock(&s->sc_lock);
> @@ -6893,6 +6884,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
>   * @seqid: seqid (provided by client)
>   * @stateid: stateid (provided by client)
>   * @typemask: mask of allowable types for this operation
> + * @statusmask: mask of allowed states: 0 or STID_CLOSED
>   * @stpp: return pointer for the stateid found
>   * @nn: net namespace for request
>   *
> @@ -6902,7 +6894,8 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
>   */
>  static __be32
>  nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
> -			 stateid_t *stateid, char typemask,
> +			 stateid_t *stateid,
> +			 unsigned int typemask, unsigned int statusmask,
>  			 struct nfs4_ol_stateid **stpp,
>  			 struct nfsd_net *nn)
>  {
> @@ -6913,7 +6906,8 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
>  	trace_nfsd_preprocess(seqid, stateid);
>  
>  	*stpp = NULL;
> -	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
> +	status = nfsd4_lookup_stateid(cstate, stateid,
> +				      typemask, statusmask, &s, nn);
>  	if (status)
>  		return status;
>  	stp = openlockstateid(s);
> @@ -6935,7 +6929,7 @@ static __be32 nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cs
>  	struct nfs4_ol_stateid *stp;
>  
>  	status = nfs4_preprocess_seqid_op(cstate, seqid, stateid,
> -						NFS4_OPEN_STID, &stp, nn);
> +					  NFS4_OPEN_STID, 0, &stp, nn);
>  	if (status)
>  		return status;
>  	oo = openowner(stp->st_stateowner);
> @@ -6966,8 +6960,8 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		return status;
>  
>  	status = nfs4_preprocess_seqid_op(cstate,
> -					oc->oc_seqid, &oc->oc_req_stateid,
> -					NFS4_OPEN_STID, &stp, nn);
> +					  oc->oc_seqid, &oc->oc_req_stateid,
> +					  NFS4_OPEN_STID, 0, &stp, nn);
>  	if (status)
>  		goto out;
>  	oo = openowner(stp->st_stateowner);
> @@ -7097,18 +7091,20 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct net *net = SVC_NET(rqstp);
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
> -	dprintk("NFSD: nfsd4_close on file %pd\n", 
> +	dprintk("NFSD: nfsd4_close on file %pd\n",
>  			cstate->current_fh.fh_dentry);
>  
>  	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
> -					&close->cl_stateid,
> -					NFS4_OPEN_STID|NFS4_CLOSED_STID,
> -					&stp, nn);
> +					  &close->cl_stateid,
> +					  NFS4_OPEN_STID, NFS4_STID_CLOSED,
> +					  &stp, nn);
>  	nfsd4_bump_seqid(cstate, status);
>  	if (status)
> -		goto out; 
> +		goto out;
>  
> -	stp->st_stid.sc_type = NFS4_CLOSED_STID;
> +	spin_lock(&stp->st_stid.sc_client->cl_lock);
> +	stp->st_stid.sc_status |= NFS4_STID_CLOSED;
> +	spin_unlock(&stp->st_stid.sc_client->cl_lock);
>  
>  	/*
>  	 * Technically we don't _really_ have to increment or copy it, since
> @@ -7150,7 +7146,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
>  		return status;
>  
> -	status = nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, &s, nn);
> +	status = nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, 0, &s, nn);
>  	if (status)
>  		goto out;
>  	dp = delegstateid(s);
> @@ -7604,9 +7600,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  							&lock_stp, &new);
>  	} else {
>  		status = nfs4_preprocess_seqid_op(cstate,
> -				       lock->lk_old_lock_seqid,
> -				       &lock->lk_old_lock_stateid,
> -				       NFS4_LOCK_STID, &lock_stp, nn);
> +						  lock->lk_old_lock_seqid,
> +						  &lock->lk_old_lock_stateid,
> +						  NFS4_LOCK_STID, 0, &lock_stp,
> +						  nn);
>  	}
>  	if (status)
>  		goto out;
> @@ -7919,8 +7916,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		 return nfserr_inval;
>  
>  	status = nfs4_preprocess_seqid_op(cstate, locku->lu_seqid,
> -					&locku->lu_stateid, NFS4_LOCK_STID,
> -					&stp, nn);
> +					  &locku->lu_stateid, NFS4_LOCK_STID, 0,
> +					  &stp, nn);
>  	if (status)
>  		goto out;
>  	nf = find_any_file(stp->st_stid.sc_file);
> @@ -8350,7 +8347,7 @@ nfs4_state_shutdown_net(struct net *net)
>  	spin_lock(&state_lock);
>  	list_for_each_safe(pos, next, &nn->del_recall_lru) {
>  		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> -		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));
> +		WARN_ON(!unhash_delegation_locked(dp, NFS4_STID_CLOSED));
>  		list_add(&dp->dl_recall_lru, &reaplist);
>  	}
>  	spin_unlock(&state_lock);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index f96eaa8e9413..22f9eb3986d2 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -88,17 +88,33 @@ struct nfsd4_callback_ops {
>   */
>  struct nfs4_stid {
>  	refcount_t		sc_count;
> -#define NFS4_OPEN_STID 1
> -#define NFS4_LOCK_STID 2
> -#define NFS4_DELEG_STID 4
> -/* For an open stateid kept around *only* to process close replays: */
> -#define NFS4_CLOSED_STID 8
> +
> +	/* A new stateid is added to the cl_stateids idr early before it
> +	 * is fully initialised.  Its sc_type is then zero.  After
> +	 * initialisation the sc_type it set under cl_lock, and then
> +	 * never changes.
> +	 */
> +#define NFS4_OPEN_STID		BIT(0)
> +#define NFS4_LOCK_STID		BIT(1)
> +#define NFS4_DELEG_STID		BIT(2)
> +#define NFS4_LAYOUT_STID	BIT(3)
> +	unsigned short		sc_type;
> +
> +/* state_lock protects sc_status for delegation stateids.
> + * ->cl_lock protects sc_status for open and lock stateids.
> + * ->st_mutex also protect sc_status for open stateids.
> + * ->ls_lock protects sc_status for layout stateids.
> + */
> +/*
> + * For an open stateid kept around *only* to process close replays.
> + * For deleg stateid, kept in idr until last reference is dropped.
> + */
> +#define NFS4_STID_CLOSED	BIT(0)
>  /* For a deleg stateid kept around only to process free_stateid's: */
> -#define NFS4_REVOKED_DELEG_STID 16
> -#define NFS4_CLOSED_DELEG_STID 32
> -#define NFS4_LAYOUT_STID 64
> +#define NFS4_STID_REVOKED	BIT(1)
> +	unsigned short		sc_status;
> +
>  	struct list_head	sc_cp_list;
> -	unsigned char		sc_type;
>  	stateid_t		sc_stateid;
>  	spinlock_t		sc_lock;
>  	struct nfs4_client	*sc_client;
> @@ -694,15 +710,15 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
>  		stateid_t *stateid, int flags, struct nfsd_file **filp,
>  		struct nfs4_stid **cstid);
>  __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
> -		     stateid_t *stateid, unsigned char typemask,
> -		     struct nfs4_stid **s, struct nfsd_net *nn);
> +			    stateid_t *stateid, unsigned int typemask,
> +			    unsigned int statusmask,
> +			    struct nfs4_stid **s, struct nfsd_net *nn);
>  struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
>  				  void (*sc_free)(struct nfs4_stid *));
>  int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
>  void nfs4_free_copy_state(struct nfsd4_copy *copy);
>  struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
>  			struct nfs4_stid *p_stid);
> -void nfs4_unhash_stid(struct nfs4_stid *s);
>  void nfs4_put_stid(struct nfs4_stid *s);
>  void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
>  void nfs4_remove_reclaim_record(struct nfs4_client_reclaim *, struct nfsd_net *);
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index fbc0ccb40424..54d82e14d724 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -641,24 +641,18 @@ DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
>  DEFINE_STATESEQID_EVENT(preprocess);
>  DEFINE_STATESEQID_EVENT(open_confirm);
>  
> -TRACE_DEFINE_ENUM(NFS4_OPEN_STID);
> -TRACE_DEFINE_ENUM(NFS4_LOCK_STID);
> -TRACE_DEFINE_ENUM(NFS4_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
> -TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
> -TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
> -
>  #define show_stid_type(x)						\
>  	__print_flags(x, "|",						\
>  		{ NFS4_OPEN_STID,		"OPEN" },		\
>  		{ NFS4_LOCK_STID,		"LOCK" },		\
>  		{ NFS4_DELEG_STID,		"DELEG" },		\
> -		{ NFS4_CLOSED_STID,		"CLOSED" },		\
> -		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
> -		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
>  		{ NFS4_LAYOUT_STID,		"LAYOUT" })
>  
> +#define show_stid_status(x)						\
> +	__print_flags(x, "|",						\
> +		{ NFS4_STID_CLOSED,		"CLOSED" },		\
> +		{ NFS4_STID_REVOKED,		"REVOKED" })		\
> +
>  DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_PROTO(
>  		const struct nfs4_stid *stid
> @@ -666,6 +660,7 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
>  	TP_ARGS(stid),
>  	TP_STRUCT__entry(
>  		__field(unsigned long, sc_type)
> +		__field(unsigned long, sc_status)
>  		__field(int, sc_count)
>  		__field(u32, cl_boot)
>  		__field(u32, cl_id)
> @@ -676,16 +671,18 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
>  		const stateid_t *stp = &stid->sc_stateid;
>  
>  		__entry->sc_type = stid->sc_type;
> +		__entry->sc_status = stid->sc_status;
>  		__entry->sc_count = refcount_read(&stid->sc_count);
>  		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
>  		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
>  		__entry->si_id = stp->si_opaque.so_id;
>  		__entry->si_generation = stp->si_generation;
>  	),
> -	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s",
> +	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s state=%s",
>  		__entry->cl_boot, __entry->cl_id,
>  		__entry->si_id, __entry->si_generation,
> -		__entry->sc_count, show_stid_type(__entry->sc_type)
> +		__entry->sc_count, show_stid_type(__entry->sc_type),
> +		show_stid_status(__entry->sc_status)
>  	)
>  );
>  
> -- 
> 2.42.0
> 

-- 
Chuck Lever
