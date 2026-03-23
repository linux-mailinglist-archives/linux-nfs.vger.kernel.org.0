Return-Path: <linux-nfs+bounces-20340-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EgaJ7rGwWlTWQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20340-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 00:03:22 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1D72FEBA2
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 00:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89C3D300D777
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 23:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8699538423A;
	Mon, 23 Mar 2026 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="z4y3i2gt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457F79CD;
	Mon, 23 Mar 2026 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774306996; cv=none; b=LGFIkDMk+gq5+yIsIZXDCugMOWWFd81ehw8UdVwPtRRaZAKrQLzO2L81K8g5cklk05TxzR4CKEQxoZ0ZfQOG4tNKAzK2K9CVKwjn2DmS46qLQqxppd7e3dv/6IowSDzVokhDsyvw+Wrf2n8EtdWN4jTY6QjrCfdynaFB+g8vYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774306996; c=relaxed/simple;
	bh=o20pGIE6e3zMP2YgHnxdXSPeVmtTzxoaRe/pQHvnMPs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=W9A3PgQGzGFK2xJpC3ke93mQoWpAf8lfXqUwS+wdzlnSmc87PjH0+6bFYE5iRyKU+879BEnGRN6+Oek1F1LzOMPh9u4js6+r2rOBIb9xAztoLeG9pROPkTAD54TaK9HA5tyiZX4G0lVrNSc+Lzsb9Po8m+cXTRTjbPRjGLPAQOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=z4y3i2gt; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SNc5qjc11LF+yDAgvSiAjcDnxKafViW2CPS3X8enE4E=; b=z4y3i2gt++8VjcZHyiUuE0M57y
	n788P0tl4uKOi3GRE7u1CPqGVgxFJ7e6maKoZ0IcG6+GHUXoTVWwiu3REBDW/9+l/amytRfu6l+LR
	LEwsCDn73ixnYNXtXyM828t3HYWDAYlA/zl6pPf/h0L9ME7qN7UR/9raR7Kx2flg/3KoJpo6wxroU
	KEU4fSkH4BiXjNyJ38A6FCKGUHISVn/jWjwJqSL5qX5FAA+MK9RWBSuaZOF4/6r5FeSu7fFLiW1VV
	Ln7+BpDZx0qkl7rziWByEtCLU5w9pMPQ6mnHpLtWwohrLNLuuL7ZZM28gFubuQTgnApWbqhC1ESEQ
	Ts/0VmBw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w4o0q-00000001TOp-3alP;
	Mon, 23 Mar 2026 19:44:44 -0300
Message-ID: <63655684a778145167a549b4a6251ccf@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: ChenXiaoSong <chenxiaosong@chenxiaosong.com>, David Howells
 <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>, Christoph
 Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Leon Romanovsky
 <leon@kernel.org>, Steve French <smfrench@gmail.com>
Cc: Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 17/17] netfs: Combine prepare and issue ops and grab
 the buffers on request
In-Reply-To: <2d8ce118-2f7a-4b7f-8786-4581b29cb74e@chenxiaosong.com>
References: <20260304140328.112636-1-dhowells@redhat.com>
 <20260304140328.112636-18-dhowells@redhat.com>
 <2d8ce118-2f7a-4b7f-8786-4581b29cb74e@chenxiaosong.com>
Date: Mon, 23 Mar 2026 19:44:44 -0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20340-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[chenxiaosong.com,redhat.com,infradead.org,kernel.dk,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[manguebit.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D1D72FEBA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ChenXiaoSong <chenxiaosong@chenxiaosong.com> writes:

> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -161,8 +161,8 @@ static int netfs_unbuffered_write(struct 
> netfs_io_request *wreq)
>                                          break;
>                                  }
>                                  netfs_put_subrequest(subreq, 
> netfs_sreq_trace_put_failed);
> -                               subreq = NULL;
>                                  ret = subreq->error;
> +                               subreq = NULL;
>                                  goto failed;

Thanks for the review.  The above is still broken as it wolud cause an
UAF on @subreq as we're putting it with netfs_put_subrequest() and then
dereferencing it afterwards.

Besides, we could also get rid of 'subreq = NULL' as it is currently a
no-op -- including in other places.

Let's wait for next patchset from Dave, though.

