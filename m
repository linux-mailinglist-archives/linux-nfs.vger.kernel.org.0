Return-Path: <linux-nfs+bounces-7636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA1B9BABDB
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 05:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA947B212C5
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 04:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2052C9A;
	Mon,  4 Nov 2024 04:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ycFX8fEX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q0ger2l8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pZk3dB+X";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VskueQTh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9AD1632CF
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 04:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730695673; cv=none; b=IN5fK16Bbrrr/Id+IhfThBl83+/Z05GuilGNKvxnUW04pHGzkDJ/2xWVr7AX7BjMRAz/j6SOI3Wx5Q1EN0TNdMS+rq5SqCXd2248qYT6ygqLF9fuoICh2hDwyh580aMCuW3O7L6HqdDmGC8b0MhVcnyZwl122X+Sh+JHrXGzQWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730695673; c=relaxed/simple;
	bh=qF4/I/8q8il/CQ1yfTbBaXdDf/cPfJJEE3jH9zgb42U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=osWQ/V9T6JJ76e/UzJAER+M96A7trwdyZe8xLuJ48L1a16j9AlqrkN9i8zxcOC8A0D8ZIFOQgc6pwOhbsNGirQE314ezmKoiRDLaZfdaUZl0k7jDBbreTYNQnRPRH+n1hrF9ZY5n7AEj1fX5yQRP9vIY3ap1i1VXQF0eEeLIbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ycFX8fEX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q0ger2l8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pZk3dB+X; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VskueQTh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB61E1F46E;
	Mon,  4 Nov 2024 04:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730695669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ki5dIGwVl3pO4a2yAM0VMLRbkC6zkLt0PcbWo/9+oYQ=;
	b=ycFX8fEXeX94urzh4PbfzSNcF5691GTN4yc5ebfK2aQPNFdFJMMdlzQrBkunZ+rQzLvhz2
	uFouFgg7/Ds5JiPy5+PvPhQqCFMAhK84Tl5hx51vy3DduSP71+lQ8zQgbv9IHseYI2fkxO
	ZeMwBuP87c8+d8CD9s6SWMf+HiclwU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730695669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ki5dIGwVl3pO4a2yAM0VMLRbkC6zkLt0PcbWo/9+oYQ=;
	b=q0ger2l8sDiJLej20crNH9o411jerWbGgNcmifkp/A2xD0H6xqVPDP+VofDS3zt8zqFx7w
	h2Ot/EZhUFYZc7Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pZk3dB+X;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VskueQTh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730695668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ki5dIGwVl3pO4a2yAM0VMLRbkC6zkLt0PcbWo/9+oYQ=;
	b=pZk3dB+Xzwr4Jr4e3qQPiDM16I3tc885nwRhyWkfdkfavJgV2Nm9cPpyjQ89uEYzGcfYYW
	nqyKPO5pxW0DlerN+kKZ8s9Q7wk0oNgtJtsgdASwE0U19+ouUiNnH/GZ1DT1IpArM3f5Ur
	MX1tPvktu/laBB9ztMQyp6IZsT6aJUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730695668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ki5dIGwVl3pO4a2yAM0VMLRbkC6zkLt0PcbWo/9+oYQ=;
	b=VskueQThVBB0N7jI22pjGsYsnXCam/Kh/y2+d6oQpm1a3ZS3UAYapAqAmZ0YawDTE2YX/D
	R/NhQbOGvlXa58Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3A1F13736;
	Mon,  4 Nov 2024 04:47:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OAw5HvJRKGcDTwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Nov 2024 04:47:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: fallback to sync COPY if async not possible
Date: Mon, 04 Nov 2024 15:47:42 +1100
Message-id: <173069566284.81717.2360317209010090007@noble.neil.brown.name>
X-Rspamd-Queue-Id: DB61E1F46E
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 


An NFSv4.2 COPY request can explicitly request a synchronous copy.  If
that is not requested then the server is free to perform the copy
synchronously or asynchronously.

In the Linux implementation an async copy requires more resources than a
sync copy.  If nfsd cannot allocate these resources, the best response
is to simply perform the copy (or the first 4MB of it) synchronously.

This choice may be debatable if the unavailable resource was due to
memory allocation failure - when memalloc fails it might be best to
simply give up as the server is clearly under load.  However in the case
that policy prevents another kthread being created there is no benefit
and much cost is failing with NFS4ERR_DELAY.  In that case it seems
reasonable to avoid that error in all circumstances.

So change the out_err case to retry as a sync copy.

Fixes: aadc3bbea163 ("NFSD: Limit the number of concurrent async COPY operati=
ons")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index fea171ffed62..06e0d9153ca9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1972,6 +1972,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compoun=
d_state *cstate,
 		wake_up_process(async_copy->copy_task);
 		status =3D nfs_ok;
 	} else {
+	retry_sync:
 		status =3D nfsd4_do_copy(copy, copy->nf_src->nf_file,
 				       copy->nf_dst->nf_file, true);
 	}
@@ -1990,8 +1991,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compoun=
d_state *cstate,
 	}
 	if (async_copy)
 		cleanup_async_copy(async_copy);
-	status =3D nfserr_jukebox;
-	goto out;
+	goto retry_sync;
 }
=20
 static struct nfsd4_copy *

base-commit: 26e6e693936986309c01e8bb80e318d63fda4a44
--=20
2.47.0


