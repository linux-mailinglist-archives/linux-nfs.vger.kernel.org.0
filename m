Return-Path: <linux-nfs+bounces-11913-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB90AC41E5
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 16:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6965189811C
	for <lists+linux-nfs@lfdr.de>; Mon, 26 May 2025 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFC6F2F2;
	Mon, 26 May 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCUBzLTa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9210828373
	for <linux-nfs@vger.kernel.org>; Mon, 26 May 2025 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748271335; cv=none; b=rrUhHmp2gvj74UqNdxweDJer+0JRFrZRpetEuVhH8ShlA6bDfDxmzDMfilHIm8mEMFPEr3o/N2Uu4SnLwCVRFm03B4h+nrwQHRMhzeUQaWCvQf6sqPgv3AIkvceIC+aHaVwQn6FXNGPr+jI+J/3t8OwpNaf5SI/UmWuRElCsQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748271335; c=relaxed/simple;
	bh=sBUbIJSlMS6QyIj/JhMZL5DC9wjpx0QvOu0usd6p70o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WXceLoCexIe+4My78PMyXptInqGlDxRb9MEpZrzTFUl2M2FetZwrFpHn6nbbY1FDn8Lq7gzJmFSD+ZZYQ1v/AAKkrkVQKLB+BOXOBa1UWwRz+cZy/P4ydT8JBCTdvyZJb/U6MoDwmZOdotuidmv+frcuQbK4ydk4miR0zMS2bYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCUBzLTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA86C4CEE7;
	Mon, 26 May 2025 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748271335;
	bh=sBUbIJSlMS6QyIj/JhMZL5DC9wjpx0QvOu0usd6p70o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=YCUBzLTaUtkQirbawAEPK22h7cJGoPoHtL1NY8cdOcs9JIWPYYkE/lXcBPx6xYYk8
	 NO6yjiSpJjqlrO/iqk8I/rgAEWHaFnlGEScfhutElCsabDJ/BUW0LQdPYlwGb4ecVF
	 UJjyTw1HJl9kFMcBzdZwTVCzkbZgZe59iOkb71+Y54MoOO2P7ke1hL0TDkewZRYAC/
	 VLTFCa6cMIDOAUQMmE05ttI7xa97xHeAFi0VtRRPLeCLisURA30vv5DjyyZtJQbdw7
	 MOstzAibdUzyKj5TFGdrYUaLURRG6My7GSLhiJVUByR5T4Yz0Wn8PYDqhfjA2lWIoG
	 dPQDLTYNQjFwg==
Message-ID: <745554aad3cce0a1c463ff0fc0e80028ba61803d.camel@kernel.org>
Subject: Re: Questions Regarding Delegation Claim Behavior
From: Jeff Layton <jlayton@kernel.org>
To: Petro Pavlov <petro.pavlov@vastdata.com>, Chuck Lever
	 <chuck.lever@oracle.com>
Cc: Roi Azarzar <roi.azarzar@vastdata.com>, linux-nfs@vger.kernel.org
Date: Mon, 26 May 2025 10:55:33 -0400
In-Reply-To: <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
References: 
	<CAN5pLa6EU6nKe=qt+QijK1OMyt8JjHBC2VCk=NMMSA4SJmS4rg@mail.gmail.com>
	 <2529724b-ad96-4b02-9d8e-647ef21eab03@oracle.com>
	 <CAN5pLa4z-v9MSwZCxbW6oMy1Fa=b9GFEwmVxdDTnguO6_9-f_g@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-26 at 14:10 +0300, Petro Pavlov wrote:
> Hello Chuck,
> Thank you for your response, and apologies for the confusion regarding th=
e kernel version =E2=80=94 the correct version is 6.15.0-rc3+ (I believe it=
's from the branch you gave us). Regarding the client, I'm using hand-writt=
en tests based on pynfs.
> I believe the following section of the RFC may be relevant to the use of =
a delegation stateid in relation to the file being accessed:
> > If the stateid type is not valid for the context in which the stateid a=
ppears, return NFS4ERR_BAD_STATEID. Note that a stateid may be valid in gen=
eral, as would be reported by the TEST_STATEID operation, but be invalid fo=
r a particular operation, as, for example, when a stateid that doesn't repr=
esent byte-range locks is passed to the non-from_open case of LOCK or to LO=
CKU, or when a stateid that does not represent an open is passed to CLOSE o=
r OPEN_DOWNGRADE. In such cases, the server MUST return NFS4ERR_BAD_STATEID=
.
>=20
> I did some further investigation and identified another scenario that see=
ms problematic:
> =C2=A0=C2=A0=C2=A01.=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Client1 creates file1 without a deleg=
ation, with read-write access. It writes some data, changes the file mode t=
o 444, and then closes the file.
> =C2=A0=C2=A0=C2=A02.=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Client2 opens file1 with read access,=
 receives a read delegation (deleg1), and closes the file without returning=
 the delegation.
> =C2=A0=C2=A0=C2=A03.=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Client2 then creates file2 with read-=
write access, receives a write delegation (deleg2), and leaves the file ope=
n (delegation is not returned).
> =C2=A0=C2=A0=C2=A04.=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Client2 tries to open file1 with writ=
e access and receives an ACCESS_DENIED error (expected).
> =C2=A0=C2=A0=C2=A05. Next, Client2 attempts to open=C2=A0file1=C2=A0 with=
 write access using CLAIM_DELEGATE_CUR, providing the stateid from=C2=A0del=
eg2=C2=A0 (which was issued for=C2=A0file2) =E2=80=94 unexpectedly, the ope=
ration succeeds.
> =C2=A0=C2=A0=C2=A06.=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Client2 proceeds to write to file1, a=
nd it also succeeds =E2=80=94 despite the file being set to 444, where no w=
rite access should be allowed.
> This behavior seems incorrect, as I would expect the write operation to f=
ail due to file permissions.
> Please see the attached PCAP file for reference.
> Best regards,
> Petro Pavlov
>=20

Yeah, that does seem like a bug. Mostly, the server treats
CLAIM_DELEGATE_CUR and CLAIM_NULL identically. We have this in
do_open_lookup() though:

        if (open->op_created ||                                            =
                        =20
                        open->op_claim_type =3D=3D NFS4_OPEN_CLAIM_DELEGATE=
_CUR)                       =20
                accmode |=3D NFSD_MAY_OWNER_OVERRIDE;                      =
                          =20
        status =3D do_open_permission(rqstp, *resfh, open, accmode);       =
                          =20
        set_change_info(&open->op_cinfo, current_fh);                      =
                        =20

...and that effectively bypasses the permission check in this case.
Maybe we should add a fh check there?

I'm not sure why CLAIM_DELEGATE_CUR wasn't deprecated when
CLAIM_DELEGATE_CUR_FH was added to the spec. Is there some use case
where CUR is necessary instead of CUR_FH?


> On Fri, May 23, 2025 at 5:41=E2=80=AFPM Chuck Lever <chuck.lever@oracle.c=
om> wrote:
> > On 5/22/25 11:51 AM, Petro Pavlov wrote:
> > > Hello,
> > >=20
> > > My name is Petro Pavlov, I'm a developer at VAST.
> > >=20
> > > I have a few questions about the delegation claim behavior observed i=
n
> > > the Linux kernel version 3.10.0-1160.118.1.el7.x86_64.
> > >=20
> > > I=E2=80=99ve written the following test case:
> > >=20
> > > =C2=A0 1. Client1 opens *file1* with a write delegation; the server g=
rants
> > > =C2=A0 =C2=A0 =C2=A0both the open and delegation (*delegation1*).
> >=20
> > Since you mention a write delegation, I'll assume you are using Linux
> > as an NFS client, and the server is not Linux, since that kernel versio=
n
> > does not implement server-side write delegation.
> >=20
> >=20
> > > =C2=A0 2. Client1 closes the open but does not return the delegation.
> > > =C2=A0 3. Client2 opens *file2* and also receives a write delegation
> > > =C2=A0 =C2=A0 =C2=A0(*delegation2*).
> > > =C2=A0 4. Client1 then issues an open request with CLAIM_DELEGATE_CUR=
,
> > > =C2=A0 =C2=A0 =C2=A0providing the filename from step 3 *(file2*), but=
 using the
> > > =C2=A0 =C2=A0 =C2=A0delegation stateid from step 1 (*delegation1*).
> >=20
> > Would that be a client bug?
> >=20
> >=20
> > > =C2=A0 5. The server begins a recall of *delegation2*, treating the r=
equest in
> > > =C2=A0 =C2=A0 =C2=A0step 4 as a normal open rather than returning a B=
AD_STATEID error.
> >=20
> > That seems OK to me. The server has correctly noticed that the
> > client is opening file2, and delegation2 is associated with a
> > previous open of file2.
> >=20
> > A better place to seek an authoritative answer might be RFC 8881.
> >=20
> > The server returns BAD_STATEID if the stateid doesn't pass various
> > checks as outlined in Section 8.2. I don't see any text requiring the
> > server to report BAD_STATEID if delegate_stateid does not match the
> > component4 on a DELEGATE_CUR OPEN -- in fact, Table 19 says that
> > DELEGATE_CUR considers only the current file handle (the parent
> > directory) and the component4 argument.
> >=20
> >=20
> > > My understanding is that the server should have verified whether the
> > > delegation stateid provided actually belongs to the file being opened=
.
> > > Since it does not, I expected the server to return a BAD_STATEID erro=
r
> > > instead of proceeding with a standard open.
> > >=20
> > > From additional tests, it seems the server only checks whether the
> > > delegation stateid is valid (i.e., whether it was ever granted), but
> > > does not verify that it is associated with the correct file or client=
.
> > > Please see the attached PCAP for reference.
> > >=20
> > > Questions:
> > >=20
> > > Is this behavior considered a bug?
> > >=20
> > > Are there any known plans to address or fix this issue in future kern=
el
> > > versions?
> >=20
> > AFAICT at the moment, NOTABUG
> >=20
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

