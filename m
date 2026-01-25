Return-Path: <linux-nfs+bounces-18450-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDHdN+RIdmmJOgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18450-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 17:46:28 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E284817DF
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 17:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190C4300E3A9
	for <lists+linux-nfs@lfdr.de>; Sun, 25 Jan 2026 16:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960BF326942;
	Sun, 25 Jan 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5BuR2de"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5721CFE0;
	Sun, 25 Jan 2026 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769359443; cv=none; b=m0XgLG5dnewZnHR70h/5wIjL52QJGovh2AJrlR+EKEfMNizaVpogYOkZu8UwRaFv9eUgBrXIZq3qPlX0tNseDW44x19P0IIbCUD3rgFWh0DpP44VVqS/yPVEOMKwK86FZPRGC+nczaM9Uovmo0dtF8IHFf6V66V6WgxvOL97yHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769359443; c=relaxed/simple;
	bh=M91B9cmFJPED30HL+COJHecfmFxSMxt9hsXhLt9lIIg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kQUM4mf1OPFiVVophWV5IIqMFryX86wtcyL32MpnVE8fU0CpD7f18LTN6pZW8VnTF47+ioZW3rMuAsWCzf9Z7ej/QP2+beuLVfld9b1CZmtXM/srUA9xIu9CzvrUvOPTVjWapcF8q7NCqo9hA41apgcHt8adjllRQx8lI8OUuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5BuR2de; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB97AC4AF0B;
	Sun, 25 Jan 2026 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769359443;
	bh=M91B9cmFJPED30HL+COJHecfmFxSMxt9hsXhLt9lIIg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=H5BuR2devwpyo/bCawvNLlcR26bfnjXEbVsC4YQeuk4xHLYV12PUeTSlZ/zc82jRn
	 N2a6/nSHBd9/ty+YCaiFxyAp3sAKFC2q5TiPfbex12WyeU5w3R1P29XQyTpZic8NJx
	 uIIA4DDReeM9E85uOGEg8+212y/HUPClZ3G876L1BnAy6mp/hMrUN3wBC9N8vsZRHk
	 SW2B45LbKBt7XakIHQwqVVwzvtKPE/1EcWsP35SIccABOp0frRlHwDnZ0p7vfkw7v/
	 XVYAC+qOwTlRxGh21ZENrr/JRaKWuxEKKhh0+Dtz3pnbGCNmNMuKf/PiLW6+L/agS+
	 pwmHxXKXFcX4Q==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B54B9F4006A;
	Sun, 25 Jan 2026 11:44:01 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sun, 25 Jan 2026 11:44:01 -0500
X-ME-Sender: <xms:UUh2abBOx9pliDi5Ss_aViq5-TU5VnSRg7I7JbDrro7BEhKIsMQBWQ>
    <xme:UUh2acV0XT1me0B70Mk4zeAvxpJhAJqF-i99fuUlyIPqppfHNiPKQwnmTgvPoRF12
    MbJcWdoa9eP4K5h8zKn3xZtjOuJ6BB75fUkeE_8tqus2plrk4BrkU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtgho
    mhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtph
    htthhopehokhhorhhnihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepthhomhes
    thgrlhhpvgihrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UUh2aQAN2RvQkf5vImx9ZWXC4yS3Zi5uHwkGhPBYg4vEsFdV7MrMWw>
    <xmx:UUh2aeiG0LlKejUDEYlXz3EAWILYxkmsXGIXLR1AVjbOyHu7xx4n2A>
    <xmx:UUh2aVwxoYcRqb8xhQmp0ZlEQ5-lnv8GnaIl0CEiweeXZsIBNHc4dw>
    <xmx:UUh2aX2Mfg1jbMYYJmQMzWdtxKTv4-BoUtJh7__-jjAmaY2xDolxIg>
    <xmx:UUh2aS_0c-GvTI-S5oCTVRa89e_wqjcjihWbJNxgPRtHmJxpZXkInTRg>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 889B3780076; Sun, 25 Jan 2026 11:44:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIHa78QCmU1N
Date: Sun, 25 Jan 2026 11:43:21 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <a6960530-c872-4bc8-a125-0834f12a6108@app.fastmail.com>
In-Reply-To: <20260125-delegts-v2-2-cd004157fb46@kernel.org>
References: <20260125-delegts-v2-0-cd004157fb46@kernel.org>
 <20260125-delegts-v2-2-cd004157fb46@kernel.org>
Subject: Re: [PATCH v2 2/2] nfsd: remove NFSD_V4_DELEG_TIMESTAMPS Kconfig option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-18450-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E284817DF
X-Rspamd-Action: no action



On Sun, Jan 25, 2026, at 7:24 AM, Jeff Layton wrote:
> Now that there is a runtime debugfs switch, eliminate the compile-time
> switch and always build in support for delegated timestamps.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/Kconfig     | 10 ----------
>  fs/nfsd/nfs4state.c |  7 -------
>  2 files changed, 17 deletions(-)
>
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index 
> 4fd6e818565ea24e4e16844a3f82e808dbc558f8..fc0e87eaa25714d621aa893c99dabe4ce34228df 
> 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -177,16 +177,6 @@ config NFSD_LEGACY_CLIENT_TRACKING
>  	  and will be removed in the future. Say Y here if you need support
>  	  for them in the interim.
> 
> -config NFSD_V4_DELEG_TIMESTAMPS
> -	bool "Support delegated timestamps"
> -	depends on NFSD_V4
> -	default n
> -	help
> -	  NFSD implements delegated timestamps according to
> -	  draft-ietf-nfsv4-delstid-08 "Extending the Opening of Files". This
> -	  is currently an experimental feature and is therefore left disabled
> -	  by default.
> -
>  config NFSD_V4_POSIX_ACLS
>  	bool "Support NFSv4 POSIX draft ACLs"
>  	depends on NFSD_V4
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 
> 95f2e87141a7ab5dd3da6741859bdcae28a8c6c0..e2f29ba490c6335e2cb6c3a411770b3a19755095 
> 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6047,19 +6047,12 @@ nfsd4_verify_setuid_write(struct nfsd4_open 
> *open, struct nfsd_file *nf)
>  	return 0;
>  }
> 
> -#ifdef CONFIG_NFSD_V4_DELEG_TIMESTAMPS
>  static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
>  {
>  	if (!nfsd_delegts_enabled)
>  		return false;
>  	return open->op_deleg_want & OPEN4_SHARE_ACCESS_WANT_DELEG_TIMESTAMPS;
>  }
> -#else /* CONFIG_NFSD_V4_DELEG_TIMESTAMPS */
> -static bool nfsd4_want_deleg_timestamps(const struct nfsd4_open *open)
> -{
> -	return false;
> -}
> -#endif /* CONFIG NFSD_V4_DELEG_TIMESTAMPS */
> 
>  static struct nfs4_delegation *
>  nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
>
> -- 
> 2.52.0

Thanks for jumping on the robot report.

This time around, LLM review produced some comments related to
documentation that seem pretty sensible to me, so I'm passing
these along verbatim:

  Key Concerns:                                                                                                                                 

  1. Behavioral change: Systems that previously disabled this experimental feature at compile-time will now have it enabled by default after upgrade. While the runtime switch allows disabling, administrators are not informed of this change.
  2. Documentation gap: The commit message is minimal and doesn't explain the transition rationale, migration path, or the loss of the RFC specification reference that was in the Kconfig help text.

[ cel: Perhaps some of the context provided in the cover letter
is not visible to the LLM -- but note, that context won't appear
in the commit history either ]

  Recommendations:                                                                                                                              
                                                                                                                                                
  1. Consider whether nfsd_delegts_enabled should default to false to preserve the conservative default of the removed Kconfig option, or document the intentional policy shift
  2. Expand commit message to include migration guidance:                                                                                       
  Administrators who previously disabled this feature at compile time can disable it at runtime via:
    echo 0 > /sys/kernel/debug/nfsd/delegated_timestamps                                                                                        
  3. Add a brief comment above nfsd4_want_deleg_timestamps() documenting the debugfs control and RFC reference


As the new debugfs switch is intended to be undocumented and
temporary, I think adding some code comments and a little more
beef to the commit message (sorry vegans) would be helpful. You
don't need to go crazy with it.


-- 
Chuck Lever

