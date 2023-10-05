Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B7F7BA193
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Oct 2023 16:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239453AbjJEOn2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Oct 2023 10:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbjJEOjE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Oct 2023 10:39:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B920A55DD9;
        Thu,  5 Oct 2023 07:05:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3950uaUe030025;
        Thu, 5 Oct 2023 12:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=VtJffvlx8QRPJI+oBH5ibNh/oaPPZ0Qz+zMISWtn/f4=;
 b=ysiU31zjT8AMBJ2w0M3yWNTd5DJNtMbrtSYn1AiIRu5RxS4Yh1zn6MLoiw4WAWhotmc9
 FOjjDDhab9CTczUCQDSfuZEDi5QNBeZoV7QH46rk51mmp9GQKtNid/SCE5imB9s0XtzG
 0HO505+xCqx3PyGz/6zFqh/pmjC0LxksBWfusBn2ImFi4cTBwpisRS2VD+kcbw3Rl7Vk
 fgwxNbETSa8ANZ8V6ENgGVi8gwVqGtyu91QTeGrVGDUFjE5EosdxtOU4Ki0YOqIcbkQY
 wqIZmGe52avk+FylxTvxibcjCbOy4Yl+6OIdF64wbQmu2HC7yXVmT2zjzz8bv6sjiHUb DA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9uhdqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 12:33:58 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 395BYe6g002877;
        Thu, 5 Oct 2023 12:33:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea49131x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Oct 2023 12:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJh8CU0Zrlv6r4eJLNovhgKJ/K+JyzCRcOSy/lHGG0dqQnxOwHQdqU94qy9We0w56Vznf7oC8oMGwTh+kdh8FTTzq53jpaXPi8Z+TYgYw1A9MZdlU/o63/F9sPyTWFw6cZ/s1xyqYkyxgKqIl08CzzN+y7UwlQ9j8mhNrn3yV4+mO05HE554Vv9rc9iv+iu1J0aMkgkUTK7zQf8vgPTjj9I9etx8eHXVYb2liGwIu259iYyhm2vJOpsCsdDBtBl9qErEwAz1aD9/wy410prBD8LFCvnFThBIB62EH+zOK+Y7oEPKQW0t4hKBlt52jhcQl6QhMH2o9C8/fSHrUsLjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtJffvlx8QRPJI+oBH5ibNh/oaPPZ0Qz+zMISWtn/f4=;
 b=kPJad5q7fk2CHktYQ84hyNwnpoFNloE6SSzz4h/FqfbQjYUCEVoT27Oq2GeGAnektbljJFpQ2LWVOG+gz0rqQs4oHCqEOtEISR85oaQ5Mn+sDfSsAQ4VyekDhyu2gVbecZx7KPGXo3st+1v8w4arxilL7Q+fHSRrG6OGsc6nyXz8OSK4xFv8Ios8p0/ge/Y/xncJRvcEQsbUoq6AZPT6TuSYPmELyOBWrDBodMLXiN3jpBv+phrISGf3a929Iuo8RbarP6Ba5JfVYML7qIZd0StYF7cWwJI9BQyKtmDt2xZxkLPP7iEa3QTmv1k7sFyI8Kh8Su42WuVNhYI62YGH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtJffvlx8QRPJI+oBH5ibNh/oaPPZ0Qz+zMISWtn/f4=;
 b=Ya7PiCK0IC2g0CxMCEFhwv34i9JB190FEZU8rE7u2ROA4LNzL4nuDnyRepO5N/aEmiMMFMd+BOok82RqiYomy9bS/irX9qqWqtH7Q8JHvKNATVOeO7D9X4ch+ZR+pMR9c2t/jiWKceq7VS3ZWrIL68DfhqXAY4wS2AbULHSVEtU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Thu, 5 Oct
 2023 12:33:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%5]) with mapi id 15.20.6813.027; Thu, 5 Oct 2023
 12:33:34 +0000
Date:   Thu, 5 Oct 2023 08:33:31 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH] NFSD: remove NLM_F_MULTI flag in
 nfsd_genl_rpc_status_compose_msg
Message-ID: <ZR6tGx/vqRURMmxo@tissot.1015granger.net>
References: <3dd8abe7304ed6649e581bcaaaf61fc1278cb3e2.1696498541.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dd8abe7304ed6649e581bcaaaf61fc1278cb3e2.1696498541.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:610:cc::11) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 272baa88-7a97-4a90-a272-08dbc59f4aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnQGP8/4r4XA5sPAWfpa23Qevv7XxE828+5n58Q6CpeO08qeNzCU5xgmM0lJXqPIBwDTRWjfqoByGylMAZZM9a1qlFhGzStAUF2hvdF4nWgqSmaVAZNykFWMEgd8xeNXVvqDO2hMZPLnH7NC8v8ETHebjzieKLxBwp0tsyiU6ailYmW4vdrHeimsT7ssPES2K5l6Jlq7wAbrabIZhJKXkLrUZFU/wjJlrlMhTl9+Pg6P05rzwfO9G4pYfe0GnkHaY5EDVEz1QZx7GuW/22I3AUj5bKu0WNz513Qs8C2ct59+n7MFAPIPDzDzUfbPBazxBmjt8/52ai0g209NA0uefzqA6oHaT7+OkaAOWj9hTaExoMO13iQrLGdRJvqIGheDImZtDINobM0qUVMCFMxLvSWZfrZiJ8goSMgHKZUxqD6a8mcETY9GnJU2TfXm148g9wvE3TtTvMAyaxw7DGoJtXJ6UDsWkfeY1xprOCZtfT+OcWiewvZCAUAj5kNyzs4raSNtq6PJzPa+8rKo2pxRFibj7+NxiiEQvxKwb5QIjvesTqYzwUrCdOuDQKQVoaH6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(66476007)(66556008)(66946007)(6916009)(316002)(41300700001)(6512007)(9686003)(6506007)(26005)(6666004)(478600001)(6486002)(38100700002)(86362001)(83380400001)(44832011)(2906002)(4744005)(4326008)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/kuAm/b/xu4i9bsOoHk0l1nq8NR0zB1E+dF7Za6FMAtaIhbrVkS1+dV5zHtp?=
 =?us-ascii?Q?ah3XAij6e4iWAYYdBubSoa76KlXl4KoqRhJgckju7yhchsurmxhvVruvVZiX?=
 =?us-ascii?Q?i0OCL+AU/f9EwnMHOhN0xYAH/z+Zy8aIohm6XLrQ8E8QVx6nGf9PenFpwwXV?=
 =?us-ascii?Q?H116ObHImkxOlwIVUtXdVGRD8i9X5QoUtogVkybAzw6y97s0l7sL38SQuggx?=
 =?us-ascii?Q?f4O+VoRF7fswl/H5gIKRy5w8ALyX091NzTnhKmq6KixG2h81T/FrhCPd7OZS?=
 =?us-ascii?Q?BFHJ7ktXho4pXnTBnzY89E0kP1rSwKAMd9Bmivz0EU8EMHKADQSHhOSuOkWP?=
 =?us-ascii?Q?Pxp21sr/uUuapquig9lM4Z+1ZxE7a9omhA9/H013BwJxphdtqLw3H/KitmIs?=
 =?us-ascii?Q?mvPzNkeksthbqo9ek+nxPFfKy5qdockP/yyPrU29m0IZxwecGIbQQpFIBNDS?=
 =?us-ascii?Q?YxjFHcoRco4nYu6hlYr6QWiUs3p39tI77CiHD5CgaR1peYHqRBAgljBbDfL9?=
 =?us-ascii?Q?v3ZxFB0Bt8U98EYNS5YUM+g/2kvRONetZ48zsPADd6wThAAeaBHkUhuS1nZm?=
 =?us-ascii?Q?SXEIq+NNz4xWhAk54zeI0F4/LuTMsZEKnzznqTzb6IrLjQju/5G121RkMFpF?=
 =?us-ascii?Q?nn3FlUYXbF3t9lmxxpSLhluTzFMi0e40elvS1IuutEeyZSLMdQqyWxaWd9Y4?=
 =?us-ascii?Q?+uAUtc8a+oe1lbvC0vZKgi1y/43771kgtaTOy/XxGfB7bwhJ8nQMZm3XDbI6?=
 =?us-ascii?Q?yxNh8+BVAMPsaLjHxtr1o5OzlOS2Cjx3CZRA9yPk5I4UK3J9bCVl8p7V4Hq6?=
 =?us-ascii?Q?za+Y4KmMkD+x9Hmk86yU+02s5roz2Nr4B6M3vGrHVz9Zx72zicLJlPN4Dxdm?=
 =?us-ascii?Q?ga1YdubS6dsQdeYDCpHLWD3OI67lM00CyYt9bZ/lxfmcv77LvJ6ct5SsdJ6K?=
 =?us-ascii?Q?2kmu0ONgdgCpJRh1RddfpPVUTqm44XxG/Ik+V1EcKcSM1k7cFvId2eHr8NGc?=
 =?us-ascii?Q?XbDoR7ENqbIziGBlmShvnww0lKGUlem3bR45K3xiOlaxe3os9NOSSg4JlGyy?=
 =?us-ascii?Q?fKEFKO/8koSxa6wY+fUTuNjHSmzAXykNrxddrQ9taCcXRWG+9YQo+fMc+uKv?=
 =?us-ascii?Q?/XGBj08M0zA6+xylmz6dzIGTI9I28kXE3ALoYnocnGD8u2tQh8RlZXwPT11Q?=
 =?us-ascii?Q?qTDY0EhdKIOole5kBaIin2srqFl5J3ghDQMb8CvinlVspLWpsFWPFeUwqiJM?=
 =?us-ascii?Q?Fp2U/Fc6ARpU4zgYzMexvyijGBqhIT+J2H3mckDOWkbq3vkxQa6SOuzYxOuG?=
 =?us-ascii?Q?ataKaf8UrT/QpPrlkBFmrGvWHkXfJq6lvc2hq8ouZji3Z6dxm6NzwtfUINhF?=
 =?us-ascii?Q?LF4YbA9aY4Fn29KNpbTgjJpLRJLLtZM4X4N3bxjZiKFOa8k522u2/Ywm7+fH?=
 =?us-ascii?Q?TwswNwbLrHh0E1AoQVW8+yVhoict7eNiFSq5ptrE7WLk2wYoGIQjeqADXax4?=
 =?us-ascii?Q?tcOyduhOTXfGW2Y7RP29d5XAW9Lw78ByVM7+ONJZGLY+Hh3TJEKTVaSr6oVL?=
 =?us-ascii?Q?0A7yEjZ2vMb5m34RsvUEe0RUp71HKA0bYUI0JTv+I/5ikIbNcBfMGf5PqqXW?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UVkB2sD8jVrWr3n1amPDV7cVcf9OTPz3q9CGUgvbNUCyxaCU9ATOBmtfesdPvD5EiHUAj057+pNHQDW4Cx0WL1BtVRGZb1GZks3+0Runi4dPbEsLsXtaUqIGaemEdI7Qcbk7kUqZEBlp7hnzcdq5tMZiIzIdztvmKpftEkQLHijfcUwTA47gWtM96URNbeVidmZy9dFZAbGRPS0BMrtGY9eaast69vDiU4yXrDCSvjgpxA3Tounifj3Fzw1oaU2oJsAX/OT5Ydoo0br4ZC536MqbD9Q9oTOMYrRY0ZbUGPDUEiA1+kL4c5UHzCDUSPZ0hk+mq3hug2ztO9rzJQg5hovoDSJRLRDtPyzMNNedl5dbXIJ3Qp6gQcGRjbKb2oq3UPZvNbKamXUzaj7PDmx2NDxiWWDSHxI5twSlcH5Mwvhv97tpkGDYExqBunO+LHNvfcZkjzKMvLkcu0Uj5JfoO/dVO2kNrRhi7WElllnR4YiiLV2rY9FncsOt8BJC/jRaoaM+SLhPN5egd/UNP0Zx0I8Rtxm+vFrBoomhOUUhp5u7Vr9ElVPJgjZmCt6FTtGvwiMzCradcxQ5d7tIToZ+/biyLJcG50KiLorvgKQuPLrnUDyhq74pHB+tSaFk+6jgzTiQvkedguWsEm+wtybCD1hQkVz8MLSAgSaGFoNRcUlSjUOD1fGLQBhwe2UADgjo0tv/DWnv7a8m8n6wSDr7aoYNewD8270yw+i0jbD6LhpkK9wO9SHsAW84cSRm7JTjC0YdBsYi8uOF3RkRfgtA0S0va4PPfboiqJr5e8m4IadzQO4If4FTZei7Qvyk3qZDaRGrbWSsalI/UhHGqW8mgw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272baa88-7a97-4a90-a272-08dbc59f4aa1
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 12:33:34.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pK43KZFT2ZnPR9985eCdyzhofP4eGX25YWouzX91mBmBOHFtW0U1MdkLCQ9DdhNWUNI3Vf5rm3jgmKP324anPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_08,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050098
X-Proofpoint-ORIG-GUID: k6ZY5BxUhIfAz0A_O2s12yoktbKRp9Aa
X-Proofpoint-GUID: k6ZY5BxUhIfAz0A_O2s12yoktbKRp9Aa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 05, 2023 at 11:38:17AM +0200, Lorenzo Bianconi wrote:
> Get rid of unnecessary NLM_F_MULTI flag in nfsd_genl_rpc_status_compose_msg
> routine
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfsctl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Squashed. Thanks!


> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index b71744e355a8..739ed5bf71cd 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1527,8 +1527,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
>  	u32 i;
>  
>  	hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
> -			  &nfsd_nl_family, NLM_F_MULTI,
> -			  NFSD_CMD_RPC_STATUS_GET);
> +			  &nfsd_nl_family, 0, NFSD_CMD_RPC_STATUS_GET);
>  	if (!hdr)
>  		return -ENOBUFS;
>  
> -- 
> 2.41.0
> 

-- 
Chuck Lever
