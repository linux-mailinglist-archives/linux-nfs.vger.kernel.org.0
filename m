Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E276B76A44E
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Aug 2023 00:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjGaWoc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 18:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGaWob (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 18:44:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D12102;
        Mon, 31 Jul 2023 15:43:54 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VKMVFW001798;
        Mon, 31 Jul 2023 22:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=qLVtAWDxssO83WVuWj3gGYNLr+kMLTnV4nRfwnDES+s=;
 b=eUUPQskJwBnyGnmNyndEN6tpDcB7Lv4ZxlOjgCtTMpxHIS0gaip5wbsk+8jD+yrytKIZ
 EQxdA/KkznFMuGK6KKZXyEc9ZKxXZ5tckZo6FVFIupR1Bql7FTGaVGj1GRQ1UZVwgmLX
 TBiEL1dtfkUsFc+X3hPRUHmN449yfRBEO1nv9h/KfvnaVqWMsU2spK6w/X9DYxdFmYO9
 UjaObyZ72yZFvjuWrYpA6IJ5LkyOPh6Jo+YKYOEDuAzJr8m2g5P6WsF5ornAZPg7hndi
 Cp5FcWGUF47zBM+v1v3N3/CSwoFsfW5UFDl1uBoAeyWfA2/s706o+oE8VqaFFZoDBse7 jQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spc3r1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 22:43:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VMSRIb000605;
        Mon, 31 Jul 2023 22:43:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7bb9fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 22:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hV7XMsBC1uAyMcl+ZSUDSl5BrvKsLDeLzUe8qWAQ9sw38ijxqmgH9dWTiencF6TYcX4gPPYnAno0v3IEsacfk70NUBEuhcILsNEcx/ZF8qXwr3NEzc+STVbz7Un/zJj7nN9AIVyiL/QbIieT2G0c7LwLHli1DNdxQB7gn5vrtBFxLjOYDrGgQIjfCUPK9nW4eDuZPGaXGfi+DqRxTGp5esMrhWlC495kLBbOECxvqgEcfOc2u2+MzgmZsawls5MXIaUadxhPIDDz5vaieXCxI49jDVSgwbDTpeW3gYMgFFisXGcg8V9YTDfg6UtB7j6cyvUK+kMGEVM0FXlMGxsbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLVtAWDxssO83WVuWj3gGYNLr+kMLTnV4nRfwnDES+s=;
 b=MfiB7WVwb9JAGYw3uZkdyux3UP7i2ji7Vc55dk72CvJHTuEqkXUXovEaJZuky9mDU4qfrscPcPxtrZ5qqB1FI4R0uhBknQJThh502VvWeZ1kngmb5fkprgg43xcrhFBr8QibYMieoQHV0U9Z3HTh5DjkC+vH/beAbv9m6ebOQ7LVCZHKgpdHhzRuCLDKWGo6+q4JRwdfocThOZX3ZYxOktLKIZ7ZT1LMwi5GJoQnJL+T9ysc9pfnSvg+SoW01Ec212tFoMUCTPJYG58cwSGLfv88Xv94qL4uSIGWUkKK9z5H4HI8jiUQ5mbKBoc8L6nzkgaA2a0JrFQIu11SyWAGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLVtAWDxssO83WVuWj3gGYNLr+kMLTnV4nRfwnDES+s=;
 b=Q5eXO2AHMIZBGoLSlglxGF6PBR6KLOBH7ha4Vb0gxIcQfJiCpg8/cEnHknvUPzVbxWguX+aoXRvWPSss2dHajN3BGL0QfQmsRpybPLV8aAOWsa2OaiDa4hFj4EAx5lz5YdowsV12pHbcL9Eq8bTfIIiK30wk7Y/FZGyp4FdLjL8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Mon, 31 Jul
 2023 22:43:28 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 22:43:25 +0000
Date:   Mon, 31 Jul 2023 18:43:22 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] nfsd: don't hand out write delegations on O_WRONLY
 opens
Message-ID: <ZMg5CrlMPsDj95Ua@tissot.1015granger.net>
References: <20230731-wdeleg-v1-1-f8fe1ce11b36@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-wdeleg-v1-1-f8fe1ce11b36@kernel.org>
X-ClientProxiedBy: CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::21) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a424f06-68a7-4040-0e68-08db92178d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OaKM2S8Cqemac8UfzOjir2hVhv+wa9C1QRRYZJZUaRNyjK2NKbB1ApOXnE5LVt6wli0csm3Z4O68eq1v6yg7EG40UHin+R/bI/Xmv/nE1Yj8Xqytk4rXiLhRS60R1/zwCA5UT1sdNmI3xuArf9ht6WJXuN2smv4AMxFpoUqcRgY6yVdSejDAEcE+mT9f83C51Qg7eS/xUebc/a8R/s0YkPd7Eo4P70j4JjkLvvPFKNSrcbrInCc1/ujjf/P17Q5UfVBxcAPvEEC57K+bfi7zJuNxIaMIue9OVFLllwAWs0xqJrldE7em8o0bwFXaCsgW2RInQTLolMB1mEwvXphpWrIWzy/7BYKQuBSQzGHnUrOPYjJyU37jbaei+UObapcb2viPLK765tZEH1pANS6BdJHlgpfLfxBiNJtXesYwtNpCmKGVRLeke6FLg5a93S5FnZxMjEnZjV7hmsldsQJTB28HjTjhNSSkQ90l1ojC4Nprj1LBZvnnwHQqt+afmdzqRzX9aKSuO/y28dovp4yEV4sDrwbdUdgTkC9W362JBhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(66476007)(86362001)(8936002)(8676002)(5660300002)(6916009)(316002)(41300700001)(66946007)(66556008)(4326008)(54906003)(478600001)(2906002)(38100700002)(6666004)(6512007)(966005)(44832011)(9686003)(6486002)(26005)(6506007)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j4ykoGBjHY/zhgyFz61uevVj9Ni5woqIwpiN2WfHfC/bcJOtE0KUdEekT0Ef?=
 =?us-ascii?Q?tdd276UuVIuM+ZJxvr7W5NKxLIEdSDBKHdtOipP0pFpvEzM6MaD/ofztKVKQ?=
 =?us-ascii?Q?t8tQqOc+znq/9030rNX7Z01PjGEwfunWMBCTWTQnWS3+1lO8ksz5uxEnuCKt?=
 =?us-ascii?Q?2uLb0NiO8hCzudb7nMCdhKtNyRKn+3+S4Fh3181c4QTtjxH9LN4id/gRCvCW?=
 =?us-ascii?Q?J51R2/j5FngrbSnUfnt3NPTndzOoYRjc7UnGiiptGTCKwkJMe8FmBAVweI/u?=
 =?us-ascii?Q?4+VoZCRzHqNbBsGdTDRwi6vHusHdQswxJCONhjbSgTfZYFwfZ5ObNyLBK3nD?=
 =?us-ascii?Q?g8fupsJ5vokyaZ+SFiowpkmdl3/bt1v6DTGT31J6qAqQdw4u0O1eeDnBa/yf?=
 =?us-ascii?Q?K0Nx7B2rKXa6a7nA1AnxS32XHeE5QPflQCAoA9FowhAGbm/FZmH8zev/83Fb?=
 =?us-ascii?Q?Nm6RCAhMzsWYJjahhPuBrukqqvxk6mjUhBo3ZatNoxFKGjKs+ddFk+UjY6F3?=
 =?us-ascii?Q?J93IKaVON/cCv1a3+AELySoEhgL/Pz86X59Ac33qiRZ6I8HB4AHVCdy1m9sf?=
 =?us-ascii?Q?U6iy76HyKdU/BrT0tGWlkSat1+B8JyLuiGmvkXx6+brfhCQlQOd8DHASXlen?=
 =?us-ascii?Q?JcjI+9QpDAVsPNYwKMRz8+LkRYKtpeKNqmt3QSRu65Ha3/8Ujlo6Gp8RiPJR?=
 =?us-ascii?Q?7v2FDLAWYndi4M1cMzLwRd17SGyNzpPoktVWcbrFEGOUndLSL3ZuVteBpeV6?=
 =?us-ascii?Q?RnmHGj5SsYw77jrEQllWiEvijnXerS4DV+nqpsvEjmeDeFL/DBPuyOGo9v/l?=
 =?us-ascii?Q?AuDsnZlzFXB29tq9iatUwT/YjEynzjDgrsBXadzJrnaLNKWIBtg2AEz5szqd?=
 =?us-ascii?Q?uAidMNEpoCkwFvYfxNxGGk6Hiw67PenEoQv/X8Lw/fKsXNUFAXAdx62c6TWc?=
 =?us-ascii?Q?UykTKeefKGMYvq8is9xzam983TW9vmY+Cz9VctZSxpaeDwq/IzAwW5h22e0/?=
 =?us-ascii?Q?NADRfJOm5m1UerjwCXc0p1nd1xQzUs5izMRPPTYf+fcWJCQclWf+xeOPRnqq?=
 =?us-ascii?Q?T9CZE/YOMxrNvA18gVBUupuajapUtpbJyvW2nSNa1exJr0yFNzTUWyOlK5B+?=
 =?us-ascii?Q?XfUIHOBDYdFj6GVdYvUtU3pVTKnb12QYAWgFzJZiy+8+fZzR1HwY5dLGzGE+?=
 =?us-ascii?Q?33SoH7iVqBF9WJ5F9NkxeCUKVQ5dIelhDVWncmVn5vev5FGIyOixgReySdOR?=
 =?us-ascii?Q?uJQ7PofyohdBLtD6x5LyLCP+0hy4zZGw8u6mtCzU6z6u1WALDC0qe3xouXEa?=
 =?us-ascii?Q?khqR7+Lks2VJ01PNxRORmqYkG+hifKcFoPvPLMvCCONhzHs/LzSUt9FgasGj?=
 =?us-ascii?Q?wDYhSGd7JnXQVEryO4PIrUBq2cLO9dtOtFwEnomepj4zDC+VGIi9jfBXmiZz?=
 =?us-ascii?Q?rti6VFbxBRVP9Sieajca0FaWT55eodCD+ikXU0qHKer/qLoKLNh+x55CNgFt?=
 =?us-ascii?Q?EoYVGntGN7ecxRn1nVbGLJzNR+8cpeMOSO8Gg4lV2r3u5VmUvl2VYUUWsFxk?=
 =?us-ascii?Q?Ra18bpixa8HEZKqhOR0I7JTYyPiPCwucsqOl3u+SvVGrbsI0uNdBfOxCjzKc?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8rRoQpAvKc1/E3WbKh7oOx9HeNlDk8GfFdq1VBYCC1Cj66jOGbJfArI/6lhHGuqFtmxo1SwryAAu76wxdMz5Y40S8dnCBf6lyM/vB+Jtm7KfCmQ2Fiuj/cYSH7FWC8OT1js7nePLvgVpl3+x1rQjCT2cOxsj0OeZnJfIWTpgLJBVkkGpdM9f66Gi9xfw/qZuHyFSapETtmlkLk4cxLjtQeM/uZh/a0GF/HiEbEFL5+RDhtPg3cnNdjr5oxodOQ1q5qX42LCW96GSzSUpP4NV74D0aHo2nQIk6GnQVkMb7CI0M7Z2L2BBc9Gvta7laip/1rOE+U29wfzdLnmu0dclQ+X9CdY/x/wj0r4B3elzXT5/jESS97TnxkPsTvqYK5NdvveMdoOC9cXiQxLa51TltPr/AnLdqvmsHV0bdJzljmYNl5BcCELQt6+ZzFFZMGvQkoYqM7wQM5JEAueS5e5dqa1kh151XUfPTtQq6dELaga5xeLosGT0BBV2TFc/VrieXW+WdaWDvb9fiy0/81Zi6XnsCWAHpybwLv2iTwZcWPY/s/rTVULJJDVPu1KQI6ezGWJ8ubCOkIo+LiuaaHinG7bY7y4OORNbEm6am8qqSjJqn1HWRNOlNqj7vVZVCyteRmP+6NEA9UCZ2+SEP5YH4yZyqhubPwwVm8rntfiABoca0bffKZva1jy07PZcS57JH8AFarqnJLcpTmHU4nik737BsT2ofMS0e8U2YlzvT8MnQGyIGqL7hqwsLmQj9zTWPSceQdiup83dYw0u4JQxj+AoH21qYMoILooGo7EcobQJsU6eMzpCekx1ZHkHwh6vGphIbqnCgtutw/e1KiiiUAiO0KPSwas3LCS50bl9SJKOAhDWsjU157/WujaCdEIF
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a424f06-68a7-4040-0e68-08db92178d66
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 22:43:25.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDcgDPRF6VGctHnru1v1dgJd/xjWU3fa6TzSyOTgFYIWMnbYJI+1FsnP3KkVvER6ncRgUKHHxUQLUmcLl9/JnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_15,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=681 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310206
X-Proofpoint-ORIG-GUID: 76MT4lR_YYtyvYE_wAug9HFIGHx8qiHC
X-Proofpoint-GUID: 76MT4lR_YYtyvYE_wAug9HFIGHx8qiHC
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 31, 2023 at 04:27:30PM -0400, Jeff Layton wrote:
> I noticed that xfstests generic/001 was failing against linux-next nfsd.

Only on NFSv4.2 mounts, I presume?


> The client would request a OPEN4_SHARE_ACCESS_WRITE open, and the server
> would hand out a write delegation. The client would then try to use that
> write delegation as the source stateid in a COPY or CLONE operation, and
> the server would respond with NFS4ERR_STALE.
> 
> The problem is that the struct file associated with the delegation does
> not necessarily have read permissions. It's handing out a write
> delegation on what is effectively an O_WRONLY open. RFC 8881 states:
> 
>  "An OPEN_DELEGATE_WRITE delegation allows the client to handle, on its
>   own, all opens."
> 
> Given that the client didn't request any read permissions, and that nfsd
> didn't check for any, it seems wrong to give out a write delegation.

A client is, in fact, permitted to use a write delegation stateid
in an otw READ operation. So, this makes sense to me.


> Don't hand out a delegation if the client didn't request
> OPEN4_SHARE_ACCESS_BOTH.
> 
> This fixes xfstest generic/001.
> 
> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=412
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I'm thinking this should be squashed into commit
68a593f24a35 ("NFSD: Enable write delegation support").


> ---
>  fs/nfsd/nfs4state.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ef7118ebee00..9f1c90afed72 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5462,6 +5462,8 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>  		return ERR_PTR(-EAGAIN);
>  
>  	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
> +		if (!(open->op_share_access & NFS4_SHARE_ACCESS_READ))
> +			return ERR_PTR(-EBADF);

			return ERR_PTR(-EAGAIN);

might be more consistent with the other failure returns in this
function.


>  		nf = find_writeable_file(fp);
>  		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>  	} else {
> 
> ---
> base-commit: ec89391563792edd11d138a853901bce76d11f44
> change-id: 20230731-wdeleg-bbdb6b25a3c6
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Chuck Lever
