Return-Path: <linux-nfs+bounces-20427-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKJCAHFDxWkU8wQAu9opvQ
	(envelope-from <linux-nfs+bounces-20427-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 15:32:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC2F336D06
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 15:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10286309E264
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2026 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ED23FB7F0;
	Thu, 26 Mar 2026 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="aD2KrMxB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2833FBEA3;
	Thu, 26 Mar 2026 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534834; cv=none; b=HxrdXYQZoifeLEaN3/bsHBqfMvGTRvOZGjVd8Wt6/HMLApW2Xb77f+w4KnPwfHvP1n52iIDCVHt6marhWO+kFOTY8UtfD+ZvSk5s17FqNd03Y56HeTnUeSd87Hlsm7XgBoSL4wx0tuozgNJegViZpycKQX86pPnD6TuHANaXDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534834; c=relaxed/simple;
	bh=4GuxjtBu05AKU6vPjLN91uKmiwjkBY146mMAHOLVBfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2Vs3lorymoEEXxcGOy+x8yjcAquz0cZi0KtvIUjvhgdN3KKrQ6At1l1ATdgVg+Q6BYu6SiotL/G7ifR/GpLI++W7QvTDPI0MHxeRFMeT2nTfWS5mgAGvh0aSeI+d1kS9z62kSHC5BTc2Yk7eVOyGIuRMds1j7RFkGD85Kz6DnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=aD2KrMxB; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <fb437a64-efa3-4284-90b3-dfff336d533b@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1774534825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GuxjtBu05AKU6vPjLN91uKmiwjkBY146mMAHOLVBfo=;
	b=aD2KrMxBMNvi7eX45TA2mMPnX+OpNAsRXdHd2hO3Y/FZBxxBH4juI5vVj9+1384jX2gnWW
	MQPGoX8eqtIORxQI5B4Ffu5wMRWB5v2OcgFpWiZ3RhsK6Tb63jJk88FVFAudIdjgyf33hA
	6UkXPdeglJvj65t97hO8QwrZml/yDEshMJijI/PNewLz/zlvnGMwIU9AC+Po5l4ttxCAY6
	W1qK3KRu13XOG4HrKN9r2OojDhQrl3iVaVmlHgl5MUG9WBBU+HQ30KfkoAVoMa7ZiLHHhQ
	V6v5O4YDl0StX6YdsEymIsoVnNdyHbqS/9J2cGDJBsD9g0au0wN5KoI4+C2Ncg==
Date: Thu, 26 Mar 2026 22:19:27 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 25/26] netfs: Limit the the minimum trigger for progress
 reporting
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
 Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-26-dhowells@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <20260326104544.509518-26-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20427-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.com,kernel.dk,kernel.org,samba.org,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chenxiaosong.com:dkim,chenxiaosong.com:mid]
X-Rspamd-Queue-Id: ADC2F336D06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are two "the"s in the subject.

On 3/26/26 18:45, David Howells wrote:
> [PATCH 25/26] netfs: Limit the the ...



