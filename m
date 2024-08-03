Return-Path: <linux-nfs+bounces-5225-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7422946ACE
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2024 20:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C1E1F21567
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Aug 2024 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E851114;
	Sat,  3 Aug 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="HrJyGaFj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078F18633
	for <linux-nfs@vger.kernel.org>; Sat,  3 Aug 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709342; cv=none; b=rlj13vRirY0fHs/64rrbrS7lRmewmKS4utlNB4oLkhSyXPxBPdqco3066nU/4otAQHHuwitpO9h7jOaePyRkAPDNC4aj+SsN6+g1aaUUqkGLb0QYlZ3QSzWrdAzze0JFW0h8rPPc+HMcd0zYkTDodwJ7R+/2LxBwqlgBZLSGdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709342; c=relaxed/simple;
	bh=/Oacuwo3q9P0TXuw02Njv//dCDm7Z9owpxbNMjv49g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9S687iN8hN2dwsJHbZQxWp9OxwF9rW0uXMNnbxPcqBOnMxjIIJtNMPcnO+aBo6+bBNfK2U55KZ6vl7MCDZCm+KZfauIGd6kp1879ha1rY0rt3sbsvsriqPb/QtGHMNh4kAUEo4YXVz5ucd4tWApbkkglyA9qDufMcu5TSZlhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=HrJyGaFj; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from [192.168.1.12] (unknown [46.22.16.104])
	(Authenticated sender: blokos@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id 56012780506;
	Sat,  3 Aug 2024 20:22:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1722709331;
	bh=/Oacuwo3q9P0TXuw02Njv//dCDm7Z9owpxbNMjv49g8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HrJyGaFjy0/BceCvCcTAhi0CZtQjNXM6eeX2lIOO7xE54BRjrwF7SWxmS0KHjkgX6
	 dku63iyxQVjXHnJEsi1sd6nzyoNgW+ggRnCPkT1N4bHhIh4SM4Eaw8DNFfJ7BV8kfo
	 GXNsD8//ppoMli234HsWa3tKcVgHaFpyHCHVeKD0SPyNqHgVBvKBkH6aAaiYwMea+R
	 wdxExtW7odMPKNMcd+GllexKzkFPUwJqZQg4W5K7dbHfQgifxEVdIRlfAE3qCCce7N
	 +GlMGJU/9HGMyJ1m3uCEZ9rPPZDUbZ1Uwl4xeddA7k+luagHJBHtbTLqwN/S42TW6H
	 KqOWaPghbheHw==
Message-ID: <8d852313-1d8e-4ddd-b676-3f7a17503c86@free.fr>
Date: Sat, 3 Aug 2024 11:22:03 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel 6.10
Content-Language: en-US
To: Hristo Venev <hristo@venev.name>,
 Trond Myklebust <trondmy@hammerspace.com>,
 "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "dhowells@redhat.com" <dhowells@redhat.com>
References: <b78c88db-8b3a-4008-94cb-82ae08f0e37b@free.fr>
 <3feb741cb32edd8c48a458be53d6e3915e6c18ed.camel@hammerspace.com>
 <zyclq4jtvvtz6vamljvfiw6cgnr763yvycl3ibydybducivhqh@lj2hgweowpsa>
 <3bd0bfc1fced855902c8963d03e8041f4452b291.camel@hammerspace.com>
 <47219e1df5edbfaf7e8a64ebf543a908511ace85.camel@venev.name>
 <5412f22e497b11c1cd3fc8b8d8f30d372b68cd03.camel@venev.name>
 <sl7cfmykqthhjss3qxeg2aweykff2gurcjqczfry62ne6edrfa@oocwcci6im3o>
 <eba1f68169ce0bfdd5e0881e04f67b0c57d6ce2e.camel@hammerspace.com>
 <056dde73b48f7a6ee1ca9bf6cc2f0f11536424c3.camel@venev.name>
From: blokos <blokos@free.fr>
In-Reply-To: <056dde73b48f7a6ee1ca9bf6cc2f0f11536424c3.camel@venev.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/3/2024 7:22 AM, Hristo Venev wrote:
> On Wed, 2024-07-31 at 15:27 +0000, Trond Myklebust wrote:
>> On Sun, 2024-07-28 at 11:33 +0300, Dan Aloni wrote:
>>> On 2024-07-28 02:57:42, Hristo Venev wrote:
>>>>
>>>> ... and 0x356 happens to be NETFS_FOLIO_COPY_TO_CACHE. Maybe the
>>>> NETFS_RREQ_USE_PGPRIV2 flag is lost somehow?
>> Why is netfs setting folio->private at all when it is running on top
>> of
>> NFS? It doesn't own that field.
> As I mentioned previously, there is something going on with the
> `NETFS_RREQ_USE_PGPRIV2` flag. In particular, it appears that it isn't
> always set in `netfs_alloc_request()`. This may happen when
> `netfs_is_cache_enabled()` returns false on a cache-enabled filesystem.
> Maybe the inode cache state is not yet fully initialized?
>
> The patch below seems to fix the issue, in the sense that reading from
> the filesystem is no longer a guaranteed crash.
>
>
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index f4a6427274792..a74ca90c86c9b 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -27,7 +27,6 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
>   	bool is_unbuffered = (origin == NETFS_UNBUFFERED_WRITE ||
>   			      origin == NETFS_DIO_READ ||
>   			      origin == NETFS_DIO_WRITE);
> -	bool cached = !is_unbuffered && netfs_is_cache_enabled(ctx);
>   	int ret;
>   
>   	for (;;) {
> @@ -56,8 +55,9 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
>   	refcount_set(&rreq->ref, 1);
>   
>   	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
> -	if (cached) {
> -		__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
> +	if (!is_unbuffered && fscache_cookie_valid(netfs_i_cookie(ctx))) {
> +		if (netfs_is_cache_enabled(ctx))
> +			__set_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags);
>   		if (test_bit(NETFS_ICTX_USE_PGPRIV2, &ctx->flags))
>   			/* Filesystem uses deprecated PG_private_2 marking. */
>   			__set_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags);
>
>
> However, there is still another issue: Unmounting deadlocks on
> `folio_wait_private_2`:
>
>     [root@localhost ~]# cat /proc/489/stack
>     [<0>] folio_wait_private_2+0xc7/0x130
>     [<0>] truncate_cleanup_folio+0x4a/0x80
>     [<0>] truncate_inode_pages_range+0xe1/0x3c0
>     [<0>] nfs4_evict_inode+0x10/0x70
>     [<0>] evict+0xbd/0x160
>     [<0>] evict_inodes+0x15e/0x1e0
>     [<0>] generic_shutdown_super+0x34/0x160
>     [<0>] kill_anon_super+0xd/0x40
>     [<0>] nfs_kill_super+0x1c/0x30
>     [<0>] deactivate_locked_super+0x27/0xa0
>     [<0>] cleanup_mnt+0xb5/0x150
>     [<0>] task_work_run+0x52/0x80
>     [<0>] syscall_exit_to_user_mode+0xef/0x100
>     [<0>] do_syscall_64+0x53/0x870
>     [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>     
> In 6.9 the `NETFS_RREQ_COPY_TO_CACHE` flag used to be considered by
> `netfs_rreq_assess`. Now it no longer appears to be checked anywhere.
> With the new netfs cache implementation, how/when is the `PG_private_2`
> flag cleared and when is data written to cache?
I don't know if it can help, but I noticed this issue growing when the 
responsive time of the NFS server (or cachefilesd?) is longer because of 
the network or a busy server doing other tasks.

