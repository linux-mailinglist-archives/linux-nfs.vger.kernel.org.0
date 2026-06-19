Return-Path: <linux-nfs+bounces-22683-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q/t7LKOKNGpFawYAu9opvQ
	(envelope-from <linux-nfs+bounces-22683-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 02:17:39 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1296A32D0
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 02:17:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nughfTNH;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22683-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22683-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 177993033193
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 00:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FBB7261A;
	Fri, 19 Jun 2026 00:17:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC1D54654
	for <linux-nfs@vger.kernel.org>; Fri, 19 Jun 2026 00:17:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781828255; cv=none; b=e+ujj0/WA1KdHPWLjnTDTT3XobpAvHzWEeKMsrjaoKcpJxuwC5SQJBwtL4JWZ3qL6tpCueUeSSR7lv1xrQRyL3nt0F1DOUSKV/53IOnYG5H6D1n9lIG36nkNcfHbSwLpgSVgi8qqqVr5LztTsx0HZnqZhpCj9BO6oMCpGObBvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781828255; c=relaxed/simple;
	bh=Bl5so3duiSAXoksk5AzcqisXclRthyx05BslWZYU8UY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=A+RXjiD2Ylspdvv+y+VCuumuxV7thkW7mOmKTmf8hXey05+p9iZKqrJ4pL53/weCp0TT3HVVuY5Tc1bt5ymIVDlm8qg7NFlgW6wtn77Y8g5PknU3QTkrkuvVj5lWAk7XWU53716HhENT7q+6ruzSHXv6qE5+8o/gxAyhxYEJ964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nughfTNH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA631F00A3D;
	Fri, 19 Jun 2026 00:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781828253;
	bh=AFIkrNrHgycA8bRVEuXFMTKEDW5jhstA494sa5dQvyM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=nughfTNHkHPHWJ9HU0AN16BVT3mwDpDVOip5BIozKHIsCAn1Harj26IkBprOoa9Gf
	 shK7EZ8MA8q+JZglgBDRLS9vuYCkoc1eeqm3N21QssozqU5WCdfIVH1uqgTnVHVEvL
	 baeO5DRwH07HSJbJ5uI0iLmO62FeUSue4yWjHRE+ce9f059l6h/PN+DMBdUp00xUUp
	 yTWqEwkd282lSR2Uga5zgSj/ucks91SC3K64UFfX+6Srji+mx4zjw9W4HnzSf+FvbS
	 b6LxgX7uqS+yoXjGv9Jv7OErm3sH+h1PIihCrha0UPe1uDvR3n/pyYjNMx38Ep7Xr5
	 MeQzR8hVUKX8A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C4CC7F4007D;
	Thu, 18 Jun 2026 20:17:32 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 18 Jun 2026 20:17:32 -0400
X-ME-Sender: <xms:nIo0am-hgq5AI2mcWBzz7jhz4DHdSvZXdNtVdLZa1me93XnRcP0jvA>
    <xme:nIo0ahhKi5rOKA0jvY6gl7-hKl1XivUxM9T9LznQJO6EVyop4i2ofrQ4XaBFLEk17
    I3n_bRENx7S3L-aOPx9yR9SR8IxkJTfjV9KfN-kHUVaKx8T8ChQ9Xw>
X-ME-Proxy-Cause: dmFkZTE8rwBbmtCmFHUkPYeP3kagMIlKMTn3E4VNmfIwLrhEQqeRKz5g43yRgLsy3VKbnn
    5UWKUHq2VkgTv27+DDow6qYnnGwW6xc5ZBGDL8FJJ4pMDNM1jIuSwRL3qk59JC597LmQvd
    lkbBkW2FL7+l2fi502jQaKSD4WYf/DPyqquklXUCsZYhoqgf11W9Kx/mVVOgEl1Mg1xMiN
    VGaSPvy7jKe6pQmo2ZcVFbLoozCLMoxFI0DKTMA9LE09Fc+oLJ7nzmthIm4+xDK93jkn1b
    lO0NAYtKbo4j6+2MRAPtZQKoJOYXcgkkZoa/BKyWy4Mu3CxmlkJrx/Qcp/aDbzQes1/tPj
    FQT/iuRw+8Qhy2ckfHE7t/oaTN1a/0G46fSDsyh0v6P3QW1BItoTg6EN+djqdIYaJWsvhy
    ikGYumeoP6QOLgjnjP8DNKCOGAhkXLizlwpqBePnVcMsFs/q+J5twqF76xDf1bP0QFi9/v
    vtgHl6wlnx/B2C3fqGfmpsqr2HYmhk0oKD74aMBO2KhWaSeLdcXCHWUv6mhP1EznyMcepe
    hwrwd5pzpiLswQfYGjYFuUI1tQGutJDg4g6dseYPdu8zYF7+X+K3Kld4VD+W2Qe7FlMCa5
    6e53ZlWyfKyacUpuSRHQZWcApG68PczziHeHkb9vHtDqzDFqpAw4G1JYDHFw
X-ME-Proxy: <xmx:nIo0auIiE3CT_MR7MWk2w0dTqWHBDChBS8Z-TD-286SHiW9OBkcm3g>
    <xmx:nIo0asJd1-ZGLNHwmbu13DLqWZOaWvRPhUBd9FVE7Lz8fUwqGJm7Nw>
    <xmx:nIo0apighwbbu3nRaLWswlAZmDCqqRmE5w9W33jA2Tr4ZOckm82KCQ>
    <xmx:nIo0amMBmkCM0qch6DXJJJ8YnNtsJ3CF31zlUnkhn3qBtyhSyun8Ww>
    <xmx:nIo0akpLkIk716XoaXkyNz6mSTeNBfpWl0MYH9Bs4u5EUYNSoeTwTU0q>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A44BE7809DD; Thu, 18 Jun 2026 20:17:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 18 Jun 2026 20:17:12 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <73060044-e8fd-4944-83e7-497e1355332e@app.fastmail.com>
In-Reply-To: <20260618-exportd-netlink-v5-6-e9aef947af3d@kernel.org>
References: <20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org>
 <20260618-exportd-netlink-v5-6-e9aef947af3d@kernel.org>
Subject: Re: [PATCH v5 6/6] nfsd: export NFSv4 callback op stats via netlink
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22683-lists,linux-nfs=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F1296A32D0



On Thu, Jun 18, 2026, at 12:58 PM, Jeff Layton wrote:
> Add a proc4cb-ops nested attribute to the server-stats netlink dump,
> reusing the existing server-proc-entry (op/count) layout. The first du=
mp
> message emits one entry per callback opcode (OP_CB_GETATTR..OP_CB_OFFL=
OAD)
> from the per-netns callback counters; the set is small and fits alongs=
ide
> the scalar stats, so no extra paging is needed.
>
> This lets nfsstat report NFSv4 backchannel operation counts over netli=
nk,
> including CB_GETATTR which corresponds to the procfs wdeleg_getattr li=
ne.
>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  6 ++++++
>  fs/nfsd/nfsctl.c                      | 23 +++++++++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  1 +
>  3 files changed, 30 insertions(+)

> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 9bedbe7096c3..674fab6a86a5 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2476,6 +2476,29 @@ int nfsd_nl_server_stats_get_dumpit(struct sk_b=
uff *skb,
>  			}
>  		}
>=20
> +#ifdef CONFIG_NFSD_V4
> +		/* NFSv4 callback (backchannel) per-operation counts */
> +		for (int op =3D OP_CB_GETATTR; op <=3D OP_CB_OFFLOAD; op++) {
> +			struct nlattr *nest;
> +			u64 cnt;
> +
> +			cnt =3D percpu_counter_sum_positive(
> +				&nn->cb_counter[op]);

The loop emits an entry for every opcode in OP_CB_GETATTR..OP_CB_OFFLOAD,
but only opcodes with a nfsd4_callback_ops instance get incremented (via
nfsd4_run_cb() keyed on cb->cb_ops->opcode). Opcodes nfsd never sends
correctly report=C2=A00. The exception is op 11 / CB_SEQUENCE: it's writ=
ten by
encode_cb_sequence4args() on every minorversion>0 callback, so it goes
out on the wire but is never counted. The dump always shows op 11 with
count 0, which could be misread as "none sent" rather than "not tracked."

Check what the forechannel counter does for SEQUENCE operations.


--=20
Chuck Lever

