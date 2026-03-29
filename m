Return-Path: <linux-nfs+bounces-20507-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMkcAn0ByWlLtQUAu9opvQ
	(envelope-from <linux-nfs+bounces-20507-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 12:39:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D95351991
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 12:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDDFF3006106
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Mar 2026 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF43126A0;
	Sun, 29 Mar 2026 10:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="LSA/p24b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A430CDAE;
	Sun, 29 Mar 2026 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774780792; cv=none; b=YrMHkc16uhVmIueGWQl7MVtaVJ6QNim9/zvrdDeu364Kf9WfgybRYihWGTg/BGRwmkdTd3gegAk92HAwFI5S+9nJoY6qFkXzflD3Kpvq8URqjM/77rdMYTvfeKGUFp7Mc5sLwOStbpz2/1QOUUkjywb+HHt7PE+zEaaOpcHMmlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774780792; c=relaxed/simple;
	bh=BJkPnJCO8ABpdlvl78QTURZEAzWWbIlz6G8H5tRn6gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vou2FIBzRsW6dP5pf0NOaI8K/nw7vwa8CIbfDCCqQB7K7RoXnep03xYfr4QC4Y2vGaA7amLoXQ8dqfCz0LjvG2LlEOkyeE3h0r1JJnNC+5EoIBPo9hjkhFCxc29HByLpoMlPjQw0Ydod+zNtZF5OBhKL3xcGo7RD1b3k9aZ58C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=LSA/p24b; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=35kKxUVBYro2SeM6ocrFn0qXSAY7oP/wMRsnYfWK9ak=; b=LSA/p24bex3iCNjrbr2Y3gClIg
	smlF06ao/O1GVSiKS7XeUE24ZKDRYRwvOOzGM8uoA5rnb22Onyz1P8NBz9nGSfD/g3jS2nNqaPe9A
	DGfj2L8iJCkYb47IpNE4El3HuTyRODDTi7K13OlSPJmD+8WCXL9ubiVLHtkKyqwAhiGKCY/rT3gLP
	2ICJJjnfxuJHHMduL5P1My7iVnuIgv1lZlGkVlKfapfkpCpAIQITV7o3CLnmmKwomXJpbpwZ0Xa4x
	StLcOYfQf7Yqnu+iARwQNmAcqiu8lYmHl/YikLgN3Lw+b4KbTM5WgoIStacBJ8UP4wo2toCUHDLe4
	+OKQRehRm9bUN9Xcg761+3HHfNTWuPPjmKqrJ+qMOT5roAzTNNAztSCEL1wM32TKxr3iPjmNiGwno
	nvpVS8TIGe+8LcHASXL1CLVANYD93DcMII9vVSIha9G1usEaQwj8z3U50VDUeR2omGhj2An0CsqxF
	Q3NFYFpj5ztkVfHsH2utDuUE;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1w6nYZ-00000004jEZ-0gHh;
	Sun, 29 Mar 2026 10:39:47 +0000
Message-ID: <3f19c05a-d8aa-4ce5-8bcf-b51a1f110cb5@samba.org>
Date: Sun, 29 Mar 2026 12:39:46 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/26] cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from
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
 <20260326104544.509518-20-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260326104544.509518-20-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20507-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,manguebit.org,microsoft.com,talpey.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:dkim,samba.org:email,samba.org:mid,linux.dev:email]
X-Rspamd-Queue-Id: A1D95351991
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

in ksmbd-for-next smbdirect_map_sges_from_iter is also called
in the server from smb_direct_writev() =>
smbdirect_connection_send_iter() =>
smbdirect_connection_send_single_iter()

So we still need ITER_KVEC.

Thanks!
metze

Am 26.03.26 um 11:45 schrieb David Howells:
> netfslib now only presents an bvecq queue and an associated ITER_BVECQ
> iterator to the filesystem, so it isn't going to see ITER_KVEC, ITER_BVEC
> or ITER_FOLIOQ iterators.  So remove that code.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/smb/client/smbdirect.c | 165 --------------------------------------
>   1 file changed, 165 deletions(-)
> 
> diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
> index f8a6be83db98..d9e026d5e9f9 100644
> --- a/fs/smb/client/smbdirect.c
> +++ b/fs/smb/client/smbdirect.c
> @@ -3142,162 +3142,6 @@ static bool smb_set_sge(struct smb_extract_to_rdma *rdma,
>   	return true;
>   }
>   
> -/*
> - * Extract page fragments from a BVEC-class iterator and add them to an RDMA
> - * element list.  The pages are not pinned.
> - */
> -static ssize_t smb_extract_bvec_to_rdma(struct iov_iter *iter,
> -					struct smb_extract_to_rdma *rdma,
> -					ssize_t maxsize)
> -{
> -	const struct bio_vec *bv = iter->bvec;
> -	unsigned long start = iter->iov_offset;
> -	unsigned int i;
> -	ssize_t ret = 0;
> -
> -	for (i = 0; i < iter->nr_segs; i++) {
> -		size_t off, len;
> -
> -		len = bv[i].bv_len;
> -		if (start >= len) {
> -			start -= len;
> -			continue;
> -		}
> -
> -		len = min_t(size_t, maxsize, len - start);
> -		off = bv[i].bv_offset + start;
> -
> -		if (!smb_set_sge(rdma, bv[i].bv_page, off, len))
> -			return -EIO;
> -
> -		ret += len;
> -		maxsize -= len;
> -		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
> -			break;
> -		start = 0;
> -	}
> -
> -	if (ret > 0)
> -		iov_iter_advance(iter, ret);
> -	return ret;
> -}
> -
> -/*
> - * Extract fragments from a KVEC-class iterator and add them to an RDMA list.
> - * This can deal with vmalloc'd buffers as well as kmalloc'd or static buffers.
> - * The pages are not pinned.
> - */
> -static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
> -					struct smb_extract_to_rdma *rdma,
> -					ssize_t maxsize)
> -{
> -	const struct kvec *kv = iter->kvec;
> -	unsigned long start = iter->iov_offset;
> -	unsigned int i;
> -	ssize_t ret = 0;
> -
> -	for (i = 0; i < iter->nr_segs; i++) {
> -		struct page *page;
> -		unsigned long kaddr;
> -		size_t off, len, seg;
> -
> -		len = kv[i].iov_len;
> -		if (start >= len) {
> -			start -= len;
> -			continue;
> -		}
> -
> -		kaddr = (unsigned long)kv[i].iov_base + start;
> -		off = kaddr & ~PAGE_MASK;
> -		len = min_t(size_t, maxsize, len - start);
> -		kaddr &= PAGE_MASK;
> -
> -		maxsize -= len;
> -		do {
> -			seg = min_t(size_t, len, PAGE_SIZE - off);
> -
> -			if (is_vmalloc_or_module_addr((void *)kaddr))
> -				page = vmalloc_to_page((void *)kaddr);
> -			else
> -				page = virt_to_page((void *)kaddr);
> -
> -			if (!smb_set_sge(rdma, page, off, seg))
> -				return -EIO;
> -
> -			ret += seg;
> -			len -= seg;
> -			kaddr += PAGE_SIZE;
> -			off = 0;
> -		} while (len > 0 && rdma->nr_sge < rdma->max_sge);
> -
> -		if (rdma->nr_sge >= rdma->max_sge || maxsize <= 0)
> -			break;
> -		start = 0;
> -	}
> -
> -	if (ret > 0)
> -		iov_iter_advance(iter, ret);
> -	return ret;
> -}
> -
> -/*
> - * Extract folio fragments from a FOLIOQ-class iterator and add them to an RDMA
> - * list.  The folios are not pinned.
> - */
> -static ssize_t smb_extract_folioq_to_rdma(struct iov_iter *iter,
> -					  struct smb_extract_to_rdma *rdma,
> -					  ssize_t maxsize)
> -{
> -	const struct folio_queue *folioq = iter->folioq;
> -	unsigned int slot = iter->folioq_slot;
> -	ssize_t ret = 0;
> -	size_t offset = iter->iov_offset;
> -
> -	BUG_ON(!folioq);
> -
> -	if (slot >= folioq_nr_slots(folioq)) {
> -		folioq = folioq->next;
> -		if (WARN_ON_ONCE(!folioq))
> -			return -EIO;
> -		slot = 0;
> -	}
> -
> -	do {
> -		struct folio *folio = folioq_folio(folioq, slot);
> -		size_t fsize = folioq_folio_size(folioq, slot);
> -
> -		if (offset < fsize) {
> -			size_t part = umin(maxsize, fsize - offset);
> -
> -			if (!smb_set_sge(rdma, folio_page(folio, 0), offset, part))
> -				return -EIO;
> -
> -			offset += part;
> -			ret += part;
> -			maxsize -= part;
> -		}
> -
> -		if (offset >= fsize) {
> -			offset = 0;
> -			slot++;
> -			if (slot >= folioq_nr_slots(folioq)) {
> -				if (!folioq->next) {
> -					WARN_ON_ONCE(ret < iter->count);
> -					break;
> -				}
> -				folioq = folioq->next;
> -				slot = 0;
> -			}
> -		}
> -	} while (rdma->nr_sge < rdma->max_sge && maxsize > 0);
> -
> -	iter->folioq = folioq;
> -	iter->folioq_slot = slot;
> -	iter->iov_offset = offset;
> -	iter->count -= ret;
> -	return ret;
> -}
> -
>   /*
>    * Extract memory fragments from a BVECQ-class iterator and add them to an RDMA
>    * list.  The folios are not pinned.
> @@ -3373,15 +3217,6 @@ static ssize_t smb_extract_iter_to_rdma(struct iov_iter *iter, size_t len,
>   	int before = rdma->nr_sge;
>   
>   	switch (iov_iter_type(iter)) {
> -	case ITER_BVEC:
> -		ret = smb_extract_bvec_to_rdma(iter, rdma, len);
> -		break;
> -	case ITER_KVEC:
> -		ret = smb_extract_kvec_to_rdma(iter, rdma, len);
> -		break;
> -	case ITER_FOLIOQ:
> -		ret = smb_extract_folioq_to_rdma(iter, rdma, len);
> -		break;
>   	case ITER_BVECQ:
>   		ret = smb_extract_bvecq_to_rdma(iter, rdma, len);
>   		break;
> 


