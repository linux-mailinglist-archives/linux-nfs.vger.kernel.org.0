Return-Path: <linux-nfs+bounces-19124-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBUlEX0fnGkZ/wMAu9opvQ
	(envelope-from <linux-nfs+bounces-19124-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 10:35:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7271173FF4
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 10:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D13730104B2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CBF34F49A;
	Mon, 23 Feb 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvjUXwJM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1434EEEF
	for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771839328; cv=pass; b=QMIFtltTrXMhgly3y7+0zS6RFkysLdxjfEwzk8gk7TU0Rdr5N04gVNEbaklTQPfKOtzoNM9Id2Xe92sGf1JcQhPwEsDPDAoDw+6wYFTFVVCta4e/OPAML1phf1KOULuJT+5KQpk1xBnHuCMvIcAjRoEdyK1TN9LXPOs6q6A63kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771839328; c=relaxed/simple;
	bh=mAAOjC5VpT1HkXsRAwtGw0eUE/35I2Skqe677nArRZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvgkJLyGgNlE1jxFTKHuF08XuXeEBoAUS0TNyQ8C92mJWOkTP7B5gJU5lp8sLYPO1kpmLGclvSLrKHfdfAs+Ubh/L9pS4wrXmXL//b23kWDu+uvxuXxVklM4Lrc947eLv1Zz+dk4skdPpfBcJPUEcbgWivlCGjjmcSlDDsdyjfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvjUXwJM; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so722588366b.2
        for <linux-nfs@vger.kernel.org>; Mon, 23 Feb 2026 01:35:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771839326; cv=none;
        d=google.com; s=arc-20240605;
        b=BIxGmsX3GsoMYGl5BGc+6v0zoFrZhJaq8MdGDN6X2uYSrMWypgMpyUACJUS+R1ld5w
         lopBzHu3oPYyjMOcqU0X5pEYmGGo8VoN17MlHlZ7KZzqa/b4XsTRPQOfYAv3VciT3MyR
         ph0pJPJVdYhktQ2gIUdTk533SbBGHE/yYXExRQXVlGULyZXtXhetSg+8UPJ0I/8dvWXH
         pXq/QvHN0UiFtJMNTsOE/NtjJkeDirtfzYyq4jPI/YlcywYYkxOhmvASp+UPVwb5a44W
         A8d7g9hu4+lxKxoQD4+qm4YGB6wakVfrDeAmVdgteb0MH5hE2rR8R1FtGnuVCF7MY2IW
         WEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        fh=mF1r9umH+nX/Q/ec9i7JRxSmlBJexvEhk35McSZWQMY=;
        b=f/+4h7rKeqs/hbmq0M84RGEFJ2NvSmhg/77S0eI6WPiv3VWxLUE0UTLpjaIExhMdna
         nKjZybC8qpk28poYWLjI/aNGAT3tVY6AfAf6IDY+0qwjHde2tkX7u/zbqmIHUnY910c6
         BgnIKDm+JoJu+LhWp6Hfbhj6QYLbRbrBVhGRV+sw6YEvdncexF1M2HqGT3Gdw0p7BLCE
         ppCmrIlhfQ/0ZgPxcO3Yv8Z+AesiMAlLqt356MsOu5mh0/0NLrjJvq7Q2bC0lNUjqTU2
         SIif62d6xvryKYG62EzCahZDMexeXW4TCtTxEVJaFEZysETD9Dn5mSjxIaA15QXR6eOD
         m1YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771839326; x=1772444126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=lvjUXwJMFDUVNdE9/6JGFIIEgXAr+NW/nxJYiNKP83A2h2rSdOYnS2Qap5SEi8qvuc
         Xvv8mX7Ib5UTjZ2Ntgfe8sP1Y8sbStPRBVlVXYlUG96b6S34FcSJuKZLdABzCTwQSawB
         6kEeAv1Xy3QQTZBXYrCOuzdG6KW4vFjs2HUXgSqvz4TtzIzp1VaFIlsTAa6b5Sp1Jd34
         8+G7qchOZolFb2NrtqZ2ma6izvwW8ElQncc0YNDtZAtfeVwNdlTIquDlE1K/HvvMVBW5
         MVSWix+ReYo/KfT3GNcH4MXXhrxRSIQZW2RW+9DJtcTlAkJOfHQiKIYj+U2ejfaspoaD
         g7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771839326; x=1772444126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/tsVKpvOF9hjEuBModNYiVpSPXtrrKrMQ519faKcis=;
        b=NFJMmCr2yu5HgMq0zgf4YsoUcoXQB35U9acUwc8/QaKFsTqc0VI64bklBfCK3BflQX
         zGTV1/UveC+NdDTjFxCQ08TmW2W1GIFJE3aFatuBDG7s4CE8Xijs8e8kEvPmr8+KNYGo
         BTHITBJEWvER5c+7kklqAzFMWxg+1xOxRdviPIADWOXlp2IToouujtqJ+66a7G5ZngO1
         LJORymoWycFDl7w0RVt8AdeVJKueAe9/tyALEjbQ3Z6CjbFUhDjqanCwPd/75FgrDa8D
         GBRnQoH2CCGdiIktqfAtAnfdM4I7unhdqo6SxCJUGLNK7uit1uQGR5vi82kCJBoKpDT+
         x8nw==
X-Forwarded-Encrypted: i=1; AJvYcCUgo5ALVM99Y7Jmhgyf4R4RtENqk6z4wBwvw2+B4QxqHJaFq6FJmFeQb8pBzWHgccHylrPWr8Me8Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/eY8Ct7f5lISaLHUHGBQJ/WkryV2yyJ1ni0qRihTi4XhlFFO
	f5wrN+VvrP4dHiFXlH0WkqSiSSGgTVO/TUVDNhQyCULr7i8blZ85TA0JzDis7hkWmwM2rk3rQkU
	mYI3SoYDuVEMiIK2v7ORRQAP2kSDcRBU=
X-Gm-Gg: AZuq6aLLzSLlQGwKpGSadRk2ow8api53H3L55eme9Uv+FbwYm1q0VAs1OnXQ20lPzOK
	Q2E4OJ4RuzHnrpdT+QWFBf6YfDowZeQf+n9ZB5I70hV689PSmiQ8td7a6Tj3vRusABl0v4vU/dD
	iEOgRGIXq8hB9sF5GcCT+dOXb3jJckBkz16lwD71BLBHk8PQN61UuZx5hAnlqMRWWRwkQ7Pu+/e
	7u8fL/+DLExKt0+rjO6sp/yBCamadrxpw9Ks7vQ33XTnMb2ES3zNkAJ3Lb+DWrxGkVhQSvQzGV6
	T6r7uh2DbMOr880EcaE/8DFx6Hj9njbaWArhlNp7/g==
X-Received: by 2002:a17:906:7307:b0:b88:5002:50c0 with SMTP id
 a640c23a62f3a-b90819db296mr564028666b.20.1771839325394; Mon, 23 Feb 2026
 01:35:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-12-neilb@ownmail.net>
In-Reply-To: <20260223011210.3853517-12-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Feb 2026 11:35:14 +0200
X-Gm-Features: AaiRm51zLgcrRbPb_4HmwkH5uY0J9aukMWrvlX2vP_E-cCHRJFMZshxY7_A02Xw
Message-ID: <CAOQ4uxibL=2Z0FZMz5wMAo=JMaJouOVo3p7t3Fi3FR59U5Tu=g@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] ovl: pass name buffer to ovl_start_creating_temp()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19124-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7271173FF4
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 2:14=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote=
:
>
> From: NeilBrown <neil@brown.name>
>
> Now ovl_start_creating_temp() is passed a buffer in which to store the
> temp name.  This will be useful in a future patch were ovl_create_real()
> will need access to that name.
>
> Signed-off-by: NeilBrown <neil@brown.name>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/dir.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index ff3dbd1ca61f..c4feb89ad1e3 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -66,10 +66,9 @@ void ovl_tempname(char name[OVL_TEMPNAME_SIZE])
>  }
>
>  static struct dentry *ovl_start_creating_temp(struct ovl_fs *ofs,
> -                                             struct dentry *workdir)
> +                                             struct dentry *workdir,
> +                                             char name[OVL_TEMPNAME_SIZE=
])
>  {
> -       char name[OVL_TEMPNAME_SIZE];
> -
>         ovl_tempname(name);
>         return start_creating(ovl_upper_mnt_idmap(ofs), workdir,
>                               &QSTR(name));
> @@ -81,11 +80,12 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs=
)
>         struct dentry *whiteout, *link;
>         struct dentry *workdir =3D ofs->workdir;
>         struct inode *wdir =3D workdir->d_inode;
> +       char name[OVL_TEMPNAME_SIZE];
>
>         guard(mutex)(&ofs->whiteout_lock);
>
>         if (!ofs->whiteout) {
> -               whiteout =3D ovl_start_creating_temp(ofs, workdir);
> +               whiteout =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(whiteout))
>                         return whiteout;
>                 err =3D ovl_do_whiteout(ofs, wdir, whiteout);
> @@ -97,7 +97,7 @@ static struct dentry *ovl_whiteout(struct ovl_fs *ofs)
>         }
>
>         if (!ofs->no_shared_whiteout) {
> -               link =3D ovl_start_creating_temp(ofs, workdir);
> +               link =3D ovl_start_creating_temp(ofs, workdir, name);
>                 if (IS_ERR(link))
>                         return link;
>                 err =3D ovl_do_link(ofs, ofs->whiteout, wdir, link);
> @@ -247,7 +247,9 @@ struct dentry *ovl_create_temp(struct ovl_fs *ofs, st=
ruct dentry *workdir,
>                                struct ovl_cattr *attr)
>  {
>         struct dentry *ret;
> -       ret =3D ovl_start_creating_temp(ofs, workdir);
> +       char name[OVL_TEMPNAME_SIZE];
> +
> +       ret =3D ovl_start_creating_temp(ofs, workdir, name);
>         if (IS_ERR(ret))
>                 return ret;
>         ret =3D ovl_create_real(ofs, workdir, ret, attr);
> --
> 2.50.0.107.gf914562f5916.dirty
>

