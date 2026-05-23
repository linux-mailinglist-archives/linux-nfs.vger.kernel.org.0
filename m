Return-Path: <linux-nfs+bounces-21855-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OrcLniJEWoJnQYAu9opvQ
	(envelope-from <linux-nfs+bounces-21855-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 13:03:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BE05BE9FC
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 13:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5E3E30166E5
	for <lists+linux-nfs@lfdr.de>; Sat, 23 May 2026 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E63238889C;
	Sat, 23 May 2026 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd5vraBT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480F389104
	for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534154; cv=pass; b=Ab557FuRl07o+FYJLSgFSWR0vatp9Vj3X1rtzhf4GUmrz7d+Od5kHVvzG9zd9OwD0vxWN9da/bhdc3GKCQXKScuwWR/8/fSfel+8BEF4wd1meJfqyZ5ozssGFz4HpfLiOhMrcNFBQ6SZUEvVZBH52Rn1h6x6Y3HlJcCa+CDHHQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534154; c=relaxed/simple;
	bh=8YPxUmKcGvWdFn6pUq77QYTQlpxGaKQQf85A5rfowlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMCkLm91i24IkTwt5JLjE9OhQefe0d+3pnz+bDOX+dmpIGSO74tzlc1eRau98SW8ekm/GOvpDFUzdcc8qwBo7D+s3NXBo2ija4NQtZHzSclJVWEB9zsy3otBmFw79TptPBZihANLoyqhc44BNFz8wsfDiOlfX8ZzYb0zD2iEAs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd5vraBT; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65eb226b1ceso2431172d50.0
        for <linux-nfs@vger.kernel.org>; Sat, 23 May 2026 04:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779534151; cv=none;
        d=google.com; s=arc-20240605;
        b=gmw8ipkgiNyQZcZLetiQZtG11FcsRt5OO3+EV43Y9msYaY2izA4cDHczsEoJXnrP8E
         ZOVQCm/DDi73zLP/uTSjsPUeEGwx0P8ExS3shqHk28GAMJWnCdsAy5iCafK6uPSIvM/e
         an4ykZAs6RIjtxEOItaGt6vOeeqk40fY1ZBlyC5AOS4Tvx3lv3uCEv2YysQftAOROWNj
         umpiXwMAy9iE0i7iIDFxYIcRK0PtiNN7PSfg1dXd/erhb+wCqRFzEW1orfS5XkragZbJ
         vAziBOIx3VtYiqA2fIiHwfu0/nYzcRHrIwr2tkW8MXFSJ1w07dKRa0F08wIo9WTqjUDZ
         g80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f8fCyOFR8iTJDC8kmWton2tfti9/JeA5m8/3Cf++Fg8=;
        fh=R2c7L9+3Kxwn9g9fozDDGqQKJRifP4n8Y3DG24KARqM=;
        b=dRlS23xHEmqpW3STDvU+gsywSiCCREncLNYxQR29MApo0q0POTKdwc/Mj7BgzDNCtf
         YXaG2z7tATQDCo4U/46oguK35mHobkINo7Lo+39D5FV9+quTl+IRBshPwk6/Xtl7gtkM
         BLiechnsz1grFQV8CxjBY+VpTEgdWMy6IrUJG8P1wSAHAMQnlYox3zRx5e6Or03JC9li
         /3raZla9CysalGaDmrlUbilt9U8Y5AUR+ZPI60BSI3N4uz4uWR6D4qFminecTiAIeQl2
         ZCLEb53HFX0rP3+twogtFr3EeHnF8Dcjmr8j0I+WlmDsE9iVEMyHCK8SGiNw3bUz8P9R
         jRnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534151; x=1780138951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8fCyOFR8iTJDC8kmWton2tfti9/JeA5m8/3Cf++Fg8=;
        b=Qd5vraBTcYKwJR11/7ikL1KwjhNnyeT8sJrD1TJQX82wYGRlvoAOsn4MQ4kChRRkTD
         JgP6J5HXwTNEABXNWDmJU0BgO9f3WprF6YV181FTyI3mVfdDDIkG7oHinbJTB2FpMD07
         D8XArQOEJvI8z7q1Z1PxeOaVG57LyyWiO5FYPjpeUSTW5xZzztpB6157ecNCSdLSDzIJ
         u3ihj3IkfLSjfF/+m0qAsRfmQU7VbUbf0TUY0EQnIqAG4G9+1pllevMlLjGldvrnpu5L
         YTGa8hqrMpV8Oi+OPhuFqy1e0eIMHJTzCfIntvzRrTS4N54WnvhjjgaTfZ5nLa3LyO74
         GUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534151; x=1780138951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8fCyOFR8iTJDC8kmWton2tfti9/JeA5m8/3Cf++Fg8=;
        b=APVRH94nhdqAkuc7uBXkB/yKvxUonFG1kFrgSNGi34zs0Z52d2k/zCCiKEwYsoorGv
         m8iloJ1EBrdYpdA963pHywlv6xVPTrTvLXP8vettr1xU4jPK5h7/xeBId/pxPsJDKlpN
         LB2IvHUNwmMQ8GsmtNluV6pZLcxsGwBru1fQf2YRnbWCDRJmqbxXo77xO7TGwTqRY2VC
         nnJIaSXGb47xdHp7myoUiwDSHS09r5+WsHjSxY/SvMU/lRfkfdL0vhGOkjmhWY29iMZ9
         //e5smgm48Na37bsqG0YSlym2LhOapybSI3PlW/HmCRN+A7+bykr+JSilPaa5/DHzWPB
         VPkw==
X-Forwarded-Encrypted: i=1; AFNElJ9uEk2MWwIa7BOLaKEfr9sZ1D3Q5+Vh52eIkI5EAbooG3lsiMT2Np/YanfnpymDyAHJccc/167dcpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7l3seiliMs1783f2w8QRtpDIqTmtNt9Ah2lyuOsOK7MiyG/Hs
	fjJR9+mc31OuVD4X0xPvyFrJOR/FziwKnP08KA4NrkAk7Wo66qQr+AxUQIdta34ZRHvw4FDBOJh
	o+Wh8e8ujGEvmLKK+rhbXydGd9JYxCwM=
X-Gm-Gg: Acq92OGprvfo95DOsHDYjQ95TVzkwdEgFERcCkxbml220FEOMkP4t+oCq5+1sQhu+tA
	JWVPNSBJFJWkQqE32yz8AU7Ao/H+tIB9QKgchLrhWdAVHG8Tr3cv6zkqdVJxGXpR2UTRsvysG8f
	LulgbFbIG1+IN2RluaL2hZ6DWUtxFSRZ3TcuuipkXezQwIgyAg8SY+6OpmscUzGZGunjc6+3AZ5
	M/CXOpmdwWu+HtaWZwKJL9ppf8E1lptmzTfc/MIYjdG3MnvEPiUjiDbBbqGvyrwYdOZ6URYcDCd
	mNL0pcM/PrWKadXol/2VMzaEo1fC0tZCXYDu
X-Received: by 2002:a05:690e:14c9:b0:654:5d65:9ff4 with SMTP id
 956f58d0204a3-65f3f4de008mr1056527d50.10.1779534150927; Sat, 23 May 2026
 04:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523014107.2460863-1-michael.bommarito@gmail.com> <8793ba93d173b82bd210a223a91664ee245b66dd.camel@kernel.org>
In-Reply-To: <8793ba93d173b82bd210a223a91664ee245b66dd.camel@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 23 May 2026 07:02:18 -0400
X-Gm-Features: AVHnY4LeFrYllrUZQFqsSaeBrspXtOWws8zkD6dO9Tih4q6y7o_N9f4-wdZrl8Y
Message-ID: <CAJJ9bXxc1C2coYCkxWYSk-ojq=XatuA_rje3NCA-s3e=NHhbpQ@mail.gmail.com>
Subject: Re: [PATCH] NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21855-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 14BE05BE9FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 6:55=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> Comment is a bit confusing, given that you replaced
> list_for_each_entry_safe() with list_for_each_entry().

Sorry, that's left over from an earlier patch attempt that introduced
a different issue.  How would this comment look?

Concurrent nfsd4_ssc_cancel_dul() can free an item while spinlock is
dropped for mntput() above, so restart the walk from the head so no
stale pointer is followed.

Thanks,
Mike

