Return-Path: <linux-nfs+bounces-22835-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S1vWALo8PWqDzwgAu9opvQ
	(envelope-from <linux-nfs+bounces-22835-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 16:35:38 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0476C6B10
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 16:35:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nhjQDjNI;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22835-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22835-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA0F03171B69
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jun 2026 14:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4F0392837;
	Thu, 25 Jun 2026 14:27:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9D538E5C4
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jun 2026 14:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397668; cv=none; b=EQYZyIjI+Gi8SUv/nHS82XzmHlpOwniIdD2KqxIRYd5i/yiYetMtpeaUG5ic0MEkUVuITacMHw7BJTf1NNd2IX3LrLUvb2gFuzRj/ZG8Bmg4eqBsBZ4rnHP/PkIVXQIrdRmiPSGJmQw1T8C+tOkUG96pxlWu/WvvlGd57eDbLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397668; c=relaxed/simple;
	bh=yrov0n4BJglgRlZ8s0Nd/vkfUcrq8uIUVk1tdl0VCSQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WWlBJ2laGBP0M5L4M9MnLM4y+D1+FBAaMvqdRokoIsOa+CnDtBiDRnjdw7f34mRV33oa6B+SgEhGsIGPo7Vo0ml+pIfs/+QayOol+f52Wa/u+2QxTQpwOpRmCgoCv/A2wjbNen3U8/bOXUgHGRjCr4SbR8yuB+T1Z6+dKXer8fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhjQDjNI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B531D1F000E9;
	Thu, 25 Jun 2026 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782397665;
	bh=9bN4MkuLPTowGDmDqgSY8eW47+jblydvdJag1+rwfaI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=nhjQDjNIHJhyXH+cprt7ChxuIcqFUvRHTQKVDAP+zsXx3iLbabOEFZkiC+iSjq0qs
	 YIaGUsR+ijsEQ6dif+N4Z1VrIqMa187Jxk6mhP+NKJmkKgnN+Te7Zv758HVopcDBKv
	 yK5Fa/V/MEhMk+bsdXafOYkWiyAYkt+8AzoPgITPE6GBypX7K0SCRA4U3GD95xkZUg
	 Rj1C706EeHNBv9L/ppaU1u2/jo9ESQ6kcCPX1i7R24F/yjgOuUEoAGyUB5ArMEf7Fc
	 +79Hzr+JmZDpc+2x2Tvu60dOuVa3/sAXlPnaSCOMvG0TCrwLKWqo1SB7OQTCK1gAzZ
	 6oBkM54EEhCXg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1F6A4F4006F;
	Thu, 25 Jun 2026 10:27:44 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-02.internal (MEProxy); Thu, 25 Jun 2026 10:27:44 -0400
X-ME-Sender: <xms:4Do9asLcAVdVhhe38AfhYElGSI1mNnWzQlBp1wQpswZgPFhO75LavA>
    <xme:4Do9am8eiFLf3euCMNV5w3-UZjxVxci9PoIJSbNqcncRFdC2Tbrfq3NUkldLCJfSP
    6gr7nvTX0q9cndB7wVMio_z_KFXSZ04Ww8827pHZ2S5XOMntFqaHVA>
X-ME-Proxy-Cause: dmFkZTGIoxEsdVdUCgBBnZSuGVVmsUaUsMbULvPKht7nhHeuVpdh/sOJUqxDKdGTFQe7as
    54aZXE+gLiAFlMQ5Bpl/L89IAPjQ4hQmgDv9HfQggLwaDlZZjseqINRUi+ybm+z+ZpZHQ1
    5qdSn5mXwyoPhAhq5QtPpPWX00BLez4q3jh66xws4qh+xvlqrErvunojBg5BZuNnjNRG5F
    IXWk66gFzzUQQEV+3oFmgslSPWq346ob99vaM39n9nkaEaC9LGLnDj4LiIqxIq3puN9+pg
    YJpRodbr+1eqp7vLUX6lHECjoyTlTkGrp9eSOSeUn3DP9t0vAxWAxD5/ZCb4KurORvz6ly
    5vvGw5/uHCnAhvqZcr/oBaZSRJVuj114bHfFzHtZgkkEO79OzbqcMdEH2gt3rSd6thxz40
    vRhcIjx2OcuBRbsnSOV+oNB2uaLLhliypux8JtHtg+2c79/WCuTQdVrwha3SDuHqMmKwQC
    phy6NbNErexWP1t1eJhmBt/C4dQ2tm0xGRVaScDWCexKuV+M6Z2bmm+qPJVvj8EwvR3MLF
    47S71alxmN6/H48BbZN/ZaFY6nQtsVmS7Gg1dEddr3c+eD3KdgVXScUXvN6REj4qyU4JIx
    +wZswOzhecwMoYYDs+mmzTRzvhSh2uf+H65gWN1hZzq8Nu9TdW2SLXAtj8Tg
X-ME-Proxy: <xmx:4Do9auPMtF85cwVDAjFOttzX6YlHgLqIbTQOiM6KYED3gmcNFR_S-A>
    <xmx:4Do9audY9HDI8F2H_TXSGq9RtXqdB18KT_kUY7YztyCPDiHHTolUKA>
    <xmx:4Do9alUh8xtl7hppOi5V7-GUQZGq00otgKXU_1puozNkZyhgen0GBg>
    <xmx:4Do9aujoz8rMvk3TLkSQg6o5YB6Bo-cd7A_pzs-FIxgQt8b81QdJTQ>
    <xmx:4Do9as_i32GhaIjNPWr-xXCYqeOjsVkm9uJuhYJXQ3xyZfpznh2ljVeB>
Feedback-ID: i20964851:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F0B2BB6006E; Thu, 25 Jun 2026 10:27:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHquR-yw989F
Date: Thu, 25 Jun 2026 10:26:22 -0400
From: "Anna Schumaker" <anna@kernel.org>
To: "Mike Snitzer" <snitzer@kernel.org>,
 "Trond Myklebust" <trondmy@kernel.org>
Cc: "Tom Haynes" <loghyr@hammerspace.com>, "Chuck Lever" <cel@kernel.org>,
 linux-nfs@vger.kernel.org
Message-Id: <16ff281b-f776-4e6c-9f2a-83c03f0d6eae@app.fastmail.com>
In-Reply-To: <20260624191706.72544-2-snitzer@kernel.org>
References: <20260624191706.72544-1-snitzer@kernel.org>
 <20260624191706.72544-2-snitzer@kernel.org>
Subject: Re: [PATCH 1/4] nfs4.2: add nfs4_2.x to generate the UNCACHEABLE_FILE_DATA
 attribute
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:snitzer@kernel.org,m:trondmy@kernel.org,m:loghyr@hammerspace.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22835-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,app.fastmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anna@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E0476C6B10

Hi Mike,

On Wed, Jun 24, 2026, at 3:17 PM, Mike Snitzer wrote:
> Introduce Documentation/sunrpc/xdr/nfs4_2.x for NFSv4.2 protocol
> extensions and define the UNCACHEABLE_FILE_DATA attribute (attr 87)
> there, verbatim from draft-ietf-nfsv4-uncacheable-files Section 7:
>
>   typedef bool            fattr4_uncacheable_file_data;
>   const FATTR4_UNCACHEABLE_FILE_DATA      = 87;
>
> This mirrors how the sibling NFSv4.2 attributes (FATTR4_OFFLINE=83,
> FATTR4_TIME_DELEG_*=84/85, FATTR4_OPEN_ARGUMENTS=86) are defined in
> Documentation/sunrpc/xdr/nfs4_1.x and generated by
> tools/net/sunrpc/xdrgen into <linux/sunrpc/xdrgen/nfs4_1.h>, which
> nfs4.h already includes.
>
> Wire the fs/nfsd "make xdrgen" target to generate the definitions header
> <linux/sunrpc/xdrgen/nfs4_2.h> and include it from <linux/nfs4.h>, so the
> generated FATTR4_UNCACHEABLE_FILE_DATA constant and the
> NFS4_fattr4_uncacheable_file_data_sz size macro are available to the
> NFSv4.2 client support that follows.

Aren't these client side changes? The xdrgen stuff is used on the
server-side. I wouldn't expect any of these values to be available
if nfsd is kconfig-ed off.

Thanks,
Anna

>
> No functional change.
>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  Documentation/sunrpc/xdr/nfs4_2.x    | 52 ++++++++++++++++++++++++++++
>  fs/nfsd/Makefile                     |  5 ++-
>  include/linux/nfs4.h                 |  1 +
>  include/linux/sunrpc/xdrgen/nfs4_2.h | 19 ++++++++++
>  4 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/sunrpc/xdr/nfs4_2.x
>  create mode 100644 include/linux/sunrpc/xdrgen/nfs4_2.h
>
> diff --git a/Documentation/sunrpc/xdr/nfs4_2.x 
> b/Documentation/sunrpc/xdr/nfs4_2.x
> new file mode 100644
> index 000000000000..d10a91d657b0
> --- /dev/null
> +++ b/Documentation/sunrpc/xdr/nfs4_2.x
> @@ -0,0 +1,52 @@
> +/*
> + * Copyright (c) 2026 IETF Trust and the persons identified
> + * as the document authors.  All rights reserved.
> + *
> + * The document authors are identified in RFC 7862 and
> + * draft-ietf-nfsv4-uncacheable-files.
> + *
> + * Redistribution and use in source and binary forms, with
> + * or without modification, are permitted provided that the
> + * following conditions are met:
> + *
> + * - Redistributions of source code must retain the above
> + *   copyright notice, this list of conditions and the
> + *   following disclaimer.
> + *
> + * - Redistributions in binary form must reproduce the above
> + *   copyright notice, this list of conditions and the
> + *   following disclaimer in the documentation and/or other
> + *   materials provided with the distribution.
> + *
> + * - Neither the name of Internet Society, IETF or IETF
> + *   Trust, nor the names of specific contributors, may be
> + *   used to endorse or promote products derived from this
> + *   software without specific prior written permission.
> + *
> + *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS
> + *   AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
> + *   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + *   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + *   FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
> + *   EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
> + *   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
> + *   EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> + *   NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
> + *   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + *   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> + *   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
> + *   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
> + *   IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
> + *   ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +pragma header nfs4;
> +
> +/*
> + * The following content was extracted from
> + * draft-ietf-nfsv4-uncacheable-files
> + */
> +
> +typedef bool            fattr4_uncacheable_file_data;
> +
> +const FATTR4_UNCACHEABLE_FILE_DATA      = 87;
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index f0da4d69dc74..0ff198e102a3 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -37,11 +37,14 @@ nfsd-$(CONFIG_DEBUG_FS) += debugfs.o
>  #
>  .PHONY: xdrgen
> 
> -xdrgen: ../../include/linux/sunrpc/xdrgen/nfs4_1.h nfs4xdr_gen.h 
> nfs4xdr_gen.c
> +xdrgen: ../../include/linux/sunrpc/xdrgen/nfs4_1.h 
> ../../include/linux/sunrpc/xdrgen/nfs4_2.h nfs4xdr_gen.h nfs4xdr_gen.c
> 
>  ../../include/linux/sunrpc/xdrgen/nfs4_1.h: 
> ../../Documentation/sunrpc/xdr/nfs4_1.x
>  	../../tools/net/sunrpc/xdrgen/xdrgen definitions $< > $@
> 
> +../../include/linux/sunrpc/xdrgen/nfs4_2.h: 
> ../../Documentation/sunrpc/xdr/nfs4_2.x
> +	../../tools/net/sunrpc/xdrgen/xdrgen definitions $< > $@
> +
>  nfs4xdr_gen.h: ../../Documentation/sunrpc/xdr/nfs4_1.x
>  	../../tools/net/sunrpc/xdrgen/xdrgen declarations $< > $@
> 
> diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> index 44e5e9fa12e1..34aa303354bc 100644
> --- a/include/linux/nfs4.h
> +++ b/include/linux/nfs4.h
> @@ -18,6 +18,7 @@
>  #include <uapi/linux/nfs4.h>
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/sunrpc/xdrgen/nfs4_1.h>
> +#include <linux/sunrpc/xdrgen/nfs4_2.h>
> 
>  enum nfs4_acl_whotype {
>  	NFS4_ACL_WHO_NAMED = 0,
> diff --git a/include/linux/sunrpc/xdrgen/nfs4_2.h 
> b/include/linux/sunrpc/xdrgen/nfs4_2.h
> new file mode 100644
> index 000000000000..9441f6cefbff
> --- /dev/null
> +++ b/include/linux/sunrpc/xdrgen/nfs4_2.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Generated by xdrgen. Manual edits will be lost. */
> +/* XDR specification file: ../../Documentation/sunrpc/xdr/nfs4_2.x */
> +/* XDR specification modification time: Fri Jun 12 10:44:36 2026 */
> +
> +#ifndef _LINUX_XDRGEN_NFS4_2_DEF_H
> +#define _LINUX_XDRGEN_NFS4_2_DEF_H
> +
> +#include <linux/types.h>
> +#include <linux/sunrpc/xdrgen/_defs.h>
> +
> +typedef bool fattr4_uncacheable_file_data;
> +
> +enum { FATTR4_UNCACHEABLE_FILE_DATA = 87 };
> +
> +#define NFS4_fattr4_uncacheable_file_data_sz \
> +	(XDR_bool)
> +
> +#endif /* _LINUX_XDRGEN_NFS4_2_DEF_H */
> -- 
> 2.47.3

