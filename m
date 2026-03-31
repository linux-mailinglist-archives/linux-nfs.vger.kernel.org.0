Return-Path: <linux-nfs+bounces-20554-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENmNKYEPzGnGNgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20554-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:16:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7BF36FD4C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 20:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39096308E97B
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378003E8667;
	Tue, 31 Mar 2026 18:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hroK7Cqm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141373DE431
	for <linux-nfs@vger.kernel.org>; Tue, 31 Mar 2026 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980455; cv=none; b=JxzjlUE0qcJpas1k0sX3LXSw3bGydw4v2Cp82yNMANxM/SZoxzVCIPo9yy+KnOP8gouunHU8R3daowrkFDfGYaMtQn3aTsRGiguO4f7PrPWVfUmbAyUtrziVoLBZEEon/6wj/IbXjx/YdZdZfmm34lokIoCCoPuVCI5Ztbt+S6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980455; c=relaxed/simple;
	bh=YS1K1J4gGL0NgWlizwlEr2rjMIxCiY0SeED8ZxbXs+Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=k9K3yIJdDQkgIhmfp7N8B5qoiaVw+Qwm/3GLH6C1QbQzXnxJzC6jUgEfigtLe74It4FWow8VVGvGU3e/6wK//lNqKqxraT27kACLMjfDIx1v4QbU4CDVE+rpTvLDmMbeZyYWDKbDOtXocQQJ0xUjUW07ugfIRylbig/oM5Gb4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hroK7Cqm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C63AC2BCB0;
	Tue, 31 Mar 2026 18:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774980454;
	bh=YS1K1J4gGL0NgWlizwlEr2rjMIxCiY0SeED8ZxbXs+Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hroK7CqmDIYTLItAiE2GDlAZkYXrZZSSItL5xlCK21+OSYk4UVVkcgc5TVCHULnlT
	 lpwWwibJccjgOp92ek+PJqD74qyJbbVGPqoRMn1R05zcBi7ED0bcVyNYERpep9DL32
	 gsNzTWIBqlFuchbpCLcme1tObOEHtOzwAw3qF7nslJcJv9740wZjOeAoN6kIJuP+PD
	 LNRzzjO+zApOnDa3iRD+2Fy9Isw2SJTwbmFF9mofek5GYPtr4xT4yocH1yGcXx2j0I
	 wsqRCGEesS8FInhsp5cqLyxr5xxrTZj5tdlXoJLPY1n+GDL/2HFtZKoGmC7pK5ynxR
	 YFuE+z3/rmSaA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 84940F40071;
	Tue, 31 Mar 2026 14:07:33 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 31 Mar 2026 14:07:33 -0400
X-ME-Sender: <xms:ZQ3MaQ2yjdi27asNB-PFpLk0zR7jhhXq7nGCjghUmGeQIK1_xugN5g>
    <xme:ZQ3MaV5R18f6obTSuAlmzRnqtfzfMQuPdOz44QGljTgwml6jjtnC3BRWd7o1c2Lze
    UNHILRT59jdWb4WEj8uPBextNa6Gp2UAytWWmvZUjwa_6yL4zl2iYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghkucfn
    vghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    ffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvg
    hvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheel
    qdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrmhhirhejfehilhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopegurghirdhnghhosehorh
    grtghlvgdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdr
    tghomhdprhgtphhtthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZQ3MabCdl3ROliCp7YAmQeannteHN36Fk71uyOkZMPClF4-1EUdSoQ>
    <xmx:ZQ3MaXi7fLNtgsl1sHBrFSPY2ZV_RV6ySmGrGcVgx2yukZ3RDFgBNA>
    <xmx:ZQ3MaRYL6vJf9P0Il9u7rhXrzfiYH5alJwg1gr_J5_EvSoqEmoIi3A>
    <xmx:ZQ3MaQmNVsKL2vZdKfwDu5LhNj8mFLQQsjfbRs2YX9ZlVZKoXbLPbQ>
    <xmx:ZQ3MafjkVt2rcfepbJ95ZruNSry3AGTh7JzPVI3-z4gmmdUlHZhbam1i>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5DD51780070; Tue, 31 Mar 2026 14:07:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ac8dKVhrw52k
Date: Tue, 31 Mar 2026 14:07:12 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>
Cc: NeilBrown <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Amir Goldstein" <amir73il@gmail.com>
Message-Id: <88fb08eb-8494-4f3d-99cd-e0b7a459a3bb@app.fastmail.com>
In-Reply-To: <20260331153406.4049290-3-hch@lst.de>
References: <20260331153406.4049290-1-hch@lst.de>
 <20260331153406.4049290-3-hch@lst.de>
Subject: Re: [PATCH 2/4] exportfs: split out the ops for layout-based block device
 access
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[brown.name,redhat.com,oracle.com,talpey.com,vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20554-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.972];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0F7BF36FD4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, Mar 31, 2026, at 11:33 AM, Christoph Hellwig wrote:
> The support to grant layouts for direct block device access works
> at a very different layer than the rest of exports.  Split the methods
> for it into a separate struct, and move that into a separate header
> to better split things out.  The pointer to the new operation vector
> is kept in export_operations to avoid bloating the super_block.

> diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
> index 221e55887a2a..a52978f6fb76 100644
> --- a/fs/xfs/xfs_pnfs.c
> +++ b/fs/xfs/xfs_pnfs.c
> @@ -332,3 +332,9 @@ xfs_fs_commit_blocks(
>  	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
>  	return error;
>  }
> +
> +struct exportfs_block_ops xfs_export_block_ops = {
> +	.get_uuid		= xfs_fs_get_uuid,
> +	.map_blocks		= xfs_fs_map_blocks,
> +	.commit_blocks		= xfs_fs_commit_blocks,
> +};

Should xfs_export_block_ops be declared "const" ?


-- 
Chuck Lever

