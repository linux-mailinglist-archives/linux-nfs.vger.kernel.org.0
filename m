Return-Path: <linux-nfs+bounces-11779-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2D6AB9FE4
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 17:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D933B160A
	for <lists+linux-nfs@lfdr.de>; Fri, 16 May 2025 15:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE02629C;
	Fri, 16 May 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e223vpEr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0125634
	for <linux-nfs@vger.kernel.org>; Fri, 16 May 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409507; cv=none; b=soFNELzB1YEydHekwTNW4zm8N5pjdgU5brhRpSUggYQ2vgPqmpUiOeQbJ2VLcu19zbroHTLx4QYKWdnwjY7l7aQFFhwc0T1OK0bEET1Bk1xJ5lJtxRXpy4fIe+8CjAo6EDx3gGbKByRlSMQ6A1l/zEIb4FrugqJqlGakg+34+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409507; c=relaxed/simple;
	bh=mEQAZpehK1QIv3jZi0l+8FnO+V5VygYrhhc41pJ9DKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PLS4FbjhCY0T9U5at8qD7O3s79AJsUBMugWneMu5mZLrIh4TnBQAXaRLLWsFL8gOj4xh1pBdFT12zMftIhdR4rkv/8Jl9ByqTGIY9fmeWFOHqODebVykKx/sPFS9aMcEzE+uICt7MvRxaBgHYP1p8G4REbFpJ1wxyg+Zi4y5ePM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e223vpEr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747409504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xpWkssrKJ+PQ6jn6bKlXzLSWFmitOBQf/Jo4ooaQlQ=;
	b=e223vpErpNjGBXQpyBgmtk4GgUSFrZSQKYzfKz6toOgfo+qDVpUVMp8Lg4PCz2VLhNLRNH
	5hw5RXsY68e8HuXqvIs4LP4cQonxxvTi9f7MxgDUliBSoWI+V480l37QIsf8U5zlHSK0zS
	q40OphgyvIV2gzgBaIhb1esUx0m9HI8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-wUHz7fm3PgemnFEX1f_unQ-1; Fri,
 16 May 2025 11:31:41 -0400
X-MC-Unique: wUHz7fm3PgemnFEX1f_unQ-1
X-Mimecast-MFC-AGG-ID: wUHz7fm3PgemnFEX1f_unQ_1747409500
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E5CF1800570;
	Fri, 16 May 2025 15:31:39 +0000 (UTC)
Received: from [10.22.88.189] (unknown [10.22.88.189])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83B1918003FC;
	Fri, 16 May 2025 15:31:38 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org, Lance Shelton <lance.shelton@hammerspace.com>
Subject: Re: [PATCH v1 1/3] Expand the type of nfs_fattr->valid
Date: Fri, 16 May 2025 11:31:36 -0400
Message-ID: <98FC701F-40B8-4C5F-8B45-0ECE3F145C44@redhat.com>
In-Reply-To: <480b2ed5ded21d186f4b4e64a8aebc226d4c3468.camel@kernel.org>
References: <cover.1747318805.git.bcodding@redhat.com>
 <725abd9afbe268c50b99a1b2ded6c2339a5e79c0.1747318805.git.bcodding@redhat.com>
 <480b2ed5ded21d186f4b4e64a8aebc226d4c3468.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 16 May 2025, at 11:05, Jeff Layton wrote:

> On Thu, 2025-05-15 at 10:40 -0400, Benjamin Coddington wrote:
>> From: Trond Myklebust <trond.myklebust@primarydata.com>
>>
>> We need to be able to track more than 32 attributes per inode.
>>
>> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
>> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>> ---
>>  fs/nfs/inode.c            |  5 ++--
>>  include/linux/nfs_fs_sb.h |  2 +-
>>  include/linux/nfs_xdr.h   | 54 +++++++++++++++++++-------------------=
-
>>  3 files changed, 31 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>> index 1aa67fca69b2..d4e449fa076e 100644
>> --- a/fs/nfs/inode.c
>> +++ b/fs/nfs/inode.c
>> @@ -2164,10 +2164,11 @@ static int nfs_update_inode(struct inode *inod=
e, struct nfs_fattr *fattr)
>>  	bool attr_changed =3D false;
>>  	bool have_delegation;
>>
>> -	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=3D0x%08x ct=3D%d info=3D0x%x)\n=
",
>> +	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=3D0x%08x ct=3D%d info=3D0x%lx)\=
n",
>>  			__func__, inode->i_sb->s_id, inode->i_ino,
>>  			nfs_display_fhandle_hash(NFS_FH(inode)),
>> -			atomic_read(&inode->i_count), fattr->valid);
>> +			atomic_read(&inode->i_count),
>> +			(unsigned long)fattr->valid);
>
> Why the cast? You could just set the format to %llx and pass fattr-
>> valid as-is?

Yes of course, the cast will be removed.

Ben


