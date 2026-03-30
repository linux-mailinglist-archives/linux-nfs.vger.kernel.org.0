Return-Path: <linux-nfs+bounces-20533-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGvgGeWJymn09gUAu9opvQ
	(envelope-from <linux-nfs+bounces-20533-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 16:34:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E62435CEFB
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 16:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 971AE300723F
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 14:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292AE3A63E3;
	Mon, 30 Mar 2026 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAM5duh0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DFF3A4F2F
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880584; cv=none; b=ACzRbOiJ5lIV32VUlyL9pmAuCwUgjjLR3yaYE0QhDHm1B3mzJT/Mpv+dPL1GtwE+p4a3LecPZNNkShetRBOLAE4BDIo9TumDuxcuTnk0u7s4X+4rrGzODl4gR+Si7Dh8mizeQIDaEr8761YYDWEMe1uMYYqhSxPGaHLvU3VDFqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880584; c=relaxed/simple;
	bh=X2QXEXEFSfwD5XWt9JWleVw62Lz3GGAaZBixEVmCkr8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GC0CWtITfR29k0kOLt2M2hsFz/23B1ewiSeF8z51MC/aGw8OFeB+uaxtoJYsBIPFhGBsBwpuyKpxzXcXW2XC8001yWkQAvQ3Ntl829stW6K3O3glDzbm1UiKk3L9JZQGnd+11w9yoMN6Gsj3F6D/TReBv0kXkMWlPx8BQVFo/t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAM5duh0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F489C2BCB3;
	Mon, 30 Mar 2026 14:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880583;
	bh=X2QXEXEFSfwD5XWt9JWleVw62Lz3GGAaZBixEVmCkr8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TAM5duh0IjYqx3GqRtuVhEWl+qVkhVyI7kSa2heg6ypA+WozAnHds5Tv7pckuG3a9
	 KwifKmDJrsYm0OJTXwrsb0kxZJBLfi5F7udP/8ycPqoNat+WxLA6s6iuC4bFnr4Y9C
	 LJ9FarRYj01SYimgUtAgeNSBBpMrk8d3Wr7FuHyRDGowtmz8eGAGnihbI7exqAfgVl
	 ZNWSbM5mkr4mpA0kFc45vFyhWLwgcUM9YJolC83lJfldHCYTOpgurDbem4Gu6u4T2M
	 NzVnFOmTgGZjRWGrI+5EfTaG0wJewOA3MXjCC+pWUTVYKu4UipuptqEJc9P2piP29k
	 jsVzN5vaslM3A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3A992F40074;
	Mon, 30 Mar 2026 10:23:02 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 30 Mar 2026 10:23:02 -0400
X-ME-Sender: <xms:RofKaS9EIgFMi90wfpVQjysssYOERs6mFNDwk29YnHfkazOiK9HESg>
    <xme:RofKadgVvL1QH6wdPxVkkGX5fIdiVKsxNLpYlIAopHM3_RFhMqnNWdjQIZGbj4joY
    Kmt16vEv8PW6870b6bACdo3STcn3nYmEVzxwJpF-zflKMiinL_o1yIL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
    dprhgtphhtthhopegrnhhnrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhm
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeht
    rhhonhgumhihsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RofKaYe-feDAY0S0u4Q3DhLiSGNtASioub4kVhaXM3a-pU5eDBE6zg>
    <xmx:RofKaWgzrfLoJ_XEhOzn-_QLtLGPGKt-fwsutXHLtVxY0nOYe5JhPQ>
    <xmx:RofKabL1wz32PObeY-a0s4G6-BTkTcCwOa5rxIh2YXOSPqa4L1PyCA>
    <xmx:RofKabFHioCJw2Vz9V4IsSY4Kq0SDyRTRbFmxAXiyJ9G81DWRB0NwQ>
    <xmx:RofKaZ0oV0-dsthFJkwPdxw3XKnYjnyBUHBoEmr-E_XNPxXE_0WxnrI9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E2B79780075; Mon, 30 Mar 2026 10:23:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AN4VOCyftktg
Date: Mon, 30 Mar 2026 10:22:41 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Donald Hunter" <donald.hunter@gmail.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <30ff0483-ec38-40b3-811b-6cd66febe1b1@app.fastmail.com>
In-Reply-To: <20260325-exportd-netlink-v2-10-067df016ea95@kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
 <20260325-exportd-netlink-v2-10-067df016ea95@kernel.org>
Subject: Re: [PATCH v2 10/13] nfsd: add netlink upcall for the svc_export cache
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20533-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.899];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6E62435CEFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, Mar 25, 2026, at 10:40 AM, Jeff Layton wrote:
> Add netlink-based cache upcall support for the svc_export (nfsd.export)
> cache to Documentation/netlink/specs/nfsd.yaml and regenerate the
> resulting files.

> diff --git a/Documentation/netlink/specs/nfsd.yaml 
> b/Documentation/netlink/specs/nfsd.yaml
> index 
> 8ab43c8253b2e83bcc178c3f4fe8c41c2997d153..709751502f8b56bd4b68462fa15337df5e3e035e 
> 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -6,7 +6,51 @@ uapi-header: linux/nfsd_netlink.h
> 
>  doc: NFSD configuration over generic netlink.
> 
> +definitions:
> +  -
> +    type: flags
> +    name: cache-type
> +    entries: [svc_export]
> +  -
> +    type: flags
> +    name: export-flags
> +    doc: These flags are ordered to match the NFSEXP_* flags in 
> include/linux/nfsd/export.h
> +    entries:
> +      - readonly
> +      - insecure-port
> +      - rootsquash
> +      - allsquash
> +      - async
> +      - gathered-writes
> +      - noreaddirplus
> +      - security-label
> +      - sign-fh
> +      - nohide
> +      - nosubtreecheck
> +      - noauthnlm
> +      - msnfs
> +      - fsid
> +      - crossmount
> +      - noacl
> +      - v4root
> +      - pnfs
> +  -
> +    type: flags
> +    name: xprtsec-mode
> +    doc: These flags are ordered to match the NFSEXP_XPRTSEC_* flags 
> in include/linux/nfsd/export.h
> +    entries:
> +      - none
> +      - tls
> +      - mtls
> +
>  attribute-sets:
> +  -
> +    name: cache-notify
> +    attributes:
> +      -
> +        name: cache-type
> +        type: u32
> +        enum: cache-type
>    -
>      name: rpc-status
>      attributes:
> @@ -132,6 +176,103 @@ attribute-sets:
>        -
>          name: npools
>          type: u32
> +  -
> +    name: fslocation
> +    attributes:
> +      -
> +        name: host
> +        type: string
> +      -
> +        name: path
> +        type: string
> +  -
> +    name: fslocations
> +    attributes:
> +      -
> +        name: location
> +        type: nest
> +        nested-attributes: fslocation
> +        multi-attr: true
> +  -
> +    name: auth-flavor
> +    attributes:
> +      -
> +        name: pseudoflavor
> +        type: u32
> +      -
> +        name: flags
> +        type: u32
> +        enum: export-flags
> +        enum-as-flags: true
> +  -
> +    name: svc-export-req
> +    attributes:
> +      -
> +        name: seqno
> +        type: u64
> +      -
> +        name: client
> +        type: string
> +      -
> +        name: path
> +        type: string

Is the svc-export-req attribute set used for anything?


> +  -
> +    name: svc-export
> +    attributes:
> +      -
> +        name: seqno
> +        type: u64
> +      -
> +        name: client
> +        type: string
> +      -
> +        name: path
> +        type: string
> +      -
> +        name: negative
> +        type: flag
> +      -
> +        name: expiry
> +        type: u64
> +      -
> +        name: anon-uid
> +        type: u32
> +      -
> +        name: anon-gid
> +        type: u32
> +      -
> +        name: fslocations
> +        type: nest
> +        nested-attributes: fslocations
> +      -
> +        name: uuid
> +        type: binary
> +      -
> +        name: secinfo
> +        type: nest
> +        nested-attributes: auth-flavor
> +        multi-attr: true
> +      -
> +        name: xprtsec
> +        type: u32
> +        enum: xprtsec-mode
> +        multi-attr: true
> +      -
> +        name: flags
> +        type: u32
> +        enum: export-flags
> +        enum-as-flags: true
> +      -
> +        name: fsid
> +        type: s32
> +  -
> +    name: svc-export-reqs
> +    attributes:
> +      -
> +        name: requests
> +        type: nest
> +        nested-attributes: svc-export
> +        multi-attr: true
> 
>  operations:
>    list:
> @@ -233,3 +374,36 @@ operations:
>            attributes:
>              - mode
>              - npools
> +    -
> +      name: cache-notify
> +      doc: Notification that there are cache requests that need 
> servicing
> +      attribute-set: cache-notify
> +      mcgrp: exportd
> +      event:
> +        attributes:
> +          - cache-type
> +    -
> +      name: svc-export-get-reqs
> +      doc: Dump all pending svc_export requests
> +      attribute-set: svc-export-reqs
> +      flags: [admin-perm]
> +      dump:
> +          request:
> +            attributes:
> +              - requests
> +    -
> +      name: svc-export-set-reqs
> +      doc: Respond to one or more svc_export requests
> +      attribute-set: svc-export-reqs
> +      flags: [admin-perm]
> +      do:
> +          request:
> +            attributes:
> +              - requests
> +
> +mcast-groups:
> +  list:
> +    -
> +      name: none
> +    -
> +      name: exportd


-- 
Chuck Lever

