Return-Path: <linux-nfs+bounces-22249-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1BtjBLV2IGo63wAAu9opvQ
	(envelope-from <linux-nfs+bounces-22249-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:47:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BCC63A9FF
	for <lists+linux-nfs@lfdr.de>; Wed, 03 Jun 2026 20:47:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JcfEjS7O;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22249-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22249-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 368DF30422F2
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jun 2026 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75CF477E31;
	Wed,  3 Jun 2026 18:46:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3615544DB62
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jun 2026 18:46:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512409; cv=pass; b=MUz4k24EvP1QKcETtOElwe0IGzfK+agZ3UoLcwKsioac1E0auIMoVNavfKA9SMsIf0dkRUenmcj/K8pxJVqrCg5Pqna0If5f4JzsM77CeD40o5KVQnN8fQKXX3gK+m54WlLqBMtEINm/d0U2dlkxFGhVkR7tjMKzporHa9xA5b8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512409; c=relaxed/simple;
	bh=T/ZPxZzlX3sZq/L9I8ve0ZkLUAVqVu/gDVfbfSQGf/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvMwVoNkcwNEmhrUI1VkIln0kpFivCiXwbfqHx2LdPZT2bjAzwPBymRV5lJP4InH7vGBLkndUSWLMh31n4IWECukMOJ5FJIuvIGgyrusM7v6Pyopw7/Z+WJiTBGC6d3ksXzrRLFuzODKNhhArhoZ4eTiHuTA/4zijqeRjYCL3ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcfEjS7O; arc=pass smtp.client-ip=209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso1880a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 03 Jun 2026 11:46:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780512407; cv=none;
        d=google.com; s=arc-20240605;
        b=VGG4SsBGN54gzWGUA492OYIfTjlzIZ1kfkzuN81fmVn/SJG4jls5XYZkc8c4BHkwn6
         LZDWjmhql1njlvJoK260U9MUKt03GNQwnf8jMVRXZl/tAjIduCn4/ykxzNUL1C4OKI3o
         1+02ZoGNxqIA8gTyl8Ut/VGrd75IqIYROgqFXWPrAaniJwA0DHQJWXBlxN3p5AVVpjKK
         Avw4L6NEyGjY456qSq7liQksOq/Dc7mvTPgF6KGQnKOB2AZxueWQZIR9Du1nVBYdWVbf
         7hcDsTAqse8cH0lrNbMh5fCUdhfZx4SzfmWkGdDMzIIu+gsOqpfrLdc+o8haT4lkDo6+
         YCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N0I/V/n5gAej83npBKjlcD3mf3nZ4PsFC7cqd9huV/c=;
        fh=Q3OXTy7HOcSQlmegpMcsXjzEBfzSRwP87hBCb2h8ILU=;
        b=TjW+MmCcu3gnNXEKlPwJX19fItDYdZjZ/Yvxs6sg1sH7Wt7dxiF3f7oBjR0svX/+Pc
         Py+K10FqT1PpXOeeSWfvKJ5eGWanK+ruWrA4Ws9LdswNAdeWa9LHWh2Hz3Rz3f4CH666
         Ksx4dOG5lKtopnctQiLzLXabyqUSbYzoQNfZxX0mmhzbSBFrYmVFY5moJErWm2cwkSD9
         t7BsundJioOqFagi7WdoZ+Foj6QcHh66W2Cyt0lXiS3Ay0onR62Oq9K9NICl8AfUSW52
         e2AHqntyc6vnwKUSew5WlKJJFtBB6doMt4Dr5SzCPEGtcwueAmHXe1lZgXCZM9aGRw3M
         9SEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780512407; x=1781117207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0I/V/n5gAej83npBKjlcD3mf3nZ4PsFC7cqd9huV/c=;
        b=JcfEjS7O54KIQ3teN1aMZHBbvg9v2fKTr6Qz7yY+k+MMty9uHyxDQryscfUpeH9rn/
         PedCCNceV9EnQATaqoro6eyfl1OFD5+P6WcV994XTBdZ+yN2BUPW8ttzM6LX8pkhbF8u
         7soJ/j1c/oBy6hJUI4SGXCIKOopBkEvUvwcvcvGfDbdx8+qGdjB76j3+WKywOUBJxx8g
         da0L9UaPVaf1Nrzw58d5fkmnSkMt9XDl7pLQkL6r1okcyRascWh2YcKYiSmFVo6doDkp
         kBWF2VzvOOLFeL7Xb2XFOm5vu2uiVeaGnhgojqXOlNEWE4c8xKvoqDcMs0Ly5sKrRgTD
         b0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512407; x=1781117207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0I/V/n5gAej83npBKjlcD3mf3nZ4PsFC7cqd9huV/c=;
        b=XUG72yUhOzTB900V1s+zhpaSeG/fQsVBR/x9jEI/Ty651pKZpCalP1WoVBe4+gVsLY
         +aT0Y15eOlrncffJ6S3UR/uUYyCkNgLIWBfwmh5HX/LjvWfS2EmPBNb30+rsPUbJkmL3
         nboGqZwm0iW2asUspwStBgJp9O03jSfUQfeNQDli5w5ZEjXI0FQ506GY/IM2blZt71x3
         1zjz5d5hv1O9PDxBWNFpMYLfPl1P9/oE1vVaYSHqRwKy/RhykvH3nlj3JReDe8bahMEC
         9DL2uEeU3jidkJOhLZMnU4bA+7GPwUod4rZnvsjV4tiHRXC6k83M9PkczrBNp3dVWpXx
         j5gw==
X-Forwarded-Encrypted: i=1; AFNElJ9V41BrMs7FTtc99DNZwp2KHhvYVnx+NlCukGST/Mh9pn+ZoIO9w34uWg9pORuyDEIeUuGaX+RUGEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAaQtHRQ73vnuBP9ONRYHMcR7jF4W60ELyFiTJ2dtkg3WWTu2K
	5O6L2cq2ZFtb0J7Cg1naFadr1atXNDmIRVUwwev4mmrX2wk3X21viXPUyNOu5suJ2C4i+y5Nn17
	2uaL3r9keZsrtdVDlJFTGMJlt59A3b0AElah7FtQ/
X-Gm-Gg: Acq92OECpmO8Ck78l0ze78JBQu0mpPDWO2S+s6mXfS4QvZfAkG4DbTCD2+sk+O1xO/o
	SzCYGDEXYjRt/HQ9aC+jofkXCjLg9O9R495CEpY1vS6s2HDPRqHhWbbEsjtWaKkh0ohUS1AuAQp
	yOPQIMgoaR0SCE3YK8q9Nb+zmnCvwp1+jEqAMiGbkPnIMD8mCRoXVxlss1XHV9X67dzP6WrohQ4
	CvuwiJtNaocUxKf0wdE+kKhCh11j0ZXpfGIqlVuYnQS/2sHCoa0RYxfZfEE9/e1XDVX8f3RMCM6
	5LSZ7npO9rp8Vi+fd3NNEK4Eu0/jeBGhQ3sOQe5X+Jb4rD8cajIXv404sJo=
X-Received: by 2002:a05:6402:10cd:b0:68a:7046:e64 with SMTP id
 4fb4d7f45d1cf-68f12aaf42cmr15325a12.3.1780512406065; Wed, 03 Jun 2026
 11:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV> <20260603182454.GX2636677@ZenIV>
In-Reply-To: <20260603182454.GX2636677@ZenIV>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 20:46:07 +0200
X-Gm-Features: AVHnY4IOIf990_8GL-GvEPTAuAhu-9aAisHbx6iJzPDbVrDL-pH0XXeLuXuhWf0
Message-ID: <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22249-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77BCC63A9FF

On Wed, Jun 3, 2026 at 8:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, Jun 03, 2026 at 07:15:23PM +0100, Al Viro wrote:
> > On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> >
> > > Fix it by taking rcu_read_lock() around the mount::mnt_ns access, lik=
e
> > > in __prepend_path().
> >
> > > +   /*
> > > +    * Containing namespace.
> > > +    * Normally protected by namespace_sem, but there are also lockle=
ss
> > > +    * readers (which must use RCU to guard against the namespace bei=
ng
> > > +    * freed).
> > > +    */
> > > +   struct mnt_namespace *mnt_ns;
> >
> > Umm...  It's somewhat subtle - at the very least you need to explain wh=
y
> > there will be an RCU delay between umount_tree() clearing that and
> > having the sucker freed.
>
> Something along the lines of "removals from namespace are serialized on
> namespace_sem and guaranteed to happen no later than the active
> refcount on namespace reaches zero; freeing of namespace happens only
> after the passive refcount hitting zero and there's an RCU delay between
> dropping the last active ref and dropping the passive one that had been
> implicitly held by the fact of having actives", perhaps?  Only in
> more readable form than that, please...

Hm, like this?

Containing namespace (active).
Normally protected by namespace_sem.
Can also be accessed locklessly under RCU. RCU readers can't rely on
the namespace still being active, but implicitly hold a passive
reference (because an RCU delay happens between a namespace no longer
being active and the corresponding passive refcount drop).

