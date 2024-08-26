Return-Path: <linux-nfs+bounces-5752-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8399795F216
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 14:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7929B2324F
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2024 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1C7189B9B;
	Mon, 26 Aug 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI1vchag"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A4217C9AD;
	Mon, 26 Aug 2024 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676614; cv=none; b=lRnAUEaYYiCTpBDkVf+9aWJvUwti6sgv3hTPqs91Z1HoLlWczMxmtYjzRogrSd6+rlUo5e5WYNO3TB3JFIN3INl/FMsdeX9tNnljoXlbThtxSoh72Omrix4FtLW2q0BIu3bQR4EoC2FGYmhwej9XlNjPvDWIn/dhhX7BNQbeMSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676614; c=relaxed/simple;
	bh=prYIWJaLE5/Qq2KKOubfaUeUSPV4xft6OYJnGcbmNsE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NMy9L4NqGMI9KYQc3kOLpS+rQGFZefQnE50kGY4dQfk9zXyvCOmqB6/fIGnqwQQOz06WrxfDKahGONuJ8g3DVODRbOQLenS6MEm4rdFIqBEjQS9ZdzBdploOVYdHRShf4fMf6sj6TdElyHO4OM3Yz88MxX06szbMasch1g8Snd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI1vchag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D35DC4FEEB;
	Mon, 26 Aug 2024 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676614;
	bh=prYIWJaLE5/Qq2KKOubfaUeUSPV4xft6OYJnGcbmNsE=;
	h=From:Subject:Date:To:Cc:From;
	b=BI1vchagXe2NjQOkTPPylHDYKbSLbLCprOCDm6/auZ7cLhlh1erYmIUM+p/nI8N2K
	 5QxUzSuQEx5LZk2ukxFeTtgbHHnW68MCNOASqRcCHhXthINogv/ipaAYehR4NC6PlQ
	 Pc3k/RiZ+UORizn10QMM2AvuypUdCwkdkjz8hjCU4VzqQ5lDIm6tqYPExxxIqdi0lp
	 hbqaM+b/8x7FOCeHctcxc9qQAOHy2eKy9NA6IKx4eBk3S9+9Hp6QrTg7Rcf0Yk6HRP
	 6c/7azGm9dcPQmX36tk+0RepOdGOnK2WbMiNY4KjO59l3x+JLEZovd7Anx+7MgHBWW
	 yjU+p69/O4Ipw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/3] nfsd: callback debugging improvements
Date: Mon, 26 Aug 2024 08:50:10 -0400
Message-Id: <20240826-nfsd-cb-v1-0-82d3a4e5913b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJ6zGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCyNT3by04hTd5CRdw6REY3PzxJREM6MUJaDqgqLUtMwKsEnRsbW1AB/
 p01ZZAAAA
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=858; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=prYIWJaLE5/Qq2KKOubfaUeUSPV4xft6OYJnGcbmNsE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmzHoEpi55/jV7Q/eiJNQ6rnRi68MNdc0sWYTig
 Gm7rq/mulqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZsx6BAAKCRAADmhBGVaC
 FW8uD/4rKw8iRtvNj3zEoGbk4vD/Je2XDtwT0Uh5PVOMFgKmRydxpynxrgrDQvlsH9+83mb30fO
 oZXfmgFecfKZET4XL+luWweHGUj3cRjvLG62eBQKDZK/sSEGLbGenz1kDqfuBFev/w67g9q/xhw
 pcpm3L9IpXEq8EYc2lxnUHWcV1y/CID5b8FNHJDLgXTPs8mGxySvCQOap8iig7k01YDu9cLzPiq
 0MuxX6s6R8FlE1yaQ/80MJSHZS5UeKLL19ewWhpp7+s+hxbWeL0MNkxQXT86KhqUkbHxoruCfWk
 GWZFTJXxzgVwoEF3jeV8EPky/RsJtvgpGHLaoU5Fe+sBuyu4gbuxdrkeB/P7OabmFkSlyEaC02n
 8PidHtK8c+ON0RW8TE7XJv3A8c1e159cxI7AHzyoXHqcZCsV7KJEoK8CuxJLp4OlpjkvNsooOfz
 /dUpJmWAdf3vPQR5+DGnsiPMyfBYfNl4sD3mHYgqM6PTpcpKUlNYjKp8bXAWZsKufeml5IZFw8n
 jz+7GUqLW2/S+RT17sgsE/R2lRCKf4tj7YOtVYHKrN+XhkvlhAYu4amN+Ow3cTUzajKyZvZpdPb
 4+APnW6VqpoQhVNksWbQQMQoG2lR12DpU8Kl+ANs4fWwL9/o5Kik+SJZyh5dd+H+QvZVlmWRtKh
 uPOGcLuM7WHTRmw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

While working on the delstid patches, I had a couple of bugs that caused
problems during the callback handling. They're now fixed, but these
patches helped me sort out the problems.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      nfsd: add more info to WARN_ON_ONCE on failed callbacks
      nfsd: track the main opcode for callbacks
      nfsd: add more nfsd_cb tracepoints

 fs/nfsd/nfs4callback.c |  8 +++++++-
 fs/nfsd/nfs4layouts.c  |  1 +
 fs/nfsd/nfs4proc.c     |  3 ++-
 fs/nfsd/nfs4state.c    |  7 +++++++
 fs/nfsd/state.h        |  1 +
 fs/nfsd/trace.h        | 27 +++++++++++++++++++++++----
 6 files changed, 41 insertions(+), 6 deletions(-)
---
base-commit: 5be63fc19fcaa4c236b307420483578a56986a37
change-id: 20240825-nfsd-cb-1ba377ada62d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


