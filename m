Return-Path: <linux-nfs+bounces-20768-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDnrIl6c1mmyGggAu9opvQ
	(envelope-from <linux-nfs+bounces-20768-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 20:20:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 379EC3C0730
	for <lists+linux-nfs@lfdr.de>; Wed, 08 Apr 2026 20:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89F9E30851FF
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Apr 2026 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D1F386550;
	Wed,  8 Apr 2026 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrd3Vq+f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32EA3537FC;
	Wed,  8 Apr 2026 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672214; cv=none; b=WRYTVNHw7LxKJ35DX4B5wC6JhtQtBP7UDuRfONliZRiXk9bCH28ueyuEZyavO7OzUrYMmxe3fxcWJJ/3YqPZCNON8ZiF9RnxbnWbk1thzW5/3GOmno8M2XrLDTexfhJYHUim5YD4BOCzzbwjSCDheisuheMlExITsjJuXcOFVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672214; c=relaxed/simple;
	bh=HKHxPoblaork2H0d6qRNs+Qxh9dmFv1KNw8j/ngGj2k=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oijGH4/UxiwicBavlloExqjMDJoCkfKAudKEzW88VofMidFcZ6BSWs4wF9jx/pBX0+OT+HWmCo1EEB1kvDn8fb8zIWRPWhTtA3wnDz/DmpSEjCVmrNDiMi25cUvZHcwIZ4S9O+1vSLRvZzKUU9Gl9ZUFzMMQeuPyVCYj7Zt1xyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrd3Vq+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9D3C19425;
	Wed,  8 Apr 2026 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775672214;
	bh=HKHxPoblaork2H0d6qRNs+Qxh9dmFv1KNw8j/ngGj2k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rrd3Vq+fpd2blfg6wopfmOudbeG4wNDSlpCfejvmvd9EMcoPsT5k51gL7CuUaYk8b
	 CpHgEcnumiCYVsoUwEVKTzSkoA/DVcdCU+DX3KHP2lXzv4YXjSXHuElsMVzZ8VZNaF
	 mnCA9VD3Q974qfsAM7/mh5BiUph3l8bViDzZ4Wt3RsjC9DHTgC0R++6fU7MAY3ViK8
	 fep2ac1qhUEMg4BJqE/fnCyhwpxcEteOSOopRmtr0JdkXz4HaLZIWkW0zTlPiKWibw
	 viZJiaSqhgue58xJCCwHiW3Zpv37EyeLmBL+v3mjOw7OWGvECH+WmbkdD6RXkg+GTx
	 tDGbFufErBw8Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 036AEF4006C;
	Wed,  8 Apr 2026 14:16:53 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 14:16:53 -0400
X-ME-Sender: <xms:lJvWaSvFhNZ43WDSF4xUIs6h7WSKhuTbM8ny4RZXenhN05SWE55zww>
    <xme:lJvWaSRp34g1uyADOBSHkG683H72946qbjCgw08XMh_E942eiYKOwFFr73cJGcLzS
    _ychiMARQA5cFpBaXc9AUgNy-tsOdFITn8Rpvv0lSPJ1udqMzygP8PH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvgedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehmrghthhhivghurd
    guvghsnhhohigvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopegrlhgvgidr
    rghrihhnghesghhmrghilhdrtghomhdprhgtphhtthhopegrmhhirhejfehilhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhr
    tghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvg
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmhhhirhgrmhgrtheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lJvWadfwdEbgHY50jIRm349uKUZoi4dIykahtitCUgzU-qDa0jnh-A>
    <xmx:lJvWac5QvBsdH_8b0EyXVCQ53CXGlvAU2LZ3Dvd5A7hJOw-v281LXQ>
    <xmx:lJvWaZ8srh66Ha6yOnd5dPMBZe86eMzFqX6S6cRH6t_Z_s4hH5_cvQ>
    <xmx:lJvWaWzPQupnYV0SPbhEsvYqUN5lmSqjdY0QzIFVlPNh9gdBGgEVig>
    <xmx:lJvWaQG2yajAQ8V64yXwD0sO-FDVUo7XOMuAJq6b2G-JRpJ3Lc7Krz8K>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C882B780070; Wed,  8 Apr 2026 14:16:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A5DZmuaHBpig
Date: Wed, 08 Apr 2026 14:16:32 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>
Cc: "Calum Mackay" <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <bb4fc3da-765d-4284-9282-dd04d286f671@app.fastmail.com>
In-Reply-To: <20260407-dir-deleg-v1-1-aaf68c478abd@kernel.org>
References: <20260407-dir-deleg-v1-0-aaf68c478abd@kernel.org>
 <20260407-dir-deleg-v1-1-aaf68c478abd@kernel.org>
Subject: Re: [PATCH 01/24] filelock: add support for ignoring deleg breaks for dir
 change events
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20768-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,oracle.com,gmail.com,goodmis.org,efficios.com,lwn.net,linuxfoundation.org,brown.name,redhat.com,talpey.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 379EC3C0730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Apr 7, 2026, at 9:21 AM, Jeff Layton wrote:
> If a NFS client requests a directory delegation with a notification
> bitmask covering directory change events, the server shouldn't recall
> the delegation. Instead the client will be notified of the change after
> the fact.
>
> Add support for ignoring lease breaks on directory changes. Add a new
> flags parameter to try_break_deleg() and teach __break_lease how to
> ignore certain types of delegation break events.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

> diff --git a/fs/locks.c b/fs/locks.c
> index 8e44b1f6c15a..dafa0752fdce 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c

> @@ -1670,7 +1709,7 @@ int __break_lease(struct inode *inode, unsigned int flags)
>  			locks_delete_lock_ctx(&fl->c, &dispose);
>  	}
> 
> -	if (list_empty(&ctx->flc_lease))
> +	if (!visible_leases_remaining(inode, flags))
>  		goto out;
> 
>  	if (flags & LEASE_BREAK_NONBLOCK) {

After breaking visible leases, the restart: label calls any_leases_conflict()
which does not filter ignored dir-delegation leases. When only ignored leases
remain, any_leases_conflict returns true, but visible_leases_remaining also
returned true (triggering the wait). The code picks the first lease (possibly
ignored), computes break_time = 1 jiffy, blocks, then loops.                                                     

For example, suppose you have two directory delegations on a directory, one
with FL_IGN_DIR_DELETE and one without. After the non-ignored one is broken
and removed, the ignored one keeps any_leases_conflict returning true. The
loop spins at 1-jiffy intervals until the ignored delegation is released.  

Should the restart: block skip ignored leases?


-- 
Chuck Lever

