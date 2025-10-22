Return-Path: <linux-nfs+bounces-15487-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE99BF9C21
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 04:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C33E4E24F1
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 02:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B41212551;
	Wed, 22 Oct 2025 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E3pzHGCc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011AA21B195;
	Wed, 22 Oct 2025 02:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101078; cv=none; b=QJT5HPnPh/QTQw8lGbctFP4Bf3QRpztg4kpvmXyMtvOxlWw0Mj7CkLC6xSRIqgurnTkddzkUiGW8L5HkH3KzAiAO0eT0lPt2W9ohywoZcl5kOZaeUOBgVkh1NS2cmu+ryqbgWPXB/x/+v4YzcF3QJs3S1+lVc08dcNDpQ88bzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101078; c=relaxed/simple;
	bh=S642hsLT3DbGO0se1uhbt4v7SgXn7F+bkZM8tu1lmZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nohDG+Tce9dyB0IohxpSd+fg5IvOV2FdPqzpDRWuGPJFsddbRtqrECbYCKIpkkqZ5nlbNHR7pPJX//EBbJAh7Wb7vPp7YvhQp1yAmZSvC3pn/Z7UepktRaFaL5CpSKVuiQRGVtOede2i8oe3xQnFfpcNDSlSD9afL4/5CwOjYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E3pzHGCc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=R13CEIBB/JFrdtyQB2TvK4h6vcDqAX9MqppCDQkD4lQ=;
	b=E3pzHGCcvts76onkle35CcVfcVtLxDAnjN0c+wdOXlvxPC3z98zBOw3ad3A8Xb
	AJw0deF6rGN3JBOjYI7IiVlskhy67C8Bu2mDgFkX7VcgnjlY5Y6bUG3+TgaUYojm
	YZPhqbDwZy0C7YLNq+d9rG0oXKUlxx6/oLuXn/8IW7MbQ=
Received: from [192.168.23.121] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnY84BRfho3XrtAw--.13497S2;
	Wed, 22 Oct 2025 10:44:18 +0800 (CST)
Message-ID: <b928fe1b-77ba-4189-8f75-56106e9fac19@163.com>
Date: Wed, 22 Oct 2025 10:44:17 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFS: Fix possible NULL pointer dereference in
 nfs_inode_remove_request()
To: Trond Myklebust <trondmy@kernel.org>, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Baolin Liu <liubaolin@kylinos.cn>
References: <20251012083957.532330-1-liubaolin12138@163.com>
 <5f1eb044728420769c5482ea95240717c0748f46.camel@kernel.org>
 <9243fe19-8e38-43e4-8ea4-077fa4512395@163.com>
 <a0accbb0e4ea7ad101dcaecf6ded576fc0c43a56.camel@kernel.org>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <a0accbb0e4ea7ad101dcaecf6ded576fc0c43a56.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBnY84BRfho3XrtAw--.13497S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAF1Uur47CFW7JFykZFW5KFg_yoW5tr45pr
	W7Kan0kF4kXr15Grn2q3W2vr1Yq34jkw4rZFn7Gw1avFnI9FnagF4UKF18uFn8Cr4xJF48
	Xr1UAay3uayYya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRhSd9UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwQKpdGj4RQL8agAA3f

> Sorry, I didn’t actually see any case where req->wb_head == NULL. 
> I found this through a smatch warning that pointed out a potential null pointer dereference. 
> Instead of removing the NULL folio check, I prefer to keep it to prevent this potential issue. Checking pointer validity before use is a good practice. 
> From a maintenance perspective, we can’t rule out the possibility that future changes might introduce a req->wb_head == NULL case, so I suggest keeping the NULL folio check.



在 2025/10/17 23:02, Trond Myklebust 写道:
> On Fri, 2025-10-17 at 14:57 +0800, liubaolin wrote:
>> [You don't often get email from liubaolin12138@163.com. Learn why
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>>> This modification addresses a potential issue detected by Smatch
>>> during a scan of the NFS code. After reviewing the relevant code, I
>>> confirmed that the change is required to remove the potential risk.
>>
>>
> 
> I'm sorry, but I'm still not seeing why we can't just remove the check
> for a NULL folio.
> 
> Under what circumstances do you see us calling
> nfs_inode_remove_request() with a request that has req->wb_head ==
> NULL? I'm asking for a concrete example.
> 
>>
>> 在 2025/10/13 12:47, Trond Myklebust 写道:
>>> On Sun, 2025-10-12 at 16:39 +0800, Baolin Liu wrote:
>>>> [You don't often get email from liubaolin12138@163.com. Learn why
>>>> this is important at
>>>> https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> From: Baolin Liu <liubaolin@kylinos.cn>
>>>>
>>>> nfs_page_to_folio(req->wb_head) may return NULL in certain
>>>> conditions,
>>>> but the function dereferences folio->mapping and calls
>>>> folio_end_dropbehind(folio) unconditionally. This may cause a
>>>> NULL
>>>> pointer dereference crash.
>>>>
>>>> Fix this by checking folio before using it or calling
>>>> folio_end_dropbehind().
>>>>
>>>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>>>> ---
>>>>    fs/nfs/write.c | 11 ++++++-----
>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
>>>> index 0fb6905736d5..e148308c1923 100644
>>>> --- a/fs/nfs/write.c
>>>> +++ b/fs/nfs/write.c
>>>> @@ -739,17 +739,18 @@ static void nfs_inode_remove_request(struct
>>>> nfs_page *req)
>>>>           nfs_page_group_lock(req);
>>>>           if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
>>>>                   struct folio *folio = nfs_page_to_folio(req-
>>>>> wb_head);
>>>> -               struct address_space *mapping = folio->mapping;
>>>>
>>>> -               spin_lock(&mapping->i_private_lock);
>>>>                   if (likely(folio)) {
>>>> +                       struct address_space *mapping = folio-
>>>>> mapping;
>>>> +
>>>> +                       spin_lock(&mapping->i_private_lock);
>>>>                           folio->private = NULL;
>>>>                           folio_clear_private(folio);
>>>>                           clear_bit(PG_MAPPED, &req->wb_head-
>>>>> wb_flags);
>>>> -               }
>>>> -               spin_unlock(&mapping->i_private_lock);
>>>> +                       spin_unlock(&mapping->i_private_lock);
>>>>
>>>> -               folio_end_dropbehind(folio);
>>>> +                       folio_end_dropbehind(folio);
>>>> +               }
>>>>           }
>>>>           nfs_page_group_unlock(req);
>>>>
>>>> --
>>>> 2.39.2
>>>>
>>>
>>> What reason is there to believe that we can ever call
>>> nfs_inode_remove_request() with a NULL value for req->wb_head-
>>>> wb_folio, or even with a NULL value for req->wb_head->wb_folio-
>>>> mapping?
>>>
>>>
>>
> 


