Return-Path: <linux-nfs+bounces-22995-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /nVbKsvYSmpQIgEAu9opvQ
	(envelope-from <linux-nfs+bounces-22995-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:20:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA570B9A5
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 00:20:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm2 header.b=FI7vLa55;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=pThDRfOZ;
	dmarc=pass (policy=none) header.from=ownmail.net;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22995-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22995-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C2C93008786
	for <lists+linux-nfs@lfdr.de>; Sun,  5 Jul 2026 22:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A379253958;
	Sun,  5 Jul 2026 22:20:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905535E944
	for <linux-nfs@vger.kernel.org>; Sun,  5 Jul 2026 22:20:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290046; cv=none; b=K8lYqHuFXCrh+1cR7fNkn82WCV9kSK8+dDl45OQdorRy80iLu6HRvwv8u0wvElCQ+cDCv0RmBqJ+znI93A5snhEerNiXQqGD7lusuqW/hTaj48cwhTsQvmDEeArO2WcU4VwyToep6NPaacSnL7BfB08NSze7I1J71ceSjWZHrsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290046; c=relaxed/simple;
	bh=Pu9blrtPa1WGsLBN/varZY1/nHGC7uGchYsAKL40IeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQoN6IJdeEK0FfkkuU2sntmiXm75RtkPCmivVAaSqXPu5Kznj7f5gS5txfJLFNE87CC8JYatD9Zq0J5NC0TxPWhfBb0zBoO+LdMm9nJiWO8uAOyJUAW0fElUFsQtTpdrT74jYyKTvOOfSu8icxeoF0gZOquPfZJBj9WzApqRMaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=FI7vLa55; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pThDRfOZ; arc=none smtp.client-ip=103.168.172.150
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 9181CEC00A3;
	Sun,  5 Jul 2026 18:20:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 05 Jul 2026 18:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1783290043; x=1783376443; bh=OD840oJL5z
	pGq+Bm0rfimUpyGMJETXWo3+CLFJUJQNs=; b=FI7vLa55ERBDyUCZ8uKZr6+1OC
	mCa8rx6627Upp6jLRZZF8edjMAzb+g56Md4TF12zT/v1VEL1Il/CgHZ62nf/l5Oh
	zCc0B7InE0AGQzaq3UkNFcNogob4zVqu9mhYmQ/zqz9ukLWwUkyvJZun2PnS+6qX
	kMRAqjxoeu0H+7e8EMuHtpnT68qbN9vYVTfGbXfMKZaQRcZCTmc+2jie10usmZ6A
	yClmjZV7K35CK40SgWJBwxoXyeuy/8A/uA9LRpkwVj475e4gLThRXqyPSrqo5i4b
	V7Mggz3c4ok16EaMj6ugOSt725qcekX63Yk7WOjceWCzU/VY4xwO1ODemdwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783290043; x=1783376443; bh=OD840oJL5zpGq+Bm0rfimUpyGMJE
	TXWo3+CLFJUJQNs=; b=pThDRfOZ6OSFsRt0bEozc9+7xhAC9/qtuIoG9hL8jb6/
	6ltcFuaDhehdBFYEw69fY+9VNxliD5MIrWLdUJHYiX6CpE8+Q+GJwOnUpIZqXdJB
	yCv4FJpZXOfkhlc1CMG8vJ08ydGhid914bvGE3UkiKxO0mYbMuf0YGdZSD95cZaw
	mjrjmtlXew/g6mlK8zaHNPKeZXoDruOIvULZdEJcrlmEgJy3XdWk6q0sG1+y9EII
	ifHyKuQ2IOVvgWIOG6EL5/Me8e54Hc0lWSOS6ONMfSChmX0iQ+W8SGERnz6kjrFm
	5dOBUr0/zHpZ08Bdv+cqr8bDP7ZIuMViFYWMyW8quQ==
X-ME-Sender: <xms:u9hKanGuQVkmYaMP1x8t72SWYnGSz2Yst8brVM2_0nWRL2L_9W65IA>
    <xme:u9hKaoANTsl-ev2Li-yJHenXPbI5eJq6zHrks4dLxTUX7rKvZk_RVZ8rAGOLm_nE2
    Uu-CHHOKbVQGe9fNkoMhoXO4McaVhPFK10hwVboes4oxcb5UPM>
X-ME-Received: <xmr:u9hKai8aIJGTY-XpcgXFJ0dwXuB1uQSsSDmX925XIKlOcAS8S-aDlGRqpz_cX-UeNFhjgCQv0Fq3ezfnb18BnGSW5i-WcH8>
X-ME-Proxy-Cause: dmFkZTF5ZwH+BpGUQg5n26VOY4Wno/Lt53cr7WHMGgkzeoJd+yALhQ/cN7be99cIrxSyBu
    g3UFbtqMmG8mgwHiIRKCOMgX96zBOP64NG1EKv7WABtHWjq3eWgPxLchuITVggcCd/0/Pw
    PABYp6AncXyOoX9poRr/KCEphflnkVZ+Vf7lscFc1+ZK+h1zaw1zvNDoHubQdO/wL2NlGS
    yku9EGwq8AkakQyv6fQNZXOTmbxUDikjwv2sgqZP3N0JA19GzpXJD1R4TMG6CGQib0IPCY
    Ha/3H3VWeeQbdiKbf9gWBIw6zDRl4+q9EkeAy8MsntfIz2jvv+12PcPp3Wz2qpBDQPMPSI
    lzdigA41Qc1uuEPIq9LyGJVDwuRCA39JHRbW+9tKHf5Q0Er8DPQfL/PldqOK8y4mZGeH9I
    YhumUk/FRPporZ38cCOiglQXBIqG2mbeflbD9TpqCaJifULugViLBwIm8rx6FMnxJyuUXz
    yIN+XVAeYkMEYXg12c+2T7IIEjqIdSwPPQ54ilFcyYSSf+UYV/oNCUKCAGRosrF57uyI94
    yTEjTfiSOHNAVPwbeIrqLlshhCGw8XOuh0YVk55+OLBI5T+/rd1FeSGZtuFVhu9O13eQlA
    AoMGlhhqgEm7rTT7FTWiNhyBcAHMYEV8oG+ICPI+0xe72uzBcPFQeBFU/S1A
X-ME-Proxy: <xmx:u9hKasDPcmuSmeygwwvxVp7XwtMETSBgUSIQiujlsiFD0hPRsdxWsQ>
    <xmx:u9hKavTD_lHkoY3DQCOo3EqbHIl27hoT6TTlRsLnN-cFA5vpl0DxDw>
    <xmx:u9hKarvFppncdRhwUatzrB7XL-B-I7yxFhEVDs9piNKh7f-8nR-vcQ>
    <xmx:u9hKaj2pFMLmY9LVDdE-SBNSuNwW95ebCuyjMN3hgG_Fj86Z424Nag>
    <xmx:u9hKatNgV_pk6Xpbd2UAoBk6gYKjYD7CWwrRXLowRNXQGf95O2N7JT8f>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:20:41 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/14] nfsd: refactor nfs4_create_file()
Date: Mon,  6 Jul 2026 08:19:32 +1000
Message-ID: <20260705222032.1240057-1-neilb@ownmail.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22995-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11EA570B9A5

This v2 incorporates changes to address issues reported by sashiko.dev.
Of particular interest is that for open/create we now get pre/post
attributes OUTSIDE of the locked region, so we cannot tell the client
that they are atomic.  This is a slight regression in that it may
require the client to revalidate the directory contents more often.  We
may be able to address it by using directory leases.  It would rather
this were done after this series lands, though I will try to get it done
before making locking changes for other operations (mkdir, link,
symlink, etc).

This series also goes further than the previous series by completing all
the nfsd changes.  Once the planned vfs_lookup_open() becomes available
we can simply switch from the current do_lookup_open() to that.

Original series description was:

nfs4_create_file() duplicates knowledge about opening a file which
exists in the VFS, mostly in lookup_open().  It does use dentry_create()
which shares some code, but there is more code that could be shared.

The nfsd code doesn't get some details quite right, particularly patch
06 shows this.

I hope to introduce a new VFS interface which encapulates more of what
nfsd needs and shares more code with lookup_open().  I particularly want
this as it will simplify some changes to locking rules that I am working
on.

This series re-arranges the nfsd code to get it ready for switching to
the new interface.  Once that interface lands we can then switch over
fairly easily.  Hopefully the series helps clarity even before that
happens.

The series is against nfsd-testing.

Thanks,
NeilBrown

 [PATCH v2 01/14] nfsd: honour client-provided attributes for
 [PATCH v2 02/14] nfsd: replace fh_fill_both_attrs() with
 [PATCH v2 03/14] nfsd: move fh_want_write() after preamble in
 [PATCH v2 04/14] nfsd: move more nfs-specific code into preamble of
 [PATCH v2 05/14] nfsd: remove subtlety from nfsd4_create_file()
 [PATCH v2 06/14] nfsd: in nfsd4_create_file() let VFS report if file
 [PATCH v2 07/14] nfsd: nfsd4_create_file(): Move NFSD_MAY_CREATE
 [PATCH v2 08/14] nfsd: always open file in nfsd4_create_file()
 [PATCH v2 09/14] nfsd: reduce range of directory lock in
 [PATCH v2 10/14] nfsd: open-code nfsd4_vfs_create() into
 [PATCH v2 11/14] nfsd: move some code out of the
 [PATCH v2 12/14] nfsd: reduce want-write range in nfsd4_create_file()
 [PATCH v2 13/14] nfsd: separate out VFS-specific from from
 [PATCH v2 14/14] nfsd: use do_lookup_open() for non-creating open

