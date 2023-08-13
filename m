Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65FE77AA67
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Aug 2023 19:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjHMRbz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Aug 2023 13:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjHMRby (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Aug 2023 13:31:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A598710DD;
        Sun, 13 Aug 2023 10:31:55 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37DEefhj030501;
        Sun, 13 Aug 2023 16:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=EoMvfxJT5kfpqPQ1E7YsgYIENaRgysIjoWm1AtIsqYs=;
 b=q+LEZ3tpP7bkCHWxfeVU41hPyIb7WbohSv5F59fmmxCtMmrHEZfJZtSEivEA76qwh2aP
 nP+qd89YNAUSjYtj7SmhvjuALMlDQ8gLB/YldNNKGPj14BfLzDl6icdY2svrzLFFgBMB
 A3KRIX2Ug4i3obGHLEyieZEeIkmxKQQM0wvi9fnYdB2c00XdK5fTGsObeKiELKOGYahh
 8ZghCilxfxQez9vZZe6eEW5NA9Q+7AXwyNs1qTmlBHTy6lm6YQVFMsYAoLht+/NpFOYR
 Ic98pbp4MWryz2WcLu4Izxhxj/M0uVAQxBUwjXakEcBNRyBNS9XwU8NU35jOnmOKONL1 qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwhb66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Aug 2023 16:04:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37DCS2pp039491;
        Sun, 13 Aug 2023 16:04:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey6x396a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Aug 2023 16:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFHWdowV6pdDwzDIHjmLu5qQx0cKQSdOrkECoRftv0OOatK1nOzOxlYiEmv6+uNTqs6mbaDsE8SmDK/inX7wY+u+7UqC6tmTp4ccvk57wsbVMVVRX0xWiv3CwfHShO4aS8b5Nw3EFnAb1TaVr5RtWzDubaJdL22BjgWCXeZQzPx927Uo4ShpuaCh73Wn7zG5f/vj8sQaf6FGNeQs+/cpolqjcuOkquGbrQuLQnTi1Fzm595RDG8DkabepCKKeCQH9sTUsvyhuyrquyzTlbs/RUvowJyX7dQKMqkGpeiVeTt9pO5Waku1ayqpDSsENVIQnjpwWWLsWOjH+pH7A6tu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoMvfxJT5kfpqPQ1E7YsgYIENaRgysIjoWm1AtIsqYs=;
 b=FeU+bk+V9cRhQehsklEaZZcatLcggeWyH31Ub3exhHE04lVswHnmdh18aDaMzQH8UheOjxWucRNpcTFep06gQCVUgmqcyH2N+JKLQ7NCYhC2jbEi+7PENRqX3MIYVM6nqrbyw7kuJWvCmH2EB6l/3IugV/wPaTVji9Q34iDONfA2EiDhqhgLk3QDEvC3KviBNzwO/61wQAhTQUMR+/su2C6xCKyZAmMBWOF3WF2JhGzwdTv0jwDw024LE2dQHXkr1icmXooNFte0DzsxAwG1D378cJFZkA9eNv1WNyLLQbEztDjuV18ton+8aRuIqLZ0YuHEUwDCO1VkZdwjIwJpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoMvfxJT5kfpqPQ1E7YsgYIENaRgysIjoWm1AtIsqYs=;
 b=vRgZ8Pe/DEfxIz1Xb7LrwOCq8uTIkS0elkdCY2i43HPofixPIRYWYir+rGh4wKgJ+978KKllw/ABZjNN0TFtOIRye5VJcC9m8lOMxncFHaGHfgLSEQTSc0yioaUjo4NS7Eh5jSp88YxANICClKLLb1Brqy5nktsTwKdsbM15Mlg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7511.namprd10.prod.outlook.com (2603:10b6:8:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 16:04:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 16:04:47 +0000
Date:   Sun, 13 Aug 2023 12:04:44 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH v2 1/4] SUNRPC: Convert svc_tcp_sendmsg to use bio_vecs
 directly
Message-ID: <ZNj/HACNv/y1zTkj@tissot.1015granger.net>
References: <168935791041.1984.13295336680505732841.stgit@manet.1015granger.net>
 <168935823761.1984.15760913629466718014.stgit@manet.1015granger.net>
 <6410981f7adc45de4f4b1c2455d5b6d398472628.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6410981f7adc45de4f4b1c2455d5b6d398472628.camel@kernel.org>
X-ClientProxiedBy: CH0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:610:b0::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 4657643b-c085-4508-9188-08db9c1703ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMxGQVIVRk+LTfgdlF3Nh38iVydiBpDlcMPJo9JumV0qi9WskxvyUjmiq1aSL9hmMrjFA/V1HEWfbUqL8f5tqoKCsQVcwzZuqdiajBnsI6CTr6QB8lh7755VQOOazUj1MjSg1sIQTRoeoAJbWtaUdJpngjXsN9zMTbtnY18ivr5lSCQPW9A22wpDDgSqEYEoDuTj1rmzOokahhquqtoP9r5JY/WJxLvYYqhwaOIDPedWhBzNMHAL3ve36hUa5dnuuipXgTBMOxW1zyOtisk0odsHsFAIYGMixzhNuVK49VsxgJkZtr9La/qh5AkDHrMJFWquTnjNNUd5yL/QBfARyHXH+36t4DVuZoyHr7Z5mpkemzKaLVkgqjfmEMAeTdos7DLeJbxh5faY6zn+PNyBK7MbXF2e483h5NtidXpJu4abEraFFdtcEUxlgfw+UIkPMityllTeKxQnZ2XE/pKqOQjMCjH+dgVCjh9aYyTVWr125Tj3IHXrJuQVPQgDwXVnTipNBCU3UDRZk9PqtwppbaDAMnRlJpxhYBRgWYOvHkNvTiYEa3ZFdTiFg5++VZ+j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(1800799006)(186006)(2906002)(8676002)(8936002)(44832011)(83380400001)(38100700002)(86362001)(478600001)(5660300002)(66556008)(41300700001)(66476007)(66946007)(316002)(4326008)(6916009)(6486002)(6666004)(6512007)(26005)(9686003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKDm1MgJVU4Jchh2ceciw+0hUBxZAEThrRmDwY82IAi8O8S6WtqjsbrU8Fej?=
 =?us-ascii?Q?eFl2JK1gm/KDz32kepumKQbSNge0BEFb7PvDVOuYQJUgkDxn/u9DPUkXluxv?=
 =?us-ascii?Q?FE9InhgsLpA1pWZQisrvqtXlvU8czUqClAAexHzOxTC0rk5spZhpTz4QKPlp?=
 =?us-ascii?Q?NdkOMlDusEFPMOo2R4j6zUVjIbBAwHIlWiQXkBku9RskQXyIyRfi0bAXhcxb?=
 =?us-ascii?Q?aO9TfpZIZT3U9aC/XcxKNCGhmHSTYG10Ba03MoG9qj7Wo3FQdipmrIdckj9U?=
 =?us-ascii?Q?gzmaOqODrzcgfsiUAz6RfQMwTJhf78EWK/sS6Rg24RrrdN9q4hpjonpnhyYA?=
 =?us-ascii?Q?bRjWWpHpixjAM8H532k2zoCYKKfSUgb1ENvyOA36L9poVZqyQtke+Di2ECFa?=
 =?us-ascii?Q?49GXWHjCQQrW2Xbc1O1yqjbvYdsGxHB5VUWUr8D4PbNDqefEogNIV8p8Eu3v?=
 =?us-ascii?Q?rXimCIsIc7w0FiF9NdM0RG6dXO2zzTT9mql5SxUzWg2jM1F7hgS8FvB8tB/G?=
 =?us-ascii?Q?qC24DZNjLsgRF3dnomihQ9wTpXld2My0wBFNn/t3xiYK02koC/86Nyg9M4/T?=
 =?us-ascii?Q?u3lnlOLf4qv8U6Jg2e1jfpjkEbD7XcW2hDjjplc76MyZI89KiwKkb0bTTm38?=
 =?us-ascii?Q?23WerGpHjYODCxWEfDijTxiLNiY6oQuRRFtI2U1vzFwjsrKe2m4H/iG6+jvl?=
 =?us-ascii?Q?4rD9KF2MYg6eWDheB1/PjG2Y9F9Yk9Vs3lm0jBID4maI708kly3vDkvZtqwh?=
 =?us-ascii?Q?AWKGyhpa7bvu2GaRMvru6xG9p7MPylnyTuZIbPECm5Nq0PlzIRXlwkyULhic?=
 =?us-ascii?Q?pPDK4GD45X7611VQt/2MuDBFjj/BrTvCxS07013bhLYiUI/uNtd3g5EaowYD?=
 =?us-ascii?Q?FDCFSYcgeCEvIyNa/G8jRKj/E3J4wDyG/4AoksOny0U9uADQsgJg6EFgLaVL?=
 =?us-ascii?Q?1966XzuQt3CMmUXf9MmqgwgvO9/EF6rLosu8suyg051f4/6DTFNXhtLFLvtW?=
 =?us-ascii?Q?US/s1ctaFSi/297Msx9CqZoqfCn9suykoP6gwCPTkPkhfifyOmPmBBpi6M8P?=
 =?us-ascii?Q?6gzlHeTm+NPc0RDny1BJnTDoEQt19V3y7eBv7oydbGpp5yFkpOnfXLNONTgs?=
 =?us-ascii?Q?r2K6e64z/n+GNC2Z0xlsBMPkCGcfeIg5pty9BlQNk1wQpP9kovC2xZfzRI0N?=
 =?us-ascii?Q?AfBBS/99ivIbmOTRXlJlhbwel/NBQd+lpqTpQ+usVq9bs37hhGAwqkUsmVDi?=
 =?us-ascii?Q?7kOhxUna6a3aG1scu6sgHMS12o0GjT6eUfXOI64/qWiBTbj30jsDaww0XQo5?=
 =?us-ascii?Q?lOnwpaf3gaxDuWZhMxLS4PICPvz92qOw3WZJcvCj6M5pvd3EBw8IRI/YZZRb?=
 =?us-ascii?Q?2T05QY3VdZMV/I5pw3Y56iNcDhBxFkwyhoA82ACmbEuLT6kDp/6aHi0nlWZ0?=
 =?us-ascii?Q?8Y4zlHlal+XVRn/BKrlZ/gMAsPra33lwVMQn6UH3pTmxspCTbh3YUl76rRp+?=
 =?us-ascii?Q?bRPHzbeCI+X6gWkjKwSdDfbdqAVBR+vuyumZ/kHVf6nJrMeK0yvLFfXKO/i8?=
 =?us-ascii?Q?jE6vA9lLmfASnrSjr3/ahd3q4OTlFXKRkMa5jChiNDb6yDnkSULImYpXpxGg?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Xx2o4dLPUNySa3HEgezGU9CKwvfiyR9swTBLauhpjKkWnkjwmGNbTdAxeaLMM3Fm3ibunaiLIBzQCuRYgmp8MnlURkaf3NhwcOQEVhHGHwxWbtpGoBOPB71Dorn42MTsB0EZeqJe9/PRYORAxIYB9UzeuMmmSi01kK10rE4ODHBpcAxALTh9JrDa0TIH67/RDb7wTIu+rhyl9A0c5u8AkP5n8bvx03VkynW9gHBWVzc0Ig/4/foVEtB8hv1w0vZX9dbwcdOZ02+UHqFNX6ynkheewkgzhI2JbYw5eawyUNejCeqFXCJc64JNLTxah6vsizaXI236pb2fM3D59qDfinfj+fyZVDDijmFRDrBExQt8bDtldE1hjkCMsM0UXsf+RrmS8blwH0md/frdUy6h6iaFFo687egOdeA5lRUxXV+AWGVVxcgGPli7mB36IP53JwIcISV9ciIZCoMzqMK0u7FBYVatF7xtAH3wXp6odDMpLsdKxSCmrM0xUDofRROwg68m6z81YUBMoyU/Il7w2Cc4MfeD1sBzhGodYfnwjiS3lTxjOAr0LtacslewtOZEEnVAsHJHp5iJPqN8QzNS4U2YhchHe9U1NMa8K1O92T3xxff/OirfOlVYupgVWhCLgzom6Ehi6M8Zz4WrqLamhGHFEG1jpwUCqFWcNz6s3bbVcZmCZC6Kg9glZSyNKWvF6ipkH667XJym/aL1mYeQ1UcA1TQTXZPGCi6oybnDeOlhQPKR4gF+zGoLOrrLPvq4HkjgicQ943LklND1ch1FtXTIXvcEzBr3PfHsiMXG/LEqIgxdT3YyCMAiNk0eOksv
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4657643b-c085-4508-9188-08db9c1703ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 16:04:47.0320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zIV4UjO3i9r83NVQ4d7BCHejaYpbnEDsyKZZ0xJVgi0mkNp7w0vj7GszIHvykT+xspu+hm4I4BT0sx9xpb1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308130152
X-Proofpoint-ORIG-GUID: 2PpynyKu6PjQtE-ovk6t4VV01zGsgn2V
X-Proofpoint-GUID: 2PpynyKu6PjQtE-ovk6t4VV01zGsgn2V
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Aug 12, 2023 at 08:04:57AM -0400, Jeff Layton wrote:
> On Fri, 2023-07-14 at 14:10 -0400, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > Add a helper to convert a whole xdr_buf directly into an array of
> > bio_vecs, then send this array instead of iterating piecemeal over
> > the xdr_buf containing the outbound RPC message.
> > 
> > Note that the rules of the RPC protocol mean there can be only one
> > outstanding send at a time on a transport socket. The kernel's
> > SunRPC server enforces this via the transport's xpt_mutex. Thus we
> > can use a per-transport shared array for the xdr_buf conversion
> > rather than allocate one every time or use one that is part of
> > struct svc_rqst.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  include/linux/sunrpc/svcsock.h |    3 ++
> >  include/linux/sunrpc/xdr.h     |    2 +
> >  net/sunrpc/svcsock.c           |   59 ++++++++++++++--------------------------
> >  net/sunrpc/xdr.c               |   50 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 75 insertions(+), 39 deletions(-)
> > 
> 
> I've seen some pynfs test regressions in mainline (v6.5-rc5-ish)
> kernels. Here's one failing test:
> 
> _text = b'write data' # len=10
> 
> [...]
> 
> def testSimpleWrite2(t, env):
>     """WRITE with stateid=zeros changing size
> 
>     FLAGS: write all
>     DEPEND: MKFILE
>     CODE: WRT1b
>     """
>     c = env.c1
>     c.init_connection()
>     attrs = {FATTR4_SIZE: 32, FATTR4_MODE: 0o644}
>     fh, stateid = c.create_confirm(t.word(), attrs=attrs,
>                                    deny=OPEN4_SHARE_DENY_NONE)
>     res = c.write_file(fh, _text, 30)
>     check(res, msg="WRITE with stateid=zeros changing size")
>     res = c.read_file(fh, 25, 20)
>     _compare(t, res, b'\0'*5 + _text, True)
> 
> This test writes 10 bytes of data (to a file at offset 30, and then does
> a 20 byte read starting at offset 25. The READ reply has NULs where the
> written data should be

Nice catch. I hope this is something you found with your nascent
kdevops rig...? :^)


> The patch that broke things is this one:
> 
>     5df5dd03a8f7 sunrpc: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage
> 
> This patch fixes the problem and gets the test run "green" again.

Note that the version of the patch in this reply is not the version
that is applied to nfsd-next. That might not make a difference,
though.


> I think we will probably want to send this patch to mainline for v6.5, but
> it'd be good to understand what's broken and how this fixes it.

I agree, I'd like to get a root cause before proceeding with a fix.


> Do you (or David) have any insight?

It's often the case that this kind of problem is because either the
send or receive code doesn't handle a non-zero xdr_buf::page_base
correctly. A failing READ at a non-page-aligned offset is a typical
feature of this kind of bug.

This class of bug slips through the cracks when testing with POSIX
pagecache-based clients because such clients only rarely send non-
aligned READ requests.


> It'd also be good to understand whether we also need to fix UDP. pynfs
> is tcp-only, so I can't run the same test there as easily.

We don't have a good story for testing UDP. We should either build
a proper test infrastructure, or cut bait and remove UDP support.
But once you spot the incorrect code in the TCP send path, I bet
it won't be hard to see whether UDP also has this problem.


> > diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
> > index a7116048a4d4..a9bfeadf4cbe 100644
> > --- a/include/linux/sunrpc/svcsock.h
> > +++ b/include/linux/sunrpc/svcsock.h
> > @@ -40,6 +40,9 @@ struct svc_sock {
> >  
> >  	struct completion	sk_handshake_done;
> >  
> > +	struct bio_vec		sk_send_bvec[RPCSVC_MAXPAGES]
> > +						____cacheline_aligned;
> > +
> >  	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
> >  };
> >  
> > diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> > index f89ec4b5ea16..42f9d7eb9a1a 100644
> > --- a/include/linux/sunrpc/xdr.h
> > +++ b/include/linux/sunrpc/xdr.h
> > @@ -139,6 +139,8 @@ void	xdr_terminate_string(const struct xdr_buf *, const u32);
> >  size_t	xdr_buf_pagecount(const struct xdr_buf *buf);
> >  int	xdr_alloc_bvec(struct xdr_buf *buf, gfp_t gfp);
> >  void	xdr_free_bvec(struct xdr_buf *buf);
> > +unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
> > +			     const struct xdr_buf *xdr);
> >  
> >  static inline __be32 *xdr_encode_array(__be32 *p, const void *s, unsigned int len)
> >  {
> > diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
> > index e43f26382411..e35e5afe4b81 100644
> > --- a/net/sunrpc/svcsock.c
> > +++ b/net/sunrpc/svcsock.c
> > @@ -36,6 +36,8 @@
> >  #include <linux/skbuff.h>
> >  #include <linux/file.h>
> >  #include <linux/freezer.h>
> > +#include <linux/bvec.h>
> > +
> >  #include <net/sock.h>
> >  #include <net/checksum.h>
> >  #include <net/ip.h>
> > @@ -1194,72 +1196,52 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
> >  	return 0;	/* record not complete */
> >  }
> >  
> > -static int svc_tcp_send_kvec(struct socket *sock, const struct kvec *vec,
> > -			      int flags)
> > -{
> > -	struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES | flags, };
> > -
> > -	iov_iter_kvec(&msg.msg_iter, ITER_SOURCE, vec, 1, vec->iov_len);
> > -	return sock_sendmsg(sock, &msg);
> > -}
> > -
> >  /*
> >   * MSG_SPLICE_PAGES is used exclusively to reduce the number of
> >   * copy operations in this path. Therefore the caller must ensure
> >   * that the pages backing @xdr are unchanging.
> >   *
> > - * In addition, the logic assumes that * .bv_len is never larger
> > - * than PAGE_SIZE.
> > + * Note that the send is non-blocking. The caller has incremented
> > + * the reference count on each page backing the RPC message, and
> > + * the network layer will "put" these pages when transmission is
> > + * complete.
> > + *
> > + * This is safe for our RPC services because the memory backing
> > + * the head and tail components is never kmalloc'd. These always
> > + * come from pages in the svc_rqst::rq_pages array.
> >   */
> > -static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
> > +static int svc_tcp_sendmsg(struct svc_sock *svsk, struct xdr_buf *xdr,
> >  			   rpc_fraghdr marker, unsigned int *sentp)
> >  {
> > -	const struct kvec *head = xdr->head;
> > -	const struct kvec *tail = xdr->tail;
> >  	struct kvec rm = {
> >  		.iov_base	= &marker,
> >  		.iov_len	= sizeof(marker),
> >  	};
> >  	struct msghdr msg = {
> > -		.msg_flags	= 0,
> > +		.msg_flags	= MSG_MORE,
> >  	};
> > +	unsigned int count;
> >  	int ret;
> >  
> >  	*sentp = 0;
> > -	ret = xdr_alloc_bvec(xdr, GFP_KERNEL);
> > -	if (ret < 0)
> > -		return ret;
> >  
> > -	ret = kernel_sendmsg(sock, &msg, &rm, 1, rm.iov_len);
> > +	ret = kernel_sendmsg(svsk->sk_sock, &msg, &rm, 1, rm.iov_len);
> >  	if (ret < 0)
> >  		return ret;
> >  	*sentp += ret;
> >  	if (ret != rm.iov_len)
> >  		return -EAGAIN;
> >  
> > -	ret = svc_tcp_send_kvec(sock, head, 0);
> > -	if (ret < 0)
> > -		return ret;
> > -	*sentp += ret;
> > -	if (ret != head->iov_len)
> > -		goto out;
> > +	count = xdr_buf_to_bvec(svsk->sk_send_bvec,
> > +				ARRAY_SIZE(svsk->sk_send_bvec), xdr);
> >  
> >  	msg.msg_flags = MSG_SPLICE_PAGES;
> > -	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, xdr->bvec,
> > -		      xdr_buf_pagecount(xdr), xdr->page_len);
> > -	ret = sock_sendmsg(sock, &msg);
> > +	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, svsk->sk_send_bvec,
> > +		      count, xdr->len);
> > +	ret = sock_sendmsg(svsk->sk_sock, &msg);
> >  	if (ret < 0)
> >  		return ret;
> >  	*sentp += ret;
> > -
> > -	if (tail->iov_len) {
> > -		ret = svc_tcp_send_kvec(sock, tail, 0);
> > -		if (ret < 0)
> > -			return ret;
> > -		*sentp += ret;
> > -	}
> > -
> > -out:
> >  	return 0;
> >  }
> >  
> > @@ -1290,8 +1272,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
> >  	if (svc_xprt_is_dead(xprt))
> >  		goto out_notconn;
> >  	tcp_sock_set_cork(svsk->sk_sk, true);
> > -	err = svc_tcp_sendmsg(svsk->sk_sock, xdr, marker, &sent);
> > -	xdr_free_bvec(xdr);
> > +	err = svc_tcp_sendmsg(svsk, xdr, marker, &sent);
> >  	trace_svcsock_tcp_send(xprt, err < 0 ? (long)err : sent);
> >  	if (err < 0 || sent != (xdr->len + sizeof(marker)))
> >  		goto out_close;
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 2a22e78af116..358e6de91775 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -164,6 +164,56 @@ xdr_free_bvec(struct xdr_buf *buf)
> >  	buf->bvec = NULL;
> >  }
> >  
> > +/**
> > + * xdr_buf_to_bvec - Copy components of an xdr_buf into a bio_vec array
> > + * @bvec: bio_vec array to populate
> > + * @bvec_size: element count of @bio_vec
> > + * @xdr: xdr_buf to be copied
> > + *
> > + * Returns the number of entries consumed in @bvec.
> > + */
> > +unsigned int xdr_buf_to_bvec(struct bio_vec *bvec, unsigned int bvec_size,
> > +			     const struct xdr_buf *xdr)
> > +{
> > +	const struct kvec *head = xdr->head;
> > +	const struct kvec *tail = xdr->tail;
> > +	unsigned int count = 0;
> > +
> > +	if (head->iov_len) {
> > +		bvec_set_virt(bvec++, head->iov_base, head->iov_len);
> > +		++count;
> > +	}
> > +
> > +	if (xdr->page_len) {
> > +		unsigned int offset, len, remaining;
> > +		struct page **pages = xdr->pages;
> > +
> > +		offset = offset_in_page(xdr->page_base);
> > +		remaining = xdr->page_len;
> > +		while (remaining > 0) {
> > +			len = min_t(unsigned int, remaining,
> > +				    PAGE_SIZE - offset);
> > +			bvec_set_page(bvec++, *pages++, len, offset);
> > +			remaining -= len;
> > +			offset = 0;
> > +			if (unlikely(++count > bvec_size))
> > +				goto bvec_overflow;
> > +		}
> > +	}
> > +
> > +	if (tail->iov_len) {
> > +		bvec_set_virt(bvec, tail->iov_base, tail->iov_len);
> > +		if (unlikely(++count > bvec_size))
> > +			goto bvec_overflow;
> > +	}
> > +
> > +	return count;
> > +
> > +bvec_overflow:
> > +	pr_warn_once("%s: bio_vec array overflow\n", __func__);
> > +	return count - 1;
> > +}
> > +
> >  /**
> >   * xdr_inline_pages - Prepare receive buffer for a large reply
> >   * @xdr: xdr_buf into which reply will be placed
> > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>

-- 
Chuck Lever
