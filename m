Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAC84878F6
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jan 2022 15:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiAGObW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Fri, 7 Jan 2022 09:31:22 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:46071 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiAGObW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jan 2022 09:31:22 -0500
Received: by mail-yb1-f182.google.com with SMTP id o185so4179136ybc.12
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jan 2022 06:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pwKFmSY3OKkXT1hgdW3iS6mMuA62aU7cNxKqGrfxNT4=;
        b=r7HOzS5FT9fohimfvllkmt9E0u7QLPWRIdwD+L8zmaY4WnbfU5VApWQ7PfGAHD3yb7
         78YARQON5b8vtwq3CBm+sEw9ATaPHsfcJwAMset9hYyIgrzzRF/P4Uet0CHSYwiskVsH
         eLvWKITK3Itd5Qi4wNCcBSUupu/m3jAEOGwydwj2r/IoIL5dMoAnnQkCNUQ2sHpKOuQk
         curdJ9M1wyBvTSg00nz9OjH9snWIALAzE/KGeptxBOa0pdiuaaLwU74Nb+V9ibkXRWUk
         BeQkjmVBcBWog0na4Kag5JytuHAOZjrUp3Y+3S752RPaVly4XnmpHXEB/QQ2PWJSvndv
         bumA==
X-Gm-Message-State: AOAM530pdya50eBqNYN+ypX3A/fVZ1IW3cpUyh5kIWFlBdoRqoHcrjbC
        nhCE8dDpHBboGYaYZflxETpV3Ahj3+tkqEo+U6BSLp1rlaA=
X-Google-Smtp-Source: ABdhPJwht9rGoDV8+fpg8H4Sn9sE2zlrUA4xh00a1bnTK/AE7jksFBApVOkuBaq0IAxYfF518TbxuykayEZZuYF8McU=
X-Received: by 2002:a25:7791:: with SMTP id s139mr62431961ybc.26.1641565881548;
 Fri, 07 Jan 2022 06:31:21 -0800 (PST)
MIME-Version: 1.0
References: <20211227190504.309612-1-trondmy@kernel.org> <20211227190504.309612-2-trondmy@kernel.org>
 <20211227190504.309612-3-trondmy@kernel.org> <20211227190504.309612-4-trondmy@kernel.org>
 <20211227190504.309612-5-trondmy@kernel.org> <20211227190504.309612-6-trondmy@kernel.org>
 <20211227190504.309612-7-trondmy@kernel.org> <CAFX2JfnXtm90Tn7Y4h04Ca+fxqxjesP1CjOpEHOKBRVPNPum5A@mail.gmail.com>
In-Reply-To: <CAFX2JfnXtm90Tn7Y4h04Ca+fxqxjesP1CjOpEHOKBRVPNPum5A@mail.gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Fri, 7 Jan 2022 09:31:05 -0500
Message-ID: <CAFX2Jfn-yQcGgTuU_09LMdQaVXOA7H7jBEJCZ=jVnSGmruJP1Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] NFSv4: Support the offline bit
To:     trondmy@kernel.org
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Jan 7, 2022 at 9:23 AM Anna Schumaker <anna.schumaker@netapp.com> wrote:
>
> Hi Trond,
>
> On Tue, Dec 28, 2021 at 3:03 AM <trondmy@kernel.org> wrote:
> >
> > From: Trond Myklebust <trond.myklebust@primarydata.com>
> >
> > Add tracking of the NFSv4 'offline' attribute.
> >
> > Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
> > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > ---
> >  fs/nfs/inode.c          | 11 +++++++++++
> >  fs/nfs/nfs4proc.c       |  6 ++++++
> >  fs/nfs/nfs4trace.h      |  3 ++-
> >  fs/nfs/nfs4xdr.c        | 31 ++++++++++++++++++++++++++++++-
> >  include/linux/nfs4.h    |  1 +
> >  include/linux/nfs_fs.h  |  1 +
> >  include/linux/nfs_xdr.h |  5 ++++-
> >  7 files changed, 55 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 4673b091ea31..33f4410190b6 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -528,6 +528,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
> >                 nfsi->archive = 0;
> >                 nfsi->hidden = 0;
> >                 nfsi->system = 0;
> > +               nfsi->offline = 0;
> >                 inode_set_iversion_raw(inode, 0);
> >                 inode->i_size = 0;
> >                 clear_nlink(inode);
> > @@ -606,6 +607,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
> >                 } else if (fattr_supported & NFS_ATTR_FATTR_SPACE_USED &&
> >                            fattr->size != 0)
> >                         nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
> > +               if (fattr->valid & NFS_ATTR_FATTR_OFFLINE)
> > +                       nfsi->offline = (fattr->hsa_flags & NFS_HSA_OFFLINE) ? 1 : 0;
> > +               else if (fattr_supported & NFS_ATTR_FATTR_OFFLINE)
> > +                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_WINATTR);
> >
> >                 nfs_setsecurity(inode, fattr);
> >
> > @@ -2274,6 +2279,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
> >                 nfsi->cache_validity |=
> >                         save_cache_validity & NFS_INO_INVALID_BLOCKS;
> >
> > +       if (fattr->valid & NFS_ATTR_FATTR_OFFLINE)
> > +               nfsi->offline = (fattr->hsa_flags & NFS_HSA_OFFLINE) ? 1 : 0;
> > +       else if (fattr_supported & NFS_ATTR_FATTR_OFFLINE)
> > +               nfsi->cache_validity |=
> > +                       save_cache_validity & NFS_INO_INVALID_WINATTR;
> > +
> >         /* Update attrtimeo value if we're out of the unstable period */
> >         if (attr_changed) {
> >                 nfs_inc_stats(inode, NFSIOS_ATTRINVALIDATE);
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 4e6cc54016ba..713a71fb3020 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -219,6 +219,7 @@ const u32 nfs4_fattr_bitmap[3] = {
> >  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
> >         FATTR4_WORD2_SECURITY_LABEL
> >  #endif
> > +       | FATTR4_WORD2_OFFLINE
> >  };
>
> This won't compile if CONFIG_NFS_V4_SECURITY_LABEL=n:
>
> fs/nfs/nfs4proc.c:218:9: error: expected expression before ‘|’ token
>   218 |         | FATTR4_WORD2_OFFLINE
>       |         ^
> make[2]: *** [scripts/Makefile.build:287: fs/nfs/nfs4proc.o] Error 1
> make[1]: *** [scripts/Makefile.build:549: fs/nfs] Error 2
> make: *** [Makefile:1846: fs] Error 2
> make: *** Waiting for unfinished jobs....

I can fix it up by doing:

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5d3dd647dbf6..9bd7a785eb1b 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -212,10 +212,10 @@ const u32 nfs4_fattr_bitmap[3] = {
        | FATTR4_WORD1_TIME_METADATA
        | FATTR4_WORD1_TIME_MODIFY
        | FATTR4_WORD1_MOUNTED_ON_FILEID,
+       FATTR4_WORD2_OFFLINE
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
-       FATTR4_WORD2_SECURITY_LABEL
+       | FATTR4_WORD2_SECURITY_LABEL
 #endif
-       | FATTR4_WORD2_OFFLINE
 };

 static const u32 nfs4_pnfs_open_bitmap[3] = {

If that works for you I can squash it into your patch in my tree

Anna

>
> Anna
>
> >
> >  static const u32 nfs4_pnfs_open_bitmap[3] = {
> > @@ -245,6 +246,7 @@ static const u32 nfs4_pnfs_open_bitmap[3] = {
> >  #ifdef CONFIG_NFS_V4_SECURITY_LABEL
> >         | FATTR4_WORD2_SECURITY_LABEL
> >  #endif
> > +       | FATTR4_WORD2_OFFLINE
> >  };
> >
> >  static const u32 nfs4_open_noattr_bitmap[3] = {
> > @@ -325,6 +327,7 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
> >         if (!(cache_validity & NFS_INO_INVALID_WINATTR)) {
> >                 dst[0] &= ~(FATTR4_WORD0_ARCHIVE | FATTR4_WORD0_HIDDEN);
> >                 dst[1] &= ~(FATTR4_WORD1_SYSTEM | FATTR4_WORD1_TIME_BACKUP);
> > +               dst[2] &= ~FATTR4_WORD2_OFFLINE;
> >         }
> >  }
> >
> > @@ -3927,6 +3930,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
> >                 memcpy(server->attr_bitmask_nl, res.attr_bitmask,
> >                                 sizeof(server->attr_bitmask));
> >                 server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
> > +               if (!(res.attr_bitmask[2] & FATTR4_WORD2_OFFLINE))
> > +                       server->fattr_valid &= ~NFS_ATTR_FATTR_OFFLINE;
> >
> >                 memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
> >                 server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
> > @@ -5486,6 +5491,7 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
> >         if (cache_validity & NFS_INO_INVALID_WINATTR) {
> >                 bitmask[0] |= FATTR4_WORD0_ARCHIVE | FATTR4_WORD0_HIDDEN;
> >                 bitmask[1] |= FATTR4_WORD1_SYSTEM | FATTR4_WORD1_TIME_BACKUP;
> > +               bitmask[2] |= FATTR4_WORD2_OFFLINE;
> >         }
> >
> >         if (cache_validity & NFS_INO_INVALID_SIZE)
> > diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
> > index 5e72639b469e..02c78d66c36d 100644
> > --- a/fs/nfs/nfs4trace.h
> > +++ b/fs/nfs/nfs4trace.h
> > @@ -35,7 +35,8 @@
> >                 { NFS_ATTR_FATTR_HIDDEN, "HIDDEN" }, \
> >                 { NFS_ATTR_FATTR_SYSTEM, "SYSTEM" }, \
> >                 { NFS_ATTR_FATTR_ARCHIVE, "ARCHIVE" }, \
> > -               { NFS_ATTR_FATTR_TIME_BACKUP, "TIME_BACKUP" })
> > +               { NFS_ATTR_FATTR_TIME_BACKUP, "TIME_BACKUP" }, \
> > +               { NFS_ATTR_FATTR_OFFLINE, "OFFLINE" })
> >
> >  DECLARE_EVENT_CLASS(nfs4_clientid_event,
> >                 TP_PROTO(
> > diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
> > index 280df43c5bf2..a45872f860ec 100644
> > --- a/fs/nfs/nfs4xdr.c
> > +++ b/fs/nfs/nfs4xdr.c
> > @@ -1623,7 +1623,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
> >                             FATTR4_WORD1_TIME_CREATE |
> >                             FATTR4_WORD1_TIME_METADATA |
> >                             FATTR4_WORD1_TIME_MODIFY;
> > -               attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
> > +               attrs[2] |= FATTR4_WORD2_SECURITY_LABEL | FATTR4_WORD2_OFFLINE;
> >                 dircount >>= 1;
> >         }
> >         /* Use mounted_on_fileid only if the server supports it */
> > @@ -4354,6 +4354,29 @@ static int decode_attr_xattrsupport(struct xdr_stream *xdr, uint32_t *bitmap,
> >         return 0;
> >  }
> >
> > +static int decode_attr_offline(struct xdr_stream *xdr, uint32_t *bitmap,
> > +                              uint32_t *res, uint64_t *flags)
> > +{
> > +       int status = 0;
> > +       __be32 *p;
> > +
> > +       if (unlikely(bitmap[2] & (FATTR4_WORD2_OFFLINE - 1U)))
> > +               return -EIO;
> > +       if (likely(bitmap[2] & FATTR4_WORD2_OFFLINE)) {
> > +               p = xdr_inline_decode(xdr, 4);
> > +               if (unlikely(!p))
> > +                       return -EIO;
> > +               if (be32_to_cpup(p))
> > +                       *res |= NFS_HSA_OFFLINE;
> > +               else
> > +                       *res &= ~NFS_HSA_OFFLINE;
> > +               bitmap[2] &= ~FATTR4_WORD2_OFFLINE;
> > +               *flags |= NFS_ATTR_FATTR_OFFLINE;
> > +       }
> > +       dprintk("%s: system file: =%s\n", __func__, (*res & NFS_HSA_OFFLINE) == 0 ? "false" : "true");
> > +       return status;
> > +}
> > +
> >  static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t attrlen)
> >  {
> >         unsigned int attrwords = XDR_QUADLEN(attrlen);
> > @@ -4842,6 +4865,12 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
> >                 fattr->valid |= status;
> >         }
> >
> > +       status = decode_attr_offline(xdr, bitmap, &fattr->hsa_flags,
> > +                                    &fattr->valid);
> > +       if (status < 0)
> > +               goto xdr_error;
> > +
> > +       status = 0;
> >  xdr_error:
> >         dprintk("%s: xdr returned %d\n", __func__, -status);
> >         return status;
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index 5662d8be04eb..817b349c24ca 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -460,6 +460,7 @@ enum lock_type4 {
> >  #define FATTR4_WORD2_SECURITY_LABEL     (1UL << 16)
> >  #define FATTR4_WORD2_MODE_UMASK                (1UL << 17)
> >  #define FATTR4_WORD2_XATTR_SUPPORT     (1UL << 18)
> > +#define FATTR4_WORD2_OFFLINE           (1UL << 19)
> >
> >  /* MDS threshold bitmap bits */
> >  #define THRESHOLD_RD                    (1UL << 0)
> > diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> > index 1839fed16b18..61f852ebb0a4 100644
> > --- a/include/linux/nfs_fs.h
> > +++ b/include/linux/nfs_fs.h
> > @@ -148,6 +148,7 @@ struct nfs_inode {
> >         unsigned char           archive : 1;
> >         unsigned char           hidden : 1;
> >         unsigned char           system : 1;
> > +       unsigned char           offline : 1;
> >
> >         /*
> >          * read_cache_jiffies is when we started read-caching this inode.
> > diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> > index dedc7e0bf2b9..f5588bc22cb1 100644
> > --- a/include/linux/nfs_xdr.h
> > +++ b/include/linux/nfs_xdr.h
> > @@ -21,6 +21,7 @@
> >  #define NFS_HSA_HIDDEN         BIT(0)
> >  #define NFS_HSA_SYSTEM         BIT(1)
> >  #define NFS_HSA_ARCHIVE                BIT(2)
> > +#define NFS_HSA_OFFLINE                BIT(3)
> >
> >  struct nfs4_string {
> >         unsigned int len;
> > @@ -119,6 +120,7 @@ struct nfs_fattr {
> >  #define NFS_ATTR_FATTR_SYSTEM           BIT_ULL(28)
> >  #define NFS_ATTR_FATTR_ARCHIVE          BIT_ULL(29)
> >  #define NFS_ATTR_FATTR_TIME_BACKUP      BIT_ULL(30)
> > +#define NFS_ATTR_FATTR_OFFLINE          BIT_ULL(31)
> >
> >  #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
> >                 | NFS_ATTR_FATTR_MODE \
> > @@ -144,7 +146,8 @@ struct nfs_fattr {
> >                 | NFS_ATTR_FATTR_SYSTEM \
> >                 | NFS_ATTR_FATTR_ARCHIVE \
> >                 | NFS_ATTR_FATTR_TIME_BACKUP \
> > -               | NFS_ATTR_FATTR_V4_SECURITY_LABEL)
> > +               | NFS_ATTR_FATTR_V4_SECURITY_LABEL \
> > +               | NFS_ATTR_FATTR_OFFLINE)
> >
> >  /*
> >   * Maximal number of supported layout drivers.
> > --
> > 2.33.1
> >
