Return-Path: <linux-nfs+bounces-18426-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALz3HkBIdGkc4QAAu9opvQ
	(envelope-from <linux-nfs+bounces-18426-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 05:19:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D53BF7C75E
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 05:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA68B3014755
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 04:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CCF27456;
	Sat, 24 Jan 2026 04:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYTnc+54"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F6821773F
	for <linux-nfs@vger.kernel.org>; Sat, 24 Jan 2026 04:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769228350; cv=none; b=UWqpGYA+0hNhJ/O1bOTRYvWklVJlU//1POuvgYCcbXjv59finHZFVShihNdbgbUK05XoQHDcR/o7ybbXMK5G/x6L1FyTFKNjNw917PhZjqQx3mLHnzHCpaWNXk8Jwwj2Ocy+4Yo1pmNn6x+fXqBG6p2rxkrJRJysSGcRVULu/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769228350; c=relaxed/simple;
	bh=Zv2HUTc7UyLJlS0s4Uh2tu2Rb/0vcJXTc+jNgT0LHFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zo/YU6wnBbLJWvwZu6MTY2d52SR7rrpjC8fVH8LdYTcjhJcOAHsES/0IkDuaMAQyjAx3SloPmKyy3Erc4WXxF2aNKMLYt9LDHpDNi3RyI39UkswFSsBsKVF8hDZPtzT/oWvIJMcNT/QaoTVZdcI7XAbSIy/8v8R3rbnDRzNsxA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYTnc+54; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c552d1f9eafso4408312a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 20:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769228348; x=1769833148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yl/RGezeEqPCSk8x4HGLwIWQiXpT/P96d0JhuIY9pWU=;
        b=zYTnc+54jkuHIMtU11MR/ZeK/TfMEMZXOdYPT/BXwXrMFLi8FKvhj1e40BNQj35lEd
         w4Mcq/Ddw7p3ZZaEGQcrnai0HpDW3gG+xJUNp35SAd2Bw8uzGv0RVl7GlO/5FY+1dWc6
         s++84JjHbSvEh+gOmgWTSFhRy/8ucwTUpXVJ2AAspyAqT4UcsxjEBy1bDg4VnXPIZhqc
         Qa6h4y5dp4iYAbXs/IDG1YrUImj6VshOlFj9rCrQBBr7dhe7xODMBtV9d2zeOCL3kAGk
         bD5K947W34JPSSRaFS7C0zt4veyrrmM9qS0quIRdx/SjNJiSyusxYpWShLNqxIDNG5yH
         S3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769228348; x=1769833148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yl/RGezeEqPCSk8x4HGLwIWQiXpT/P96d0JhuIY9pWU=;
        b=adwe2vjKqYS2iCZ1/aNbhbbVQ7f1ovp+WX6RDAjNpXlm1/NgYwfDE2f43ymVJjVOFS
         mcReezdijF4ntg6MtS+KBnkZi3qPVpnr/WilF8M7JXOSzfzek1k6VnpK8Fg/0tZ+ORyX
         r/tN2ZOpepCouS9zt32RoTmTxWENyElAbWIdT1MCG/1Oi0Ns//QDiUPPCy1QjqxwVSIE
         DdKajJoRT9fYrXzB3oqf2Qsw5y4ansZIBwe5JKSAPNUXAj6Gr2mWMTQgPqWwiNcf4BOT
         awduMYY7j9tAn6UmFk0haUxxgBXWxDYQWOp4trQAd3JysWWSQVd94oiL52LG/Pt06tC7
         ZAyw==
X-Forwarded-Encrypted: i=1; AJvYcCUpI3Cl3nME3rZhXWynfPD5kTAEtOsldKMiQOUkIxdYA8NjBQJHFkyIX9SI0vENi5Ar3KNWJXpGR9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzctmvxQrDEzcp6f1RxC0Zi50i64/Rj6NqwVm+ROD5KVm1raQGQ
	ORe2LqqHNR41iYKwDj6kTy5/hSf4Vi79N1yu1YxKd2bd56q3roqbrHBZtb9rSd+84WTmWVXLP95
	PMnXyFw==
X-Received: from pgnh1.prod.google.com ([2002:a63:3841:0:b0:c61:3434:4ec])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4404:b0:7f7:5783:fc6d
 with SMTP id d2e1a72fcca58-82317e146abmr4802828b3a.41.1769228348530; Fri, 23
 Jan 2026 20:19:08 -0800 (PST)
Date: Sat, 24 Jan 2026 04:18:41 +0000
In-Reply-To: <20260124041902.548904-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260124041902.548904-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124041902.548904-3-kuniyu@google.com>
Subject: [PATCH v1 2/2] nfsd: Fix cred ref leak in nfsd_nl_listener_set_doit().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18426-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[brown.name,redhat.com,oracle.com,talpey.com,kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D53BF7C75E
X-Rspamd-Action: no action

nfsd_nl_listener_set_doit() uses get_current_cred() without
put_cred().

As we can see from other callers, svc_xprt_create_from_sa()
does not require the extra refcount.

nfsd_nl_listener_set_doit() is always in the process context,
sendmsg(), and current->cred does not go away.

Let's use current_cred() in nfsd_nl_listener_set_doit().

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 fs/nfsd/nfsctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ec9782fd4a36..85e3bd0e82ba 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1993,7 +1993,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		}
 
 		ret = svc_xprt_create_from_sa(serv, xcl_name, net, sa, 0,
-					      get_current_cred());
+					      current_cred());
 		/* always save the latest error */
 		if (ret < 0)
 			err = ret;
-- 
2.52.0.457.g6b5491de43-goog


