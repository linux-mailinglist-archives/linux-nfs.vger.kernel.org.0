Return-Path: <linux-nfs+bounces-22730-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xx72KpvnNWrK5wYAu9opvQ
	(envelope-from <linux-nfs+bounces-22730-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2026 03:06:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 395336A822D
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2026 03:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TlQFYWqY;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22730-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22730-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 768F6300BBA0
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Jun 2026 01:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EB71898FB;
	Sat, 20 Jun 2026 01:06:31 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FDE1BBBFC
	for <linux-nfs@vger.kernel.org>; Sat, 20 Jun 2026 01:06:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781917590; cv=none; b=D5jCf8yUrKPZWdpaR6GtcstyBsQGKUjs+OqvOB5nKCeaq2MIpL7Tz4YGCxq9r/366GM4cnEUFUNxlz4njHyUsQ8JoY+7mrzXKD8nw+ygOpwbFU7oUKUkHFj3xl6fBEqSxyKl1769eFVfaDyEa02KtEXbSUPQIYn7aUq/TjRf+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781917590; c=relaxed/simple;
	bh=3prelMc5dG+0W6Kjrw6lP6dSLPKwItkQ1/0G1SkBz+U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=T8Q0it1FTTY4lPQF/MxeKCLvWSYZ2iH0TXf464iXWr9KRX4h4aFcGGy2bdufIBzJ4dHiiNGZNRiWgneiou5HcFGt/OK1H5HS9j9RWUl3Fe+zBpWr0DKCexAU5UVGcaWEFj/gamr7XcEIiBiN1c113q3oTCeVH247dQnW3pC7Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlQFYWqY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A15D1F00A3D;
	Sat, 20 Jun 2026 01:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781917587;
	bh=SZQ7/SfvsWmVgYqu2LXMzrKhPm6UvoVj5U/q/aslqfA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=TlQFYWqYLbN+NSNKYqa8ep8uQ4pnJxVyPPiD0uhUIGBG3bCjEPGYU6x62UMztSQUN
	 aICzVFpzic0V5KFONvWi94lxGMgIoSx4x86Ndnzb28Ndzk26299F1clljPuy2TfeHf
	 PhyAMGEPWE7J9eXWCEKIpR7/LxKwtnsIxRLZFD2gEvK+I4ZdJ4R2UmnxPv7eVDu83U
	 8k5W/eBC34rzj9mNqYoQKLDpQWavUDon5eZHjd/S5ydtp8vt1ahv0Le5rzIXqn5Uhw
	 LFGn9c7B+VNQe68tyNR94/OfsYRNHXbruzPY9UWoLLtTehfSPtJjRwZu1G0sMO+Y42
	 mcEU83Yj+SNlQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B351F4008A;
	Fri, 19 Jun 2026 21:06:26 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 19 Jun 2026 21:06:26 -0400
X-ME-Sender: <xms:kuc1aoqc8g94z8LMT4VeUXoCEqMAYmdlZi6WX1D0Sc9zEm9bWdfZXQ>
    <xme:kuc1apd2t5mC8295i95yx0BqnIRGoX1FYPzV1KXMKidwfJZY0UG-vtyNUFL1_v-8r
    0z5kRyE2YxLvb125_IiNuBYmR1IhvGQiskCsZ0N8qCSq4Jqaq7Xdpo>
X-ME-Proxy-Cause: dmFkZTFcJ0Odreew0JOuAcax4GfY4AEKiB6fDOkf0l/lqFjmUA8s4L1z7RWdV8n5Gth5tC
    5GJkexNhbeVpgTcltvd3PZTKBnvzujzW5vwbfZSkcTl5OfnUAnAr9N1+KM5LdtdMMXi0Zw
    Fjm5I7pIiTmqo5XXCC76eoNsgUln6pTGW2ek8GYplMUaEC/JISAZ03X9ePWa90XUQgZGyf
    QA1/ReA0XiKdmqkznUmHKI5wQQoscD9V/Fc7j5zD5Mq2ERykXlB7P4p/0ZucYg3Ww8O5LY
    s+mkgwv+pjRAq0PhZX/4XXitNwFTNoXyitcN0lC7dr4QCMN2z/N7RzGq7GjwCaRo+MGZMp
    5Sz/Qcu9L/CzBxNJqGzs89+rUL3YZupo1YBvioN8CJG6B3gLrNGcCnh2e1pkoXEb1Wftla
    CoZCFtr3ixsTkboSth6vBxHYfuKSikYO5HCcdiLHRq+nRacIMdOmJ4sJwldSV376ZvZqfb
    IHXSF4zfUIgs0YOm04abBtaP7kQZ95c4rPScI+rryNSrwSBCyGogFqRHmLBiRavOCIwtcE
    gsTzFABOiEdIDeGz/kt0NaqLnfjil9Y6e1l/xvvVYjiYgwNEw64AkTYhBGUBXC5ACLj9VA
    a1wP2TG5RqgNyFqD9FCh2CWNzzXkH+onRzdPSpnl04ZouPqvNwuIQ3cTtbvg
X-ME-Proxy: <xmx:kuc1amTiBtgVmW-SZxNN0rzCr6N5mr-8DKkm3MH6sRces9cO0MA-6A>
    <xmx:kuc1al2c0ejIC-T6cH05nZNmn4TUIluraM3pR1AqjSRyZtZER9UYPQ>
    <xmx:kuc1ajt9UbNozYWSl7EGNtxIy_ROJuuApmzUPUEz35_6V9XNaRT74Q>
    <xmx:kuc1ajhPArseuvnZAp1AyQPyCs791hLyY-0-LvVpcgqkvE6zQeYs8w>
    <xmx:kuc1as_IVN5J61lAp_FvD37mwOyWx8rVhnuRD_Pl-3bmA9BpRDHIHsvR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32C5E780AB5; Fri, 19 Jun 2026 21:06:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 19 Jun 2026 21:06:06 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <a16c3b22-3b24-4aef-8ca9-d6eb43be72b2@app.fastmail.com>
In-Reply-To: <20260619-dir-deleg-fixes-v2-1-ad22fe2c7d7d@kernel.org>
References: <20260619-dir-deleg-fixes-v2-1-ad22fe2c7d7d@kernel.org>
Subject: Re: [PATCH v2] nfsd: recall deleg if a requested dir attr change can't be
 encoded
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22730-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,app.fastmail.com:mid];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 395336A822D



On Fri, Jun 19, 2026, at 5:32 PM, Jeff Layton wrote:
> When the client requested NOTIFY4_CHANGE_DIR_ATTRS,
> nfsd4_cb_notify_prepare() tried to append the dir attribute change to
> the CB_NOTIFY, but silently dropped it if the attrmask space
> reservation failed or nfsd4_encode_dir_attr_change() failed to marshal
> the change into the buffer. It then returned true and transmitted a
> CB_NOTIFY lacking the requested notification, leaving the client's
> cached directory attributes stale with no indication.
>
> RFC 8881 s10.9.4 requires the server to recall the delegation when the
> directory changes in a way that is not covered by the notification.
> Treat a failure to encode the dir attribute change like the per-event
> encode failures already handled in the loop above: set error and fall
> through to out_recall.
>
> The granted notification mask and the requested dir attribute mask come
> from independent fields of the GET_DIR_DELEGATION request, so a client
> can be granted NOTIFY4_CHANGE_DIR_ATTRS while requesting no specific d=
ir
> attributes. nfsd4_encode_dir_attr_change() now distinguishes a genuine
> encode failure (which forces the recall) from that benign case (which
> simply omits the event).
>
> While we're in there, also remove an unneeded check for
> NOTIFY4_CHANGE_DIR_ATTRS from nfsd4_encode_dir_attr_change().
>
> Fixes: 757a16cd93d5 ("nfsd: add support to CB_NOTIFY for dir attribute=20
> changes")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This version should address Chuck's comments about the NULL pointer
> handling.
> ---
> Changes in v2:
> - Allow nfsd4_encode_dir_attr_change() to return ERR_PTR when there ar=
e=20
> errors
> - Drop unneeded NOTIFY4_CHANGE_DIR_ATTRS check
> - Link to v1:=20
> https://lore.kernel.org/r/20260617-dir-deleg-fixes-v1-0-32b85b366c29@k=
ernel.org
> ---
>  fs/nfsd/nfs4state.c | 43 ++++++++++++++++++++++++++++---------------
>  fs/nfsd/nfs4xdr.c   | 30 +++++++++++++++++-------------
>  2 files changed, 45 insertions(+), 28 deletions(-)

Sashiko reports (and gpt-5.5 agrees):

Pre-existing issues:
- [High] Genuine encode failures and `vfs_getattr` failures are silently=
 masked as 0-length attributes, causing the directory attribute change e=
vent to be erroneously omitted instead of triggering a delegation recall.

But this isn=E2=80=99t really a pre-existing issue. It pre-exists this f=
ix, yes,
but it was introduced by =E2=80=9Cnfsd: add support to CB_NOTIFY for dir
attribute changes=E2=80=9D. What that means is this patch is not yet a c=
omplete
fix.


--=20
Chuck Lever

