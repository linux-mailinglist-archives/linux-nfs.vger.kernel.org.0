Return-Path: <linux-nfs+bounces-20822-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJrOHKY03Wl9agkAu9opvQ
	(envelope-from <linux-nfs+bounces-20822-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 20:23:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF86F3F1F1C
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 20:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC57301FF8E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Apr 2026 18:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B57199FB0;
	Mon, 13 Apr 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr5oZKmc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCBD176FB1
	for <linux-nfs@vger.kernel.org>; Mon, 13 Apr 2026 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776104513; cv=none; b=RmhiALp7jNBp3DjtGabJHgSlD3yJfcfiyp5XK5hOabpPAQISrK1eyXJHPUJhs9EwiIneT7aqUAJYkupJeZBQIATgcuI8KLheU4uNt/Fist1Yscqu87lfd0jMl1Svqv1Ban6ACRw36MdGFFpu25Hq88fUyRqUFU9aSp3II8xPn0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776104513; c=relaxed/simple;
	bh=WpVpBFg9y9XjVLSo/o2ERI3lJ0TC/czy9PBccjVHyE8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U7uA8j37ee9g2Bjot3VLbRDNbFrdtCDrkrn+1umbfkynFKOGxxrqvqoXuO0pY+o7uNXnL2KUC/NrHc4vq2xXsYLr7PSx5r/bRhaIdLgTywDIm6RG8KCKPYv0Y38N4DmInq3wKlPFk+1gclGcBs4YimN/5oN/t9AX3Qr7GPWPmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vr5oZKmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FCFC4AF09;
	Mon, 13 Apr 2026 18:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776104513;
	bh=WpVpBFg9y9XjVLSo/o2ERI3lJ0TC/czy9PBccjVHyE8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Vr5oZKmcIVedZXKIzHNAULkPycZGudlYu3xOsnUJwR7wsJpdDSSFxHmkO8E0qRD1/
	 NWAnW15p8W/iPrr5Llr17YYwfasiJitN0RPUZFLTw3cVnlH7gWNPKf502PAdTy4GBT
	 AOV4DJgTC0lz8ISAbUOMI1tn+XUFtvIUx4YGZ4DOFykLv9rvJMYJgpi6rYN+AHJmRe
	 JvKylVcfO4uYxVcIu7BI1VTf1gOjouMFBTwZxD6DCvsyj6YQuYK/p1vkfN6SHA/+xc
	 371itrUv8cF5o5ZAlkf5k9LxVk4YQzwRGDIUaJvvWqN0a42LrjYuAy1Br9atpgHipp
	 K2nP6+6uudzrA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CB59DF4006A;
	Mon, 13 Apr 2026 14:21:51 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 13 Apr 2026 14:21:51 -0400
X-ME-Sender: <xms:PzTdae0Oqumd45KoKHXpPl5aP8VpcAjtWIeVykok-WwbYn65DcvCdw>
    <xme:PzTdab4c3GqlX3DLZa3ZoookCNZAFKyolMTL-K7-RvSCcU0SuNnFE36qLIMvbOLFe
    ig_A7MnG_qwbfAMZFvFsP8iaOJ28QKDE5Byd9i28Gt-Nf6sw7TXFHOx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheptghpphgtohhffhgvvg
    esghhmrghilhdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhope
    gthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhesthgrlhhpvgihrdgtoh
    hmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PzTdaTH2TRDwAugf9-qE-12hD-a_BkmEFd2UsVMWdy8f9veMlbmGZg>
    <xmx:PzTdaQyPL4GvdTy9onGaeNOyhzBOP2um7NlAg6AGWoih9Y5Qw_bNuQ>
    <xmx:PzTdaV2s28t6CAOMDhf0DhKzGMlyQvF_IRGP1vGlqqgoZaPb5cXI1Q>
    <xmx:PzTdaYrY6yw-kSleuAq2mnSeJUjyqJ5r7a9_dt9jtYj_qKOZf5Ww7Q>
    <xmx:PzTdaaVn1cNz-l6HJHRRti8LSgvrEx8yRi_24I3_Dugb4aflbkAnCTSS>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A9DA2780076; Mon, 13 Apr 2026 14:21:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9-XCDWUQyb3
Date: Mon, 13 Apr 2026 11:21:30 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Xiaobo Liu" <cppcoffee@gmail.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <3c90cf66-e073-4ccd-9ba5-2a6b38afa882@app.fastmail.com>
In-Reply-To: <20260412130133.2308-1-cppcoffee@gmail.com>
References: <20260412130133.2308-1-cppcoffee@gmail.com>
Subject: Re: [PATCH] nfsd: fix replay buffer length underflow in nfsd4_encode_operation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20822-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BF86F3F1F1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sun, Apr 12, 2026, at 6:01 AM, Xiaobo Liu wrote:
> When nfsd4_encode_operation() truncates the reply back to
> op_status_offset + XDR_UNIT, the replay-cache path may still try to
> compute the encoded payload length from xdr->buf->len.

It seems to me that this sequence cannot actually occur.  The
xdr_truncate_encode() call and the replay-cache length computation
are in mutually exclusive branches of an if/else-if chain in
nfsd4_encode_operation():

  if (op->status == nfserr_resource ||
      op->status == nfserr_rep_too_big ||
      op->status == nfserr_rep_too_big_to_cache) {
          ...
          xdr_truncate_encode(xdr, op_status_offset + XDR_UNIT);
  } else if (so) {
          /* replay-cache length computation here */
  }

The replay-cache path only executes when the truncation path does
not. The commit message describes a flow where both execute, but
the else-if prevents that.


> If xdr->buf->len is smaller than op_status_offset + XDR_UNIT, the
> subtraction underflows

Is this condition reachable?  op_status_offset is captured from
xdr->buf->len before xdr_reserve_space(xdr, XDR_UNIT) at the top
of the function. After the reserve succeeds, buf->len is at least
op_status_offset + XDR_UNIT. The encoder called at line

  op->status = encoder(resp, op->status, &op->u);

only adds data to the buffer. Encoders that internally truncate
(e.g. nfsd4_encode_readdir) truncate to their own starting_len,
which is recorded after the opnum and status are already encoded,
so buf->len stays >= op_status_offset + XDR_UNIT. After
xdr_commit_encode(), the invariant still holds.

The underflow condition appears structurally impossible on this
code path.


-- 
Chuck Lever

