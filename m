Return-Path: <linux-nfs+bounces-10333-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F5A43F55
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 13:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29E7172479
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Feb 2025 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80713266B40;
	Tue, 25 Feb 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3cY6lOv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E7263F4D
	for <linux-nfs@vger.kernel.org>; Tue, 25 Feb 2025 12:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486109; cv=none; b=JwlU3bxrYJ30vO6iBRIFBx/dFfB2t1BqgvVVGZaCCG3ymGj/UcvVC4HXBEvJTcrFLurEcBOvi2Zt2r0lejutd1v4N8v7Z2aXoqaSUXDC+q9rCMGBNKJt7p7xsVX4jqSfiYj9k+47wnIduuhkIV2GMWvvF9068snELwbZFhXNGn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486109; c=relaxed/simple;
	bh=KCg+B0VJhsQqaSvEErtOXW9NRf+gEwsemJr1KYdu040=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPegSrtj8/q3zZn8SQR6uzeKcVyiUAMglcFLqookXiVM0eQcdzyGWLArLbAcc5gOP746Ii7hfhs6Mgr3POfaScs/+ubhNzn8SAY6Lr19D4yUpfJKxCU04HI8kUQXbaumkbVg92sHqjba6OnTtCXJgcKo6dDp3iR0xzaO6awXm5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3cY6lOv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740486106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxaqt9Kny3KFobvge15AyNIeDOV3rBi4zqOZlCd3flw=;
	b=S3cY6lOvFfVDFZxmLrWApc7CG6cvpe9YN4w/+RU4J3GPIrWkjBs/SaLmJv13R2YSwoVQSF
	We1k2tagPKx8E82KcqVThwMdcuXfL+uMfQXnY3NXJS8/UB/KInzEHEUiuU2//J+UgbNxwG
	/MlvxzmZ3WQFpKhb1sfsQ+t4iQw7/UE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-FUhlZd4TM7qafqoaW0ZNKg-1; Tue,
 25 Feb 2025 07:21:43 -0500
X-MC-Unique: FUhlZd4TM7qafqoaW0ZNKg-1
X-Mimecast-MFC-AGG-ID: FUhlZd4TM7qafqoaW0ZNKg_1740486102
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E583519373D9;
	Tue, 25 Feb 2025 12:21:41 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.81.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 566D01955BD4;
	Tue, 25 Feb 2025 12:21:41 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id E572E335D68; Tue, 25 Feb 2025 07:21:38 -0500 (EST)
Date: Tue, 25 Feb 2025 07:21:38 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: "zhangjian (CG)" <zhangjian496@huawei.com>
Cc: sorenson@redhat.com, s.ikarashi@fujitsu.com, jlayton@kernel.org,
	steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfsdcld: fix cld pipe read size
Message-ID: <Z7210sTaCaamBGFR@aion>
References: <07ba7ede-5127-4978-9195-26c3d04679c4@huawei.com>
 <cfa8c2a3-4e2d-45c8-a605-c66d92412d41@huawei.com>
 <277a7a65-0aea-496c-beb5-e4b6f6afc10e@huawei.com>
 <3e26c767-f347-4dbe-ae04-aabe8e87af12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3e26c767-f347-4dbe-ae04-aabe8e87af12@huawei.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 25 Feb 2025, zhangjian (CG) wrote:

> Another thinking for that case: is it neccessory to write pipe with all p=
ossible xid to wake up all nfsd waiting for nfsdcld ? If nfsdcld is signale=
d SIGTERM in processing message, nfsdcld may also crash and nfsd wait for i=
t forever too.=20
I'm not sure I understand.  Are you suggesting nfsdcld ignore signals in
cld_gracestart()?

-Scott
>=20
> On Tue, 25 Feb 2025, zhangjian (CG) wrote:
> > When nfsd inits failed for detecting cld version in nfsd4_client_tracki=
ng_init, kernel may assume nfsdcld support version 1 message format and try=
 to upcall with v1 message size to nfsdcld. There exists one error case in =
the following process, causeing nfsd hunging for nfsdcld replay:=20
> >=20
> > kernel write to pipe->msgs (v1 msg length)    =20
> >     |--------- first msg --------|-------- second message -------|
> >=20
> > nfsdcld read from pipe->msgs (v2 msg length)
> >     |------------ first msg --------------|---second message-----|
> >     |  valid message             | ignore |     wrong message    |
> >=20
> > When two nfsd kernel thread add two upcall messages to cld pipe with v1=
 version cld_msg (size =3D=3D 1034) concurrently=EF=BC=8Cbut nfsdcld reads =
with v2 version size(size =3D=3D 1067), 33 bytes of the second message will=
 be read and merged with first message. The 33 bytes in second message will=
 be ignored. Nfsdcld will then read 1001 bytes in second message, which cau=
se FATAL in cld_messaged_size checking. Nfsd kernel thread will hang for it=
 forever until nfs server restarts.
> >=20
> > Signed-off-by: zhangjian <zhangjian496@huawei.com>
> > ---
> >  utils/nfsdcld/nfsdcld.c | 63 ++++++++++++++++++++++++++++-------------
> >  1 file changed, 43 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/utils/nfsdcld/nfsdcld.c b/utils/nfsdcld/nfsdcld.c
> > index dbc7a57..76308d1 100644
> > --- a/utils/nfsdcld/nfsdcld.c
> > +++ b/utils/nfsdcld/nfsdcld.c
> > @@ -716,35 +716,58 @@ reply:
> >  	}
> >  }
> >=20
> > +static int cld_pipe_read_msg(struct cld_client *clnt) {
> > +	ssize_t len, left_len;
> > +	ssize_t hdr_len =3D sizeof(struct cld_msg_hdr);
> > +	struct cld_msg_hdr *hdr =3D (struct cld_msg_hdr *)&clnt->cl_u;;
> > +
> > +	len =3D atomicio(read, clnt->cl_fd, hdr, hdr_len);
> > +
> > +	if (len <=3D 0) {
> > +		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
> > +		goto fail_read;
> > +	}
> > +
> > +	switch (hdr->cm_vers) {
> > +	case 1:
> > +		left_len =3D sizeof(struct cld_msg) - hdr_len;
> > +		break;
> > +	case 2:
> > +		left_len =3D sizeof(struct cld_msg_v2) - hdr_len;
> > +		break;
> > +	default:
> > +		xlog(L_ERROR, "%s: unsupported upcall version: %hu",
> > +								__func__, hdr->cm_vers);
> > +		goto fail_read;
> > +	}
> > +
> > +	len =3D atomicio(read, clnt->cl_fd, hdr, left_len);
> > +
> > +	if (len <=3D 0) {
> > +		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
> > +		goto fail_read;
> > +	}
> > +
> > +	return 0;
> > +
> > +fail_read:
> > +	cld_pipe_open(clnt);
> > +	return -1;
> > +}
> > +
> >  static void
> >  cldcb(int UNUSED(fd), short which, void *data)
> >  {
> > -	ssize_t len;
> >  	struct cld_client *clnt =3D data;
> > -#if UPCALL_VERSION >=3D 2
> > -	struct cld_msg_v2 *cmsg =3D &clnt->cl_u.cl_msg_v2;
> > -#else
> > -	struct cld_msg *cmsg =3D &clnt->cl_u.cl_msg;
> > -#endif
> > +	struct cld_msg_hdr *hdr =3D (struct cld_msg_hdr *)&clnt->cl_u;
> >=20
> >  	if (which !=3D EV_READ)
> >  		goto out;
> >=20
> > -	len =3D atomicio(read, clnt->cl_fd, cmsg, sizeof(*cmsg));
> > -	if (len <=3D 0) {
> > -		xlog(L_ERROR, "%s: pipe read failed: %m", __func__);
> > -		cld_pipe_open(clnt);
> > +	if (cld_pipe_read_msg(clnt) < 0)
> >  		goto out;
> > -	}
> > -
> > -	if (cmsg->cm_vers > UPCALL_VERSION) {
> > -		xlog(L_ERROR, "%s: unsupported upcall version: %hu",
> > -				__func__, cmsg->cm_vers);
> > -		cld_pipe_open(clnt);
> > -		goto out;
> > -	}
> >=20
> > -	switch(cmsg->cm_cmd) {
> > +	switch (hdr->cm_cmd) {
> >  	case Cld_Create:
> >  		cld_create(clnt);
> >  		break;
> > @@ -765,7 +788,7 @@ cldcb(int UNUSED(fd), short which, void *data)
> >  		break;
> >  	default:
> >  		xlog(L_WARNING, "%s: command %u is not yet implemented",
> > -				__func__, cmsg->cm_cmd);
> > +				__func__, hdr->cm_cmd);
> >  		cld_not_implemented(clnt);
> >  	}
> >  out:
>=20


