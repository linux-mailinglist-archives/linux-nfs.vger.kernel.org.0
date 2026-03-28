Return-Path: <linux-nfs+bounces-20497-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFCtNhQcyGkShAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20497-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:21:08 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5691A34F807
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B14483031E8E
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD783A4F5F;
	Sat, 28 Mar 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="sqT5cKpt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB738A70A;
	Sat, 28 Mar 2026 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722061; cv=none; b=Za3dZod/bl9+4tpkj2lT+lWo6QbSNVWCEJmi0K7amYQY0cfXWNiSzwCke3tGDjdImVW6Wiyzz6ehwiXqDwz08FDgbCxV/X6yATXW2fIbQlsxj3ROco0D1vmVqvF4fRT4XxoZalAtTbBtefc6zLjalQgIFDAjnYmpGv9/UXD2xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722061; c=relaxed/simple;
	bh=NRoMd/7d12F1ENt5m8qXDzmQksu82jSPGugSRjcnwtA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=MFN7eEW503t+7+rJyWNwpkAl/iiWUSRyWWZpv2c5W7fIuBdYh4u/MIh8Hva2anLbx/tfKoNrOjYsGQa+JMKDb5vby4XMvXQ2omHiDd0TJhh2ZasBsQC+wLFc+HFNMBWRMkW1DyNKHYvCam5YdlRRhVPjnHLf4sWF6IyqSGB8v1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=sqT5cKpt; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=reVttJ4xFR0WcZPDlyXMurvNf6WDPPLRFPlRnwcnixk=; b=sqT5cKpt/tMHM/kACWo4Il0ZHF
	IUn796fZuwnC+Wyu5QTqvpyb9bJ6qK8ZoJAGB4agtzpORv3z2VlKCzgEkPc4syqvJNIBWy7OEoOkn
	c9gCghMvJCWFLiYP4XakWG1pNiMyLAhVENhn9MIXdrLgexLNZu9R6oej67AMc7IyHkkHeY9CNPowv
	Cxg83PHujJQVOiNsgjiK2ughsIWXPfBn5VbD7eKMYxgTBWCsr+i8d5wQwaZz1X76zNVZGxvyF16Bs
	tZl4exrAbAMoRFSuzdMDCmT07ly8JceXPTMH0KuLk1ohGPE/60mwdmWtufn4QiD7Q57hCJWEo9U/A
	zvcmaNUw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YGz-00000001nf0-3jFV;
	Sat, 28 Mar 2026 15:20:37 -0300
Message-ID: <9677d7ab513928a8677a1ce99f18d189@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: David Howells <dhowells@redhat.com>, Christian Brauner
 <christian@brauner.io>, Matthew Wilcox <willy@infradead.org>, Christoph
 Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, Leon
 Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne
 <marc.dionne@auristor.com>, Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Ilya Dryomov
 <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com, Deepanshu Kartikey
 <Kartikey406@gmail.com>
Subject: Re: [PATCH 01/26] netfs: Fix NULL pointer dereference in
 netfs_unbuffered_write() on retry
In-Reply-To: <20260326104544.509518-2-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-2-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:20:37 -0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20497-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,syzkaller.appspotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[manguebit.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs,7227db0fbac9f348dba0];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5691A34F807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> From: Deepanshu Kartikey <kartikey406@gmail.com>
>
> When a write subrequest is marked NETFS_SREQ_NEED_RETRY, the retry path
> in netfs_unbuffered_write() unconditionally calls stream->prepare_write()
> without checking if it is NULL.
>
> Filesystems such as 9P do not set the prepare_write operation, so
> stream->prepare_write remains NULL. When get_user_pages() fails with
> -EFAULT and the subrequest is flagged for retry, this results in a NULL
> pointer dereference at fs/netfs/direct_write.c:189.
>
> Fix this by mirroring the pattern already used in write_retry.c: if
> stream->prepare_write is NULL, skip renegotiation and directly reissue
> the subrequest via netfs_reissue_write(), which handles iterator reset,
> IN_PROGRESS flag, stats update and reissue internally.
>
> Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
> Reported-by: syzbot+7227db0fbac9f348dba0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7227db0fbac9f348dba0
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  fs/netfs/direct_write.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

