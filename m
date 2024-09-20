Return-Path: <linux-nfs+bounces-6561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F4497D00C
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 05:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0A01C21740
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Sep 2024 03:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F158488;
	Fri, 20 Sep 2024 03:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j+ygPxJ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P3KxT1p8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j+ygPxJ2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="P3KxT1p8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C6BE4E
	for <linux-nfs@vger.kernel.org>; Fri, 20 Sep 2024 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726801372; cv=none; b=HaUeXsNy8Hiyd1ULracIexuuqZMediWLR36MssZtvJ7bMqtieixcTQ4s97njnMIHFOHLcExNccxWCTEie+sXFC9wfZcw1ZGLt4DOI+f1AqnWbGraqsGA1tGzo/xv2h7E4gKczQn4MthCMrw35vRakHlUi1tsBwoYcmkY+t6Sj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726801372; c=relaxed/simple;
	bh=RYlnRXy++4J2nces+xDqWjJdaxYmkRxRzjtsvsFMNHs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=kturS1G4VDJx9/sbSEReXsWJp1QHHNTRrsVQ0rYOolpysTQTcBpoa5+DHp5beh1+9PKPRTjzCYFEq4yRi6mJLEap6dhDIl9XUIO3MMne4Ea3gxqWsSvXOyhC7RBLiEvae0u5MVT/OLvNh8rTwufqlE3AKH2ORDhp+xSuCQHedWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j+ygPxJ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P3KxT1p8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j+ygPxJ2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=P3KxT1p8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 475FC20A4A;
	Fri, 20 Sep 2024 03:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726801368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVNtiWir/ENWAUXNwWc1nRKDRnAaOiGzKXF4lbMpO48=;
	b=j+ygPxJ24t1PeFhujx4f5nx3b2uHJqpmSs1aeJt+bfHHtx25X0mtS6Wm+ZouQkYPFbkv59
	DPrFPmeILEpGV+2m49RmTb0T77HplHS1oTtWptvsAOHZdBZA5zqGPMD2HqTqmpyZQE6tWE
	01v5/CXwSWy96YuIMQsBntZXCTCKX14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726801368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVNtiWir/ENWAUXNwWc1nRKDRnAaOiGzKXF4lbMpO48=;
	b=P3KxT1p8WW/Y7qVpjgmaA9xL/vMWusRLmFSn2bJ3FmFg6y3wwCc5wzZJl8PHAEsep9IZgN
	zjXT6YwsyR39xMAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726801368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVNtiWir/ENWAUXNwWc1nRKDRnAaOiGzKXF4lbMpO48=;
	b=j+ygPxJ24t1PeFhujx4f5nx3b2uHJqpmSs1aeJt+bfHHtx25X0mtS6Wm+ZouQkYPFbkv59
	DPrFPmeILEpGV+2m49RmTb0T77HplHS1oTtWptvsAOHZdBZA5zqGPMD2HqTqmpyZQE6tWE
	01v5/CXwSWy96YuIMQsBntZXCTCKX14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726801368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVNtiWir/ENWAUXNwWc1nRKDRnAaOiGzKXF4lbMpO48=;
	b=P3KxT1p8WW/Y7qVpjgmaA9xL/vMWusRLmFSn2bJ3FmFg6y3wwCc5wzZJl8PHAEsep9IZgN
	zjXT6YwsyR39xMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75B6913974;
	Fri, 20 Sep 2024 03:02:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EsyLCtbl7GbeDgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 20 Sep 2024 03:02:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Steven Price" <steven.price@arm.com>, Jon Hunter <jonathanh@nvidia.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: simplify and guarantee owner uniqueness.
In-reply-to: <1d66e015-1ca7-4786-893c-9224ad0c7371@arm.com>
References: <>, <1d66e015-1ca7-4786-893c-9224ad0c7371@arm.com>
Date: Fri, 20 Sep 2024 13:02:43 +1000
Message-id: <172680136351.17050.10296437171546281772@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 19 Sep 2024, Steven Price wrote:
> On 19/09/2024 02:29, NeilBrown wrote:
> > On Wed, 18 Sep 2024, Steven Price wrote:
> >> Hi Neil,
> >>
> >> (Dropping the list/others due to the attachment)
> >=20
> > (re-adding others now - thanks for the attachment).
> >=20
> >>
> >> Attached, this is booting a kernel compiled from 00fd839ca761 ("nfs:
> >> simplify and guarantee owner uniqueness.") which uses an NFS root with a
> >> Debian bullseye userspace.
> >=20
> > This shows that the owner_id was always different - or almost always.
> > Once it repeated we got an error because the seqid kept increasing.
> > This is because the xdr encoding is broken.
> >=20
> > Please apply this incremental patch and confirm that it works now.
>=20
> Thanks, I've tested the below and I don't see NFS errors any more.
>=20
> Tested-by: Steven Price <steven.price@arm.com>

Thanks Steve.

Anna: could you please squash this fix in to the commit?
Jon: could you please confirm that this fixes your problem too.

Thanks,
NeilBrown

diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 1aaf908acc5d..88bcbcba1381 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1429,7 +1429,7 @@ static inline void encode_openhdr(struct xdr_stream *xd=
r, const struct nfs_opena
 	*p++ =3D cpu_to_be32(28);
 	p =3D xdr_encode_opaque_fixed(p, "open id:", 8);
 	*p++ =3D cpu_to_be32(arg->server->s_dev);
-	xdr_encode_hyper(p, arg->id.uniquifier);
+	p =3D xdr_encode_hyper(p, arg->id.uniquifier);
 	xdr_encode_hyper(p, arg->id.create_time);
 }

