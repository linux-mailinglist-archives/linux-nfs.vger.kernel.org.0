Return-Path: <linux-nfs+bounces-13195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4097DB0E462
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 21:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6D83B163C
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 19:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF87280CC9;
	Tue, 22 Jul 2025 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/pFndXb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BD221297
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213884; cv=none; b=oZuF5DuMSK57vfrlrIhku7yDpxCx0sEQ6MTS93JE7vIde+gXU14zEsnI6WrFn3drHrRMgpqchXejg52NR8TtLYHTTEYO8+fYQKMtPuK57V5j68XKJHeYh8duzPpCO2MonWlRcOLitR0yhdMcURuERR2HfH3yONKT5fDVLvXorTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213884; c=relaxed/simple;
	bh=Qr/c93UFTJEStKD0uZQr4zM9DJykQ4JVCXP4rAOUFKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArSCvsJLJ/gDNUlbD8mtbanGBJyZDzE4KrtNWbfLaDbzQDM/CxC6aomSNxjvMwkb9lA9hronZENuhAhSYoTCHsWSUq/2fUCQm/QxYVpC/xHvGsPGyVmNRbNasT/9DbUHpf2HIiN+On4Jj/YwKw8uDNWn8tXa9ndJ2/eAsY86gLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/pFndXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07A9C4CEEB;
	Tue, 22 Jul 2025 19:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753213884;
	bh=Qr/c93UFTJEStKD0uZQr4zM9DJykQ4JVCXP4rAOUFKg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=b/pFndXbLoZCyg7fW5LFX50vDlVuXOyrjfY9Bu12TD18HnTwvY71MJsViQfyI4SIa
	 iZGTAqt1B8fKokVva+3enfNO2+B6PZ6jUmvYq8J9CSxNNCEY6TTWNe7plCzroaBKOC
	 BXForvJtevGWlc0k/EKhH8YMCUsKJnoPt52Li9kkU+4sRbJfNKCyUT0AReBsDm0MN8
	 1cotMg2GMJXDjxiVKK1IT2vWgJCOndEdMRfmNOAzZgUAXeJVnUA2oesVIHb2eRs+H5
	 WULVZcqVm6CNZ0IgcuV6iTpcPSNXHHcsIbvA3mO8yZDjTTxhGVnddEbNgiCeWvVpgT
	 t2X56s5uyEEhw==
Message-ID: <1b1d82709ee0edb5de4f4ac6d3eb6d72219583e0.camel@kernel.org>
Subject: Re: delegated timestamp woes
From: Trond Myklebust <trondmy@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Thomas Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, Chuck Lever
	 <chuck.lever@oracle.com>
Date: Tue, 22 Jul 2025 15:51:22 -0400
In-Reply-To: <bfa20f4a81e0c2d5df8525476fb29af156f4f5f1.camel@kernel.org>
References: <bfa20f4a81e0c2d5df8525476fb29af156f4f5f1.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 15:27 -0400, Jeff Layton wrote:
> I've been chasing some problems with the git regression testsuite
> that
> crop up with delegated timestamps enabled. I've knocked down a couple
> of problems on the server side, but I'm not sure how to fix the
> latest
> issue.
>=20
> Most of the problems with gitr suite and delegated timestamps
> manifest
> as spurious changes to the timestamps. e.g., it will do a git
> checkout
> and then later find that some file in the checkout appears to have
> changed when it didn't expect that.
>=20
> I reproduced one of the problems with some debugging turned up. What
> we
> see is this in the wireshark capture (filtered on the filehandle):
>=20
> 939238 1753209666.985827 192.168.122.151 =E2=86=92 192.168.122.103 NFS 48=
6 V4
> Reply (Call In 939237) OPEN StateID: 0xafa9
> 939239 1753209666.987808 192.168.122.103 =E2=86=92 192.168.122.151 NFS 29=
8 V4
> Call SETATTR FH: 0x68fcd843
> 939240 1753209666.995860 192.168.122.151 =E2=86=92 192.168.122.103 NFS 29=
4 V4
> Reply (Call In 939239) SETATTR
> 939241 1753209666.999909 192.168.122.103 =E2=86=92 192.168.122.151 NFS 27=
8 V4
> Call WRITE StateID: 0xe7e8 Offset: 0 Len: 2
> 939242 1753209667.019570 192.168.122.151 =E2=86=92 192.168.122.103 NFS 18=
2 V4
> Reply (Call In 939241) WRITE
> 944922 1753209696.313938 192.168.122.103 =E2=86=92 192.168.122.151 NFS 15=
14
> V4 Call SETATTR FH: 0xb6dd63b6 | DELEGRETURN StateID: 0x3eebV4 Call
> SETATTR FH: 0xcf57bbcb | DELEGRETURN StateID: 0x69ca=C2=A0 ; V4 Call
> SETATTR FH: 0x68fcd843 | DELEGRETURN StateID: 0xe245=C2=A0 ; V4 Call
> SETATTR FH: 0x02d757ea | DELEGRETURN StateID: 0xc788=C2=A0 ; V4 Call
> SETATTR FH: 0x130870b2 | DELEGRETURN StateID: 0x8c12
> 946410 1753209702.893917 192.168.122.103 =E2=86=92 192.168.122.151 NFS 25=
4 V4
> Call GETATTR FH: 0x68fcd843
> 946411 1753209702.895304 192.168.122.151 =E2=86=92 192.168.122.103 NFS 31=
0 V4
> Reply (Call In 946410) GETATTR
>=20
> We get an open for write (with no open stateid and delegated
> timestamps), a write, and then and=C2=A0 setattr|delegreturn. git had the
> delegated mtime (1753209666.995071118) on file because the delegation
> allowed getattr() on the client to return before writeback had
> completed.
>=20
> In this case, the setattr for the delegated mtime was for a value
> older
> than the existing mtime, so it was ignored. Note that the reply to

Uhh... Why is the existing value of the mtime on the server grounds for
rejecting the delegated mtime? The client owns that value.=20

> the
> WRITE didn't go out until 1753209667.019570, which is after
> 1753209666.995071118.
>=20
> Eventually the client gets the "real" mtime from the server after
> returning the delegation, which now doesn't match the one git has on
> file.
>=20
> I don't see a way to fix this right offhand. Any thoughts?

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

