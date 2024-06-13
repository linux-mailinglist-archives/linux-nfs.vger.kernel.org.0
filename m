Return-Path: <linux-nfs+bounces-3793-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5C907D1A
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 22:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0AA1F26D7E
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 20:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BBE76F17;
	Thu, 13 Jun 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ukjNILCS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422457C8D
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309054; cv=none; b=We76Md15Ad04LA4VeAD0zkgyc3pO+UTHie6zFlf7e0XgVf85ZPT7hKEEg2FYxm1ZabpuJmXrGI4Fx756+t2TnUpCVSg5bOs+dU2yqh9OLmOXJMa2Eb3w/cSqfLMNxRFuamAaCEH0Iec9lZclom6JUZcvB5C/Q1AurA6l2o0lUac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309054; c=relaxed/simple;
	bh=+zfe+5DTXRSlprFCd15kKynaWKu4n3mT8VFOxdeojxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WTdUHdEmmhfAMd1wpHKo8hsqvd+7KL0qRih6jfQ6+7nPeknZg25kKKdTYJfDfkNvc0o+LGeOE0ahuEmahmvFk8JgSYvSytphnvdpvAu58zJC+Nqq1X7/A2lblRugJNmxm6bJM7G2h7igula/huDJwDsaI1RA2O0sHBRWNHKzpt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ukjNILCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18B2C2BBFC;
	Thu, 13 Jun 2024 20:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718309054;
	bh=+zfe+5DTXRSlprFCd15kKynaWKu4n3mT8VFOxdeojxo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ukjNILCSDK6wGnKQnQA6PJL2U7YhcS4eahHr0NBOFp7d6bQM0LQSbbBRhBJ5j1bPm
	 9A8B89Wmgv/IHDDWFqgFsY83lj3TaR0OAAzHqIEAGfn1I1UIy75QW09ZolqEQ+fL9k
	 h+jMTJzUf0qZL1rZOdrGI2QKOQICwADdXWW/UjScwyYo0BklVROrDTiIWzO66oVKkl
	 cK5MEo4E221u8YBgRVzUj5PVlxe7ddAqmJo5yTh0Uvyuf/Uoo0WsmAMfobWhU3dQnx
	 JVtp3S3NTuI/dD4loVtl8B83VrKP3qG+vL4H65yfE5v2khkHHnsMK7Yn48Rb/sVcCf
	 x/maxdoqbNQiA==
Message-ID: <fe224e6691204c200f9dced6aa56380cb4ddb3e6.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfs: Block on write congestion
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>, Trond Myklebust
 <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>
Date: Thu, 13 Jun 2024 16:04:12 -0400
In-Reply-To: <20240613082821.849-3-jack@suse.cz>
References: <20240612153022.25454-1-jack@suse.cz>
	 <20240613082821.849-3-jack@suse.cz>
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
> Commit 6df25e58532b ("nfs: remove reliance on bdi congestion")
> introduced NFS-private solution for limiting number of writes
> outstanding against a particular server. Unlike previous bdi congestion
> this algorithm actually works and limits number of outstanding writeback
> pages to nfs_congestion_kb which scales with amount of client's memory
> and is capped at 256 MB. As a result some workloads such as random
> buffered writes over NFS got slower (from ~170 MB/s to ~126 MB/s). The
> fio command to reproduce is:
>=20

That 256M cap was set back in 2007. I wonder if we ought to reconsider
that. It might be worth experimenting these days with a higher cap on
larger machines. Might that improve throughput even more?

> fio --direct=3D0 --ioengine=3Dsync --thread --invalidate=3D1 --group_repo=
rting=3D1
> =C2=A0 --runtime=3D300 --fallocate=3Dposix --ramp_time=3D10 --new_group -=
-rw=3Drandwrite
> =C2=A0 --size=3D64256m --numjobs=3D4 --bs=3D4k --fsync_on_close=3D1 --end=
_fsync=3D1
>=20
> This happens because the client sends ~256 MB worth of dirty pages to
> the server and any further background writeback request is ignored until
> the number of writeback pages gets below the threshold of 192 MB. By the
> time this happens and clients decides to trigger another round of
> writeback, the server often has no pages to write and the disk is idle.
>=20
> To fix this problem and make the client react faster to eased congestion
> of the server by blocking waiting for congestion to resolve instead of
> aborting writeback. This improves the random 4k buffered write
> throughput to 184 MB/s.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
> =C2=A0fs/nfs/client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> =C2=A0fs/nfs/write.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 12 ++++++++----
> =C2=A0include/linux/nfs_fs_sb.h |=C2=A0 1 +
> =C2=A03 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 3b252dceebf5..8286edd6062d 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -994,6 +994,7 @@ struct nfs_server *nfs_alloc_server(void)
> =C2=A0
> =C2=A0	server->change_attr_type =3D NFS4_CHANGE_TYPE_IS_UNDEFINED;
> =C2=A0
> +	init_waitqueue_head(&server->write_congestion_wait);
> =C2=A0	atomic_long_set(&server->writeback, 0);
> =C2=A0
> =C2=A0	ida_init(&server->openowner_id);
> diff --git a/fs/nfs/write.c b/fs/nfs/write.c
> index c6255d7edd3c..21a5f1e90859 100644
> --- a/fs/nfs/write.c
> +++ b/fs/nfs/write.c
> @@ -423,8 +423,10 @@ static void nfs_folio_end_writeback(struct folio *fo=
lio)
> =C2=A0
> =C2=A0	folio_end_writeback(folio);
> =C2=A0	if (atomic_long_dec_return(&nfss->writeback) <
> -	=C2=A0=C2=A0=C2=A0 NFS_CONGESTION_OFF_THRESH)
> +	=C2=A0=C2=A0=C2=A0 NFS_CONGESTION_OFF_THRESH) {
> =C2=A0		nfss->write_congested =3D 0;
> +		wake_up_all(&nfss->write_congestion_wait);
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static void nfs_page_end_writeback(struct nfs_page *req)
> @@ -698,12 +700,14 @@ int nfs_writepages(struct address_space *mapping, s=
truct writeback_control *wbc)
> =C2=A0	struct nfs_pageio_descriptor pgio;
> =C2=A0	struct nfs_io_completion *ioc =3D NULL;
> =C2=A0	unsigned int mntflags =3D NFS_SERVER(inode)->flags;
> +	struct nfs_server *nfss =3D NFS_SERVER(inode);
> =C2=A0	int priority =3D 0;
> =C2=A0	int err;
> =C2=A0
> -	if (wbc->sync_mode =3D=3D WB_SYNC_NONE &&
> -	=C2=A0=C2=A0=C2=A0 NFS_SERVER(inode)->write_congested)
> -		return 0;
> +	/* Wait with writeback until write congestion eases */
> +	if (wbc->sync_mode =3D=3D WB_SYNC_NONE && nfss->write_congested)
> +		wait_event(nfss->write_congestion_wait,
> +			=C2=A0=C2=A0 nfss->write_congested =3D=3D 0);
> =C2=A0

It seems odd to block here, but if that helps throughput then so be it.

> =C2=A0	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
> =C2=A0
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 92de074e63b9..38a128796a76 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -140,6 +140,7 @@ struct nfs_server {
> =C2=A0	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
> =C2=A0	struct nlm_host		*nlm_host;	/* NLM client handle */
> =C2=A0	struct nfs_iostats __percpu *io_stats;	/* I/O statistics */
> +	wait_queue_head_t	write_congestion_wait;	/* wait until write congestion=
 eases */
> =C2=A0	atomic_long_t		writeback;	/* number of writeback pages */
> =C2=A0	unsigned int		write_congested;/* flag set when writeback gets too =
high */
> =C2=A0	unsigned int		flags;		/* various flags */

Reviewed-by: Jeff Layton <jlayton@kernel.org>

