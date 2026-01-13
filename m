Return-Path: <linux-nfs+bounces-17811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 615DAD1ADC6
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 19:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B5A73031351
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C23A33DED6;
	Tue, 13 Jan 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nydonA5p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758A1D432D;
	Tue, 13 Jan 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329470; cv=none; b=nh9tE7Z7feBj7by3Yaqc+Q1K5G9QhlaSD5MPYq4ZYKhAbaWQ/Wm8s7IPGr1wNFEdyOr09jhfE406oVZkNXsdbZ56LfGgRClTDQDwBPzx7Ra0C3edTNAkhwnrj/aIxLC+VXK8wksjitv8v5ZU0ahjpxhP6RddSBU/MVjGIAYeo5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329470; c=relaxed/simple;
	bh=u5PAgTbcP8a+xaTDWd2wrVwD3bTUwkdZSYQhNqRGMWk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hcBgf+B6qX9VDHa9Yql3q3fJrpBYk++DtRtZgA+SL/B2T2oWF5fjNknXFv5pa+6SwxOTMMIcHZ/Y7na8z1+tPPXPipkZkRug7E+s3b9k9b29b0wejtzrKRhRzxsCx3W3mf+F/N4l1OAKoRe0tJNolF+b/8lNOdauh+vq4JzTjiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nydonA5p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8841C116C6;
	Tue, 13 Jan 2026 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768329469;
	bh=u5PAgTbcP8a+xaTDWd2wrVwD3bTUwkdZSYQhNqRGMWk=;
	h=From:Subject:Date:To:Cc:From;
	b=nydonA5px97hYIgo0f+bI5vqUktBdrQxzmNSx6s3em4AiejCry6sMusKrwMJ+6o3F
	 jGI/SOVEnYaeyNmzg0YC44ZPj6AXxKJDvhlYvAuNJBVvQMLTi85/zAFYrSvzfecfiL
	 jwgsfcdGN6ZlCcZb1aQOmmdKzX08iHCZuL/UtRghmpZvwYwGN6RujLy7/hUO82IdXA
	 +aiIdyRwBM8+IrH1HIW2JXfK01mZ3OCnwfiVxdTJTjW4rarUYMUSm86Xc6Zp12cooD
	 sGsMMC0iVt5XmjLZmQHVnzRVHsqZYz59QQOvaORMN5x/4DBYydxdwZu9IQ8v1HHt2y
	 dInPpBb/hjjWg==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] nfsd/sunrpc: fix up some layering violations
Date: Tue, 13 Jan 2026 13:37:38 -0500
Message-Id: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0Nj3aLC+IKizLLEklRdA9M0I6PExGSDZCMDJaCGgqLUtMwKsGHRsbW
 1APN7zItcAAAA
X-Change-ID: 20260113-rq_private-05f22aac0c20
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Ben Coddington <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=u5PAgTbcP8a+xaTDWd2wrVwD3bTUwkdZSYQhNqRGMWk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpZpD8v6kallP3lVPBOuhtzMWD+RQ3X53BzJuzb
 2i76LyedgKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWaQ/AAKCRAADmhBGVaC
 FWW2EACwjcb06Ucj05OAg1MKy6ErrQyOr7vJwJT+uJygQp4b+IP6kFEtDAeyxvnwPpvMmhzBSDa
 oW6Bqp/MfvnDcUHbf3oiwrrOp3w4jNhKNsO+zK9RqOSgWUaLKm9CJnqoHkLt9SX4AwNKBjqIWno
 KcXqhQZ0vjFqfAb50i87skpJkYTidepIkdHV+9iw1omXdsKWy+eQTFkNInSWsDn9PpEDfTCBykz
 +q7G3jlhPmy8SDLeOxdniPtBDFDL2Fn7BT/uGEU4WnsjHCXUszsO9ItIgWllDNIUZuF+Qy8ov9m
 Jeh7/2r3pJVgnTzrLF0M9R1FDNS13XrW7OVzPm+UrH+yf9Omq7lxUrTo/6QO+7PRhRjtogjLSMh
 xNvZDyh7fneTVv4/aa3N7tHaM0uBYzTyJGvI5bks+JcV4EgpVvvasJ1DIEfFVNqD7vlDhz5rDCU
 KxhOCm8B1zCH1bbeSOUmno4FKFvZMsZVZTrOUaavRYz6G+OCrZA8et5ZsUAgZ6m7Ee6fyuN+Lkk
 jnw1MtdgdFH0zGJfOLbJLJw+LHvivqreiRUzbeJpuN1v5PwPAdePukA3M8SQyO1eYgw6DqmqyUf
 6UYY/T4+NGLQarl5jjXaRfcTvjutN59Qug2jHpawtAcU3yre2tQhar6M16KhKrbV5MM9KCy4ZB0
 BYOkfiIbI+kxGuQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The rq_lease_breaker and rq_cachetype fields are only used by nfsd.
These patches shrink struct svc_rqst slightly and makes the layering
between the two a little cleaner. In the case of rq_lease_breaker, I
think this also gives us a little more type safety.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      nfsd/sunrpc: add svc_rqst->rq_private pointer and remove rq_lease_breaker
      nfsd/sunrpc: move rq_cachetype into struct nfsd_thread_local_info

 fs/nfsd/nfs4proc.c         | 3 ++-
 fs/nfsd/nfs4state.c        | 9 ++++++---
 fs/nfsd/nfs4xdr.c          | 3 ++-
 fs/nfsd/nfscache.c         | 3 ++-
 fs/nfsd/nfsd.h             | 5 +++++
 fs/nfsd/nfssvc.c           | 8 ++++++--
 include/linux/sunrpc/svc.h | 6 ++++--
 7 files changed, 27 insertions(+), 10 deletions(-)
---
base-commit: e42954bff52b9538de21267c1bde2567b13b6632
change-id: 20260113-rq_private-05f22aac0c20

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


