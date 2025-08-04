Return-Path: <linux-nfs+bounces-13408-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF863B1A73D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 18:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E613BD133
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Aug 2025 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EBC285CB4;
	Mon,  4 Aug 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9pHdVwC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3F286412
	for <linux-nfs@vger.kernel.org>; Mon,  4 Aug 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325850; cv=none; b=stfzzdZ1mek6oESmP2+gfGf6+nN70w+WPqWS7KbpWSuRiBohJRC2zs5DZpbxiFirEnSPM9Ck3maQkdL9zbSbbvYR/fpdNrIsyoGRwLsWRX/2o/1pl3Z5Awxqa8Q+6v4xKg5lXK7pT7qTf+pNwOkA6vkqxiKubZ9xJgAEGD1pgkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325850; c=relaxed/simple;
	bh=k3KItyMbtEU5K3mTPdCRieeE/2NrsTT/I6RkMQtcvsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Flb62xt5B2Z3w1OCOP+8sPycgsr2zJDAd9Zvrm0YN++21enSTwT29yu7mWydCRecPyiQbAhdon4tzShCU1GFff9xmi9UI9Oyrp07LZQ3/a3h+BaSLjrmCZ8SOtBTR1WlsriiJ8Nwe8Cy/pEztrbfw8LsoAae8hofMu4U0ekXBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9pHdVwC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754325847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/zY3of5r7Ol888kYC6O4aWY05TY+JY8oRqlFASGm10s=;
	b=B9pHdVwCR4cMYYc3mxT8rvfT/ruxHnObVxeyvCYia/iH/37vrBhuZJaaRpM9NmWjt+fxvE
	/3hZW8f0LeXkuv0o7LPOpZyuzpqobVyDn4biR0i31fnEXCH2A5Vg2r329epoHmPnqev6Rv
	EtdeqPXJVGkA54SZCJPARyl/cFPVTMo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634--TPFpXCpMZ22EOntTqkBLA-1; Mon,
 04 Aug 2025 12:44:03 -0400
X-MC-Unique: -TPFpXCpMZ22EOntTqkBLA-1
X-Mimecast-MFC-AGG-ID: -TPFpXCpMZ22EOntTqkBLA_1754325843
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBE6C195D02F;
	Mon,  4 Aug 2025 16:44:02 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.74.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E3371800EEC;
	Mon,  4 Aug 2025 16:44:02 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Remove duplicate lookups, capability probes
 and fsinfo calls
Date: Mon, 04 Aug 2025 12:43:59 -0400
Message-ID: <4FB030C4-24BD-40ED-8442-8A0BFC970269@redhat.com>
In-Reply-To: <c7c737e442abb6984cef194fd8d66acab2e0b83f.1754270543.git.trond.myklebust@hammerspace.com>
References: <cover.1754270543.git.trond.myklebust@hammerspace.com>
 <c7c737e442abb6984cef194fd8d66acab2e0b83f.1754270543.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 3 Aug 2025, at 21:29, Trond Myklebust wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> When crossing into a new filesystem, the NFSv4 client will look up the
> new directory, and then call nfs4_server_capabilities() as well as
> nfs4_do_fsinfo() at least twice.
>
> This patch removes the duplicate calls, and reduces the initial lookup
> to retrieve just a minimal set of attributes.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/nfs4_fs.h     |  5 ++-
>  fs/nfs/nfs4getroot.c | 14 +++----
>  fs/nfs/nfs4proc.c    | 87 ++++++++++++++++++++------------------------=

>  3 files changed, 48 insertions(+), 58 deletions(-)
>
> diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
> index d3ca91f60fc1..c34c89af9c7d 100644
> --- a/fs/nfs/nfs4_fs.h
> +++ b/fs/nfs/nfs4_fs.h
> @@ -63,7 +63,7 @@ struct nfs4_minor_version_ops {
>  	bool	(*match_stateid)(const nfs4_stateid *,
>  			const nfs4_stateid *);
>  	int	(*find_root_sec)(struct nfs_server *, struct nfs_fh *,
> -			struct nfs_fsinfo *);
> +				 struct nfs_fattr *);
>  	void	(*free_lock_state)(struct nfs_server *,
>  			struct nfs4_lock_state *);
>  	int	(*test_and_free_expired)(struct nfs_server *,
> @@ -296,7 +296,8 @@ extern int nfs4_call_sync(struct rpc_clnt *, struct=
 nfs_server *,
>  extern void nfs4_init_sequence(struct nfs4_sequence_args *, struct nfs=
4_sequence_res *, int, int);
>  extern int nfs4_proc_setclientid(struct nfs_client *, u32, unsigned sh=
ort, const struct cred *, struct nfs4_setclientid_res *);
>  extern int nfs4_proc_setclientid_confirm(struct nfs_client *, struct n=
fs4_setclientid_res *arg, const struct cred *);
> -extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh *, =
struct nfs_fsinfo *, bool);
> +extern int nfs4_proc_get_rootfh(struct nfs_server *, struct nfs_fh *,
> +				struct nfs_fattr *, bool);
>  extern int nfs4_proc_bind_conn_to_session(struct nfs_client *, const s=
truct cred *cred);
>  extern int nfs4_proc_exchange_id(struct nfs_client *clp, const struct =
cred *cred);
>  extern int nfs4_destroy_clientid(struct nfs_client *clp);
> diff --git a/fs/nfs/nfs4getroot.c b/fs/nfs/nfs4getroot.c
> index 1a69479a3a59..e67ea345de69 100644
> --- a/fs/nfs/nfs4getroot.c
> +++ b/fs/nfs/nfs4getroot.c
> @@ -12,30 +12,28 @@
>
>  int nfs4_get_rootfh(struct nfs_server *server, struct nfs_fh *mntfh, b=
ool auth_probe)
>  {
> -	struct nfs_fsinfo fsinfo;
> +	struct nfs_fattr *fattr =3D nfs_alloc_fattr();
>  	int ret =3D -ENOMEM;
>
> -	fsinfo.fattr =3D nfs_alloc_fattr();
> -	if (fsinfo.fattr =3D=3D NULL)
> +	if (fattr =3D=3D NULL)
>  		goto out;
>
>  	/* Start by getting the root filehandle from the server */
> -	ret =3D nfs4_proc_get_rootfh(server, mntfh, &fsinfo, auth_probe);
> +	ret =3D nfs4_proc_get_rootfh(server, mntfh, fattr, auth_probe);
>  	if (ret < 0) {
>  		dprintk("nfs4_get_rootfh: getroot error =3D %d\n", -ret);
>  		goto out;
>  	}
>
> -	if (!(fsinfo.fattr->valid & NFS_ATTR_FATTR_TYPE)
> -			|| !S_ISDIR(fsinfo.fattr->mode)) {
> +	if (!(fattr->valid & NFS_ATTR_FATTR_TYPE) || !S_ISDIR(fattr->mode)) {=

>  		printk(KERN_ERR "nfs4_get_rootfh:"
>  		       " getroot encountered non-directory\n");
>  		ret =3D -ENOTDIR;
>  		goto out;
>  	}
>
> -	memcpy(&server->fsid, &fsinfo.fattr->fsid, sizeof(server->fsid));
> +	memcpy(&server->fsid, &fattr->fsid, sizeof(server->fsid));
>  out:
> -	nfs_free_fattr(fsinfo.fattr);
> +	nfs_free_fattr(fattr);
>  	return ret;
>  }
> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
> index c7c7ec22f21d..7d2b67e06cc3 100644
> --- a/fs/nfs/nfs4proc.c
> +++ b/fs/nfs/nfs4proc.c
> @@ -4240,15 +4240,18 @@ static int nfs4_discover_trunking(struct nfs_se=
rver *server,
>  }
>
>  static int _nfs4_lookup_root(struct nfs_server *server, struct nfs_fh =
*fhandle,
> -		struct nfs_fsinfo *info)
> +			     struct nfs_fattr *fattr)
>  {
> -	u32 bitmask[3];
> +	u32 bitmask[3] =3D {
> +		[0] =3D FATTR4_WORD0_TYPE | FATTR4_WORD0_CHANGE |
> +		      FATTR4_WORD0_SIZE | FATTR4_WORD0_FSID,

Just a thought when noticing this change --

Don't we want at least FATTR4_WORD0_FILEID and
FATTR4_WORD1_MOUNTED_ON_FILEID as well here?

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben


