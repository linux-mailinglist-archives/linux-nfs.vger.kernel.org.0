Return-Path: <linux-nfs+bounces-2253-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE63877997
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 02:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE979280DC1
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Mar 2024 01:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF089801;
	Mon, 11 Mar 2024 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jE4pAIvm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gx3U1cNx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XYi6MVHw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b57Hay7s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8B27EC
	for <linux-nfs@vger.kernel.org>; Mon, 11 Mar 2024 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710121421; cv=none; b=NFN9lsnQl0XcEF6jhws1lrVMinNivki3A/YEOf+JuJGPsRP9Xxfi/Wery5bCnR/y0VSPMg8IBL5cZr4x2pd+IEaCPBkl1R6Vqa24ryF9AfjtWvuT3f7KkOGjJ8drSMlFNH1d99Q96d5Jj7Cdm0CQdkAxOfI9SMn6BwGj1f7dPqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710121421; c=relaxed/simple;
	bh=rSd9MLwu7X5Z4GEFs4fIvnHEMVGmaY2DCPYR9P33hLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SqbSm+SfZMwCE7wc11m1Q79XpopEfbp4DGuySaMih9s89CeaN623Xh0odMHw5XyLJ3+7hVdxH+3PhtTtqP+qyyKqDY3K09pfORxq9FaSeW8Ay8Matvhw3fpjkeJifmVmp8YWH/zw/mm1WbwI6LZR2Ye26JHX6bQwJfhPAoghkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jE4pAIvm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gx3U1cNx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XYi6MVHw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b57Hay7s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E04B4346B3;
	Mon, 11 Mar 2024 01:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710121418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rSd9MLwu7X5Z4GEFs4fIvnHEMVGmaY2DCPYR9P33hLc=;
	b=jE4pAIvm+2Gdgo2EuCWNV/WH2hw7AHD+bz9u2D4OOty8N5Afjm/7JJEtr2DMUAPalcA4Lr
	duEx2456LmLl6aAen0Dgx1lm2ZuFJC+71fpt8URHzeDW38llHn3nvK3+aaKJ1HPM0jY9xC
	+9WMTvDdAtYk05TX6L86gGNDDJmnuk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710121418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rSd9MLwu7X5Z4GEFs4fIvnHEMVGmaY2DCPYR9P33hLc=;
	b=Gx3U1cNx8gd+aTJ3j91ijOiPFIPhFvIW+Dc8L0H5WtMa5pnSyFHNTPbYL1H2xpSEu6TjKm
	QSoAX3ohFWGQ37DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710121417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rSd9MLwu7X5Z4GEFs4fIvnHEMVGmaY2DCPYR9P33hLc=;
	b=XYi6MVHwQUsToTVXZ/YU14HxsH3DVyyJRZ9J1k3ANQ94Y8S9+QY7P7BN+iHX8DEB59sfL0
	+aiQQNtuUNKfUt0JzSx73pzaz9EZUWIGFApWJxVrRA/nnTjANx/UznBWsAoyPlqoe7UI5g
	vrKTG2lSQXLD7wKGbjA5w0uAmV6ar4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710121417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=rSd9MLwu7X5Z4GEFs4fIvnHEMVGmaY2DCPYR9P33hLc=;
	b=b57Hay7s5vseS0juAd4AiufklZ3Z/6XGnJJ1GHYZvWY1RmkXZdTSIPP+vHchHLEWa1nY8V
	GU4Ac8nE33qFFmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC051134AB;
	Mon, 11 Mar 2024 01:43:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U7JnF8hh7mXmfgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Mar 2024 01:43:36 +0000
From: NeilBrown <neilb@suse.de>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/3 libtirpc v2] Support abstract addresses for rpcbind in libtirpc
Date: Mon, 11 Mar 2024 12:41:15 +1100
Message-ID: <20240311014327.19692-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XYi6MVHw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b57Hay7s
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.43 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.06)[61.73%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 3.43
X-Rspamd-Queue-Id: E04B4346B3
X-Spam-Flag: NO

This resend includes a couple of bug fixes.
In the first patch, __rpc_taddr2uaddr_af() was reported a "universal" address
of the absract socket as starting with "\0" instead of "@".

In the second patch, only one local_rpcb() call wants the target address.

Thanks,
NeilBrown

 [PATCH 1/3] Allow working with abstract AF_UNIX addresses.
 [PATCH 2/3] Change local_rpcb() to take a targaddr pointer.
 [PATCH 3/3] Try using a new abstract address when connecting to

