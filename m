Return-Path: <linux-nfs+bounces-20815-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NjJFllb2WmEowgAu9opvQ
	(envelope-from <linux-nfs+bounces-20815-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 22:19:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DB23DC73A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 22:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C9683010614
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Apr 2026 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4436C5BB;
	Fri, 10 Apr 2026 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8q0Agoc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD23A35E929
	for <linux-nfs@vger.kernel.org>; Fri, 10 Apr 2026 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852373; cv=none; b=UyYXJ+MuWrNGgqpFHLQvUCKt94a99IwwayJ7YUGofqmeAcE5vjL8cJeADuAIBwDOCOJf8/7KaVVgQAvjb0y5dxhXuzja66cIExiKfe7RQxRLGoLWmp7lCUSKBid4qV9HEV1ccDHWdiumNSi+16lZDnUBkq7yrfn1sNEhUMTx6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852373; c=relaxed/simple;
	bh=anx9oH8n+wxw5Afb9fuchdp7cu7WgGWLxkD13M/XXMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxlhAovrqLfj3fTdNN8j/LXOo2Zmw5y4AQP1fZ88vB4bqNB4mIdFbAmUrQaEXw1sbuHKEeeVSPYN4vyNqRjpdJITnxOimCoLOjZEQi4S+xf2VROEvnkptxoQ0EIqyHEpxByGKlhhpJNLVyERXNIAq0tFFRTPZqiVujyuQohGfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8q0Agoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0465C19421;
	Fri, 10 Apr 2026 20:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775852373;
	bh=anx9oH8n+wxw5Afb9fuchdp7cu7WgGWLxkD13M/XXMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8q0Agocg+88UOY0yKzvC4B7H0Z3cyvhwQysdBeO5imDqoRnJKo1tqdo60joMwAOl
	 dAvtKrDk9kVkM91QQg4tH5gBLwlAInTPJnPX1iM2QqFB4aQlF/JL3N3+32FoPZSEgG
	 wduSoEXvHM06bucnTQyrAy/lDzvZcjpmyYS9QXNBfGGeMIPiBZBaYn/xD9H7rZBb3j
	 Ysyl3SkQWAEi1LEcu6yhgDdH3D0vllQBgbsG7JUmX9lWZ3EB3xuik+31cznkkyvq+N
	 YP1HDXcBHI61g1ty/WBYBR3QruVRN1OFeAO2h8U92KTgB7rVY8gBa8DWx4itw9w1Wp
	 CqqVrDYsIcwoA==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org,
	neilb@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: Re: [PATCH v4 0/2] nfsd update mtime/ctime on CLONE/COPY with delegated attritutes
Date: Fri, 10 Apr 2026 16:19:29 -0400
Message-ID: <177585235184.1992986.5886959705627774468.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410160920.56855-1-okorniev@redhat.com>
References: <20260410160920.56855-1-okorniev@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20815-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: E7DB23DC73A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 10 Apr 2026 12:09:18 -0400, Olga Kornievskaia wrote:
> generic/407 is failing in presence of delegated attributes and this patch series
> explores the solution where the CLONE compound returns updated mtime/ctime
> in the GETATTR op in the compound.
> 
> Both CLONE and COPY need to update destination file mtime/ctime
> (in presence of delegated timestamp) when file was modified.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/2] nfsd: update mtime/ctime on CLONE in presense of delegated attributes
      commit: a7f570141bae209189f05fdff295f67fe84dd183
[2/2] nfsd: update mtime/ctime on COPY in presence of delegated attributes
      commit: d0814470307048890b3cf6c8b373815f0b8cd64d

--
Chuck Lever


