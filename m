Return-Path: <linux-nfs+bounces-21174-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MY8CYZk72mHAwEAu9opvQ
	(envelope-from <linux-nfs+bounces-21174-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:28:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C5473642
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F0403007BAA
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472453CA4A0;
	Mon, 27 Apr 2026 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+Xu28RE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1136E3C8723
	for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2026 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296486; cv=none; b=JpEQ0yEDxBFovEiRwEYcYnWlmYCRid/c6FsFQA5B/FOLhgb7l1IHhDx9xnxu6G02z2IWBLWrSnxQcS5gTwF03VJuXmlvHEogIFaaWIU+xs1Dxllf6nhNiwABnsy9z1JqOzJB8zXx5yKaQ2wDBl71OTiGyczTZK1tQolF1A9ZaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296486; c=relaxed/simple;
	bh=bl50Ep5/p8ND33Uem3F9a2mCUjhFig1ZZdRelrFhzvs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGoa5SmiZy+EE36PYU/ENNzeH8Hi+bx4aS9nnz9Y8Q/6I2LkySSV0YUijy8dqpkXaefwQchAurGX0HGSR65qFHTfvUvKXWpGp1UGKmNbtMSF6UHm1bWERlUfJNoSVr5PrgQpsJdCp+6WYIGA2fpmZaiuXsAnXwO37Ni0UV4AZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+Xu28RE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777296481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB5Kgu6P3tnZXGszhQUVKu+SbjuqgQqzL2PHunRJg4s=;
	b=f+Xu28REtVzZTuUMFazq0EYzL+YBinNg4DF18uOv775xVgXSdvwtj4DZt0epG1LWXuUepq
	XN7+caw6+ioiVyyEiQGs9errGNiUAKhHS5NZUcdqUGWvHq6SNYccnkQbJqd2s+TERVzTZP
	j6u0rUpD0lZE9J2e4GuGOGr9PEgYZLU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-xvuMkHvJNe-8r8RECjYy7g-1; Mon,
 27 Apr 2026 09:27:59 -0400
X-MC-Unique: xvuMkHvJNe-8r8RECjYy7g-1
X-Mimecast-MFC-AGG-ID: xvuMkHvJNe-8r8RECjYy7g_1777296475
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66EE318002C6;
	Mon, 27 Apr 2026 13:27:53 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.48.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C3B3180047F;
	Mon, 27 Apr 2026 13:27:40 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  ceph-devel@vger.kernel.org,
  gfs2@lists.linux.dev,  linux-nfs@vger.kernel.org,
  linux-cifs@vger.kernel.org,  v9fs@lists.linux.dev,
  linux-kselftest@vger.kernel.org,  viro@zeniv.linux.org.uk,
  brauner@kernel.org,  jack@suse.cz,  jlayton@kernel.org,
  chuck.lever@oracle.com,  alex.aring@gmail.com,  arnd@arndb.de,
  adilger@dilger.ca,  mjguzik@gmail.com,  smfrench@gmail.com,
  richard.henderson@linaro.org,  mattst88@gmail.com,  linmag7@gmail.com,
  tsbogend@alpha.franken.de,  James.Bottomley@HansenPartnership.com,
  deller@gmx.de,  davem@davemloft.net,  andreas@gaisler.com,
  idryomov@gmail.com,  amarkuze@redhat.com,  slava@dubeyko.com,
  agruenba@redhat.com,  trondmy@kernel.org,  anna@kernel.org,
  sfrench@samba.org,  pc@manguebit.org,  ronniesahlberg@gmail.com,
  sprasad@microsoft.com,  tom@talpey.com,  bharathsm@microsoft.com,
  shuah@kernel.org,  miklos@szeredi.hu,  hansg@kernel.org
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
In-Reply-To: <20260328172314.45807-2-dorjoychy111@gmail.com> (Dorjoy
	Chowdhury's message of "Sat, 28 Mar 2026 23:22:22 +0600")
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
	<20260328172314.45807-2-dorjoychy111@gmail.com>
Date: Mon, 27 Apr 2026 15:27:37 +0200
Message-ID: <lhuzf2oy1me.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: E50C5473642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21174-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,HansenPartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

* Dorjoy Chowdhury:

> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/=
errno.h
> index 92e7ae493ee3..bd78e69e0a43 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -122,4 +122,6 @@
>=20=20
>  #define EHWPOISON	133	/* Memory page has hardware error */
>=20=20
> +#define EFTYPE		134	/* Wrong file type for the intended operation */
> +
>  #endif

This is what POSIX says about EFTYPE, in the Rationale for System
Interfaces:

=E2=80=9C
[EFTYPE]
    This error code was proposed in earlier proposals as "Inappropriate
    operation for file type", meaning that the operation requested is
    not appropriate for the file specified in the function call. This
    code was proposed, although the same idea was covered by [ENOTTY],
    because the connotations of the name would be misleading. It was
    pointed out that the fcntl() function uses the error code [EINVAL]
    for this notion, and hence all instances of [EFTYPE] were changed to
    this code.
=E2=80=9D

So I'm not sure if reusing this name is a good idea.

Thanks,
Florian


