Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F35601B31
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJQVWd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 17:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJQVWb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 17:22:31 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3716D2871B
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 14:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlnXRp4tiUIMCKduOs12LNdsuW5Ka8Gr9PUKlwwKV8ilYaw+7rNwqA8Ed7FqWnBXbehyvQw8B9pwarNmHJhCjtAgJXMAJK9tPprf/v0wptGNGzumLolX3jvnbXMIrDnBY1YImr92zPn43cD9/8+Jwlz0mOSUMG3eaubhRtc2W1SWw7XsSYyfvN91nnswSWu0aTz38A6cbe+w+wIPnG9NzQq4ftWeh87ThcM8l0T8I1AWgHbRUaZ+FdtKsW/HF/VclqFffc4CeAFqb8z1zKIhmKwfep4TMn+80UdMmF8FxlnIvSrRRZnXGU7QZkHfFiY7s3o29fB5lhbTXFpPam81AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFZjDo75sE69gVUEKYLPrlZoajYhhir/drvpgJMs6QM=;
 b=Y5Oh1eN5WO6fgLnHPO8Skuyi52LQsLUYPv9sz5t5m4KXr+BPGWu3rElP88IKeIDZMJPFwKpbuaf6/BbB5A6rESFunyS/jN0gVK8vjRtUttilZD/cONp6qbiqZV0iwd74Gj8a0h1z37kDq/UpogGbWORTQZBiW/4mUZpzK1N6cIg/mbIjzsI/bMHtOxbrBY66ZDvNHe2pHBPMeyXvVHojSXozEroI30B+YSvTKMNvRgtfRlurfLlO9J1x4czo+UzET4Umyp34eCP68PRqkGK0ecRjiWJLb0bO+JPZt0c2WLXwWnBqMjVs0HUwELV8FUXBzcSoZ0xQd+WOs4oZrpAl2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 DM8PR01MB6853.prod.exchangelabs.com (2603:10b6:8:30::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Mon, 17 Oct 2022 21:22:28 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::454c:df56:b524:13ef]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::454c:df56:b524:13ef%5]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 21:22:28 +0000
Message-ID: <5a3646b2-685b-1fbb-ab8a-2c4a8449a647@talpey.com>
Date:   Mon, 17 Oct 2022 17:22:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/2] nfsd: allow disabling NFSv2 at compile time
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20221017201436.487627-1-jlayton@kernel.org>
 <20221017201436.487627-2-jlayton@kernel.org>
 <0A1BE7DD-070F-4427-823A-92866DC7C9A9@oracle.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <0A1BE7DD-070F-4427-823A-92866DC7C9A9@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0104.namprd02.prod.outlook.com
 (2603:10b6:208:51::45) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|DM8PR01MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c4fa32-f5eb-489e-bbbd-08dab085b187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZdgNoMg7hFfv2leAlDr/EJlV5MtPJbQNbzy6Pi2EwNN0vZ5RgSBkCAB2pYXahexNuvBxxoFpaYiIgnQQpgGUHCRQvF9MKI4TsMR/2vBqZC4PD9VFCYjgzQg0L+mHISICb78nnqKzTvYPyrG8HbaLtTN2vPqAXHph96zYesex09Zn2pTtvQdcFlChwCOqYMcLZyu/XWlcyQMuk4mFEtXc/8Eh1zSQz2Xl2rQBN/uUmN8uW5MwlD0MqbXH18z/KAOjovHVA5Qa45jBd7azTSWj2awrl6pW3VXvBZF/bMv8EhXHweWGEHiPlbMz91iboa3wcvTPtMn0dQdwTahKyiKDB5m2j/0nNEFszVkvZtFDHGOfLJS8txtZkrgDXgFrQiMN6E3LuJpcULEGRyMk9+XHa+iF4/z7q4h19cpAiAdJnwav0yerZ/maDmvq47oVAyOxfF8P93XNQsxJPjEco48JYBtRB0FzxZ7YXaXTQau8ngO/VAN/IvkwZVa8L5h6FTSOFuMAucbuov2AHFtIEYJamTsCaNFyuJZcCZj+q43rDTpKVMNEeNNQPD0Zl9rcTWmnJAiFt/3EEvfZNdtQqMoB4y3f95eCclFeVDY236Azxclg0EPfIqUUArsJQib4gky7b2nLXpF3NyW2/9fN6OXZzy8DoNNmSjIoLVGMWIoWM8Bh6QnG/IruY5Bm7VrNNt9B0fQk9lQhNFP/EBMZhH96zsGuAX6YxmdfAJC7f5e2I6teotVD3HL5nwzSXiEuYd2kwGXwWDUO0bzLEESDkyLR49II2gzC+nNLT3I9jdS7GU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(376002)(39830400003)(366004)(451199015)(31686004)(6506007)(36756003)(2906002)(8936002)(52116002)(5660300002)(38350700002)(31696002)(86362001)(53546011)(4326008)(6512007)(186003)(26005)(41300700001)(2616005)(478600001)(8676002)(6486002)(66946007)(83380400001)(66476007)(66556008)(38100700002)(316002)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJZVU56a3A3bGxSWmFhdkxIdTRqVGFCaGpoaGRXRVVSMEp5d0t1amZQNzBz?=
 =?utf-8?B?TnZ0WXZrQVJvNCttbEo4TDVyb2RCcHZaaEpmWlZHalhMTVhGTldjWnFXRXJm?=
 =?utf-8?B?bTFaT1RNY0RybVY4UlppZzlVQm5SRDlqR2N0MzRyOXZtYmRLN3FjQlhQOXR1?=
 =?utf-8?B?Z3hUV0JBMjZlbzhlLy9GaWNJUllKTk9EMEU0TElxQUxRMHRpVFhzb1NoVm5v?=
 =?utf-8?B?bGIyaTN2Zk9vdmcwZUt1d0ZSUWVraS9TS1pEeHVZeTZVUEtIakt2MGRkTThp?=
 =?utf-8?B?RjZWSUtWVnlRTDJPVHRPb3dMZHJKRXVHOTF5OEFISFdDcllWUktrRjlxeENC?=
 =?utf-8?B?blM0QWtOR04vdEd3ZlQvUEgvYmlpK3B5dzFDSVAwUHRHNUcxb1lHTzQ5Mnpv?=
 =?utf-8?B?dm0vRGtlUmovcnBNcG02YTcxbFd4UkN0WFZoZ1ZrRmFGbElJUUpabVcySWVU?=
 =?utf-8?B?R0NPT0VVekRadVJlL29WaVMwQVpWZGNjUVlPaStNZU5RQzR2ZHpFN1RXYjc4?=
 =?utf-8?B?akEwbEFPb1J5ME0zTHRrMEp4ZDBrNUgzU3dTc0JBY0o0bTIzRlNxZ3pyQXFh?=
 =?utf-8?B?R0hXZCs3aWI2RUtTSU10SEFiTE1LVkNzK0pwVE00ZTk0RllYRzUwOW5vcFhL?=
 =?utf-8?B?TEk3MHNWK24wa1Joei91ZllnMTVXWTlaOEh0TGl1WXQ5NjFsd05hYlBlb0c3?=
 =?utf-8?B?UWZGNlhDSzlSY1JLUHd3eCtNZWVPbGVHS1JTZTdoVUk4WE5PRFVyMHdFc2hu?=
 =?utf-8?B?TEwvZkZKdUNBZFpqVEp4MDlMUUlNYUJHUE13d1d5UGJlbFNuOFRNWVBOWmdr?=
 =?utf-8?B?MGdQbm8yY0RmN1BXRFJmYy8xSWt2MndOOFNpd1ZaZVlvWXQ1LzVhT0tuTGxY?=
 =?utf-8?B?QXhoOGM4Q3ZGOEczYkxIdGpybXpZTkN3ZzBmcVIvNDlyY2VlRDBXQ2JMUnd3?=
 =?utf-8?B?eWpmcS9Ob0hRR0VOMHVxZEx2c1ltcTg5MXNyRTJLN3pTdmVEMU4wWWhOejBI?=
 =?utf-8?B?MTN2SGZ4NDE3M2RrK2lXUjliWjdmeDVFT082TnJrMDZENytSbTlPY0EwL29R?=
 =?utf-8?B?N1Nhd1pkK1hRL2VjK2JIdXI3OG1JUE1kZlBwUXZ6b0RHK0drQksrTE80OXl1?=
 =?utf-8?B?SGlCbmUvSEhRejI3ZXJTR2l0ZnhsVExQcTJZQ3dXM1EyaVp4WkFBVVdOeGhn?=
 =?utf-8?B?dVE5UHFGWXJxTnZ4WEZXRmNwVmlkb1VUNGtibEJRT1lvWXo4RlpVSUFsazFY?=
 =?utf-8?B?ak1GQ2dXdERSc09SNjJxVDlKcHJKcU1PaWFLdzlXSGI4NE05bFh1dUlOVGx2?=
 =?utf-8?B?UjZpbVFWYkZ3WG8ydytpRFdicGJXUW00WldyRTJic3V0anBOeThkamFDUFdY?=
 =?utf-8?B?MU1xWUxBaWZ6TFRicXZtNWMwNUdVK0VKRDBqUGUzQURkWVRQUG51a2RtZnVa?=
 =?utf-8?B?M2tnMjRyTktaeTZBY0RwOHdsVDBINWVlc2FBRnNUblBSVElsTHBQSjEzM1pv?=
 =?utf-8?B?TUhnM0FCQW5TN1NFa2lSZDROZnNCcm9RRDh3dUdZc3FaVEdFWlpFNFpjSlYw?=
 =?utf-8?B?cGRFL1l3QlhLemtuUkcrUWJFWGFSOUUrK0hVRCtNdnYxYXorcytoVnhVWmxD?=
 =?utf-8?B?N2pBVXk2K2xaQUwxbWRFK1dLZHFVck1kOGpDaTQ4alc5RDBhUGxVWFdlcEdU?=
 =?utf-8?B?QS9ReUIzbWtOcldSTXZxNGVRTGF4NDJXVzVoaWRoMzlseGVwVW9nREdnV1BC?=
 =?utf-8?B?Z29NMVdyUmV1TmVUYTBqT1dVSmIrd0lDcFIrNHpWTlZGS0Y3bFd6Y0htdGw2?=
 =?utf-8?B?NTNGbDNyZ0NnVlpzc2R4dENBc21ZQzZNLzZRRFQ1ZHp5NmFjSWQwWW1SQkl0?=
 =?utf-8?B?YWo5SWk1ZVM1ck52RXkzU1hSVE44czdvNGxFSitrT1pLZGhXQWtlWXpNSUpa?=
 =?utf-8?B?WkNoblRoWDl2ZTgzMVFaYmFmeGF6L3JsZ3RJZ3p4WEZ5Z3dSVWVWY2ptcFBa?=
 =?utf-8?B?NEVTREpyRjd0UGhmS1RRbm51VmJEQ05EQjZLVDNhOUdTbHp2NVZ5eGZVeVRl?=
 =?utf-8?B?ZkJjSzdHT0U0M3FWWFdjbWFMVm9uT1dTb0JMZHpHNlp2dlZWL2hjSlVlVTNa?=
 =?utf-8?Q?/KLU=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c4fa32-f5eb-489e-bbbd-08dab085b187
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 21:22:28.3354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFfRmkqI5n6XDU/PPQsd3/VsV+a8m9xpFXHEbJ7r/TvHzppb8Ltpr0mwFxNzlJHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6853
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/17/2022 4:25 PM, Chuck Lever III wrote:
> 
> 
>> On Oct 17, 2022, at 4:14 PM, Jeff Layton <jlayton@kernel.org> wrote:
>>
>> rpc.nfsd stopped supporting NFSv2 a year ago. Take the next logical
>> step toward deprecating it and allow NFSv2 support to be compiled out.
>>
>> Add a new CONFIG_NFSD_V2 option that can be turned off and rework the
>> CONFIG_NFSD_V?_ACL option dependencies. Add a description that
>> discourages enabling it.
>>
>> Also, change the description of CONFIG_NFSD to state that the always-on
>> version is now 3 instead of 2.
> 
> This works for me. I'll wait for more comments, but I plan
> to pull this into for-next soon.

It's a worthy change, but it's only a small step along the way.
Distros will still be forced to set NFSD_V2, because they'll
want a way to allow V2 support but there's only one V2/V3
module to package it in. So, they're stuck turning it on.

But, shouldn't this at least squawk if the admin attempts to
enable V2 when it's not configured? I don't usually suggest
a message in the kernel log, but this one seems important.

Tom.

>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>> fs/nfsd/Kconfig  | 19 +++++++++++++++----
>> fs/nfsd/Makefile |  5 +++--
>> fs/nfsd/nfsd.h   |  3 +--
>> fs/nfsd/nfssvc.c |  6 ++++++
>> 4 files changed, 25 insertions(+), 8 deletions(-)
>>
>> v2: split out nfserrno move into separate patch
>>     add help text to CONFIG_NFSD_V2 Kconfig option
>>     don't error out in __write_versions
>>
>> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
>> index f6a2fd3015e7..7c441f2bd444 100644
>> --- a/fs/nfsd/Kconfig
>> +++ b/fs/nfsd/Kconfig
>> @@ -8,6 +8,7 @@ config NFSD
>> 	select SUNRPC
>> 	select EXPORTFS
>> 	select NFS_ACL_SUPPORT if NFSD_V2_ACL
>> +	select NFS_ACL_SUPPORT if NFSD_V3_ACL
>> 	depends on MULTIUSER
>> 	help
>> 	  Choose Y here if you want to allow other computers to access
>> @@ -26,19 +27,29 @@ config NFSD
>>
>> 	  Below you can choose which versions of the NFS protocol are
>> 	  available to clients mounting the NFS server on this system.
>> -	  Support for NFS version 2 (RFC 1094) is always available when
>> +	  Support for NFS version 3 (RFC 1813) is always available when
>> 	  CONFIG_NFSD is selected.
>>
>> 	  If unsure, say N.
>>
>> -config NFSD_V2_ACL
>> -	bool
>> +config NFSD_V2
>> +	bool "NFS server support for NFS version 2 (DEPRECATED)"
>> 	depends on NFSD
>> +	default n
>> +	help
>> +	  NFSv2 (RFC 1094) was the first publicly-released version of NFS.
>> +	  Unless you are hosting ancient (1990's era) NFS clients, you don't
>> +	  need this.
>> +
>> +	  If unsure, say N.
>> +
>> +config NFSD_V2_ACL
>> +	bool "NFS server support for the NFSv2 ACL protocol extension"
>> +	depends on NFSD_V2
>>
>> config NFSD_V3_ACL
>> 	bool "NFS server support for the NFSv3 ACL protocol extension"
>> 	depends on NFSD
>> -	select NFSD_V2_ACL
>> 	help
>> 	  Solaris NFS servers support an auxiliary NFSv3 ACL protocol that
>> 	  never became an official part of the NFS version 3 protocol.
>> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
>> index 805c06d5f1b4..6fffc8f03f74 100644
>> --- a/fs/nfsd/Makefile
>> +++ b/fs/nfsd/Makefile
>> @@ -10,9 +10,10 @@ obj-$(CONFIG_NFSD)	+= nfsd.o
>> # this one should be compiled first, as the tracing macros can easily blow up
>> nfsd-y			+= trace.o
>>
>> -nfsd-y 			+= nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
>> -			   export.o auth.o lockd.o nfscache.o nfsxdr.o \
>> +nfsd-y 			+= nfssvc.o nfsctl.o nfsfh.o vfs.o \
>> +			   export.o auth.o lockd.o nfscache.o \
>> 			   stats.o filecache.o nfs3proc.o nfs3xdr.o
>> +nfsd-$(CONFIG_NFSD_V2) += nfsproc.o nfsxdr.o
>> nfsd-$(CONFIG_NFSD_V2_ACL) += nfs2acl.o
>> nfsd-$(CONFIG_NFSD_V3_ACL) += nfs3acl.o
>> nfsd-$(CONFIG_NFSD_V4)	+= nfs4proc.o nfs4xdr.o nfs4state.o nfs4idmap.o \
>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>> index 09726c5b9a31..93b42ef9ed91 100644
>> --- a/fs/nfsd/nfsd.h
>> +++ b/fs/nfsd/nfsd.h
>> @@ -64,8 +64,7 @@ struct readdir_cd {
>>
>>
>> extern struct svc_program	nfsd_program;
>> -extern const struct svc_version	nfsd_version2, nfsd_version3,
>> -				nfsd_version4;
>> +extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_version4;
>> extern struct mutex		nfsd_mutex;
>> extern spinlock_t		nfsd_drc_lock;
>> extern unsigned long		nfsd_drc_max_mem;
>> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
>> index bfbd9f672f59..62e473b0ca52 100644
>> --- a/fs/nfsd/nfssvc.c
>> +++ b/fs/nfsd/nfssvc.c
>> @@ -91,8 +91,12 @@ unsigned long	nfsd_drc_mem_used;
>> #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
>> static struct svc_stat	nfsd_acl_svcstats;
>> static const struct svc_version *nfsd_acl_version[] = {
>> +# if defined(CONFIG_NFSD_V2_ACL)
>> 	[2] = &nfsd_acl_version2,
>> +# endif
>> +# if defined(CONFIG_NFSD_V3_ACL)
>> 	[3] = &nfsd_acl_version3,
>> +# endif
>> };
>>
>> #define NFSD_ACL_MINVERS            2
>> @@ -116,7 +120,9 @@ static struct svc_stat	nfsd_acl_svcstats = {
>> #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
>>
>> static const struct svc_version *nfsd_version[] = {
>> +#if defined(CONFIG_NFSD_V2)
>> 	[2] = &nfsd_version2,
>> +#endif
>> 	[3] = &nfsd_version3,
>> #if defined(CONFIG_NFSD_V4)
>> 	[4] = &nfsd_version4,
>> -- 
>> 2.37.3
>>
> 
> --
> Chuck Lever
> 
> 
> 
> 
