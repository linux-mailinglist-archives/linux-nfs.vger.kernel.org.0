Return-Path: <linux-nfs+bounces-9570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC9A1B3A9
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 11:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C3077A1241
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11B1CEE8E;
	Fri, 24 Jan 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6V+5idt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E187A155759
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715378; cv=none; b=oZm7QBJqQfuGZ9slV2j+pZ+8sTxZ986dlW2RmDc7Nd4LA4JbsJUPgrZvUyz+G7XLrutcvZ0g2asck/rZZuQmdusrYr0BNSTMHFcyJiBmKC3pyhfne1wunm8zj/2dQW5KCpnbKkuLBzkLjygX+0qedv/dDryuD9TFuljUirllZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715378; c=relaxed/simple;
	bh=aVsDP5dM3APKtRJKuELHKwJyRgd1+RzasVEgG55lyD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLChf4SCrxhpJRFQeVfx6Ik6lcJPwxGTde4bwu75ed3rmYNZnIbQUpn8Htu74FM79KeHaGMI+UZAajz+iceV79fL4cBHeiP96/s5LGVwVLigEwjv0/EJ6UQLzD5psrf0jWhLEjY5TmWVhH2ZVHcYzWahT6SpHOa0Hn7JA6mk6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6V+5idt; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so3785736a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 02:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737715375; x=1738320175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwsxtSdk4KNSUBdxKOfR63ssLEWfYLhnH849c9s4R78=;
        b=X6V+5idt+coaxaOo+pMR2UjqzVKCJzkcP4T/4dbWWmLG6bd/6P3rvrr1J99wssGMrT
         IEsbrpzsn73Yq48rFMAlIuEBBSCJOBxkCLgehxMjgqha/Iidave28Z2rEVoE+oXOT9QH
         v9XCjenOIWG8uN1S7edITSdcblbSaHesk5sMmk6LUteCmx85VzXMqAEkAM4m4jEb4EOM
         QbjOq+RXd8cQQU5G7Sz16wE51PmmQ8CFPzfubsXxG5rb1q6rx3isaoiRDuWs8wkpvIf1
         sNDmoUu4XW0Pq8BkOkvL5aAowIKQO50hTGlKhi8d3H8tefl5faZfWC5s3KfghMEOEtUm
         ANwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737715375; x=1738320175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwsxtSdk4KNSUBdxKOfR63ssLEWfYLhnH849c9s4R78=;
        b=Px3/DW0nJyG7OMbzo6AyEvAh9dxqkPEtCPNh/vt3J/I+4xDVUrVgE0yO31UBODnDUQ
         MB7pfPSXIndXIWt+ntPWNC5g/quueILxVddgetRhGV2FKV2Yv1wj0Z9PHw8ZVlaJUDlg
         ZKOt4U42HBil8eiOJQsUp5Az7am1x+MgAAiJQbQBPSvbfPZJMZJgdeWjD0dUqHR4UUkv
         X3oQ3AhHb0qYyYlGalwpLISqeHrUdSYWCb8tS7Vbfe/hrWQMJ5s7gFnArHLLLzMNnDqY
         tGBzNgdLRS0Fmvik/qHtK7tQHQHdSaVN4LsKPEJtF56vLbV+LcUH8qsOrIK6O5ILW6uB
         KoMg==
X-Forwarded-Encrypted: i=1; AJvYcCXsFcjoc7AiXW5STb1Q6SpGTtW6eDnMOzDG8AxAvZRTVCJx5wcEgMCAMeUIYKrm5mQT8hFLO826QoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QnDir+pSESXCEY0VbyEB7AItzTPaLieDJ2dNDpn/x4w019H8
	rjQ8L50nnU7fH/djp5NZdlAzFPLLL9knAJIbxi7mbSp3YbP7aJD3YAquM3AtGh0FBjyiYSuODjL
	ELbcxa1qVfWD5+Sd/I5iET87Yioc=
X-Gm-Gg: ASbGncucP3G6PXNriHo1OQcyeZ0BEUtNQPBSoire3gOVMx/XBtcr1nEscpUtCtakm7w
	tJr8wTNCoqbVzlwA4swSfMRg/Qwuj/q4whIZl8ZTyzccoCvEhugb+7tou0JpZIQ==
X-Google-Smtp-Source: AGHT+IGPlgwDmXqIvTXt5lOTI/gooy/xG7LAFEl1HCKq/pjpYegQN+9OeLuHvxmRb9AymSVVJDhVx3dfQRi5XHKTch4=
X-Received: by 2002:a17:907:da0:b0:aab:cdbd:595a with SMTP id
 a640c23a62f3a-ab38b0a12bcmr2796359266b.3.1737715374764; Fri, 24 Jan 2025
 02:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123195242.1378601-1-cel@kernel.org> <20250123195242.1378601-3-cel@kernel.org>
 <8565d8e45073f76705a23e00eedd4d911f24a360.camel@kernel.org> <2a55bf53-dc35-49bf-bcd0-b76999e1ef34@oracle.com>
In-Reply-To: <2a55bf53-dc35-49bf-bcd0-b76999e1ef34@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Jan 2025 11:42:43 +0100
X-Gm-Features: AWEUYZmW4TfKj574icrBWjHl25cDwB6kxXA-xcK_QwcnxAXfOf5zCwaqIvvTjTc
Message-ID: <CAOQ4uxhZByoddDLqFnSfSri7wBLFnVORjh+8t6FfekHh8d4MOA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] NFSD: Never return NFS4ERR_FILE_OPEN when
 removing a directory
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, cel@kernel.org, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, Trond Myklebust <trondmy@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 10:07=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 1/23/25 3:43 PM, Jeff Layton wrote:
> > On Thu, 2025-01-23 at 14:52 -0500, cel@kernel.org wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> RFC 8881 Section 18.25.4 paragraph 5 tells us that the server
> >> should return NFS4ERR_FILE_OPEN only if the target object is an
> >> opened file. This suggests that returning this status when removing
> >> a directory will confuse NFS clients.
> >>
> >> This is a version-specific issue; nfsd_proc_remove/rmdir() and
> >> nfsd3_proc_remove/rmdir() already return nfserr_access as
> >> appropriate.
> >>
> >> Unfortunately there is no quick way for nfsd4_remove() to determine
> >> whether the target object is a file or not, so the check is done in
> >> to nfsd_unlink() for now.
> >>
> >> Reported-by: Trond Myklebust <trondmy@hammerspace.com>
> >> Fixes: 466e16f0920f ("nfsd: check for EBUSY from vfs_rmdir/vfs_unink."=
)
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>   fs/nfsd/vfs.c | 24 ++++++++++++++++++------
> >>   1 file changed, 18 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> >> index 2d8e27c225f9..3ead7fb3bf04 100644
> >> --- a/fs/nfsd/vfs.c
> >> +++ b/fs/nfsd/vfs.c
> >> @@ -1931,9 +1931,17 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_=
fh *ffhp, char *fname, int flen,
> >>      return err;
> >>   }
> >>
> >> -/*
> >> - * Unlink a file or directory
> >> - * N.B. After this call fhp needs an fh_put
> >> +/**
> >> + * nfsd_unlink - remove a directory entry
> >> + * @rqstp: RPC transaction context
> >> + * @fhp: the file handle of the parent directory to be modified
> >> + * @type: enforced file type of the object to be removed
> >> + * @fname: the name of directory entry to be removed
> >> + * @flen: length of @fname in octets
> >> + *
> >> + * After this call fhp needs an fh_put.
> >> + *
> >> + * Returns a generic NFS status code in network byte-order.
> >>    */
> >>   __be32
> >>   nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
> >> @@ -2007,10 +2015,14 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc=
_fh *fhp, int type,
> >>      fh_drop_write(fhp);
> >>   out_nfserr:
> >>      if (host_err =3D=3D -EBUSY) {
> >> -            /* name is mounted-on. There is no perfect
> >> -             * error status.
> >> +            /*
> >> +             * See RFC 8881 Section 18.25.4 para 4: NFSv4 REMOVE
> >> +             * distinguishes between reg file and dir.
> >>               */
> >> -            err =3D nfserr_file_open;
> >> +            if (type !=3D S_IFDIR)
> >
> > Should that be "if (type =3D=3D S_ISREG)" instead? What if the inode is=
 a
> > named pipe or device file? I'm not sure you can ever get EBUSY with
> > those, but in case you can, what's the right error in those cases?
>
> Check out nfsd_unlink()'s callers to see what they pass as the type
> parameter. Unfortunately we have to compare against S_IFDIR here.
>

Not exactly. nfsd4_remove() is the only caller that needs to get
nfserr_file_open and this caller calls with type =3D 0, so type here
is going to be the actual type of the inode and (type =3D=3D S_ISREG)
would be correct. No?

Thanks,
Amir.

