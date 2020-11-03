Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D412A4851
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 15:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgKCOgC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 09:36:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56664 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728103AbgKCOf2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 09:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604414127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uA6cpus8THcXPyiW5j/bqN+nBclL1EO2zasxd8f2t1U=;
        b=fryeMp9KTrF8bQ1rWjQnTFHymChR3EFUpfFkQuQBZEInN1FF4sLrd3cwr5KBcGk45zKOaM
        VXbxqRtcIjP0LgI9biddZljMsvwbpESX27KqHsWj7+sZeafSFe4aWtOefkKKkbfmAEPgnm
        B6nKttoW0M3w12Y+5AhgwA+lpGPlFfI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-4vp5017kNEy54zGTjnpNUw-1; Tue, 03 Nov 2020 09:35:22 -0500
X-MC-Unique: 4vp5017kNEy54zGTjnpNUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 017D210219FB;
        Tue,  3 Nov 2020 14:34:08 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B349821E8C;
        Tue,  3 Nov 2020 14:34:07 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 02/12] NFS: Clean up readdir struct nfs_cache_array
Date:   Tue, 03 Nov 2020 09:34:06 -0500
Message-ID: <37BCFCA0-58EE-499F-8A45-435C6C3925CA@redhat.com>
In-Reply-To: <ACB62869-286C-4189-9BF9-C4F622C02C73@redhat.com>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
 <015FB69A-1E45-4A93-89F3-2755F2A565F0@redhat.com>
 <ACB62869-286C-4189-9BF9-C4F622C02C73@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3 Nov 2020, at 9:09, Benjamin Coddington wrote:

> On 3 Nov 2020, at 8:35, Benjamin Coddington wrote:
>
>> On 2 Nov 2020, at 13:06, trondmy@kernel.org wrote:
>>
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> Since the 'eof_index' is only ever used as a flag, make it so.
>>> Also add a flag to detect if the page has been completely filled.
>>>
>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>> ---
>>>  fs/nfs/dir.c | 66 
>>> ++++++++++++++++++++++++++++++++++++++--------------
>>>  1 file changed, 49 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>> index 67d8595cd6e5..604ebe015387 100644
>>> --- a/fs/nfs/dir.c
>>> +++ b/fs/nfs/dir.c
>>> @@ -138,9 +138,10 @@ struct nfs_cache_array_entry {
>>>  };
>>>
>>>  struct nfs_cache_array {
>>> -	int size;
>>> -	int eof_index;
>>>  	u64 last_cookie;
>>> +	unsigned int size;
>>> +	unsigned char page_full : 1,
>>> +		      page_is_eof : 1;
>>>  	struct nfs_cache_array_entry array[];
>>>  };
>>>
>>> @@ -172,7 +173,6 @@ void nfs_readdir_init_array(struct page *page)
>>>
>>>  	array = kmap_atomic(page);
>>>  	memset(array, 0, sizeof(struct nfs_cache_array));
>>> -	array->eof_index = -1;
>>>  	kunmap_atomic(array);
>>>  }
>>>
>>> @@ -192,6 +192,17 @@ void nfs_readdir_clear_array(struct page *page)
>>>  	kunmap_atomic(array);
>>>  }
>>>
>>> +static void nfs_readdir_array_set_eof(struct nfs_cache_array 
>>> *array)
>>> +{
>>> +	array->page_is_eof = 1;
>>> +	array->page_full = 1;
>>> +}
>>> +
>>> +static bool nfs_readdir_array_is_full(struct nfs_cache_array 
>>> *array)
>>> +{
>>> +	return array->page_full;
>>> +}
>>> +
>>>  /*
>>>   * the caller is responsible for freeing qstr.name
>>>   * when called by nfs_readdir_add_to_array, the strings will be 
>>> freed in
>>> @@ -213,6 +224,23 @@ int nfs_readdir_make_qstr(struct qstr *string, 
>>> const char *name, unsigned int le
>>>  	return 0;
>>>  }
>>>
>>> +/*
>>> + * Check that the next array entry lies entirely within the page 
>>> bounds
>>> + */
>>> +static int nfs_readdir_array_can_expand(struct nfs_cache_array 
>>> *array)
>>> +{
>>> +	struct nfs_cache_array_entry *cache_entry;
>>> +
>>> +	if (array->page_full)
>>> +		return -ENOSPC;
>>> +	cache_entry = &array->array[array->size + 1];
>>> +	if ((char *)cache_entry - (char *)array > PAGE_SIZE) {
>>> +		array->page_full = 1;
>>> +		return -ENOSPC;
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>>
>> I think we could do this calculation at compile-time instead of doing 
>> it for
>> each entry, for dubious nominal gains..
>
> and doing so might allow us to detect the case where the array is full
> before doing another RPC that we'll discard.

And you handle this case in patch 4/12...

Ben

