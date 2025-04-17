Return-Path: <linux-nfs+bounces-11161-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28AA92012
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F80C19E3A56
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 14:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC802522A2;
	Thu, 17 Apr 2025 14:46:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC663594B
	for <linux-nfs@vger.kernel.org>; Thu, 17 Apr 2025 14:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901194; cv=none; b=Ky70uPLIN1uStupdclG0jNoWeY4+80myHatWwZobLzL7Hu4PWPKCOJLmw62A32A7l1ODbG+ffz7zncrpt6qDTZ6rBsNjw1lT7nDJoDx/if+3jZl9+Yl5h+Nv/gTwYbBfOvOueQzXQHP7tZ7+reF9gHL/wta8XeNDF/bEKbHnxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901194; c=relaxed/simple;
	bh=Ob05fnepWXK9rbjv7dgBdvTRQ2jxlIBHapTTjK6F6+U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hHtghbuKtWWiCBBiAvG0ydrWekUE5P+cp1QlrwkJww/L/QV0XIgV+FtJGGAnhmTSGqoeUpYXkVs1vD8LvW3Mnf4GpsPBEYWX0Y8KGu8iahrgSEGinczkHPXw4iBbsri5B97uJbppz1TI1uEK+hkbxFZUAGcWYzDI9adInXqAuKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so79493839f.1
        for <linux-nfs@vger.kernel.org>; Thu, 17 Apr 2025 07:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744901192; x=1745505992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ob05fnepWXK9rbjv7dgBdvTRQ2jxlIBHapTTjK6F6+U=;
        b=c443tHma1txFz4PYOt7atbtOI5ClQZVKi9T455Lbp4EAJjWBAAj0ZIWGjbcWbTlq2T
         hQHPCUjdr+9lHcm89h5xJzkyPP0ByW/2BmEH91/yKnViTq+/wmChqOkFcYZXyOV8Hif+
         SBmW5NHMceo50Rj0El+YuDN9Z2T7ibyRvPLG7l1GD8t7HmgNVtF72iDXUCE8XQwP60Yh
         UVZTdA3inso4ozCrE48dwpI/wLwV/H1QeE9NhRwV/uhwyHmKMt6Zy9rBcXbISfu/Nm5M
         yIvXl5/l25lkULMVOxqXDp6XiGc3dB44h0xyjtr9WWPhBIE/Qz/ufvlwVHknRSanHgse
         wlmA==
X-Forwarded-Encrypted: i=1; AJvYcCVAWFHhzzkIEeHRIpax9MfTY3Has4eeeUXBpSrBGa3Mz8EdsWAC5S7YCjXlHRVSlUQU6UlFIgJ94yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZHYfeTND7Fdd2uuHX+teJWDxHQ9HqgmgCELGbHV2APghKoCEU
	jew9oPmpbY0z8nXRHvcUGSxdty28+l4QxLV3kwhfazTMduePsR8=
X-Gm-Gg: ASbGnctnCiEvciHHj/12JZZe2W/drdlZwmEg09x7/pXhNpqnOPLqsGeE6PviGdl+eaa
	jIhblW+e7+DiIT/pD1vJjUdCnMTNQnT1NqWNU729ZKpp7kH/kmtKo5Afa1mso1btbHPBOTw6dFp
	MgFgAvj+pJOW4uSRyG7MKTqbOdN5L+blYZej5BFzaFkVsaTXOYuZVbxshLGBI4YOWih4YVJ10om
	BDb4oolBN8puZDLZ2Asu9PAuHIqyjNW72IMUMtThO1IVcyaVTLz9QkyOXBSvo+jRWTZGnST+KHq
	sM9DRHttIxzUTzmRvfDrMDHpgbHD32x8+WiFUrTDCLOXyPiFDxAZkUmo3eqxlCkeLuUou5jqCQa
	v4ndrHlN91pZmTeraIpyTl1RpQhprhK9c3k7hyDs=
X-Google-Smtp-Source: AGHT+IFnfnR45scn75msrL7lXb0Tec0Tn/uQhEntG3vTVh1e6/rMJE2ZW4+gr1BKfePlSkxwQMgdkA==
X-Received: by 2002:a05:6e02:3a11:b0:3d2:b72d:a502 with SMTP id e9e14a558f8ab-3d815b70c8dmr73321105ab.22.1744901192350;
        Thu, 17 Apr 2025 07:46:32 -0700 (PDT)
Received: from leira.trondhjem.org (162-232-235-235.lightspeed.livnmi.sbcglobal.net. [162.232.235.235])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d821ed06dfsm93755ab.65.2025.04.17.07.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 07:46:31 -0700 (PDT)
Message-ID: <abb530ae3de183aa5839222757b36f186c68d65a.camel@kernel.org>
Subject: Re: Wanted: more fixups for client delegations test/free walk
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Anna Schumaker <anna@kernel.org>, Linux NFS Mailing List
	 <linux-nfs@vger.kernel.org>
Date: Thu, 17 Apr 2025 10:46:30 -0400
In-Reply-To: <2CD51D9C-D481-463B-851D-195B10C1F1CD@redhat.com>
References: <9146009C-5726-400D-8571-504F5B36C651@redhat.com>
	 <387a5701d884538aa36a35d186d03f3e4123ffbc.camel@kernel.org>
	 <2CD51D9C-D481-463B-851D-195B10C1F1CD@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 (3.56.0-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 10:33 -0400, Benjamin Coddington wrote:
> On 17 Apr 2025, at 9:59, Trond Myklebust wrote:
>=20
> > On Thu, 2025-04-17 at 09:28 -0400, Benjamin Coddington wrote:
> > > Hey Trond, Anna, et al.
> > >=20
> > > I'm looking at working on nfs_server_reap_expired_delegations()
> > > because
> > > the work to walk that list is order n(n+1)/2=C2=A0 and the list can
> > > grow very
> > > large due to some servers doing SEQ4_STATUS_ADMIN_STATE_REVOKED
> > > these
> > > days.=C2=A0 It can currently grow unlimited by 5k delegation
> > > watermark.
> >=20
> > Why would we be seeing an increase of
> > SEQ4_STATUS_ADMIN_STATE_REVOKED
> > cases? That should normally just be seen on network outages that
> > last
> > longer than a full lease period.
>=20
> No idea - but its happening.=C2=A0 Maybe I've been too hasty to blame
> ADMIN_STATE_REVOKED, but we do see in the results many
> NFS_DELEGATION_REVOKED states. Perhaps the linux server's admin
> revocation
> interfaces are gaining popular use for some reason.

Why should we be changing the client if the server implementation or
the admins are abusing the functionality? Revoking delegation state
should be an exceptional case because it breaks locks and therefore has
serious potential to corrupt data.

>=20
> > > First observation is that we don't remove revoked states from the
> > > list
> > > even after doing FREE_STATEID, so we're still doing walks across
> > > delegation state we'll never use again.=C2=A0 I think we can fix this
> > > by
> > > plumbing in the error result from FREE_STATEID.. so that's a
> > > potential
> > > bit of work.
> > >=20
> > > I'm tempted to just do:
> > >=20
> > > @@ -1342,7 +1346,7 @@ nfs_delegation_test_free_expired(struct
> > > inode
> > > *inode,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D ops->test_and_f=
ree_expired(server, stateid,
> > > cred);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status =3D=3D -NFS4ERR=
_EXPIRED || status =3D=3D -
> > > NFS4ERR_BAD_STATEID)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nfs_remove_bad_delegation(inode, stateid);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nfs_delegation_mark_returned(inode, stateid);
> > > =C2=A0}
> > >=20
> > > .. but I think that gets us up to not tracking state the server
> > > might
> > > still be tracking.
> >=20
> > Just marking the delegation as being returned isn't helpful. That
> > doesn't trigger any action to recover the state.
>=20
> That's the only path to removing the delegation from the nfs_server's
> delegations list, and seems to do all the right steps for this case..
> but
> calling it here can't currently account for cases where FREE_STATEID
> wasn't
> successful.
>=20
> > >=20
> > > Other approaches might be to walk the list once moving the work
> > > to a
> > > temporary list and then operate on that linearly.
> > >=20
> > > Advice, thoughts, or direction welcomed..=C2=A0 I'll probably work on
> > > splitting out nfs41_free_stateid() from test_and_free_expired(),
> > > so the
> > > delegation code can know for sure that we're done with that
> > > state.
> >=20
> > Setting up a separate list for state that needs recovery of some
> > sort
> > might be useful. However that doesn't solve the problem that you
> > have
> > to scan the entire list of stateids every time the server sets
> > SEQ4_STATUS_ADMIN_STATE_REVOKED. The latter is a protocol
> > requirement,
> > which is why if we're seeing a lot of it happening, then we need to
> > solve that problem first.
>=20
> Well, we did have some misbehaving servers that are getting fixed,
> but its
> still entirely possible to end up with client systems that keep old
> revoked
> state on that list (that it has already done FREE_STATEID for), and
> once we
> have to walk and test it things get hot.=C2=A0 We're seeing this on
> clients that
> are /not/ on misbehaving servers, we've seen some clients with ~500k
> entries
> on that list.
>=20
> I'd really like a way to trim the list, thus the desire to remove
> state
> after a successful FREE_STATEID.

We can definitely have a separate list on which we put the state that
fails the FREE_STATEID test.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

