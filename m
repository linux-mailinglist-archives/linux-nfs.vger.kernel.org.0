Return-Path: <linux-nfs+bounces-14798-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40573BACB12
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 13:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAFA3BDA4B
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Sep 2025 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AC2257848;
	Tue, 30 Sep 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+qidfTH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5120734BA3B
	for <linux-nfs@vger.kernel.org>; Tue, 30 Sep 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759232048; cv=none; b=D/ESxu6iFPpn9JBp8424T2DnLIZd1LEbhhA0vgBsUz34VRGuk4DoYxcATsaDywLSnTVlI2lBhsaaQFeZMFPh4kaLXl31jPGHT/ObmZhrWiKRk5yi7laBptV4hFkx8AASSxExN/wKEbpyWVomckrC55LqaQ9+L76GqlY3C2Q7pMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759232048; c=relaxed/simple;
	bh=M7iLt987p8BD0IMEUxaTCdjzDBrzfTCoxOAQSHm0Kko=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lpO0inek+rycHfF5Be/uYUkh4mQZ6XAp6u7V3XeyfX4SaMsZvilwrDSGxj3iBdLWWnciBBU2mynvoY3b6Jur/Y7ThmvjUGf6pvUWdz/JuJZpMZA1PfOu4AT6S8Nr4VhL5KbSkZSVUh6Q2GgBmZRWaoxNcyxae/VKeMm22iYTpRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+qidfTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE23C4CEF0;
	Tue, 30 Sep 2025 11:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759232045;
	bh=M7iLt987p8BD0IMEUxaTCdjzDBrzfTCoxOAQSHm0Kko=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U+qidfTHG6TZ03eP3/UqWSTDBRcWpym843FdnNZAsRKHIiyG0ZRCCohYlKzD17gYa
	 7awJ78QuWCpWqgHrnG6A2f62tdBjMl4g8ANkNyz/oSwF62kRk6NUYTOmSOqzEbmsmS
	 PautDv+4DgJrjDJ5DI+qSsx3e5pFb0cJOKww6zbEsmk59DOSh2K+ikZnpjip0s6QtE
	 Im268Tt+Lqu1hbrUUp1FkqsACNyqPaLDbXdhyeKszA2s8sAzE7YneAtv2iZRpXGMAi
	 2uaFDk5M+8Yc/OjUwYetSOwwotKN/2SU+Md2peg0s/hO5Be+ja4I3MGgoeMX5XMvUC
	 77AK5n9habTnA==
Message-ID: <6f5ef72c1a8c222d4d1263e23d8239ad510bc46a.camel@kernel.org>
Subject: Re: [PATCH] Add some tests for unsupported fattr4 attributes
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Calum Mackay <calum.mackay@oracle.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date: Tue, 30 Sep 2025 07:34:04 -0400
In-Reply-To: <20250929201622.37884-1-cel@kernel.org>
References: <20250929201622.37884-1-cel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-29 at 16:16 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Linux NFSD does not implement a handful of these NFSv4.0 fattr4
> attributes. Ensure that NFSD's fattr4 result encoder is correctly
> clearing the result mask and returning NFS4_OK.
>=20
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  nfs4.0/servertests/st_getattr.py | 149 +++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>=20
> diff --git a/nfs4.0/servertests/st_getattr.py b/nfs4.0/servertests/st_get=
attr.py
> index 1c47ebf60571..d423aa1df46d 100644
> --- a/nfs4.0/servertests/st_getattr.py
> +++ b/nfs4.0/servertests/st_getattr.py
> @@ -521,6 +521,155 @@ def testOwnerName(t, env):
>          t.fail_support("owner not a supported attribute")
>      # print(res.resarray[-1].obj_attributes)
> =20
> +def testArchive(t, env):
> +    """GETATTR on "archive" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11a
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_ARCHIVE])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(archive)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("archive not a supported attribute")
> +
> +def testHidden(t, env):
> +    """GETATTR on "hidden" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11b
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_HIDDEN])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(hidden)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("hidden not a supported attribute")
> +
> +def testMimetype(t, env):
> +    """GETATTR on "mimetype" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11c
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_MIMETYPE])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(mimetype)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("mimetype not a supported attribute")
> +
> +def testQuotaAvailHard(t, env):
> +    """GETATTR on "quota avail hard" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11d
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_QUOTA_AVAIL_HARD])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_avail_hard=
)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("quota_avail_hard not a supported attribute")
> +
> +def testQuotaAvailSoft(t, env):
> +    """GETATTR on "quota avail soft" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11e
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_QUOTA_AVAIL_SOFT])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_avail_soft=
)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("quota_avail_soft not a supported attribute")
> +
> +def testQuotaUsed(t, env):
> +    """GETATTR on "quota used" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11f
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_QUOTA_USED])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(quota_used)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("quota_used not a supported attribute")
> +
> +def testSystem(t, env):
> +    """GETATTR on "system" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11g
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_SYSTEM])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(system)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("system not a supported attribute")
> +
> +def testTimeBackup(t, env):
> +    """GETATTR on "time backup" attribute
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11h
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_TIME_BACKUP])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4_OK, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_backup)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("time_backup not a supported attribute")
> +
> +def testTimeAccessSet(t, env):
> +    """GETATTR on "time access set" attribute (write-only)
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11i
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_TIME_ACCESS_SET])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_acces=
s_set)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("time_access_set not a supported attribute")
> +
> +def testTimeModifySet(t, env):
> +    """GETATTR on "time modify set" attribute (write-only)
> +
> +    FLAGS: getattr all
> +    DEPEND: LOOKFILE
> +    CODE: GATT11j
> +    """
> +    c =3D env.c1
> +    ops =3D c.use_obj(env.opts.usefile)
> +    ops +=3D [c.getattr([FATTR4_TIME_MODIFY_SET])]
> +    res =3D c.compound(ops)
> +    check(res, [NFS4ERR_INVAL, NFS4ERR_ATTRNOTSUPP], "GETATTR(time_modif=
y_set)")
> +    if res.status =3D=3D NFS4ERR_ATTRNOTSUPP:
> +        t.fail_support("time_modify_set not a supported attribute")
> =20
>  ####################################################
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>

