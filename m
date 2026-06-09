Return-Path: <linux-nfs+bounces-22390-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F+yFAcVnJ2oywQIAu9opvQ
	(envelope-from <linux-nfs+bounces-22390-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 03:09:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A965B8B7
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 03:09:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=CmQpj3ow;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="U HzxCRi";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22390-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22390-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7917F3024950
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 01:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30752D7DC8;
	Tue,  9 Jun 2026 01:04:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE8EED8;
	Tue,  9 Jun 2026 01:04:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967042; cv=none; b=CKSE6Pr1B8yTY/0Urb5NdwRzdIm+m7NiCppicpzkWx3UYphDL9yvlr7UXpCq4ufPt/Pkx5w+E7g8mrmmebVz5OiDV70SfP97foct//5suseU9+LILhTPuLPdapIEHIMQLS2qyJq0AvvgGFp6MO52oSOEdC+e7WDfopb6FpkIaIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967042; c=relaxed/simple;
	bh=d1zNRbMYD93mzf+O5L+utrI/JLLz9sEalRwWCppvVO0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YyqoPbSasqIXps+V493Al/uE5PYe35T4JDRaKjEwhZfpIOvsJH5yDjzFwWWqf5LOHZPRuaZ/vZz9UYQy7W8yU35TFyAf/5nWJoJlqhyUBAKULmsTwX5FxJ5k8oDzX4q+iOwg/h9xVnTBGc7NMVGXdiuxiwAWScieMT9ldbWMlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=CmQpj3ow; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHzxCRis; arc=none smtp.client-ip=103.168.172.146
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DC3FEC00C0;
	Mon,  8 Jun 2026 21:04:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Jun 2026 21:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780967040; x=1781053440; bh=WYR9i7uezYmtcM0nrVMn9y93zwsTGGFlY0S
	qSGrrz6w=; b=CmQpj3ow07EZNTJimBXzAaZHyFgkuXc9Igjx6kk8nQLPdukn2zn
	MK3Gqh5LgY5Se1MlJEScopz5e80A8Xv0FzGbgiaX9DdKQG7peHRRetYfs0oQ3r+Z
	axDcl8ZIzyQd+JbSzVxOBoFTqSXex4PVTUUIkcEUdxPMWu79wYClUZyV+gZJ9TMU
	CPK8abGvLUZQHWK7zRuZAX/IFgRD4G+sM8zSSctJvD7F42c6DdFT2fOfpHZEPTz+
	Zp8YLF9fckWdWPr5CtuKV/ZrS0Dbv6n+LKQZr0v3JNpVlrJqYV7sTdfuBhJxE5eD
	+asL/5OTIRfvqC2Ag9F2oeOCA6tSb9czw0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780967040; x=
	1781053440; bh=WYR9i7uezYmtcM0nrVMn9y93zwsTGGFlY0SqSGrrz6w=; b=U
	HzxCRisC3gmmBiZZFCYHjwwQHZQ1u+ChT34fchX+ZEGVn1kt+/5SAo0+nUXKN1KZ
	2ZbVdcTTSDDeCXm8FWYoWbjXdLfyxUWqeEbHAwNhfm9kQlD4++WmBbpP9vgSIKG3
	7QcNsbavjNGzCKpVg+vb9WtWU1v/166p+11Ue61tm4Uj1UPHGsCYzjrBZ8k75z+n
	aqF6h3WpREOcnzeU7q9yKxJdYJXHPIlX179dIdHvJ67Qa522bQf5fuLjm4O1Oj97
	W81spN7bd7gkUF3q86Za97RoEdgD5/pt4pePgV2QtViEWdqhIvTkivx6dPHvJYwQ
	ZeIoUNF+57fGp4y1CfakA==
X-ME-Sender: <xms:f2YnamNaFPGePD7ojJdnUKYdALyMi4srNVTH-Hd2W2y57dwDIe-2xA>
    <xme:f2YnatJ-ld4P7yX94njPi-AinWW9bvMLzuAUhKRF3wv3r1mrf-HpmhPmyfAbOMxVK
    0HyEfap3wsxYNLAUm-INXeCYwXHPJI32Fjuy9gjhrlYM09t>
X-ME-Received: <xmr:f2Ynao1tqqRoYsFkIGj0PsWCZPSPNLJ_8UjripCHCXUxKBhRXeY1Ar7YYl516vLJ0XeWHuw2FfAwaRWLskxFxxltoyvqHP4>
X-ME-Proxy-Cause: dmFkZTGT1ujCFYkbQmlc8SzKxH8O/y8CLjjkqMH/Lp3tVdWKypf1GnVm57lyLt4q4Z0kkr
    TzCGdF1IvUt8/sKJIujww03ZtNMis/+f3QN2p0mxLeHiVqNYwcLmVEau0clcOJlO/IglfF
    K+STXSnhHP1YsCgkJLco1oRA5iKrBj6zzaJpw2PpUt/LuPk6VUUSyliTx+Di3PV1N2XGvW
    BOrKdwn9GVgGKXTLTAgl+A5D18dNjlxtjIiLNy0+MBpg52Q22ULt2ezcHMxZj218P1KheW
    1xdGm/U4rm8g0bewAAaZa3mCST2UFI/R5lCbAPTI8wBKg33rPhjMYHesFos+ZRkskURKkn
    pXcF77VqYfI2s9xB0pTt403KGcnbjK28zAmuFI2RLmDvw8bcodJvPtnum27uCz05zm61D1
    07BWyYsKn3YtyR9v2HhfLYRuY1Fl4tMD/FbUJb/7gjcY8ULLffPw+2KxinGW7OMfjb2CAl
    v+GwOAXVw0cfQk9DCnW2HR90vhpEugujNOs8j/x6SbP+/Dc4QxE3WwT67LoSBYU63c3v8O
    bhnMYz0RVB3cLy4yhjx+ACldjsiIFH5xTjk4jvfO/EXoFvrkt0BK/fOiTxMEy4EwIC6u9H
    NFkCofH8Pize+JEsnwDIu3ls5kWboQtFzbgQ/F7BozGeot6ii7sP89v8NJqA
X-ME-Proxy: <xmx:f2YnahXZceExONZpGrKAqa2aQ6cuCuqL85J6t_9HTN5xL7lUiTGIsg>
    <xmx:f2YnaqOPLJMRnIscXbw-B8zLRUTu1cTMjATIXlI6F3LdYKKSjqtHyQ>
    <xmx:f2Ynak1tLm66eBze79UKQMc0eQQ3-FApv3-qpBhSDWic7ZtcD5ctGA>
    <xmx:f2YnauTSvvhQsOg7d9cuE3NVwUqFfzdywBCrQM46eRYUjHUOIYIxGQ>
    <xmx:gGYnavwNWbHdfAQlsa_XMpB51yGkgV78iTmHuXcuK3r889KxlWPgZQjq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 21:03:56 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jeff Layton" <jlayton@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 "Jori Koolstra" <jkoolstra@xs4all.nl>,
 "Benjamin Coddington" <ben.coddington@hammerspace.com>,
 "Mateusz Guzik" <mjguzik@gmail.com>
Subject: Re: [PATCH 17/18] nfsd: use vfs_lookup_open() for non-creating open
 requests too.
In-reply-to: <2f5da5fd-442f-4889-af15-58f9b5d68d71@app.fastmail.com>
References: <20260601070042.249432-1-neilb@ownmail.net>
  <20260601070042.249432-18-neilb@ownmail.net>
  <2f5da5fd-442f-4889-af15-58f9b5d68d71@app.fastmail.com>
Date: Tue, 09 Jun 2026 11:03:54 +1000
Message-id: <178096703408.3392745.3772559791386922644@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22390-lists,linux-nfs=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,xs4all.nl,hammerspace.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jlayton@kernel.org,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jkoolstra@xs4all.nl,m:ben.coddington@hammerspace.com,m:mjguzik@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	HAS_REPLYTO(0.00)[neil@brown.name];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ownmail.net:dkim,ownmail.net:from_mime,messagingengine.com:dkim,brown.name:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 571A965B8B7

On Fri, 05 Jun 2026, Chuck Lever wrote:
> 
> On Sun, May 31, 2026, at 11:38 PM, NeilBrown wrote:
> 
> > @@ -429,45 +438,35 @@ do_open_lookup(struct svc_rqst *rqstp, struct 
> > nfsd4_compound_state *cstate, stru
> >  	fh_init(*resfh, NFS4_FHSIZE);
> >  	open->op_truncate = false;
> > 
> > -	status = fh_fill_pre_attrs(current_fh);
> > -	if (status)
> > -		goto out;
> > -	if (open->op_create) {
> > -		/* FIXME: check session persistence and pnfs flags.
> > -		 * The nfsv4.1 spec requires the following semantics:
> > -		 *
> > -		 * Persistent   | pNFS   | Server REQUIRED | Client Allowed
> > -		 * Reply Cache  | server |                 |
> > -		 * -------------+--------+-----------------+--------------------
> > -		 * no           | no     | EXCLUSIVE4_1    | EXCLUSIVE4_1
> > -		 *              |        |                 | (SHOULD)
> > -		 *              |        | and EXCLUSIVE4  | or EXCLUSIVE4
> > -		 *              |        |                 | (SHOULD NOT)
> > -		 * no           | yes    | EXCLUSIVE4_1    | EXCLUSIVE4_1
> > -		 * yes          | no     | GUARDED4        | GUARDED4
> > -		 * yes          | yes    | GUARDED4        | GUARDED4
> > -		 */
> > +	/* FIXME: check session persistence and pnfs flags.
> > +	 * The nfsv4.1 spec requires the following semantics:
> > +	 *
> > +	 * Persistent   | pNFS   | Server REQUIRED | Client Allowed
> > +	 * Reply Cache  | server |                 |
> > +	 * -------------+--------+-----------------+--------------------
> > +	 * no           | no     | EXCLUSIVE4_1    | EXCLUSIVE4_1
> > +	 *              |        |                 | (SHOULD)
> > +	 *              |        | and EXCLUSIVE4  | or EXCLUSIVE4
> > +	 *              |        |                 | (SHOULD NOT)
> > +	 * no           | yes    | EXCLUSIVE4_1    | EXCLUSIVE4_1
> > +	 * yes          | no     | GUARDED4        | GUARDED4
> > +	 * yes          | yes    | GUARDED4        | GUARDED4
> > +	 */
> > 
> > -		current->fs->umask = open->op_umask;
> > -		status = nfsd4_create_file(rqstp, current_fh, *resfh, open);
> > -		current->fs->umask = 0;
> > +	current->fs->umask = open->op_umask;
> > +	status = nfsd4_open_file(rqstp, current_fh, *resfh, open);
> > +	current->fs->umask = 0;
> > +
> > +	/*
> > +	 * Following rfc 3530 14.2.16, and rfc 5661 18.16.4
> > +	 * use the returned bitmask to indicate which attributes
> > +	 * we used to store the verifier:
> > +	 */
> > +	if (open->op_create && status == 0 &&
> > +	    nfsd4_create_is_exclusive(open->op_createmode))
> > +		open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
> > +				      FATTR4_WORD1_TIME_MODIFY);
> > 
> > -		/*
> > -		 * Following rfc 3530 14.2.16, and rfc 5661 18.16.4
> > -		 * use the returned bitmask to indicate which attributes
> > -		 * we used to store the verifier:
> > -		 */
> > -		if (nfsd4_create_is_exclusive(open->op_createmode) && status == 0)
> > -			open->op_bmval[1] |= (FATTR4_WORD1_TIME_ACCESS |
> > -						FATTR4_WORD1_TIME_MODIFY);
> > -	} else {
> > -		status = nfsd_lookup(rqstp, current_fh,
> > -				     open->op_fname, open->op_fnamelen, *resfh);
> > -		/* NFSv4 protocol requires change attributes even though
> > -		 * no change happened.
> > -		 */
> > -		fh_fill_post_noop(current_fh);
> > -	}
> >  	if (status)
> >  		goto out;
> >  	status = nfsd_check_obj_isreg(*resfh, cstate->minorversion);
> 
> Logic bug: Pre-series, the non-create case takes do_open_lookup()'s
> else branch and succeeds; post-series, do_open_lookup() calls
> nfsd4_open_file() unconditionally. Every CLAIM_NULL open of an
> existing file fails with NFS4ERR_EXIST.

yes - that is bad. I think

 	if (!open->op_created &&
-	    createmode == NFS4_CREATE_UNCHECKED) {
+	    (open->op_create == NFS4_OPEN_NOCREATE ||
+	     createmode == NFS4_CREATE_UNCHECKED)) {
 		/* NFSv4 protocol requires change attributes
 		 * even though no change happened.
 		 */

is what I wanted to do.  I've also move the clearing of ATTR_SIZE down
to where we know we did created the file, so no trunc is needed.

Thanks a lot for the review.

NeilBrown

