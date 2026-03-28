Return-Path: <linux-nfs+bounces-20502-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GUFAb4eyGkShAUAu9opvQ
	(envelope-from <linux-nfs+bounces-20502-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:32:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE7434F9D1
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 19:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B63B3023069
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2026 18:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423AD3A543F;
	Sat, 28 Mar 2026 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="INI1qEvU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA83A3E82;
	Sat, 28 Mar 2026 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774722573; cv=none; b=mk2OS6NwhVwRUIdVdy03zq6plPPp7vE3uKQM/pLcI3sK0sC/pSLvAaUUfqZatNwsSkMBfYwyyc3aHvLjecjkPdF8tIUTPKXNeTryq06cYh7dPnU78xYFBrE9Q4JJojqftB8A455xmX188AwPIDTayYkv7moDxP31VzUswIW7oeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774722573; c=relaxed/simple;
	bh=stj4Bstm93FVtyrGE8gZawmys4uV6p7BkRzmehGQNsE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=Wj+D39pjnYvqSZC03QRpC+P2xYvRr9Ga2foQYINc/TxfDsK081q1dC5L9l2dYJX45eaz5cLJXMGVrOydEsVWhrVDOxU7Wd/Je1MgAj7hwwI/ED0+lA1Kysunt73uJOXWlH16e+PFo0QCkh2HZvFLFvkyX4X4p9luYZPI1hiceBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=INI1qEvU; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Sender:Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description;
	bh=pjWAhC/pRJ11i7dihmGstGNUCTp1Y38MOjqiDtDdmNs=; b=INI1qEvUexzKgv/Xbd2+s18EwR
	FHn0RIWLefTqo8OnxI0eiHFe9yd7Wgk/um9AhFcKtHPtEj01PXM9wvSUs1TZpqUIivsMSujqn6m4H
	FCZtN/q1vNxkgyKtNOQXjPsMRItEkBEEQNQF+f24nBty5o3q03Of/pZbvCNmaXH2ohSyObbv6UhIB
	7kVxtfq63z13dLrvUOvCGkoT1TUXPgcqcT7AEjbl4Coiu0gkejZqcv1EnPTOxgzJEykcTZRPObyVS
	ir/wFgpEVQaYdVONbf2uxhfixfCy/hJKtlytT0+DYASOdIEVyJmgYwXaxHFqR6Y5NHxFF2vgzdYCf
	NohctqLA==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1w6YPY-00000001nlp-2Cuc;
	Sat, 28 Mar 2026 15:29:28 -0300
Message-ID: <7e285c78b2f745b0b4c33db2af7b6d26@manguebit.com>
From: Paulo Alcantara <pc@manguebit.com>
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
 linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>
Subject: Re: [PATCH 07/26] cachefiles: Fix excess dput() after end_removing()
In-Reply-To: <20260326104544.509518-8-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-8-dhowells@redhat.com>
Date: Sat, 28 Mar 2026 15:29:28 -0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: pc@manguebit.org
X-Spamd-Result: default: False [0.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[manguebit.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20502-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,brown.name];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[manguebit.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.com:mid,infradead.org:email,linux.dev:email,auristor.com:email,manguebit.org:dkim,manguebit.org:email,brown.name:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6EE7434F9D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

David Howells <dhowells@redhat.com> writes:

> When cachefiles_cull() calls cachefiles_bury_object(), the latter eats the
> former's ref on the victim dentry that it obtained from
> cachefiles_lookup_for_cull().  However, commit 7bb1eb45e43c left the dput
> of the victim in place, resulting in occasional:
>
>   WARNING: fs/dcache.c:829 at dput.part.0+0xf5/0x110, CPU#7: cachefilesd/11831
>   cachefiles_cull+0x8c/0xe0 [cachefiles]
>   cachefiles_daemon_cull+0xcd/0x120 [cachefiles]
>   cachefiles_daemon_write+0x14e/0x1d0 [cachefiles]
>   vfs_write+0xc3/0x480
>   ...
>
> reports.
>
> Actually, it's worse than that: cachefiles_bury_object() eats the ref it was
> given - and then may continue to the now-unref'd dentry it if it turns out to
> be a directory.  So simply removing the aberrant dput() is not sufficient.
>
> Fix this by making cachefiles_bury_object() retain the ref itself around
> end_removing() if it needs to keep it and then drop the ref before returning.
>
> Fixes: bd6ede8a06e8 ("VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: NeilBrown <neil@brown.name>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: netfs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/cachefiles/namei.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)

Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

