Return-Path: <linux-nfs+bounces-18731-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ti1D7fCg2mouAMAu9opvQ
	(envelope-from <linux-nfs+bounces-18731-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 23:05:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D93EECEA9
	for <lists+linux-nfs@lfdr.de>; Wed, 04 Feb 2026 23:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BC0A300DDDB
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Feb 2026 22:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8656933A6EC;
	Wed,  4 Feb 2026 22:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9hJonF2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594482AD10;
	Wed,  4 Feb 2026 22:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770242740; cv=none; b=Zgf9rMM0+lbH1Jz1tPdefwD3Z4fenB4Yk5DPuewNVY8Sq7pJH41KbHu6bbXpoj/yrm+MyP+LvOrfVVFUaFRbcwsg0T+QLkiS4ywr4aG6fq+rXjjlrNDaoHNVnZW5tQZFWWmlzd0lVWdxJlexuSO8I7dTLUUj0SRIzGpWwCoaRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770242740; c=relaxed/simple;
	bh=LBh3yZrxTbV+Nik3y8NVWmrFxuD/4ne8LGXSYzVBtmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQ8d8MgRw/e+C53Xc7LB4qgNIHHY174jYoBRWfMX1OsfN1qaJP/0RfsPeiD2Vk2K4cHyOCJzGQb1gu1LgPl94B7FKTKl1XJ6THDZ+ICY6gtXHr/3uCu6UMYPTFeZZHHksejaDBznU/Ixzc+umijKvHPW+H2XaQe5RZlAwOadO+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9hJonF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BF6C4CEF7;
	Wed,  4 Feb 2026 22:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770242739;
	bh=LBh3yZrxTbV+Nik3y8NVWmrFxuD/4ne8LGXSYzVBtmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9hJonF28c+UKC8ECjTyGoNn3tuyVfS/FBMi/AEv0nGT/aj292ptmxLXt7+dA6XAd
	 FEu/QeNZiiZvYz92C+tLqAuWmXRRZUkiwnY0XdqgP/Fw86okwEK2250/QgzV5MLnD9
	 x5RozvylBba8Rz6KpJ6+8V/qbw42th/onoPQK2qlaOI3H02AuYh+txaBilwJ+t2cRl
	 Ckf4zev8EjZcLCo0NKDHBYv8lG7MXWmvN3eCoCkHN/OMVVQQt537170bWrAT4mmPjP
	 rGM/um/EiCcGLw7002lKyC7Y+nRhxGUI/POkmpA2uqygTPlFHylm1xVqhlkXgTtbsI
	 PKf+ytyjFbb3Q==
From: Chuck Lever <cel@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
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
Subject: Re: [PATCH v3 0/3] sunrpc: Fix `make W=1` build issues
Date: Wed,  4 Feb 2026 17:05:35 -0500
Message-ID: <177024270291.126397.9981743455921781902.b4-ty@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260204202437.2762161-1-andriy.shevchenko@linux.intel.com>
References: <20260204202437.2762161-1-andriy.shevchenko@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18731-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[oracle.com,kernel.org,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs,lkml];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D93EECEA9
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

On Wed, 04 Feb 2026 21:21:48 +0100, Andy Shevchenko wrote:
> Compiler is not happy about unused variables (especially when
> dprintk() call is defined as no-op). Here is the series to
> address the issues.
> 
> Changelog v3:
> - removed ifdeffery to have struct rpc_task::tk_pid available (LKP)
> - collected more tags (Anna, Jeff)
> 
> [...]

Applied to nfsd-testing, thanks!

[1/3] nfs/blocklayout: Fix compilation error (`make W=1`) in bl_write_pagelist()
      commit: 5ea3d8c52742bc3fef3b1399ecb6d750fa94b11c
[2/3] sunrpc: Kill RPC_IFDEBUG()
      commit: 69998e1a90d71181df815570a89e972a8bde2b0e
[3/3] sunrpc: Fix compilation error (`make W=1`) when dprintk() is no-op
      commit: d5a6213462466a15cecb601896eb4df81aa13b9f

--
Chuck Lever


