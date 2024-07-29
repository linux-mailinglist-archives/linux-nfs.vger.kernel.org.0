Return-Path: <linux-nfs+bounces-5139-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4DD93F737
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 16:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71D81F2252A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 14:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC03B548F7;
	Mon, 29 Jul 2024 14:05:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA31487C6
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261919; cv=none; b=igYFX9LS6Fo+ILyZjZbEFg8kfCNIggdV4JUePyF0mh+vJ7B0J01jH+LDeFsMf/xXgQhR/o2JiYL5Uzm8L3D1VQZ1looDXfsSgzsC2dYWIokgoa2NjtVZYx0budL0BXetjcRyrGZeNHfcNqm69x3g6sRqIl/HOAj1/d8kIks0V1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261919; c=relaxed/simple;
	bh=6KBK2gjarQeBwlXJmGyMNXZdRzzCzx0elA6G/0CKKfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrB6udAOHTO2WdtuxV2X38OhnTnnhMIvNl8xro72BhDdK+VHHDAYAPqvHP7mk2e0bZJD+jZ8x7/TpIMfqSriRzpXkXCUh4ZcceI8Zgz72n7aj/T6juBaRQ2zuz/wMWiaC7RAEO+cCMZDrdNCR/HueMu0pRDAHMf5k/kMsgUFq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3684e2d0d8bso267699f8f.2
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 07:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722261916; x=1722866716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Odm2zGUIP35TLZxyEVeDyIYnBs5IKQG8Vnv6UpouyuQ=;
        b=bTtnOExCI9F8KmFWSlhv0ThCKMNQG7UnseMnD+1RY8oTuabD6m1bhQriZ/FQRxYZHr
         lFkRXeVwQWqAgryLifTf3C6kycHofLSlAh5QA2wM6zu7scAMTAS3ePJI0yX30i4ycGs+
         yIh7zx05ScuyLokFtawtGvUlje8NWTr4eZ7vcxGql4LPNzIqpENWJvKhnAtUVA5UVsqU
         BkLz+3CsbxQaKt0JAy2PyOcavvXC6EDCoXSLZspJUCWzJCdJ3z62PbTL592NDJQH9ky4
         Qz5IVhZJdcQ/hnWuuRiIgUFNSG9VA/Ev2d2IFsvG0PRSMDDzkpEFpQ3oCNDCAJlP/O7U
         yRiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/RlitQ/TUzId2Jlzfr1MFW5IQz7UNhFbKtJGqEEJVfb0Wk+jEHTYrVB18bGGx4izfuw1pFsvja9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd56xFPs3CACCfyNVhd0ittgtyP0TzgtKYLL0OVHnlRiaIhtVG
	NYoSWoyiRJZ/SEXi/Ebr/O/2wRbY8s0nzPu3h55bqVUkLCwEmuXDLv1txw==
X-Google-Smtp-Source: AGHT+IEeKKNCA+fSUXIZXfKLUuk/bIlQevAaC8HYC6AAmsPjjpgYafqa2/vGf4qq9NMuiJLg7VDJbw==
X-Received: by 2002:a05:6000:2cf:b0:368:4c5:1b5a with SMTP id ffacd0b85a97d-36b34e3d995mr6598770f8f.9.1722261915529;
        Mon, 29 Jul 2024 07:05:15 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c06f4sm12426596f8f.6.2024.07.29.07.05.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 07:05:15 -0700 (PDT)
Message-ID: <92b8506f-05fe-4ad1-abb4-d2a269041352@grimberg.me>
Date: Mon, 29 Jul 2024 17:05:13 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nfsd: Offer write delegations for o_wronly opens
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
 Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
References: <20240728204104.519041-1-sagi@grimberg.me>
 <20240728204104.519041-3-sagi@grimberg.me>
 <81765320f56c349298be08457ef2211a581c29f9.camel@kernel.org>
 <6a78bd6b-b5c4-489c-a7dd-bd688fed8d94@grimberg.me>
 <cb6cf6834ca3383804b7bd994eeaf310cfbf8c78.camel@kernel.org>
 <0fc73dce-1ab1-4229-a81e-3c058e2bcee3@grimberg.me>
 <ZqeetZx5MjiSnu5J@tissot.1015granger.net>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZqeetZx5MjiSnu5J@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit




On 29/07/2024 16:52, Chuck Lever wrote:
> On Mon, Jul 29, 2024 at 04:39:07PM +0300, Sagi Grimberg wrote:
>>
>>
>> On 29/07/2024 16:10, Jeff Layton wrote:
>>> On Mon, 2024-07-29 at 15:58 +0300, Sagi Grimberg wrote:
>>>>
>>>> On 29/07/2024 15:10, Jeff Layton wrote:
>>>>> On Sun, 2024-07-28 at 23:41 +0300, Sagi Grimberg wrote:
>>>>>> In order to support write delegations with O_WRONLY opens, we
>>>>>> need to
>>>>>> allow the clients to read using the write delegation stateid (Per
>>>>>> RFC
>>>>>> 8881 section 9.1.2. Use of the Stateid and Locking).
>>>>>>
>>>>>> Hence, we check for NFS4_SHARE_ACCESS_WRITE set in open request,
>>>>>> and
>>>>>> in case the share access flag does not set NFS4_SHARE_ACCESS_READ
>>>>>> as
>>>>>> well, we'll open the file locally with O_RDWR in order to allow
>>>>>> the
>>>>>> client to use the write delegation stateid when issuing a read in
>>>>>> case
>>>>>> it may choose to.
>>>>>>
>>>>>> Plus, find_rw_file singular call-site is now removed, remove it
>>>>>> altogether.
>>>>>>
>>>>>> Note: reads using special stateids that conflict with pending
>>>>>> write
>>>>>> delegations are undetected, and will be covered in a follow on
>>>>>> patch.
>>>>>>
>>>>>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>>>> ---
>>>>>>     fs/nfsd/nfs4proc.c  | 18 +++++++++++++++++-
>>>>>>     fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++------------------
>>>>>> ----
>>>>>>     fs/nfsd/xdr4.h      |  2 ++
>>>>>>     3 files changed, 39 insertions(+), 23 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>>>>>> index 7b70309ad8fb..041bcc3ab5d7 100644
>>>>>> --- a/fs/nfsd/nfs4proc.c
>>>>>> +++ b/fs/nfsd/nfs4proc.c
>>>>>> @@ -979,8 +979,22 @@ nfsd4_read(struct svc_rqst *rqstp, struct
>>>>>> nfsd4_compound_state *cstate,
>>>>>>     	/* check stateid */
>>>>>>     	status = nfs4_preprocess_stateid_op(rqstp, cstate,
>>>>>> &cstate-
>>>>>>> current_fh,
>>>>>>     					&read->rd_stateid,
>>>>>> RD_STATE,
>>>>>> -					&read->rd_nf, NULL);
>>>>>> +					&read->rd_nf, &read-
>>>>>>> rd_wd_stid);
>>>>>> +	/*
>>>>>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow
>>>>>> write
>>>>>> +	 * delegation stateid used for read. Its refcount is
>>>>>> decremented
>>>>>> +	 * by nfsd4_read_release when read is done.
>>>>>> +	 */
>>>>>> +	if (!status) {
>>>>>> +		if (read->rd_wd_stid &&
>>>>>> +		    (read->rd_wd_stid->sc_type != SC_TYPE_DELEG
>>>>>> ||
>>>>>> +		     delegstateid(read->rd_wd_stid)->dl_type !=
>>>>>> +					NFS4_OPEN_DELEGATE_WRITE
>>>>>> )) {
>>>>>> +			nfs4_put_stid(read->rd_wd_stid);
>>>>>> +			read->rd_wd_stid = NULL;
>>>>>> +		}
>>>>>> +	}
>>>>>>     	read->rd_rqstp = rqstp;
>>>>>>     	read->rd_fhp = &cstate->current_fh;
>>>>>>     	return status;
>>>>>> @@ -990,6 +1004,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct
>>>>>> nfsd4_compound_state *cstate,
>>>>>>     static void
>>>>>>     nfsd4_read_release(union nfsd4_op_u *u)
>>>>>>     {
>>>>>> +	if (u->read.rd_wd_stid)
>>>>>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>>>>>     	if (u->read.rd_nf)
>>>>>>     		nfsd_file_put(u->read.rd_nf);
>>>>>>     	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>>>>>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>>>>>> index 0645fccbf122..538b6e1127a2 100644
>>>>>> --- a/fs/nfsd/nfs4state.c
>>>>>> +++ b/fs/nfsd/nfs4state.c
>>>>>> @@ -639,18 +639,6 @@ find_readable_file(struct nfs4_file *f)
>>>>>>     	return ret;
>>>>>>     }
>>>>>> -static struct nfsd_file *
>>>>>> -find_rw_file(struct nfs4_file *f)
>>>>>> -{
>>>>>> -	struct nfsd_file *ret;
>>>>>> -
>>>>>> -	spin_lock(&f->fi_lock);
>>>>>> -	ret = nfsd_file_get(f->fi_fds[O_RDWR]);
>>>>>> -	spin_unlock(&f->fi_lock);
>>>>>> -
>>>>>> -	return ret;
>>>>>> -}
>>>>>> -
>>>>>>     struct nfsd_file *
>>>>>>     find_any_file(struct nfs4_file *f)
>>>>>>     {
>>>>>> @@ -5784,15 +5772,11 @@ nfs4_set_delegation(struct nfsd4_open
>>>>>> *open,
>>>>>> struct nfs4_ol_stateid *stp,
>>>>>>     	 *  "An OPEN_DELEGATE_WRITE delegation allows the client
>>>>>> to
>>>>>> handle,
>>>>>>     	 *   on its own, all opens."
>>>>>>     	 *
>>>>>> -	 * Furthermore the client can use a write delegation for
>>>>>> most READ
>>>>>> -	 * operations as well, so we require a O_RDWR file here.
>>>>>> -	 *
>>>>>> -	 * Offer a write delegation in the case of a BOTH open,
>>>>>> and
>>>>>> ensure
>>>>>> -	 * we get the O_RDWR descriptor.
>>>>>> +	 * Offer a write delegation for WRITE or BOTH access
>>>>>>     	 */
>>>>>> -	if ((open->op_share_access & NFS4_SHARE_ACCESS_BOTH) ==
>>>>>> NFS4_SHARE_ACCESS_BOTH) {
>>>>>> -		nf = find_rw_file(fp);
>>>>>> +	if (open->op_share_access & NFS4_SHARE_ACCESS_WRITE) {
>>>>>>     		dl_type = NFS4_OPEN_DELEGATE_WRITE;
>>>>>> +		nf = find_writeable_file(fp);
>>>>>>     	}
>>>>>>     	/*
>>>>>> @@ -5934,8 +5918,8 @@ static void
>>>>>> nfsd4_open_deleg_none_ext(struct
>>>>>> nfsd4_open *open, int status)
>>>>>>      * open or lock state.
>>>>>>      */
>>>>>>     static void
>>>>>> -nfs4_open_delegation(struct nfsd4_open *open, struct
>>>>>> nfs4_ol_stateid
>>>>>> *stp,
>>>>>> -		     struct svc_fh *currentfh)
>>>>>> +nfs4_open_delegation(struct svc_rqst *rqstp, struct nfsd4_open
>>>>>> *open,
>>>>>> +		struct nfs4_ol_stateid *stp, struct svc_fh
>>>>>> *currentfh)
>>>>>>     {
>>>>>>     	struct nfs4_delegation *dp;
>>>>>>     	struct nfs4_openowner *oo = openowner(stp-
>>>>>>> st_stateowner);
>>>>>> @@ -5994,6 +5978,20 @@ nfs4_open_delegation(struct nfsd4_open
>>>>>> *open,
>>>>>> struct nfs4_ol_stateid *stp,
>>>>>>     		dp->dl_cb_fattr.ncf_cur_fsize = stat.size;
>>>>>>     		dp->dl_cb_fattr.ncf_initial_cinfo =
>>>>>>     			nfsd4_change_attribute(&stat,
>>>>>> d_inode(currentfh->fh_dentry));
>>>>>> +		if ((open->op_share_access &
>>>>>> NFS4_SHARE_ACCESS_BOTH)
>>>>>> != NFS4_SHARE_ACCESS_BOTH) {
>>>>>> +			struct nfsd_file *nf = NULL;
>>>>>> +
>>>>>> +			/* make sure the file is opened locally
>>>>>> for
>>>>>> O_RDWR */
>>>>>> +			status = nfsd_file_acquire_opened(rqstp,
>>>>>> currentfh,
>>>>>> +				nfs4_access_to_access(NFS4_SHARE
>>>>>> _ACC
>>>>>> ESS_BOTH),
>>>>>> +				open->op_filp, &nf);
>>>>>> +			if (status) {
>>>>>> +				nfs4_put_stid(&dp->dl_stid);
>>>>>> +				destroy_delegation(dp);
>>>>>> +				goto out_no_deleg;
>>>>>> +			}
>>>>>> +			stp->st_stid.sc_file->fi_fds[O_RDWR] =
>>>>>> nf;
>>>>> I have a bit of a concern here. When we go to put access references
>>>>> to
>>>>> the fi_fds, that's done according to the st_access_bmap. Here
>>>>> though,
>>>>> you're adding an extra reference for the O_RDWR fd, but I don't see
>>>>> where you're calling set_access for that on the delegation stateid?
>>>>> Am
>>>>> I missing where that happens? Not doing that may lead to fd leaks
>>>>> if it
>>>>> was missed.
>>>> Ah, this is something that I did not fully understand...
>>>> However it looks like st_access_bmap is not something that is
>>>> accounted on the delegation stateid...
>>>>
>>>> Can I simply set it on the open stateid (stp)?
>>> That would likely fix the leak, but I'm not sure that's the best
>>> approach. You have an NFS4_SHARE_ACCESS_WRITE-only stateid here, and
>>> that would turn it a NFS4_SHARE_ACCESS_BOTH one, wouldn't it?
>>>
>>> It wouldn't surprise me if that might break a testcase or two.
>> Well, if the server handed out a write delegation, isn't it effectively
>> equivalent to
>> NFS4_SHARE_ACCESS_BOTH open?
> It has to be equivalent, since the write delegation gives the client
> carte blanche to perform any open it wants to, locally. The server
> does not know about those local client-side opens, and it has a
> notification set up to fire if anyone else wants to open that file.
>
> In nfs4_set_delegation(), we have this comment:
>
>>        /*
>>         * Try for a write delegation first. RFC8881 section 10.4 says:
>>         *
>>         *  "An OPEN_DELEGATE_WRITE delegation allows the client to handle,
>>         *   on its own, all opens."
>>         *
>>         * Furthermore the client can use a write delegation for most READ
>>         * operations as well, so we require a O_RDWR file here.
>>         *
>>         * Offer a write delegation in the case of a BOTH open, and ensure
>>         * we get the O_RDWR descriptor.
>>         */
> I think we did it this way only to circumvent the broken test cases.
>
> A write delegation stateid uses a local O_RDWR OPEN, yes? If so, why
> can't it be used for READ operations already? All that has to be
> done is hand out the write delegation in the correct cases.
>
> Instead of gating the delegation on the intent presented by the OPEN
> operation, gate it on whether the user who is opening the file has
> both read and write access to the file.

Umm, I'm a little unclear on what is the suggestion here Chuck. You mean
checking the openowner permissions to access the file? If so, won't buffered
read-modify-write be a problem ?

