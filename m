Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464022E9D7F
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Jan 2021 19:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbhADSyn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Jan 2021 13:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADSyn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Jan 2021 13:54:43 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06637C061574
        for <linux-nfs@vger.kernel.org>; Mon,  4 Jan 2021 10:54:02 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id h22so66889256lfu.2
        for <linux-nfs@vger.kernel.org>; Mon, 04 Jan 2021 10:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2iFXH1gqrXOP5ITcjpRYN/mIpTDzywpH+4/SghJriU0=;
        b=F0xPvCpvNa21VCHrEHMvQ0f1AIjhzHtEFvdOZxM4Wlktz3LI0usVeZBW0ItPWGeyPu
         pcI2n+1Nnqf3JK9m9ViNyjP7H0wm7LYxsaRZPBYlalx3I1FOR4hCq/9Ti2QWpeB7xFVs
         zhZ/nm6lga98RCuphWX8uwKD1ASht67D1dPL8yvDz8C7bJLA7SoTw0z60Qlnbjd+NSUM
         g3x4kGagmwX9Z5bUVS/emjKSZF/XpcXPusq/K33yqjImtOwQcTOCcvMldfMBg+KvpG3U
         CmPtAzOWw9WjPPZ0rr8JDS8Mdd+NOAsc60+zUUWG9HBpBlCtl/uQ2sAOdnfaohYlza3V
         07vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2iFXH1gqrXOP5ITcjpRYN/mIpTDzywpH+4/SghJriU0=;
        b=nNIvshTVJHWQWjb56P45sxYwnegOm0S6xSJ4WsSEZTNbTBzzhJG7f7BXWQfSoT70Oj
         cnGFYMfhTs8IeTgiBKdydUJqFSLAizYsZOUeuC1irGWetBrGB/qXw/MTcP9xcPt4Mole
         MyU6jIRccY1H6SyUk/ehf3Of1HmOBeyWhSDyZZjwayGLoV1Cb/H0ZxqSKBEpdT91no4z
         pIHWBIup36Kt4oFsb7EjYSm8LfgQ0e2HiLA3/1gWp7ckQSP5nyMZB4BtmieK1JQxBrMq
         +C8bUuw54fJylbwqGmcv1xV14zdtSCnaXJOpXLTHagdOzroaGHpgKoqFCwoUuSCMzbx2
         MFbA==
X-Gm-Message-State: AOAM532AbHZ8uq3LSZPT0d9UrARJqUVaKg8FCsgMb2uez/fZxaQpvcno
        KJjdJ82QEqzc4TGGvl/91Ucjl/kfh8HpBX0OFhwz7iXxhvA=
X-Google-Smtp-Source: ABdhPJxYtxUGNOs4eZ+mVXZbhK1zNo2HnqFirnOKpnyjJXK0ZUmVZRWndBuLXIW6u2R2ihc46uaV005vyjD2wDVGwzs=
X-Received: by 2002:a19:8053:: with SMTP id b80mr35062569lfd.74.1609786441511;
 Mon, 04 Jan 2021 10:54:01 -0800 (PST)
MIME-Version: 1.0
References: <CAL5u83HS=nurJ=r0tJU8ZqAXXkvu9-vWZpbVWoKALNh22WdKnw@mail.gmail.com>
 <87F51982-465A-46D4-BFB9-4B5E5A7EB82C@oracle.com> <CAL5u83FRJQ_ys32S1KWjx72kamNw_3a2eFEAwH=MNMhruU9X=g@mail.gmail.com>
 <6F313888-0355-4286-8692-E4685BCB2536@oracle.com> <CAL5u83Fxd2rGuYuaghcC4irUtscmXr5-p36Qqf4+FwtctZJFaQ@mail.gmail.com>
 <07383012-D499-498E-A194-716ABE1DE4C2@oracle.com> <CAL5u83FRV_-sae4cXLN3VqFe_=3wXm5g911LFjzohCp+c+55aQ@mail.gmail.com>
 <A5C09F1B-9309-40AC-99E6-BADA5CAD6CED@oracle.com>
In-Reply-To: <A5C09F1B-9309-40AC-99E6-BADA5CAD6CED@oracle.com>
From:   Hackintosh Five <hackintoshfive@gmail.com>
Date:   Mon, 4 Jan 2021 18:53:50 +0000
Message-ID: <CAL5u83EsMkuLLRqN+VznAvgxKQQBFEjqzr=jS+G6sRd8Ea3dFQ@mail.gmail.com>
Subject: Re: Boot time improvement with systemd and nfs-utils
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The issue isn't with the forking type, that's certainly correct (since
it does indeed fork). The problem is that systemd is putting a
dependency between nfs-client (required by multi-user.target) and
rpc-statd-notify (which requires network-online), resulting in gdm
waiting for network-online. The only workaround I was able to make
work was to create a new timer unit which simply launches sm-notify
after 1 second. nfs-client can start the timer unit, which then
*asynchronously* starts sm-notify, meaning that sm-notify gets to keep
its dependency on network-online. Patch with that method will be sent
in a moment (if git send-email decides to work)



On Mon, Jan 4, 2021 at 6:00 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> I'm not aware of a similar reason why the notify step would need to
> block the boot process. Maybe Type=3Dforking is wrong, but I thought
> sm-notify was a forking/daemonizing type of utility.
>
>
> > On Jan 4, 2021, at 11:03 AM, Hackintosh Five <hackintoshfive@gmail.com>=
 wrote:
> >
> > I see. Does rpc-statd-notify HAVE to start before nfs-client? If not,
> > perhaps a one-off timer unit with no delay could be made so that the
> > startup of rpc-statd-notify doesn't block the boot process, while
> > still running after network-online?
> >
> > On Mon, Jan 4, 2021 at 1:26 PM Chuck Lever <chuck.lever@oracle.com> wro=
te:
> >>
> >> The problem is not in sm-notify itself, it's in the C library function=
s. The system's DNS resolver configuration is set during network startup. W=
hen a process first attempts a DNS query, it retrieves the system DNS confi=
guration as it is at that moment, and keeps that configuration until the pr=
ocess exits. If sm-notify starts before the system's DNS resolver is config=
ured, then it simply doesn't work because it can't perform DNS queries corr=
ectly.
>
>
> --
> Chuck Lever
>
>
>
