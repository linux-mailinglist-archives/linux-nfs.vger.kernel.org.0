Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25A8621926
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Nov 2022 17:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiKHQLs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Nov 2022 11:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiKHQLq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Nov 2022 11:11:46 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC00BE35
        for <linux-nfs@vger.kernel.org>; Tue,  8 Nov 2022 08:11:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdFWz1StF1Ds7Ws0ubwBgT+/gfYjxTon2NttHU4kL6qCWYjR2e3umbyVhpJR4yCJDbPsGBSJUBhyYG+GWfSlM5Hdtcj26ImX1tUUeVlrzE1k0N/gzsY1l+VlazT53QF56B1THOCipAeCYXek1epeJgkO+Paw+Rr07HlLZaNk0I89VD1Uf2DIJiy555+IYUKa7bUalimwfoufYXav4YBawFFqDHzJSEeOQA9JteVdHDhzILjpqA8cwloHwCP2FLu8VZBY8llknJcdF+HDAr6mI6su4nbDew8xEr52KOMVPRJoFXF9CfzEjixmbPWrA799l7zH1OAD8UCEwV/F8Us0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVsCrZStI4mCPxp6pbrF+XqBGh+gIls3VcqoFqbt4Bc=;
 b=W9d3mWr3o+wZ0HMeJqwmVpiedEAnTFx7bpJFJbN6XuFRsQCA6lO/0fr8rJufEo0IG2zi45kR56OMOQiU5cQ37G0jB3LYypfWnl20ziCL7yjAW0kXM+Nn5+AMSHppHhoViiTVel1b8X4VJVCBd6sbl/9uBDE/JPl5nsz8CM9rFlY1gYuFXEpECr7lp0EjmhWebrPimV+B/TYPjkJfGAU5xIZGJJEDuIH52jzFQxujlpXZkvVMLiIdvu21Wb0Uss98VrFxMdTUKPWtZcJucugBWrVCQ1wCIMN98x2S4BOmdd6NeAsfLZGxH2T/vBo/iXp7UpZF0H7FIOp6kSyn/byM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 SN4PR01MB7422.prod.exchangelabs.com (2603:10b6:806:1e9::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 8 Nov 2022 16:11:44 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::4869:f99b:94c1:b502]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::4869:f99b:94c1:b502%7]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 16:11:43 +0000
Message-ID: <4fc8385e-2396-e64a-c31d-1ccafa8d263e@talpey.com>
Date:   Tue, 8 Nov 2022 11:11:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] NFS: Allow setting rsize / wsize to a multiple of
 PAGE_SIZE
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
        linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     Jianhong Yin <jiyin@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>
References: <20220617202336.1099702-1-anna@kernel.org>
 <9c9363ccabfa9906bcfd2604ec25994b57ee0f44.camel@kernel.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <9c9363ccabfa9906bcfd2604ec25994b57ee0f44.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0059.namprd19.prod.outlook.com
 (2603:10b6:208:19b::36) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|SN4PR01MB7422:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f8ed11-3bfc-4b17-eb79-08dac1a3ed8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MbO/bDqqnKxE5lNoWnkjUS782yhd0bIPFUypxc5pAHmM16GYNLQTjf4ug1X9e3fQC/X/IwarpSujjeKxRg6BIBURTtKJfNxHFf0SIh/O5TeoqcYarzxVVKlzUgpPN826AlPLevOybxi4+MGsRzC8TVv6OCBxxJgQVHzVTk5ciC5kLHkURWy2MGdJFRy23EZRPz5YQkUbl/tBmRRj+3DNKtpVJT7f8pmEGmogFCjxndkFKwt5HCOh2NQzPcxtIIdxoS6irCwhnrB9BLbyAmlH7sEeHjy4wy0UdjpVkRWO5+6aKdifjyndBaFx1dQk38936f7Hz2EAdyRANJSoXe+vc2aXLtUM1+35+AGxCI8/PuXqMw8zmeU8aOoj+kC+SqYPTxVLRjZikPHWRtSNBm/Bhb/mZb435B9919NpDF6lKUwkJ/hFL/0wTTzm434gcvF36LctUA4r6MhHprbUblPX2LRKEn5uC1sCn3SZ637TFgTKTxOkvA/1EcnOjh5QRYmky/T3Qc2Xao07X1zuE8edM+M51/TZ2t2z93ufSzVe/EViFGHZZvoVSRqwdWR+ahey5X/s+v+RPpAHNGucd1hfhUGyYsA8BbQEd3Vs+iX0K+ihLsb3QP9Vvsb8efwVzjTdOuC0DsoqL8w6AXqAr2gK22M+nf1Xzgdi+YqofTkIiumXF493bapag/fnDAa3ZTeIKDToWXrsWd5hBsMFUc4HhFKfkz4uWGilXT8YwrNnjfFvRpNpiIYeqdHBLd3iZ8+0UUaZzyYVX532vm7vE2WDanYL77CYjKZ/SB60VgYXZDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(396003)(366004)(376002)(346002)(136003)(451199015)(36756003)(2906002)(83380400001)(110136005)(54906003)(186003)(53546011)(6486002)(2616005)(38350700002)(66946007)(38100700002)(478600001)(66476007)(4326008)(66556008)(8676002)(316002)(31686004)(6506007)(26005)(6512007)(8936002)(5660300002)(41300700001)(86362001)(52116002)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9rZy9rRDZGSGZYUi9qeHUwQ0dHcG9nckxocm1aMDlrMU55ZGtmVURkM1Qx?=
 =?utf-8?B?dURQN2VMOVhKYzBKdDNIcjZySHJWYVplcUlJcVBEbXlDSXdXY3BnK00yZ0xp?=
 =?utf-8?B?Um1uM2h2d1dKNDl6elBvYTdrOFNhM0VhdTIvTTF1cW1KRE44SEM4L21iMW8v?=
 =?utf-8?B?em0wUXJXcmxVSTUzeGJwZzJyRUFCbGMxTEhtRXpOcFVva0JxaGR0bVpoTmw0?=
 =?utf-8?B?S0ZQREtEekZWNnFlZHFXVjl6dmliR1N0QVNpUkpJSFdHdE1xMHFIY2xWUktV?=
 =?utf-8?B?Y0RkdVh1ZkV0V05lbVhWeWQzV3gzYTJDWSs2eVd1cFEyaFVjRHI0U2hKdFdP?=
 =?utf-8?B?bTJMYkdQbWswMnpFd2VuZEY3SVFiS2kzeXMwekVERjRiWG01WTVIY1IzVHFk?=
 =?utf-8?B?Y1dCdW5IZHU4Wm5aWjYyUUVwOUt1SGpQd0dGRS9VMHZFK2o3OUg5QnFMb29U?=
 =?utf-8?B?Y3F3R2wzUmtYdXl2QTBFSFhHZ0gyVzdaQ3BFNVFIckJkV3UydFE5dk5uWW01?=
 =?utf-8?B?cVlreWZvelFmaE5ZS3hpRng5cVlmTW5uYyt6UmxwaGtNeVZnTzlkMEQ5WURC?=
 =?utf-8?B?cW9aTkNZUVlTRjNBQ2tOc3RmOUsyamMvQUlyWUQvSGU2b01JZjNoZVppblVQ?=
 =?utf-8?B?aWg2dnAxenJFMHZvZmwxbEQyNkdUdmtFMWxZR3RaTDVQMkF1VUgxZmV6WnZ2?=
 =?utf-8?B?bTJYOFBxN1VteXN1UjJGeXBaTGtSVW9zR1RSNkxJY2IrbGRoS1Y4RFZwN3ZI?=
 =?utf-8?B?akxuWXhDMFdtL0pHODErWkhFRkFxZmhSa1I2K01oV3BaRE52MUtENXE1YWpW?=
 =?utf-8?B?c2I3QlVGWGtONEZySTMzeDlHZGVCR1RGS1Erak5TZGxGYUdHVEJPcWdvcjRk?=
 =?utf-8?B?MGVoVHh5czdabEVQUjFDalM5YjlyU0x4V1J4cC9OWWxQZ2ZnS21qMUlXTnFn?=
 =?utf-8?B?T3Z6RTVnV0RCRUJCRktkbFd5MTYyWEQwSUh0NWw4QjQ0a3I2Y3NSbFlHaG9X?=
 =?utf-8?B?S3dLcmlldHpNU3FiZ3hTUSttcGM2alo5RkF2QzFWQ25DUEJkcGdsWGw3Nngy?=
 =?utf-8?B?bkJxaE9nK3dHMDRvVzR4TWNSN3pHT2QrNy9IeXA1M3RpUXl3U0NFTXZtellB?=
 =?utf-8?B?ZGIvTXM5Wlk3T291MzBJODdTeXBVZktETVFLcGxndXRha1BDR0NQWVNOblJk?=
 =?utf-8?B?NGJBMmJPeWdOZFQvM1NaSVBDU2JDdGYzQ1ZjYVJseVo4M2tuSFF6bzJNcnFp?=
 =?utf-8?B?cHNLNXVaT1lKSUxZR1ZRSjB5MW14bFFXVGZ5QnkzcDJsUjRidjJQT1hoK3ZL?=
 =?utf-8?B?alJFY21LVTdrWGJaQ2FHVXI1M0NnZFRIODZ3dTRka21YWkFod3k0ZnZIYjhD?=
 =?utf-8?B?TDhEazFPMUpCMTVJV0tTSVA4MXpmTXZrZzNmT3NOdVliWTF1bEg2Y1IzUElp?=
 =?utf-8?B?cXY0QkU4MFlhclc1MWdKM08wa3FMWWk2dTFxSWNHQzhCaGs5MFZmaHNhMDB3?=
 =?utf-8?B?aWFxQWgwRDhTM1VKRGVFUnV5QlVHUjZUUDEwc1BjMXdQV2xpWklPUVU4UG5E?=
 =?utf-8?B?V2k3YnBrcE5WMjNzOENoT0JybUZvS1ErcG93L2x4emszWUVMSzZmcnBKMWk4?=
 =?utf-8?B?TExWTXVBV3JIZUM2eVNneldSbmh2OENYazJ0ekVMMU8vZElHMTlyWWRQeDRK?=
 =?utf-8?B?RnhGdlhsU3BiWWYvQXA3ZXVsenBxRFRMd3pXSTBoa3MwRlFNTzl6c20wSWxr?=
 =?utf-8?B?dzhJUWJlVmlaQ2FUbjVzaS81MjBFc3Mvd3F6V1J0eVc2ZlNyN25CYk9JLyts?=
 =?utf-8?B?anFLb0NoejA1V1FyTG1sZEFIc3FkKzUyVDFaamNxMDlYa1gzbm1hei9GRFdZ?=
 =?utf-8?B?V3NyQWVOVHIxc0NTc2M0OENBeFhyWm1BNWpDZ3lHM2RoS3I5cDh1RS9YMjRX?=
 =?utf-8?B?di95bFhSODNFOTV5T1BhVHVHR2VqVGJ3MG52K09QUmQzOVdFTFczaTVWQzhK?=
 =?utf-8?B?RG5QNnhSU05PS1dwcVdsL0tFbWVRTy9uektjQ0RGeGcyazhCd0Vaa1dpeWNl?=
 =?utf-8?B?WTRXOWxrSHNZeWhBOTZlbXorMkVzOFRVMXp5anh0d1RuQ1EydklvQmpXU1Mv?=
 =?utf-8?Q?dEYc=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f8ed11-3bfc-4b17-eb79-08dac1a3ed8a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 16:11:43.7043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrhGhEBMbEkVGCPAHmrG1Vyx+W6hzm2ZkMF7/7KKKHaf/BK6WdtKaSS8A8mAOmL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7422
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 11/8/2022 5:01 AM, Jeff Layton wrote:
> On Fri, 2022-06-17 at 16:23 -0400, Anna Schumaker wrote:
>> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>>
>> Previously, we required this to value to be a power of 2 for UDP related
>> reasons. This patch keeps the power of 2 rule for UDP but allows more
>> flexibility for TCP and RDMA.
>>
>> Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>> ---
>>   fs/nfs/client.c                           | 13 +++++++------
>>   fs/nfs/flexfilelayout/flexfilelayoutdev.c |  6 ++++--
>>   fs/nfs/internal.h                         | 18 ++++++++++++++++++
>>   fs/nfs/nfs4client.c                       |  4 ++--
>>   4 files changed, 31 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
>> index e828504cc396..da8da5cdbbc1 100644
>> --- a/fs/nfs/client.c
>> +++ b/fs/nfs/client.c
>> @@ -708,9 +708,9 @@ static int nfs_init_server(struct nfs_server *server,
>>   	}
>>   
>>   	if (ctx->rsize)
>> -		server->rsize = nfs_block_size(ctx->rsize, NULL);
>> +		server->rsize = nfs_io_size(ctx->rsize, clp->cl_proto);
>>   	if (ctx->wsize)
>> -		server->wsize = nfs_block_size(ctx->wsize, NULL);
>> +		server->wsize = nfs_io_size(ctx->wsize, clp->cl_proto);
>>   
>>   	server->acregmin = ctx->acregmin * HZ;
>>   	server->acregmax = ctx->acregmax * HZ;
>> @@ -755,18 +755,19 @@ static int nfs_init_server(struct nfs_server *server,
>>   static void nfs_server_set_fsinfo(struct nfs_server *server,
>>   				  struct nfs_fsinfo *fsinfo)
>>   {
>> +	struct nfs_client *clp = server->nfs_client;
>>   	unsigned long max_rpc_payload, raw_max_rpc_payload;
>>   
>>   	/* Work out a lot of parameters */
>>   	if (server->rsize == 0)
>> -		server->rsize = nfs_block_size(fsinfo->rtpref, NULL);
>> +		server->rsize = nfs_io_size(fsinfo->rtpref, clp->cl_proto);
>>   	if (server->wsize == 0)
>> -		server->wsize = nfs_block_size(fsinfo->wtpref, NULL);
>> +		server->wsize = nfs_io_size(fsinfo->wtpref, clp->cl_proto);
>>   
>>   	if (fsinfo->rtmax >= 512 && server->rsize > fsinfo->rtmax)
>> -		server->rsize = nfs_block_size(fsinfo->rtmax, NULL);
>> +		server->rsize = nfs_io_size(fsinfo->rtmax, clp->cl_proto);
>>   	if (fsinfo->wtmax >= 512 && server->wsize > fsinfo->wtmax)
>> -		server->wsize = nfs_block_size(fsinfo->wtmax, NULL);
>> +		server->wsize = nfs_io_size(fsinfo->wtmax, clp->cl_proto);
>>   
>>   	raw_max_rpc_payload = rpc_max_payload(server->client);
>>   	max_rpc_payload = nfs_block_size(raw_max_rpc_payload, NULL);
>> diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
>> index bfa7202ca7be..e028f5a0ef5f 100644
>> --- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
>> +++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
>> @@ -113,8 +113,10 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
>>   			goto out_err_drain_dsaddrs;
>>   		ds_versions[i].version = be32_to_cpup(p++);
>>   		ds_versions[i].minor_version = be32_to_cpup(p++);
>> -		ds_versions[i].rsize = nfs_block_size(be32_to_cpup(p++), NULL);
>> -		ds_versions[i].wsize = nfs_block_size(be32_to_cpup(p++), NULL);
>> +		ds_versions[i].rsize = nfs_io_size(be32_to_cpup(p++),
>> +						   server->nfs_client->cl_proto);
>> +		ds_versions[i].wsize = nfs_io_size(be32_to_cpup(p++),
>> +						   server->nfs_client->cl_proto);
>>   		ds_versions[i].tightly_coupled = be32_to_cpup(p);
>>   
>>   		if (ds_versions[i].rsize > NFS_MAX_FILE_IO_SIZE)
>> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
>> index 8f8cd6e2d4db..af6d261241ff 100644
>> --- a/fs/nfs/internal.h
>> +++ b/fs/nfs/internal.h
>> @@ -704,6 +704,24 @@ unsigned long nfs_block_size(unsigned long bsize, unsigned char *nrbitsp)
>>   	return nfs_block_bits(bsize, nrbitsp);
>>   }
>>   
>> +/*
>> + * Compute and set NFS server rsize / wsize
>> + */
>> +static inline
>> +unsigned long nfs_io_size(unsigned long iosize, enum xprt_transports proto)
>> +{
>> +	if (iosize < NFS_MIN_FILE_IO_SIZE)
>> +		iosize = NFS_DEF_FILE_IO_SIZE;
>> +	else if (iosize >= NFS_MAX_FILE_IO_SIZE)
>> +		iosize = NFS_MAX_FILE_IO_SIZE;
>> +	else
>> +		iosize = iosize & PAGE_MASK;
>> +
>> +	if (proto == XPRT_TRANSPORT_UDP)
>> +		return nfs_block_bits(iosize, NULL);
>> +	return iosize;
>> +}
>> +
>>   /*
>>    * Determine the maximum file size for a superblock
>>    */
>> diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
>> index 47a6cf892c95..3c5678aec006 100644
>> --- a/fs/nfs/nfs4client.c
>> +++ b/fs/nfs/nfs4client.c
>> @@ -1161,9 +1161,9 @@ static int nfs4_init_server(struct nfs_server *server, struct fs_context *fc)
>>   		return error;
>>   
>>   	if (ctx->rsize)
>> -		server->rsize = nfs_block_size(ctx->rsize, NULL);
>> +		server->rsize = nfs_io_size(ctx->rsize, server->nfs_client->cl_proto);
>>   	if (ctx->wsize)
>> -		server->wsize = nfs_block_size(ctx->wsize, NULL);
>> +		server->wsize = nfs_io_size(ctx->wsize, server->nfs_client->cl_proto);
>>   
>>   	server->acregmin = ctx->acregmin * HZ;
>>   	server->acregmax = ctx->acregmax * HZ;
> 
> This patch seems to have caused a regression. With this patch in place,
> I can't set an rsize/wsize value that is less than 4k:
> 
>      # mount server:/export /mnt -o rsize=1024,wsize=1024
> 
> ...now yields:
> 
>      server:/export on /mnt type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.1.210,local_lock=none,addr=192.168.1.3)
> 
> ...such that the requested sizes were ignored.
> 
> Was this an intended effect? If we really do want to deprecate the use
> of small rsize/wsize with TCP/RDMA, then we probably ought to reject
> these mount attempts with -EINVAL.

I hope that's not the intent! Small r/w sizes can be quite useful for
many deployments, for example where network bandwidth is limited or
highly contended. And RDMA below 4KB shifts to inline-only (no direct
placement), which is useful for constrained environments and can
actually improve performance in certain cases.

It seems as if there should be some sort of notice if the sizes are
ignored, in any case. Asking for 1KB and getting 1MB is a rather
unfriendly result.

Tom.
