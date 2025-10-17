Return-Path: <linux-nfs+bounces-15323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE57BE6D89
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 08:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B674C188D565
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 06:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C680217659;
	Fri, 17 Oct 2025 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y6vIdVVb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36283346A8;
	Fri, 17 Oct 2025 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684281; cv=none; b=hBgQZEOj1+4RbXuiXVIancVq6rKMY202fq9AyOyq9LnCeCvvImwrGENpTBuo9pUTWb+W1gRlcFMbdizrDpcoEpxEQ8uGLe5efVXzWWVKRScInl98NBl39aUOGzCYuQadUF76gtsjuc0Kw0NlwHaAjKOgFK6qCNVDVTVMGyJvBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684281; c=relaxed/simple;
	bh=5EOFhaT2qmqGRTZHFHtUrP/zV7D8Q4Pvqvo6kIQE8cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krjNODG3h2b5yOrTrxqymyxHBfCEbwA8z2BeGSqNjPJRv6fUs/IaFIxSytv19dS7MXPm7/CQDtHseT9BKGN4RV3Gq/yli/GbZfWldq1RXi4XVAOosB4DDnCtJzsx1lSmpfLdIQM0jjL9BecQZMhrhmFFmZRGMEIpgfHoQouxnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y6vIdVVb; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=FGd5RXB8QlREl9/LLTHXwa2ZhK7XYvfRQukFEnQk428=;
	b=Y6vIdVVbu6R9Lnb2DI4PNSl7egSSK83QrFcODb4m+DunLMFhSuXe+me/suqZOX
	SM17TTCSr2gT7OsizpOz/Cqccz2IqdC0l8LxpWq64qG/ykebBHhm74qV7jwJYYin
	X9CB4bQ4NhX9pt8TN50pWZ0o+5XwMMrUTtU8/mylrtsfw=
Received: from [192.168.23.121] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3X_Lj6PFoW_K7AQ--.63274S2;
	Fri, 17 Oct 2025 14:57:40 +0800 (CST)
Message-ID: <9243fe19-8e38-43e4-8ea4-077fa4512395@163.com>
Date: Fri, 17 Oct 2025 14:57:39 +0800
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
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <5f1eb044728420769c5482ea95240717c0748f46.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgC3X_Lj6PFoW_K7AQ--.63274S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4kZw1xXF4xCFyrJr1DJrb_yoW8trW8pr
	WUKFs0kF48Xr15urn2qF42ya1jq340g3yfAFn3Gw13AFnxCrnIgF4UKF1rWFZ8Cr4xAF48
	XF4UAay3WFWYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRhSd9UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiUgrpymjx5fpKHAAAsr

> This modification addresses a potential issue detected by Smatch during a scan of the NFS code. After reviewing the relevant code, I confirmed that the change is required to remove the potential risk.



在 2025/10/13 12:47, Trond Myklebust 写道:
> On Sun, 2025-10-12 at 16:39 +0800, Baolin Liu wrote:
>> [You don't often get email from liubaolin12138@163.com. Learn why
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> From: Baolin Liu <liubaolin@kylinos.cn>
>>
>> nfs_page_to_folio(req->wb_head) may return NULL in certain
>> conditions,
>> but the function dereferences folio->mapping and calls
>> folio_end_dropbehind(folio) unconditionally. This may cause a NULL
>> pointer dereference crash.
>>
>> Fix this by checking folio before using it or calling
>> folio_end_dropbehind().
>>
>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>> ---
>>   fs/nfs/write.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
>> index 0fb6905736d5..e148308c1923 100644
>> --- a/fs/nfs/write.c
>> +++ b/fs/nfs/write.c
>> @@ -739,17 +739,18 @@ static void nfs_inode_remove_request(struct
>> nfs_page *req)
>>          nfs_page_group_lock(req);
>>          if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
>>                  struct folio *folio = nfs_page_to_folio(req-
>>> wb_head);
>> -               struct address_space *mapping = folio->mapping;
>>
>> -               spin_lock(&mapping->i_private_lock);
>>                  if (likely(folio)) {
>> +                       struct address_space *mapping = folio-
>>> mapping;
>> +
>> +                       spin_lock(&mapping->i_private_lock);
>>                          folio->private = NULL;
>>                          folio_clear_private(folio);
>>                          clear_bit(PG_MAPPED, &req->wb_head-
>>> wb_flags);
>> -               }
>> -               spin_unlock(&mapping->i_private_lock);
>> +                       spin_unlock(&mapping->i_private_lock);
>>
>> -               folio_end_dropbehind(folio);
>> +                       folio_end_dropbehind(folio);
>> +               }
>>          }
>>          nfs_page_group_unlock(req);
>>
>> --
>> 2.39.2
>>
> 
> What reason is there to believe that we can ever call
> nfs_inode_remove_request() with a NULL value for req->wb_head-
>> wb_folio, or even with a NULL value for req->wb_head->wb_folio-
>> mapping?
> 
> 


