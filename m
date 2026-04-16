Return-Path: <linux-nfs+bounces-20928-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DjwMrM44WmaqgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20928-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 21:29:55 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE15414159
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 21:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4645B302BA5C
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C43A6B80;
	Thu, 16 Apr 2026 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuvgudHs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE1337110
	for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367506; cv=pass; b=rrJq0+t8uCo2dV9KNFE+FmIv/+nL92quEB4nf8gZT38iyUACMHBemNrN9+XqDHIl11LIiL1LLOS/KoH6ObnmuOfqI3JMbRwvKdcguQ7BQgn7r+HSdGvYJegR2TH1C65C+S+82+XhnVvo9TRG7IjWsOV2/zzdHKbX7t7CWNV2hoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367506; c=relaxed/simple;
	bh=YTWAuUgodP4x0SGZZNXpfJHoOQ/Al8dOyWsalMJbeKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jm2CyEBc3TvhuJgA8/qFLihna9idTU2ql257CAyX/egM6uAMHgUIF56mTFFCOqEcyWyh3NCoPPBn62rSladAVHYs7qQmwFaFTY4CsEEmpXACYWAYGUbMqH7quUmiFbGL83bmHw8ohr0OrIswVzLePrfheWOvhabqt9gvHP6ENQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuvgudHs; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9d6c8871c7so1293705866b.1
        for <linux-nfs@vger.kernel.org>; Thu, 16 Apr 2026 12:24:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776367496; cv=none;
        d=google.com; s=arc-20240605;
        b=SYIVT3B6PplwA/7UpE8kI/6RxuRsNkfj94BYxNpc8bKo1xpbCNOH5pOcDduqbElckC
         JUFePWWsOHu1bpYX9YT3NB7sD3MLSs6kD976FqhALYXhv1wN/+Wxs31q+DlRanDy0tUd
         xknJSpCkcjiK61hQ3Aqn2KMlb9vNqq4QQ/z0D/Ej0hvzrGtFIM3hpyV2Jgcw3lj3kIhm
         jV8QoGfd3cqw9IR7LFXuHUYRRxWDB8PD/MW+/U8h5NVszWztE/jusAmDsBv09iItuAfE
         zWHChlDRtTC0p2OheBwmIk54sUd77r8Ra6GpRL95J0Y4+pBgdy7ByO5su088wsVB8q8k
         Mgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9K3ysuZXV4OKgvP6Hz+tr/FztQIKDGUmUgbaHLYQ4fs=;
        fh=fOH6taobcQfA0k7sAOtiXglxcuuGdHccAXVKLNCjKPI=;
        b=MAcp3kde8FMR3uOEyL6aixY5sPVtSSrModbG6tvIpst0E51U53z6g3mrC+yy28DYfZ
         0htLH52gTagXfa3pw56RhwR+0VqWON3btTIWCzSaUhfeqYmMHADaj2yndUUArkj28nBF
         A3Hcj5WorQHVhRuwCjEYOSQL4SZmEN3CmM8fSxpzp17rV3r51bqmU2FfaWmntKjraYNU
         hiWJuWUCAnvPMlYLtjC0U0NVbNcefH1ifZpSTyURE8zOY2rO0LsqqTZGjMwY5i4T+h9P
         Lwk08LdvnNkHVm8r4gGKl6XUjYIVBkTSjp+9lNjY0UfAN+SXrQSSJbUmbY7lg1rG91uv
         2sDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776367496; x=1776972296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K3ysuZXV4OKgvP6Hz+tr/FztQIKDGUmUgbaHLYQ4fs=;
        b=IuvgudHss3pf9xta9CoHzbNM/KkqwvVlbZG1ujAPlUvsEERquMRMCcNKuZB4ePTAM5
         7NtHkTfv5kJNgOXozHtBzx6BeOftPECAFzrLC/Kx+7C6Z+aMX16BAnXG4S26OUfk3WGg
         CWZQvHirIm8BMV/eAS7dQVd+snAopqjN+dWq8LBfZchgH0SFAJBxKZ7twV1lroXi7RqL
         6seCdSS2mS6a+aqyWvZotzTjBpSsVqzQV/ddt5/cyYwOEsyfwdY8ZTvZnZXvtx6xF+FO
         5LV2B5eGbqXEDNgAZKrrj0OIGOZ6Vfb9iUPXy8OI0AkX/Cx2xeQJhF/vFCWfKeI7U4O9
         g8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367496; x=1776972296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9K3ysuZXV4OKgvP6Hz+tr/FztQIKDGUmUgbaHLYQ4fs=;
        b=IrrV1RQy48vrtljMd0Rg0e5ws7fL2cCsPL/MB0jIecDxZvz6jCjQQCQcrbiyPYEDKC
         4zBu6QsFPoW7h1uN65B1OHRkYGfWu2B1xJp9nUync4Y/bFwZIQ6D+TRnsIx0cZk6MmMG
         WMlvxmv6DodCiGbbPuiX7lnN3DD/wp4d+upy9+NK8FT+wXCUo7uoEPUuDIDIhH6G2EJO
         Nd2K5sFoVW4avnlpjQEHWxmuEPOeWgN+6+EUqQAAgQveEnnuus4hhI7AefzS1w4gjTXV
         PfAI/flOo0SpAvvwuRERqiZlJmaohnEnXm8cxuuZAQQTNcotUdYxdegdJlXTLeYHVg3G
         f7pw==
X-Forwarded-Encrypted: i=1; AFNElJ+s0/8Z1LkWP9OZG3elECfQ5dMEUx9lfWz6KJAtIjhcCrl9MPRfQkzZMgDwXaI2fhFG3ik+xj8cIyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPQdsXQuEIOnzK1BM4Z1vx0a8E4K7pNgaFefX7yhwLVNCPb0n
	GliolnKLccP4H+liwRDBvv/OGfs1bRCnqLoV2+9sl9xpwkIqQuK8Lx3zmN8qPVc/xxMvv4sNQNU
	7tnXXj64Fqe10TAZrUC8/BEPqDbbdvgQ=
X-Gm-Gg: AeBDievdn7MsecE1MlXPyb5JCD4qrAEXtHZNzssz6uIfcxEpCs033+aafVY/O562iyI
	YY030kVZgyfJrM4tgPM7QevVhZ8KiKF8PA5ExkHbKE+h0Kc41F5ejsMsUD+VZq4BdcPuBAhSyTF
	6yJw/VmYDHOlXVFEQRMdq5Mo0m0paXaII4zuCR3t3IsLPQdo3nYwnuqyvkq41JoEN9hbt/FG49o
	b/FiHB0FExN/dgsLi0tuYf+b5pqEXvvS9lcWxrqRjABdAQ0mD6/oApv/3Xqy/HWISEvKxkcxyqk
	DV2xoqCbwiDpp+1u6hwhxM2UX+8AuSUQzcgUH0OnPcAdYUvPdk7r36ATWTul9hk=
X-Received: by 2002:a17:907:c002:b0:b9c:34f8:b969 with SMTP id
 a640c23a62f3a-ba3dd6a4727mr34562766b.49.1776367495571; Thu, 16 Apr 2026
 12:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org> <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Apr 2026 21:24:44 +0200
X-Gm-Features: AQROBzDkNbo1A8vs3cuxkYPYXRSUZziZymY7H6-6on9ynU_2C3mPiqqxTu3HE2k
Message-ID: <CAOQ4uxg2jHxCi77A1DGtopjZHsTNg4etdboW2GjL85N3uc_KqQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/28] fsnotify: add FSNOTIFY_EVENT_RENAME data type
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20928-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1EE15414159
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 7:35=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add a new fsnotify_rename_data struct and FSNOTIFY_EVENT_RENAME data
> type that carries both the moved dentry and the inode that was
> overwritten by the rename (if any).
>
> Update fsnotify_data_inode(), fsnotify_data_dentry(), and
> fsnotify_data_sb() to handle the new type, and add a new
> fsnotify_data_rename_target() helper for extracting the overwritten
> target inode.
>
> Update fsnotify_move() to use the new data type for FS_RENAME and
> FS_MOVED_TO events, passing the overwritten target inode through the
> event data. FS_MOVED_FROM is unchanged since the source directory
> doesn't need overwrite information.
>
> This is done so that fsnotify consumers like nfsd can atomically
> observe the overwritten file when a rename replaces an existing entry,
> without needing a separate FS_DELETE event.
>
> Assisted-by: Claude (Anthropic Claude Code)
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/fsnotify.h         |  8 ++++++--
>  include/linux/fsnotify_backend.h | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)

It is strange to me that the NFS protocol needs to report the overwritten
node in the same event of the rename, but oh well, fine by me.

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 079c18bcdbde..bda798bc67bc 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -257,6 +257,10 @@ static inline void fsnotify_move(struct inode *old_d=
ir, struct inode *new_dir,
>         __u32 new_dir_mask =3D FS_MOVED_TO;
>         __u32 rename_mask =3D FS_RENAME;
>         const struct qstr *new_name =3D &moved->d_name;
> +       struct fsnotify_rename_data rd =3D {
> +               .moved =3D moved,
> +               .target =3D target,
> +       };
>
>         if (isdir) {
>                 old_dir_mask |=3D FS_ISDIR;
> @@ -265,12 +269,12 @@ static inline void fsnotify_move(struct inode *old_=
dir, struct inode *new_dir,
>         }
>
>         /* Event with information about both old and new parent+name */
> -       fsnotify_name(rename_mask, moved, FSNOTIFY_EVENT_DENTRY,
> +       fsnotify_name(rename_mask, &rd, FSNOTIFY_EVENT_RENAME,
>                       old_dir, old_name, 0);
>
>         fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
>                       old_dir, old_name, fs_cookie);
> -       fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
> +       fsnotify_name(new_dir_mask, &rd, FSNOTIFY_EVENT_RENAME,
>                       new_dir, new_name, fs_cookie);
>
>         if (target)
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 66e185bd1b1b..f8c8fb7f34ae 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -311,6 +311,7 @@ enum fsnotify_data_type {
>         FSNOTIFY_EVENT_DENTRY,
>         FSNOTIFY_EVENT_MNT,
>         FSNOTIFY_EVENT_ERROR,
> +       FSNOTIFY_EVENT_RENAME,
>  };
>
>  struct fs_error_report {
> @@ -335,6 +336,11 @@ struct fsnotify_mnt {
>         u64 mnt_id;
>  };
>
> +struct fsnotify_rename_data {
> +       struct dentry *moved;   /* the dentry that was renamed */
> +       struct inode *target;   /* inode overwritten by rename, or NULL *=
/
> +};
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int da=
ta_type)
>  {
>         switch (data_type) {
> @@ -348,6 +354,8 @@ static inline struct inode *fsnotify_data_inode(const=
 void *data, int data_type)
>                 return d_inode(file_range_path(data)->dentry);
>         case FSNOTIFY_EVENT_ERROR:
>                 return ((struct fs_error_report *)data)->inode;
> +       case FSNOTIFY_EVENT_RENAME:
> +               return d_inode(((const struct fsnotify_rename_data *)data=
)->moved);
>         default:
>                 return NULL;
>         }
> @@ -363,6 +371,8 @@ static inline struct dentry *fsnotify_data_dentry(con=
st void *data, int data_typ
>                 return ((const struct path *)data)->dentry;
>         case FSNOTIFY_EVENT_FILE_RANGE:
>                 return file_range_path(data)->dentry;
> +       case FSNOTIFY_EVENT_RENAME:
> +               return ((struct fsnotify_rename_data *)data)->moved;
>         default:
>                 return NULL;
>         }
> @@ -395,6 +405,8 @@ static inline struct super_block *fsnotify_data_sb(co=
nst void *data,
>                 return file_range_path(data)->dentry->d_sb;
>         case FSNOTIFY_EVENT_ERROR:
>                 return ((struct fs_error_report *) data)->sb;
> +       case FSNOTIFY_EVENT_RENAME:
> +               return ((const struct fsnotify_rename_data *)data)->moved=
->d_sb;
>         default:
>                 return NULL;
>         }
> @@ -430,6 +442,14 @@ static inline struct fs_error_report *fsnotify_data_=
error_report(
>         }
>  }
>
> +static inline struct inode *fsnotify_data_rename_target(const void *data=
,
> +                                                       int data_type)
> +{
> +       if (data_type =3D=3D FSNOTIFY_EVENT_RENAME)
> +               return ((const struct fsnotify_rename_data *)data)->targe=
t;
> +       return NULL;
> +}
> +
>  static inline const struct file_range *fsnotify_data_file_range(
>                                                         const void *data,
>                                                         int data_type)
>
> --
> 2.53.0
>

