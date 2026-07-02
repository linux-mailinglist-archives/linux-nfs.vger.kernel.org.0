Return-Path: <linux-nfs+bounces-22926-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aEzFNrTCRWo2EwsAu9opvQ
	(envelope-from <linux-nfs+bounces-22926-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:45:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DE06F2D85
	for <lists+linux-nfs@lfdr.de>; Thu, 02 Jul 2026 03:45:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b="rW/MhjFV";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=juJaXlKX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22926-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22926-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 574083062F7B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jul 2026 01:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E870B2BDC23;
	Thu,  2 Jul 2026 01:40:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BC29ACC5
	for <linux-nfs@vger.kernel.org>; Thu,  2 Jul 2026 01:40:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956413; cv=none; b=lJOMDVENW0rHZ0/JURe8cfmMwsOB6wshDrNu/4llwlp+eJviteQElHxbAx25bUoRbnW9Np/uGy8E1SdRks0bQ19hutp5xv6wfL5+7Dpvjf3rqrXhQT63DsyGsmFrByc9jU800Ry35OcM4RhJfvWnNigt1C/RjHjy/TqTmDDQzbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956413; c=relaxed/simple;
	bh=lO6OprdwBDWbu+lpWAS1PnLm/qWnbznHLJZ0gCbeomU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BlT/hZMkztwdr0ZmAfU2ZaInQzL6q5/bW7VEC6c1VpsqwnYRXvH7jlWd5uLB7WgvZ8FKXTBhOhtSu78+pRXWls/y1Ekze3blmYcMSVM4n1wK5PNS0Auforjhpy9KfZWpPUJ7sW9suohXphHhZofhFRgkmEH6NzRQK/Gp7vkkb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=rW/MhjFV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=juJaXlKX; arc=none smtp.client-ip=103.168.172.147
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 49039EC01CA;
	Wed,  1 Jul 2026 21:40:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 21:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1782956411; x=1783042811; bh=lxYQp5Xpew
	YScTm6gp83EtC7vTEEKwWNUGPhPhHMiL4=; b=rW/MhjFVEYHn9K99g0Gq1FTNqo
	KGSf0GljT2Q/QISrrM/zxa+6MfHpJ1sjfCkBdPIH+YHkJu3xxLILPlB+vum4Thmf
	tG55GgikkF8xC91yr4RasQdRw7m38+1uqhwrPXWQjpNvOcanB96beWlIKB4/Z4HZ
	RuINgK1zuAcbFxjEt+gOux698BLqlASM3NN/fwWDjWvcTOo1V04XS6i+R3LX/o2p
	/gyORlTsiFg4okhNV/CxtX53pXO/Pj1J6nD3W6813AzCV72Xtf+J5EsJsfcc8yVf
	YCunum2R7sSw8PU9RN5wPj0M2HuQSd8ydFDbfak+uRBk+83CUPkM6L7vtljw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1782956411; x=1783042811; bh=lxYQp5XpewYScTm6gp83EtC7vTEE
	KwWNUGPhPhHMiL4=; b=juJaXlKXt9dlSc3jeo4aOb+5uczJhsNA7Kw83ocvTKbw
	GbfCnkI0CR676SGduUtxXnj1vzZURl89KetJ5AumZ7idvWzA3q3aQQlzxSPzVrPB
	TYIslOFYs+WoZ2jGXh16ff/e1g0KAzHR1ds3P/Lj7P/vaPv9tCE+rH7kvMxUP9HS
	RK1OgAkWyW5DJkRKDmu4YvgGHECraT5ympZS3ybjuWIYZY1nFUtXl3r7sbiTWvu/
	ldu/coKfv1rkShaNVLUSaD5NM5jwpVgRVrfKnQPLI16sQV2lR5e4g0/DlY9B/l6p
	Cwgd3/Jp+c4ACGpAg1fELpX5LBmyhcbDjm4u4yhDSw==
X-ME-Sender: <xms:e8FFan_LhtyNqOorYH-vXUfFx8mqo0W63YKurh6hSoFsg7qdGDBXdQ>
    <xme:e8FFanYAvrLfLlKPjn-7EzXz6bfrtMo0i-P8k22mKLUiPDfkgdm76nAW8T0YO_BcI
    vaWpNK_GaG0ooik58tIANYJB8pkRDmReDWkvEye1_NKOx8GXA>
X-ME-Received: <xmr:e8FFau2Q29hYF0kRK7eWUioChYLJP5pi6kBEBlKrMlA7ETRPcCcxGHI2gJj_SjvazA>
X-ME-Proxy-Cause: dmFkZTFqj2Md5VJ7jfQaVwYYbIvel3JE9u5r9QDw85qFtFj2jhXFNxFImlPLqXTRBT6ESd
    in5p3dmY6rEI2uVAvsUSQ4soSe9ibLn5tWU2vXoBy5bdru9kwx027ndxVtQHmS8eB4j8Zp
    27I26A+hocF9Jpoc3DwGf/LjaZG+lOS2/BWb7XfLfl4Gxq51qqgrChJxzTVrtUl5ryZou6
    j3nhWe8inMQwBtmNzOFfkhits51VKY+mLVv9VPGK/36peltdM7IZ8WCcU9OoaRCfKBF2uQ
    2m0t0x4G7K4wZ6+GlRtU2zBG8n6TVyKL2emPkeDapH7jpeTUs2/jYfm26DChCsfbpgPbG3
    aKDHGPxnf23klmZ/9fzMefuhudwGsYImn/ALPDVoxqzROOEEhrNoEKZYpW6hM8N6SkBEh3
    jzgDVYtzrOVNsM9DGxfEDOGWqlILHHABU9DHBgQepnoAJDBB2VmmueCjQ6NqdBfwRn6J++
    QNYVEgIfXCcbXbuOlm0Bsymuzoe+IDrsWAocqd0SF9Jx96KzDqHB/+ihrNjyoHfaAVyUqu
    G2XXUnNi1syqvIi+guBdEKsckZaOwaaF64pItC/4ml93S7l7/FccwqNoTXeqmggP/fDOYs
    fcDKJhdDmEPCh16KW3x2LiVQL8Dnu7T9XUNmUcUTnPBkr66YkmzvQ+eRRC3g
X-ME-Proxy: <xmx:e8FFaqYSG54o4Pt8RvNEiIQDUJqB_grcK8yop6RoZztaDUlHfiyUog>
    <xmx:e8FFauLjxS8-lNHZwvnlm8TFG49oRPnfRmudRYBc3y4A-r4Sla9ILA>
    <xmx:e8FFahEyh8GthdqgSWmMaQYSmHQABWwkGiPqECsWeoIYP9WMdU0Rzg>
    <xmx:e8FFatsNQNE0DaQ9nAKx5jYoRApOf84EmonLq_kI1FEicahjDfq6nQ>
    <xmx:e8FFaldRMSMeLTri3_lAsvsLVPt1TLQV2HdJrnPKSLHq2aUEhxyZGJQ5>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 21:40:09 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 00/10] nfsd:refactor nfsd4_create_file()
Date: Thu,  2 Jul 2026 11:34:19 +1000
Message-ID: <20260702014000.3397240-1-neilb@ownmail.net>
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
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22926-lists,linux-nfs=lfdr.de];
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:replyto,messagingengine.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:dkim,ownmail.net:mid,ownmail.net:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37DE06F2D85

nfs4_create_file() duplicates knowledge about opening a file which
exists in the VFS, mostly in lookup_open().  It does use dentry_create()
which shares some code, but there is more code that could be shared.

The nfsd code doesn't get some details quite right, particularly patch
05 shows this.

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
NeilBrown.


 [PATCH 01/10] nfsd: replace fh_fill_both_attrs() with
 [PATCH 02/10] nfsd: move fh_want_write() after preamble in
 [PATCH 03/10] nfsd: move more nfs-specific code into preamble of
 [PATCH 04/10] nfsd: remove subtlety from nfsd4_create_file()
 [PATCH 05/10] nfsd: in nfsd4_create_file() let VFS report if file was
 [PATCH 06/10] nfsd: nfsd4_create_file(): remove NFSD_MAY_CREATE
 [PATCH 07/10] nfsd: reduce range of directory lock in
 [PATCH 08/10] nfsd: open-code nfsd4_vfs_create() into
 [PATCH 09/10] nfsd: move some code out of the d_really_is_negative()
 [PATCH 10/10] nfsd: reduce want-write range in nfsd4_create_file(

