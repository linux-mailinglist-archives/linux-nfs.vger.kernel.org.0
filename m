Return-Path: <linux-nfs+bounces-8519-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AD09EC35B
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 04:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EB328376C
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Dec 2024 03:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311196F073;
	Wed, 11 Dec 2024 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="csJ/g75g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ey6vUoFw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="csJ/g75g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ey6vUoFw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10803A8D2
	for <linux-nfs@vger.kernel.org>; Wed, 11 Dec 2024 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887946; cv=none; b=LZQedG8hOqsH8SDYSDJJVXmMgdMfGDNfb/Jifz0tfa6Hv3dGtphm0GFLZFp4LpgykzWD2gefONh842fMsZ54SLIW2pilOyWTSEt9PpqJIR+72HtgpaFr6EnA7+H1LrJMWnAfexhEPgizZOk0oMOvdJGFrb6D+ZyU2AwkhSFyhUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887946; c=relaxed/simple;
	bh=euCYwX1d83UcqG/kD4DtyH+FrcxWFGonlWFKyjeduOQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=a6qv6f3z/paf4XJUOJthK+akCv09HDw9VWZpYTcsZe0b07KUYNuOCmxoLdAsLVN71gm8i5yktd2Mrdvv19EchuGVvBggfHS+VLzLP1Xe0hEi5CyfX/nSm7FvP5aV4oOubE3tYRP4sZCFTZqlBxEqUvoFheQi2nMTzsiMxo7t8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=csJ/g75g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ey6vUoFw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=csJ/g75g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ey6vUoFw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B855C21167;
	Wed, 11 Dec 2024 03:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733887941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrHCNL31FS81x8ng3O1ss2cfdZONpho9RxDGk2EFjQM=;
	b=csJ/g75g3Jaf0Q+Xi4BPeBG0UYa/aHOmPDCPBYWzN8wb6EEKZ2r4AoU5GxPvD+lQn8p8k1
	6QXYXcu4lW5dJ+yxz3QiGbNNzXFCumQ5+T0qLM1pm1bDvMC888biZI5bXJL4g69cJm1+vj
	0FC3nqO72L453g+CdzUaBX7JBT0WxYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733887941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrHCNL31FS81x8ng3O1ss2cfdZONpho9RxDGk2EFjQM=;
	b=Ey6vUoFwAENwyYNNnsblDm8zkWu2620KqQXwxakvkVhftIOg8Z4/bXEkol1UnXVhspN1dM
	duAQCUEWI+lbgQBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="csJ/g75g";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ey6vUoFw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733887941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrHCNL31FS81x8ng3O1ss2cfdZONpho9RxDGk2EFjQM=;
	b=csJ/g75g3Jaf0Q+Xi4BPeBG0UYa/aHOmPDCPBYWzN8wb6EEKZ2r4AoU5GxPvD+lQn8p8k1
	6QXYXcu4lW5dJ+yxz3QiGbNNzXFCumQ5+T0qLM1pm1bDvMC888biZI5bXJL4g69cJm1+vj
	0FC3nqO72L453g+CdzUaBX7JBT0WxYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733887941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrHCNL31FS81x8ng3O1ss2cfdZONpho9RxDGk2EFjQM=;
	b=Ey6vUoFwAENwyYNNnsblDm8zkWu2620KqQXwxakvkVhftIOg8Z4/bXEkol1UnXVhspN1dM
	duAQCUEWI+lbgQBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A4D013695;
	Wed, 11 Dec 2024 03:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xbhaE8MHWWcWbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 11 Dec 2024 03:32:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH 6/6] nfsd: add shrinker to reduce number of slots
 allocated per session
In-reply-to: <526f9a90-6515-4208-a40d-10c5c38a5a11@oracle.com>
References: <>, <526f9a90-6515-4208-a40d-10c5c38a5a11@oracle.com>
Date: Wed, 11 Dec 2024 14:32:16 +1100
Message-id: <173388793661.1734440.6914654105982751515@noble.neil.brown.name>
X-Rspamd-Queue-Id: B855C21167
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, 11 Dec 2024, Chuck Lever wrote:
> On 12/8/24 5:43 PM, NeilBrown wrote:
> > Add a shrinker which frees unused slots and may ask the clients to use
> > fewer slots on each session.

> 
> Bisected to this patch. Sometime during the pynfs NFSv4.1 server tests,
> this list_del corruption splat is triggered:

Thanks.
This fixes it.  Do you want to squash it in, or should I resend?

Having two places that detach a session from a client seems less than
ideal.  I wonder if I should fix that.

Thanks,
NeilBrown


diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 311f67418759..3b76cfe44b45 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2425,8 +2425,12 @@ unhash_client_locked(struct nfs4_client *clp)
 	}
 	list_del_init(&clp->cl_lru);
 	spin_lock(&clp->cl_lock);
-	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
+	spin_lock(&nfsd_session_list_lock);
+	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt) {
 		list_del_init(&ses->se_hash);
+		list_del_init(&ses->se_all_sessions);
+	}
+	spin_unlock(&nfsd_session_list_lock);
 	spin_unlock(&clp->cl_lock);
 }
 

Process Finished

