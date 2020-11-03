Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09312A4812
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 15:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgKCO06 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 09:26:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729421AbgKCOYt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 09:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604413488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2aSzw7FyaZX3oauxPdfrTWcbAjXC504WwToQbpb0xdg=;
        b=WPBrtrFEnbjZBQwlx6srgHC9NpbOItTABi5db/5wfyUnjVVTw2A2PSab+/ikd51Kfqbwzy
        utVEu0W5aPn/Fb5SvKrSIxNAMODOrhhwhBN+4qiFA1Ty298Mx+hqiwUt3Y+qNn0BTq0In9
        dGptdLW+KhZAuepJjv3kl4Rvl53r3/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-wUVxaA7mOaepXMNEEKs7gg-1; Tue, 03 Nov 2020 09:24:46 -0500
X-MC-Unique: wUVxaA7mOaepXMNEEKs7gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81A181009E23;
        Tue,  3 Nov 2020 14:24:45 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 464DB21E8C;
        Tue,  3 Nov 2020 14:24:45 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 03/12] NFS: Clean up nfs_readdir_page_filler()
Date:   Tue, 03 Nov 2020 09:24:44 -0500
Message-ID: <46951701-9996-4625-ABD1-E516549C728E@redhat.com>
In-Reply-To: <36E36AEF-E3D3-472B-A837-FF1312B7C169@redhat.com>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
 <20201102180658.6218-4-trondmy@kernel.org>
 <36E36AEF-E3D3-472B-A837-FF1312B7C169@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 3 Nov 2020, at 9:18, Benjamin Coddington wrote:

> On 2 Nov 2020, at 13:06, trondmy@kernel.org wrote:
>
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> Clean up handling of the case where there are no entries in the 
>> readdir
>> reply.
>>
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>>  fs/nfs/dir.c | 39 ++++++++++++++++++---------------------
>>  1 file changed, 18 insertions(+), 21 deletions(-)
>>
>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>> index 604ebe015387..68acbde3f914 100644
>> --- a/fs/nfs/dir.c
>> +++ b/fs/nfs/dir.c
>> @@ -601,16 +601,12 @@ int 
>> nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct 
>> nfs_entry *en
>>  	struct xdr_stream stream;
>>  	struct xdr_buf buf;
>>  	struct page *scratch;
>> -	unsigned int count = 0;
>>  	int status;
>>
>>  	scratch = alloc_page(GFP_KERNEL);
>>  	if (scratch == NULL)
>>  		return -ENOMEM;
>>
>> -	if (buflen == 0)
>> -		goto out_nopages;
>> -
>>  	xdr_init_decode_pages(&stream, &buf, xdr_pages, buflen);
>>  	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
>>
>> @@ -619,27 +615,27 @@ int 
>> nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct 
>> nfs_entry *en
>>  			entry->label->len = NFS4_MAXLABELLEN;
>>
>>  		status = xdr_decode(desc, entry, &stream);
>> -		if (status != 0) {
>> -			if (status == -EAGAIN)
>> -				status = 0;
>> +		if (status != 0)
>>  			break;
>> -		}
>> -
>> -		count++;
>>
>>  		if (desc->plus)
>>  			nfs_prime_dcache(file_dentry(desc->file), entry,
>>  					desc->dir_verifier);
>>
>>  		status = nfs_readdir_add_to_array(entry, page);
>> -		if (status != 0)
>> -			break;
>> -	} while (!entry->eof);
>> +	} while (!status && !entry->eof);
>>
>> -out_nopages:
>> -	if (count == 0 || (status == -EBADCOOKIE && entry->eof != 0)) {
>> -		nfs_readdir_page_set_eof(page);
>> +	switch (status) {
>> +	case -EBADCOOKIE:
>> +		if (entry->eof) {
>> +			nfs_readdir_page_set_eof(page);
>> +			status = 0;
>> +		}
>> +		break;
>> +	case -ENOSPC:
>
> If you return ENOSPC, then you don't need to use
> nfs_readdir_array_is_full(array) below..
>
>> +	case -EAGAIN:
>>  		status = 0;
>> +		break;
>>  	}
>>
>>  	put_page(scratch);
>> @@ -714,14 +710,15 @@ int 
>> nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page 
>> *page,
>>
>>  		if (status < 0)
>>  			break;
>> +
>>  		pglen = status;
>> -		status = nfs_readdir_page_filler(desc, &entry, pages, page, 
>> pglen);
>> -		if (status < 0) {
>> -			if (status == -ENOSPC)
>> -				status = 0;
>> +		if (pglen == 0) {
>> +			nfs_readdir_page_set_eof(page);
>>  			break;
>>  		}
>> -	} while (!nfs_readdir_array_is_full(array));
>> +
>> +		status = nfs_readdir_page_filler(desc, &entry, pages, page, 
>> pglen);
>> +	} while (!status && !nfs_readdir_array_is_full(array));
>
> ^^ here.
>
> I suppose nfs_readdir_array_is_full() is nice and clear.. I wonder if 
> the
> compiler would optimize it away.

  Ah, I see now -- the check handles the case of eof as well..

I suppose I shouldn't send a stream of consciousness to the list.  Sorry 
about that.

Ben

