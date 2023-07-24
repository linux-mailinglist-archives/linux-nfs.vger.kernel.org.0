Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18AB75F848
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 15:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjGXN2T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 09:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjGXN2S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 09:28:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A501B1;
        Mon, 24 Jul 2023 06:28:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36O6o6We009823;
        Mon, 24 Jul 2023 13:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=84GDqhJdh/U1H7vTh8DK8BwmENQ0iJjqkaherAXO4aA=;
 b=Su1XJlJflBf07GcmBRF3gYQS7TMQ8K1HEcWlJ6z6H/g2IumcT6JuXYoBwmvyikDkLzaw
 V6rRd/evb7lbaahvvfuTKIoJfWEWK6QbQVJugEduFPRzwVASZFJvEevmkbXg7LHCAkEK
 v0IDomwn0kcD55MmbfCGSD46CHAdT5qmi5WMmjDdsHH3sX+zCMe5+3otkqDtcK5Ns4xF
 KOqAO5d9u73cKqnQUo4lnTldVHDDRvLSEcbXSJzOcTgvGZlTRaoICs/bFFyo1rJhmmw7
 z3QoqjooD9DiG5QcAEAKJffyKiaLck1w36D9t7ld7pX+udfZDnkDQC7MMQMUg6BlTmWg 1w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1tqrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 13:28:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OC49RC028906;
        Mon, 24 Jul 2023 13:28:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j3nt7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jul 2023 13:28:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM0sa9ZVenG1OuyvqQlxQ+qadebvdThVZKGP9r1UVIhagqT8qnUm9lUdha0SSVPOImwS+mS+nCEUbFOVqfNnG1e07xlb/ysvfV9UFwfc4DZ8ZfO8RRaUwzQ3Frn4lx0zqRJR2kN+HGDUm2ETwj0aEXSJfsGEj14IizMwT0S3hAT0XqPQOC3x/VtvPVwo2iFkGZdxq3kNucZ74yhOh9WClw+u/iGrcq+i+iLMQxkG/H17wmeqv5LgGzodAmLfNkixcA02b5uoKZIEH5EQHllFAMhau87bhE4dLVTtt7bnu9+DzUdC2jXXMGVrDfn6S5B+F0aTVPUe+fgpwMe2R8XJjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84GDqhJdh/U1H7vTh8DK8BwmENQ0iJjqkaherAXO4aA=;
 b=FfIn+7KIljScUfXyaqGW2rLOQxItIyrRuyQPwPKBORJROqMbWlnZmOGO1JVAi92uwmEJNjRF2ZWtbn5fBTsDYGsf2i/FUF/EZHZxoa8lGoKvdbvCuZQWeXnvsVKLpRrdQlNon9VDPQofQunIlgH8jsyD+2wa9TqnO1tYKeDERJUW2WxKJmTAsCfw/TPZZokF9ou4rGsiPVITIQ3E/mxkcgh0DOxVzvrQMyAEmd5FhZCx4XP4RIm+4Mh24h1vjVE51Ku6jM28QAMP+ugXGesKwvNRPfXI9NDaPAO74f88hjOj/aH52/2jz33Fp3zT6dmJ5jxYq9VnOj0F56vjztAzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84GDqhJdh/U1H7vTh8DK8BwmENQ0iJjqkaherAXO4aA=;
 b=anhimUQCaWj0HB7t58NRCQG/eGyadA4z5BHSBWPNxoumw0FNGbTjlvKSyA/gJ1jY/QSWdQNx81QakRfzu/bhaS4AAXjeij4VI96yJiqLSVcqQKPPudun+ZyJDG0m5nUPicPi7kS5L4RbLIAVJRSWQ8vDoDc5XiaQY7V1f+JUW6A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7092.namprd10.prod.outlook.com (2603:10b6:8:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 13:27:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:27:59 +0000
Date:   Mon, 24 Jul 2023 09:27:54 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/5] SUNRPC: Send RPC message on TCP with a single
 sock_sendmsg() call
Message-ID: <ZL58WsAxz3Gj/Jlt@tissot.1015granger.net>
References: <168979146971.1905271.4709699930756258041.stgit@morisot.1015granger.net>
 <168979108540.1905271.9720708849149797793.stgit@morisot.1015granger.net>
 <64140.1690192730@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64140.1690192730@warthog.procyon.org.uk>
X-ClientProxiedBy: SJ0PR03CA0344.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::19) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f5aa49-ecb4-4176-d448-08db8c49cc32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QDtmD17/QyG+jNpvHfCVa/xb6qgNdFCyh24/IJFHgXVMLMsGuZAEE0hyjS+TKBv4j68NTod0KNtyMiCy7P+fJ4TRf2qCcwghJ0zQVi1TkYxnYhcSBjXJ5w09Em+kn4Pu9UScBkL4fdqWK8YEd5JCXcGUx7p/FuoU4lRYZdm36gRgxoKAv5b3hGZ7OLGjja4lKGBT+PXKVqVs/E+7kOrnCYYQsnc3a1hbsCgQgt7mz6zbuBVJ8jxVZaSUQRUP/jJRNX3LhJetNyAuIYvT3WUPu0uka/sqFGCTaeHnUHjS0LBJZJZ0JGxKnw0eg7pnJV6XEWv1GE6PpLO1ZQu3Ob4IHUOZPqErjygYWYywc8iUS7P5A61cDRyScJ/6OyjF9ZFgNOWCfhw0/XbUK+s6q2HtU2ZL9jTSOx0N0B/1LQyc/oTAJHtxmMSPHUHrONviAtmQvCocYUApC4pYW/+odWaIOxfzQUvLsfCtOeLrg+kMyulo+TDyODcynPy4hTV48qdLmiGA16r+G3hW7d6PAxFHJXu9BTe1cKXJUGDoTIwllEMymOkQsbAxbiC6PsTI+rJh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(478600001)(6512007)(6486002)(6666004)(6506007)(186003)(26005)(9686003)(4744005)(2906002)(316002)(4326008)(41300700001)(66946007)(66556008)(66476007)(8676002)(6916009)(5660300002)(8936002)(44832011)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kZ+uG2medbvezx3E4RSGvKQXonZkTMKdWwbUdFCWLEl23ApjduKXF1XcNQ1o?=
 =?us-ascii?Q?rWtTwt6aXIKM0My/uCGok9nc7GmTrFEpYnRTdZWmEHSHeTgPeskZTjcHg/fs?=
 =?us-ascii?Q?jpIQYWlkO53CKc/KQrTfDReeED3K27AKpdN/I2W3wIbM6lw5zdESZ9qK3OKL?=
 =?us-ascii?Q?JvXGzgcKPW/Z2eMz4DFoa/pPyT6MItTnWocIChmm4LqZZq7hd16YzNV2oWno?=
 =?us-ascii?Q?anup+lza+qsKUw3E76nAc9SfOvSp19BWrBVvhmjVuAvMoRsbxrnEicymNiWZ?=
 =?us-ascii?Q?cBOwVptAB35wkQtx9WIRcMsm+PSp5O8P2IaINW0KzpIYmkv5Yov8x5jW+9V9?=
 =?us-ascii?Q?4XyeJM3AwOTzky+C5EgfitUa8EkxZ0hgCVV8v3Yl1kZxkhGSyBXDIlcku9rh?=
 =?us-ascii?Q?2POQF/FIk4aB16LCM72ylmzNUFCYTDxzDyaZxG1orCacqlUL99DgrOE5V2ss?=
 =?us-ascii?Q?i+bGKl7ENmlK1wrgSnqZOoBwg/23ulShjlqWirZOOLMiPe/pUa6g48H24IgE?=
 =?us-ascii?Q?FV6JeurEMCMZWILvRMA95TKkW8M3MHkpai5H6SGbPCY5tTzLRo37ab5W8KYF?=
 =?us-ascii?Q?oJ/Kfys0vLe2im1TUFGyz7fTnIk2aP3gS/ms5ON31AMAKJA5YHU5fxEl104U?=
 =?us-ascii?Q?vK17ZbXJDMky5/sLAsoY80Ct7d9aYj3x89bQH5LlfI8NNFYxSILefR5nirT2?=
 =?us-ascii?Q?/qQuja8bqDE+5CefL8yYzsBEarufSBid5Wp0DXcrzNGtou9PKvdlGg8Hecja?=
 =?us-ascii?Q?efBWCy4zzT6BnFcQ/Vsb+RJ8Sr+63b5ae19gzF3w3kh7HkBAcfPGs6EpRdrK?=
 =?us-ascii?Q?QCPbc0YTnyQp4GA1dsd9rhzIcNT9dzRiM+It5NH0RoY9hRvC46gtG5dWzocS?=
 =?us-ascii?Q?TTHIDhxuifEoMBhIZ4IliOxTvY0IQOdOSfSY3Z0NEb7kyqoty7F5kF8tAB3T?=
 =?us-ascii?Q?TOcv6NZI4c3kANkYjgbUR+ZQV9wlK1AJVVo1N7cbMqNLQGFn+l3ushwgZ2+0?=
 =?us-ascii?Q?AvCpqRCDz/2OfKuHN8pbfJp19YTESn1uzY7HoD4EyQqRaKn5dNwY+e75tnhw?=
 =?us-ascii?Q?/u16z12/+KJlc1kwK+tIK9WJB0ArXuHK3sf5Jz7RUoBZ50gPdcqFLLRJJSni?=
 =?us-ascii?Q?FIaj9w7uUx1L2TGKlxSVecnqxG9hw4yYO9t7d/Igp4/Yg3Hsuq9+t/yaE2CC?=
 =?us-ascii?Q?//+oMvs8n3FAEfnXSzz8+24Jp9luY1LNLqsC8Px+Ia+izQcZDPZE9kVJp0CE?=
 =?us-ascii?Q?Q4KpUhmCHuCMDpcq8uUFChLs34TPnoDdPfmpz9FNArhQTqxapNksuo0Nc6wK?=
 =?us-ascii?Q?BpA2SB1qFZAHWcn32m9EzP6ZM354uR1V2jhVo3jX96HrX4xTdpxIfB1tAA/d?=
 =?us-ascii?Q?sJ6RwLMXIOWLc6uPYMwW4gmYYEcJLaB57TOShdDJs1cnU9MyglXbzwFt0TVX?=
 =?us-ascii?Q?IK+2VlPa+jl2a/xfANeMtO9z4nwXOSdvRNNGUnjA56qCpFp9Z+tAS1kgibo2?=
 =?us-ascii?Q?DJKP4lxnAUgqO0k0LNus4z4S9OVJWlFgbm+8yGJ0Ywnr7JAjGAAxTYLRcPTk?=
 =?us-ascii?Q?G9cNzfE3mxaxYbH3n/HPAEEg8Fo1yico0wegXDoM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d0AVUd9nIFjsTPc7IV5PqxY1ZApul7gFdhugrUhmgqj6IBc8FI2G2QCkfGTuloY54sh1rYwSf6DKnpdm3baMkPRQJ/GPC25iX5YFbL2Vxe0qvSjeUIN1E8JlZJRfagNjwD+3cX90E45bJCP5TjwRTK2rNALmTzqtZOcmgW6gPQc3cnq9hsDlhSnI6rjfIe/F1htzMLtDiBfI0Re3TfErVGa597w6/bSYYwIoT8vGhq23l/DtUyS1RcRoBuOYXBi/+w10HVLa2Ka9YnAI72tPXEIUgS9qD1OqE4w1rOQKYnM4Y2UhxJeJFUZlZfwhDxzdJ8vDAhvxbGz91FdzDvixshxK96wXDznr5qzRywKdyv/Ckmhy6ws+phJXGevQVUDoVaAFPMmKnrGKQ+/oYTdtbVVfvKv3vna4XpiCuAz5VQJPWkXJDyadqmBaqgTZXaWqNaBJl5esB7tt0GrISvOeF7thFhAr/RIMRWK6/C9l+23vRZ3HK76NPAzMhQUQbx1hf0ZzxwyrK6H/HnIy7qLRvFmMcLNGsy/YQRg80FtjW8kgWtRqeYdiy3odXDAsqkTndTduSBO1VQ0rVNhUGbdl39DXiruOz+FpsMJ8QFMgk+g4bxF110zyns3Cp0nMKR0GOd9Lju8k1K90Zdtvocy1zWSU3ETaU8OhMXDoc/vzNMhMkS2DpWedXWQ8tXju9WgJV3TprKS+LUdXF6i6x4pHwuL7EGGloTOwEjP9ts2APAStcCX+MHcz2HzINJDjseykUBzj+MHl7MK47IjHkBhPjBP4BKNTjgQSG0cQuffNZgqokyQK73OOIkM2yZPAKM2G
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f5aa49-ecb4-4176-d448-08db8c49cc32
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:27:59.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q7T42GfGPmk/MBPtKBMpMNpNbRxU7jLQaI5z5mybT9EABFt0djivmd+0TsRPUX15tKy1fAtiTWzSZtsCxgn6+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_10,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=622 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240120
X-Proofpoint-GUID: o7X5cBes7QhwehSPFtXuwb9stJptDvXX
X-Proofpoint-ORIG-GUID: o7X5cBes7QhwehSPFtXuwb9stJptDvXX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 24, 2023 at 10:58:50AM +0100, David Howells wrote:
> Chuck Lever <cel@kernel.org> wrote:
> 
> > +	buf = page_frag_alloc(&svsk->sk_frag_cache, sizeof(marker),
> > +			      GFP_KERNEL);
> 
> Is this SMP-safe?  page_frag_alloc() does no locking.

Note that svc_tcp_sendto() takes xprt->xpt_mutex. There can be only
one thread (per svsk) running in svc_tcp_sendmsg() at a time.


-- 
Chuck Lever
