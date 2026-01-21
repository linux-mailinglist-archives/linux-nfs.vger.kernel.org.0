Return-Path: <linux-nfs+bounces-18232-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMSaEwWfcGlyYgAAu9opvQ
	(envelope-from <linux-nfs+bounces-18232-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 10:40:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96752548E8
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 10:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A54F3882F96
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Jan 2026 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F535E529;
	Wed, 21 Jan 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCQpM/mT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95836C5A2
	for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768987536; cv=pass; b=bEgAecfE1Dn7UDigR/KHbGBSfIbSonOsAcMOW8blMzysQWf6GEMw/dS+gr6SGxcvcHi/ZUlFB0JSO+Oyllv8BXZRlKOuqY97Z2wXc9Ybj/4zTrXDs6koXRGmtv35Q4s+lxSnQ2ZxE8c6CLsoCJ3zHORFMytDCL0naU9qcZMzSc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768987536; c=relaxed/simple;
	bh=QHugJybIn+A13bUi62gHbfpfGj3a683riqV/MptVDbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXDdIdVWOFpCqTBbA3pxP/7y3KJR9QF6NXkiB6E9asZ8nM9+gW+3cc8yx4BW38BU2H6TCmUs9jr7AFRe70xAh4PgN1w4F81Defr8uBSdxDxLKVWpoBD99yon5KCM1qvxCRbNoqnqiW8whcANahibBE3RBWGq/nedr4UQVjSo+ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCQpM/mT; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso1281216a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 21 Jan 2026 01:25:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768987533; cv=none;
        d=google.com; s=arc-20240605;
        b=Jv79aHzfErq2tcBgE/PCXSgbTs/EhW1tOJ4+UZdreoTxIZDmRuWJXQxRfOvhQXxEeU
         Em2XDy6VM5Vfru/jO9R6jZ0/f2dweo53O0HIBJw/PPEIXdhR4chG4OxaJ0JV1ZEDUPjH
         RzyeS6ChiIp/FjexRw5tDSjWLAdTqSYHPPGUD2paWu7UuUD5MKIeK/pUqnhFcJX55JKY
         lLiALPkHrPoAWjgteerY96JzkaWlfPpC8j7/1cmDrF4vR3apQ4h24gp6gdn7WeMQTb5Y
         ld0xdey6v2OhzJ9Li2pn8wWFq0pxUshKZTgvJOnC0/u37RHNpamy8BAW90ggVa/OxMtp
         SC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AovLu71ODAdo18YutR1H+JltiofIbaBqra9fEuDNW2w=;
        fh=SD9xnvqbik0ks64db4glQyNLTXT7L0heXNlXLtOs+fI=;
        b=LcMOtO9RncPYEaSflDnsp7JnQSUJWu8IutXaazZQe99y0C9SXaZYNFwJBsVKT+2CZt
         z4OVao0iwdGVGGpEuQgIDMyOS9Ug6ouhPQdk6NLEq19EljmgRiL0IT1qIp4u7+GFbLrA
         S5NY1EdWH763/QMxSaFVn6nZn3xbskg300j9ZBYLVfKF/SjhXZuQBnGJHOdIsJqAmRba
         nmKxsZ6cziiIbpV8BK9K3pBRUpmTUiSc3zxW32F8rOpKQmEqcEo6mCdYmgwF3YNghXsd
         7LuwbS6xxEXyzwV3se6nO6K0gFzTQuJX3sXTApnAflbz3KCdCP9OQjX8Not+oSG0slUe
         eq5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768987533; x=1769592333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AovLu71ODAdo18YutR1H+JltiofIbaBqra9fEuDNW2w=;
        b=RCQpM/mTCf0IblwbblMvXor3Ww5iKS14y0hIGBnXAGD2vs5lrrO0h90Uh2ggtKjg7E
         vtkCbY9KgRnVP15t3soAYBliMpAJgZLejOWxcfhpeHpop1dFNC3CGlbidbiPy+Ew8YAh
         TrTY484JamF1DNlfN3QE5BAbi9D+J0l6WbIBM5DX4FzRh5c62ySsUAjaTKwTWpiPlNpz
         1Lkaz8+HbfKPr4IcmUfsxlNY+Gx9CgoOTT263ddJru4F060cSyx5m4N1PdMM8uh/1EiC
         lQUsSJy/4pSMuh0L1c558fphhp1thud85h/8TjLEoLDpNwjTKu3vOxUYvev0wv1Dr1MB
         9A9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768987533; x=1769592333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AovLu71ODAdo18YutR1H+JltiofIbaBqra9fEuDNW2w=;
        b=oXYSqdlIJAGfH+bI9axm/xsvj+bq57HqN7UC/BoGv3EWU06M/qsaptOM+TrGUY6+aS
         1sMf2qS5Bdlk2zB92cKTUifs5fLFWbO3ccllQ5loM68sbICXUBj6NhEGc9nBxyyjRegN
         u42DDI4iiJlilYSduP6PcaedCfpfSAUQ40/70eEvO4oGtq6wkCmot4QCttLhMcqQn9GT
         uITV4fbL1X7/T2xZp149wNMEL6Q3GoX+nrAXJ7utFYIwM5x+Nr8l5F6v9j6qCq1Fj0Nm
         it3R9ICDcEKoBjYqV701Vk8/7iNVmk4WcbsbJKMZNKADmqVDIruqfj0xeo0FZDAIPbXo
         zcyg==
X-Forwarded-Encrypted: i=1; AJvYcCU0TyVZzYd61YTzkgmznH96vNWfN1QpNwGAZo2D5q6vzOKXW8Wk1nErcxw4CdRnf2Wwwj0SSgThAFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu04Q97IA+R6qRdW07Nfcp6ER0kwVY/4rKeP/mXUK4nFE6Q0VG
	o2/YiARRHEcvBV8Pq5kKKBKU6/2iJGL4uMRqdZ++8EIwPXvBEOxf99GrqsBrxbapJ5Fj0REcrhM
	lJ8j7yE7IOjzCbGss/d2TuDemhksoEmQ=
X-Gm-Gg: AZuq6aI1UWpk6jHFarVX80SqzxvVPPOsUR/krLgmV4/65nFQ7YZ+3csEM0O9QsOqleC
	ycRTcqMSvleWZfJ5RtJdoNlXWCOTU69w9SrzM9amg9RYZzZdzshN39X9uc5BAfto2BaYrVzVVKi
	XorA1rXNyDbTj75TVPpaCi+n4ZQgvG8vFRcUp1mplurfohTo3YkcQldlh5QhZFSfHuA7EBukVG8
	CkyyGt3VRjlE2vNQ/Xivc+uvW9hOxqY8A2Ht+edrwkiwg7PQcxNgn4mlypcD979cRNvzQ+/gtBS
	HaPtFyttaKLl2YiS+mQklYoZ15mZQA==
X-Received: by 2002:aa7:c708:0:b0:658:ded:97c8 with SMTP id
 4fb4d7f45d1cf-6580ded999fmr1927493a12.9.1768987532701; Wed, 21 Jan 2026
 01:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121085028.558164-1-amir73il@gmail.com>
In-Reply-To: <20260121085028.558164-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 10:25:21 +0100
X-Gm-Features: AZwV_Qha9OC9bEP43y2_OZbfZ-P8E78cWE_KF4QdlarDuJNF0ODtiZxG6MZgt5E
Message-ID: <CAOQ4uxikycvR4+z34Ox5tuoaFoX3XyUkv6mP53V38b25_tNhQQ@mail.gmail.com>
Subject: Re: [PATCH] nfsd: do not allow exporting of special kernel filesystems
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-18232-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 96752548E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[cc the correct email address for Neil]

On Wed, Jan 21, 2026 at 9:50=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> pidfs and nsfs recently gained support for encode/decode of file handles
> via name_to_handle_at(2)/opan_by_handle_at(2).
>
> These special kernel filesystems have custom ->open() and ->permission()
> export methods, which nfsd does not respect and it was never meant to be
> used for exporting those filesystems by nfsd.
>
> Therefore, do not allow nfsd to export filesystems with custom ->open()
> or ->permission() methods.
>
> Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
> Fixes: 5222470b2fbb3 ("nsfs: support file handles")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfsd/export.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> Christian,
>
> I had enough of the stable file handles discussion [1].
>
> This patch which I already suggested [2] on week ago, states a justified
> technical reason why pidfs and nsfs should not be exported by nfsd,
> so let's use this technical reasoning and stop the philosophic discussion=
s
> about what is a stable file handle is please.
>
> Regarding cgroupfs, we can either deal with it later or not - it is not
> a clear but as pidfs and nsfs which absolutely should be fixed
> retroactively in stable kernels.
>
> If you think that cgroupfs could benefit from "exhaustive" file handles [=
3]
> then we can implement open_by_handle_at(FD_CGROUPFS_ROOT, ... and that
> would classify cgroupfs the same as pidfs and nsfs.
>
> Thanks,
> Amir.
>
> [1] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-0-1a=
247645cef5@kernel.org/
> [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhkaGFtQRzTj2xaf2GJucoAY5=
CGiyUjB=3D8YA2zTbOtFvw@mail.gmail.com/
> [3] https://lore.kernel.org/linux-fsdevel/20250912-work-namespace-v2-29-1=
a247645cef5@kernel.org/
>
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 2a1499f2ad196..232dacac611e9 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -405,6 +405,7 @@ static struct svc_export *svc_export_lookup(struct sv=
c_export *);
>  static int check_export(const struct path *path, int *flags, unsigned ch=
ar *uuid)
>  {
>         struct inode *inode =3D d_inode(path->dentry);
> +       const struct export_operations *nop =3D inode->i_sb->s_export_op;
>
>         /*
>          * We currently export only dirs, regular files, and (for v4
> @@ -422,13 +423,12 @@ static int check_export(const struct path *path, in=
t *flags, unsigned char *uuid
>         if (*flags & NFSEXP_V4ROOT)
>                 *flags |=3D NFSEXP_READONLY;
>
> -       /* There are two requirements on a filesystem to be exportable.
> -        * 1:  We must be able to identify the filesystem from a number.
> -        *       either a device number (so FS_REQUIRES_DEV needed)
> -        *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> -        * 2:  We must be able to find an inode from a filehandle.
> -        *       This means that s_export_op must be set.
> -        * 3: We must not currently be on an idmapped mount.
> +       /*
> +        * The requirements for a filesystem to be exportable:
> +        * 1. The filehandle must identify a filesystem by number
> +        * 2. The filehandle must uniquely identify an inode
> +        * 3. The filesystem must not have custom filehandle open/perm me=
thods
> +        * 4. The requested file must not reside on an idmapped mount
>          */
>         if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
>             !(*flags & NFSEXP_FSID) &&
> @@ -437,11 +437,16 @@ static int check_export(const struct path *path, in=
t *flags, unsigned char *uuid
>                 return -EINVAL;
>         }
>
> -       if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> +       if (!exportfs_can_decode_fh(nop)) {
>                 dprintk("exp_export: export of invalid fs type.\n");
>                 return -EINVAL;
>         }
>
> +       if (nop->open || nop->permission) {
> +               dprintk("exp_export: export of non-standard fs type.\n");
> +               return -EINVAL;
> +       }
> +
>         if (is_idmapped_mnt(path->mnt)) {
>                 dprintk("exp_export: export of idmapped mounts not yet su=
pported.\n");
>                 return -EINVAL;
> --
> 2.52.0
>

