Return-Path: <linux-nfs+bounces-18732-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OziJszCg2mouAMAu9opvQ
	(envelope-from <linux-nfs+bounces-18732-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 23:06:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D72ECEC0
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 23:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF5493012BC4
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 22:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C16A339B5B;
	Wed,  4 Feb 2026 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQBXjGe6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFB3311C38
	for <linux-nfs@vger.kernel.org>; Wed,  4 Feb 2026 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242761; cv=none; b=umPR8Uk3jyXYJLIlUDe5sc9KPekGBYH+YRgSiyBf2oH2YA8Uc21KKejVvIbn3l0mTOxZst4CfhBF88KgZx6bohtvSxTGnr7Cps5606AVGz608MIT/Hq+FWSAW3uovRY2fuAT7riBykbzQVG/Qmp+aHPxB2wM0I1V59EpHqhrK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242761; c=relaxed/simple;
	bh=E2UkXUcSjdFnyJlDwLcfQmeZ9dyGhEcZrJXArwhgwig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o788z3qmsysqHh8yUxbiMHvCja0w469m013DKLl+I/7GM3qeiVh5L6LYTOzJf5/K1j1lTPyPQTtIdV9Q3Gl32E2b0Hbtlr769hvIeGdZ6q3zTtrU50a9SOrk/Tn99XgV7LbHCAOJvszfLqJjBUjJrcTsjWH4XHSYbtT0J6k2C1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQBXjGe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209CFC4CEF7;
	Wed,  4 Feb 2026 22:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770242761;
	bh=E2UkXUcSjdFnyJlDwLcfQmeZ9dyGhEcZrJXArwhgwig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQBXjGe6tBILIIfkIxuPbc2B/qe/8Wkan2mKUVjt0cMszqjiiBpnvJ0aZgkZCT9WU
	 1zdhR/xdsGuvl/8qjBq+BcedPeNTrzDWW1y+ztescknGUiJcyU2i4E6yX7dyedNM3k
	 HvLgsBE2QijfPzWzTELbVnWQmwZWFL4axoqOeAwKd6/9q9AwnH42A8mDJ/s9U/oPwC
	 W0AqVQCI7QeZtZ4MfAD6jbHCnfD5Slwsm0kd1IMuMXWaGSMsqdTRr/1vnQQguP4ekF
	 DXrAlEFIoMCi7abgsIMFY93qHlM7S5wRXfDbvkhCg4BLB7qA9REcpIpdon1AnwoVTv
	 OWBFMepJOvN4g==
From: Chuck Lever <cel@kernel.org>
To: jlayton@kernel.org,
	neil@brown.name,
	okorniev@redhat.com,
	tom@talpey.com,
	hch@lst.de,
	Dai Ngo <dai.ngo@oracle.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: fix nfs4_file access extra count in nfsd4_add_rdaccess_to_wrdeleg
Date: Wed,  4 Feb 2026 17:05:58 -0500
Message-ID: <177024274638.126550.5570313022933600659.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204210807.4134644-1-dai.ngo@oracle.com>
References: <20260204210807.4134644-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18732-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 12D72ECEC0
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 04 Feb 2026 13:07:43 -0800, Dai Ngo wrote:
> In nfsd4_add_rdaccess_to_wrdeleg, when there is a race condition where
> fp->fi_fds[O_RDONLY] is not NULL, __nfs4_file_get_access should not be
> called to increment the access count nfs4_file since that was already
> done by the thread that adds READ access to the file. The extra fi_access
> count in nfs4_file can prevent the corresponding nfsd_file to be freed.
> 
> When stopping nfs-server service, these extra access counts trigger a
> BUG in kmem_cache_destroy() that shows nfsd_file object remaining on
> __kmem_cache_shutdown.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] NFSD: fix nfs4_file access extra count in nfsd4_add_rdaccess_to_wrdeleg
      commit: b4ae2fc4d1344fe20f431baf00f8256fb3bbaa87

--
Chuck Lever


