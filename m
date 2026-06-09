Return-Path: <linux-nfs+bounces-22388-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UXPNKTNgJ2rkvQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22388-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 02:37:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC42465B628
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 02:37:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YaskCfwA;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22388-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22388-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93C53045472
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 00:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B3527816C;
	Tue,  9 Jun 2026 00:33:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDC25B0A6
	for <linux-nfs@vger.kernel.org>; Tue,  9 Jun 2026 00:33:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965228; cv=none; b=JFgNNbHm8okP56hkXhPFLHlqkSxYHuhflIYC14X4VX5LqaUIY+ZQZLzBNgUR3GreeZ0RzvzgutSXeQ0cjlVL2ebOkghxqqATaJcuiGO/LbSCEqfPVvOYeC2Ud4breo3U8Y4WnusMDjHio4AfiGFc/Stq2wVEzvqVEJuIHQ7Vvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965228; c=relaxed/simple;
	bh=4BDaSKNnO+9IDR5DcWlnWEKpMx/wr6udWoa6eoDrvnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTNb98wg9o3QtUREwuhO67IlW6pcZ9XYVMJZ7Rx34mKVrnEe5wtSrUAndiJW+Nvf1FvIrylWe6JhCnWsCNWQGQUPonOo6UlDMbm9qu56LvgjXqkg57yACdvzkmsffJSR7L5HQGU56R2q/3fVtjOirG3UIuvmm482vxuY3Dq2WBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaskCfwA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495351F00898;
	Tue,  9 Jun 2026 00:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780965227;
	bh=/ayfQF7CQIgWL0+T3brAhz1iir9IHt/iYBZr0g2+2mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YaskCfwAo9ZxWB3/WMV2vibqPgco/1w2eR92RXrLontD2ejoJgyGMvBIkQxol1yfQ
	 snF1zM78IphgMSx1+hwk0A5XjEIRAsf0YTBPwWP8nclo6HA89aRwp/gDvsg1xF32cn
	 faBBzEG4Xuz/ZcioGGm3Kue34MEuQpu+GigdMaQRfGRT0KiDRUDsk9wnq4czBya8i2
	 vXaadNDGUVhH0oRePfe8yyIJHtaYx7Dcxd6A5mDBnNLeKnA4SE/gEtC9+dvQ0eFXOs
	 8d+4NsCWiWp1HDqG2daxXKuFoBfRBMvYorakBcFJou5XAR5liewEesec16DQNWvDrM
	 fOLY+JRtiu4zA==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Scott Mayhew <smayhew@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSD: fix up error returned by write_threads()
Date: Mon,  8 Jun 2026 20:33:39 -0400
Message-ID: <178096512219.86595.6779381800614443178.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608131402.95625-1-smayhew@redhat.com>
References: <20260608131402.95625-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:smayhew@redhat.com,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22388-lists,linux-nfs=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC42465B628

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 08 Jun 2026 09:14:02 -0400, Scott Mayhew wrote:
> Previously, writing 0 to /proc/fs/nfsd/threads would return 0 if the NFS
> server wasn't running.  After commit 14282cc3cfa2, -EIO is returned.
> Existing scripts don't expect this behavior.
> 
> Add a check to bypass the call to nfsd_svc() when newthreads is 0 and
> the NFS server is already stopped.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: fix up error returned by write_threads()
      commit: 36f28c2e37a6a508f5a7be62ebe9c8887ed9bd20

--
Chuck Lever <chuck.lever@oracle.com>

