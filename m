Return-Path: <linux-nfs+bounces-7286-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBF9A462E
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 20:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C05285F70
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 18:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EB0204030;
	Fri, 18 Oct 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN28ppis"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74288176FA4;
	Fri, 18 Oct 2024 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277119; cv=none; b=InAhEb4emN8qcDznGC4v+YfKY+z0s+ayU5F10EJKXiBzb/lcQUQZrqgCdWqokN/exJkswp6z0pVmU2DJexQrWXBOIjtDb9qOyaTQlHSRPFSbva6Uk9eb0jrL0FDirmCRRS57Gi9jlOeaKsICnFYaitX4ueRsAio5P23Tr8SQaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277119; c=relaxed/simple;
	bh=x4ff+XQW/aNOmPRzEmjtn3b1sDpMrO1nVcAmrJV7A9I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r3sfQYAeDdlaPmAw02D6ow0QH2XIuipFRSI0+xtwigXFQ3UCt53bxTnWNoNP9jZJOUJNMFB4KGaLj84WJvdHzbVbma2KLJmo49ZWte4zI6sk6LPh/SBVe6jzWFhl8FWcoyiLQhejg39EcXneC5h3ziBY3x3xGAwNacW4nL3rwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PN28ppis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9FAC4CEC3;
	Fri, 18 Oct 2024 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729277119;
	bh=x4ff+XQW/aNOmPRzEmjtn3b1sDpMrO1nVcAmrJV7A9I=;
	h=From:Subject:Date:To:Cc:From;
	b=PN28ppiszz3W3auSF/IwdNtKHPgcjDMe4SMvTrzt6OwAd1Nt55CzrFwWFHOUfox1H
	 MJt+mE7rsaAzroCY0K7InooDQ/vPoB8cJ8zKO8vL+m4BJvqZi+/DCrYDVQrO9DT5qc
	 3S/T04d62kT8QUIeayJ/O85xTLn0ao/gzr1YOJT057aGqouXBLWjMOjbwpNz6kokDm
	 0thkO+YrzPqy3uJoieNj0DVvV5U4yHcEJIcoFbaWRJbrjqa78dS2kNkRucYp935eub
	 /iiHKfScjFe5LUmG0s18Uj78UmtDE4PlcQzrNp2uMW4MOBB2/jGg24XsoZnA85DTqk
	 fMfn88MIFu2ug==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfsd: fix final setattr on delegated timestamps
Date: Fri, 18 Oct 2024 14:44:58 -0400
Message-Id: <20241018-delstid-v1-0-c6021b75ff3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKqsEmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0ML3ZTUnOKSzBRdU0NDEzNjE0sT85RUJaDqgqLUtMwKsEnRsbW1ADb
 imE9ZAAAA
X-Change-ID: 20241018-delstid-5114634947de
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia <aglo@umich.edu>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=x4ff+XQW/aNOmPRzEmjtn3b1sDpMrO1nVcAmrJV7A9I=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnEqy4IYfdHz8t/zH2Zy3U0ITRKvxH3/Uxa1G0U
 WWNshl2hpiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZxKsuAAKCRAADmhBGVaC
 FZ+QD/9Vx/jqEjrlyFrizJo4T+H6ZP/X+fn1R4sSet5TGUdFN2wk3M6v2aZIAjtlGbkkLytDhWu
 M7/sG/RmvSBKnmqJimT72nqgupntisMQiYpsvY5V6i7i/Ry9jUI89kZzRn1LqA8Wu8mHi/f7UW0
 xdHBixJi/wEaU4O1HBFudjRTbj6EYCTPdFEBDv+JZjIghh+kInwSIKlvP5v6V6vTbk4w3mFiTUg
 MzYviYZaP/5b075BfRa7WM/kx9+kB6fhakpbHfz7JKjL3q3rncpeZ82OleLZWims9I3JBCVfnYd
 2vV5pZx0OaMkReVZ82blqUdrI/QyulPteVqKRlV8+7cujpfeyy1n+AjsYMm0L7sPvGojlULmN7u
 CdYWQealKYzsaNSnpPjx10DnkZU8qGRpNV8dGJasXSTXewJHdSNfnyzJN3JlAnsE4O/1JEcV2wX
 q1x/WwMDBGvkvpIx71l4W3wVxVD1/COPJJta2lNsxYdA05zPZo2rN76pUmTGOLBi9yOzkulxdJc
 0QlS67Zt2/zaJdFASuayJ2epCoutDHjFoKWCS1n73ihFak3VPew7fmfswyYz8JRTN2SGMthvtVs
 FvkH3f8WKhggHIwJ1Heat9JaxNO1QHWJcExHhB4MCUrtlYoKY+nGTneO9L4A1KVGRE9+wb1AGAW
 FrjvbNQF3ZLLeVg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Olga reported seeing a NFS4ERR_INVAL return on the final SETATTR before
a DELEGRETURN to set the timestamps. The first patch fixes that by
simply ensuring they are declared writeable. The second patch fixes a
related bug in the stateid handling in that same SETATTR. The last patch
adds a new tracepoint that I found useful for tracking this down.

It might be best to squash the first two patches into this one:

    f6b1cfab609d nfsd: handle delegated timestamps in SETATTR

The last one should probably go in on its own.

Thanks!

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfsd: add TIME_DELEG_ACCESS and TIME_DELEG_MODIFY to writeable attrs
      nfsd: allow SETATTR to provide a READ deleg for updating time_access
      nfsd: new tracepoint for after op_func in compound processing

 fs/nfsd/nfs4proc.c  |  8 +++++++-
 fs/nfsd/nfs4state.c |  2 +-
 fs/nfsd/nfsd.h      |  5 ++++-
 fs/nfsd/trace.h     | 14 +++++++++++++-
 4 files changed, 25 insertions(+), 4 deletions(-)
---
base-commit: 0f8b1a41842544ec66d328ce4349834d7a823d30
change-id: 20241018-delstid-5114634947de

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


