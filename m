Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1B2A475F
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 15:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgKCOKa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 09:10:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729505AbgKCOJU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 09:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604412559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tc6fk/nl8GTjKGZXgMbhSd6hhw+TWj3pyHi0GFYb3yE=;
        b=N1mPIjrsxUESymMgs665/kAfwFDDDKeqaY7U1Q+yNZzXNt06O1kVPLgxC/jFbRgxYGd2lG
        oFI951VLyTbjtuYQFdjV5p+mmSEY+Kd458b1q26reOshfQUNUgf91l4srnzDSjtia0T0LQ
        1j5MmbmlFV3HWZg2DS9uT0p9BVbo05A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-A32ISuGxPLyXYyCNtkSGhA-1; Tue, 03 Nov 2020 09:09:17 -0500
X-MC-Unique: A32ISuGxPLyXYyCNtkSGhA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44F5C64161;
        Tue,  3 Nov 2020 14:09:16 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E144A1002D5D;
        Tue,  3 Nov 2020 14:09:15 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 02/12] NFS: Clean up readdir struct nfs_cache_array
Date:   Tue, 03 Nov 2020 09:09:14 -0500
Message-ID: <ACB62869-286C-4189-9BF9-C4F622C02C73@redhat.com>
In-Reply-To: <015FB69A-1E45-4A93-89F3-2755F2A565F0@redhat.com>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
 <015FB69A-1E45-4A93-89F3-2755F2A565F0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 3 Nov 2020, at 8:35, Benjamin Coddington wrote:

> On 2 Nov 2020, at 13:06, trondmy@kernel.org wrote:
>
>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>
>> Since the 'eof_index' is only ever used as a flag, make it so.
>> Also add a flag to detect if the page has been completely filled.
>>
>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>> ---
>>  fs/nfs/dir.c | 66 
>> ++++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 49 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>> index 67d8595cd6e5..604ebe015387 100644
>> --- a/fs/nfs/dir.c
>> +++ b/fs/nfs/dir.c
>> @@ -138,9 +138,10 @@ struct nfs_cache_array_entry {
>>  };
>>
>>  struct nfs_cache_array {
>> -	int size;
>> -	int eof_index;
>>  	u64 last_cookie;
>> +	unsigned int size;
>> +	unsigned char page_full : 1,
>> +		      page_is_eof : 1;
>>  	struct nfs_cache_array_entry array[];
>>  };
>>
>> @@ -172,7 +173,6 @@ void nfs_readdir_init_array(struct page *page)
>>
>>  	array = kmap_atomic(page);
>>  	memset(array, 0, sizeof(struct nfs_cache_array));
>> -	array->eof_index = -1;
>>  	kunmap_atomic(array);
>>  }
>>
>> @@ -192,6 +192,17 @@ void nfs_readdir_clear_array(struct page *page)
>>  	kunmap_atomic(array);
>>  }
>>
>> +static void nfs_readdir_array_set_eof(struct nfs_cache_array *array)
>> +{
>> +	array->page_is_eof = 1;
>> +	array->page_full = 1;
>> +}
>> +
>> +static bool nfs_readdir_array_is_full(struct nfs_cache_array *array)
>> +{
>> +	return array->page_full;
>> +}
>> +
>>  /*
>>   * the caller is responsible for freeing qstr.name
>>   * when called by nfs_readdir_add_to_array, the strings will be 
>> freed in
>> @@ -213,6 +224,23 @@ int nfs_readdir_make_qstr(struct qstr *string, 
>> const char *name, unsigned int le
>>  	return 0;
>>  }
>>
>> +/*
>> + * Check that the next array entry lies entirely within the page 
>> bounds
>> + */
>> +static int nfs_readdir_array_can_expand(struct nfs_cache_array 
>> *array)
>> +{
>> +	struct nfs_cache_array_entry *cache_entry;
>> +
>> +	if (array->page_full)
>> +		return -ENOSPC;
>> +	cache_entry = &array->array[array->size + 1];
>> +	if ((char *)cache_entry - (char *)array > PAGE_SIZE) {
>> +		array->page_full = 1;
>> +		return -ENOSPC;
>> +	}
>> +	return 0;
>> +}
>> +
>
> I think we could do this calculation at compile-time instead of doing 
> it for
> each entry, for dubious nominal gains..

and doing so might allow us to detect the case where the array is full
before doing another RPC that we'll discard.

Ben

