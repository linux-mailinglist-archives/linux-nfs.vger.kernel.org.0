Return-Path: <linux-nfs+bounces-20463-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAFMG2aexmnrMQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20463-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 16:12:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED633346812
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 16:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 128DD3023933
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Mar 2026 15:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6A526C3B0;
	Fri, 27 Mar 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="HlJcpxmI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BA7311C01
	for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624322; cv=pass; b=W7imRt/3X9yKF8ExkYDWOaSToWlDxLalc8oG0Po3kJXXSpyKgDLO/T0l6KzFw3Ixy+XtctINHvN6IZXfVyxbYLUqXPhmNvGKoD5mTDSZIrDpEct5sEdNhft2l7WxVqpUmgKBpC8XzR1pnowot72rKLkQMldKiY4NNsIJmangoVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624322; c=relaxed/simple;
	bh=YmdSJ18GWkk0SOj83PsyJ1qG5XGbu/4l+iic+d0Bdnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2sUFPBE4dGPB4rpITnbKrZCV4MfU2nQCV0m6+qkzutrFeT6TjEs5erM39z/z7atWqDKw+cKuuiNxRYVx/21uBtux1LqiutWEeH3DaUfgFBnZZCtskxpTNtRloY1dmgAwwVRExSdeNqmOONWxqbq3PS0ifFHzHyAUToO0vKc0+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=HlJcpxmI; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38bd3c6c502so17564071fa.1
        for <linux-nfs@vger.kernel.org>; Fri, 27 Mar 2026 08:12:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774624318; cv=none;
        d=google.com; s=arc-20240605;
        b=hzQEwLlCXhKwd0RoTz3KQ5WcCZGYbKTSSsFDM98+I9/NDpT3yNt3aALxShiwL2h8TJ
         zc2EtI2UFd2JZqsa/mG/SQHsO5rwcTIY82jtdVS/sCSHg6PsWsbC1DMWxp4fj806dTdV
         kP8b5GX7lEUog0Nk7RIMaYfIGXT9VZqPoCAVzbalHDxrcb7gsxZN/IZH3kYqGTtsnlYu
         dnl1IwxKnYvJEB7bUMbGt6X9urE8OLHv1JxaRe392v9OXPCDUb0BtM5MR+96DP9dBn83
         aweCqa6YVpWt7Ry8ri7Tu8RVDV4zuIDzHpN/hVFsDYaVYKBx8gdBrjHcaINeeSipb6Sd
         +LkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ydww1udgC7FkR7a0r90QxkT2w1L59qt5mG3/GsIJ0a8=;
        fh=eO6LvoX/+KBXWv6cnXw8QaV83SDT2EbQ3jC8/QAm5iw=;
        b=F2wsPHYa9QVTyJN3AkIe3fJgw0BBlmBcpudYYt0gnmciKfIqZ4suWJF154YUn9CsNz
         FsXKvq+Zk5YmHzQDHoeqacrOuz0rAq1ZKgbhJ3W4tW42Xt83eSVFd1VomzLr458BvcvH
         9x7Nsc/7RukkxEsMqDbM/IaulBHW9MR2cYqT9XpK8IcGuZvN1GZbAY7FiEdlYO+4hxdM
         n0qACPgXtMdNExmZARcTUHzO6LkYcfRJCf9/+N8qx1Y1IoRgGKjP1usyEPMd7ZVItuaW
         KL3gKCrBJs9ADFFs/BB8k1o4ryOc2niKtct3ce1njdo8RpE18U6TlJTb4eJIqjgXUHqD
         XOyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1774624318; x=1775229118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ydww1udgC7FkR7a0r90QxkT2w1L59qt5mG3/GsIJ0a8=;
        b=HlJcpxmIOlJ8Qr8qi7f5bNDsHMvDgRGEO6dkjVsofhReJf4zMa2l1a7Oiv3tISJspt
         ZxVtjMAV3qVsgzvdw3fxBD6eu19nTjKdxHzyU5suGFFyyAMsvxH/ipEKnR3nOKGOo5r1
         kdhkewAcDiQEmvm7gobB6yHILNGz9QCfmPwuzVu4J5MTkMwHn3N8PUPfymtCxOAgIPCA
         0zE6qjysVhmBfWH8n2eIottiyRJQWdO3KEkJF1D60WhbMcjtaws18l+0yQIdUCeYE8Bc
         Lh49+L5t0ESH14MIvvUnzZQLSofbMJhXBYuaonxCDDlBE30uacw4b6d+8I6KJ0OIyQki
         3HNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774624318; x=1775229118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ydww1udgC7FkR7a0r90QxkT2w1L59qt5mG3/GsIJ0a8=;
        b=KYYiauT3/qV9TbGfXKiPdPjfS/nJmMwUEY8Q99lrI8hVhQIUcF2fRjLq1UWl5KEbYd
         egMQdk6vYCQPW3Vi/K0pSkhLGLQ0yONbR7Vjo0Bge7+i+jaIPAtAW5y9CLKVzIsSB95g
         XCOISkrDbO/YH+MxSdUAUKlx/BZpjEFQ4qU23N8DTy74WYBy9wnIZZztpaZIld6ld7qa
         mL3oqHFdTqP9UW1yTU3EnunPLI+PbKzP5rc46N8sZ4iqdccGO1L8oqDnZAZVOZr/avI3
         ZlV99aw+iDts7ydob71fc9Q1Jn6gFO7jrpI3fx38E6RTFTOtAOAuWO86SPAgb0IPWL30
         re8w==
X-Forwarded-Encrypted: i=1; AJvYcCVFTTcYbuGsUsA4vimPHfQQpLYUgGnupXFoRqpZc/RKJ8Zs3L9L455jcnu6fVl9tMJGo+4rjBCGDdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn2jdm5VQISZbvtka/AGaheyPseXn0/t41/n4hHSoAb0JPMYcx
	96kxT9u6QpGTykOjVnG3C5MwdgFeMvuhVd+quHmUkoDWudvDPNxMp8HmGst1FtiOyTKn1xRRKeD
	KVrLOzYot4yPfopuV+FwjpEeLHM8Ptpo=
X-Gm-Gg: ATEYQzwQ0tdeCoLCfjRdlY0S+leU5LaNu8WkhR37O5Esd734n9hg7thdajcaOJb+3tH
	Mr3yzMfNqT8we3bNFZVJS6+kN5OsSO2zLbiHl13iI/D7N2t1V/uTeqxxFJ7VRJUDhpuDpekdTrt
	651Gknwj2VQ0UJwAfzgx0kCgDHjhbcsbWqgquc42RI7whsEcOEFuixS/lQrQ3VkmRfTlyCmkk88
	djd9ysKBa1oFLpB+5u+J+5slzre9IlAweqlcWoVWu2wEK8yrlUrvhhkNJDf4Ze3OELod3O6kEMm
	Vx1SrQTtWuR2CtzFSg/y3Hu8VgPhvmw2Roeif0eg2Q==
X-Received: by 2002:a05:651c:f02:b0:38a:5e09:21ba with SMTP id
 38308e7fff4ca-38c74098a56mr9958411fa.25.1774624318274; Fri, 27 Mar 2026
 08:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-nfs-7-1-v2-0-d110da3c0036@kernel.org> <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
In-Reply-To: <20260324-nfs-7-1-v2-2-d110da3c0036@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Fri, 27 Mar 2026 11:11:46 -0400
X-Gm-Features: AQROBzA6dzIptZ6ReRgV3JSt8JWj00oyE8Iy2BhA8ZMI4aWgvxJwXl2d4E_RS2U
Message-ID: <CAN-5tyFpsuE9+5ZvAASwvTYKtcN5jNpAxi8ejde90e-vpUzFKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nfs: update inode ctime after removexattr operation
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20463-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[umich.edu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,umich.edu:dkim,umich.edu:email]
X-Rspamd-Queue-Id: ED633346812
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 1:32=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> xfstest generic/728 fails with delegated timestamps. The client does a
> removexattr and then a stat to test the ctime, which doesn't change. The
> stat() doesn't trigger a GETATTR because of the delegated timestamps, so
> it relies on the cached ctime, which is wrong.
>
> The setxattr compound has a trailing GETATTR, which ensures that its
> ctime gets updated. Follow the same strategy with removexattr.

This approach relies on the fact that the server the serves delegated
attributes would update change_attr on operations which might now
necessarily happen (ie, linux server does not update change_attribute
on writes or clone). I propose an alternative fix for the failing
generic/728.

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 7b3ca68fb4bb..ede1835a45b3 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1389,7 +1389,13 @@ static int _nfs42_proc_removexattr(struct inode
*inode, const char *name)
            &res.seq_res, 1);
        trace_nfs4_removexattr(inode, name, ret);
        if (!ret)
-               nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
+               if (nfs_have_delegated_attributes(inode)) {
+                       nfs_update_delegated_mtime(inode);
+                       spin_lock(&inode->i_lock);
+                       nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS=
);
+                       spin_unlock(&inode->i_lock);
+               } else
+                       nfs4_update_changeattr(inode, &res.cinfo, timestamp=
, 0);

        return ret;
 }

>
> Fixes: 3e1f02123fba ("NFSv4.2: add client side XDR handling for extended =
attributes")
> Reported-by: Olga Kornievskaia <aglo@umich.edu>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfs/nfs42proc.c      | 18 ++++++++++++++++--
>  fs/nfs/nfs42xdr.c       | 10 ++++++++--
>  include/linux/nfs_xdr.h |  3 +++
>  3 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> index 7b3ca68fb4bb3bee293f8621e5ed5fa596f5da3f..7e5c1172fc11c9d5a55b36219=
77ac83bb98f7c20 100644
> --- a/fs/nfs/nfs42proc.c
> +++ b/fs/nfs/nfs42proc.c
> @@ -1372,11 +1372,15 @@ int nfs42_proc_clone(struct file *src_f, struct f=
ile *dst_f,
>  static int _nfs42_proc_removexattr(struct inode *inode, const char *name=
)
>  {
>         struct nfs_server *server =3D NFS_SERVER(inode);
> +       __u32 bitmask[NFS_BITMASK_SZ];
>         struct nfs42_removexattrargs args =3D {
>                 .fh =3D NFS_FH(inode),
> +               .bitmask =3D bitmask,
>                 .xattr_name =3D name,
>         };
> -       struct nfs42_removexattrres res;
> +       struct nfs42_removexattrres res =3D {
> +               .server =3D server,
> +       };
>         struct rpc_message msg =3D {
>                 .rpc_proc =3D &nfs4_procedures[NFSPROC4_CLNT_REMOVEXATTR]=
,
>                 .rpc_argp =3D &args,
> @@ -1385,12 +1389,22 @@ static int _nfs42_proc_removexattr(struct inode *=
inode, const char *name)
>         int ret;
>         unsigned long timestamp =3D jiffies;
>
> +       res.fattr =3D nfs_alloc_fattr();
> +       if (!res.fattr)
> +               return -ENOMEM;
> +
> +       nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask,
> +                        inode, NFS_INO_INVALID_CHANGE);
> +
>         ret =3D nfs4_call_sync(server->client, server, &msg, &args.seq_ar=
gs,
>             &res.seq_res, 1);
>         trace_nfs4_removexattr(inode, name, ret);
> -       if (!ret)
> +       if (!ret) {
>                 nfs4_update_changeattr(inode, &res.cinfo, timestamp, 0);
> +               ret =3D nfs_post_op_update_inode(inode, res.fattr);
> +       }
>
> +       kfree(res.fattr);
>         return ret;
>  }
>
> diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
> index 5c7452ce6e8ac94bd24bc3a33d4479d458a29907..ec105c62f721cfe01bfc60f59=
81396958084d627 100644
> --- a/fs/nfs/nfs42xdr.c
> +++ b/fs/nfs/nfs42xdr.c
> @@ -263,11 +263,13 @@
>  #define NFS4_enc_removexattr_sz                (compound_encode_hdr_maxs=
z + \
>                                          encode_sequence_maxsz + \
>                                          encode_putfh_maxsz + \
> -                                        encode_removexattr_maxsz)
> +                                        encode_removexattr_maxsz + \
> +                                        encode_getattr_maxsz)
>  #define NFS4_dec_removexattr_sz                (compound_decode_hdr_maxs=
z + \
>                                          decode_sequence_maxsz + \
>                                          decode_putfh_maxsz + \
> -                                        decode_removexattr_maxsz)
> +                                        decode_removexattr_maxsz + \
> +                                        decode_getattr_maxsz)
>
>  /*
>   * These values specify the maximum amount of data that is not
> @@ -869,6 +871,7 @@ static void nfs4_xdr_enc_removexattr(struct rpc_rqst =
*req,
>         encode_sequence(xdr, &args->seq_args, &hdr);
>         encode_putfh(xdr, args->fh, &hdr);
>         encode_removexattr(xdr, args->xattr_name, &hdr);
> +       encode_getfattr(xdr, args->bitmask, &hdr);
>         encode_nops(&hdr);
>  }
>
> @@ -1818,6 +1821,9 @@ static int nfs4_xdr_dec_removexattr(struct rpc_rqst=
 *req,
>                 goto out;
>
>         status =3D decode_removexattr(xdr, &res->cinfo);
> +       if (status)
> +               goto out;
> +       status =3D decode_getfattr(xdr, res->fattr, res->server);
>  out:
>         return status;
>  }
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index ff1f12aa73d27b6fd874baf7019dd03195fc36e5..fcbd21b5685f46136a210c8e1=
1c20a54d6ed9dad 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1611,12 +1611,15 @@ struct nfs42_listxattrsres {
>  struct nfs42_removexattrargs {
>         struct nfs4_sequence_args       seq_args;
>         struct nfs_fh                   *fh;
> +       const u32                       *bitmask;
>         const char                      *xattr_name;
>  };
>
>  struct nfs42_removexattrres {
>         struct nfs4_sequence_res        seq_res;
>         struct nfs4_change_info         cinfo;
> +       struct nfs_fattr                *fattr;
> +       const struct nfs_server         *server;
>  };
>
>  #endif /* CONFIG_NFS_V4_2 */
>
> --
> 2.53.0
>

