Return-Path: <linux-nfs+bounces-6041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED91596580F
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 09:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD351C211A2
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 07:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E513E40F;
	Fri, 30 Aug 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NeIq0+wI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NE8FHw3+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NeIq0+wI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NE8FHw3+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37A86AFA
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001636; cv=none; b=TLYC3f4Ltgffoq3Jr40Miw6T7sitFBblADF+wdNfR0byJ6ZiXJUPRBUtJGjKljpTOdCfwf5PgtkQ4IM+rLrsFIZePaUFJ7mqlN/8MBklJWidhBgxXSG6wh1LeBUpX5RZZNuu9ESJ1r/hkOLVLoEoJ2jFyI4H4ZSGIUNZ8JA5boM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001636; c=relaxed/simple;
	bh=3tAyOmHATqCu+/48P8YhgUYm1mU/9cc6nlLQdaWApT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l43ONmhEi4Eq/I9MAr0Txcbsa1mMq1gMe4A9ofasRLwtYTVMdk2XcYWlZ14A+KYsWbUV4VClgjYl2iK8tXrbnui4y3/88ypQ25Cbgsj5gaj9sSWxhkOWxTefx93f/uMLIuZqvZuXr8068L9u6Y+BCjSEcYKhlXxin8VuVumxDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NeIq0+wI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NE8FHw3+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NeIq0+wI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NE8FHw3+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1627C21A0A;
	Fri, 30 Aug 2024 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725001633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZvHCVIglz/7h4IZPkiyOHC47wFjwpw5oOe8mWnozTZ8=;
	b=NeIq0+wI7Gx82ZDfaUWil5IwldijVgwj2Ef2IrKqffbo4VNhmeLo4MN+Mk+hnbQ7jB+w2v
	RJUP++VfN/MS2qJ8y28ktceBtYJGIaaPUJeI6kUXchXq9eAfTBGafiHW+Yo6ev7rTyu/hQ
	ncHl39uBlvF6fZO5ApWYUnZ/ae/8BMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725001633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZvHCVIglz/7h4IZPkiyOHC47wFjwpw5oOe8mWnozTZ8=;
	b=NE8FHw3+2qHJBclRXs2E5/DYC5yAoNKKwNvKzA/Q16CP29+K1/bLFtEJAHFyk5wKHiQowE
	yqPrqfktjV0HKRDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725001633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZvHCVIglz/7h4IZPkiyOHC47wFjwpw5oOe8mWnozTZ8=;
	b=NeIq0+wI7Gx82ZDfaUWil5IwldijVgwj2Ef2IrKqffbo4VNhmeLo4MN+Mk+hnbQ7jB+w2v
	RJUP++VfN/MS2qJ8y28ktceBtYJGIaaPUJeI6kUXchXq9eAfTBGafiHW+Yo6ev7rTyu/hQ
	ncHl39uBlvF6fZO5ApWYUnZ/ae/8BMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725001633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZvHCVIglz/7h4IZPkiyOHC47wFjwpw5oOe8mWnozTZ8=;
	b=NE8FHw3+2qHJBclRXs2E5/DYC5yAoNKKwNvKzA/Q16CP29+K1/bLFtEJAHFyk5wKHiQowE
	yqPrqfktjV0HKRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D579413A44;
	Fri, 30 Aug 2024 07:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5ilaIp9v0WZ2XAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 30 Aug 2024 07:07:11 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 0/2] nfsd: improvements for wake_up_bit/var
Date: Fri, 30 Aug 2024 17:03:15 +1000
Message-ID: <20240830070653.7326-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

I've been digging into wake_up_bit and wake_up_var recently.  There are
a lot of places where the required barriers aren't quite right.

This patch fixes them up for nfsd.  The bugs are mostly minor, though
the rp_locked on might be a credible problem on weakly ordered hosts
(e.g.  power64).

NeilBrown

 [PATCH 1/2] nfsd: use clear_and_wake_up_bit()
 [PATCH 2/2] nfsd: avoid races with wake_up_var()

