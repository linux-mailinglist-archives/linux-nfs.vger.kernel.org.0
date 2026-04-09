Return-Path: <linux-nfs+bounces-20792-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB0sLpC012lURwgAu9opvQ
	(envelope-from <linux-nfs+bounces-20792-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 16:15:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1413CBDC0
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Apr 2026 16:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C90483024A59
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Apr 2026 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361F31A045;
	Thu,  9 Apr 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="lfCZ/gsG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987D2EC0A1
	for <linux-nfs@vger.kernel.org>; Thu,  9 Apr 2026 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743961; cv=pass; b=FJt+J+r8rjDvz1buNt9tMjXCzPTJe7dewIJ/FSVFiPs5CNSFkF/wr7dQgOmokbbyLt37Ro5Ncl/6ihBUGtXcd2c5wZ5BszcokE3CTZexcYbfY/95V1GGamfBfdUjPcPrxmrspQqbjl9ueq/PnsxMMBzOZp7nomEgYNwtdbFwWtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743961; c=relaxed/simple;
	bh=Bh3QwITRJOyBDzDp2pvbxvsfC0BZG/KTDsk14sfOH/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U92/JFYr3PsQXhwOYCX1J14jWAwmG39k+IekgL3iagcUjA6rGLCMb8IS4fzEI74sOyJ74qKsHvzhMXfWOpI1zlnOCTVLjeD6mnyX1F+m4Px98OCvEf6ySX+T7rn7x+xvLMnYGJCpiWuUBKpozyrW3d+tqW87yTFCfg2MXE47E5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=lfCZ/gsG; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a3be187ffbso713842e87.0
        for <linux-nfs@vger.kernel.org>; Thu, 09 Apr 2026 07:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775743956; cv=none;
        d=google.com; s=arc-20240605;
        b=CromDDHtqYzV5gsqSvDk1U6zEwuBMP9VNQ0W0iODIDErm6W1GSntVJNtvrab5edl4X
         UiUGJwvxJeb8+XjwQy1K/oybnLNlPR/ALAWofqiy4jiOgpKam3e0n3LFSjjzH+dAQ+iZ
         Y71qEBYMv8ZF6rm0C8OR3Gnb7hfv6XBlXhhMCpPy58Z7vX/WmIoeVSCAM6iwytUzCEaE
         Xl95eRVDwC/3w33i65cn/0UJYCfw+779IHA9Dtgb7tMdBR3pIidpg/y4YmSzW68tPz9C
         BxCFiHPrXQWucITNDgA8Iex9gXLlgpVBg0isVx6rh5uJ2x1agWgC1ht2Hamh/T/zOiJs
         Unbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qt+aZxhquqsL+hKqp+cFFEJ0u+tkn/yJjkQsfS1ALY4=;
        fh=9s9cm6LDdo4vug/eXrC96B6eMcjvyCZQ7bAbMp5hN50=;
        b=k7Vrf2kGINhQFN8eTUpIXDzXuYrBTM6kSjCm73t2fIezttsK19maxrd6qHz31317B1
         0BhTKrXvNxD40j4WE/biBoxO9fCpZc/PcF9NnmE6s19OMRwPFDrpbb0XrjsdBSOSOEad
         ggxlVHPYhvqi0fbrOgFHocTIJXqaYrpN50NwiWmG18tCTo1DTCg2UfZaL8MGAYWGWxG+
         fcbsJafsSf/iH9ASs4MMxNpmYWapviWnpkS2BXSjHHKOU+2TLEP3kLqTj0kM90G4OWJh
         uu6gti1x4n9a/vMsmUEhOPQkR9TbvVu5pREa/PNjTK/zUbha8/w2RFA2ZoFoY8xUsa27
         VDiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775743956; x=1776348756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qt+aZxhquqsL+hKqp+cFFEJ0u+tkn/yJjkQsfS1ALY4=;
        b=lfCZ/gsGX678UF5KAzPZhBxOCw30Z5CXddGmrqfb/szmcrD6peebwj0HOLrHFj/UZj
         hBwD1VTnoKGrm/6GKV7H6bOHIn4WqA56qoRKf+UiV8FD8rmC92jWWRQ0EaJtD0P5QDoU
         Kh9aqXHLyKmyemgxLd8UCOjm/QhmAKQSXhL7PDGjYi6vo54e+tqzhd48UAvjqU+p1jvb
         UHVGo89I7admLxpjFR8vYtBLvjuNyU40BtORF11piQOliaRX7tFZWr2hU04N4pQYDFvl
         vfs2upnF4Gwg+qX0svn1mzsJr61Tk6MjGOwC3AgNcOBlpvX13uY19UFeudpkY5mlYP87
         RdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775743956; x=1776348756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qt+aZxhquqsL+hKqp+cFFEJ0u+tkn/yJjkQsfS1ALY4=;
        b=ZFBDMNOI2NuTNtTPT/2dJQvR+tBb4Bcs6JI2HvOXfyrpVHkSDUAUlT+qx8fPEDZkJ2
         B2LLRQ8/fPYqwrPT6rH/11rzHYCddi6w2nd77DSAlnSDTQnJGII7KY+j8dm+Vhi3SKuF
         tFfXt6aAmkFrnMRJwAgXQPihv1UXQpRiDd2JjmOXosi7LTyYSNN0wpcNOUjQfa9OYlvp
         2MPEZsRxl6N1D9oHrONABoqeWZz9IWIavzpNsguQZU3dHropiiImgsEXC8Fxf/ggUB2/
         LoQIbYIr8YGc+lXRkuG3TCffk8ARS6gcXxnXkNCBVJmjCxZDaAnxzFUVzNqsX4g2eKY/
         pKDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzSeQVNqV/uU/wu13eGxRi+k1imp5fB8svHDc4mPzDB/9VVBuVadtBVbNPYfPzuB81S2t45i3pG9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhB/vc8/1WbqbVviPi5M854lirFbHQdehtRyEJhr/6uJSXWB1b
	LQ9fQDMAKyvr3Pn+tbUosMWoHepce5zykPvpnxsodo0w6LhujvCtkg261vMALMDRygb8nan44iD
	Ddh2lATTR2dI8Vv9pIGldByM18uTCX+M=
X-Gm-Gg: AeBDietzIC3N6UZKI2SeMNIfsIXJ0EE3HNKw9TMIVcb14wyNLRY4DQ1MswpHeKJE8gg
	ff4Cp74AvpxL15hH+zuINGGFggY6ZvjK7d3Y6JK2gelQodBVHCfTsn+jC3xJDDBRZ2FT6fVfV6s
	ZVL++dwG59qq2XgKBkeYQJonq/CJFuzUaYYv86qkutT2qGpPPyqhNcdaC/gAWLZLXvY+UGTiePw
	+TGQ8phDQoum9Yu0Dk97lBn24Ic+ZLSXlVTb8awhW9IeFqJO+Aw+MZGWGTp89Fq+G4wTF4sLQvt
	mDfoZSmf92jscy/+Q2TBm3rqUBL6NEYbCmp9rP+ZcA==
X-Received: by 2002:a05:6512:ac7:b0:5a3:e5fc:7b11 with SMTP id
 2adb3069b0e04-5a3e7c72670mr1166988e87.0.1775743955334; Thu, 09 Apr 2026
 07:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408190008.85082-1-okorniev@redhat.com> <20260408190008.85082-2-okorniev@redhat.com>
 <a8ca4c64-af78-42c5-9a59-78dd27b8d022@app.fastmail.com>
In-Reply-To: <a8ca4c64-af78-42c5-9a59-78dd27b8d022@app.fastmail.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Thu, 9 Apr 2026 10:12:23 -0400
X-Gm-Features: AQROBzCEXHqUt5Kx35riNDoZGaXQBiinBzf2g4Pl8UAqM5jE5BDH4abSgt7dqxw
Message-ID: <CAN-5tyF-XjJ7n4rPDU_1ndR-_N9Say9QdeDty8JZ8ZDwPNng6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] nfsd: update mtime/ctime on CLONE in presense of
 delegated attributes
To: Chuck Lever <cel@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, neilb@brown.name, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20792-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[umich.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,umich.edu:dkim]
X-Rspamd-Queue-Id: 9F1413CBDC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:12=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
> On Wed, Apr 8, 2026, at 3:00 PM, Olga Kornievskaia wrote:
> > When delegated attributes are given on open, the file is opened with
> > NOCMTIME and modifying operations do not update mtime/ctime as to not g=
et
> > out-of-sync with the client's delegated view. However, for CLONE operat=
ion,
> > the server should update its view of mtime/ctime and reflect that in an=
y
> > GETATTR queries.
> >
> > Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding
> > WRITE_ATTRS delegation")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
>
>  b/fs/nfsd/nfs4proc.c
> > index 99b44b6ec056..1272f2eb5ff4 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1396,6 +1396,17 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct
> > nfsd4_compound_state *cstate,
> >       goto out;
> >  }
> >
> > +static void nfsd_update_cmtime_attr(struct dentry *dentry)
> > +{
> > +     struct iattr attr =3D {
> > +             .ia_valid =3D ATTR_CTIME | ATTR_MTIME | ATTR_DELEG,
> > +     };
> > +
> > +     inode_lock(d_inode(dentry));
> > +     notify_change(&nop_mnt_idmap, dentry, &attr, NULL);
> > +     inode_unlock(d_inode(dentry));
> > +}
>
> nfsd4_finalize_deleg_timestamps() invokes the same call and logs
> failures. notify_change() can fail through security_inode_setattr()
> or the filesystem's ->setattr method. Is it worth logging the
> failure (or adding a trace point)? (I don't really know, just
> asking here).

Well, I'm now thinking of stripping out that piece that calls
notify_change() in nfsd4_finalize_deleg_timestamps() into its own
function and call it from both places?

Now that I see that nfsd4_finalize_deleg_timestamps() gets a dentry
from file->fh_path.dentry, I'm thinking I don't need to save a dentry
in the copy case and get it from
copy->nf_dst->nf_file->fh_path.dentry? I'm assuming then I no longer
need to dget/dput then?

>

>
> --
> Chuck Lever
>

