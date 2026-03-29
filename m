Return-Path: <linux-nfs+bounces-20508-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PkGDZUGyWkOtgUAu9opvQ
	(envelope-from <linux-nfs+bounces-20508-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 13:01:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81444351B4C
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 13:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF944301AF42
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B7D314A60;
	Sun, 29 Mar 2026 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="z+2I+EsC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD173148CF;
	Sun, 29 Mar 2026 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781722; cv=none; b=Db65TF3flkyq5clthv6lt6FWh9k+IY8bSLFZd3MUJdAx5Ws4Oy5/hzdAUGcIY/+aEcr7wW+Vp2dYHPbW89IYcR7CBb1p50vGa0VWqSMo16S3TcEJBaUYDInNxhqR4k2iB2naBIkUMH9HzK7M+hBvVApU6SrvFJ4MCKLFU3I2//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781722; c=relaxed/simple;
	bh=gYwCcL+NBW5oYxupSOAtvJnHCMlNUhYVOgfb7EorQeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ar0qHQX8UPWgnlIIKJ5PWIIWbB3DyJasGJtuzi0KEXJZwvPrltL+OGXTrJscKFcGxWE0QrCb2Z5C+PsrB7uajDDestpbUQLeSaL1uY2xSFrjKu4fp5JHRiOqLX/FLGmuN8wK9tcPvVXsblxmO/d0ibYhaQfn1KVpLIVA9tAhJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=z+2I+EsC; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=h5eM8nrJzZ6W15HT/jpsM8V2AUQr7PUIFnp6zW6jBc0=; b=z+2I+EsCMfs+xrchz8bAZUcLJu
	mEgw1uxNVxyKoydzGHYkY1wgWsuXzWoBDiShT1BgwxuNr9yHEcFZ7y3TreWQ5MawJYOvVkY5Oa7Tp
	Kd+sQykeeKv1irSbOtQL838p9yvhKEjt07JYtZHZ9ww7u5EOeGLG0A6OMzg1tC241DbmSroVFSska
	5JiBs3eOWaTvanJUYirJFfUZSvzTrr9lcVR9n0b9jKidyNg+OutWdHaqoRCTfuGWUcjsWC54yukTj
	BjTj6BsPyAbpXAW/uQOEbInho7iRjpaDbCvIzgJEwqaWrQPWvzj2Sfl/OWAmCagU7Na3aWuf6I629
	M4Rvoq3+1hhUBWaS9DZkerCVtrHWS8QIhbzM8mpkL5kG6+i5T2kFKNUaCc9AstpwY8J7YzNwqvvLz
	N/ccB5SEvjXdIdeYC6JH9T7+kSeNQz2YN6FC+dLv+We3mT2pphhvqyfE8UVdFIZH0D2S96cm4RQmJ
	SIADzPqUoN3z9q4vzYSZFFXj;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1w6nV3-00000004jBp-1bxe;
	Sun, 29 Mar 2026 10:36:09 +0000
Message-ID: <1eda9321-e259-43b8-8c4a-d0f54a9d28d5@samba.org>
Date: Sun, 29 Mar 2026 12:36:08 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/26] cifs: Support ITER_BVECQ in
 smb_extract_iter_to_rdma()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
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
 linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
 <20260326104544.509518-18-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260326104544.509518-18-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20508-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org,microsoft.com,talpey.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samba.org:dkim,samba.org:email,samba.org:mid,infradead.org:email,manguebit.org:email,talpey.com:email]
X-Rspamd-Queue-Id: 81444351B4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

this conflicts with my patches in ksmbd-for-next
where we have this as smbdirect_map_sges_from_iter
and shared between client and server.

Can you rebase on ksmbd-for-next?

Thanks!
metze

Am 26.03.26 um 11:45 schrieb David Howells:
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
> ---
>   fs/smb/client/smbdirect.c | 60 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> index c79304012b08..f8a6be83db98 100644
> --- a/fs/smb/client/smbdirect.c
> +++ b/fs/smb/client/smbdirect.c
> @@ -3298,6 +3298,63 @@ static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
>   	return ret;
>   }
>   
> +/*
> + * Extract memory fragments from a BVECQ-class iterator and add them to an RDMA
> + * list.  The folios are not pinned.
> + */
> +static ssize_t smb_extract_bvecq_to_rdma(struct iov_iter *iter,
> +					 struct smb_extract_to_rdma *rdma,
> +					 ssize_t maxsize)
> +{
> +	const struct bvecq *bq = iter->bvecq;
> +	unsigned int slot = iter->bvecq_slot;
> +	ssize_t ret = 0;
> +	size_t offset = iter->iov_offset;
> +
> +	if (slot >= bq->nr_slots) {
> +		bq = bq->next;
> +		if (WARN_ON_ONCE(!bq))
> +			return -EIO;
> +		slot = 0;
> +	}
> +
> +	do {
> +		struct bio_vec *bv = &bq->bv[slot];
> +		struct page *page = bv->bv_page;
> +		size_t bsize = bv->bv_len;
> +
> +		if (offset < bsize) {
> +			size_t part = umin(maxsize, bsize - offset);
> +
> +			if (!smb_set_sge(rdma, page, bv->bv_offset + offset, part))
> +				return -EIO;
> +
> +			offset += part;
> +			ret += part;
> +			maxsize -= part;
> +		}
> +
> +		if (offset >= bsize) {
> +			offset = 0;
> +			slot++;
> +			if (slot >= bq->nr_slots) {
> +				if (!bq->next) {
> +					WARN_ON_ONCE(ret < iter->count);
> +					break;
> +				}
> +				bq = bq->next;
> +				slot = 0;
> +			}
> +		}
> +	} while (rdma->nr_sge < rdma->max_sge && maxsize > 0);
> +
> +	iter->bvecq = bq;
> +	iter->bvecq_slot = slot;
> +	iter->iov_offset = offset;
> +	iter->count -= ret;
> +	return ret;
> +}
> +
>   /*
>    * Extract page fragments from up to the given amount of the source iterator
>    * and build up an RDMA list that refers to all of those bits.  The RDMA list
> @@ -3325,6 +3382,9 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
>   	case ITER_FOLIOQ:
>   		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
>   		break;
> +	case ITER_BVECQ:
> +		ret = smb_extract_bvecq_to_rdma(iter, rdma, len);
> +		break;
>   	default:
>   		WARN_ON_ONCE(1);
>   		return -EIO;
> 


