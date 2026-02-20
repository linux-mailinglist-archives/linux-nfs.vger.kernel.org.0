Return-Path: <linux-nfs+bounces-19060-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CylHO1SmGk1GQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19060-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 13:26:21 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EBB1677A2
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 13:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D2143053085
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBE343D72;
	Fri, 20 Feb 2026 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAkt4oMw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93185296BA5;
	Fri, 20 Feb 2026 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590378; cv=none; b=NRyAiaxINeo9QKMSUqw4dLbQQtyUZrgOEOPp9aYkkiOCVctKkAOPS0GG+n8O8aLGrUc/MizFJWGr7++5KkcPptizo8t91FkE+wnUgXznejlRQ0Ud1egK5nBUgsIePE9hk3towPLSIlClzAe9CtqqZlTb3w6w6c6SH9IJz65Fkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590378; c=relaxed/simple;
	bh=rbIVHAAbXa0rkw/T7e5ufCHQxsYBvOF8XoGc+42kKcg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AGX0s6mSDmNpzuPC9pnuIAA6NZA5S8+yLhdUhQLZwYZH9dXoDd/wIlvI/6L+yGpFeKam3wVTJbyDg/yRDwcZMYiounuYIVGTwXSpNLgg0i3SYxsfi7oz1nU3v130ntaOzhanXuNznW1pm/lQT1XGmsjTRnduVCyytZ1lOhfYbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAkt4oMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DF6C116C6;
	Fri, 20 Feb 2026 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771590378;
	bh=rbIVHAAbXa0rkw/T7e5ufCHQxsYBvOF8XoGc+42kKcg=;
	h=From:Subject:Date:To:Cc:From;
	b=dAkt4oMwD8GurMIY4EcRzZphMhLt78lnyP0QI9S4Zl8kpwPG+u6zM0lKpi9yrIc/X
	 IziV8jx1497k3/c0Qq57SzsYMjihVou427qrwuFlrbqmEnlX6VRA27f064Cjpbxh++
	 q7nctL90j2dF9kRyyaTzRRS4QUd8NiskYvkN0o8+/DMmZ1MhhNvvhegTJcRdObL0jl
	 kcxIgb5XE3X7s0BmWCB7p/yN/lCcD7Q+7T/Vv0wM/3RS6gFtNgrYCKIknOrdr3Gtpp
	 H2df0VosRL+riKfPE7w7Vb1YRKVOJqF+bBARRhWEGK/Hf4ituyGtkoSqQyvgX9P+2U
	 qLtKFqIdCq4eg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] sunrpc: cache infrastructure scalability improvements
Date: Fri, 20 Feb 2026 07:26:02 -0500
Message-Id: <20260220-sunrpc-cache-v1-0-47d04014c245@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avIrBP8o0VXiRYyjjkbE6UIxLsnL
 b/Fex0aVaYGm+hQ6eHGV57QiwBMPp8kOUyDUWZVxijZ7lwLSvSYSEZyGJxz2gYLMymVIr//bj/
 G+ADULkgsXgAAAA==
X-Change-ID: 20260220-sunrpc-cache-fe4cd44413d3
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rbIVHAAbXa0rkw/T7e5ufCHQxsYBvOF8XoGc+42kKcg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpmFLjNQ2BRtGONwMJZZG/r4k522FXa/VGJjZoQ
 OuTmGTE4smJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaZhS4wAKCRAADmhBGVaC
 FaN6D/4+VDDNNG8OKafMoiqOj+nEc4EQ32kXVdVwBk9CYxLyPwW3HJxU/gbMOU1w08Xdd4Zhqs3
 6FLyPCuxJNYl9HN5HLRYcEhmyoR4yfCv30QcCNc9MrDf74rMq3abI6NeuRa6WCZ5ROWZTa7Lvh7
 wAiOhhC3OFb+4IaSDU6fs4zmx96X1mL36wZjVZwOkOuGpVfBi1SuA9o/ieYRQavHPG5gPJJ2+ZY
 sBqilrC4pb/E8iSOpE2+SxMFjaRpZzBEoq1G5h9V10kqCZkd8M5pUb35tvW4v1xporF6pkLAJb0
 DIZIVB8kJVWAapGd5VZVJ4Htd6WdPuyVWXqHE1Z4Y7lxYXrpmn/eCUiaSWnV6zIJfWY/Tjxej+b
 Xk01j7RFJWPre0mXIJWI28SETevhJI44GP7Y1ILQXwD7GOtqwqfZPs1LRFQVHYzyrS5hrvHsd1b
 QRy0EbXwPoaSvJaKE7NdI41460C5oQJ8S98uo6P83XsQJ8VZ4dvjQPfgUKlGs/6lb8P38ah3gXC
 dDhcmcQJjTaCbL9wGDApkVHK24v/T8ZbjVZreV4krwQqCWokMBNuup+H1aMHeZtPNmqEAjvkyEE
 x1JXtZLm8owIdQq93gsw6FAQ7TdCtKJOMFnwIsYAzCqjCcjRNPsOltAKI8b8sU5NS729eB20WZf
 Cie5s7jk8D8RZiQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19060-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3EBB1677A2
X-Rspamd-Action: no action

I've been working on trying to retrofit a netlink upcall into the sunrpc
cache infrastructure. While crawling over that code, I noticed that it
relies on both a global spinlock and waitqueue. The first two patches
convert those to be per-cache_detail instead.

The last patch splits up the cache_detail->queue into two lists: one to
hold cache_readers and one for cache_requests. This simplifies the code,
and the new sequence number that helps the readers track position may
help with implementing netlink upcalls.

Please consider these for v7.1.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      sunrpc: convert queue_lock from global spinlock to per-cache_detail lock
      sunrpc: convert queue_wait from global to per-cache_detail waitqueue
      sunrpc: split cache_detail queue into request and reader lists

 include/linux/sunrpc/cache.h |   7 +-
 net/sunrpc/cache.c           | 179 +++++++++++++++++++------------------------
 2 files changed, 85 insertions(+), 101 deletions(-)
---
base-commit: cca65706e7b428b96c951016fc372cc766b94b71
change-id: 20260220-sunrpc-cache-fe4cd44413d3

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


