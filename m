Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCBC2B0EFE
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Nov 2020 21:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgKLUXj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Nov 2020 15:23:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726566AbgKLUXi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Nov 2020 15:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605212616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+63JV1fFSlZAnlS+OKv1UTeGHeRr8TcS0CtYalXPmNw=;
        b=aQidY/yWxRbXytCpkR80Wx3qh+YpqVPEv1Rax+WZKovQj+A/IVcSCgqmTRj4j9IPhQ09hD
        8HT7oeRgpKLMCyEdRJoAHRLMxycQC9KIDVuJpIPrhAq4VxjK2EQOnOhObXKtJY1KbUnzGP
        3BAT1QmGDGYnQnhdH6dmnchT/nHAY6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-DRSWmQtrP2i8qrB8fvf2uw-1; Thu, 12 Nov 2020 15:23:34 -0500
X-MC-Unique: DRSWmQtrP2i8qrB8fvf2uw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E87186DD50;
        Thu, 12 Nov 2020 20:23:33 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-194.rdu2.redhat.com [10.10.64.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EE9B60C0F;
        Thu, 12 Nov 2020 20:23:33 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org, dwysocha@redhat.com
Subject: Re: [PATCH v5 00/22] Readdir enhancements
Date:   Thu, 12 Nov 2020 15:23:32 -0500
Message-ID: <FF04DA98-C072-4C92-ABF9-41FE6ECB10B5@redhat.com>
In-Reply-To: <DD8B2AD2-34BF-4751-A01A-3E10677EB8E7@redhat.com>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <CALF+zOkdXMDZ3TNGSNJQPtxy-ru_4iCYTz3U2uwkPAo3j55FZg@mail.gmail.com>
 <CALF+zO=-Si+CcEJvgzaYAjd2j8APV=4Xwm=FJibhuJRV+zWE5Q@mail.gmail.com>
 <723ef5d47994e34804f5514b06940e96620e2b70.camel@hammerspace.com>
 <6b07ff95824f5b46237fa07f5f72d8261d764007.camel@hammerspace.com>
 <DC49EB88-4B79-40FC-97C3-47D2A588F96C@redhat.com>
 <6eed4c13be095a979b31b98668bf64f60ad0be51.camel@hammerspace.com>
 <DD8B2AD2-34BF-4751-A01A-3E10677EB8E7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12 Nov 2020, at 14:09, Benjamin Coddington wrote:

> On 12 Nov 2020, at 14:04, Trond Myklebust wrote:
>
>> On Thu, 2020-11-12 at 13:39 -0500, Benjamin Coddington wrote:
>>>
>>>
>>> On 12 Nov 2020, at 13:26, Trond Myklebust wrote:
>>>
>>>> On Thu, 2020-11-12 at 16:51 +0000, Trond Myklebust wrote:
>>>>>
>>>>> I was going to ask you if perhaps reverting Scott's commit
>>>>> 07b5ce8ef2d8
>>>>> ("NFS: Make nfs_readdir revalidate less often") might help here?
>>>>> My thinking is that will trigger more cache invalidations when
>>>>> the
>>>>> directory is changing underneath us, and will now trigger
>>>>> uncached
>>>>> readdir in those situations.
>>>>>
>>>>>>
>>>>
>>>> IOW, the suggestion would be to apply something like the following
>>>> on
>>>> top of the existing readdir patchset:
>>>
>>> I'm all for this approach, but - I'm rarely seeing the mapping-
>>>> nrpages == 0
>>> since the cache is dropped by a process in nfs_readdir() that
>>> immediately
>>> starts filling the cache again.
>>
>> That's why I moved the check in readdir_search_pagecache. Unless that
>> process has set desc->dir_cookie == 0, then that should prevent the
>> refilling.
>
> My pathological benchmarking does send another process in with
> desc->dir_cookie == 0.
>
> I'm doing fork(), while(getdents) every second with acdirmin=1 and a 
> listing
> that takes longer than 1 second to complete uncached, while touching 
> the
> directory every second.


As long as I use a buffer > 16k for getdents(), this hack can keep up 
with the testcase:

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d7a9efd31ecd..ae687662112a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -78,6 +78,7 @@ static struct nfs_open_dir_context 
*alloc_nfs_open_dir_context(struct inode *dir
                 ctx->attr_gencount = nfsi->attr_gencount;
                 ctx->dir_cookie = 0;
                 ctx->dup_cookie = 0;
+               ctx->page_index = 0;
                 spin_lock(&dir->i_lock);
                 if (list_empty(&nfsi->open_files) &&
                     (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
@@ -150,6 +151,7 @@ struct nfs_readdir_descriptor {
         struct page     *page;
         struct dir_context *ctx;
         pgoff_t         page_index;
+       pgoff_t         last_page_index;
         u64             dir_cookie;
         u64             last_cookie;
         u64             dup_cookie;
@@ -928,7 +930,12 @@ static bool nfs_readdir_dont_search_cache(struct 
nfs_readdir_descriptor *desc)
          * Default to uncached readdir if the page cache is empty, and
          * we're looking for a non-zero cookie in a large directory.
          */
-       return desc->dir_cookie != 0 && mapping->nrpages == 0 && size > 
dtsize;
+       if (desc->dir_cookie == 0)
+               return false;
+       else if (mapping->nrpages < desc->last_page_index && size > 
dtsize)
+               return true;
+
+       return false;
  }

  /* Search for desc->dir_cookie from the beginning of the page cache */
@@ -936,10 +943,10 @@ static int readdir_search_pagecache(struct 
nfs_readdir_descriptor *desc)
  {
         int res;

-       if (nfs_readdir_dont_search_cache(desc))
-               return -EBADCOOKIE;
-
         do {
+               if (nfs_readdir_dont_search_cache(desc))
+                       return -EBADCOOKIE;
+
                 if (desc->page_index == 0) {
                         desc->current_index = 0;
                         desc->prev_index = 0;
@@ -1062,11 +1069,9 @@ static int nfs_readdir(struct file *file, struct 
dir_context *ctx)
          * to either find the entry with the appropriate number or
          * revalidate the cookie.
          */
-       if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
-               res = nfs_revalidate_mapping(inode, file->f_mapping);
-               if (res < 0)
-                       goto out;
-       }
+       res = nfs_revalidate_mapping(inode, file->f_mapping);
+       if (res < 0)
+               goto out;

         res = -ENOMEM;
         desc = kzalloc(sizeof(*desc), GFP_KERNEL);
@@ -1082,6 +1087,7 @@ static int nfs_readdir(struct file *file, struct 
dir_context *ctx)
         desc->duped = dir_ctx->duped;
         desc->attr_gencount = dir_ctx->attr_gencount;
         memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
+       desc->last_page_index = dir_ctx->page_index;
         spin_unlock(&file->f_lock);

         do {
@@ -1121,6 +1127,8 @@ static int nfs_readdir(struct file *file, struct 
dir_context *ctx)
         dir_ctx->duped = desc->duped;
         dir_ctx->attr_gencount = desc->attr_gencount;
         memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
+       if (desc->page_index > dir_ctx->page_index)
+               dir_ctx->page_index = desc->page_index;
         spin_unlock(&file->f_lock);

         kfree(desc);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 681ed98e4ba8..ad1f8e9a22e6 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -98,6 +98,7 @@ struct nfs_open_dir_context {
         __u64 dir_cookie;
         __u64 dup_cookie;
         signed char duped;
+       pgoff_t page_index;
  };

  /*



Here's the testcase I'm using:
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/syscall.h>
#include <sys/time.h>

/*
  * mkdir /exports/10k_dentries
  * for i in {1..10000}; do printf "/exports/10k_dentries/file%.12d\n" 
$i; done | xargs touch
  */
#define DIR "/mnt/fedora/10k_dentries"
#define BUF_SIZE 1024 * 16

void evict_pagecache() {
	int dir_fd = open(DIR, O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC);
	posix_fadvise(dir_fd, 0, 0, POSIX_FADV_DONTNEED);
	close(dir_fd);
}

/* call getdents64() until no more, return time taken */
int listdir() {
	struct timeval tvs, tve;
	char buf[BUF_SIZE];
	int dir_fd = open(DIR, O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC);

	gettimeofday(&tvs, NULL);
	while (syscall(SYS_getdents, dir_fd, buf, BUF_SIZE)) { }
	gettimeofday(&tve, NULL);
	return tve.tv_sec - tvs.tv_sec;
}

int main(int argc, char **argv)
{
	evict_pagecache();

	while (1) {
		if (!fork()) {
			int secs;
			printf("pid %d starts..\n", getpid());
			fflush(stdout);

			secs = listdir();

			printf("pid %d done        %d seconds\n", getpid(), secs);
			fflush(stdout);
			return 0;
		}
		sleep (1);
	}
}

Ben

