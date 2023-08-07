Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6786772718
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Aug 2023 16:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjHGOJs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Aug 2023 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjHGOJr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Aug 2023 10:09:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E096983
        for <linux-nfs@vger.kernel.org>; Mon,  7 Aug 2023 07:09:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377BQxdx025621;
        Mon, 7 Aug 2023 14:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=EnitpzbwOjB9a3uSEFp/vFIvnoQSGmfgWuOnB7rwjzI=;
 b=E+k9jJvkYZ1WdoyNVo9eNn/9L8FKUmQOLSW3Q38olu31WF6N8yToIrQr7gIkYitvZght
 p+WF7bviqlppHo8nNoEvXhxOp0toTBppC06cdBMIISlp/LsAhOJygeobETW/9VApM3rq
 rs3Zm0lu4uJ6OP5xYA8pwbuU5avp7WQ57+pMprzA0Gqr8IfpNbpRn5afy77PsdrnZjJ9
 rm8se58HkRfJ7aMg2qklxuXsml+KRsZtV7q0AM3zDYixDv09gXE3Ym+OzSOAnwMRYFba
 Ssb/7y27OJJT7ciNW3YgcqsjZPYFViRCA9oo3Vl+IoxTHOshw3eTS3405DYQa9RlKQTT 1A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eaajt7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 14:09:35 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 377DcMc7021400;
        Mon, 7 Aug 2023 14:09:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvb48hw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 14:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXaySiUoJ7biwrilXsjJakm4TnM49NBQp1XE+LEbDS69y13tJzv7z56djemRKObk36FwKdDM1FCxPd2wIqNYE+QRWQnsrYuoEKIZJS1pD6VjAwRdVC5ta/+qdQPK4sRRkmB/NOJ+5BzAlZea6idjGk0Wf3dse+5DrvxkPDS3CagyJ4JfSE4XrpTZ5b5psFjPb94JL1s416Vqz8pw3WHx+iRNI6lmb+JM58xTbDdv+DJM54ahwCrWbT4BNg0Vz8DJ8jYWsPzA8r1cX5JumKViUQxgfvBkS7VMC4fgTR1CbhIhQQlbtIimeNzuBK/a/fXx42bCuQzXvEnsl+k8WdqI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnitpzbwOjB9a3uSEFp/vFIvnoQSGmfgWuOnB7rwjzI=;
 b=VsvIwPx8kbveXAUKj9vdd0Sn84W4pfIkGeLlgu6dQrLDVE8kRA2boRCqIcX6hTEnkAQLQfytEd6cEJONfXUIwZPd/fRfYF3AlEmcnfR6KJ0+gfME6rKr8nynI5j4R5vlBjzGH9rvWY4C9kuiMwagKaFMXXDdT1w15aklH9nBO1mao3gd/UxqqNsk+8bGHOcHFSzNPH2jln7WT75iXonIId5FLuvrUTVJiAz9OspeI0rrCzp3uTcGnYA5UrGdrnXl7aako9ys/wWe1n3TyfMn+KDbov0hqhQsYCI5OnuJnI+Ivp7kygtuMpPhkHUKDynKEHAjcIKyB3uWZA6u0e3mfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnitpzbwOjB9a3uSEFp/vFIvnoQSGmfgWuOnB7rwjzI=;
 b=PtdP0KHnuuKizVUOOL+pWAJDDrXEcKY/ka1wgk8lIGeV6VxZoOYaURt97/BM4B7JUsGrXGcIpcoJuPLMIQqSFU3am3y5IX99e/J5dKcwbzsZs4zTtFqp2zaZGm8c+ucAMqip6ZysVNstOZLGUgtjS0yOTIwH1envsIykq9Zk2Cg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 14:09:32 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 14:09:32 +0000
Date:   Mon, 7 Aug 2023 10:09:23 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>, trondmy@hammerspace.com, anna@kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 3/6] SUNRPC: integrate back-channel processing with
 svc_recv()
Message-ID: <ZND7E31GZjpX/DME@tissot.1015granger.net>
References: <20230802073443.17965-1-neilb@suse.de>
 <20230802073443.17965-4-neilb@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802073443.17965-4-neilb@suse.de>
X-ClientProxiedBy: CH2PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:610:38::27) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a1de00-4804-47af-ad85-08db974fec36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrS69PsmDZf6JPUSu87C2nl9FjB5g+cwJ0q5bsyyalqOHmb5Gecj58YPXxUaX6pqjCnwd36HvbZNtd12e4lQajjfi1/Gd83g6f7xf+Uml5iAeLQfuR0KqYq4oH7saYuM0ejuLpDV7COGE7xkS23/NUcEjRlK4k7E5H60ee4jseVGyMBAYP5g2B1Hv39xZIgG3k8yZodqjiMLZJtuzSlwJtvG8XW+nvoupO5qF82McUw+YzKOkYh5pNIhhNabTl8IG69prFxMJ6ucHsZ/CcWKjMoqduL/LNPi0ZgAmVgwUVqs8rVzUpE33UHQJwvlOEH+pq5cD+hKEwWE9gxq4Na73chl/vVmDDNIL11EjJVKyZDJAyVq8v6UuPA3kCX86Bja9xNccpZcRmW16Ql0C624kfiwLjR0B2+sOxkEddr7Va0V6g8y5YUFyRxJr4OhMvnFNQtTA/TURvM4bDa5n3nH9vqo4XD0+t+ACX39Lk/vv8qhgxcGWabIb8Crbi+mXIpo6Xm1blzpi9DtXn0cJd35YKGc6tmqrpK/Ts22GusgDEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(376002)(136003)(346002)(186006)(1800799003)(451199021)(478600001)(83380400001)(6486002)(6512007)(9686003)(966005)(26005)(6506007)(41300700001)(66946007)(66556008)(66476007)(8936002)(8676002)(316002)(4326008)(2906002)(6666004)(38100700002)(44832011)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DyzZi4SvdcB6SmZCs1oZgC6RDwuvQzYDkDpwy0yRcXC4BsNuUik2W/1p70Pr?=
 =?us-ascii?Q?7clzS03vyNdx+25LkORAGxELDOdI4hHW1CnUbOeUPJTwLOqSXv+R64Y4+ji+?=
 =?us-ascii?Q?aU9bDNVWxgaa4Jv2yTzaD9Wiv9ZrYGuhAsUiDS9/1e9Sa0F33Gwf9PdOeOa4?=
 =?us-ascii?Q?hIIrhkZr2Ooam8Ars7gJ1JpGFrPJACtw5e5JsWnpTEuqPH5R0/77nwHCweEM?=
 =?us-ascii?Q?n3CXn4JrvF8B/w4aua7wFkRckh+NpRu5vJt8BBYxDUESJk1lPkoLIBBMU2nG?=
 =?us-ascii?Q?FYzM3n3HnnBsE7CVAn+/YvqFd0dC/AQPcTwG/8y2AIgBSezL93Sgrso0gDhX?=
 =?us-ascii?Q?hVBeJ6erfVo2oWcf1Eyfv7DvyKd4MfSRsLjn1clrI7xDI4a19F3gGNTpfC7X?=
 =?us-ascii?Q?opVjAo+sVZpy00fXYSh/Wr5a/KTBoH/8x4QGIJ1pW3AUWZj7zaaDPuVfaAPB?=
 =?us-ascii?Q?vbciAYhezmG+K+HceuxKRfkrVq+sMM8/mZA8jdjxkLHhSPQIqi/nRzt+7JyQ?=
 =?us-ascii?Q?jsC3gSa22xwm1u/gqdpOZWAFnkZynyNfv+k212p2g0C4udY0eWbD0vlTEu2B?=
 =?us-ascii?Q?sGcpyeERNwso8x7sW1D/HuHdSZN7Lvy1HGWyGT/iC/LklNbbcfHvecFyWHF9?=
 =?us-ascii?Q?+8suVCs33msE28M51dqCp47GyFnBVdc05wfNvz1UrVLObmR9yj21c0buJYAZ?=
 =?us-ascii?Q?UyZIAdvO9yrClWr2V8HBUl78sSEdiqIFcFj+bHU/lEYSTgFBE3bdGTkB5jWN?=
 =?us-ascii?Q?G3ifsa6JWeuw+yrlDxkqikvIWzb9gXP7aK99U1Em/vcj3t+OFI65EwMsGHO4?=
 =?us-ascii?Q?RKPZUD4SftdeYQ4Qka9N6MVWFwDdMhke4H5Ooz9b88eGiUcGbj1EDcG/c4Xe?=
 =?us-ascii?Q?Pz+SG2KrDNU/NVogSzMIFsbS/P31MhBpKkEainJtr+bf2mZ4nGlgJxr3YhN+?=
 =?us-ascii?Q?QWTLYBLU3kji0ki4DEl66krTI7KyLy/viH0vC9aEqdsHJ0wfN2myLziGVCIT?=
 =?us-ascii?Q?6TtGtl8CpiI1gPdjs6+CCAGR/xqJrIUvU/sDYJNavVxLfyJjEm/GkXqGN4kS?=
 =?us-ascii?Q?BpgpgD25RwoskX3GuTo4hThE79zKP7i3FA89KoujRYbdIKzZ5pIyzHy1Sxt0?=
 =?us-ascii?Q?/dsUpRtJydad/89rIiFeLn+5HdwGLMW3qGIh5P53c4pshcJyPl4+fykpXIP8?=
 =?us-ascii?Q?y9WXgelmJBgBa3Q9EnsOus7xajB7OYat2MPIRF1ZEE5KBZtenp3734yTsm2L?=
 =?us-ascii?Q?FiIeFDY/cW1boZUy9eQoSJB/ZItaB4d6NRC33Qq+S7dUTFWTXEV1JnWLvAUP?=
 =?us-ascii?Q?rgPQrVf0byOOg9yzXPZcdZdx2PjWt1GrIG4w+y4XT3SQKffT1h/hoJPTphlA?=
 =?us-ascii?Q?6GmI6r/geQV/tvb4Uv6D4ao6fetDH2Tg++zjcLyPdV1xqdLbfVkmwxC6YDkD?=
 =?us-ascii?Q?rdnDkY9405YxV306C3ObILqd6mt1kS54uwZLpK4UpOhm9vHUncfSBQiNWm9J?=
 =?us-ascii?Q?fKvt/tMLsgNT4WNp+kMu7CEvg/JSJTdgvKq+ajsHCssR16683MzMsQ/XKZ1i?=
 =?us-ascii?Q?fk/WolKHv0hUMDG59gPVn13yE79lM9VQWDD5BF64sQimCCl4odP5zjT78flD?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CDkqkMxj1nH6BH/iAH4ZRaZ5VN3KA9jPtQmvRpQtBKXwle9mzPhgKJrLtCiy1LCSOp7yCdf3wLaohw9zGFtXIPxsCUa4gE69WyoxKU1sMwc+rDUYeyUJ/i/g+cxoZuwdVRj1BsPzyWamHfXPU8uyjbYA2cpUzOjmYZ8J1dsaw6Viaw4/IVRa0cxOf1MFOfgErOFeK3OiVDdB2nPwdwtkQexYBSMB0L4ecJF0ZdR4NGyCNi2yCg56UYaeiwwkKgKWxsQsLO6ge/aIRKhcbw4VQRP06zXa0/5IZtDotJgkTStlj44zQXebeERfJi3yy+LtZ42eo8/HK4ifn6cUDUr2+AWmemaNSfqcbEa0lMRiExmfla2SPtHj6OPy6EmI2xQI1U/k8qs72V2jIxpSfP1cZLFoI9qjth4ToOjqwLH3+A0ePj9ZvmlAJdQpKCUqiG9xbe9qlqD+7EcrCWg6YxeCryUOMaYbY32Ky+S/eMExTkEfMLRTM+BK92bXltJAQ4wwKAH0AuM/6mHkw00FrvCRBW3j42T6ZsOvMdlxCtGY5hhK9/SvFnDsd0BUA7V+lITL0FEjR7BDVsufPk5AWEI6Q0LRsgYOWL28zdAaa+Rayer5/JuayG8BFMTOKOxlkVcfVQgBBSGiDwq1ojoyQ6oBrTpMj4WHaaIoBZyqnVfzgII60wDN99sKC6HA+Sh/pYV1lj/HpTxa+FL5wXY597PqJeXpnFlEEOy10tcgMrUPBuR1LbYI3RThCTeApffv8bBF7t/uXm90BzenB0DKzwr3DQHo3q6suIukFG4oe+5+1WABSKrfNymW5MNxF0qzH8r9m2txzH5bOoXs2S8uaSCbJmMWHa7cTHUtzzo/0AHn/wI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a1de00-4804-47af-ad85-08db974fec36
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 14:09:32.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oCgXbI4AsjYORyDLM3sxV+yXXUOhlxuUUeOBbQ2Zh0RGJgw+aau1HyVY73vlMrDTLFIR+vljkw8PrE1N5mv+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070131
X-Proofpoint-ORIG-GUID: 0O_X8lUzkF_ELuGLxamoKB8R3b2FcMnL
X-Proofpoint-GUID: 0O_X8lUzkF_ELuGLxamoKB8R3b2FcMnL
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 02, 2023 at 05:34:40PM +1000, NeilBrown wrote:
> Using svc_recv() for (NFSv4.1) back-channel handling means we have just
> one mechanism for waking threads.
> 
> Also change kthread_freezable_should_stop() in nfs4_callback_svc() to
> kthread_should_stop() as used elsewhere.
> kthread_freezable_should_stop() effectively adds a try_to_freeze() call,
> and svc_recv() already contains that at an appropriate place.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>

This one needs review and ack from the client maintainers.

Anna/Trond, if you haven't been following along, we're working on
updating the server-side thread scheduler. This patch replaces the
ad hoc scheduler in the client's NFSv4 callback service so that all
kernel RPC services utilize the same thread scheduling mechanism.

The whole series so far appears in the topic-sunrpc-thread-scheduling
branch in the public nfsd repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
>  fs/nfs/callback.c                 | 46 ++-----------------------------
>  include/linux/sunrpc/svc.h        |  2 --
>  net/sunrpc/backchannel_rqst.c     |  8 ++----
>  net/sunrpc/svc.c                  |  2 +-
>  net/sunrpc/svc_xprt.c             | 32 +++++++++++++++++++++
>  net/sunrpc/xprtrdma/backchannel.c |  2 +-
>  6 files changed, 39 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 466ebf1d41b2..42a0c2f1e785 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -78,7 +78,7 @@ nfs4_callback_svc(void *vrqstp)
>  
>  	set_freezable();
>  
> -	while (!kthread_freezable_should_stop(NULL))
> +	while (!kthread_should_stop())
>  		svc_recv(rqstp);
>  
>  	svc_exit_thread(rqstp);
> @@ -86,45 +86,6 @@ nfs4_callback_svc(void *vrqstp)
>  }
>  
>  #if defined(CONFIG_NFS_V4_1)
> -/*
> - * The callback service for NFSv4.1 callbacks
> - */
> -static int
> -nfs41_callback_svc(void *vrqstp)
> -{
> -	struct svc_rqst *rqstp = vrqstp;
> -	struct svc_serv *serv = rqstp->rq_server;
> -	struct rpc_rqst *req;
> -	int error;
> -	DEFINE_WAIT(wq);
> -
> -	set_freezable();
> -
> -	while (!kthread_freezable_should_stop(NULL)) {
> -		prepare_to_wait(&serv->sv_cb_waitq, &wq, TASK_IDLE);
> -		spin_lock_bh(&serv->sv_cb_lock);
> -		if (!list_empty(&serv->sv_cb_list)) {
> -			req = list_first_entry(&serv->sv_cb_list,
> -					struct rpc_rqst, rq_bc_list);
> -			list_del(&req->rq_bc_list);
> -			spin_unlock_bh(&serv->sv_cb_lock);
> -			finish_wait(&serv->sv_cb_waitq, &wq);
> -			dprintk("Invoking bc_svc_process()\n");
> -			error = bc_svc_process(serv, req, rqstp);
> -			dprintk("bc_svc_process() returned w/ error code= %d\n",
> -				error);
> -		} else {
> -			spin_unlock_bh(&serv->sv_cb_lock);
> -			if (!kthread_should_stop())
> -				schedule();
> -			finish_wait(&serv->sv_cb_waitq, &wq);
> -		}
> -	}
> -
> -	svc_exit_thread(rqstp);
> -	return 0;
> -}
> -
>  static inline void nfs_callback_bc_serv(u32 minorversion, struct rpc_xprt *xprt,
>  		struct svc_serv *serv)
>  {
> @@ -237,10 +198,7 @@ static struct svc_serv *nfs_callback_create_svc(int minorversion)
>  			cb_info->users);
>  
>  	threadfn = nfs4_callback_svc;
> -#if defined(CONFIG_NFS_V4_1)
> -	if (minorversion)
> -		threadfn = nfs41_callback_svc;
> -#else
> +#if !defined(CONFIG_NFS_V4_1)
>  	if (minorversion)
>  		return ERR_PTR(-ENOTSUPP);
>  #endif
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index dbf5b21feafe..5e2d3b83999e 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -92,8 +92,6 @@ struct svc_serv {
>  						 * that arrive over the same
>  						 * connection */
>  	spinlock_t		sv_cb_lock;	/* protects the svc_cb_list */
> -	wait_queue_head_t	sv_cb_waitq;	/* sleep here if there are no
> -						 * entries in the svc_cb_list */
>  	bool			sv_bc_enabled;	/* service uses backchannel */
>  #endif /* CONFIG_SUNRPC_BACKCHANNEL */
>  };
> diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
> index 65a6c6429a53..44b7c89a635f 100644
> --- a/net/sunrpc/backchannel_rqst.c
> +++ b/net/sunrpc/backchannel_rqst.c
> @@ -349,10 +349,8 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xid)
>  }
>  
>  /*
> - * Add callback request to callback list.  The callback
> - * service sleeps on the sv_cb_waitq waiting for new
> - * requests.  Wake it up after adding enqueing the
> - * request.
> + * Add callback request to callback list.  Wake a thread
> + * on the first pool (usually the only pool) to handle it.
>   */
>  void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
>  {
> @@ -371,6 +369,6 @@ void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
>  	xprt_get(xprt);
>  	spin_lock(&bc_serv->sv_cb_lock);
>  	list_add(&req->rq_bc_list, &bc_serv->sv_cb_list);
> -	wake_up(&bc_serv->sv_cb_waitq);
>  	spin_unlock(&bc_serv->sv_cb_lock);
> +	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
>  }
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index dc21e6c732db..0c3272f1b3b6 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -440,7 +440,6 @@ __svc_init_bc(struct svc_serv *serv)
>  {
>  	INIT_LIST_HEAD(&serv->sv_cb_list);
>  	spin_lock_init(&serv->sv_cb_lock);
> -	init_waitqueue_head(&serv->sv_cb_waitq);
>  }
>  #else
>  static void
> @@ -718,6 +717,7 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
>  
>  	set_bit(SP_CONGESTED, &pool->sp_flags);
>  }
> +EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
>  
>  static struct svc_pool *
>  svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index f1d64ded89fb..39582ac33cbd 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -17,6 +17,7 @@
>  #include <linux/sunrpc/svc_xprt.h>
>  #include <linux/sunrpc/svcsock.h>
>  #include <linux/sunrpc/xprt.h>
> +#include <linux/sunrpc/bc_xprt.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <trace/events/sunrpc.h>
> @@ -719,6 +720,13 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	if (freezing(current))
>  		return false;
>  
> +#if defined(CONFIG_SUNRPC_BACKCHANNEL)
> +	if (svc_is_backchannel(rqstp)) {
> +		if (!list_empty(&rqstp->rq_server->sv_cb_list))
> +			return false;
> +	}
> +#endif
> +
>  	return true;
>  }
>  
> @@ -867,6 +875,30 @@ void svc_recv(struct svc_rqst *rqstp)
>  		trace_svc_xprt_dequeue(rqstp);
>  		svc_handle_xprt(rqstp, xprt);
>  	}
> +
> +#if defined(CONFIG_SUNRPC_BACKCHANNEL)
> +	if (svc_is_backchannel(rqstp)) {
> +		struct svc_serv *serv = rqstp->rq_server;
> +		struct rpc_rqst *req;
> +
> +		spin_lock_bh(&serv->sv_cb_lock);
> +		req = list_first_entry_or_null(&serv->sv_cb_list,
> +					       struct rpc_rqst, rq_bc_list);
> +		if (req) {
> +			int error;
> +
> +			list_del(&req->rq_bc_list);
> +			spin_unlock_bh(&serv->sv_cb_lock);
> +
> +			dprintk("Invoking bc_svc_process()\n");
> +			error = bc_svc_process(rqstp->rq_server, req, rqstp);
> +			dprintk("bc_svc_process() returned w/ error code= %d\n",
> +				error);
> +			return;
> +		}
> +		spin_unlock_bh(&serv->sv_cb_lock);
> +	}
> +#endif
>  }
>  EXPORT_SYMBOL_GPL(svc_recv);
>  
> diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
> index e4d84a13c566..bfc434ec52a7 100644
> --- a/net/sunrpc/xprtrdma/backchannel.c
> +++ b/net/sunrpc/xprtrdma/backchannel.c
> @@ -267,7 +267,7 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
>  	list_add(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
>  	spin_unlock(&bc_serv->sv_cb_lock);
>  
> -	wake_up(&bc_serv->sv_cb_waitq);
> +	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
>  
>  	r_xprt->rx_stats.bcall_count++;
>  	return;
> -- 
> 2.40.1
> 

-- 
Chuck Lever
