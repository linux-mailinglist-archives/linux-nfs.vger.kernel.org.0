Return-Path: <linux-nfs+bounces-22375-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9qQBEr/9JmpDpQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22375-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 19:37:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 921AB659505
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 19:37:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Et3aoZm+;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22375-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22375-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BB743106921
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 16:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B73B27CD;
	Mon,  8 Jun 2026 16:24:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43C31F991
	for <linux-nfs@vger.kernel.org>; Mon,  8 Jun 2026 16:24:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935857; cv=none; b=lbaqJ6W4S+MP24uYqgx3/QkskUoTYvbl2FKLT1K6cgwmCHuNSfXT5+YuGQcV2OI56BJeU6LocEF9vET+iLO3WipY9oSnBzk9xKdd8aV8bKsZo0LuZtrjGv5ot0r+0VGsxjOhPhfepUOYYG6QaEyHaop8mVyJ6T1CeBbyc0ql2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935857; c=relaxed/simple;
	bh=Za+kVPKa2AwiJlfvCP8JXIj/JufkaNptoX+jtK/OG4U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kwHh7b8mJG1iQPZkbJmzTWcgRzvstMHnEQAqKcBLMg7evRCuixusPjEZhfozbDJSHKFr+evajrQhht4T0ns13XkVWSJE8yeazrfACaDWWFj1BwzOCtanZP9WF3xRdYNmLEFW9Gu0kSJkhdcbjDixUYP9lI6dxY1ujVutZHK+wL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Et3aoZm+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4471F00898;
	Mon,  8 Jun 2026 16:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780935854;
	bh=ugksCuZC6wpT8aoAPTtnEfz1vWdw++QWxPb73hfX0tE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Et3aoZm+WNr1t39h4ncJiaJl6w6jdfnKOfEqb8+vRZj8vRQFaHjffWdbQC3rA/pCy
	 w4ASbpQvNjxdBtmDE+AnQXqO1V2b0PE6iAmtaLlgIDXynAtN+m2/K/HPrK89YvrPkl
	 tBPnp/2Dk0hQn4bHrdedeMpS5Szoemj8wClyu/RpwxX74PnmLoO1HNdoTI8Tdx9HEV
	 d9ugxVJLdK0cBa+7rfQc6Oadx8wGDCDVpWPfEROikE7cboEhr5/1BpikHDUpjeCb/G
	 xKG6Gr286DalFeoUsNz1tqWNvAHz1zUUqVNRF8lioXF9avjviiZLhEvGiO91VgJwB0
	 pRhy4xqiraSMg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 401A7F40074;
	Mon,  8 Jun 2026 12:24:13 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 08 Jun 2026 12:24:13 -0400
X-ME-Sender: <xms:rewmalFHAZap8oqdVoPycHO1vyfn2l-05cXt63gmoYFnZJ000SHRMg>
    <xme:rewmalL32Nyn46OtPRw1jlFroKt-entvKEB6lN0VQhWbRdGk6DsEibGAB1ZpFBD4U
    8wA6Kv_36Mpv59rLypZRV0TejRYnFSn63FjNp2p8fb7Pp8ng2O2EbE>
X-ME-Proxy-Cause: dmFkZTGQmWP4SITDFdMmfoDJDOuHGc1AaRMxLeXAu25kBSoaFZUGyn073Z/HvyUkjm7D0b
    fmLdunJCKPvgIljEQxSn3ir84MvS4jmma0tlBYTFyCmx7vmi0dcslya/La3iii/TW+kKj9
    0OqtBp4mwrB4XUVf+p3QHZMGO0HS8q1i6RESaNM1qy9rWA0QKx7kk/dcEZZ9aGpsr5H6ac
    ogdi2FKNtuHja0VDvt2mZ2Z71je/WPat2NF3nAp8gjjVYRWP9qpe495LGuShoudO4JSybg
    7HpBSQuxmYL74PK/sKLgZcVEuWgVYtG/tJdhFxVOJwr8OEX7tnd+e2MYUvaQMjQ7xc7HDe
    R+29UGY8yNLkdyys4YRDpxM8yCS0AwRsq1U9jBtUFJ05hVMbBZohJQB7Ktl2B8+V+5yyQZ
    MTn0tbgEOkjodLc+Wm+TK/aLU1JowvIwSE7uaZ6A5U3Srw8wEcsjFWowxlKtZEEtW8hNZb
    c8G3gUK0AaRo+gYhMDz4hzpYTGems7UC1mNb3tftTvD9Gz1Ldt4nFWe0dHODDpCFb8UJZd
    V5tdbvwA2XicxlH3/o+jcBxZTicSIOsZ/KUVjcaSmIL8AV6lEu04xIgkbe6xfujgdBML0j
    YR6DfweizacgTnpCE7OVtjBzVZRGQjJ+2+Y8035Nmslii09OTGx2WUDeZdBw
X-ME-Proxy: <xmx:rewmag9JBoNZYt8j0lxHyhfFiy4rPZJsnxnegok_B8QgdscU5c9YIQ>
    <xmx:rewmajZuyu02k09knoUXIZUV3VpqQ0dhbPdGq5U9ifU24-4M6Q6UUg>
    <xmx:rewmasojvZhGFTrQapzy44cV8BRDF88sjJ9dfAEwPRGgQeGuXrev0Q>
    <xmx:rewmarZUEL5PR1xiz7AzbL_f5sti0QjOYMEZSNNWqU2BlOWCw7sd3Q>
    <xmx:rewmav60ds-lv_UEKh555xm7ca0vAvUFkxtbUqEMvrsTk_dKqkObLBJ_>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 11D81780075; Mon,  8 Jun 2026 12:24:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AD4ixzKPKzqo
Date: Mon, 08 Jun 2026 12:23:52 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: "Alexander Aring" <alex.aring@gmail.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Calum Mackay" <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <bf852bf8-2d80-4b12-8d7c-bb0770c8b379@app.fastmail.com>
In-Reply-To: <20260522-dir-deleg-v4-3-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
 <20260522-dir-deleg-v4-3-2acb883ac6bc@kernel.org>
Subject: Re: [PATCH v4 03/21] nfs_common: add new NOTIFY4_* flags proposed in
 RFC8881bis
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22375-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 921AB659505

Unfortunately, reviewing this series slipped off my radar. I'm just now
getting to it. I'm going to do this in order and some of the earlier
reviews are cosmetic. But there are some significant changes needed
later on, so I expect we'll need to redrive this series and punt it to
v7.3.

One thing you might update before you repost is to remove the "Acked-by:
Chuck Lever" throughout the series.


Nit: the Subject: prefix should be "nfsd:" not "nfs_common:"


On Fri, May 22, 2026, at 8:28 AM, Jeff Layton wrote:
> RFC8881bis adds some new flags to GET_DIR_DELEGATION that we very much
> need to support.

Nit: Let's say: "RFC8881bis adds new flags to GET_DIR_DELEGATION
that later patches consume."

One recent private comment to me was a question about whether we can
trust the stability of the specification, which is still a WG document
and has been for years. This patch's commit message should address
that.


> diff --git a/Documentation/sunrpc/xdr/nfs4_1.x 
> b/Documentation/sunrpc/xdr/nfs4_1.x
> index 632f5b579c39..aa14b590b524 100644
> --- a/Documentation/sunrpc/xdr/nfs4_1.x
> +++ b/Documentation/sunrpc/xdr/nfs4_1.x
> @@ -416,7 +416,21 @@ enum notify_type4 {
>          NOTIFY4_REMOVE_ENTRY = 2,
>          NOTIFY4_ADD_ENTRY = 3,
>          NOTIFY4_RENAME_ENTRY = 4,
> -        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5
> +        NOTIFY4_CHANGE_COOKIE_VERIFIER = 5,
> +        /*
> +         * Added in NFSv4.1 bis document
> +         */

I clarified this comment: "/* Proposed in RFC8881bis */"

I rebuilt the generated source to confirm that it hasn't been altered
by recent changes to xdrgen or this comment change. The only thing
that changed in the output was the header's timestamp.


-- 
Chuck Lever

