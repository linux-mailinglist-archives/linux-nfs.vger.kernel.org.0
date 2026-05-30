Return-Path: <linux-nfs+bounces-22106-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIlROcLkGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22106-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:23:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6273960CF40
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 367A1308AD7B
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713723CA4B9;
	Sat, 30 May 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9ELSfSy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576113C9ECF;
	Sat, 30 May 2026 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147186; cv=none; b=eB2vw0OpJumc49KLJPXaW9fKLpUnbziprZC1CkP7NaKOpYYblfDaiQz63sdiaywa7/pSSlb/de6h3Zdvze3hihWHYUNCT0Pmd9/twZkQ6KnSBVTJuF6QNpgigMP3yLe7eN76wpU9YgG3fhjE0/p+4LYtJTUSqibiQASz1HtjDk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147186; c=relaxed/simple;
	bh=NbRlfS2hKj/KAZsTryBykM3B03U4/PXef6fILxnBTP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gvbdmpZOaoeBPHQuWTVicF6nNyzTrIPvNIhn7sEga87Xj2Zuk6zm9neNUuaMe695h7YL5aIWJ63gfpLTrW4nJCPgHxdV6+kT8rbPt9GutQ0VFEwV1CxB9fVra2bM9QnFenPAI9S1nFc5hP3XKhSPXuFCTO4q+uXCVNnvgDIbIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9ELSfSy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62271F0089A;
	Sat, 30 May 2026 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147185;
	bh=pM0Cde0iN0QU5Gn0jKc8lGq+Fi5zQvJL/t7Pg3WNv+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f9ELSfSyy5bz0IC4KE7vd5MS3jzGjbwa7Smq88HI5ytLl/UUT5C9Sakc+HihRJ2Gh
	 wQJB+P+v6i7He7Pg0wJmUNLL9dxZHfGv1K0/qkDoHIBVi+0YoY1h6Jz4d+i0eZkIFj
	 UVwG3LszHXJAnT0AKrTHVMuCAVtWTJyMjhvlTTcUAmMqqI/7qWQ1kXiptHvweusB8/
	 1cCW9W7jHZkpz4dAAYVTNQfklKH/lRPxHc94vadX9ZZ8k82+aUl1DJuAWD1DavxYDt
	 VsaTttybHrb59uj9WJscSzpw2vHOVOiUjWW1Fz+oH49XaRpu7ySfuwbk5pyJEipNAr
	 UBzgcgTWGkVtQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:24 -0400
Subject: [PATCH v2 8/9] nfsd: cap decoded POSIX ACL count to bound sort
 cost
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-nfsd-fixes-v2-8-f27e8eb4d974@kernel.org>
References: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
In-Reply-To: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2297; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=V05w/EewdcZtlzm9cb8T88Z3VDzp6smQDgz+JVDOueY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPiH7lDADAHTadcmL9VEGOOl9xG0vvceCxys
 8OrCjvybtqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj4gAKCRAADmhBGVaC
 FdYkD/9FkeeQiY+HHTlfVb48/pzdFSkrDYE5+OD7zqJuiUiMp+/RbaDwC8kfssbc6bYj3Yn6VWm
 CFX92W/c5rpJMH2Ndh4/1FqnOvfkl5FV+tkjw1xIpiclOEps8q5Qf2mgjlB3rDjnu+/D3Z9xWNA
 MKy4ofctNa1p3XdR1TAsYaacbTfBG8jUdvTr/Lsis8aAO0eV5YkmmJzxHY5mLqhR6okIknb1yTE
 q4RkamSkV/QnG75+sxuc8XESGIcRCfyA2Nr9Xf2BoMK+GKON7HDFnV0fvgC31KBiuyi5hoM4VcM
 xvmhDz8G3y0jTcmTO8ZPlswQ4TpWFirgWHt689XTD/uiaXAKfUn+iwSw7UeIE2LrexBIIXU+wX2
 pdzE4N7lR5T5AVXyUb/nwOQDf+U+Qny9CzHXut950v0WGHHUooRdOd8SJLJOqiCBVTMBLRz4dNh
 pn43ICOebQXYsMqcxMqzCgIotxANXcuHyJBYT3RsGB7DFqxzdH1fg3FUq1nO3kcVSX9YrGfzS1l
 BA/VfH6MGz5yMEhGCEQ6q9lPvAtMRa0u67AGS2fpOo9q5d8QjWcV47014zo4fWQjXgD7BV00NBU
 J9I44IquI8FzF1EorfNULepAYxD2kGng5eaDvlGLH/4kugZHIkPIC7h2qFOgw3os0vs76kftVbY
 h7VrycLiUMx7rWg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22106-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:email]
X-Rspamd-Queue-Id: 6273960CF40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd4_decode_posixacl() reads a u32 entry count off the wire and passes
it straight to posix_acl_alloc() and sort_pacl_range(). The latter is
an O(n^2) bubble sort, so a client-chosen count drives unbounded CPU in
the server's compound processing path.

    nfsd4_decode_posixacl()
      xdr_stream_decode_u32(&count)       /* uncapped u32 */
      posix_acl_alloc(count, GFP_KERNEL)
      sort_pacl_range(*acl, 0, count - 1) /* O(n^2) bubble sort */

The encoder side in the same file already rejects ACLs whose a_count
exceeds NFS_ACL_MAX_ENTRIES, but the decoder introduced in commit
5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
omitted the symmetric check.

Fix by rejecting a wire count greater than NFS_ACL_MAX_ENTRIES with
nfserr_inval, before any allocation, so the sort is bounded by
NFS_ACL_MAX_ENTRIES^2 comparisons.

While we're in here, also fix the nfserr_resource return if
posix_acl_alloc() fails. That's not a legal error code for v4.1+. Change
it to return nfserr_jukebox as that's more appropriate for memory
allocation failures.

Fixes: 5fc51dfc2eb1 ("NFSD: Add support for XDR decoding POSIX draft ACLs")
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/nfs4xdr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index c6c50c376b23..508f6986842f 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -449,9 +449,18 @@ nfsd4_decode_posixacl(struct nfsd4_compoundargs *argp, struct posix_acl **acl)
 	if (xdr_stream_decode_u32(argp->xdr, &count) < 0)
 		return nfserr_bad_xdr;
 
+	/*
+	 * The NFSv4 POSIX ACL draft doesn't define a max number of ACE's, but
+	 * the NFSACL spec does. For NFSv4, cap the number of entries to the v3
+	 * limit, as we want to ensure that ACLs set via NFSv4 POSIX ACL
+	 * extensions are retrievable via NFSACL.
+	 */
+	if (count > NFS_ACL_MAX_ENTRIES)
+		return nfserr_inval;
+
 	*acl = posix_acl_alloc(count, GFP_KERNEL);
 	if (*acl == NULL)
-		return nfserr_resource;
+		return nfserr_jukebox;
 
 	(*acl)->a_count = count;
 	for (ace = (*acl)->a_entries; ace < (*acl)->a_entries + count; ace++) {

-- 
2.54.0


