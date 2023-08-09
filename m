Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED9A775FD5
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Aug 2023 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjHIMxy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Aug 2023 08:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjHIMxy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Aug 2023 08:53:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3D41FFA
        for <linux-nfs@vger.kernel.org>; Wed,  9 Aug 2023 05:53:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379Crfes008001;
        Wed, 9 Aug 2023 12:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=yr+Y4dFCwVKqreK8ZWKVqmYKFGg4BB20BpekK3NX2x0=;
 b=2YZSjSAzvvjJ6ff4h3lmWN0vzSt+00zil58F+T7cBMn5YCCz/6d53cR1H37VPdLjQ6Ve
 q1XRSumWgxANTZGr1vdRPrOtoou2LmUqFSBMVRuawtZuLlkq/2dmcQ9OXdpICOH2ql4Q
 b4mXMgxR89H5LFJoYY+I9Nf3onPaKC32LF9LTJVwzb2SRMT6NkOsfdxp2pf2aIa6OpPx
 LoaEmqsW9uf6xsExByvQJjAu2csesFk6SEuTWEKTk9VZ6dVqRyW+hwrmh9l/iY29fv9Y
 RdBuEVmE/bV8e/tzgsI4Ex1+dCIdi01bOhz4N6zB0Q+8XTUFRR8mOeCFOstSeiMjmko8 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9cuerfx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 12:53:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 379C2Ive010581;
        Wed, 9 Aug 2023 12:53:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv6ya0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Aug 2023 12:53:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRfOGH5ZLWFoZWn3OcuCl7EyVz8ajDlGXdV4aKJe347eI8xG2VmFu5ouPjnvrfGz/q0YIGcNRwYFq3cA5UA2nsR80noVD1CzJYW+ERusmoEu3/Km/SJ2fZb0Lz4UPnWpJgwb719DI33QD+utsMeY/2a0TW1S8U6KVhFTwA6iZPYFmrSSwXIouc4DxCMq1fT2X5ZpUn9AJSkXSwmFt8Hqc+hJZueJUi+EWvRzTAQp2UiiRP6+XRG3yiUDd7l3APKTqX+PagB2pAz3upiL3uSx4iD1kgy6cQpa2rhJmqwWsjFXwsPUUfYiLrMONVcLGbW00ZvWWX98rqagcMoOx1SO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yr+Y4dFCwVKqreK8ZWKVqmYKFGg4BB20BpekK3NX2x0=;
 b=nLDORJ667/caWpyG5APOjj2qPl7knGQWaDvd9a4p1XzNpWsTepwO0NErlqpQbIZ3PR5+oNiHaSOyDDLI/wGoppOx+X5YRz7MWxazURJFajoIk14Or7483I/S8sWYDdZFPT9nZvPVA4tNMXP2Cahy5n6lK2Yt7HGnRb4dBlyFDDh39K9GtT1MhZp9dy6mCq4iJYEMljZ0QFP27NqLje7nVOZDWPr/7StlsGgh3lS6tQCuBBM2eoEZ4Bc4fRfSvVZ73h2tEdo8MPUIZA2wIgk5+KYs8n2AZmRJbvczJNqqDFnVR8UWi/tA2iKOq1YxRLQO2AaMYCcYFJvpauM3KjPR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yr+Y4dFCwVKqreK8ZWKVqmYKFGg4BB20BpekK3NX2x0=;
 b=VUUQQQNejL0LsscfF0ZqiaeZfLjNmee80GLUW7O2hxou8imLfVx014ohnBtF1E4aVAlStNspU3IWR2eLSJUa35cwuc2LAyNj1Q18IvFEfxN+yPpuW7D1MVbiscWcAHHDRsg8z28tODkzfxj2jCrIsBmJjBhVJBRCtNP9aWDggz4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA3PR10MB7095.namprd10.prod.outlook.com (2603:10b6:806:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 12:53:43 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 12:53:43 +0000
Date:   Wed, 9 Aug 2023 08:53:39 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.de>,
        linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] NFSD: add version field to nfsd_rpc_status_show handler
Message-ID: <ZNOMU0jejloVhqDz@tissot.1015granger.net>
References: <6431d0ea2295a1e128f83cd76a419dee161e4c44.1691482815.git.lorenzo@kernel.org>
 <169149440399.32308.1010201101079709026@noble.neil.brown.name>
 <ZNJCIRjI64YIY+I0@tissot.1015granger.net>
 <ea598236b2da9f1aa9b587ca797afaa9de5545c7.camel@kernel.org>
 <ZNJLQIxweTaEsu16@tissot.1015granger.net>
 <ed02b06f96eeeca4d499583f2bdf31a433921aa1.camel@kernel.org>
 <ZNKBvgAMnOsDiaKQ@tissot.1015granger.net>
 <ZNNFI7baJW+XGTJS@lore-rh-laptop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNNFI7baJW+XGTJS@lore-rh-laptop>
X-ClientProxiedBy: CH2PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:610:20::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA3PR10MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8fccec-a1ca-4490-388f-08db98d7a90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XM5YyacyGMu6EAlTexq4RAht/mvAlXwJaBhsjTPszUsp977pM5EkrNZ5UiSmgJHj6YLD45wG0LFnTctKetKDVjTidhd+LHoQqp9G6p/wqAslYUtMXbrwif8rJ/SmBCwTa6zY9SKtIlvTiTPvvtQAXNQQViuHHbUv2r2cvgdRjG/nrmPEUzYFH5ZyMG2myBfc+c1r9S2WDktlZ12hljHFUQq0m79/kRbWQBrqYp05SPFH8KE8UAQD9+fhhDQpD0Wyz230JTmO6ApW/qD3NYz0H5KPgCzGK3FcimUoZ4+t0oS5ct/uUnibj38/gPNFQ/XDirdgTTw6HLXXQ7V/+GkIs3yvxZGrxSYhcyNqXwaNoYUGO6lNqsE0nyMzTnLdjPTzRsEmQeFigNQ6YQiXSIJ1abTPZXqRZ3U3D5oIfK+kmnPy5zSK4PlwSyGlZ1fR6gXIq3YMXe07x/vH7WQjZtBxwJgaZJa0uY9vV8IQOtOcMO9A/E1nxB3Ivnpl0ku+K3yWBNaWy1ugPGHlBBAijY0cGj/5QVv+WkbHsSA6uy/aNaSm6A+I9zA7d6/e5YC5aaRx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(366004)(346002)(396003)(1800799006)(186006)(451199021)(316002)(4326008)(6916009)(83380400001)(54906003)(41300700001)(9686003)(6512007)(6666004)(6486002)(66476007)(478600001)(66556008)(66946007)(26005)(6506007)(2906002)(86362001)(5660300002)(38100700002)(8936002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dYcGoRPasILJmkTD4uukRczghrPhCYoADGUyy8RxNsAa2bkSUy6onuVMs6M/?=
 =?us-ascii?Q?/nTkYqYX8VUYX9/OIPKabGaQvPWiFqKC0UX/C3Lyc3vChllel3tBKHG5S1+x?=
 =?us-ascii?Q?5HYYEJNCiqrpZWteyxW7mhzb+1VOF4TWilHU84+ZeFydiHu49SaotESBx81f?=
 =?us-ascii?Q?v/xXJs5r4YQVnZ084vuEBHD3iPZwRQw40IDkLfblwFejBpvCveJ3O8XdrqU6?=
 =?us-ascii?Q?HnI3UJ+RttshzbE2c6KX5SV1ZdH79cQwkGnI8vu0kaBKMzeFaUvvoqXMcFpz?=
 =?us-ascii?Q?pRSAz7NtG6DtVP5aSJake1h/2ifGzSkY2/yXU/K8vnmKBFwV0BbP9gCKOMZA?=
 =?us-ascii?Q?SlYVNYkAGeDuHAqkctqOELne7PK11/QHOhKFk7yl+if3lXg+1c/afETzffOA?=
 =?us-ascii?Q?egkRlBZA7j8J7TMF3iBN8eY958pJ8EfoC+EgPd7x8tkLojYsdY43eqmocBP1?=
 =?us-ascii?Q?65qE4zZZjooFXjFqZAu5mM07PIShAAZX8gyBdvD7d9RdmwCdg3ZBaUYsbfgG?=
 =?us-ascii?Q?DH+VyFsBI23An0ZFDbO6DHxd04NOyx8cMGSHmWvNqpu7K2/2ALEARNtxSTwN?=
 =?us-ascii?Q?rfwVKCjLX407R3V+DJ2aL2xDzMeTmaccq/NT8owJl0hZw0jKOvRCnQ2f5C3A?=
 =?us-ascii?Q?Ja61vNkQHnC/LEmr8ayMGStZYQ7X7l5LBc8KFkS8JHOWf0bovgKpWuMpYQIt?=
 =?us-ascii?Q?haCP2V5PVKhgj5ZKIfTB/Rgua85R7eNCtGy1dczyuqWpAOWmZEH6FiZsgXx0?=
 =?us-ascii?Q?smivypSp3TwRlXlG2z7JKPUjBUVPXu1qiw0zlzRKlV5HTTixV49kpDTBdtuU?=
 =?us-ascii?Q?QOqbuV0b91kB2BTmhP3KzxCld+UCNfqXlssyCpCQX9hMTIf2RPvtXCl2lwoP?=
 =?us-ascii?Q?rVmenG+gi58JgPm/ZPF8Non1uDAvuSQRn/3zAT4BA4hC216GQ25QUGNCMjBQ?=
 =?us-ascii?Q?YoUS4i2DSRgb0+whNf7O1a2OJTADG+HXYHI91GHSXuL3/eEgSEWigGJBTIlM?=
 =?us-ascii?Q?qenD/EWKpunimGqopyZIbTRdWYuGdgVM7lbhHzMbeoY+xHeMhD7wqX3fd2x9?=
 =?us-ascii?Q?lwC3D472ZAoRGdTl/zFsXqjEksqHZSDtdJ+KIqwo168J77azssT/UZTSfd3N?=
 =?us-ascii?Q?Kec0KOrq2BagIghd1JuE8V8oBjpD0D39ioVol6yYW1GMa1Arh0Jo04try9Ne?=
 =?us-ascii?Q?x2dIOyNiEOAQ8pD57j6dPdPpO15TKNVjwWVZiU1DJ04YNgG7zjy//DEpWjwv?=
 =?us-ascii?Q?Am8MT2OJQ/eZtzt6siwzj7DG+NcT+kg+U11vDjaBxxI4epUv6gGSiR4IU/R3?=
 =?us-ascii?Q?SBxUmIb0cpDngGroN9q/3M/VRWGg9CpH7L9ZWffScXOPL0m5fVwiPzqSZHck?=
 =?us-ascii?Q?Ojoe1IOUsOw3qAyS5aeKnb2OCEe67TdFfhLaHPOmcug2YBCzIwj+NIgCcXeS?=
 =?us-ascii?Q?9bOysYMWcSillVYPVPgKFyZy4J9aKGGEulC+p+/lctzeGacnrv/SEkv7DRoL?=
 =?us-ascii?Q?Lk0M2iRAnp0t3JD/ViMI5AQaWOXhB9lpUo5t0QqgTAyRCY6P4zumtNVyAWKt?=
 =?us-ascii?Q?ZlYekvFkRdn+vSwExvAxAHFCgxOijyZLtzgqAq6DILpObzTUoti3FKdbh5Y8?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yD6pls/ISz4gXigjjRLENmB2ET+g4teB4zgboY4zK9WgIO9x0hOMoBNut0pONwUMidAn+i+fpK5y0V48NOAwLceT7+4muWms/VJaSejALxXiwhnDjU4AAUHV1geOtG1YdaP2YN8q1Vu72K5YoEppi/5RJr7Rl+UJLe2E5M3474RIncaMISJlTH8RWGI5XMQ9SCV8lNB1w1leI3PtjF0TBSTjkwt4HOFe98gZrH2ONAgfSDYKNXidu6pfkQhymZ6pUH0iNoouRzUGFGdmGG//ItxCOzA2UyEqefF4usMkQ1gCpBVDBx5y387Uf5K3H00u9Pf3EH54MvfQjxkLaAiZgzYD3SIxeRMwvJiMcV+jnW41X9NEYF8n+d9d2W8OHLlvzhTY1krUHKfs8R1/6fT05mV01UsxpDgxoJzD4trrhNJ5X2p6vrLpqa7ib/iBzk/yF4FaJHhyGIeplSdcC1biHAR2Da+7Q8ZBToyneLGnySD6MERx00sGGAr4uGj+WzDe2TljjnIcdfqdTgsjUttbrld9Ux5yyVVad2kEOQKGbKfNcqSr1CSh6QTqPo5M0eTaankOE5DQeT8sGO4aOcKHeyAjq/4/W26eOssVou7hm3AwSW3UAg9yCck2Ml17b8hiaID2chA4xZp4ZEoLGKYxEpU5XRX6NP3klTVcIJFZuTib+NHPQhMAty5NjQ1FmdbLU2At95di1YrUhIL8U51Lr31uZ5VX1Ub0qsHo4HK5B33il4T4vHCXqMFnnfGrzR6OU7ElbwBMS66YhKEiivIjyZA+VUOx7vInBGLhU6eV89iT4EGGq6BlC+niWu5OG54vgFP9mqTyC7JQ7BjmCeVJWA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8fccec-a1ca-4490-388f-08db98d7a90c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 12:53:42.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmuMFoTGfvPaJds0YVVzo9ExtaRnKXtdoT38BpUyZo//axKG6oGUo1mIpsM7qGT4S7gJw71X7mFqACuYcwTpnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_10,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=490 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090114
X-Proofpoint-ORIG-GUID: M84xFsyfP5kJ8fbh9BXNM-t-LZNXAW9t
X-Proofpoint-GUID: M84xFsyfP5kJ8fbh9BXNM-t-LZNXAW9t
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 09, 2023 at 09:49:55AM +0200, Lorenzo Bianconi wrote:
> > Lorenzo, I'll drop the v5 of this series from nfsd-next. When you're
> > ready, please send another version with the discussed changes
> > squashed in.
> 
> ack, fine to me. Just a couple of questions:
> - do we want to expose the output in yaml or is it enough to fix the NFSv4 COMPOUND
>   parsing using ":" as sub-delimiter (and add a placeholder for non NFSv4 COMPOUND)?
>   The yaml approach downside is we will need to add some specific code since afaik
>   there isn't any yaml code we can rely on in the kernel, right?

Would you mind spinning a series with the simple delimiter changes
and the other things we've discussed so far? It seems we have some
items that still need sorting before tackling netlink v. sysfs.


> - what about netlink? I would say we can have both of them (cat + netlink) so
>   the user does not need to have a specific userspace tool to decode the info.

The trend in network subsystems is to use netlink and a purpose-
built tool, no "cat" support. The trouble with "cat" is we can't
seem to decide on where to put the output file.

Also, I notice that rq_flags appears for each in-flight request in
raw hexadecimal form. That's not especially user-friendly and cries
out for a tool to interpret the bits in that field. (Actually IIRC
there is now a tool that can take a yaml-defined netlink protocol
and perform each of the protocol's operations and spit out the
raw results).

I'm wondering if having support for "cat" is really just an old
habit we need to discard.


Re: netlink... folks should keep in mind that the output would not
be yaml. netlink uses yaml to define the netlink protocol, which is
quite like SunRPC. This still meets our extensibility requirements,
IMO.

Creating a netlink protocol would provide a vehicle for exporting
other information. Once there is an NFSD-specific netlink protocol,
it's straightforward to define an additional netlink procedure for
any of the information that are now available in /proc/fs/nfsd/
files.


> I will work on v6 as soon as we have agreed on the points above.

Thanks, I appreciate it!


-- 
Chuck Lever
