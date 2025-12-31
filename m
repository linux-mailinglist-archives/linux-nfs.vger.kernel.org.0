Return-Path: <linux-nfs+bounces-17385-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BBECEB1C6
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58ACF3008D64
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4252765C5;
	Wed, 31 Dec 2025 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpSXay1q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F1274FEB
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767149301; cv=none; b=C2KdAJZEvuIz91sBUeOGRMM0E07XxkrG29Uz9Q9uIM05s8U23RHpoWL627dkhIOS3GmuLW5o+xump6PpWzPKY1raYvRiAeelrJ3xnnQIIZMneYzfNqgTUbco31WaDZhFLbXn4Zwdzhnb9duQCtezX5uAmVpi6TOjTX465VKVuqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767149301; c=relaxed/simple;
	bh=s7/pVUJGV39xgB/Bi1eSbp60FwRUeBcWoRTN+1L/ees=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n53smEkvAsavKf1OWd5sQiATDZP4KrjuZq+KPCQsefCMJBtzva+/9gmq5u/8mNHnAlIUapNB0ifvc6NOVL1KrYMeB1dJiw+tjZed9FQMtsN/kM6FZuP4BADV83yNTGB2pa+i8uZRc7F0JslGhqheHTBO9fPX3OlFDJrZn/wONvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpSXay1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B81C16AAE
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767149300;
	bh=s7/pVUJGV39xgB/Bi1eSbp60FwRUeBcWoRTN+1L/ees=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=OpSXay1qQrvF5WszgLsE97SghzUzI4EdPGu+4OAWNddOGFu6vx8d/YWbbNF+QmYaV
	 xLxplZPdtK2WoBEEE4ih9WjuLnjqnu/bKbChyaJCf/UXf70hykq5obdfNCtj4SiSWw
	 5ypYsQfUynuD6EOt+lQrZONiu1d+FComPahYJpi2C9TpX47i361r1bL/tNzq7xMVZr
	 S3IHox3RClQpvxyIUeyIwrWGlX6T9KSMaKIZ0dP8Kvs9J6BFTAX5k32cW8PRAJjzX2
	 EvwD5LVHcVDr0oKM3ZJvYDeIBnE5X9DQvbw3+XZ8Ve1Ll3ZzSycRSUkBgCvspt+UX6
	 elDsGbLROZ8/g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 70D93F40068;
	Tue, 30 Dec 2025 21:48:19 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 30 Dec 2025 21:48:19 -0500
X-ME-Sender: <xms:845Uab7pSpcDmTIk6uapv5Xf4ysjCjRiIipuO04HaeXAUaLNml37ew>
    <xme:845UabsNndMLMLVzEhL2NTU4gIZWrZql5IlpIMLJERctK9sOjF4qXZ8n_kg4XzwdB
    nityw60hjWjz6BUCUmq7hV5jcSQqVr8FMQgHkvYtLJEeGdOIaghQcU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekudejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    epgfdvvdefvdelheetfffgfedtffdvgeefledvfffhteeludeivdejtdeuveekhedunecu
    ffhomhgrihhnpehivghtfhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegthhhutghklhgvvhgvrhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeifeegleelleehledqfedvleekgeegvdefqdgtvghlpeepkh
    gvrhhnvghlrdhorhhgsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhitghkrdhmrggtkhhlvghmsehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprhhmrggtkhhlvghmsehuohhguhgvlhhphhdrtggr
    pdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:845UaaVIbRDtnp20EhMBqFueXg4T2uquLzcEsiGbX3DCZkenpHvpCw>
    <xmx:845UaeWvsiTwD4CdUwSbEBg1P6YjA-qSybqGCIpev5Hvwus6n1UV-g>
    <xmx:845UaRcemlGz6jix9pn-NpKGjli7pY64mEkSAG07ssNzcHSwWAoLuw>
    <xmx:845UafX6bO-mtqropVq8f7M1tTZeQk1KrrduN4RYWN3jI7SmfRGYDw>
    <xmx:845UaScCjhivkSejfY1SJcpouFBz9DOPadeQRNhJy0YOQGzOhrQW1eav>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4EB1F780054; Tue, 30 Dec 2025 21:48:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfTh0LQYDPSo
Date: Tue, 30 Dec 2025 21:47:59 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org
Cc: "Rick Macklem" <rmacklem@uoguelph.ca>
Message-Id: <5045ae28-4f2d-4d57-b6c3-523e8bbd99cd@app.fastmail.com>
In-Reply-To: <20251231022119.1714-1-rick.macklem@gmail.com>
References: <20251231022119.1714-1-rick.macklem@gmail.com>
Subject: Re: [PATCH v1 00/17] Add NFSv4.2 POSIX ACL support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Dec 30, 2025, at 9:21 PM, rick.macklem@gmail.com wrote:
> From: Rick Macklem <rmacklem@uoguelph.ca>
>
> The Internet draft "POSIX Draft ACL support for
> Network File System Version 4, Minor Version2"
> https://datatracker.ietf.org/doc/draft-ietf-nfsv4-posix-acls/
> describes an extension to NFSv4.2 so that POSIX
> draft ACLs can get acquired and set directly,
> without using the loosey NFSv4->POSIX draft mapping
> algorith.  It extends the protocol with four new
> attributes.
>
> This patch series implements the server side of
> this extension for the knfsd.  It is analogous
> to the NFSACL protocol used as a sideband protocol
> for NFSv3 and allows the ACLs to be acquired/set
> be getfacl(1)/setfacl(1).
>
> The current implementation does not support the
> "per file" scope, where individual file objects
> store/use either an NFSv4 ACL or POSIX draft ACL
> and assumes POSIX draft ACLs are supported for an
> entire file system, if support for POSIX draft ACLs
> is indicated.
>
> Rick Macklem (17):
>   Add definitions for the POSIX draft ACL attributes
>   Add a new function to acquire the POSIX draft ACLs
>   Add a function to set POSIX ACLs
>   Add support for encoding/decoding POSIX draft ACLs
>   Add a check for both POSIX and NFSv4 ACLs being set
>   Add na_dpaclerr and na_paclerr for file creation
>   Add support for POSIX draft ACLs for file creation
>   Add the arguments for decoding of POSIX ACLs
>   Fix a couple of bugs in POSIX ACL decoding
>   Improve correctness for the ACL_TRUEFORM attribute
>   Make sort_pacl_range() global
>   Call sort_pacl_range() for decoded POSIX draft ACLs
>   Fix handling of POSIX ACLs with zero ACEs
>   Fix handling of zero length ACLs for file creation
>   Do not allow (N)VERIFY to check POSIX ACL attributes
>   Set the POSIX ACL attributes supported
>   Change a bunch of function prefixes to nfsd42_
>
>  fs/nfsd/acl.h        |   3 +
>  fs/nfsd/nfs4acl.c    |  35 ++++-
>  fs/nfsd/nfs4proc.c   | 126 +++++++++++++++--
>  fs/nfsd/nfs4xdr.c    | 312 ++++++++++++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfsd.h       |   8 +-
>  fs/nfsd/vfs.c        |  34 ++++-
>  fs/nfsd/vfs.h        |   2 +
>  fs/nfsd/xdr4.h       |   6 +
>  include/linux/nfs4.h |  37 +++++
>  9 files changed, 536 insertions(+), 27 deletions(-)
>
> -- 
> 2.49.0

Thanks for posting, Rick!  What branch/tree/commit did you base this series on?


-- 
Chuck Lever

