Return-Path: <linux-nfs+bounces-18428-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLFpOc6idGnz8AAAu9opvQ
	(envelope-from <linux-nfs+bounces-18428-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 11:45:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B17D460
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 11:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7F6630097DB
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Jan 2026 10:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5662B221FBB;
	Sat, 24 Jan 2026 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWrdm395"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF118B0F
	for <linux-nfs@vger.kernel.org>; Sat, 24 Jan 2026 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769251532; cv=pass; b=qXbJAfVnvHqFx6zfO/pzjIiT+nj3FOJ2W0XF8Klqeqhh2Uic0ur8V790FMA7i1Zn6oSLx8jEoFBjowRwTML8kVmit0MdDU1oJr4dnN6qyU01VyMVSGs6YsghmAfa0YgSlcxTGwSmHZXSx8g3+4L8xj/fDyzvhAwWMpV3ToRZpZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769251532; c=relaxed/simple;
	bh=OhfWhlQZiS1Yq37GsKg1ZRvFgI+/q0guhtaSDhFcjg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqwJXeAoBMiqPPHpTf3SX8P0R+LnaMhK/8ier+UehFAHCawiRcTvpoJKVaPGVu+CNz0kCP09oq8BYe/6bFSPz0qkNG3m8iQEauckslwUCeY0BxEWFDr5Ow2BVvbnAOJfRsIkU0TNLjQ3zKcNmEDj27zoq1NY9SBwnoZuHzvYtxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWrdm395; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so4623098a12.1
        for <linux-nfs@vger.kernel.org>; Sat, 24 Jan 2026 02:45:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769251529; cv=none;
        d=google.com; s=arc-20240605;
        b=E/THATmfniyn27l+ZsZzgdfIYVNHY1SE/Q5Bz8mVDz9u1c3HzS9N2BgIlrLjTZptrx
         ZxzHXMuyEZ9XIQPplbLLSzx/OIyrffA/fSL9g7bRf6J0V2ISpeUZsYuPnGZzczN/FxAo
         qxbqVUeMAnOU3mXDovMl2SIyM6bbWEj4mGp/0LkPV4ojNGDMO1g8bTWGZUL2wKAiSG7g
         ZlI4a2rljzEN3SQBl4I2VNAwzJNZir6Pupuo2DY7prI3yCEXUrwsZaAH35QWPz2x3yyU
         O1TfXux4LbTk8ncSteDOjHcG4kTM1UjxVDjnZs8G/4pFoqotjSyI6VsxKJ+GgTWnZwZ5
         eQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eYTZThtnBEBRsjkEMZ8Jc1BneVEDWprUm5MZX/gFhJo=;
        fh=ErZkXQ4KLE8I+Q97D8ldUbnWAQ2btuZGD8MYCXWpqPk=;
        b=bcnbzK/hGsttoKw/P2VdGwgcMrqQP5DUETBJVlx9kHypFmiuWfo39SQJgB2IqNnUEJ
         rfDdZxvtOvDqMPreY9GXFMqr6M/lFPld+UDBMuSGIP9aXiN9WGiYIRbkjcGnsY3HGvS6
         2WBsxbXIqwAIr4T8anoxc4HNvTX2ivcvgpkZEXnpN/rFN5EDPyKeXYUs4ylLuuYSP1SQ
         mO1WwdlPNYiON6q1lDWf7ES++cRUUoKzChd5hYDZfkVUGa4Cc3cF5fnbeeMF/Iy/DOwq
         7JAIHc09MZ+WGx1qckc/mq0bFBpmCmeyLacrA9hSBUD1Ky55jpCd2CRbDEEIuaq7kljj
         momg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769251529; x=1769856329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYTZThtnBEBRsjkEMZ8Jc1BneVEDWprUm5MZX/gFhJo=;
        b=nWrdm395wUmY0BCaISWaPOutLg163MXaaFaptr3TTl4rfWl7AxdcgS6OuDLbYYEpaz
         wME6dE/pV4njENzX/dnctf1XEEQ37vKc7YP2fi/sWsKFP+qDie/YBSevOnzomRoJtiYo
         KMqzTpsJ+MwgRfGOu231yJ8/8kW47AMeWL50DlUX42blTBQKPcLC4C0MmTkdbDquDbra
         aGjiNQRHD9Am8aaaPhEa0sTUxxFWuByY0Y9yX5e9Avzpr8Y2dA3dbTopa12UxBbIXfwl
         mnW4sFPT0BasxFjWJrHNA5XOdlSRWKTj9C+w4Ku3fYVpEGO2k7fWwPo1tQsGP0cKx0hy
         T/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769251529; x=1769856329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eYTZThtnBEBRsjkEMZ8Jc1BneVEDWprUm5MZX/gFhJo=;
        b=ly1wEAYHs9LXKsz7pSD6OkqrV5czbjZBCiYkP7vQ9aqX1qCEIlBDC3GrdbswziidPW
         Sddv5gJaiwKbJePVTEJkeYBKA2Kp5q2HOf80SIUh9BbNa0+a4nt6BHWnU7zskR3ArMyg
         Ch0ELM/e7gZcI8SCetIFVeheHlr4Bipjnq6MKPVWO9NuGkK8Qckfr1X55ZuAhlr2vzRD
         xLSlAbun9L1+X7Ex2ptWi19rmFLF0ipLMa107tCEX1743dQAFz7be8mtkquFmuuRgnpz
         HQOFmGHuqAPQmjjnmDWWR+mJyLA8wev8U0qE/G5UanznCeNLH7MUqQGQWCzLfQ0ORuPW
         hpfg==
X-Forwarded-Encrypted: i=1; AJvYcCUfl6VQ9WgT6YdfdZBoE61Lj4YhUKOPwQVLBHXMtZbJGGdiAwA+kuHBMDrxExBuVBPCj159CARMEo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKW8Ww+mRb/VPeoj7QPsdDyOE5w8W5LWyHWXKWVn/VZ366Vhm
	t2E3MZDBZ0/+Ts7ubDmfg3+ra6vCv0BHPIVuSklzxmQf9H9lM4nQKR38tQ+X0as7JbCGdMqYWWt
	j8OikbD3t/lx2eftjxMN/2zM84MCmlDM=
X-Gm-Gg: AZuq6aLSebX5OFWfe8uGOliUceeg+FXO7vnz8IPQg7K5uXHUfV+Ek3DBSIwMrOglcRC
	qIcg36ISpNeSadY+HXQjva5SySMyzOY/kg06qo/g5XeT0f09dZNEBjlnqMqILti5ED4Iic398nz
	vPU8Hv6gdUWoswgd7UyLlqZ/LeNvMplstoBoTE0c3AmUKsc0ebHBvMXAtMeHxlRCfQJCE2hXKAs
	Gcx+gHxl6A3MMa2jtOKBEC1mUhOMNdS+D5ocx0nfD5IDTUkcDUowE1aB53bm6F/a2/q7uEv4Hrn
	5dV66vzRsc2aP5Vp/NcOZ3hHEl1ic4R+1Ji7ud0=
X-Received: by 2002:a17:907:1c0a:b0:b87:173f:630 with SMTP id
 a640c23a62f3a-b885ae61dc2mr478554866b.40.1769251528580; Sat, 24 Jan 2026
 02:45:28 -0800 (PST)
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
 <CAOQ4uxg6dKr4XB3yAkfGd_ehZkBMcoNHiF5CeB9=3aca44yHRg@mail.gmail.com>
 <ee38734b-c4c3-4b96-8ff2-b4ce5730b57c@igalia.com> <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
In-Reply-To: <8ab387b1-c4aa-40a5-946f-f4510d8afd02@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 24 Jan 2026 11:45:17 +0100
X-Gm-Features: AZwV_QilNv7skh3Dbv-Uyf4qbklEv15lpqvlCHXP7YddmY5hXQul6pw3DTKCtH8
Message-ID: <CAOQ4uxiRpwuyfj_Wy3Zj+HAi+jgQOq8nPQK8wmn6Hgsz-9i1fw@mail.gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18428-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E3B17D460
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 9:08=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@iga=
lia.com> wrote:
>
> Em 23/01/2026 10:24, Andr=C3=A9 Almeida escreveu:
> >
> > Em 22/01/2026 17:07, Amir Goldstein escreveu:
> >> On Tue, Jan 20, 2026 at 4:12=E2=80=AFPM Amir Goldstein <amir73il@gmail=
.com>
> >> wrote:
> >>>
> >>> On Mon, Jan 19, 2026 at 5:56=E2=80=AFPM Andr=C3=A9 Almeida
> >>> <andrealmeid@igalia.com> wrote:
> >>>>
> >> ...
> >>>> Actually they are not in the same fs, upper and lower are coming fro=
m
> >>>> different fs', so when trying to mount I get the fallback to
> >>>> `uuid=3Dnull`. A quick hack circumventing this check makes the mount
> >>>> work.
> >>>>
> >>>> If you think this is the best way to solve this issue (rather than
> >>>> following the VFS helper path for instance),
> >>>
> >>> That's up to you if you want to solve the "all lower layers on same f=
s"
> >>> or want to also allow lower layers on different fs.
> >>> The former could be solved by relaxing the ovl rules.
> >>>
> >>>> please let me know how can
> >>>> I safely lift this restriction, like maybe adding a new flag for thi=
s?
> >>>
> >>> I think the attached patch should work for you and should not
> >>> break anything.
> >>>
> >>> It's only sanity tested and will need to write tests to verify it.
> >>>
> >>
> >> Andre,
> >>
> >> I tested the patch and it looks good on my side.
> >> If you want me to queue this patch for 7.0,
> >> please let me know if it addresses your use case.
> >>
> >
> > Hi Amir,
> >
> > I'm still testing it to make sure it works my case, I will return to yo=
u
> > ASAP. Thanks for the help!
> >
>
> So, your patch wasn't initially working in my setup here, and after some
> debugging it turns out that on ovl_verify_fh() *fh would have a NULL
> UUID, but *ofh would have a valid UUID, so the compare would then fail.
>
> Adding this line at ovl_get_fh() fixed the issue for me and made the
> patch work as I was expecting:
>
> +       if (!ovl_origin_uuid(ofs))
> +               fh->fb.uuid =3D uuid_null;
> +
>          return fh;
>
> Please let me know if that makes sense to you.

It does not make sense to me.
I think you may be using the uuid=3Doff feature in the wrong way.
What you did was to change the stored UUID, but this NOT the
purpose of uuid=3Doff.

The purpose of uuid=3Doff is NOT to allow mounting an overlayfs
that was previously using a different lower UUID.
The purpose is to mount overlayfs the from the FIRST time with
uuid=3Doff so that ovl_verify_origin_fh() gets null uuid from the
first call that sets the ORIGIN xattr.

IOW, if user want to be able to change underlying later UUID
user needs to declare from the first overlayfs mount that this
is expected to happen, otherwise, overlayfs will assume that
an unintentional wrong configuration was used.

I updated the documentation to try to explain this better:

Is my understanding of the problems you had correct?
Is my solution understood and applicable to your use case?

Thanks,
Amir.

diff --git a/Documentation/filesystems/overlayfs.rst
b/Documentation/filesystems/overlayfs.rst
index ab989807a2cb6..af5a69f87da42 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -753,9 +753,9 @@ Note: the mount options index=3Doff,nfs_export=3Don
are conflicting for a
 read-write mount and will result in an error.

 Note: the mount option uuid=3Doff can be used to replace UUID of the under=
lying
-filesystem in file handles with null, and effectively disable UUID checks.=
 This
+filesystem in file handles with null, in order to relax the UUID checks. T=
his
 can be useful in case the underlying disk is copied and the UUID of this c=
opy
-is changed. This is only applicable if all lower/upper/work directories ar=
e on
+is changed. This is only applicable if all lower directories are on
 the same filesystem, otherwise it will fallback to normal behaviour.


@@ -769,7 +769,7 @@ controlled by the "uuid" mount option, which
supports these values:
     UUID of overlayfs is null. fsid is taken from upper most filesystem.
 - "off":
     UUID of overlayfs is null. fsid is taken from upper most filesystem.
-    UUID of underlying layers is ignored.
+    UUID of underlying layers is ignored and null used instead.
 - "on":
     UUID of overlayfs is generated and used to report a unique fsid.
     UUID is stored in xattr "trusted.overlay.uuid", making overlayfs fsid

