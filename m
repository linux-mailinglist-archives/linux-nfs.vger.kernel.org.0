Return-Path: <linux-nfs+bounces-16654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC8C7C094
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 01:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD273A65F0
	for <lists+linux-nfs@lfdr.de>; Sat, 22 Nov 2025 00:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8951623D2AB;
	Sat, 22 Nov 2025 00:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="EY6Pyy1b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="okB+BzfW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E461314A91
	for <linux-nfs@vger.kernel.org>; Sat, 22 Nov 2025 00:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763772790; cv=none; b=AYSahD/gzzUx8e0OJJJEgF2INQThmLYHRbD3XwHSz34mJhtqW04xEiMt9kAO2lSv1RyeXXLuceU4s//U4fhVU+8FRN7VWSJe9WBrf/lYNjUfmDz6ItjNj/sabFaLc9D+qKuZCidWgA7TcHDI6mBUOItczLw2tNw4hDIQ5TbEic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763772790; c=relaxed/simple;
	bh=lhQB5Ygipun+My+LgxomZ4MWJKJFzKEoxGXh5/yvVwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOkZH15FhFiXle1uj8R6xSeXdTk4CsH79WwVIARLBrosmVthcsQZ1ppFnpK3g6eQv1VguMZ97daqjceux/mHarJWSAhSgVlIjlIlSC20dsgT2scDtlB7Tm842p11JFEiqsN0sBbHfjUCGQKzXtZtYCfJALmbIlp5+apTvO7tKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=EY6Pyy1b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=okB+BzfW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EFF6140009C;
	Fri, 21 Nov 2025 19:53:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 21 Nov 2025 19:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1763772788;
	 x=1763859188; bh=2AcaNVwXudbl7FEdSWWRNFTG40HTo8nhhRSEBXA8GYs=; b=
	EY6Pyy1bSWXOnMwTlT5b3y4++59crdvmACvZto/CLym1TOsDvNGb71qw3jM4wYKc
	hNYDd1rCDUONXV/5JZt21ACz+ww2PmJ7/6Cv3BrwKZPipEYltt904L3TEbg04eF+
	p7v63Nb057KrDzL8q+Gb/mG6YZEKQ35JiDUviizMknASrnFtpDDMVD5i1QTgyZ21
	nS7lqAruriHSPWz49v1d/3qDKF+UOzIRFWEcIHS47oC/z4qpEITjSxtsUQGAyX06
	FuzxCXxWJaL4/dpr0AtHiP9JnKWKQ3QajvtvQ9yn6ZO3VRxWD56GyLIMCBogGiH3
	K3sN1Y1N6U2gfy84bMqJWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1763772788; x=1763859188; bh=2
	AcaNVwXudbl7FEdSWWRNFTG40HTo8nhhRSEBXA8GYs=; b=okB+BzfWqAe4qzFz+
	1BfzEJUnGhW1jssocTKjZItcTeLLRGjsmuq3BH9HOeJtE2jXokzX1ToWfn125F8l
	Uslal0uujeu3596iYhocBCDBIzqlXfRfaILU3siDt5jpllsKq/cX/DK3bqNPk056
	0blxVFSuUfsuwhCqnRYt2sKCw3rZUmqR4/EzCgdnpX15qVU8tAmbUGEAFZSsoukw
	71kzNdC2R+oXZ77derPRZfXF+rRWPqgl62doySjfax/6948frMlEK4GthxvZVijA
	tlpOFYSWLRtWQN43bNKm3t6LpdNARr9H4TbVHnmAKFbXcIU/YihRmEFy6IoJKoXs
	k4UhQ==
X-ME-Sender: <xms:cwkhabHuvkMEYNf-_mVT9cuF4rg-XjnKNaY2D76EVY6nFr7lKH6myQ>
    <xme:cwkhaQwCrjSJtwsRAGU-1g8w2bRVOIRp6UO9NaCN_ahODxziiFa17BQ91RaoEnt3R
    LHnkBVRT55X1UKLEoNQCEt7DYBpnogWlnGAhiEKyG535a2hDA>
X-ME-Received: <xmr:cwkhadkW6_Ls1sKeUbvDRSquJlFZ5vd90VZdavhWLdQiYOk_tqUdNXrRpGcyD47AF2uJr504_SGO8ScXhCPMzTG6h0G9B9nJf1LClfuEe2ZW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cwkhaZl_IUl01NrV8mE8a4bcnk4IR5XU4Umv3Af6JMBjg7D92hPCTw>
    <xmx:cwkhafzoIhqlzU0RKpzeAQv8S2CLGGKgkaq4_DEwd7aDsh6qBhI6EQ>
    <xmx:cwkhaeoRiNzQoBvUWnCTUabmXAgE9uqiAeK6pJ8Ovsq3jWbLinTCOA>
    <xmx:cwkhae7gjZToMuHaR2m5R_uaxkcM6fUCNFAu5TVo3zWTSdefhYtVdQ>
    <xmx:dAkhaURJajRz38XM2an8BNPdExgZivUQankIC2ucNaMnXAt6kgfkhPDl>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 19:53:05 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v6 05/14] nfsd: report correct error for attempt to use foreign filehandle
Date: Sat, 22 Nov 2025 11:47:03 +1100
Message-ID: <20251122005236.3440177-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251122005236.3440177-1-neilb@ownmail.net>
References: <20251122005236.3440177-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

A COMPOUND with
   SEQUENCE
   PUTFH foreign filehandle
   SAVFH
   RESTOREFH
   some-op-that-uses-current_fh
   COPY

will report NFS4ERR_NOHANDLE for that 5th op as ALLOWED_WITHOUT_LOCAL_FH
is not set and ->fh_dentry is NULL.  However that error is not correct.
NFS4ERR_STALE or NFS4ERR_BADHANDLE would be the correct error.

This patch saves the correct error and reports it when appropriate.

It is highly unlikely that a client would ever notice this difference as
the COMPOUND that would produce it is bizarre.  Maybe we don't need this
patch.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/nfs4proc.c | 4 +++-
 fs/nfsd/xdr4.h     | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index ae34b816371c..bd7ba5df07a7 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -720,6 +720,7 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			 * server is running a different NFS implementation,
 			 * NFS4ERR_BADHANDLE is a likely error.
 			 */
+			cstate->saved_status = ret;
 			ret = 0;
 		}
 	}
@@ -2865,6 +2866,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	resp->tag = args->tag;
 	resp->rqstp = rqstp;
 	cstate->minorversion = args->minorversion;
+	cstate->saved_status = nfserr_nofilehandle;
 	fh_init(current_fh, NFS4_FHSIZE);
 	fh_init(save_fh, NFS4_FHSIZE);
 	/*
@@ -2916,7 +2918,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 		}
 		if (!current_fh->fh_dentry) {
 			if (!(op->opdesc->op_flags & ALLOWED_WITHOUT_LOCAL_FH)) {
-				op->status = nfserr_nofilehandle;
+				op->status = cstate->saved_status;
 				goto encode_op;
 			}
 		} else if (current_fh->fh_export->ex_fslocs.migrated &&
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index cf2355ceb1ff..b5ec2cdd61a0 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -187,10 +187,11 @@ struct nfsd4_compound_state {
 	struct nfsd4_session	*session;
 	struct nfsd4_slot	*slot;
 	int			data_offset;
-	bool                    spo_must_allowed;
+	bool			spo_must_allowed;
 	size_t			iovlen;
 	u32			minorversion;
 	__be32			status;
+	__be32			saved_status;
 	stateid_t	current_stateid;
 	stateid_t	save_stateid;
 	/* to indicate current and saved state id presents */
-- 
2.50.0.107.gf914562f5916.dirty


