Return-Path: <linux-nfs+bounces-11933-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E372EAC5E0A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 02:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9021BA41AA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 00:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273A83208;
	Wed, 28 May 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCc+dDi4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72197A55
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748390998; cv=none; b=fI2swLnj0vbW3riQ/CPm2QHX/JxIk6Euu41n6P1lC198TsdQGGyb2OWuNjZgl7ahcoY0gp0dJlzeM19186BD4dzh+WRGVziFq/kUKfAo510MgVocmgPRm4WEKhkes6kDuMfe34mxGbGYMM2j/ghbITjp+gLHBE8+gez//68jiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748390998; c=relaxed/simple;
	bh=uLJk348NJ9vceepg4iZEi8KFK1HkMRsGiVyj0bPiahU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5Wm3PDmiKGqOq2+Em/1b7q+69KZ9062+YgUHKOjaj3Dg8r0hnwxymglpeiEsMDn0DNEbRENTDRFuIFziepAGg+7m3k6dwQEoSBwvDgqfn+xTw/XNM5vCLteNi/KO5meKlzD3WDHgM1s2QXJmr+U446Tzb4l0ps4mi2Gh6iEQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCc+dDi4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748390995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F9yteADgmJximuFiM7VcSD8sK5YalC4NzuilSYZIcbE=;
	b=LCc+dDi43iPH/qhknaM9rnOsM2Ceq4sZUdQlGibVsqngjHwkoueU00GlT3Lm7pbEj3uObJ
	Ko5dxaYjyLwqHFYjeQuqu8V4qhR0kqAM6JzbwRKfgqGo2qtOhzZ4DIW9xa6XD598xjh2AJ
	oF8k2Eeoz9tllIpwxy1YwHAXH51V14M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-2NNNvr9oN8KrtcQ10xbmHg-1; Tue,
 27 May 2025 20:09:50 -0400
X-MC-Unique: 2NNNvr9oN8KrtcQ10xbmHg-1
X-Mimecast-MFC-AGG-ID: 2NNNvr9oN8KrtcQ10xbmHg_1748390989
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27E2D19560BC;
	Wed, 28 May 2025 00:09:49 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A14741956095;
	Wed, 28 May 2025 00:09:47 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
 Lance Shelton <lance.shelton@hammerspace.com>
Subject: Re: [PATCH v1 1/3] Expand the type of nfs_fattr->valid
Date: Tue, 27 May 2025 20:09:45 -0400
Message-ID: <CA489054-92BE-4886-90B7-F2EF67209354@redhat.com>
In-Reply-To: <2bbd09ca-5423-4cb3-8497-f3a45915f321@oracle.com>
References: <cover.1747318805.git.bcodding@redhat.com>
 <725abd9afbe268c50b99a1b2ded6c2339a5e79c0.1747318805.git.bcodding@redhat.com>
 <480b2ed5ded21d186f4b4e64a8aebc226d4c3468.camel@kernel.org>
 <98FC701F-40B8-4C5F-8B45-0ECE3F145C44@redhat.com>
 <2bbd09ca-5423-4cb3-8497-f3a45915f321@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 27 May 2025, at 17:26, Anna Schumaker wrote:

> Hi Ben,
>
> On 5/16/25 11:31 AM, Benjamin Coddington wrote:
>> On 16 May 2025, at 11:05, Jeff Layton wrote:
>>
>>> On Thu, 2025-05-15 at 10:40 -0400, Benjamin Coddington wrote:
>>>> From: Trond Myklebust <trond.myklebust@primarydata.com>
>>>>
>>>> We need to be able to track more than 32 attributes per inode.
>>>>
>>>> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
>>>> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
>>>> ---
>>>>  fs/nfs/inode.c            |  5 ++--
>>>>  include/linux/nfs_fs_sb.h |  2 +-
>>>>  include/linux/nfs_xdr.h   | 54 +++++++++++++++++++-----------------=
---
>>>>  3 files changed, 31 insertions(+), 30 deletions(-)
>>>>
>>>> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
>>>> index 1aa67fca69b2..d4e449fa076e 100644
>>>> --- a/fs/nfs/inode.c
>>>> +++ b/fs/nfs/inode.c
>>>> @@ -2164,10 +2164,11 @@ static int nfs_update_inode(struct inode *in=
ode, struct nfs_fattr *fattr)
>>>>  	bool attr_changed =3D false;
>>>>  	bool have_delegation;
>>>>
>>>> -	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=3D0x%08x ct=3D%d info=3D0x%x)=
\n",
>>>> +	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=3D0x%08x ct=3D%d info=3D0x%lx=
)\n",
>>>>  			__func__, inode->i_sb->s_id, inode->i_ino,
>>>>  			nfs_display_fhandle_hash(NFS_FH(inode)),
>>>> -			atomic_read(&inode->i_count), fattr->valid);
>>>> +			atomic_read(&inode->i_count),
>>>> +			(unsigned long)fattr->valid);
>>>
>>> Why the cast? You could just set the format to %llx and pass fattr-
>>>> valid as-is?
>>
>> Yes of course, the cast will be removed.
>
> I'm not seeing any objections to adding btime. I was wondering if you'r=
e planning
> a v2 of these patches, or should I fix up the casting in my tree?

I'll send a v2, hoping for more review - thanks Anna!

Ben


