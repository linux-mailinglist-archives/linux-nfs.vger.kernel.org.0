Return-Path: <linux-nfs+bounces-22389-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mGbYJuthJ2pWvgIAu9opvQ
	(envelope-from <linux-nfs+bounces-22389-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 02:44:27 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 412AA65B698
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 02:44:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=d+ci7v+z;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="M Oqro+v";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22389-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22389-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80DD6300C387
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 00:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A52233928;
	Tue,  9 Jun 2026 00:44:20 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD051EB5FD;
	Tue,  9 Jun 2026 00:44:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965860; cv=none; b=BEtzx36359UXfzazkFpmSydR1wCatelrgmdTPBUlXrgLFhWrUuaJcAqBcjWMMpCaeLoN0om4bJB8vPsPmvNVfvDRCYDiaLryX+anzx0RJGeAhX6Lekdl/8V0qHIdh83tC5mO43bZjszAyyAyZStSUEZZquPO5Xp8qPgrfVCpalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965860; c=relaxed/simple;
	bh=uFHRxAwqPNzeiyffA88wyGhZ3Q0f1iXtGICJjpXnQ1U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ORFxx24np+ijPHWNPP/aNO3CmTIeC2wYyNbJO8xQqWrHKmHsmhF+zLFdY69lYyBJyQVHsoWB+/5p0t9bAboEnKN1TU9vuRjVpZz19tH1qUybkd7zTtEqwNMHXHi1YjLFZXlMr340e02XwlFrRR+3Uw18TObLvYkv2y/KnL2NtdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=d+ci7v+z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MOqro+vt; arc=none smtp.client-ip=103.168.172.146
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F75FEC001E;
	Mon,  8 Jun 2026 20:44:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 08 Jun 2026 20:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780965858; x=1781052258; bh=5V/2rRots6QeczNcRTdPEmIepp++pUqmGvY
	B1fDr/Kw=; b=d+ci7v+zD51xpZFDq31C3vxtTjujVcQDZSITRt+7mPq9lc9NjWB
	U1TsMH/7zNlJgevxrGHge6Cc/U6riF75gQbnUvs9HI8f50Q4ARkuobZRy2W8dGXS
	Bnq8uG7aZR3jjT86jfgyvDd5fElYgCvJYCBiTzIUEyaBcYNhxJ8XR7DwkNYiikoL
	1faWNTfSbI1vGSQ8XOv0rHFOLXLRyd+dN48YXDXDqPwGUk+C2e29XPZ+YqCC/ekC
	NeduglKTV9rr/JH/hf7brj4xdpWuyvxEXdgUZWnahSeyKu7vk4P3QVu1MojzpD/a
	cH9PwgzYIGHo1+gGb59YRI5kAa6RB9HJWOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780965858; x=
	1781052258; bh=5V/2rRots6QeczNcRTdPEmIepp++pUqmGvYB1fDr/Kw=; b=M
	Oqro+vtkyG/ZT5Qv13pU58t0RGaTyICuw6m1YSTFUcnsIjfV0k5DQpHnJJ1ByA0q
	f7OK9HALivlDUVcm/tj5A3elTwa5WsMjNidramhaOBMwMPKIRh2dxJ7mhDLMsS1e
	7NahqEmU+VkSMaeVYDYId61L+pnjopo0ySlSgChAoqKFOkdqJ2dXAPtz1rGK9m0W
	Lb8/uSbLwBJZdBsNTBQfYrE6D9fh583ZHkdZbwFH0ZhZsq/9eZEDw9B5zyG6ooak
	vayO7iJ+X2vsTRa3R3KyvPHCAI64gsGIgFyxvkB2KByr5ISrOYBr52SYTl8Pk371
	gFcgvmCy2FwAvKCSONJ1Q==
X-ME-Sender: <xms:4WEnarIbG-iBvTgLGaqBek61IBZWGGX7aJOlxQos5QSHGk1BvZJ6CA>
    <xme:4WEnanXH9tS5W3NzeUePaPGTd8yD4pP1W65USOC7yEBii36v9iFKCpdxVy2u5JXMP
    o4rw7AhVxTgVVSJmBJwbY69GZ8O8KPgUMvrvdEhRJeCRvrrgw>
X-ME-Received: <xmr:4WEnavTMnENGTUG6zHPMbk5giMT9Aa4djXqT6oYrvZjFr7_MvlM2Frx4iLb8Py1MFU2XseAa9Jn1OEoSox8sx_TIUXVDLko>
X-ME-Proxy-Cause: dmFkZTFjHXDugryQZzSujC/ldj3GoMALI+8Ai5m4bJ3n9QAJBqQsFhzuS21dlRamr22RB1
    VbHKzwE9C+HGFtjmjYtFIvtg3sCp9EQnmElUDbcwb01G36d4hcayXyTpS5xUjt6sjCdrgp
    m9DVG79JVUOq/TO5Hl/DITe+gEvHCnzK8AXqh1Z+g0UJPRtkNQp0HOEJ+3zbKfb7K1L3GA
    IQp924DPz6GS4+V3V9mkpog3BAUUfvkERfCcTbkJ8rXT36ohx4dNkt16459rbki38L2t28
    d4BvavG1yLfDOWMspaKGx/wM3Ic3mt18AAKVFCS435JygnpF1VP7O5PCZQVeiC10tXccIH
    wXVR78KcJTOGixpX2i4yxiknnppD9FUWTS/6YZH1qMTiThXhcUsNhPxelI9liPXi1QQt9I
    yM5zIcm3ajPdXqgdatc9Krn4graeW+6JaBZlb97hG5hP83SxBZkQXhCqgzW2ipF9BGd0Wq
    5iktIzIp/mpC8saX5bvD46byi/3eC/SZLlymBu20JbYDLwR4upVClvQNwQi8IInWLwl8MH
    iNu0D4qfU8lG6OeY4yoAiCPI5B3QCAxn/tHevBqYZYvfTSBqGC5Li7r3vhxP5jrYdFP+ua
    E+T/yxmXWB3nEF+sPAOkPfq1yfbYoxaTU6f7bfTb4Mr2g5thGMRMDCfkqJkQ
X-ME-Proxy: <xmx:4WEnavABT5VzLHCN14herehh8Y__ZChUrX_ARmc0iWTl_3ibnar75Q>
    <xmx:4WEnauK2724reQ-MTbP8Qbyao71ttxJu8Db5zm6S4BnWGrW5OrAtXQ>
    <xmx:4WEnaiC9nCWbGzsC_XIJT7u5VOmSqTny8LPzSwX8zhbhP1Q8yJ3kmQ>
    <xmx:4WEnarth8r7iMP_lXkYUmUzwfaUBhaZeIdp1ShvkKfIgPy0WffasoA>
    <xmx:4mEnavPy_mQMVS3o2vOzzph4OwFJ01KcsvSEkKyVrtY04WfYDHyz8LO0>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 20:44:14 -0400 (EDT)
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
Subject:
 Re: [PATCH 16/18] nfsd: switch nfsd4_create_file() to use vfs_lookup_open()
In-reply-to: <b86f4070-c2b8-4989-b956-ad0f40f88acb@app.fastmail.com>
References: <20260601070042.249432-1-neilb@ownmail.net>
  <20260601070042.249432-17-neilb@ownmail.net>
  <b86f4070-c2b8-4989-b956-ad0f40f88acb@app.fastmail.com>
Date: Tue, 09 Jun 2026 10:44:11 +1000
Message-id: <178096585114.3392745.13448656265781184569@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22389-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,brown.name:replyto,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 412AA65B698

On Fri, 05 Jun 2026, Chuck Lever wrote:
> 
> On Sun, May 31, 2026, at 11:38 PM, NeilBrown wrote:
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 5bd19e5d9e34..61ecd4123817 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> 
> > @@ -302,33 +302,18 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct 
> > svc_fh *fhp,
> >  		oflags |= O_RDONLY;
> >  	}
> > 
> > -	host_err = fh_want_write(fhp);
> 
> This fh_want_write() is removed, but ...
> 
> 
> > -	if (host_err)
> > -		return nfserrno(host_err);
> > -
> > -	child = start_creating(&nop_mnt_idmap, parent,
> > -			       &QSTR_LEN(open->op_fname, open->op_fnamelen));
> > -	if (IS_ERR(child)) {
> > -		status = nfserrno(PTR_ERR(child));
> > -		goto out_write;
> > -	}
> > -	path.dentry = child;
> > -
> > -	if (d_really_is_negative(child)) {
> > -		open->op_filp = dentry_create(&path, oflags, open->op_iattr.ia_mode,
> > -					      current_cred());
> > -		child = path.dentry;
> > -
> > -		if (IS_ERR(open->op_filp)) {
> > -			end_creating(child);
> > -			status = nfserrno(PTR_ERR(open->op_filp));
> > -			open->op_filp = NULL;
> > -			goto out_write;
> > -		}
> > -
> > -		open->op_created = open->op_filp->f_mode & FMODE_CREATED;
> > +	open->op_filp = vfs_lookup_open(&parent,
> > +					&QSTR_LEN(open->op_fname,
> > +						  open->op_fnamelen),
> > +					oflags,
> > +					open->op_iattr.ia_mode);
> > +	if (IS_ERR(open->op_filp)) {
> > +		status = nfserrno(PTR_ERR(open->op_filp));
> > +		open->op_filp = NULL;
> > +		goto out;
> >  	}
> > -	end_creating(child);
> > +	child = open->op_filp->f_path.dentry;
> > +	open->op_created = open->op_filp->f_mode & FMODE_CREATED;
> >  	fh_drop_write(fhp);
> 
>  ... the "matching" fh_drop_write remains. Harmless since nothing
> has set fhp->fh_want_write, but should be cleaned up.

Thanks for catching that!

NeilBrown


> 
> 
> > 
> >  	status = fh_compose(resfhp, fhp->fh_export, child, fhp);
> 
> 
> -- 
> Chuck Lever
> 


