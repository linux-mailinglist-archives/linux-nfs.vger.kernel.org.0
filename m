Return-Path: <linux-nfs+bounces-20498-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIkTI20cyGkShAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20498-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:22:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1853034F843
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B339303C01C
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957993A5E8B;
	Sat, 28 Mar 2026 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="yV3i1ZDX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34F311C3E;
	Sat, 28 Mar 2026 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722093; cv=none; b=k68H4QliFQsmzm8Q0a6XlSjOd5sVR5JxRCEDNF7Fow/zB1zOeW4pHDObB+kgaAeZDRrAcsuBj7FtdBMatQghykwUKeY3NtTEtabxay78btlF99/naax7zuZOfVqbIdYMGadm89tQD8gzZcLFDr/oi3TTjIs2sgjfzx1m5sNfAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722093; c=relaxed/simple;
	bh=MinlzgTRZOQOU+ZnCzi3bVVdRjTaVwW+2Q7t1oOEGuQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=rszQXD4TT9XvVmH0LzQp+5CREJWA/E+FpoSEQPTfDgVRNcD9uECenIMxTfDNEEUmQPd28K/YFmyCOEHFDVoWg5OqMkperf1TgY7E3Yp4mlWt0r194PI1IdXoo0jfxxL+1ifBewEERrUP8HJhKkKH3Id+K0r/bXsO/B+wQdM9FHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=yV3i1ZDX; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eneYkUaGNQxVaJ+FyiE6Puc0DLjeVqMvpsPglKgRZDc=; b=yV3i1ZDXK5EP1hNmZxbH/02Szf
	WQxC6OwS5mlem0F8BGjttX7h18KoSHbC0p2ZFNWIl6OfFQbhmrgItu+J8wNr1Werr/qAMI6z6XsHN
	DVDGDfJnlfc/EQzfo9vaIiL60AqN8bUwbyS43nLgHHG5c4MyH3GFkACVC8r/Z4SUCWPmXjrgH1dIo
	4ss35KIRn098GQxrF/1YfwPahfjBG5venCzwkrm14SlsG6PZOOlkEkkrJ076yt/sIYk+MV9S2L9Qc
	nb9DyiO2xACZ9VJEYvcPxNSyiInLhKb1gRkz2+CA9TVcrQNMJc96B9+GOzI3zXLvgla2n4snmsOae
	ZwNRAgyw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YHq-00000001ng2-0xPm;
	Sat, 28 Mar 2026 15:21:30 -0300
Message-ID: <ae7728f96fd050ec3224ddcfb539eeae@manguebit.org>
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
 syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com, Deepanshu Kartikey
 <Kartikey406@gmail.com>
Subject: Re: [PATCH 02/26] netfs: Fix kernel BUG in netfs_limit_iter() for
 ITER_KVEC iterators
In-Reply-To: <20260326104544.509518-3-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-3-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:21:30 -0300
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
	TAGGED_FROM(0.00)[bounces-20498-lists,linux-nfs=lfdr.de];
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
	TAGGED_RCPT(0.00)[linux-nfs,9c058f0d63475adc97fd];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,manguebit.org:dkim,manguebit.org:email,manguebit.org:mid]
X-Rspamd-Queue-Id: 1853034F843
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> From: Deepanshu Kartikey <kartikey406@gmail.com>
>
> When a process crashes and the kernel writes a core dump to a 9P
> filesystem, __kernel_write() creates an ITER_KVEC iterator. This
> iterator reaches netfs_limit_iter() via netfs_unbuffered_write(), which
> only handles ITER_FOLIOQ, ITER_BVEC and ITER_XARRAY iterator types,
> hitting the BUG() for any other type.
>
> Fix this by adding netfs_limit_kvec() following the same pattern as
> netfs_limit_bvec(), since both kvec and bvec are simple segment arrays
> with pointer and length fields. Dispatch it from netfs_limit_iter() when
> the iterator type is ITER_KVEC.
>
> Fixes: cae932d3aee5 ("netfs: Add func to calculate pagecount/size-limited span of an iterator")
> Reported-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9c058f0d63475adc97fd
> Tested-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  fs/netfs/iterator.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

