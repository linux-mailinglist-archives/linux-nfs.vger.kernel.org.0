Return-Path: <linux-nfs+bounces-14706-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE0AB9F2ED
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C58A5601F0
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA502FD1CF;
	Thu, 25 Sep 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icFt4T66"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBA32FCBE9;
	Thu, 25 Sep 2025 12:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802471; cv=none; b=ZMGcKmhapJtxC6B7JVNVc8vPZcN2hWaoIR+1v4Cycu/eo+pEVXfO8b4DWLNjVNw4MBco6JyhasdhZW71HyX0jNyM2gbt8Ifwv9COsR5q3ypminB8X0Njja6nliKDTRehdzcNfrWoJiWG77aI+OXZ5eERBY8o82P7wgIY7SKNRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802471; c=relaxed/simple;
	bh=XbGnmtwio3B3JgSAQG1zHDw8yELBmaP//jXBQIJLcXM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=F2kmp/gnaRhfAAMCqmRvI4ZE5d17wSPg+jz7asNUvpTFsgCM8v279yyBbRQ8dEhOZJzV3rPdTRWCyfTF1DaT/GVi6sVYq78TpoQPOlQguaw0zNcumZR462esC9DCf8qJ4MgxxQ+/G4sEQ67jLgtvaDFAEYDF4KHYT1JwTQjO29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icFt4T66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B574C4CEF0;
	Thu, 25 Sep 2025 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758802470;
	bh=XbGnmtwio3B3JgSAQG1zHDw8yELBmaP//jXBQIJLcXM=;
	h=From:Date:Subject:To:Cc:From;
	b=icFt4T66GiXb+CBLNVZnPuczSTRX3lKXQaU2vDDt6fCjIKEhLapiBiHrPmJLrQFwH
	 qXCGu1qB1u68KcLfLlQm9UomUjlaYO/N+Eh4jxeoArpIFrHtrtkQs68MZcw+/7Ci+w
	 U/YVzPOD0Wx++ta4fbVUZ7L5kB2tSdBTOo/4+McG6diUrybq8TxLFowTuxXbLge4xI
	 kCmz3VIHjdZL5jP2yaoTgRJvl6QFmNDJct0eQfTppF8UtZoKe26hJLLveJZFDootTD
	 mtUCKbAkm3jiTaUvZe0ophUeAGJZnTrw9v76JqCgHnJzI78cTTAthPQCnkH9J0Q3iH
	 OsyPRWfs9NhVw==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 25 Sep 2025 08:14:21 -0400
Subject: [PATCH] nfsd: Move strlen declaration in
 nfsd4_encode_components_esc()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-nfsd-fix-trace-printk-strlen-error-v1-1-1360530e4c6b@kernel.org>
X-B4-Tracking: v=1; b=H4sIABwy1WgC/x2NwQrCQAwFf6XkbKAbW1F/RXpY21SDkpaXRYTSf
 3fxOIeZ2SgUpkHXZiPox8IWr5AODY3P7A9lmyqTtNK3F+nZ55h4ti8X5FF5hXl5cRS81VmBBSx
 Zui4d9Z7OJ6qhFVqF/+Q27PsPTNLDeXQAAAA=
X-Change-ID: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>
Cc: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Simon Horman <horms@kernel.org>, linux-nfs@vger.kernel.org, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3575; i=nathan@kernel.org;
 h=from:subject:message-id; bh=XbGnmtwio3B3JgSAQG1zHDw8yELBmaP//jXBQIJLcXM=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBlXjVT+P2t7ypHHzcKcozD/4/JfPIUvqyNORf14+Z5rU
 9Z3bUm/jlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjARpjaGv0JTXZmOOJY8uvRi
 guvHL4dmx3rli7iIl/5ZZX3j2rnJ+TEM/ywqpjyd07LN9mrNAQanjJ3867fL/V6/rSVlXs3iSrd
 VJ/gB
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

There is an error building nfs4xdr.c with CONFIG_SUNRPC_DEBUG_TRACE=y
and CONFIG_FORTIFY_SOURCE=n due to the local variable strlen conflicting
with the function strlen():

  In file included from include/linux/cpumask.h:11,
                   from arch/x86/include/asm/paravirt.h:21,
                   from arch/x86/include/asm/irqflags.h:102,
                   from include/linux/irqflags.h:18,
                   from include/linux/spinlock.h:59,
                   from include/linux/mmzone.h:8,
                   from include/linux/gfp.h:7,
                   from include/linux/slab.h:16,
                   from fs/nfsd/nfs4xdr.c:37:
  fs/nfsd/nfs4xdr.c: In function 'nfsd4_encode_components_esc':
  include/linux/kernel.h:321:46: error: called object 'strlen' is not a function or function pointer
    321 |                 __trace_puts(_THIS_IP_, str, strlen(str));              \
        |                                              ^~~~~~
  include/linux/kernel.h:265:17: note: in expansion of macro 'trace_puts'
    265 |                 trace_puts(fmt);                        \
        |                 ^~~~~~~~~~
  include/linux/sunrpc/debug.h:34:41: note: in expansion of macro 'trace_printk'
     34 | #  define __sunrpc_printk(fmt, ...)     trace_printk(fmt, ##__VA_ARGS__)
        |                                         ^~~~~~~~~~~~
  include/linux/sunrpc/debug.h:42:17: note: in expansion of macro '__sunrpc_printk'
     42 |                 __sunrpc_printk(fmt, ##__VA_ARGS__);                    \
        |                 ^~~~~~~~~~~~~~~
  include/linux/sunrpc/debug.h:25:9: note: in expansion of macro 'dfprintk'
     25 |         dfprintk(FACILITY, fmt, ##__VA_ARGS__)
        |         ^~~~~~~~
  fs/nfsd/nfs4xdr.c:2646:9: note: in expansion of macro 'dprintk'
   2646 |         dprintk("nfsd4_encode_components(%s)\n", components);
        |         ^~~~~~~
  fs/nfsd/nfs4xdr.c:2643:13: note: declared here
   2643 |         int strlen, count=0;
        |             ^~~~~~

Move the declaration of strlen into the while loop (as that is the only
place where it is used), which is after the call to dprintk, to clear up
the error.

Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This solution may be too subtle but given that dprintk() seems to be on
its way out, maybe it is fine. An alternative would be a rename such as
str_len but there is some symmetry with pathlen so I opted for this one
up front.
---
 fs/nfsd/nfs4xdr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index ea91bad4eee2..580bfa8011c7 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2640,7 +2640,7 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
 	__be32 *p;
 	__be32 pathlen;
 	int pathlen_offset;
-	int strlen, count=0;
+	int count=0;
 	char *str, *end, *next;
 
 	dprintk("nfsd4_encode_components(%s)\n", components);
@@ -2654,6 +2654,7 @@ static __be32 nfsd4_encode_components_esc(struct xdr_stream *xdr, char sep,
 	end = str = components;
 	while (*end) {
 		bool found_esc = false;
+		int strlen;
 
 		/* try to parse as esc_start, ..., esc_end, sep */
 		if (*str == esc_enter) {

---
base-commit: 3fadfaec904dffab02ebf63dd9c2ae8fa15c6d32
change-id: 20250925-nfsd-fix-trace-printk-strlen-error-2a24413eb186

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


