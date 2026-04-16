Return-Path: <linux-nfs+bounces-20929-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKwwEwVM4WmDrQAAu9opvQ
	(envelope-from <linux-nfs+bounces-20929-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 22:52:21 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B13C5414B97
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 22:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97F79304978F
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2026 20:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16138E11A;
	Thu, 16 Apr 2026 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKesMjhI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95859361DB1;
	Thu, 16 Apr 2026 20:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776372738; cv=none; b=Js7jcmkmlJ1XA6cEQkTEL0sV4o7d94dfvHSPQ+eUjrDqoobtmVgsRrx92QIX+J6Zet1Xbya7FXtFK9iBGdiGVYdrwXSntfGsPHpYhNoWi0MaHeI5FLcknpEgkjoluQMO7akvFt/3dl15/NFeUkYH6t4b08B2QorQGJ/Qpfz0E30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776372738; c=relaxed/simple;
	bh=VHRi7NI74kLtq+S0agOteKx+vYNdF5NC1WWpOKC4t7w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIH9FqmAal9uG58upBd+SkK00j7J4s5gp7HNTur5QG/4sbuJUEq2Fb9w7pN8/9aEQFvv8nEe9Qt0qd2L4WjBmleQ+8Y1KQVmdKNSATBylx87DrjG4whIjcbdqV77fe27JaNJ51UUH9xLS2Ol5CYQX4A6AXnYiQhS2udRR3S3q0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKesMjhI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850C6C2BCAF;
	Thu, 16 Apr 2026 20:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776372738;
	bh=VHRi7NI74kLtq+S0agOteKx+vYNdF5NC1WWpOKC4t7w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=OKesMjhIr8NDvNkDBRKHrk2Z9KUxpVJsPdIDCklZ6HMuSksv/thmUJ4MuE7aMhsg0
	 Lc0ECsX4QLXrm9WuDa0ODgPHQSEOHdzmZUfFQTKBI2B+xXLG+c8qkrawR2o9wEv5K8
	 y+27fVS5jUKeZEik2FXGIqwUj+wvO9wiqR+Cf+vqrrEXppj6v2OAR3rFm419zF0JSC
	 vigiXltqUWAJluqKXh9zR1BnKKHDlPCVV08GGncnm+8wdu8fNtwvb0zXYpLORhn9rO
	 4mnnx8pgCNZMBPjW9gFl++QiqRE4i1zGv/vubKBzcb6Af+pTdtHFtVL9if3kxwNnaQ
	 gc/tdPcA2hiAg==
Message-ID: <776f0804a98a62461f867eb69e3ddada140e0861.camel@kernel.org>
Subject: Re: [PATCH v2 07/28] fsnotify: add FSNOTIFY_EVENT_RENAME data type
From: Jeff Layton <jlayton@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner	
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chuck Lever	
 <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan	 <skhan@linuxfoundation.org>, NeilBrown
 <neil@brown.name>, Olga Kornievskaia	 <okorniev@redhat.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,  Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Calum Mackay
 <calum.mackay@oracle.com>, 	linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, 	linux-nfs@vger.kernel.org
Date: Thu, 16 Apr 2026 13:52:16 -0700
In-Reply-To: <CAOQ4uxg2jHxCi77A1DGtopjZHsTNg4etdboW2GjL85N3uc_KqQ@mail.gmail.com>
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org>
	 <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
	 <CAOQ4uxg2jHxCi77A1DGtopjZHsTNg4etdboW2GjL85N3uc_KqQ@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20929-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B13C5414B97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-16 at 21:24 +0200, Amir Goldstein wrote:
> On Thu, Apr 16, 2026 at 7:35=E2=80=AFPM Jeff Layton <jlayton@kernel.org> =
wrote:
> >=20
> > Add a new fsnotify_rename_data struct and FSNOTIFY_EVENT_RENAME data
> > type that carries both the moved dentry and the inode that was
> > overwritten by the rename (if any).
> >=20
> > Update fsnotify_data_inode(), fsnotify_data_dentry(), and
> > fsnotify_data_sb() to handle the new type, and add a new
> > fsnotify_data_rename_target() helper for extracting the overwritten
> > target inode.
> >=20
> > Update fsnotify_move() to use the new data type for FS_RENAME and
> > FS_MOVED_TO events, passing the overwritten target inode through the
> > event data. FS_MOVED_FROM is unchanged since the source directory
> > doesn't need overwrite information.
> >=20
> > This is done so that fsnotify consumers like nfsd can atomically
> > observe the overwritten file when a rename replaces an existing entry,
> > without needing a separate FS_DELETE event.
> >=20
> > Assisted-by: Claude (Anthropic Claude Code)
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  include/linux/fsnotify.h         |  8 ++++++--
> >  include/linux/fsnotify_backend.h | 20 ++++++++++++++++++++
> >  2 files changed, 26 insertions(+), 2 deletions(-)
>=20
> It is strange to me that the NFS protocol needs to report the overwritten
> node in the same event of the rename, but oh well, fine by me.
>=20

Yeah, it's not very useful, but the protocol requires it. Unfortunately
RFC5661 was written before anyone had made a real implementation of
directory delegations. If we were rewriting it today, we'd probably
make that info optional.

> Feel free to add:
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>=20
>=20

Thanks, Amir!

> >=20
> > diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> > index 079c18bcdbde..bda798bc67bc 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -257,6 +257,10 @@ static inline void fsnotify_move(struct inode *old=
_dir, struct inode *new_dir,
> >         __u32 new_dir_mask =3D FS_MOVED_TO;
> >         __u32 rename_mask =3D FS_RENAME;
> >         const struct qstr *new_name =3D &moved->d_name;
> > +       struct fsnotify_rename_data rd =3D {
> > +               .moved =3D moved,
> > +               .target =3D target,
> > +       };
> >=20
> >         if (isdir) {
> >                 old_dir_mask |=3D FS_ISDIR;
> > @@ -265,12 +269,12 @@ static inline void fsnotify_move(struct inode *ol=
d_dir, struct inode *new_dir,
> >         }
> >=20
> >         /* Event with information about both old and new parent+name */
> > -       fsnotify_name(rename_mask, moved, FSNOTIFY_EVENT_DENTRY,
> > +       fsnotify_name(rename_mask, &rd, FSNOTIFY_EVENT_RENAME,
> >                       old_dir, old_name, 0);
> >=20
> >         fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
> >                       old_dir, old_name, fs_cookie);
> > -       fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
> > +       fsnotify_name(new_dir_mask, &rd, FSNOTIFY_EVENT_RENAME,
> >                       new_dir, new_name, fs_cookie);
> >=20
> >         if (target)
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_=
backend.h
> > index 66e185bd1b1b..f8c8fb7f34ae 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -311,6 +311,7 @@ enum fsnotify_data_type {
> >         FSNOTIFY_EVENT_DENTRY,
> >         FSNOTIFY_EVENT_MNT,
> >         FSNOTIFY_EVENT_ERROR,
> > +       FSNOTIFY_EVENT_RENAME,
> >  };
> >=20
> >  struct fs_error_report {
> > @@ -335,6 +336,11 @@ struct fsnotify_mnt {
> >         u64 mnt_id;
> >  };
> >=20
> > +struct fsnotify_rename_data {
> > +       struct dentry *moved;   /* the dentry that was renamed */
> > +       struct inode *target;   /* inode overwritten by rename, or NULL=
 */
> > +};
> > +
> >  static inline struct inode *fsnotify_data_inode(const void *data, int =
data_type)
> >  {
> >         switch (data_type) {
> > @@ -348,6 +354,8 @@ static inline struct inode *fsnotify_data_inode(con=
st void *data, int data_type)
> >                 return d_inode(file_range_path(data)->dentry);
> >         case FSNOTIFY_EVENT_ERROR:
> >                 return ((struct fs_error_report *)data)->inode;
> > +       case FSNOTIFY_EVENT_RENAME:
> > +               return d_inode(((const struct fsnotify_rename_data *)da=
ta)->moved);
> >         default:
> >                 return NULL;
> >         }
> > @@ -363,6 +371,8 @@ static inline struct dentry *fsnotify_data_dentry(c=
onst void *data, int data_typ
> >                 return ((const struct path *)data)->dentry;
> >         case FSNOTIFY_EVENT_FILE_RANGE:
> >                 return file_range_path(data)->dentry;
> > +       case FSNOTIFY_EVENT_RENAME:
> > +               return ((struct fsnotify_rename_data *)data)->moved;
> >         default:
> >                 return NULL;
> >         }
> > @@ -395,6 +405,8 @@ static inline struct super_block *fsnotify_data_sb(=
const void *data,
> >                 return file_range_path(data)->dentry->d_sb;
> >         case FSNOTIFY_EVENT_ERROR:
> >                 return ((struct fs_error_report *) data)->sb;
> > +       case FSNOTIFY_EVENT_RENAME:
> > +               return ((const struct fsnotify_rename_data *)data)->mov=
ed->d_sb;
> >         default:
> >                 return NULL;
> >         }
> > @@ -430,6 +442,14 @@ static inline struct fs_error_report *fsnotify_dat=
a_error_report(
> >         }
> >  }
> >=20
> > +static inline struct inode *fsnotify_data_rename_target(const void *da=
ta,
> > +                                                       int data_type)
> > +{
> > +       if (data_type =3D=3D FSNOTIFY_EVENT_RENAME)
> > +               return ((const struct fsnotify_rename_data *)data)->tar=
get;
> > +       return NULL;
> > +}
> > +
> >  static inline const struct file_range *fsnotify_data_file_range(
> >                                                         const void *dat=
a,
> >                                                         int data_type)
> >=20
> > --
> > 2.53.0
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

