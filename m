Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BA041CD52
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 22:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346575AbhI2UXn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 16:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25021 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346369AbhI2UXm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Sep 2021 16:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632946921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=atdiJKCN1rPb9B1csLecm6E+ZZ9KOVT2cb/f42xSuWo=;
        b=inyl4lYT/0rs3AHok9+8wSiE7yN6m6STaZbh4HAeL3ryFMwxrkIAZmi6TPfu3oxC+Ch2aS
        cyK/qCNzX0oX6Ou+SiztD9en4sXti+F+OrBs7/BT+tiYwnPeNP3+/YgX15NZe5DNRCRU0k
        1K0DiY2LCshLKMzPzsXOl8BUTa4Xdn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-DDhi8SIMNueLyRXz8aFd0A-1; Wed, 29 Sep 2021 16:21:59 -0400
X-MC-Unique: DDhi8SIMNueLyRXz8aFd0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D65FA8B4A9A;
        Wed, 29 Sep 2021 20:21:24 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9058219C59;
        Wed, 29 Sep 2021 20:21:24 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/5] NFS: Further optimisations for 'ls -l'
Date:   Wed, 29 Sep 2021 16:21:23 -0400
Message-ID: <F6D17359-3190-4A67-9DF7-08BCE61BE075@redhat.com>
In-Reply-To: <f09a7c00b70d51a442542dec1e1ba98289ad612c.camel@hammerspace.com>
References: <20210929134944.632844-1-trondmy@kernel.org>
 <20210929134944.632844-2-trondmy@kernel.org>
 <20210929134944.632844-3-trondmy@kernel.org>
 <20210929134944.632844-4-trondmy@kernel.org>
 <C9ED123C-A092-4417-8597-AB6267379E2F@redhat.com>
 <f09a7c00b70d51a442542dec1e1ba98289ad612c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 29 Sep 2021, at 12:23, Trond Myklebust wrote:

> On Wed, 2021-09-29 at 10:56 -0400, Benjamin Coddington wrote:
>> On 29 Sep 2021, at 9:49, trondmy@kernel.org wrote:
>>
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> If a user is doing 'ls -l', we have a heuristic in GETATTR that
>>> tells
>>> the readdir code to try to use READDIRPLUS in order to refresh the
>>> inode
>>> attributes. In certain cirumstances, we also try to invalidate the
>>> remaining directory entries in order to ensure this refresh.
>>>
>>> If there are multiple readers of the directory, we probably should
>>> avoid
>>> invalidating the page cache, since the heuristic breaks down in
>>> that
>>> situation anyway.
>>
>> Hi Trond, I'm curious about the motivation for this work because
>> we're often
>> managing expectations about performance between various workloads. 
>> What
>> does the workload look like that prompted you to make this
>> optimization?
>>
>> I'm also interested because I have some work that improves readdir
>> performance for multiple readers on large directories, but is rotting
>> because things have been "good enough" for folks over here.
>>
>
> Are you talking about this patch specifically, or the series in
> general?

A bit of both - the first two patches didn't really make sense to me, but I
get it now.  Thanks.

> The general motivation for the series is that in certain circumstances
> involving a read-only scenario (no changes to the directory) and
> multiple processes we're seeing a regression w.r.t. older kernels.
>
> The motivation for this particular patch is twofold:
>    1. I want to get rid of the cached page_index in the inode and
>       replace it with something less persistent (inodes are forever,
>       unlike file descriptors).
>    2. The heuristic in question is designed to only work in the single
>       process/single threaded case.

Make sense to me now.

I'm wondering if this might be creating a READDIR op amplification for N
readers sharing the directory's fd because one process can be dropping the
cache, which artificially deflates desc->page_index for a given dir_cookie.
That lower page_index gets reused on the next pass dropping the cache, and
it'll keep using the bottom pages and doing READDIRs.  That wasn't possible
before because we only invalidated past nfsi->page_index.

Maybe an unlikely case (but I think some http servers could behave this
way), and I'd have to test it to be sure.  I can try to do that unless you
think its not possible or concerning.

Ben

