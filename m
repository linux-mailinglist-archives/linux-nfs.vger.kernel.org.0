Return-Path: <linux-nfs+bounces-22060-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aK1cBmK6GGqsmggAu9opvQ
	(envelope-from <linux-nfs+bounces-22060-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:57:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D15FAA25
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 23:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8701C30702AE
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206C369204;
	Thu, 28 May 2026 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0thdS0T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D52367B8C;
	Thu, 28 May 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005342; cv=none; b=RQzbfpripX3iwmZVEcpDO8/a9Se2GbLcsByYit/7+RmRQcHZ+GKwtX/V8SCzr9tgVWRCzriWruQilqX8497Ll5AXFw9nuAvCoQIXT9uQXmWe146WbOUhysk9aj395OMhqSUJLCzE0k82FiAlmyHhmesWkWhNUG+q4TCdOYsQcR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005342; c=relaxed/simple;
	bh=14ZvczbnLPmszix02zJpjBn510ZrCpD9uZ8yHxb0h+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irYPawnxrLcEmVwujApl1NjI0rY5ImM26kMjBYsgD0kojfUBbb9EmsrfonYO19fWp7d91sjt5FxjRA3BfxBQ654f+ODO0vdHqbz0rJHADD9LuxWDooiDqM+BYDbEQu7CbyqdWC9CAtG9wVjpfdvPV1HBSBLzREbM6fGcprjcoJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0thdS0T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901AA1F000E9;
	Thu, 28 May 2026 21:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005340;
	bh=6/t4f0OHFqr8Avxv8F1KCmoMLWiMdtXQ8guYxaB+nnc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O0thdS0TkMiKTV5OIJvwf6frMukeGG1bIT3owEnQrtT9DXusY4g1A+bzreUc3VBd1
	 aSsfkgNw8mOZoczIYASdZzCbD7ZX1ZzCiLfxePyagF8QcQaW4nDRh39+2KYKBNYA8s
	 yIqrqY54ZpzdYB8QSQKDBtlyNiDUFcSm9wzBL3JcpjzX5OhCGNl53xlf9kRCQUlk9L
	 buZw/oTYt/93X2dSnYi6XDfUy1yN0pH+9Mp0CQsC5MvGxOHlgWM+DstfjIJHWEUXwM
	 Ql+E6jK4OWmd0h4+OHBvdHKUqV4imcolkHE6CH35gVbV1g9nmkUinT2x+2hEbewjAo
	 6FC0Uv7wOor7g==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 28 May 2026 17:55:21 -0400
Subject: [PATCH 10/10] nfsd: validate symlink target length in NFSv4 CREATE
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-nfsd-fixes-v1-10-e78708eff77d@kernel.org>
References: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
In-Reply-To: <20260528-nfsd-fixes-v1-0-e78708eff77d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=14ZvczbnLPmszix02zJpjBn510ZrCpD9uZ8yHxb0h+A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGLnM+6gs3ykB2WslLr7jJHyxmfP7Hp0ovRyjO
 wBDuwynIAmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahi5zAAKCRAADmhBGVaC
 FYk8D/9QaA/L0TFoD0GsRdaA4q3ZgNaceFWDnHqD9PitbZef8wU/185jRhoNN4UM6G2NI5mhB85
 lH8cF0XK79z5K3qLEvpasMm6eJmx1sLzrutxWqffADwvcliiOKr4qSpjzsj9i3WAIHzA5c5BD2y
 c0bGmek6DCs7nB4QaLronjoS16peezdN1Y6WyB94YYfh0DwVGUNzjtjenRzB+uRgv751vStEPcG
 gDoBD6e2QbaoEHQNylvj+JVfH8hrnmHnuWerCtSrlg9pTtT0OL+Ig8RQ79LZIFgUoDuq9drgZg1
 OH1GEiEf3jfWa42jIeujmpQPo5WHIoSHySfhmyriLD6hfLpx4St4vomgxq2wpah8CF4AJ1l6hBa
 j+J/bcvMgoknVnwz7C/L1rm8Q4fzbMhN/ycWt1Uc2DI8lThxU2WjBf3NqBIxht0J7MO4y2avkrH
 JiC0GFDWmkqqzda78E7C3WxUDfthwI5a29fbKgdDtuf46pDEgp5NhJpYXYsxkmaAv141D5i5CQY
 1UHGjWTKtOEA9+vU6UANauh29uH7649ig0eWFa+CEpJr1rqMs37dsR32ONHWSItO0BL9DgXhBzA
 SRmR3/ZKI09CDsAbA3bPKeDFig9Z989ZEvyclj3Kn+drVk/KOpUi3ZgSSk+VqA6bUKyVbBUUifM
 1eLk1e4vMdzmTDw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22060-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B66D15FAA25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_decode_create() accepts an unbounded cr_datalen from the wire for
NF4LNK symlink targets, allowing a client to force a kmalloc of up to
the RPC-max size (~1 MiB) per COMPOUND op that persists until compound
teardown.  The VFS rejects oversized targets with ENAMETOOLONG, but the
allocation has already occurred.

Reject cr_datalen == 0 or cr_datalen >= PATH_MAX early with
nfserr_nametoolong to bound the allocation.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 5469c6c207ba..1f5e49f50f3a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -957,6 +957,10 @@ nfsd4_decode_create(struct nfsd4_compoundargs *argp, union nfsd4_op_u *u)
 	case NF4LNK:
 		if (xdr_stream_decode_u32(argp->xdr, &create->cr_datalen) < 0)
 			return nfserr_bad_xdr;
+		if (create->cr_datalen == 0)
+			return nfserr_inval;
+		if (create->cr_datalen >= PATH_MAX)
+			return nfserr_nametoolong;
 		p = xdr_inline_decode(argp->xdr, create->cr_datalen);
 		if (!p)
 			return nfserr_bad_xdr;

-- 
2.54.0


