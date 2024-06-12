Return-Path: <linux-nfs+bounces-3695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD990542B
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE37B20E34
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B4317C7D5;
	Wed, 12 Jun 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzHfhVv0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D0C176ACE
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200323; cv=none; b=oKaGyoMePBgMSGmcz76CMBbJfIV/RlTRf1+S8yNFtvEhint3MzdT51v474G3tfOGuAKMYtbp0l/VacgNOWJJDWnvT2Tc67YhJknrYuXcrbJjED0ZKnpfS9HRD/lsP7jyyr30jlv6Gj+oUIVLNZe2w/GbpcDjQd9aHDLBVbfC0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200323; c=relaxed/simple;
	bh=CTeoL6qeqRTNKUfhkSqehTngSkPOgwYStfeqdeQ8nZY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EqB5oVjEtUfXt6SARmeUmhklhelXdpxVAUEy0cVKoJq0yBsKVtckjZ+KrxEs/11qEd1U6hP4lEWT3+CS4zvnzfpHKuWDqNjDtOsvWYfW498y5oQ6k0XDoKA+NMrk5/yZyIihndrQg5W8t+Zhf9GAp5jpeekg0Ks7pAaox6HoNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzHfhVv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62871C116B1;
	Wed, 12 Jun 2024 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718200323;
	bh=CTeoL6qeqRTNKUfhkSqehTngSkPOgwYStfeqdeQ8nZY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CzHfhVv0o63lUeOng4i/LTqmktuY6cpjtI7mNoYqHph6obJPFvawTw0Uzez8QoiZt
	 Ka8fImfkQ39QT7SH51eCcNgbd9L+4G30WekI5Tn68aKvlgQNOI1QNOvLk0mR2SS2/j
	 KvldHS/tgnNOYUQAuOUiwC8avxzBWntJ/oGYqlr/Qt84xBx0w/CNbUeL0VnrxaJSLY
	 qg1VsTTvzcSLWkaCMc2uNecGonzCCoCwu7RwZFvirUwcB6cEmBWRYkUZgluBhY6BIK
	 Y2LbfpdimiXKmC9GXGFDKBQ+goeALA/Yz9Wc2b9Nl3+fwYKgon15KKoKqqpx5dvjIg
	 KuhwZCt4d5JJQ==
Message-ID: <98ef88e17f3996c2584f49be34bbee0ec78d72b1.camel@kernel.org>
Subject: Re: [PATCH v2] NFSD: Support write delegations in LAYOUTGET
From: Jeff Layton <jlayton@kernel.org>
To: cel@kernel.org, linux-nfs@vger.kernel.org
Cc: Neil Brown <neilb@suse.de>, Dai Ngo <dai.ngo@oracle.com>, Olga
 Kornievskaia <kolga@netapp.com>, Tom Talpey <tom@talpey.com>, Chuck Lever
 <chuck.lever@oracle.com>, Christoph Hellwig <hch@lst.de>
Date: Wed, 12 Jun 2024 09:52:01 -0400
In-Reply-To: <20240611193645.65792-2-cel@kernel.org>
References: <20240611193645.65792-2-cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-11 at 15:36 -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> I noticed LAYOUTGET(LAYOUTIOMODE4_RW) returning NFS4ERR_ACCESS
> unexpectedly. The NFS client had created a file with mode 0444, and
> the server had returned a write delegation on the OPEN(CREATE). The
> client was requesting a RW layout using the write delegation stateid
> so that it could flush file modifications.
>=20
> Creating a read-only file does not seem to be problematic for
> NFSv4.1 without pNFS, so I began looking at NFSD's implementation of
> LAYOUTGET.
>=20
> The failure was because fh_verify() was doing a permission check as
> part of verifying the FH presented during the LAYOUTGET. It uses the
> loga_iomode value to specify the @accmode argument to fh_verify().
> fh_verify(MAY_WRITE) on a file whose mode is 0444 fails with -EACCES.
>=20
> To permit LAYOUT* operations in this case, add OWNER_OVERRIDE when
> checking the access permission of the incoming file handle for
> LAYOUTGET and LAYOUTCOMMIT.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> X-Cc: stable@vger.kernel.org=C2=A0# v6.6+
> Message-Id: 4E9C0D74-A06D-4DC3-A48A-73034DC40395@oracle.com
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> =C2=A0fs/nfsd/nfs4proc.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 46bd20fe5c0f..2e39cf2e502a 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2269,7 +2269,7 @@ nfsd4_layoutget(struct svc_rqst *rqstp,
> =C2=A0	const struct nfsd4_layout_ops *ops;
> =C2=A0	struct nfs4_layout_stateid *ls;
> =C2=A0	__be32 nfserr;
> -	int accmode =3D NFSD_MAY_READ_IF_EXEC;
> +	int accmode =3D NFSD_MAY_READ_IF_EXEC |
> NFSD_MAY_OWNER_OVERRIDE;
> =C2=A0
> =C2=A0	switch (lgp->lg_seg.iomode) {
> =C2=A0	case IOMODE_READ:
> @@ -2359,7 +2359,8 @@ nfsd4_layoutcommit(struct svc_rqst *rqstp,
> =C2=A0	struct nfs4_layout_stateid *ls;
> =C2=A0	__be32 nfserr;
> =C2=A0
> -	nfserr =3D fh_verify(rqstp, current_fh, 0, NFSD_MAY_WRITE);
> +	nfserr =3D fh_verify(rqstp, current_fh, 0,
> +			=C2=A0=C2=A0 NFSD_MAY_WRITE |
> NFSD_MAY_OWNER_OVERRIDE);
> =C2=A0	if (nfserr)
> =C2=A0		goto out;
> =C2=A0

Reviewed-by: Jeff Layton <jlayton@kernel.org>

