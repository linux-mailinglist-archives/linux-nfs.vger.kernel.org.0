Return-Path: <linux-nfs+bounces-8439-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DC09E88BA
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 01:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6980B163EE2
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 00:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40704A0F;
	Mon,  9 Dec 2024 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r55t+pm1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tTw1FPKh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r55t+pm1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tTw1FPKh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261B4409
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733705007; cv=none; b=EOS427eWXUMAZlkXQi3d4ynaICxqImX+aEoSsCzTT5LZ1itpsT72ht4SILbH8lyI/BIIURdjlYAWAItFCREc9/8IaEnw7Nmogi5RtRCO2YdFYMeBIEFHdD6ww+/ILI9qnZxjFuQERnFH+ccmfMDCOB/23dIXjfF/j1dXDmpn624=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733705007; c=relaxed/simple;
	bh=uTsMUioEWNKk8JInYVOzbSFn9SgOLotlWXjTFowkMHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCQSCRfSUpX9EHYbvJliRVmiFU1Sw/hidaAdg/zqUAnDH5Ue4+IhAP9ca/Gli0L0kfEo2whXQhO7sCcvAgZt3rzZN0x4hhmLHAh6NIqz5zVluc5AdAvGPowNGDawfMiHEYcmCnYvDZx8smYjoX35UR1l5sj3Hkhs0M3ucUyEWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r55t+pm1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tTw1FPKh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=r55t+pm1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tTw1FPKh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3547E1F385;
	Mon,  9 Dec 2024 00:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733705004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l4XD+sn3eFiz9skv3OPjq4i2GSgWNORjaipUgOPqeKQ=;
	b=r55t+pm17T3qYsAQ9s0YUSXCGyQOuPr1gVYucCmzfetv5nE64Fr4XG43CwCr2JOF7HTBvp
	U3c7E9B4EwpQIcBD8Z7w0gj7M88UW6XtkGyGcKq3II3rlI6mp/YgabfhBtL8Jg5kK1J1z0
	J+vL7Z2Spnk3011RTsdLsi5AofP/9KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733705004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l4XD+sn3eFiz9skv3OPjq4i2GSgWNORjaipUgOPqeKQ=;
	b=tTw1FPKhc9RLFALJIuIk2vbovOkLLRsqZNC9GIoRHqinlDts6u6+0zj4jYbzyftmVO4ulU
	++XfYD10QKIeZUCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733705004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l4XD+sn3eFiz9skv3OPjq4i2GSgWNORjaipUgOPqeKQ=;
	b=r55t+pm17T3qYsAQ9s0YUSXCGyQOuPr1gVYucCmzfetv5nE64Fr4XG43CwCr2JOF7HTBvp
	U3c7E9B4EwpQIcBD8Z7w0gj7M88UW6XtkGyGcKq3II3rlI6mp/YgabfhBtL8Jg5kK1J1z0
	J+vL7Z2Spnk3011RTsdLsi5AofP/9KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733705004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=l4XD+sn3eFiz9skv3OPjq4i2GSgWNORjaipUgOPqeKQ=;
	b=tTw1FPKhc9RLFALJIuIk2vbovOkLLRsqZNC9GIoRHqinlDts6u6+0zj4jYbzyftmVO4ulU
	++XfYD10QKIeZUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B0C7138A5;
	Mon,  9 Dec 2024 00:43:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mLrrKyk9VmeWHQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 09 Dec 2024 00:43:21 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 0/2] nfsd: don't use sv_nrthreads in connection limiting
Date: Mon,  9 Dec 2024 11:41:25 +1100
Message-ID: <20241209004310.728309-1-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This is a resend of a couple of patches from a series that didn't get
accepted in its entirety, but I think these patches were not objected
to.  Hopefully they can land so that when I get back to the series it
will be smaller.

Thanks,
NeilBrown



