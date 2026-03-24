Return-Path: <linux-nfs+bounces-20342-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLS5LTjlwWkYXwQAu9opvQ
	(envelope-from <linux-nfs+bounces-20342-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 02:13:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF133005D1
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 02:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355D930C623B
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 01:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3A481AA8;
	Tue, 24 Mar 2026 01:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="EnaS0NnL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C8239567
	for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314265; cv=none; b=O5oOWG4qUtY0MBOMXBNbrVCdo1XI/HE8S+qlW9wNxohiZ/CQoaOGcqucdectEOq+tjLpoqXzfNCyksfn6n2hTUIrHDe7LbMZH5nueUDYmEOGbt6LyuACF1gwwjBpqqfj5DyCuhj+4uStDO2nwbDbu3D38tW44u+Jp9M1b9bw7rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314265; c=relaxed/simple;
	bh=VCBWYnp25rctm2RL0ZGr6yuNE7P6effUaZZkJOEqG4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ze6ak7qWx8ju/O5oLglZk/wrGd6T96D0LXMWR7ebKFuGovmFtxr5YTm/h3ERHm8/cUdFnCfPto/jy00kFgFU7nx7CoVBS2D2oKAkgP6G6wm2GE8+YCDFOysebAcLyp09wtvgGDFgeu0kN6av7Y4beeBpO/barMyA+cO2FA1/1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=EnaS0NnL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <a1949f85-2e92-429e-83eb-91a7691b9a9b@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1774314251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYB7aOLuuY4WEpXNaPnEw3hBO7I/ba2yl9abrDSlF+4=;
	b=EnaS0NnL5rSLKHG0i7K4ZsSpjkOYn7Ci9qQB0DaMsPs2Fx0culu8tggklKHwAehxV0IYiC
	0A8fzr5POg+oSf6E9/PWj5de52Opn5QSxijYOtdOASXrIGzsFWF+tsa1ZHFuN8lCXap9sm
	JIYPsxKGiU+fU/gaeP7rTX0/mcvxWRFM6tW4wM1KiZB9ephOwsB+POVQNNwzm8r/qWnT0n
	Rbj5QPmi2EVj+Dm5GRglDmY2muoguEmESvdUqe+ltRm7DA/x4hwKlKxg9FWkluYx7XN8Sd
	8Ozk6K+9ut95LIqTaeDQvyhqFvyW8RJSg2n36MfRcjXOAhybHNKggI2vkriBcA==
Date: Tue, 24 Mar 2026 09:03:29 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 17/17] netfs: Combine prepare and issue ops and grab
 the buffers on request
To: Paulo Alcantara <pc@manguebit.org>, David Howells <dhowells@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
 Steve French <smfrench@gmail.com>
Cc: Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260304140328.112636-1-dhowells@redhat.com>
 <20260304140328.112636-18-dhowells@redhat.com>
 <2d8ce118-2f7a-4b7f-8786-4581b29cb74e@chenxiaosong.com>
 <63655684a778145167a549b4a6251ccf@manguebit.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <63655684a778145167a549b4a6251ccf@manguebit.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[manguebit.org,redhat.com,infradead.org,kernel.dk,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20342-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,chenxiaosong.com:dkim,chenxiaosong.com:mid]
X-Rspamd-Queue-Id: 5AF133005D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In netfs_writeback_single(), on the failure path, should we call 
netfs_put_failed_request() instead of netfs_put_request()?

```
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -1041,7 +1041,7 @@ int netfs_writeback_single(struct address_space 
*mapping,
         return ret;

  cleanup_free:
-       netfs_put_request(wreq, netfs_rreq_trace_put_return);
+       netfs_put_failed_request(wreq, netfs_rreq_trace_put_return);
  couldnt_start:
         mutex_unlock(&ictx->wb_lock);
         _leave(" = %d", ret);
```

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 3/24/26 06:44, Paulo Alcantara wrote:
> Thanks for the review.  The above is still broken as it wolud cause an
> UAF on @subreq as we're putting it with netfs_put_subrequest() and then
> dereferencing it afterwards.
> 
> Besides, we could also get rid of 'subreq = NULL' as it is currently a
> no-op -- including in other places.
> 
> Let's wait for next patchset from Dave, though.


