Return-Path: <linux-nfs+bounces-11950-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF46AC6CAE
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A5F3A3568
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497DA28751C;
	Wed, 28 May 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8BBZYuD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4122339
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445246; cv=none; b=mMTxvInwDqTNkTuCEqUuOyGKwLn4rtgFgznZ19aFM8meGYyjG53Tf3oYGjtu1AYijFRzjPdCd23em6bD02wOHKLaacQRtmvmlrwbqquMpHMJWs0OtU/X0pXqc50Z9WD5cJcunfrJIKSsQKXC35U0bY6sLA1nYKY7aiYhFQfbpX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445246; c=relaxed/simple;
	bh=wfbUwjvmubuqmM8aws8S7TSn+XiwgrJtTxozw+4yWro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXE31AQUwtO7ofeE72ThHWo8kBF7hXaqBuqjtCijWH769L4BHYyPxk8a3QYlwY7JMHhcg5cDYpS49Ad5pT2XkJ5xmhA/GoRCVaqJ6B677h459Thmm9LpXpNSi6FMeVJG1AKitq+6aFMjeAzV0yTidROyk7kr18ri7M+oZkFJU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8BBZYuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748445243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8pmKtibbAzwe8PecjiQHFfRz8atJevy0gUZ4oH0rdU=;
	b=h8BBZYuDpIOpem+dhzQoZhLo+PFMvJm+QMQcR3QD1JwPNImP9RDKqTSdpWjgEV73IYHRCi
	KkHESrX6zq8KG1/NHwq6/egPaB8kKBqny//7SKnQKwTfwpcfosttld/YXftp46tmUotbcb
	Z2bn747RWc0nrBDI9/kFM78axSFnWas=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-9dAHDuNCNKCYCjdXkLTiww-1; Wed,
 28 May 2025 11:14:00 -0400
X-MC-Unique: 9dAHDuNCNKCYCjdXkLTiww-1
X-Mimecast-MFC-AGG-ID: 9dAHDuNCNKCYCjdXkLTiww_1748445239
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6A981800368;
	Wed, 28 May 2025 15:13:58 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8086E1955F1B;
	Wed, 28 May 2025 15:13:57 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 Lance Shelton <lance.shelton@hammerspace.com>
Subject: Re: [PATCH v2 2/3] nfs: Add timecreate to nfs inode
Date: Wed, 28 May 2025 11:13:55 -0400
Message-ID: <F0C8CB76-5A7E-45C2-A09B-C608F59A93DC@redhat.com>
In-Reply-To: <a639fc978c9bdc54943301fad6618f8f068203ce.camel@kernel.org>
References: <cover.1748436487.git.bcodding@redhat.com>
 <ee8d37a7b6495e95aa2875241e2962d41e57dc14.1748436487.git.bcodding@redhat.com>
 <a639fc978c9bdc54943301fad6618f8f068203ce.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 28 May 2025, at 8:56, Jeff Layton wrote:

> On Wed, 2025-05-28 at 08:50 -0400, Benjamin Coddington wrote:
>> From: Anne Marie Merritt <annemarie.merritt@primarydata.com>
>>
>> Add tracking of the create time (a.k.a. btime) along with correspondin=
g
>> bitfields, request, and decode xdr routines.
>>
>> Signed-off-by: Anne Marie Merritt <annemarie.merritt@primarydata.com>
>> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>>  fs/nfs/inode.c          | 28 ++++++++++++++++++++++------
>>  fs/nfs/nfs4proc.c       | 14 +++++++++++++-
>>  fs/nfs/nfs4xdr.c        | 24 ++++++++++++++++++++++++
>>  fs/nfs/nfstrace.h       |  3 ++-
>>  include/linux/nfs_fs.h  |  7 +++++++
>>  include/linux/nfs_xdr.h |  3 +++
>>  6 files changed, 71 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>> index 160f3478a835..fd84c24963b3 100644
>> --- a/fs/nfs/inode.c
>> +++ b/fs/nfs/inode.c
>> @@ -197,6 +197,7 @@ void nfs_set_cache_invalid(struct inode *inode, un=
signed long flags)
>>  		if (!(flags & NFS_INO_REVAL_FORCED))
>>  			flags &=3D ~(NFS_INO_INVALID_MODE |
>>  				   NFS_INO_INVALID_OTHER |
>> +				   NFS_INO_INVALID_BTIME |
>>  				   NFS_INO_INVALID_XATTR);
>>  		flags &=3D ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
>>  	}
>> @@ -522,6 +523,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *f=
h, struct nfs_fattr *fattr)
>>  		inode_set_atime(inode, 0, 0);
>>  		inode_set_mtime(inode, 0, 0);
>>  		inode_set_ctime(inode, 0, 0);
>> +		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
>>  		inode_set_iversion_raw(inode, 0);
>>  		inode->i_size =3D 0;
>>  		clear_nlink(inode);
>> @@ -545,6 +547,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *=
fh, struct nfs_fattr *fattr)
>>  			inode_set_ctime_to_ts(inode, fattr->ctime);
>>  		else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
>>  			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
>> +		if (fattr->valid & NFS_ATTR_FATTR_BTIME)
>> +			nfsi->btime =3D fattr->btime;
>> +		else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
>> +			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BTIME);
>>  		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
>>  			inode_set_iversion_raw(inode, fattr->change_attr);
>>  		else
>> @@ -1900,7 +1906,7 @@ static int nfs_inode_finish_partial_attr_update(=
const struct nfs_fattr *fattr,
>>  		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
>>  		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
>>  		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
>> -		NFS_INO_INVALID_NLINK;
>> +		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
>>  	unsigned long cache_validity =3D NFS_I(inode)->cache_validity;
>>  	enum nfs4_change_attr_type ctype =3D NFS_SERVER(inode)->change_attr_=
type;
>>
>> @@ -2219,10 +2225,13 @@ static int nfs_update_inode(struct inode *inod=
e, struct nfs_fattr *fattr)
>>  	nfs_fattr_fixup_delegated(inode, fattr);
>>
>>  	save_cache_validity =3D nfsi->cache_validity;
>> -	nfsi->cache_validity &=3D ~(NFS_INO_INVALID_ATTR
>> -			| NFS_INO_INVALID_ATIME
>> -			| NFS_INO_REVAL_FORCED
>> -			| NFS_INO_INVALID_BLOCKS);
>> +	nfsi->cache_validity &=3D
>> +		~(NFS_INO_INVALID_ATIME | NFS_INO_REVAL_FORCED |
>> +		  NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
>> +		  NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
>> +		  NFS_INO_INVALID_OTHER | NFS_INO_INVALID_BLOCKS |
>> +		  NFS_INO_INVALID_NLINK | NFS_INO_INVALID_MODE |
>> +		  NFS_INO_INVALID_BTIME);
>>
>
> The delta above is a little curious. This patch is just adding
> NFS_INO_INVALID_BTIME, but the patch above adds the clearing of several=

> other bits as well. Why does this logic change?

Good point, I wonder if it was based on other attribute work at the time,=

the original was here:
https://lore.kernel.org/linux-nfs/20211227190504.309612-3-trondmy@kernel.=
org/

So I think what we're doing here is clearing what we know we don't have t=
o
check/update - I think we can drop this entire hunk, its a minor
optimization, but hopefully we can get some expert opinion.   Trond, do y=
ou
want me to test with this hunk removed?

Ben


