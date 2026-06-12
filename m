Return-Path: <linux-nfs+bounces-22536-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rCa9Ao5bLGpjPwQAu9opvQ
	(envelope-from <linux-nfs+bounces-22536-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 21:18:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6355C67BF42
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 21:18:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WxDIYOg1;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22536-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22536-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DD4C30816C3
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 19:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39D8377EB8;
	Fri, 12 Jun 2026 19:18:33 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001DD35E948
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 19:18:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291913; cv=none; b=J2GorECxCb7SOceZHDVpJk1+TeYYQ7pnRpgrbMsCno04z879D2CgHR3SVkQOQdqBqZ3YNIo30rgd3Z7ZGqqATqqcwcrydJjott50w3HrApqnku3EcnW1M057taiBHF+RUUn/ezi9oEzmVf02AxROooLAh5HIw/xd3WasGK0k62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291913; c=relaxed/simple;
	bh=88CznP89OPfh0nx/a4fmeyIxV7J/CnpK9Cztntq25Hk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jzBkrvKT3smLoNxps8jh8a+Gsv4T/pQFthl9F0Mc4CuT1QNBiZc00vvabTF2NDtjOQOwajqCnK4PngwYcw4Rxdxx/KBA7CbEX/gzzqza7EQ61VHCk904eLBlCOWj3VIg5zspcMQHOJuie1MA2qlVxubFTrPfjrWhu9wQT6Xi5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxDIYOg1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4861F00A3A;
	Fri, 12 Jun 2026 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781291912;
	bh=zwQCSTw89WPYHnhN55Nj2O1IYQvWYTQvbh232mJ0G9o=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=WxDIYOg15PqhsW2Xuk0iurVbr3wmoPGhMz6QATCRVNC0oWfh0b46KUBaZURPzKLpB
	 sgJMkpi+MsyOsss8xFVg1cohjfYgcvvszJE8qnZyIH3pMFPUZAnE/bl31D+aSepWo8
	 6XY0EiYPhUL2hv3LPrwryIDZyVDPfDF7Xi43EyVDsXwAVwjs9MjhYvIQM0gltk6ELI
	 SG5xNWLGMp90U9TP83qMNHyeO60Ll5ORbNRfVRdDl9pc8Tb1lu9lmCbhxTYLM0M4AY
	 FN45UNZUm1Ym5DhTaDPLBglPL8B0cntgsmVf9rQdfS3tcPB5xhE12GKHrPeVeXDjyP
	 RCYE+XBaAu1zg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8552DF40071;
	Fri, 12 Jun 2026 15:18:31 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 12 Jun 2026 15:18:31 -0400
X-ME-Sender: <xms:h1ssamIUolYl9cjt8BFZ5h9QJ3FGvwdCN2FgjBWfn7WAF3fv6xgagg>
    <xme:h1ssao-NOSMf-fVjuzehuURw5GlyPkWEVnQYzwpFglMjyk5YT0QK7n7brE4EQIYPK
    S5Wim66vKV0bKSwMIT3bSOdrFcZq_1WzsPFSOb5FYkgdcsjeKwKCStd>
X-ME-Proxy-Cause: dmFkZTF7NItPVs42p0VQdAX0yaqJ+MYLlOpr/quZNqISK1VUlKZcn1pnmcIa+91qTHDpXq
    XC7Clkjb/K4Af3SxFDxSiYXg3X94LUavwAP4XvbemAVLkVgcKHriUBduGwHYkCv8ctPeRq
    f9Obss60LW/Il1ghOsnzXEKUiON5JcZiaINCBvd+XvjeIf0i0B8ACxDtVWOI2UNwPdmNyf
    UMgismEx9BfztCsmSuW13OvG6nVPhs6UrLthtDrtx7gP6t+35H73hdlczaNx44Ck/dT4BH
    Jk7u6gKA49G3VGYLoChWtha3FObjguNdmee3c8ZNj1E3R1NTRma/A/n+1GrJs0ArKGmSNG
    TVN372sVSrR4fPPAG6vXLSDJESnG78AxGeH8MqvDghMBp1NsYVePe9BkwlGeYrurVSUTRX
    AMSXYwgdikcO+cV05JZ1RV5DAdvYW650WOPokASLfji6PxgzMOGph3lFGUfDq/iGpLlNjZ
    3dj207JTVPI3qEFGRSccu3c1HPamnDJqODU3wRiBqNlV/t1qX4+T0+SzBHh2LherMUPXyy
    eOyCQPLasmxVlS1G2S9jD4BVzH+2p1gbVkH4+C6qd6JSamvzARX9zbUF0BtOytQGwW10jp
    rn96B52YOcZLa7KZ87Pt6IOAHUja6S280NWkaEc1ivV+5WItlZY16k7HGtBg
X-ME-Proxy: <xmx:h1ssaoOtjKlKrRnncdw6tLI5A4CP1bZuUu8pJzYWs2Ya7V5i6_R5MQ>
    <xmx:h1ssage9LqlQsvUKMOhPg6MfjM5qU5Jx_N4QKCQIL1kDY49pbtEPEw>
    <xmx:h1ssavWCRJBp9Nvd1MmFFD0cOPeV34cpQ6BdVhdevzooKOauCyVFag>
    <xmx:h1ssagg6rC4JC7tRmRrLMBFuMi5YynCTOMac0PQq6mmQA0JwZWiAkA>
    <xmx:h1ssam8tEWF9Jg28Rg8AjP27u82H9GEY21MjE7eLxUY_VW_KW2uSuTj->
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 64D0A780070; Fri, 12 Jun 2026 15:18:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AX6p6lkWayPV
Date: Fri, 12 Jun 2026 15:18:11 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Nikol Kuklev" <nikolk202@gmail.com>
Cc: security@kernel.org, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Message-Id: <9b3bf3c9-c2c7-4db1-b722-d440ffd8d9a1@app.fastmail.com>
In-Reply-To: 
 <CAM4XWym=NREGQ67b-ypADfJwemnF61dNyHp2LVMpkxphE_+dvQ@mail.gmail.com>
References: 
 <CAM4XWym=NREGQ67b-ypADfJwemnF61dNyHp2LVMpkxphE_+dvQ@mail.gmail.com>
Subject: Re: [SECURITY] nfsd: fix null dereference in nfsd4_setattr for deleg timestamp
 attrs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:nikolk202@gmail.com,m:security@kernel.org,m:linux-nfs@vger.kernel.org,m:chuck.lever@oracle.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22536-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6355C67BF42



On Fri, Jun 12, 2026, at 2:37 PM, Nikol Kuklev wrote:
> I would like to report a remotely triggerable null pointer dereference=
 in
> nfsd4_setattr(),
> introduced by commit 7e13f4f8d27d ("nfsd: handle delegated timestamps =
in
> SETATTR").

Thank you for the bug report. Unfortunately the attachment does
not apply using "git apply". Please resend the patch inline. See:

Documentation/process/email-clients.rst =E2=80=94 "Email clients info fo=
r Linux."

Lines 21-26 state: patches are submitted via email "preferably as inline
text in the body of the email." Attachments are "generally frowned upon
because it makes quoting portions of the patch more difficult in the pat=
ch
review process," and where accepted must use content-type text/plain.
 =20
This doc then covers per-client configuration (Mutt, Alpine, Claws,
Evolution, Kmail, Thunderbird, etc.) to send patches inline without
mangling whitespace.

Related companion docs:
  - Documentation/process/submitting-patches.rst =E2=80=94 overall patch=
 submission guidance
  - Documentation/process/applying-patches.rst =E2=80=94 the receiving e=
nd


--=20
Chuck Lever

