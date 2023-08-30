Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91F78D807
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 20:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjH3S3P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 30 Aug 2023 14:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244812AbjH3OIG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 30 Aug 2023 10:08:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D9AB9
        for <linux-nfs@vger.kernel.org>; Wed, 30 Aug 2023 07:08:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U9iODm022328;
        Wed, 30 Aug 2023 14:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=seiHrNlvqVVWmtxRrwFu8H0rgBndbwjaIEDbESnPPbo=;
 b=S3JAXT55ERO2/ZD2mEUwsrAeIAIGZ+XhWClFd7RT1T1z7vSATc8F4J+hVLDVrHH2AJo3
 wb5NXe8pTlNTT8hiI7hUvc8Ymre6tjx1AYAMw8Mlis26EDSCDGnrijgOYtJG//QG3MAE
 pHkrldjPeQY1iIjjCVU0MlbXqlwEZiZrXRxKDnOYV1iwZwWCBGqVj/Ld/RzlmgWIAv7q
 XoMBvwNn2KkSAvJIjhd1h1ITccwmmdFF1VUBC19bRk9D7yCw100Bekf5CX3kOfKFPHpO
 dLZlYis1Wq2+Va/JJhXhBL1ZtMIu1XF3u4rN9/zK5j5uUEkgV+oi1DHAvFzcwq6qm9eu jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gdyc7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 14:07:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37UDDnZc000623;
        Wed, 30 Aug 2023 14:07:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gcm9du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 14:07:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAsW7K+W24A2b0QzJ1+ee+HGzKYoYAMOU2VIz3j2g14fHgoqCXlrOwSsaEI28AlYanRdb9f56y5cDECFy1+TjtwTTpmolhhjchwLgVcf2O1citIsC5B1DO+lYmuJ9v7CNcO0WCViVSP8C1KSXCu2YqAIC4fNmrmZ0qxIX3ylBlzUmVpNLTCLP9WLHoE1Zg3+T70Lv5dPwzwgW4HFkoqRg0Y9QGSStlbDiVZIgnumcHCafsXsx3Q38bPBOgDnEHPScfYs5Po9azcDtyceLdKgM+LGGeFWigRz2zwqoBukD3hx2Bbv+un7V8lCmjcdSTO/jEguhKDUf/uNJbKab0Pvnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seiHrNlvqVVWmtxRrwFu8H0rgBndbwjaIEDbESnPPbo=;
 b=a9fTaVycA/nExKHcirwyB0Rs9aSY2lfE1OS+2l07xRRDgV9tytJKvHQJP0AsBtFsmxP47DiKQeZi0MMRHAWjLLkEApfExXPXu8eRILjBcu6eZ4wib3l0vw8HpW/Q3mWIE05fPkRpnHoGTWHaFAxeVckLj3W6MNP//EWJnCqfqRA7uDex0Sb/5e7H8cIPefPEXzRnN5XqbN9MeQxDe9qxo3ao5EQz9XJVhYsfPBlgxXexW45zMf5X0uB6C/LtRyulA/v8OqOUvBqqyEFHuOHAzFcasjYRZxomnRR+fh6y+zfBTIwVAXQRHRt8PtctRQkr9x3Nq+o0+SpMFw33ij1Hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seiHrNlvqVVWmtxRrwFu8H0rgBndbwjaIEDbESnPPbo=;
 b=hcgNd61HcfiyMl5zUZig0ez7hbJhQRlIIazrRb3iKtS4Snfn7ZjsYdHvHNqa8vyfe7JHvuTaNCRAFWxWnIaJB7aeZO3gpPtJP0NX/jvOZrnOlnmoRqYQXYig5TJU39zCLldKcBX/MUVLg7YX/06GT7aoARqqid9mW5RaFxMFDII=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7866.namprd10.prod.outlook.com (2603:10b6:408:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 14:07:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 14:07:50 +0000
Date:   Wed, 30 Aug 2023 10:07:47 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] SUNRPC: always clear XPRT_SOCK_CONNECTING before
 xprt_clear_connecting on TCP xprt
Message-ID: <ZO9NMyfUwOlULuOQ@tissot.1015granger.net>
References: <169336886172.5133.14231863738996844866@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169336886172.5133.14231863738996844866@noble.neil.brown.name>
X-ClientProxiedBy: CH0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:610:e7::20) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|LV3PR10MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4d49ad-a336-4f95-17eb-08dba9627ea8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3QNMxKilSbZRW0I525fwcbi33MTz3ybfnHa17ywmPbhTQK5Wv62LJckifLrE5QpoQXHP1sgPp7hAfaO5QXsDuh9qxoQMGxCmAIAb/MFVLNe0E6zIiaOZupqG4Dtw0HVi2BOy8Yr8fIB5ccd6+l3vU1prh01T4dyKRWQAbjV5954HvBn71/NQI9B5/zbN5S1gSEtGyoPHFGmqAboO1W2Gsl34Lx+KOo0Jje9/yf0AFx+BaJki/EJu38sbq7Vj4Kz0SeppKeZTxMi7TKygG3vSY5lPFRqNBpZ47nXNUFRNgmvyQPlHjOrm9w8gDLuYnGgnrfT8qYyx+yOSVWLs+lijtts98eYlrtii1AFGZX69esryj1fFL6mwaEDQG+lWIxllHR9k6PEuGe5r7XZ2dWc7bMG6qOGKCW7pbqybHDQ43LO7cV+twJ+GP6P/lTNKyDPhCgFl7wTWLtifi2hqIw4DAs4lJ2rtY89u7EVQA7h35Z6MAXETDMpLKrl3J/DagoKTtIlctZftOLBCCGHEnxDK9/X+gnaKL7DkM3cJbodT3AOSHilbK0gqTfCgoP3JR16
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(6666004)(66946007)(478600001)(6506007)(66556008)(66476007)(54906003)(6486002)(316002)(38100700002)(41300700001)(6512007)(9686003)(5660300002)(8676002)(44832011)(26005)(2906002)(83380400001)(6916009)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3/J7rQisVHuTGEkphA/Ejfb2fB4Hmt5r+7ekADev+NONDmSxUnV6TyzZu9me?=
 =?us-ascii?Q?vEevAyzH9VxRxaPAvlvBPMR3hmnWBqUrUqoA9MDmIqdwBZlaeVUhvsMEUoY8?=
 =?us-ascii?Q?uWOAx9uo2/BS98Qv8WiOfvxVDL5DivOrRX1r/Y0+cAh+R46zTsMxzDgOF8dH?=
 =?us-ascii?Q?u2a9jIi2oH5cMypm8Num/Upciwm7jB1VBkZV2Nb1oYjcQO9MpoLxmH3fofoQ?=
 =?us-ascii?Q?/7wV+Orb6HcI1/nPdghUSa7s2rlpXo6RGzzKMo0rON9fuE/2wGPSmm/xco/j?=
 =?us-ascii?Q?Z9rR7ih7iDfyJz5IlJ6xBiVhYI1kUGGgYQMLJEyA4JuYcx11++9872XnX8iL?=
 =?us-ascii?Q?vb8BvZBZtgUmknsYIHRTjGNfS6qzDhaM0DFUXs2cxPdKI4JuCP9SmOpMARW1?=
 =?us-ascii?Q?X5h+Hks6AdMfPaNCOW4K2/ZAa6IrbwvgLFBVqkzMqpM1AUDL8zCc44XJViQh?=
 =?us-ascii?Q?3+bPsUGFZg/bzWSa6HuGyZEgLATeQZw7iV3w66ZmpUcOsOSzrEUwSa8202/u?=
 =?us-ascii?Q?7VUPFjp38E772OXICzHx5hNURfm7odHhI9AEIUANlpo6AcBU36rzx9/qZVzt?=
 =?us-ascii?Q?cFAfkMIRV7nGI4WKg9xhYI7qYMerBXtS491hSvbb/8NO9Q92e8FXstzYwXfI?=
 =?us-ascii?Q?6xoTL5Rli6UN8WYdMubdU7+Z3mDVsCM7VHCt0XWLhEwz7EUCTNrVyxYZ5UD2?=
 =?us-ascii?Q?0VWY73kv83io6/Ne2TshK3p6ArxFmecxEHAsT8YQ9M2bACPD+oOtHW9i1cbR?=
 =?us-ascii?Q?aUcqfFL6YVnMrCNAqUBtdCII9SSVwBvU1CPZtvLy1xeyvFi5oLxD/HC2R2Lm?=
 =?us-ascii?Q?dCAoZLYINn3fUWYJyCFqbw0p9Zl97RvAZ+sIRGvl7XprVKY3jX8HeEfOxJUf?=
 =?us-ascii?Q?yenwrFfnhYeijJyJApV6n90qhTkUI9CCvcV4B5Fvn8kHEEIeQts3lFKusl8S?=
 =?us-ascii?Q?h7RNw6CcAaUoRfFdIRSMf4gRkthLH5EuYFMq+COIV3mVcoMX4x8auIo5x4vs?=
 =?us-ascii?Q?kmvnrpnwBDn8Sr7WnIBcorIiDMJVrC9/EBwfZOplYzHLKRfh+xVNPpaoBjjj?=
 =?us-ascii?Q?rwpu8bYwWpkJRNLmzwQMWa+IkIqt0G80VstZvz+Xtlu8GWUcH6k4ohnH5kRO?=
 =?us-ascii?Q?eHiuMxd/dm35OR8bmJXAn8gfZhEayj9g4Z4SmQ+fldpuf2dXqcWbLHm70tqw?=
 =?us-ascii?Q?9pkIv7QgDQRj9nZ2RpwCdk5SJ6Jo+I8OTzY2AENUY28EVDcR101l5mPSn3PK?=
 =?us-ascii?Q?snHMIiEGA+i5kWwYSlkxEvTrTJBykia+A2UQKfN/GiVAjFai74G1PqrDUaOo?=
 =?us-ascii?Q?j418o/mTBsy7NO3PitholTVhHGFdd7w2eK04pmHKJACJNB6cpxZCEkPJq+Hr?=
 =?us-ascii?Q?ce0/hDqvklpUVZvjqQsH7jgFxCXdoHVFVEkeKp33QnZzwsViUXDU8dY1nuLV?=
 =?us-ascii?Q?Ivorm9XqLK7raYlvUfMxlefxdI2H7/4NGYJRbUzpZsMM2/BcRns3f5NyD3Zr?=
 =?us-ascii?Q?dzHzAOdVVPG0G6l55+3y9qOglzBri0apuolUTt0IM/UpdcinNwQ84jHZfCEh?=
 =?us-ascii?Q?jcBUkJ5I6wrDJVOliN9Ihz2xAV++QCPCNEG1eP3ZRncFBJW+2cNjAJGtcas0?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AybLUiBWofqcixc0kF4B9dQlHAaFGr6K+mX10ZQC0XCUDABrd4L3uXLlCel1Kfd+uUsOn0YNfjMyW5edxbWwKHOY5WN79h3dkO9oYmV772HftJDzXvzAyVpmYzqF1gkyH3DemebhVXvrMRwFIu05DUDpk3DQG3OldfcReDtnwEF3D/mmayUj21LnZtF2qge9zvPu+ZysLJmFlUKm22zdfzt2CMrHFv/jt4eS0KA8UbVsaCcyKeFwbjuhz8RzZuMW9TwV8B9R9udZpN/NOiwLkgNT0/txTGsDGgUvs1mBQMHo/PWHD7V2J+LyXeSsxnn3QcVpTlEV9VmSJYurIW7K8kFpygA1g0QBvpHZUYvXHzO8H39s0jTWTuq2pxKlQZL3hxSzM7wOBUSIHHAoAvvPsHtGLiAtJJ8iMGuRPjk9v2bXA/K1kVMAj+A92yrCmbrfWkIxPIAq7mu6vPRUw1NcRqzh346rJmY5eGrkfyRchCQoV/e3I+/IVkjS/K7KzHBHxSdnECZVa1P6cZLyW0jYWUKZUxUhxueBLJC9iY26rAhyTYZ7h/81cpwRYFTScRMphAmVoe6pJGteVn4y/+P8sZnXy0C8LArWbCRIx1Uud14z7FvFbnk0VCJpqv1SOr3u2mQSqWp1saTTw/U0wR1PB9RNSSj2bIKw4skfkTKLLWeUyAH3eB6cgA/kjlsojRfSxXsGBWpVj4g26embgGq6n4NmvsBYaXgu7661PS2XvQ4R3IdSUWloVVFBDcrOwz0i6uM9ofcKBO9y0sPr5vnDoZ1lnSAjio5KSCQWIP4aWK/PwYqdREwghm94Gxkfg1dzPlqnSzpT1eXKAShIUzBygOO795MkMXLcoAm3AKSM8Cg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4d49ad-a336-4f95-17eb-08dba9627ea8
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 14:07:50.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C39/i0VPFLhsoBWFdZDBsAttQnR3NIP3OOogoqu6FFN14xMIjieAIDJUgnqqjWaaR04BZ34KGcvWs9AOFmCS+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7866
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=993
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300131
X-Proofpoint-ORIG-GUID: hTHi62-A7sOw4hFU-f96G4ouAV4A1ZwH
X-Proofpoint-GUID: hTHi62-A7sOw4hFU-f96G4ouAV4A1ZwH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 30, 2023 at 02:14:21PM +1000, NeilBrown wrote:
> 
> sunrpc/xprtsock.c has an XPRT_SOCK_CONNECTING flag which is used only on
> TCP xprts while connecting.
> The purpose appears to be to protect against delayed TCP_CLOSE
> transitions from calling xprt_clear_connecting() asynchronously.
> 
> Normally it is set after calling xprt_set_connecting() and before
> calling kernel_connect(), and cleared before calling
> xprt_clear_connecting().  It is only tested on a state change to
> TCP_CLOSE.
> 
> Unfortunately there is one time that it is *not* explicitly cleared
> before calling xprt_clear_connecting().  I don't know what all to
> consequences of this are.  It may well relate to the underlying problem
> that resulted in
> Commit 3be232f11a3c ("SUNRPC: Prevent immediate close+reconnect")
> That close/reconnect pattern can happen if a TCP_CLOSE is seen
> while XPRT_SOCK_CONNECTING is set but shouldn't be.
> 
> local and udp connections don't use XPRT_SOCK_CONNECTING.
> 
> tcp_tls connection don't *appear* to set the flag but do sometimes clear
> it.

Note: At this early stage, don't assume that code is 100% complete
and consistent. ;-)


> I don't understand all of the tls code, so I added what might be a
> missing clear of XPRT_SOCK_CONNECTING there.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  net/sunrpc/xprtsock.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index 268a2cc61acd..9426b1051b09 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -2425,6 +2425,7 @@ static void xs_tcp_setup_socket(struct work_struct *work)
>  	 */
>  	xprt_wake_pending_tasks(xprt, status);
>  	xs_tcp_force_close(xprt);
> +	clear_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
>  out:
>  	xprt_clear_connecting(xprt);
>  out_unlock:
> @@ -2689,6 +2690,7 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
>  	 */
>  	xprt_wake_pending_tasks(upper_xprt, status);
>  	xs_tcp_force_close(upper_xprt);
> +	clear_bit(XPRT_SOCK_CONNECTING, &upper_transport->sock_state);
>  	xprt_clear_connecting(upper_xprt);
>  	goto out_unlock;
>  }
> -- 
> 2.41.0
> 

-- 
Chuck Lever
