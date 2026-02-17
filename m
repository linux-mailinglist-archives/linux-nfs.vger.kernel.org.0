Return-Path: <linux-nfs+bounces-18957-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCCgAMJslGkEDwIAu9opvQ
	(envelope-from <linux-nfs+bounces-18957-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 14:27:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004214C8FA
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 893BB3032F79
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE28D36AB75;
	Tue, 17 Feb 2026 13:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NESqdyBD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5E36AB5B
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771334834; cv=pass; b=A/1nLDiHiODZNur8q5qd43lc5sftZioUgS1zCWeLE83Q/H3vJfqTTsk700VJ8OrAus8iyUCmM++Iloied7tuGUUI728yYnqeIHCwMQMV6ZhEcTutd84niFAUnMKkwFl9kb/S3N5hb5CMYJA7zGElCIsNT47xQysAfL5JukTXcHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771334834; c=relaxed/simple;
	bh=q5oVq95jqQQoO+Nm/H6qoKVVfjO/F3iq8iJp7dxOY7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkmojxwH8pWPY042ulab9I2oWAc1VsiS41uTRsGhDCCH5o4W8ARltyBF8Ha+HOoiQ3VRCWnb/ZZpQifKmHVOL7dU95VhF5vhunVuKzvhvzqQTfOgOA6jMU7lVoD/l3MQKagxDCiMn8lYCgSmeSLyTs2bSBAlYRW4EDz3b8tku/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NESqdyBD; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-436356740e6so5014985f8f.2
        for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 05:27:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771334832; cv=none;
        d=google.com; s=arc-20240605;
        b=FlQja/qJjCf0kPVeSgZbUh7xkah6xAAQNaKDd9r+v/JH2+TXA/DIXsFWy1DU+xlaL1
         t8N5jFq2qrPQ3bvzf0ZP+NznQPGQFpDBd894tXqBPMpduQmB+xRLjioFxy9qJwassicl
         UDpXeopFQx5YYnoLtTgyUg7NNWi1cNBflyNHMemWVkBiJhi5E6QXJTJFaWgqC/DFAZkC
         ZQ/PdshV7mzXmo5+yzr4fvpPZmxwYZI3/7tGfn/LBIq5y5k9inv0Tb9hkZ63/yg1ALlr
         nJkeZk8VQaUtDqXBGoLgLG+9cFFlwMCngmdQrBQ+CiC1KVLhyhlTd4hoLMwRqfQcy4fe
         /KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q5oVq95jqQQoO+Nm/H6qoKVVfjO/F3iq8iJp7dxOY7w=;
        fh=OcynZHdYloChcMz/Ic3X4nlgw+42fg1Bu/F6sXxhIlQ=;
        b=RdXZa50M9FzEZZKLxOOVrJLc5AjiWmLGNVitWKaihLxEoscAmVdd4PdvDA62Y8npJI
         f61w6LcPeYJ1vjfZh0lWhXtXZ0DVfR587GkUvCNgyiL9QgJV4K3seJyFMENXq/ZT4iLS
         /uMmamK5kDRruC2kmpXlN8sXjSHmBVmWSRx0bJ80x4xWFKjanjARa9KSBLOMwGBZhD69
         ayPLv+4V/FVsW1hFTbN5YHpvtLl85yJmycEKpviCz0kNIIq1nL+RGgrhWmWNXvB7sZvQ
         NvTf7wjAh6ispj/DyS7o02SFBj2PuoliNpMU7UP/JZxHRA4INHw+Y3P7txc/mox8we20
         YjKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771334832; x=1771939632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5oVq95jqQQoO+Nm/H6qoKVVfjO/F3iq8iJp7dxOY7w=;
        b=NESqdyBDUBdPzO/qTCuoUo6jqKEfI7dWKzhf7admbKHUKEfVT7l3Y/+4l75auvfuSn
         Po9rOlOXCrb6ujJO2eQLx7mFUdB8V1ZLgFtUhgrpr0o1H8K2uog8fRkRRpt5owyAo7Ct
         NhdF4lVBH2KDsPHy6plc2KC6aSjjeT7ozckKC/obumO5z9/d2eFMy0dECxfQjJPvIR+i
         Cz8VJ+Z9462OqiO+yhhiuO5rLthG7GHKlxe1ZFWM6zVWGVcKI0E42ZLSSdoWj1SnVdtC
         A535K9oHwDb6IGhOFzICsIE32/Gv5USdcYDp9DpoMpCa4InLCRiWN64HChvK6OM9+Anv
         bmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771334832; x=1771939632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q5oVq95jqQQoO+Nm/H6qoKVVfjO/F3iq8iJp7dxOY7w=;
        b=RwmlvCQgCyJqgEk4IOIhK0WLaXQ1p1tXOT9mX3GN40ajZ+LXIv88sX5GAGFeuOJA9T
         04P7NDQIxiWzVxSd8kpaQrD44akrAt2XwqndPa5KgON5di/iATTpQKl1g/S5MLxr/p8w
         oOAIIVZ2YbhoBsQVpLcSp4l08njUhHhSAjVUOqjbeK94pLd/WFg58X6UxI4citXxorBL
         PQyiM/wbOci0hQSg7828TFJkd+vwIPRbLKvIglR0ub389QgdFefSsvXxzk2XAXQfpkA8
         5NGHOqU9v25L5VXvp0UZ/tTSfCJQ4HT5lfRCQhgYn7uo/s1/DEeMlOD0WareSAjUlhuj
         eQBg==
X-Forwarded-Encrypted: i=1; AJvYcCX6giFVOvJ0cFLZ55iHwI5ezT2xL4IcHcSwMSmM7JYjBc9ZW3Dg2iJwUS72YckYwv6KEUf8pN7/7Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRBQGx80dVyN2BtELkp6s/e/XCvEy60KxdZzgnYKPs6IkQFLb0
	q8kCJwDmF5Vh+xCDzSr5HNhmevzZPOk0HwVBt8wQEH1f/cYfADzWtCdFvIo+EhgNsO2MYPm5NGD
	2D0v+afJYPqGEwewa/RwNKYsgJlRvK6o=
X-Gm-Gg: AZuq6aJ/mRImeTGAwHOUhpZaCkPBNKNQTWEcORY3Py9mbv5WBsTn6dcM2cm1lZbavx0
	hOcMko0YKAnFz66NpTatoPYjV+/VZmwUjjA7HyffgCkJ7z1tYWQuTgb9x06lG8p2lSJmZdHAN/n
	yuDicsudljcNFPEphrCrfg9ngfPmLScPjpQL0mQEtpNFomF4qCdwtChaN3CZFXC9C+tfKisNzNJ
	06Yd42Jbv98L9kOunC78mbkCKBxe+931qqEL7CxXkEpDoD/etFxH+BOkr7IEOWI2VDjmwMmXI6/
	28BsdkAI
X-Received: by 2002:a05:6000:40df:b0:436:8058:452 with SMTP id
 ffacd0b85a97d-4379dba36d1mr20165444f8f.44.1771334831515; Tue, 17 Feb 2026
 05:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114-tonyk-get_disk_uuid-v1-0-e6a319e25d57@igalia.com>
 <22b16e24-d10e-43f6-bc2b-eeaa94310e3a@igalia.com> <CAOQ4uxhbz7=XT=C3R8XqL0K_o7KwLKsoNwgk=qJGuw2375MTJw@mail.gmail.com>
 <0241e2c4-bf11-4372-9eda-cccaba4a6d7d@igalia.com> <CAOQ4uxi988PutUi=Owm5zf6NaCm90PUCJLu7dw8firH8305w-A@mail.gmail.com>
 <33c1ccbd-abbe-4278-8ab1-d7d645c8b6e8@igalia.com> <CAOQ4uxgCM=q29Vs+35y-2K9k7GP2A2NfPkuqCrUiMUHW+KhbWw@mail.gmail.com>
 <75a9247a-12f4-4066-9712-c70ab41c274f@igalia.com> <CAOQ4uxig==FAd=2hO0B_CVBDSuBwdqL-zaXkpf-QXn5iEL364g@mail.gmail.com>
 <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
 <ee38734b-c4c3-4b96-8ff2-b4ce5730b57c@igalia.com> <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
 <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
 <CAOQ4uxhHFvYNAgES9wpM_C-7GvfwXC2xet1ensfeQOyPJRAuNQ@mail.gmail.com>
 <05c37282-715e-4334-82e6-aea3241f15eb@igalia.com> <CAOQ4uxgzK7qYDFWYT62jH_zq8JkLGussD5ro4cKDqSNQqBiVUA@mail.gmail.com>
 <8bec19de-6e6e-418a-a256-5918bd835d98@igalia.com>
In-Reply-To: <8bec19de-6e6e-418a-a256-5918bd835d98@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Feb 2026 14:26:59 +0100
X-Gm-Features: AaiRm50wzuTW2-Y09oQNfhcaN_Xf9kQsFW2GVozychJKf87k4BKo6-ETNYdwiV0
Message-ID: <CAOQ4uxhpB-D+DaCVZ6-uZGM8WnsZ9Bkxdd4+f_EkvYnQ8xpvqQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18957-lists,linux-nfs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9004214C8FA
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 4:59=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 06/02/2026 10:12, Amir Goldstein escreveu:
> > On Thu, Feb 5, 2026 at 9:34=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@=
igalia.com> wrote:
> >>
> >> Anyhow, I see that we are now too close to the merge window, and from =
my
> >> side we can delay this for 7.1 and merge it when it gets 100% clear th=
at
> >> this is the solution that we are looking for.
> >>
> >
> > I pushed this patch to overlayfs-next branch.
> > It is an internal logic change in overlayfs that does not conflict with
> > other code, so there should not be a problem to send a PR on the
> > second half of the 7.0 merge window if this is useful.
> >
> > I think that the change itself makes sense because there was never
> > a justification for the strict rule of both upper/lower on the same fs
> > for uuid=3Doff, but I am still not going to send it without knowing tha=
t
> > someone finds this useful for their workload.
> >
>
> Hi Amir,
>
> I can confirm that this is useful for my workload. After correctly
> setting this flag for every mount, everything is working good and we can
> bypass the random UUID issues. Thank you for your help!

OK, PR sent.

Thanks,
Amir.

