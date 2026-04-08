Return-Path: <linux-nfs+bounces-20784-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLIhGs7g1mmsJQgAu9opvQ
	(envelope-from <linux-nfs+bounces-20784-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 01:12:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3B33C4B38
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 01:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 938DB301738D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 23:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40662378D9A;
	Wed,  8 Apr 2026 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaEj0tdQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0452D3ECF
	for <linux-nfs@vger.kernel.org>; Wed,  8 Apr 2026 23:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775689930; cv=none; b=LjsEO28OqPGzLjKQLfc/IAOVw4NKIXffboZztSMpJ2xdKF30+jeFEOquJkeV196jEachHE3RqIZt7zRiwSVqH4KeZcd4OuCR3qm9ysk5OevuyA0bZUMsccYnoRjlPgBb9gkVVLMtQipJOe2csfDP/daZdNivvt4/0xgG6O6tH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775689930; c=relaxed/simple;
	bh=K9QfbZ5i/TkDDDQEXqauyCVMgliRGpJ6doUa7YB87LI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WSD2DH4sF9qSiiQIFdTeIkge2dlxmmdqy00+gVo7XTm4aXzqpMD1o+CZzj7XUqhJzP5nYsU0hwbIN5tGjfc444ofPZNvYKR5SuKpeMfL+1XsD9hb1Qcaj51HMKTGTTUbOeeuqai/ZJ6Ye4OiHP+y/w7Qm2DNif6YWS1bkAGfHy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaEj0tdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624EEC4AF09;
	Wed,  8 Apr 2026 23:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775689929;
	bh=K9QfbZ5i/TkDDDQEXqauyCVMgliRGpJ6doUa7YB87LI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=AaEj0tdQuiF7lgeLQ8mf69DYeItAzJOXZ5QgU2fZXM9FyJZQpF7Roqzl7iMAdNXtT
	 asqnoI29wJ7dUPo1pIAU4c2PrQ5GCCjUV0NKtJmWh9x1UAPNQdq5MY1ozKRhXxJiYy
	 LZcn/1t0bBYSJdRrFhjMTbDQ1PIO0Hc0YivQg1iAdqtAa3wrE0g4qH+3WKDbTvBi9u
	 OI1Wsl2tBO0nIfwsB3rPVPa2yanP6Ayi2oQQomkqdZ+RBMzQv5jPlA5egMCaujyPAf
	 9kh3qujZgR5I6yhEGxNRvSR/ET5wSAKfa3oEWOHH/yDFBqJ/mGQikuUHGOlms07yB2
	 UzLJVGGOMAf2Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5A264F40078;
	Wed,  8 Apr 2026 19:12:08 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 19:12:08 -0400
X-ME-Sender: <xms:yODWaV5WkMRtEsgJGmA4X5NvM2HgRaPI1COBDXUD2QDsUwWxgsah1A>
    <xme:yODWadsNRF1sxFA8dt8nMk7Feu6CLxJjdPX4FAaETLEwXvrqrkUAKVMEcNF9G8s07
    hPQyjdLYshsrpvVaG1qi0njSNwcMVS-Ei4LO9AYq9k7mx4ce8ndi8s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgeekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvghilhgssegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yODWabwc31vOQztjdiyrHXBIEdRITUp3mNp1kNhbETRhSH71Jkw0TA>
    <xmx:yODWaT-Sz6WrghznWQi-HrbOBRyD11yLlX4OHDOq8LeK4N_-kv9h6w>
    <xmx:yODWaTizjtLNBi6afjQ_pV8ApAdA1cD2q1xF-SL-BjWpm6TdXTYSrw>
    <xmx:yODWaaH-s_VOmC8N4xImF5DSIKTeagP6KHCrMb7y71W4xchmTeXInA>
    <xmx:yODWaS9sriJxb0yOIyZ77Oh9nU5yhcvt537FLZbCHODIyixg4nPBEFZz>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3BBE3780070; Wed,  8 Apr 2026 19:12:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Af2DAw9i9IjZ
Date: Wed, 08 Apr 2026 19:11:48 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Olga Kornievskaia" <okorniev@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, neilb@brown.name,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Message-Id: <d81b1bc3-4e1b-43cc-9596-8a5c753ca9fc@app.fastmail.com>
In-Reply-To: <20260408190008.85082-4-okorniev@redhat.com>
References: <20260408190008.85082-1-okorniev@redhat.com>
 <20260408190008.85082-4-okorniev@redhat.com>
Subject: Re: [PATCH v2 3/3] nfsd: update mtime/ctime on asynchronous COPY with
 delegated attributes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-20784-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA3B33C4B38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, Apr 8, 2026, at 3:00 PM, Olga Kornievskaia wrote:
> Asynchronous COPY should update destination file's mtime/ctime upon
> completion of copy work (not COPY compound processing).
>
> Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding 
> WRITE_ATTRS delegation")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index ac47cddef384..b6490167e78b 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2132,8 +2132,19 @@ static int nfsd4_do_async_copy(void *data)
> 
>  	set_bit(NFSD4_COPY_F_COMPLETED, &copy->cp_flags);
>  	trace_nfsd_copy_async_done(copy);
> -	nfsd4_send_cb_offload(copy);
>  	atomic_dec(&copy->cp_nn->pending_async_copies);
> +	/*
> +	 * choosing to check for existence of set dentry pointer to indicate
> +	 * that we need to update the attributes and do a dput because the
> +	 * file flag could be cleared by a DELEGRETURN and then we'd lose
> +	 * that copy was started with file opened with NOCMTIME and we got
> +	 * a reference on the dentry.
> +	 */
> +	if (copy->d_dst && copy->cp_res.wr_bytes_written > 0) {
> +		nfsd_update_cmtime_attr(copy->d_dst);
> +		dput(copy->d_dst);
> +	}
> +	nfsd4_send_cb_offload(copy);
>  	return 0;
>  }
> 

There might be another potential dentry reference underflow here.

If the async copy fails before writing any bytes
(wr_bytes_written == 0), the dput is skipped but the dget taken
in nfsd4_copy() is never released elsewhere.

This might happen when _nfsd_copy_file_range() fails on the first
iteration, when nfs42_ssc_open() fails for inter-SSC copies, or
when kthread_should_stop() fires before any bytes are copied.

Rearranging the logic a little might avoid the issue:

  if (copy->d_dst) {
      if (copy->cp_res.wr_bytes_written > 0)
          nfsd_update_cmtime_attr(copy->d_dst);
      dput(copy->d_dst);
  }

-- 
Chuck Lever

