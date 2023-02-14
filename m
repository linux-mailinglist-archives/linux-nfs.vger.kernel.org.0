Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB93C6967B2
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 16:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjBNPLk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 14 Feb 2023 10:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjBNPLh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 10:11:37 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E45A28D16
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 07:11:34 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id 5so17728226qtp.9
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 07:11:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RlKcHWMRAyTrSGO7eZXg+53JARh0c37wwoG7UKvwtyw=;
        b=d8cVtfz07i0LNj7h0wnXt3E81yf8/ogcD8w2/95v7Cd/kSiNQTXli3RAEd9kIc6I/N
         Is1yks+8hcVRNyFSLfI1P5hLcCoWcs5h9Lfv5vrIh5IiVDVQ7970rOFTHwoLbEA0+hM4
         jV2hz792Umlo4mWEuUcjaubb29ZGpnE917wOilpUPocM6mprjNVSjUEQFA9uDnCOtWe4
         VFFqafrcUZbDxvSVogPlr0NCMlv0p/ZUqtNv/9TLzVWXzVtDIzKnt5u9QNyw4zW3ldBF
         Xr3mpLm5WB0CSNQ23iH5Lap0fzbxDRh9wOe/LF83/jp9bcC7wOjJTmQUI6NSEaiDt4hS
         SA/A==
X-Gm-Message-State: AO0yUKUmSvcssied7/9w/D4uTIyNJ3gj7EUONEWXf6eDlPixits5zsGG
        cs+sYixRDlGZBYQNZ/1vYw==
X-Google-Smtp-Source: AK7set+epEgDZQFoayvTMJmVnPIc/3T5A5Nic0mf8yC79c+pWrUrLgk3lzgYy7z7i9iw/hm8lDRdJg==
X-Received: by 2002:a05:622a:11d1:b0:3b8:6c68:e6d with SMTP id n17-20020a05622a11d100b003b86c680e6dmr4437562qtk.13.1676387493511;
        Tue, 14 Feb 2023 07:11:33 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id g17-20020ac842d1000000b003b8558eabd0sm11295578qtm.23.2023.02.14.07.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:11:33 -0800 (PST)
Message-ID: <75a0e5062a32f9b19892582175c24a6ddbf97a36.camel@kernel.org>
Subject: Re: [PATCH] nfsd: allow reaping files that are still under writeback
From:   Trond Myklebust <trondmy@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 14 Feb 2023 10:11:32 -0500
In-Reply-To: <21FDFADF-FAA8-4526-80CB-9ECCB2F937CF@oracle.com>
References: <20230213202346.291008-1-jlayton@kernel.org>
         <E1A055FD-45C3-47A0-A6CB-296C84985D43@oracle.com>
         <d7eea987852cffb5fc719310ed01f771390d60d2.camel@kernel.org>
         <21FDFADF-FAA8-4526-80CB-9ECCB2F937CF@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-02-14 at 15:05 +0000, Chuck Lever III wrote:
> 
> 
> > On Feb 14, 2023, at 10:00 AM, Trond Myklebust <trondmy@kernel.org>
> > wrote:
> > 
> > On Tue, 2023-02-14 at 14:48 +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Feb 13, 2023, at 3:23 PM, Jeff Layton <jlayton@kernel.org>
> > > > wrote:
> > > > 
> > > > There's no reason to delay reaping an nfsd_file just because
> > > > its
> > > > underlying inode is still under writeback. nfsd just relies on
> > > > client
> > > > activity or the local flusher threads to do writeback.
> > > > 
> > > > Holding the file open does nothing to facilitate that, nor does
> > > > it
> > > > help
> > > > with tracking errors. Just allow it to close and let the kernel
> > > > do
> > > > writeback as it normally would.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > 
> > > Thanks! Applied to topic-filecache-cleanups.
> > > 
> > > 
> > > > ---
> > > > fs/nfsd/filecache.c | 22 ----------------------
> > > > 1 file changed, 22 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index e6617431df7c..3b9a10378c83 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -296,19 +296,6 @@ nfsd_file_free(struct nfsd_file *nf)
> > > >         call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> > > > }
> > > > 
> > > > -static bool
> > > > -nfsd_file_check_writeback(struct nfsd_file *nf)
> > > > -{
> > > > -       struct file *file = nf->nf_file;
> > > > -       struct address_space *mapping;
> > > > -
> > > > -       if (!file || !(file->f_mode & FMODE_WRITE))
> > > > -               return false;
> > > > -       mapping = file->f_mapping;
> > > > -       return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> > > > -               mapping_tagged(mapping,
> > > > PAGECACHE_TAG_WRITEBACK);
> > > > -}
> > > > -
> > > > static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > > > {
> > > >         set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > > @@ -438,15 +425,6 @@ nfsd_file_lru_cb(struct list_head *item,
> > > > struct list_lru_one *lru,
> > > >         /* We should only be dealing with GC entries here */
> > > >         WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
> > > > 
> > > > -       /*
> > > > -        * Don't throw out files that are still undergoing I/O
> > > > or
> > > > -        * that have uncleared errors pending.
> > > > -        */
> > > > -       if (nfsd_file_check_writeback(nf)) {
> > > > -               trace_nfsd_file_gc_writeback(nf);
> > > > -               return LRU_SKIP;
> > > > -       }
> > > > -
> > > >         /* If it was recently added to the list, skip it */
> > > >         if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf-
> > > > > nf_flags)) {
> > > >                 trace_nfsd_file_gc_referenced(nf);
> > > > -- 
> > > > 2.39.1
> > > > 
> > > 
> > > --
> > > Chuck Lever
> > > 
> > > 
> > > 
> > 
> > Wait... There is a good reason for wanting to do this in the case
> > of
> > NFS re-exports, since close() is a very expensive operation if the
> > file
> > has dirty data.
> 
> Then perhaps skipping these files can be gated on an EXPORT_OP flag?

That would work.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


