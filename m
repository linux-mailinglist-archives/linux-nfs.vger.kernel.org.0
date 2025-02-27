Return-Path: <linux-nfs+bounces-10386-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BA2A48A6B
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 22:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABE8188AC6E
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Feb 2025 21:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9328BEC;
	Thu, 27 Feb 2025 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zk6DI9eF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A2326E96A
	for <linux-nfs@vger.kernel.org>; Thu, 27 Feb 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691547; cv=none; b=Nu/dOKniTze23nYq5m+kuEwci3YO1SrMQyCANToAkZJMWvOv/QmNqy0N2xcIMMXI8M2Qv9b+nTFdMdECLMyZNr8VcgBnZb5/L22ZvkJ5AaNMEifxLpQ06IFk9x0zE2152YbPuhMQ8kEFkilgkBtZRoAB31sD5MvbLr7eIFEXoPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691547; c=relaxed/simple;
	bh=mFBC6u9R1z7rhJ4ECUxFmrQkOFMN1hhlb7aE2UuIjTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0CBZAoW+Rmsjfpnk3y/IieFOp5H1/3LVEuzrpStJ0WqlVjRc5+JX6uwzsBwWNiv0hq0jg2hRzMD1PRrXIARE4pT3iY7Tmcw7ytTD285ob5vau9Kw8X1jXh7Xqbp0wJMRMefe6aSPVEHuJCd7lNqpgLdZlnwqpCIySrK/iMJGiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zk6DI9eF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740691543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Dy8XwAJSjCOfV/sMNnAOLhoIkxeTEhni4BTuN6+iqE=;
	b=Zk6DI9eFvAyTwE1SCcqUpoRdGcIrvn3zoyGNWnrFDC4MGNXutFQNpyWcG0TKTCE5AzJfu6
	54Q1KxIdZzt1L2LXbZTLgNSBP0iE5roNmsqEjlSIHM4tnk5PjV56expNA1czz/sb6Gt8xS
	k7J/V9q7T/kAIy10/yt2EeRoRUErjy4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-gAzb3Ii9PV6XGuSsTOo6sA-1; Thu,
 27 Feb 2025 16:25:39 -0500
X-MC-Unique: gAzb3Ii9PV6XGuSsTOo6sA-1
X-Mimecast-MFC-AGG-ID: gAzb3Ii9PV6XGuSsTOo6sA_1740691539
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B65831944D44;
	Thu, 27 Feb 2025 21:25:38 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.64.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F99E19560B9;
	Thu, 27 Feb 2025 21:25:38 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 3544533644D; Thu, 27 Feb 2025 16:25:36 -0500 (EST)
Date: Thu, 27 Feb 2025 16:25:36 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: zhangjian <zhangjian496@huawei.com>
Cc: sorenson@redhat.com, s.ikarashi@fujitsu.com, jlayton@kernel.org,
	steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH V3] nfsdcld: fix cld pipe read size
Message-ID: <Z8DYUPf8BDM9KPsU@aion>
References: <20250227005530.3358455-1-zhangjian496@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250227005530.3358455-1-zhangjian496@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, 27 Feb 2025, zhangjian wrote:

> When nfsd inits failed for detecting cld version in
> nfsd4_client_tracking_init, kernel may assume nfsdcld support version 1
> message format and try to upcall with v1 message size to nfsdcld.
> There exists one error case in the following process, causeing nfsd
> hunging for nfsdcld replay:
>=20
> kernel write to pipe->msgs (v1 msg length)
>     |--------- first msg --------|-------- second message -------|
>=20
> nfsdcld read from pipe->msgs (v2 msg length)
>     |------------ first msg --------------|---second message-----|
>     |  valid message             | ignore |     wrong message    |
>=20
> When two nfsd kernel thread add two upcall messages to cld pipe with v1
> version cld_msg (size =3D=3D 1034) concurrently=EF=BC=8Cbut nfsdcld reads=
 with v2
> version size(size =3D=3D 1067), 33 bytes of the second message will be re=
ad
> and merged with first message. The 33 bytes in second message will be
> ignored. Nfsdcld will then read 1001 bytes in second message, which cause
> FATAL in cld_messaged_size checking. Nfsd kernel thread will hang for
> it forever until nfs server restarts.
>=20
> Signed-off-by: zhangjian <zhangjian496@huawei.com>
> Reviewed-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  utils/nfsdcld/nfsdcld.c | 65 ++++++++++++++++++++++++++++-------------
>  1 file changed, 45 insertions(+), 20 deletions(-)
>=20
> diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
> index dbc7a57..005d1ea 100644
> --- a/utils/nfsdcld/nfsdcld.c
> +++ b/utils/nfsdcld/nfsdcld.c
> @@ -716,35 +716,60 @@ reply:
>  	}
>  }
> =20
> -static void
> -cldcb(int UNUSED(fd), short which, void *data)
> +static int
> +cld_pipe_read_msg(struct cld_client *clnt)
>  {
> -	ssize_t len;
> -	struct cld_client *clnt =3D data;
> -#if UPCALL_VERSION >=3D 2
> -	struct cld_msg_v2 *cmsg =3D &clnt->cl_u.cl_msg_v2;
> -#else
> -	struct cld_msg *cmsg =3D &clnt->cl_u.cl_msg;
> -#endif
> +	ssize_t len, left_len;
> +	ssize_t hdr_len =3D sizeof(struct cld_msg_hdr);
> +	struct cld_msg_hdr *hdr =3D (struct cld_msg_hdr *)&clnt->cl_u;
> =20
> -	if (which !=3D EV_READ)
> -		goto out;
> +	len =3D atomicio(read, clnt->cl_fd, hdr, hdr_len);
> =20
> -	len =3D atomicio(read, clnt->cl_fd, cmsg, sizeof(*cmsg));
>  	if (len <=3D 0) {
>  		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
> -		cld_pipe_open(clnt);
> -		goto out;
> +		goto fail_read;
>  	}

We probably also want to fail if len !=3D hdr_len.
> =20
> -	if (cmsg->cm_vers > UPCALL_VERSION) {
> +	switch (hdr->cm_vers) {
> +	case 1:
> +		left_len =3D sizeof(struct cld_msg) - hdr_len;
> +		break;
> +	case 2:
> +		left_len =3D sizeof(struct cld_msg_v2) - hdr_len;
> +		break;
> +	default:
>  		xlog(L_ERROR, "%s: unsupported upcall version: %hu",
> -				__func__, cmsg->cm_vers);
> -		cld_pipe_open(clnt);
> -		goto out;
> +			__func__, hdr->cm_vers);
> +		goto fail_read;
>  	}
> =20
> -	switch(cmsg->cm_cmd) {
> +	len =3D atomicio(read, clnt->cl_fd, hdr, left_len);

This is reading into the beginning of the message and overwriting the
header.  In the original version of this patch you had hdr + 1 as the
to read the data into.

-Scott

> +
> +	if (len <=3D 0) {
> +		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
> +		goto fail_read;
> +	}
> +
> +	return 0;
> +
> +fail_read:
> +	cld_pipe_open(clnt);
> +	return -1;
> +}
> +
> +static void
> +cldcb(int UNUSED(fd), short which, void *data)
> +{
> +	struct cld_client *clnt =3D data;
> +	struct cld_msg_hdr *hdr =3D (struct cld_msg_hdr *)&clnt->cl_u;
> +
> +	if (which !=3D EV_READ)
> +		goto out;
> +
> +	if (cld_pipe_read_msg(clnt) < 0)
> +		goto out;
> +
> +	switch (hdr->cm_cmd) {
>  	case Cld_Create:
>  		cld_create(clnt);
>  		break;
> @@ -765,7 +790,7 @@ cldcb(int UNUSED(fd), short which, void *data)
>  		break;
>  	default:
>  		xlog(L_WARNING, "%s: command %u is not yet implemented",
> -				__func__, cmsg->cm_cmd);
> +				__func__, hdr->cm_cmd);
>  		cld_not_implemented(clnt);
>  	}
>  out:
> --=20
> 2.33.0
>=20


