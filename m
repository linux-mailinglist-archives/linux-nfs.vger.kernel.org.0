Return-Path: <linux-nfs+bounces-5889-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE19633DA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6E411F2195D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 21:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16B1ACE10;
	Wed, 28 Aug 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="D5PUrbuQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA91AC8A9
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880551; cv=none; b=Tn6kwvyzncuCln2UCfc56DkptFq08loT3fhOaNBkyB6VkqPt/uroZ2zNi1zEKyqyp+2WeaF9FrfHtuiC+d6onEFv8zI2cTpCJnfp9UHvjEYfZtPb00++8AZ0OoD/x1wer0wewQwHHbg6opnedY4nSffurnQ5GSuA+N5WHuKp9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880551; c=relaxed/simple;
	bh=CPlhz09WBYdUrOP0HsAmb99X4pGZevIStEZ9mkNk0bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYvshmH5Qs4EV9dhvwk4x4ObRgN7+JYoDGdXMh27kvUrPqsl3mjRwjj+LxJGryGphvFB380WA58EyA/TB+5zsvkqs2QPoUD6s1AU//KC3bqUGLiznpO83bo2cx2+3fyI9Zugy1dn0As+2jyUvc6Si2GiC07L5+0XLbRHFQom2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=D5PUrbuQ; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724880541; bh=uwzy6q6gMEU7xm9N/z0y8nG8Cq40ddWaiQkG9koMAv8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=D5PUrbuQr4oqzXLSgz/H9aoCUNOyw+Amp6eVsaa/tPy7FfTTyR1kmCg1Fz2GwrkKS8+3wRKoKzKpEPWpEZnX6ap0Iz04Kfu32Tj0zorS9+MSMENdLmdbAeERFLYznhvdt0lSnNCE31HMWy0C8VPx73tKXdsHvsA6x+ThEWVe0FEzUEv8twdeMUuDrPF6bMPzQSt68gavOsTvQUBCmYy07O8GHkEWUaqFB/naShKxTi6uWQXigJMo6CVxhuyWMb02/tf69iOC7O9erxUUaLQ2tbGwVXJfQ3v8FivUZc6Nsyz3EDlaS0hyGPoVxiQUvGk20RHZvisMUkcERtpM4w1k4Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1724880541; bh=yy8oaGZjePWIJRxe7/4PsznPBAcoJLwu9ao4d6Td2Y7=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PE1NVcj6CC5enJyql/QLekEmQJwVlDaKereG5fLsd9eop6fpTU0h6o+J6e7hx8gcqfmqA6tUHIwvhz5dqwUBEg77KFX6GCO8ol+Qh07Y8T2yPTEwF743lrP4/SSQtqo0zwh6gaoaMxOzwQn9hRQAQ7DpHxHWztOHT3l8UMNnRjBS+wF3zl+eUrUpbBNLZmNNLqaTQx2GQYD3kHT8r+6pYjy074dCuMgC5OYOxbwW1hK0cYAO7RGN9GKYEREPu4QDEx9BdOMNpnPzbx/mIqRejtJyLzJ5M9JbxuApwWH+qCN5gZhddreM+vTWvrTJ34ZWF9i1fsdAVvAoEXocD6SXvg==
X-YMail-OSG: Mql5tMYVM1n8LSXLbDnoAkV3AiWok7BlewOMUs57jKrxT5fNvBcrbsDfH6EL0VW
 VG5WPjwrJyQRXc4KxxpGQ.uzM8BK3FAhL5ZLgNrsTWtOl0oYe05q7jwK.BzgWQaIsEh.SBTpwjHt
 _JySUHYyEwJCKBw1Ame3tsKQnfb7r53mC5gfzl4PE.s8VX1RLQhUnHPPkQFjZ7IISIsEZopOyvLJ
 vroShUd5vZm7kU6mYBuPByZx1XwagPdCaAzYkZSu3KbhCJ8BBVyE4Zx6ESAGCwhObuzj_oHzUZnd
 pXxDM.4o58u3KJAhpXmIHKZe1mGa3FMzUDWwdhdhZruylfgWysDj0X5LIlEc4xGp3GdAoU5kr3X9
 Fl0iWxq_tEaocOwKZBaFJQxyiMUELMAx0E_GwCNfy3eYzi_WdEOW2RXrJheh9OVwKui178Z_s1t6
 X4HLyuWXGWCQGS61Pkh.5ZBz3RDs7o4mKsFADyZw_LORrwxN5cE4OchXTRJ6Eo.38QVkWMXiRMLt
 GqfVlNUVZHl9hLHyNsvpss4ljA0kYvgn60O7pNktUhmFyqSH.S83T36ju8_WX.v0JYh3_4D82e4.
 5WNMgb0kJX3.ALzKF6QgaiOauoBKvHYq06fHW5iiVbSh11zbhncKKNGiSejj7E3dEiWCvGMG1lTM
 iIjBtsKzrcST8kwzcdm6EzYS3ojhCLAfsATDFgg02Tt8CBVqOJLTKQlKQO3kHAcPhlEpORxENeQG
 NIx4qDTnkDOVzJrBjTzt09d_IVD3GnJhnSCPSwUDp_PMBiqiHGr09541X.ThYR02GqhePT7ne4NQ
 uR.w51ellEJXuZj_JqmFRUQVu3lGO8d8acy039OmzHQnHLFrEPGfpnY_Ka8jg8Jne6Ot91lKgi0v
 H_VVrNozxnsoshL3d1cBKowIugo56_juSXTOYlFS_omZ4a8DZm3MEkT.z_skXwK4zUwEWABMEtrH
 c73vVj8KeeruqFs3ScOkP7Ek3fLoegtSSI6b5MKT4_m8XzfEDGxUTk55b0joPSVxdNvsYnODvMQL
 TNe0mYVrpGwBQhGLVHzGjj6TmKp_KU6Y40Pl4dSvah5cl4uVvlHhv2b1QvxgMVrPA66t8bV1oaiL
 aqjbDC6LSNvVnbVVScU1HVAuAzWQq_ADw0MAOGGka6WmJ.2Hd.hvGI1PX_lY3QRJoXPjcAY1Nt5a
 hDeQ8ImlUJ52ITtzF4Slf_fgFxzKnessdbat_OTfzHmZeY.e5sVDCLsB19WKX6otzb9we1.t71BY
 QZ49YdoFSPPTZzfWGPFmS0XcOA2XBOVVP2XNzYLetoE4SZbnd0X0mnwaoRoJ8i3qRKRTJulhtP9U
 XiBy_oayrmH3jkwgup58FaWk8u4rG02sN.RDgyu34j3Q.kVNwoA16c.7M8tO1nvHN66YpLTcSDLf
 ARUTNMwXF3fMeEuAbb4SuRYmAwg1WMFABblLcUp4Pf7stBWHnlHJj4fOraxPAR6t30U_xbi2kIMA
 BuF1S6qKv1t7lgLa.IZKl3yI52PXk_Srx4MtdNGnTd7yhvG7YWEpZ0OFUfnGjLXmcz4Z6.q5mUYu
 aFN2FhliPwTDaJnEWyXaT8E2rXLlrqZpaSnXiW4TobiSeqwPlcl284vQ5.KQ8IuK8TXxpD2RblO5
 gDvoWFTEfNUXo3hmdjziLuG6nIeHgTchID6Yux3FMwB4Du7uZlxcr.Fzm4uBaYSuQ_YDDK1d2ud8
 ak1UdUo0ibMYbvh8f_5R9o9nSiHYmpQHHG9XDiFAj48Eju4nvaEMlP2xzOKFFFz.s3P1.dfo9AE2
 i4H9K04uZCpymctINwS6FeWHkv5kW6z2iPGtJxmEE8tJr3SA9ilvBbdPZeoXjvyvIUFBraqEqKFl
 IOZqem_bPN8Z79t4is5dD3NwAIB2.rwLqS3lcn3kF4OhXk5GhwqeeQpFBivyxvroo_8VrINi6.KL
 hmKmL_6RG1yCxxwaB2vmzvTReDhcdao2Cq6Ob8hJMBtASh0ECer4wBzi9q3iwfsw7Zr_Lx0Aaz7i
 gsLARlMGwJK0WMI7d9KGQM27EsbswuLtXirxRW3GlZRyRDJN4zv8zGMGbP6JmnIUwtYk55H9fAYb
 1aUM9m7iYK68LaeEVl1qUViWG0_t75qjP2LcDJNXwOhbVP55juvsUhNoAQLZEL1K_MQFRt3wUQy1
 9imkhcj5xdZN.4retGV9myDD0_m.mb8HTKtw98l7nPMTEL1WglDK3BGK9oECYaczyr5ouPiO4pY9
 bM9EMffiR3WcYE8HIN2eoD0q2.i609v63AF0cdzfHsQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b689ae5e-236a-44cd-94fb-3435ac3e75b0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 28 Aug 2024 21:29:01 +0000
Received: by hermes--production-gq1-5d95dc458-6q8w6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 09ed5b280ca4a493a552bc3d75462550;
          Wed, 28 Aug 2024 21:28:59 +0000 (UTC)
Message-ID: <70639b16-d48c-4465-80f5-4192c9d86b36@schaufler-ca.com>
Date: Wed, 28 Aug 2024 14:28:51 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] selinux,smack: don't bypass permissions check in
 inode_setsecctx hook
To: Paul Moore <paul@paul-moore.com>, Scott Mayhew <smayhew@redhat.com>
Cc: stephen.smalley.work@gmail.com, chuck.lever@oracle.com,
 marek.gresko@protonmail.com, selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240828195129.223395-1-smayhew@redhat.com>
 <20240828195129.223395-2-smayhew@redhat.com>
 <CAHC9VhTCpm0=QrvBq_rHaRXNqu7iRcW7kqxjL8Jq9g=ZypfzsQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTCpm0=QrvBq_rHaRXNqu7iRcW7kqxjL8Jq9g=ZypfzsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 8/28/2024 2:05 PM, Paul Moore wrote:
> On Wed, Aug 28, 2024 at 3:51 PM Scott Mayhew <smayhew@redhat.com> wrote:
>> Marek Gresko reports that the root user on an NFS client is able to
>> change the security labels on files on an NFS filesystem that is
>> exported with root squashing enabled.
>>
>> The end of the kerneldoc comment for __vfs_setxattr_noperm() states:
>>
>>  *  This function requires the caller to lock the inode's i_mutex before it
>>  *  is executed. It also assumes that the caller will make the appropriate
>>  *  permission checks.
>>
>> nfsd_setattr() does do permissions checking via fh_verify() and
>> nfsd_permission(), but those don't do all the same permissions checks
>> that are done by security_inode_setxattr() and its related LSM hooks do.
>>
>> Since nfsd_setattr() is the only consumer of security_inode_setsecctx(),
>> simplest solution appears to be to replace the call to
>> __vfs_setxattr_noperm() with a call to __vfs_setxattr_locked().  This
>> fixes the above issue and has the added benefit of causing nfsd to
>> recall conflicting delegations on a file when a client tries to change
>> its security label.
>>
>> Reported-by: Marek Gresko <marek.gresko@protonmail.com>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218809
>> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
>> ---
>>  security/selinux/hooks.c   | 4 ++--
>>  security/smack/smack_lsm.c | 4 ++--
>>  2 files changed, 4 insertions(+), 4 deletions(-)
> Thanks Scott, this looks good to me, but since it touches Smack too
> I'd also like to get Casey's ACK on this patch;

Testing labeled NFS has always been a challenge for the somewhat
limited resources available to the Smack project. I'll Ack the patch,
but won't claim to have tested it.

>  if for some reason we
> don't hear from Casey after a bit I'll go ahead and merge it.
> Speaking of merging, since this touches both SELinux and Smack I'll
> likely pull this in via the LSM tree, with a marking for the stable
> kernels, if anyone has any objections to that please let me know.
>

