Return-Path: <linux-nfs+bounces-22842-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UyMHJMRuPWps3AgAu9opvQ
	(envelope-from <linux-nfs+bounces-22842-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 20:09:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF606C819D
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 20:09:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XMreICqz;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22842-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22842-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D27B63016B5C
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 18:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287C2DF59;
	Thu, 25 Jun 2026 18:09:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128872FFDEA
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 18:09:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410945; cv=none; b=JoPocnx82GF8gvQohU1B3jDEUs4vGZ06hfgM5Zd5uzHkQw01tOnsykt/K1MxgWAJ0UGNs330IbH6EFY23mKGu9k/jyc3ioEkDSIrY0NO2Mz1RvoKn96qMsAg0F9/1QntmN8JYb0cIbuXsgNmLiC8cdUQFw6aRlZl0ZD19eQu/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410945; c=relaxed/simple;
	bh=URhoe/12787U6wk+0zIE+oV4H7YxcHOVawrEu5vvfDQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XmCUQyZ0LLpqnix8Ih9NtnXjsJk1oqOL3Q/brMpO1emRY0/CjwvoHzEBDSrT8opfwQswdPpjJWDcQgMJrHsyFZ69/RM3Qcqmo9Eoa/tsubBAMEL7hvFqxi0xlonjIak1JoUbuEYtrISVsCJOKgxdDzia88Iuzccv8eGcQIT/ssM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMreICqz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADB61F00A3D;
	Thu, 25 Jun 2026 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782410943;
	bh=EaYrFb+aKPglSiaKMJdIRuG5zOXc65NEAeoSwbWzbr4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=XMreICqzlQduJgM/wSUomOFPX4+co/i9g+nKt+nI13DsjqJC7AR6QI/Osvn0cZ9Wg
	 QFsFC7VZvCboGgtiTHPs2RoGCQc3sRSrdEtdelYiyu+DuKmfBxysAH5XWMcPH84DpO
	 OyB/Wdt1qAx9O7SeLNQLhcEcu12zoV9UDwr1dyMiecWtpzq03qJOXCHJN3EzL2iYjz
	 dC/czN0lRQtEXtaEkNtyN0ZmlcEOIn1SiHcfAo5q8Qc30x5cmahoRIp9dbWNxB5CbK
	 6x8Pr2Vfjvw/UE2Wd7mvWZXjNPwLcvG3gizWUhXSpOx5VgsezyDyvC8nkdycbMob2l
	 rOAWNcIbfS2kQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9E836F40073;
	Thu, 25 Jun 2026 14:09:02 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 25 Jun 2026 14:09:02 -0400
X-ME-Sender: <xms:vm49aiGv_9PsxaDBJSmsXlNTd96FVjetoO9CaUQEvYHAVI5bahPUuQ>
    <xme:vm49auIKMOfynPBMrT-XmM4liBaR9iLU9LxU1j5-HStdfSuSrZzM0sKbWe0pnIsdr
    H3e_iytNVG1gTx6x-QULPx2cFoha-AQTsNSHisy_zDG79wnji-vTw>
X-ME-Proxy-Cause: dmFkZTFs1C1q0xopVpmFf75RP4Jetd0cOSVsvl5PaT570P4R4/k+R2g1vAejGVwK13j0aT
    tV99+elyAz43t9LhWphO6Rf5Wsev1Ci0/xPTsNEuUOf7DAu0Jdeyq1u+t7C5bwV21MTKCf
    QPR/In477gdxdarbuG6ZHdKPsr6LwG1ccteO9z/iEJOuT/XUcoExFtbVfSX2YLx+SNAkc9
    GoMmMYt5002RqtziN5A8I5q98437Cv5qhpsWggqNW/5LlP0vtBhcHLYe6gm4i8+Ca97T12
    yavJkhP8ONhjG0EDR8zqRbFf8nm304FkSi03AbCkuZBqV0rw+zJsDnGzu63boQIbh2/4LB
    nAS3BuzESR3ezaOPQjvF+q3QC2JQOGLV6EHOFkBCBtRaYceXvSKlCVMBZC+UJc+13kDS+r
    dfgwu7UypJ7D+ecd3LrV0wTG86PGOUCiDjYz7PEREnzoYld2aS9wrhDXpZ4c97GqfA5Cqr
    Nq+6ZRdZWKEz2rE8RaGwuATvvPdAxMisrYOkzzA8ELsEw664J9fi9fcpGXDQCo1zQ/IeMA
    +8qCRyvt2MbAYuRAavehudUORhWdzV9RGTWArQH7GaDueonvVycHk3z7dIH3GsmSlH3WnV
    zjk9rkduYFdnx0JTkkqJsVmt0leeS/Wm3t3CI3YiycVguY77w4LHQC/pyDzg
X-ME-Proxy: <xmx:vm49apLDs_JZXyiHMjqOmvHTzenq-LrTjJcKh7syQeYh6zBJpG4s5g>
    <xmx:vm49aiQu7fN5D6MvsdcKHSEZemkGptlygXnHymm-zdv4QJs_2ZBwzQ>
    <xmx:vm49agtXnbiviTizOfG_cnFCEHAfERgph7lTmxV0Bpnv0ct-AkoBBQ>
    <xmx:vm49arY5jxWGvTDMChq7_hmYnshZ6P65ghuPR3qYigRJc_4WrMAb8w>
    <xmx:vm49auFXDtvIGyhHnmgewwTZ8dNl-XOIn2kh8AGJM1kqsd1UysFDmMq8>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7F7EF780ABA; Thu, 25 Jun 2026 14:09:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AuAPBZ_DauHw
Date: Thu, 25 Jun 2026 14:08:42 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Mike Snitzer" <snitzer@kernel.org>, "Anna Schumaker" <anna@kernel.org>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Thomas Haynes" <loghyr@hammerspace.com>, linux-nfs@vger.kernel.org
Message-Id: <95f1c397-0630-44dc-a1d4-6e093c27fd6e@app.fastmail.com>
In-Reply-To: <aj1l6i8ebnkHu67U@kernel.org>
References: <20260624191706.72544-1-snitzer@kernel.org>
 <20260624191706.72544-2-snitzer@kernel.org>
 <16ff281b-f776-4e6c-9f2a-83c03f0d6eae@app.fastmail.com>
 <aj1l6i8ebnkHu67U@kernel.org>
Subject: Re: [PATCH 1/4] nfs4.2: add nfs4_2.x to generate the UNCACHEABLE_FILE_DATA
 attribute
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:snitzer@kernel.org,m:anna@kernel.org,m:trondmy@kernel.org,m:loghyr@hammerspace.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22842-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DF606C819D



On Thu, Jun 25, 2026, at 1:31 PM, Mike Snitzer wrote:
> On Thu, Jun 25, 2026 at 10:26:22AM -0400, Anna Schumaker wrote:
>> Hi Mike,
>> 
>> On Wed, Jun 24, 2026, at 3:17 PM, Mike Snitzer wrote:
>> > Introduce Documentation/sunrpc/xdr/nfs4_2.x for NFSv4.2 protocol
>> > extensions and define the UNCACHEABLE_FILE_DATA attribute (attr 87)
>> > there, verbatim from draft-ietf-nfsv4-uncacheable-files Section 7:
>> >
>> >   typedef bool            fattr4_uncacheable_file_data;
>> >   const FATTR4_UNCACHEABLE_FILE_DATA      = 87;
>> >
>> > This mirrors how the sibling NFSv4.2 attributes (FATTR4_OFFLINE=83,
>> > FATTR4_TIME_DELEG_*=84/85, FATTR4_OPEN_ARGUMENTS=86) are defined in
>> > Documentation/sunrpc/xdr/nfs4_1.x and generated by
>> > tools/net/sunrpc/xdrgen into <linux/sunrpc/xdrgen/nfs4_1.h>, which
>> > nfs4.h already includes.
>> >
>> > Wire the fs/nfsd "make xdrgen" target to generate the definitions header
>> > <linux/sunrpc/xdrgen/nfs4_2.h> and include it from <linux/nfs4.h>, so the
>> > generated FATTR4_UNCACHEABLE_FILE_DATA constant and the
>> > NFS4_fattr4_uncacheable_file_data_sz size macro are available to the
>> > NFSv4.2 client support that follows.
>> 
>> Aren't these client side changes? The xdrgen stuff is used on the
>> server-side. I wouldn't expect any of these values to be available
>> if nfsd is kconfig-ed off.
>
> The NFS4.x client code needs and has access to NFS spec definitions
> also, via <linux/nfs4.h>.
>
> Its only that the server side's xdrgen framework is needed to generate
> updates to the headers.  So you'll note that I have also included in
> this commit the gnerated output of <linux/sunrpc/xdrgen/nfs4_2.h>.
> Even if NFSD weren't Kconfig'd on, the NFS client code still has the
> benefit of these NFS spec definitions via <linux/nfs4.h> (and its
> inclusion of previously generated <linux/sunrpc/xdrgen/nfs4_1.h> and
> now <linux/sunrpc/xdrgen/nfs4_2.h>).
>
> Getting xdrgen to build and verify it to work took effort (Chuck uses
> recent Fedora AFAIK, I happen to be using EL9.6 in this container, but
> Claude code helped me cut through the missing deps pretty quickly).
>
> So to be clear: the Linux kernel build (and NFS client build) isn't
> dependent on xdrgen running at build time.

Correct: The Makefile changes are for a target that is used only
when the .x file changes, not for rebuilding the kernel.

However, as far as I am aware the client does not use the xdrgen
headers for anything, currently. Changing the server-side should
be done in a separate patch and only if the server-side code also
needs the new protocol definitions. Otherwise I think we continue
with the duplicated infrastructure -- or only hand-rolled, if
there are no server-side needs yet.


> Tangential but related: maybe the xdrgen stuff should get lifted to
> fs/nfs_common/ ?  Or we're fine with it living with NFS server?

We're not that far along with xdrgen. I haven't heard any interest
in the client-side maintainers adopting the tool-generated approach.


-- 
Chuck Lever

