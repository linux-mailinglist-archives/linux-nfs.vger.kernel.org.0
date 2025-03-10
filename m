Return-Path: <linux-nfs+bounces-10547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E77D9A59939
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 16:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8819C1887C52
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Mar 2025 15:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D98B22A4EF;
	Mon, 10 Mar 2025 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="M11WnA1F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3E0374EA
	for <linux-nfs@vger.kernel.org>; Mon, 10 Mar 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619470; cv=none; b=nIpTOG6kTqObzf/VwDZeXapM3wmS139EN1nU8OwTuaKwCIVlQdHZ7mIIhzZLxwNCPy2MUGWTvdauaqco75eARYsJ6661r3RVKYyNYP16fEjwsxzvCLTcUPAl1mToYNxR2LdRPeGVJ+59futL22IKsKyLztI9V0zIWx8cLksiSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619470; c=relaxed/simple;
	bh=sagrptvYS45f2KkZS4wyUyei87EBblAN2ua2KPLJjpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q5VaLlphInaETn5u0X1JdxutbaCZWpoRhoMaczzK4ZpYKuNLPcoX7VeF+9wwNEJK8JafzNMNBEfgm85dC+VPY23SA262YapeusqS3WiLNiyLXz2LMgeMwvg1K1TmDM4jlOHPRN2E6VJHsjv3bMvMcBzwcSJt12Q7ow2fbb9IgjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=M11WnA1F; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Date: Mon, 10 Mar 2025 11:11:02 -0400
From: Nikhil Jha <njha@janestreet.com>
To: njha@janestreet.com
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 	Chuck Lever <chuck.lever@oracle.com>,
 	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
 	Olga Kornievskaia <okorniev@redhat.com>,
 	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fix gss seqno handling to be more rfc-compliant
Message-ID: <20250310A15110284b71e58.njha@janestreet.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1741619462;
  bh=8+j4RZQxEvPp50n/z3AP4/HWcFwA5ubLD58W/xz/5cI=;
  h=Date:From:To:Cc:Subject;
  b=M11WnA1FgrQPOLsZ2FIwMG5sk/gf2v6X65fqWb+RvQbr33rTSTmP7ZuIzNHUlCMSY
  tbqeEfHXmms1lM8CbnvQYCoPddYFarOb9qYNUeBdqyju2TpOoEoR7j0BhhGpIdqIUs
  eB7zHoGMZQ/qd+5c2BBkNv1FUeGwH3MSIeu7H7zHpA3fVorQmz501gGOGcjJLCISou
  H7Qeb5tB3Bd1fl51nzObEBmR2PStPo4Z0tTjaWIg918Ef810mMMjIveoGGMRfxE7pv
  LYYrYyUHfQLAGdE0nr5gyEZsvNyq642CNABb5dBgcjNX3l/i+3kw2zOW58GOdsDu0O
  4T/SnH2jjmVWQ==

When the client retransmits an operation (for example, because the
server is slow to respond), a new GSS sequence number is associated with
the XID. In the current kernel code the original sequence number is
discarded. Subsequently, if a response to the original request is
received there will be a GSS sequence number mismatch. A mismatch will
trigger another retransmit, possibly repeating the cycle, and after some
number of failed retries EACCES is returned.

RFC2203, section 5.3.3.1 suggests a possible solution... “cache the
RPCSEC_GSS sequence number of each request it sends” and "compute the
checksum of each sequence number in the cache to try to match the
checksum in the reply's verifier." This is what FreeBSD’s implementation
does (rpc_gss_validate in sys/rpc/rpcsec_gss/rpcsec_gss.c).

However, even with this cache, retransmits directly caused by a seqno
mismatch can still cause a bad message interleaving that results in this
bug. The RFC already suggests ignoring incorrect seqnos on the server
side, and this seems symmetric, so this patchset also applies that
behavior to the client as well.

These two patches are *not* dependent on each other. I tested them by
delaying packets with a Python script hooked up to NFQUEUE. If it would
be helpful I can send this script along as well.

Nikhil Jha (2):
  sunrpc: implement rfc2203 rpcsec_gss seqnum cache
  sunrpc: don't retransmit on seqno events

 include/linux/sunrpc/xprt.h    | 31 +++++++++++++++++++++++++++++-
 net/sunrpc/auth_gss/auth_gss.c | 35 +++++++++++++++++++++++-----------
 net/sunrpc/clnt.c              |  9 +++++++--
 net/sunrpc/xprt.c              |  1 +
 4 files changed, 62 insertions(+), 14 deletions(-)

-- 
2.39.3


