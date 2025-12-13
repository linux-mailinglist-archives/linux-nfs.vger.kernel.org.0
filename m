Return-Path: <linux-nfs+bounces-17068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4237CCBA385
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 03:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FE8F30170E6
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 02:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D982EFDB2;
	Sat, 13 Dec 2025 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKLacHMU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E2C2ECE9B;
	Sat, 13 Dec 2025 02:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765594415; cv=none; b=dOO+umi5ljlOrT0/xU3kS42Zuwzse+OiHBMCEtxbahbH++3kOA3KAR8cCS/y1jMXMhRO989mWiI4VLXMiVlSGM7t75Jwnu0JOB51YhE+IV7T8zC+poXFzWBkP3kp9p3aXRPHiTE/eQTvn74R4+h0P+RbFvgA8q0iRlLs066aUNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765594415; c=relaxed/simple;
	bh=YZBKqehDM05OI+wzUkbxGNac+Z/5rqR7JJV9R5qY3zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pwSRFRO9XpD+S1xiFYMb8X0pcPhFG3dzwtCZHYvtn68GCxOcodpx9JJ3QmVLC4niiOIPsGKbsDm8J2fMnCYssIE5r4/W+/MVmmAMcnDJGuAAUCNAiNtG9METHowHvqCvlyl2qnsfeS+Nl+Q/GND+wQBQHBQLp6HtksIZ+xB8PHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKLacHMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BDBC4CEF1;
	Sat, 13 Dec 2025 02:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765594415;
	bh=YZBKqehDM05OI+wzUkbxGNac+Z/5rqR7JJV9R5qY3zw=;
	h=From:Date:Subject:To:Cc:From;
	b=FKLacHMUjcPF0gkHcfyZKvMNywk1JHg8gN7DvS0Io0GJvpks5RATHKxt5XI4r0qu6
	 QkiEsbWmEd0Hj0hrUAew6AFcp2Wt48JNeb8zxcMfpTAswEVinn/N7IfZyT8FP4vUYE
	 5W3vJz43DG0hNxUKhTlO1/nuWXDLPhrBRvHyXmcrANGyIdRWFEkNDYUaoa5+AfPCmk
	 8OtW/ZbRvaTfJtMGZ1J5QSJjmgMkI00i3XmSdqlcmhjzkwcL4eCoTSFR3YX7Q3mccX
	 3nWtEK8qg/OqZp93Y2QEmbyPONo4AqVcD3m7icKpvu9WwOrfaCrfAN45oJKvKtVod6
	 7Zq6wnWNS0VDQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 13 Dec 2025 11:53:17 +0900
Subject: [PATCH] nfsd: fix nfs4_file refcount leak in nfsd_get_dir_deleg()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251213-nfsd-6-19-v1-1-8af64b59c14e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Nj3by04hRdM11DS92kREuLZFOjZHPzlEQloPqCotS0zAqwWdGxtbU
 AGr1aUFsAAAA=
X-Change-ID: 20251213-nfsd-6-19-ba98c52c77da
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Christian Brauner <brauner@kernel.org>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YZBKqehDM05OI+wzUkbxGNac+Z/5rqR7JJV9R5qY3zw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpPNUsg9PNCmEapQfLZ+Ny6Hb3OJdA+ZRqO2Y15
 4ziFpOSxIeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTzVLAAKCRAADmhBGVaC
 FRHUEACFgat6eIkyhxbgrmGz4O/DJm8UiuF4sInp77XAxdpWkIF48GsDfYPyzWefXferQd4LYDT
 c1BMe7hoNuQncL8634UidboS2x1HhznSHlulhW8fNWD+bMud3sSphLIJPEn/RZlVw63kbhPZL4/
 8ENjnQpS+5sei7TxxsGMMLZxQRe6pyANrzNXzzl5Md6GsUt5PMllHXFQ3tTgXjG3ETzadSv+LUP
 MvGYQ4gAXsvnqwFMZdOTVuK5AaImNM771JlVZGjFFla62lSs5wywb9DKdDZicGiGWI6aoKUav0Q
 EnCKBhYJfpyYVUu+iqLeYUBIMt8whYtqWFYs5YCO+KVxmFMpanCWwKY2idRew+rY1KkT8a+G1Cm
 EGxO9ewESEQ4/TRqL4PBMffsHR9rQpM5Xy2c2ST6+kOad73wI3zIppbCsl7ptAIZFt34KmlXBME
 zEpY6b07RA2Fg7zQCIj+9RWPrKpTLqeTKncwuTTHVx0bHiPkft37NcR4XBaRKR5rBV1Mgt5bj8K
 n0k/1YVjdyWc3hy5gwnsWWWtPiL6tBMDQ1YI1HZh+XedN+F8K32lUL7mh9QuEMh5Q/misVey5dn
 K5Il3NmbQVushQdKfAJRZBMxZdCQA+m7pOGi6Vl7GC5EE5xHrP9YpOmHVC2TX3ozlNYAyPXK1IQ
 WfxANLyMs39+HEA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Claude pointed out that there is nfs4_file refcount leak in
nfsd_get_dir_deleg(). Ensure that the reference to "fp" is released
before returning.

Cc: Chris Mason <clm@meta.com>
Fixes: 8b99f6a8c116 ("nfsd: wire up GET_DIR_DELEGATION handling")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 808c24fb5c9a0b432d3271c051b409fcb75970cd..90d355af1a21e6cab14fc1178f249c9716aef441 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9456,8 +9456,10 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	spin_unlock(&clp->cl_lock);
 	spin_unlock(&state_lock);
 
-	if (!status)
+	if (!status) {
+		put_nfs4_file(fp);
 		return dp;
+	}
 
 	/* Something failed. Drop the lease and clean up the stid */
 	kernel_setlease(fp->fi_deleg_file->nf_file, F_UNLCK, NULL, (void **)&dp);
@@ -9465,5 +9467,6 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 	nfs4_put_stid(&dp->dl_stid);
 out_delegees:
 	put_deleg_file(fp);
+	put_nfs4_file(fp);
 	return ERR_PTR(status);
 }

---
base-commit: 187d0801404f415f22c0b31531982c7ea97fa341
change-id: 20251213-nfsd-6-19-ba98c52c77da

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


