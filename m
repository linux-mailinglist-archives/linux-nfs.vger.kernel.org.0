Return-Path: <linux-nfs+bounces-22135-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FmaJyJaHGq7NAkAu9opvQ
	(envelope-from <linux-nfs+bounces-22135-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 17:56:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEE96170BB
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 17:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39412304996B
	for <lists+linux-nfs@lfdr.de>; Sun, 31 May 2026 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F46390CB0;
	Sun, 31 May 2026 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC1vsYMU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF0390985;
	Sun, 31 May 2026 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780242824; cv=none; b=AuyMeCgxPh1AaFVTyaRoVLv10Ia77JuVMAzZsHNTFe7plddi7cg6YmvRczTpToXrolDvGDW8uZz9FApiwImiM0XTvxKoM82tQ0PmWtiTwQzHR6B24DDzqMy64Mwd2roeXfnXXP70ufj1bYXXsoeeQdzLTNO8xb37Y/taKtvsTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780242824; c=relaxed/simple;
	bh=spQq8ib9RgblRwF2Z8LdI+WnRytoRB5lW5TmZ0J5FcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7VO59Cxu2qnGzJ3BekhHu5Ah2DPmzLRQ5MTBIPVc5lPbG97boHzFs/EzF/ogprPnwJP82l+tw71x4FW7Sbn7H6qA+K/DKAs+YEMi7P+9FAy1PMVkpLnovcOKd3go20kR9bEGAEs5ikGcngZl3XsOrUkQyvyl6G1HO3pwJG+XIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC1vsYMU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9487F1F00893;
	Sun, 31 May 2026 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780242823;
	bh=/5bL47vKbBSHjmSSVLepTySdcrQqtjvi9dVD+9qepIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RC1vsYMU1zCXYi2k15xaDLjBHvfDGZZhwWY+dJiaKb+vTwWytp8O/Du777SW4+GsC
	 hkhCKuRGJONT5BezcBfOQau/KnfYHZHo17rL+Wod3vOTEHleVImeL0Sc2ovN8/K5XI
	 mKKMP3K8ib1VfXxfOt7EGhabExz+jVad+azO7v7f9e3FQgm6Rm57FdauXHWMUT5bDm
	 7RCYcYtNdBce+1zO8/y9gX9DfesgOh0g6y8ftQAR8/4//PMfC4nj+3zd5NNq5SSJ0o
	 HZ+ilc/qDYYw88G+k3w7e+cCOUpXRDgCULp67l19LwMeU10Mtbo5OAlDl9lgXu40PK
	 JWrsgFq7LFCRA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Rick Macklem <rmacklem@uoguelph.ca>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] nfsd: medium-severity bugfixes
Date: Sun, 31 May 2026 11:53:39 -0400
Message-ID: <178024277887.699547.17672585328822959963.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22135-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 1FEE96170BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Sun, 31 May 2026 08:06:57 -0400, Jeff Layton wrote:
> These are classified as medium-severity, remote-triggerable.  Some
> memory leaks and refcounting bugs, and a potential buffer overrun in a
> tracepoint.

Applied to nfsd-testing, thanks!

[1/6] nfsd: size fh_verify server sockaddr slot by xpt_locallen
      commit: bbbc993f3932be9428ebf81009d0d1a4aed26d00
[2/6] nfsd: release path refs on follow_down() error
      commit: 41c9073b511fe70d5e3b03f039c409d2060de06b
[3/6] nfsd: fix nfsd_file leak on inter-server COPY setup failure
      commit: b55429cfce784ffcbaed2960d66b7c5db90ceec3
[4/6] nfsd: fix dentry ref leak on V4ROOT export filehandle lookup
      commit: 657c7e3082589c35695f77821f1dfa31bf4c6a34
[6/6] nfsd: fix layout fence worker double-reference race
      commit: 4faa69d7158a4436d340b7324aa34fa672362b5c

--
Chuck Lever <chuck.lever@oracle.com>

