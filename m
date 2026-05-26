Return-Path: <linux-nfs+bounces-21935-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAOtGRAwFWr9TQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21935-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 07:30:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB565D0D98
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 07:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F69B3002E2D
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 05:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E13BF667;
	Tue, 26 May 2026 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="C4Yp5owt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bNKqK+RK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271F3AA518
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779773434; cv=none; b=mV6hhf9LiA6o4ErlvjzF4X6u3ZaTlDplTO6OgvPul00HNlyuqsEaZ+NlfqeyxqYXKdXWZVyHfnYF7rteUdV0TWLgGFKi9FVWFEhi0x1sslFoYLi3y0FiDuuKnOZMnRmmsprbryR8QgpFkwMOpWsgesJ+QD1JOFGcec4nZQ/2ahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779773434; c=relaxed/simple;
	bh=VNcal33lXaWhzYoegJ9W5ntzTk6ntOv9mjjtMw8tMNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnE62XesV1t0gc6E4VNmNsEDq0czzVcFsWgH5IoYQDCJcxMn6SomxNpa6yZg4hhRiGxOuJ9bNBa/zp2hazVEWWwVho0ay9a9lXY0On7mI2KeEEW3V3BowWEEfIQ9g8XKrYn6cKgNCoptExtDQF527whYQgV0qcvYezRbEhFyvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=C4Yp5owt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bNKqK+RK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A97BCEC0079;
	Tue, 26 May 2026 01:30:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 01:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1779773431; x=1779859831; bh=4iKXia0rGf
	J5YIdFn8cbxII5LqZuVxInzo5UmNkF4HU=; b=C4Yp5owtXeNVwriO4mofFv2MGt
	S9ZAo6Zc2cNwYHxcf0LAB4S3h9gXIR8nZ705XQ/AY/FrlCTh1EBgq7EKMmgfVPYY
	VByL83bWLrLsg5S+CLWwfiiNh3qhpofcafHQNaapGdDZKJMjGJJdUbCOFqoTr3Pv
	LKaatMwtODtjnkWJ0oTq5t7IP7dudTL4jb0OlQ+eEGqf2u+RHxOi5mV8sge1HAbA
	CxuqxbOVOr8JZJznr3z+pSh2aYQ9xNPNNrZQ7+Z5ZgrzTNWi5S7iH79BAo1raFik
	ICO7/LFyHmii5p4rbrb8p3KdPZ9Rn2+sVfVqUy3xOto95i6UBc5sBD3Z2E6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779773431; x=1779859831; bh=4iKXia0rGfJ5YIdFn8cbxII5LqZu
	VxInzo5UmNkF4HU=; b=bNKqK+RKEoYR0ie91ny3liiFsqkFSbHIBXfJCV7h8cfJ
	5Xfb+QJPtzSKnnnA+xLy7W9o+6b/D/+l31VUcFPUaxCC6n+ki4roMgmHEYPlA5Mr
	WeJv4OMvKvS3Xn6jUpxlR9SOAu4p5guu8w+xLq0vDxtAIybmVu0grE8EGYTmSXsp
	p9D2Uyz6kHl/4KCRe4wzFb5+Ev49mZwM3KOsCsA+ptKj0lbT1aXCfQmVGzrh4Ez9
	5DjV+1Fhu3HxsWEmAz+5qLF849RnlMr8kSEx4IzdOOWKbVS0KyXX/PeXFDf1jrI5
	rEuO+wx0adJ938R0kg7jnXDL8cg2wp5NMFmFxeZPqA==
X-ME-Sender: <xms:9y8Vau_BfzSR4c7hYWuCRPe79A1hPJaJuHptEeBWpovB1XQpaEXARQ>
    <xme:9y8ValsNJZCOShodNaWmMhPtm-xrpmJGDvDv_4mc7O9bxZ-AO0RclCDTo78l4CsmK
    JLi7jAvdf07CutbUDZiurIwBCXfyHvxokbvPJHRwoL460r06Q>
X-ME-Received: <xmr:9y8VapB_lFHVZ2_bEyOy_nNQ3vqcJAN06tmMi1LbsH0-hVDPqch757a-zb27HtymRqFXlEZcs4LDkzeJdvHTgioFl68lC4g>
X-ME-Proxy-Cause: dmFkZTEMdAsId/OvxGQNTFco3hlC8wIxjAH/nydx7rvpS7Mdgh6M79iO/sz7lX+0uGp/55
    R+lcjttpvEerZiekjBSyuOQgpF2/YnIRxbWcy5jHZHyiSd/1z8N7NExAHT3irw6NN1Pt94
    cRl7+9MteoPF/Yo5ubqj03UZeb2pYrM7K+9B0qNlTZJysWn3+E39nGVU7ZzktVQyUL4RO0
    vv8lMwpO47IVWW4hLuPu6ppS/wJfg5ZO2C5O+sGD9pHNqFKaO+acNJfx0UqdyvY3gCPpzf
    0jNPrFfamQda5hD3h1WQKh1SZ910DQQLbzgaLv032X8eOaN+TeaxgSHz+dZPaHmcmLNaTz
    Rx0FFz1hBXQiRZdyo6aEzW7u79QyTrIqnBcLVZG2vrE+RKTQoLB9ZwFHUbgie44sPkYSLl
    1XcCFIPvl8KvW+9WVe9gjfeZ2SDgfkpNtJBU/yppaAUT2d6naBnuG4k7bvsrjSuCjeLR6E
    aXd1IghYyoGIj29asOnqQof77DWUtY9c14xBqjhlPMBzbwqiMfzWAzTmchK7VkJwePBf62
    ZNTVHivHKaeGE8QkmJxYwnwVvRG7ZIafXVQJEHp49RYlSRECFzrJgBgXB1W4O9/LqQkKg6
    vjWzXO//uSqnIXxeDKvFuNTM+C4sLHiJxfL35Ak4thKYjEhVFsWkwMteavKg
X-ME-Proxy: <xmx:9y8ValW-tXgUYvgA4T-0F-Pyk0Ikv_88ucoGfX1_W7HAaE2VboLCnQ>
    <xmx:9y8VavCd_4dGiqwwt_S4mBVpF_kZgtGrqj_ejuvJl84vP6bUsfv1ow>
    <xmx:9y8Vag8tkpcYPOWpBpUlA8iouiWkJOt4ifec2hoPLQKzw_vWd7Ug5A>
    <xmx:9y8VauG8d_HfNPKMyPY6FiA9s8-roKuzWOWicuuIRJtz14AywVg9sQ>
    <xmx:9y8Vat8cRiU6oMZ-mB_ugazBBTJ6ZC8kftcBEz2OXEYGt8F07ZfLcNrO>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 01:30:29 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 02/] nfsd: fix minor issues with atomic_create() use in dentry_create()
Date: Tue, 26 May 2026 15:27:57 +1000
Message-ID: <20260526053004.4014491-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21935-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,messagingengine.com:dkim,ownmail.net:mid,ownmail.net:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: CCB565D0D98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

    https://sashiko.dev/#/patchset/177969022571.3379282.16448744624428323496@noble.neil.brown.name?part=1

 reported a couple of edge-case problems with the use of atomic_open()
 in dentry_create(), called from nfsd4_create_file.

 These patches attempt to address those issues.

NeilBrown


 [PATCH 1/2] nfsd: fix possible fh_compose of wrong dentry in
 [PATCH 2/2] nfsd: ensure nfsd_file_to_acquire() does not use a

