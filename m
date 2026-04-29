Return-Path: <linux-nfs+bounces-21273-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAtoC8ga8mlyoAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21273-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 16:50:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2B4963D3
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CC5330022CB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2026 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69043254B8;
	Wed, 29 Apr 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL18D2lC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343427E1DC
	for <linux-nfs@vger.kernel.org>; Wed, 29 Apr 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474240; cv=none; b=HIpdTESttsC4bSb3wE3rbSFJ2MPSYbECqZb0W9rHMKGvdqdAGKrGamWhZFQX/6O7FS08IuKDoN4O5t0+YtY84Wauns4Xzw/TqL3rv+qVSYaiIOvv/24J3fFd4lfVYdnSd+QrLJyDlGhVKRwDHe6Gdr98aLSgHLf+xW67+CAwLZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474240; c=relaxed/simple;
	bh=thfUlE0axhTR/XnrGpaLu6GUutQHpZ011AZmWf1HJPI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mPa+5cLNx/FAhwK/8Pc061ZHcWHrt2jBEW5lz3Pe1zPIKzKyN8zHE7vGQrwILqEZ0lJ7PHpkpV94FG+Ko5nUqGR5UfMOTjdT0i35TNje47chc4eh8RukvEfmvK9AKcCywi2/b0IsM1pAvtj3CCQjKqhVmJH1K7K4SxFJGNBBS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL18D2lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FA4C19425;
	Wed, 29 Apr 2026 14:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474239;
	bh=thfUlE0axhTR/XnrGpaLu6GUutQHpZ011AZmWf1HJPI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EL18D2lC5/TNS/vf9oGrmGdSZ+4/LQ+mYg5ueb0bmlDSu3hoInq+MXfPtV0x67xGj
	 bFoN/koD35he2TRwnTokjaWdGCzWS+qT1sqbGedPGQ3jkN3U2F/zH1g0O2sre5yTx8
	 EfX668MAN91CFcLiP0F9TtkoKc7KHP5X2GS+xCr2U4DSHaNwH1Q3hTZPjfpZamf6j9
	 wGHJ1zsjAVNjAudxI1MU6AGaR2tUamwI6CGKjaEKEJeUdLvOfJ3boWuQXL5IqlD54O
	 PwWyTr6NSfTkkm0nRGlb5CP9clEPN1ZEVk6BprN1UmG2NbOQqdICopWUs42g9ALJ2Z
	 VNKPIk9LUnv4g==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id C2343F40070;
	Wed, 29 Apr 2026 10:50:38 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Wed, 29 Apr 2026 10:50:38 -0400
X-ME-Sender: <xms:vhryaVWgC_WqaK_UK1aWHRVcYiwN_5IzuUphssA1-LkfM5WLHIKhJA>
    <xme:vhryaQZ26iclxCk9Q3H9wDH7OCX9h7LQeUc65mFD8dbXqV0VFTWPcSO11SEocr21g
    BjSInEFPz-VfROUj8MoTnEEReubOJ3nPlvwc0bMHl1xk2Yp79xIESg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetnhhnrgcu
    ufgthhhumhgrkhgvrhdfuceorghnnhgrsehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepudeuveegffelvdelvdeiffehvedvvdetfeefgeefhfdvtdeufffgteevhfev
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnnhgrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejjeduvddtjeel
    qdeffedvvdefgeejuddqrghnnhgrpeepkhgvrhhnvghlrdhorhhgsehnohifhhgvhigtrh
    gvrghmvghrhidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepthhighhrrghnrdhmkhhrthgthhihrghnseguvghshidruggvpdhrtg
    hpthhtohepkhgvnhhnvghrrdhlihhnuhiguggvvhesghhmrghilhdrtghomhdprhgtphht
    thhopehsnhhithiivghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtrhhonhgumh
    ihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgr
    tghlvgdrtghomhdprhgtphhtthhopehjtghurhhlvgihsehpuhhrvghsthhorhgrghgvrd
    gtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:vhryaeGWdWZlDfXD2I-e8B9Gw3RC6ggpqNupXNAxo2aLrKP771UKLA>
    <xmx:vhryaWG0zv1MXl0Z67JS8gPj1V_qtaYTvCKEDw2AqGG_hKD6tHJPwA>
    <xmx:vhryaZ7TMWGJb961BJS_pk9FKJMPDwL2FYVT1lzX0bkcpiCMgnufbg>
    <xmx:vhryaTzjHMce8LMS5U3U8WrVSVEMrtbWGxzaovZ-IqaO87MMOjtpUg>
    <xmx:vhryaQNeUUxwWcdSlC2anTQHTeVskDA9igZY5BZ50PUKKoapg43FwqVX>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A49BCB6006E; Wed, 29 Apr 2026 10:50:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AY8c0H4t9Dfo
Date: Wed, 29 Apr 2026 10:50:17 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Kenner de Azevedo dos Santos Miranda" <kenner.linuxdev@gmail.com>,
 "Trond Myklebust" <trondmy@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Jonathan Curley" <jcurley@purestorage.com>,
 "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Mike Snitzer" <snitzer@kernel.org>
Message-Id: <d5df5a69-5003-40dd-b23a-c88b6fe315a4@app.fastmail.com>
In-Reply-To: <20260428195919.29794-1-kenner.linuxdev@gmail.com>
References: <20260428195919.29794-1-kenner.linuxdev@gmail.com>
Subject: Re: [PATCH] nfs: flexfilelayout: fix unused-but-set variable 'err'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EDA2B4963D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21273-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi Kenner,

On Tue, Apr 28, 2026, at 3:59 PM, Kenner de Azevedo dos Santos Miranda w=
rote:
> The variable int err in f_layout_io_track_ds_error() is set but not=20
> used in the code.
>
> The warning was identified by running make w=3D1:
>
>    warning: variable =E2=80=98err=E2=80=99 set but not used
>
> I set the (void)err to prevent the warning.

Wouldn't it be better to handle the error instead of ignoring it?

Thanks,
Anna

>
> I didn`t test with hardware, i ran again the make w=3D1 and the warnin=
g=20
> was removed.
>
> Signed-off-by: Kenner de Azevedo dos Santos Miranda <kenner.linuxdev@g=
mail.com>
> ---
>  fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c=20
> b/fs/nfs/flexfilelayout/flexfilelayout.c
> index 8b1559171fe3..d9a0fed41eac 100644
> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> @@ -1536,6 +1536,7 @@ static void ff_layout_io_track_ds_error(struct=20
> pnfs_layout_segment *lseg,
>  				       mirror, dss_id, offset, length, status, opnum,
>  				       nfs_io_gfp_mask());
>=20
> +	(void)err;
>  	switch (status) {
>  	case NFS4ERR_DELAY:
>  	case NFS4ERR_GRACE:
> --=20
> 2.43.0

