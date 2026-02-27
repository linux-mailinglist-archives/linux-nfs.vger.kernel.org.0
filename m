Return-Path: <linux-nfs+bounces-19431-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBwhM/XuoWm5xQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19431-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 20:22:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F71BCAD6
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 20:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE697302D180
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 19:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ACB264612;
	Fri, 27 Feb 2026 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9aZWcwW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDB40B6D2
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220110; cv=none; b=q/5zHDTZsnPAxwVpfZK8MBsyFzMgNojRFb5ksl+4rtN4Q0uiZVxU+z5H3GjnZF6OVHJioPF3sIgxJJbZW4lt7+fYxpw5SjEjdk69uixjn4kyyTEI63bBVjInilOEM5C1TtUBskWu3k+6WI1ob5rw8Utfb2QoEBYUjDFjlwVB3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220110; c=relaxed/simple;
	bh=g4uW0gV0nG1xsBlBZQS3nFa+qinARR1cQZau27M6GU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UHd6pmTn4yZ+mtnqvssxipu+d1UU36SXq+c/qg7VOiQ26NCOkfCmcGqA5Ojl/SZJeXQ+THKwdnsnPyZixbBBX9pzojbw8G2u9iBe83qP7pRHXDws6qOCuws0e2T3cQe0XYaLA3018ZDxCzclru7h49zx6UrrUbtIzfU6Sh12eu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9aZWcwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07F8C2BC87;
	Fri, 27 Feb 2026 19:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772220109;
	bh=g4uW0gV0nG1xsBlBZQS3nFa+qinARR1cQZau27M6GU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J9aZWcwWxEsuTI2SKCYSj9d6nVX1ZSDNu9Lig5DFIjqmLz5vXQOwkjH8ADN1q9Q5r
	 wAC121Mkxk+glpvmNtEh8YMWTSB+TbyqKScowQHTDiDEPsSa3PLp96udqjvKr3Farf
	 RgFssymykp0R22iZuhXQg8DPi42UWnBTf9/6BQrNCcLUgmGZ/RPLE9xEYyDk76Bt9u
	 8M+iwIRxj4QI1Z+ersThPs9ZqJQRxKA/EcLPCpu21O6ow0moe7QeMBfhT4UfliTgMu
	 FA+8t329OiK4CfUtIK6jdn+l9vbMv4i4sboEh+lRESj/CoxHDk42r5WtGGRF0UZrQL
	 uxMrLCryb+DsQ==
Message-ID: <77566649-f3ea-445e-a85a-afa1235ac9e1@kernel.org>
Date: Fri, 27 Feb 2026 14:21:47 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] NFSD: move accumulated callback ops to per-net
 namespace
To: Dai Ngo <dai.ngo@oracle.com>, Chuck Lever <chuck.lever@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Tom Talpey <tom@talpey.com>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nfs@vger.kernel.org
References: <20260226193611.1038076-1-dai.ngo@oracle.com>
 <a4bf76dc-2805-415e-be50-5501ea1ebf9a@app.fastmail.com>
 <e4b79d8b-ff77-4e1c-b2c6-8408b8310c5f@oracle.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <e4b79d8b-ff77-4e1c-b2c6-8408b8310c5f@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19431-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C7F71BCAD6
X-Rspamd-Action: no action

On 2/27/26 1:20 PM, Dai Ngo wrote:
> 
> On 2/27/26 7:56 AM, Chuck Lever wrote:
>>
>> On Thu, Feb 26, 2026, at 2:35 PM, Dai Ngo wrote:
>>> Track accumulated callback operations on a per-network-namespace basis
>>> instead of globally, ensuring proper isolation and behavior when running
>>> nfsd in containers.
>> Where are the consumers of this information? "Subsequent patch"
>> is an OK answer, but that should be indicated here in your patch
>> description.
> 
> Should I first expand the output of /proc/net/rpc/nfsd and then follow
> up with a netlink-based implementation? Or are we trying to avoid adding
> anything new under /proc at this point?

The current kernel-wide policy, as I understand it, is that subsystems
are to avoid adding new items under /proc unless absolutely needed.

I believe nfsdctl and the NFSD netlink protocol does not yet have an
operation to retrieve statistics. Jeff can help you put that together.


> Also, is there currently any user-space utility that can extract nfsd
> statistics via the netlink interface?
> 
> -Dai
> 
>>
>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/nfsd/netns.h        |  5 +++
>>>   fs/nfsd/nfs4callback.c | 75 ++++++++++++++++++++++--------------------
>>>   fs/nfsd/nfsctl.c       |  5 +++
>>>   fs/nfsd/state.h        |  2 ++
>>>   4 files changed, 52 insertions(+), 35 deletions(-)
>>>
>>> v2:
>>>    . free memory allocated for nn->nfsd_cb_version4.counts in
>>>      nfsd_net_cb_stats_init() on error in nfsd_net_init().
>>> v3:
>>>    . reword commit message.
>>>    . fix initialization of nn->nfsd_cb_program.nrvers.
>>> v4:
>>>    . fix merge conflict in nfsd_net_exit in nfsd-testing branch.
>>> v5:
>>>    . restore commit message to the original in v1
>>>
>>> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
>>> index 6ad3fe5d7e12..c101bf2c24c2 100644
>>> --- a/fs/nfsd/netns.h
>>> +++ b/fs/nfsd/netns.h
>>> @@ -228,6 +228,11 @@ struct nfsd_net {
>>>       struct list_head    local_clients;
>>>   #endif
>>>       siphash_key_t        *fh_key;
>>> +
>>> +    struct rpc_version    nfsd_cb_version4;
>>> +    const struct rpc_version *nfsd_cb_versions[2];
>> I know this is copy-paste of existing code, but can you find a
>> proper symbolic constant to use here instead of "2" ?
>>
>>
>>> +    struct rpc_program    nfsd_cb_program;
>>> +    struct rpc_stat        nfsd_cb_stat;
>>>   };
>>>
>>>   /* Simple check to find out if a given net was properly initialized */
>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>> index aea8bdd2fdc4..759f24657c34 100644
>>> --- a/fs/nfsd/nfs4callback.c
>>> +++ b/fs/nfsd/nfs4callback.c
>>> @@ -1016,7 +1016,7 @@ static int nfs4_xdr_dec_cb_offload(struct
>>> rpc_rqst *rqstp,
>>>       .p_decode  = nfs4_xdr_dec_##restype,                \
>>>       .p_arglen  = NFS4_enc_##argtype##_sz,                \
>>>       .p_replen  = NFS4_dec_##restype##_sz,                \
>>> -    .p_statidx = NFSPROC4_CB_##call,                \
>>> +    .p_statidx = NFSPROC4_CLNT_##proc,                \
>>>       .p_name    = #proc,                        \
>>>   }
>> Previously all compound-based callbacks mapped to statidx 1
>> (NFSPROC4_CB_COMPOUND); now each operation gets its own counter
>> slot (values 0–7). This changes what stats are reported, IIUC.
>> So bundling it here means a bisect on a stats regression cannot
>> isolate when accounting changed, and reverting either change
>> forces reverting both.
>>
>> IMO this should be a pre-requisite commit with its own
>> rationale.
>>
>>
>>> @@ -1032,40 +1032,7 @@ static const struct rpc_procinfo
>>> nfs4_cb_procedures[] = {
>>>       PROC(CB_GETATTR,    COMPOUND,    cb_getattr,    cb_getattr),
>>>   };
>>>
>>> -static unsigned int nfs4_cb_counts[ARRAY_SIZE(nfs4_cb_procedures)];
>>> -static const struct rpc_version nfs_cb_version4 = {
>>> -/*
>>> - * Note on the callback rpc program version number: despite language
>>> in rfc
>>> - * 5661 section 18.36.3 requiring servers to use 4 in this field, the
>>> - * official xdr descriptions for both 4.0 and 4.1 specify version 1,
>>> and
>>> - * in practice that appears to be what implementations use.  The
>>> section
>>> - * 18.36.3 language is expected to be fixed in an erratum.
>>> - */
>>> -    .number            = 1,
>>> -    .nrprocs        = ARRAY_SIZE(nfs4_cb_procedures),
>>> -    .procs            = nfs4_cb_procedures,
>>> -    .counts            = nfs4_cb_counts,
>>> -};
>>> -
>>> -static const struct rpc_version *nfs_cb_version[2] = {
>>> -    [1] = &nfs_cb_version4,
>>> -};
>>> -
>>> -static const struct rpc_program cb_program;
>>> -
>>> -static struct rpc_stat cb_stats = {
>>> -    .program        = &cb_program
>>> -};
>>> -
>>>   #define NFS4_CALLBACK 0x40000000
>>> -static const struct rpc_program cb_program = {
>>> -    .name            = "nfs4_cb",
>>> -    .number            = NFS4_CALLBACK,
>>> -    .nrvers            = ARRAY_SIZE(nfs_cb_version),
>>> -    .version        = nfs_cb_version,
>>> -    .stats            = &cb_stats,
>>> -    .pipe_dir_name        = "nfsd4_cb",
>>> -};
>>>
>>>   static int max_cb_time(struct net *net)
>>>   {
>>> @@ -1152,14 +1119,15 @@ static int setup_callback_client(struct
>>> nfs4_client *clp, struct nfs4_cb_conn *c
>>>           .addrsize    = conn->cb_addrlen,
>>>           .saddress    = (struct sockaddr *) &conn->cb_saddr,
>>>           .timeout    = &timeparms,
>>> -        .program    = &cb_program,
>>>           .version    = 1,
>>>           .flags        = (RPC_CLNT_CREATE_NOPING |
>>> RPC_CLNT_CREATE_QUIET),
>>>           .cred        = current_cred(),
>>>       };
>>>       struct rpc_clnt *client;
>>>       const struct cred *cred;
>>> +    struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> Nit: Reverse Christmas tree ordering -- this new declaration
>> belongs close to the top.
>>
>>
>>> +    args.program = &nn->nfsd_cb_program;
>>>       if (clp->cl_minorversion == 0) {
>>>           if (!clp->cl_cred.cr_principal &&
>>>               (clp->cl_cred.cr_flavor >= RPC_AUTH_GSS_KRB5)) {
>>> @@ -1786,3 +1754,40 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
>>>           nfsd41_cb_inflight_end(clp);
>>>       return queued;
>>>   }
>>> +
>>> +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn)
>>> +{
>>> +    kfree(nn->nfsd_cb_version4.counts);
>>> +}
>>> +
>>> +int nfsd_net_cb_stats_init(struct nfsd_net *nn)
>>> +{
>>> +    nn->nfsd_cb_version4.counts = kzalloc_objs(unsigned int,
>>> +            ARRAY_SIZE(nfs4_cb_procedures), GFP_KERNEL);
>>> +    if (!nn->nfsd_cb_version4.counts)
>>> +        return -ENOMEM;
>>> +    /*
>>> +     * Note on the callback rpc program version number: despite
>>> language
>>> +     * in rfc 5661 section 18.36.3 requiring servers to use 4 in this
>>> +     * field, the official xdr descriptions for both 4.0 and 4.1
>>> specify
>>> +     * version 1, and in practice that appears to be what
>>> implementations
>>> +     * use. The section 18.36.3 language is expected to be fixed in an
>>> +     * erratum.
>>> +     */
>>> +    nn->nfsd_cb_version4.number = 1;
>>> +
>>> +    nn->nfsd_cb_version4.nrprocs = ARRAY_SIZE(nfs4_cb_procedures);
>>> +    nn->nfsd_cb_version4.procs = nfs4_cb_procedures;
>>> +    nn->nfsd_cb_versions[1] = &nn->nfsd_cb_version4;
>> Could you add a comment explaining that slot 0 is intentionally
>> NULL and slot 1 corresponds to the CB protocol version number?
>> The original designated-initializer syntax made this self-
>> evident; the replacement imperative assignment here does not.
>>
>>
>>> +
>>> +    memset(&nn->nfsd_cb_stat, 0, sizeof(nn->nfsd_cb_stat));
>>> +    nn->nfsd_cb_program.name = "nfs4_cb";
>>> +    nn->nfsd_cb_program.number = NFS4_CALLBACK;
>>> +    nn->nfsd_cb_program.nrvers = ARRAY_SIZE(nn->nfsd_cb_versions);
>>> +    nn->nfsd_cb_program.version = &nn->nfsd_cb_versions[0];
>>> +    nn->nfsd_cb_program.pipe_dir_name = "nfsd4_cb";
>>> +    nn->nfsd_cb_program.stats = &nn->nfsd_cb_stat;
>>> +    nn->nfsd_cb_stat.program = &nn->nfsd_cb_program;
>>> +
>>> +    return 0;
>>> +}
>> New non-static functions should get kernel-doc comments.
>>
>>
>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>> index 032ab44feb70..5daa647ef0fa 100644
>>> --- a/fs/nfsd/nfsctl.c
>>> +++ b/fs/nfsd/nfsctl.c
>>> @@ -2216,6 +2216,9 @@ static __net_init int nfsd_net_init(struct net
>>> *net)
>>>       int retval;
>>>       int i;
>>>
>>> +    retval = nfsd_net_cb_stats_init(nn);
>>> +    if (retval)
>>> +        return retval;
>> Does this build if CONFIG_NFSD_V4 is not enabled?
>>
>>
>>>       retval = nfsd_export_init(net);
>>>       if (retval)
>>>           goto out_export_error;
>>> @@ -2256,6 +2259,7 @@ static __net_init int nfsd_net_init(struct net
>>> *net)
>>>   out_idmap_error:
>>>       nfsd_export_shutdown(net);
>>>   out_export_error:
>>> +    nfsd_net_cb_stats_shutdown(nn);
>>>       return retval;
>>>   }
>>>
>>> @@ -2286,6 +2290,7 @@ static __net_exit void nfsd_net_exit(struct net
>>> *net)
>>>       struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>>>
>>>       kfree_sensitive(nn->fh_key);
>>> +    nfsd_net_cb_stats_shutdown(nn);
>>>       nfsd_proc_stat_shutdown(net);
>>>       percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
>>>       nfsd_idmap_shutdown(net);
>>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>>> index 9b05462da4cc..490193c1877d 100644
>>> --- a/fs/nfsd/state.h
>>> +++ b/fs/nfsd/state.h
>>> @@ -895,4 +895,6 @@ struct nfsd4_get_dir_delegation;
>>>   struct nfs4_delegation *nfsd_get_dir_deleg(struct
>>> nfsd4_compound_state *cstate,
>>>                           struct nfsd4_get_dir_delegation *gdd,
>>>                           struct nfsd_file *nf);
>>> +int nfsd_net_cb_stats_init(struct nfsd_net *nn);
>>> +void nfsd_net_cb_stats_shutdown(struct nfsd_net *nn);
>>>   #endif   /* NFSD4_STATE_H */
>>> -- 
>>> 2.47.3


-- 
Chuck Lever

