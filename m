Return-Path: <linux-nfs+bounces-11969-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF1CAC7BBF
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 12:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5164C16B113
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 10:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0252227EA0;
	Thu, 29 May 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNs8IwfX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B99E21A445
	for <linux-nfs@vger.kernel.org>; Thu, 29 May 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514537; cv=none; b=S2lLAJbDI2cHa8BPxjfTl6VX/bfrGjvanmNzU8d12ZYM5UjJ/6UZsKxsxAnu7JYKNX2bFV4OLIjZbCYRCaaIXfJ6+dN+I5aPnD1bVtKCO6bexUQEk9CHLIxeXJQ6tSiTgq/Sfv6NVJ9T7NaxNJIwdsdtWlviyQ/LIq14Oevxjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514537; c=relaxed/simple;
	bh=jitP/Zz8abpPm2oIwUl1f7tIPTF2jZTuysc2osg1r0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZvCqAkbo0770FLo1iPxWUQEoDGm8hL3VGD9hGtkFiGpsmDR/zygjnVy/4C6DNElDlaY1Pxh0ZJIrIqFIaeVYkqk2ZZO9/BfENJJrmtwXDni/i0NpDEaoqL9fBLk1taf6feR+/6M7ctb8yhIgoI8K+FVkvbx002Tnv+RNVkIAhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNs8IwfX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748514534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9DTO2kVK5nIUw4mALs9e/oZmT6L4ecHWx8YIdusa//U=;
	b=YNs8IwfXQvKpFqsAc8UQXx8pcOdnPZF4tJe9fv+e8AIzCDeH83dv9noflSEzpjHlriqefH
	DbFo96+wgWg3vwsAO6wnJOa2V1Z5giHEdk/IEInjJm67lgRnMyLQe/ya/WU33U58y6v2CR
	/oOwgddQfTa9uX5Fj+SBPODFZ3TgZEA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-_MugXRzhMmWz0AD35_ddPA-1; Thu,
 29 May 2025 06:28:51 -0400
X-MC-Unique: _MugXRzhMmWz0AD35_ddPA-1
X-Mimecast-MFC-AGG-ID: _MugXRzhMmWz0AD35_ddPA_1748514530
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C285718003FC;
	Thu, 29 May 2025 10:28:49 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC31C1955D82;
	Thu, 29 May 2025 10:28:47 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 Lance Shelton <lance.shelton@hammerspace.com>
Subject: Re: [PATCH v2 2/3] nfs: Add timecreate to nfs inode
Date: Thu, 29 May 2025 06:28:45 -0400
Message-ID: <519E99B6-8B08-4DE2-9341-820F6F0E2F69@redhat.com>
In-Reply-To: <291a926b2dd3aba5532c940a5dd18f38ab4c58e3.camel@kernel.org>
References: <cover.1748436487.git.bcodding@redhat.com>
 <ee8d37a7b6495e95aa2875241e2962d41e57dc14.1748436487.git.bcodding@redhat.com>
 <a639fc978c9bdc54943301fad6618f8f068203ce.camel@kernel.org>
 <F0C8CB76-5A7E-45C2-A09B-C608F59A93DC@redhat.com>
 <d60ba979c9e2f762f1a4c48ede81e9a83682584b.camel@kernel.org>
 <291a926b2dd3aba5532c940a5dd18f38ab4c58e3.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 28 May 2025, at 16:16, Trond Myklebust wrote:

> On Wed, 2025-05-28 at 11:27 -0400, Jeff Layton wrote:
>> On Wed, 2025-05-28 at 11:13 -0400, Benjamin Coddington wrote:
>>> On 28 May 2025, at 8:56, Jeff Layton wrote:
>>>
>>>> On Wed, 2025-05-28 at 08:50 -0400, Benjamin Coddington wrote:
>>>>> From: Anne Marie Merritt <annemarie.merritt@primarydata.com>
>>>>>
>>>>> Add tracking of the create time (a.k.a. btime) along with
>>>>> corresponding
>>>>> bitfields, request, and decode xdr routines.
>>>>>
>>>>> Signed-off-by: Anne Marie Merritt
>>>>> <annemarie.merritt@primarydata.com>
>>>>> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
>>>>> Signed-off-by: Trond Myklebust
>>>>> <trond.myklebust@hammerspace.com>
>>>>> ---
>>>>> =C2=A0fs/nfs/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 28 ++++++++++++++++++++++------
>>>>> =C2=A0fs/nfs/nfs4proc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++=
+++++++++++-
>>>>> =C2=A0fs/nfs/nfs4xdr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
24 ++++++++++++++++++++++++
>>>>> =C2=A0fs/nfs/nfstrace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 3 ++-
>>>>> =C2=A0include/linux/nfs_fs.h=C2=A0 |=C2=A0 7 +++++++
>>>>> =C2=A0include/linux/nfs_xdr.h |=C2=A0 3 +++
>>>>> =C2=A06 files changed, 71 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>>>>> index 160f3478a835..fd84c24963b3 100644
>>>>> --- a/fs/nfs/inode.c
>>>>> +++ b/fs/nfs/inode.c
>>>>> @@ -197,6 +197,7 @@ void nfs_set_cache_invalid(struct inode
>>>>> *inode, unsigned long flags)
>>>>> =C2=A0		if (!(flags & NFS_INO_REVAL_FORCED))
>>>>> =C2=A0			flags &=3D ~(NFS_INO_INVALID_MODE |
>>>>> =C2=A0				=C2=A0=C2=A0 NFS_INO_INVALID_OTHER |
>>>>> +				=C2=A0=C2=A0 NFS_INO_INVALID_BTIME |
>>>>> =C2=A0				=C2=A0=C2=A0 NFS_INO_INVALID_XATTR);
>>>>> =C2=A0		flags &=3D ~(NFS_INO_INVALID_CHANGE |
>>>>> NFS_INO_INVALID_SIZE);
>>>>> =C2=A0	}
>>>>> @@ -522,6 +523,7 @@ nfs_fhget(struct super_block *sb, struct
>>>>> nfs_fh *fh, struct nfs_fattr *fattr)
>>>>> =C2=A0		inode_set_atime(inode, 0, 0);
>>>>> =C2=A0		inode_set_mtime(inode, 0, 0);
>>>>> =C2=A0		inode_set_ctime(inode, 0, 0);
>>>>> +		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>>>>> =C2=A0		inode_set_iversion_raw(inode, 0);
>>>>> =C2=A0		inode->i_size =3D 0;
>>>>> =C2=A0		clear_nlink(inode);
>>>>> @@ -545,6 +547,10 @@ nfs_fhget(struct super_block *sb, struct
>>>>> nfs_fh *fh, struct nfs_fattr *fattr)
>>>>> =C2=A0			inode_set_ctime_to_ts(inode, fattr-
>>>>>> ctime);
>>>>> =C2=A0		else if (fattr_supported &
>>>>> NFS_ATTR_FATTR_CTIME)
>>>>> =C2=A0			nfs_set_cache_invalid(inode,
>>>>> NFS_INO_INVALID_CTIME);
>>>>> +		if (fattr->valid & NFS_ATTR_FATTR_BTIME)
>>>>> +			nfsi->btime =3D fattr->btime;
>>>>> +		else if (fattr_supported &
>>>>> NFS_ATTR_FATTR_BTIME)
>>>>> +			nfs_set_cache_invalid(inode,
>>>>> NFS_INO_INVALID_BTIME);
>>>>> =C2=A0		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
>>>>> =C2=A0			inode_set_iversion_raw(inode, fattr-
>>>>>> change_attr);
>>>>> =C2=A0		else
>>>>> @@ -1900,7 +1906,7 @@ static int
>>>>> nfs_inode_finish_partial_attr_update(const struct nfs_fattr
>>>>> *fattr,
>>>>> =C2=A0		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME
>>>>> |
>>>>> =C2=A0		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
>>>>> =C2=A0		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER
>>>>> |
>>>>> -		NFS_INO_INVALID_NLINK;
>>>>> +		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
>>>>> =C2=A0	unsigned long cache_validity =3D NFS_I(inode)-
>>>>>> cache_validity;
>>>>> =C2=A0	enum nfs4_change_attr_type ctype =3D NFS_SERVER(inode)-
>>>>>> change_attr_type;
>>>>>
>>>>> @@ -2219,10 +2225,13 @@ static int nfs_update_inode(struct
>>>>> inode *inode, struct nfs_fattr *fattr)
>>>>> =C2=A0	nfs_fattr_fixup_delegated(inode, fattr);
>>>>>
>>>>> =C2=A0	save_cache_validity =3D nfsi->cache_validity;
>>>>> -	nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
>>>>> -			| NFS_INO_INVALID_ATIME
>>>>> -			| NFS_INO_REVAL_FORCED
>>>>> -			| NFS_INO_INVALID_BLOCKS);
>>>>> +	nfsi->cache_validity &=3D
>>>>> +		~(NFS_INO_INVALID_ATIME | NFS_INO_REVAL_FORCED
>>>>> |
>>>>> +		=C2=A0 NFS_INO_INVALID_CHANGE |
>>>>> NFS_INO_INVALID_CTIME |
>>>>> +		=C2=A0 NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE
>>>>> |
>>>>> +		=C2=A0 NFS_INO_INVALID_OTHER |
>>>>> NFS_INO_INVALID_BLOCKS |
>>>>> +		=C2=A0 NFS_INO_INVALID_NLINK | NFS_INO_INVALID_MODE
>>>>> |
>>>>> +		=C2=A0 NFS_INO_INVALID_BTIME);
>>>>>
>>>>
>>>> The delta above is a little curious. This patch is just adding
>>>> NFS_INO_INVALID_BTIME, but the patch above adds the clearing of
>>>> several
>>>> other bits as well. Why does this logic change?
>>>
>>> Good point, I wonder if it was based on other attribute work at the
>>> time,
>>> the original was here:
>>> https://lore.kernel.org/linux-nfs/20211227190504.309612-3-trondmy@ker=
nel.org/
>>>
>>> So I think what we're doing here is clearing what we know we don't
>>> have to
>>> check/update - I think we can drop this entire hunk, its a minor
>>> optimization, but hopefully we can get some expert opinion.=C2=A0=C2=A0=

>>> Trond, do you
>>> want me to test with this hunk removed?
>>
>> Looking little closer, I think what happened there is that
>> NFS_INO_INVALID_ATTR got unrolled into individual attr flags. So
>> there
>> may be no net change here (other than adding BTIME).
>>
>> Still, it'd be best to do that in a separate patch, IMO, esp. since
>> this is in nfs_update_inode(), which is already so "fiddly".
>
> NFS_INO_INVALID_ATTR is a dinosaur that I'd like to see extinct. We
> have fine grained attribute tracking these days, and so keeping the old=

> coarse grained one around is just confusing.
>
> That said, I'm fine with this being a separate patch.

Ok - I'll resend this on v3 adding BTIME to NFS_INO_INVALID_ATTR.

Ben


