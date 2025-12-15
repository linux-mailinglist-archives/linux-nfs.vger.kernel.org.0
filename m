Return-Path: <linux-nfs+bounces-17091-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4939BCBC28F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 01:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52213300ACDB
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Dec 2025 00:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47EF2FD68F;
	Mon, 15 Dec 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjBtJHE+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BAA2FD684;
	Mon, 15 Dec 2025 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765759322; cv=none; b=a62c97pY77e5ML74tImUzTkrmane1WQYhdIDHYIYAkn6MOyBS23ECKRVDcIiUIcWhBBzmJ9ZWZ8NCt5NLa7BGssjKJ1w2/hLo+77ZJxNEbmXVAnNrhKMrrEzriL5rQgr+bUW366lss9WfTr7ReAzSDga9+oFZ5A7ofwG4acogGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765759322; c=relaxed/simple;
	bh=ePrQEDJTjFPMk1FBBpabiX+sqdPJ/KVdv7MxbTCpqRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kMan7ziq7LxPYPaHkZIjLVoRbxnxq7cxFT6xi9XQypkNSq8MnsnA+9t7szi92fKDfE/xSQPPbvjLClclwuusYxcQp/7nmH+Fv2+fbeVgbZ9blM4gy+4S9iYMPFxZuEfL0oyp/3iBYH3jM3o+fN9SvkQtwrtdNkacgAWPLVJoMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjBtJHE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA85C4CEFB;
	Mon, 15 Dec 2025 00:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765759322;
	bh=ePrQEDJTjFPMk1FBBpabiX+sqdPJ/KVdv7MxbTCpqRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KjBtJHE+rI0TNkEPZ/D6rwcWmVVahE86VROPLC1MlHa2nAc1Q/n44WxB9n4+EiIOH
	 ZSlZyUzWRTEuBsBF0aWSXak2R50hPdD3ei9Loz+WEK9TukTdmAxQAV6yWjhaWUUIoS
	 Y4FtaJexhADr/aJLOn1JQioTErJw+OHN5JyL5fhMOv7SCllIXthFK/CtvgKElCB0qL
	 xkqBg253jgdoFHqskS4yznv56PyxDCeoe2Apu5+FpOSVlvR/0h5Ah1hpNF9rSgPn5X
	 9hgWoMn2ugDrP4SQtW27fwH+Mpi9AlIVSX+j3+zE2DU0Wg7TkCHg7aOmNgpgjT81oc
	 ofwjtWgip/HKg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] NFS: Fix up the automount fs_context to use the correct cred
Date: Sun, 14 Dec 2025 19:41:24 -0500
Message-ID: <20251215004145.2760442-7-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251215004145.2760442-1-sashal@kernel.org>
References: <20251215004145.2760442-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit a2a8fc27dd668e7562b5326b5ed2f1604cb1e2e9 ]

When automounting, the fs_context should be fixed up to use the cred
from the parent filesystem, since the operation is just extending the
namespace. Authorisation to enter that namespace will already have been
provided by the preceding lookup.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## NFS Automount Credential Fix Analysis

### Commit Overview
This commit fixes a credential handling bug in NFS automount operations.
When automounting (crossing a mountpoint boundary within an NFS export),
the filesystem context should inherit credentials from the parent
filesystem rather than using potentially incorrect default credentials.

### Code Change Analysis

The change adds 4 lines to `nfs_d_automount()` in `fs/nfs/namespace.c`:

```c
if (fc->cred != server->cred) {
    put_cred(fc->cred);
    fc->cred = get_cred(server->cred);
}
```

**Technical mechanism:**
- When `fs_context_for_submount()` creates a new fs_context, it may not
  inherit the proper credentials from the parent NFS mount
- The fix explicitly checks if the credentials differ and replaces them
  with the parent server's credentials
- This follows proper reference counting: `put_cred()` releases the old
  reference, `get_cred()` acquires a new reference to the server's
  credentials

**Pattern consistency:**
The fix follows an identical pattern already present in the same
function for network namespace handling:
```c
if (fc->net_ns != client->cl_net) {
    put_net(fc->net_ns);
    fc->net_ns = get_net(client->cl_net);
}
```

This demonstrates the code is consistent with existing practices and is
obviously correct.

### Bug Impact

**Without this fix:**
- Automounted NFS submounts could use wrong credentials (likely task
  credentials instead of mount credentials)
- This can cause authorization failures or inconsistent access behavior
- Users may experience permission denied errors when traversing NFS
  automounts
- Potential security implications with credential mismatch

**User scenarios affected:**
- Enterprise NFS deployments with automount configurations
- Users crossing mountpoints within NFS exports
- Any NFS setup using submounts/referrals

### Stable Kernel Criteria Assessment

| Criteria | Assessment |
|----------|------------|
| Obviously correct | ✅ Follows existing pattern, proper refcounting |
| Fixes real bug | ✅ Credential mismatch in automount |
| Important issue | ✅ Authentication/authorization affects NFS usability
|
| Small and contained | ✅ 4 lines in single function |
| No new features | ✅ Bug fix only |
| Clean backport | ✅ Localized change |

### Risk Assessment

**Low risk:**
- Change is minimal (4 lines)
- Follows existing code pattern exactly
- Author is Trond Myklebust, the NFS maintainer
- Proper reference counting used
- No new APIs or behavioral changes
- Isolated to automount path

**No dependencies identified:**
- Uses standard NFS server structure fields (`server->cred`)
- Uses standard fs_context fields (`fc->cred`)
- These structures have existed for years in stable kernels

### Author Credibility

Trond Myklebust is the long-time NFS maintainer and this is core NFS
code within his area of expertise. This adds significant confidence to
the fix's correctness.

### Conclusion

This is a clear, straightforward bug fix for NFS automount credential
handling:
- Surgically small (4 lines)
- Fixes a real functional bug affecting NFS users
- Follows existing patterns in the same function
- Written by the NFS maintainer
- Low regression risk
- No new features or API changes

The fix ensures proper credential propagation during NFS automount
operations, which is critical for correct authorization behavior. This
is exactly the type of small, contained bug fix that stable trees are
designed to accept.

**YES**

 fs/nfs/namespace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 5a4d193da1a98..30430eaa77b08 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -169,6 +169,11 @@ struct vfsmount *nfs_d_automount(struct path *path)
 	if (!ctx->clone_data.fattr)
 		goto out_fc;
 
+	if (fc->cred != server->cred) {
+		put_cred(fc->cred);
+		fc->cred = get_cred(server->cred);
+	}
+
 	if (fc->net_ns != client->cl_net) {
 		put_net(fc->net_ns);
 		fc->net_ns = get_net(client->cl_net);
-- 
2.51.0


