Return-Path: <linux-nfs+bounces-21697-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PLtMuYeDGqoWgUAu9opvQ
	(envelope-from <linux-nfs+bounces-21697-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 10:27:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 500E257A039
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63E6630433CA
	for <lists+linux-nfs@lfdr.de>; Tue, 19 May 2026 08:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887733E0C6F;
	Tue, 19 May 2026 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="kuwZ1DAz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F4629B200;
	Tue, 19 May 2026 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178803; cv=none; b=Y6ac7zA+z0s7ZrCQxRrjE/w6V/N2cZt52L12KPsTZKrrGnqt5erWY8G0X36+ev6mRJs2UMau2W+m6RJ+ZhBxS5le6Vh/Pbk07unMaKSHTis+u7eKMLdXauuANmzmCfSRNQ4i89nXCMnyJo8kTh50gaMJ2F4plgqYIO7cKRAoa0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178803; c=relaxed/simple;
	bh=BPoANtWN8bxjpzaJqRiXB8yCCFSbtQURcz0h5mbYkyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCefNVp6EXv0gbW2eXqkTFerFv0y9lLHjfiRnx+8iEVevOezIDuMl5gZw5CMj/EwTcyHDtPXFOBmFWTUprLA7y3LAeLgVhrjpZfQxWrsO6Wl3/vKrVU1Y77MVX5+DYwJ35KMx1iemBJ3qGl5wrVhRiW8kFxl7Rs7/nDDTLP9+DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=kuwZ1DAz; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=fr2zJjLeRwLyU1stMgWUrx1BS/dEa/ud23FxfpYN88k=; b=kuwZ1DAzGal4aQoOj1GbVdC865
	rmds6XPQSBxs2++l2qrHmS7opx1hRc6JFcHOLDxv28CyzpVX7YMy3ZXH4C0rEqs8GeTE3/Ob7XFW3
	f0G2XsIq0I/T48R+ySzDLEoAp9NuaMgywT7xLw0H9DGEuUyylhbvn1qiDpYGzT866YvN6siGxqmZZ
	1KQdh5FejimtlL98a4qqAIK4r3XovtJlGPuMeX4YkEkgLn8iaAU9IGZPiySsVZEgBu8o/vjYodAJa
	+cVXeVf7ovNAXUZtBD2CmoCz4ooD02lDXqc5l8qdI8R+m2Co2O4wBhrFimzonL5tvbsjxZubLxoZO
	ARHN9porL18ETE3NAEt/lAhvlzSbpsL2DDGhrgFX5fRo0KaUqitCF2uu1W8Hysm800za8KckXsxXH
	+M8w5u+/UnGGW3oW+lpG26oeVKJOO1kwzlr7TTDNHuGKWshe5cgLbz1PC4mWiInZV9YPF33wutZV8
	iRU6lg5+6+066NUuuXZSKNvS;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wPFgF-0000000A4AG-0bCE;
	Tue, 19 May 2026 08:19:59 +0000
Message-ID: <83ade7bf-9117-400d-b120-ed15401d09ff@samba.org>
Date: Tue, 19 May 2026 10:19:58 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/21] cifs: Remove support for ITER_FOLIOQ from
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
 <20260518222959.488126-15-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260518222959.488126-15-dhowells@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-21697-lists,linux-nfs=lfdr.de];
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
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,samba.org:mid,samba.org:dkim,talpey.com:email,manguebit.org:email,linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 500E257A039
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Am 19.05.26 um 00:29 schrieb David Howells:
> netfslib now only presents an bvecq queue and an associated ITER_BVECQ
> iterator to the filesystem, so it isn't going to see the ITER_FOLIOQ
> iterator.  So remove that code.
> 
> Netfslib also won't supply ITER_BVEC/KVEC iterators, though smbdirect
> might; further in future, it won't supply iterators at all, but rather a
> bvecq slice (that can be used to construct an iterator).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Stefan Metzmacher <metze@samba.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

Acked-by: Stefan Metzmacher <metze@samba.org>
if you change this in the commit message
cifs: to smbdirect: and smb_extract_iter_to_rdma to
smbdirect_map_sges_from_iter

Thanks!
metze

