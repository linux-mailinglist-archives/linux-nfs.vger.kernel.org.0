Return-Path: <linux-nfs+bounces-22565-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lc0PMqBoMGo4SwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22565-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 23:03:28 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E99568A189
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 23:03:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QEIjRu0U;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22565-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22565-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866983101FF8
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 21:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A78383339;
	Mon, 15 Jun 2026 21:02:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA864391E49;
	Mon, 15 Jun 2026 21:02:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557334; cv=none; b=MrjzI4GrMcPiEusIQeWNVOZre7IKtDO3O8l/Txcyqo+lZxuCl0qNACBHQXwNqQzND1VDpXmPOtvG6p1HyOlCquFC31QHvRKet5YITCOq1sZPB8XQlQHM+MtZxfgh2KV4+T/rZq6XhahRwf/dfE42ATyqmmFpTCYHLP9bwniGovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557334; c=relaxed/simple;
	bh=s41iXnqBS3EN//qmas3KSAcvkBLlPLobebsrCOnpFRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwAewj/MZVNHrBJyquJdeQG5kFYwSbCuYcLTHu5sY3dCr2LxTD6U2Igk5+XzmsPKTNmeeFIJ4Um489IX5qJctx+XXfMTcwvpkUVRAcXHq+atS9Otax6HFrdg2jdXk76DiUAgQvWDvdIkyVZ+fvLDLK0RKtqVRA6u3yxntl2ASxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEIjRu0U; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F315F1F000E9;
	Mon, 15 Jun 2026 21:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781557333;
	bh=Jku2/OpmuiyvPwKyvy69esCM6N0Xy/x9/NMFC8OhodI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QEIjRu0UbsWgVbyyUhFRY0R0TXczd/9DbFRqPfPnBA57oCpbZ5K+jDSJToZFivfvv
	 3sGYaQf0mfj7gsOF2t8apUW08XTKffn6XNk8liX8np/8+pC52nkN7KVaCogTSPhY4j
	 Tn1uu2GbanK0KSzkAPHJm2SJYswDxmy4kVN2XfmNdV7sJCTvoQhTKYOdbMiiEF0Nzy
	 KVRUp1GouqSo3ZKnMDPDyAR8RCVDQAY7UlV992pBBbEvpKMRYbF6WtNUDl2b2cAAVK
	 qe3MGoav/ujJZrvoZrZqycDdiWfuWpR+3UIj5LF+kuijJOcFWaYqAZ0Tqse0pddCuE
	 X4mWxHA4jdSSw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chris Mason <clm@meta.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] nfsd: validate sockaddr length per family in listener_set
Date: Mon, 15 Jun 2026 17:02:09 -0400
Message-ID: <178155731956.328534.13401607491444151302.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615-nfsd-testing-v5-1-188d75aedda0@kernel.org>
References: <20260615-nfsd-testing-v5-1-188d75aedda0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:jlayton@kernel.org,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22565-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E99568A189

On Mon, 15 Jun 2026 14:31:25 -0400, Jeff Layton wrote:
> nfsd_sock_nl_policy declares NFSD_A_SOCK_ADDR as a bare NLA_BINARY
> attribute with no minimum length. A CAP_NET_ADMIN caller can send a
> 16-byte NFSD_A_SOCK_ADDR with sa_family=AF_INET6, causing a 12-byte
> OOB read across three consumers (rpc_cmp_addr_port, svc_find_listener,
> kernel_bind).
> 
> nfsd_nl_listener_set_doit() also parsed and validated each listener
> entry inline in two separate loops, interleaved with mutating the
> running listener configuration. The validation was duplicated, used an
> open-coded "nla_len < sizeof(struct sockaddr)" check that was too short
> for AF_INET6, and handled a malformed entry inconsistently depending on
> which loop noticed it.
> 
> [...]

Applied to nfsd-testing, thanks!

[1/1] nfsd: validate sockaddr length per family in listener_set
      commit: 1f102d9ff00620b845546051ad1ee57976f2db88

--
Chuck Lever


