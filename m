Return-Path: <linux-nfs+bounces-21543-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE1nM111A2rf5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21543-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:45:49 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 549EC528156
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D4E32F1565
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DE336D510;
	Tue, 12 May 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sghZpwZm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17F366831
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609643; cv=none; b=TlpGsJx50SvQE4gts9wbn/xyLwSqiPHnP6Jla1aqb7wefABRq4x42LajVLWEW+TRtkCSAbFrbq5B+jMoWspAQfL7d/8SCqxRC6P/zL9e4JGjpUrKL5mHDcZbu9SOLdubSB5g5O1HS+Io1g54ETEe9kUvaZO9bM69EsSUNi2WjAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609643; c=relaxed/simple;
	bh=0hSWjmD4mPsRwQq8NZaarmKq2sWxPnGUpvETRYD+KIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R6hawB/fsia6mCEIh95Hi+CacaZvOZ4jp3mKXcs8WavcV0lOh8cnILvXlgxpIo+bq+BlpsAy159+XX+T2S365Nsqxj3QxhDlBB3NlsKhxXEh6ZE7MLcScj2jDEBj6WMjy03kcwcHEx8HtNzWHLsITX/SwbwLSNxvKqbVE9Jnk4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sghZpwZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A528C4AF09;
	Tue, 12 May 2026 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609642;
	bh=0hSWjmD4mPsRwQq8NZaarmKq2sWxPnGUpvETRYD+KIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sghZpwZmAGtjoC4eilRDopA613Yus/d/cx+CvqHwsVfuWarGmWKE5OA3hux44aQb3
	 2HW98Wrx9kAuDYNjYzdm7Bl6VKM/CVJ2Z2atIFrMcgyzgZDnoB6wkp7yjsn72HQ0cE
	 CQLJWmPF0ot+FDdgkwqOIdzayMjK53EWcV2wRPyIFMzLQer1INyCA03EGedxaBejnr
	 7HELHUQPkX8a2NRPE95K2zLYL/p0yV09VVKKyAjq1v7VgwTb5aKy6RJ4VJoRJhuUo7
	 3u2yiyRcbC/JdAI54XUxDrj/yFXDt5Bix8/aTX9C4cBGidoF4aG26ZFGWLE0n/H5ZE
	 ZSQAZMEFBcw6g==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:38 -0400
Subject: [PATCH 03/38] lockd: Drop locks_init_lock() from
 nlm4_lock_to_lockd_lock()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-3-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Z79XTLFOVy2IsddMRIiVmb3gBV4UUz9RHUMPEe/4AKI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23k3sr1nz4ahfOvTBG+CfKFVLFTLCxp+FlUU
 HiWFhnZz0eJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5AAKCRAzarMzb2Z/
 lzRqEACJAA7gBo9HZOGz4PbrYS2wmFf18qzi8EfxSHcTnCTHXcQRhZBsKPCharugz+4yEXeE9Qj
 DJhPk/lx7sZwpfqfxafgCkgb9v/VOKJdtnuDEbh/Am5acYaFhIt9liNToVoHJQwBVo3BKg41W45
 ecSNNgb8XazuRANfTPDJKy1zNSgVINHCOLyXxv6hgv9kwb5nir7ksidHt5/EjG+K53HG0e+1BCz
 GznFp/4TpW9mc6KgWQJ52/KohNLxin47i4Xq8Gg2pg813Goetq9j//WzpivSBKChqqWcuWFBfhN
 CzD1NSoPBQAxc5Sqv4o5wkMskE1BEWyIk6PeT7icc5UPRnwHVsXzHfn8dtEzyqam0nuRbsx6gM4
 hXrity0V1rRt4fjdWPumFD+RsyCV3DfVNmJm3Q0Rk/NAMqjrH7cJsmy1/jwQkNNDMoLATBL6TLX
 bmxwg7MYQ5mXz9Jodqa5b9PuwLVZ6rn1SuW5Od0jLGJIQQVX3Fao6EGOBdg8e55YH+2GuLukx4s
 vm6YjT4BCvXvIt++9Aab9lD9cozEmqr9aebQUQmUaHmP7iTh02EJbL6qTkNlzBNLywo/3GAGWJn
 9fjR+vg9e2lol6wlXhL1o20qI8p2/tFkq0ZuJJkIt3HsZITZhj9Stxv61bTL72mTaEtLqWzec/Q
 G5TH9KM/h3MzL+g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 549EC528156
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21543-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The NLMv4 GRANTED helper passes the wrapper's lock to
nlmclnt_grant(), which compares only fl_start, fl_end, svid, and
fh, and the shared nlmclnt_lock_event tracepoint now sources its
byte-range fields from fl_start and fl_end as well. Both fl_start
and fl_end are set unconditionally by lockd_set_file_lock_range4()
on the line below, so the locks_init_lock() call left no observable
effect: every other field of struct file_lock is unread on the
GRANTED path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index fc9ed4abb7ca..2bd71bc2b481 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -119,7 +119,6 @@ nlm4_lock_to_nlm_lock(struct nlm_lock *lock, struct nlm4_lock *alock)
 	lock->oh.len = alock->oh.len;
 	lock->oh.data = alock->oh.data;
 	lock->svid = alock->svid;
-	locks_init_lock(&lock->fl);
 	lockd_set_file_lock_range4(&lock->fl, alock->l_offset, alock->l_len);
 	return nlm_granted;
 }

-- 
2.54.0


