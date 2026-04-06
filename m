Return-Path: <linux-nfs+bounces-20670-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LupBkW802mslAcAu9opvQ
	(envelope-from <linux-nfs+bounces-20670-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 15:59:33 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EE53A3C07
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F5883006B52
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 13:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDB31A065;
	Mon,  6 Apr 2026 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="fVaRsH9Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175602DF701
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483969; cv=pass; b=LvEWLbpa1ULw0XrGLnCI7bCyCvvXgvqaf7lehzs91cqfhm8/LgzkAt0AZXBcJ3ssRaWXmziBRrQw/dePjB2A8A6Y8G9gHLhXWaZC58xYaMc+h6PhHRdiAS59rSvH4B5hXEAQVu8C9UvikV8fOCiTb7HQo+Mrx/a7DbGDtO/FsRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483969; c=relaxed/simple;
	bh=QKEY1RDtotqkOor42/zoEV1lS18KOeVdHdS9AynUrYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9aVpfm9dEmSkKGuWnFwRN5037ZVP1kPqtbmbx4IbNIaJDrLxr4SaQuiuOu/w2XULb7Wp2/roiG9fA9EYi8xtegm0NVdM8AyeXmW+068kMdgi6weIOuppO6NPKMQTItMcF2798GqjBGSpxt2BL6HE65m5z3IX0bCbQO2mONe1I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=fVaRsH9Q; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38deb82daa9so14408231fa.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Apr 2026 06:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775483965; cv=none;
        d=google.com; s=arc-20240605;
        b=ctLQRHVrsqf22LWjz60K64WF7oi0acG3WjyEQWFLEF6Jcl1sWC0hTqPyVdX9WiBbzd
         0JWPbL6yXkYF7FbR7JAGI0nHVEd/+I150/XgWgkCtq6+ppEvObPf85mVfYwTwpDyfFVm
         LxcpAE8eiWaZekUaE3ROEb5c1IKkV7vRruevOzCxKCOyEtvsb99ck6KZK18DrJal8JUK
         EHpuRV0zLVrPdmZCtaPPj+QEsBVZ8o3hRbqmFteguJsBpFTPC0qyLfxlo4zpXk6Yv9nw
         Uic6A1ndoK85b6hqkDP9Bcu1WMfG//ohnCaOJ3SMGdfmNJOpU+et/pGGBHhf/URQliXf
         AzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ucIKpZSaFQIFLXgv8VhP0yNvzTDhl+y3ytAFPozx90=;
        fh=Ttq0Egb3GYidGFv0vZS784fTvOafRIF4DXcQ1Vu1OnU=;
        b=fEA8as5nLvUpX3A1e83PpB+yUCHXQfbKD49fIw2tRS4BkOzQREcfjAl3THq0TSaqXC
         6LpBsARW23KygICuc6ZzRE2BK+2buRfKwZkflqTCEBbVRshYQ5HPWmX56HHMtXo3m9oM
         9lRgsbsg81mFf5yTlUojWkZrl0eVACRhuhlI4nsWSwHJ4uEomTy21DnFqG0ymxuUBAxp
         FkJAOrBP9L4JGpXKguGwMCNFkBNWtfGsgxMXoMlFqbLGJbDJC6ViA/LfDJ6EKpGaPf92
         461gXGEK32JIzvbThA8nP6o/zsacMQv85FYzVir4QvYWw5d8v1nU5mLQrWQf+izUIC9j
         Fmsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1775483965; x=1776088765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ucIKpZSaFQIFLXgv8VhP0yNvzTDhl+y3ytAFPozx90=;
        b=fVaRsH9QP5hq4Gv21bbxzZOiyDApgTG6iuLdPTm7TU2IPHcAAo/aGXZMbGFr0jS+JE
         K0SMr8yZy81rnQkD24ns2LBgX7Z0jSvtyMer3h9ewgoKY4+ck+gODVRhLuWHygSgFUPG
         8PTe+hsz4BfIaa0uu2vqFmStv9JevdjCWLcGeH/ZfTN65bTpv3DuNipZ51rP3pP7lTtJ
         K2zuLcb3L0YAlOy+9MTAXXLsVZytxFtUXRfYmDqdOsqnwMdMjuu5qTg3mTam4g0HFtJS
         fY+FuG2FJPW+zmcE2SGAS6BiiXoLFa2u6o6XYNw7XQo34EgNtFh9EJp9EPaqecOhvhyr
         K9vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775483965; x=1776088765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ucIKpZSaFQIFLXgv8VhP0yNvzTDhl+y3ytAFPozx90=;
        b=VIExF5hiw85Qp2fiM6crBRWNyGdNMa1JJ0ejIKYR5QlMTro8FFSw745a3xWbtjDSkm
         1fqesF/SrFVLusnD684XZhKd3iv65ltE3mYf4yjJMHkfJyWAMbdc4KBz8ooXExtTCazY
         CFWF6PitkzbMMZ34/ry3wExgEZ9tQinGfNuL3qhaaxl3vggMp9aNk2n2qld1Y4oylbys
         6Bh/jcS2ONgf0lvlP5xu2ZlhfA/G/SEj43w08/cnvOeUCC1SwrZ0WAKzp87ekda7hKlt
         kESLYcwK1pm5LoxAXxKb5Pt3mQg79ZlOGiqWzHs7tNPz43m1y+wCpmZxwDqUhiTgYTpX
         jBcA==
X-Forwarded-Encrypted: i=1; AJvYcCVF3JELRMZj8yRncTtmyNLy5G2nHdE129ZiCxnP2/lXA7gGnwL8s57/2bm30lKRRkNCQdT3oWYA114=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4pmgosl+lx9Afrrvup83lle6ICdjQ9raEVN3eUmR0z+Z9DEP
	k++uad0ZWSZYZxLG5maWQ2ZWsoNE/aAFsbQx276mJaq2+iI5OBhCzqAhE+bXANqprBELh2urqOd
	7ITLZL6zdNaK58ZBg8j6kjGgT+d9pr2c=
X-Gm-Gg: AeBDietFv4+U6xfbMdbB8irJ7z3YzZ+CDdI1XH0FA76W5nJEUhS1GqgSV1c+/IYikkY
	torwnzrvpmWYYszpKU6V+KDFO8BD17jamr4cKMtxqIM+KUqZPaEas3vnAyKH+xgdLsgtOAo86Kz
	gjVTDA7c4+Mls4I9nq8PGS5zbFDRNEVK4Qg1dSyggtUwgamtuL1iJptVjgmOr4QnHbAufY0tVbp
	9QDyXx4qu+1fY/mE8bi/2so3oGl/Zt5KfR3iGXpt16eXKct1lqYWZGshtrA48cbCZhxcV5bsJKf
	72SUFH4a0FZPqWGPHYRygHM2MsgfyvAaDfFh4xRxJA==
X-Received: by 2002:a05:651c:e1b:b0:38b:2907:dc4 with SMTP id
 38308e7fff4ca-38d8d386e96mr27529001fa.12.1775483964941; Mon, 06 Apr 2026
 06:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403165335.73070-1-okorniev@redhat.com> <63fbd05720af891a2f7339be78fea2460beda7a8.camel@kernel.org>
In-Reply-To: <63fbd05720af891a2f7339be78fea2460beda7a8.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Mon, 6 Apr 2026 09:59:12 -0400
X-Gm-Features: AQROBzCU8M0HQ8MpGex9kxlp_B4cnJR4fKzU-UuA6QvZcM8AzGmIyPTobf07pAI
Message-ID: <CAN-5tyE7yW=27HObj+cfHW-6HJsiGx=m6JbAcfEw+fTA2HXgsA@mail.gmail.com>
Subject: Re: [PATCH 1/1] nfsd: update mtime/ctime on CLONE and COPY in
 presence of delegated attributes
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[umich.edu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[umich.edu:s=google-2016-06-03];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20670-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[umich.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aglo@umich.edu,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 34EE53A3C07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 1:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Fri, 2026-04-03 at 12:53 -0400, Olga Kornievskaia wrote:
> > When delegated attributes are given on open the file is opened with NOC=
MTIME
> > and modifying operations do not update mtime/ctime as to not get out-of=
-sync
> > with the client's delegated view. However, for operations CLONE/COPY se=
rver
> > should update its view of mtime/ctime and reflect that in any GETATTR q=
ueries.
> >
> > Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding WRI=
TE_ATTRS delegation")
> > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 99b44b6ec056..66bde3732b03 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1396,6 +1396,24 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
> >       goto out;
> >  }
> >
> > +static bool nfsd4_clear_nocmtime(struct file *f)
> > +{
> > +     if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) !=3D 0) {
> > +             spin_lock(&f->f_lock);
> > +             f->f_mode &=3D ~FMODE_NOCMTIME;
> > +             spin_unlock(&f->f_lock);
> > +             return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +static void nfsd4_restore_nocmtime(struct file *f)
> > +{
> > +     spin_lock(&f->f_lock);
> > +     f->f_mode |=3D FMODE_NOCMTIME;
> > +     spin_unlock(&f->f_lock);
> > +}
> > +
> >  static __be32
> >  nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstat=
e,
> >               union nfsd4_op_u *u)
> > @@ -1403,16 +1421,19 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
> >       struct nfsd4_clone *clone =3D &u->clone;
> >       struct nfsd_file *src, *dst;
> >       __be32 status;
> > +     bool restore_nocmtime =3D false;
> >
> >       status =3D nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_statei=
d, &src,
> >                                  &clone->cl_dst_stateid, &dst);
> >       if (status)
> >               goto out;
> >
> > +     restore_nocmtime =3D nfsd4_clear_nocmtime(dst->nf_file);
> >       status =3D nfsd4_clone_file_range(rqstp, src, clone->cl_src_pos,
> >                       dst, clone->cl_dst_pos, clone->cl_count,
> >                       EX_ISSYNC(cstate->current_fh.fh_export));
> > -
> > +     if (restore_nocmtime)
> > +             nfsd4_restore_nocmtime(dst->nf_file);
> >       nfsd_file_put(dst);
> >       nfsd_file_put(src);
> >  out:
> > @@ -2132,6 +2153,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >       struct nfsd4_copy *copy =3D &u->copy;
> >       struct nfsd42_write_res *result;
> >       __be32 status;
> > +     bool restore_nocmtime =3D false;
> >
> >       result =3D &copy->cp_res;
> >       nfsd_copy_write_verifier((__be32 *)&result->wr_verifier.data, nn)=
;
> > @@ -2157,6 +2179,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >               }
> >       }
> >
> > +     restore_nocmtime =3D nfsd4_clear_nocmtime(copy->nf_dst->nf_file);
> >       memcpy(&copy->fh, &cstate->current_fh.fh_handle,
> >               sizeof(struct knfsd_fh));
> >       if (nfsd4_copy_is_async(copy)) {
> > @@ -2199,6 +2222,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> >                                      copy->nf_dst->nf_file, true);
> >       }
> >  out:
> > +     if (restore_nocmtime)
> > +             nfsd4_restore_nocmtime(copy->nf_dst->nf_file);
> >       trace_nfsd_copy_done(copy, status);
> >       release_copy_files(copy);
> >       return status;
>
> This seems simple enough, but there is some raciness involved if other
> calls are running concurrently with the COPY/CLONE. You might end up
> reenabling FMODE_NOCMTIME before a second COPY/CLONE finishes.
>
> A simpler idea might be to just do a notify_change() for ATTR_MTIME
> after each COPY or CLONE operation done on a file with FMODE_NOCMTIME
> set.
>
> That should set the timestamp to something pretty close to whatever the
> last write() would have set it to, but without having to monkey with
> the fmode.

Thanks Jeff and Chuck. I've changed the code to use the
notify_change() but before I send out I have a question regarding
where you think this notify_change () should take place in case of a
copy (specifically thinking about async copy vs sync copy). The
easiest option is to do it (regardless of sync or async) upon
completion of the COPY compound (ie not at the end of when async copy
completes). Or for the async copy should it happen upon (successful)
copy completion?

> --
> Jeff Layton <jlayton@kernel.org>
>

