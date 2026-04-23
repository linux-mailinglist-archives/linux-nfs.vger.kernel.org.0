Return-Path: <linux-nfs+bounces-21072-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMbGIROJ6mnU0QIAu9opvQ
	(envelope-from <linux-nfs+bounces-21072-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 23:03:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2836345797B
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 23:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D23F30041D5
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 21:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF2351C2B;
	Thu, 23 Apr 2026 21:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDvAu1SN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215F434CFDA
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 21:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776978190; cv=pass; b=f2kH61EyEaTWp6HN9cXSx9G+QTtqH7aFatycmGtxKePI8X+hSnmwkstgzSeY6Onkz0wfM1AfKRWHU4DutiKV0MAKxz3o33VXrEVPrTzn3NRwdGz9ik1yMqC1Eb5Lq4W3a3+xlHK5xF2zF9Gs9Sl4LxS8skk+PywLqDGSb1gSlpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776978190; c=relaxed/simple;
	bh=xhEH603J8v85yHWTGq8ZnN7Uus4HM3riSO2QoNgy+fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoDCLAnOuvZ+VfsGq6MMrpuF4vBYp0fzwV4njV/seMf/ypdj07ZHHJuN3++GevtbtcVTWvZujh9diOb7goScUTRgcCkoynFy4nAByiNrHMctL2a2dM9BXP5UFXjnZ+m1+j4JGR3bEaPdghICUC6LGPewUj2q2e9mS+qoWQHxq8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDvAu1SN; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acae26e564so81121356d6.2
        for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 14:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776978188; cv=none;
        d=google.com; s=arc-20240605;
        b=blulK+oGO5EpCYWgpyccpU15NDCjRl48cMwAgGQpoM7OCqdKWrAN9LEHpPFopX2WX9
         FwsmodBrBMj8Nhxr+We9oAFIQhfNyMSUu1VHtaYlfz8eF8eMRXUA0ZZFuw/zsMBzj2oA
         OT/sxYqAcbMY2+dZHpftR9bOl1M6Rh32fRcqQqJJsgSxCVpCeqW390N7aP4BO4NRpG4K
         kgwxvbiADIJLhGJJH3cx5f5VGBcLL7jjfKWZeggohw8Vkv5Oh43o6/jYsvIIQmCYfwJa
         0CafoIOWJugw7Jw620Hg6CT8lNhzSmIDx7GD2Vejs5SAsuKjvhaMyFpA8niRNJ5JMpUF
         Ir3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=;
        fh=F+7QpNWSpWKP0JzZPaThDzCBXEM/hNDIybss/NWP5FM=;
        b=ig99B05amvNZxljiuFCN1dhFB0ovHV6eEfRDYIHhjLzi1sq8gaFU8sxVTHHlqrUM5A
         T7V/uqjsk6BLTJPv7lcFUDdxWutSKctnjClLqh+wcZlgk2FgucOf3s7yobDxSJJL5ZSm
         1LowtHBh7wyUWd6/yt95OpDW5SZOi9eyCmAkqRzuT7czXFRa7Om9p4xOXnvzhC45QFvh
         5LsMgMc+aq4PO/Qf90WeNdbCEOjvbMgWl55ku4h114r6P8UDiVuOg5hjpl7PJ+PMtmy3
         mCMw3/cHGCI25b/SgHwGOnuds1lm62eZ+w0RdH+Keo9cFwprg8FoPPiNL/8IbWzlEa5M
         gHVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776978188; x=1777582988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=;
        b=rDvAu1SNNCNFOtPGGZA1Ilm0Le5RC3HqJ0wXokdqmzOLVNi8lHw7GMMZu9w9TKLwL2
         97WG5/8zvZHB8yvJKvWest8upLdKisDZ7H05Ka5/vdYNhsrnM3D9ri/hCBGJJWSYMJ6A
         4aV5pN8ZpW+OvUAVyQXtCxyz+lKlPQ3JSP3K8P+ESur67eGHrRIzYUzsXwVHkCd6yj2/
         ctzXdJjsBXDJTbKbibVy0FNHQzCBCqmL0wFBtBXUGYA9rjTxlgcuc+yyfB6WixhGhej1
         k1hqtskE52BY3YNgHMeEYZ4kRq1QB4GqeTj/Zh+a80rccrsXdmSCnU6wEvXr81Y4Mp/o
         /xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776978188; x=1777582988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PB9D2kfgkJFOe3p8pXvyrrOYHUrSUtT15eUJWPkJgQk=;
        b=W6+y1flGsE4M4cZM0y8l7/jOHh53YtZoLw/MJM3wOiPFxFZrVFtOEB0Ezv3taYzGi1
         XmaaMpuA6dqJDOHSTiUon3+0/HfrbTGjs8Sf4guBIE4+sYXqh7HrbS0vj3MuzP9H5jSo
         ACRJK3LAqG/rGu5PD2d+CxhOmjKeGzkAmy824gRaNkg7+V8tAH/uJRZ7r7tDcNWjUj1P
         sPrtJcx4wpqeepDyJE7KFQzmIb1rCeagYQnF7xL0jQyBqBxXCdFPMq/pOVhNgJCadDD0
         98pKmWum4XJxHe4ThjLkv6MkoLtdHfvnLgEvjO/72RI82MqvWpvvhf7LKTLJrU3aXT0a
         8I4A==
X-Forwarded-Encrypted: i=1; AFNElJ9LWRb9T/CBpaXtyWGqA9PMmhvlB4ZwekwSB2vihh5rwRBWJB08XKZ5545inrllOIfvxKe7dywgLyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhieBLtOBPX7mdKRXQ0o+TkSWMkvoubu5CjWV0mgBg8E9NMJdh
	8hsqWr44NFhWsGt4Hwz7GqQ2iOudh0/6oHTOkcq43TJON2DmGq9UA7pnu8r8H/1znr1Q3FjUXGT
	5KE5/oUOnNVCAK8L81JMvgTju4bVC1TA=
X-Gm-Gg: AeBDiesMJQuQPHQOCQnju5t9+AHCrZBtdNaaaGg4u+ckHmKIA4ecB7xlyc9kYKp3Qfj
	aO+gcFFqnXY+RWQ4mQWCtdGvEG2H0Z0yOpVHeQmvptfWxvTdESGfDZxY99kK02YlOUUXbzvz3EA
	ZWMkgWbf0ct/WMzPMP7O7Akj7xavcdCLS8jg/JSWpe7VJVlACdr4hwzv1kifHY9bQC7YiGm65Mf
	1sX4Zt+TS2AjrfIDG1eTtK26lL/kqbws0+tfNd5ngLPsi3xetjTNHKD1s6lpjwi3pH+wncSyfp/
	hOXCewP+EbI+RqTNmLscqmDaKVk9G/r8ikPOkIy3G4sxtuzBGIE2BT5wK0PV1JQoimSbPxB1bf/
	YDO7n6OGwPF0kwn9Sk41q0YW3KUuKCNqbMTVm0wb+RzKwRL/8DXj76hJxgHEnhD5a6W57MQTdvW
	gGUgcyhBY5sEjdcN80veS37UIgXZaqvmc=
X-Received: by 2002:ad4:5d65:0:b0:8ae:6282:df2e with SMTP id
 6a1803df08f44-8b02822456emr461252066d6.44.1776978187970; Thu, 23 Apr 2026
 14:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423-case-sensitivity-v10-0-c385d674a6cf@oracle.com> <20260423-case-sensitivity-v10-10-c385d674a6cf@oracle.com>
In-Reply-To: <20260423-case-sensitivity-v10-10-c385d674a6cf@oracle.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 23 Apr 2026 16:02:56 -0500
X-Gm-Features: AQROBzDF43-id-Qgk6rRbL0HPyUPTg1w8GYo4-J0uBb2d6IfD5ElWAtE-TtbFxA
Message-ID: <CAH2r5mu1Wg_9tZCjei-xF357UjKR+h6jQr9zey39v59rx9quZQ@mail.gmail.com>
Subject: Re: [PATCH v10 10/17] cifs: Implement fileattr_get for case sensitivity
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp, 
	linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	almaz.alexandrovich@paragon-software.com, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu, 
	adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, trondmy@kernel.org, 
	anna@kernel.org, jaegeuk@kernel.org, chao@kernel.org, hansg@kernel.org, 
	senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>, 
	Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21072-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2836345797B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Should this also be checking if the SMB3.1.1 Linux Extensions or SMB
POSIX Extensions are negotiated (ie the server supports case
sensitivity)?

On Thu, Apr 23, 2026 at 8:20=E2=80=AFAM Chuck Lever <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Upper layers such as NFSD need a way to query whether a filesystem
> handles filenames in a case-sensitive manner. Report CIFS/SMB case
> handling behavior via the FS_XFLAG_CASEFOLD flag.
>
> CIFS servers (typically Windows or Samba) are usually case-insensitive
> but case-preserving, meaning they ignore case during lookups but store
> filenames exactly as provided.
>
> The implementation reports case sensitivity based on the nocase mount
> option, which reflects whether the client expects the server to perform
> case-insensitive comparisons. When nocase is set, the mount is reported
> as case-insensitive.
>
> The callback is registered in all three inode_operations structures
> (directory, file, and symlink) to ensure consistent reporting across
> all inode types.
>
> Acked-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/smb/client/cifsfs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 2025739f070a..9b70ffa3e01d 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -30,6 +30,7 @@
>  #include <linux/xattr.h>
>  #include <linux/mm.h>
>  #include <linux/key-type.h>
> +#include <linux/fileattr.h>
>  #include <uapi/linux/magic.h>
>  #include <net/ipv6.h>
>  #include "cifsfs.h"
> @@ -1199,6 +1200,22 @@ struct file_system_type smb3_fs_type =3D {
>  MODULE_ALIAS_FS("smb3");
>  MODULE_ALIAS("smb3");
>
> +static int cifs_fileattr_get(struct dentry *dentry, struct file_kattr *f=
a)
> +{
> +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(dentry->d_sb);
> +       struct cifs_tcon *tcon =3D cifs_sb_master_tcon(cifs_sb);
> +
> +       /*
> +        * The nocase mount option installs case-insensitive dentry
> +        * operations on this superblock. SMB preserves case on the
> +        * wire and at rest, so the mount matches FS_XFLAG_CASEFOLD
> +        * semantics: case-folded lookup, verbatim storage.
> +        */
> +       if (tcon->nocase)
> +               fa->fsx_xflags |=3D FS_XFLAG_CASEFOLD;
> +       return 0;
> +}
> +
>  const struct inode_operations cifs_dir_inode_ops =3D {
>         .create =3D cifs_create,
>         .atomic_open =3D cifs_atomic_open,
> @@ -1217,6 +1234,7 @@ const struct inode_operations cifs_dir_inode_ops =
=3D {
>         .listxattr =3D cifs_listxattr,
>         .get_acl =3D cifs_get_acl,
>         .set_acl =3D cifs_set_acl,
> +       .fileattr_get =3D cifs_fileattr_get,
>  };
>
>  const struct inode_operations cifs_file_inode_ops =3D {
> @@ -1227,6 +1245,7 @@ const struct inode_operations cifs_file_inode_ops =
=3D {
>         .fiemap =3D cifs_fiemap,
>         .get_acl =3D cifs_get_acl,
>         .set_acl =3D cifs_set_acl,
> +       .fileattr_get =3D cifs_fileattr_get,
>  };
>
>  const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
> @@ -1261,6 +1280,7 @@ const struct inode_operations cifs_symlink_inode_op=
s =3D {
>         .setattr =3D cifs_setattr,
>         .permission =3D cifs_permission,
>         .listxattr =3D cifs_listxattr,
> +       .fileattr_get =3D cifs_fileattr_get,
>  };
>
>  /*
>
> --
> 2.53.0
>
>


--=20
Thanks,

Steve

