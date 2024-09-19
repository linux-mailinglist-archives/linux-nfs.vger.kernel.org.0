Return-Path: <linux-nfs+bounces-6544-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C597C270
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 03:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC09D1C21372
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Sep 2024 01:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF6DF58;
	Thu, 19 Sep 2024 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V+vebXHw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0eTLSHDt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V+vebXHw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0eTLSHDt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5DD171A1
	for <linux-nfs@vger.kernel.org>; Thu, 19 Sep 2024 01:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709383; cv=none; b=dJn+fJ6MSMnbiObVND6gSluYdu80FlkuoE1zIzlBMawqFQTWVzKtYpiUKaZwHrxf/AWQIBZxY8XZTd9dvyTkUj4iz+X2CxBpEouOoa+X/QVZkzvKgCiOhE1ij+C0DPq6Tn870CL0fwtEcLUZq71Ysne5oxCn1l/fik+sfHJElUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709383; c=relaxed/simple;
	bh=TY75v5nngH5TplfbDDFav9QD35WY7yU+FClvacuH/RU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JdaRTvJkLZ/9Z4UdHFMESe8pKvQRbsOS4x6Pdxwh6t/MfsEtCQ16Q1yL/h5WjeYFrHXQsBcXhg77d01CufQrcRAFbWqOvUXoKNvDIrFxaokVFUSc6vFNi7Eer6rcarE3FeJPLIIUDiREnTHGAKwfaA+563rxHLhjN+u+JHU9kic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V+vebXHw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0eTLSHDt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V+vebXHw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0eTLSHDt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 414412070C;
	Thu, 19 Sep 2024 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726709378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JdMvuKiNPhTVG1c8i5iWlAbLcMZD9TP4XlZXeYZt30=;
	b=V+vebXHwWXuuuPsIKQJVNMperpvH3lto+RuSYrRXSEy7pja6SB0mIMK4+jM6UiDBs4D+Vf
	D/zHJHIKFRillIv+8jiehMFtbgZRKH+nEHeiuUCnvXfmdivAUG2dUU1sl0wnZM8HmoSMkf
	m/c1ClaPNrolTaiu4yecgtfqzSNeyXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726709378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JdMvuKiNPhTVG1c8i5iWlAbLcMZD9TP4XlZXeYZt30=;
	b=0eTLSHDtIgUUUI6uvGpEOMOy0fekwtgUpQha6U7meWQbchwmx1o/VjbPSKevO+8pG1QyYu
	rXOrB4ARp3BozSCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726709378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JdMvuKiNPhTVG1c8i5iWlAbLcMZD9TP4XlZXeYZt30=;
	b=V+vebXHwWXuuuPsIKQJVNMperpvH3lto+RuSYrRXSEy7pja6SB0mIMK4+jM6UiDBs4D+Vf
	D/zHJHIKFRillIv+8jiehMFtbgZRKH+nEHeiuUCnvXfmdivAUG2dUU1sl0wnZM8HmoSMkf
	m/c1ClaPNrolTaiu4yecgtfqzSNeyXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726709378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+JdMvuKiNPhTVG1c8i5iWlAbLcMZD9TP4XlZXeYZt30=;
	b=0eTLSHDtIgUUUI6uvGpEOMOy0fekwtgUpQha6U7meWQbchwmx1o/VjbPSKevO+8pG1QyYu
	rXOrB4ARp3BozSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDDD713A91;
	Thu, 19 Sep 2024 01:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iQvVHIB+62aldAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 19 Sep 2024 01:29:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Steven Price" <steven.price@arm.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfs: simplify and guarantee owner uniqueness.
In-reply-to: <02879298-7c13-41b0-a99d-1e0829a8886e@arm.com>
References: <>, <02879298-7c13-41b0-a99d-1e0829a8886e@arm.com>
Date: Thu, 19 Sep 2024 11:29:33 +1000
Message-id: <172670937352.17050.5443512085908242810@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 18 Sep 2024, Steven Price wrote:
> Hi Neil,
>=20
> (Dropping the list/others due to the attachment)

(re-adding others now - thanks for the attachment).

>=20
> Attached, this is booting a kernel compiled from 00fd839ca761 ("nfs:
> simplify and guarantee owner uniqueness.") which uses an NFS root with a
> Debian bullseye userspace.

This shows that the owner_id was always different - or almost always.
Once it repeated we got an error because the seqid kept increasing.
This is because the xdr encoding is broken.

Please apply this incremental patch and confirm that it works now.

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
=20

