Return-Path: <linux-nfs+bounces-22537-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ag3HMBVlLGqaQQQAu9opvQ
	(envelope-from <linux-nfs+bounces-22537-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 21:59:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E1467C397
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 21:59:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WVxeeaiF;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22537-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22537-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6F72301257D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 19:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E033A717;
	Fri, 12 Jun 2026 19:59:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D23148DA
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 19:59:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781294354; cv=none; b=PS8+AJlqrZltJiVol1qTVsr9+RVwqIZuxljrEbHVfxHLEkxW7ycguUA+bZk8ibttnvcddAtdw50i8C5uAbvfsd4RyuExt5Zd0P08HF1YtbgiB6mAnZsZIQnDdp9mvkUB5BJ+lyQ+Fr6say+FyzXvZ2z/MYiALO/dGuA0RF56+aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781294354; c=relaxed/simple;
	bh=iTgU8nZ8iXkwZoC31XYOHFH0wngH/eP3SyFgs76+w/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnLCVUXPMWMKPVPjTg1tEAbtkBVxXF7FfvjhS9O4kqhYIFhW/WFkAsraK1bPG++H07agu3VxyyB18mohwu6HV8Esy905Jd9/E4LSsiqEAtgAwpDBkVCtdWYozm8LLnB7auH7qj0fsrpPWRJSZQpIz+0oA9OYaRIJd103/CAHbfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVxeeaiF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C3E1F000E9;
	Fri, 12 Jun 2026 19:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781294353;
	bh=mffusFcQyg449pYAeDq+Mjl5sK8KiFgwO8EJvP2Xvow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WVxeeaiFwYeJRwHjUoypH21Ljpmv2fd31SU3+3IPwl+SU7MSR3BuYTUkkzy4bRFBE
	 HgzBQQnxv1eAAf38xFfH87znDqyOPVKCFQW0+jiK9cxC6wZckyV/FbylB7z9fP7e1p
	 Ts5fyc+xf0THp4jclbJfJBASBFmJwkCM9dysmOtjFKQ1GVhVcnGTMfvuMuT9SVAoEY
	 tlp+dobNnBGCRRRw8X8aapfN8bSryFkIUp8PSl8G13tXmIzq8R2VlHeM7bXdLE1WG3
	 naMBW90ELPJMg8wXAMXPlSXRLDpurtNejLcrewkj9H7a+j8FFbptLOqkz+M9g1boJ7
	 yTX+3djWUostw==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: remove flawed WARN_ON_ONCE from nfsd_mode_check
Date: Fri, 12 Jun 2026 15:59:10 -0400
Message-ID: <178129434237.2112345.8630514032722535119.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612191410.50177-1-snitzer@kernel.org>
References: <20260612191410.50177-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:snitzer@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22537-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58E1467C397

On Fri, 12 Jun 2026 15:14:10 -0400, Mike Snitzer wrote:
> The header for commit e75b23f9e323 ("nfsd: check d_can_lookup in
> fh_verify of directories") details the assumption that justified
> adding the WARN_ON_ONCE to nfsd_mode_check(), that assumption is
> invalid (in the case of NFS reexport).
> 
> When NFSD exports an NFS filesystem it is very possible for
> nfsd_mode_check() to encounter a @dentry that doesn't have
> i_op->lookup (see nfs_fhget()'s NFS_ATTR_FATTR_MOUNTPOINT and
> NFS_ATTR_FATTR_V4_REFERRAL handling, and d_flags_for_inode()).
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: remove flawed WARN_ON_ONCE from nfsd_mode_check
      commit: 4b4af25d320d077102026bf72fa2b73614f2605c

--
Chuck Lever


