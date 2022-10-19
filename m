Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329B7604B06
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 17:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJSPRp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 11:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJSPRb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 11:17:31 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA211CC76E
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 08:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxcMAHgFTHI2TnxoHpA42q0pBoDDRvIejC49eu8yh/jU2wTHzmYgDZC5xMOFECs2nvOqWsF7IfuNS4NdLbnhRpFLt7HVJacoYsc5PgC5tgiyI7KDoMxXxvlXup/kk6hkLiE+Ek/CSYImhkcL1UdHPIq4rBbcpgp1VQE4bYhnE6P7pSn8UZRei5uAeFEhUbqtboPpwxnjo3WjV/VuzosbI/6Hbv05aDR20bDMikL/bZsTZ7MNlBXtuNei3kSszNKHcLdjJ4I68QK5UsmByqa69vrH7TYMg/I/6tE97pnBDi9VxXLRx1++cGVnoxc5dBmpaX6Ha5RfkSE5Nw/gkAq6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kI9s1gOpmi6s+3n+TH8u/UhW8W9kkN05SBMg2kYhRc=;
 b=Eo7HBMsiM5ILIMB3v0ilZHD0yA6rSun0pNXKeMc/GIWkz54sg//R/HRUx+x3XJlC2IOt1CFqDP82+/3H+XupAyIJCRSTKCigSYBi5U70CJPaAtoBntY0a76FyqyLMbe3K6LiI7efdJ9CdLX8gCuGoSqNa88gXODvPXgKCSZvlcjDbhHStb60h40CMxV3oZJpFJyo7LRUznh+X/zNtyM2ePiTlC2DbO9kkwkXIHKDwBh6wt+wdTG6H7wr+OjM5fuo7yXRh+okP73symldPYMNu5xTwtwVvBnDjWYN6CS3BxJsM7tess2KQGqNYrmbF7Ywwf5Jb1efiNoJ0yz1tFPZ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from BL0PR01MB4434.prod.exchangelabs.com (2603:10b6:208:81::17) by
 BY5PR01MB5732.prod.exchangelabs.com (2603:10b6:a03:1c3::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.32; Wed, 19 Oct 2022 15:09:11 +0000
Received: from BL0PR01MB4434.prod.exchangelabs.com
 ([fe80::28a9:57b1:9a6:c5d4]) by BL0PR01MB4434.prod.exchangelabs.com
 ([fe80::28a9:57b1:9a6:c5d4%7]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 15:09:11 +0000
Message-ID: <865a1b1f-811d-312c-4141-31e572b37679@talpey.com>
Date:   Wed, 19 Oct 2022 11:09:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 3/3] nfsd: allow disabling NFSv2 at compile time
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <20221018114756.23679-1-jlayton@kernel.org>
 <20221018114756.23679-3-jlayton@kernel.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20221018114756.23679-3-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:32b::21) To BL0PR01MB4434.prod.exchangelabs.com
 (2603:10b6:208:81::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB4434:EE_|BY5PR01MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: d651d721-925e-4568-75e8-08dab1e3e02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D99xvgePAmYpE74Sy+8nWG1Oc8qfnMgOF8+Nji6CCU+h1R+KMnQ1fXW5kPuxrsurwyRz8y2vRPwKhfeeiXGUqo6rgOz3r8B68R2+rvXLQi/Y1YHgLPl8FJk6JIkITAxS8bmp9Y0wXw4Oouhub14+NZRILrC/uFvGzp9wzohLIUXzI2Kc6L8bWcZe5ovv2zW/7m8xSuWvmeOEbYTcje5xJT2V0hTESG11K9+pZBi0DZxj26krxrk1oKLRhKnlkrT+mVyPpVfeyNnLODt0sUud/vbZfTmEu4kE4ZiGD87nooGcIc8iJyyGB2MM+LTW+Z/55n/fBLFRMoyIWhTclEl4+g2w8RuzhKPS4ityQDlgQFJlTWm+b8FjUzrxp0k1qcYArfd15cFzGZ9Rpv50CcA+K3EYMX7ciUsyKh7EZeaKI+MO2z3KUK+i/BnXxaGrH9B3UnjnO/+u+pm7tTEzz+DoAErAHbTeNe/ME4rDGLqIquxTZ7QQIafpl3UNF6db/hbLHuWAZNA0pzhH29tAmyz0FJ9w69iSD12vjyhizUB7oMFh9+jL+YubJ+kW6p0zOcWbdyPmOQfrEUIoGCTmzbS5TWapOvTRoNO/u9HG8PmqDSEaVcTR44vFsAb3txNpy90saXcQ3RUEQ3pKDA7FnsUd14URevhPf3gfJc4RZpg7e0uZ12C62cpgXbjODxTtts0rtVslPDsBeAhqoBn/LT47G3nl60mgDZS+TtzshvogDoGEZpHCn5mz8ehuTDJzGSNElSodYz7Oo/AwcttHLSTMqRTqEyL90aMQzXGxFoTv9BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB4434.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39830400003)(136003)(346002)(396003)(451199015)(36756003)(86362001)(31696002)(38350700002)(6666004)(38100700002)(83380400001)(66946007)(8676002)(316002)(31686004)(2906002)(5660300002)(4326008)(6486002)(186003)(2616005)(26005)(8936002)(66556008)(66476007)(6506007)(41300700001)(478600001)(6512007)(53546011)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVpMmZFRFJwTmRaMnlBTHpuV0JZdFc1RXJlVVo1NlRyOERtRDlBbSt2ZERD?=
 =?utf-8?B?QkcrM3VkRUFXd2hscDUvem1Pb1lTcE9sRE0zSlJ4eUp1YUNNLzl6dnZJR0hs?=
 =?utf-8?B?YkpxZ3RNNWNoUG5xcVpkazJtUGIvNFhtWWlSajhIWFllOFg1ZjhQby9zYU1Y?=
 =?utf-8?B?NUkzMGZWaEVuTXdxQ0tXNkFzRHRpTm9WSE1EelZKWTFsQkVPMEUyaHU5cmNu?=
 =?utf-8?B?TGZSRFRvWStlL2p0emhjYlNCZHJUdmRSNk91aVBZQW0rM3V4ZkFqSkpyS3ZZ?=
 =?utf-8?B?MG41eml1emNQTjMvbHRmS09vS2hVdHUzY1RSblZZM2ZkUjNVUjBvdHlTanB5?=
 =?utf-8?B?eVVQbDNXNUppVUdEbnVhTHQ4Vzd5b2NmV0xDeU4rS09vZVZGV0pZNzdaenJ2?=
 =?utf-8?B?TU52R29TejlYcEo3SzcwdE04QXlsWm9YZHl6RnppdngyUm1mTnhEdklYVXAy?=
 =?utf-8?B?TmNqT0tpN2hMR3hZc0F6TDRQQ1VWekM0L1doLzFVS01FRWlLTGsvNjM0OHNq?=
 =?utf-8?B?cjVncTNQTUVya2VDNzJaOXRvb1B0TzhVRFZBYk1zelNQdkpPbm5RUExzejRs?=
 =?utf-8?B?ZmhQWjNpTDR6UUlPR3AzVHlaZlhyTDNMbFg5ZjdtSnRIVXBmckdSeUNJSk9a?=
 =?utf-8?B?Sk5CSk5ZUTBRQVRUUE4yVFlJdjBBZXAvbXpHc3I1NmhwdXZ2cGx4bjlWWHpz?=
 =?utf-8?B?UUE3U2FqU20zZTJpd21MTHB4WGRORjl2cUxzWUIrVDFUdUNmcnpIUCtKSzd0?=
 =?utf-8?B?OGdnVGRDUnRhY2dvWGJGTDVpelFjSSt5S0lFVzB4TkxSbWhkTzhNV2NCUWdP?=
 =?utf-8?B?cDMxUTNNbGV6dldQQzgwakExS0ladjZWUjNVYk56aC9kMmZRS1JZQ2lrdkwr?=
 =?utf-8?B?SFRUM05jc3crTDNmd2lqbS82V1dMWWY1L2RHNWJWdVhUV1l4MUhsTFQ0dEE5?=
 =?utf-8?B?VzA3NmpXNHIwTkJ4bTRWT1VSUUdFNFRPdHhxaER3ZHcrdDlkeGh4WnZGc1gw?=
 =?utf-8?B?dGY4a1FMYjZzSHFTQXlhc2UwV0E2RWNmblI0WUl0ejVnYXZQV3ZMLzBaUlNw?=
 =?utf-8?B?OXdrUWpZQWxFZXgvNjluQS9EZGw2NzNMYXNCU041dzlGN0praDlDQ25vOENE?=
 =?utf-8?B?ZHZ5aGxUSXNMbFFVVDgwSU9OcGRNbkE1cG9mNTQ4TE1ES2g5dkpicXFoa2do?=
 =?utf-8?B?SjZqT0o4NmhKUHhsKzZJUUFGVzBXYzcxNHNIV2VjTlZucGdCeG1YYm5wN1JR?=
 =?utf-8?B?NlM2SHpNOTQwZmZCQ1ltUTJiZ05ueTRaY1dVQ2FaTEozS0ZUVG1oSkNSbWFQ?=
 =?utf-8?B?amdIeitQZzV6Y1lpeDVNWExnK2IyWWtJdndlSzJyL0lnSlc3RHNqblY5SjVR?=
 =?utf-8?B?T2NRZkJCV2dGcEFhUklBVVN3VDQ4UmtwZy9iU3hyUUgySlZSZVdMcnZjQ0Jq?=
 =?utf-8?B?NG1taVJaNGV0MnIxSmVjUlJjaWtKL3RhRkF5ZnNMcnozM05qaE5hT2xHbFJN?=
 =?utf-8?B?SDYvNHVPMUozaVh3VjMxVzNUQkU4dURwMTJFUFZRQmc2bW5veW56VE1zQ1Nj?=
 =?utf-8?B?TC9SdmZGUzZsbEYwcUZnOTEzUWZvdXozWkw4RGZJSUd3MU5ibnptRTVIS0Js?=
 =?utf-8?B?bDErVTA4UGxoMmVSbnkvbHlxWXlraks4dFZNaVRrL2V6dldVbVpFRHBRc0ov?=
 =?utf-8?B?bWdSY0hRRDZnb2RHcE03S1VnTTJMbTRTeDZPL2tBVW8wYVowTldmaWhmWmtP?=
 =?utf-8?B?NFRiVDlGaU9YSDFLQ3FvKzd5Q284MDRCc1hSSUVicXJNNjFKSllQWGxLK2Fi?=
 =?utf-8?B?aC92RWgyUW05NHFnWUM5OHk2c3pCdXlXN3pSU21LTG9JYytHaVNnc1AxNElp?=
 =?utf-8?B?ZURLRmNJdDlvbXBGaklEN2NQQ3kvSXdjR3pBci8xWkdzemVCaXZkSWdUbzJL?=
 =?utf-8?B?YjRlZEtxZHh1QzV5OFJNTkxidzNGeUJwNU9VU2IyM2k0cm9ZSU5CUGJIeERR?=
 =?utf-8?B?WnJRZXByYSs4cFRLdlc4d0ZnaC82bDkrVDNIRExUZ2pid1ROSDlKY2pnVVBh?=
 =?utf-8?B?ZDhFNFdEeEhlcnd4WmxPdnZkWFJmQ3greEV5Nm1xY2V0bS9NaWpMTXVEWUha?=
 =?utf-8?Q?dub8=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d651d721-925e-4568-75e8-08dab1e3e02d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB4434.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 15:09:11.2957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaOEsspovB4WtL7gNCe20WlDv3hv0MvuWc0EvxF4b4xzLKSXKRDsW1YQcjGJpm73
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5732
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

LGTM

Reviewed-by: Tom Talpey <tom@talpey.com>

Next, to make it a module!

On 10/18/2022 7:47 AM, Jeff Layton wrote:
> rpc.nfsd stopped supporting NFSv2 a year ago. Take the next logical
> step toward deprecating it and allow NFSv2 support to be compiled out.
> 
> Add a new CONFIG_NFSD_V2 option that can be turned off and rework the
> CONFIG_NFSD_V?_ACL option dependencies. Add a description that
> discourages enabling it.
> 
> Also, change the description of CONFIG_NFSD to state that the always-on
> version is now 3 instead of 2.
> 
> Finally, add an #ifdef around "case 2:" in __write_versions. When NFSv2
> is disabled at compile time, this should make the kernel ignore attempts
> to disable it at runtime, but still error out when trying to enable it.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/nfsd/Kconfig  | 19 +++++++++++++++----
>   fs/nfsd/Makefile |  5 +++--
>   fs/nfsd/nfsctl.c |  2 ++
>   fs/nfsd/nfsd.h   |  3 +--
>   fs/nfsd/nfssvc.c |  6 ++++++
>   5 files changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index f6a2fd3015e7..7c441f2bd444 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -8,6 +8,7 @@ config NFSD
>   	select SUNRPC
>   	select EXPORTFS
>   	select NFS_ACL_SUPPORT if NFSD_V2_ACL
> +	select NFS_ACL_SUPPORT if NFSD_V3_ACL
>   	depends on MULTIUSER
>   	help
>   	  Choose Y here if you want to allow other computers to access
> @@ -26,19 +27,29 @@ config NFSD
>   
>   	  Below you can choose which versions of the NFS protocol are
>   	  available to clients mounting the NFS server on this system.
> -	  Support for NFS version 2 (RFC 1094) is always available when
> +	  Support for NFS version 3 (RFC 1813) is always available when
>   	  CONFIG_NFSD is selected.
>   
>   	  If unsure, say N.
>   
> -config NFSD_V2_ACL
> -	bool
> +config NFSD_V2
> +	bool "NFS server support for NFS version 2 (DEPRECATED)"
>   	depends on NFSD
> +	default n
> +	help
> +	  NFSv2 (RFC 1094) was the first publicly-released version of NFS.
> +	  Unless you are hosting ancient (1990's era) NFS clients, you don't
> +	  need this.
> +
> +	  If unsure, say N.
> +
> +config NFSD_V2_ACL
> +	bool "NFS server support for the NFSv2 ACL protocol extension"
> +	depends on NFSD_V2
>   
>   config NFSD_V3_ACL
>   	bool "NFS server support for the NFSv3 ACL protocol extension"
>   	depends on NFSD
> -	select NFSD_V2_ACL
>   	help
>   	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
>   	  never became an official part of the NFS version 3 protocol.
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index 805c06d5f1b4..6fffc8f03f74 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -10,9 +10,10 @@ obj-$(CONFIG_NFSD)	+= nfsd.o
>   # this one should be compiled first, as the tracing macros can easily blow up
>   nfsd-y			+= trace.o
>   
> -nfsd-y 			+= nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
> -			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
> +nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
> +			   export.o auth.o lockd.o nfscache.o \
>   			   stats.o filecache.o nfs3proc.o nfs3xdr.o
> +nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
>   nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
>   nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
>   nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o \
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 68ed42fd29fc..d1e581a60480 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -581,7 +581,9 @@ static ssize_t __write_versions(struct file *file, char *buf, size_t size)
>   
>   			cmd = sign == '-' ? NFSD_CLEAR : NFSD_SET;
>   			switch(num) {
> +#ifdef CONFIG_NFSD_V2
>   			case 2:
> +#endif
>   			case 3:
>   				nfsd_vers(nn, num, cmd);
>   				break;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 09726c5b9a31..93b42ef9ed91 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -64,8 +64,7 @@ struct readdir_cd {
>   
>   
>   extern struct svc_program	nfsd_program;
> -extern const struct svc_version	nfsd_version2, nfsd_version3,
> -				nfsd_version4;
> +extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
>   extern struct mutex		nfsd_mutex;
>   extern spinlock_t		nfsd_drc_lock;
>   extern unsigned long		nfsd_drc_max_mem;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index bfbd9f672f59..62e473b0ca52 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -91,8 +91,12 @@ unsigned long	nfsd_drc_mem_used;
>   #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>   static struct svc_stat	nfsd_acl_svcstats;
>   static const struct svc_version *nfsd_acl_version[] = {
> +# if defined(CONFIG_NFSD_V2_ACL)
>   	[2] = &nfsd_acl_version2,
> +# endif
> +# if defined(CONFIG_NFSD_V3_ACL)
>   	[3] = &nfsd_acl_version3,
> +# endif
>   };
>   
>   #define NFSD_ACL_MINVERS            2
> @@ -116,7 +120,9 @@ static struct svc_stat	nfsd_acl_svcstats = {
>   #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
>   
>   static const struct svc_version *nfsd_version[] = {
> +#if defined(CONFIG_NFSD_V2)
>   	[2] = &nfsd_version2,
> +#endif
>   	[3] = &nfsd_version3,
>   #if defined(CONFIG_NFSD_V4)
>   	[4] = &nfsd_version4,
