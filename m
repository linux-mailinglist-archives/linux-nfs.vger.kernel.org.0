Return-Path: <linux-nfs+bounces-8375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD79E6480
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34EDC16A228
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E8F1553A7;
	Fri,  6 Dec 2024 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DHa9e+KZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rh6wa6lY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EB7H2L3R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1sw5VWo3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCF140360
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453865; cv=none; b=fKp1wIZ4qHxo7M8Kfw1rWK7fy4eoN0kGn40HZm/esPdo/tYPR3f9ilGxLkvjQeHH7iVKplL3rSGvRo+hkHLo6iK7OHBGvZ/BeYacGoxEWGrycFTyUkAUoZDEo11t1IyX7wsAJD/jKcgOOaSvbfBxHIFjmaK8FgHyA6u8eEIotEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453865; c=relaxed/simple;
	bh=MXqJO7OjTu1WCnmKbe6voZGlj9LGqoEldjx0iLQqFL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLQfT7FTGuDrLutL44k9/ADeHG5D98t3loCUymABnfWKoH59V7JCzGatS1uC2yWI+AxQCqrqtaQoqCDmhbiiJVPCzqjMUio+/9P4pyk7Qoa3WcHvviskTJ6Q0yegKW7WHMo3Y4zgpAhHYygmSIkGjcOUc7kWvaRFwvpCI3iMQTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DHa9e+KZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rh6wa6lY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EB7H2L3R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1sw5VWo3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5E711F38E;
	Fri,  6 Dec 2024 02:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733453862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LSTAT9AjLe1nCwWSg0evwKUPIFSXCavRyO0PtrRQ2Do=;
	b=DHa9e+KZIJ8ceDECcn+B+dFZS/45H1CGz3DfRZW+VgKfLELuFv57VwMhPOCVt/lSKonCtO
	g9DvisoC0f0bAXmPz8uLfrPLisxIfEs0ViKuUhjotCE0gCnZCvda1R+yG/sBl5+u2wUnIq
	72aFRx+PeNY/qIPLhq5xr/A59VBr33o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733453862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LSTAT9AjLe1nCwWSg0evwKUPIFSXCavRyO0PtrRQ2Do=;
	b=rh6wa6lYCDilXE4CTrz0oCYMH9f1E46pwRWySUM9KbLEIXCGpq077K2NkouN2FWEzvEYq+
	waa1CK+lDJNUpoCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EB7H2L3R;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1sw5VWo3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733453861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LSTAT9AjLe1nCwWSg0evwKUPIFSXCavRyO0PtrRQ2Do=;
	b=EB7H2L3Rfy+HH1Ta2umGvJ/fOow31H2qM3jen/E8tJF+JO6we0Gn0AK2TUA9DnJNO7wVLA
	kZwp0pXssS4sRtLjFY/jfxZjxKZf/VtMf75yRxsSujStMJHmWfaMlh40fvxnzzMCWHmPWX
	3cD5cC16ao/63njp69UmEDYNv7tn2A4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733453861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=LSTAT9AjLe1nCwWSg0evwKUPIFSXCavRyO0PtrRQ2Do=;
	b=1sw5VWo3jdgj0kir7cCYq0r48U1pmvWMFsDgijklSgLAScuAUSNuGNxqaYoumyPtArmy8o
	9kaqDA07AWXE1EAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8D8D13647;
	Fri,  6 Dec 2024 02:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TN8dGyNoUmeuLAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:57:39 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/2] nfsd: use new wake_up_var interface
Date: Fri,  6 Dec 2024 13:55:51 +1100
Message-ID: <20241206025723.3537777-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5E711F38E
X-Spam-Score: -2.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.95 / 50.00];
	BAYES_HAM(-2.94)[99.73%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

wake_up_var() in a fragile interface as it sometimes needs a memory
barrier before it.  Recently new interfaces were added which include all
required barriers.

These patches update nfsd and svc parrts of sunrpc to use new interfaces
where appropriate.

NeilBrown



