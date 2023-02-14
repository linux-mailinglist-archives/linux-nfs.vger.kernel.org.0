Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4194E6967EB
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 16:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjBNPWX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 14 Feb 2023 10:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjBNPWW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 10:22:22 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23322BF06
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 07:22:01 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id mg2so3457427qvb.9
        for <linux-nfs@vger.kernel.org>; Tue, 14 Feb 2023 07:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8biF+OgfeR0j2DohiBqG51/PIWzgRG+2wjupQt3bXQ8=;
        b=u+O8k1ASioVCe4eX4qWyhgO4Di08vGljgbDKkn1cw6jOfuCfDCo+c3kVU1IU0XfCIo
         JYZoKaVXmCHMGYsrL5rolkJnjc5DFzA4cUZWkfpViJWt+vYh0aZkFN6wrSQ1yczMYeAf
         3hoe0c+GoikL4AK2RAy/qEkF0swGPJJ+EtwjY+nSzE23W9dYsvFmCdnkvlu9Mkdg8+lN
         evSwZxxCap9sEu6L0BxdhX7A8pZWAu/YqnoA0KS259Dc38NpYUQO1ravuQytamc+6v/0
         5PSinP7XsFt19CoySbXKAK40D+JYXINlbuB+o0tptra/BflBineiTClbo6KYqbbo/Qif
         uogg==
X-Gm-Message-State: AO0yUKUxnDFSYjQ+tf5k5P/R6IgtFtE9jXdHfGSmGENqF4E7qB5AHZ9N
        tMl8uAjVStbzcWwLStXU3UkBEK+ZJA==
X-Google-Smtp-Source: AK7set/Db8SH6agQSsSad6lZThuhX+7MybX//rTUpNSZE9AACvB2myzjYinJzU8y/2cHSIPwuFBqQA==
X-Received: by 2002:ad4:4bc4:0:b0:56e:c3bf:d9d2 with SMTP id l4-20020ad44bc4000000b0056ec3bfd9d2mr4274112qvw.13.1676388118856;
        Tue, 14 Feb 2023 07:21:58 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id 23-20020a370417000000b006ef1a8f1b81sm11971009qke.5.2023.02.14.07.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:21:58 -0800 (PST)
Message-ID: <3afba9fdbd9b0056eff0d3262d6951641f46ca10.camel@kernel.org>
Subject: Re: [PATCH] nfsd: allow reaping files that are still under writeback
From:   Trond Myklebust <trondmy@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 14 Feb 2023 10:21:57 -0500
In-Reply-To: <e8f5b07200f197a2972beb0628df55ec92b627b5.camel@kernel.org>
References: <20230213202346.291008-1-jlayton@kernel.org>
         <E1A055FD-45C3-47A0-A6CB-296C84985D43@oracle.com>
         <d7eea987852cffb5fc719310ed01f771390d60d2.camel@kernel.org>
         <e8f5b07200f197a2972beb0628df55ec92b627b5.camel@kernel.org>
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

On Tue, 2023-02-14 at 10:16 -0500, Jeff Layton wrote:
> On Tue, 2023-02-14 at 10:00 -0500, Trond Myklebust wrote:
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
> > > >         call_rcu(&nf->nf_rcu, nfsd_file_slab_free);
> > > > }
> > > > 
> > > > -static bool
> > > > -nfsd_file_check_writeback(struct nfsd_file *nf)
> > > > -{
> > > > -       struct file *file = nf->nf_file;
> > > > -       struct address_space *mapping;
> > > > -
> > > > -       if (!file || !(file->f_mode & FMODE_WRITE))
> > > > -               return false;
> > > > -       mapping = file->f_mapping;
> > > > -       return mapping_tagged(mapping, PAGECACHE_TAG_DIRTY) ||
> > > > -               mapping_tagged(mapping,
> > > > PAGECACHE_TAG_WRITEBACK);
> > > > -}
> > > > -
> > > > static bool nfsd_file_lru_add(struct nfsd_file *nf)
> > > > {
> > > >         set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> > > > @@ -438,15 +425,6 @@ nfsd_file_lru_cb(struct list_head *item,
> > > > struct list_lru_one *lru,
> > > >         /* We should only be dealing with GC entries here */
> > > >         WARN_ON_ONCE(!test_bit(NFSD_FILE_GC, &nf->nf_flags));
> > > > 
> > > > -       /*
> > > > -        * Don't throw out files that are still undergoing I/O
> > > > or
> > > > -        * that have uncleared errors pending.
> > > > -        */
> > > > -       if (nfsd_file_check_writeback(nf)) {
> > > > -               trace_nfsd_file_gc_writeback(nf);
> > > > -               return LRU_SKIP;
> > > > -       }
> > > > -
> > > >         /* If it was recently added to the list, skip it */
> > > >         if (test_and_clear_bit(NFSD_FILE_REFERENCED, &nf-
> > > > > nf_flags)) {
> > > >                 trace_nfsd_file_gc_referenced(nf);
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
> > 
> 
> Fair enough. What if we added a new EXPORT_OP_FLUSH_ON_CLOSE flag
> that
> filesystems could set in the export_operations? Then we could make
> this
> behavior conditional on that being set?

Sure.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


