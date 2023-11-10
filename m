Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CF7E8286
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Nov 2023 20:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbjKJTVC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Nov 2023 14:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236147AbjKJTUh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Nov 2023 14:20:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2497C239
        for <linux-nfs@vger.kernel.org>; Fri, 10 Nov 2023 11:12:12 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHiSg7017445;
        Fri, 10 Nov 2023 19:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=HSBwGH4LxVgp8Adn5yuI3lL2fdusM7oii1xPIc1PbHU=;
 b=V+DVoi0s1/W2uFhn2+Vd2ULqGt3VjCoz+3IEZL5Yrb10JMJssi54K61fDkXuVHSnjVfI
 oScE/37r9jrOoMG9DsMw/p2JTloujQNI0M3IPO/bZMXp0DhN1ndbKQtQqYIpHxVUsfGF
 PsQmigcBO4m1SswFikcR0NFMLPb05sgyOqotDmd5vJVFUR0AW4bAYFkZkAsS7uItM+v8
 Xdjq9qw3zHKgfZkuiyX1t+eNn9uyHVQm80iY1m6goHWnudc2/DGoVWrQ/SX7Exv2IbB0
 O2amoxHGNFiid2INCLymxosM3jR4AgzPxnLq3EN5y+OUIomrqKfQ3wn6zhu9rD0wmi8o aw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w26xq9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 19:11:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AAHxWXl018361;
        Fri, 10 Nov 2023 19:11:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u8c026fwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 19:11:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQCzOEWUcG8tFa6liiaIX1ILkht8z+GEFI5Yqs7pcQ1CIlbtFQBfuf+pVaBCSTtDg/QhEpJS5/XN+vDIMxeVdXYnIF1R3dgbJ530JKzRUaY147dADrR2FGcX0D7DfcK5fnF1bnSFJuV3j/cBrAPQ9M/g1vuOHfDUQSZWQ31pXmS4ISSJaRRYKQSZdXyKeohWSyQdTa5gwyDUMX3WW0EBANdaWmt0knVVMNH1JrnroIZht3CWGzd8LzYY6C4ZwLZaIwLjhy08thijzKJw97VT3AlIA0dpYiEiyAKZbqABD1kT4+m10Fbps7eWWKWcEKfrVi6jdvDEVHg3DmFJ9zXwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSBwGH4LxVgp8Adn5yuI3lL2fdusM7oii1xPIc1PbHU=;
 b=BahIDcuLfSfGSigudMUQrRPuR5d22c/3oQbMop8TBhRuxINQvi5pgvI1H52VYZ+CUXvRmp+hN92pp4/JeRafC1W/4jB/0X3PLCnOf3SeqOQ5HgQb1Se884ePSX0Jru3wnrKa/3n+15i1KTzl4JcUfaK92zZX2FJ2QYJu81ejVaeVs+RCIAGH9zimgKuzhWTKwBaeDeI/GYd67lky5Mrl+dmAV5EIy/Q9kg4q6pvqBmGYlrhkDFntLRdAgav+eonB/GFk5P/vnv9ZIX5HrfPigVBgBWpG1A8uSWoUxkHBO1DtsOuYX63WAwf5q35RyUpm5AIhRx95R1Cz0FMpDF55yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSBwGH4LxVgp8Adn5yuI3lL2fdusM7oii1xPIc1PbHU=;
 b=cr8LmPBGpMqPRQ6jd/34JU2jtidTq7U92NeG5MRyFZegAP7PnvZiduAQYoCMt+McrDQmftwS4pHMtuOfAxhwzKCtWeDS7AeidJZWaFYwrwM4IqPuWur4UY8tYvedjRVzdabA427uP2kTqrM2jKEP8jcjnutqzifuG5pqkd7pl7c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6812.namprd10.prod.outlook.com (2603:10b6:610:14b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 19:11:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.6977.020; Fri, 10 Nov 2023
 19:11:43 +0000
Date:   Fri, 10 Nov 2023 14:11:40 -0500
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Russell Cattelan <cattelan@thebarn.com>,
        David Howells <dhowells@redhat.com>,
        Simo Sorce <simo@redhat.com>
Subject: Re: [PATCH RFC] SunRPC: Split server-side GSS sequence number window
 update
Message-ID: <ZU6AbHlnN3wec1mC@tissot.1015granger.net>
References: <169842400684.2384.5932301559665706233.stgit@91.116.238.104.host.secureserver.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169842400684.2384.5932301559665706233.stgit@91.116.238.104.host.secureserver.net>
X-ClientProxiedBy: CH0PR03CA0302.namprd03.prod.outlook.com
 (2603:10b6:610:118::24) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: ca9f6680-f7fa-4262-1b46-08dbe220e05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iV7dGgKq9hoAjpkXRQ9hGsewahoZaKkTdZ/T7OFOpku9d3I/miPyNIriZJofqUXZ6R4ZKqtyxyNj6kdNsOIGetPpXiVkkB6VPK7F/OL53JAH6seEWMcvR3ZIr2EOa13DLhYyTw0VwEygw+zv7rfbXJPtLkzcufswYneddKPRiruL6r1mKagaP338JqRTl1+JcMETCQC+IShfU79VnmVGC4mzww0kCitTFqnO3rd6OwWYury6vw9D/rs32uryywLY84ZOCy1rgDWv5Ji9uS1a/W4w33iVDCOg9v6d+q7kCxe0CVylemf4h2zkn8HTqCCm2GR3JoeG3G1wHCl75SwDzjoTFLzdXTSbq1GYolzbOyx7E/Q+OFvmBSi5UvGY90PJyhJT3z2vh+Oz8U3xSzfQO0buR8v0Es8K4EmY+1BU4hDNVO15NmfU7xZiKUxYS5YqIlRyCSr0XbnDcwQewfNOgHSsRrC5gb0s7bEEpGBOYUEvRXs8ooZ4ST6CGPR/5izhmzOGnYFnsUwRyi7q3bAe1K30AhigOrPegTaFLDWWlzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(44832011)(4326008)(478600001)(5660300002)(83380400001)(8936002)(8676002)(6506007)(2906002)(15650500001)(66476007)(6916009)(66556008)(26005)(66946007)(54906003)(6486002)(316002)(9686003)(6512007)(966005)(86362001)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IUBTM0hcHLo+BmBDAQj3JUluZI6qnRo8SfJZtmzSMBrgABh5hINZuIQI0tVG?=
 =?us-ascii?Q?DQX7QdMBP5LpzmxLab4sMlqd5fc6fin7W8zOQZfDkOyql6v43pq4lzuJCg7b?=
 =?us-ascii?Q?5SLh/oPQySzticXnWZ2BJ2lhjHiMeCegFnLBt3qLDYU84WZnxaS2V2jYEpFz?=
 =?us-ascii?Q?lsjXkCk0n7itSDEJZwhf9SahBz/nNGH4Fd/BFNBTPrBcghO6w40lHNPUwy0x?=
 =?us-ascii?Q?K54pKIJcq5llbrm5oZeFIjn6DpWJJr64HmjTBURS4rhGf79C75zDA0go0HSz?=
 =?us-ascii?Q?r4tCP3Ss1hum8H1ZALlLsJSTUAsWarelzX9MArmd/VNe/oFJXZvz4Rn7jRRi?=
 =?us-ascii?Q?IAcdeTaYTWkVnv7LQpRuIjhQpQBTTuAc/FATOlSHKvbbzXiLQTZcoJ6q2ctE?=
 =?us-ascii?Q?h3q06DQpefpOc5dVNkApkABl1yA4fC/ajfbKFJ6Urzvp2Moh/tbt/zu6b0eO?=
 =?us-ascii?Q?BATNdd3G1FN7h1827mV0bmoRum1ajbSp2axoOKsmcQ4HA4n50EVPdn3YMp59?=
 =?us-ascii?Q?cO2aLpKzlXeE1oMmQXW2/c/DxoQF42opRLyEKijXUl1xSzKg/t4iVXcZKBR7?=
 =?us-ascii?Q?e+BHWNV5PeUnikRsXxzR6K6iKgGmgnvNX5Z7ah44AInuxjPjg1YOh1BTfTSz?=
 =?us-ascii?Q?FzGoCTVwF4I0w13/R3/MdxTSintQwDbrxIQpSydgMNcsAc4PBr9KhibC1yjp?=
 =?us-ascii?Q?0oigiiI4nlCx62qOX5/391NeQbBLVrC/WK6oSUiu+ANHcp4u+cJhOQG68KN/?=
 =?us-ascii?Q?cqBquSHxq6fBKj67nZgK8AP1vBDDLZf4+x3KEa5ha+gduw4vvaG+VM1JBbd9?=
 =?us-ascii?Q?C+wZ2SBnlTFH3vBuUeYXoPl5CjY9CioY9MN+3DdzLYN1Y/7pCHtmcm9fAXp1?=
 =?us-ascii?Q?eG6UTNdTs44vZwnKtJzqNxQqgr1lDVW0JBMljn2qcQFQFQ+kmnHhSE+NSZki?=
 =?us-ascii?Q?EqaMxgz2GzE/CAJmll2kUqWA8jgtTpUFYf211zpoudEPj17a3bjvzwunuYFU?=
 =?us-ascii?Q?l4mZZ6ir7+gdYpzVxLlEhB9A9sYt8SB3zjGFt1B8ULPU5oX5/N2I0Hz7TJ80?=
 =?us-ascii?Q?mHBwyYDR4bxnKtiJlUPaJhyFqcoF2rr2ibB8EBCBMbiBi/Pm17ZK3LNeG11t?=
 =?us-ascii?Q?kbZcKYJvDDU7wdmzS//FO8HZI6vPRkzLyBghW50qTRsN6k8Y55PLkm0feoTp?=
 =?us-ascii?Q?tP+Fj29yBNlPjRfnMqzslMlq96dFWYiPqmlnZw/rbsa6kZqOZWYbCXC7TwIX?=
 =?us-ascii?Q?yrxx9ULuKD2qyqE93FRytjloBArHpPmVGCuAeOtcj1maaKj9WxWToIzuhh7X?=
 =?us-ascii?Q?AefKPql9tDJIrp3skxiVh2aq5pDvpVWsCK99k4sokazsJo/5NL5MmT1q4xI9?=
 =?us-ascii?Q?u0dKQzoW3gpaA3GdSYortm5hdDMiTVCcm4PD3S6l2VYeJUnPb9kbBFtjDs5M?=
 =?us-ascii?Q?W3bcR8T99qyac3LCeONAVVw7BRACI//lMwDDFsG1DMEQEOzKC2lnhm6kAKCA?=
 =?us-ascii?Q?jgzYzTxuz4kvvJSS5W/Bw/+jB0fXVJgSGp7vYHbj3QPXDH534L2p02LsIgnm?=
 =?us-ascii?Q?6bRSgd5rqQoMI1XuWhvo6XUMgGIJ1i2pXREGtnIe6vM7+Vj4TGrJFkMPy6cR?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jEzjkq0OSRakRQTdAWyrsxQWkKFV8EYR59vNWObtSQPGJu0w/nG+ZMt29bugBpFpYful5A73ih95KJM74y8/UDD4aSSbuFWFzvfPsLLTsb5OS5BJSbFcqQTXeeFztkfFrTAgZqRttOQX/fM+UjQVFegONE/EddITIhZsAzyhBOJ3L6JoYW4sGsA8Y6wP1ZxfdIg9e34wsar8pyp+RaNO/2/kMxK6oLEkvq16ws+jstD1hXWaWl1RYnibH4I5SXHuj4V+qM+zxuG1LevceiPUpMiHfiT0lvFXAV6u6rmRr85BknyqKCXBe+uYEtV102DF0lMoFmUfbEfFboOvCrR9zimbZO/luPCGrMgTmwDePYsWw0PnSsuqLELKEUxRnQfzA+TMvj4BBt6PzPWUXOC5NY3A8eNaeAK53fgmuE+3WxCe8nhghPxeDhxROYMwxfVUnMQYK9wufk818Irwn9mgEb8250mOJgU9l6ZCvged8yY4FiSmULf0F6S7bm1fn4euiPY8nUbMziUujTd6E2IOFODlDxcelIrqbq8rt88aC5IbOfE9+ke/+xjLNVwviPl14g+iIEYpr7Tle/2CS6EsWB1keoCVxvCDli9pnpOYXXUbgQYvaQMoPTxqp16SF2obf6jdTBWkY6uvqEzFmszn9ijH1Udwc9aSsghiSVjSvYirIaztBaymcCqHD37o7jffYjq4N57tPNhZ9HhpR4sjYu2XSRVnDpaTcJUX0tqoVvtIOrN12Ko/0B3H3+yLXBBefncqwPJ63/iFS6T4DQ9Xtk614lowvtq2JBikBEiOZe2JbSrkMhwocopiLKV4GFqi3fMjxLnHmJKOaV42Uyf+mXfwnmY/RAqxzHkcfENV1bY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca9f6680-f7fa-4262-1b46-08dbe220e05a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 19:11:43.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zW5xHYeCPXAYj24uBXTvj546LUinoAQHxk8pU4LJJLvAy/XI4ZfbvLkXQt4OgCMAOL9V1QU+tmwEYu2rGGFPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_16,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=995 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100160
X-Proofpoint-GUID: jvsErW9NSD7fjiU8o7JxA3bd9P2QwT99
X-Proofpoint-ORIG-GUID: jvsErW9NSD7fjiU8o7JxA3bd9P2QwT99
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 27, 2023 at 12:32:36PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> RFC 2203 Section 5.3.3.1 says that the sequence number window check
> on a server can advance the highest received sequence number only if
> GSS_VerifyMIC() returns GSS_S_COMPLETE. Thus NFSD's implementation
> calls GSS_VerifyMIC() first, then checks and updates the sequence
> window under a spin lock.
> 
> The problem with this arrangement is that the kernel's
> implementation of GSS_VerifyMIC() can sleep and schedule. Or a
> version of checksum verification that hides timing could be in use.
> 
> Sometimes it can take several milliseconds for GSS_VerifyMIC() to
> return. By that time, on a fast transport, the client has advanced
> the GSS sequence number until the current sequence number being
> checked falls below the current window.
> 
> RFC 2203 mandates that the server silently discard the request in
> that case, which translates to a dropped connection and retransmit.
> In some cases this leads to spurious I/O errors or even data
> corruption.

Since the underlying cause of the corruption/I/O errors is bugs in
the DRC, I'm dropping this patch.


> This issue affects all NFS versions using GSS Kerberos.
> 
> To avoid the latency of GSS_VerifyMIC() triggering GSS sequence
> window bounds check failures, perform the lower bound check
> /before/ calling gss_verify_mic().
> 
> Closes: https://bugzilla.linux-nfs.org/show_bug.cgi?id=416
> Cc: Russell Cattelan <cattelan@thebarn.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Simo Sorce <simo@redhat.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/sunrpc/auth_gss/svcauth_gss.c |   63 ++++++++++++++++++++++++++++---------
>  1 file changed, 47 insertions(+), 16 deletions(-)
> 
> This is untested, but it's a possible way to reduce spurious
> failures seen when using sec=krb5[ip]. At this point, I'm
> interested in thoughts and comments.
> 
> diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
> index 18734e70c5dd..ebaa5c68d22f 100644
> --- a/net/sunrpc/auth_gss/svcauth_gss.c
> +++ b/net/sunrpc/auth_gss/svcauth_gss.c
> @@ -640,7 +640,38 @@ gss_svc_searchbyctx(struct cache_detail *cd, struct xdr_netobj *handle)
>  }
>  
>  /**
> - * gss_check_seq_num - GSS sequence number window check
> + * gss_seq_num_lower_bound - GSS sequence number window check
> + * @rqstp: RPC Call to use when reporting errors
> + * @rsci: cached GSS context state (updated on return)
> + * @seq_num: sequence number to check
> + *
> + * Implements the lower bound check part of the sequence number
> + * algorithm as specified in RFC 2203, Section 5.3.3.1. "Context
> + * Management". This is lockless since we're not updating the
> + * window here. Also, it happens before GSS_VerifyMIC() since MIC
> + * verification can take a long time during which the window can
> + * advance considerably.
> + *
> + * Return values:
> + *   %true: @rqstp's GSS sequence number is inside the window
> + *   %false: @rqstp's GSS sequence number is below the window
> + */
> +static bool gss_seq_num_lower_bound(const struct svc_rqst *rqstp,
> +				    const struct rsc *rsci, u32 seq_num)
> +{
> +	const struct gss_svc_seq_data *sd = &rsci->seqdata;
> +	unsigned int max = READ_ONCE(sd->sd_max);
> +
> +	if (seq_num + GSS_SEQ_WIN <= max) {
> +		trace_rpcgss_svc_seqno_low(rqstp, seq_num,
> +					   max - GSS_SEQ_WIN, max);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +/**
> + * gss_seq_num_update - GSS sequence number window update
>   * @rqstp: RPC Call to use when reporting errors
>   * @rsci: cached GSS context state (updated on return)
>   * @seq_num: sequence number to check
> @@ -652,8 +683,8 @@ gss_svc_searchbyctx(struct cache_detail *cd, struct xdr_netobj *handle)
>   *   %true: @rqstp's GSS sequence number is inside the window
>   *   %false: @rqstp's GSS sequence number is outside the window
>   */
> -static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
> -			      u32 seq_num)
> +static bool gss_seq_num_update(const struct svc_rqst *rqstp, struct rsc *rsci,
> +			       u32 seq_num)
>  {
>  	struct gss_svc_seq_data *sd = &rsci->seqdata;
>  	bool result = false;
> @@ -669,8 +700,6 @@ static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
>  		}
>  		__set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win);
>  		goto ok;
> -	} else if (seq_num + GSS_SEQ_WIN <= sd->sd_max) {
> -		goto toolow;
>  	}
>  	if (__test_and_set_bit(seq_num % GSS_SEQ_WIN, sd->sd_win))
>  		goto alreadyseen;
> @@ -681,11 +710,6 @@ static bool gss_check_seq_num(const struct svc_rqst *rqstp, struct rsc *rsci,
>  	spin_unlock(&sd->sd_lock);
>  	return result;
>  
> -toolow:
> -	trace_rpcgss_svc_seqno_low(rqstp, seq_num,
> -				   sd->sd_max - GSS_SEQ_WIN,
> -				   sd->sd_max);
> -	goto out;
>  alreadyseen:
>  	trace_rpcgss_svc_seqno_seen(rqstp, seq_num);
>  	goto out;
> @@ -709,6 +733,14 @@ svcauth_gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
>  	struct xdr_netobj	checksum;
>  	struct kvec		iov;
>  
> +	if (unlikely(gc->gc_seq > MAXSEQ)) {
> +		trace_rpcgss_svc_seqno_large(rqstp, gc->gc_seq);
> +		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
> +		return SVC_DENIED;
> +	}
> +	if (!gss_seq_num_lower_bound(rqstp, rsci, gc->gc_seq))
> +		return SVC_DROP;
> +
>  	/*
>  	 * Compute the checksum of the incoming Call from the
>  	 * XID field to credential field:
> @@ -738,12 +770,11 @@ svcauth_gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
>  		return SVC_DENIED;
>  	}
>  
> -	if (gc->gc_seq > MAXSEQ) {
> -		trace_rpcgss_svc_seqno_large(rqstp, gc->gc_seq);
> -		rqstp->rq_auth_stat = rpcsec_gsserr_ctxproblem;
> -		return SVC_DENIED;
> -	}
> -	if (!gss_check_seq_num(rqstp, rsci, gc->gc_seq))
> +	/*
> +	 * RFC 2203 states that the sequence number window should
> +	 * be updated only if GSS_VerifyMIC returns GSS_S_COMPLETE.
> +	 */
> +	if (!gss_seq_num_update(rqstp, rsci, gc->gc_seq))
>  		return SVC_DROP;
>  	return SVC_OK;
>  }
> 
> 

-- 
Chuck Lever
