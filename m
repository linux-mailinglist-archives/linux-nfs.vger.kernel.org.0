Return-Path: <linux-nfs+bounces-2051-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F685FF46
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 18:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45AEC1C23EB3
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Feb 2024 17:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F20154C17;
	Thu, 22 Feb 2024 17:26:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D891482EA;
	Thu, 22 Feb 2024 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622800; cv=none; b=Kp8EmxvN0lVhsR10hKOvYE98GvOgln+0sIc6UsRGI7G4UzxLD/pgDs5fskObtQZvgHfN2YJcE5/voSn98RxRyF55yLQPlyBYmHoH4m0+YiyuuosD4qbSFlytsKjnlGhrmcUmI2yX+mYbzFl8AVrrG4tJwvNez1/Y/xybVU3DUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622800; c=relaxed/simple;
	bh=6g0prWZ7Mq8U3GlrMjmMcSvysWHUsBuonuNf4FT0a8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bFvMRJP38UBKezeFjz5vsHDykBSnOAvmHlEz/JPQ9jvpJYi/hSXyPOsiXcffGUkUK1A67bsvJjBasxmcy3QJ0KGRs+eBGOU5cad+Y22fAXfWO1s8EU7d6kP7OnaJwRiQ8Jw3lz3YTpvXXyqMkdsG0Rf9ZaGSpcu5P4K+kBCve84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6111C433C7;
	Thu, 22 Feb 2024 17:26:38 +0000 (UTC)
Date: Thu, 22 Feb 2024 12:28:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, Jeff
 Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>
Subject: [PATCH] NFSD: Fix nfsd_clid_class use of __string_len() macro
Message-ID: <20240222122828.3d8d213c@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

I'm working on restructuring the __string* macros so that it doesn't need
to recalculate the string twice. That is, it will save it off when
processing __string() and the __assign_str() will not need to do the work
again as it currently does.

Currently __string_len(item, src, len) doesn't actually use "src", but my
changes will require src to be correct as that is where the __assign_str()
will get its value from.

The event class nfsd_clid_class has:

  __string_len(name, name, clp->cl_name.len)

But the second "name" does not exist and causes my changes to fail to
build. That second parameter should be: clp->cl_name.data.

Fixes: d27b74a8675ca ("NFSD: Use new __string_len C macros for nfsd_clid_class")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/nfsd/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1e8cf079b0f..2cd57033791f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -843,7 +843,7 @@ DECLARE_EVENT_CLASS(nfsd_clid_class,
 		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
 		__field(unsigned long, flavor)
 		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
-		__string_len(name, name, clp->cl_name.len)
+		__string_len(name, clp->cl_name.data, clp->cl_name.len)
 	),
 	TP_fast_assign(
 		__entry->cl_boot = clp->cl_clientid.cl_boot;
-- 
2.43.0


