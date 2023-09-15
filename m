Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31F67A2727
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 21:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbjIOTYu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Sep 2023 15:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236951AbjIOTYb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Sep 2023 15:24:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DC6199;
        Fri, 15 Sep 2023 12:24:26 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FIecTC013417;
        Fri, 15 Sep 2023 19:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=k8JcLhJVjT8gQPp4e4noZLBg3JQm0FGDJI0FGBUENvY=;
 b=OCtFYOa6j97DsdRXJmtYHSC4CcmgCtfHzdzKhQ9dVQN4Cn462a1oCout9Bmdmh2/G/Ed
 G9QlqstnxbZWIC7+rc7P/ae2wAaj83Z3EjmLrWZxRjyA+En4rXbXpjo3qq7tKeKFObM9
 eoaktNy3+oMxv93rVowrmwdjnCh0z6d1l9yqSJaqdpG3Z8jN5+R2ORbGMP6mC6TLHTlA
 P1xa/Rr2i6/risjvyiaHzU5yV73AqhUP/Su83x8TlkeSAz7NIZGzGuVgEgBxkCWkNjo9
 QoXUgGXkOgp6rVDW6SokEvYBVpnT5HgqBBi86wPS3yYzr3I7kQP4Ys7Z7UhREXXLm3Bq dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rgn7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 19:24:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FI5o1C008804;
        Fri, 15 Sep 2023 19:24:14 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5arh0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 19:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7QKdAfAAYSqpzI4r3omXqMb9GUbtkUGyM4yCWgRLyvZOpuj9nFfYxOqRwOLeRLKvOmS0bI9Y/sxy4mRO9IrP/EF8MVZVdkgFXy8G+h5gOKjKHiIoCZSfXsIRhzTGsx7b03QiV8iDNwfsa3iWlXS2E/ksDcB34AEl6cZwxoRvqzy2edsqlTUbmZSUaMxZSzYs4PZaiTqCHvuCZhq0jQiTFtDpbjkHl56fIW+BV/7YObHJLb5cei7YM0k8uWlJcafHg4Gn1STS1hMnx8EDapZXvi4FkyxfysV+/6kmawG+YMJniA6Hla74B2DiRMhR9QZlaPN33U6v7z8SeSbUxj25g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8JcLhJVjT8gQPp4e4noZLBg3JQm0FGDJI0FGBUENvY=;
 b=gKcfjhIo/SIyhFTXgCGxzwczNXnVR2VC9YFyrNQ2EO5BBKC8ZL2xe5rTcJucpu2qFV/GVUWq1JhEHd9YmqOmgkYAEeyH/jRa63TZR+WMjMaMpcULHYBN2fZrTBHOeEi8+ayjaI0UdHVjx3t8uNGzCAyqK7R98tz/9/os9valKEEWnxGjPzorIoNDPCvtveKcQEf93hF0CrAtGIRLRxKK80S3I2PD3dEogz+ZOpOJH0mvWNtRvzU4VL4NgbGhXq6c5ehW61Pl04pB/HfobLajG7Aa+iWSazS5WL34lNsfeb0SOTXWnoW2mWG4n62VqUbP3S7fw02I8JE6nzpUdFd/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8JcLhJVjT8gQPp4e4noZLBg3JQm0FGDJI0FGBUENvY=;
 b=AZThrKy0YF9UKHk0+287T/+Nd0kyeVjOglcVQVQHAY6aoGohSQh/FCII/3W5Zx1kSo29xWr/snXnK1rJ9mwZaEXPmIA23cTOh7uuGtB/oB2+d5kDo0L9ATMnuegzsw9VKseeyY2gLdThkzG/kMHTzbwe1PToKFxpXR5cPWmMyVk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7038.namprd10.prod.outlook.com (2603:10b6:a03:4c5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Fri, 15 Sep
 2023 19:24:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::bffc:4f39:2aa8:6144%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 19:24:10 +0000
Date:   Fri, 15 Sep 2023 15:24:07 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org
Subject: Re: [PATCH v8 0/3] add rpc_status netlink support for NFSD
Message-ID: <ZQSvV/eZOohnQulw@tissot.1015granger.net>
References: <cover.1694436263.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694436263.git.lorenzo@kernel.org>
X-ClientProxiedBy: CH3P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::28) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 57460f41-28ec-4e95-8100-08dbb62156b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZiYcG+NL1uHDQWdFugpoGGlxAB1Q0Ik5XHW1yxmvQLceJpFrAU9psSZkJ96DyX1J9jQbIYTATkZjXWjKgx75jO9yErHW7OXMxpVCBHVSBM33cOMIcjHcuzLnnJBbRq/iX2Xvzw5QSeYGvzRpXPx8D+7It2m27Xb82OGCZS9fx8KP28AHjNaE8EBrYDavI7gF2Z4/KCwYQ3V4tvj1EnItCVzPVChY/Qy2Obmz+v7AM82ryW7T/qtiLYvnMRPb4BmH43W1497mCFl+7LI/sr1FFcqZG5KfVNLu5d9Jja8wcClml76ydQyD50sj1vr9LLdI9QTo26K2g+rrVfg9OVUrKPlcyZ9/yEqIlPwAFNWEi9pVfntmtnqqiwOlpphPbmzQrNTgcma90O/DbJclDRaoLOAZ4dXM2mRL1nzfjMW+uJakMTVYIaCi/B1Ky9tobxDpHkNgr5xZc3hj73juqHjLTnHVCT3FNYgDcANMqd+Lk27fuxrfVFT1ncm2RiTJC0YA1uyYgvs35AqOe7nT4JzNYLi55E8kk6RswyEuY3ZJXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(1800799009)(451199024)(186009)(41300700001)(2906002)(44832011)(38100700002)(5660300002)(8676002)(4326008)(86362001)(6666004)(6916009)(83380400001)(966005)(9686003)(66946007)(66476007)(66556008)(478600001)(6506007)(316002)(6512007)(26005)(6486002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0hlfZafCOW1R9c9YvRHSDI7HQsAn10HUmDI7KQmST4FH2lTDV8uiwqJy6fLe?=
 =?us-ascii?Q?/zG12Z1umOC/vc9h426c8Tm7j+CnQpWDtWmLuPOzsNdfpvP801cfpoUTxvZ9?=
 =?us-ascii?Q?c1KFSLTHTwOon+6zi1YScY3A46o8Q31X4p8F78puhif5iTh3GtRv5WWSmroQ?=
 =?us-ascii?Q?Xh5N7f9pz/v3Xq9UsVZXY+bYkZTChtPA7QkqzCZzMBz2KGLpWNlhLIK8tqju?=
 =?us-ascii?Q?rymfZhkqgR33JOndo4D/wSi/5Sr9nMOtuXic6JlAc7t1oJuKAXvAPcUTekq3?=
 =?us-ascii?Q?ODj0mO9FSJ6iGpL3En+NviCm/Ks7VX1DCk3nj8rotUdXopuSetLisRn+slFW?=
 =?us-ascii?Q?8VeMNQB9wTQG86LJQsW2v8HdOqo5fVgZxxl8Rsiug1D/d0iDGY7IyzdXq2p8?=
 =?us-ascii?Q?8XtGQsT9OWTYkXAwJb1roBYXLI/07OZbQdel5ver9ueFzSiV9oFmZfmzBt+f?=
 =?us-ascii?Q?n1fyAn7x7MYbPdrv9CdApKAK5b5iPGXD/OXZVx6qw+oJMyzw/FKV/1xSAu2X?=
 =?us-ascii?Q?2wUJf6b9XiOAkebb6XEyf8XvbwU12PX0EOeK2UL13QtMTrecIVLEXtRgONgS?=
 =?us-ascii?Q?74YLUWeO1NExrhdaRufZUbm2tUvrzaFjnqisS4AorfY2p65GYY/l+3XTE8Lz?=
 =?us-ascii?Q?UOovj3XVDvQS0NFv62Vp81gLxuebF1nsxGfkSqzw64G1tFRoAGaBYzxEWKUe?=
 =?us-ascii?Q?ebaPXAhYCCjuCZn10x7IkJ/dcu21ahphL0zao1tmF5/T/xjHjhqNs7dd/35o?=
 =?us-ascii?Q?kcg3CqbBghB7qpYi/loiGaflEBmY+DOePRtjOtOZ42XfPccDQ0ECFrgIlNGk?=
 =?us-ascii?Q?j7cLSXmJm4XNyQbXXhbr/fHm5qxnLQdsW2NYYVz6oDgwJ+vRjnwErc7qmTnQ?=
 =?us-ascii?Q?VpPll9RxOBZvFdUtXyoTxP0jFn9joFUYZzSsuj4g4x2ZjaMDrSxjAEPFmNQ3?=
 =?us-ascii?Q?RCG1o0VnuwoiX/snp1hTbU1VWXrBOpL3ndLSELzjOzQn7qj7kMb9nTzOsTPG?=
 =?us-ascii?Q?EdZVGKBfI38Z+sPKP8DkXXuUCDH9Hgnhi2mWMu2by4M/x+Ckr0qV5bYdqCQb?=
 =?us-ascii?Q?RDe+rZa8/65kpqS64qX3Uj5ueaf1Ka+OiQxWFQo87CAGMNszPc1wMWrLRD7w?=
 =?us-ascii?Q?6O5UzlfXqGiX1oqhJJ00JRWzHAoFvcAyhcmxMy+r5YAUOPAMgODU+K6GBDZk?=
 =?us-ascii?Q?BbqJDi3ju+Sx60Nhvhp6/LJeIU1HrZmE/FZQSuynNaoUtN2fHCM3cor8vFGC?=
 =?us-ascii?Q?2Q/m9HsfbTeZ01TYGHgqe7mbKKS7nMt6yIu7rEeEIIpB0vFx9m8kzUi6jbQn?=
 =?us-ascii?Q?s8DA4GTqQbzntOpp/2tBfeIglchcKrFH1TKXbMndHsyhVbCTRGVEgYFl4kd7?=
 =?us-ascii?Q?cfo2UbYBw+L/BC89RMPCd4DNtC3EnYQJ0CBSxA3az9Z8nr3ZbYXF41zyfAvf?=
 =?us-ascii?Q?5qJncE6Of5CUktiBLSGTuADLTmc4Ktsmop6c+9xSMudNtg/v5of+GphdI2R5?=
 =?us-ascii?Q?NBfNswsin4DocO2g5ENEw8zOEeDHKfJh/d5+ArKNktY3d+1QVb1yuaK9A+Li?=
 =?us-ascii?Q?IMTyWTIzooY1/hy5Uc/4FjqsBaTnDzjOxAU8+h5begMHoNmbQXaDHVKRvULV?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QFp6I4EMcFXlMKQeoFJw0cXwUDruWSln3wYTv+f8sJuqrPTncQvvWcAVG6fBKn9wLWELmWsQDjD/e3N3xF1STriJQdDH4AKgJUGrgajbsGwX7YoEBDKeAwe5a6u0dMR5psFU3uu2Q70548/nLsxN+MoFl8wNtutgBFqs/TkjynMcf/S1ZDNDYfOZ6IynI8xOkYLPzIh4m1aXYkcrOWrFzAWYGgGay4hs2sknq/dskLKlumBjgSAwFy0XQ4bYvrjjysNVFnlR5eowCoDZxGO9vHQd06jhqIxRjKDLTdkDIxZ7wlT8wmhwlGWIerMnXYw9tYiCtIwO9Tx9ROGYUJBAm3Vlk2+aqslpan8ixD8gHN1ExKoA+QguCxyHS6GAZ/CoEvRAbhzrxx7y/S7ccpdZeT0+wLQMvXwe/bxcE7I8fk0LTjVz/F7e5JgojFtCEwGV5Iw1QIaBX1GqTAtCMYKPpLkrcLjNa5PUxxMV8XqHl89kSr4NKgalHAiupzfB/6PJdVECG042TA4c9F3uHpJDsmKFdSanlv3h5YsDQUznuxxbmYmEo2/lgdHuh2VyJzu+ZXlyplrMaRC3RrNE8f3LBDa1cXS48dqiKeI+mR4MlmCfRB4syi3j9IbLTYfV7hz29s2tpa/hMHbR3jyomZnhu4e3ycOq1Bh+ddMH+nl8IcRIPnv3avCPZoZmNJeqO6+rWQXUWRt36pW+OAy6OzWHTN1jSAnCfj9m++/qgbCklwt/I9RFAEAsPrk1tV/EHw4Vs3A36hAljjXgtFsebNxmmGTHsYhPZuU/jSw/jaGj4lCKCWGY+CkBzMOtG34w1BTtKXmkEtjr7IirSOY7+vbGaw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57460f41-28ec-4e95-8100-08dbb62156b7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 19:24:10.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMrYvTHjwYQYfVeLBdeks6Cwvm2ADutzNYmDR3aTpg1b8vkU5pRi0Br5775yg/06DnjmX9X7htGImb++BcUSFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_16,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=925 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150174
X-Proofpoint-ORIG-GUID: MHTbvjmUu61Pvdapy3ol_rxkkn9cxrIW
X-Proofpoint-GUID: MHTbvjmUu61Pvdapy3ol_rxkkn9cxrIW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Sep 11, 2023 at 02:49:43PM +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status netlink support for NFSD in order to dump pending
> RPC requests debugging information from userspace.
> The new code can be tested with the user-space tool reported below:
> https://github.com/LorenzoBianconi/nfsd-rpc-netlink-monitor/tree/main
> 
> Changes since v7:
> - introduce nfsd_server.yaml for netlink messages
> 
> Changes since v6:
> - report info to user-space through netlink and get rid of the related
>   entry in the procfs
> 
> Changes since v5:
> - add missing delimiters for nfs4 compound ops
> - add a header line for rpc_status handler
> - do not dump rq_prog
> - do not dump rq_flags in hex
> 
> Changes since v4:
> - rely on acquire/release APIs and get rid of atomic operation
> - fix kdoc for nfsd_rpc_status_open
> - get rid of ',' as field delimiter in nfsd_rpc_status hanlder
> - move nfsd_rpc_status before nfsd_v4 enum entries
> - fix compilantion error if nfsdv4 is not enabled
> 
> Changes since v3:
> - introduce rq_status_counter in order to detect if the RPC request is
>   pending and RPC info are stable
> - rely on __svc_print_addr to dump IP info
> 
> Changes since v2:
> - minor changes in nfsd_rpc_status_show output
> 
> Changes since v1:
> - rework nfsd_rpc_status_show output
> 
> Changes since RFCv1:
> - riduce time holding nfsd_mutex bumping svc_serv refcoung in
>   nfsd_rpc_status_open()
> - dump rqstp->rq_stime
> - add missing kdoc for nfsd_rpc_status_open()
> 
> Link: https://bugzilla.linux-nfs.org/show_bug.cgi?id=3D3D3D366
> 
> Lorenzo Bianconi (3):
>   Documentation: netlink: add a YAML spec for nfsd_server
>   NFSD: introduce netlink rpc_status stubs
>   NFSD: add rpc_status netlink support
> 
>  Documentation/netlink/specs/nfsd_server.yaml |  97 +++++++++
>  fs/nfsd/Makefile                             |   3 +-
>  fs/nfsd/nfs_netlink_gen.c                    |  32 +++
>  fs/nfsd/nfs_netlink_gen.h                    |  22 ++
>  fs/nfsd/nfsctl.c                             | 204 +++++++++++++++++++
>  fs/nfsd/nfsd.h                               |  16 ++
>  fs/nfsd/nfssvc.c                             |  15 ++
>  fs/nfsd/state.h                              |   2 -
>  include/linux/sunrpc/svc.h                   |   1 +
>  include/uapi/linux/nfsd_server.h             |  49 +++++
>  10 files changed, 438 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/netlink/specs/nfsd_server.yaml
>  create mode 100644 fs/nfsd/nfs_netlink_gen.c
>  create mode 100644 fs/nfsd/nfs_netlink_gen.h
>  create mode 100644 include/uapi/linux/nfsd_server.h

Hi Lorenzo -

I've applied these three to nfsd-next with the following changes:

- Renaming as we discussed
- Replaced the nested compound_op attribute -- may require some user
  space tooling changes
- Simon's Smatch bug fixed
- Squashed 1/3 and 2/3 into one patch
- Added Closes/Acked-by etc

If you spot a bug, send patches against nfsd-next and I can squash
them in.

I was wondering if you have a little more time to try adding one or
two control cmds. write_threads and v4_end_grace might be simple
ones to start with. No problem if you are "done" with this project,
I can add these over time.

-- 
Chuck Lever
