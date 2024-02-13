Return-Path: <linux-nfs+bounces-1908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191298534B8
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 16:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7FA283081
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Feb 2024 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84A55EE7A;
	Tue, 13 Feb 2024 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FaJ+SJ2r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6E55EE6C
	for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838437; cv=none; b=qPhEN+KGczPXfWfzL85LbYqeh9lS8/rLxZo+eyaroG0B/bfFVjsLMp20A7eQBXT1e10iOYag3EG1yRTzHXiQoPcqU9gXSRkDmjqcri0O0mJE2kpJkdByhJx/asiMVtDXqkYHZjtdsnnZT0SMEWiGpqkEIm60eCbu4UPgFiv96Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838437; c=relaxed/simple;
	bh=1wgOC11E4WsIHJN8sQAbPNgNjm1Tj7LN4SZFvsn5QAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcHR0oFFFFtBWdZa9kpX2VQ7sdrV2c3UZbt369DMLYvN4WQbRj6Fpo0+CywuQ/sTjAgttwK56EeK7zIisUXCfV+ORCUYnp9sy6QSeniRaXiQJM6tG3ue2iJtN/4ivimSJCTSHiY7ceZSEqjlwe3kTcb7JavxqZZFLJDDCMsTqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FaJ+SJ2r; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc745927098so3747868276.3
        for <linux-nfs@vger.kernel.org>; Tue, 13 Feb 2024 07:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707838434; x=1708443234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqydKoyTOasPxiPJoWDY9vsZCIGGHm243lsYdLUdgFs=;
        b=FaJ+SJ2rWv9CKMitnT5LLuR41tbjkrm+BMWVk5oD+ec/erdSd9QVZ2je05QqdnMRWk
         Im9W0wj5gHWVvnF2/3Oma13A1S5T+br7kgBW/UFFPMaSUFiGbNlBIxfTdJlmxdh52UUf
         /hruPYfY4OxF4TPP7Huzhtzpuxl4e9co9fH1yQajmkbDGsktPzyqUXWSQG7yj+xzUOXR
         voiLBL6f/Vkb5iHgvEQ86RFnJNBzxZ6hNVQWFUZGuVN94AHcc/dueNO1wElhkCRbEHLA
         0GmF5ZbfUFqLBPr1WQ5pEI+kFOBsp/k3RBLKJjlSVHcE8WVQtkGPF+1j2LqDeLfvBj0q
         +DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838434; x=1708443234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WqydKoyTOasPxiPJoWDY9vsZCIGGHm243lsYdLUdgFs=;
        b=hMHwodlh0p+OUyBGrHcHzM/JCdD9todby8E85hQROlnyaQjomImQSNX72X9gPUfjff
         uIZSCrWbHCSOJsx3qjMR1W2I3LoaLKCOpOFY+vSdUgeOn9hG6w+ANqHC94rmM77eIx2I
         xlWNUOQw2pzvdrHViPRLboO7HUF5kpY7dl2QLpHTHHbxnyq94We6KmlR+oObieUfUL3o
         sR3JlGKyQblDGHV4Dh3s8L1CnGp8zf8JzQXvfiUfQt3S27xA/7Dc2Hp53GwJAIMctRxV
         PN+UDcBn/pSsFgMVdGSaugcOXlkwNrmJ0BKAdKfHiNErLoXLxb9djHxVS2o0TR3OKuRg
         NhmA==
X-Gm-Message-State: AOJu0YxtTD+R2LKvHRty1N60kEsJtHktQ9hd8RYCa9yOMmAoBXpC3QhR
	AfNJnwIrJohbwMkDu8ZFrfsKZmOKKuBMsMxyLz/hIhpo6eziro+R5rtxWslZ0wF0gYMSxX7OQFU
	i2iodOOxpZ9lAv3pfLvV87H3iE1qC63KBuW1Z
X-Google-Smtp-Source: AGHT+IHnyTIkOdFHIvfDQnb3DdpYo/kENKzsoxJTQjNhdWhD9FR1CMXLFwKe75ZdrflWgWwKWc2sbhF4w4SE8MNPLwk=
X-Received: by 2002:a05:6902:569:b0:dc6:bbeb:d889 with SMTP id
 a9-20020a056902056900b00dc6bbebd889mr7861710ybt.52.1707838433767; Tue, 13 Feb
 2024 07:33:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-13-roberto.sassu@huaweicloud.com> <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
 <CAHC9VhQ7DgPJtNTRCYneu_XnpRmuwfPCW+FqVuS=k6U5-F6pJw@mail.gmail.com> <05ad625b0f5a0e6c095abee5507801da255b36cd.camel@huaweicloud.com>
In-Reply-To: <05ad625b0f5a0e6c095abee5507801da255b36cd.camel@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 Feb 2024 10:33:42 -0500
Message-ID: <CAHC9VhR2M_MWHs34kn-WH3Wr0sgT09WKveecy7onkFhUb1-gEg@mail.gmail.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, 
	jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, 
	casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 7:59=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2024-02-12 at 16:16 -0500, Paul Moore wrote:
> > On Mon, Feb 12, 2024 at 4:06=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > >
> > > Hi Roberto,
> > >
> > >
> > > > diff --git a/security/security.c b/security/security.c
> > > > index d9d2636104db..f3d92bffd02f 100644
> > > > --- a/security/security.c
> > > > +++ b/security/security.c
> > > > @@ -2972,6 +2972,23 @@ int security_file_open(struct file *file)
> > > >       return fsnotify_perm(file, MAY_OPEN);  <=3D=3D=3D  Conflict
> > >
> > > Replace with "return fsnotify_open_perm(file);"
> > >
> > > >  }
> > > >
> > >
> > > The patch set doesn't apply cleaning to 6.8-rcX without this change. =
 Unless
> > > there are other issues, I can make the change.
> >
> > I take it this means you want to pull this via the IMA/EVM tree?
>
> Not sure about that, but I have enough changes to do to make a v10.

Sorry, I should have been more clear, the point I was trying to
resolve was who was going to take this patchset (eventually).  There
are other patches destined for the LSM tree that touch the LSM hooks
in a way which will cause conflicts with this patchset, and if
you/Mimi are going to take this via the IMA/EVM tree - which is fine
with me - I need to take that into account when merging things in the
LSM tree during this cycle.  It's not a big deal either way, it would
just be nice to get an answer on that within the next week.

--=20
paul-moore.com

