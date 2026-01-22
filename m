Return-Path: <linux-nfs+bounces-18329-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EElLOKGDcmkrlwAAu9opvQ
	(envelope-from <linux-nfs+bounces-18329-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 21:08:01 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE916D559
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 21:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B6863007A4D
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Jan 2026 20:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18A838E134;
	Thu, 22 Jan 2026 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/lWqrLz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AB3090E4
	for <linux-nfs@vger.kernel.org>; Thu, 22 Jan 2026 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112470; cv=pass; b=rafnDyoJMlPYaxVaC9vwxaVn4Keg5PRGML0TTMy8lBt6A96oxtFBmYXE76NRx/u7dzF4wvXH/uLGvm+NDEpHMSAAliZDjROrvPDTuj2jbMEdJD+854acM3BKd4TQxKVq0/ZQaz3Hxn1EOuQs+RPo/e0OkTymFp1+R1AYswB/mkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112470; c=relaxed/simple;
	bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EAPj6m7kuDi1CsmtDGyiTapPBp6Po/2IbZo42278bWCBbpF/dpi3At9PmcUcV39GYs/Y27gi9OqtWmwD8+f1PBVPTqVbBhyKps887vv08ISOBcFRxCRsGTz/T2vLR6Lik1fPf8VFeaQwNU+kCXKXLcLHPndVFLKM6hdR8ytZnE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/lWqrLz; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8837152db5so142270966b.0
        for <linux-nfs@vger.kernel.org>; Thu, 22 Jan 2026 12:07:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769112459; cv=none;
        d=google.com; s=arc-20240605;
        b=ACjvp/hBQU5qHBNWrvPvc/JmdUayGmsDYmte8fpLhqaTP73v2nzfEaCDGZm7a755Ly
         LbQRW+pGnzW2aiJVhfXT2mp1TMBefzSdBm5wBiPXfzDeQpUlTHksTbCkWlhsrTotaeow
         WlBGREUUVZ6wB5IRD2RzicsbRQtu3aB0moU7zA79XLWITy1Q4Uglfz6g5o29aDTEmigy
         6c5Wm4Za/H3sO/UzzU3chMte2otNyOCu62yWFuv4BE7bPMbMswmGnhAWU2E9SrzSI3EL
         EaFtzKNKFvb5GvBY0cL3SIpq4iz4X0YD76Te9SaJ7Fyl+XSsLPIolSGmb/zVyCfjBkeH
         2HzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
        fh=2Jxtsj0n4o+KW5aJD4x8YR6oslRjSvXWwQdKEbs3JmA=;
        b=W3fVE2M9/TSaKzp3boybLJ4KXoUaq1VWq4AaHdH74FGgAErO4JkVIhQRt/KZOwJp7U
         Xo+Ub47O9AtLy0UNF0Xt4c/6VOm78RBNjPNgHgfW5Q5/N5dqniXxSUwyI755HU/vk3Zl
         yFmejWwYFBX/En9U4xOJCDnzWunF+FcZO7yonoJ0cfccAGEFxD6oQX5IpGqVeKvy38jJ
         2nGEQarPymqwyn4nw83mxjvIlHHb8aF8QesK83ApyR8oNaL6e0Xhr+INBelbnrFLYZgK
         5vP55fYemnH8UewHF+GZAm90LyKi86wO0LC4fULBiRi9Gu9cvJ8WkRRCNrXsk+Hj6Fdp
         xw6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769112459; x=1769717259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
        b=X/lWqrLz2bQ6qvlxMp7/4e7A3KNMkcvHPGvJrXvIoIFpAaXIC/J52gb0mTswrvGFCP
         qSSVd1czapsgBn9o4IwsRwvrzkDyZFQx/Q7wv1QR4ekmsTMySm+kz1F5NgHYxohKdeQW
         9UBy+879Kpi1tgCxNhjuYt8DS45VfiBkOyHJO/2HCOK97WnN26k3ENKaWBrgHO+JG8UL
         BEq6qWIJt7oQcNqg684IBIHDoze+DmC0pRYl6PWRXWVulbGGtM+GXeZOX3icPwGLoZvy
         F8yBwJU6ABDv/T7C8paHIdvH8dD98D8xBTj2IE6kxogY0Puri6AgRf99EEFaozcudOgy
         Dzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112459; x=1769717259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UeToXNeIZz9y9OvrlDazfYnO7oODJgQv05/I8arOeUU=;
        b=HrwK1wdEhjFEI2nH+SfPPfiEM/hYqzO20/JqecNrQQWxSd5K8tr5ZD9uaN/sVZTQvr
         C3Q9sunBPiHOJJapZd9gUK+TrugVaCWMViUpQpKK0WUkBrxs/0j2UE9tbwmI9kMoxYgR
         B8B127a05YKj1LqWLjnc1byr+o26ggCr2C7Z4oFjXTbdqDlQ/3ZRbd2DE5bfYBa34Ua8
         mgmNjZv+Nuc4x1b2RKqIgxgDKNqcP1bkrSFu9NBY0ftbOvAb5Se/QHH/wrkHTTCSm9IO
         N/oSV9OBbCihkfWoP13viYRPAn8yxTKTvEKxJdiLYlRPxyjUoqiQ7i7K7YaS+TBFKXRM
         mV6w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ4KHE4jR7bLNuqoaVCKpynMUYishPJ8AbjUTG+XJ9gxwRqOjAqRCEgHIR0A6BCFM/gAQH44lG868=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9AJgfed3tyb2aH/IrhvTaPSkj/4NSIFda3jB3fvZYB+GRWvP1
	mcGeXI0ZB6MWGDnZCEusGpdh5M8Wraj6zSOLD6cjX1n55dBUT6GcE7B1dN3MjkUwB5j272M7d1S
	bhEslQ9S0i5dl2OH8j7WicMPsTw9eQJA=
X-Gm-Gg: AZuq6aIK4dHhlh3lb2ajsHHa8oBdnbSxk1q3sPf5cCr0TymULlctfXXW5D042BrvoEb
	Eu+xMan8UqdovkbJ/RPijDPG6lTYWoKf3CO+2s4nlINaCwd8dKBXQN+7AkC/aG4SsgJkUiyJ0gt
	Ihr3MHGEMMIvKXWTv0hfD1aqJWxcKHGsbkyLYLAYXQ+n5KhSGM+4q6fbE9SAUtxkNQW3ORM1iss
	kifhtYdAVwbDMWC0Qu7Y8HVPnOR6FEhWyLqqZCahnSkK9bgOcs1qOJn8hNntt6FWrefpP0/qKin
	ndrLM5pH1hhEB/2YpfRcdU8psovzzARGlwWCAjyG
X-Received: by 2002:a17:907:70a:b0:b84:42e5:2b7e with SMTP id
 a640c23a62f3a-b885ae682a6mr30056466b.51.1769112458391; Thu, 22 Jan 2026
 12:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <20260114-tonyk-get_disk_uuid-v1-3-e6a319e25d57@igalia.com>
 <20260114062608.GB10805@lst.de> <5334ebc6-ceee-4262-b477-6b161c5ca704@igalia.com>
 <20260115062944.GA9590@lst.de> <633bb5f3-4582-416c-b8b9-fd1f3b3452ab@suse.com>
 <20260115072311.GA10352@lst.de> <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com>
 <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com> <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com> <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
In-Reply-To: <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 Jan 2026 21:07:27 +0100
X-Gm-Features: AZwV_Qj-Pre4XZbhvcFXr13YDWLuhkhhzBZFRQumTLtcoMVU1rOesRZLphknff4
Message-ID: <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ovl: Use real disk UUID for origin file handles
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Christoph Hellwig <hch@lst.de>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Carlos Maiolino <cem@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kernel-dev@igalia.com, vivek@collabora.com, 
	Ludovico de Nittis <ludovico.denittis@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18329-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DEE916D559
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 4:12=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@i=
galia.com> wrote:
> >
...
> > Actually they are not in the same fs, upper and lower are coming from
> > different fs', so when trying to mount I get the fallback to
> > `uuid=3Dnull`. A quick hack circumventing this check makes the mount wo=
rk.
> >
> > If you think this is the best way to solve this issue (rather than
> > following the VFS helper path for instance),
>
> That's up to you if you want to solve the "all lower layers on same fs"
> or want to also allow lower layers on different fs.
> The former could be solved by relaxing the ovl rules.
>
> > please let me know how can
> > I safely lift this restriction, like maybe adding a new flag for this?
>
> I think the attached patch should work for you and should not
> break anything.
>
> It's only sanity tested and will need to write tests to verify it.
>

Andre,

I tested the patch and it looks good on my side.
If you want me to queue this patch for 7.0,
please let me know if it addresses your use case.

Thanks,
Amir.

