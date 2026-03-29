Return-Path: <linux-nfs+bounces-20509-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBxRNFMIyWk3tgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20509-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 13:09:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6916C351BBA
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 13:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83070303DD5D
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C7531E82B;
	Sun, 29 Mar 2026 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="PiLEQZm5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9259EDDA9;
	Sun, 29 Mar 2026 11:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774782475; cv=none; b=T3+5g99/dVZnsu4i7xqVEYspXhAyAPGVWvhn3TQhZbD1N80M0j9JpxzP/pr1IJsr7meV8WWeLOiGWEZWiyl1iHTG+6SQsYpvguDPbpmtjqEMlfyC3PXsAzy8dwXyOcbnODbn2uv9l0SXqwg+3QF6+fNM5XuMTWdXTIjmmNkib3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774782475; c=relaxed/simple;
	bh=yjjxpqvd+a/rjA5MTzXYdAhwfxQxaGwCW/0Eq+6+umE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZTBTCxnafYCRhLFUB+XL9WYgtpjHUXin2Sxg2mrNNeh1H8Mc3rhfojdRX+7zAnMhDSU6XKAXp9weIqSZ4qRHBdN6g5bYhT5E6AjUiqwWC61qwfNvFaUWyffIUop1SKiPZa9tsB6rDH88imAMuiPQm2V0cqnpsLEdXeneV2dey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=PiLEQZm5; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=RxhU2zRFQJPwn1alKxvt3d1j41p1m0pswRCOYSeSKwk=; b=PiLEQZm5mqvScAjS2ran7A93NN
	tT+0hqNaO3AKSp38VFjDOyr4QqHf3f/PF+otaCe3CHPlw3os32ci3djrk1cBqD0QoXt3Cj1l3rWbk
	2VhlGnA/OnYQzduAxvCOfFunZuYi887tOwzpuwaxAD9U9qBTuBgFZr9ZBYQ4RVf2EcjrlTt68tjxI
	VzJjMsBP5bIXQc+7FkCMtUMPXo5BJ4eIfdkXMudiMTr6OOw0Dly9xZUQ2WPBzDhEmlB/xpOMCn81K
	ViLZrp89MjoXaFWcEnmY3wJkRyOAvQKCa3yzwF3BbuaNm2s1thT9Nk+ilOoR6VnbMT1qlPoKnUxgR
	uGk35xQTni/lUJofQir41P6/cB4pTAu3aBDEt3aSmXyUo1tAFqygU5UQpOfuDYGildw2qghrqeKQP
	jbs24HACeelMd0x7/+0rocvMjfOtLuEbguusbVq73SMM/S1GHueZTkRaFsaMkZsBtKr272mpMP1lc
	b9lye8A4/GwbzG9YVkIUg9qx;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1w6nzj-00000004jUw-0RdL;
	Sun, 29 Mar 2026 11:07:51 +0000
Message-ID: <52ad0aa6-d8dd-4ba1-adf2-f79128df9d90@samba.org>
Date: Sun, 29 Mar 2026 13:07:50 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] netfs: Keep track of folios in a segmented
 bio_vec[] chain
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
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
 linux-kernel@vger.kernel.org
References: <20260326104544.509518-1-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20509-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,brauner.io,infradead.org,gmail.com,kernel.org];
	FREEMAIL_CC(0.00)[manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samba.org:dkim,samba.org:mid]
X-Rspamd-Queue-Id: 6916C351BBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 26.03.26 um 11:45 schrieb David Howells:
> Hi Christian,
> 
> Could you add these patches to the VFS tree for next?

As this conflicts with ksmbd-for-next (and that's
a branch that's typically rebased every few days)
I'm wondering what that best way is to resolve that
problem.

Maybe we should have a fixed non rebased branch for the
smbdirect.ko patches in ksmbd-for-next, so that David
can rebase on that.

Or should Steve put this also into ksmbd-for-next?

Another possible way would be to skip this for now
cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from smb_extract_iter_to_rdma()
and I rebase my changes on top of Davids patches assuming they
will be stable commits (at least up to
cifs: Support ITER_BVECQ in smb_extract_iter_to_rdma())

Any ideas?

metze

