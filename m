Return-Path: <linux-nfs+bounces-23283-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HVbaFlWEVGpgmwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23283-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AEC747800
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 08:23:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=MIrambur;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=UxBP0YJ5;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23283-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23283-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82DA23023FBF
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jul 2026 06:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B009361640;
	Mon, 13 Jul 2026 06:22:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A466381EB5
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jul 2026 06:22:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923759; cv=none; b=hOzJY1yfjxCkcxOSkX0xPEONkyZ3uGQUDJBFqwvLadz2oitxb1kiPZhVl06V0WuweOsKG64vTTnTLLzVp4Ccj8BYV7MB0FmJsD2UHfsCjlH2pDdb7cn3/ToqVlHYjdvesWlt3E57NrT56JvaDFZ545swe4I86m/ulHF72P/Dqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923759; c=relaxed/simple;
	bh=Sihrys6In2WTRAijW/uh5ci6E1WIwlFmbeot7pJr5ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=re6fq8qIJz+JgeQpn6lpvbCtsctxd6DBKFNIKa/RQ0wJmPzbOucoglSDxz2H3lxfwjk5fH7098yUHRAMFsUWe1YSYNV+uZUPNUcYNExW1mHfpPE2Gh8VHtaOLmfx4mBOon+vXzA84x2s74tEor0tEJMqAnHQvTQPcmm7ioGOFrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MIrambur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UxBP0YJ5; arc=none smtp.client-ip=202.12.124.157
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCDA97A0048;
	Mon, 13 Jul 2026 02:22:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 02:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1783923755; x=1784010155; bh=b3aaGLM50n
	SV5o9dOkmgJBcKmvSv0BToSi1EJWGplN4=; b=MIramburUoufviaXH2gx35TZyD
	X07kkCJPcCGtoiNveuPaSdjWgn+JYLrtopSTRH9DdVe2HRwAdEQa8sGyzGUsekCE
	+uh8M5HQRM+oiyPSyW2q7pjSVlFRx5P3mrn1vRDnnsJtoJWDQO/vTq4bU9K9v/tt
	cXIUhq8IGCztHhiRaPjD0sLe+ypwIetdagbS7eD3vcynrss2bF8vI6510p1Ac+rp
	zv0nukGqjVcTuYOBeCE+zdT6OGmYlwunVpQL8C51j3e7aTDmzSEDlX+q8DE2+utt
	UVVNHyQHBPe0W9zxWRn1dH1gB6ST05RywN5D/xdCwIfQA3ju6UM5x/nl7DSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783923755; x=1784010155; bh=b3aaGLM50nSV5o9dOkmgJBcKmvSv
	0BToSi1EJWGplN4=; b=UxBP0YJ5m3vyl49TsOiYjVpbVjWuStJZ6OKViqSSd6iz
	1am3vJFpKgJC1S4gbxRRtOX0ixiQSXAmgV7xGvlCXV+OBiiGAKsMUpta9z3Sm3Mz
	R7SfUWWpQFLJ5uDmDYdl48IU1SZVjWUMLZVPRKHqlFb57iivDH5uRJf5bI3H9hO0
	mNw3ZV7kM+6F+uNNWF0dsM16I8z6VctYcL5AOSE0CiLgwGr4VZxu5I9z6hlxKFtE
	FqqTDsAKjYBIysYkq7LVHOZ16VWBFiMErGz5H5hRBKpFgF+itJtyQu8lB5moiwFi
	nQ3GRQ82d3iPSB3Im8vlAzJVmhBtR40kIeDrNl4JlQ==
X-ME-Sender: <xms:K4RUanUxW9XKD1b9Ii0mF53AmLNrr9NKUMnslGPtftSI_6msLXpRYw>
    <xme:K4RUajRukMsdLYwj9A3ytDiAoxAzY560GkLsyiHwN-1PazLx9cb7CP5JXwAkqMeTd
    hZBFRgBcGxg-pJo8WVxDhawJ5LaLqWqFJGJoLhSnOg77BG7zQ>
X-ME-Received: <xmr:K4RUatP-NGiKLPgCc9tTc2xtmeFWZifmKGMRSOMLrME3gAbNSdaXZN46sywtmpGFoKtfLtAWp5xYrMc4E6R9pkpWxIlErlU>
X-ME-Proxy-Cause: dmFkZTFZteYL/X42stvhyMd8Op4TSTcA7vt4fDc7U6re7bTY5qc4xnEEiWsfowAelbmWhf
    ZizNNGzT8wOMjCXSMKntwVFGBcNw45LnlK2jpxXUKe2H3CxGYPLMIaX7dDU+B0lMi5bLpk
    R/7pOpV8SFF4UJ2cReEqWM1lSiz3SWZTmyV3bbQbfS6j9rmOswF3yvaoWc366SVdWRlvRj
    g4pG/1ce6YPNic22Vf/+VoLcEcS/h5mIY6talyfoMC+CS7EE3pmqJVCJkToZDXUmZahcz5
    OKXJQ17ODXDEbL3/cClyLAYO8k/igvB//daSaUGf/DvKLo2qz4dq+CoZCOmxA0mKD10QeH
    PWR8dzQYJjYxS1m9C+QXBkIxFjLSwurTkJoxaKs573CAtyCzvehYci6F7beg8nC2L1/yyy
    SM7R2wdKI04sIGmjkkSgUx+TizQ6M5Qx5dCTcizY9byAAOvxfAo9i9L5mD/Xkj+NNU/ak+
    KB2iVZI2mRnqHhCY098XFRr1esnzftnh0DJBXC5SurL/wso21j+oZdiOX8u/FCX572zSCH
    eApC3mhVXz+OtYyvyzqCQWG3b/1YA3LI6pJzoKD4GzAucKFmzHeMhFNSgkNQBSOrEWZKXZ
    IBLJaP1GWN3fdPlBHb5yZh0/ethoC8Epz3SyMrGPgDT0EewmoQLnQx9LpdUg
X-ME-Proxy: <xmx:K4RUapSB88MIqQU0nEzLStYJWT9abK8WYsooSQc38sDF07aiW7EhbQ>
    <xmx:K4RUajjz_mf1a53Lv0C7HUxlCfh6I9w6O1ZyTUskzbHWtpCNo1ncmg>
    <xmx:K4RUaq_94awBqFR09_2obPBclko_AP_2cOB9xMC8XvEzKdQxUgsNxQ>
    <xmx:K4RUaiG0gFO8lNygHg1oSzk3ykrkvhOHOJQZhuJw265kQA_6JOh9CA>
    <xmx:K4RUas2Gjn-qd-btWNJ29VpB_FiCsNnVuULMqIabA1IPrfNVwbKrZ4FZ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 02:22:33 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 00/17] nfsd: refactor nfs4_create_file()
Date: Mon, 13 Jul 2026 16:15:23 +1000
Message-ID: <20260713062219.6399-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-23283-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,ownmail.net:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0AEC747800

This v2 incorporates fixes for issues Chuck reported from "Codex
review".  These changes are distributed around the patches a bit, but
02/17 is an interesting new bugfix.

This is against nfs-testing (5f5dc3d855cf).

Thanks,
NeilBrown

 [PATCH v3 01/17] nfsd: honour client-provided attributes for
 [PATCH v3 02/17] nfsd: correctly handle CREATE of mounted-on files
 [PATCH v3 03/17] nfsd: replace fh_fill_both_attrs() with
 [PATCH v3 04/17] nfsd: move fh_want_write() after preamble in
 [PATCH v3 05/17] nfsd: move more nfs-specific code into preamble of
 [PATCH v3 06/17] nfsd: remove subtlety from nfsd4_create_file()
 [PATCH v3 07/17] nfsd: in nfsd4_create_file() let VFS report if file
 [PATCH v3 08/17] nfsd: nfsd4_create_file(): Move NFSD_MAY_CREATE
 [PATCH v3 09/17] nfsd: fh_want_write) failure need not be immediately
 [PATCH v3 10/17] nfsd: (almost) always open file in
 [PATCH v3 11/17] nfsd: reduce range of directory lock in
 [PATCH v3 12/17] nfsd: open-code nfsd4_vfs_create() into
 [PATCH v3 13/17] nfsd: move some code out of the
 [PATCH v3 14/17] nfsd: reduce want-write range in nfsd4_create_file()
 [PATCH v3 15/17] nfsd: move v0 checking out of nfsd_check_obj_isreg()
 [PATCH v3 16/17] nfsd: separate out VFS-specific code from
 [PATCH v3 17/17] nfsd: use do_lookup_open() for non-creating open

