Return-Path: <linux-nfs+bounces-21955-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPmmNGKhFWprWwcAu9opvQ
	(envelope-from <linux-nfs+bounces-21955-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:34:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 270E45D6940
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C66A83075C32
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2026 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDDF3F39DD;
	Tue, 26 May 2026 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF5uQqN4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5313DE452
	for <linux-nfs@vger.kernel.org>; Tue, 26 May 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802097; cv=none; b=dpvp9mm+eZw1m3Z7/XDBvo6bnvItHnqtWzsWrIh+a/fl7pQOO6P0hPdhSvNZ91YDA/qD2CjBFifsfqvqgw2zoT4K0lODO/ivpu3r47njRDZt/YXVBd+3eOVNCkdxfaByuRl/QvdKumBqW1bSDZs5F4SmMqxwdNKGdtlFcAagnKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802097; c=relaxed/simple;
	bh=W2fszqpCJROlDxFDIyLILFetCYJcuFYQ+GH/gjrTtVk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gh3OAP5yFQBNnweoppop05IcVBEn+bVBk2PW3JGlOKts2un36jCm3Ta5EyQEm41jPTz9YV0Q7GQ6XrAEI1FXdph9jfMghdWXgNsuz1J8iU+jHtZY2w/XxzXjAye/w+IacRiNSoROvKiwGEltcDTRJMy5Og2zIXPyQoYSAczDF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF5uQqN4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996E11F000E9;
	Tue, 26 May 2026 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802095;
	bh=zhvRiEdb+IN3GAskf2InVkCHEoeGDqzn6qKTF6/uFUs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=DF5uQqN42HhbVp1p91C0vg5bkRahvY82bK+SkkJ0M/w7AHfQ3SwrpzT+Issk1PxoI
	 9ees4ebGp1rimwML9eP4DUIPORloU0NNrjCMz4yK+CbqTZxWFOV8S1rPm/9cd+QARo
	 qxN5jYPs6xvnttjD2f5+RlzWAmF2/9MHpPFtbpPtEHvHusOhio+ujMaNa8E0k0KWah
	 PvKzazaJDnR9qGyzUkrKUiQl1LNnlbSqGSPdva6Nsw2NlGtxjx8H06ojVd8l5NCgMM
	 kmHT666+C1K8O9DWF9BAsHBBqxlhj59DB0gUCfv6i5H+84VTBAe848VvCvM8nYu4+k
	 etwKBYn8D3Qcg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id BD9A1F4006C;
	Tue, 26 May 2026 09:28:14 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 26 May 2026 09:28:14 -0400
X-ME-Sender: <xms:7p8VamElRy-mWaFhg1EJ4AAjDzytRqz9bdZfuE6xB6pOKWpCRASoUg>
    <xme:7p8VaiLk2nvIGgBFht5MXNvITiGGQpmh4aHZIHE4_DHqA3cKYBqYeeYvu0-reIvey
    J6vy1c1RT5etXBbERaHbaov7289KzzCpUKdVtLbrz1RIBAQ6nqEZKg>
X-ME-Proxy-Cause: dmFkZTGvCD41TFwBzAbM/Szf3/QedqMjA4FuF7ko6LIyzN43BWD8Iqoo0aXvfjdzc2kJXT
    8VJpurFQIDLP9V4Iru8pZ8Yvg9CmdgbeJD7IVa1k2a3HPO+1UamWOJc+sVzirKsB0AP2Vc
    /BCs2MtNyj/4TP5CAl8WQ2mozJII28xccy26xkvyuBikn620ZEZxy/vvFJR8azTKetMUD8
    Da+UsNOF9NzyLjH3rJg0I9nvd/YLZc/JK4Ky2xiQDFw79mLJDQydwXShlyReqhaTHWGh7u
    K7V9rWs0gk48VxN9azJVjYpPlBgOE/8TYrc3bR32PKiuI5YBJASY95mHmhPp8i8Rzd8vks
    l1yc70WU0kX1eKlbM4aKS4DV98cxYy4xtfJBw/Yrp1zlV/dUoHcf1WmZXamG9mvyetwsNv
    PFR4eUvAEburIrbYcm4vMPA+q8k3ggjjb+GkxzVZw8Ymw6xZi2cRDXDtOBQDLCnEXaHdbU
    IdBN8yWi76Bx72DjcZP1NZJ9Rk6ZnYSC/6vzEkcXGjliWO6lc5DoCP4QDH1N9wsxdN4Tjb
    MqgF7Ku4UAHULAY+h9Mz5iDXVB9tG8ek7wU86IzWg9yEFJMnI5CSk5Ksm9tPfYADZbI91O
    OXK2pE9EwbbKv0E0KFQhgIW10pSm/dbtgwGJ2bYpsEMJU7vWdIFQORAzKxBw
X-ME-Proxy: <xmx:7p8VanvTGToePzKNK_GFAllosP--OZdQpj1RSeUZFf3wWcJ1iRe88A>
    <xmx:7p8VamSbg2mc0j0XKLb8K5N92wHVgIOJ5efjc1kNmVMP_S8SlP4DUw>
    <xmx:7p8ValM3FtBkv216TW87F_HUlTrGtL0JWpcnaQXwM8tlu2zOpXFaaQ>
    <xmx:7p8VajZuRNiNuGE8DzMicp5GZ4CfsSFM37HUGVB4mm4azz6QvMHCcA>
    <xmx:7p8VanyE2oWPDwpHR3KWEkm43_P5KmbJlfNk74c6juoEUIxQ7oOEIE8X>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 98180780078; Tue, 26 May 2026 09:28:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AGShp_p4hdAB
Date: Tue, 26 May 2026 09:27:53 -0400
From: "Chuck Lever" <cel@kernel.org>
To: NeilBrown <neil@brown.name>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Benjamin Coddington" <bcodding@hammerspace.com>,
 linux-nfs@vger.kernel.org
Message-Id: <40cb481d-105b-408d-969c-9aed9199708c@app.fastmail.com>
In-Reply-To: <20260526053004.4014491-1-neilb@ownmail.net>
References: <20260526053004.4014491-1-neilb@ownmail.net>
Subject: Re: [PATCH 02/] nfsd: fix minor issues with atomic_create() use in
 dentry_create()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-21955-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,app.fastmail.com:mid];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 270E45D6940
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Tue, May 26, 2026, at 1:27 AM, NeilBrown wrote:
> https://sashiko.dev/#/patchset/177969022571.3379282.16448744624428323496@noble.neil.brown.name?part=1
>
>  reported a couple of edge-case problems with the use of atomic_open()
>  in dentry_create(), called from nfsd4_create_file.
>
>  These patches attempt to address those issues.
>
> NeilBrown
>
>
>  [PATCH 1/2] nfsd: fix possible fh_compose of wrong dentry in
>  [PATCH 2/2] nfsd: ensure nfsd_file_to_acquire() does not use a

Hi Neil -

These do not apply to nfsd-testing. Where should I apply them?

-- 
Chuck Lever

