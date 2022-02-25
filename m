Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DFD4C43BE
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 12:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbiBYLjK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 06:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239111AbiBYLjJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 06:39:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 49B0B79392
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 03:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645789115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ex192q0a20m+CSrn70Fja6U/wYc1GnpXn5v+z4ZYJc=;
        b=UTH0zy7C73HxCkz84kdkhD0oJah+DVGikgbFf2D/oeoRk93WZR2sfHPDcFQkLibuAlsvoB
        RqrEppw/B/l65TSq0ret4NjKc9ojbe3/AjCqg0ebpPxnrHc6g3YtuQN30zea70DIZlqBAg
        KlWoCdaHSMFbAxgq6Dfpfg1xnY9LkJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-RRnQkcIiPXyEvdmOITFf1Q-1; Fri, 25 Feb 2022 06:38:32 -0500
X-MC-Unique: RRnQkcIiPXyEvdmOITFf1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E672804B82;
        Fri, 25 Feb 2022 11:38:31 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29DF07ADAE;
        Fri, 25 Feb 2022 11:38:31 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 05/21] NFS: Store the change attribute in the directory
 page cache
Date:   Fri, 25 Feb 2022 06:38:30 -0500
Message-ID: <640B2705-35C6-4E9E-89D2-CC3D0E10EC3A@redhat.com>
In-Reply-To: <9506801a7b7b6330ce2807721da5e03d77cf5c78.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <0DBE97BF-3A88-49FD-B078-012B5EDA5849@redhat.com>
 <1ca16f7e7be9588d15525e3afa4f7a80eb66b12b.camel@hammerspace.com>
 <9506801a7b7b6330ce2807721da5e03d77cf5c78.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 24 Feb 2022, at 22:51, Trond Myklebust wrote:

> On Fri, 2022-02-25 at 02:26 +0000, Trond Myklebust wrote:
>> On Thu, 2022-02-24 at 09:53 -0500, Benjamin Coddington wrote:
>>> On 23 Feb 2022, at 16:12, trondmy@kernel.org=C2=A0wrote:
>>>
>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>
>>>> Use the change attribute and the first cookie in a directory page
>>>> cache
>>>> entry to validate that the page is up to date.
>>>>
>>>> Suggested-by: Benjamin Coddington <bcodding@redhat.com>
>>>> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>> ---
>>>> =C2=A0fs/nfs/dir.c | 68
>>>> ++++++++++++++++++++++++++++------------------------
>>>> =C2=A01 file changed, 37 insertions(+), 31 deletions(-)
>>>>
>>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>>> index f2258e926df2..5d9367d9b651 100644
>>>> --- a/fs/nfs/dir.c
>>>> +++ b/fs/nfs/dir.c
>>>> @@ -139,6 +139,7 @@ struct nfs_cache_array_entry {
>>>> =C2=A0};
>>>>
>>>> =C2=A0struct nfs_cache_array {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 change_attr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 last_cookie;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int size;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned char page_f=
ull : 1,
>>>> @@ -175,7 +176,8 @@ static void nfs_readdir_array_init(struct
>>>> nfs_cache_array *array)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(array, 0, siz=
eof(struct nfs_cache_array));
>>>> =C2=A0}
>>>>
>>>> -static void nfs_readdir_page_init_array(struct page *page, u64
>>>> last_cookie)
>>>> +static void nfs_readdir_page_init_array(struct page *page, u64
>>>> last_cookie,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0u64 =

>>>> change_attr)
>>>> =C2=A0{
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nfs_cache_arr=
ay *array;
>>>
>>>
>>> There's a hunk missing here, something like:
>>>
>>> @@ -185,6 +185,7 @@ static void nfs_readdir_page_init_array(struct
>>> page
>>> *page, u64 last_cookie,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_readdir_array_in=
it(array);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 array->last_cookie =3D=
 last_cookie;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 array->cookies_are_o=
rdered =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 array->change_attr =3D change_a=
ttr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kunmap_atomic(array)=
;
>>> =C2=A0 }
>>>
>>>>
>>>> @@ -207,7 +209,7 @@ nfs_readdir_page_array_alloc(u64 last_cookie,
>>>> gfp_t gfp_flags)
>>>> =C2=A0{
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct page *page =3D=
 alloc_page(gfp_flags);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (page)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0nfs_readdir_page_init_array(page, =

>>>> last_cookie);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0nfs_readdir_page_init_array(page, =

>>>> last_cookie,
>>>> 0);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return page;
>>>> =C2=A0}
>>>>
>>>> @@ -304,19 +306,44 @@ int nfs_readdir_add_to_array(struct
>>>> nfs_entry
>>>> *entry, struct page *page)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
>>>> =C2=A0}
>>>>
>>>> +static bool nfs_readdir_page_cookie_match(struct page *page, u64
>>>> last_cookie,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =

>>>> u64 change_attr)
>>>
>>> How about "nfs_readdir_page_valid()"?=C2=A0 There's more going on tha=
n a
>>> cookie match.
>>>
>>>
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nfs_cache_array *a=
rray =3D kmap_atomic(page);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D true;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (array->change_attr !=3D=
 change_attr)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D false;
>>>
>>> Can we skip the next test if ret =3D false?
>>
>> I'd expect the compiler to do that.
>>
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (array->size > 0 && ar=
ray->array[0].cookie !=3D
>>>> last_cookie)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ret =3D false;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunmap_atomic(array);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
>>>> +}
>>>> +
>>>> +static void nfs_readdir_page_unlock_and_put(struct page *page)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unlock_page(page);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0put_page(page);
>>>> +}
>>>> +
>>>> =C2=A0static struct page *nfs_readdir_page_get_locked(struct
>>>> address_space
>>>> *mapping,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pgof=
f_t =

>>>> index,
>>>> u64
>>>> last_cookie)
>>>> =C2=A0{
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct page *page;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 change_attr;
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0page =3D grab_cache_=
page(mapping, index);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (page && !PageUptodate=
(page)) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0nfs_readdir_page_init_array(page, =

>>>> last_cookie);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if =

>>>> (invalidate_inode_pages2_range(mapping, index
>>>> +
>>>> 1, -1) < 0)
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_=
zap_mapping(mapping->host, =

>>>> mapping);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0SetPageUptodate(page);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!page)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return NULL;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0change_attr =3D =

>>>> inode_peek_iversion_raw(mapping->host);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (PageUptodate(page)) {=

>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if =

>>>> (nfs_readdir_page_cookie_match(page,
>>>> last_cookie,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =

>>>> change_attr))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0retu=
rn page;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0nfs_readdir_clear_array(page);
>>>
>>>
>>> Why use i_version rather than nfs_save_change_attribute?=C2=A0 Seems
>>> having a
>>> consistent value across the pachecache and dir_verifiers would help
>>> debugging, and we've already have a bunch of machinery around the
>>> change_attribute.
>>
>> The directory cache_change_attribute is not reported in tracepoints
>> because it is a directory-specific field, so it's not as useful for
>> debugging.
>>
>> The inode change attribute is what we have traditionally used for
>> determining cache consistency, and when to invalidate the cache.
>
> I should probably elaborate a little further on the differences =

> between
> the inode change attribute and the cache_change_attribute.
>
> One of the main reasons for introducing the latter was to have
> something that allows us to track changes to the directory, but to
> avoid forcing unnecessary revalidations of the dcache.
>
> What this means is that when we create or remove a file, and the
> pre/post-op attributes tell us that there were no third party changes
> to the directory, we update the dcache, but we do _not_ update the
> cache_change_attribute, because we know that the rest of the directory
> contents are valid, and so we don't have to revalidate the dentries.
> However in that case, we _do_ want to update the readdir cache to
> reflect the fact that an entry was added or deleted. While we could
> figure out how to remove an entry (at least for the case where the
> filesystem is case-sensitive), we do not know where the filesystem
> added the new file, or what cookies was assigned.
>
> This is why the inode change attribute is more appropriate for =

> indexing
> the page cache pages. It reflects the cases where we want to =

> revalidate
> the readdir cache, as opposed to the dcache.

Ok, thanks for explaining this.

I've noticed that you haven't responded about my concerns about not =

checking
the directory for changes with every v4 READDIR.  For v3, we have =

post-op
updates to the directory, but with v4 the directory can change and we'll
end up with entries in the cache that are marked with an old =

change_attr.

I'm pretty positive that not checking for changes to the directory (not
sending GETATTR with READDIR) is going to create cases of double-listed =

and
truncated-listings for dirctory listers.  Not handling those cases means =

I'm
going to have some very unhappy customers that complain about their =

files
disappearing/reappearing on NFS.

If you need me to prove that its an issue, I can take the time to write =

up
program that shows this problem.

Ben

