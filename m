Return-Path: <linux-nfs+bounces-23301-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iLYMNXbqVGpyhAAAu9opvQ
	(envelope-from <linux-nfs+bounces-23301-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 15:39:02 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16ADC74BB60
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 15:39:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bytedance.com header.s=2212171451 header.b=me5m4Z0l;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23301-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23301-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=bytedance.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55BDE304B86E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649D642B321;
	Mon, 13 Jul 2026 13:36:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92042E007
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 13:36:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949815; cv=none; b=ivZMBJbVjDCq75m7kufEwpCyGYjSHgdA7Ha251OtZJ99LQkL7HASsndFOprHrYTp2rXOoPWPMk9DPRyDXS3D/dYdFbBTEhNLoJFyLe2l1ul4LKq+tNcsWkQwCrsFXZ+V5ga5SKvwbkBLJt09+9E14P64Gl8NfSuTfD6Kw/xm+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949815; c=relaxed/simple;
	bh=W4I+tc2wn2F51YLrlBss1qWCPyTe3a4tGfNT0fOdc4M=;
	h=To:From:Message-Id:Content-Type:References:Cc:Subject:Date:
	 Mime-Version:In-Reply-To; b=CvuPOxXXhi62g5dSoKD0M5uMd7ax/FilRpUDRCtQuApskBKycw6RS1j6Fu3URO6MAEuZZENC2TOoVNRbk+UMQAkYZZptZvth+isvoWHTPBdG+CKkiHz0hK3M0YCaY8xV/jgyfqug1d405JyoGElh7s3g1OhU0CllJnOy7qzHcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=me5m4Z0l; arc=none smtp.client-ip=209.127.230.112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783949807; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=mcFWwoR8HJHvqxrrzW8rX6MYuuJtu4ui77uwEmpQcjg=;
 b=me5m4Z0lX8nzxzWzHThb8Mnvs4iUriI3onGAg9/FZyVpXJKEShPtmqT/GiPRSQ4iTRmPch
 inIRNWJVEtB5qp2k9J+SFWkcfbxljh/r0N5Ervg0EjVYs7zGWzLE4H2JA6s+GwHkY3rD5b
 qBtGqzYb7NVFQMOqwTWDP2SEubEMIMUuXQTFFniNV2gv4aznN49z1tgHMJ70v3/WdS2qEO
 OPDuVIUvLEUy/Z6IWAN72IUriScwvNpaIR3I+wI5sTiirZnDMY7dieTzwW25l5DckBdX91
 f4B827qjZejZpJKOzBYepBeR5kv/R0hlDphBIfBwc6/9uMEPNqMRI0BRArTpuA==
To: "Anna Schumaker" <anna@kernel.org>
From: "Jia Zhu" <zhujia.zj@bytedance.com>
Message-Id: <20260713133057.23079-1-zhujia.zj@bytedance.com>
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
References: <20260710204715.621189-1-anna@kernel.org>
Cc: "Jia Zhu" <zhujia.zj@bytedance.com>, <linux-nfs@vger.kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Lms-Return-Path: <lba+26a54e9ed+7f42e4+vger.kernel.org+zhujia.zj@bytedance.com>
Subject: Re: [PATCH 1/2] NFS: Pin the 'struct nfs_server' during a FREE_STATEID call
Date: Mon, 13 Jul 2026 21:36:41 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260710204715.621189-1-anna@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23301-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[zhujia.zj@bytedance.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:anna@kernel.org,m:zhujia.zj@bytedance.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhujia.zj@bytedance.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bytedance.com:from_mime,bytedance.com:dkim,bytedance.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16ADC74BB60

Hi Anna,

On Fri, Jul 10, 2026 at 08:47:14PM +0000, Anna Schumaker wrote:
> Dan Aloni reports that he was able to hit a use-after-free bug if a
> FREE_STATEID operation gets delayed for whatever reason. Fix this by
> bumping the refcount of the 'struct nfs_server' object for the duration
> of the FREE_STATEID so it doesn't get cleaned up from underneath us
> while operations are still in flight.

This patch reminded me of a similar nfs_server use-after-free that we
recently encountered in production. However, it appears to involve a
different race and root cause:

  NFSv4: pin the superblock for active state owners
  https://lore.kernel.org/all/20260707133623.23078-1-zhujia.zj@bytedance.com/

Would you mind taking a look at it and letting me know if the approach
looks reasonable?

Thanks,
Jia

