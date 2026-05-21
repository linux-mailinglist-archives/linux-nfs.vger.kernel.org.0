Return-Path: <linux-nfs+bounces-21777-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCTIAlWcD2rBNwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21777-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 01:59:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A41F25AD2B6
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 01:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CA4E3145F10
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 23:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F6A38551A;
	Thu, 21 May 2026 23:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GN+ULxyh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8AF313273
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407268; cv=none; b=VTO5HbKIIZxYjHb5VXvgzsfLYBEocSN63DusG+EUIJ+k6UBa9o9FBzzx9ZcbN5kqvxhuJChvtbB1F3fvK22LAVIWiCLbPWo44cOxAQ9KOZm/8KEUntLj+2ikbgzagswyg9BKDvW2kj+0GXQ7biafHRxSgpdfCvmwVypRZPwX2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407268; c=relaxed/simple;
	bh=y1EWs3cSPL09nflnRjIAJkiltIlH8L/6uVxSipLcWhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2aGzX2IYIqYrGPRAWBPbl5UrUTGxROBDUJZ8WK1F2e5hwnZ1Qp2zRX4fx1gv5NcGmATdyRA3KwW4upwOETGczFkyrp84GM2TWxSbuyINADGmkHXickMFejsu/Cwevz9HhYCHUPIBB+ND6vBKx/DPLWm+IqQZwy6skjU8GK1u+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GN+ULxyh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779407247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYseuu1ZjXT+bdnjcS5bMSHbytCNHIqrHnUDzC+u9RM=;
	b=GN+ULxyht4JbhTzUxXPR1d+EaqWdTw8+prMxCRzCvt/osaMMetkbrmZBQA4eIF1FqVIkLj
	1ebHqXKvg33z/v3qb8ZiofpjuJJAaAZ2dfpMpwX56I2wpc2pqDCIZl45nEERMIdYgC8KO4
	rM33WQoxl9P+Qvu4AmWvKQoxxixOXbA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-OEhT_fI5OyaCp0hJxVtvMA-1; Thu,
 21 May 2026 19:47:22 -0400
X-MC-Unique: OEhT_fI5OyaCp0hJxVtvMA-1
X-Mimecast-MFC-AGG-ID: OEhT_fI5OyaCp0hJxVtvMA_1779407241
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AC1A19560BB
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 23:47:21 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03BB93002D2D;
	Thu, 21 May 2026 23:47:21 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 4E8228A8684;
	Thu, 21 May 2026 19:47:20 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] rpcbind: fix memory leak in read_warmstart()
Date: Thu, 21 May 2026 19:47:20 -0400
Message-ID: <20260521234720.818996-4-smayhew@redhat.com>
In-Reply-To: <20260521234720.818996-1-smayhew@redhat.com>
References: <20260521234720.818996-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21777-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A41F25AD2B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

struct rpcblist contains a struct rpcb, which has pointers to 3
strings.  We need to free those before freeing the struct rpcblist or we
leak memory.  Fixes memory leaks such as:

==8754== 56 bytes in 12 blocks are definitely lost in loss record 54 of 93
==8754==    at 0x485436B: calloc (vg_replace_malloc.c:1616)
==8754==    by 0x4884CD6: xdr_string (xdr.c:808)
==8754==    by 0x4884D50: xdr_rpcb (rpcb_prot.c:57)
==8754==    by 0x488591C: xdr_reference (xdr_reference.c:88)
==8754==    by 0x4885A3F: xdr_rpcblist_ptr (rpcb_prot.c:123)
==8754==    by 0x40C2E0: read_struct (warmstart.c:122)
==8754==    by 0x40C6C9: read_warmstart (warmstart.c:190)
==8754==    by 0x40606F: main (rpcbind.c:357)

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 src/warmstart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/warmstart.c b/src/warmstart.c
index 8ecd933..b845369 100644
--- a/src/warmstart.c
+++ b/src/warmstart.c
@@ -205,6 +205,9 @@ read_warmstart()
 				*tail = pos;
 				tail = &pos->rpcb_next;
 			} else {
+				free(pos->rpcb_map.r_netid);
+				free(pos->rpcb_map.r_addr);
+				free(pos->rpcb_map.r_owner);
 				free(pos);
 			}
 		}
-- 
2.54.0


