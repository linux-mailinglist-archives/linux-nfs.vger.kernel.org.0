Return-Path: <linux-nfs+bounces-3794-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75186907D71
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 22:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDCB283C62
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 20:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF3A137921;
	Thu, 13 Jun 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrFyn7pV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEB712FB09
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718310397; cv=none; b=gtJPyqklc0mmllkphd6LqUPYJDIeSqTgxVONmVmtpx9AWBWdw/UxarCz1+RqBtW7optN0Bf9q2gl8XoYRw1mq70x/zlq0Fbc/aDA5euaWs339skr1/ZNF1CLdvtNCSnaxRKzp6PMqhCUBM9cI2mlfHuGw+e7D515+/zczuYLiDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718310397; c=relaxed/simple;
	bh=K8cbpa8z7kZ/fTGk3axtj43dxVTvCPULbZV280fWFS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVB5VNnX6F+JL/5MqWI/34Uaq42LzclpjiX8+Y5y4eVl9+4MzhVkWdrFaSrRR7Phhzx8E3Pv/eCjkZHADXIoX65flbVaAfNs4m81cX1zmovZx5decfcI954aU4mEo7L+l7U7cDxyedCLQD8Ik1BS7QF1NaZj5tGqxQPFJfIMabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrFyn7pV; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-797e2834c4eso122676285a.0
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 13:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718310394; x=1718915194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GTfYOBqqrUKiO4WKadrRzdDCvzu7pV/wtkqoToCmYE=;
        b=BrFyn7pVSNSna0RbUP6uRis705t/iF4u85KyDFMKK/cOUjGOQV9r7IRigPlo3tXs1t
         Kgbif/nEm/hAn4kMWIlaxXRkHDkBX1GUB+ZbhtD/pRBt4t8+uyoyWK+9FV2fQJzUgA5Y
         hqJ5WSOqu4ZLtBI9lNwGS2KAPD/BLdu2V+DF6+uasQBMkHbdWKX9zbjPbT5w9W9yfJFv
         MvcAyBw/Wv3RY5ysvL8CYq/r9DUaFq5LEzZoHu0m79NXC7Sbk+EgDKOC9fBmUwBe7V0x
         E88kcnHhtXmrEgFpVgdgwm7kxGUAkJMCQm+GhIp/REHrNGpUn/UajdkrPIE4TaL/PwOd
         mIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718310394; x=1718915194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GTfYOBqqrUKiO4WKadrRzdDCvzu7pV/wtkqoToCmYE=;
        b=TqpAf2MBUVSITD+cfYVwXUT8+zbYd8wIcgpLWQYmZNtTtNVuvLnDPC6gx6wU4B6jUP
         jmgqDMUYZZ9sV/bLKJ/yLGMdcK0UsI2jdxDIRUhtr81Xdn7a+C493KaIFFs1Znergmb/
         5weDk/xqKxxrk1C2fSYqRMvGil4fIg847N6F+lNDeilW/2xXGaJElpU/BwgccW4i+Xqj
         Sn/70hD6GqjvHadNWUYSh/nAoysW9CfVYbkanBJQAsz3CY2584dbHwxoQXAV3dtWiYGp
         /fLA1wWocyodRNBQN62t55JBsy297Jl+LVCMo/jMsVh9WBEun6oc1MdtmCRSMchwjosK
         j3pA==
X-Gm-Message-State: AOJu0Yy5t4OrWpEzPMextSbwNYTnYu8nKJR1coKyLOcJwgEr1fLZ2cNB
	P0W4GpIJ4kyJi1CIw9UXKOIPbHCX6KVTVF6Xs7WaW/sWCpkLrjB4Nmx/mxMumzZFQS3p0jqfcsT
	EL1hyQSDIT6ZOM86SkZIlJVnBd4w=
X-Google-Smtp-Source: AGHT+IFFMcu/yrSM66VHicf0cTGhZ72oqhQbXegAuzxxXVgLDyHpiHHGQN8ZplmLpevVx72m0s+dbPUunFuBnfnpUhA=
X-Received: by 2002:a05:620a:4153:b0:795:5bff:ce48 with SMTP id
 af79cd13be357-7981017ab6fmr595727385a.25.1718310393958; Thu, 13 Jun 2024
 13:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613041136.506908-1-trond.myklebust@hammerspace.com>
 <20240613041136.506908-2-trond.myklebust@hammerspace.com> <20240613041136.506908-3-trond.myklebust@hammerspace.com>
 <20240613041136.506908-4-trond.myklebust@hammerspace.com> <20240613041136.506908-5-trond.myklebust@hammerspace.com>
 <20240613041136.506908-6-trond.myklebust@hammerspace.com> <20240613041136.506908-7-trond.myklebust@hammerspace.com>
 <20240613041136.506908-8-trond.myklebust@hammerspace.com>
In-Reply-To: <20240613041136.506908-8-trond.myklebust@hammerspace.com>
From: Anna Schumaker <schumaker.anna@gmail.com>
Date: Thu, 13 Jun 2024 16:26:15 -0400
Message-ID: <CAFX2Jf=Pr8m2Pd81utaQhFtHqCOE9cbYbjopd0dNk3u39BowfA@mail.gmail.com>
Subject: Re: [PATCH 07/19] NFSv4: Add support for delegated atime and mtime attributes
To: trondmy@gmail.com
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trond,

On Thu, Jun 13, 2024 at 12:17=E2=80=AFAM <trondmy@gmail.com> wrote:
>
> From: Trond Myklebust <trond.myklebust@primarydata.com>
>
> Ensure that we update the mtime and atime correctly when we read
> or write data to the file and when we truncate. Let the server manage
> ctime on other attribute updates.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
> Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/delegation.c | 24 +++++++++++++++-----
>  fs/nfs/delegation.h | 25 +++++++++++++++++++--
>  fs/nfs/inode.c      | 54 +++++++++++++++++++++++++++++++++++++++++----
>  fs/nfs/nfs4proc.c   | 21 ++++++++++--------
>  fs/nfs/read.c       |  3 +++
>  fs/nfs/write.c      |  9 ++++++++
>  6 files changed, 116 insertions(+), 20 deletions(-)
>
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index 6fdffd25cb2b..e72eead06c08 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -115,6 +115,9 @@ static int nfs4_do_check_delegation(struct inode *ino=
de, fmode_t type,
>                 if (mark)
>                         nfs_mark_delegation_referenced(delegation);
>                 ret =3D 1;
> +               if ((flags & NFS_DELEGATION_FLAG_TIME) &&
> +                   !test_bit(NFS_DELEGATION_DELEGTIME, &delegation->flag=
s))
> +                       ret =3D 0;
>         }
>         rcu_read_unlock();
>         return ret;
> @@ -221,11 +224,12 @@ static int nfs_delegation_claim_opens(struct inode =
*inode,
>   * @type: delegation type
>   * @stateid: delegation stateid
>   * @pagemod_limit: write delegation "space_limit"
> + * @deleg_type: raw delegation type
>   *
>   */
>  void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred=
 *cred,
>                                   fmode_t type, const nfs4_stateid *state=
id,
> -                                 unsigned long pagemod_limit)
> +                                 unsigned long pagemod_limit, u32 deleg_=
type)
>  {
>         struct nfs_delegation *delegation;
>         const struct cred *oldcred =3D NULL;
> @@ -250,7 +254,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode=
, const struct cred *cred,
>         } else {
>                 rcu_read_unlock();
>                 nfs_inode_set_delegation(inode, cred, type, stateid,
> -                                        pagemod_limit);
> +                                        pagemod_limit, deleg_type);
>         }
>  }
>
> @@ -418,13 +422,13 @@ nfs_update_inplace_delegation(struct nfs_delegation=
 *delegation,
>   * @type: delegation type
>   * @stateid: delegation stateid
>   * @pagemod_limit: write delegation "space_limit"
> + * @deleg_type: raw delegation type
>   *
>   * Returns zero on success, or a negative errno value.
>   */
>  int nfs_inode_set_delegation(struct inode *inode, const struct cred *cre=
d,
> -                                 fmode_t type,
> -                                 const nfs4_stateid *stateid,
> -                                 unsigned long pagemod_limit)
> +                            fmode_t type, const nfs4_stateid *stateid,
> +                            unsigned long pagemod_limit, u32 deleg_type)
>  {
>         struct nfs_server *server =3D NFS_SERVER(inode);
>         struct nfs_client *clp =3D server->nfs_client;
> @@ -444,6 +448,11 @@ int nfs_inode_set_delegation(struct inode *inode, co=
nst struct cred *cred,
>         delegation->cred =3D get_cred(cred);
>         delegation->inode =3D inode;
>         delegation->flags =3D 1<<NFS_DELEGATION_REFERENCED;
> +       switch (deleg_type) {
> +       case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
> +       case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
> +               delegation->flags |=3D BIT(NFS_DELEGATION_DELEGTIME);
> +       }
>         delegation->test_gen =3D 0;
>         spin_lock_init(&delegation->lock);
>
> @@ -508,6 +517,11 @@ int nfs_inode_set_delegation(struct inode *inode, co=
nst struct cred *cred,
>         atomic_long_inc(&nfs_active_delegations);
>
>         trace_nfs4_set_delegation(inode, type);
> +
> +       /* If we hold writebacks and have delegated mtime then update */
> +       if (deleg_type =3D=3D NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG &&
> +           nfs_have_writebacks(inode))
> +               nfs_update_delegated_mtime(inode);
>  out:
>         spin_unlock(&clp->cl_lock);
>         if (delegation !=3D NULL)
> diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
> index 257b3d726043..2e9ad83acf2c 100644
> --- a/fs/nfs/delegation.h
> +++ b/fs/nfs/delegation.h
> @@ -38,12 +38,17 @@ enum {
>         NFS_DELEGATION_TEST_EXPIRED,
>         NFS_DELEGATION_INODE_FREEING,
>         NFS_DELEGATION_RETURN_DELAYED,
> +       NFS_DELEGATION_DELEGTIME,
>  };
>
> +#define NFS_DELEGATION_FLAG_TIME       BIT(1)

This flag is defined under an "#if IS_ENABLED(CONFIG_NFS_V4)" guard,
so it doesn't exist for the functions farther down in this file when
v4 is disabled.

Anna

> +
>  int nfs_inode_set_delegation(struct inode *inode, const struct cred *cre=
d,
> -               fmode_t type, const nfs4_stateid *stateid, unsigned long =
pagemod_limit);
> +                            fmode_t type, const nfs4_stateid *stateid,
> +                            unsigned long pagemod_limit, u32 deleg_type)=
;
>  void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred=
 *cred,
> -               fmode_t type, const nfs4_stateid *stateid, unsigned long =
pagemod_limit);
> +                                 fmode_t type, const nfs4_stateid *state=
id,
> +                                 unsigned long pagemod_limit, u32 deleg_=
type);
>  int nfs4_inode_return_delegation(struct inode *inode);
>  void nfs4_inode_return_delegation_on_close(struct inode *inode);
>  int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_st=
ateid *stateid);
> @@ -84,6 +89,10 @@ int nfs4_inode_make_writeable(struct inode *inode);
>
>  #endif
>
> +void nfs_update_delegated_atime(struct inode *inode);
> +void nfs_update_delegated_mtime(struct inode *inode);
> +void nfs_update_delegated_mtime_locked(struct inode *inode);
> +
>  static inline int nfs_have_read_or_write_delegation(struct inode *inode)
>  {
>         return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
> @@ -99,4 +108,16 @@ static inline int nfs_have_delegated_attributes(struc=
t inode *inode)
>         return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ, 0);
>  }
>
> +static inline int nfs_have_delegated_atime(struct inode *inode)
> +{
> +       return NFS_PROTO(inode)->have_delegation(inode, FMODE_READ,
> +                                                NFS_DELEGATION_FLAG_TIME=
);
> +}
> +
> +static inline int nfs_have_delegated_mtime(struct inode *inode)
> +{
> +       return NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE,
> +                                                NFS_DELEGATION_FLAG_TIME=
);
> +}
> +
>  #endif
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index 89722919b463..91c0aeaf6c1e 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -275,6 +275,8 @@ EXPORT_SYMBOL_GPL(nfs_zap_acl_cache);
>
>  void nfs_invalidate_atime(struct inode *inode)
>  {
> +       if (nfs_have_delegated_atime(inode))
> +               return;
>         spin_lock(&inode->i_lock);
>         nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATIME);
>         spin_unlock(&inode->i_lock);
> @@ -603,6 +605,33 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh,=
 struct nfs_fattr *fattr)
>  }
>  EXPORT_SYMBOL_GPL(nfs_fhget);
>
> +void nfs_update_delegated_atime(struct inode *inode)
> +{
> +       spin_lock(&inode->i_lock);
> +       if (nfs_have_delegated_atime(inode)) {
> +               inode_update_timestamps(inode, S_ATIME);
> +               NFS_I(inode)->cache_validity &=3D ~NFS_INO_INVALID_ATIME;
> +       }
> +       spin_unlock(&inode->i_lock);
> +}
> +
> +void nfs_update_delegated_mtime_locked(struct inode *inode)
> +{
> +       if (nfs_have_delegated_mtime(inode)) {
> +               inode_update_timestamps(inode, S_CTIME | S_MTIME);
> +               NFS_I(inode)->cache_validity &=3D ~(NFS_INO_INVALID_CTIME=
 |
> +                                                 NFS_INO_INVALID_MTIME);
> +       }
> +}
> +
> +void nfs_update_delegated_mtime(struct inode *inode)
> +{
> +       spin_lock(&inode->i_lock);
> +       nfs_update_delegated_mtime_locked(inode);
> +       spin_unlock(&inode->i_lock);
> +}
> +EXPORT_SYMBOL_GPL(nfs_update_delegated_mtime);
> +
>  #define NFS_VALID_ATTRS (ATTR_MODE|ATTR_UID|ATTR_GID|ATTR_SIZE|ATTR_ATIM=
E|ATTR_ATIME_SET|ATTR_MTIME|ATTR_MTIME_SET|ATTR_FILE|ATTR_OPEN)
>
>  int
> @@ -630,6 +659,17 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *=
dentry,
>                         attr->ia_valid &=3D ~ATTR_SIZE;
>         }
>
> +       if (nfs_have_delegated_mtime(inode)) {
> +               if (attr->ia_valid & ATTR_MTIME) {
> +                       nfs_update_delegated_mtime(inode);
> +                       attr->ia_valid &=3D ~ATTR_MTIME;
> +               }
> +               if (attr->ia_valid & ATTR_ATIME) {
> +                       nfs_update_delegated_atime(inode);
> +                       attr->ia_valid &=3D ~ATTR_ATIME;
> +               }
> +       }
> +
>         /* Optimization: if the end result is no change, don't RPC */
>         if (((attr->ia_valid & NFS_VALID_ATTRS) & ~(ATTR_FILE|ATTR_OPEN))=
 =3D=3D 0)
>                 return 0;
> @@ -685,6 +725,7 @@ static int nfs_vmtruncate(struct inode * inode, loff_=
t offset)
>
>         spin_unlock(&inode->i_lock);
>         truncate_pagecache(inode, offset);
> +       nfs_update_delegated_mtime_locked(inode);
>         spin_lock(&inode->i_lock);
>  out:
>         return err;
> @@ -708,8 +749,9 @@ void nfs_setattr_update_inode(struct inode *inode, st=
ruct iattr *attr,
>         spin_lock(&inode->i_lock);
>         NFS_I(inode)->attr_gencount =3D fattr->gencount;
>         if ((attr->ia_valid & ATTR_SIZE) !=3D 0) {
> -               nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIME |
> -                                                    NFS_INO_INVALID_BLOC=
KS);
> +               if (!nfs_have_delegated_mtime(inode))
> +                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_MTIM=
E);
> +               nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
>                 nfs_inc_stats(inode, NFSIOS_SETATTRTRUNC);
>                 nfs_vmtruncate(inode, attr->ia_size);
>         }
> @@ -855,8 +897,12 @@ int nfs_getattr(struct mnt_idmap *idmap, const struc=
t path *path,
>
>         /* Flush out writes to the server in order to update c/mtime/vers=
ion.  */
>         if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_CHANGE_COO=
KIE)) &&
> -           S_ISREG(inode->i_mode))
> -               filemap_write_and_wait(inode->i_mapping);
> +           S_ISREG(inode->i_mode)) {
> +               if (nfs_have_delegated_mtime(inode))
> +                       filemap_fdatawrite(inode->i_mapping);
> +               else
> +                       filemap_write_and_wait(inode->i_mapping);
> +       }
>
>         /*
>          * We may force a getattr if the user cares about atime.
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index 27fb40653f1d..83edbc7a3bcc 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -1245,7 +1245,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
>         struct nfs_inode *nfsi =3D NFS_I(inode);
>         u64 change_attr =3D inode_peek_iversion_raw(inode);
>
> -       cache_validity |=3D NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME=
;
> +       if (!nfs_have_delegated_mtime(inode))
> +               cache_validity |=3D NFS_INO_INVALID_CTIME | NFS_INO_INVAL=
ID_MTIME;
>         if (S_ISDIR(inode->i_mode))
>                 cache_validity |=3D NFS_INO_INVALID_DATA;
>
> @@ -1961,6 +1962,8 @@ nfs4_process_delegation(struct inode *inode, const =
struct cred *cred,
>         switch (delegation->open_delegation_type) {
>         case NFS4_OPEN_DELEGATE_READ:
>         case NFS4_OPEN_DELEGATE_WRITE:
> +       case NFS4_OPEN_DELEGATE_READ_ATTRS_DELEG:
> +       case NFS4_OPEN_DELEGATE_WRITE_ATTRS_DELEG:
>                 break;
>         default:
>                 return;
> @@ -1974,16 +1977,16 @@ nfs4_process_delegation(struct inode *inode, cons=
t struct cred *cred,
>                                    NFS_SERVER(inode)->nfs_client->cl_host=
name);
>                 break;
>         case NFS4_OPEN_CLAIM_PREVIOUS:
> -               nfs_inode_reclaim_delegation(inode, cred,
> -                               delegation->type,
> -                               &delegation->stateid,
> -                               delegation->pagemod_limit);
> +               nfs_inode_reclaim_delegation(inode, cred, delegation->typ=
e,
> +                                            &delegation->stateid,
> +                                            delegation->pagemod_limit,
> +                                            delegation->open_delegation_=
type);
>                 break;
>         default:
> -               nfs_inode_set_delegation(inode, cred,
> -                               delegation->type,
> -                               &delegation->stateid,
> -                               delegation->pagemod_limit);
> +               nfs_inode_set_delegation(inode, cred, delegation->type,
> +                                        &delegation->stateid,
> +                                        delegation->pagemod_limit,
> +                                        delegation->open_delegation_type=
);
>         }
>         if (delegation->do_recall)
>                 nfs_async_inode_return_delegation(inode, &delegation->sta=
teid);
> diff --git a/fs/nfs/read.c b/fs/nfs/read.c
> index a142287d86f6..1b0e06c11983 100644
> --- a/fs/nfs/read.c
> +++ b/fs/nfs/read.c
> @@ -28,6 +28,7 @@
>  #include "fscache.h"
>  #include "pnfs.h"
>  #include "nfstrace.h"
> +#include "delegation.h"
>
>  #define NFSDBG_FACILITY                NFSDBG_PAGECACHE
>
> @@ -372,6 +373,7 @@ int nfs_read_folio(struct file *file, struct folio *f=
olio)
>                 goto out_put;
>
>         nfs_pageio_complete_read(&pgio);
> +       nfs_update_delegated_atime(inode);
>         ret =3D pgio.pg_error < 0 ? pgio.pg_error : 0;
>         if (!ret) {
>                 ret =3D folio_wait_locked_killable(folio);
> @@ -428,6 +430,7 @@ void nfs_readahead(struct readahead_control *ractl)
>         }
>
>         nfs_pageio_complete_read(&pgio);
> +       nfs_update_delegated_atime(inode);
>
>         put_nfs_open_context(ctx);
>  out:
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index a9186b113fe7..c0cd644b97ff 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -289,6 +289,8 @@ static void nfs_grow_file(struct folio *folio, unsign=
ed int offset,
>         NFS_I(inode)->cache_validity &=3D ~NFS_INO_INVALID_SIZE;
>         nfs_inc_stats(inode, NFSIOS_EXTENDWRITE);
>  out:
> +       /* Atomically update timestamps if they are delegated to us. */
> +       nfs_update_delegated_mtime_locked(inode);
>         spin_unlock(&inode->i_lock);
>         nfs_fscache_invalidate(inode, 0);
>  }
> @@ -1514,6 +1516,13 @@ void nfs_writeback_update_inode(struct nfs_pgio_he=
ader *hdr)
>         struct nfs_fattr *fattr =3D &hdr->fattr;
>         struct inode *inode =3D hdr->inode;
>
> +       if (nfs_have_delegated_mtime(inode)) {
> +               spin_lock(&inode->i_lock);
> +               nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
> +               spin_unlock(&inode->i_lock);
> +               return;
> +       }
> +
>         spin_lock(&inode->i_lock);
>         nfs_writeback_check_extend(hdr, fattr);
>         nfs_post_op_update_inode_force_wcc_locked(inode, fattr);
> --
> 2.45.2
>
>

