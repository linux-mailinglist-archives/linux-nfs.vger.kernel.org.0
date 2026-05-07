Return-Path: <linux-nfs+bounces-21437-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOnqDaa6/GkqTAAAu9opvQ
	(envelope-from <linux-nfs+bounces-21437-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 18:15:34 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 911E04EC071
	for <lists+linux-nfs@lfdr.de>; Thu, 07 May 2026 18:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A52DD311F4DB
	for <lists+linux-nfs@lfdr.de>; Thu,  7 May 2026 16:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC9B4508F7;
	Thu,  7 May 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTEeTm4r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859B73B38A4;
	Thu,  7 May 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170118; cv=none; b=fDoq7SZCvl+fYSNz/9Ahjcq+tlwbhfgZAAvUrTdyVYQIObK0RONZS5Tgy/eWXwbMVTiJFU5WOlSryqgUWmBnkI0tjKT0HXlCUGZ9G+Zy9d3SqKH/2eYRQgpMgsT1337HfUbDKLmZBkBac8mBGjNP/XPBbWBMLl7jtGmvJtwECYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170118; c=relaxed/simple;
	bh=RY3ZhrJkHje4r1jufnaEPJRII5OPlMz9wlkUozkjHvs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZQD723zpGQ2mNhWamJsTeJqzop4FiIm82QvwrIP3k9qqsXBC1jHRTWbPofdUQQr2fWgNR1WbOxKPMhVGVXkJd1j1Z0wNtLh+eqra0U9iDDfHy80AbPjTUNhNhepClELGKMXQFu+YNBJePrl7cKAmsyF3+COXBiovt7fFApFmb1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTEeTm4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B49C2BCC9;
	Thu,  7 May 2026 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778170118;
	bh=RY3ZhrJkHje4r1jufnaEPJRII5OPlMz9wlkUozkjHvs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fTEeTm4rpKFCG9FTUGob3ijEpxLuoDpyd1b9sNaBqW1o6F3HroHYw/FFlknHL02As
	 hLrzx/Lj5WxqV/ip6kOeGso9w/Sk00mlyApkLEr1SdEP089DgRhbsLeDKgJCdjfrBw
	 +jNIFupmthUGDLRmOXjLy4Bt85bm/2nlRBZWhDAVzeLgI0OUXBkxtgjomQW1S6dp2g
	 FJUw3nkZQDWXqK12onkhnJFLfImgcqaGeyGqJjZ0QUR1Ty00HRHttO1ej2QOFbbCBp
	 3WRyHymmJ8dAVpilFmUDc8L0Xfv90vgdnC5OIiTTz9oinKXpHgckwKAqeQ8TFfq04T
	 2xx9HRlOJeWWg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 97A6BF4006B;
	Thu,  7 May 2026 12:08:36 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Thu, 07 May 2026 12:08:36 -0400
X-ME-Sender: <xms:BLn8af-LYH9Iff5iFRbrdGDSksCah1ZBv_EXgZ-Is2l2k7VN7msIWw>
    <xme:BLn8aWiJhQa78EEMhGsU-1NqyZLnjtEnMl2Ew7nKg8hv3Y77WrEnJHU_hwrpLcm9M
    ebxJG7cDgf0hTtWADhuCeWd9ZSUhSBBOaZDOAwHtLkMIs_glwvGLYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdejleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeegheduieeiveevheelheelueeghffhtddtheelhfdutddtheeileetkeelvedtjeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlh
    eppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthho
    pedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvihhlsegsrhhofihnrd
    hnrghmvgdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghp
    thhtohepjhhirghnghhshhgrnhhlrghisehgmhgrihhlrdgtohhmpdhrtghpthhtohepvg
    guuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrnhhnrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhiht
    ohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:BLn8aUsnDqb65XljD9YpArGILeP1n53qoFoIIQ7Jsi7uQgRMoHUM8A>
    <xmx:BLn8aR7k5MlUwPuYnCi8PCL2VnYG6-7HEzG_4WHdaWWF9J9fGPuyKQ>
    <xmx:BLn8aVNYzr8RfPSS6Uhj4IiZbgQlnFr_KgI5IuLLtUkXBM8MF5MkjQ>
    <xmx:BLn8aVKE8opzgthiEpQBPFgCo_lt4EgMu2QZN-TsKK3MBq7an98vsQ>
    <xmx:BLn8aYx7cxttl21BTOmNcqr6SsKeJYff9skFqz3MfaqMKK6bbjXnmbom>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 61786780077; Thu,  7 May 2026 12:08:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AJo0cZWtw0Z3
Date: Thu, 07 May 2026 18:08:16 +0200
From: "Chuck Lever" <cel@kernel.org>
To: "Marco Crivellari" <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org
Cc: "Tejun Heo" <tj@kernel.org>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 "Michal Hocko" <mhocko@suse.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Message-Id: <38019ee1-4a2e-40d3-81fe-f29551cca309@app.fastmail.com>
In-Reply-To: <20260507130117.252825-1-marco.crivellari@suse.com>
References: <20260507130117.252825-1-marco.crivellari@suse.com>
Subject: Re: [PATCH v2] xprtrdma: Move long delayed work on system_dfl_long_wq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 911E04EC071
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21437-lists,linux-nfs=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Thu, May 7, 2026, at 3:01 PM, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
>
> The function(s) end up calling __queue_delayed_work(), which set a glo=
bal
> timer that could fire anywhere, enqueuing the work where the timer fir=
ed.
>
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a sing=
le
> CPU.
>
> Recently, a new unbound workqueue specific for long running work has
> been added:
>
> =C2=A0=C2=A0=C2=A0=C2=A0c116737e972e ("workqueue: Add system_dfl_long_=
wq for long unbound works")
>
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit fr=
om
> scheduler task placement.
>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
> Changes in v2:
> - Commit log improvements
>
> - Rebase on v7.1-rc2
>
> Link to v1:=20
> https://lore.kernel.org/all/20260430085412.96961-1-marco.crivellari@su=
se.com/

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


--=20
Chuck Lever

