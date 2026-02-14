Return-Path: <linux-nfs+bounces-18936-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DKgAYW2kGn5cQEAu9opvQ
	(envelope-from <linux-nfs+bounces-18936-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 18:53:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5984613CA74
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 18:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05892300BDA9
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Feb 2026 17:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F041A3160;
	Sat, 14 Feb 2026 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbwXL5tE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007D16EB42;
	Sat, 14 Feb 2026 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771091586; cv=none; b=Tn/0Go1upraz6F3VWHjT/SZWf9ZdlcAlEnztbsOokICLkbrYpna8EGjGgf+tDzEfZZgog09TT7jf6CQlabWf6yqX6R4bj5E4MxZ02NAQm2cY9t7UIyX04wWfdqfWT7R8QoFZLomBigRwf87Msgc0iWwQex8Ye71Ud/nBKvucR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771091586; c=relaxed/simple;
	bh=2h6+kikS07dDpolK+hkv/uXzydA8DWQiG8leXAtnIWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4Lpn04DuIh4sNzYm56mQdUtzh3y26rBhLn1re3qnC2ECKafCsaOslgW51Cz0HPQcGxDmF9bSkw8N/CvP/LoZKOEbQUJXhmySa5/DgGQWMBo1n0C8LJ3q5gIR5/oRZnW/KEC5V+MAcRvuNsA6+yE3XRcu/bEZfXIleHw2YUTiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbwXL5tE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63C4C16AAE;
	Sat, 14 Feb 2026 17:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771091585;
	bh=2h6+kikS07dDpolK+hkv/uXzydA8DWQiG8leXAtnIWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GbwXL5tEof8jhFP6aX/swtdEBicYvd+pwBg0LOc2ZEZHJMEB2Edt/VKdgH6KgD7JJ
	 xo4nI/h43n2duIbwvMaUgPdCGXKcPgkdtLYN7FA3H1pvJ1lqjfNTz1G1JOHSx4XNq9
	 m5C2mgexG6bxfSzHEXpqFm4nALO0wp0xIn0ASbe/iBkH3oOpsUY5EuA9sEU3m4WDgN
	 o+T1iXJTOGgNgSvH8jeGe7IPHLhxFeYH7wVvBpjaeKkCtO6mKJdk5RQOr/a2n7dty2
	 Mz5w6oyvctvo7slRgF7GJkblOlsPa1yIARAu4S6I5w2H1YHpKBXBye1CdFQEIVT8Jm
	 3D7njq64SYbQg==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	tom@talpey.com,
	hch@lst.de,
	alex.aring@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v12 1/1] NFSD: Enforce timeout on layout recall and integrate lease manager fencing
Date: Sat, 14 Feb 2026 12:53:01 -0500
Message-ID: <177109154296.57968.985044750836996107.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213183647.4045478-1-dai.ngo@oracle.com>
References: <20260213183647.4045478-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,brown.name,redhat.com,talpey.com,lst.de,gmail.com,zeniv.linux.org.uk,suse.cz,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18936-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 5984613CA74
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Fri, 13 Feb 2026 10:36:30 -0800, Dai Ngo wrote:
> When a layout conflict triggers a recall, enforcing a timeout is
> necessary to prevent excessive nfsd threads from being blocked in
> __break_lease ensuring the server continues servicing incoming
> requests efficiently.
> 
> This patch introduces a new function to lease_manager_operations:
> 
> [...]

Applied to nfsd-testing, thanks!

I made a couple of small adjustments, please review the result.

[1/1] NFSD: Enforce timeout on layout recall and integrate lease manager fencing
      commit: ce1368c9edf719a4fada76bf537f0614ab611835

--
Chuck Lever


