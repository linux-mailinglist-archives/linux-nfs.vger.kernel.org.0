Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83969AD62
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Feb 2023 15:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjBQOJ5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Feb 2023 09:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBQOJ4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Feb 2023 09:09:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5796747B
        for <linux-nfs@vger.kernel.org>; Fri, 17 Feb 2023 06:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676642947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ds1iYS2PAgZKHxpFwgCV8oaw6gvOKwKZ6vYa+kb1e5o=;
        b=OvRChE1lJjcTP0Nberh0awbc2uRci6K+lSUyuRardWJM/ZmbS5Xwxzqap7mM+9/QIJBB8W
        QDD9XConnPxpP2+d+klrvF7bw5yd/UC26RaMnzQWOOBOI+2sg0nBQUntZxPJBiD0x9bPEN
        /Ocf/n2h7j2F8HaZmmpUlvtoKIfbjbk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-312-TjJcaeuCNyCIFUJ5JJGpNQ-1; Fri, 17 Feb 2023 09:09:05 -0500
X-MC-Unique: TjJcaeuCNyCIFUJ5JJGpNQ-1
Received: by mail-pg1-f200.google.com with SMTP id b17-20020a63d311000000b004fb64e929f2so438653pgg.7
        for <linux-nfs@vger.kernel.org>; Fri, 17 Feb 2023 06:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ds1iYS2PAgZKHxpFwgCV8oaw6gvOKwKZ6vYa+kb1e5o=;
        b=zC+STViZRNHFdoiQYpIPreYY/bOzN/sUP9WV+dxbiMynfbumr0nWiu93nzfNChDdNe
         neiOz9UHSnQezoB+8+z4sXzxPr4pVgLkSMoJ3921Tplrr1ehy3KLnf4J9X4lgJzIJReY
         92B3jHQZPZj836s62oybqhU9NUbtvsyuZOWxc/xShAsazsKtDCUMb6e1zdTIZiVewAkN
         n2BJdB/qhWHwFADhZCXP5l01vqdWnY6ctwVtCTqSfhLtnXTzCOWC6k6T0Zpc8uJitORE
         pyWbyusRgCb8yLbS/rXeRjAdhXlLp6BwVP6dTe7nwgCzJlTHbqC37iPtiIuFy69KdBDm
         flsw==
X-Gm-Message-State: AO0yUKU2s0krhcKURRlC7q+SDt1DlAKWkafjF0uja0iDXA3ZDPFodha/
        j3F1BY+roNBFjoqBlsG+K7GKmqJ0l8RdId/k8HAOsozf/lXVAZ6jFdoT/b0KA8zF7f3rG4J9INn
        bDyViMpQp/sRm9gnLWDYFfB4UEXGv7EiShZq2
X-Received: by 2002:a17:90b:17ca:b0:233:d1eb:de8b with SMTP id me10-20020a17090b17ca00b00233d1ebde8bmr1478345pjb.130.1676642944531;
        Fri, 17 Feb 2023 06:09:04 -0800 (PST)
X-Google-Smtp-Source: AK7set+i9FzSBbZlSnTiOj2nUIte8iA4u9yjfRydhXLCqDjZEcX6ogmd/AN56RpcB/gKpFLtzX4Qqer6+szwMipxk00=
X-Received: by 2002:a17:90b:17ca:b0:233:d1eb:de8b with SMTP id
 me10-20020a17090b17ca00b00233d1ebde8bmr1478339pjb.130.1676642944246; Fri, 17
 Feb 2023 06:09:04 -0800 (PST)
MIME-Version: 1.0
References: <CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com>
In-Reply-To: <CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 17 Feb 2023 09:08:27 -0500
Message-ID: <CALF+zO=e+d3sdLA4MZ_-SZh3epWBKF=hY=8FB+aB8+H4rxe4KA@mail.gmail.com>
Subject: Re: /proc/PID/io/read_bytes accounting regression?
To:     Daire Byrne <daire@dneg.com>, Matthew Wilcox <willy@infradead.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Feb 17, 2023 at 6:56 AM Daire Byrne <daire@dneg.com> wrote:
>
> Hi,
>
> Maybe someone here can quickly point me in the right direction for
> this oddity that we noticed.
>
> On newer kernels, it looks like the task io accounting is not
> incrementing the read_bytes when reading from a NFS mount? This was
> definitely working on v5.16 downwards, but has not been working since
> v5.18 up to v6.2 (I haven't tested v5.17 yet).
>
> If I read from a local filesystem, then the read_bytes for that PID is
> incremented as expected.
>
> If I read over NFS using directIO, then the read_bytes is also
> correctly incremented for that PID. It's just when reading normally
> without directIO that it is not.
>
> The write_bytes and rchar are also still both correct in all situations.
>
> I have checked the kernel config and I'm fairly sure I have all the
> right things enabled:
>
> CONFIG_TASK_XACCT=y
> CONFIG_TASK_IO_ACCOUNTING=y
> CONFIG_TASKSTATS=y
>
> Unless there was some extra config introduced specific to the nfs
> client in later kernels that I missed?
>
> Cheers,
>
> Daire
>

Daire,
Thanks for the report.

Willy,
Question for you at the bottom of this.

First, here's what looks to be the candidate changes between these versions:

$ git log --oneline v5.16..v5.18 fs/nfs/read.c
89c2be8a9516 NFS: discard NFS_RPC_SWAPFLAGS and RPC_TASK_ROOTCREDS
fc1c5abfca7e NFS: Rename fscache read and write pages functions
8786fde8421c Convert NFS from readpages to readahead
16f2f4e679cf nfs: Implement cache I/O by accessing the cache directly

I would be this  is due to this patch, which went into 5.18:
8786fde8421c Convert NFS from readpages to readahead


And the hunks that now call readahead_page vs read_cache_pages:

@@ -397,14 +396,16 @@ int nfs_readpage(struct file *file, struct page *page)
        return ret;
 }

-int nfs_readpages(struct file *file, struct address_space *mapping,
-               struct list_head *pages, unsigned nr_pages)
+void nfs_readahead(struct readahead_control *ractl)
 {
+       unsigned int nr_pages = readahead_count(ractl);
+       struct file *file = ractl->file;
        struct nfs_readdesc desc;
-       struct inode *inode = mapping->host;
+       struct inode *inode = ractl->mapping->host;
+       struct page *page;
        int ret;

-       trace_nfs_aop_readahead(inode, lru_to_page(pages), nr_pages);
+       trace_nfs_aop_readahead(inode, readahead_pos(ractl), nr_pages);
        nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);

        ret = -ESTALE;
@@ -422,14 +423,18 @@ int nfs_readpages(struct file *file, struct
address_space *mapping,
        nfs_pageio_init_read(&desc.pgio, inode, false,
                             &nfs_async_read_completion_ops);

-       ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
+       while ((page = readahead_page(ractl)) != NULL) {
+               ret = readpage_async_filler(&desc, page);
+               put_page(page);
+               if (ret)
+                       break;
+       }

        nfs_pageio_complete_read(&desc.pgio);

        put_nfs_open_context(desc.ctx);
 out:
        trace_nfs_aop_readahead_done(inode, nr_pages, ret);
-       return ret;
 }

and this hunk:
@@ -397,14 +396,16 @@ int nfs_readpage(struct file *file, struct page *page)
        return ret;
 }

-int nfs_readpages(struct file *file, struct address_space *mapping,
-               struct list_head *pages, unsigned nr_pages)
+void nfs_readahead(struct readahead_control *ractl)
 {
+       unsigned int nr_pages = readahead_count(ractl);
+       struct file *file = ractl->file;
        struct nfs_readdesc desc;
-       struct inode *inode = mapping->host;
+       struct inode *inode = ractl->mapping->host;
+       struct page *page;
        int ret;

-       trace_nfs_aop_readahead(inode, lru_to_page(pages), nr_pages);
+       trace_nfs_aop_readahead(inode, readahead_pos(ractl), nr_pages);
        nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);

        ret = -ESTALE;
@@ -422,14 +423,18 @@ int nfs_readpages(struct file *file, struct
address_space *mapping,
        nfs_pageio_init_read(&desc.pgio, inode, false,
                             &nfs_async_read_completion_ops);

-       ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
+       while ((page = readahead_page(ractl)) != NULL) {
+               ret = readpage_async_filler(&desc, page);
+               put_page(page);
+               if (ret)
+                       break;
+       }

        nfs_pageio_complete_read(&desc.pgio);

        put_nfs_open_context(desc.ctx);
 out:
        trace_nfs_aop_readahead_done(inode, nr_pages, ret);
-       return ret;
 }

 int __init nfs_init_readpagecache(void)



In v5.16 we had this call to task_io_account_read(PAGE_SIZE); on line 109
of read_cache_pages();
76 /**
 77  * read_cache_pages - populate an address space with some pages &
start reads against them
 78  * @mapping: the address_space
 79  * @pages: The address of a list_head which contains the target
pages.  These
 80  *   pages have their ->index populated and are otherwise uninitialised.
 81  * @filler: callback routine for filling a single page.
 82  * @data: private data for the callback routine.
 83  *
 84  * Hides the details of the LRU cache etc from the filesystems.
 85  *
 86  * Returns: %0 on success, error return by @filler otherwise
 87  */
 88 int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 89                         int (*filler)(void *, struct page *), void *data)
 90 {
 91         struct page *page;
 92         int ret = 0;
 93
 94         while (!list_empty(pages)) {
 95                 page = lru_to_page(pages);
 96                 list_del(&page->lru);
 97                 if (add_to_page_cache_lru(page, mapping, page->index,
 98                                 readahead_gfp_mask(mapping))) {
 99                         read_cache_pages_invalidate_page(mapping, page);
100                         continue;
101                 }
102                 put_page(page);
103
104                 ret = filler(data, page);
105                 if (unlikely(ret)) {
106                         read_cache_pages_invalidate_pages(mapping, pages);
107                         break;
108                 }
109                 task_io_account_read(PAGE_SIZE);

But there's no call to task_io_account_read() anymore in the new
readahead code paths that I could tell,
but maybe I'm missing something.

Willy,
Does each caller of readahead_page() now need to call
task_io_account_read() or should we add that into
readahead_page() or maybe inside read_pages()?

