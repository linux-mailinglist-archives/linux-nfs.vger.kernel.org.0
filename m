Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB65A862F
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Aug 2022 20:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiHaS7m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Aug 2022 14:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233156AbiHaS7g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Aug 2022 14:59:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5757C04DF
        for <linux-nfs@vger.kernel.org>; Wed, 31 Aug 2022 11:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kml6lntpK4+uHhovKBxrdELOWMLYLaJdHAHwFikBvgo=; b=Es+5wh9VSMT5l5yk9g/wPakIUb
        zYWfOd6fpu8xhQkiW6z/mPZ+YLulg7IGhitoFMz0B5Fv99zJq79fEXusrf6XXZpRhioTXjdajcbOu
        pnhFy2d8RRp67ZFRYfiOqdRmrMwgFBSpjyQ0Z3u9jWHwUhjthEHNNt1SsOC0/lb9mgxD1O0agSP4f
        9JxVX5KlPt/2CYriR77e2ythGDsoa4slX638AmoUsIYsJrvHfyXzuHIIQmm5q94qm7abwLwcTm7dU
        v3kooKeUuLFkqgHqKskcQ6gOIZatdqKG9dL4Mv8AeGs8KM68P27x4UTW2jQqZFBK4IY4wPv4U5vyf
        /n9w2KxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTSuq-005MIW-SL; Wed, 31 Aug 2022 18:58:20 +0000
Date:   Wed, 31 Aug 2022 19:58:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Subject: Re: [PATCH v3 3/3] NFS: Convert buffered read paths to use netfs
 when fscache is enabled
Message-ID: <Yw+vTFdk4gAoNR27@casper.infradead.org>
References: <20220831005053.1287363-1-dwysocha@redhat.com>
 <20220831005053.1287363-4-dwysocha@redhat.com>
 <2c4f4fae20c702e805162f7fa780fc09f7f05aaa.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c4f4fae20c702e805162f7fa780fc09f7f05aaa.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Aug 31, 2022 at 02:21:23PM -0400, Jeff Layton wrote:
> > +static int nfs_netfs_init_request(struct netfs_io_request *rreq, struct file *file)
> >  {
> > -	struct netfs_cache_resources cres;
> > -	struct fscache_cookie *cookie = netfs_i_cookie(&NFS_I(inode)->netfs);
> > -	struct iov_iter iter;
> > -	struct bio_vec bvec[1];
> > -	int ret;
> > -
> > -	memset(&cres, 0, sizeof(cres));
> > -	bvec[0].bv_page		= page;
> > -	bvec[0].bv_offset	= 0;
> > -	bvec[0].bv_len		= PAGE_SIZE;
> > -	iov_iter_bvec(&iter, READ, bvec, ARRAY_SIZE(bvec), PAGE_SIZE);
> > -
> > -	ret = fscache_begin_read_operation(&cres, cookie);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	ret = fscache_read(&cres, page_offset(page), &iter, NETFS_READ_HOLE_FAIL,
> > -			   NULL, NULL);
> > -	fscache_end_operation(&cres);
> > -	return ret;
> > +	struct nfs_open_context *ctx;
> > +
> > +	if (file == NULL) {
> > +		ctx = nfs_find_open_context(rreq->inode, NULL, FMODE_READ);
> > +		if (!ctx)
> > +			return -ENOMEM;
> 
> That error return seems like an odd choice. A NULL return here just
> means that we don't have a suitable open file, not that we're out of
> memory.
> 
> I think a NULL file pointer from netfs can only happen in readahead, and
> the comments over readahead_control say:
> 
>  * @file: The file, used primarily by network filesystems for authentication.
>  *        May be NULL if invoked internally by the filesystem.
> 
> AFAICT though, only f2fs and ext4 invoke it internally.
> 
> Maybe instead of doing this, it ought to just throw a WARN if we get a
> NULL file pointer and return -EINVAL or something?
> 
> Willy, am I correct on when ractl->file can be NULL?

Yes.  Just to quickly verify it:

$ git grep -w DEFINE_READAHEAD
fs/ext4/verity.c:       DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
fs/f2fs/file.c: DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, page_idx);
fs/f2fs/verity.c:       DEFINE_READAHEAD(ractl, NULL, NULL, inode->i_mapping, index);
fs/netfs/buffered_read.c:       DEFINE_READAHEAD(ractl, file, NULL, mapping, index);
fs/verity/enable.c:     DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, index);
include/linux/pagemap.h:#define DEFINE_READAHEAD(ractl, f, r, m, i)                             \
include/linux/pagemap.h:        DEFINE_READAHEAD(ractl, file, ra, mapping, index);
include/linux/pagemap.h:        DEFINE_READAHEAD(ractl, file, ra, mapping, index);
mm/filemap.c:   DEFINE_READAHEAD(ractl, file, &file->f_ra, mapping, folio->index);
mm/filemap.c:   DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
mm/filemap.c:   DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
mm/internal.h:  DEFINE_READAHEAD(ractl, file, &file->f_ra, mapping, index);

Those two uses in pagemap.h are wrappers, so we need to check their
callers too:

$ git grep 'page_cache_\(a\)*sync_readahead'
mm/filemap.c:           page_cache_sync_readahead(mapping, ra, filp, index,
mm/khugepaged.c:                                page_cache_sync_readahead(mapping, &file->f_ra,
(ignoring the ones inside filesystems)

So yes, they all pass in a real struct file.  I wouldn't even check
whether the file pointer is NULL; just assume that it's not and the
crash will be obvious to debug.
