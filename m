Return-Path: <linux-nfs+bounces-3791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CED0907CFC
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 21:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E116B2834D1
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 19:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F46F073;
	Thu, 13 Jun 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB1VieHK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A76E5ED
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718308503; cv=none; b=XKXoG078RJrehnDkyGk5GNIQm1sveS6IUXw6u377M8vnouC4TgqXgpAmFMffBzLYLK/cFG7pj3wNw4baxB8L1i0ifjZvuJDjzidZY5FmCpjZayJYBEES2QjZnHx3UZekriZyy8bVsj60kRE8K7QomY9xmlcR7No6paGcn0BccBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718308503; c=relaxed/simple;
	bh=qHVqWLcahKdgxYPKezlDK4auYnKQtwu151xKVA1ui+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=apjNhabEBm695xsLb2ORXuMNwzplNaJDrbdLE4v+KQMIYZmjUCJGXBnZoRcJnhyrjXOZNR9XVCNMiEgPklpKLbTykrqXFRBzILxgx0Gu/L8jlrMB0UQa7hkm7bqYd/znHgKu8QQtWVaItVgx4Dyt3r2cB2b7muFC8R83cltQnV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB1VieHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714F5C2BBFC;
	Thu, 13 Jun 2024 19:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718308502;
	bh=qHVqWLcahKdgxYPKezlDK4auYnKQtwu151xKVA1ui+w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CB1VieHKSkQynipsHDGEPWJkq9qoou5lo/asY/+94AMyOBbCa6fQdKt3MBfDn2oB7
	 zC3xE9JQ/8ycR0UnVpe64UVwZ1LOWX15FNPD+7iUjsktOEpgTMSbBCu6K66hE328/j
	 ggFc0TPmqwNPi+neDPabxog1syOUa/NguFhNly0aCsg9p12PgAdVV/r0NL51we7Ho8
	 hT8sETQu6bgiVPA6H0WJkAKSn5jnw94g9uGZEGTvYujEGQ3e9b1P5LMuaEfAgFwsxX
	 Oj951b9PSjzBZQobilRbAj/Myx8cf1mlFkW/IGDQZtRka9PIdG4f+zZ4ugEpA/nKaY
	 1EdB//4/nTh0g==
Message-ID: <ddb9488389cbb0c9395c3b634d05ed82a59fa604.camel@kernel.org>
Subject: Re: [PATCH 1/3] nfs: Drop pointless check from
 nfs_commit_release_pages()
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>, Trond Myklebust
 <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
Date: Thu, 13 Jun 2024 15:55:01 -0400
In-Reply-To: <20240613082821.849-1-jack@suse.cz>
References: <20240612153022.25454-1-jack@suse.cz>
	 <20240613082821.849-1-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 10:28 +0200, Jan Kara wrote:
> nfss->writeback is updated only when we are ending page writeback and
> at
> that moment we also clear nfss->write_congested. So there's no point
> in
> rechecking congestion state in nfs_commit_release_pages(). Drop the
> pointless check.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> =C2=A0fs/nfs/write.c | 4 ----
> =C2=A01 file changed, 4 deletions(-)
>=20
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index 5fc12a721ec3..c6255d7edd3c 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -1837,7 +1837,6 @@ static void nfs_commit_release_pages(struct
> nfs_commit_data *data)
> =C2=A0	struct nfs_page	*req;
> =C2=A0	int status =3D data->task.tk_status;
> =C2=A0	struct nfs_commit_info cinfo;
> -	struct nfs_server *nfss;
> =C2=A0	struct folio *folio;
> =C2=A0
> =C2=A0	while (!list_empty(&data->pages)) {
> @@ -1880,9 +1879,6 @@ static void nfs_commit_release_pages(struct
> nfs_commit_data *data)
> =C2=A0		/* Latency breaker */
> =C2=A0		cond_resched();
> =C2=A0	}
> -	nfss =3D NFS_SERVER(data->inode);
> -	if (atomic_long_read(&nfss->writeback) <
> NFS_CONGESTION_OFF_THRESH)
> -		nfss->write_congested =3D 0;
> =C2=A0
> =C2=A0	nfs_init_cinfo(&cinfo, data->inode, data->dreq);
> =C2=A0	nfs_commit_end(cinfo.mds);

Reviewed-by: Jeff Layton <jlayton@kernel.org>

