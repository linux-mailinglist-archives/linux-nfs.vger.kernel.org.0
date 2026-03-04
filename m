Return-Path: <linux-nfs+bounces-19777-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI1lEUBUqGnUtAAAu9opvQ
	(envelope-from <linux-nfs+bounces-19777-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:48:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B572033A0
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Mar 2026 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53125306CD89
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Mar 2026 15:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2342A336889;
	Wed,  4 Mar 2026 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2eKO2EX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA833986F;
	Wed,  4 Mar 2026 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639076; cv=none; b=b3Z884nQrJKQL2Ri37J//oGZxFvVRFZpdkw2RRkXdZDSIhUDrN2F/zcL0fl7fL7CZdmLgNItob2+oT/17iDvgZgtSgmdJZnbb0GRGlBhDy/L38goZoaR91WZ2sf4Rd2a+Qg9PEvI5wXHDSnLa4j8fNipB0YwmwejMFs/wRXb3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639076; c=relaxed/simple;
	bh=dZwirCIyW2p8OcjaEFKmNp3sEpiEgyQvrSbUghh+aNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOnIE+b3feopvu6EKqdgVZV4HA0QBN7hgXSUsvbAGWfjBW4nVxtgEFsUYnL85GNCI8DFgnMUoqwXR6BuhFUp5sxKJ6oOVwZzlvsBS9uVw3KtKqedjSntd7DtTfUm5sZOkFb92pZofyIR9yuIdoaX8DuzevI1nhos5UFnVNXJNCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2eKO2EX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7815DC4CEF7;
	Wed,  4 Mar 2026 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772639075;
	bh=dZwirCIyW2p8OcjaEFKmNp3sEpiEgyQvrSbUghh+aNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f2eKO2EXN0Yndk4JZLFaO6HTOloUQLOoi3bMrVverVYCxo5Gpc6zZpOV1nyWSyqqe
	 boJYOtyoSMo4fKtY4lQWAuV9kqRANiYTEm5FpSTMDkdiRe279zWRuFgxupg/X3iCSI
	 rJAQeoZ1SMmt1NxtmzkER9KY1WFuj1a5SJ5rotKMehNVAcPhMH0qngNV1jjBwzxx/t
	 8dXx7M5PtAHCsYv9cB1rtyZA0DXPgmV/A6mXvfP1MeO0c8CixNz3u+8AyXlr4uA0rH
	 8jnKJvJRU5LuHd74eaBPfxDkcf4AlMqt3TQXdDf12tSceu0pRWIOmY/gB6O/iDvJCy
	 5I3ETWuw5pTqA==
From: Sasha Levin <sashal@kernel.org>
To: Tj <tj.iam.tj@proton.me>,
	1128861@bugs.debian.org,
	Neil Brown <neilb@suse.de>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	stable@vger.kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: Regression: Missing check in nfsd_permission() causes -ENOLCK No locks available
Date: Wed,  4 Mar 2026 10:44:23 -0500
Message-ID: <20260304154427.443501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
References: <c0f15088-3fc0-487a-9f24-cf89c158420d@proton.me>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8B572033A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19777-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

This response was AI-generated by bug-bot. The analysis may contain errors — please verify independently.

---

Bug Summary

Commit 4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK"),
backported to v6.12.54 as 18744bc56b0ec, removed a critical
permission downgrade from nfsd_permission() that affects NLM lock
requests. This is a severity: functional regression -- exclusive
(and shared) file locking via NLM fails with ENOLCK on files where
the requesting user lacks write permission on the inode, such as
read-only ISO images served over NFSv3.

Stack Trace Analysis

No stack trace was included in the report; the failure is a
user-visible ENOLCK error, not a kernel crash or warning.

Root Cause Analysis

The bug is in the interaction between nlm_fopen() in
fs/nfsd/lockd.c and nfsd_permission() in fs/nfsd/vfs.c.

Before 4cc9b9f2bf4d, nfsd_permission() contained this block:

    if (acc & NFSD_MAY_LOCK) {
        if (exp->ex_flags & NFSEXP_NOAUTHNLM)
            return 0;
        else
            acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
    }

This downgraded the permission check for lock requests from
MAY_WRITE to MAY_READ, because file locks do not require write
access to the file data -- only read access is needed.

Commit 4cc9b9f2bf4d correctly moved the NFSEXP_NOAUTHNLM bypass
into __fh_verify() (fs/nfsd/nfsfh.c, line 377) and added explicit
NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS flags in
nlm_fopen(). However, it dropped the permission downgrade (the
"else" branch) entirely.

The call chain for an exclusive NLM lock is:

  nlm_fopen() [fs/nfsd/lockd.c:50]
    access = NFSD_MAY_WRITE | NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE
             | NFSD_MAY_BYPASS_GSS
  -> nfsd_open()
    -> __fh_verify() -> nfsd_permission()
      -> inode_permission(inode, MAY_WRITE)   <-- FAILS with -EACCES
  -> nfsd_open() returns nfserr
  -> nlm_fopen() default case returns nlm_failed
  -> client sees ENOLCK

For files like ISO images (typically mode 0444 or 0644 owned by
root), the requesting NFS user does not have write permission, so
inode_permission(MAY_WRITE) fails. Previously, the downgrade to
MAY_READ would have allowed this to succeed.

The NFSD_MAY_OWNER_OVERRIDE added in nlm_fopen() only helps when
the NFS credential matches the file owner (checked at
fs/nfsd/vfs.c:2858), which is not the case for files owned by
root when accessed by non-root NFS users.

Affected Versions

This is a regression introduced by:
  4cc9b9f2bf4d ("nfsd: refine and rename NFSD_MAY_LOCK")

Mainline: affected since v6.13-rc1
Stable:   v6.12.54+ (backport 18744bc56b0ec)

Any kernel version >= v6.13 or v6.12.54 is affected. Versions
prior to v6.12.54 in the 6.12.y series are not affected.

Relevant Commits and Fixes

Introducing commit (mainline):
  4cc9b9f2bf4d nfsd: refine and rename NFSD_MAY_LOCK

Stable backport:
  18744bc56b0ec nfsd: refine and rename NFSD_MAY_LOCK (v6.12.54)

Predecessor commit that removed NFSD_MAY_LOCK from NFSv4:
  6640556b0c80 NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()

Existing partial fix for a different aspect of the same regression:
  0813c5f01249 nfsd: fix access checking for NLM under XPRTSEC policies
  (Fixes: 4cc9b9f2bf4d, by Olga Kornievskaia -- addresses only the
  XPRTSEC policy bypass, NOT the permission downgrade issue)

No existing mainline fix for the permission downgrade regression
was found.

Prior Discussions

No prior reports of this specific NLM permission downgrade
regression were found on lore.kernel.org. The only related
discussion is the XPRTSEC fix by Olga Kornievskaia (commit
0813c5f01249), which addresses a different facet of the same
4cc9b9f2bf4d refactoring.

The original bug was also reported via Debian bug #1128861.

Adding Neil Brown who authored the original commit 4cc9b9f2bf4d.
Adding Chuck Lever and Jeff Layton as NFSD maintainers.
Adding Olga Kornievskaia who authored the related XPRTSEC fix
(0813c5f01249) and is an NFSD reviewer.
Adding Dai Ngo and Tom Talpey as NFSD reviewers.
CC'ing stable@vger.kernel.org as the regression affects v6.12.y.

Suggested Actions

The fix is to restore the permission downgrade for NFSD_MAY_NLM
in nfsd_permission() (fs/nfsd/vfs.c). The following patch should
resolve the issue:

  --- a/fs/nfsd/vfs.c
  +++ b/fs/nfsd/vfs.c
  @@ nfsd_permission(...)
       if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
           return nfserr_perm;

  +    if (acc & NFSD_MAY_NLM)
  +        acc = NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
  +
       /*
        * The file owner always gets access permission for accesses that

This restores the "else" branch behavior that was lost in
4cc9b9f2bf4d: for NLM lock requests, the inode permission check
is downgraded from MAY_WRITE to MAY_READ, since file locks do not
require write access to the file data.

The reporter's workaround of keeping the check in nfsd_permission()
while also having the copy in __fh_verify() confirms this analysis.

For immediate relief, the reporter can either:
1. Apply the above one-line fix and rebuild the kernel
2. Downgrade to v6.12.48 or earlier in the 6.12.y series

Neil, could you review whether restoring just the permission
downgrade (without the NFSEXP_NOAUTHNLM check, which is now
correctly handled in __fh_verify) is the right approach?


