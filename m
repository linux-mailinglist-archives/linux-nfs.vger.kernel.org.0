Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6614C491D
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 16:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242100AbiBYPfU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 10:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbiBYPfT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 10:35:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52D0F19414E
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 07:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645803285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qEc+VL8pppuqv2ro2md5HRTQdNL5qRKgeebtFEG1B4=;
        b=e3LhHULxqKGAZDk9snpB8oCPQVEtkS7ouopZdZgimC2HGBY3ro4uIOKyH463sZDV4XEJC9
        s0kNxAcFEiWrwhwMpWFHazZR07gOVz6lFfH4a16EHCkYJN6EGqxuF5/4CB7kVIDCIURkij
        vyO04bAgllzpfHFOtcw8DgGpeopKY/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-89aLG_AyMeqa3KeBbXy6Wg-1; Fri, 25 Feb 2022 10:34:44 -0500
X-MC-Unique: 89aLG_AyMeqa3KeBbXy6Wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CE7B835DE0;
        Fri, 25 Feb 2022 15:34:43 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C5FCA7C027;
        Fri, 25 Feb 2022 15:34:42 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v7 05/21] NFS: Store the change attribute in the directory
 page cache
Date:   Fri, 25 Feb 2022 10:34:41 -0500
Message-ID: <6878D746-0A5E-4815-A520-5CE7CD98A1E2@redhat.com>
In-Reply-To: <f9ca09baa9e41000ab6286a27de567ca306f6991.camel@hammerspace.com>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <0DBE97BF-3A88-49FD-B078-012B5EDA5849@redhat.com>
 <1ca16f7e7be9588d15525e3afa4f7a80eb66b12b.camel@hammerspace.com>
 <9506801a7b7b6330ce2807721da5e03d77cf5c78.camel@hammerspace.com>
 <640B2705-35C6-4E9E-89D2-CC3D0E10EC3A@redhat.com>
 <eb2a551096bb3537a9de7091d203e0cbff8dc6be.camel@hammerspace.com>
 <11744FC6-5EFB-427A-ADB4-D211BA1C74F4@redhat.com>
 <f9ca09baa9e41000ab6286a27de567ca306f6991.camel@hammerspace.com>
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

On 25 Feb 2022, at 10:18, Trond Myklebust wrote:

> On Fri, 2022-02-25 at 09:44 -0500, Benjamin Coddington wrote:
>> On 25 Feb 2022, at 8:10, Trond Myklebust wrote:
>>
>>> On Fri, 2022-02-25 at 06:38 -0500, Benjamin Coddington wrote:
>>>> On 24 Feb 2022, at 22:51, Trond Myklebust wrote:
>>>>
>>>>> On Fri, 2022-02-25 at 02:26 +0000, Trond Myklebust wrote:
>>>>>> On Thu, 2022-02-24 at 09:53 -0500, Benjamin Coddington wrote:
>>>>>>> On 23 Feb 2022, at 16:12, trondmy@kernel.org=C2=A0wrote:
>>>>>>>
>>>>>>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>>>>>>
>>>>>>>> Use the change attribute and the first cookie in a
>>>>>>>> directory
>>>>>>>> page
>>>>>>>> cache
>>>>>>>> entry to validate that the page is up to date.
>>>>>>>>
>>>>>>>> Suggested-by: Benjamin Coddington <bcodding@redhat.com>
>>>>>>>> Signed-off-by: Trond Myklebust
>>>>>>>> <trond.myklebust@hammerspace.com>
>>>>>>>> ---
>>>>>>>> =C2=A0fs/nfs/dir.c | 68
>>>>>>>> ++++++++++++++++++++++++++++------------------------
>>>>>>>> =C2=A01 file changed, 37 insertions(+), 31 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
>>>>>>>> index f2258e926df2..5d9367d9b651 100644
>>>>>>>> --- a/fs/nfs/dir.c
>>>>>>>> +++ b/fs/nfs/dir.c
>>>>>>>> @@ -139,6 +139,7 @@ struct nfs_cache_array_entry {
>>>>>>>> =C2=A0};
>>>>>>>>
>>>>>>>> =C2=A0struct nfs_cache_array {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 change_attr;
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 last_cookie;=

>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int siz=
e;
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned char pa=
ge_full : 1,
>>>>>>>> @@ -175,7 +176,8 @@ static void
>>>>>>>> nfs_readdir_array_init(struct
>>>>>>>> nfs_cache_array *array)
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(array, 0,=
 sizeof(struct =

>>>>>>>> nfs_cache_array));
>>>>>>>> =C2=A0}
>>>>>>>>
>>>>>>>> -static void nfs_readdir_page_init_array(struct page
>>>>>>>> *page,
>>>>>>>> u64
>>>>>>>> last_cookie)
>>>>>>>> +static void nfs_readdir_page_init_array(struct page
>>>>>>>> *page,
>>>>>>>> u64
>>>>>>>> last_cookie,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0u64
>>>>>>>> change_attr)
>>>>>>>> =C2=A0{
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nfs_cache=
_array *array;
>>>>>>>
>>>>>>>
>>>>>>> There's a hunk missing here, something like:
>>>>>>>
>>>>>>> @@ -185,6 +185,7 @@ static void
>>>>>>> nfs_readdir_page_init_array(struct
>>>>>>> page
>>>>>>> *page, u64 last_cookie,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nfs_readdir_arra=
y_init(array);
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 array->last_cook=
ie =3D last_cookie;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 array->cookies_a=
re_ordered =3D 1;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 array->change_attr =3D chan=
ge_attr;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kunmap_atomic(ar=
ray);
>>>>>>> =C2=A0 }
>>>>>>>
>>>>>>>>
>>>>>>>> @@ -207,7 +209,7 @@ nfs_readdir_page_array_alloc(u64
>>>>>>>> last_cookie,
>>>>>>>> gfp_t gfp_flags)
>>>>>>>> =C2=A0{
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct page *pag=
e =3D alloc_page(gfp_flags);
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (page)
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_readdir_page_init_array(page,
>>>>>>>> last_cookie);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_readdir_page_init_array(page,
>>>>>>>> last_cookie,
>>>>>>>> 0);
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return page;
>>>>>>>> =C2=A0}
>>>>>>>>
>>>>>>>> @@ -304,19 +306,44 @@ int nfs_readdir_add_to_array(struct
>>>>>>>> nfs_entry
>>>>>>>> *entry, struct page *page)
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
>>>>>>>> =C2=A0}
>>>>>>>>
>>>>>>>> +static bool nfs_readdir_page_cookie_match(struct page
>>>>>>>> *page,
>>>>>>>> u64
>>>>>>>> last_cookie,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>>>>>>> u64 change_attr)
>>>>>>>
>>>>>>> How about "nfs_readdir_page_valid()"?=C2=A0 There's more going
>>>>>>> on
>>>>>>> than a
>>>>>>> cookie match.
>>>>>>>
>>>>>>>
>>>>>>>> +{
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct nfs_cache_arra=
y *array =3D
>>>>>>>> kmap_atomic(page);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret =3D true;
>>>>>>>> +
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (array->change_att=
r !=3D change_attr)
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D false;
>>>>>>>
>>>>>>> Can we skip the next test if ret =3D false?
>>>>>>
>>>>>> I'd expect the compiler to do that.
>>>>>>
>>>>>>>
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (array->size > 0 &=
& array->array[0].cookie !=3D
>>>>>>>> last_cookie)
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D false;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunmap_atomic(array);=

>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static void nfs_readdir_page_unlock_and_put(struct page
>>>>>>>> *page)
>>>>>>>> +{
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unlock_page(page);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0put_page(page);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> =C2=A0static struct page *nfs_readdir_page_get_locked(struct
>>>>>>>> address_space
>>>>>>>> *mapping,
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p=
goff_t
>>>>>>>> index,
>>>>>>>> u64
>>>>>>>> last_cookie)
>>>>>>>> =C2=A0{
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct page *pag=
e;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 change_attr;
>>>>>>>>
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0page =3D grab_ca=
che_page(mapping, index);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (page && !PageUpto=
date(page)) {
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_readdir_page_init_array(page,
>>>>>>>> last_cookie);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if
>>>>>>>> (invalidate_inode_pages2_range(mapping, index
>>>>>>>> +
>>>>>>>> 1, -1) < 0)
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
nfs_zap_mapping(mapping->host,
>>>>>>>> mapping);
>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0SetPageUptodate(page);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!page)
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0change_attr =3D
>>>>>>>> inode_peek_iversion_raw(mapping->host);
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (PageUptodate(page=
)) {
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if
>>>>>>>> (nfs_readdir_page_cookie_match(page,
>>>>>>>> last_cookie,
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=

>>>>>>>> change_attr))
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
return page;
>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0nfs_readdir_clear_array(page);
>>>>>>>
>>>>>>>
>>>>>>> Why use i_version rather than nfs_save_change_attribute?=C2=A0
>>>>>>> Seems
>>>>>>> having a
>>>>>>> consistent value across the pachecache and dir_verifiers
>>>>>>> would
>>>>>>> help
>>>>>>> debugging, and we've already have a bunch of machinery
>>>>>>> around
>>>>>>> the
>>>>>>> change_attribute.
>>>>>>
>>>>>> The directory cache_change_attribute is not reported in
>>>>>> tracepoints
>>>>>> because it is a directory-specific field, so it's not as
>>>>>> useful
>>>>>> for
>>>>>> debugging.
>>>>>>
>>>>>> The inode change attribute is what we have traditionally used
>>>>>> for
>>>>>> determining cache consistency, and when to invalidate the
>>>>>> cache.
>>>>>
>>>>> I should probably elaborate a little further on the differences
>>>>> between
>>>>> the inode change attribute and the cache_change_attribute.
>>>>>
>>>>> One of the main reasons for introducing the latter was to have
>>>>> something that allows us to track changes to the directory, but
>>>>> to
>>>>> avoid forcing unnecessary revalidations of the dcache.
>>>>>
>>>>> What this means is that when we create or remove a file, and
>>>>> the
>>>>> pre/post-op attributes tell us that there were no third party
>>>>> changes
>>>>> to the directory, we update the dcache, but we do _not_ update
>>>>> the
>>>>> cache_change_attribute, because we know that the rest of the
>>>>> directory
>>>>> contents are valid, and so we don't have to revalidate the
>>>>> dentries.
>>>>> However in that case, we _do_ want to update the readdir cache
>>>>> to
>>>>> reflect the fact that an entry was added or deleted. While we
>>>>> could
>>>>> figure out how to remove an entry (at least for the case where
>>>>> the
>>>>> filesystem is case-sensitive), we do not know where the
>>>>> filesystem
>>>>> added the new file, or what cookies was assigned.
>>>>>
>>>>> This is why the inode change attribute is more appropriate for
>>>>> indexing
>>>>> the page cache pages. It reflects the cases where we want to
>>>>> revalidate
>>>>> the readdir cache, as opposed to the dcache.
>>>>
>>>> Ok, thanks for explaining this.
>>>>
>>>> I've noticed that you haven't responded about my concerns about
>>>> not
>>>> checking
>>>> the directory for changes with every v4 READDIR.=C2=A0 For v3, we ha=
ve
>>>> post-op
>>>> updates to the directory, but with v4 the directory can change
>>>> and
>>>> we'll
>>>> end up with entries in the cache that are marked with an old
>>>> change_attr.
>>>>
>>>
>>> Then they will be rejected by nfs_readdir_page_cookie_match() if a
>>> user
>>> looks up that page again after we've revalidated the change
>>> attribute
>>> on the directory.
>>>
>>> ...and note that NFSv4 does returns a struct change_info4 for all
>>> operations that change the directory, so we will update the change
>>> attribute in all those cases.
>>
>> I'm not worried about changes from the same client.
>>
>>> If the change is made on the server, well then we will detect it
>>> through the standard revalidation process that usually decides when
>>> to
>>> invalidate the directory page cache.
>>
>> The environments I'm concerned about are setup very frequently: they
>> look
>> like multiple NFS clients co-ordinating on a directory with millions
>> of
>> files.=C2=A0 Some clients are adding files as they do work, other clie=
nts
>> are
>> then looking for those files by walking the directory entries to
>> validate
>> their existence.=C2=A0 The systems that do this have a "very bad time"=
 if
>> some
>> of them produce listings that are _dramatically_ and transiently
>> different
>> from a listing they produced before.
>>
>> That can happen really easily with what we've got here, and it can
>> create a
>> huge problem for these setups.=C2=A0 And it won't be easily =

>> reproduceable,
>> and it
>> will be hard to find.=C2=A0 It will cost everyone involved a lot of ti=
me
>> and
>> effort to track down, and we can fix it easily.
>>
>>>> I'm pretty positive that not checking for changes to the
>>>> directory
>>>> (not
>>>> sending GETATTR with READDIR) is going to create cases of double-
>>>> listed
>>>> and
>>>> truncated-listings for dirctory listers.=C2=A0 Not handling those
>>>> cases
>>>> means
>>>> I'm
>>>> going to have some very unhappy customers that complain about
>>>> their
>>>> files
>>>> disappearing/reappearing on NFS.
>>>>
>>>> If you need me to prove that its an issue, I can take the time to
>>>> write
>>>> up
>>>> program that shows this problem.
>>>>
>>>
>>> If you label the page contents with an attribute that was retrieved
>>> _after_ the READDIR op, then you will introduce this as a problem
>>> for
>>> your customers.
>>
>> No the problem is already here, we're not introducing it.=C2=A0 By
>> labeling
>> the
>> page contents with every call we're shifting the race window from the
>> client
>> where it's a very large window to the server where the window is
>> small.
>>
>> Its still possible, but *much* less likely.
>>
>>> The reason is that there is no atomicity between operations in a
>>> COMPOUND. Worse, the implementation of readdir in scalable modern
>>> systems, including Linux, does not even guarantee atomicity of the
>>> readdir operation itself. Instead each readdir entry is filled
>>> without
>>> holding any locks or preventing any changes to the directory or to
>>> the
>>> object itself.
>>
>> I understand all this, but its not a reason to make the problem
>> worse.
>>
>>> POSIX states very explicitly that if you're making changes to the
>>> directory after the call to opendir() or rewinddir(), then the
>>> behaviour w.r.t. whether that file appears in the readdir() call is
>>> unspecified. See
>>> https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.ht=
ml
>>
>> Yes, but again - just because the problem exists doesn't give us
>> reason
>> to
>> amplify it when we can easily make a better choice for almost no
>> cost.
>>
>> Here are my reasons for wanting the GETATTR added:
>> =C2=A0 - it makes it *much* less likely for this problem to occur, wit=
h
>> the
>> minor
>> =C2=A0=C2=A0=C2=A0 downside of decreased caching for unstable director=
ies.
>> =C2=A0 - it makes v3 and v4 readdir pagecache behavior consistent WRT
>> changing
>> =C2=A0=C2=A0=C2=A0 directories.
>>
>> I spent a non-trivial amount of time working on this problem, and saw
>> this
>> exact issue appear.=C2=A0 Its definitely something that's going to com=
e
>> back
>> and
>> bite us if we don't fix it.
>>
>> How can I convince you?=C2=A0 I've offered to produce a working exampl=
e =

>> of
>> this
>> problem.=C2=A0 Will you review those results?=C2=A0 If I cannot convin=
ce you, =

>> I
>> feel
>> I'll have to pursue distro-specific changes for this work.
>
> Ben, the main cause of this kind of issue in the current code is the
> following line:
>
>         /*
>          * ctx->pos points to the dirent entry number.
>          * *desc->dir_cookie has the cookie for the next entry. We =

> have
>          * to either find the entry with the appropriate number or
>          * revalidate the cookie.
>          */
>         if (ctx->pos =3D=3D 0 || nfs_attribute_cache_expired(inode)) {
>                 res =3D nfs_revalidate_mapping(inode, file->f_mapping);=

>                 if (res < 0)
>                         goto out;
>         }
>
>
> That line protects the page cache against changes aften opendir(). It
> was introduced by Red Hat in commmit 07b5ce8ef2d8 in order to fix a
> claim of a severe performance problem.
>
> These patches _remove_ that protection, because we're now able to cope
> with more frequent revalidation without needing to restart directory
> reads from scratch.

Yes, I know.  But the big change is that now we're heavily relying on
page validation to produce sane listing results, and proper page =

validation
relies on up-to-date change info.

> So no. Without further proof, I don't accept your claim that this
> patchset introduces a regression. I don't accept your claim that we =

> are
> required to revalidate the change attribute on every readdir call. We
> can't do that for NFSv2 or NFSv3 (the latter offers a post_op
> attribute, not pre-op attribute) and as I already pointed out, there =

> is
> nothing in POSIX that requires this.

You don't need a pre-op attribute.  You just need to detect the case =

where
you're walking into pages that contain entries that don't match the ones
you're currently using, and post-op is as good as we can get it.

Ok, so I'm reading that further proof is required, and I'm happy to do =

the
work.  Thanks for the replies here and elsewhere.

Ben

