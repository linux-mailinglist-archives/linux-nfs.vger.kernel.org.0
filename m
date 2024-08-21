Return-Path: <linux-nfs+bounces-5548-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF1A95A54B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 21:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C7E1C2176C
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 19:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE94816849A;
	Wed, 21 Aug 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAdC/Wwe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868215C159
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 19:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268656; cv=none; b=Dt0oXwsCflegREYZk5nPAthZb8sh+eIGORUucFaS9AA6jLUkwkxvnzPCNd03PWI+QT7Z3kRoUGsy0Is2arpPhzHIJeH4BU7LlLcXOMMFAAHk+hxKujEYFy/PHedcz4CTU8cXY1thIKfKoCWQqSnTTlFGwvBDGLEKWpRYH5dUZ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268656; c=relaxed/simple;
	bh=9U2VIUIxeDvHFLBYvPFr91tZAWSNVISdcKow2CiQnGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CoH3b5TdBK+qI8NUk8LWlC7ugjc8drvumkLxnG+XmCAP4Xi1dEUFwsXMf4QYFNm2BUb3aVSti52+N1mzvcBHlWIq1ElDLFKnCmGHYwmGLpgYltzpDz8e/NNs0kjdLrK6VfgC/hOW9/kyp3q1XZupizuydmbEoQ4dBQWNvbTsitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAdC/Wwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E327C32781
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724268656;
	bh=9U2VIUIxeDvHFLBYvPFr91tZAWSNVISdcKow2CiQnGc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lAdC/Wweg9xgaW3wS0w0QQHDJbuaFsXGi2YN3OqrG5GaftYJe0XrqBHqvozGv4hmV
	 soaqGr1WGLSAbjwCmL5F4clMtDL52YOX8sAP2nXFB/hQEaNvOAjvreDnLA2v40gWxV
	 AKPPv9c1VzhwAwKjTL+Fwz+9pS4iJrzBt5GIUKtye6hJ7uvZUJKpHqQ1QIuQ28sw2B
	 AzyJw9TDrlNJyG+d8FIGgSUhpFSNq0a+DgwT116tpb6xihRBeyeR2/ZTVbXEudGyt+
	 1S3BIdcWVyOgc7sRCQiaBF1Miq0613gwcPjlIcjj3lpZ+sQKD4lBRPyD+hvQ7qsV00
	 CN8bz61N7kjGA==
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-451b7e1d157so491371cf.3
        for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 12:30:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCUlSHs868vIk8aRvS/ZxqNFUYv/drVWW/DB2wCuqzbtqrysB2ygYq3xDLD6AbUB1tTMd+1HyGU3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGB/hz9vjcSWroIICt72o4Qnr+xhtugV8OjFc7RWxEzLm7xaOB
	2r9SvDiABbt34eCF+Oe+Wbo51Pgfs9K3+XykrgOOzcsCSCoZ9HpNSUOon8MRKlFq5twY0HocQN/
	QrKMFjlQawJiNneTgdrP5GzIn0Os=
X-Google-Smtp-Source: AGHT+IGjrVXdO2brbY7zAtD9LVM7i05J1KIBgdKH1/jsp+kLRjegQxypkY1pSmBnQGe7f5U3q1S7gknFxCLUTiB/a88=
X-Received: by 2002:a05:622a:40ca:b0:447:f922:64fd with SMTP id
 d75a77b69052e-454f2242e26mr37529191cf.35.1724268655488; Wed, 21 Aug 2024
 12:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815141841.29620-1-jlayton@kernel.org> <ddf1b7a06b9f67635a42b57d2c7e1042a9eeffb2.camel@kernel.org>
In-Reply-To: <ddf1b7a06b9f67635a42b57d2c7e1042a9eeffb2.camel@kernel.org>
From: Anna Schumaker <anna@kernel.org>
Date: Wed, 21 Aug 2024 15:30:39 -0400
X-Gmail-Original-Message-ID: <CAFX2JfkLXvWL63+vwy2+eh7aC7-TrK0VZvkFUjnyxyQNndUxCw@mail.gmail.com>
Message-ID: <CAFX2JfkLXvWL63+vwy2+eh7aC7-TrK0VZvkFUjnyxyQNndUxCw@mail.gmail.com>
Subject: Re: [PATCH] nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS
To: Jeff Layton <jlayton@kernel.org>
Cc: trondmy@kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 8:20=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Thu, 2024-08-15 at 10:18 -0400, Jeff Layton wrote:
> > The client doesn't properly request FATTR4_OPEN_ARGUMENTS in the initia=
l
> > SERVER_CAPS getattr. Add FATTR4_WORD2_OPEN_ARGUMENTS to the initial
> > request.
> >
> > Fixes: 707f13b3d081 (NFSv4: Add support for the FATTR4_OPEN_ARGUMENTS a=
ttribute)
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfs/nfs4proc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> > index 8883016c551c..39ad7780986c 100644
> > --- a/fs/nfs/nfs4proc.c
> > +++ b/fs/nfs/nfs4proc.c
> > @@ -3931,7 +3931,7 @@ static int _nfs4_server_capabilities(struct nfs_s=
erver *server, struct nfs_fh *f
> >                    FATTR4_WORD0_CASE_INSENSITIVE |
> >                    FATTR4_WORD0_CASE_PRESERVING;
> >       if (minorversion)
> > -             bitmask[2] =3D FATTR4_WORD2_SUPPATTR_EXCLCREAT;
> > +             bitmask[2] =3D FATTR4_WORD2_SUPPATTR_EXCLCREAT | FATTR4_W=
ORD2_OPEN_ARGUMENTS;
> >
> >       status =3D nfs4_call_sync(server->client, server, &msg, &args.seq=
_args, &res.seq_res, 0);
> >       if (status =3D=3D 0) {
>
> Ping? It would be nice to have this fixed before v6.11 ships.

This and your other patch both look good to me. I'll try to get out a
bugfixes pull request by the end of the week!

Anna

> --
> Jeff Layton <jlayton@kernel.org>

