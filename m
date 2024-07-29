Return-Path: <linux-nfs+bounces-5132-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2709293F5FF
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 14:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029801C2218A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 12:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD214901B;
	Mon, 29 Jul 2024 12:58:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D4B148826
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257932; cv=none; b=dW7YRNUkOW34mG4qRGTJsGmjngI/xrwCXytOg8mSMiYQm2vBMfsrZUqiyhIHKzuF7OZmlvDgc5wXrVWWH/CgYXfuGisaE/D7mXNh8MbeGK7MPNWIt52V0BBgPAZk1AqCcfZdUpRzwoS59bSwqSB/U0jqLY+AdmjMxsYU2LWZE+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257932; c=relaxed/simple;
	bh=ZzEhtHNYiC/QdDw6XckAQZmLbZnJleBG1E5TMCN29wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJUl5ciQwe7eqpDT/miAP/C3pX8isj4pyZPK8gy7GS2lmt4BRUUUEXiAYVfILHlbzGOH9KA0OxQ9xH9hykXgtQnBHnMAhbl7gQMxn8GIjfL5GqmdCshh9FNmKw9XJ5oQouFNMY3SYQLJxhguc/0+R7INGNeDXWNi4B84k5069iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36830a54b34so250326f8f.0
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 05:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257929; x=1722862729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gniDgVWezgZ15ReB5A+uynQH11FwStHDAHn3P5u02z0=;
        b=CJEalk2vfcbN5k6KZ+jjoBiN00bDZfySC/dfQP6Se3AbecsVV2Lt1IWLMbsSTo/4xx
         z6bRkWgrAuTPDiADvZ0RypplNb/Hqd0nI0PisqYlXWHV+a/FFxDd1Z4bZUSzFiDJTgge
         Z8XO9hhJyps0YTv2v1fgW5CqUD2ttzFCuWS6i3W4FXyBrjNuj9qMzrqSr6iw1c5WO1Lh
         DnEw0W2s4SXUWdb+MPUC3y5p2PHxTF4EUDrFOdBztMyN/6IcNLxMPoWmbCvH5/gQUPhv
         10d1LJKsD9J4MXA1PukNO+zRV/kfvoSEtrE28n8+exd1EXxfFTefaPe5IVa0l/X/Ag1o
         8syw==
X-Forwarded-Encrypted: i=1; AJvYcCWiThgBP+E/1QwlnVIDBQJ4JiYLfTYNALFML87tWidJhcc+59Xc8Az3N/PHoPEz/CSx0Mc28V0V/HjQEzKsKKIV/aa9tmlFxZbq
X-Gm-Message-State: AOJu0YyE3sMDel65P5Pg0euIYoAEHnmpBnD7htsIPrMwESGUsk9UJ3U+
	NeyTORk4XHjx7FbX0dDMLu3h+D5JGXcqgj1oxfGH45oPXxBORAyU
X-Google-Smtp-Source: AGHT+IE+SbcUS0oMXR4Pa7RTljpC67wRzwBwVQOzi32/CJOvuK5w7pOM8DKlVmDgdk14obKsjFkCuQ==
X-Received: by 2002:a05:6000:402c:b0:366:eb60:bd0c with SMTP id ffacd0b85a97d-36b34bf28ebmr6517212f8f.3.1722257928184;
        Mon, 29 Jul 2024 05:58:48 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281ef5a416sm21275285e9.33.2024.07.29.05.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 05:58:47 -0700 (PDT)
Message-ID: <6a78bd6b-b5c4-489c-a7dd-bd688fed8d94@grimberg.me>
Date: Mon, 29 Jul 2024 15:58:46 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, Olga Kornievskaia <aglo@umich.edu>,
 linux-nfs@vger.kernel.org
References: <20240728204104.519041-1-sagi@grimberg.me>
 <20240728204104.519041-3-sagi@grimberg.me>
 <81765320f56c349298be08457ef2211a581c29f9.camel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <81765320f56c349298be08457ef2211a581c29f9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 29/07/2024 15:10, Jeff Layton wrote:
> On Sun, 2024-07-28 at 23:41 +0300, Sagi Grimberg wrote:
>> In order to support write delegations with O_WRONLY opens, we need to
>> allow the clients to read using the write delegation stateid (Per RFC
>> 8881 section 9.1.2. Use of the Stateid and Locking).
>>
>> Hence, we check for NFS4_SHARE_ACCESS_WRITE set in open request, and
>> in case the share access flag does not set NFS4_SHARE_ACCESS_READ as
>> well, we'll open the file locally with O_RDWR in order to allow the
>> client to use the write delegation stateid when issuing a read in
>> case
>> it may choose to.
>>
>> Plus, find_rw_file singular call-site is now removed, remove it
>> altogether.
>>
>> Note: reads using special stateids that conflict with pending write
>> delegations are undetected, and will be covered in a follow on patch.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   fs/nfsd/nfs4proc.c  | 18 +++++++++++++++++-
>>   fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++----------------------
>>   fs/nfsd/xdr4.h      |  2 ++
>>   3 files changed, 39 insertions(+), 23 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 7b70309ad8fb..041bcc3ab5d7 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -979,8 +979,22 @@ nfsd4_read(struct svc_rqst *rqstp, struct
>> nfsd4_compound_state *cstate,
>>   	/* check stateid */
>>   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate-
>>> current_fh,
>>   					&read->rd_stateid, RD_STATE,
>> -					&read->rd_nf, NULL);
>> +					&read->rd_nf, &read-
>>> rd_wd_stid);
>>   
>> +	/*
>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
>> +	 * delegation stateid used for read. Its refcount is
>> decremented
>> +	 * by nfsd4_read_release when read is done.
>> +	 */
>> +	if (!status) {
>> +		if (read->rd_wd_stid &&
>> +		    (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
>> +		     delegstateid(read->rd_wd_stid)->dl_type !=
>> +					NFS4_OPEN_DELEGATE_WRITE)) {
>> +			nfs4_put_stid(read->rd_wd_stid);
>> +			read->rd_wd_stid = NULL;
>> +		}
>> +	}
>>   	read->rd_rqstp = rqstp;
>>   	read->rd_fhp = &cstate->current_fh;
>>   	return status;
>> @@ -990,6 +1004,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct
>> nfsd4_compound_state *cstate,
>>   static void
>>   nfsd4_read_release(union nfsd4_op_u *u)
>>   {
>> +	if (u->read.rd_wd_stid)
>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>   	if (u->read.rd_nf)
>>   		nfsd_file_put(u->read.rd_nf);
>>   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 0645fccbf122..538b6e1127a2 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -639,18 +639,6 @@ find_readable_file(struct nfs4_file *f)
>>   	return ret;
>>   }
>>   
>> -static struct nfsd_file *
>> -find_rw_file(struct nfs4_file *f)
>> -{
>> -	struct nfsd_file *ret;
>> -
>> -	spin_lock(&f->fi_lock);
>> -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
>> -	spin_unlock(&f->fi_lock);
>> -
>> -	return ret;
>> -}
>> -
>>   struct nfsd_file *
>>   find_any_file(struct nfs4_file *f)
>>   {
>> @@ -5784,15 +5772,11 @@ nfs4_set_delegation(struct nfsd4_open *open,
>> struct nfs4_ol_stateid *stp,
>>   	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to
>> handle,
>>   	 *   on its own, all opens."
>>   	 *
>> -	 * Furthermore the client can use a write delegation for
>> most READ
>> -	 * operations as well, so we require a O_RDWR file here.
>> -	 *
>> -	 * Offer a write delegation in the case of a BOTH open, and
>> ensure
>> -	 * we get the O_RDWR descriptor.
>> +	 * Offer a write delegation for WRITE or BOTH access
>>   	 */
>> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>> NFS4_SHARE_ACCESS_BOTH) {
>> -		nf = find_rw_file(fp);
>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>   		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>> +		nf = find_writeable_file(fp);
>>   	}
>>   
>>   	/*
>> @@ -5934,8 +5918,8 @@ static void nfsd4_open_deleg_none_ext(struct
>> nfsd4_open *open, int status)
>>    * open or lock state.
>>    */
>>   static void
>> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid
>> *stp,
>> -		     struct svc_fh *currentfh)
>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open
>> *open,
>> +		struct nfs4_ol_stateid *stp, struct svc_fh
>> *currentfh)
>>   {
>>   	struct nfs4_delegation *dp;
>>   	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>> @@ -5994,6 +5978,20 @@ nfs4_open_delegation(struct nfsd4_open *open,
>> struct nfs4_ol_stateid *stp,
>>   		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>   		dp->dl_cb_fattr.ncf_initial_cinfo =
>>   			nfsd4_change_attribute(&stat,
>> d_inode(currentfh->fh_dentry));
>> +		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH)
>> != NFS4_SHARE_ACCESS_BOTH) {
>> +			struct nfsd_file *nf = NULL;
>> +
>> +			/* make sure the file is opened locally for
>> O_RDWR */
>> +			status = nfsd_file_acquire_opened(rqstp,
>> currentfh,
>> +				nfs4_access_to_access(NFS4_SHARE_ACC
>> ESS_BOTH),
>> +				open->op_filp, &nf);
>> +			if (status) {
>> +				nfs4_put_stid(&dp->dl_stid);
>> +				destroy_delegation(dp);
>> +				goto out_no_deleg;
>> +			}
>> +			stp->st_stid.sc_file->fi_fds[O_RDWR] = nf;
> I have a bit of a concern here. When we go to put access references to
> the fi_fds, that's done according to the st_access_bmap. Here though,
> you're adding an extra reference for the O_RDWR fd, but I don't see
> where you're calling set_access for that on the delegation stateid? Am
> I missing where that happens? Not doing that may lead to fd leaks if it
> was missed.

Ah, this is something that I did not fully understand...
However it looks like st_access_bmap is not something that is
accounted on the delegation stateid...

Can I simply set it on the open stateid (stp)?

