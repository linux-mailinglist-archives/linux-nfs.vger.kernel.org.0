Return-Path: <linux-nfs+bounces-22629-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jld1FH9HMWrofwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22629-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:54:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834C68FA4A
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:54:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chenxiaosong.com header.s=key1 header.b=DXl5YP4w;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22629-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22629-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=chenxiaosong.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDD6C316005C
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F308A369D73;
	Tue, 16 Jun 2026 12:48:53 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCD369D53;
	Tue, 16 Jun 2026 12:48:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614133; cv=none; b=EqQXloIGrKjaZER9T6THEGxu261evYsKtY7eY/0B0FO0OOUHS0lXt1irLZ3Flb/Dtek3IjDLkMM7h/7epQAKDc3Gb2+NLRoIKIaaX8zpNp8MoaFhOad/DIBw1ZYgN7Sy5LyrsKWw1Cz+WWCDAudRGunbCV9UkWZp0X8nnopP5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614133; c=relaxed/simple;
	bh=+BRhsPWDpZjoK0HsveNG5UGVmQHqK2OhhoOq5wslwZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FY59LDnsN5Hqwi0HhBTCdaFKrzjoTjLyeUPPfk5ro9f6DgeaeNGjnFq/9ZXoQ+2GVanEMAVPHV6CY3Hbeyrulg3socybKc8tNHH6kq4siwbG/HzhlbAywPwl4YA/QtvdBeFSUlp1ea3etRjc8+XjAFRgAAiOgaPUUeEshWdYdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=DXl5YP4w; arc=none smtp.client-ip=95.215.58.173
Message-ID: <b6b19c84-7734-42ea-b2ec-9ace1f36ad08@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1781614119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wv0+MgqNRvRce0wQH8tzVOBI1JIX52tUPZ58AWe7J8U=;
	b=DXl5YP4w2nX9zBF/auRW6duXvS9I+LFh6H72wP2z7tgKv4bVq1GepXsY8YwJgiuxk/3GYJ
	utsvh8oA1hM5Kec1L2eqj7x9jLuM39MuNcqFVWCQlxcbVvJf5UuT7X6eGlgcHbnkR/32DA
	5PNFdhWzOvpVWaJ/smJLv8N+zcFXXuBpa/tcwnDrn+6tX8vWPV0jrQwPKilpFVlwL6JsyU
	NgC8RocoDRsvVJelCGWkydzsykPdIiiMd9+HKmhv/CAAb0NJhfq7tp8HQgIgsnKJEnb/FJ
	zY3lj94Gbuc4hUnVoAKzBsLPkNkrQsg062VkaRzcyMkvx+Oemz6MzQHqkEjodQ==
Date: Tue, 16 Jun 2026 20:47:29 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 30/30] CHANGES
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
 Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260616100821.2062304-1-dhowells@redhat.com>
 <20260616100821.2062304-31-dhowells@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260616100821.2062304-31-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22629-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chenxiaosong@chenxiaosong.com,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[manguebit.org,kernel.dk,kernel.org,samba.org,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chenxiaosong.com:url,chenxiaosong.com:from_mime,chenxiaosong.com:dkim,chenxiaosong.com:email,chenxiaosong.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9834C68FA4A

Is this patch missing the subject and commit message?

On 6/16/26 18:08, David Howells wrote:
> ---
>   fs/netfs/iterator.c    | 22 ++++++++++++++--------
>   fs/netfs/read_retry.c  | 12 +++++++++---
>   fs/netfs/write_issue.c | 24 ++++++++++++++++++++++--
>   fs/netfs/write_retry.c | 23 ++++++++++++++---------
>   fs/nfs/fscache.c       |  3 ++-
>   fs/smb/client/file.c   |  2 +-
>   6 files changed, 62 insertions(+), 24 deletions(-)

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en


