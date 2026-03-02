Return-Path: <linux-nfs+bounces-19509-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA5ZBz3fpWkvHgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19509-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 20:04:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0F1DE990
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 20:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF2023010B94
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7455137104C;
	Mon,  2 Mar 2026 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKr+iH1w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB189330656
	for <linux-nfs@vger.kernel.org>; Mon,  2 Mar 2026 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478265; cv=none; b=sW+anrShMlU6p1kBfgj93u17J0RzoY/Z7khXe5NDK/xLWOxlKy1vS4PobwAolVYYQuvQ+elOGMvygDfLqpJ05i5Nm8t+tJu+V1veFohyd69bG2CePRyvdA2MJOTm/w+Vz4dCOOy8U1phB/BAA+Wloxq295VLy9KIGYNIoTqq3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478265; c=relaxed/simple;
	bh=p+lYqqGTOQz/dTVnAqrWtXzmXtMhWU8oe2MCDwvmFuc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=eiT5PN01qKNBZmCeae7v/UveQyUnK+sN7zFOWXszZmVGsSkg3Io7N8PdfKaSUOSN/p136tNaBfZvBBxdMayqjHtVZmPTcXTIwFbhM7R09BKDBfhJ/YZvhKP+TGXGZU85lDaA88ZlHTK0Qmt9y150nAlsCNkJPM4dJijIepdSiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKr+iH1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93593C19423;
	Mon,  2 Mar 2026 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772478264;
	bh=p+lYqqGTOQz/dTVnAqrWtXzmXtMhWU8oe2MCDwvmFuc=;
	h=Subject:From:To:Cc:Date:From;
	b=TKr+iH1wwvPbp4b3SRhYk83qU5RZ4u7pHfM9T6qsEnOuD9b3T5FklU/5zRMSpVko4
	 EnOHcnaWRuniSlQDNQdHUjAeIEj8UmVoTtzQ+APObZgadTBMHyabHSMaCdaCQoHs9j
	 Qkf5KdOIFTCLs7Wv3S/lUo+h/tWaomPEJ6Vssn59GCBnFJE8rLj1MkuFevAxznTCsC
	 MlKD5rdhKYYZgukvO064yghSimGsMla2a0CvQUMGcelQ+lJr4m84u+Kny9e/S+CcHb
	 nB1W5LZI3HtRkcphhSmu3hO0tQxHyUIM219tnjAkm6hhPFdHAN4enlpS2Z+NS2FiHr
	 GGdFmPG+SR/Rw==
Message-ID: <c4dcc644fa65036f9bcae63e64b66509db85efc1.camel@kernel.org>
Subject: client-side xfstest failures with delegated attributes
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker
 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Mon, 02 Mar 2026 14:04:21 -0500
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: multipart/mixed; boundary="=-9xJUHj90FIG7HNIG3y2P"
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 70F0F1DE990
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	MIME_BAD_ATTACHMENT(1.60)[gz:application/x-pcapng];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19509-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

--=-9xJUHj90FIG7HNIG3y2P
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I sent a couple of fragmented emails last week about these problems,
but didn't get a response. Let me try again.

With v7.0, we're now enabling delegated timestamps by default in knfsd.
There is a runtime switch in debugfs for disabling them. Olga was doing
some testing with this and hit a couple of test failures in xfstests. I
took a look and I believe them to be client-side bugs. My analysis of
both problems is below.

generic/221:

Here is the strace of the program that it's running:

9234  creat("file", 0600)               =3D 3
9234  fstat(3, {st_dev=3Dmakedev(0, 0x38), st_ino=3D115480, st_mode=3DS_IFR=
EG|0600, st_nlink=3D1, st_uid=3D0, st_gid=3D0, st_blksize=3D1048576, st_blo=
cks=3D0, st_size=3D0, st_atime=3D1000000000 /* 2001-09-08T21:46:40-0400 */,=
 st_atime_nsec=3D0, st_mtime=3D1772114154 /* 2026-02-26T08:55:54.240765990-=
0500 */, st_mtime_nsec=3D240765990, st_ctime=3D1772114154 /* 2026-02-26T08:=
55:54.240765990-0500 */, st_ctime_nsec=3D240765990}) =3D 0
9234  clock_nanosleep(CLOCK_REALTIME, 0, {tv_sec=3D1, tv_nsec=3D0}, 0x7ffff=
9da2e50) =3D 0
9234  utimensat(3, NULL, [{tv_sec=3D1000000000, tv_nsec=3D0} /* 2001-09-08T=
21:46:40-0400 */, UTIME_OMIT], 0) =3D 0
9234  fstat(3, {st_dev=3Dmakedev(0, 0x38), st_ino=3D115480, st_mode=3DS_IFR=
EG|0600, st_nlink=3D1, st_uid=3D0, st_gid=3D0, st_blksize=3D1048576, st_blo=
cks=3D0, st_size=3D0, st_atime=3D1000000000 /* 2001-09-08T21:46:40-0400 */,=
 st_atime_nsec=3D0, st_mtime=3D1772114154 /* 2026-02-26T08:55:54.240765990-=
0500 */, st_mtime_nsec=3D240765990, st_ctime=3D1772114154 /* 2026-02-26T08:=
55:54.240765990-0500 */, st_ctime_nsec=3D240765990}) =3D 0

...and then eventually it closes the file when the program exits. The
ctime should change due to the utimensat() call.

I attached the capture. The network trace of the relevant part looks
like this:

No.	Time	Source	Destination	Protocol	Length	Info
15	08:55:54.238880	192.168.122.158	192.168.122.129	NFS	334	V4 Call (Reply I=
n 16) OPEN DH: 0xf31a816b/
16	08:55:54.242641	192.168.122.129	192.168.122.158	NFS	446	V4 Reply (Call I=
n 15) OPEN StateID: 0xafa9
17	08:56:08.806830	192.168.122.158	192.168.122.129	NFS	194	V4 Call (Reply I=
n 18) SEQUENCE
18	08:56:08.808234	192.168.122.129	192.168.122.158	NFS	150	V4 Reply (Call I=
n 17) SEQUENCE
19	08:56:29.287004	192.168.122.158	192.168.122.129	NFS	194	V4 Call (Reply I=
n 20) SEQUENCE
20	08:56:29.287994	192.168.122.129	192.168.122.158	NFS	150	V4 Reply (Call I=
n 19) SEQUENCE
21	08:56:29.288038	192.168.122.158	192.168.122.129	NFS	346	V4 Call (Reply I=
n 22) SETATTR FH: 0xf31a816b | DELEGRETURN StateID: 0xc2cb
22	08:56:29.290851	192.168.122.129	192.168.122.158	NFS	254	V4 Reply (Call I=
n 21) SETATTR | DELEGRETURN

The server grants a WRITE_ATTRS_DELEG delegation on the OPEN and then
the client sets the delegated attrs and returns the delegation.

In the capture, the server sends the client an mtime/ctime of
1772113983:668837149 in the initial GETATTR after the create, but the
first fstat() of the file after the creat() shows the ctime to be later
than that. So, I think that is likely a bug.

Those times then don't change after utimensat() like they should, which
makes the test fail. This seems like a different bug.

ISTM that the client needs to do an on the wire SETATTR call to set the
atime in this case, even though it has a delegation, or else the ctime
won't end up being correct.

The new delegated attributes don't give us a way to tell the server to
only update the ctime and not the mtime, unfortunately, which is what
we'd need to do to handle utimensat() properly.

---------------------------------8<---------------------------------
generic/751:

This one seems fairly straightforward. The client does a REMOVEXATTR
while holding an attribute delegation, and the ctime isn't updated.

The REMOVEXATTR compound doesn't contain a GETATTR, so the client
doesn't update its timestamps after issuing one. The SETXATTR compound
does contain one, so it seems like one probably just needs to be added
to REMOVEXATTR:

No.	Time	Source	Destination	Protocol	Length	Info
35	09:45:20.287193	192.168.122.158	192.168.122.129	NFS	362	V4 Call (Reply I=
n 36) OPEN DH: 0x60a9c780/testfile
36	09:45:20.292964	192.168.122.129	192.168.122.158	NFS	506	V4 Reply (Call I=
n 35) OPEN StateID: 0xafa9
38	09:45:22.387717	192.168.122.158	192.168.122.129	NFS	290	V4 Call (Reply I=
n 39) SETXATTR
39	09:45:22.390218	192.168.122.129	192.168.122.158	NFS	250	V4 Reply (Call I=
n 38) SETXATTR
41	09:45:24.518285	192.168.122.158	192.168.122.129	NFS	262	V4 Call (Reply I=
n 42) REMOVEXATTR
42	09:45:24.520337	192.168.122.129	192.168.122.158	NFS	186	V4 Reply (Call I=
n 41) REMOVEXATTR
44	09:45:44.550896	192.168.122.158	192.168.122.129	NFS	194	V4 Call (Reply I=
n 45) SEQUENCE
45	09:45:44.551913	192.168.122.129	192.168.122.158	NFS	150	V4 Reply (Call I=
n 44) SEQUENCE
46	09:45:44.552221	192.168.122.158	192.168.122.129	NFS	346	V4 Call (Reply I=
n 51) SETATTR FH: 0x559aaf9c | DELEGRETURN StateID: 0x33d9
48	09:45:44.553823	192.168.122.158	192.168.122.129	NFS	346	V4 Call (Reply I=
n 50) SETATTR FH: 0xc275dd69 | DELEGRETURN StateID: 0x674c

Alternately, I guess we could mark the attributes as bogus after a REMOVEXA=
TTR. It looks like without delegated timestamps, the client does an on-the-=
wire GETATTR after the REMOVEXATTR:

No.	Time	Source	Destination	Protocol	Length	Info
197	09:58:19.129157	192.168.122.158	192.168.122.129	NFS	362	V4 Call (Reply =
In 198) OPEN DH: 0x60a9c780/testfile
198	09:58:19.133943	192.168.122.129	192.168.122.158	NFS	506	V4 Reply (Call =
In 197) OPEN StateID: 0xafa9
199	09:58:19.135941	192.168.122.158	192.168.122.129	NFS	306	V4 Call (Reply =
In 200) SETATTR FH: 0xb007cc80
200	09:58:19.138457	192.168.122.129	192.168.122.158	NFS	294	V4 Reply (Call =
In 199) SETATTR
202	09:58:21.233187	192.168.122.158	192.168.122.129	NFS	290	V4 Call (Reply =
In 203) SETXATTR
203	09:58:21.235414	192.168.122.129	192.168.122.158	NFS	250	V4 Reply (Call =
In 202) SETXATTR
205	09:58:23.367791	192.168.122.158	192.168.122.129	NFS	262	V4 Call (Reply =
In 206) REMOVEXATTR
206	09:58:23.369903	192.168.122.129	192.168.122.158	NFS	186	V4 Reply (Call =
In 205) REMOVEXATTR
208	09:58:23.406309	192.168.122.158	192.168.122.129	NFS	262	V4 Call (Reply =
In 209) GETATTR FH: 0xb007cc80
209	09:58:23.407822	192.168.122.129	192.168.122.158	NFS	266	V4 Reply (Call =
In 208) GETATTR
211	09:58:42.791073	192.168.122.158	192.168.122.129	NFS	194	V4 Call (Reply =
In 212) SEQUENCE
212	09:58:42.792068	192.168.122.129	192.168.122.158	NFS	150	V4 Reply (Call =
In 211) SEQUENCE
213	09:58:42.792464	192.168.122.158	192.168.122.129	NFS	282	V4 Call (Reply =
In 215) DELEGRETURN StateID: 0x2cd6
215	09:58:42.794509	192.168.122.129	192.168.122.158	NFS	230	V4 Reply (Call =
In 213) DELEGRETURN
217	09:59:03.270925	192.168.122.158	192.168.122.129	NFS	194	V4 Call (Reply =
In 218) SEQUENCE
218	09:59:03.272006	192.168.122.129	192.168.122.158	NFS	150	V4 Reply (Call =
In 217) SEQUENCE
220	09:59:03.273179	192.168.122.158	192.168.122.129	NFS	282	V4 Call (Reply =
In 221) DELEGRETURN StateID: 0xbbe2
221	09:59:03.275087	192.168.122.129	192.168.122.158	NFS	230	V4 Reply (Call =
In 220) DELEGRETURN

--=20
Jeff Layton <jlayton@kernel.org>

--=-9xJUHj90FIG7HNIG3y2P
Content-Type: application/x-pcapng; name="nfs-generic221.pcapng.gz"
Content-Disposition: attachment; filename="nfs-generic221.pcapng.gz"
Content-Transfer-Encoding: base64

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


--=-9xJUHj90FIG7HNIG3y2P--

