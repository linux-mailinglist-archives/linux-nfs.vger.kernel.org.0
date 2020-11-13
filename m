Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B642B19AC
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 12:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKMLKx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 06:10:53 -0500
Received: from smtp-o-2.desy.de ([131.169.56.155]:35656 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgKMLJS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 13 Nov 2020 06:09:18 -0500
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id 8BBA9160F9B
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 12:09:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 8BBA9160F9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1605265747; bh=OSOJc+c4wKFXXoHH2Uj7kakoaBuwb81H5+H1gtGxTBY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hSAtb/wLcq56jCpWU5DT/7LOu1/vTzAvngLtGoDiTPURBdfLPVOlRzpUF2Y4zpw52
         gTt+cyCJajQ5FTHbWvvRwZmzRW7M8HrAGeTzJSnQyzPmqNdEr4IhUKm/Nao1Ilvkto
         nzcA+71JHMyEum/j3gshEIsu1wWIa7DuXQr1xX74=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id 7DA421A00AC;
        Fri, 13 Nov 2020 12:09:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 505C080067;
        Fri, 13 Nov 2020 12:09:07 +0100 (CET)
Date:   Fri, 13 Nov 2020 12:09:06 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     trondmy <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>
Message-ID: <1763183200.587093.1605265746816.JavaMail.zimbra@desy.de>
In-Reply-To: <FF04DA98-C072-4C92-ABF9-41FE6ECB10B5@redhat.com>
References: <20201110213741.860745-1-trondmy@kernel.org> <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com> <723ef5d47994e34804f5514b06940e96620e2b70.camel@hammerspace.com> <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com> <DC49EB88-4B79-40FC-97C3-47D2A588F96C@redhat.com> <6eed4c13be095a979b31b98668bf64f60ad0be51.camel@hammerspace.com> <DD8B2AD2-34BF-4751-A01A-3E10677EB8E7@redhat.com> <FF04DA98-C072-4C92-ABF9-41FE6ECB10B5@redhat.com>
Subject: Re: [PATCH v5 00/22] Readdir enhancements
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF82 (Mac)/8.8.15_GA_3953)
Thread-Topic: Readdir enhancements
Thread-Index: FaEPkXejAB4uR4ThzJ8c+KBTzjz9lg==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



Hi Trond,

I can confirm that with latest patchset we see 3x improvement
on directories listings with 100K and 500K files.

The downside is that our users will start to create directories
with even more files :). This weeks record 2.5M files at
200 files-per-second rate....

Thanks again,
   Tigran.

----- Original Message -----
> From: "Benjamin Coddington" <bcodding@redhat.com>
> To: "trondmy" <trondmy@hammerspace.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>, "David Wysochanski" <dwysocha@redhat.com>
> Sent: Thursday, 12 November, 2020 21:23:32
> Subject: Re: [PATCH v5 00/22] Readdir enhancements

> On 12 Nov 2020, at 14:09, Benjamin Coddington wrote:
> 
>> On 12 Nov 2020, at 14:04, Trond Myklebust wrote:
>>
>>> On Thu, 2020-11-12 at 13:39 -0500, Benjamin Coddington wrote:
>>>>
>>>>
>>>> On 12 Nov 2020, at 13:26, Trond Myklebust wrote:
>>>>
>>>>> On Thu, 2020-11-12 at 16:51 +0000, Trond Myklebust wrote:
>>>>>>
>>>>>> I was going to ask you if perhaps reverting Scott's commit
>>>>>> 07b5ce8ef2d8
>>>>>> ("NFS: Make nfs_readdir revalidate less often") might help here?
>>>>>> My thinking is that will trigger more cache invalidations when
>>>>>> the
>>>>>> directory is changing underneath us, and will now trigger
>>>>>> uncached
>>>>>> readdir in those situations.
>>>>>>
>>>>>>>
>>>>>
>>>>> IOW, the suggestion would be to apply something like the following
>>>>> on
>>>>> top of the existing readdir patchset:
>>>>
>>>> I'm all for this approach, but - I'm rarely seeing the mapping-
>>>>> nrpages == 0
>>>> since the cache is dropped by a process in nfs_readdir() that
>>>> immediately
>>>> starts filling the cache again.
>>>
>>> That's why I moved the check in readdir_search_pagecache. Unless that
>>> process has set desc->dir_cookie == 0, then that should prevent the
>>> refilling.
>>
>> My pathological benchmarking does send another process in with
>> desc->dir_cookie == 0.
>>
>> I'm doing fork(), while(getdents) every second with acdirmin=1 and a
>> listing
>> that takes longer than 1 second to complete uncached, while touching
>> the
>> directory every second.
> 
> 
> As long as I use a buffer > 16k for getdents(), this hack can keep up
> with the testcase:
> 
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index d7a9efd31ecd..ae687662112a 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -78,6 +78,7 @@ static struct nfs_open_dir_context
> *alloc_nfs_open_dir_context(struct inode *dir
>                 ctx->attr_gencount = nfsi->attr_gencount;
>                 ctx->dir_cookie = 0;
>                 ctx->dup_cookie = 0;
> +               ctx->page_index = 0;
>                 spin_lock(&dir->i_lock);
>                 if (list_empty(&nfsi->open_files) &&
>                     (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
> @@ -150,6 +151,7 @@ struct nfs_readdir_descriptor {
>         struct page     *page;
>         struct dir_context *ctx;
>         pgoff_t         page_index;
> +       pgoff_t         last_page_index;
>         u64             dir_cookie;
>         u64             last_cookie;
>         u64             dup_cookie;
> @@ -928,7 +930,12 @@ static bool nfs_readdir_dont_search_cache(struct
> nfs_readdir_descriptor *desc)
>          * Default to uncached readdir if the page cache is empty, and
>          * we're looking for a non-zero cookie in a large directory.
>          */
> -       return desc->dir_cookie != 0 && mapping->nrpages == 0 && size >
> dtsize;
> +       if (desc->dir_cookie == 0)
> +               return false;
> +       else if (mapping->nrpages < desc->last_page_index && size >
> dtsize)
> +               return true;
> +
> +       return false;
>  }
> 
>  /* Search for desc->dir_cookie from the beginning of the page cache */
> @@ -936,10 +943,10 @@ static int readdir_search_pagecache(struct
> nfs_readdir_descriptor *desc)
>  {
>         int res;
> 
> -       if (nfs_readdir_dont_search_cache(desc))
> -               return -EBADCOOKIE;
> -
>         do {
> +               if (nfs_readdir_dont_search_cache(desc))
> +                       return -EBADCOOKIE;
> +
>                 if (desc->page_index == 0) {
>                         desc->current_index = 0;
>                         desc->prev_index = 0;
> @@ -1062,11 +1069,9 @@ static int nfs_readdir(struct file *file, struct
> dir_context *ctx)
>          * to either find the entry with the appropriate number or
>          * revalidate the cookie.
>          */
> -       if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
> -               res = nfs_revalidate_mapping(inode, file->f_mapping);
> -               if (res < 0)
> -                       goto out;
> -       }
> +       res = nfs_revalidate_mapping(inode, file->f_mapping);
> +       if (res < 0)
> +               goto out;
> 
>         res = -ENOMEM;
>         desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> @@ -1082,6 +1087,7 @@ static int nfs_readdir(struct file *file, struct
> dir_context *ctx)
>         desc->duped = dir_ctx->duped;
>         desc->attr_gencount = dir_ctx->attr_gencount;
>         memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
> +       desc->last_page_index = dir_ctx->page_index;
>         spin_unlock(&file->f_lock);
> 
>         do {
> @@ -1121,6 +1127,8 @@ static int nfs_readdir(struct file *file, struct
> dir_context *ctx)
>         dir_ctx->duped = desc->duped;
>         dir_ctx->attr_gencount = desc->attr_gencount;
>         memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
> +       if (desc->page_index > dir_ctx->page_index)
> +               dir_ctx->page_index = desc->page_index;
>         spin_unlock(&file->f_lock);
> 
>         kfree(desc);
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 681ed98e4ba8..ad1f8e9a22e6 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -98,6 +98,7 @@ struct nfs_open_dir_context {
>         __u64 dir_cookie;
>         __u64 dup_cookie;
>         signed char duped;
> +       pgoff_t page_index;
>  };
> 
>  /*
> 
> 
> 
> Here's the testcase I'm using:
> #include <stdio.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/syscall.h>
> #include <sys/time.h>
> 
> /*
>  * mkdir /exports/10k_dentries
>  * for i in {1..10000}; do printf "/exports/10k_dentries/file%.12d\n"
> $i; done | xargs touch
>  */
> #define DIR "/mnt/fedora/10k_dentries"
> #define BUF_SIZE 1024 * 16
> 
> void evict_pagecache() {
>	int dir_fd = open(DIR, O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC);
>	posix_fadvise(dir_fd, 0, 0, POSIX_FADV_DONTNEED);
>	close(dir_fd);
> }
> 
> /* call getdents64() until no more, return time taken */
> int listdir() {
>	struct timeval tvs, tve;
>	char buf[BUF_SIZE];
>	int dir_fd = open(DIR, O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC);
> 
>	gettimeofday(&tvs, NULL);
>	while (syscall(SYS_getdents, dir_fd, buf, BUF_SIZE)) { }
>	gettimeofday(&tve, NULL);
>	return tve.tv_sec - tvs.tv_sec;
> }
> 
> int main(int argc, char **argv)
> {
>	evict_pagecache();
> 
>	while (1) {
>		if (!fork()) {
>			int secs;
>			printf("pid %d starts..\n", getpid());
>			fflush(stdout);
> 
>			secs = listdir();
> 
>			printf("pid %d done        %d seconds\n", getpid(), secs);
>			fflush(stdout);
>			return 0;
>		}
>		sleep (1);
>	}
> }
> 
> Ben
