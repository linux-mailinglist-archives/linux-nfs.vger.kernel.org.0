Return-Path: <linux-nfs+bounces-981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FE0827B56
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jan 2024 00:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1AD1C22911
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jan 2024 23:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F96D1DDDC;
	Mon,  8 Jan 2024 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="PSz250jy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gi3M9wRd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499BBB672
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jan 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 30BB23200A12;
	Mon,  8 Jan 2024 18:16:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 08 Jan 2024 18:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1704755774;
	 x=1704842174; bh=l3JYqJtsA83RY3G0BsbNOzDiYA+azkGjlbXxI8M8Thg=; b=
	PSz250jy2rErdoKjv3wa0vSslWUHob/Ce3Tbq0rVPPTRV/+0fBUpiqHBFpeebCzq
	0c2U36uTxjSBnYoXmRw/6+z4wtiAN6iGuzky/Y83ddQQN8xJfThm7A2fCTBQF3+t
	fLiBjC0Vs5ICjsbfIsBJMKIXEtYGVD5HDZH7pwR6JWnE45JldzUNBetFiVqcFlLo
	MSlFfKGxCUc+gfwPSObVkt7YgixLuv/cMZ37y7Xaq+jGAYYlbSHIipjgXo0oQa8M
	oW0aYnJsmQMUPJcXyD7X4tMH0xzYO6LI9365MkEotyEtocgZEzWbjpv3rdeLE/7c
	To/hnWP7kISNsX4vOz3tLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1704755774; x=
	1704842174; bh=l3JYqJtsA83RY3G0BsbNOzDiYA+azkGjlbXxI8M8Thg=; b=g
	i3M9wRdoC+9GKK1zsZmize+TD0P3SRhgPdW2kFyhqbGAiRKKEVRmNpj4c1jDtKUC
	BOXEg2xWPBQQemhTOR8ThWm+pOO11IoxacphkMrvRcbIHHTMIzMNhdbevO5CiFkZ
	dJOkWrC21QHliknLYEV72C4ozTDo1so2Ikh9v8+kq1ikxBZydrA8XuvYJOblmY5h
	EnRpnoo2YEuAb2ik8m35QB4nqgBxJ1r7LnrAyCSp3msFT5ubXzzX/mIhAwzNP6XS
	2HXvD/KHqyj7UQOg9RF2pBRYKFH+yfAdBuepcH960ckJsoM6CQjfbXQ9lldRBZ33
	ddzjqjjQQ6jGNOiY8aaDQ==
X-ME-Sender: <xms:PoKcZS00BTWqPnphL-kZbcdYNvY4BtTlJbnzlaZHveIdXl-fb6KxMQ>
    <xme:PoKcZVHBiacRGrXiwY9gXz_RHNs__SvS7NazCjDrgU3arivFhNS4ncFRwQxLoybvc
    s028UQszoZX>
X-ME-Received: <xmr:PoKcZa5tYoUskTbqV9gPrw0EnmlfkwSbTlWha0fjBI9Ha4vN1ao0XG18LP0JE8_BmSrbnPRCLTN9iNjUlzrwMeM1YX9aMZHtN5-tqZZ9QYfvIIdR-N6nK2K4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehkedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    fggeektddvtdegieelhfetffffueekgeeghedvudelgedvieeiiefhteduheejleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:PoKcZT1zvn6PddLC4m5X_DZYM5uZ1Z_oTKaaXTcoZn9rt1b7GL2VFQ>
    <xmx:PoKcZVGjH3FBCkIP_9llc0jnl2wLjrEWmwfj2agr-w1gp4AIy-MNcw>
    <xmx:PoKcZc_rxeTWYTJxjNvgCX7Xm7eiDziuL-zMQ-FxiNMG5SJoszwCkg>
    <xmx:PoKcZYNSQmjlB5snBpJnRHSrjpT03W5OJEWNHglkk4MNn3V86meAYA>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jan 2024 18:16:12 -0500 (EST)
Message-ID: <b89c26b5-6b9b-0a83-f0ff-dce4dadd5528@themaw.net>
Date: Tue, 9 Jan 2024 07:16:08 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: nfs-utils&nfsd&autofs not supporting non-2049 TCP port numbers -
 Fwd: showmount -e with custom port number?
To: Jeff Layton <jlayton@kernel.org>,
 Cedric Blancher <cedric.blancher@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CALXu0UdFR7Xn51eKFUUi6a68wvDKc-RXz7F4LKyQgDptqfYbgw@mail.gmail.com>
 <CALXu0UfSJ0Qc3HOecf4pQ=VnEVqxRw6OGzNwhh9BUVYaHV7_oQ@mail.gmail.com>
 <61666d84cd8d6849a9e9c5147603b10bb49e0519.camel@kernel.org>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
In-Reply-To: <61666d84cd8d6849a9e9c5147603b10bb49e0519.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/1/24 22:52, Jeff Layton wrote:
> On Sun, 2024-01-07 at 23:33 +0100, Cedric Blancher wrote:
>> Good evening!
>>
>> Generic issue in all of nfs-utils: None of the utils properly support
>> NFSv4 with non.standard (TCP/2049) port numbers.
>>
>> mount supports it for mounting, but does not show it for listing mounts
>> /proc/mounts does not show the port number either
> mount just gets the mount info from /proc/mounts, which absolutely does
> show a port= option when you use a different port than 2049.
>
>> showmount -e does not support a port number
> showmount talks directly to mountd so you wouldn't usually point it at
> the same port nfs is listening on.  As with most sunrpc based tools, it
> queries rpcbind in order to determine what port to talk to. If you're
> going to use stuff like showmount, then you need to ensure that rpcbind
> is reachable and that the daemons register with it properly.
>
>> autofs does not support non-2049 port numbers
>> nfsd referrals do not support setting non-2049 port numbers
> The same goes for autofs. It just calls /bin/mount. I think (but am not
> sure) that even with NFSv4, when the client can't contact the server on
> port 2049, it'll try to use rpcbind to determine the port.

That is exactly what autofs does, and always has done.


The other thing to be aware of is if you want NFSv4 only you need to tell

autofs that by using the option fstype=nfs4 so that it doesn't try to fall

back to earlier NFS versions and also tries to avoid contacting rpcbind.


Ian

>
> Alternately, if you don't want to deal with rpcbind for mounting, you
> could also specify a hardcoded "port=" mount option in your autofs maps.
>
>
>> ...
>>
>> Could you please make a concentrated effort and allow non-2049 port
>> numbers for NFSv4 mounts, in all of the lifecycle of a NFSv4 mount?
>>  From nfsd, nfsd referrals, client mount/umount, autofs
>> mount/umount+LDAP spec
>>
>> Ced
>>
>> ---------- Forwarded message ---------
>> From: Cedric Blancher <cedric.blancher@gmail.com>
>> Date: Sun, 7 Jan 2024 at 22:32
>> Subject: showmount -e with custom port number?
>> To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
>>
>>
>> Good evening!
>>
>> How can I get showmount -e to use a non-2049 TCP port number to show
>> mounts on a NFSv4 server?
>>
>> /sbin/showmount -e localhost@30000
>> clnt_create: RPC: Unknown host

