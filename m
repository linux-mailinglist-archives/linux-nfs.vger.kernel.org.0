Return-Path: <linux-nfs+bounces-18659-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF+aACkggmlIPgMAu9opvQ
	(envelope-from <linux-nfs+bounces-18659-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Feb 2026 17:19:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B90DBD28
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Feb 2026 17:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE374315FBDE
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Feb 2026 16:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322CE3C1998;
	Tue,  3 Feb 2026 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="AxhekHSE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370573C1985
	for <linux-nfs@vger.kernel.org>; Tue,  3 Feb 2026 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135133; cv=pass; b=IjdDwD3KQ7oRfhySGSm5kjMNHlvnqy7l5+2SdRAUe6ehSywA+I1Smu/VUgOyED7gkG/kW2Lo4Te51D/Q/seXEeZlApJXbHrh0lfMgm/i8IRSkAVzr6831OshEb92hmjgL16llO1s9xcMuGYVQg4yhl/aOoUWnjRJal2M3QQpPGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135133; c=relaxed/simple;
	bh=A8RN4GDLWQ83r49qq2Mz8+c6CAijfCOfj8JYE67qE84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMxkXBweq7qtTlnjSPsKrbgXiPpGHV/vjN+oPuYqL8OKinLU9JBzz0pI7xdZLWGLUtgjHPTQnn8QRVgPbJRCvATtqRBITpN8sfwM3pfkWZEgFWDl73BaH724dZ9qLCW0+CO6Cn9Amka5FmyHZdlXCcQwFkRKhGfZxRPNlKCZQZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=AxhekHSE; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59dd9aef51eso6661117e87.2
        for <linux-nfs@vger.kernel.org>; Tue, 03 Feb 2026 08:12:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770135128; cv=none;
        d=google.com; s=arc-20240605;
        b=Y1HEe/jeMtFEccfveagOSdyW0mp6cQt/Fi6NUAnuSTDk7aNb1rDBp3o3kdLtZ+Lpci
         Mg4GLV5AUXxA8767012Wdm812kCKocHbIR114Xq4pCTaRNqr3tAKs45600Z8UTuHxEN6
         9glaHzMrHynN3MEL4I0xSGMyfE8p6aV/qt8TaA88pAChiAn4Jwo0VNeBe9mu6Pr5c78e
         uUnRCFQDmpVbstWPZU4bCB1KSYulfUxojNMblL+DCspIlulvZQofqEC/sk4URNl+pI43
         H5CubhKGk0dmZNqaGGQU4/xUehO1qDEzrf4Q7g3nUz6bJWkrIT3UrTOol3CfqBU3DarG
         zF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AQpego8feKFB7r7Kf6rf1Qb5zSTvuesnvWGekYZ4xX4=;
        fh=pwXuzeKi0xXUa9h05b3owNlkTlxekHt4QQMBmoF4uk4=;
        b=FY0yZ6tKoiBpETBoV/XMt3M+zLXN/TLcWQfy3tOUfSIFltUoqRC2J3h/67SicnSZMH
         8T2Pr2M9GykdzpOZLVQ+Yu/B+FtvSNRAmaZmj84717ozJDQdWk/pHUXg62L8bsV8ZqaB
         HOtwgIvwkRd4Iew62DXqt6xoM5r1TPqi71tMzefAQhJXmPAOOOOVy/2WnbzPXuY8WhXj
         1twrwfqadvxbyrXAAuuy2xBR2m11SclJFqDgRST1ax9ptDj20T0tuf+0pgfd3dr+4hFp
         RQcz4MXiAIEAlCTx6PJ4exMZXDsFjegxYKiZa9zznJ4VEQp6VAtjQXWtBcgcuFvUS1wB
         ZFTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1770135128; x=1770739928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AQpego8feKFB7r7Kf6rf1Qb5zSTvuesnvWGekYZ4xX4=;
        b=AxhekHSELVLKOo3FYHbVT2qZpM6RKlitYeyZqwDwVR/4s7jxrV+h9SiHNbmQdr/3D6
         57gKBKJZDEj1OEnS0itIagto3vVC6Qq8FlE3V/H0c/elq4YYAb9DZ+I8RXFPmzw7+kDQ
         G0ZLdoG/KQu28HDJAD8f/BcHB8Uc4mTIhFQ5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770135128; x=1770739928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQpego8feKFB7r7Kf6rf1Qb5zSTvuesnvWGekYZ4xX4=;
        b=Bz9IMaDC28PcgzDRwTxRsJ4OJ93/epFcj16SujeOX1yPe3Kcxe8Q4nzHlOISE5ujnV
         fZ9L5TYMATcyCdJrRufLrSjfHDr0HtCYIxWVXM3xA8SOMvkBK5wNz8M7hGmLnE3Xx4Y4
         BPjdCqCqbboUDSJ+WxnCgpcdNIcxYW0GByhybPxl68rNa9Yo5jH3JvF0gEKukYt+4Ygx
         Yvarkf3+R2TzN72NXG8dDlhCf95S/wwmx/gkxfu886wHMUAJ0sRQDFaJumVwnCG7xfUa
         Nvk+ve8X7CEM9vr+QFsHZbxf7wGMP6bcv0mGEW908QDbTH/NWxCvT8mddk86JGwz83EQ
         hFxw==
X-Forwarded-Encrypted: i=1; AJvYcCWtlkL106LnABnE1WX/p9/fPRd4LaFcgnGV3pl9W6Qi/tIXr7SIv0XIBw4bYCvNobEc1bK4y/624OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE4frG1ONDB7Bc9WLFWlhz3FIB6lfzi2E3mHzF0yJaMVQTG9uP
	r3Zb57cQlId7+q2WuCgvVkyfAP9r3J5yQvLpowPvzjRwykHLtz2jzxkWn8wVJYnu1QfIuoeuaT+
	V3LWvzE3LTJbE4thkm+jsgKKUreG2i4HXoG4kZIDnwQ==
X-Gm-Gg: AZuq6aJJQLvCvoE/dI/ZHAThBfEzkeIoH83h9d3wew0ELnFxAzFohXJP5j2tr1vX1C9
	Q8PDz+Y18Vze9U0s4Ec9547yYB9cdrTy8VVjryH5mNYZGGrDv/wJkVh/amlOLl0lY9BCOb9hLtz
	kSZma3enYP+wpvV156dvoKj/sWnUfOCV5nRi1dHLlWi25PGimkOLqr2LDu2/LniWrrceMoICLhd
	VMZ12j3t3CpSPJCxm82bqMPRK5+d333hYeM3IjHv0TnGVnLPDeDRvosCuVvisxwrfB8wA==
X-Received: by 2002:a05:6512:361a:b0:59e:174e:fce0 with SMTP id
 2adb3069b0e04-59e174efd13mr3804850e87.42.1770135127877; Tue, 03 Feb 2026
 08:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
In-Reply-To: <20260129-twmount-v1-1-4874ed2a15c4@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 3 Feb 2026 17:11:55 +0100
X-Gm-Features: AZwV_Qh3STuAfXyfImYoG9ogVPD44LxztQyiZo154t6EomlvRura8CdCgjeoM8I
Message-ID: <CAJqdLrphO1GnAZ2=n8wQAP7B+ZwFnD0wSLY7sAjacZTpLZrqBg@mail.gmail.com>
Subject: Re: [PATCH] vfs: add FS_USERNS_DELEGATABLE flag and set it for NFS
To: Jeff Layton <jlayton@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mihalicyn.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mihalicyn.com:s=mihalicyn];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18659-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mihalicyn.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander@mihalicyn.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[futurfusion.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mihalicyn.com:dkim]
X-Rspamd-Queue-Id: 94B90DBD28
X-Rspamd-Action: no action

Am Do., 29. Jan. 2026 um 22:48 Uhr schrieb Jeff Layton <jlayton@kernel.org>:
>
> Commit e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems
> without FS_USERNS_MOUNT") prevents the mount of any filesystem inside a
> container that doesn't have FS_USERNS_MOUNT set.
>

Hi Jeff,

> This broke NFS mounts in our containerized environment. We have a daemon
> somewhat like systemd-mountfsd running in the init_ns. A process does a
> fsopen() inside the container and passes it to the daemon via unix
> socket.
>
> The daemon then vets that the request is for an allowed NFS server and
> performs the mount. This now fails because the fc->user_ns is set to the
> value in the container and NFS doesn't set FS_USERNS_MOUNT.  We don't
> want to add FS_USERNS_MOUNT to NFS since that would allow the container
> to mount any NFS server (even malicious ones).
>
> Add a new FS_USERNS_DELEGATABLE flag, and enable it on NFS.

Great idea, very similar to what we have with BPFFS/BPF Tokens.

Taking into account this patch, shouldn't we drop FS_USERNS_MOUNT and
replace it with
FS_USERNS_DELEGATABLE for bpffs too?

I mean something like:

======================
$ git diff
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9f866a010dad..d8dfdc846bd0 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -1009,10 +1009,6 @@ static int bpf_fill_super(struct super_block
*sb, struct fs_context *fc)
        struct inode *inode;
        int ret;

-       /* Mounting an instance of BPF FS requires privileges */
-       if (fc->user_ns != &init_user_ns && !capable(CAP_SYS_ADMIN))
-               return -EPERM;
-
        ret = simple_fill_super(sb, BPF_FS_MAGIC, bpf_rfiles);
        if (ret)
                return ret;
@@ -1085,7 +1081,7 @@ static struct file_system_type bpf_fs_type = {
        .init_fs_context = bpf_init_fs_context,
        .parameters     = bpf_fs_parameters,
        .kill_sb        = bpf_kill_super,
-       .fs_flags       = FS_USERNS_MOUNT,
+       .fs_flags       = FS_USERNS_DELEGATABLE,
 };

 static int __init bpf_init(void)
======================

Because it feels like we were basically implementing this FS_USERNS_DELEGATABLE
flag implicitly for BPFFS before. I can submit a patch for BPFFS later
after testing.

>
> Fixes: e1c5ae59c0f2 ("fs: don't allow non-init s_user_ns for filesystems without FS_USERNS_MOUNT")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Kind regards,
Alex

> ---
>  fs/nfs/fs_context.c |  8 ++++++--
>  fs/super.c          | 11 ++++++-----
>  include/linux/fs.h  |  1 +
>  3 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
> index b4679b7161b0968810e13f57c889052ea015bf56..128ebd48b4f4ba1c17e8b5b1b9dcefbd7a97db1a 100644
> --- a/fs/nfs/fs_context.c
> +++ b/fs/nfs/fs_context.c
> @@ -1768,7 +1768,9 @@ struct file_system_type nfs_fs_type = {
>         .init_fs_context        = nfs_init_fs_context,
>         .parameters             = nfs_fs_parameters,
>         .kill_sb                = nfs_kill_super,
> -       .fs_flags               = FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> +       .fs_flags               = FS_RENAME_DOES_D_MOVE |
> +                                 FS_BINARY_MOUNTDATA   |
> +                                 FS_USERNS_DELEGATABLE,
>  };
>  MODULE_ALIAS_FS("nfs");
>  EXPORT_SYMBOL_GPL(nfs_fs_type);
> @@ -1780,7 +1782,9 @@ struct file_system_type nfs4_fs_type = {
>         .init_fs_context        = nfs_init_fs_context,
>         .parameters             = nfs_fs_parameters,
>         .kill_sb                = nfs_kill_super,
> -       .fs_flags               = FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
> +       .fs_flags               = FS_RENAME_DOES_D_MOVE |
> +                                 FS_BINARY_MOUNTDATA   |
> +                                 FS_USERNS_DELEGATABLE,
>  };
>  MODULE_ALIAS_FS("nfs4");
>  MODULE_ALIAS("nfs4");
> diff --git a/fs/super.c b/fs/super.c
> index 3d85265d14001d51524dbaec0778af8f12c048ac..b7f1bb2b679b43261fbdcd586971c551b85e8372 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -738,12 +738,13 @@ struct super_block *sget_fc(struct fs_context *fc,
>         int err;
>
>         /*
> -        * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
> -        * not set, as the filesystem is likely unprepared to handle it.
> -        * This can happen when fsconfig() is called from init_user_ns with
> -        * an fs_fd opened in another user namespace.
> +        * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT or
> +        * FS_USERNS_DELEGATABLE is not set, as the filesystem is likely
> +        * unprepared to handle it. This can happen when fsconfig() is called
> +        * from init_user_ns with an fs_fd opened in another user namespace.
>          */
> -       if (user_ns != &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
> +       if (user_ns != &init_user_ns &&
> +           !(fc->fs_type->fs_flags & (FS_USERNS_MOUNT | FS_USERNS_DELEGATABLE))) {
>                 errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
>                 return ERR_PTR(-EPERM);
>         }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index a01621fa636a60764e1dfe83f2260caf50c4037e..94695ce5e25b5fbe4f321d5478172b8cb24e00d1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2273,6 +2273,7 @@ struct file_system_type {
>  #define FS_MGTIME              64      /* FS uses multigrain timestamps */
>  #define FS_LBS                 128     /* FS supports LBS */
>  #define FS_POWER_FREEZE                256     /* Always freeze on suspend/hibernate */
> +#define FS_USERNS_DELEGATABLE  512     /* Can be mounted inside userns from outside */
>  #define FS_RENAME_DOES_D_MOVE  32768   /* FS will handle d_move() during rename() internally. */
>         int (*init_fs_context)(struct fs_context *);
>         const struct fs_parameter_spec *parameters;
>
> ---
> base-commit: 8dfce8991b95d8625d0a1d2896e42f93b9d7f68d
> change-id: 20260129-twmount-114ddfd43420
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>

