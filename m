Return-Path: <linux-nfs+bounces-4452-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163BF91D659
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 04:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51B01F21276
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 02:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491D1DDB3;
	Mon,  1 Jul 2024 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n5OF72gW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SGGIi1ec";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n5OF72gW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SGGIi1ec"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A676C144
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802713; cv=none; b=eLPXdr66ms6va1etm8ZDorIw2JDx1DMvb5qkzYTdYYwhFPzzbFxGtfROHQ1TudQbY+N9dSxkZn34KOYPB+vI1HiXWUZFqE9NJGAWzM2sYW0VJU7zDjpizECL498fv4aNQHY/T4JsPphqYEudIuEcPuogCkYiaQamT+uChgc8oAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802713; c=relaxed/simple;
	bh=QcBo3/Jk/MtJjuuJq95ReoGfib9PubcswPGWMIOHAa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YCAcV4jovCw01Mrx1E1i47T5VzUfzMv6Ijh3tNXpc2pbYw+sEqNEEpWCzm5AkyZIN5NIAwCWbPhDfVBmleqHmNct/0L50n6JS6aBg7yJSKF9K2hmo9qpSQqgskZcRZac6EZV5LhvVNMj88yudhYwWDFg5AKTrMW6cSQG6QqQkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n5OF72gW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SGGIi1ec; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n5OF72gW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SGGIi1ec; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6370A219EE;
	Mon,  1 Jul 2024 02:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Mk/Zc2grS2tLnJIqt67aG4Mx+iIZs/JVVNXdnXWt0Qo=;
	b=n5OF72gWZsUn/tX6D99E7tdvhD57bWBdlWmMgZvMjLetrCMPSUItU/nutJ6qgIxjoD54Le
	rCPrj+gEZerQcqMzLLcnwEG/EYlEM1kL0vCENFBOt8r1dn+uz5STgRioNS4X4WxbF39WMK
	nscCjI1ipTjatsz6iUlVZJLH1kQ6BD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Mk/Zc2grS2tLnJIqt67aG4Mx+iIZs/JVVNXdnXWt0Qo=;
	b=SGGIi1ec4KwR83q6EJG2Iajag2H1MCBrjn7Zv63IPakAmllbKB4zzNOSLhpf1Oj7SKxJOo
	I0G1Uy5AUgLVxPBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719802709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Mk/Zc2grS2tLnJIqt67aG4Mx+iIZs/JVVNXdnXWt0Qo=;
	b=n5OF72gWZsUn/tX6D99E7tdvhD57bWBdlWmMgZvMjLetrCMPSUItU/nutJ6qgIxjoD54Le
	rCPrj+gEZerQcqMzLLcnwEG/EYlEM1kL0vCENFBOt8r1dn+uz5STgRioNS4X4WxbF39WMK
	nscCjI1ipTjatsz6iUlVZJLH1kQ6BD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719802709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Mk/Zc2grS2tLnJIqt67aG4Mx+iIZs/JVVNXdnXWt0Qo=;
	b=SGGIi1ec4KwR83q6EJG2Iajag2H1MCBrjn7Zv63IPakAmllbKB4zzNOSLhpf1Oj7SKxJOo
	I0G1Uy5AUgLVxPBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B80E1340C;
	Mon,  1 Jul 2024 02:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1Mw9O1EbgmbKLgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 01 Jul 2024 02:58:25 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 0/6 RFC] nfsd: provide simpler interface for LOCALIO access
Date: Mon,  1 Jul 2024 12:53:15 +1000
Message-ID: <20240701025802.22985-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The purpose of this series is to provide an iterface to the filecache
which can be used without a struct svc_rqst, and without any xprt.

This interface is realised in the final patch as nfsd_file_acquire_local().

That function currently takes and nfs_vers option.  That was a natural
fallout of the refactorisation that lead here, but it probably isn't
wanted.  I need to review exactly what effect it has - mostly it is
about error code choice I think.

The function also takess a 'struct auth_domain*'.  It is not clear how a
caller would get hold of such a thing.  I suspect that the server should
register a "local-io" auth_domain in the nfsd_net, and it should be used
here.

Comments on design and implementation most welcome.

Thanks,
NeilBrown

 [PATCH 1/6] nfsd: introduce __fh_verify which takes explicit nfsd_net
 [PATCH 2/6] nfsd: add cred parameter to __fh_verify()
 [PATCH 3/6] nfsd: pass nfs_vers explicitly to __fh_verify()
 [PATCH 4/6] nfsd: pass client explicitly to __fh_verify()
 [PATCH 5/6] nfsd: __fh_verify now treats NULL rqstp as a trusted
 [PATCH 6/6] nfsd: add nfsd_file_acquire_local().

