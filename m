Return-Path: <linux-nfs+bounces-22189-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Hq0BYTeHWpsfQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22189-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 21:33:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809AC624AED
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 21:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D0D730591E1
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBF0379EE7;
	Mon,  1 Jun 2026 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QApBbHXp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776D935C1BD;
	Mon,  1 Jun 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342311; cv=none; b=sHbPWU+no4rtGs+3nobywwbMb7Ds0Pqfa6FIC4Hu/Bd4iZDiBrv/IGvGi0WHv/dQIQ6k8za9+udtGjMpEYuq+X4VEcIg8OojB7sB2A/G01KmVnOH22/QTVChRY5JtC5new+5C3zCICUbx/UkC6il9d5xb3eF4zNnQOLmVv0SbNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342311; c=relaxed/simple;
	bh=FtN11HLx3XZ2GtKwwdBVfYbx8Tsd6UnyDJMlDS6MhEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pW0X9PGTkSL9QZ4DhcUuECpGdhLFSjBPDIyUkXUzWX+Co9s2nrepVbJb9RK1xo02IrmAwg0xlf1nQT+BLht/sOjYUuATm3ImV/dUuqZSGFHhbvq/k/MZLexBT3WFx38OOyA4uxHRXANWq426qd0NvvHIN3Xoo/DlsPy92AYjwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QApBbHXp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8qyfP8rJskJrqJHWVgOtlr4br9uqr2ONGpCMnVyuRtg=; b=QApBbHXpPVDUNziVxuwce7NUMg
	Sqs/UE84QyfNixaR9E1wSkkeo28T6tE/znkajzniJ1QEtoIHk9bcf0fpWfMKW/Vgb9NK6a2bnNEDI
	rM1TshTH/14dr84icyM/S4RXG9ksToPczkzF/6IzSYcbcRM76YOM5o8b8aZ1PTGjFNZ+ZT86sTqwJ
	5H8F5wwN2bxmMvWBCZTCcUouqOCVq4Uj8Lx/UO77eViSutXduQU+G3I5jT7ywOKPSOnlGgzMLnk4/
	UgZ2/Q7gDOvRaqIeu3dmmK1Im++8vbZjIvCFiE3gP59H0R6oDD0CmnAYT/y77fv24wPtVUagDa3zJ
	aLaHm93g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wU8MN-00000003rCc-1mRq;
	Mon, 01 Jun 2026 19:31:39 +0000
Date: Mon, 1 Jun 2026 20:31:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	David Howells <dhowells@redhat.com>,
	Rick Macklem <rmacklem@uoguelph.ca>, Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] nfsd: release path refs on follow_down() error
Message-ID: <20260601193139.GK2636677@ZenIV>
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
 <20260531-nfsd-testing-v1-2-7bfa481b0540@kernel.org>
 <20260601184715.GJ2636677@ZenIV>
 <8080069f52abd6d6c6dc199c52e6b14e961f3cc8.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8080069f52abd6d6c6dc199c52e6b14e961f3cc8.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22189-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 809AC624AED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 02:57:16PM -0400, Jeff Layton wrote:

> Looks reasonable. Chuck has already taken this patch into his tree, but
> we could do a cleanup on top. Want to send us an "official" patch?

Not a problem, but it's completely untested.  It compiles, but...

unify cleanups in nfsd_cross_mnt() exits

Instead of having a separate path_put() on each failure exit, as well as
on the normal path, let's move all of those past the point where these
codepaths join.  We want to keep the ordering between path_put() and
exp_put(), so move that one as well.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 95ce15440492..cfac0cc4207c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -137,20 +137,19 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		follow_flags = LOOKUP_AUTOMOUNT;
 
 	err = follow_down(&path, follow_flags);
-	if (err < 0) {
-		path_put(&path);
+	if (err < 0)
 		goto out;
-	}
+
 	if (path.mnt == exp->ex_path.mnt && path.dentry == dentry &&
 	    nfsd_mountpoint(dentry, exp) == 2) {
 		/* This is only a mountpoint in some other namespace */
-		path_put(&path);
 		goto out;
 	}
 
 	exp2 = rqst_exp_get_by_name(rqstp, &path);
 	if (IS_ERR(exp2)) {
 		err = PTR_ERR(exp2);
+		exp2 = NULL;
 		/*
 		 * We normally allow NFS clients to continue
 		 * "underneath" a mountpoint that is not exported.
@@ -160,10 +159,7 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		 */
 		if (err == -ENOENT && !(exp->ex_flags & NFSEXP_V4ROOT))
 			err = 0;
-		path_put(&path);
-		goto out;
-	}
-	if (nfsd_v4client(rqstp) ||
+	} else if (nfsd_v4client(rqstp) ||
 		(exp->ex_flags & NFSEXP_CROSSMOUNT) || EX_NOHIDE(exp2)) {
 		/* successfully crossed mount point */
 		/*
@@ -177,9 +173,10 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
 		*expp = exp2;
 		exp2 = exp;
 	}
-	path_put(&path);
-	exp_put(exp2);
 out:
+	path_put(&path);
+	if (exp2)
+		exp_put(exp2);
 	return err;
 }
 

