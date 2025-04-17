Return-Path: <linux-nfs+bounces-11158-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6399A91F04
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 15:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0C34476BB
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Apr 2025 13:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B72C2512CD;
	Thu, 17 Apr 2025 13:59:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76E2512C1
	for <linux-nfs@vger.kernel.org>; Thu, 17 Apr 2025 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898386; cv=none; b=TS2iRARc7Q2TodRxzQkx/30dyWgoEwYFZiRQSVfvtC6ACTnBCGCejUbsEIuQQ0a1pXQj4HB41QeI/8ZYiDE1e+Dew7F3rSisSp8NEXrE41f6HpsJg8FO5l+9uLnaSXkUqRGx5aYu58qtI3ao35QFYKWD7KbcGb9dlUMH4WiLW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898386; c=relaxed/simple;
	bh=hn6DAaD1mAGdghSO58NoYSaSwWtKgkyL/v5+t1G7pxo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IFPXc9XMkDLOOeMGFQ8wNm7j9Ny50wFT3L9QmCwTuv/rtBQiv2MoPK9SZ6RZe5XBe7Gx+9+/5cWhR8LNlJTNFrljfhzsmrzQ4WPhRHLlV5AQXbCGfSlG/Ddq9X54vPcr9HUVN3Kb4nx8Rsy6fVFtQG6wpwmDdDoHyRJVuuu6GEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-861b1f04b99so23273639f.0
        for <linux-nfs@vger.kernel.org>; Thu, 17 Apr 2025 06:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744898384; x=1745503184;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hn6DAaD1mAGdghSO58NoYSaSwWtKgkyL/v5+t1G7pxo=;
        b=YJopsRCQTaAYz1HPLmNs6V9+f2nxzu1hDIB4geOF3/8JQG5vYvJmxg1qegasEftSKY
         2j64CU278f9DTDZ8nRx80OWkGwbJGv8OgJzPDSl1hAEl0XLk23YbSCqboMsuwAqnBxqm
         DIAeH7reRaXda1cPV9QTWY6DOIml0e8M5zGv+msYSvv7yA+rTkpwj4LQpd1SOlUPhnae
         khtaVstlddhECsN4aCxG2+wa6FPjQQ9TnByAedd+HYgOYgV/NcraaOkVTf5lTO/kbJkN
         OLUeenkwi1SAkmzldc+QGJrhq4nPQoLqjDrYisS5pT70T5kAfiN4RGJq9nraXssyjkTW
         Z8iw==
X-Gm-Message-State: AOJu0YxMmytY3pFIQsCH0sfLg5xodNPVcqW7tYC7DvusF+7Z0PSALCh3
	QFCQPrtVar5CZhWHbjE5JyZNnS5cqgXc1P2HWyun2D1Dx0R4LaUn+0yc
X-Gm-Gg: ASbGncvKDBmPahzQCTKuD8fHrjG1Z2rg5DQCpl0y1VLjBJ2laat8TDC4pPEIRAQNwqD
	mYp5jzCpDeEMWNtUoIa+uSAFD3nmHAIpIVceoEcDMi+eLLJRXLWhJhcf6ZEgbuNDr+IcdMnKeDv
	yvh2oLXRIK3Bacuj7Yl/jw9G0q8hAcijJFWShtjieFYVHT38AlaIqxb2XgcL0EKY1nr1YXERhOe
	9XH0ji8XY/DgbI8IsOGUS+X0FlmnyR9vej69nweGbHbi1lKl9TJtRWuYvFYzDMmKaVz//RsIKYU
	ZxUpq5dHsm1NUfgQk1Q3VTJsuAXBFZYqKQsHbbmUdjWHGDQFwoGEWpok66/VYtx5hOyYIw++gDI
	cjAWJOVRCUHoapNoGWWytdBW5H2O4FjeLbB/gKrk=
X-Google-Smtp-Source: AGHT+IFMbgbqIJLJrwc2bxK2oip+nshXlQxHSxO43QSx0/LePaXb5g64M3WXCKWhSdu9eoMOZQzk6w==
X-Received: by 2002:a05:6602:3790:b0:85b:5869:b66 with SMTP id ca18e2360f4ac-861c4f6f899mr670411839f.1.1744898384158;
        Thu, 17 Apr 2025 06:59:44 -0700 (PDT)
Received: from leira.trondhjem.org (162-232-235-235.lightspeed.livnmi.sbcglobal.net. [162.232.235.235])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-86165425bd2sm338520639f.11.2025.04.17.06.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 06:59:42 -0700 (PDT)
Message-ID: <387a5701d884538aa36a35d186d03f3e4123ffbc.camel@kernel.org>
Subject: Re: Wanted: more fixups for client delegations test/free walk
From: Trond Myklebust <trondmy@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>, Anna Schumaker
 <anna@kernel.org>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Thu, 17 Apr 2025 09:59:40 -0400
In-Reply-To: <9146009C-5726-400D-8571-504F5B36C651@redhat.com>
References: <9146009C-5726-400D-8571-504F5B36C651@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 (3.56.0-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-17 at 09:28 -0400, Benjamin Coddington wrote:
> Hey Trond, Anna, et al.
>=20
> I'm looking at working on nfs_server_reap_expired_delegations()
> because the
> work to walk that list is order n(n+1)/2=C2=A0 and the list can grow very
> large
> due to some servers doing SEQ4_STATUS_ADMIN_STATE_REVOKED these
> days.=C2=A0 It
> can currently grow unlimited by 5k delegation watermark.

Why would we be seeing an increase of SEQ4_STATUS_ADMIN_STATE_REVOKED
cases? That should normally just be seen on network outages that last
longer than a full lease period.

>=20
> First observation is that we don't remove revoked states from the
> list even
> after doing FREE_STATEID, so we're still doing walks across
> delegation
> state we'll never use again.=C2=A0 I think we can fix this by plumbing in
> the
> error result from FREE_STATEID.. so that's a potential bit of work.
>=20
> I'm tempted to just do:
>=20
> @@ -1342,7 +1346,7 @@ nfs_delegation_test_free_expired(struct inode
> *inode,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D ops->test_and_free_=
expired(server, stateid, cred);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status =3D=3D -NFS4ERR_EXP=
IRED || status =3D=3D -
> NFS4ERR_BAD_STATEID)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nfs_remove_bad_delegation(inode, stateid);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 nfs_delegation_mark_returned(inode, stateid);
> =C2=A0}
>=20
> .. but I think that gets us up to not tracking state the server might
> still
> be tracking.

Just marking the delegation as being returned isn't helpful. That
doesn't trigger any action to recover the state.

>=20
> Other approaches might be to walk the list once moving the work to a
> temporary list and then operate on that linearly.
>=20
> Advice, thoughts, or direction welcomed..=C2=A0 I'll probably work on
> splitting
> out nfs41_free_stateid() from test_and_free_expired(), so the
> delegation
> code can know for sure that we're done with that state.
>=20

Setting up a separate list for state that needs recovery of some sort
might be useful. However that doesn't solve the problem that you have
to scan the entire list of stateids every time the server sets
SEQ4_STATUS_ADMIN_STATE_REVOKED. The latter is a protocol requirement,
which is why if we're seeing a lot of it happening, then we need to
solve that problem first.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com

