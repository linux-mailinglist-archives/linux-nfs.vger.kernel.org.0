Return-Path: <linux-nfs+bounces-22376-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0EX9GLj+Jmp7pQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22376-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 19:41:12 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A04659572
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Jun 2026 19:41:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QL8rj9k+;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22376-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22376-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4293155337
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2026 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833663B774F;
	Mon,  8 Jun 2026 16:29:45 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9D33F597;
	Mon,  8 Jun 2026 16:29:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780936185; cv=none; b=XFqtKeuulQsCB0kQtQV1rMqvRElYyGBNoMWStoP78672n9SvGyXRjJCqE95uqgw93n1SvW/Nm/pfdgdk8b0/ejq3ScSzBpEArOQcFyogjxeQdCbZajs6hLp4faVMGtOzIXBVzrYuBcLJG+FOZUnMdzY9auYobUp65VCaEEvSKss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780936185; c=relaxed/simple;
	bh=11z58iAyEcYy3Dth3xvikIZTFPKRl+eJTkUmquR/mV4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SVrDnK+qg/p7+Feuc2KM9HHOtzgQopZI/EFOk3PgCIYUd6msSqX2gkhoFOCS3s4YRQzTo/uD08QxO/eEgt071BP98zLugKAFHGgl+eb1uJHX9DwtvG5B9O+h/oexL/WmfehmN0by+EcntArubM5xXWqfTRFMEc732RMBqQ5BQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL8rj9k+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E061F00893;
	Mon,  8 Jun 2026 16:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780936184;
	bh=GRwBJZlA2idFs2u/aBjaurSGcINlR0luye9wgJgLajs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=QL8rj9k+yrvuTawiEKeps8gBJW0QV69dGkiQwCCfS36lp5/m+RPFqFdtoul3ZPUWr
	 1rQL7ivEJT+NprUnSmGY7JJ3WlMl9L0Y/sVoqXUFBz9oRHUkVZwjyGFtK65pR4INCW
	 wd7eOwL+m29nvBivtxLodwT1WNTsTcD3THryog0cgTuCVJq8qmsJFnhD3YBQfBxjJt
	 MjtlWXs36K4dgNu4A2stX0oujDp9WySOenYsy+rGmlR3hkJY6/nrt0b6p9B2h2G8tB
	 wD8+quuEWSEMnAyA+4XzJ1PDVFCwSi/JDmrEiX/oYZ5CsTBcKBM/dO7J2K6sxNiMJr
	 QWeO9Z3gfWC1w==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DA86BF40070;
	Mon,  8 Jun 2026 12:29:42 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Mon, 08 Jun 2026 12:29:42 -0400
X-ME-Sender: <xms:9u0mapuXqQB7erAGLGeLNIvC3e7qYd0AATeKeBCG5a4J-H_6y2GvDg>
    <xme:9u0matSi3a4Cp71icBBblGdc1zC5CMjENSiaTmvKrtbzn1wDbwRYAblA2KSPVM6zn
    ymf8qBSqnfzknDORlHlAsQoQga5gT-W9GFVyK660_QWL9edgnaz8s0>
X-ME-Proxy-Cause: dmFkZTFfEy47y8CplgjlS4QZQQEbu5Xw6BaEiI7gfpUj/PHeXzXuN5IYsX04jrvz7ErIA5
    CB04FuWXJC+mAKdcXrv2ZohVOndgmNOE6Osp5FRTrv2XPTYJjhp6tOukuhbATfMIixNaCb
    jVidfwuXz7PsHsIkiY4AUpX3LX7n1pNs3YQEaE0DoryFJPiw7jAtgzMNWZC3FQ2ow1raKa
    XWqUF/aKKQtleqStOZmMsuflFR1urvxHfvKNjHXQVVnoAk7Y471mqqWy2K9jTpC9iqfGwq
    l31GvkgPQ436qIFdOHvKsgaosa+LtvKxpGVYYcIN23NLaVsBumjaOx+QP0Mzg/gPUVbojf
    F1cdTwg0OTAihtc7nxfClwx/1+KTrdCVATrarx6IDOVqhCFjrWweOGwNo/eS/CzA+2/UHd
    D+0cHsr6GMs6iPSKUZ4LchAcLhSITruM9b9vhhPF6ML6Z1HIGOP96EIfwrpfRFEbFPFXlC
    HIkm9HCJBX54E+LgYUx5rJVSbd0mybYsS6ALGeP8hY8n2osGPxR2RTC85MswAljqVUlsQH
    abyMeKshB8ZdEpezo8iim2r64xWms79wrW5MaofxBob2APQca27rPl2+6LzaXI9hUCEZCy
    mZHQNIK713jwL3rNjCj81SEwO4QquN9NUF52w7baFJyoSedRuhHXkt4E+UGQ
X-ME-Proxy: <xmx:9u0marW8P80uKAO-ZcSVC7U-a5IdXAkH6yN52y0IZZX4Er7dEhNwMw>
    <xmx:9u0maqqN5VTtITKsx3BBkuPLQyJ8i78xgp1FODf2IAkOQnYjOZHHQA>
    <xmx:9u0mavEuhnFBIOs1OXjJXAzn-nW4qsNqqnHZb2FM1N2F141hu2lJXw>
    <xmx:9u0mass2ifJaNYX6ubLLJ3gr9TNFuztXFDBlNdbMEH1NRbn9OlfI_g>
    <xmx:9u0maiTEhJc2AcIVBh_u5O4Wvfj-v1ME8AFsMTzABrhnzEWqcTp06B7K>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B5A03780075; Mon,  8 Jun 2026 12:29:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AmGpORDpATm-
Date: Mon, 08 Jun 2026 12:29:22 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
 "Alexander Aring" <alex.aring@gmail.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>,
 "Calum Mackay" <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Message-Id: <f1c139cf-c95c-430a-8896-fc857f7b06c5@app.fastmail.com>
In-Reply-To: <20260522-dir-deleg-v5-4-542cddfad576@kernel.org>
References: <20260522-dir-deleg-v5-0-542cddfad576@kernel.org>
 <20260522-dir-deleg-v5-4-542cddfad576@kernel.org>
Subject: Re: [PATCH v5 04/21] nfsd: allow nfsd to get a dir lease with an ignore mask
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22376-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4A04659572


On Fri, May 22, 2026, at 3:42 PM, Jeff Layton wrote:
> When requesting a directory lease, enable the FL_IGN_DIR_* bits that
> correspond to the requested notification types.

> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 67e163ee13a2..2a34ba457b74 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c

> @@ -9642,12 +9657,11 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
>  		dp->dl_stid.sc_export =
>  			exp_get(cstate->current_fh.fh_export);
> 
> -	fl = nfs4_alloc_init_lease(dp);
> +	fl = nfs4_alloc_init_lease(dp, gdd->gddr_notification[0]);

Both Sashiko and my own gpt-5.5 review noted the use of a response field
here rather than a request field, but that is a false positive finding.
The commit message needs to explain why the use of gddr_notification[0]
is correct.


>  	if (!fl)
>  		goto out_put_stid;
> 
> -	status = kernel_setlease(nf->nf_file,
> -				 fl->c.flc_type, &fl, NULL);
> +	status = kernel_setlease(nf->nf_file, fl->c.flc_type, &fl, NULL);
>  	if (fl)
>  		locks_free_lease(fl);
>  	if (status)

This last edit appears to be a clean-up that is unrelated to the purpose
of the patch.


-- 
Chuck Lever

