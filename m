Return-Path: <linux-nfs+bounces-20619-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNzpFmvbzmmGqgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20619-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 23:11:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A7438E43D
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Apr 2026 23:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ADB130063B4
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2026 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04848382360;
	Thu,  2 Apr 2026 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEe1fCc5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E87204C36;
	Thu,  2 Apr 2026 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775164131; cv=none; b=k+wUSv1CYxVaenbAWOifT/jWwBT2F0GGIYNORdySiQr8+umazfVnA6iWTp4GN5g1C3r0WavaMsSiS/cUtuoYJhbLi/GZ+I49JnLZyEYmGpS/tJ8BICki0zr8FEtj5AuAl+QzwZKo75GSqRCnpyDhXlYd5JFb+dagOqQUHVo05oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775164131; c=relaxed/simple;
	bh=8V19yQPUf7XED54pgj6wnQOvP1KeE1ujGFv7TD0JL5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ok7Wfsj1yY6dDFmfX2SE2TDtOLedFZcd9qqkc2b1GnussgoprURvOLxtFsMlmxWGu4GbgltmvT4jade4S+81LapFE1toCtimct2d3TeW06VaufY9QQkuU8qejTIl4vpfQGG9YDUQNmuMZ3E2wlgvAOcEXi5Pj3tFQ2Zyo+bTp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEe1fCc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2623FC116C6;
	Thu,  2 Apr 2026 21:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775164131;
	bh=8V19yQPUf7XED54pgj6wnQOvP1KeE1ujGFv7TD0JL5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XEe1fCc5kDC0Fuqy72hIOi+R2xKhI3tr3kEtTfexldS5XElYXHdeRCTsfXleX/tKl
	 7hU1+uW+ps48WvBxqnv4qgK/1QPxPTSzPqj4Uysaxvkj47mE4+zwjJuvCdx02a/gy+
	 msCYm1QpYb2El9Em3kie6CdCFjrkzTD86dMriGn5LvVcorK5YJHLkcFrQv+Fw4zzfQ
	 A58c7XB7804tE/jg9MWp/1sB2sWZUtAKRfpmTR6QGoD1eSevxkcJaBCb/pGI3EpUS9
	 p+/Gs4bMTn5/naCoZcfPrlFb9bml48WDRHTVxPToGYEsBxdknych7XF7+FgDlmvJHO
	 NE5xNoF7INy9Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 00/13] nfsd/sunrpc: add support for netlink upcalls for mountd/exportd
Date: Thu,  2 Apr 2026 17:08:45 -0400
Message-ID: <177516411713.3059543.823840324914491662.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[brown.name,redhat.com,oracle.com,talpey.com,davemloft.net,google.com,kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20619-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email]
X-Rspamd-Queue-Id: B7A7438E43D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 25 Mar 2026 10:40:21 -0400, Jeff Layton wrote:
> This version should address most of Chuck's review comments. The
> userland patch series is unchanged. I've added the netdev folks this
> time too in order to get more experienced eyes on the netlink bits.
> 
> Original cover letter follows:
> 
> mountd/exportd use the sunrpc cache mechanism for some of its internal
> caches that are populated by userland. These currently use some very
> antiquated interfaces in /proc to handle upcalls and downcalls. While it
> has worked well for decades and is relatively stable, it has some
> problems.
> 
> [...]

Applied to nfsd-testing, thanks!

[01/13] nfsd: move struct nfsd_genl_rqstp to nfsctl.c
        commit: 9255d64c38df86b504fd9928c4599f506e0e9a5f
[02/13] sunrpc: rename sunrpc_cache_pipe_upcall() to sunrpc_cache_upcall()
        commit: 296a9a594de51e5d4f875a56ece878dab3a4afd0
[03/13] sunrpc: rename sunrpc_cache_pipe_upcall_timeout()
        commit: 4695f0a549afde54672311ff3b70e4a8c9f67ee4
[04/13] sunrpc: rename cache_pipe_upcall() to cache_do_upcall()
        commit: 9699085b61700e040ddb500828cf5430e0a9f7f3
[05/13] sunrpc: add a cache_notify callback
        commit: 0f2e29eb49430fba0ddcc9f0a8fb10334751e9f8
[06/13] sunrpc: add helpers to count and snapshot pending cache requests
        commit: d5d861c2a0340a70c869b5688c57741564956875
[07/13] sunrpc: add a generic netlink family for cache upcalls
        commit: 44139e2b768b1bfd9fcc8fbefdcc5a425ef448cf
[08/13] sunrpc: add netlink upcall for the auth.unix.ip cache
        commit: 8f056ebed4272238de8f003925d91bdb4e6726ae
[09/13] sunrpc: add netlink upcall for the auth.unix.gid cache
        commit: 6bfbaa6d611bcde1d62435982a2d8895ca0082e8
[10/13] nfsd: add netlink upcall for the svc_export cache
        commit: cfefcaec25438cc82344ac3ea22c474798e05531
[11/13] nfsd: add netlink upcall for the nfsd.fh cache
        commit: dbd292f2d787b7ae0d471da9783996eb8eea759e
[12/13] sunrpc: add SUNRPC_CMD_CACHE_FLUSH netlink command
        commit: e91b082fdae41cdeb73772aeeee2f61937d14c65
[13/13] nfsd: add NFSD_CMD_CACHE_FLUSH netlink command
        commit: 895a916e2c31d86a11b867c16ac0e4e167298e5e

--
Chuck Lever


