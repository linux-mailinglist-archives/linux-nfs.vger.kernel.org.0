Return-Path: <linux-nfs+bounces-13426-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB23BB1B50D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 15:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB5818A4A4B
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A924274670;
	Tue,  5 Aug 2025 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xc1LM0vD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C21272E71
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754400964; cv=none; b=TIhyBbOBZStUzqjGoFzS9m90EoSyV322lFZgxhLlCjxT+gFEJ/IIbdF7mU1EV5EjviWHKCr+sAxfvbUMrcqYoDRfvSsz3NbrGv8ETHj2+b4Qx0duuE4P8Jv25iDKXCNAwgRqnoXCepJg9iuxmGuee9aBDBgG/adUMhsXEy2nNaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754400964; c=relaxed/simple;
	bh=IwjAr4RxlNynjFI+NkKiRBYOjmlgVwr+vvVa639dugc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o44/VbM9ykDIm+FF/FNP+eH1uK5b8qjNfFIhwhY0IaAMQCk+ngjsvyoYvpjhT06pv0Q3oIS8BAT8bqqD1G3TNC6/HEYmzlHgxbRS6OtGtQIdBWuhQTsU4aXR/k0eAoNXMwMHB2ckNnEiyBAyaA51nqrI0oN85eEj5ILBsaUaHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xc1LM0vD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754400961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EKjpFpcNM8YaCkwqRRnLI5sOrpdTqqpFDA1HEJ0J3js=;
	b=Xc1LM0vDCPja/wBRnsuFWov/+RhT7H55NMu8vuoQDTzQc7OdPoFg6N/6VAya6iyA+oj1sf
	O/keM6e4uOp/yHv1N9tDM3guL+guxyH2Jau0vyKv3jZCANHHXaGKllgbTkCAKbp0IVU5a7
	lS6/zlX8aj9JS3g9HaGSZqiYnYlNUDY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321--e7WnXl9N7y9LBtKhUpnYw-1; Tue,
 05 Aug 2025 09:36:00 -0400
X-MC-Unique: -e7WnXl9N7y9LBtKhUpnYw-1
X-Mimecast-MFC-AGG-ID: -e7WnXl9N7y9LBtKhUpnYw_1754400959
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79364180034A;
	Tue,  5 Aug 2025 13:35:59 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7BB03000199;
	Tue,  5 Aug 2025 13:35:58 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Remove duplicate lookups, capability probes
 and fsinfo calls
Date: Tue, 05 Aug 2025 09:35:56 -0400
Message-ID: <83834E19-9F81-4A31-B71B-F816C173D13D@redhat.com>
In-Reply-To: <32CC64BD-C2EE-4474-BF40-3532AEC06F1F@redhat.com>
References: <cover.1754270543.git.trond.myklebust@hammerspace.com>
 <c7c737e442abb6984cef194fd8d66acab2e0b83f.1754270543.git.trond.myklebust@hammerspace.com>
 <4FB030C4-24BD-40ED-8442-8A0BFC970269@redhat.com>
 <5036eb3f8190034811ee380d4df3ed6036de5148.camel@kernel.org>
 <32CC64BD-C2EE-4474-BF40-3532AEC06F1F@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 4 Aug 2025, at 15:07, Benjamin Coddington wrote:

> On 4 Aug 2025, at 12:54, Trond Myklebust wrote:
>
>> On Mon, 2025-08-04 at 12:43 -0400, Benjamin Coddington wrote:
>>> On 3 Aug 2025, at 21:29, Trond Myklebust wrote:
>>>
>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>
>>>> When crossing into a new filesystem, the NFSv4 client will look up
>>>> the
>>>> new directory, and then call nfs4_server_capabilities() as well as
>>>> nfs4_do_fsinfo() at least twice.
>>>>
>>>> This patch removes the duplicate calls, and reduces the initial
>>>> lookup
>>>> to retrieve just a minimal set of attributes.
>>>>
>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>> ---
>>>>  fs/nfs/nfs4_fs.h     |  5 ++-
>>>>  fs/nfs/nfs4getroot.c | 14 +++----
>>>>  fs/nfs/nfs4proc.c    | 87 ++++++++++++++++++++--------------------
>>>> ----
>>>>  3 files changed, 48 insertions(+), 58 deletions(-)
>>>>
>>>> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
>>>> index d3ca91f60fc1..c34c89af9c7d 100644
>>>> --- a/fs/nfs/nfs4_fs.h
>>>> +++ b/fs/nfs/nfs4_fs.h
>>>> @@ -63,7 +63,7 @@ struct nfs4_minor_version_ops {
>>>>  	bool	(*match_stateid)(const nfs4_stateid *,
>>>>  			const nfs4_stateid *);
>>>>  	int	(*find_root_sec)(struct nfs_server *, struct
>>>> nfs_fh *,
>>>> -			struct nfs_fsinfo *);
>>>> +				 struct nfs_fattr *);
>>>>  	void	(*free_lock_state)(struct nfs_server *,
>>>>  			struct nfs4_lock_state *);
>>>>  	int	(*test_and_free_expired)(struct nfs_server *,
>>>> @@ -296,7 +296,8 @@ extern int nfs4_call_sync(struct rpc_clnt *,
>>>> struct nfs_server *,
>>>>  extern void nfs4_init_sequence(struct nfs4_sequence_args *, struct
>>>> nfs4_sequence_res *, int, int);
>>>>  extern int nfs4_proc_setclientid(struct nfs_client *, u32,
>>>> unsigned short, const struct cred *, struct nfs4_setclientid_res
>>>> *);
>>>>  extern int nfs4_proc_setclientid_confirm(struct nfs_client *,
>>>> struct nfs4_setclientid_res *arg, const struct cred *);
>>>> -extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh
>>>> *, struct nfs_fsinfo *, bool);
>>>> +extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh
>>>> *,
>>>> +				struct nfs_fattr *, bool);
>>>>  extern int nfs4_proc_bind_conn_to_session(struct nfs_client *,
>>>> const struct cred *cred);
>>>>  extern int nfs4_proc_exchange_id(struct nfs_client *clp, const
>>>> struct cred *cred);
>>>>  extern int nfs4_destroy_clientid(struct nfs_client *clp);
>>>> diff --git a/fs/nfs/nfs4getroot.c b/fs/nfs/nfs4getroot.c
>>>> index 1a69479a3a59..e67ea345de69 100644
>>>> --- a/fs/nfs/nfs4getroot.c
>>>> +++ b/fs/nfs/nfs4getroot.c
>>>> @@ -12,30 +12,28 @@
>>>>
>>>>  int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh
>>>> *mntfh, bool auth_probe)
>>>>  {
>>>> -	struct nfs_fsinfo fsinfo;
>>>> +	struct nfs_fattr *fattr = nfs_alloc_fattr();
>>>>  	int ret = -ENOMEM;
>>>>
>>>> -	fsinfo.fattr = nfs_alloc_fattr();
>>>> -	if (fsinfo.fattr == NULL)
>>>> +	if (fattr == NULL)
>>>>  		goto out;
>>>>
>>>>  	/* Start by getting the root filehandle from the server */
>>>> -	ret = nfs4_proc_get_rootfh(server, mntfh, &fsinfo,
>>>> auth_probe);
>>>> +	ret = nfs4_proc_get_rootfh(server, mntfh, fattr,
>>>> auth_probe);
>>>>  	if (ret < 0) {
>>>>  		dprintk("nfs4_get_rootfh: getroot error = %d\n", -
>>>> ret);
>>>>  		goto out;
>>>>  	}
>>>>
>>>> -	if (!(fsinfo.fattr->valid & NFS_ATTR_FATTR_TYPE)
>>>> -			|| !S_ISDIR(fsinfo.fattr->mode)) {
>>>> +	if (!(fattr->valid & NFS_ATTR_FATTR_TYPE) ||
>>>> !S_ISDIR(fattr->mode)) {
>>>>  		printk(KERN_ERR "nfs4_get_rootfh:"
>>>>  		       " getroot encountered non-directory\n");
>>>>  		ret = -ENOTDIR;
>>>>  		goto out;
>>>>  	}
>
> .. now I think we won't have fattr->mode here, more below:
>
>>>>
>>>> -	memcpy(&server->fsid, &fsinfo.fattr->fsid, sizeof(server-
>>>>> fsid));
>>>> +	memcpy(&server->fsid, &fattr->fsid, sizeof(server->fsid));
>>>>  out:
>>>> -	nfs_free_fattr(fsinfo.fattr);
>>>> +	nfs_free_fattr(fattr);
>>>>  	return ret;
>>>>  }
>>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>>> index c7c7ec22f21d..7d2b67e06cc3 100644
>>>> --- a/fs/nfs/nfs4proc.c
>>>> +++ b/fs/nfs/nfs4proc.c
>>>> @@ -4240,15 +4240,18 @@ static int nfs4_discover_trunking(struct
>>>> nfs_server *server,
>>>>  }
>>>>
>>>>  static int _nfs4_lookup_root(struct nfs_server *server, struct
>>>> nfs_fh *fhandle,
>>>> -		struct nfs_fsinfo *info)
>>>> +			     struct nfs_fattr *fattr)
>>>>  {
>>>> -	u32 bitmask[3];
>>>> +	u32 bitmask[3] = {
>>>> +		[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
>>>> +		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FSID,
>>>
>>> Just a thought when noticing this change --
>>>
>>> Don't we want at least FATTR4_WORD0_FILEID and
>>> FATTR4_WORD1_MOUNTED_ON_FILEID as well here?
>>
>>
>> Only FATTR4_WORD0_TYPE and FATTR4_WORD0_FSID are used by the caller, so
>> we don't actually need FATTR4_WORD0_CHANGE or FATTR4_WORD0_SIZE either.
>> I put them in so that the test for the auth flavour would have more
>> chances of catching a problem.
>
> Ah, I see now...  we're going to call ->fsinfo() again (as you stated in the
> description).
>
> But I don't see how _CHANGE or _SIZE are used..  and as I was hunting around
> there's that check in nfs4_get_rootfh() (above) for S_ISDIR(fattr->mode), but this
> dropped the fsinfo call out of nfs4_proc_get_rootfh(), so I think
> fattr->mode will never be set.

I ran this through some basic testing, and I see now that _TYPE gets into
fattr->mode when we decode, which of course makes sense.

So, FWIW - this makes sense and looks good to me now.

Ben


