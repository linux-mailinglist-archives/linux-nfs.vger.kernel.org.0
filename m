Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4346578D835
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjH3S3m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244806AbjH3OGk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 10:06:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF0DFC
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 07:06:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9iNOC032341;
        Wed, 30 Aug 2023 14:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=DTEITOqJUV+pKn8lSP3fkYrdZQDewWRgg0hHDFxESJ0=;
 b=EhK/COAkjjw70tLqBQhl6kTf8k0QlNnwPmR+TAmRhTyHzafUvw2kqToLoOQ+hJKOEpOc
 U0K8YzGLqw27GWy2qKPLSnmlg/lGUQMTTtX61+yqfH7d12QvbvwZ5bQPN5o3WjUB1JMg
 wto9Z3o8LDR+oBpuBRzyuPcD9nYDRZh8ztN06A3TYY0aDhGgpWk7r4QqAFAyP4/rHHkT
 2ZYdFGP4kA7GuCuUeafgQoxX3khXspPVocL0WwEgIo/CxWDe8vfbcTrBQRUs6NsVIVst
 nlo5FPYea+ej5aKb0O3adjmTcsDhdr3MEWt9hnBwT27vjRhQ0p3ohJHJngUQvXWqNGu3 rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gcqcj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 14:06:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UDPBaD000488;
        Wed, 30 Aug 2023 14:06:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gcm7kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 14:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmhkqEG7SrbmVyutEaHTBPE1NCWCjfrtzTLwqrP6Jy2+f8U+V4R2sQ2QBIigJjZb8l6JVxhcptInZ9fttNmeAWMNRirJsMpfjifDIzJnN6UI2Vm9+8FUsMYK0vzgAMey7cs9XL62rmCNZIn8NyVhh/iXJh87hcVsjsLlMmpjofIdESs20EXQFXBHsL9XGWI0WDR2nLXrpjrp+Uh0Myqr11suJUKon6lOfmjTME+gZP1jAXLAp3FCEA7WnAZRAHMxSljOoNFo7qVieu5i28t8q8hdlx3ver3JGOCrXTAOJiGnjKT4oB0vAh9Zjw6qiVXYHbAoIjmGnwld5YFokHv4hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DTEITOqJUV+pKn8lSP3fkYrdZQDewWRgg0hHDFxESJ0=;
 b=MSjgwVj4FcoVnITUtgb9D7oT9ikCEDJRmIDUNk+GLZdCcbE2jobGmbKh3l7v5gB/zwhdmNpQI5c8z+3a/WSuNWuKG7e9MhZUtD9Imub4Zshpbjs7uWajRacbTJUHx5M/bAQEk92/yPDXcJ/y045vytem62ynfiGn2RXv47niBFvHuT3DTFA88kJGKIu6p6ZhY8K6oq3H4zoVvRg1Xbx8LKveOkaFJXZSOcLqK3KaoDFNgk3T3LdjEsbRsOhN2Whn44Wilug8P/uPXCFdKqe2v5n2NxqrRQh+dRBish8iSn1Pmno85B/BpjDQ3/MZvVvxWBVKDf4jHGsqPaOspNsaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DTEITOqJUV+pKn8lSP3fkYrdZQDewWRgg0hHDFxESJ0=;
 b=g1K/ji9mKHHD6pUAuF9RdMnFQ8AOvZ/o6MWWJLi7muERHeV++QnzrRqbRxkEeOspwGTwGo/fmkWbLympbh5Tnp7Stflqamoka86jrT17ecK/jLuKDr8JPLkrgtnwFm4CWytCQnurqe6K+MMMnn3HApOFEQdLEXfvFr0tvCc0leA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6563.namprd10.prod.outlook.com (2603:10b6:930:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 14:06:23 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 14:06:22 +0000
Date:   Wed, 30 Aug 2023 10:06:19 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de
Subject: Re: [PATCH v7 3/3] NFSD: add rpc_status netlink support
Message-ID: <ZO9M27f3+KGQ0/TJ@tissot.1015granger.net>
References: <cover.1693400242.git.lorenzo@kernel.org>
 <b750dd468dd3fe4af8febf3a0bf8bc278ca7c05e.1693400242.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b750dd468dd3fe4af8febf3a0bf8bc278ca7c05e.1693400242.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH2PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:610:59::15) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CY8PR10MB6563:EE_
X-MS-Office365-Filtering-Correlation-Id: d5582ce0-522f-4aeb-750a-08dba9624a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBwp3ZvfxY5F+lkyCYnHlazHduhRWaaGblqEsVt9NxVxMjTnhxfV1aVNx2tgxAHFJZp2IXCfIQFVlKEE1O8evtbcsF3o6V+LV8INvzqkJZoi5RCdxc4gPvNeCuYNXB1wq7DzgCCqvZYVduNgaEeUqHCxE3YVhhjeEvGF1t0MLd7HP5My2I5GEk6o8Xs2gExDcNX48UnKPGaAC2L8xQDUtmRxGDUScVxdi1PcVpZDGziQlrewLqgTogLBLbWI/SrhsB6T9cObACjUqwvXQKvuVi0eBcRjUXvJtJYUL3rz9yFxiadF6jf/kJ1gixWd12tqbJOrxJG1zLiS/7BDY7NEIKOZKTd2zkiinIvkmBDcAwPs3zx8ZZYZWUHoSEWJCil3IPV7OdjreNQ8bEoCyS/fPEuPET0QGbpzxZ//ac89BuKzqWD0hmAaLMltbIHjF7/TuZs0nmHOM13gWEqQGBqjgbt2c2mYeWhyLwrJmANYkD4RigKr8Qw78rOLIlPR0KYxbyUy/KB+UHViZM5u54tFno2coflegLqF98mzOESHysnl/gG6UcAoMzQidMi1cEm34PnyrticThaFPC4yoAKJrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(186009)(1800799009)(451199024)(6506007)(6486002)(9686003)(6512007)(6666004)(83380400001)(966005)(26005)(478600001)(30864003)(6916009)(316002)(41300700001)(66556008)(66476007)(66946007)(4326008)(5660300002)(8936002)(2906002)(44832011)(8676002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GSFqTtV63g3tJPdeMFwHsxUo1xIR3axlro6n/3tUTrQ78svHuI1juPDfN1kK?=
 =?us-ascii?Q?alTg9yTW/SARD6DiBoenT0Ju4jTeSejexixj5Lwt6tnDureE4qPZQUPswRM5?=
 =?us-ascii?Q?bdtn2Lpv30yaIfRPH6BhQPFNXW0rREV9QQ1wvzDs9mdoQ6Yu2NF7jOCUMBdc?=
 =?us-ascii?Q?iwxTVsTfDJJQ7VX6iDgefUvBcQCMRYJ5VWKQduu1hcijA4li4fNcWnQ6KS//?=
 =?us-ascii?Q?SDHYSfzGZuW+pGht0bzQxkt4bf2qT8eOlxbBR1xE422m7FQPwuWs4nu1w3z+?=
 =?us-ascii?Q?ZYD0W5qOwEnbxpKfgzi5dnJOyisknr8uLuEv2Qvf3ZjD0mWAxkwFzqsgLPHc?=
 =?us-ascii?Q?pmEj0GcOcPFQfbG1Ei+G5klI1TQztDOzB9yJFQtNi6vBt9e6SWkXu45/o41f?=
 =?us-ascii?Q?Cqbp3B4HtwE08MMNda7+otP++SaOsOPdp+xRWOWQyXuWZzglZba8y/bh19N5?=
 =?us-ascii?Q?c72fGoyBEzCDsHjZQBWk3svmAbzfJkF0fMV76nBVgOyziuw2trA8TOcNBon0?=
 =?us-ascii?Q?otJwcoHT9gwgMM89HaNqev0CLJ6r1+zyRiRRyUhhlvREvaZhWQ53P5jMdG/u?=
 =?us-ascii?Q?8X4fkkePlWGzFPaoI6ytLstnC1udbAqZ7bh8vn+WhfKjBkdrQkXX+d8jlBLv?=
 =?us-ascii?Q?9ciZbarM+vIr+78TTFUdov04sVN0e96yaooszw1MYdCyed03fgNcTIfnCYlD?=
 =?us-ascii?Q?49I5u0LnaZML64g57MSxGJ+LyQftBcY+6Qy99IKQ3PBp938oQBGrnEfTc1L0?=
 =?us-ascii?Q?vaI85RTwpZU0Z0mZuFaoOnOD8AUU40gVp9eI0VJ0KYROCVIvC6BCBq8E5076?=
 =?us-ascii?Q?C17i2YomYNF0mQ5My5G+4VctgYzBIDQ7dpsXapxMNGY2tQWRxnOW7Ww8s/l8?=
 =?us-ascii?Q?eiWj4+egJ5hGoqZgNGlzzIU5cefeyocJagkaITvmL2Vr12mLhl+ji4sVti12?=
 =?us-ascii?Q?4BcdFqpe8Ug51dxfM4SfZ0XtDLxrB3N7Yg8V6kQrYg47N/FFJYSiPjabYJ2g?=
 =?us-ascii?Q?3jZQ1DJIKJnhqk6bKW+Y29b+DNOEjiG+7YlX3lQvLZLVErnt6WqcLAOG9oWP?=
 =?us-ascii?Q?4/4jUiIEQx7EttcCEe8zWBINO5/MCXfPYSKC/uu9PCLOT7VtBZsSKn4lIrqo?=
 =?us-ascii?Q?2ocpby4zei+0gTeQQCsUKLSDL3lRZV5Ud2BPKLIb2P4KhCD95B5oK3tVR5Uv?=
 =?us-ascii?Q?M3BeCn2LYr4zkHzN0k89lvBczYFPpQZDndMhi5sR7hdwx/9EiCWaLzIYC14k?=
 =?us-ascii?Q?AJFRCuSpXUk7BIfZkc34qXRZsX/txEvXuehUUQpisNablp0jRbXMONlHdw0Y?=
 =?us-ascii?Q?2DyFUZrhstrLeUmY0ybZFnYfINdHIZqEugDkZrgBC689RHfU7pTwMnkvBB9x?=
 =?us-ascii?Q?fIEuQVemo6MFvb3maEa3rG4rEbft6ZOA5TZKHVw1PagRJYZKVJWZJfHLBYD9?=
 =?us-ascii?Q?ZO/D/uE8/MuDcF24WOfpBRcyCbUdLkbRb6QhOvxZuBRxler+SpK7FBLSzguV?=
 =?us-ascii?Q?DfBqv9H8wKav6AJQzSIDtDA7fCEOABmN5JXCD4CUsvD6aWSa93EqWD7iBHdw?=
 =?us-ascii?Q?Xs1rbIoH9Vg73W4Dex4qiHaO1Q8vvnAAR5dgun2DtRdp26eJGMQTQWqheUdb?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BvfBOuLs7miPxREZjT+VJEH7Tofy2tGY0r4sV1Au8oklIJRlv4+h0dHd2/qOmcz2Vj0AldPG1BU2Bh5wpvjaW95Yx+MNBCrHgiQhfU1IhcfIDzlpSFBb8tsWAo6XIYOfj9jgjvVgDDvN6+HLfZ3fTnZ3QZP8EXM2v8iPdTvJsAHN8cpMw5ZECeGVLP132yLfSbXC0I2BkUUDfqzVbGP0Bnp76YeK1Utag03gPIITHwLQVxManqkBpzqDMVMQ6UCHjETLDbOq2XB4wRuhKf0rLcgUyPMH1VKw31pV0PCm43mKChQYF4Me7lQQuE2zMG8nstkmebyE62UC43ru5r7nS9yxuZLTNJU/B5YmScsLVoyuLATWC6TJl9IOVbmgYrDXJpOUIpiLqrulBTZlRKBvv85xpSvWsIqt/MW+5pJJDv4KEySlz29gpQuKRTk9SAfvxVw35byLb+SlxE6NxqCE9xVJnkvyfMy1sNOpCRnkjFuKi8Yam6Qb4/+1iv3RcPpr75Zi8eo9P6aK1JtbW31DzmgsXDUh8CA3C5h0Bd1rMsxy3wEMiYDn3BKx54nVarhpnTaZg6P5adFYsABdYp2z6SyTAV+XUA/JLyvT4uLI3PHsPNYzRvzGrv2eFurvs4duNomm/8NmUdUm/tJhbpz42NrRr5aXRkfVqOL9Lt/OUGFaBjEHGmmXJwtzNuWkDRF1ZlC4kwr1Pr7JOCfTrKy/I+cAJpAFef7U0wu61N6xYLJxhoziiyXtDI6QKpNRi+4D/PHOfF732X3tdvCbt6P/afAjLAbQ3FKYsQ1aEAAq9gtCh49SXtw5oPIMIh/sINM46qo3fVhF9RE0wzb7CxQOOA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5582ce0-522f-4aeb-750a-08dba9624a9a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 14:06:22.7911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXJMO5sx2IVuARfC6uJZ8CWKQYUKggO+M7mBcFq/4xUPNOLmzXTDw8QqQWY4EJUc3ETaPUmjLX6nTNSdVdKxww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6563
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300131
X-Proofpoint-ORIG-GUID: 0Vcu9O2wMe24WNJIx8m9eNzrfCo1bi-R
X-Proofpoint-GUID: 0Vcu9O2wMe24WNJIx8m9eNzrfCo1bi-R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 30, 2023 at 03:05:46PM +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status netlink support for NFSD in order to dump pending
> RPC requests debugging information from userspace.

Very good to see this update!

netdev has asked that all new netlink protocols start from a yaml
spec that resides under Documentation/netlink/specs/  That spec is
then used to generate netlink parser code for the kernel and for
user space tooling. You can find this all described here:

https://docs.kernel.org/next/userspace-api/netlink/specs.html

and here is a weak example of how this might be done:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/net/handshake?id=3b3009ea8abb713b022d94fba95ec270cf6e7eae

I say weak because I did that work while the yaml spec tools were
still under development. It might not completely reflect how this
needs to be done today.

So the yaml file would be named something like:

Documentation/netlink/specs/nfsd.yaml

and it would generate files "fs/nfsd/netlink.[ch]". It should
generate a lot of the parser boiler plate you've written below
by hand, so just replace that code with calls to the generated
code.

When you post the next revision of the series, cc: netdev.


> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfsctl.c           | 275 +++++++++++++++++++++++++++++++++++++
>  fs/nfsd/nfsd.h             |  19 +++
>  fs/nfsd/nfssvc.c           |  15 ++
>  fs/nfsd/state.h            |   2 -
>  include/linux/sunrpc/svc.h |   1 +
>  include/uapi/linux/nfs.h   |  54 ++++++++
>  6 files changed, 364 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 33f80d289d63..4626a0002ceb 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -17,6 +17,9 @@
>  #include <linux/sunrpc/rpc_pipe_fs.h>
>  #include <linux/module.h>
>  #include <linux/fsnotify.h>
> +#include <net/genetlink.h>
> +#include <net/ip.h>
> +#include <net/ipv6.h>
>  
>  #include "idmap.h"
>  #include "nfsd.h"
> @@ -1495,6 +1498,273 @@ static int create_proc_exports_entry(void)
>  
>  unsigned int nfsd_net_id;
>  
> +/* the netlink family */
> +static struct genl_family nfsd_genl;
> +
> +static const struct nla_policy
> +nfsd_rpc_status_compound_policy[NFS_ATTR_RPC_STATUS_COMPOUND_MAX + 1] = {
> +	[NFS_ATTR_RPC_STATUS_COMPOUND_OP] = { .type = NLA_STRING },
> +};
> +
> +static const struct nla_policy
> +nfsd_rpc_status_policy[NFS_ATTR_RPC_STATUS_MAX + 1] = {
> +	[NFS_ATTR_RPC_STATUS_XID] = { .type = NLA_U32 },
> +	[NFS_ATTR_RPC_STATUS_FLAGS] = { .type = NLA_U32 },
> +	[NFS_ATTR_RPC_STATUS_PC_NAME] = { .type = NLA_STRING },
> +	[NFS_ATTR_RPC_STATUS_VERSION] = { .type = NLA_U8 },
> +	[NFS_ATTR_RPC_STATUS_STIME] = { .type = NLA_S64 },
> +	[NFS_ATTR_RPC_STATUS_SADDR4] = { .len = sizeof_field(struct iphdr, saddr) },
> +	[NFS_ATTR_RPC_STATUS_DADDR4] = { .len = sizeof_field(struct iphdr, daddr) },
> +	[NFS_ATTR_RPC_STATUS_SADDR6] = { .len = sizeof_field(struct ipv6hdr, saddr) },
> +	[NFS_ATTR_RPC_STATUS_DADDR6] = { .len = sizeof_field(struct ipv6hdr, daddr) },
> +	[NFS_ATTR_RPC_STATUS_SPORT] = { .type = NLA_U16 },
> +	[NFS_ATTR_RPC_STATUS_DPORT] = { .type = NLA_U16 },
> +	[NFS_ATTR_RPC_STATUS_COMPOUND] =
> +		NLA_POLICY_NESTED_ARRAY(nfsd_rpc_status_compound_policy),
> +};
> +
> +static const struct nla_policy
> +nfsd_genl_policy[NFS_ATTR_MAX + 1] = {
> +	[NFS_ATTR_RPC_STATUS] = NLA_POLICY_NESTED_ARRAY(nfsd_rpc_status_policy),
> +};
> +
> +static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb, int index,
> +					    struct nfsd_genl_rqstp *rqstp)
> +{
> +	struct nlattr *rq_attr, *comp_attr;
> +	int i;
> +
> +	rq_attr = nla_nest_start(skb, index);
> +	if (!rq_attr)
> +		return -ENOBUFS;
> +
> +	if (nla_put_be32(skb, NFS_ATTR_RPC_STATUS_XID, rqstp->rq_xid) ||
> +	    nla_put_u32(skb, NFS_ATTR_RPC_STATUS_FLAGS, rqstp->rq_flags) ||
> +	    nla_put_string(skb, NFS_ATTR_RPC_STATUS_PC_NAME, rqstp->pc_name) ||
> +	    nla_put_u8(skb, NFS_ATTR_RPC_STATUS_VERSION, rqstp->rq_vers) ||
> +	    nla_put_s64(skb, NFS_ATTR_RPC_STATUS_STIME,
> +			ktime_to_us(rqstp->rq_stime), NFS_ATTR_RPC_STATUS_PAD))
> +		return -ENOBUFS;
> +
> +	switch (rqstp->saddr.sa_family) {
> +	case AF_INET: {
> +		const struct sockaddr_in *s_in, *d_in;
> +
> +		s_in = (const struct sockaddr_in *)&rqstp->saddr;
> +		d_in = (const struct sockaddr_in *)&rqstp->daddr;
> +		if (nla_put_in_addr(skb, NFS_ATTR_RPC_STATUS_SADDR4,
> +				    s_in->sin_addr.s_addr) ||
> +		    nla_put_in_addr(skb, NFS_ATTR_RPC_STATUS_DADDR4,
> +				    d_in->sin_addr.s_addr) ||
> +		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_SPORT,
> +				 s_in->sin_port) ||
> +		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_DPORT,
> +				 d_in->sin_port))
> +			return -ENOBUFS;
> +		break;
> +	}
> +	case AF_INET6: {
> +		const struct sockaddr_in6 *s_in, *d_in;
> +
> +		s_in = (const struct sockaddr_in6 *)&rqstp->saddr;
> +		d_in = (const struct sockaddr_in6 *)&rqstp->daddr;
> +		if (nla_put_in6_addr(skb, NFS_ATTR_RPC_STATUS_SADDR6,
> +				     &s_in->sin6_addr) ||
> +		    nla_put_in6_addr(skb, NFS_ATTR_RPC_STATUS_DADDR6,
> +				     &d_in->sin6_addr) ||
> +		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_SPORT,
> +				 s_in->sin6_port) ||
> +		    nla_put_be16(skb, NFS_ATTR_RPC_STATUS_DPORT,
> +				 d_in->sin6_port))
> +			return -ENOBUFS;
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	comp_attr = nla_nest_start(skb, NFS_ATTR_RPC_STATUS_COMPOUND);
> +	if (!comp_attr)
> +		return -ENOBUFS;
> +
> +	for (i = 0; i < rqstp->opcnt; i++) {
> +		struct nlattr *op_attr;
> +
> +		op_attr = nla_nest_start(skb, i);
> +		if (!op_attr)
> +			return -ENOBUFS;
> +
> +		if (nla_put_string(skb, NFS_ATTR_RPC_STATUS_COMPOUND_OP,
> +				   nfsd4_op_name(rqstp->opnum[i])))
> +			return -ENOBUFS;
> +
> +		nla_nest_end(skb, op_attr);
> +	}
> +
> +	nla_nest_end(skb, comp_attr);
> +	nla_nest_end(skb, rq_attr);
> +
> +	return 0;
> +}
> +
> +static int nfsd_genl_get_rpc_status(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
> +	struct nlattr *rpc_attr;
> +	int i, rqstp_index = 0;
> +	struct sk_buff *msg;
> +	void *hdr;
> +
> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_put(msg, info->snd_portid, info->snd_seq, &nfsd_genl,
> +			  0, NFS_CMD_NEW_RPC_STATUS);
> +	if (!hdr) {
> +		nlmsg_free(msg);
> +		return -ENOBUFS;
> +	}
> +
> +	rpc_attr = nla_nest_start(msg, NFS_ATTR_RPC_STATUS);
> +	if (!rpc_attr)
> +		goto nla_put_failure;
> +
> +	rcu_read_lock();
> +
> +	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +		struct svc_rqst *rqstp;
> +
> +		list_for_each_entry_rcu(rqstp,
> +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> +				rq_all) {
> +			struct nfsd_genl_rqstp genl_rqstp;
> +			unsigned int status_counter;
> +
> +			/*
> +			 * Acquire rq_status_counter before parsing the rqst
> +			 * fields. rq_status_counter is set to an odd value in
> +			 * order to notify the consumers the rqstp fields are
> +			 * meaningful.
> +			 */
> +			status_counter =
> +				smp_load_acquire(&rqstp->rq_status_counter);
> +			if (!(status_counter & 1))
> +				continue;
> +
> +			genl_rqstp.rq_xid = rqstp->rq_xid;
> +			genl_rqstp.rq_flags = rqstp->rq_flags;
> +			genl_rqstp.rq_vers = rqstp->rq_vers;
> +			genl_rqstp.pc_name = svc_proc_name(rqstp);
> +			genl_rqstp.rq_stime = rqstp->rq_stime;
> +			genl_rqstp.opcnt = 0;
> +			memcpy(&genl_rqstp.daddr, svc_daddr(rqstp),
> +			       sizeof(struct sockaddr));
> +			memcpy(&genl_rqstp.saddr, svc_addr(rqstp),
> +			       sizeof(struct sockaddr));
> +
> +#ifdef CONFIG_NFSD_V4
> +			if (rqstp->rq_vers == NFS4_VERSION &&
> +			    rqstp->rq_proc == NFSPROC4_COMPOUND) {
> +				/* NFSv4 compund */
> +				struct nfsd4_compoundargs *args;
> +				int j;
> +
> +				args = rqstp->rq_argp;
> +				genl_rqstp.opcnt = args->opcnt;
> +				for (j = 0; j < genl_rqstp.opcnt; j++)
> +					genl_rqstp.opnum[j] =
> +						args->ops[j].opnum;
> +			}
> +#endif /* CONFIG_NFSD_V4 */
> +
> +			/*
> +			 * Acquire rq_status_counter before reporting the rqst
> +			 * fields to the user.
> +			 */
> +			if (smp_load_acquire(&rqstp->rq_status_counter) !=
> +			    status_counter)
> +				continue;
> +
> +			if (nfsd_genl_rpc_status_compose_msg(msg,
> +							     rqstp_index++,
> +							     &genl_rqstp))
> +				goto nla_put_failure_rcu;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +
> +	nla_nest_end(msg, rpc_attr);
> +	genlmsg_end(msg, hdr);
> +
> +	return genlmsg_reply(msg, info);
> +
> +nla_put_failure_rcu:
> +	rcu_read_unlock();
> +nla_put_failure:
> +	genlmsg_cancel(msg, hdr);
> +	nlmsg_free(msg);
> +
> +	return -EMSGSIZE;
> +}
> +
> +static int nfsd_genl_pre_doit(const struct genl_split_ops *ops,
> +			      struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct nfsd_net *nn = net_generic(genl_info_net(info), nfsd_net_id);
> +
> +	if (ops->internal_flags & NFSD_FLAG_NEED_REF_COUNT) {
> +		int ret = -ENODEV;
> +
> +		mutex_lock(&nfsd_mutex);
> +		if (nn->nfsd_serv) {
> +			svc_get(nn->nfsd_serv);
> +			ret = 0;
> +		}
> +		mutex_unlock(&nfsd_mutex);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void nfsd_genl_post_doit(const struct genl_split_ops *ops,
> +				struct sk_buff *skb, struct genl_info *info)
> +{
> +	if (ops->internal_flags & NFSD_FLAG_NEED_REF_COUNT) {
> +		mutex_lock(&nfsd_mutex);
> +		nfsd_put(genl_info_net(info));
> +		mutex_unlock(&nfsd_mutex);
> +	}
> +}
> +
> +static struct genl_small_ops nfsd_genl_ops[] = {
> +	{
> +		.cmd = NFS_CMD_GET_RPC_STATUS,
> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +		.doit = nfsd_genl_get_rpc_status,
> +		.internal_flags = NFSD_FLAG_NEED_REF_COUNT,
> +	},
> +};
> +
> +static struct genl_family nfsd_genl __ro_after_init = {
> +	.name = "nfsd_server",
> +	.version = 1,
> +	.maxattr = NFS_ATTR_MAX,
> +	.module = THIS_MODULE,
> +	.netnsok = true,
> +	.parallel_ops = true,
> +	.hdrsize = 0,
> +	.pre_doit = nfsd_genl_pre_doit,
> +	.post_doit = nfsd_genl_post_doit,
> +	.policy = nfsd_genl_policy,
> +	.small_ops = nfsd_genl_ops,
> +	.n_small_ops = ARRAY_SIZE(nfsd_genl_ops),
> +	.resv_start_op = NFS_CMD_NEW_RPC_STATUS + 1,
> +};
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> @@ -1589,6 +1859,10 @@ static int __init init_nfsd(void)
>  	retval = register_filesystem(&nfsd_fs_type);
>  	if (retval)
>  		goto out_free_all;
> +	retval = genl_register_family(&nfsd_genl);
> +	if (retval)
> +		goto out_free_all;
> +
>  	return 0;
>  out_free_all:
>  	nfsd4_destroy_laundry_wq();
> @@ -1613,6 +1887,7 @@ static int __init init_nfsd(void)
>  
>  static void __exit exit_nfsd(void)
>  {
> +	genl_unregister_family(&nfsd_genl);
>  	unregister_filesystem(&nfsd_fs_type);
>  	nfsd4_destroy_laundry_wq();
>  	unregister_cld_notifier();
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index e95c3322eb9b..749c871b3291 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -62,6 +62,25 @@ struct readdir_cd {
>  	__be32			err;	/* 0, nfserr, or nfserr_eof */
>  };
>  
> +enum nfsd_genl_internal_flag {
> +	NFSD_FLAG_NEED_REF_COUNT = BIT(0),
> +};
> +
> +/* Maximum number of operations per session compound */
> +#define NFSD_MAX_OPS_PER_COMPOUND	50
> +
> +struct nfsd_genl_rqstp {
> +	struct sockaddr daddr;
> +	struct sockaddr saddr;
> +	unsigned long rq_flags;
> +	const char *pc_name;
> +	ktime_t rq_stime;
> +	__be32 rq_xid;
> +	u32 rq_vers;
> +	/* NFSv4 compund */
> +	u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> +	u16 opcnt;
> +};
>  
>  extern struct svc_program	nfsd_program;
>  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 1582af33e204..fad34a7325b3 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -998,6 +998,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
>  		goto out_decode_err;
>  
> +	/*
> +	 * Release rq_status_counter setting it to an odd value after the rpc
> +	 * request has been properly parsed. rq_status_counter is used to
> +	 * notify the consumers if the rqstp fields are stable
> +	 * (rq_status_counter is odd) or not meaningful (rq_status_counter
> +	 * is even).
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter | 1);
> +
>  	rp = NULL;
>  	switch (nfsd_cache_lookup(rqstp, &rp)) {
>  	case RC_DOIT:
> @@ -1015,6 +1024,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>  		goto out_encode_err;
>  
> +	/*
> +	 * Release rq_status_counter setting it to an even value after the rpc
> +	 * request has been properly processed.
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter + 1);
> +
>  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
>  out_cached_reply:
>  	return 1;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index cbddcf484dba..41bdc913fa71 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -174,8 +174,6 @@ static inline struct nfs4_delegation *delegstateid(struct nfs4_stid *s)
>  
>  /* Maximum number of slots per session. 160 is useful for long haul TCP */
>  #define NFSD_MAX_SLOTS_PER_SESSION     160
> -/* Maximum number of operations per session compound */
> -#define NFSD_MAX_OPS_PER_COMPOUND	50
>  /* Maximum  session per slot cache size */
>  #define NFSD_SLOT_CACHE_SIZE		2048
>  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index dbf5b21feafe..caa20defd255 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -251,6 +251,7 @@ struct svc_rqst {
>  						 * net namespace
>  						 */
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	unsigned int		rq_status_counter; /* RPC processing counter */
>  };
>  
>  /* bits for rq_flags */
> diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
> index 946cb62d64b0..86a5daaaf9d9 100644
> --- a/include/uapi/linux/nfs.h
> +++ b/include/uapi/linux/nfs.h
> @@ -132,4 +132,58 @@ enum nfs_ftype {
>  	NFFIFO = 8
>  };
>  
> +enum nfs_commands {
> +	NFS_CMD_UNSPEC,
> +
> +	NFS_CMD_GET_RPC_STATUS,
> +	NFS_CMD_NEW_RPC_STATUS,
> +
> +	/* add new commands above here */
> +
> +	__NFS_CMD_MAX,
> +	NFS_CMD_MAX = __NFS_CMD_MAX - 1,
> +};
> +
> +enum nfs_rcp_status_compound_attrs {
> +	__NFS_ATTR_RPC_STATUS_COMPOUND_UNSPEC,
> +	NFS_ATTR_RPC_STATUS_COMPOUND_OP,
> +
> +	/* keep it last */
> +	NUM_NFS_ATTR_RPC_STATUS_COMPOUND,
> +	NFS_ATTR_RPC_STATUS_COMPOUND_MAX = NUM_NFS_ATTR_RPC_STATUS_COMPOUND - 1,
> +};
> +
> +enum nfs_rpc_status_attrs {
> +	__NFS_ATTR_RPC_STATUS_UNSPEC,
> +
> +	NFS_ATTR_RPC_STATUS_XID,
> +	NFS_ATTR_RPC_STATUS_FLAGS,
> +	NFS_ATTR_RPC_STATUS_PC_NAME,
> +	NFS_ATTR_RPC_STATUS_VERSION,
> +	NFS_ATTR_RPC_STATUS_STIME,
> +	NFS_ATTR_RPC_STATUS_SADDR4,
> +	NFS_ATTR_RPC_STATUS_DADDR4,
> +	NFS_ATTR_RPC_STATUS_SADDR6,
> +	NFS_ATTR_RPC_STATUS_DADDR6,
> +	NFS_ATTR_RPC_STATUS_SPORT,
> +	NFS_ATTR_RPC_STATUS_DPORT,
> +	NFS_ATTR_RPC_STATUS_PAD,
> +	NFS_ATTR_RPC_STATUS_COMPOUND,
> +
> +	/* keep it last */
> +	NUM_NFS_ATTR_RPC_STATUS,
> +	NFS_ATTR_RPC_STATUS_MAX = NUM_NFS_ATTR_RPC_STATUS - 1,
> +};
> +
> +enum nfs_attrs {
> +	NFS_ATTR_UNSPEC,
> +
> +	NFS_ATTR_RPC_STATUS,
> +
> +	/* add new attributes above here */
> +
> +	__NFS_ATTR_MAX,
> +	NFS_ATTR_MAX = __NFS_ATTR_MAX - 1
> +};
> +
>  #endif /* _UAPI_LINUX_NFS_H */
> -- 
> 2.41.0
> 

-- 
Chuck Lever
