Return-Path: <linux-nfs+bounces-10210-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D66FBA3E14B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 17:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73463188BC56
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B312139C9;
	Thu, 20 Feb 2025 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGWGbma/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DC8211A0B;
	Thu, 20 Feb 2025 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070048; cv=none; b=OOF4P2kW7Y6InBzm163zAGyW+2c7neKLjpGCoeX+XJCPOHXqqNGqy4VyZIX4s1Gsv6/l85QMHt9Sr7YGg7biU6mzfHkXeSI5c4/Y1eR+ejAQX7szBqTblJJNzbjypMGw4JcRXSSeXaZiDc4Lv9gp4NiVUsOAx1bV415QlqojInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070048; c=relaxed/simple;
	bh=C5p/ojW3QfHFyvcxVtc9cHreBC7v/KQwFhn3nzGhpEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BP9i5yEkzTgl+sGONhMayOtyHGFYMTtS8gqZmLskA7b6zt+Sk6gcV04ZLgoW9jny1a2lEP+jxsb/B0tfM0G3xLSDwZdYYmb/Piu2fbzhEW7Ha13q3hpKAq8yspJjm5blw50r3A2/qZxQO1srQ1r7PNipbf+gDKVzuNFVgfVwCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGWGbma/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A8EC4CED1;
	Thu, 20 Feb 2025 16:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070047;
	bh=C5p/ojW3QfHFyvcxVtc9cHreBC7v/KQwFhn3nzGhpEk=;
	h=From:Subject:Date:To:Cc:From;
	b=CGWGbma/2m6e3p5frqXg8A57Bj7nJ5u+W/FJtb4NSzwtzngyTqCipaoF0iek5XMmi
	 +1H6iIPL64tCVlp4DvjDNXLD/VOITyCC57K2LnrdYe/Fn4VITZwKJVVZbN26cuDax8
	 8/syzH/8t0sqCTjor8rbVLLNevpQu4vtvcsP46jnp9HpGFPVhhiD0owy0qBs4cCcNP
	 XlSjD8gVp0okq533aK0sXseGuQzS5Ult4yGJvsC/w9AWPhyLVA9axsu99+3UUIzCbE
	 gPleLuY+nfft2Yeex7FttY15TBwrr7t4KosAAAyaISoLbRQ9au9+ptOMd8uD2GNH25
	 /MZwLnW0Dj+SA==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/5] nfsd: don't allow concurrent queueing of workqueue
 jobs
Date: Thu, 20 Feb 2025 11:47:12 -0500
Message-Id: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJBct2cC/3XMQQ7CIBRF0a00fywGsAJ15D5MBxQ+LWkDBgzRN
 Oxd7Nzhfck7O2RMHjPcuh0SFp99DC34qQOz6DAj8bY1cMqvlDNFgsuWGL1tkzYrcZJfJtUPykg
 F7fNM6Pz78B5j68XnV0yfgy/st/6TCiOUsN4NQgxCWqvuK6aA2zmmGcZa6xfkVP6mqwAAAA==
X-Change-ID: 20250218-nfsd-callback-f723b8498c78
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2116; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=C5p/ojW3QfHFyvcxVtc9cHreBC7v/KQwFhn3nzGhpEk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnt1yZ6kX4I9MSfm+jtr2Ija35JdQx9LrKP4IuD
 gg38AGdRLOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7dcmQAKCRAADmhBGVaC
 FQRwEADPhXqfHOWJH4PaK6HRJCcfOPYMiY+S9T4vJScKVFrns5+qirVozTX6Vn2+O2V7xyhu0LU
 qBLJYlmoWNk2xLl7GaQIj8k1yFOXHDa6+InP4qgwaVHOp6g0gyAWHZMOIgjMub9vhdFU2Maky4/
 W1TC31NiZS60Oguwb66tvCzNrw1HFhqCBUYGjwK+ZOP5wfRTgAFlLvvVnkr+hPERpFyEYHdK+hr
 pIn/pmWSBFbQdXMUTFFeYNO38AfM0BkRMUr0rEdlrMTxbmUEEs/TqtSTWCmNws8sVfjD/cB3UXb
 dOSoqQpWkWoNvt26eFdBgaP3Ymi9ieIso2WwwfpUzJVcZAv1YDkujS3czIClhIIlvIiPqP9sSVI
 j/YRN02VcXXJH9pXDJ6imxb6Rk8oV9WSTGTGiyfM0WdqjB+VXH2SAKrSOd5+pitzpCtv9egQsLA
 iWm5BPZEd1p5uoKTLJQ9oBMy69HBZt2G0WcIYlRSo+uY65T9UfWTU/7xysDR3uX6AiagsX/AatQ
 S4WinM3aAZL5VDMGtHn4K9siw8gfPjoILsZ0otD4SHuqITDWXjfGQ6SYIz8dtEk5O5bgozS2E2w
 1VSda0Vl/KtnzgNuHIwoN3juJSPhPraru+yhHR+lS5DWvk0sjjlFS78eErxNzOsjvVcAkzbYUsB
 Sn4jAbK4XUwSOtQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

While looking at the problem that Li Lingfeng reported [1] around
callback queueing failures, I noticed that there were potential
scenarios where the callback workqueue jobs could run concurrently with
an rpc_task. Since they touch some of the same fields, this is incorrect
at best and potentially dangerous.

This patchset adds a new mechanism for ensuring that the same
nfsd4_callback can't run concurrently with itself, regardless of where
it is in its execution. This also gives us a more sure mechanism for
handling the places where we need to take and hold a reference on an
object while the callback is running.

This should also fix the problem that Li Lingfeng reported, since
queueing the work from nfsd4_cb_release() should never fail. Note that
their earlier patch (fdf5c9413ea) should be dropped from nfsd-testing
before this will apply cleanly.

[1]: https://lore.kernel.org/linux-nfs/20250218135423.1487309-1-lilingfeng3@huawei.com/

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- added patche to handle rpc_call_async() errors
- rename NFSD4_CALLBACK_RESTART to NFSD4_CALLBACK_REQUEUE
- add patch to replace CB_GETATTR_BUSY with NFSD4_CALLBACK_REQUEUE
- Link to v1: https://lore.kernel.org/r/20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org

---
Jeff Layton (5):
      nfsd: prevent callback tasks running concurrently
      nfsd: eliminate cl_ra_cblist and NFSD4_CLIENT_CB_RECALL_ANY
      nfsd: replace CB_GETATTR_BUSY with NFSD4_CALLBACK_RUNNING
      nfsd: move cb_need_restart flag into cb_flags
      nfsd: handle errors from rpc_call_async()

 fs/nfsd/nfs4callback.c | 26 +++++++++++++++++---------
 fs/nfsd/nfs4layouts.c  |  7 ++++---
 fs/nfsd/nfs4proc.c     |  2 +-
 fs/nfsd/nfs4state.c    | 31 ++++++++++++++-----------------
 fs/nfsd/state.h        | 18 +++++++++++-------
 fs/nfsd/trace.h        |  2 +-
 6 files changed, 48 insertions(+), 38 deletions(-)
---
base-commit: b7e85fd7c8964e31f8fa1cf7333b12f442b642f1
change-id: 20250218-nfsd-callback-f723b8498c78

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


