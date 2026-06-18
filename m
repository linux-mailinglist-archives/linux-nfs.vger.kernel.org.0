Return-Path: <linux-nfs+bounces-22668-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hRZWKev2M2qDJwYAu9opvQ
	(envelope-from <linux-nfs+bounces-22668-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 15:47:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E106A0AFB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 15:47:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J1D8dOl9;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22668-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22668-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8C4C300341E
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964028D8DA;
	Thu, 18 Jun 2026 13:47:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9245123392B;
	Thu, 18 Jun 2026 13:47:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790439; cv=none; b=pjQYnlG9BJBvCghOi6ZyagOvrCtKVqN/EljYaYzSppbFhsaF9Dsi+AS7t4I/edInRn8nmu4k8/82ALSHjfXfzBsTpWadLER/VVgJmIQfeXofZSKOF2gqB8yNI3YtwzPB2INHwexlCfIiqWfmSH40CLI/1+m7fzNCYBxf1ySfgzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790439; c=relaxed/simple;
	bh=OzTCveUqxSxREZfwATAui+JUH1lISwAbxFh+lIqRo4w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hXMvcbCoHJtxD+ftBoYhy4mhhbpL4uF9HAig7AF4LIzceeT1plreQDJytR4H6MZkr3KdSAqVc0nIh44hF6Oy9nbQmiwJm4uq5fsb0zcgkWfbMR+O4SFutgPyWr++9wviY/Apubvka+5v3DJVCFa8hmM+FwE38QPDpLfuvs8LRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1D8dOl9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41831F00A3D;
	Thu, 18 Jun 2026 13:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781790438;
	bh=Bvq3sTQQdH6/37LIG07RLz3nk+4dfhJf1j0AlJ44g4s=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=J1D8dOl9iOsR/vxRTXPndeUvITyhZs0YVyqxgBffhZXVSHtflslzTXmQEo9Vhf6Q+
	 wLcz0DqKA0MjAXqARfuWpimyCyYVS5RJWbHVPmQUS505h2kXmPsIkd9NUA4pciYiES
	 nRMuN3GK6qq0oZXsm11xoUgLOJsvPhn+MCofgDg5gWqs3k1bB+iVDbzCxH5gcRtzNi
	 /xVDh16son8T4FsqqS7Vyiog2lMPktQjSU9v+hLL61I+NLlUYfgDePqm6wMwPR0IUp
	 Ls5oHGERJvj9kACCiYOCbcVtTcQlbHgWTFpOF3Z2k2aUkU2oXAIp/eDcQyx/X4weVo
	 jDg4FI0uK6maQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id E1BBFF4007B;
	Thu, 18 Jun 2026 09:47:16 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 18 Jun 2026 09:47:16 -0400
X-ME-Sender: <xms:5PYzajhsHPIzsTsjbosEPmu4fQOF9aZHZp3AA1qk9alc0JSysmh7oQ>
    <xme:5PYzaq03g871uYVJk8BC94o3mh9wU9TvvZx_ALMGnZb7kwgsRTwrrBSpKVLCSDC3x
    rGVaO0Jk5m03huQzPk6U0oD87vRUcjTNyd4sjv2GNk1lWpjhvcUOls>
X-ME-Proxy-Cause: dmFkZTGZhS7+od6rKPrNHL8hdXHh4jrwo6gkqq9UgK+oklxTkDHweyrGEfdJnIO1uDkl5g
    QSxy/JU6VUcbbGuilSY4GW5LuiQnNKHd5RhnkjQNJ5PoMnS3hLRMTU+P/AaR0R8q1LGQqG
    uC9+gbcR9w9Uz++2F2iMaJiBbwC/+kLC7uoZ3NE6QGkuFk1jXmhUppgduyuhdcPHYldGV5
    Q+/MP+1WMzTj+AaldqgKpF/eJusXVXpTR5+TPHZ+GFijQzIxW87hI3WEmoy9Y4X9Yoxmbk
    WZ/WLQqHbeKdgxjRmKRIkavdJOlyYxWAB6VVwfRQ74hlsPVpPN++pYXp8U/6WvPwSlsVhm
    ftpgeGwPV2OSB7SeOSOxSG9KNX6lCVkQEZ3UZFmZYQJn5/M8l8xEw4gBooXIykTsmpxxqI
    i+4G2A6Dumnk+EdeRWiO4pxIzxmXegtskoxxG8Jc+TdA4uFCDOKn07RKfoykkgJ8Yc+ylP
    uJY37KlRBWDIPAwqjbQ3pGci5FXTapKjsQrsRnCpslZEuKcI18umMCkXLi6+uEtTZ6GsDZ
    LogD0e6CXq9MUpff8BpeW4xPi/tkNKioQX5LlwLO/q9AHSSTW2hwaw742s1ISxoW2GaRhi
    utsPy9iJn7/Abf0gmoV9CzyhlvINsFTUfHVA25XLvd/eK8XeDZ3oMYEptMcg
X-ME-Proxy: <xmx:5PYzakik4EZeMNGt_SziC487BBbvKLSxoL7iyJsNZcqHBDHwB1_k8w>
    <xmx:5PYzapCgVsSrP8WaI3fN2ad6z0eHmBUTENFdLtYDt29wYhsucTsokA>
    <xmx:5PYzauQNp9TxdlmLqCpup9Ed5VqB8oneQ0clviMhnG9ZSuL52CNmVw>
    <xmx:5PYzamWif1pFO6xOpKmTjm1ZG_qgr512gd3LXE0z4n42iedCqhjheg>
    <xmx:5PYzave3eAaWt9DLNAbJG4n_EBaB-J3i8UNL14GIypdNgUE-y-jdetwQ>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C007A780070; Thu, 18 Jun 2026 09:47:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ACNyiN20PYYk
Date: Thu, 18 Jun 2026 09:46:56 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Pranjal Shrivastava" <praan@google.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Shivaji Kant" <shivajikant@google.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <e9000012-ac58-4520-826d-b5734439ab0e@app.fastmail.com>
In-Reply-To: <20260616134000.2733403-1-praan@google.com>
References: <20260616134000.2733403-1-praan@google.com>
Subject: Re: [PATCH v2 0/7] nfs: Modernize Direct I/O path
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22668-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:praan@google.com,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16E106A0AFB

Hi Pranjal -

On Tue, Jun 16, 2026, at 9:39 AM, Pranjal Shrivastava wrote:
> Modernize the NFS Direct I/O path as a preparatory step to enable PCI
> Peer-to-Peer DMA (P2PDMA) support. Following feedback on the initial
> RFC [1], the modernization and architectural changes are split into
> this standalone series.

Good idea! Following is a review process note:

Please add linux-rdma@vger.kernel.org and linux-pci@vger.kernel.org
when reposting this series for review. The latter is suggested by
the MAINTAINERS file; you might know of an even more relevant set of
reviewers to include.

-- 
Chuck Lever

