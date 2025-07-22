Return-Path: <linux-nfs+bounces-13197-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A791B0E4A5
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4DC73A9E08
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 20:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CEC1C1AB4;
	Tue, 22 Jul 2025 20:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mpx/bzcm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0F40BF5
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215367; cv=none; b=Btw+dfKEWOJ0j5LlFYtTMlyWiKTAS3/xK7uo5cujHfMl7OtWu1DnTMWm6A4npOOzirQc64IW8jBFGQ7CRFu5wyIpWHSJY7qB1+t5k/1DpnHqAxu9l9pqPQG/uC4bHXvQu5+ZUf4/TBMM+0r4YoK3HklZzKkdzIC8poLLa+cD2K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215367; c=relaxed/simple;
	bh=YWMfKlZ5meLm887O7e6urC3NE/p0H3TZrDJdnAssX7Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZ2Rt0OBm4bUj6BjZgwiaEYbtvDrVQa1/cPlUH4J5wmsxlpB1Oiwrzl1mpsaZYUR9gTn8CP8BwIAPPbq+9u9qcDsGs9xNEjz1B8crKxXwQwltFSd7+kKZSoLqm7dRUV5mClYt7sAHKAY6YKfQkjOLO1Z16dKZzG7EKSuFgMpzgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mpx/bzcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57200C4CEEB;
	Tue, 22 Jul 2025 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753215366;
	bh=YWMfKlZ5meLm887O7e6urC3NE/p0H3TZrDJdnAssX7Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Mpx/bzcmVYbEKuz8RYshuUglivtyn8FLnWRbAQGrysyLQOqdzsFe/nZnziiDlESAM
	 rKD0YIZlh4NB4N+sn95Yh5P8DR/FMrhU6xGzD86PWHA6wDQ8J2UUJgGHFJTH47AsMx
	 FQHTO5b+NYwQIXfNuAuPUSAukLkIs94xrgLGom86O3AU9k0xwEvJzjq8CWoaM9fGC8
	 zdfkPWDbg53YoROhbh0/QuwipJWgOOhan//rOJUefBGqOcYpXXEeA59TPwkaBtOtSr
	 8Mvd05km9C+e8oGZ5f6Y9VCRrz6D6sUIhhDCpwapl3Ec7ZVWKTb/U6k0uBWhnYIZqk
	 HMosPFMnUzKUw==
Message-ID: <47a4e40310e797f21b5137e847b06bb203d99e66.camel@kernel.org>
Subject: Re: delegated timestamp woes
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Thomas Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Tue, 22 Jul 2025 16:16:05 -0400
In-Reply-To: <da5ce5ea155d761f16c8834c9525f46b705da79f.camel@kernel.org>
References: <bfa20f4a81e0c2d5df8525476fb29af156f4f5f1.camel@kernel.org>
		 <1b1d82709ee0edb5de4f4ac6d3eb6d72219583e0.camel@kernel.org>
	 <da5ce5ea155d761f16c8834c9525f46b705da79f.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 16:03 -0400, Jeff Layton wrote:
> On Tue, 2025-07-22 at 15:51 -0400, Trond Myklebust wrote:
> > On Tue, 2025-07-22 at 15:27 -0400, Jeff Layton wrote:
> > > I've been chasing some problems with the git regression testsuite
> > > that
> > > crop up with delegated timestamps enabled. I've knocked down a
> > > couple
> > > of problems on the server side, but I'm not sure how to fix the
> > > latest
> > > issue.
> > >=20
> > > Most of the problems with gitr suite and delegated timestamps
> > > manifest
> > > as spurious changes to the timestamps. e.g., it will do a git
> > > checkout
> > > and then later find that some file in the checkout appears to
> > > have
> > > changed when it didn't expect that.
> > >=20
> > > I reproduced one of the problems with some debugging turned up.
> > > What
> > > we
> > > see is this in the wireshark capture (filtered on the
> > > filehandle):
> > >=20
> > > 939238 1753209666.985827 192.168.122.151 =E2=86=92 192.168.122.103 NF=
S
> > > 486 V4
> > > Reply (Call In 939237) OPEN StateID: 0xafa9
> > > 939239 1753209666.987808 192.168.122.103 =E2=86=92 192.168.122.151 NF=
S
> > > 298 V4
> > > Call SETATTR FH: 0x68fcd843
> > > 939240 1753209666.995860 192.168.122.151 =E2=86=92 192.168.122.103 NF=
S
> > > 294 V4
> > > Reply (Call In 939239) SETATTR
> > > 939241 1753209666.999909 192.168.122.103 =E2=86=92 192.168.122.151 NF=
S
> > > 278 V4
> > > Call WRITE StateID: 0xe7e8 Offset: 0 Len: 2
> > > 939242 1753209667.019570 192.168.122.151 =E2=86=92 192.168.122.103 NF=
S
> > > 182 V4
> > > Reply (Call In 939241) WRITE
> > > 944922 1753209696.313938 192.168.122.103 =E2=86=92 192.168.122.151 NF=
S
> > > 1514
> > > V4 Call SETATTR FH: 0xb6dd63b6 | DELEGRETURN StateID: 0x3eebV4
> > > Call
> > > SETATTR FH: 0xcf57bbcb | DELEGRETURN StateID: 0x69ca=C2=A0 ; V4 Call
> > > SETATTR FH: 0x68fcd843 | DELEGRETURN StateID: 0xe245=C2=A0 ; V4 Call
> > > SETATTR FH: 0x02d757ea | DELEGRETURN StateID: 0xc788=C2=A0 ; V4 Call
> > > SETATTR FH: 0x130870b2 | DELEGRETURN StateID: 0x8c12
> > > 946410 1753209702.893917 192.168.122.103 =E2=86=92 192.168.122.151 NF=
S
> > > 254 V4
> > > Call GETATTR FH: 0x68fcd843
> > > 946411 1753209702.895304 192.168.122.151 =E2=86=92 192.168.122.103 NF=
S
> > > 310 V4
> > > Reply (Call In 946410) GETATTR
> > >=20
> > > We get an open for write (with no open stateid and delegated
> > > timestamps), a write, and then and=C2=A0 setattr|delegreturn. git had
> > > the
> > > delegated mtime (1753209666.995071118) on file because the
> > > delegation
> > > allowed getattr() on the client to return before writeback had
> > > completed.
> > >=20
> > > In this case, the setattr for the delegated mtime was for a value
> > > older
> > > than the existing mtime, so it was ignored. Note that the reply
> > > to
> >=20
> > Uhh... Why is the existing value of the mtime on the server grounds
> > for
> > rejecting the delegated mtime? The client owns that value.=20
> >=20
>=20
> From RFC 9754:
>=20
> =C2=A0=C2=A0 When the time presented is before the original time, then th=
e
> update
> =C2=A0=C2=A0 is ignored.=C2=A0 When the time presented is in the future, =
the server
> can
> =C2=A0=C2=A0 either clamp the new time to the current time or return
> NFS4ERR_DELAY
> =C2=A0=C2=A0 to the client, allowing it to retry.
>=20
> In this case, the preceding WRITE operation from the client updated
> the
> mtime and ctime on the server. That operation happened after the
> mtime
> was updated on the client for that write.
>=20
> Are you suggesting that the server needs to "disable" mtime/ctime
> updates from WRITE calls (and I guess atime updates from READs) when
> there is a delegation outstanding? If so, that would potentially be
> quite ugly in the face of a crash.

It just needs to record what the original atime and mtime was on the
file when it issued the delegation.
That gets a little complicated if the server reboots, and the client
has to reclaim the delegation and so you might want to give it a little
more leeway in that situation.

>=20
> > > the
> > > WRITE didn't go out until 1753209667.019570, which is after
> > > 1753209666.995071118.
> > >=20
> > > Eventually the client gets the "real" mtime from the server after
> > > returning the delegation, which now doesn't match the one git has
> > > on
> > > file.
> > >=20
> > > I don't see a way to fix this right offhand. Any thoughts?

