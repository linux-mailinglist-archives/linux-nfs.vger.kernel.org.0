Return-Path: <linux-nfs+bounces-20234-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKASNDZduWnYAgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20234-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 14:55:02 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A32AB484
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 14:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352B4302D12B
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Mar 2026 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CF5335546;
	Tue, 17 Mar 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8BFuUUt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F79C308F32
	for <linux-nfs@vger.kernel.org>; Tue, 17 Mar 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773755506; cv=none; b=LvOOP7bOj/NfeGxFkyKKhT49sMM27nC5xdC727p+oyOXFk+rObsRvBuJ1u5EcWEiktu1UaeXpog+VARGmsFFeJMEqdlWRMF/70ZuBLl6Ku1vJYK1X8o9fL+LOur3uo9fKxFysdueen6TLchmb6Dzp2TqyRRRwWBVPBtsjvMaMVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773755506; c=relaxed/simple;
	bh=72Vgq2TbPCCRdL41KrlheAJHXUpLQ4Z3KuXw9aBIj+M=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZGSVXt+EPe6m20JPlpqVg+1Vo3ZULgn8WQUqdgiGjwiLrMgOdLz8QGYnFJ+EWCVK82oA4Br5Tl67/ku4iJuaG7xtUHFuC/vAMB1BsrHKK/juIEGX/NaMbAezwENAIjyjrB/NZH7fqiMOwmkvFi7JfKXiLiVy3gLai9EpHkHlthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8BFuUUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CFBC4CEF7;
	Tue, 17 Mar 2026 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773755506;
	bh=72Vgq2TbPCCRdL41KrlheAJHXUpLQ4Z3KuXw9aBIj+M=;
	h=Date:From:To:In-Reply-To:References:Subject:From;
	b=b8BFuUUtGHaAs1rGsvhuaoX+b/W+Vfccgko90B47CuJ/2y1WZdhlVPbLnZo2nSI7k
	 0EhWbcwm/cKGFRJpchlTjHs3WA5915BvM0gadxhtbAy49AZKlSGV0X6uYVvsbJkWRk
	 bsIhqkgB+oglW2INIPV6QY79D4HN5dY0AdCuhQ8OBbLstjVL2mYpUzKzAYsRlW0Xey
	 32KX7fOabnZCeTVOnwkYA15IrBe882OYsRKuzNlJIs+psLcDSgb2nhcnI9KFUnTpbQ
	 l2BmU13/lrYL6GE3AmIrqvoRyOKU07lo8QgQV25ahXMba49U56NCuvyjgQpUb289a5
	 mFTSVLs4mG1KQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id DE2C7F40086;
	Tue, 17 Mar 2026 09:51:44 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 09:51:44 -0400
X-ME-Sender: <xms:cFy5aZtULnt-zKb68eXi1Ub_XaiNu91dS1U4FArKbp7UBll3_I2BVA>
    <xme:cFy5adQbMFdGp4X8GobkRZwpKHtAeNyyKNMT3jDzBInopR59lx-d6EFEZeuumh-vO
    Iw6UDuG1Ht10Hps4dyRMJZ67Px1difj1xXsMyZB-mk6P0m5S37NFCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddugeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetnhhnrgcu
    ufgthhhumhgrkhgvrhdfuceorghnnhgrsehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnheptdetledvgefgtdeuteduteefffetvdeifefhuedvteetheeuledvuddtteev
    ffevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnnhgrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejjeduvddtjeel
    qdeffedvvdefgeejuddqrghnnhgrpeepkhgvrhhnvghlrdhorhhgsehnohifhhgvhigtrh
    gvrghmvghrhidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptggvughrihgtrdgslhgrnhgthhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopegtvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhn
    fhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cFy5adpLHipVWTo96LZ5Q6qI1v8M5_m7fJ9_6FDTIYTNNrZy1Nu7IQ>
    <xmx:cFy5aXarzgjYFrOvESrWakQ0hTrosZF9hG4niRwwo499y_08kG5lLg>
    <xmx:cFy5adSAND1vvUn_ZJZJ70iaQY7mMfLu6qc0ESPcMzBGyMR5H9-qAQ>
    <xmx:cFy5aW7TGuHJmTBk6ysfG8g46j8pscnnp267vRz8bFre62S4dk0Bjg>
    <xmx:cFy5aazjm63kFZL4pGocS8uuPKvRXyXLFxjGm8Nmsg7D5VJpO-JdaiBB>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B1914B6006E; Tue, 17 Mar 2026 09:51:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aa0bF5Tl8dL3
Date: Tue, 17 Mar 2026 09:51:23 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Chuck Lever" <cel@kernel.org>,
 "Cedric Blancher" <cedric.blancher@gmail.com>,
 "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Message-Id: <88adbb3b-38da-4279-a4b8-db68551d6a8b@app.fastmail.com>
In-Reply-To: <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com>
References: 
 <CALXu0UdOR8mVr=8pwNP95FnOsOk1w1A2=DcayKk3YnDfS+PzUA@mail.gmail.com>
 <5acaa8e7-0691-4cbd-b501-c26831a7be81@app.fastmail.com>
Subject: Re: Increase default NFSv4 server size "max_block_size" to 4MB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20234-lists,linux-nfs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5F4A32AB484
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Mon, Mar 16, 2026, at 8:39 AM, Chuck Lever wrote:
> On Mon, Mar 16, 2026, at 3:51 AM, Cedric Blancher wrote:
>> As debated a while ago, can the default NFSv4 server size for
>> "max_block_size" be increased to 4MB, please?
>
> There is an administrative setting to raise this limit for
> recent versions of the kernel. Can you report your experience
> when you raise the limit? Hiccups, performance issues, etc? I
> would kind of like this exercise to be data-driven.
>
> What is still unknown to me is which NFS client implementations
> can support 4MB or 8MB. Without client support, an increase in
> the default in NFSD doesn't mean anything. Rick, Anna, Roland?

The NFS client would need a code change to support >1MB sizes. I
spent some time playing around with 4MB yesterday and it passed
all my tests.

Anna

>
> -- 
> Chuck Lever

