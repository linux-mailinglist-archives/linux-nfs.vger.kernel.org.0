Return-Path: <linux-nfs+bounces-21650-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFcLKHeeB2oD+wIAu9opvQ
	(envelope-from <linux-nfs+bounces-21650-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 00:30:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A3558DF9
	for <lists+linux-nfs@lfdr.de>; Sat, 16 May 2026 00:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93A5A300A52C
	for <lists+linux-nfs@lfdr.de>; Fri, 15 May 2026 22:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED983F5BE9;
	Fri, 15 May 2026 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1BmAcRS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8A3F44D8
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884209; cv=none; b=p/g/tT13MfdqbumK9EzMr3NTUHg5sflGfgSx4SVI3QzzGtTxQTiNZgtg6OsRyts4JYEsw69SDlBLmvjZWrUSU05NEUEa4+g/1xvrybcHUKwkwyeBBeSYOB4b0x4n/hNJx711l2tOybIYypnzvPom4KGc9qDQCnrysE6D2PXmMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884209; c=relaxed/simple;
	bh=ReQtRGN6YCVCM+VLe1SVEp6J++lmzI2ST6cnJuKfsNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvlHGU9FujJwUr6tsxTd6zftaHSPjsCUimEPDZBL7Im1tMc06LdMd4+6lkbbcSR8gXFqS2jVmRfJbaj5JmTS+W6hEfyFPdaPg61EgJsE4xDbKaOTMJOLkvFFsQLgoCpyZinaIYCJqbdEBPGTwPI3xxIhY03hLC10w3yhBDwZa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1BmAcRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86DFC2BCB7
	for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 22:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778884208;
	bh=ReQtRGN6YCVCM+VLe1SVEp6J++lmzI2ST6cnJuKfsNY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=l1BmAcRSlMtkGR8AS0UI7PMBSsVdeQ+vAfkS1phC7SdTdRHX+BGs4MAQg6DgBmiXA
	 d+XKcoVCgyus/I8MJO2S5377iU9wMxI4ndzUMSOH3X0aA5wcic6o9RuVDF3YmW+Cyd
	 Rsm0oXBAm3I4KOJJf2LhQe4ro/ZXtPTXTgkhYGdTF1JpalHy6mrdtRIOikrONxR6gi
	 khlgGqooS0g8AnPRBVazaVmq7yYCJ19qdANfoofjF9OShgb9otGvgrG9SRWnjQPRsF
	 l52n9H+vH0yBViDvJWLpYnNjBc23ogiZTPw0OfmtteiSRyxOR0C1GXSFcVk7sCYfIz
	 GNPD2LtwC5Ozg==
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-656d749109cso450370d50.3
        for <linux-nfs@vger.kernel.org>; Fri, 15 May 2026 15:30:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8Hftqoo+Hq2SOSfVeFl8zdOIOqrdduz9Qnzzv9GrlqHOduBImnWc1HahuVdi19ukn+6PBbydltnnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeCLd9AgBfnqOPbP0NmL5O61O3jjWuF2HTlWRzaGzJPmwHLr6O
	wLhE2jrYQ0quwh9aC7nfCJLmHpYcAyYH7XN6kH1YihS5MRGZAehyeQAoBKNiW3vNGnQZfXpKGrY
	nRioc4iSA1UsZKhDVD9S4ciGWbH3TS/V1azPUW7X3Uw==
X-Received: by 2002:a05:690e:480f:b0:64e:597a:f5c2 with SMTP id
 956f58d0204a3-65e2289a39cmr4822587d50.65.1778884208163; Fri, 15 May 2026
 15:30:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512053625.2950900-1-hch@lst.de> <20260512053625.2950900-3-hch@lst.de>
In-Reply-To: <20260512053625.2950900-3-hch@lst.de>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 May 2026 15:29:57 -0700
X-Gmail-Original-Message-ID: <CACePvbUPQ=tO5feC=2-8XdBV1PgzoX+EwASU__jNiuzcGsPMPA@mail.gmail.com>
X-Gm-Features: AVHnY4KVT3GwVUdlKXUpf18PwWGpkgh1B7IPlKLHiB6TxVcw3NQNEM73-FjKVDw
Message-ID: <CACePvbUPQ=tO5feC=2-8XdBV1PgzoX+EwASU__jNiuzcGsPMPA@mail.gmail.com>
Subject: Re: [PATCH 02/12] swap: move boilerplate code into the core swap code
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4C1A3558DF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21650-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,tencent.com,kernel.org,kernel.dk,suse.com,mit.edu,gmail.com,samba.org,manguebit.org,wdc.com,vger.kernel.org,kvack.org,lists.sourceforge.net];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:36=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Make the core swap code calculate sis->pages, nr_extents and the span,
> re-set sis->max based on it and don't require passing the current offset
> into the swap file to swap_add_extent as all that can trivially be
> calculated internally.  Also truncate the spans based on the available
> information.
>
> All this removes a lot of boilerplate code in the callers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Very nice cleanup.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

