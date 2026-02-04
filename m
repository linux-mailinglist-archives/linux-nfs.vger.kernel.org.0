Return-Path: <linux-nfs+bounces-18708-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCLTM5Bwg2mFmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-18708-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:15:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEFBEA09E
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 17:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0F72326FB4A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 15:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116F3410D35;
	Wed,  4 Feb 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjO2UtoH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DB53EDAC3;
	Wed,  4 Feb 2026 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219732; cv=none; b=VXe/y1OEAO+EibdYRoJ2oBaOIDNxkGcpEiXgBPuw8ie85sQH6r21Eavv1ka526B/aU4UIK0wFH0+nGZAJnoetTwjZQMXSZSRrgEi067URdtPTPEO6n1OJBEgN8LjPCGnJzemWkiBooG3whCZGMugzh+mgPHlxn07CnBrV0alaYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219732; c=relaxed/simple;
	bh=j16DCHzTYFhgMNNXLWUYmmV1peJOwGFCMDbhW4/8pRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USGDb7pZ2kKCbp8t2Z6UXirINZuASQYrEPsHaSVD30RzJ1v9yqvF3X3ukEj4dm6bkll/xWSbBiQvIcoAGVY/z/8oupNd4TUT/1RdybeBqBcTD2Ep4+qFRdt7ilzWRGfIoyOmU4isfqct6D8hend/XD5CnYbDGucTxHEKAmiodig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjO2UtoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C308CC4CEF7;
	Wed,  4 Feb 2026 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770219731;
	bh=j16DCHzTYFhgMNNXLWUYmmV1peJOwGFCMDbhW4/8pRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjO2UtoHfMVRTkEXdQMDTZA0npLozUQoJ5DanPKFbBK42cLSd5UsaH8ySBAFAXvXn
	 UvfTcwUFFvTu1CZNvAc5yDVjMDG8NtbI1yvWudI7sKKOLwChlIDR9BVUlu0MgBsRIz
	 s+hf5MhmMbI2exexvhO1bblf5KC5Pqsv1bdF2ExoQoBeppDUByDo4K81KWacp3vwWT
	 5QVH2NFVPeTmqJdkKLqoSJE0uq4KTFajuE1wFhwlZUG5Da5UhdLRo6kqf79oeKIrpK
	 DZZfOJ1B3acvcb1h7Z/HWinh4WAZ/518G1p+rNmecyAn2UgIFl2ZEcSMPsWGK2uNmr
	 u72U6Gx2frP/Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2 0/3] sunrpc: Fix `make W=1` build issues
Date: Wed,  4 Feb 2026 10:42:06 -0500
Message-ID: <177021968762.97318.15008544066362314853.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
References: <20260204094500.2443455-1-andriy.shevchenko@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18708-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FEFBEA09E
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 04 Feb 2026 10:41:20 +0100, Andy Shevchenko wrote:
> Compiler is not happy about unused variables (especially when
> dprintk() call is defined as no-op). Here is the series to
> address the issues.
> 
> Changelog v2:
> - added patch to kill RPC_IFDEBUG() macro (LKP, Geert)
> - united separate patches in the series
> - collected tags (Geert)
> 
> [...]

Applied to nfsd-testing, thanks!

Acks from the NFS client maintainers on 1/3 are welcome.

[1/3] nfs/blocklayout: Fix compilation error (`make W=1`) in bl_write_pagelist()
      commit: b2e8b11ff47d3ba5075844ac4fb806296b3c4859
[2/3] sunrpc: Kill RPC_IFDEBUG()
      commit: 85acbbcb4127f635c062cb52e5dbc62b0635b3f8
[3/3] sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op
      commit: 380f84a3c8fc3809b614a6765c2fb0acc3e8674b

--
Chuck Lever


