Return-Path: <linux-nfs+bounces-5133-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD493F604
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6B4B21CD2
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F5148FE1;
	Mon, 29 Jul 2024 13:00:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4E148826
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722258000; cv=none; b=snZQhDsgtxMDYbM+ijt3cXmHLpzWnXECjI7OnFq+kzdhHhxOjL9MjcSRRV3RAz38jtXrBEb0sTEt8DltJXxvY+PJY+wfa+Si2m8VBEy2GC+VFOalQ6nZaElzIVx/5Lc2O6KeVhsg3q8E15fxR9l8uD+IiRAhBKBgYJYG1GR7pkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722258000; c=relaxed/simple;
	bh=y5vA7y5/JrEUZ/vmZyEMy2++a973Z8AY7KmX1cPfy0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LbcMwSSY0jxKmnz+LZ0z0Y2pUZ4IfqjjuvN2CkYjuMWTlVItkXZH792M8MlmlGkSi21GkraXzRrasTOx3i0nyZxrhugtFbHC0pKDsbde16HkvqOOpPZmKzPjeq6R8HGicU7GptlCKxerKuIf2fpj5WSWDufracuVAV1uzWyShCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36841f56cf6so343023f8f.3
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 05:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257997; x=1722862797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efmBKwSNYuKKHSTA+MjGcBcnPxih0fMmh8ChlvsXqJg=;
        b=aKx6S7xZ+j56ApsU17n/KfXCAsLzrNP4vZbhkYg7JO92elFNxqY7a8D2UE6NwHCb+T
         LVxDoQ1nh4DeeGVnu2GiyY6Fq1PKgYulHjVY+4kKqlydRHcZsTcuushFqVDxVZSfDeBj
         DsUSShVC4168XoKjSlkABIIEcr4sdKHGDQSmcFJ84PigVh6E9Srb3iEjtradIRRczIvw
         ntTXFlRN4PH8cLtUdafcA2Qd4h92OLCjWnRnmE+cFasfBwsteyBSkFdZRuTmDzBoDoFk
         ku4gv24l3Kfo+8As+SdoFNYDZj1tlDqEufhLH0+dqo57ZGUbNEFDPGiG16kv3XSowTBD
         eT7A==
X-Forwarded-Encrypted: i=1; AJvYcCXbDlB6nyJNOgPqTEyNWAH+vNpi2OxnzNlMbzsLnH+OfhTmnARFY2VcV+udxbk0Mv0gEDQEmGT8ZI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+hGbXIlabh+/T51skNylAs1LBfbtaA53JzJGhUJAyHoF8Js0z
	Q2DEZkod+k02i9EnuwIizaSChZeiS8IGzz58n2kwrFP16Pe9moPs
X-Google-Smtp-Source: AGHT+IENgiIxyQzDPZK2RoSjkWDm8vbcT2bMiXCEQhJEW1s0YaU1yYg1H02/yKv9iYEwAFI+OW2fmQ==
X-Received: by 2002:a05:6000:1849:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-36b34d183b9mr6276959f8f.2.1722257996871;
        Mon, 29 Jul 2024 05:59:56 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0113sm12201668f8f.14.2024.07.29.05.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 05:59:56 -0700 (PDT)
Message-ID: <a468cd66-0099-4642-a0cd-7f0a3c5cbe66@grimberg.me>
Date: Mon, 29 Jul 2024 15:59:55 +0300
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
 <78944d2e1ba2831eb6e46bd7009dfd5e176d48bb.camel@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <78944d2e1ba2831eb6e46bd7009dfd5e176d48bb.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 29/07/2024 15:26, Jeff Layton wrote:
> On Sun, 2024-07-28 at 23:41 +0300, Sagi Grimberg wrote:
>> In order to support write delegations with O_WRONLY opens, we need to
>> allow the clients to read using the write delegation stateid (Per RFC
>> 8881 section 9.1.2. Use of the Stateid and Locking).
>>
>> Hence, we check for NFS4_SHARE_ACCESS_WRITE set in open request, and
>> in case the share access flag does not set NFS4_SHARE_ACCESS_READ as
>> well, we'll open the file locally with O_RDWR in order to allow the
>> client to use the write delegation stateid when issuing a read in case
>> it may choose to.
>>
>> Plus, find_rw_file singular call-site is now removed, remove it altogether.
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
>> @@ -979,8 +979,22 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	/* check stateid */
>>   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>>   					&read->rd_stateid, RD_STATE,
>> -					&read->rd_nf, NULL);
>> +					&read->rd_nf, &read->rd_wd_stid);
>>   
>> +	/*
>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
>> +	 * delegation stateid used for read. Its refcount is decremented
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
>> @@ -990,6 +1004,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
>> @@ -5784,15 +5772,11 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   	 *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>   	 *   on its own, all opens."
>>   	 *
>> -	 * Furthermore the client can use a write delegation for most READ
>> -	 * operations as well, so we require a O_RDWR file here.
>> -	 *
>> -	 * Offer a write delegation in the case of a BOTH open, and ensure
>> -	 * we get the O_RDWR descriptor.
>> +	 * Offer a write delegation for WRITE or BOTH access
>>   	 */
>> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) == NFS4_SHARE_ACCESS_BOTH) {
>> -		nf = find_rw_file(fp);
>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>   		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>> +		nf = find_writeable_file(fp);
>>   	}
>>   
>>   	/*
>> @@ -5934,8 +5918,8 @@ static void nfsd4_open_deleg_none_ext(struct nfsd4_open *open, int status)
>>    * open or lock state.
>>    */
>>   static void
>> -nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>> -		     struct svc_fh *currentfh)
>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open *open,
>> +		struct nfs4_ol_stateid *stp, struct svc_fh *currentfh)
>>   {
>>   	struct nfs4_delegation *dp;
>>   	struct nfs4_openowner *oo = openowner(stp->st_stateowner);
>> @@ -5994,6 +5978,20 @@ nfs4_open_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>>   		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>   		dp->dl_cb_fattr.ncf_initial_cinfo =
>>   			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
>> +		if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) != NFS4_SHARE_ACCESS_BOTH) {
> More comments on this part:
>
>
> nit: You've already tested for NFS4_SHARE_ACCESS_WRITE here, and this
> seems easier to read:
>
> 		if (!(open->op_share_access & NFS4_SHARE_ACCESS_READ))
>
>
>
>> +			struct nfsd_file *nf = NULL;
>> +
>> +			/* make sure the file is opened locally for O_RDWR */
>> +			status = nfsd_file_acquire_opened(rqstp, currentfh,
>> +				nfs4_access_to_access(NFS4_SHARE_ACCESS_BOTH),
>> +				open->op_filp, &nf);
>> +			if (status) {
>> +				nfs4_put_stid(&dp->dl_stid);
>> +				destroy_delegation(dp);
>> +				goto out_no_deleg;
>> +			}
>> +			stp->st_stid.sc_file->fi_fds[O_RDWR] = nf;
> How do you know that this fd isn't already set? Also, this field is
> protected by the sc_file->fi_lock and that's not held here.

Something like this?
--
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a6c6d813c59c..ee0c65ff1940 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5978,19 +5978,24 @@ nfs4_open_delegation(struct svc_rqst *rqstp, 
struct nfsd4_open *open,
                 dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
                 dp->dl_cb_fattr.ncf_initial_cinfo =
                         nfsd4_change_attribute(&stat, 
d_inode(currentfh->fh_dentry));
-               if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) != 
NFS4_SHARE_ACCESS_BOTH) {
+               if (!(open->op_share_access & NFS4_SHARE_ACCESS_READ)) {
+                       u32 access = 
nfs4_access_to_access(NFS4_SHARE_ACCESS_BOTH);
+                       struct nfs4_file *fp = stp->st_stid.sc_file;
                         struct nfsd_file *nf = NULL;

                         /* make sure the file is opened locally for 
O_RDWR */
+                       set_access(access, stp);
                         status = nfsd_file_acquire_opened(rqstp, currentfh,
- nfs4_access_to_access(NFS4_SHARE_ACCESS_BOTH),
-                               open->op_filp, &nf);
+                                       access, open->op_filp, &nf);
                         if (status) {
                                 nfs4_put_stid(&dp->dl_stid);
                                 destroy_delegation(dp);
                                 goto out_no_deleg;
                         }
-                       stp->st_stid.sc_file->fi_fds[O_RDWR] = nf;
+                       spin_lock(&fp->fi_lock);
+                       if (!fp->fi_fds[O_RDWR])
+                               fp->fi_fds[O_RDWR] = nf;
+                       spin_lock(&fp->fi_lock);
                 }
         } else {
--

