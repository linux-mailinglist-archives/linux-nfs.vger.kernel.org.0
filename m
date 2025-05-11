Return-Path: <linux-nfs+bounces-11662-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71076AB2BB7
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 23:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C338C1894257
	for <lists+linux-nfs@lfdr.de>; Sun, 11 May 2025 21:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0625B697;
	Sun, 11 May 2025 21:59:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6925CC60
	for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747000768; cv=none; b=Xtc7zDvJQWqxYTbW76nvj2JFTi5piXPkuaoqLAqmXfy0lZs66JMgTHZHu+YYWSf+2og2tRt2Apd2aSUS7fnJNkBf8WfhTmUTJdC5S4KxNE+LMjgwXg88E4Ueri95VEuZ+9yM3S3IBc3X4DYsRDcn+Ulx5aIbJNR4Irc+ni/wXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747000768; c=relaxed/simple;
	bh=HqUmaFh1bh9evHUsTx7rAGuCJVNOpBgV4npjHymDHH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTH9qdoX+Wqa9mIzF3OWQwZ7N92FXox/pPiIhlLsVGX/pu/8AE4b1/p+LwNjf6WyOgrHWyMPMy1SdfGRqlMWci5baMgePGDp0eTLw4OA6AWf5IUcfHN2VAZnP9+zkbDB4TMu3YO+3RWWGRXNNbuQGHcNMs6k5EMrdhPNYy2Cj94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ace94273f0dso746926966b.3
        for <linux-nfs@vger.kernel.org>; Sun, 11 May 2025 14:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747000764; x=1747605564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6UyAhwFX58hxnl7anFiq7GDtjJSGOUhCL/g6EQkey4I=;
        b=V5jNf4GwD9OmOZQq/UOFXMsJwA6dXy4KP/j9ZKEZv591JgSh/vRyEURhvxuL1LCeVm
         bJnDpd+E/ch0P0NpQoEh4yPoUOC3k2wPlI4pT7QQzzwrQA8YCSs8GEc6mYPx4m9eycNw
         eqRj8atJJVQNVcEM1A5iJy+pZbjfuglLjG842wVrf430Wq5fKwsWR7RAWC03oqGamOwI
         uSV7fMHAsD4XAr9tnp8bdLrcc1Bq//HOlpLex3lgWr4rnZnqRWsqV0bA79MxVy3xxMv5
         vDml3QxH5/8OgVqXA0ompf/osPodqxIPLtFk15MWCb0Hsqk57cDdjpBfTe/VDQ8vqMhM
         cwJw==
X-Gm-Message-State: AOJu0Yxtzhrxb/jZEPRTN/F7Lkmf+XYbP22rjppAJM1snWemI2fCGfuD
	HFUSxYL8McUY5erKsPQzW4oJdPRGaly9kYXkvxtNtYB8YWsAZeEc
X-Gm-Gg: ASbGncujb50+yAk8E9mNNy6e2nmT0Ed/EAgpUCqCCYu7u04PWSrhc1Gfw3oXUkXu3N0
	6s2ko1W2AOyjGiweYoL16tUP8JLlYX3vGwK/n8a7cjbyOmydYX82o8WMbeo91/1lO22s6ypy3/S
	6yKv+ckhKRtNquVH0fz27JYl/YaQCjuvUFKIJS59ihQtACd7KtkQH//0TQK7ULICd4kaM55rhvY
	hASkhrdqVB9Wu/exxFtegEyM1u2iqPLXcsVtJ0GsZ6Lzz72k3U+qlYrRkJ8CoPp7x5XjQ2bPBxs
	/oNhDJZBHu4Pw88uwsxDleRROq31CiVSXhmfFBV2hD3o2vVv/uSSmdQszNRHhwjQCXlSkvtAURS
	6wU/K1yHB
X-Google-Smtp-Source: AGHT+IFrRaP1AFg3gFQBxh+1Ha5Vg1G6SjimCG2vMw/BOYgfKIkrLQq2dPin9HKT7C+foKyQZNWpYQ==
X-Received: by 2002:a17:907:3f1b:b0:ad2:51d8:791b with SMTP id a640c23a62f3a-ad251d87a39mr211424666b.19.1747000763749;
        Sun, 11 May 2025 14:59:23 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd3easm526476066b.147.2025.05.11.14.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 May 2025 14:59:23 -0700 (PDT)
Message-ID: <0fc2c857-dc46-439c-a259-1f093d114e4b@grimberg.me>
Date: Mon, 12 May 2025 00:59:22 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 1/1] NFSD: Offer write delegation for OPEN with
 OPEN4_SHARE_ACCESS_WRITE
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Dai Ngo <dai.ngo@oracle.com>, neilb@suse.de, okorniev@redhat.com,
 tom@talpey.com
Cc: linux-nfs@vger.kernel.org
References: <1741289493-15305-1-git-send-email-dai.ngo@oracle.com>
 <1741289493-15305-2-git-send-email-dai.ngo@oracle.com>
 <ac9d076fb33f7ad5d536ac593a2eb6afd09015b0.camel@kernel.org>
 <0314dd65-f7ed-47be-b39e-813e6b334ec9@oracle.com>
 <89da1d14-e66f-402a-a0ca-2434476e4c7f@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <89da1d14-e66f-402a-a0ca-2434476e4c7f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/05/2025 3:10, Chuck Lever wrote:
> On 5/9/25 5:48 PM, Chuck Lever wrote:
>> On 5/9/25 3:32 PM, Jeff Layton wrote:
>>> On Thu, 2025-03-06 at 11:31 -0800, Dai Ngo wrote:
>>>> RFC8881, section 9.1.2 says:
>>>>
>>>>    "In the case of READ, the server may perform the corresponding
>>>>     check on the access mode, or it may choose to allow READ for
>>>>     OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>>>     implementation may unavoidably do reads (e.g., due to buffer cache
>>>>     constraints)."
>>>>
>>>> and in section 10.4.1:
>>>>     "Similarly, when closing a file opened for OPEN4_SHARE_ACCESS_WRITE/
>>>>     OPEN4_SHARE_ACCESS_BOTH and if an OPEN_DELEGATE_WRITE delegation
>>>>     is in effect"
>>>>
>>>> This patch allow READ using write delegation stateid granted on OPENs
>>>> with OPEN4_SHARE_ACCESS_WRITE only, to accommodate clients whose WRITE
>>>> implementation may unavoidably do (e.g., due to buffer cache
>>>> constraints).
>>>>
>>>> For write delegation granted for OPEN with OPEN4_SHARE_ACCESS_WRITE
>>>> a new nfsd_file and a struct file are allocated to use for reads.
>>>> The nfsd_file is freed when the file is closed by release_all_access.
>>>>
>>>> Suggested-by: Chuck Lever <chuck.lever@oracle.com>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>>   fs/nfsd/nfs4state.c | 75 ++++++++++++++++++++++++++++-----------------
>>>>   1 file changed, 47 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>> index 0f97f2c62b3a..295415fda985 100644
>>>> --- a/fs/nfsd/nfs4state.c
>>>> +++ b/fs/nfsd/nfs4state.c
>>>> @@ -633,18 +633,6 @@ find_readable_file(struct nfs4_file *f)
>>>>   	return ret;
>>>>   }
>>>>   
>>>> -static struct nfsd_file *
>>>> -find_rw_file(struct nfs4_file *f)
>>>> -{
>>>> -	struct nfsd_file *ret;
>>>> -
>>>> -	spin_lock(&f->fi_lock);
>>>> -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
>>>> -	spin_unlock(&f->fi_lock);
>>>> -
>>>> -	return ret;
>>>> -}
>>>> -
>>>>   struct nfsd_file *
>>>>   find_any_file(struct nfs4_file *f)
>>>>   {
>>>> @@ -5987,14 +5975,19 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>   	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>>>   	 *   on its own, all opens."
>>>>   	 *
>>>> -	 * Furthermore the client can use a write delegation for most READ
>>>> -	 * operations as well, so we require a O_RDWR file here.
>>>> +	 * Furthermore, section 9.1.2 says:
>>>> +	 *
>>>> +	 *  "In the case of READ, the server may perform the corresponding
>>>> +	 *  check on the access mode, or it may choose to allow READ for
>>>> +	 *  OPEN4_SHARE_ACCESS_WRITE, to accommodate clients whose WRITE
>>>> +	 *  implementation may unavoidably do reads (e.g., due to buffer
>>>> +	 *  cache constraints)."
>>>>   	 *
>>>> -	 * Offer a write delegation in the case of a BOTH open, and ensure
>>>> -	 * we get the O_RDWR descriptor.
>>>> +	 *  We choose to offer a write delegation for OPEN with the
>>>> +	 *  OPEN4_SHARE_ACCESS_WRITE access mode to accommodate such clients.
>>>>   	 */
>>>> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>>>> -		nf = find_rw_file(fp);
>>>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>> +		nf = find_writeable_file(fp);
>>>>   		dl_type = deleg_ts ? OPEN_DELEGATE_WRITE_ATTRS_DELEG : OPEN_DELEGATE_WRITE;
>>>>   	}
>>>>   
>>>> @@ -6116,7 +6109,7 @@ static bool
>>>>   nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>>>   		     struct kstat *stat)
>>>>   {
>>>> -	struct nfsd_file *nf = find_rw_file(dp->dl_stid.sc_file);
>>>> +	struct nfsd_file *nf = find_writeable_file(dp->dl_stid.sc_file);
>>>>   	struct path path;
>>>>   	int rc;
>>>>   
>>>> @@ -6134,6 +6127,33 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>>>   	return rc == 0;
>>>>   }
>>>>   
>>>> +/*
>>>> + * Add NFS4_SHARE_ACCESS_READ to the write delegation granted on OPEN
>>>> + * with NFS4_SHARE_ACCESS_WRITE by allocating separate nfsd_file and
>>>> + * struct file to be used for read with delegation stateid.
>>>> + *
>>>> + */
>>>> +static bool
>>>> +nfsd4_add_rdaccess_to_wrdeleg(struct svc_rqst *rqstp, struct nfsd4_open *open,
>>>> +			      struct svc_fh *fh, struct nfs4_ol_stateid *stp)
>>>> +{
>>>> +	struct nfs4_file *fp;
>>>> +	struct nfsd_file *nf = NULL;
>>>> +
>>>> +	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>>> +			NFS4_SHARE_ACCESS_WRITE) {
>>>> +		if (nfsd_file_acquire_opened(rqstp, fh, NFSD_MAY_READ, NULL, &nf))
>>>> +			return (false);
>>>> +		fp = stp->st_stid.sc_file;
>>>> +		spin_lock(&fp->fi_lock);
>>>> +		__nfs4_file_get_access(fp, NFS4_SHARE_ACCESS_READ);
>>>> +		fp = stp->st_stid.sc_file;
>>>> +		fp->fi_fds[O_RDONLY] = nf;
>>>> +		spin_unlock(&fp->fi_lock);
>>>> +	}
>>>> +	return true;
>>>> +}
>>>> +
>>>>   /*
>>>>    * The Linux NFS server does not offer write delegations to NFSv4.0
>>>>    * clients in order to avoid conflicts between write delegations and
>>>> @@ -6159,8 +6179,9 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, struct svc_fh *currentfh,
>>>>    * open or lock state.
>>>>    */
>>>>   static void
>>>> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>> -		     struct svc_fh *currentfh)
>>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>>>> +		     struct nfs4_ol_stateid *stp, struct svc_fh *currentfh,
>>>> +		     struct svc_fh *fh)
>>>>   {
>>>>   	bool deleg_ts = open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>>>>   	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>>>> @@ -6205,7 +6226,8 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>>>   	memcpy(&open->op_delegate_stateid, &dp->dl_stid.sc_stateid, sizeof(dp->dl_stid.sc_stateid));
>>>>   
>>>>   	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>> -		if (!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>> +		if (!nfsd4_add_rdaccess_to_wrdeleg(rqstp, open, fh, stp) ||
>>>> +				!nfs4_delegation_stat(dp, currentfh, &stat)) {
>>>>   			nfs4_put_stid(&dp->dl_stid);
>>>>   			destroy_delegation(dp);
>>>>   			goto out_no_deleg;
>>>> @@ -6361,7 +6383,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
>>>>   	* Attempt to hand out a delegation. No error return, because the
>>>>   	* OPEN succeeds even if we fail.
>>>>   	*/
>>>> -	nfs4_open_delegation(open, stp, &resp->cstate.current_fh);
>>>> +	nfs4_open_delegation(rqstp, open, stp,
>>>> +		&resp->cstate.current_fh, current_fh);
>>>>   
>>>>   	/*
>>>>   	 * If there is an existing open stateid, it must be updated and
>>>> @@ -7063,7 +7086,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
>>>>   		return_revoked = true;
>>>>   	if (typemask & SC_TYPE_DELEG)
>>>>   		/* Always allow REVOKED for DELEG so we can
>>>> -		 * retturn the appropriate error.
>>>> +		 * return the appropriate error.
>>>>   		 */
>>>>   		statusmask |= SC_STATUS_REVOKED;
>>>>   
>>>> @@ -7106,10 +7129,6 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
>>>>   
>>>>   	switch (s->sc_type) {
>>>>   	case SC_TYPE_DELEG:
>>>> -		spin_lock(&s->sc_file->fi_lock);
>>>> -		ret = nfsd_file_get(s->sc_file->fi_deleg_file);
>>>> -		spin_unlock(&s->sc_file->fi_lock);
>>>> -		break;
>>>>   	case SC_TYPE_OPEN:
>>>>   	case SC_TYPE_LOCK:
>>>>   		if (flags & RD_STATE)
>>> I'm seeing a nfsd_file leak in chuck's nfsd-next tree and a bisect
>>> landed on this patch. The reproducer is:
>>>
>>> 1/ set up an exported fs on a server (I used xfs, but it probably
>>> doesn't matter).
>>>
>>> 2/ mount up the export on a client using v4.2
>>>
>>> 3/ Run this fio script in the directory:
>>>
>>> ----------------8<---------------------
>>> [global]
>>> name=fio-seq-write
>>> filename=fio-seq-write
>>> rw=write
>>> bs=1M
>>> direct=0
>>> numjobs=1
>>> time_based
>>> runtime=60
>>>
>>> [file1]
>>> size=50G
>>> ioengine=io_uring
>>> iodepth=16
>>> ----------------8<---------------------
>>>
>>> When it completes, shut down the nfs server. You'll see warnings like
>>> this:
>>>
>>>      BUG nfsd_file (Tainted: G    B   W          ): Objects remaining on __kmem_cache_shutdown()
>>>
>>> Dai, can you take a look?
>> After any substantial NFSv4 workload on my nfsd-testing server followed
>> by a clean unmount from the client, /proc/fs/nfsd/filecache still has
>> junk in it:
>>
>> total inodes:  281105
>> hash buckets:  524288
>> lru entries:   0
>> cache hits:    307264
>> acquisitions:  2092346
>> allocations:   1785084
>> releases:      1503979
>> evictions:     0
>> mean age (ms): 400
>>
>> Looks like a leak to me.
>>
>>
> An additional symptom: At shutdown I see the unmount of exports fail
> with EBUSY. I don't see the crash that Jeff reports above, but I'm
> guessing he's got some extra slub debugging enabled.
>
> I've dropped "NFSD: Offer write delegation for OPEN with
> OPEN4_SHARE_ACCESS_WRITE" from nfsd-next for the moment.
>

Consistent with the kmemleak complaint that I see a bunch of (running
simple untar):
--
unreferenced object 0xffff8c778fd93e80 (size 128):
   comm "nfsd", pid 920, jiffies 4300669441
   hex dump (first 32 bytes):
     80 1d 87 8d 77 8c ff ff 00 00 00 00 00 00 00 00 ....w...........
     28 e4 b7 c9 77 8c ff ff 00 b3 20 8f 77 8c ff ff  (...w..... .w...
   backtrace (crc 3c1e761e):
     kmemleak_alloc+0x4a/0x90
     kmem_cache_alloc_noprof+0x344/0x410
     nfsd_file_do_acquire+0x22e/0xd70 [nfsd]
     nfsd_file_acquire_opened+0x30/0x50 [nfsd]
     nfs4_open_delegation+0xfd9/0x12d0 [nfsd]
     nfsd4_process_open2+0x4a1/0xa30 [nfsd]
     nfsd4_open+0x833/0xf50 [nfsd]
     nfsd4_proc_compound+0x3b0/0x7d0 [nfsd]
     nfsd_dispatch+0xd3/0x210 [nfsd]
     svc_process_common+0x465/0x760 [sunrpc]
     svc_process+0x136/0x1f0 [sunrpc]
     svc_recv+0x925/0xb20 [sunrpc]
     nfsd+0x90/0xf0 [nfsd]
     kthread+0x119/0x240
     ret_from_fork+0x44/0x70
     ret_from_fork_asm+0x1a/0x30


