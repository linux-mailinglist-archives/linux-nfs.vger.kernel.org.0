Return-Path: <linux-nfs+bounces-6851-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04ED98FBD0
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 03:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0223AB21430
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Oct 2024 01:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABBF1D5ADD;
	Fri,  4 Oct 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mQaDkPiI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fss8yPC4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mQaDkPiI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fss8yPC4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8FC1862
	for <linux-nfs@vger.kernel.org>; Fri,  4 Oct 2024 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728004053; cv=none; b=bnT5T5GnjB4krkROwrL3ZxICQP9p4u13drvM9wSeNJuYBXwQy4+06SL59QwOKJLFvxkCreaYsCcwVk3TCgaL87C3Ks5NpVY5Q343mgmdh5WAuHMt6piTRGC+OzJJ7VLaNug/GVdwphC/GjfWtofHQ9xWe4YL1gOy3XpOLJv1CGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728004053; c=relaxed/simple;
	bh=yAsEzUoqaTPWIdOCxn3rhMj+qb0CIoA8abNB+ImQV54=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=PwGNNjt68gD0QargwGTWKH5BWzpSCKfU4YgY7sl1KMiz0AoIv/+4daI5hZzsASWlY7ql1QSi9DeXJwKuBiUQyCWtMgSFxS4311MeiocOjpigvMehfrZyrkNBU6+rp+rrX9xPZm37jQ2+kk/Pm89thxhsM2Yzo66EuhfYxBr+9t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mQaDkPiI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fss8yPC4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mQaDkPiI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fss8yPC4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B09121FE67;
	Fri,  4 Oct 2024 01:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728004048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3fiYnOcEO3TR33M/96dCFVtY4TO8ajqPFdRt+XzEK2I=;
	b=mQaDkPiIht24KnXikTR8ZFkWVyFTYIl9w8o8uE1ZdtfDAgOszl6kAN+aTWayW2qrvfLERn
	Io2RN2jY1OLzTzdbQd1r1civPoOCqJngI/QnynLwDrUx1Q5oxcRYML8VIrfNV/PEVYbzEy
	2/NyucJwn+XMOinavoDfL8M++rnYbdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728004048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3fiYnOcEO3TR33M/96dCFVtY4TO8ajqPFdRt+XzEK2I=;
	b=Fss8yPC4sHFl90ygkS34qk0maRjjuZIwqodV7qBa3FBrmTpFIsN8gTARdmZY5xM+Ms7Ksu
	n+FiwuQQXS42c/Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mQaDkPiI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Fss8yPC4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728004048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3fiYnOcEO3TR33M/96dCFVtY4TO8ajqPFdRt+XzEK2I=;
	b=mQaDkPiIht24KnXikTR8ZFkWVyFTYIl9w8o8uE1ZdtfDAgOszl6kAN+aTWayW2qrvfLERn
	Io2RN2jY1OLzTzdbQd1r1civPoOCqJngI/QnynLwDrUx1Q5oxcRYML8VIrfNV/PEVYbzEy
	2/NyucJwn+XMOinavoDfL8M++rnYbdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728004048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3fiYnOcEO3TR33M/96dCFVtY4TO8ajqPFdRt+XzEK2I=;
	b=Fss8yPC4sHFl90ygkS34qk0maRjjuZIwqodV7qBa3FBrmTpFIsN8gTARdmZY5xM+Ms7Ksu
	n+FiwuQQXS42c/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F53C13A55;
	Fri,  4 Oct 2024 01:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DlLgNM4//2befgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 04 Oct 2024 01:07:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Eryu Guan <eguan@linux.alibaba.com>
Cc: linux-nfs@vger.kernel.org
Subject:
 [PATCH] NFSv3: only use NFS timeout for MOUNT when protocols are compatible
Date: Fri, 04 Oct 2024 11:07:23 +1000
Message-id: <172800404387.1692160.2013457390996721241@noble.neil.brown.name>
X-Rspamd-Queue-Id: B09121FE67
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO


If a timeout is specified in the mount options, it currently applies to
both the NFS protocol and (with v3) the MOUNT protocol.  This is
sensible when they both use the same underlying protocol, or those
protocols are compatible w.r.t timeouts as RDMA and TCP are.

However if, for example, NFS is using TCP and MOUNT is using UDP then
using the same timeout doesn't make much sense.

If you
   mount -o vers=3D3,proto=3Dtcp,mountproto=3Dudp,timeo=3D600,retrans=3D5 \
      server:/path /mountpoint

then the timeo=3D600 which was intended for the NFS/TCP request will
apply to the MOUNT/UDP requests with the result that there will only be
one request sent (because UDP has a maximum timeout of 60 seconds).
This is not what a reasonable person might expect.

This patch disables the sharing of timeout information in cases where
the underlying protocols are not compatible.

Fixes: c9301cb35b59 ("nfs: hornor timeo and retrans option when mounting NFSv=
3")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/super.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 9723b6c53397..ae5c5e39afa0 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -885,7 +885,15 @@ static int nfs_request_mount(struct fs_context *fc,
 	 * Now ask the mount server to map our export path
 	 * to a file handle.
 	 */
-	status =3D nfs_mount(&request, ctx->timeo, ctx->retrans);
+	if ((request.protocol =3D=3D XPRT_TRANSPORT_UDP) =3D=3D
+	    !(ctx->flags & NFS_MOUNT_TCP))
+		/*
+		 * NFS protocol and mount protocol are both UDP or neither UDP
+		 * so timeouts are compatible.  Use NFS timeouts for MOUNT
+		 */
+		status =3D nfs_mount(&request, ctx->timeo, ctx->retrans);
+	else
+		status =3D nfs_mount(&request, NFS_UNSPEC_TIMEO, NFS_UNSPEC_RETRANS);
 	if (status !=3D 0) {
 		dfprintk(MOUNT, "NFS: unable to mount server %s, error %d\n",
 				request.hostname, status);
--=20
2.46.0


