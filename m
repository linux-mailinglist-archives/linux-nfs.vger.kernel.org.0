Return-Path: <linux-nfs+bounces-2023-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CBD8599BC
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 23:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6F33B20CF3
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C63974295;
	Sun, 18 Feb 2024 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="asDq1yQ4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2wxVesKX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BfheGFLK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+2Kjx3re"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED16F07C;
	Sun, 18 Feb 2024 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294651; cv=none; b=m3/NK8P6F+928KR81KII1DHUVVKwoK8sH7viSHcITRKdmdU9g5CTrJyZ2I/7IUDbjQ5UfG0KrXYDdD1Jw5BfnNzE5CiwScZgYB4Pn+vhLpRMtA3WO05Y8v6XDCmiub22f1zJY1TdXanUIE8qjaLOyi2C9yZbsFeMSVSjHB0EuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294651; c=relaxed/simple;
	bh=ChOSezAKDLZ/7An8MXAMha+Vzh5/qiW3BtupqQXeTO0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=tS1F+hKbNcYCKQ59nrYiSzh/bfgZz7HSbbN445uPdGXoZqJqCBcjdg2zU1+/+35vsbMoVIfpK/hRV+qqyTf7d5FcUm7xEfgFemO8BEWorSo4V22YjIX9hXM81M5PY+S6ssgZcm+pKcSaRml5yvs2Wc9NPU+Kx+MOniK0VH84qWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=asDq1yQ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2wxVesKX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BfheGFLK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+2Kjx3re; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A12421CFB;
	Sun, 18 Feb 2024 22:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708294647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mA7lxWiF+oraQAzGHICYfdobEjl/bRVoJRdYvmZznk=;
	b=asDq1yQ4L7FWy6q9LD2Vox8ecrqIRgidVV1K1QbPIDmlmjCWeO0PH9oyaEBmQx0j7Ru3/G
	ov2ncc0N1pJDZEl15tSHVu3a8eza3+avaVx3FqMJSXi4XZZ8JFiSDVYA9bLA3lrHh33Ktu
	60Bdy3PB80fG071T9kEfk/youbHAOQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708294647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mA7lxWiF+oraQAzGHICYfdobEjl/bRVoJRdYvmZznk=;
	b=2wxVesKXcZOdfdHXfgnGVBZWVemhzl+iVobcuOLYzGSPqm80rDaPywiDWBiExn7dS8pJog
	uP4+2AKJn7H7KcAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708294644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mA7lxWiF+oraQAzGHICYfdobEjl/bRVoJRdYvmZznk=;
	b=BfheGFLK5Rmp5ISvInUbqhbJRsJVlTJ0HaoCbb2gK0r6OMVs6O5yiV8SdkL0YMviSoZAsn
	Nz8JvaNstKKq47lfRfSxvguoHCUif0HasclGKjKOiri5zZC0IL+mLj/gEXf/RCNvUhrN7R
	GweeKfNigVuKCD3T+SCIK1QVu1erlXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708294644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4mA7lxWiF+oraQAzGHICYfdobEjl/bRVoJRdYvmZznk=;
	b=+2Kjx3reNhyXgwOBXpw+4lSOWNb3HDwsJIT1nSCJsoABcffyEKvkfaLeVUJTdmxeOQNCSP
	nO4/Vsoau7AorlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FD8C139D8;
	Sun, 18 Feb 2024 22:17:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gYqIAfGB0mVqBgAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 18 Feb 2024 22:17:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Fedor Pchelkin" <pchelkin@ispras.ru>
Cc: "Aleksandr Burakov" <a.burakov@rosalinux.ru>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 linux-nfs@vger.kernel.org, "Dai Ngo" <Dai.Ngo@oracle.com>,
 linux-kernel@vger.kernel.org, "Tom Talpey" <tom@talpey.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] nfsd: fix memory leak in
 __cld_pipe_inprogress_downcall()
In-reply-to: <d6ac2546-cf4e-43c3-bc41-b62a61141339-pchelkin@ispras.ru>
References: <20240216134541.31577-1-a.burakov@rosalinux.ru>,
 <d6ac2546-cf4e-43c3-bc41-b62a61141339-pchelkin@ispras.ru>
Date: Mon, 19 Feb 2024 09:17:18 +1100
Message-id: <170829463835.1530.4794427167476868043@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,princhash.data:url,rosalinux.ru:email,name.data:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.82%]
X-Spam-Flag: NO

On Mon, 19 Feb 2024, Fedor Pchelkin wrote:
> Hello Aleksandr,
>=20
> On 24/02/16 04:45PM, Aleksandr Burakov wrote:
> > Dynamic memory, referenced by 'princhash.data' and 'name.data',=20
> > is allocated by calling function 'memdup_user' and lost=20
> > at __cld_pipe_inprogress_downcall() function return
>=20
> It is not actually lost. If nfs4_client_to_reclaim() fails and thus
> returns NULL - this error case is already properly handled.
>=20
> If nfs4_client_to_reclaim() succeeds then reference to the memory in
> question is passed to crp->cr_name.data and crp->cr_princhash.data
> correspondingly, and crp->cr_strhash entry is added to the list associated
> with nfsd_net. In this case the memory is supposed to be freed by
> nfs4_remove_reclaim_record(). See comment for nfs4_client_to_reclaim().
>=20
> So I think the patch just introduces a double-free.

Agreed - this patch is incorrect.

Thanks,
NeilBrown


>=20
> >=20
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >=20
> > Fixes: 11a60d159259 ("nfsd: add a "GetVersion" upcall for nfsdcld")
> > Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
> > ---
> >  fs/nfsd/nfs4recover.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> > index 2c060e0b1604..02663484782d 100644
> > --- a/fs/nfsd/nfs4recover.c
> > +++ b/fs/nfsd/nfs4recover.c
> > @@ -850,6 +850,8 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v=
2 __user *cmsg,
> >  			kfree(princhash.data);
> >  			return -EFAULT;
> >  		}
> > +		kfree(name.data);
> > +		kfree(princhash.data);
> >  		return nn->client_tracking_ops->msglen;
> >  	}
> >  	return -EFAULT;
> > --=20
> > 2.25.1
>=20
> --
> Fedor
>=20
>=20


