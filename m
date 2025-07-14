Return-Path: <linux-nfs+bounces-13044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE91B03F3E
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 15:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546DA189EB80
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6071E18C034;
	Mon, 14 Jul 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryPClRcE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5B54315A
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752498453; cv=none; b=A4+cwoW2nftvAUqttCch7AJiYPcndKUcsglSErgTsXJ6f1oleLrvHZBbk7HgC7anbzKIZr1NNW5wfzPt6C9ux2AGmkbU7DdjYqUmDgz/vJs5wt0nTSpdblz83xuw+kw4qnmQShIrW4N3vjBOwg4ih1vzk1K+jDbuYlnEnI8oFMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752498453; c=relaxed/simple;
	bh=Fen5luEZ29jz0ZCMQph1mP//rxGARphm9Q4wO6kyw28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2reJW7R4gucYoMRXA1zq1/3+Z2YXOTWEe9yKaTdh3a9TJ9vOhTHRopGuB9qrm9kWfCcE9Fzj6TlmIbiIDwqpJIZzQ9SKFqKsSdeCC74zIJsO+Esm2LA1JdHDBPvjpX9UeZjk0GR0Ny6T6xf7AJZ8ExiZozWHmJMthxS8tTV5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryPClRcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58F1C4CEED;
	Mon, 14 Jul 2025 13:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752498453;
	bh=Fen5luEZ29jz0ZCMQph1mP//rxGARphm9Q4wO6kyw28=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ryPClRcEOKKGAQ9SgkZ5pfvYrOmK1MhduLRYTplyxQoq5eE0kXYWgAk9247gN7e8h
	 R/2kJLEjdKCOx/P6402qoUiqfh2Dz8uDnlPyPu7iE2cA/Mlk+FUAtNZ0dWilHFGgAt
	 zRAnFz7160xn85/BVKyVq1ewbYHlKVW39DM0xe6fXbjDLTsxd/10e8AYGtutKBhmrS
	 dqyayuIRKzpUFTD73bthWEQTY9gX7rmvGA4wi+CWRb2WvWm6324SCKqRKC8F+pCTWQ
	 ICH7VTfOO0KHbQjfdugkLL8MrpmzXFrUdYJ/I22ovneNAV5eS1DKAzbFRsWR/sDsbA
	 Ye6vLjepqEoqg==
Message-ID: <6db09cc485ae37a4c8c89b4a9a2bcf0dd1302733.camel@kernel.org>
Subject: Re: [PATCH 3/4] NFS: track active delegations per-server
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Date: Mon, 14 Jul 2025 09:07:30 -0400
In-Reply-To: <20250714111651.1565055-4-hch@lst.de>
References: <20250714111651.1565055-1-hch@lst.de>
	 <20250714111651.1565055-4-hch@lst.de>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-07-14 at 13:16 +0200, Christoph Hellwig wrote:
> The active delegation watermark was added to avoid overloading servers.
> Track the active delegation per-server instead of globally so that client=
s
> talking to multiple servers aren't limited by the global limit.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/nfs/client.c           |  1 +
>  fs/nfs/delegation.c       | 35 +++++++++++++++++++----------------
>  include/linux/nfs_fs_sb.h |  1 +
>  3 files changed, 21 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 1a55debab6e5..f55188928f67 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -1017,6 +1017,7 @@ struct nfs_server *nfs_alloc_server(void)
>  	INIT_LIST_HEAD(&server->ss_src_copies);
> =20
>  	atomic_set(&server->active, 0);
> +	atomic_long_set(&server->nr_active_delegations, 0);
> =20
>  	server->io_stats =3D nfs_alloc_iostats();
>  	if (!server->io_stats) {
> diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
> index d036796dbe69..621b635d1c56 100644
> --- a/fs/nfs/delegation.c
> +++ b/fs/nfs/delegation.c
> @@ -27,7 +27,6 @@
> =20
>  #define NFS_DEFAULT_DELEGATION_WATERMARK (15000U)
> =20
> -static atomic_long_t nfs_active_delegations;
>  static unsigned nfs_delegation_watermark =3D NFS_DEFAULT_DELEGATION_WATE=
RMARK;
>  module_param_named(delegation_watermark, nfs_delegation_watermark, uint,=
 0644);
> =20
> @@ -38,11 +37,12 @@ static void __nfs_free_delegation(struct nfs_delegati=
on *delegation)
>  	kfree_rcu(delegation, rcu);
>  }
> =20
> -static void nfs_mark_delegation_revoked(struct nfs_delegation *delegatio=
n)
> +static void nfs_mark_delegation_revoked(struct nfs_server *server,
> +		struct nfs_delegation *delegation)
>  {
>  	if (!test_and_set_bit(NFS_DELEGATION_REVOKED, &delegation->flags)) {
>  		delegation->stateid.type =3D NFS4_INVALID_STATEID_TYPE;
> -		atomic_long_dec(&nfs_active_delegations);
> +		atomic_long_dec(&server->nr_active_delegations);
>  		if (!test_bit(NFS_DELEGATION_RETURNING, &delegation->flags))
>  			nfs_clear_verifier_delegated(delegation->inode);
>  	}
> @@ -60,9 +60,10 @@ static void nfs_put_delegation(struct nfs_delegation *=
delegation)
>  		__nfs_free_delegation(delegation);
>  }
> =20
> -static void nfs_free_delegation(struct nfs_delegation *delegation)
> +static void nfs_free_delegation(struct nfs_server *server,
> +		struct nfs_delegation *delegation)
>  {
> -	nfs_mark_delegation_revoked(delegation);
> +	nfs_mark_delegation_revoked(server, delegation);
>  	nfs_put_delegation(delegation);
>  }
> =20
> @@ -261,7 +262,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode=
, const struct cred *cred,
>  	}
>  	clear_bit(NFS_DELEGATION_NEED_RECLAIM, &delegation->flags);
>  	if (test_and_clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
> -		atomic_long_inc(&nfs_active_delegations);
> +		atomic_long_inc(&NFS_SERVER(inode)->nr_active_delegations);
>  	spin_unlock(&delegation->lock);
>  	rcu_read_unlock();
>  	put_cred(oldcred);
> @@ -413,7 +414,8 @@ nfs_update_delegation_cred(struct nfs_delegation *del=
egation,
>  }
> =20
>  static void
> -nfs_update_inplace_delegation(struct nfs_delegation *delegation,
> +nfs_update_inplace_delegation(struct nfs_server *server,
> +		struct nfs_delegation *delegation,
>  		const struct nfs_delegation *update)
>  {
>  	if (nfs4_stateid_is_newer(&update->stateid, &delegation->stateid)) {
> @@ -426,7 +428,7 @@ nfs_update_inplace_delegation(struct nfs_delegation *=
delegation,
>  			nfs_update_delegation_cred(delegation, update->cred);
>  			/* smp_mb__before_atomic() is implicit due to xchg() */
>  			clear_bit(NFS_DELEGATION_REVOKED, &delegation->flags);
> -			atomic_long_inc(&nfs_active_delegations);
> +			atomic_long_inc(&server->nr_active_delegations);
>  		}
>  	}
>  }
> @@ -481,7 +483,7 @@ int nfs_inode_set_delegation(struct inode *inode, con=
st struct cred *cred,
>  	if (nfs4_stateid_match_other(&old_delegation->stateid,
>  				&delegation->stateid)) {
>  		spin_lock(&old_delegation->lock);
> -		nfs_update_inplace_delegation(old_delegation,
> +		nfs_update_inplace_delegation(server, old_delegation,
>  				delegation);
>  		spin_unlock(&old_delegation->lock);
>  		goto out;
> @@ -530,7 +532,7 @@ int nfs_inode_set_delegation(struct inode *inode, con=
st struct cred *cred,
>  	rcu_assign_pointer(nfsi->delegation, delegation);
>  	delegation =3D NULL;
> =20
> -	atomic_long_inc(&nfs_active_delegations);
> +	atomic_long_inc(&server->nr_active_delegations);
> =20
>  	trace_nfs4_set_delegation(inode, type);
> =20
> @@ -544,7 +546,7 @@ int nfs_inode_set_delegation(struct inode *inode, con=
st struct cred *cred,
>  		__nfs_free_delegation(delegation);
>  	if (freeme !=3D NULL) {
>  		nfs_do_return_delegation(inode, freeme, 0);
> -		nfs_free_delegation(freeme);
> +		nfs_free_delegation(server, freeme);
>  	}
>  	return status;
>  }
> @@ -756,7 +758,7 @@ void nfs_inode_evict_delegation(struct inode *inode)
>  		set_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
>  		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
>  		nfs_do_return_delegation(inode, delegation, 1);
> -		nfs_free_delegation(delegation);
> +		nfs_free_delegation(NFS_SERVER(inode), delegation);
>  	}
>  }
> =20
> @@ -842,7 +844,8 @@ void nfs4_inode_return_delegation_on_close(struct ino=
de *inode)
>  	if (!delegation)
>  		goto out;
>  	if (test_bit(NFS_DELEGATION_RETURN_IF_CLOSED, &delegation->flags) ||
> -	    atomic_long_read(&nfs_active_delegations) >=3D nfs_delegation_water=
mark) {
> +	    atomic_long_read(&NFS_SERVER(inode)->nr_active_delegations) >=3D
> +	    nfs_delegation_watermark) {
>  		spin_lock(&delegation->lock);
>  		if (delegation->inode &&
>  		    list_empty(&NFS_I(inode)->open_files) &&
> @@ -1018,7 +1021,7 @@ static void nfs_revoke_delegation(struct inode *ino=
de,
>  		}
>  		spin_unlock(&delegation->lock);
>  	}
> -	nfs_mark_delegation_revoked(delegation);
> +	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
>  	ret =3D true;
>  out:
>  	rcu_read_unlock();
> @@ -1050,7 +1053,7 @@ void nfs_delegation_mark_returned(struct inode *ino=
de,
>  			delegation->stateid.seqid =3D stateid->seqid;
>  	}
> =20
> -	nfs_mark_delegation_revoked(delegation);
> +	nfs_mark_delegation_revoked(NFS_SERVER(inode), delegation);
>  	clear_bit(NFS_DELEGATION_RETURNING, &delegation->flags);
>  	spin_unlock(&delegation->lock);
>  	if (nfs_detach_delegation(NFS_I(inode), delegation, NFS_SERVER(inode)))
> @@ -1272,7 +1275,7 @@ static int nfs_server_reap_unclaimed_delegations(st=
ruct nfs_server *server,
>  		if (delegation !=3D NULL) {
>  			if (nfs_detach_delegation(NFS_I(inode), delegation,
>  						server) !=3D NULL)
> -				nfs_free_delegation(delegation);
> +				nfs_free_delegation(server, delegation);
>  			/* Match nfs_start_delegation_return_locked */
>  			nfs_put_delegation(delegation);
>  		}
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 73bed04529a7..fe930d685780 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -255,6 +255,7 @@ struct nfs_server {
>  	struct list_head	state_owners_lru;
>  	struct list_head	layouts;
>  	struct list_head	delegations;
> +	atomic_long_t		nr_active_delegations;
>  	struct list_head	ss_copies;
>  	struct list_head	ss_src_copies;
> =20

Good idea. I like this.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

