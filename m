Return-Path: <linux-nfs+bounces-11254-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B94A99915
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 22:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B79644705B
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29726983E;
	Wed, 23 Apr 2025 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIOYTFzh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC2C267F52
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745438402; cv=none; b=Im+DsFjKB53b2/T1yM7fN6r+SD59J0Zh9tS89UOsEvzP63ye+1FmGfBpmpW0SgaqfDryhR1QRJ1zlK+DA5o8Gl8Y5W4qx8ipcFlbM5mw5j/U7tagrcM9oL8jZTKuxbx1nfloch5pAZFm+TU+/B3mtTy3/c+tCqOPcT5u1wDzQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745438402; c=relaxed/simple;
	bh=SyqlHIBU+XNWHLa2fVlA/+UEL8OtfkutQHFkn8WdZds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dai2keVfbVJuULuSzpnScm/+KpgbnbPDVVgsgk3ZW130YlDfUSU3sxvItELxHs45DdWxms0zeF1PQRncwXGHDTbESKW6OjZ68+kGk2AbvPl01e3hQMB3OD2sVStdI8TotIY21FyYR4rHF0tD9LRkZMBeje+99ktlmvZ1PfSPEH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIOYTFzh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745438400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sTnmBvAFu/fKJSlgWUkcniFzGVWJPpuZ8ieIYxKIx2k=;
	b=gIOYTFzhvVjHbikUycyM67y7sRqu4wNKwD+GPGtqTvsWNZ/M478ET8M0NnPu71eGsyJGNn
	/aIMF7dtdycsZ4UzFNZJDFcEET03v0dwV45BEpkYddN3vGVsEdFYc1YVGzT/Zff+VBNhKT
	D6aqNScTc+OWOSMw7S8IwqD7V/TNgr8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-wtpecDdXMpqGLLdOFHFc-Q-1; Wed,
 23 Apr 2025 15:59:58 -0400
X-MC-Unique: wtpecDdXMpqGLLdOFHFc-Q-1
X-Mimecast-MFC-AGG-ID: wtpecDdXMpqGLLdOFHFc-Q_1745438397
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAE37180036D;
	Wed, 23 Apr 2025 19:59:56 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F16DB18001EF;
	Wed, 23 Apr 2025 19:59:55 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow FREE_STATEID to clean up delegations
Date: Wed, 23 Apr 2025 15:59:51 -0400
Message-ID: <FF36159B-E39E-4391-9955-394249FF27F6@redhat.com>
In-Reply-To: <f768ca3c27d1b0e6934a7ec319fa2ea9d0778b07.camel@kernel.org>
References: <cover.1745430006.git.bcodding@redhat.com>
 <e8c113d33be1bf52016b6b747330eec5c17dc948.1745430006.git.bcodding@redhat.com>
 <f768ca3c27d1b0e6934a7ec319fa2ea9d0778b07.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 23 Apr 2025, at 15:41, Jeff Layton wrote:

> On Wed, 2025-04-23 at 13:59 -0400, Benjamin Coddington wrote:
>> @@ -10612,6 +10610,7 @@ static int nfs41_free_stateid(struct nfs_server *server,
>>  	if (IS_ERR(task))
>>  		return PTR_ERR(task);
>>  	rpc_put_task(task);
>> +	stateid->type = NFS4_FREED_STATEID_TYPE;
>
> Would it be possible to call nfs_delegation_mark_returned() at this
> point, and skip all of the type changing?

It won't because we can be here with a lock stateid or open
stateid.

Ben


