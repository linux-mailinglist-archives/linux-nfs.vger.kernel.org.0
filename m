Return-Path: <linux-nfs+bounces-22036-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJaBImBfGGpEjggAu9opvQ
	(envelope-from <linux-nfs+bounces-22036-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 17:29:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F65F46B2
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E7EE301EC76
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 15:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833884611C2;
	Thu, 28 May 2026 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeV9hQfN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09D41B37D;
	Thu, 28 May 2026 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981354; cv=none; b=K9WUzUnD39ii5JOG2bpmcQC8OaKgTGZWFH1pVv2eHVCsSN3wfNFWViJ59VwXkNsdgSfpE5RF0PT3NGxvsT1mF/TTbj8N4SJRKsE//PQwJUk/bX0mc4PB7NStMst/BmqcVxOK+BCYfFU4ExqMq0NQAe6eX2QCO4PO7mwbZvjAvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981354; c=relaxed/simple;
	bh=bo5WTW0l50NUrPIr1NpcJGhvZeTuDBzgXDquCQNuqqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDrhMtvAJ+gV9++gzXgR5Q6hawRdrQSxFBwyU5hHbsEvqWCbwGO4QP4rF41egw1JrKkm7YRmi62hyCqK39yh8jqr0kMOi1q0bZ6OWOQgcaZYP3eN+OERZiogPJwFFcAjRL1fZy/3swHMXB27Lk3UyaAZ5RsAiuY8w8ef7cbkC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeV9hQfN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38DC1F00A3C;
	Thu, 28 May 2026 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779981248;
	bh=SAbZ6LQsbuhY2YaTUKrtmmABGDdFKXkhoLQzCPPWdcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QeV9hQfNU/Mf3Gz5TnppXYQk0X+3qGcTxgc/zFnY90JxzFxV8dgg5RArFD4khdndM
	 GSXKr2PiUosXvn8hBk1HVhAMUixFRIPi46sep5PIFx2JDArcdtMpj6xVNLOkjfMH5W
	 k9rqF8+FVfEwMuan3WbN6QoJ2giAmbpxRPQQ/MqF+X2ue5+XMX/RB5OSSZAvcoyjyS
	 kMb/nDI0nDq8OtqSpLt1wAVk50NEBEelKR5sEG9ZMWxmqI6+wUhn3ZX1Xm2pm17lIh
	 XZrZ8cHn+Ms0jExgWFcjZguQhKmDDAWBsR9s/kCupdDIuigfOoIGsboI/oQdJj5gbR
	 bQs8YcpJ/Sefg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Sasha Levin <sashal@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: fix XDR padding calculation in ff_encode_getdeviceinfo
Date: Thu, 28 May 2026 11:14:04 -0400
Message-ID: <177998122996.340259.15377525881232211349.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527-pnfs-fixes-v1-1-784f39dc1eca@kernel.org>
References: <20260527-pnfs-fixes-v1-1-784f39dc1eca@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22036-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Queue-Id: 020F65F46B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 27 May 2026 14:30:41 -0400, Jeff Layton wrote:
> nfsd4_ff_encode_getdeviceinfo() computes the da_addr_body reservation
> as 16 + netid_len + addr_len, but the subsequent xdr_encode_opaque()
> calls emit 8 + round_up(netid_len, 4) + round_up(addr_len, 4) bytes.
> The mismatch means the declared da_addr_body length exceeds the actual
> encoded data by 2-8 bytes on every flexfile GETDEVICEINFO reply,
> leaking stale reply-page content to the client and mis-aligning the
> subsequent version list decode.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: fix XDR padding calculation in ff_encode_getdeviceinfo
      commit: d53136757d4192934ad67d4c5c58eb9bc99daf4b

--
Chuck Lever <chuck.lever@oracle.com>

