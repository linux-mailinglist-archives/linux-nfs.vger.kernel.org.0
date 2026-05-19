Return-Path: <linux-nfs+bounces-21696-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE7MOrUeDGqoWgUAu9opvQ
	(envelope-from <linux-nfs+bounces-21696-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 10:26:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7F3579FF2
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 10:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 297003026F3C
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92613E0C71;
	Tue, 19 May 2026 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="jbVosT1Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099813E0C5A;
	Tue, 19 May 2026 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178731; cv=none; b=oJOlmbUkTpexhSriGX7xp/bTPuEAcD/DufKxyy6FsyfAADPrP4BXCvZLLkPNvGWuMXN9WLyrS5o8DKfFMgcmZC7zNpgRkN7Ldr7BeweRRl0f5EeSOW/DOfvzQFar2zi9EKc2v7+dUdY6TKr1zu3HdHiqv7JQH7Np5YI3XR9I5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178731; c=relaxed/simple;
	bh=sth4L1Aj3uBS95TQ8Tp0GZde5GDnWBdau+lLH9/OFjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRGSxLgKDAa4IGnbRRGxcF9ZRBKXnkG7YMctdHTD6lzqCy7E87QFYYyS+H2sxcR0m8Q8OUkibmU3+/jcC2N+DMowJ93zuUFsV+qcxbOw+v8GLU+KAxg3XzOW433jovz/EE5uEBYz+NMfj9k0JpYD/BBC1mXN5tQ644uZhpn56Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=jbVosT1Q; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=/V0uCcTkPx7SeLeHejwFFUsYezoJoa/+Lv/mTKKGzLs=; b=jbVosT1QO1f9Cz7qpHgjMlsyf/
	4e27Lu3/yXnfG2P6cxGcZFyCuyo6R/904UuuUgS4YpJ9SpcrK09xs8RmAUB8yvVZSpm2BnuJjZjXQ
	936i/53btEChIGEzBwTVNoySMidn4LvxGErxmLtickMl2DJD0Ty/bBad3wzkC1iE3vApcipTdN9aK
	Dp4i/ehpjwITkuuSfxWmvIgsWl7c4j+2UMIhg2fm8hQr+6lYz7nXlTBvBda0Bib18j7XA4XdHgNbV
	+XToJwitaNLB6r8/e2M80jTehqcSgxK4OUJa5P6Pi3vpao16vZTTj75LFFEDnkKniXbTgrTgBCoC6
	+cZ9gRye8zmzFIBG6Q/QrRxhuwG56tHWzD+0ngfii4Uv3Mu00QUWhYNCnVVFDZdCckKT9JHvI4r5k
	9YA6FzYWJG6oV4jQbTGhVGUsheO0d3W2+mArrQatYOPM+FZ9TgK60aX7Iy44bEvyOpcBaYkGghQJs
	IxRS4vrPQQvJaKgUeUCku595;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wPFev-0000000A48T-2DUc;
	Tue, 19 May 2026 08:18:37 +0000
Message-ID: <682a2d95-60d7-4303-a9ea-7dbd16f20b48@samba.org>
Date: Tue, 19 May 2026 10:18:36 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] cifs: Support ITER_BVECQ in
 smb_extract_iter_to_rdma()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
 Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shyam Prasad N <sprasad@microsoft.com>,
 Tom Talpey <tom@talpey.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
 <20260518222959.488126-13-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260518222959.488126-13-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21696-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,microsoft.com,talpey.com];
	DKIM_TRACE(0.00)[samba.org:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-nfs@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,samba.org:mid,samba.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:email,manguebit.org:email,linux.dev:email,talpey.com:email]
X-Rspamd-Queue-Id: AF7F3579FF2
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi David,

> Add support for ITER_BVECQ to smb_extract_iter_to_rdma().
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Christoph Hellwig <hch@infradead.org>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

Please cc me on this if you report.

Acked-by: Stefan Metzmacher <metze@samba.org>
if you change this in the commit message
cifs: to smbdirect: and smb_extract_iter_to_rdma to
smbdirect_map_sges_from_iter

Thanks!
metze


