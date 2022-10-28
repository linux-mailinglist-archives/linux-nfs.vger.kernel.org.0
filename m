Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B7E611885
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 18:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiJ1Q7l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 28 Oct 2022 12:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJ1Q7R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 12:59:17 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF7D201BF
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 09:59:15 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id n191so5054077iod.13
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 09:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+c0RrXob86GQMOgizni3Jp+3zaFITWpeDgo3UiqSg0=;
        b=5uXOUwxGoTm0v+NSIKD3zXTa7yGeiffQIDlorB9RbmD3yvMtVrZ8Rx5es3j1srrOYP
         yq4iBzYKDtbIHVJ84oAr9uLMojw9VaquFBMh0IqEMx8EdUaozKz1S9ii1ZkPyQFghSjV
         6Rwdso7kd0Qjw3YufDsm5ipZCqsyc3k4rq6oB72RPNeFmZdPmd4D/yI34giUvSaZcoh8
         ticHQ2x/HjRGFCuc+B2r65ghxnHGqn2pFwtx9p5Eb6mf4N4+N0lZrurxZ757qXmcQifH
         tKg40NDxeeFQ4PA9vUKBNuU2UU+Oss4dUkMlNvjKbKURfBWRjP/MrtnadYMVKzF1yzm1
         Sf9w==
X-Gm-Message-State: ACrzQf1QwC43/L1x2ioKt0B2O6Ewnv2JsGdFBrtrKFHov7HmFBihGL2Y
        SdHyQ/mD8fBVHbKkqkipcjSDa1FThg==
X-Google-Smtp-Source: AMsMyM4EzC+N29Wk2WNLPcWAoRAU/08L4/IvIrjOZ/P7COIe2VnCCc8s1RIDFY4Z79lNOQfmTMN20w==
X-Received: by 2002:a02:a1c5:0:b0:372:d180:fbc1 with SMTP id o5-20020a02a1c5000000b00372d180fbc1mr211122jah.297.1666976354079;
        Fri, 28 Oct 2022 09:59:14 -0700 (PDT)
Received: from [192.168.75.138] (50-36-85-28.alma.mi.frontiernet.net. [50.36.85.28])
        by smtp.gmail.com with ESMTPSA id r20-20020a92c5b4000000b002f584a19a79sm1774172ilt.34.2022.10.28.09.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:59:13 -0700 (PDT)
Message-ID: <0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org>
Subject: Re: [PATCH v9 3/5] NFS: Convert buffered read paths to use netfs
 when fscache is enabled
From:   Trond Myklebust <trondmy@kernel.org>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Date:   Fri, 28 Oct 2022 12:59:12 -0400
In-Reply-To: <CALF+zOm+-2QLOMu4J7NAK++xfjZ8SQqmMh8zNFcM2H78_qYAzA@mail.gmail.com>
References: <20221017105212.77588-1-dwysocha@redhat.com>
         <20221017105212.77588-4-dwysocha@redhat.com>
         <870684b35a45b94c426554a62b63f80f421dbb08.camel@kernel.org>
         <CALF+zOm+-2QLOMu4J7NAK++xfjZ8SQqmMh8zNFcM2H78_qYAzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-10-28 at 07:50 -0400, David Wysochanski wrote:
> On Thu, Oct 27, 2022 at 3:16 PM Trond Myklebust <trondmy@kernel.org>
> wrote:
> > 
> > On Mon, 2022-10-17 at 06:52 -0400, Dave Wysochanski wrote:
> > > Convert the NFS buffered read code paths to corresponding netfs
> > > APIs,
> > > but only when fscache is configured and enabled.
> > > 
> > > The netfs API defines struct netfs_request_ops which must be
> > > filled
> > > in by the network filesystem.  For NFS, we only need to define 5
> > > of
> > > the functions, the main one being the issue_read() function.
> > > The issue_read() function is called by the netfs layer when a
> > > read
> > > cannot be fulfilled locally, and must be sent to the server
> > > (either
> > > the cache is not active, or it is active but the data is not
> > > available).
> > > Once the read from the server is complete, netfs requires a call
> > > to
> > > netfs_subreq_terminated() which conveys either how many bytes
> > > were
> > > read
> > > successfully, or an error.  Note that issue_read() is called with
> > > a
> > > structure, netfs_io_subrequest, which defines the IO requested,
> > > and
> > > contains a start and a length (both in bytes), and assumes the
> > > underlying
> > > netfs will return a either an error on the whole region, or the
> > > number
> > > of bytes successfully read.
> > > 
> > > The NFS IO path is page based and the main APIs are the pgio APIs
> > > defined
> > > in pagelist.c.  For the pgio APIs, there is no way for the caller
> > > to
> > > know how many RPCs will be sent and how the pages will be broken
> > > up
> > > into underlying RPCs, each of which will have their own
> > > completion
> > > and
> > > return code.  In contrast, netfs is subrequest based, a single
> > > subrequest may contain multiple pages, and a single subrequest is
> > > initiated with issue_read() and terminated with
> > > netfs_subreq_terminated().
> > > Thus, to utilze the netfs APIs, NFS needs some way to accommodate
> > > the netfs API requirement on the single response to the whole
> > > subrequest, while also minimizing disruptive changes to the NFS
> > > pgio layer.
> > > 
> > > The approach taken with this patch is to allocate a small
> > > structure
> > > for each nfs_netfs_issue_read() call, store the final error and
> > > number
> > > of bytes successfully transferred in the structure, and update
> > > these
> > > values
> > > as each RPC completes.  The refcount on the structure is used as
> > > a
> > > marker
> > > for the last RPC completion, is incremented in
> > > nfs_netfs_read_initiate(),
> > > and decremented inside nfs_netfs_read_completion(), when a
> > > nfs_pgio_header
> > > contains a valid pointer to the data.  On the final put (which
> > > signals
> > > the final outstanding RPC is complete) in
> > > nfs_netfs_read_completion(),
> > > call netfs_subreq_terminated() with either the final error value
> > > (if
> > > one or more READs complete with an error) or the number of bytes
> > > successfully transferred (if all RPCs complete successfully). 
> > > Note
> > > that when all RPCs complete successfully, the number of bytes
> > > transferred
> > > is capped to the length of the subrequest.  Capping the
> > > transferred
> > > length
> > > to the subrequest length prevents "Subreq overread" warnings from
> > > netfs.
> > > This is due to the "aligned_len" in nfs_pageio_add_page(), and
> > > the
> > > corner case where NFS requests a full page at the end of the
> > > file,
> > > even when i_size reflects only a partial page (NFS overread).
> > > 
> > > Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > 
> > 
> > This is not doing what I asked for, which was to separate out the
> > fscache functionality, so that we can call that if and when it is
> > available.
> > 
> I must have misunderstood then.
> 
> The last feedback I have from you was that you wanted it to be
> an opt-in feature, and it was a comment on a previous patch
> to Kconfig.  I was proceeding the best I knew how, but
> let me try to get back on track.
> 
> > Instead, it is just wrapping the NFS requests inside netfs
> > requests. As
> > it stands, that means it is just duplicating information, and
> > adding
> > unnecessary overhead to the standard I/O path (extra allocations,
> > extra
> > indirect calls, and extra bloat to the inode).
> > 
> I think I understand what you're saying but I'm not sure.  Let me
> ask some clarifying questions.
> 
> Are you objecting to the code when CONFIG_NFS_FSCACHE is
> configured?  Or when it is not?  Or both?  I think you're objecting
> when it's configured, but not enabled (we mount without 'fsc').
> Am I right?
> 
> Also, are you objecting to the design that to use fcache we now
> have to use netfs, specifically:
> - call into netfs via either netfs_read_folio or netfs_readahead
> - if fscache is enabled, then the IO can be satisfied from fscache
> - if fscache is not enabled, or some of the IO cannot be satisfied
> from the cache, then NFS is called back via netfs_issue_read
> and we use the normal NFS read pageio interface.  This requires
> we call netfs_subreq_terminated() when all the RPCs complete,
> which is the reason for the small changes to pagelist.c

I'm objecting to any middle layer "solution" that adds overhead to the
NFS I/O paths.

I'm willing to consider solutions that are specific only to the fscache
use case (i.e. when the 'fsc' mount option is specified). However when
I perform a normal NFS mount, and do I/O, then I don't want to see
extra memory allocations, extra indirect calls and larger inode
footprints.

IOW: I want the code to optimise for the case of standard NFS, not for
the case of 'NFS with cachefs additions'.

> 
> Can you be more specific as to the portions of the patch you don't
> like
> so I can move it in the right direction?
> 
> This is from patch #2 which you didn't comment on.  I'm not sure
> you're
> ok with it though, since you mention "extra bloat to the inode".
> Do you object to this even though it's wrapped in an
> #ifdef CONFIG_NFS_FSCACHE?  If so, do you require no
> extra size be added to nfs_inode?
> 
> @@ -204,9 +208,11 @@ struct nfs_inode {
>         __u64 write_io;
>         __u64 read_io;
>  #ifdef CONFIG_NFS_FSCACHE
> -       struct fscache_cookie   *fscache;
> -#endif
> +       struct netfs_inode      netfs; /* netfs context and VFS inode
> */
> +#else
>         struct inode            vfs_inode;
> +#endif
> +

Ideally, I'd prefer no extra size. I can live with it up to a certain
point, however for now NFS is not unconditionally opting into the netfs
project. If we're to ever do that, then I want to see streamlined code
for the standard I/O case.

> 
> 
> Are you ok with the stub functions which are placed in fscache.h, and
> when CONFIG_NFS_FSCACHE is not set, become either a no-op
> or a 1-liner (nfs_netfs_readpage_release)?
> 
>  #else /* CONFIG_NFS_FSCACHE */
> +static inline void nfs_netfs_inode_init(struct nfs_inode *nfsi) {}
> +static inline void nfs_netfs_initiate_read(struct nfs_pgio_header
> *hdr) {}
> +static inline void nfs_netfs_read_completion(struct nfs_pgio_header
> *hdr) {}
> +static inline void nfs_netfs_readpage_release(struct nfs_page *req)
> +{
> +       unlock_page(req->wb_page);
> +}
>  static inline void nfs_fscache_release_super_cookie(struct
> super_block *sb) {}
>  static inline void nfs_fscache_init_inode(struct inode *inode) {}
> 
> 
> Do you object to the below?  If so, then do you want
> #ifdef CONFIG_NFS_FSCACHE here?
> 
> -- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2249,6 +2249,8 @@ struct inode *nfs_alloc_inode(struct
> super_block *sb)
>  #ifdef CONFIG_NFS_V4_2
>         nfsi->xattr_cache = NULL;
>  #endif
> +       nfs_netfs_inode_init(nfsi);
> +
>         return VFS_I(nfsi);
>  }
>  EXPORT_SYMBOL_GPL(nfs_alloc_i
> node);
> 
> 
> Do you object to the changes in fs/nfs/read.c?  Specifically,
> how about the below calls to netfs from nfs_read_folio and
> nfs_readahead into equivalent netfs calls?  So when
> NFS_CONFIG_FSCACHE is set, but fscache is not enabled
> ('fsc' not on mount), these netfs functions do immediately call
> netfs_alloc_request().  But I wonder if we could simply add a
> check to see if fscache is enabled on the mount, and skip
> over to satisfy what you want.  Am I understanding what you
> want?

Quite frankly, I'd prefer that we just split out the functionality that
is needed from the netfs code so that it can be optimised. However I'm
not interested enough in the cachefs functionality to work on that
myself. ...and as I indicated above, I might be OK with opting into the
netfs project, once the overhead can be made to disappear.

> 
> @@ -355,6 +343,10 @@ int nfs_read_folio(struct file *file, struct
> folio *folio)
>         if (NFS_STALE(inode))
>                 goto out_unlock;
> 
> +       ret = nfs_netfs_read_folio(file, folio);
> +       if (!ret)
> +               goto out;
> +
> 
> @@ -405,6 +399,10 @@ void nfs_readahead(struct readahead_control
> *ractl)
>         if (NFS_STALE(inode))
>                 goto out;
> 
> +       ret = nfs_netfs_readahead(ractl);
> +       if (!ret)
> +               goto out;
> +
> 
> 
> And how about these calls from different points in the read
> path to the earlier mentioned stub functions?
> 
> @@ -110,20 +110,13 @@ EXPORT_SYMBOL_GPL(nfs_pageio_reset_read_mds);
> 
>  static void nfs_readpage_release(struct nfs_page *req, int error)
>  {
> -       struct inode *inode = d_inode(nfs_req_openctx(req)->dentry);
>         struct page *page = req->wb_page;
> 
> -       dprintk("NFS: read done (%s/%llu %d@%lld)\n", inode->i_sb-
> >s_id,
> -               (unsigned long long)NFS_FILEID(inode), req->wb_bytes,
> -               (long long)req_offset(req));
> -
>         if (nfs_error_is_fatal_on_server(error) && error != -
> ETIMEDOUT)
>                 SetPageError(page);
> -       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
> -               if (PageUptodate(page))
> -                       nfs_fscache_write_page(inode, page);
> -               unlock_page(page);
> -       }
> +       if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE))
> +               nfs_netfs_readpage_release(req);
> +

I'm not seeing the value of wrapping unlock_page(), no... That code is
going to need to change when we move it to use folios natively anyway.

>         nfs_release_request(req);
>  }
> 
> @@ -177,6 +170,8 @@ static void nfs_read_completion(struct
> nfs_pgio_header *hdr)
>                 nfs_list_remove_request(req);
>                 nfs_readpage_release(req, error);
>         }
> +       nfs_netfs_read_completion(hdr);
> +
>  out:
>         hdr->release(hdr);
>  }
> @@ -187,6 +182,7 @@ static void nfs_initiate_read(struct
> nfs_pgio_header *hdr,
>                               struct rpc_task_setup *task_setup_data,
> int how)
>  {
>         rpc_ops->read_setup(hdr, msg);
> +       nfs_netfs_initiate_read(hdr);
>         trace_nfs_initiate_read(hdr);
>  }
> 
> 
> Are you ok with these additions?  Something like this would
> be required in the case of fscache configured and enabled,
> because we could have some of the data in a read in
> fscache, and some not.  That is the reason for the netfs
> design, and why we need to be able to call the normal
> NFS read IO path (netfs calls into issue_read, and we call
> back via netfs_subreq_terminated)?
> 
> @@ -101,6 +101,9 @@ struct nfs_pageio_descriptor {
>         struct pnfs_layout_segment *pg_lseg;
>         struct nfs_io_completion *pg_io_completion;
>         struct nfs_direct_req   *pg_dreq;
> +#ifdef CONFIG_NFS_FSCACHE
> +       void                    *pg_netfs;
> +#endif
> 
> @@ -1619,6 +1619,9 @@ struct nfs_pgio_header {
>         const struct nfs_rw_ops *rw_ops;
>         struct nfs_io_completion *io_completion;
>         struct nfs_direct_req   *dreq;
> +#ifdef CONFIG_NFS_FSCACHE
> +       void                    *netfs;
> +#endif
> 
> 
> And these additions to pagelist.c?
> 
> @@ -68,6 +69,10 @@ void nfs_pgheader_init(struct
> nfs_pageio_descriptor *desc,
>         hdr->good_bytes = mirror->pg_count;
>         hdr->io_completion = desc->pg_io_completion;
>         hdr->dreq = desc->pg_dreq;
> +#ifdef CONFIG_NFS_FSCACHE
> +       if (desc->pg_netfs)
> +               hdr->netfs = desc->pg_netfs;
> +#endif

Why the conditional?

> 
> 
> @@ -846,6 +851,9 @@ void nfs_pageio_init(struct nfs_pageio_descriptor
> *desc,
>         desc->pg_lseg = NULL;
>         desc->pg_io_completion = NULL;
>         desc->pg_dreq = NULL;
> +#ifdef CONFIG_NFS_FSCACHE
> +       desc->pg_netfs = NULL;
> +#endif
> 
> 
> @@ -1360,6 +1369,9 @@ int nfs_pageio_resend(struct
> nfs_pageio_descriptor *desc,
> 
>         desc->pg_io_completion = hdr->io_completion;
>         desc->pg_dreq = hdr->dreq;
> +#ifdef CONFIG_NFS_FSCACHE
> +       desc->pg_netfs = hdr->netfs;
> +#endif

Those all need wrapper functions instead of embedding #ifdefs.

> 
> 
> > My expectation is that the standard I/O path should have minimal
> > overhead, and should certainly not increase the overhead that we
> > already have. Will this be addressed in future iterations of these
> > patches?
> > 
> 
> I will do what I can to satisfy what you want, either by fixing up
> this patch or follow-on patches.  Hopefully the above questions
> will clarify the next steps.
> 

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


