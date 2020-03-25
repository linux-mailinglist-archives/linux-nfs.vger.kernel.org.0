Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C7192DD8
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 17:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgCYQJs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 12:09:48 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:35761 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgCYQJs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 12:09:48 -0400
Received: by mail-wm1-f50.google.com with SMTP id m3so3393166wmi.0
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2020 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3YyngCDtHoeyOl2D3NWmERu7ZyhAVN/hTrtg2IeA1OA=;
        b=nnExzdsFQe0iublXyFy2a9PmJZ4uS6XFpp9FbFP2vSrJqt2CcZMm0rINITlx8BjRyw
         yL5jMn+4uowAXAUq3AlnN4yaGySmvRcELZBLDUCnT6NJiH61FZMfwecKuQ4GDCdN+y5m
         hKWbBxwpT2pNp2MSwbTYUOz6L84MwKdY1V+ZlaBw+c5KN3G263o3/Yv+acoMXL3VCjlW
         9L207RZkXKxqfSLmEOdLXlLc3YLc4/CDc1RZAo26v+Xe/RP3h6yQqKossZC7jAgwm100
         Op9bxlgaD2kGmsETyUxnsBibO5/uee7WzO2AyeNtmbjwpbu6CUkq+TS33mc6Bf43UoBa
         JDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3YyngCDtHoeyOl2D3NWmERu7ZyhAVN/hTrtg2IeA1OA=;
        b=Kl+3IU5gVHxdbfzGcQMiYHUnw4tfMs9lUBxz84pHlKBUppdctUfbgQ19JIWoZUvyXJ
         f15XAmxfMbM+zdtvZDWJg+2o9V4aXQ+zOM/3dr0uFxUH/X3p2KxxPeaDSHbvbJw7siSB
         d3mNmGkoHUWuN6d2znwtgFBcbr21FcMy18wNylJr65xUtwcwRDKe/mAa4e8GVoGbsqF2
         clmTe/UQwunTRqWVi4TwuzVvL603Kc+wIiydIKrThr1uxXF8hP0D6qHqPcVYiPpKDJOX
         WMAqCju7TDEVIZvvrNcDCg5e3k/XJwI4JYcP/TTQelDYbrsIQ++SFRAfttqkS0hh123k
         rnSQ==
X-Gm-Message-State: ANhLgQ3lDs+5BlP13SBX7knaoPJd8oC4e6ZsTP3ejH1Dzzz1DlxanMDU
        iD58w0UIyhyQTqN2ZQNzeyD521x15VxLzCsJRr8=
X-Google-Smtp-Source: ADFU+vszOzrXzlDlORj3naZC46wIE9EZtTg5ZV7nZKirk96sSD/HXjPwGDZhT3FZ2fjy96rSJMkZXOpRe2a2Np4tg5s=
X-Received: by 2002:a1c:2c8a:: with SMTP id s132mr4109555wms.22.1585152585451;
 Wed, 25 Mar 2020 09:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <9932cd04adc20b73040d82c605acb0b5a24e3855.camel@hammerspace.com>
 <8B8B914C-D741-42E0-BC0C-4850635B5551@gmail.com> <CAK3fRr_=e_JzBGPH-kWW6P8tQ-ZLhOpnFkd9kgGEmDxbHzJOhA@mail.gmail.com>
In-Reply-To: <CAK3fRr_=e_JzBGPH-kWW6P8tQ-ZLhOpnFkd9kgGEmDxbHzJOhA@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 25 Mar 2020 12:09:33 -0400
Message-ID: <CAN-5tyH1TNrVoxPv0hcZ5gEpeHg6MOEjYhii+GCFM7urt_q1xQ@mail.gmail.com>
Subject: Re: Stuck NFSv4 mounts of Isilon filer with repeated
 NFS4ERR_STALE_CLIENTID errors
To:     James Pearson <jcpearson@gmail.com>
Cc:     Kevin Vasko <kvasko@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi James,

What's in your /var/log/messages on the client that's looping?

If your network traces had some interleaved SETCLIENTIDs I would have
said that it's possible you are hitting this RHEL7.5 problem:  Bug
1592911 - Fix how client ID in SETCLIENTID is constructed to prevent
lease tempering. https://bugzilla.redhat.com/show_bug.cgi?id=3D1592911
but if the only thing that you see is RENEWs then it might not be it.


On Wed, Mar 25, 2020 at 10:02 AM James Pearson <jcpearson@gmail.com> wrote:
>
> On Wed, 25 Mar 2020 at 13:20, Kevin Vasko <kvasko@gmail.com> wrote:
> > James,
> >
> > Just curious are your symptoms anything similar to mine where if you tr=
ansfer a file (200MB+) to the NFS server, the transfer will just lock up an=
d never complete? Are you using Kerberos as well? If so...
> >
> > I had a problem on a Dell Unity box where on a transfer to the NFS serv=
er the sequence number gets out of order and it would lock up the Dell Unit=
y box NFS and the transfer would never complete.
> >
> > Dell was not aware of this bug and they had to have engineering look at=
 the issue. After about 3 months they got back with and had me change two p=
arameters.
> >
> > scv_nas ALL -parma -facility nfs -modify rpcgss.discardReplay -value 0
> >
> > scv_nas ALL -parma -facility nfs -modify rpcgss.discardOld -value 0
> >
> > I=E2=80=99m doubtful that this would be the same way you would change t=
hese settings on the Isilon but just figured if it=E2=80=99s related it mig=
ht help.
> > a Isilon
>
> We're not using Kerberos, just SYS_AUTH ...
>
> James
