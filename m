Return-Path: <linux-nfs+bounces-15160-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FB4BD084A
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 19:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B647E3BDF52
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Oct 2025 17:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DE12EC0BC;
	Sun, 12 Oct 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kreTWyCG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514532ECE87
	for <linux-nfs@vger.kernel.org>; Sun, 12 Oct 2025 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760288873; cv=none; b=ZKY0zEWzELIcCg+BvloHEWRLwBsm8PocFZk3a+xU5+KqZdhuY8Th9bp3h7ZCp9LO5oG6DrMYwBJeZaxo8LNmHPbOEneh2uUSqL/ua7MixnZwJvuGL7wRjf+FyfG0Fg/5PuGHGnoMqjWOP713SjFi1Xw5GCZCK+Cui0hIMFupLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760288873; c=relaxed/simple;
	bh=1TyHCGtRnCI2kEUawaHUczk1uvI04DsXEHfaarp7+8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FITQ3JgAieI/vtrzIGiIKPWBM7geC4OMApW98efncDsiBKWzheaz5xBu1dMSerO6HGlI5w1fyKl9zSrr83XFQjiyhqq1m66dakujhF10aQ49c2gnTGZw7KRt5m1EfNz6jlMWySLujaeybGgLObtAG0g3bUTQagZCcwAftiC6tug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kreTWyCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F4BC116B1;
	Sun, 12 Oct 2025 17:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760288871;
	bh=1TyHCGtRnCI2kEUawaHUczk1uvI04DsXEHfaarp7+8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kreTWyCGTEVpKciy6eBcZ0pELNWnQfhoyemUOpd+ezo0loWPeqUx3h4sOZcocivpw
	 ap/Un4zcpI3UeUBrBGvdFL7osufmn154oBD/2k1GK/AciGEOpZGXET7oU1svBDKR73
	 ehXb3Xd7AnkCkntCovkVdnhC68zR6HMnURz55N06t9EZ3AjbGyyRXjS2r+tEl0iXGF
	 sHC0mOpszNtTWBhMPAF3RrLUzIp4/yaFG26Tj8EKUXC42BLgXNlWQ00/KGKH9Jrv2t
	 qG7tBwfIXOqCKJX197NATUEdF1xEWdZn/MHW9DThgh7BACl95JxCpZru3fwfTgwrWY
	 pwBWliTo8ztiw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 3/4] NFSD: Fix the "is this a solo SEQUENCE" predicate
Date: Sun, 12 Oct 2025 13:07:45 -0400
Message-ID: <20251012170746.9381-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012170746.9381-1-cel@kernel.org>
References: <20251012170746.9381-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The logic in nfsd4_is_solo_sequence() is incorrect: it checks the
current operation index, not the total count of operations in the
COMPOUND. If the SEQUENCE operation, which is always operation 1,
fails in a multi-operation compound, resp->opcnt is always 1. Thus
when a SEQUENCE operation fails, nfsd4_is_solo_sequence() always
returns true.

Note that, because nfsd4_is_solo_sequence() is called only by
nfsd4_store_cache_entry(), it is assured that the first operation
in the COMPOUND being checked is a SEQUENCE op. Thus the opnum
check is redundant.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/xdr4.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index ee0570cbdd9e..d4548a16a36e 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -926,7 +926,8 @@ struct nfsd4_compoundres {
 static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
 {
 	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
-	return resp->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
+
+	return args->opcnt == 1;
 }
 
 /*
-- 
2.51.0


