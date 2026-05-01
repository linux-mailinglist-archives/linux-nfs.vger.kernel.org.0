Return-Path: <linux-nfs+bounces-21343-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKJrOPEK9WlcHwIAu9opvQ
	(envelope-from <linux-nfs+bounces-21343-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 22:20:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F60E4AF73E
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 22:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FCEB300B9F0
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 20:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6803A5448;
	Fri,  1 May 2026 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mv0uQaxA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A73F7871
	for <linux-nfs@vger.kernel.org>; Fri,  1 May 2026 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777666774; cv=none; b=L7pOKBGkGxq14SN+WMuKK7NLshgpn02E6fHjyJ+NdFkALQQv9HZRf3k+F/TxNIHyGeA5bCL/jbyhZQNY1/ZyVzmzs8k1RI4buZkfw4uW99F+OZy5zbLoNCb3TsmIUVHqSuJzgWmumdJVMro3I+b4vN5a/DHhRHaMsCmK5pado7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777666774; c=relaxed/simple;
	bh=hvKBwFY+EwheUwTy+5D6HPYgqXhA+U0+jMyG4RbhV44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9jlevpkk1q3f2dst+hoBD0GkzceWv1TJQLQGp1lGdfcDagY4+aGlbm1j6KRZTPyFVZJl3u3hFkmgN/YUPrr3e2bOeiAGxtVPz3FK7OLCFrIcCkPqfCWVm1scyHB8X+NfZZL3hIqgVUTYhJKOxxP/dSvqn9HZ/vPjZKS/f9l1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mv0uQaxA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777666771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ecBdeBNxfadLal0eXrWlLOX9ftjkrpfMK9YbR0q/Czg=;
	b=Mv0uQaxAnEfbeeUQ/lJRKLEAW9b9h5e571hS23dlQfE0Nw2UY+YQ8iQZci+ngvICT355ve
	zi+mlLJP95kcfkuz6RwcjbipPGxmWephK3mzFmWUjVHFrsQ4OV/78a2x1UhN3j1e7NIxLR
	qEdnE/q78zorEBCzjskswionaAsa2yA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-6KPs5neGN2Cg8WGdh97y4A-1; Fri,
 01 May 2026 16:19:28 -0400
X-MC-Unique: 6KPs5neGN2Cg8WGdh97y4A-1
X-Mimecast-MFC-AGG-ID: 6KPs5neGN2Cg8WGdh97y4A_1777666767
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92A56195608C;
	Fri,  1 May 2026 20:19:27 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.80.84])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C95630001A1;
	Fri,  1 May 2026 20:19:27 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 73D577C9FB2; Fri, 01 May 2026 16:19:25 -0400 (EDT)
Date: Fri, 1 May 2026 16:19:25 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <cel@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	kernel-tls-handshake@lists.linux.dev
Subject: Re: Breakage in ktls-utils with nfs keyring?
Message-ID: <afUKzeUYPhb97DX4@aion>
References: <fd4aaf4e-b1b7-4ca2-bc93-955c31fab317@grimberg.me>
 <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <92a53963-1e4b-42eb-af81-6be9f63f9e43@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 4F60E4AF73E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21343-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]

On Thu, 30 Apr 2026, Chuck Lever wrote:

> Cc'ing the ktls-utils development list.
>=20
> On Thu, Apr 30, 2026, at 9:32 AM, Sagi Grimberg wrote:
> > Hey Chuck,
> >
> > Upstream ktls-utils fails passing client certificate and private key=20
> > using the .nfs keyring.
> > Bisecting leads commit facd084e43fc ("tlshd: Client-side dual=20
> > certificate support").
> >
> > I manually apply this (probably wrong) change and keyring works:
> > --
> > diff --git a/src/tlshd/client.c b/src/tlshd/client.c
> > index 2664ffb..a946797 100644
> > --- a/src/tlshd/client.c
> > +++ b/src/tlshd/client.c
> > @@ -327,7 +327,7 @@ tlshd_x509_retrieve_key_cb(gnutls_session_t session,
> >  =A0 =A0 =A0 =A0 } else {
> >  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tlshd_log_debug("%s: Selecting x509.ce=
rtificate from=20
> > conf file", __func__);
> >  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *pcert_length =3D tlshd_certs_len;
> > -=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pcert =3D tlshd_certs + tlshd_pq_certs=
_len;
> > +=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pcert =3D tlshd_certs;
> >  =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *privkey =3D tlshd_privkey;
> >  =A0 =A0 =A0 =A0 }
> >  =A0 =A0 =A0 =A0 return 0;
> > --
> >
> > But, I have a feeling its not the correct change...
>=20
>=20
> Scott, can you triage this?

So when I added the dual certificate support, I didn't touch any of the
keyring code.  Frankly, I'm not entirely sure what is the right way to
set it up and the docs are pretty much nonexistent.  As far as I can
tell:

- you need to load nfs.ko first so that the .nfs keyring gets created
  via nfs_init_keyring()
- you need to restart tlshd so that it links the .nfs keyring into its
  session keyring (I tried loading nfs.ko at boot via modules-load.d,
  but tlshd still reported an error saying it couldn't find the .nfs
  keyring)
- you need to convert the cert and key to DER format
- you need to add the cert and key to the .nfs keyring, e.g.

  keyctl padd user "nfs_cert" %:.nfs < smayhew-rawhide.crt.der
  keyctl padd user "nfs_key" %:.nfs < smayhew-rawhide.key.der

- then you mount w/ '-o xprtsec=3Dmtls,cert_serial=3D...,privkey_serial=3D.=
=2E.'

Is that somewhat accurate?  Is there a better way to do it?  It seems
like a lot more work than just using the config file.

At any rate, I was able to reproduce the reported bug and the patch I
just sent fixes it, but I think we probably want to make dual
certificate support work with keyrings too.  What's the right way to go
about that?  Add PQ cert and PQ key parameters to the upcall?  Or add
lists of both PQ and RSA certs and private keys to the existing keys
and teach tlshd to parse both out of the existing keys (which I'm not
sure is possible)?

Also, is nfsd supposed to work with keyrings?  I see that tlshd looks
for a .nfsd keyring, but svc_tcp_handshake() doesn't populate ta_my_cert
and ta_my_privkey...

-Scott
>=20
>=20
> --=20
> Chuck Lever
>=20


