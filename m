Return-Path: <linux-nfs+bounces-22801-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hgcDKp4MPGrljAgAu9opvQ
	(envelope-from <linux-nfs+bounces-22801-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 18:58:06 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B56C0263
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 18:58:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZNk75iV6;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22801-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22801-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6FB1312F7B8
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C078340DB8;
	Wed, 24 Jun 2026 16:52:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A693403FF;
	Wed, 24 Jun 2026 16:52:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319956; cv=none; b=qkvMwUFexMt9OF7p6LZQGPXX2m7Fbv6LZIS+oV+DY2qNY7MKtI46HNtM2GKsGvSAmmN/KbdEC/UcvTmMsGbuqgFGf2EgOTrTsPX1mlkPPIJiiUIoTYnUXr7Osb4JyEzOTSkPrfMWlopRBqdNU1cypSLhNhhWDWcqVOYchSAUzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319956; c=relaxed/simple;
	bh=eC5Wtqb/LTJHsD/VbW5QPtvYZoT0SyWymiXngnYjRBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8NtyGo46DK+lp0cw51bLGDT5Yfh1pumQXrg7ONeZUKDDjQh1B8HGU+bEnDHHZzZ4FgQQpW6Lgali+3vjm/sq6NWNZ3wtRDn5qKCXPvjmKdMq7DOy8TxvPK85uQzZzuhanl0CfIxmT1OPycwgI0Eq1k1P8EWmqlbPdmcJAzWXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNk75iV6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CDB1F000E9;
	Wed, 24 Jun 2026 16:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782319955;
	bh=eC5Wtqb/LTJHsD/VbW5QPtvYZoT0SyWymiXngnYjRBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNk75iV6f0TJSnB86o/JZDI0zbCdW0v3/eF4E29xKJr5EAH/muFcFAH4n74CGOEiw
	 8volv8a6sNwg94bzpzxiMzt3wLqE54y7wQM2DYqb3N0pBHF1k7VcAxTSm4cqPPvZlh
	 B5rhQOsrhz/F0KNAqemdcThXjM5dakFXa4eDOa1z6grDgjFLwRrne7GRqNjgNfMhUQ
	 UZ/vatWB5UdG8TDkAb12ADQ+ekRlhcvZS5PDbbMy93FsJi6Bl7yqwz54Y3Z/9AgPZ8
	 1myaLf99jkPTH8pjBuev5O0Y1zXJ6pyie377mnIEVxc/391N26jGMAYjQ3UNgP66rD
	 fQM95We4Oi64w==
From: Chuck Lever <cel@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michael Nemanov <michael.nemanov@vastdata.com>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 0/2] Fix a few memory bugs in RPC-with-TLS
Date: Wed, 24 Jun 2026 12:52:26 -0400
Message-ID: <20260624165228.2920869-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
References: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:michael.nemanov@vastdata.com,m:chuck.lever@oracle.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22801-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B1B56C0263

Gentle ping on this series, posted seven weeks ago. Michael=0D
Nemanov reviewed and tested both patches the following day; he is=0D
the reporter of the use-after-free that patch 2 addresses on an=0D
mTLS mount whose client certificate the server rejected.=0D
=0D
Could one of you queue these for an upcoming release? I am glad=0D
to repost against a current base if that is easier to apply.=0D
=0D
--=0D
Chuck Lever=0D

