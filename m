Return-Path: <linux-nfs+bounces-21874-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cATbHm3dEWq+rQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21874-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:01:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BD25BFF75
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 19:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A483D300AD86
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA306326D4A;
	Sat, 23 May 2026 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLKrghU2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD5431F9AB;
	Sat, 23 May 2026 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555621; cv=none; b=Whh0L58eniLN7FlNa0AwlMtRdSsui2GMit/KJvgIM4BJWLQV/HQUPdCmGHo1RbznvKEcxsLvOWnwC33ygqVanNbc6v5HODxRcQnKc0Oj7fVIPrfx26NtPVU4cKTOASVJPnBsOfCwPH0dpyvbN4vJNPKa4dBS7oWfyq40s3mpyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555621; c=relaxed/simple;
	bh=G545fC2PdNaI1UoLxNJOhM5XjwxpNcTsDun0VUoEq8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmXrPe6NE7MKLAXOjN4uywqCtrId2zrnltTjlDnkKxOR89j+U4pQplA5P5Fwt+n/S4UIAdkrYsBhCS1oVkpHe4YHK8TM1T3rIEUAWdAbnyQWpwZjSjR80I5CQ8eNrKsIYgsulppAmPkPWrd1SrVZvjFORFwIJMJd4mQBEJliFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLKrghU2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA611F000E9;
	Sat, 23 May 2026 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779555620;
	bh=3X6jsp4ObFTigOVsjSW7o9aKPhTBc7EVHv1JjTErOtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iLKrghU2JcV1fRITfx5dGJ8MJfEQL4Hclk8gSDFgFwsJNPlSIgYlEdyvXQ1Kuxh1A
	 KFFaNXoX9DU8bkc1d4tL26E6IIeKZaIzy2sr6S18i9QbjKONoO7KSpbOFqUs8edLux
	 HOdMTrPnZpZLVsNTXOR6KDV4wW+ULYN25FuHs8jm8BGVClqaVHrQeJQ15T+X9QcdL+
	 ARNcHPZbf+eQcPGLLoFTpS0yQr3uTJn2je1MXk1AKoqPonEIu3qfdydRnkX19LOfPE
	 6dh6prmjxBD1yiI8Kr51o9Bp1m/gtoptC7ULSyLD974iHIV/5M2Nu+Z90AIJDnvXCo
	 ldbemHipLOf3w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] nfsd: follow-on fixes for directory delegations
Date: Sat, 23 May 2026 13:00:16 -0400
Message-ID: <177955559085.514471.15267080765520493031.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523-dir-deleg-fixes-v1-0-142c884f85ce@kernel.org>
References: <20260523-dir-deleg-fixes-v1-0-142c884f85ce@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21874-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 88BD25BFF75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Sat, 23 May 2026 12:17:33 -0400, Jeff Layton wrote:
> Just a few small fixes for problems that Sashiko noticed flagged during
> review. None are super-critical but it'd be good to have them fixed
> before the feature ships.

Applied to nfsd-testing, thanks!

[1/4] nfsd: check for FILEID_INVALID in setup_notify_fhandle
      commit: fb1d813dcb193d52322e3320543c029c2931f613
[2/4] nfsd: use empty string for directory name in NOTIFY4_CHANGE_DIR_ATTRS
      commit: 9e8c221e056f6bf4a525fa5d74ecad735855935d
[3/4] nfsd: check delegation status in nfsd4_cb_notify_done
      commit: 62fdbd7c4ce24aee5aa9698c256047d2e4071f30
[4/4] nfsd: fix ino_t format specifier in nfsd_handle_dir_event tracepoint
      commit: 04cc256388df5d2d284f4d9d3e9f22ebf974f806

--
Chuck Lever <chuck.lever@oracle.com>

