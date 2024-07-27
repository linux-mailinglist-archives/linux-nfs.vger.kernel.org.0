Return-Path: <linux-nfs+bounces-5095-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C140D93E0B3
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 21:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1561C20986
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 19:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170BF1386B4;
	Sat, 27 Jul 2024 19:26:30 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553A11C83
	for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 19:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722108390; cv=none; b=qPZe6hX0pHRtWSS+oarOhzr43f/VkHy3P8mAiG9S2Xgm7Y2ayVsUFZd6dZhNctU1G2dBecwjmUJaQ+9eJZiVYQIKN0l2cP3q84x0pdXC+4xXBINz+SEVOwFTAzLb3ZFBwS8LaChXDEA4vhjxPtn6VIaX3xuwk9US+ZA1my+G95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722108390; c=relaxed/simple;
	bh=RKwAwi6H9mzt+VnvLf10WPSMTTjhvIqI66gCEM6VAFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyKDbCRH41bTYj0RlPcl7V0w4ZvlIUKF1MQJ2TNNlazO1jjrl5Ia4FpdwgY/8I/SpDG5ihOON2sIYZBaPg80oFFd2Bk1G7m8nja6p2aliQSeo5WetlrxwL/uVlE4BrhDQpMCELY60/AB1YQB1vlP/HviHqo38vZ2tes2v/Nczlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280921baa2so763055e9.2
        for <linux-nfs@vger.kernel.org>; Sat, 27 Jul 2024 12:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722108386; x=1722713186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLdxPuTsQWFTRZrMrb3+Kis20/VQXy3eSpHcfNbMQW4=;
        b=XX/u5TH63p5FAs8L2m5ERaYPRdhR30XlmNQoOTqUoGzngCy/Z435zgCXeNE5vuroKu
         BKOjMDvyrXkNUTN+Ird/HJCsWv8DtzpGDSPe0sofZoKAyx/xRtX6dYoSkVlC51OZdmu6
         NxC3tlgKrZ8ri+ByAE1N57xwaeAPHth96v2H37G1CWk5Agz1MrEagKYypWg3/KzHj8Ga
         QktzY/NrTRRJ0gEm9Db7NDZpP9hox6PWXil0jQFEM3A1b3lc/zFBRWi/yHGH3CSKEwDd
         QAReNOid224ZKlnAD+KY8Crw5gQqFfyHUgLvVQz5jp6BDC44nIGXK+KO4oaElsWHOnDu
         wpcw==
X-Forwarded-Encrypted: i=1; AJvYcCXUM6lGXe5KAgttWnOASamQJdIkEOWYJY/2SZNOCHwUemRKbMbWrIr4V+8TbkCliju0RtuZnzU4Z+qDpORyAdzXYzaLEGO4KMRm
X-Gm-Message-State: AOJu0YynVPzyL1O1b4bYa5k+iBk9sht+vhGw8sdk8pJzku6NHl0ZqK6U
	9CPrrAvmokiHE5TZh46rYpHUmTULDEJoOmSXZIfqizv2Fs/KjdPZ3lYRyg==
X-Google-Smtp-Source: AGHT+IHt1Pk4qzZRT0/kFX6YnaqobgBAdHm3tcZD3rxdhYsJCCh0ISusdhzId3kTY7jakp1RIWlnuQ==
X-Received: by 2002:a05:600c:3b87:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-428053c9c55mr42824725e9.0.1722108386093;
        Sat, 27 Jul 2024 12:26:26 -0700 (PDT)
Received: from [10.100.102.74] (89-138-69-172.bb.netvision.net.il. [89.138.69.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f941352asm163304385e9.41.2024.07.27.12.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 12:26:25 -0700 (PDT)
Message-ID: <a9705537-e9ec-47e6-8a96-b783868d96e9@grimberg.me>
Date: Sat, 27 Jul 2024 22:26:24 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 2/2] NFSD: allow client to use write delegation
 stateid for READ
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org
References: <20240724170138.1942307-1-sagi@grimberg.me>
 <20240724170138.1942307-2-sagi@grimberg.me>
 <ZqOtYYV2rQ7ROqXs@tissot.1015granger.net>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZqOtYYV2rQ7ROqXs@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 26/07/2024 17:06, Chuck Lever wrote:
> On Wed, Jul 24, 2024 at 10:01:38AM -0700, Sagi Grimberg wrote:
>> Based on a patch fom Dai Ngo, allow NFSv4 client to use write delegation
>> stateid for READ operation. Per RFC 8881 section 9.1.2. Use of the
>> Stateid and Locking.
>>
>> In addition, for anonymous stateids, check for pending delegations by
>> the filehandle and client_id, and if a conflict found, recall the delegation
>> before allowing the read to take place.
>>
>> Suggested-by: Dai Ngo <dai.ngo@oracle.com>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   fs/nfsd/nfs4proc.c  | 22 +++++++++++++++++++--
>>   fs/nfsd/nfs4state.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   |  9 +++++++++
>>   fs/nfsd/state.h     |  2 ++
>>   fs/nfsd/xdr4.h      |  2 ++
>>   5 files changed, 80 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index 7b70309ad8fb..324984ec70c6 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -979,8 +979,24 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   	/* check stateid */
>>   	status = nfs4_preprocess_stateid_op(rqstp, cstate, &cstate->current_fh,
>>   					&read->rd_stateid, RD_STATE,
>> -					&read->rd_nf, NULL);
>> -
>> +					&read->rd_nf, &read->rd_wd_stid);
>> +	/*
>> +	 * rd_wd_stid is needed for nfsd4_encode_read to allow write
>> +	 * delegation stateid used for read. Its refcount is decremented
>> +	 * by nfsd4_read_release when read is done.
>> +	 */
>> +	if (!status) {
>> +		if (!read->rd_wd_stid) {
>> +			/* special stateid? */
>> +			status = nfsd4_deleg_read_conflict(rqstp, cstate->clp,
>> +				&cstate->current_fh);
>> +		} else if (read->rd_wd_stid->sc_type != SC_TYPE_DELEG ||
>> +			   delegstateid(read->rd_wd_stid)->dl_type !=
>> +						NFS4_OPEN_DELEGATE_WRITE) {
>> +			nfs4_put_stid(read->rd_wd_stid);
>> +			read->rd_wd_stid = NULL;
>> +		}
>> +	}
>>   	read->rd_rqstp = rqstp;
>>   	read->rd_fhp = &cstate->current_fh;
>>   	return status;
>> @@ -990,6 +1006,8 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>   static void
>>   nfsd4_read_release(union nfsd4_op_u *u)
>>   {
>> +	if (u->read.rd_wd_stid)
>> +		nfs4_put_stid(u->read.rd_wd_stid);
>>   	if (u->read.rd_nf)
>>   		nfsd_file_put(u->read.rd_nf);
>>   	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index dc61a8adfcd4..7e6b9fb31a4c 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8805,6 +8805,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>   	get_stateid(cstate, &u->write.wr_stateid);
>>   }
>>   
>> +/**
>> + * nfsd4_deleg_read_conflict - Recall if read causes conflict
>> + * @rqstp: RPC transaction context
>> + * @clp: nfs client
>> + * @fhp: nfs file handle
>> + * @inode: file to be checked for a conflict
>> + * @modified: return true if file was modified
>> + * @size: new size of file if modified is true
>> + *
>> + * This function is called when there is a conflict between a write
>> + * delegation and a read that is using a special stateid where the
>> + * we cannot derive the client stateid exsistence. The server
>> + * must recall a conflicting delegation before allowing the read
>> + * to continue.
>> + *
>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>> + * code is returned.
>> + */
>> +__be32 nfsd4_deleg_read_conflict(struct svc_rqst *rqstp,
>> +		struct nfs4_client *clp, struct svc_fh *fhp)
>> +{
>> +	struct nfs4_file *fp;
>> +	__be32 status = 0;
>> +
>> +	fp = nfsd4_file_hash_lookup(fhp);
>> +	if (!fp)
>> +		return nfs_ok;
>> +
>> +	spin_lock(&state_lock);
>> +	spin_lock(&fp->fi_lock);
>> +	if (!list_empty(&fp->fi_delegations) &&
>> +	    !nfs4_delegation_exists(clp, fp)) {
>> +		/* conflict, recall deleg */
>> +		status = nfserrno(nfsd_open_break_lease(fp->fi_inode,
>> +					NFSD_MAY_READ));
>> +		if (status)
>> +			goto out;
>> +		if (!nfsd_wait_for_delegreturn(rqstp, fp->fi_inode))
>> +			status = nfserr_jukebox;
>> +	}
>> +out:
>> +	spin_unlock(&fp->fi_lock);
>> +	spin_unlock(&state_lock);
>> +	return status;
>> +}
>> +
>> +
>>   /**
>>    * nfsd4_deleg_getattr_conflict - Recall if GETATTR causes conflict
>>    * @rqstp: RPC transaction context
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index c7bfd2180e3f..f0fe526fac3c 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -4418,6 +4418,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>   	unsigned long maxcount;
>>   	struct file *file;
>>   	__be32 *p;
>> +	fmode_t o_fmode = 0;
>>   
>>   	if (nfserr)
>>   		return nfserr;
>> @@ -4437,10 +4438,18 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
>>   	maxcount = min_t(unsigned long, read->rd_length,
>>   			 (xdr->buf->buflen - xdr->buf->len));
>>   
>> +	if (read->rd_wd_stid) {
>> +		/* allow READ using write delegation stateid */
>> +		o_fmode = file->f_mode;
>> +		file->f_mode |= FMODE_READ;
>> +	}
> nfsd4_encode_read_plus() needs to handle write delegation stateids
> as well.

Yes, missed that one.

>
> I'm not too sure about modifying the f_mode on an nfsd_file you
> just got from a cache of shared nfsd_files.

If that is a problem, nfsd can open the file with rw access to begin with
if a write deleg was given?

>
> I think I'd prefer if preprocess_stateid returned an nfsd_file that
> was already open for read. IIUC that would mean that no changes
> would be needed here or in nfsd4_encode_read_plus().
>
> Would that be difficult?

preprocess_stateif to return a nfsd_file? not sure. But Nai correctly 
pointed out
that the file may have not been opened for read.

