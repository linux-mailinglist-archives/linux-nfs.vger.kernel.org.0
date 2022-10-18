Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23998602CE5
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 15:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJRN0c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 09:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiJRN0D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 09:26:03 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915531FFAD
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 06:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faodUMIbG7dHWFcLiqaT4Frh5PHuXBENeSOiVauLOa3tiSOCRj/rWFBKUGv/IGIRU7iS3XfAnEJdJ83LO5YQlYkFElI08xuUdc1Fqk0pFG6zBpqm5DAaKzl9ty2+nru2lPJKQPTysPXyKuNoJnEBUtEqGgdTdPhVCV2qfaCPkGr7h9aRO6rrDNvz2aGfDLgPTVm9oyPcrWGJ8TUvMbpxDXe1bujyEkNkllT5lnLvUEW1QsDNJwe6qxw/kPUwH9rsWG3Wo20KH365KjIGmXssZvAxQBzNXgP6s9wla/XJG4uX66a+enFk0zaS6UY7wd5ERZ1toDXORZlRbWRmbIYVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJ06f/GHVNevz55w2cq5KSj/2d6Zb3fKScVuFxPPBI4=;
 b=PYDj9mYHSW1rROW8DPPuULK4UVhtGvXwDox76myI/fd43Ct4DkWZkPehO5nqFrNvhzXx8+IKTTDkQHupOE8XPR7Qc5wDPYjrB40RGcuMLUHkogA62Q+2BHM+A+2HxdclAshZ1hJiuluC9uQCUOYAAjRajIEPbTv4IiEQK21WRjE6EgF2q8A1o3POKniAWmtwRfwMoIIWbNdP/vACRyWssD3KzVXY6qnMRTC8Ci1xqK03aefb56Y4oOljnako1RrZyZIRoPZ9WXrforOfhA50LUqaJDlj8MvQozNde2KYv0iEDXhmwuUx5qmfDRd7KTRIWVc/SU+nBQsmuS8pPSKN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 CH0PR01MB7138.prod.exchangelabs.com (2603:10b6:610:eb::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.26; Tue, 18 Oct 2022 13:25:19 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::454c:df56:b524:13ef]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::454c:df56:b524:13ef%5]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 13:25:19 +0000
Message-ID: <2b3d2faa-c430-b456-f7fb-25dd6273d71a@talpey.com>
Date:   Tue, 18 Oct 2022 09:25:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] NFSD: add support for sending CB_RECALL_ANY
Content-Language: en-US
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
References: <1666070139-18843-1-git-send-email-dai.ngo@oracle.com>
 <1666070139-18843-2-git-send-email-dai.ngo@oracle.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <1666070139-18843-2-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0381.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::26) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|CH0PR01MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 514765fb-55ed-4345-cee6-08dab10c33f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnMo52XTmHay3ikT53TJ3Nj9D4/Y3PQ5cjNbnzlJgB9U0daoGsVUJGmkGmlSe0H7UJFUPz8EQCMHRyCPCg17bkdZAFFplHuXyRNUXlSQ2vRH0WJ8NxzrprpVQn0l1IUTy8oWqizi2RmynAnUY5kajqeQVWVzzgC+SVWBjjD92/UN4AG280HQm8DHABXCGhIqjaS1Ui0GZMD8iz4WbjGRsCN+f6yLKxyKLgRWK1xHfK+z8cqWKjJhi+/wItHJZGvmkb6DZ62UaYDvdt1z5YyMOqduZxUvv3xM4YNnEa19z3QMRugXm+hsagRCvenpzznzDN7+CffOybxptOwNfY2nnPUvWbYgW4yDKVZlri8C9ptNBHfQfimaQ5TKi0iedyhwn8XLmv0j7fOzcSBFLpkbChq3ooj+V52/fr2fv+kDpvKfXIXXupjWACeGA6fJexgvjZOOuHZfMIkcNr2llNZ40JB0WqFC89Et44cksdpuhIgWu000SEDOwCfRLQvHXk6Jg6kaxxPzJGvEzZnMjNjLLfKtoccPuBsnvveHTQvMUotnducuJV9xrcrNwAkULq70nozEEMEzELWQdvWxJOUILwyPUMBo2xwIY0lDgBeUHG9H6NhnIU344VSLB52Wo/g4OZRACLrSVWA4w2ARRggsG+tHJK5/dT3Fi+GcrNyuV6UcjFykzf6b+g5sLnuGQlzdZAcmHLYDgChQEvh201hiVGoWwlvdQwGYZtGi4dcWo7C/cr7cELxWLEOYsj12+ggp8S41Mu5CEXG+xgEtPqbPB3sifrs0j+/KLeX8IG45lSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39830400003)(346002)(366004)(376002)(396003)(451199015)(8936002)(26005)(6512007)(316002)(186003)(66556008)(66946007)(66476007)(36756003)(53546011)(4326008)(5660300002)(6506007)(52116002)(86362001)(31696002)(83380400001)(2906002)(41300700001)(8676002)(2616005)(6486002)(31686004)(38100700002)(38350700002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGF3cFBsbXlpT3pPbCsyWG1pZ0laWjFsb3JGMDVrU1hKOVR2NU9makVNM2di?=
 =?utf-8?B?dm0yT0RLMmI2aENSeVA1RXp2OVNiU3lZQW1pcnliM0FMTDBUcDR3N1ZRalg5?=
 =?utf-8?B?K3JwdlV6aHgvNFZjOFlOeHdMbm1COXFzMUN2Z1AxZEhUMlh0YTdrTE1qdE5W?=
 =?utf-8?B?Q1NNeHBhS0FSZUx5ZHFPLzJFU0FZb1hKWStpVk80Q29LeFNOdUJxYXJHamJE?=
 =?utf-8?B?QU9vb3BGSVI2bWlla3c2Qmx3TVpuc1lzcDFqWTRqUi9UTG5yNHF5VVpNNjhF?=
 =?utf-8?B?b0dndS9PcmYvcU5MT1JHZWNjZlBZTVhjL1lTMzUrYVNFNm1uRDdFM2RPRUQ2?=
 =?utf-8?B?ajBWTFovWFQyejRZcXZwMjdUZ2tGVGJyOUlyODZNc21RM2hkTVoydi8yWFlp?=
 =?utf-8?B?V3NqQmxTMHRSaFBBOC9HZ1ZPZjhGZUJQS0xPcCtIcWlDUUdVNUxPeU5nK0lV?=
 =?utf-8?B?eFBQVFlYVjhjb2RvWXRuaGdJOXhYNXg5NjcxUlU3NSt3dzBkWDRNTVRkUnlw?=
 =?utf-8?B?N0ZCK3lRMzhKaEN5emR0eGI3Q1VuUUxYeDhERVNmTjZrQ01pZVVxc1dsbGFE?=
 =?utf-8?B?VnhyUVJBU2xCRWd3aXkreW1pMG9kV0k5YjQ0VW1CRkdpWGhZYzJsNnhmc2pS?=
 =?utf-8?B?aTFDRGpiWVM5L3NDN0RwemJXUXRYMlJhSCszV2llM2RXbkowcGVWVU1BWWd3?=
 =?utf-8?B?WkRDWFRYK0NLZi9sVWU2bS9FTGFKLzhnMk5XVnJpeWRMMnFLUXhRbVdsdWpK?=
 =?utf-8?B?cnNxUmhnWXZ3blVaYkcrVDJKMVVSRnh6Y0pFSC9CSU9JU0c4NkJBUDhwbkJw?=
 =?utf-8?B?S3NEaFZUMzN6dXBZdmkxNWZWMHhJVFc2ZjJhUkN3ZEdWTlBZU2RneEsya0hQ?=
 =?utf-8?B?Q3pnc1JCdlFoTVF0TkZCb0RPVzk4aXhPY3Jwd1RIbnoxM09kSVJWNEU1eVF6?=
 =?utf-8?B?U2ZPVW9oUGRITVdiaklZN3U2V21SYXhUQndta2pIMGMvNk1TenVRdVBERThK?=
 =?utf-8?B?aWFKV2xWRUcwQ0NaakRtcnkyNWhFQms3bnhDYitPQWptWHM2Rmxoc2dRdkU2?=
 =?utf-8?B?Y1pjalRNdlFNWHlzSlBOUHRkUmU2Tnc1NVh5WlNiaUw4M2Z5MHZQem9tM0hF?=
 =?utf-8?B?MWdRUXhQL1ZaVFVxRnhmeldXVG43Z3crU055SVpCQmxMRnhJTVhJcU05T1Vt?=
 =?utf-8?B?VXdrTTdETm42UllhUU9SS2VOVlhBVnMrZ3QvdGlLWDlyemowWmR6MFErbUJK?=
 =?utf-8?B?cnh4V1Y5Q2ltdnVlMlpGcDZ5aktHNDh6OHV1SUE0YTlkQURDTlUwdXkwbHhS?=
 =?utf-8?B?dTgyUHlhSGt1ZzZzOEdlTlZnT3V3SkQ2SUluT3lLQ21lYWdhZExmWHhjYmkw?=
 =?utf-8?B?RzdJaEpieVEvMkM5QTA2ejJucW1QY1RFTVoxSnJudEtjd2cwL0EwdTJ4UFRt?=
 =?utf-8?B?U2Y3ajJHeEZBS1VwZW5xWkRTbjF6bVpnK0dZU1krSWRpSXBFODRpVWdpVzVk?=
 =?utf-8?B?aTJBQng2enVQWVNZRnJQLzllR1F3TVdWSlZTQ1h3R1VBZlk3NXFhY2RXN1pM?=
 =?utf-8?B?WEhrMVZ0ZzltNGc2bXI4UTdZNGNkTWJJWmpxSmtrd1lUWE5MSTBnbmxIZGhX?=
 =?utf-8?B?YTVtN2xUNDl4U0VIVXB6QmZ0eGdmUkFiamJUTk1adnlidnlKMGNGb2Q0UmtW?=
 =?utf-8?B?MVJienk4SmxPaUxYVmVHS3VVL0l3alZOS3l1b1k0bFVlTXg4WXUrNjJ4RWdT?=
 =?utf-8?B?ZDBka0F1b0htNnczVkd6bHFXMTJHSVRMcVpMR1dYZ3gvSCtXelI0aWlDdG5w?=
 =?utf-8?B?OTA3Um1jOWloOGdSSWFkcXhxN3pxWjNGdERPRitjMi9sbENham43SXp1VzZr?=
 =?utf-8?B?Ykd1YzZBQmVSc1NsZVNyYllLakRCTDZoTmlPa1dwYjlrVEczMjBiU0xsVTBT?=
 =?utf-8?B?b29GNGFmMlVTMThIWnBnZWdvNThhNjlHb2pzOTVqRktnd3NPR1ROeG1iV2Jz?=
 =?utf-8?B?M2pFVExsRERoQTFJQ2pzcTZIVXoveTRCWitTWUhDeXJ1WjZ6L1NvbVFxek1S?=
 =?utf-8?B?Uk9tamZlQ1hzakw1bzg2Z2pXc0lueWdRL0VnUTZ4UU5GOWZQODNSNEU4SWVx?=
 =?utf-8?Q?NkGZ8Jl+5pKSiTun+aBV5h5/6?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514765fb-55ed-4345-cee6-08dab10c33f0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:25:19.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sS+lryZv54oDGCgMQbuoH1/pUyv1psgGFCUeJonZrpxliFouvy8vNUUU8R44chW8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/18/2022 1:15 AM, Dai Ngo wrote:
> There is only one nfsd4_callback, cl_recall_any, added for each
> nfs4_client. Access to it must be serialized. For now it's done
> by the cl_recall_any_busy flag since it's used only by the
> delegation shrinker. If there is another consumer of CB_RECALL_ANY
> then a spinlock must be used.

I'm curious if clients have shown any quirks with the operation in
your testing. If the (Linux) server hasn't ever been sending it,
then I'd expect some possible issues/quirks in the client.

For example, do they really start handing back a significant number
of useful delegations? Enough to satisfy the server's need without
going to specific resource-based recalls?

Tom.

> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>   fs/nfsd/nfs4callback.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   fs/nfsd/nfs4state.c    | 27 +++++++++++++++++++++
>   fs/nfsd/state.h        |  8 +++++++
>   fs/nfsd/xdr4cb.h       |  6 +++++
>   4 files changed, 105 insertions(+)
> 
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index f0e69edf5f0f..03587e1397f4 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -329,6 +329,29 @@ static void encode_cb_recall4args(struct xdr_stream *xdr,
>   }
>   
>   /*
> + * CB_RECALLANY4args
> + *
> + *	struct CB_RECALLANY4args {
> + *		uint32_t	craa_objects_to_keep;
> + *		bitmap4		craa_type_mask;
> + *	};
> + */
> +static void
> +encode_cb_recallany4args(struct xdr_stream *xdr,
> +			struct nfs4_cb_compound_hdr *hdr, uint32_t bmval)
> +{
> +	__be32 *p;
> +
> +	encode_nfs_cb_opnum4(xdr, OP_CB_RECALL_ANY);
> +	p = xdr_reserve_space(xdr, 4);
> +	*p++ = xdr_zero;	/* craa_objects_to_keep */
> +	p = xdr_reserve_space(xdr, 8);
> +	*p++ = cpu_to_be32(1);
> +	*p++ = cpu_to_be32(bmval);
> +	hdr->nops++;
> +}
> +
> +/*
>    * CB_SEQUENCE4args
>    *
>    *	struct CB_SEQUENCE4args {
> @@ -482,6 +505,24 @@ static void nfs4_xdr_enc_cb_recall(struct rpc_rqst *req, struct xdr_stream *xdr,
>   	encode_cb_nops(&hdr);
>   }
>   
> +/*
> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> + */
> +static void
> +nfs4_xdr_enc_cb_recall_any(struct rpc_rqst *req,
> +		struct xdr_stream *xdr, const void *data)
> +{
> +	const struct nfsd4_callback *cb = data;
> +	struct nfs4_cb_compound_hdr hdr = {
> +		.ident = cb->cb_clp->cl_cb_ident,
> +		.minorversion = cb->cb_clp->cl_minorversion,
> +	};
> +
> +	encode_cb_compound4args(xdr, &hdr);
> +	encode_cb_sequence4args(xdr, cb, &hdr);
> +	encode_cb_recallany4args(xdr, &hdr, cb->cb_clp->cl_recall_any_bm);
> +	encode_cb_nops(&hdr);
> +}
>   
>   /*
>    * NFSv4.0 and NFSv4.1 XDR decode functions
> @@ -520,6 +561,28 @@ static int nfs4_xdr_dec_cb_recall(struct rpc_rqst *rqstp,
>   	return decode_cb_op_status(xdr, OP_CB_RECALL, &cb->cb_status);
>   }
>   
> +/*
> + * 20.6. Operation 8: CB_RECALL_ANY - Keep Any N Recallable Objects
> + */
> +static int
> +nfs4_xdr_dec_cb_recall_any(struct rpc_rqst *rqstp,
> +				  struct xdr_stream *xdr,
> +				  void *data)
> +{
> +	struct nfsd4_callback *cb = data;
> +	struct nfs4_cb_compound_hdr hdr;
> +	int status;
> +
> +	status = decode_cb_compound4res(xdr, &hdr);
> +	if (unlikely(status))
> +		return status;
> +	status = decode_cb_sequence4res(xdr, cb);
> +	if (unlikely(status || cb->cb_seq_status))
> +		return status;
> +	status =  decode_cb_op_status(xdr, OP_CB_RECALL_ANY, &cb->cb_status);
> +	return status;
> +}
> +
>   #ifdef CONFIG_NFSD_PNFS
>   /*
>    * CB_LAYOUTRECALL4args
> @@ -783,6 +846,7 @@ static const struct rpc_procinfo nfs4_cb_procedures[] = {
>   #endif
>   	PROC(CB_NOTIFY_LOCK,	COMPOUND,	cb_notify_lock,	cb_notify_lock),
>   	PROC(CB_OFFLOAD,	COMPOUND,	cb_offload,	cb_offload),
> +	PROC(CB_RECALL_ANY,	COMPOUND,	cb_recall_any,	cb_recall_any),
>   };
>   
>   static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 4e718500a00c..c60c937dece6 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -2854,6 +2854,31 @@ static const struct tree_descr client_files[] = {
>   	[3] = {""},
>   };
>   
> +static int
> +nfsd4_cb_recall_any_done(struct nfsd4_callback *cb,
> +			struct rpc_task *task)
> +{
> +	switch (task->tk_status) {
> +	case -NFS4ERR_DELAY:
> +		rpc_delay(task, 2 * HZ);
> +		return 0;
> +	default:
> +		return 1;
> +	}
> +}
> +
> +static void
> +nfsd4_cb_recall_any_release(struct nfsd4_callback *cb)
> +{
> +	cb->cb_clp->cl_recall_any_busy = false;
> +	atomic_dec(&cb->cb_clp->cl_rpc_users);
> +}
> +
> +static const struct nfsd4_callback_ops nfsd4_cb_recall_any_ops = {
> +	.done		= nfsd4_cb_recall_any_done,
> +	.release	= nfsd4_cb_recall_any_release,
> +};
> +
>   static struct nfs4_client *create_client(struct xdr_netobj name,
>   		struct svc_rqst *rqstp, nfs4_verifier *verf)
>   {
> @@ -2891,6 +2916,8 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
>   		free_client(clp);
>   		return NULL;
>   	}
> +	nfsd4_init_cb(&clp->cl_recall_any, clp, &nfsd4_cb_recall_any_ops,
> +			NFSPROC4_CLNT_CB_RECALL_ANY);
>   	return clp;
>   }
>   
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e2daef3cc003..49ca06169642 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -411,6 +411,10 @@ struct nfs4_client {
>   
>   	unsigned int		cl_state;
>   	atomic_t		cl_delegs_in_recall;
> +
> +	bool			cl_recall_any_busy;
> +	uint32_t		cl_recall_any_bm;
> +	struct nfsd4_callback	cl_recall_any;
>   };
>   
>   /* struct nfs4_client_reset
> @@ -639,8 +643,12 @@ enum nfsd4_cb_op {
>   	NFSPROC4_CLNT_CB_OFFLOAD,
>   	NFSPROC4_CLNT_CB_SEQUENCE,
>   	NFSPROC4_CLNT_CB_NOTIFY_LOCK,
> +	NFSPROC4_CLNT_CB_RECALL_ANY,
>   };
>   
> +#define RCA4_TYPE_MASK_RDATA_DLG	0
> +#define RCA4_TYPE_MASK_WDATA_DLG	1
> +
>   /* Returns true iff a is later than b: */
>   static inline bool nfsd4_stateid_generation_after(stateid_t *a, stateid_t *b)
>   {
> diff --git a/fs/nfsd/xdr4cb.h b/fs/nfsd/xdr4cb.h
> index 547cf07cf4e0..0d39af1b00a0 100644
> --- a/fs/nfsd/xdr4cb.h
> +++ b/fs/nfsd/xdr4cb.h
> @@ -48,3 +48,9 @@
>   #define NFS4_dec_cb_offload_sz		(cb_compound_dec_hdr_sz  +      \
>   					cb_sequence_dec_sz +            \
>   					op_dec_sz)
> +#define NFS4_enc_cb_recall_any_sz	(cb_compound_enc_hdr_sz +       \
> +					cb_sequence_enc_sz +            \
> +					1 + 1 + 1)
> +#define NFS4_dec_cb_recall_any_sz	(cb_compound_dec_hdr_sz  +      \
> +					cb_sequence_dec_sz +            \
> +					op_dec_sz)
