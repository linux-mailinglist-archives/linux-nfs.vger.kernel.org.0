Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6934A2C2F88
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Nov 2020 19:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404146AbgKXSEu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 13:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404145AbgKXSEu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 13:04:50 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD658C0613D6
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 10:04:48 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id a15so21872700edy.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 10:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYMj1oDE1gOu53HFa/E0YOvvnbUndDYyU3BrZ8H2Sb8=;
        b=J6AyLMZ7OUtpgOFaKxxUhDICjbM29sjffHW3F1woG1GMlUazb8NLR0gLnfBDRd1vof
         JqI56hMqHf9co9CqhBxlsOkcpsE13GAuW1OFxE8kGFq7CEKEpH1rHTWokTZwIaUKxSsE
         Ykmzx2ISUhOfoD6oetiYVRF2vd/FTQe8TQ1d/Ft0dLo6MEC3ixXYRNoyUgZB6QBIE4dI
         aT0LleH1c3gENnewnYplO0SmqGlBUS7yEb/YITNcJVgth1dt4B01CTVSuKqesD9iRjfz
         NzmGQxci9S5Scii1OOCdOZgZVAqwkAo/Ow9JkC8e9ZZZsMFJnIBl9KcK4utXZTHp763x
         Yi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYMj1oDE1gOu53HFa/E0YOvvnbUndDYyU3BrZ8H2Sb8=;
        b=JIi/71VS5gGR5pse5YOnHsFP4W3zFX6bmA3oxwleos/9iXtKSKrrSNi3G72dPU8lcb
         IPgfJNz7zZlDefHa1TS2gBI7AV30DmNUPeYjxTWZK8rvGw+yyLTpR5kvvkbQCdC25nuE
         9lF7/Bk8S8wTkWWCUGr3ZH7v5kAAmlwbCnVvOkQZ8G2BwncIzdtnAT+bFNUPVH6ADYKN
         oIzXiaRl143P+u6oPXpIMYfvRkXs+64PhdRbmCVfDT1Ix8R27UrZJOs/7KmEli6a5Voa
         xigFqfF7FDh/fMy+JIwT4RudGkUx3Hn7lxN4Q/lByK61L8ixEA6lzMhPObof8IWFFHY1
         k19g==
X-Gm-Message-State: AOAM532s5ZzE1ZW255K7n+c4MUbMGsOXjijocJsCkg1z6cMcnz+2kAgi
        WhlF9a/d8KdlFmZ1TOuqxb6AEOIjs8F/hfJdz9Y=
X-Google-Smtp-Source: ABdhPJw2UcVsngU6soAhwiEwRDrt+qklzqqFFOgXo7wOSSatJ29VhXDo/EPEn//9G9/f/BV3NVmd7MrMLH1Ew5N/fV4=
X-Received: by 2002:a50:8ada:: with SMTP id k26mr5192663edk.281.1606241087372;
 Tue, 24 Nov 2020 10:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20201124135025.1097571-1-trondmy@kernel.org> <20201124135025.1097571-2-trondmy@kernel.org>
 <20201124135025.1097571-3-trondmy@kernel.org> <20201124135025.1097571-4-trondmy@kernel.org>
 <20201124135025.1097571-5-trondmy@kernel.org> <20201124135025.1097571-6-trondmy@kernel.org>
 <CAFX2Jf=K3KEVZPiL490T2pzXvq1yyJL5fTfbaaQ383LCg4uv0Q@mail.gmail.com> <MN2PR13MB39576255BD4CC8160E020B35B8FB0@MN2PR13MB3957.namprd13.prod.outlook.com>
In-Reply-To: <MN2PR13MB39576255BD4CC8160E020B35B8FB0@MN2PR13MB3957.namprd13.prod.outlook.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 24 Nov 2020 13:04:30 -0500
Message-ID: <CAFX2Jfm+9CN_KycbieRp-mdz1zgqb=9_Nq2ZA8WuKMS2mVGi2A@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] SUNRPC: Clean up the handling of page padding in rpc_prepare_reply_pages()
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "trondmy@kernel.org" <trondmy@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 1:02 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Is that triggering the read plus code? This patch does not attempt to fix that.

Looks like it's running fsstress, so probably. I'll try again after
applying patch 9 to see if that makes a difference.

> ________________________________
> From: Anna Schumaker <schumaker.anna@gmail.com>
> Sent: Tuesday, November 24, 2020 12:52
> To: trondmy@kernel.org <trondmy@kernel.org>
> Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> Subject: Re: [PATCH v2 5/9] SUNRPC: Clean up the handling of page padding in rpc_prepare_reply_pages()
>
> Hi Trond,
>
> On Tue, Nov 24, 2020 at 8:54 AM <trondmy@kernel.org> wrote:
> >
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >
> > rpc_prepare_reply_pages() currently expects the 'hdrsize' argument to
> > contain the length of the data that we expect to want placed in the head
> > kvec plus a count of 1 word of padding that is placed after the page data.
> > This is very confusing when trying to read the code, and sometimes leads
> > to callers adding an arbitrary value of '1' just in order to satisfy the
> > requirement (whether or not the page data actually needs such padding).
> >
> > This patch aims to clarify the code by changing the 'hdrsize' argument
> > to remove that 1 word of padding. This means we need to subtract the
> > padding from all the existing callers.
>
> After applying this patch, xfstests generic/013 on NFS v4.2 gives me:
>
> umount.nfs4: /mnt/test: device is busy
> rm: cannot remove
> '/mnt/test/fsstress.161220.1/p0/d4/d8XXXXXXXXXXXXXXXXXXXXXXXXX':
> Directory not empty
> rm: cannot remove '/mnt/test/fsstress.161220.2/p3/d6XX': Directory not empty
> rm: cannot remove '/mnt/test/fsstress.161220.2/p5': Directory not empty
> rm: cannot remove '/mnt/test/fsstress.161220.2/p6/d4XXXXXXXXXX':
> Directory not empty
> rm: cannot remove
> '/mnt/test/fsstress.161220.2/pc/d2/d4XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/d13X':
> Directory not empty
> rm: cannot remove
> '/mnt/test/fsstress.161220.2/pe/d1/dcXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX':
> Directory not empty
> rm: cannot remove '/mnt/test/fsstress.161220.2/p11/d1': Directory not empty
> rm: cannot remove
> '/mnt/test/fsstress.161220.2/p9/d0XXXXXXXXXXXXXXXXX/d1XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX/d17XXXXXXXXX/d19XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX':
> Directory not empty
>
> Thanks,
> Anna
>
> >
> > Fixes: 02ef04e432ba ("NFS: Account for XDR pad of buf->pages")
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  fs/nfs/nfs2xdr.c  | 19 ++++++++++---------
> >  fs/nfs/nfs3xdr.c  | 29 ++++++++++++++++-------------
> >  fs/nfs/nfs4xdr.c  | 36 +++++++++++++++++++-----------------
> >  net/sunrpc/clnt.c |  5 +----
> >  net/sunrpc/xdr.c  |  3 ---
> >  5 files changed, 46 insertions(+), 46 deletions(-)
> >
> > diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
> > index f6676af37d5d..7fba7711e6b3 100644
> > --- a/fs/nfs/nfs2xdr.c
> > +++ b/fs/nfs/nfs2xdr.c
> > @@ -34,6 +34,7 @@
> >   * Declare the space requirements for NFS arguments and replies as
> >   * number of 32bit-words
> >   */
> > +#define NFS_pagepad_sz         (1) /* Page padding */
> >  #define NFS_fhandle_sz         (8)
> >  #define NFS_sattr_sz           (8)
> >  #define NFS_filename_sz                (1+(NFS2_MAXNAMLEN>>2))
> > @@ -56,11 +57,11 @@
> >
> >  #define NFS_attrstat_sz                (1+NFS_fattr_sz)
> >  #define NFS_diropres_sz                (1+NFS_fhandle_sz+NFS_fattr_sz)
> > -#define NFS_readlinkres_sz     (2+1)
> > -#define NFS_readres_sz         (1+NFS_fattr_sz+1+1)
> > +#define NFS_readlinkres_sz     (2+NFS_pagepad_sz)
> > +#define NFS_readres_sz         (1+NFS_fattr_sz+1+NFS_pagepad_sz)
> >  #define NFS_writeres_sz         (NFS_attrstat_sz)
> >  #define NFS_stat_sz            (1)
> > -#define NFS_readdirres_sz      (1+1)
> > +#define NFS_readdirres_sz      (1+NFS_pagepad_sz)
> >  #define NFS_statfsres_sz       (1+NFS_info_sz)
> >
> >  static int nfs_stat_to_errno(enum nfs_stat);
> > @@ -592,8 +593,8 @@ static void nfs2_xdr_enc_readlinkargs(struct rpc_rqst *req,
> >         const struct nfs_readlinkargs *args = data;
> >
> >         encode_fhandle(xdr, args->fh);
> > -       rpc_prepare_reply_pages(req, args->pages, args->pgbase,
> > -                               args->pglen, NFS_readlinkres_sz);
> > +       rpc_prepare_reply_pages(req, args->pages, args->pgbase, args->pglen,
> > +                               NFS_readlinkres_sz - NFS_pagepad_sz);
> >  }
> >
> >  /*
> > @@ -628,8 +629,8 @@ static void nfs2_xdr_enc_readargs(struct rpc_rqst *req,
> >         const struct nfs_pgio_args *args = data;
> >
> >         encode_readargs(xdr, args);
> > -       rpc_prepare_reply_pages(req, args->pages, args->pgbase,
> > -                               args->count, NFS_readres_sz);
> > +       rpc_prepare_reply_pages(req, args->pages, args->pgbase, args->count,
> > +                               NFS_readres_sz - NFS_pagepad_sz);
> >         req->rq_rcv_buf.flags |= XDRBUF_READ;
> >  }
> >
> > @@ -786,8 +787,8 @@ static void nfs2_xdr_enc_readdirargs(struct rpc_rqst *req,
> >         const struct nfs_readdirargs *args = data;
> >
> >         encode_readdirargs(xdr, args);
> > -       rpc_prepare_reply_pages(req, args->pages, 0,
> > -                               args->count, NFS_readdirres_sz);
> > +       rpc_prepare_reply_pages(req, args->pages, 0, args->count,
> > +                               NFS_readdirres_sz - NFS_pagepad_sz);
> >  }
> >
> >  /*
> > diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
> > index 69971f6c840d..ca10072644ff 100644
> > --- a/fs/nfs/nfs3xdr.c
> > +++ b/fs/nfs/nfs3xdr.c
> > @@ -33,6 +33,7 @@
> >   * Declare the space requirements for NFS arguments and replies as
> >   * number of 32bit-words
> >   */
> > +#define NFS3_pagepad_sz                (1) /* Page padding */
> >  #define NFS3_fhandle_sz                (1+16)
> >  #define NFS3_fh_sz             (NFS3_fhandle_sz)       /* shorthand */
> >  #define NFS3_sattr_sz          (15)
> > @@ -69,13 +70,13 @@
> >  #define NFS3_removeres_sz      (NFS3_setattrres_sz)
> >  #define NFS3_lookupres_sz      (1+NFS3_fh_sz+(2 * NFS3_post_op_attr_sz))
> >  #define NFS3_accessres_sz      (1+NFS3_post_op_attr_sz+1)
> > -#define NFS3_readlinkres_sz    (1+NFS3_post_op_attr_sz+1+1)
> > -#define NFS3_readres_sz                (1+NFS3_post_op_attr_sz+3+1)
> > +#define NFS3_readlinkres_sz    (1+NFS3_post_op_attr_sz+1+NFS3_pagepad_sz)
> > +#define NFS3_readres_sz                (1+NFS3_post_op_attr_sz+3+NFS3_pagepad_sz)
> >  #define NFS3_writeres_sz       (1+NFS3_wcc_data_sz+4)
> >  #define NFS3_createres_sz      (1+NFS3_fh_sz+NFS3_post_op_attr_sz+NFS3_wcc_data_sz)
> >  #define NFS3_renameres_sz      (1+(2 * NFS3_wcc_data_sz))
> >  #define NFS3_linkres_sz                (1+NFS3_post_op_attr_sz+NFS3_wcc_data_sz)
> > -#define NFS3_readdirres_sz     (1+NFS3_post_op_attr_sz+2+1)
> > +#define NFS3_readdirres_sz     (1+NFS3_post_op_attr_sz+2+NFS3_pagepad_sz)
> >  #define NFS3_fsstatres_sz      (1+NFS3_post_op_attr_sz+13)
> >  #define NFS3_fsinfores_sz      (1+NFS3_post_op_attr_sz+12)
> >  #define NFS3_pathconfres_sz    (1+NFS3_post_op_attr_sz+6)
> > @@ -85,7 +86,8 @@
> >  #define ACL3_setaclargs_sz     (NFS3_fh_sz+1+ \
> >                                 XDR_QUADLEN(NFS_ACL_INLINE_BUFSIZE))
> >  #define ACL3_getaclres_sz      (1+NFS3_post_op_attr_sz+1+ \
> > -                               XDR_QUADLEN(NFS_ACL_INLINE_BUFSIZE)+1)
> > +                               XDR_QUADLEN(NFS_ACL_INLINE_BUFSIZE)+\
> > +                               NFS3_pagepad_sz)
> >  #define ACL3_setaclres_sz      (1+NFS3_post_op_attr_sz)
> >
> >  static int nfs3_stat_to_errno(enum nfs_stat);
> > @@ -909,8 +911,8 @@ static void nfs3_xdr_enc_readlink3args(struct rpc_rqst *req,
> >         const struct nfs3_readlinkargs *args = data;
> >
> >         encode_nfs_fh3(xdr, args->fh);
> > -       rpc_prepare_reply_pages(req, args->pages, args->pgbase,
> > -                               args->pglen, NFS3_readlinkres_sz);
> > +       rpc_prepare_reply_pages(req, args->pages, args->pgbase, args->pglen,
> > +                               NFS3_readlinkres_sz - NFS3_pagepad_sz);
> >  }
> >
> >  /*
> > @@ -939,7 +941,8 @@ static void nfs3_xdr_enc_read3args(struct rpc_rqst *req,
> >                                    const void *data)
> >  {
> >         const struct nfs_pgio_args *args = data;
> > -       unsigned int replen = args->replen ? args->replen : NFS3_readres_sz;
> > +       unsigned int replen = args->replen ? args->replen :
> > +                                            NFS3_readres_sz - NFS3_pagepad_sz;
> >
> >         encode_read3args(xdr, args);
> >         rpc_prepare_reply_pages(req, args->pages, args->pgbase,
> > @@ -1239,8 +1242,8 @@ static void nfs3_xdr_enc_readdir3args(struct rpc_rqst *req,
> >         const struct nfs3_readdirargs *args = data;
> >
> >         encode_readdir3args(xdr, args);
> > -       rpc_prepare_reply_pages(req, args->pages, 0,
> > -                               args->count, NFS3_readdirres_sz);
> > +       rpc_prepare_reply_pages(req, args->pages, 0, args->count,
> > +                               NFS3_readdirres_sz - NFS3_pagepad_sz);
> >  }
> >
> >  /*
> > @@ -1281,8 +1284,8 @@ static void nfs3_xdr_enc_readdirplus3args(struct rpc_rqst *req,
> >         const struct nfs3_readdirargs *args = data;
> >
> >         encode_readdirplus3args(xdr, args);
> > -       rpc_prepare_reply_pages(req, args->pages, 0,
> > -                               args->count, NFS3_readdirres_sz);
> > +       rpc_prepare_reply_pages(req, args->pages, 0, args->count,
> > +                               NFS3_readdirres_sz - NFS3_pagepad_sz);
> >  }
> >
> >  /*
> > @@ -1328,7 +1331,7 @@ static void nfs3_xdr_enc_getacl3args(struct rpc_rqst *req,
> >         if (args->mask & (NFS_ACL | NFS_DFACL)) {
> >                 rpc_prepare_reply_pages(req, args->pages, 0,
> >                                         NFSACL_MAXPAGES << PAGE_SHIFT,
> > -                                       ACL3_getaclres_sz);
> > +                                       ACL3_getaclres_sz - NFS3_pagepad_sz);
> >                 req->rq_rcv_buf.flags |= XDRBUF_SPARSE_PAGES;
> >         }
> >  }
> > @@ -1648,7 +1651,7 @@ static int nfs3_xdr_dec_read3res(struct rpc_rqst *req, struct xdr_stream *xdr,
> >         result->op_status = status;
> >         if (status != NFS3_OK)
> >                 goto out_status;
> > -       result->replen = 4 + ((xdr_stream_pos(xdr) - pos) >> 2);
> > +       result->replen = 3 + ((xdr_stream_pos(xdr) - pos) >> 2);
> >         error = decode_read3resok(xdr, result);
> >  out:
> >         return error;
> > diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> > index c16b93df1bc1..3899ef3047f4 100644
> > --- a/fs/nfs/nfs4xdr.c
> > +++ b/fs/nfs/nfs4xdr.c
> > @@ -84,6 +84,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
> >  /* lock,open owner id:
> >   * we currently use size 2 (u64) out of (NFS4_OPAQUE_LIMIT  >> 2)
> >   */
> > +#define pagepad_maxsz          (1)
> >  #define open_owner_id_maxsz    (1 + 2 + 1 + 1 + 2)
> >  #define lock_owner_id_maxsz    (1 + 1 + 4)
> >  #define decode_lockowner_maxsz (1 + XDR_QUADLEN(IDMAP_NAMESZ))
> > @@ -215,14 +216,14 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
> >                                  nfs4_fattr_bitmap_maxsz)
> >  #define encode_read_maxsz      (op_encode_hdr_maxsz + \
> >                                  encode_stateid_maxsz + 3)
> > -#define decode_read_maxsz      (op_decode_hdr_maxsz + 2 + 1)
> > +#define decode_read_maxsz      (op_decode_hdr_maxsz + 2 + pagepad_maxsz)
> >  #define encode_readdir_maxsz   (op_encode_hdr_maxsz + \
> >                                  2 + encode_verifier_maxsz + 5 + \
> >                                 nfs4_label_maxsz)
> >  #define decode_readdir_maxsz   (op_decode_hdr_maxsz + \
> > -                                decode_verifier_maxsz + 1)
> > +                                decode_verifier_maxsz + pagepad_maxsz)
> >  #define encode_readlink_maxsz  (op_encode_hdr_maxsz)
> > -#define decode_readlink_maxsz  (op_decode_hdr_maxsz + 1 + 1)
> > +#define decode_readlink_maxsz  (op_decode_hdr_maxsz + 1 + pagepad_maxsz)
> >  #define encode_write_maxsz     (op_encode_hdr_maxsz + \
> >                                  encode_stateid_maxsz + 4)
> >  #define decode_write_maxsz     (op_decode_hdr_maxsz + \
> > @@ -284,14 +285,14 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
> >  #define decode_delegreturn_maxsz (op_decode_hdr_maxsz)
> >  #define encode_getacl_maxsz    (encode_getattr_maxsz)
> >  #define decode_getacl_maxsz    (op_decode_hdr_maxsz + \
> > -                                nfs4_fattr_bitmap_maxsz + 1 + 1)
> > +                                nfs4_fattr_bitmap_maxsz + 1 + pagepad_maxsz)
> >  #define encode_setacl_maxsz    (op_encode_hdr_maxsz + \
> >                                  encode_stateid_maxsz + 3)
> >  #define decode_setacl_maxsz    (decode_setattr_maxsz)
> >  #define encode_fs_locations_maxsz \
> >                                 (encode_getattr_maxsz)
> >  #define decode_fs_locations_maxsz \
> > -                               (1)
> > +                               (pagepad_maxsz)
> >  #define encode_secinfo_maxsz   (op_encode_hdr_maxsz + nfs4_name_maxsz)
> >  #define decode_secinfo_maxsz   (op_decode_hdr_maxsz + 1 + ((NFS_MAX_SECFLAVORS * (16 + GSS_OID_MAX_LEN)) / 4))
> >
> > @@ -393,12 +394,13 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
> >                                   /* devaddr4 payload is read into page */ \
> >                                 1 /* notification bitmap length */ + \
> >                                 1 /* notification bitmap, word 0 */ + \
> > -                               1 /* possible XDR padding */)
> > +                               pagepad_maxsz /* possible XDR padding */)
> >  #define encode_layoutget_maxsz (op_encode_hdr_maxsz + 10 + \
> >                                 encode_stateid_maxsz)
> >  #define decode_layoutget_maxsz (op_decode_hdr_maxsz + 8 + \
> >                                 decode_stateid_maxsz + \
> > -                               XDR_QUADLEN(PNFS_LAYOUT_MAXSIZE) + 1)
> > +                               XDR_QUADLEN(PNFS_LAYOUT_MAXSIZE) + \
> > +                               pagepad_maxsz)
> >  #define encode_layoutcommit_maxsz (op_encode_hdr_maxsz +          \
> >                                 2 /* offset */ + \
> >                                 2 /* length */ + \
> > @@ -2342,7 +2344,7 @@ static void nfs4_xdr_enc_open(struct rpc_rqst *req, struct xdr_stream *xdr,
> >                 encode_layoutget(xdr, args->lg_args, &hdr);
> >                 rpc_prepare_reply_pages(req, args->lg_args->layout.pages, 0,
> >                                         args->lg_args->layout.pglen,
> > -                                       hdr.replen);
> > +                                       hdr.replen - pagepad_maxsz);
> >         }
> >         encode_nops(&hdr);
> >  }
> > @@ -2388,7 +2390,7 @@ static void nfs4_xdr_enc_open_noattr(struct rpc_rqst *req,
> >                 encode_layoutget(xdr, args->lg_args, &hdr);
> >                 rpc_prepare_reply_pages(req, args->lg_args->layout.pages, 0,
> >                                         args->lg_args->layout.pglen,
> > -                                       hdr.replen);
> > +                                       hdr.replen - pagepad_maxsz);
> >         }
> >         encode_nops(&hdr);
> >  }
> > @@ -2499,7 +2501,7 @@ static void nfs4_xdr_enc_readlink(struct rpc_rqst *req, struct xdr_stream *xdr,
> >         encode_readlink(xdr, args, req, &hdr);
> >
> >         rpc_prepare_reply_pages(req, args->pages, args->pgbase,
> > -                               args->pglen, hdr.replen);
> > +                               args->pglen, hdr.replen - pagepad_maxsz);
> >         encode_nops(&hdr);
> >  }
> >
> > @@ -2520,7 +2522,7 @@ static void nfs4_xdr_enc_readdir(struct rpc_rqst *req, struct xdr_stream *xdr,
> >         encode_readdir(xdr, args, req, &hdr);
> >
> >         rpc_prepare_reply_pages(req, args->pages, args->pgbase,
> > -                               args->count, hdr.replen);
> > +                               args->count, hdr.replen - pagepad_maxsz);
> >         encode_nops(&hdr);
> >  }
> >
> > @@ -2541,7 +2543,7 @@ static void nfs4_xdr_enc_read(struct rpc_rqst *req, struct xdr_stream *xdr,
> >         encode_read(xdr, args, &hdr);
> >
> >         rpc_prepare_reply_pages(req, args->pages, args->pgbase,
> > -                               args->count, hdr.replen);
> > +                               args->count, hdr.replen - pagepad_maxsz);
> >         req->rq_rcv_buf.flags |= XDRBUF_READ;
> >         encode_nops(&hdr);
> >  }
> > @@ -2588,7 +2590,7 @@ static void nfs4_xdr_enc_getacl(struct rpc_rqst *req, struct xdr_stream *xdr,
> >                         ARRAY_SIZE(nfs4_acl_bitmap), &hdr);
> >
> >         rpc_prepare_reply_pages(req, args->acl_pages, 0,
> > -                               args->acl_len, replen + 1);
> > +                               args->acl_len, replen);
> >         encode_nops(&hdr);
> >  }
> >
> > @@ -2810,7 +2812,7 @@ static void nfs4_xdr_enc_fs_locations(struct rpc_rqst *req,
> >         }
> >
> >         rpc_prepare_reply_pages(req, (struct page **)&args->page, 0,
> > -                               PAGE_SIZE, replen + 1);
> > +                               PAGE_SIZE, replen);
> >         encode_nops(&hdr);
> >  }
> >
> > @@ -3014,14 +3016,14 @@ static void nfs4_xdr_enc_getdeviceinfo(struct rpc_rqst *req,
> >         encode_compound_hdr(xdr, req, &hdr);
> >         encode_sequence(xdr, &args->seq_args, &hdr);
> >
> > -       replen = hdr.replen + op_decode_hdr_maxsz;
> > +       replen = hdr.replen + op_decode_hdr_maxsz + 2;
> >
> >         encode_getdeviceinfo(xdr, args, &hdr);
> >
> >         /* set up reply kvec. device_addr4 opaque data is read into the
> >          * pages */
> >         rpc_prepare_reply_pages(req, args->pdev->pages, args->pdev->pgbase,
> > -                               args->pdev->pglen, replen + 2 + 1);
> > +                               args->pdev->pglen, replen);
> >         encode_nops(&hdr);
> >  }
> >
> > @@ -3043,7 +3045,7 @@ static void nfs4_xdr_enc_layoutget(struct rpc_rqst *req,
> >         encode_layoutget(xdr, args, &hdr);
> >
> >         rpc_prepare_reply_pages(req, args->layout.pages, 0,
> > -                               args->layout.pglen, hdr.replen);
> > +                               args->layout.pglen, hdr.replen - pagepad_maxsz);
> >         encode_nops(&hdr);
> >  }
> >
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index 3259120462ed..612f0a641f4c 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -1251,10 +1251,7 @@ void rpc_prepare_reply_pages(struct rpc_rqst *req, struct page **pages,
> >                              unsigned int base, unsigned int len,
> >                              unsigned int hdrsize)
> >  {
> > -       /* Subtract one to force an extra word of buffer space for the
> > -        * payload's XDR pad to fall into the rcv_buf's tail iovec.
> > -        */
> > -       hdrsize += RPC_REPHDRSIZE + req->rq_cred->cr_auth->au_ralign - 1;
> > +       hdrsize += RPC_REPHDRSIZE + req->rq_cred->cr_auth->au_ralign;
> >
> >         xdr_inline_pages(&req->rq_rcv_buf, hdrsize << 2, pages, base, len);
> >         trace_rpc_xdr_reply_pages(req->rq_task, &req->rq_rcv_buf);
> > diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
> > index 3ce0a5daa9eb..5a450055469f 100644
> > --- a/net/sunrpc/xdr.c
> > +++ b/net/sunrpc/xdr.c
> > @@ -193,9 +193,6 @@ xdr_inline_pages(struct xdr_buf *xdr, unsigned int offset,
> >
> >         tail->iov_base = buf + offset;
> >         tail->iov_len = buflen - offset;
> > -       if ((xdr->page_len & 3) == 0)
> > -               tail->iov_len -= sizeof(__be32);
> > -
> >         xdr->buflen += len;
> >  }
> >  EXPORT_SYMBOL_GPL(xdr_inline_pages);
> > --
> > 2.28.0
> >
