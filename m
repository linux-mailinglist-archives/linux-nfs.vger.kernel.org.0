Return-Path: <linux-nfs+bounces-13413-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF32B1A95B
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 21:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B5B180603
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 19:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA05EEB2;
	Mon,  4 Aug 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbu1DQlZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CE310942
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754334488; cv=none; b=L5Ij9neYUH0at+f9nQtjEUOeDMmtpvOuV8jDkohqJ/wuw7Pum2usoRVlvNe2y+lmk1f5ILPMitFPYZa5zyblQgLZDRg6o8GCZbadqsPOOgJ8bjVzqRqWjiGmUYfn6MRuzqgo/J+/te6vZmPar4TzC8hBsgL8Y6x3HBzJP1rQS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754334488; c=relaxed/simple;
	bh=oIDH6K3Yy8bBH5a9RDuXLZkHBci22C2j+C/WXDW+PU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6vdtj5XeN/RFVjD4tpXoS7eH8WfzmDBAuMovDhY9v9Y5N2kws8SWGm9Jfjc9kmfFCfEojo4tVLRmfpae9Opj7mzXmfLeMS28KOH6dEj65HbNUhVQiJdVlnUuZXJ6/ejZitW2TysRw2Yxk3TrS2+NgXK6FdGm2LPqoESJWH6DCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbu1DQlZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754334485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ylmJStQPHdR5ic1TslzM4DRqi3FNv5K1UjbIepgdJ9Y=;
	b=fbu1DQlZkCKFCI4ieRv2njuGCKIrI850kFKq++0oFmxqP3Eb5khtXB51La90nxboJlP3To
	pO01/UtrjyktW7F9XeoPSnhM4nmXZkmzewhIhnaQoI8vNiqxMnyqWNs84B7X0KuRJ2yyE3
	2r/yYzu9P9G+oL8EGJIgxXu6ODIrqo0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-O8kf5n8qMJOMCk4l3pKLbw-1; Mon,
 04 Aug 2025 15:08:02 -0400
X-MC-Unique: O8kf5n8qMJOMCk4l3pKLbw-1
X-Mimecast-MFC-AGG-ID: O8kf5n8qMJOMCk4l3pKLbw_1754334481
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AC8B19560B6;
	Mon,  4 Aug 2025 19:08:01 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 038E61954B04;
	Mon,  4 Aug 2025 19:08:00 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Remove duplicate lookups, capability probes
 and fsinfo calls
Date: Mon, 04 Aug 2025 15:07:58 -0400
Message-ID: <32CC64BD-C2EE-4474-BF40-3532AEC06F1F@redhat.com>
In-Reply-To: <5036eb3f8190034811ee380d4df3ed6036de5148.camel@kernel.org>
References: <cover.1754270543.git.trond.myklebust@hammerspace.com>
 <c7c737e442abb6984cef194fd8d66acab2e0b83f.1754270543.git.trond.myklebust@hammerspace.com>
 <4FB030C4-24BD-40ED-8442-8A0BFC970269@redhat.com>
 <5036eb3f8190034811ee380d4df3ed6036de5148.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 4 Aug 2025, at 12:54, Trond Myklebust wrote:

> On Mon, 2025-08-04 at 12:43 -0400, Benjamin Coddington wrote:
>> On 3 Aug 2025, at 21:29, Trond Myklebust wrote:
>>
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> When crossing into a new filesystem, the NFSv4 client will look up
>>> the
>>> new directory, and then call nfs4_server_capabilities() as well as
>>> nfs4_do_fsinfo() at least twice.
>>>
>>> This patch removes the duplicate calls, and reduces the initial
>>> lookup
>>> to retrieve just a minimal set of attributes.
>>>
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>>  fs/nfs/nfs4_fs.h     |  5 ++-
>>>  fs/nfs/nfs4getroot.c | 14 +++----
>>>  fs/nfs/nfs4proc.c    | 87 ++++++++++++++++++++--------------------
>>> ----
>>>  3 files changed, 48 insertions(+), 58 deletions(-)
>>>
>>> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
>>> index d3ca91f60fc1..c34c89af9c7d 100644
>>> --- a/fs/nfs/nfs4_fs.h
>>> +++ b/fs/nfs/nfs4_fs.h
>>> @@ -63,7 +63,7 @@ struct nfs4_minor_version_ops {
>>>  	bool	(*match_stateid)(const nfs4_stateid *,
>>>  			const nfs4_stateid *);
>>>  	int	(*find_root_sec)(struct nfs_server *, struct
>>> nfs_fh *,
>>> -			struct nfs_fsinfo *);
>>> +				 struct nfs_fattr *);
>>>  	void	(*free_lock_state)(struct nfs_server *,
>>>  			struct nfs4_lock_state *);
>>>  	int	(*test_and_free_expired)(struct nfs_server *,
>>> @@ -296,7 +296,8 @@ extern int nfs4_call_sync(struct rpc_clnt *,
>>> struct nfs_server *,
>>>  extern void nfs4_init_sequence(struct nfs4_sequence_args *, struct
>>> nfs4_sequence_res *, int, int);
>>>  extern int nfs4_proc_setclientid(struct nfs_client *, u32,
>>> unsigned short, const struct cred *, struct nfs4_setclientid_res
>>> *);
>>>  extern int nfs4_proc_setclientid_confirm(struct nfs_client *,
>>> struct nfs4_setclientid_res *arg, const struct cred *);
>>> -extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh
>>> *, struct nfs_fsinfo *, bool);
>>> +extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh
>>> *,
>>> +				struct nfs_fattr *, bool);
>>>  extern int nfs4_proc_bind_conn_to_session(struct nfs_client *,
>>> const struct cred *cred);
>>>  extern int nfs4_proc_exchange_id(struct nfs_client *clp, const
>>> struct cred *cred);
>>>  extern int nfs4_destroy_clientid(struct nfs_client *clp);
>>> diff --git a/fs/nfs/nfs4getroot.c b/fs/nfs/nfs4getroot.c
>>> index 1a69479a3a59..e67ea345de69 100644
>>> --- a/fs/nfs/nfs4getroot.c
>>> +++ b/fs/nfs/nfs4getroot.c
>>> @@ -12,30 +12,28 @@
>>>
>>>  int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh
>>> *mntfh, bool auth_probe)
>>>  {
>>> -	struct nfs_fsinfo fsinfo;
>>> +	struct nfs_fattr *fattr = nfs_alloc_fattr();
>>>  	int ret = -ENOMEM;
>>>
>>> -	fsinfo.fattr = nfs_alloc_fattr();
>>> -	if (fsinfo.fattr == NULL)
>>> +	if (fattr == NULL)
>>>  		goto out;
>>>
>>>  	/* Start by getting the root filehandle from the server */
>>> -	ret = nfs4_proc_get_rootfh(server, mntfh, &fsinfo,
>>> auth_probe);
>>> +	ret = nfs4_proc_get_rootfh(server, mntfh, fattr,
>>> auth_probe);
>>>  	if (ret < 0) {
>>>  		dprintk("nfs4_get_rootfh: getroot error = %d\n", -
>>> ret);
>>>  		goto out;
>>>  	}
>>>
>>> -	if (!(fsinfo.fattr->valid & NFS_ATTR_FATTR_TYPE)
>>> -			|| !S_ISDIR(fsinfo.fattr->mode)) {
>>> +	if (!(fattr->valid & NFS_ATTR_FATTR_TYPE) ||
>>> !S_ISDIR(fattr->mode)) {
>>>  		printk(KERN_ERR "nfs4_get_rootfh:"
>>>  		       " getroot encountered non-directory\n");
>>>  		ret = -ENOTDIR;
>>>  		goto out;
>>>  	}

.. now I think we won't have fattr->mode here, more below:

>>>
>>> -	memcpy(&server->fsid, &fsinfo.fattr->fsid, sizeof(server-
>>>> fsid));
>>> +	memcpy(&server->fsid, &fattr->fsid, sizeof(server->fsid));
>>>  out:
>>> -	nfs_free_fattr(fsinfo.fattr);
>>> +	nfs_free_fattr(fattr);
>>>  	return ret;
>>>  }
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index c7c7ec22f21d..7d2b67e06cc3 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -4240,15 +4240,18 @@ static int nfs4_discover_trunking(struct
>>> nfs_server *server,
>>>  }
>>>
>>>  static int _nfs4_lookup_root(struct nfs_server *server, struct
>>> nfs_fh *fhandle,
>>> -		struct nfs_fsinfo *info)
>>> +			     struct nfs_fattr *fattr)
>>>  {
>>> -	u32 bitmask[3];
>>> +	u32 bitmask[3] = {
>>> +		[0] = FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
>>> +		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FSID,
>>
>> Just a thought when noticing this change --
>>
>> Don't we want at least FATTR4_WORD0_FILEID and
>> FATTR4_WORD1_MOUNTED_ON_FILEID as well here?
>
>
> Only FATTR4_WORD0_TYPE and FATTR4_WORD0_FSID are used by the caller, so
> we don't actually need FATTR4_WORD0_CHANGE or FATTR4_WORD0_SIZE either.
> I put them in so that the test for the auth flavour would have more
> chances of catching a problem.

Ah, I see now...  we're going to call ->fsinfo() again (as you stated in the
description).

But I don't see how _CHANGE or _SIZE are used..  and as I was hunting around
there's that check in nfs4_get_rootfh() (above) for S_ISDIR(fattr->mode), but this
dropped the fsinfo call out of nfs4_proc_get_rootfh(), so I think
fattr->mode will never be set.

> Note that neither FATTR4_WORD0_FILEID or FATTR4_WORD1_MOUNTED_ON_FILEID
> are mandatory attributes, so I also chose to avoid them + all the
> timestamps for that reason.

Gotcha, making sense.  This is tricky for me to review, maybe I should just
test it..  :)

Ben


