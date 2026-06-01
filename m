Return-Path: <linux-nfs+bounces-22187-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJMEGIjWHWptfQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22187-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 20:59:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B64BD6245B6
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 20:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 443DD3004211
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C2435677E;
	Mon,  1 Jun 2026 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tykIP5KY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345A534A797;
	Mon,  1 Jun 2026 18:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339647; cv=none; b=q9kAuMkkiOlkiwiBOE9JTsbp6ixtxBK6SskkK22UfEQTHLdCCRThr0guGdgRhidB4tnHZPvYt/JCEDi8GR2N2gCfMWbbsfepgx6G3TzLlp7a2COkNdko7IcZkw2bnuY+z5OkpoR2l/MmBjSHziylJIU1qmO5tGja0p69WNmOM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339647; c=relaxed/simple;
	bh=20T54J+jQNZmADsMBseHhaKW95Pi0I49+HpNkopXDLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQzdCkNRv0+NeszdXI/sE7DVJvg1+v7py2fCQYw451FAA13vwBubvLlLHglHDGFn1Ik5U/c6O2imkhlsnxlcxkauz33JEpB4NdsfUlbBcxOt80FrjzXY9WIaabIf3mZx8Ebf1p1VgDENs1GPJrhLjFSOl66jYVM2tlXD5pInMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tykIP5KY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ctY67JM/7uBpWvM3JS0gHoDy69jmoh0iHIjO+3IZLzg=; b=tykIP5KYQhl6VIUGWUMnd+bOl5
	1j0tHikqu0mpGA3jGQbLV0AQ/AqwKhjWslyTGR//ulV4olwtqa+YKwqPNnNHmBXV3wFes96gw4ghb
	oIkdklRjnyf4u9KFmkpaIyrPFG4SH1FCy6N24On90Ek8Cwg0yFNnudynnOncXFnWxPsDASfFocYPD
	OwK8VFOdUsQexCj/kem0Sn5tsINcYUfFUX+wRrEvO9eMO+WYYoYl6C4MbFuuIJz46v0Bl0WtIbglk
	mt55Vd13rHZTxW6QSwFqPQXa4OchwYFs1oR3R7MCUZ+9akEKS/0zQ+/bHPUGA5aIEZSR3coj8YCoJ
	3RPgNReQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wU7fP-00000003g9c-0db1;
	Mon, 01 Jun 2026 18:47:16 +0000
Date: Mon, 1 Jun 2026 19:47:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	David Howells <dhowells@redhat.com>,
	Rick Macklem <rmacklem@uoguelph.ca>, Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] nfsd: release path refs on follow_down() error
Message-ID: <20260601184715.GJ2636677@ZenIV>
References: <20260531-nfsd-testing-v1-0-7bfa481b0540@kernel.org>
 <20260531-nfsd-testing-v1-2-7bfa481b0540@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260531-nfsd-testing-v1-2-7bfa481b0540@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22187-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.org.uk:dkim]
X-Rspamd-Queue-Id: B64BD6245B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 08:06:59AM -0400, Jeff Layton wrote:


> Fix by calling path_put(&path) before the goto out in the err < 0
> arm so the entry-time refs are released on all follow_down() error
> returns.

Might be better to unify all those path_put()...  Something like this,
perhaps?

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eafdf7b7890f..bdcd78f49112 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -141,13 +141,13 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
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
@@ -157,10 +157,7 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
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
@@ -174,9 +171,10 @@ nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
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
 

