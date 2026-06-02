Return-Path: <linux-nfs+bounces-22194-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI9iKXRSHmpqigkAu9opvQ
	(envelope-from <linux-nfs+bounces-22194-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 05:48:04 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A38627E08
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 05:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D59E300A13A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 03:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEEA21E0BA;
	Tue,  2 Jun 2026 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cid9Bdqt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99773191F91;
	Tue,  2 Jun 2026 03:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372035; cv=none; b=W1/6UYWz2kamrdgaaBpgyDIdLCAoU5CBByOQSENpwCFgFdVmvO46vukZh0oAIqudxlR9eNPVpQlLyryx27iuRHaVN0HjRvMZCgc2u/xVxLJsv5kfK1oFUc43uK9DL+F5pQcq7VxNWNr80uH2JXrY+sasV4sHXZhfJBXj8qyX4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372035; c=relaxed/simple;
	bh=wcmsjqfJR5NyB5p5ZX6zx6V3TLiZRcsovum2gbBkONI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rP7M2M3WVJ/5UrFMMIWLwnyGdCRZKQ2O8kSx3TP7xxmFygBk5bYvZ3ujm5r0amy3J6EmUxFC4L4IhPJ8/JgsYNyI457z6l5t0VXHmLHI/kEfvkzEOANVJJXSxOFoYAByBtY32+1yW2nfEfA0/Id3zvl+VFceBQ7yseGwMAYgsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cid9Bdqt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5851F00893;
	Tue,  2 Jun 2026 03:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780372034;
	bh=y102JK7t4zjzQxZJy7Z6tnvCtua2FlBZGuYUxjshNiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cid9BdqtKUcbMp8bk6GKNuLUCa9jZChhSJGF1mCHrHduAQu+OBnwWet2rsUa71oQq
	 lyNyx7MVswhR+tWr/RJZydi7S64OLXQbfst3P3U8g8DXbU1BKnlgTKFTGoyT4voPrH
	 Ww157MG2hk27njl3H69Ssfingw91qUiA8wAO6twzuVo3axW4+6d8Mq8RKqS+DWUKUo
	 fQyB9o3CMyZhUl+O2TXs5ixPxys7VNFEZho/NNHAGE5U8hZuHH/JGiSG4/LHz57Yhp
	 CvlsahlwqFmH0SFPitqF62NqLeB7VucUpNb6aT7FQuzp605B50rc96DIu/AGExKYOE
	 C6Ocj/YajmEcQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Rick Macklem <rmacklem@uoguelph.ca>,
	Chris Mason <clm@meta.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] nfsd: release OPEN-decoded posix ACLs via op_release
Date: Mon,  1 Jun 2026 23:47:11 -0400
Message-ID: <178037202577.29007.13514470184077854481.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601-nfsd-testing-v3-1-a31cd10bdd4f@kernel.org>
References: <20260601-nfsd-testing-v3-1-a31cd10bdd4f@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22194-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 22A38627E08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Mon, 01 Jun 2026 11:32:56 -0400, Jeff Layton wrote:
> nfsd4_decode_createhow4() calls nfsd4_decode_fattr4(), which allocates
> refcounted struct posix_acl objects via posix_acl_alloc() and stores
> them in open->op_pacl and open->op_dpacl. These pointers must be
> released once the OPEN compound finishes.
> 
> When nfsd4_decode_open_claim4() returns a non-seqid-mutating error,
> the dispatcher short-circuits before op_func runs:
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: release OPEN-decoded posix ACLs via op_release
      commit: 844f63869b2038377b82cdb90f8872acbdc8fde3

--
Chuck Lever <chuck.lever@oracle.com>

