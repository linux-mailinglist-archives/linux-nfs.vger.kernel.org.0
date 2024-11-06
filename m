Return-Path: <linux-nfs+bounces-7731-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17999BF81B
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 21:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5416B1F22026
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D920220C47F;
	Wed,  6 Nov 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCRK5yaD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCFB20C47E
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730925629; cv=none; b=hkpRNWbGIsXwsk9OhTdFBR+EtfdrLzDzxZGW2ILKWCBIUDjS30zQjZAnKpPOBCaV3cCcb9heEkJ/dnHaJjvW/frycrgUebT8HJqEVZ48Q23h2P56EFFg62l1KVa+ziO0dBiheVcXIoqosy9kXN5v9227SPpGGkEnLwm/7Yiqvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730925629; c=relaxed/simple;
	bh=F+KE7KBA/1TmMwyqOENSHLf8ZBLeXogNnKlVFcjwcvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDLfIW0UmU9+h7OCIR6TJ+k3IN5N7uRi/vqBxGq79lvgPrAOOU5hBi3QBiegekLe3EVhsdeNHZYUds5F7XbRk2qpj1NRVUx2njbaseCJ/J5yKgfSR9X7sjfjG8AVKJk2nEpGp8Q/ynintH4yInD4VFoDY6+uwXTirp7cKhXiKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCRK5yaD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730925626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KKn4W9T/w7nBsU5GxlYBQNWch8oQwyyIJZkLvlSdOHs=;
	b=XCRK5yaDHFAfUCPzUP419vluzbmumldtA4jO7Myd+JSDEIqWyJ8RfYCBOCuYPLEmnLGsyA
	IylgtakcBegclv/k8vGTWobuTYdY25+ACxdWFAgDdzW2w04vL4PtociidABww7JxsfAI9E
	z75aefklvtWLDuO5a6rrYGqvB5JY26A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-06rhO1L1PVCNfvvNbR5cZQ-1; Wed,
 06 Nov 2024 15:40:22 -0500
X-MC-Unique: 06rhO1L1PVCNfvvNbR5cZQ-1
X-Mimecast-MFC-AGG-ID: 06rhO1L1PVCNfvvNbR5cZQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A92A31956096;
	Wed,  6 Nov 2024 20:40:21 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.17])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0F4C1956088;
	Wed,  6 Nov 2024 20:40:20 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Roland Mainz <roland.mainz@nrubsig.org>
Cc: open list <linux-kernel@vger.kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs_sysfs_link_rpc_client(): Replace strcpy with strscpy
Date: Wed, 06 Nov 2024 15:40:18 -0500
Message-ID: <283409A8-6FD1-461C-8490-0E81B266EF9D@redhat.com>
In-Reply-To: <CAKAoaQnOfAU2LgLRwNNHion=-iHB1fSfPnfSFUQMmUyyEzu6LQ@mail.gmail.com>
References: <20241106024952.494718-1-danielyangkang@gmail.com>
 <CAKAoaQnOfAU2LgLRwNNHion=-iHB1fSfPnfSFUQMmUyyEzu6LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 6 Nov 2024, at 15:20, Roland Mainz wrote:

> On Wed, Nov 6, 2024 at 3:49 AM Daniel Yang <danielyangkang@gmail.com> wrote:
>>
>> The function strcpy is deprecated due to lack of bounds checking. The
>> recommended replacement is strscpy.
>>
>> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
>> ---
>>  fs/nfs/sysfs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
>> index bf378ecd5..f3d0b2ef9 100644
>> --- a/fs/nfs/sysfs.c
>> +++ b/fs/nfs/sysfs.c
>> @@ -280,7 +280,7 @@ void nfs_sysfs_link_rpc_client(struct nfs_server *server,
>>         char name[RPC_CLIENT_NAME_SIZE];
>>         int ret;
>>
>> -       strcpy(name, clnt->cl_program->name);
>> +       strscpy(name, clnt->cl_program->name);
>
> How should the "bounds checking" work in this case if you only pass
> two arguments ?

The linux kernel strscpy() checks the sizeof the destination.

Ben


