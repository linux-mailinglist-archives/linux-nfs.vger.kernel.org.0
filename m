Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6E775DD18
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Jul 2023 17:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjGVPNw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 22 Jul 2023 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVPNv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 22 Jul 2023 11:13:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA72269D
        for <linux-nfs@vger.kernel.org>; Sat, 22 Jul 2023 08:13:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36M5FErl009846;
        Sat, 22 Jul 2023 15:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=/biw+cEXZqkeHmXFBYzZXnqGxb8YsNrQX2vrNVqKgYg=;
 b=UGtF7QN+CIdHmTuFfWQt0JrblDVmgJm9qIF55kl+vR2HWbm5cVmA7XIMEZ76pMF8t+WM
 xJHojqRBMQ5+/aPk+Q6RgwMCTM82j5tOG8sEtX/prGItcfOAQn9uKxxM4Fdf37v+Lu+4
 cguBv86n/A7TTFKGtA9xa89ElWW6pXmEGmGAYCLxzQ7tTNodc11i9/Q6E462tnjSHgMc
 +o7euugL/qPn9kLVUdUaTLQfI7dRJKLlvc3qnMdRi8GA5yPjJe8x/ROMeaUmHdRFRNhT
 yTi6xbgyYogut7kO+eaMXUe3E20Wut2mYeF6+Qt4IMPHP5/+zsV+jC7cfsCOibQT35B2 /g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1rhds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 15:13:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36MECfjV003893;
        Sat, 22 Jul 2023 15:13:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j1wu8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 15:13:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8/JaM8KblspW96IIHMIPBGZ/WRvQUWuxq2QlzAfb58XMHD1F2e5PzsKZKH6+V/aPRZJ3qrf+AMZjALoNANXFvCZAknmgsFjAUU6cmVYsEPAvn9elfxar6cNFloD4qihibyqYkKrsDLDXbiJTqvMMX8KH/81Ml2S47/hk1Nn95jhSYc1NCwvg1RW8k+j/zN+jSfVCkQE/dS64cYRtwz1WFw80N5N65LO+jGGSAcO0p7d60/O03cSrPepHFMGW0Rjt8KGb1chHlHDpoTSmzkJ1jo5zwSjZYzZ8OF3ypDFcC6zvIgOop5QSWJmyob+a0Yt2RHpShdIn+Y9ht/hVHJMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/biw+cEXZqkeHmXFBYzZXnqGxb8YsNrQX2vrNVqKgYg=;
 b=Bx2cXFhosg72rxrbRJlVytUabVhRoGpctFsTd3Rgpr6b/mZY6MG2gl5x3j7XcFiISEiT1/TGnLmkbulYLidTYagHlkbTCUkjreIIJFwTeD2VYo7jHIt1AN2RWNueCgAfP24AI9YUmgtrEYDzo03wV15z3HvEyGGYIXeAXVUEJQZvr7RQ+SDMcDr0K/zi/B5X05Skna6TxQqLrMVlentrfUdywQ1xhAYzlQ//oPGk9dPwlOElleoARa2DKY3QQAnfum9u47G9OVO+4gUUnalB7nFxl0ZXTtebK6AVp10NX8GC7wQXjNr3JyZfv1BNUrITowIZCMK6rO8UbgNzngETVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/biw+cEXZqkeHmXFBYzZXnqGxb8YsNrQX2vrNVqKgYg=;
 b=FvrN0TsUkbAhEnLmh1oSp44iR8x2fnrlLPcG3Ht23FD9j26JKOWb44ezGEOZb+LhpKAADWCI8jUXygyRZV94EQ5Vnt+Chj0hqOd8FuEjp3vyZYxfCWY8rXT7NfIRMwel1uRdmaidz7owOWmGFgpbbzp8HSfmN9qOAl0oM4V5d58=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 15:13:16 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6609.031; Sat, 22 Jul 2023
 15:13:16 +0000
Date:   Sat, 22 Jul 2023 11:13:11 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v6 4/5] SUNRPC: kmap() the xdr pages during decode
Message-ID: <ZLvyB8E121gZWjny@tissot.1015granger.net>
References: <20230721203953.315706-1-anna@kernel.org>
 <20230721203953.315706-5-anna@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721203953.315706-5-anna@kernel.org>
X-ClientProxiedBy: SJ0PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: ae83c624-c8a5-407e-9c41-08db8ac62cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcNTod1wKyYvdDAOjWm85yt0EJL5ORpJjgIg3lbUUQNfLmfsQv/4LsmQRPtBN1I2KEoV3ohy6AxrNqG9L41Bwnev91HS8K09p9X5uR5y/6NYjY4XT0A5/V1fmKT60ZDtbKEWzt+FfMTrFHLXvncHDmY+IkpVO2uThoYS3x0jUmsSPnBNckQicA519M9h7uz4XJ8GUu/Kp3PhnNGB4TXdpQusE2k4WcorYj0kM6vDjkDpDzEIuk8WDgylSRIH6qZLCE4v0L41nEO//hY/BeUTVmCrK8PRzbmQ5Y7ylEHwyuZvO5x8yT3MBcap+rKxkCi+mPOdmh6V8TqRYspvXoQ3XqFl5kkyCUET4lp4zHaNRDifBY2kPn9BbmcDFuXSpKX0WRtIoIqDaMHb/Kq+BGwjZdKak2HvyyXpi9d+OOdrFvwqrDFgNnm8I5LWccFEIYd9/klwUEuMoRB24yl2f2kxUwRMK5D3tVb7NVlCSLveao5qU5ceWpI1coPMCrvSQ7Pvg08QSF+camPdFLmZOEVUH2yQQPghZplglMw6jAN9sA9l8J0FQGobrsE6emhieBpN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(5660300002)(8936002)(41300700001)(83380400001)(26005)(8676002)(6506007)(186003)(6916009)(4326008)(316002)(66946007)(66476007)(66556008)(86362001)(6512007)(6666004)(38100700002)(9686003)(6486002)(44832011)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3KHhFZd+paouPAp5+9vMKQrk+q+wELrQEaV9tUjqEE4QqCFOi4rZE+EmZxTv?=
 =?us-ascii?Q?V3wlje7X4FVVI2RK3ffwx2Rs2b8yWukCQuRc8H1ehQHGOlw/ZwiTmFqy91iV?=
 =?us-ascii?Q?kXPvJez3rSMrMiKY2TSGePv5vrfdbY9U3QfAT2fJmo9ws65xvtEqWBHlGQ1W?=
 =?us-ascii?Q?eT1jBUT7ueD0/iHSb5r+Ptu0D7Z8yz1Dsf7iEyvEEEofhaeXQZTWS4tAX/9H?=
 =?us-ascii?Q?A94j77D13eIecuP4x8+9xyQNEFtkLG/KdogYU+ar3lkj6gEnGImPqhA92u/x?=
 =?us-ascii?Q?35tMHr7yxX5b91vlzMtioHTT0R0bpMQdOIvu9CFwPbGyCjsGQvD+HtaypL1e?=
 =?us-ascii?Q?wG4+7zrEwBPY4aZ3QmQASZflMYWqWhtDhQKnJApxjVl6XDZp2dkQrb+Arr/F?=
 =?us-ascii?Q?xSlSK2A4sUB/2klcUa+aWtM0FDFvzAK1iH5GtAjcs7nPX2ujuYR+lBG1/7gI?=
 =?us-ascii?Q?PJMgwffRPoEnn6IFKKLBXRvivbUCxTVVHBk4NkxVQy36l+AnRwoCjR7tFHGL?=
 =?us-ascii?Q?U6KocOJ0fWv88PC7l9ZEgMmPcj+k7OPCvUZoXioHwjWFtLC0NWPAQcp6cHrj?=
 =?us-ascii?Q?Gdpzdq7w+gtN/iKpyl6wIiKMzddclv/UXeQhoFL0JO1T1M8NWT4jCvmnUwdi?=
 =?us-ascii?Q?ZDqhg0bm7nkQsaoCcwg0lff5d4gFtTdFGxkL8s3IhfLtcRTU5pGLL6B/7jmM?=
 =?us-ascii?Q?/yMMN/yIG+cITmVhqtIFTm/Wa7KmLTRJ2M9a4mptprxsuUV2uoRraNxX5SIr?=
 =?us-ascii?Q?XEqyAzOwYW50wzGevtoay+spfOc/VxO+8qaGHYq7fS8V4occUwOFVBTY4lTd?=
 =?us-ascii?Q?Or85wYQ1rMyQa3ogAxZREbHIhKxnRPV7aVMDH96yrJ23xlsablz2wJ77jP0a?=
 =?us-ascii?Q?jE2uTb+OZyCot3e9DjuM2JAZegwTNa4tf5GoC+nczQpkq+ToL4G8DgfsABrB?=
 =?us-ascii?Q?7Vizq368ymeUUhSJ0+ZGpr31GDN9P1kdiaHaNOH+wfhlb4hRexTepwahNbDz?=
 =?us-ascii?Q?SjYCnvxNtfqyiws4Fam0UZKXIdJWqXr96sC2NXdq1xQczEYEWT0Ptkeq/d/o?=
 =?us-ascii?Q?zqir5luOVYV9goi3FwfSatHJ1g40PFXaFtXQWEzvwtTzxButIZ+Q+dZqDaAt?=
 =?us-ascii?Q?G4EV1A0Rj6WwaOFgnR9GFYQXdPjmGcoFIm8KA/ozomxTcN1f0LBcbqks5lQ0?=
 =?us-ascii?Q?l7cocelk8jKu29BCQ2XoaPyIGsNefUUb5Rs9bVVF9uifKuouxixT3VLfcTy6?=
 =?us-ascii?Q?8wqyP58husIYUWIyaECFYIrOQXfvygPzvl4ADEhAKONssbKjT8EuT3qNRJLi?=
 =?us-ascii?Q?/jDqQD6E5Uw/vc/S0fiSBU5XmMgo2xICXJGMqE0WspRokH+EbXOPK13wJnGA?=
 =?us-ascii?Q?OvvRVLTYQsXQFh0h43E8bgPvHspGNDcoptpDidVaYJ0y4ulVXouSQfMJ77sI?=
 =?us-ascii?Q?BUWNBDgCI90hIN2hZVaFYtAddUDrrAGARNbvv3EKy814NKjbZsRHPvC/N3zH?=
 =?us-ascii?Q?SljUehsucOPUIrOJyHDB0mxw6j+NEXDy+l2wm2UA0NznHjMExgzrGZMp/nv7?=
 =?us-ascii?Q?8z0Vy6jG/x0ka2Gn4rRCds1ekjVCUBvw29fjgNxj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C1fVCBUn42BlylDAYpRJYrMDylM3wTpAL8ivNu+4V7PkZvmBqfVhdSUBgbeo0XxnbLeTf/fM0wXcF7xtXF4ChJ6rjhOnkYOI7iSEXQ3cVSLQUn5dU0YZxsq5W6VO5lfiwF5FtRqcUpqSganChY3m/JCrpRte9ypKMW8tBXxyaQO7HpYg87v6jkiz6hEYfwNg7wRKyrDPlx4G20xxOVzZtB12p5wQtCYa8pgaz2mU5sujTSY/jOgKdfzYWGLI89RjlycyuetWDYBdRuwrRv7ADC2PbCcXHF0Y3E7QOjyWM7G0JMbfS0w70aMjYP2CnKd8fh69tPWAfvaEA2K8OG+yVLP+K3D2YggFCpvLNtBy5LnQNNvwgBfnz7ouNQhYtTjZtscM/fI7wgSwxHJHSSx2NC/xznucMfCdgwfiEFlLreJtRorSb1jy3JcKe1bI3/HcNHg+cRGDoAg4vH1PxZMKofZOIpoEFSU2gp0apXLzG8qhiKKvhv4yq2gDI24c6sZfGfw8WI2XBPdxfI2sNbu3ZwSc+ukGnVB6QMPtGebmLzVMfBkb7WfY5w4uBEQZRsFdrU9JNs0++jyWV8ao0BxCfm+yGkYxKEcNZYFlWotEyY6ZKzcj8Ssqxhts0yzG+RkrTuAJEH3pqXORlxotggNrkzfJKm/Oq+Jn876vMH1bSbarWj2IiTwwZDfmFhLDuDPcEc9YIdM/QbEESwhKkYUl2+F0RPDYq0gb1tTOwqqnbj+r26qlblOkzF29UFKW0RcRsEi8sPykErTniGRPEsFiqBdZZuVDulKU8XaBZ+0wwp1FyD5xpH+S2oGIZDbZwmjNO9J1o+u4pKA15DJWGsNs8J0u/G1eBQSah78HzC3G5GA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae83c624-c8a5-407e-9c41-08db8ac62cfa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 15:13:16.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gkaVEeapcBn76WDVBHDSjRBZDj6m8RKyFtJcWfYXuULB7bBRd3ga3OGE+3JK1UDnNuhpFSud4KnKjFy3zgOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307220138
X-Proofpoint-GUID: 37Qc_8nM4IbfrEoLoowoDYkfF7Yj6UY-
X-Proofpoint-ORIG-GUID: 37Qc_8nM4IbfrEoLoowoDYkfF7Yj6UY-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jul 21, 2023 at 04:39:52PM -0400, Anna Schumaker wrote:
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> 
> If the pages are in HIGHMEM then we need to make sure they're mapped
> before trying to read data off of them, otherwise we could end up with a
> NULL pointer dereference.
> 
> The downside to this is that we need an extra cleanup step at the end of
> decode to kunmap() the last page. I introduced an xdr_finish_decode()
> function to do this. Right now this function only calls the
> unmap_current_page() function, but other generic cleanup steps could be
> added in the future if we come across anything else.
> 
> Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> ---
>  include/linux/sunrpc/xdr.h |  3 +++
>  net/sunrpc/clnt.c          |  1 +
>  net/sunrpc/svc.c           |  2 ++
>  net/sunrpc/xdr.c           | 27 ++++++++++++++++++++++++++-
>  4 files changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
> index 6bffd10b7a33..b75b3d416c5c 100644
> --- a/include/linux/sunrpc/xdr.h
> +++ b/include/linux/sunrpc/xdr.h
> @@ -228,6 +228,7 @@ struct xdr_stream {
>  	struct kvec *iov;	/* pointer to the current kvec */
>  	struct kvec scratch;	/* Scratch buffer */
>  	struct page **page_ptr;	/* pointer to the current page */
> +	void *page_kaddr;	/* kmapped address of the current page */
>  	unsigned int nwords;	/* Remaining decode buffer length */
>  
>  	struct rpc_rqst *rqst;	/* For debugging */
> @@ -253,12 +254,14 @@ extern void xdr_truncate_decode(struct xdr_stream *xdr, size_t len);
>  extern int xdr_restrict_buflen(struct xdr_stream *xdr, int newbuflen);
>  extern void xdr_write_pages(struct xdr_stream *xdr, struct page **pages,
>  		unsigned int base, unsigned int len);
> +extern void xdr_stream_unmap_current_page(struct xdr_stream *xdr);

Nit: I don't think this function needs to be public any more. The
usual convention is to make helpers like this static until they are
needed somewhere outside the source file where they are defined.

The current definition (below) of xdr_stream_unmap_current_page()
has neither an EXPORT_SYMBOL nor a kdoc comment, so seems like an
easy change to make it static.

I don't see other issues, so you could just make this change as
you apply it rather than posting a v7, but it's your nickel.


>  extern unsigned int xdr_stream_pos(const struct xdr_stream *xdr);
>  extern unsigned int xdr_page_pos(const struct xdr_stream *xdr);
>  extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf,
>  			    __be32 *p, struct rpc_rqst *rqst);
>  extern void xdr_init_decode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
>  		struct page **pages, unsigned int len);
> +extern void xdr_finish_decode(struct xdr_stream *xdr);
>  extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
>  extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
>  extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> index d7c697af3762..ca2c6efe19c9 100644
> --- a/net/sunrpc/clnt.c
> +++ b/net/sunrpc/clnt.c
> @@ -2602,6 +2602,7 @@ call_decode(struct rpc_task *task)
>  	case 0:
>  		task->tk_action = rpc_exit_task;
>  		task->tk_status = rpcauth_unwrap_resp(task, &xdr);
> +		xdr_finish_decode(&xdr);
>  		return;
>  	case -EAGAIN:
>  		task->tk_status = 0;
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 587811a002c9..a864414ce811 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -1370,6 +1370,8 @@ svc_process_common(struct svc_rqst *rqstp)
>  	rc = process.dispatch(rqstp);
>  	if (procp->pc_release)
>  		procp->pc_release(rqstp);
> +	xdr_finish_decode(xdr);
> +
>  	if (!rc)
>  		goto dropit;
>  	if (rqstp->rq_auth_stat != rpc_auth_ok)
> diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> index 94bddd1dd1d7..d318701a904a 100644
> --- a/net/sunrpc/xdr.c
> +++ b/net/sunrpc/xdr.c
> @@ -1306,6 +1306,14 @@ static unsigned int xdr_set_tail_base(struct xdr_stream *xdr,
>  	return xdr_set_iov(xdr, buf->tail, base, len);
>  }
>  
> +void xdr_stream_unmap_current_page(struct xdr_stream *xdr)
> +{
> +	if (xdr->page_kaddr) {
> +		kunmap_local(xdr->page_kaddr);
> +		xdr->page_kaddr = NULL;
> +	}
> +}
> +
>  static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
>  				      unsigned int base, unsigned int len)
>  {
> @@ -1323,12 +1331,18 @@ static unsigned int xdr_set_page_base(struct xdr_stream *xdr,
>  	if (len > maxlen)
>  		len = maxlen;
>  
> +	xdr_stream_unmap_current_page(xdr);
>  	xdr_stream_page_set_pos(xdr, base);
>  	base += xdr->buf->page_base;
>  
>  	pgnr = base >> PAGE_SHIFT;
>  	xdr->page_ptr = &xdr->buf->pages[pgnr];
> -	kaddr = page_address(*xdr->page_ptr);
> +
> +	if (PageHighMem(*xdr->page_ptr)) {
> +		xdr->page_kaddr = kmap_local_page(*xdr->page_ptr);
> +		kaddr = xdr->page_kaddr;
> +	} else
> +		kaddr = page_address(*xdr->page_ptr);
>  
>  	pgoff = base & ~PAGE_MASK;
>  	xdr->p = (__be32*)(kaddr + pgoff);
> @@ -1382,6 +1396,7 @@ void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
>  		     struct rpc_rqst *rqst)
>  {
>  	xdr->buf = buf;
> +	xdr->page_kaddr = NULL;
>  	xdr_reset_scratch_buffer(xdr);
>  	xdr->nwords = XDR_QUADLEN(buf->len);
>  	if (xdr_set_iov(xdr, buf->head, 0, buf->len) == 0 &&
> @@ -1414,6 +1429,16 @@ void xdr_init_decode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
>  }
>  EXPORT_SYMBOL_GPL(xdr_init_decode_pages);
>  
> +/**
> + * xdr_finish_decode - Clean up the xdr_stream after decoding data.
> + * @xdr: pointer to xdr_stream struct
> + */
> +void xdr_finish_decode(struct xdr_stream *xdr)
> +{
> +	xdr_stream_unmap_current_page(xdr);
> +}
> +EXPORT_SYMBOL(xdr_finish_decode);
> +
>  static __be32 * __xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes)
>  {
>  	unsigned int nwords = XDR_QUADLEN(nbytes);
> -- 
> 2.41.0
> 

-- 
Chuck Lever
