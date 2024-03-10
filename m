Return-Path: <linux-nfs+bounces-2249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D38778B3
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Mar 2024 23:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686E11F213B3
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Mar 2024 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB4E3B2A4;
	Sun, 10 Mar 2024 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d62J3aqR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AcK8Jnmo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nXqZbI09";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="F/O0lkd3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248DE3B2A1
	for <linux-nfs@vger.kernel.org>; Sun, 10 Mar 2024 22:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710108688; cv=none; b=HX15MbFyNfgU34LAwprKDWy3jHw229twucW1gYo2hUyiccdKEP7e2+JifMnJifPlvB0MPuUoNGpKIIEiHZmwJGk165o2OFoQp8KuBRzRyZQw32KLci4gTLXtjUELR5C9YkIoEsWS12V7ps0G9OSsNaZhLkRLLlNskUOqdiA2Xoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710108688; c=relaxed/simple;
	bh=iZLKb55YSpLqaPdlnvwGhxdcLOeDWMeNgj1hYUw0fAg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=nfYu/QyTcPMm011XjRTP56BF5y4XQ+Bnrr6SPEa20FzmRKz/yqd2rEmGSBvRUIY2zjgX78mx6xLH8jpiTUVAS06/p2NRu+beiGqJjLwB/sccAN4z9sHTjZSJfHLsiVoYHwlko7bJFFmwOJ2zlx0Co7hY3Rz0bqZbed1fla0bmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d62J3aqR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AcK8Jnmo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nXqZbI09; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=F/O0lkd3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7D2521BFF;
	Sun, 10 Mar 2024 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710108678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbrrPwZVTdcGBQs9SGvX5MWYu5rH0BNkomnFpZD5AOI=;
	b=d62J3aqRnLJepCWkLUu3r8SiQUW6ouwNXVAZZYvAAyF6wtgt4Px4dmdzj5c8P6aUhTrtaW
	DU8X8jSHJcFiIvzu2q225ot/jPSd961pUmWS2W1/W1Svc5PvVC40bzq4pLFnjeqEE//hz/
	5NtNYaVFdwPDl6oXT3d1B8pC7VzMYKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710108678;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbrrPwZVTdcGBQs9SGvX5MWYu5rH0BNkomnFpZD5AOI=;
	b=AcK8Jnmo7Pmo/U+EI2twillVDm3r9LLXLGCPnShGRjuCDWETSce/dqpwH2J4EWTYHiWyTb
	WEMPVdpb7RBW45CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710108677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbrrPwZVTdcGBQs9SGvX5MWYu5rH0BNkomnFpZD5AOI=;
	b=nXqZbI09Hysc5SKg/B2V+x1uxmaN5fIORkDYuhi1V1mwsunAx4PYR8/oufTD0Rwlp7ZAlj
	hx+7gvfrl4iM0DDGJX1wJ/qlSbBfPZMGPY9fC2IUZ6KPQD3jFRu2rvkBm3p4cDBVJ8Z5RR
	o3b8R2piwkS0Y70cBu0gct+UhumOa30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710108677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbrrPwZVTdcGBQs9SGvX5MWYu5rH0BNkomnFpZD5AOI=;
	b=F/O0lkd3beLysw4IW/Sd1zc5muk2HLgCCaYz4vNFkhMnnZhSrwxul+ld+jBzW+CE9SDJUy
	sH7/jdWbN6jlaYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8495134AB;
	Sun, 10 Mar 2024 22:11:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ck35FgQw7mUYSQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 10 Mar 2024 22:11:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: linux-nfs@vger.kernel.org
Subject: Re: [bug report] nfsd: perform all find_openstateowner_str calls in
 the one place.
In-reply-to: <44e5a5f5-f8df-45bd-be1f-7d67cfb011de@moroto.mountain>
References: <44e5a5f5-f8df-45bd-be1f-7d67cfb011de@moroto.mountain>
Date: Mon, 11 Mar 2024 09:11:13 +1100
Message-id: <171010867304.13576.11261693671416322907@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nXqZbI09;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="F/O0lkd3"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.97%]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: D7D2521BFF
X-Spam-Flag: NO

On Fri, 08 Mar 2024, Dan Carpenter wrote:
> Hello NeilBrown,
>=20
> Commit 11c3d0a15bbc ("nfsd: perform all find_openstateowner_str calls
> in the one place.") from Mar 5, 2024 (linux-next), leads to the
> following Smatch static checker warning:
>=20
> 	fs/nfsd/nfs4state.c:1674 release_openowner()
> 	warn: sleeping in atomic context
>=20
> fs/nfsd/nfs4state.c
>     1657 static void release_openowner(struct nfs4_openowner *oo)
>     1658 {
>     1659         struct nfs4_ol_stateid *stp;
>     1660         struct nfs4_client *clp =3D oo->oo_owner.so_client;
>     1661         struct list_head reaplist;
>     1662=20
>     1663         INIT_LIST_HEAD(&reaplist);
>     1664=20
>     1665         spin_lock(&clp->cl_lock);
>     1666         unhash_openowner_locked(oo);
>     1667         while (!list_empty(&oo->oo_owner.so_stateids)) {
>     1668                 stp =3D list_first_entry(&oo->oo_owner.so_stateids,
>     1669                                 struct nfs4_ol_stateid, st_perstat=
eowner);
>     1670                 if (unhash_open_stateid(stp, &reaplist))
>     1671                         put_ol_stateid_locked(stp, &reaplist);
>     1672         }
>     1673         spin_unlock(&clp->cl_lock);
> --> 1674         free_ol_stateid_reaplist(&reaplist);
>                  ^^^^^^^^^^^^^^^^^^^^^^^^
> This is a might sleep function.

Thanks Dan - very helpful as always!


>=20
>     1675         release_last_closed_stateid(oo);
>     1676         nfs4_put_stateowner(&oo->oo_owner);
>     1677 }
>=20
> The caller is find_or_alloc_open_stateowner()
>=20
> fs/nfsd/nfs4state.c
>   4863  find_or_alloc_open_stateowner(unsigned int strhashval, struct nfsd4=
_open *open,
>   4864                                struct nfsd4_compound_state *cstate)
>   4865  {
>   4866          struct nfs4_client *clp =3D cstate->clp;
>   4867          struct nfs4_openowner *oo, *new =3D NULL;
>   4868 =20
>   4869          while (1) {
>   4870                  spin_lock(&clp->cl_lock);
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^
> Huh...  This looks like the same lock that we take in
> release_openowner().  Why do I not see a static checker warning for
> double lock?

Good question.  Maybe the relationship between oo and clp is too subtle
for the checker to follow?
It would certainly have deadlocked if ever NFS4_OO_CONFIRMED was not
set.

Fortunately this is easily fixed.

Thanks again,
NeilBrown


>=20
>=20
>   4871                  oo =3D find_openstateowner_str(strhashval, open, cl=
p);
>   4872                  if (oo && !(oo->oo_flags & NFS4_OO_CONFIRMED)) {
>   4873                          /* Replace unconfirmed owners without check=
ing for replay. */
>   4874                          release_openowner(oo);
>                                 ^^^^^^^^^^^^^^^^^^^^^^
> Here
>=20
>   4875                          oo =3D NULL;
>   4876                  }
>   4877                  if (oo) {
>   4878                          spin_unlock(&clp->cl_lock);
>   4879                          if (new)
>   4880                                  nfs4_free_stateowner(&new->oo_owner=
);
>   4881                          return oo;
>   4882                  }
>   4883                  if (new) {
>   4884                          hash_openowner(new, clp, strhashval);
>   4885                          spin_unlock(&clp->cl_lock);
>   4886                          return new;
>   4887                  }
>   4888                  spin_unlock(&clp->cl_lock);
>=20
>=20
>=20
> regards,
> dan carpenter
>=20
>=20


